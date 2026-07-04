# Mac World Clock

A lightweight native macOS **menu bar** app that shows a clock icon in the status area. Click it to open an expanded panel listing up to 10 configured cities with current local time and offset versus your Mac's timezone.

## Features

- Clock icon only in the menu bar (no Dock icon)
- Click-to-open panel with live updating times
- Sun or moon icon beside each city's time (daytime 6 AM–6 PM local in that timezone)
- Up to 10 cities from a curated catalog (~125 major cities)
- Offset display vs your local time (e.g. `(+5h)`, `(-3h 30m)`, `(same time)`)
- Inline configure panel to add, remove, and reorder cities (search, per-row X buttons, swipe-delete, drag reorder)
- Keyboard shortcut **⌘,** opens Configure from the main panel
- **Launch at login** toggle in the configure panel (above Cancel / Done)
- **Export / import** city list as JSON backup (configure panel footer)
- Persists city selections immediately via UserDefaults (`worldClockEntries`); survives app restart

## Requirements

- macOS 13 Ventura or later (`MenuBarExtra` window style)
- Xcode Command Line Tools (`xcode-select --install`)

## Build and run

```bash
cd "Mac Clock Widget"
swift build -c release
.build/release/MacClockWidget
```

The app runs as a menu bar utility. Look for the clock icon in the top-right status area.

> **Note:** The raw SPM binary is fine for development, but **launch at login** requires a proper `.app` bundle (see below).

## Build a `.app` bundle

For double-click launch, launch at login, or installing to `/Applications`:

```bash
./scripts/build-app.sh           # produces ./build/MacClockWidget.app
./scripts/build-app.sh run       # build and launch
./scripts/build-app.sh install   # quit running instance, copy to /Applications, launch
```

The script ad-hoc code-signs the bundle (`com.cktools.macclockwidget`) so macOS launches it locally without quarantine issues.

## Launch at login

### In-app toggle (recommended)

1. Build and run the **`.app` bundle** (not the raw binary):
   ```bash
   ./scripts/build-app.sh run
   # or: ./scripts/build-app.sh install
   ```
2. Click the clock icon in the menu bar.
3. Click **Configure…**, then turn on **Launch at login** in the configure panel footer (above **Cancel** / **Done**).

The preference is stored in UserDefaults (`launchAtLoginEnabled`, default **off** on first launch). The app uses Apple's `SMAppService.mainApp` API (macOS 13+) to register as a login item. If registration fails, the toggle reverts and a short error appears under the switch.

When running via `swift build` and `.build/release/MacClockWidget`, the toggle is **disabled** — `SMAppService` requires a bundled `.app`. Use `scripts/build-app.sh` instead.

### Manual Login Items (alternative)

1. Build and install: `./scripts/build-app.sh install`
2. Open *System Settings → General → Login Items*
3. Click **+** and select `MacClockWidget.app` from `/Applications`

You can also drag `MacClockWidget.app` into the Login Items list.

## Usage

1. Click the clock icon in the menu bar.
2. View configured cities with live times, day/night icons, and offsets.
3. Click **Configure…** (or press **⌘,**) to add, remove, or reorder cities (inline panel — stays open while editing). Changes save automatically; use **Cancel** to revert changes made since opening configure.
4. Search the catalog by city, country, timezone identifier, or region.

### Backup and restore

In the configure panel footer (between **Launch at login** and **Cancel** / **Done**):

- **Export…** — save the current city list as a JSON file (default name `world-clock-cities.json`). Useful for backup before reinstall or moving to another Mac.
- **Import…** — choose a previously exported JSON file to replace the current city list. Invalid files show an error under the buttons.

Import applies immediately (same as add/remove/reorder). Use **Cancel** to revert an import along with other changes made since opening configure.

Example backup shape:

```json
{
  "entries": [
    {
      "displayName": "Tokyo, Japan",
      "id": "A1B2C3D4-E5F6-7890-ABCD-EF1234567890",
      "timeZoneIdentifier": "Asia/Tokyo"
    }
  ],
  "exportedAt": "2026-07-03T11:39:00Z",
  "schemaVersion": 1
}
```

## Project layout

```
Mac Clock Widget/
├── Package.swift
├── README.md
├── scripts/build-app.sh
├── Resources/Info.plist
└── Sources/MacClockWidget/
    ├── MacClockWidgetApp.swift   # @main, MenuBarExtra
    ├── AppDelegate.swift           # menu-bar-only (.accessory) activation
    ├── Models/
    │   ├── WorldClockEntry.swift
    │   ├── WorldClockBackupDocument.swift
    │   └── TimeZoneCatalogEntry.swift
    ├── Services/
    │   ├── WorldClockStore.swift
    │   ├── WorldClockBackupService.swift
    │   ├── LaunchAtLoginService.swift
    │   └── TimeFormatting.swift
    ├── Data/
    │   └── TimeZoneCatalog.swift   # 125 curated cities, 6 regions
    └── Views/
        ├── ExpandedClockView.swift
        ├── CityRowView.swift
        └── ConfigureTimezonesView.swift
```

## Troubleshooting

- **No menu bar icon:** The app may be hidden behind the menu bar overflow (»). Hold ⌥ and drag icons to reorder, or quit other menu bar apps.
- **Launch at login toggle disabled:** Build the `.app` with `./scripts/build-app.sh` and run that bundle — the raw `swift build` binary cannot register with `SMAppService`.
- **Launch at login failed:** Check *System Settings → General → Login Items* for approval prompts. Ensure you are running `MacClockWidget.app`, not a duplicate copy with a different signature.
- **Times look wrong:** Offsets account for daylight saving time at the current instant. Verify the correct IANA timezone was selected in Configure.
- **12h vs 24h format:** Follows your macOS *System Settings → General → Language & Region* time format preference.
- **Import failed:** Ensure the file is a World Clock JSON export (`schemaVersion: 1`) with valid IANA timezone identifiers. Raw `[WorldClockEntry]` arrays without the backup envelope are not supported.

## Notes

- Hover-to-open is not supported; the panel opens on click only.
- Duplicate timezone IDs cannot be added twice.
- Default cities on first launch: your local timezone, UTC, New York, London, and Tokyo (when available).
- City selections persist in UserDefaults (`worldClockEntries`) and are written on every add, remove, or reorder — no separate Save step.
