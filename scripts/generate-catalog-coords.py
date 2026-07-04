#!/usr/bin/env python3
"""Geocode TimeZoneCatalog cities via Open-Meteo and rewrite TimeZoneCatalog.swift."""

from __future__ import annotations

import json
import re
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CATALOG_PATH = ROOT / "Sources/MacClockWidget/Data/TimeZoneCatalog.swift"
GEOCODE_URL = "https://geocoding-api.open-meteo.com/v1/search"

ENTRY_PATTERN = re.compile(
    r'TimeZoneCatalogEntry\(\s*'
    r'city:\s*"([^"]+)",\s*'
    r'country:\s*"([^"]+)",\s*'
    r'timeZoneIdentifier:\s*"([^"]+)",\s*'
    r'region:\s*"([^"]+)"'
    r'(?:,\s*latitude:\s*[-\d.]+,\s*longitude:\s*[-\d.]+)?'
    r'\s*\),'
)

# Known coordinates when geocoding search returns no match.
MANUAL_COORDS: dict[str, tuple[float, float]] = {
    "La Paz, Bolivia": (-16.4897, -68.1193),
    "San José, Costa Rica": (9.9281, -84.0907),
    "San Juan, Puerto Rico": (18.4655, -66.1057),
    "Amsterdam, Netherlands": (52.3676, 4.9041),
    "Prague, Czech Republic": (50.0755, 14.4378),
    "Istanbul, Turkey": (41.0082, 28.9784),
    "Hong Kong, China": (22.3193, 114.1694),
    "Bangalore, India": (12.9716, 77.5946),
    "Guam, United States": (13.4443, 144.7937),
    "UTC, Coordinated Universal Time": (51.4778, -0.0015),
    "Pago Pago, American Samoa": (-14.2756, -170.7020),
    "Tahiti, French Polynesia": (-17.5516, -149.5585),
    "Kiritimati, Kiribati": (1.8721, -157.4278),
}


def geocode_query(query: str) -> tuple[float, float] | None:
    """Resolve latitude and longitude for a free-text geocoding query."""
    params = urllib.parse.urlencode({"name": query, "count": 1, "language": "en", "format": "json"})
    url = f"{GEOCODE_URL}?{params}"
    request = urllib.request.Request(url, headers={"User-Agent": "MacClockWidget/2.0"})
    with urllib.request.urlopen(request, timeout=30) as response:
        payload = json.load(response)
    results = payload.get("results") or []
    if not results:
        return None
    top = results[0]
    return float(top["latitude"]), float(top["longitude"])


def geocode_city(city: str, country: str) -> tuple[float, float] | None:
    """Resolve coordinates using multiple query strategies and manual fallbacks."""
    label = f"{city}, {country}"
    if label in MANUAL_COORDS:
        return MANUAL_COORDS[label]

    queries = [
        label,
        city,
        f"{city}, {country.split()[0]}",
    ]
    seen: set[str] = set()
    for query in queries:
        if query in seen:
            continue
        seen.add(query)
        coords = geocode_query(query)
        if coords is not None:
            return coords
        time.sleep(0.1)
    return None


def format_entry(city: str, country: str, tz: str, region: str, lat: float, lon: float) -> str:
    """Format one TimeZoneCatalogEntry initializer line with coordinates."""
    return (
        f'        TimeZoneCatalogEntry('
        f'city: "{city}", country: "{country}", '
        f'timeZoneIdentifier: "{tz}", region: "{region}", '
        f'latitude: {lat:.4f}, longitude: {lon:.4f}'
        f'),'
    )


def main() -> int:
    """Geocode all catalog entries and update TimeZoneCatalog.swift."""
    text = CATALOG_PATH.read_text(encoding="utf-8")
    matches = list(ENTRY_PATTERN.finditer(text))
    if not matches:
        print("No catalog entries found.", file=sys.stderr)
        return 1

    print(f"Geocoding {len(matches)} catalog cities…")
    replacements: list[tuple[re.Match[str], str]] = []
    failures: list[str] = []

    for index, match in enumerate(matches, start=1):
        city, country, tz, region = match.groups()
        label = f"{city}, {country}"
        try:
            coords = geocode_city(city, country)
            if coords is None:
                failures.append(label)
                print(f"  [{index}/{len(matches)}] FAILED (no result): {label}")
                continue
            lat, lon = coords
            line = format_entry(city, country, tz, region, lat, lon)
            replacements.append((match, line))
            print(f"  [{index}/{len(matches)}] {label} → {lat:.4f}, {lon:.4f}")
        except Exception as exc:  # noqa: BLE001
            failures.append(label)
            print(f"  [{index}/{len(matches)}] ERROR {label}: {exc}", file=sys.stderr)
        time.sleep(0.1)

    if failures:
        print(f"\nFailed to geocode {len(failures)} cities:", file=sys.stderr)
        for name in failures:
            print(f"  - {name}", file=sys.stderr)
        return 1

    updated = text
    for match, line in reversed(replacements):
        updated = updated[: match.start()] + line + updated[match.end() :]

    CATALOG_PATH.write_text(updated, encoding="utf-8")
    print(f"\nUpdated {CATALOG_PATH}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
