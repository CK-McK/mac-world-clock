import Foundation

/// Resolves geographic coordinates for world clock entries used by weather fetch.
enum WeatherCoordinateResolver {

    /// UserDefaults key for cached geocoded coordinates keyed by entry identity.
    private static let cacheKey = "weatherCoordinateCache"

    /// Returns whether weather should be skipped for the given entry.
    ///
    /// UTC has no meaningful single location for current weather.
    ///
    /// - Parameter entry: Persisted world clock row.
    /// - Returns: `true` when weather fetch should be omitted.
    static func shouldSkipWeather(for entry: WorldClockEntry) -> Bool {
        entry.timeZoneIdentifier == "UTC"
    }

    /// Resolves coordinates for a world clock entry using catalog data, cache, or geocoding.
    ///
    /// - Parameters:
    ///   - entry: Persisted world clock row.
    ///   - defaults: User defaults suite for coordinate cache persistence.
    /// - Returns: Latitude and longitude when resolved; `nil` when weather should be skipped or lookup fails.
    static func coordinates(
        for entry: WorldClockEntry,
        defaults: UserDefaults = .standard
    ) async -> (latitude: Double, longitude: Double)? {
        guard !shouldSkipWeather(for: entry) else { return nil }

        if let catalog = TimeZoneCatalog.entry(matching: entry) {
            return (catalog.latitude, catalog.longitude)
        }

        let cacheIdentity = cacheKey(for: entry)
        if let cached = cachedCoordinate(forKey: cacheIdentity, defaults: defaults) {
            return cached
        }

        if let geocoded = await geocode(displayName: entry.displayName) {
            storeCoordinate(geocoded, forKey: cacheIdentity, defaults: defaults)
            return geocoded
        }

        return nil
    }

    /// Builds a stable cache key from timezone and display name.
    ///
    /// - Parameter entry: Persisted world clock row.
    /// - Returns: Cache key string.
    private static func cacheKey(for entry: WorldClockEntry) -> String {
        "\(entry.timeZoneIdentifier)|\(entry.displayName)"
    }

    /// Reads cached coordinates from UserDefaults.
    ///
    /// - Parameters:
    ///   - key: Cache identity string.
    ///   - defaults: User defaults suite.
    /// - Returns: Cached latitude and longitude when present.
    private static func cachedCoordinate(
        forKey key: String,
        defaults: UserDefaults
    ) -> (latitude: Double, longitude: Double)? {
        guard let cache = defaults.dictionary(forKey: cacheKey) as? [String: [Double]],
              let values = cache[key],
              values.count == 2 else {
            return nil
        }
        return (values[0], values[1])
    }

    /// Persists resolved coordinates to UserDefaults.
    ///
    /// - Parameters:
    ///   - coordinate: Latitude and longitude to store.
    ///   - key: Cache identity string.
    ///   - defaults: User defaults suite.
    private static func storeCoordinate(
        _ coordinate: (latitude: Double, longitude: Double),
        forKey key: String,
        defaults: UserDefaults
    ) {
        var cache = defaults.dictionary(forKey: cacheKey) as? [String: [Double]] ?? [:]
        cache[key] = [coordinate.latitude, coordinate.longitude]
        defaults.set(cache, forKey: cacheKey)
    }

    /// Geocodes a display name via the Open-Meteo Geocoding API.
    ///
    /// - Parameter displayName: City and country label such as `"Tokyo, Japan"`.
    /// - Returns: Resolved coordinates when the API returns a match.
    private static func geocode(displayName: String) async -> (latitude: Double, longitude: Double)? {
        var components = URLComponents(string: "https://geocoding-api.open-meteo.com/v1/search")
        components?.queryItems = [
            URLQueryItem(name: "name", value: displayName),
            URLQueryItem(name: "count", value: "1"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "format", value: "json")
        ]
        guard let url = components?.url else { return nil }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse, (200 ... 299).contains(http.statusCode) else {
                return nil
            }
            let decoded = try JSONDecoder().decode(GeocodingResponse.self, from: data)
            guard let first = decoded.results?.first else { return nil }
            return (first.latitude, first.longitude)
        } catch {
            return nil
        }
    }
}

/// Open-Meteo geocoding API response envelope.
private struct GeocodingResponse: Decodable {
    /// Matching locations returned by the search endpoint.
    let results: [GeocodingResult]?
}

/// One geocoding search result row.
private struct GeocodingResult: Decodable {
    /// Latitude in decimal degrees.
    let latitude: Double
    /// Longitude in decimal degrees.
    let longitude: Double
}
