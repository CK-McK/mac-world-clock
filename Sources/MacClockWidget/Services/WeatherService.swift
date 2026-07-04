import Combine
import Foundation

/// Fetches and caches current weather for configured world clock entries via Open-Meteo.
@MainActor
final class WeatherService: ObservableObject {

    /// Maximum age of cached weather before a refresh is attempted.
    private static let cacheLifetime: TimeInterval = 20 * 60

    /// Cached weather snapshots keyed by world clock entry identifier.
    @Published private(set) var snapshots: [UUID: WeatherSnapshot] = [:]

    /// Whether a network fetch is currently in progress.
    @Published private(set) var isLoading = false

    /// Optional caption shown when every weatherable row failed to load.
    @Published private(set) var allFailedMessage: String?

    private var lastRefreshDate: Date?
    private var lastEntryIDs: Set<UUID> = []
    private var refreshTask: Task<Void, Never>?

    /// Returns the cached weather snapshot for an entry when available.
    ///
    /// - Parameter entryID: World clock entry identifier.
    /// - Returns: Cached snapshot, or `nil` when not yet fetched.
    func snapshot(for entryID: UUID) -> WeatherSnapshot? {
        snapshots[entryID]
    }

    /// Refreshes weather when the panel is visible and cache is stale or entries changed.
    ///
    /// - Parameter entries: Currently configured world clock rows.
    func refreshIfNeeded(for entries: [WorldClockEntry]) {
        let entryIDs = Set(entries.map(\.id))
        let isStale: Bool
        if let lastRefreshDate {
            isStale = Date().timeIntervalSince(lastRefreshDate) > Self.cacheLifetime
        } else {
            isStale = true
        }
        let entriesChanged = entryIDs != lastEntryIDs

        guard isStale || entriesChanged else { return }
        guard refreshTask == nil else { return }

        refreshTask = Task { [weak self] in
            await self?.refresh(for: entries)
            await MainActor.run {
                self?.refreshTask = nil
            }
        }
    }

    /// Performs a full coordinate resolution and batch weather fetch for the given entries.
    ///
    /// - Parameter entries: World clock rows to fetch weather for.
    private func refresh(for entries: [WorldClockEntry]) async {
        isLoading = true
        allFailedMessage = nil
        defer { isLoading = false }

        var resolved: [(entry: WorldClockEntry, latitude: Double, longitude: Double)] = []
        for entry in entries {
            if Task.isCancelled { return }
            if let coordinate = await WeatherCoordinateResolver.coordinates(for: entry) {
                resolved.append((entry, coordinate.latitude, coordinate.longitude))
            }
        }

        lastEntryIDs = Set(entries.map(\.id))

        guard !resolved.isEmpty else {
            lastRefreshDate = Date()
            return
        }

        let fetched = await fetchForecasts(for: resolved)
        if Task.isCancelled { return }

        for (entry, snapshot) in fetched {
            snapshots[entry.id] = snapshot
        }

        lastRefreshDate = Date()

        if fetched.isEmpty {
            allFailedMessage = "Weather unavailable"
        } else if fetched.count < resolved.count {
            allFailedMessage = nil
        } else {
            allFailedMessage = nil
        }
    }

    /// Batch-fetches current weather from Open-Meteo for resolved coordinates.
    ///
    /// - Parameter resolvedEntries: Entries paired with latitude and longitude.
    /// - Returns: Successfully parsed snapshots keyed by entry.
    private func fetchForecasts(
        for resolvedEntries: [(entry: WorldClockEntry, latitude: Double, longitude: Double)]
    ) async -> [(entry: WorldClockEntry, snapshot: WeatherSnapshot)] {
        let latitudes = resolvedEntries.map { String(format: "%.4f", $0.latitude) }.joined(separator: ",")
        let longitudes = resolvedEntries.map { String(format: "%.4f", $0.longitude) }.joined(separator: ",")

        var components = URLComponents(string: "https://api.open-meteo.com/v1/forecast")
        components?.queryItems = [
            URLQueryItem(name: "latitude", value: latitudes),
            URLQueryItem(name: "longitude", value: longitudes),
            URLQueryItem(name: "current", value: "temperature_2m,weather_code"),
            URLQueryItem(name: "timezone", value: "auto")
        ]
        guard let url = components?.url else { return [] }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse, (200 ... 299).contains(http.statusCode) else {
                return []
            }
            return parseForecastResponse(data: data, resolvedEntries: resolvedEntries)
        } catch {
            return []
        }
    }

    /// Parses single- or multi-location Open-Meteo forecast JSON into snapshots.
    ///
    /// - Parameters:
    ///   - data: Raw JSON response body.
    ///   - resolvedEntries: Entries in the same order as the batch request coordinates.
    /// - Returns: Parsed snapshots aligned with entries that returned data.
    private func parseForecastResponse(
        data: Data,
        resolvedEntries: [(entry: WorldClockEntry, latitude: Double, longitude: Double)]
    ) -> [(entry: WorldClockEntry, snapshot: WeatherSnapshot)] {
        let decoder = JSONDecoder()

        if let locations = try? decoder.decode([ForecastLocationResponse].self, from: data) {
            return zip(resolvedEntries, locations).compactMap { pair, location in
                guard let snapshot = snapshot(from: location) else { return nil }
                return (pair.entry, snapshot)
            }
        }

        if let location = try? decoder.decode(ForecastLocationResponse.self, from: data),
           let first = resolvedEntries.first,
           let snapshot = snapshot(from: location) {
            return [(first.entry, snapshot)]
        }

        return []
    }

    /// Builds a ``WeatherSnapshot`` from one Open-Meteo location payload.
    ///
    /// - Parameter location: Parsed forecast location response.
    /// - Returns: Snapshot when current weather fields are present.
    private func snapshot(from location: ForecastLocationResponse) -> WeatherSnapshot? {
        guard let temperature = location.current?.temperature2m,
              let weatherCode = location.current?.weatherCode else {
            return nil
        }
        let fetchedAt = Self.parseOpenMeteoTime(location.current?.time) ?? Date()
        return WeatherSnapshot(
            temperatureCelsius: temperature,
            weatherCode: weatherCode,
            fetchedAt: fetchedAt
        )
    }

    /// Parses Open-Meteo current observation timestamps (`yyyy-MM-dd'T'HH:mm`).
    ///
    /// - Parameter string: Raw time field from the API response.
    /// - Returns: Parsed date when the format matches.
    private static func parseOpenMeteoTime(_ string: String?) -> Date? {
        guard let string else { return nil }
        return openMeteoTimeFormatter.date(from: string)
    }

    /// Formatter for Open-Meteo current-weather timestamps without seconds or timezone suffix.
    private static let openMeteoTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}

/// One Open-Meteo forecast location in a batch or single response.
private struct ForecastLocationResponse: Decodable {
    /// Current conditions for the location.
    let current: ForecastCurrentResponse?
}

/// Current weather fields returned by Open-Meteo.
private struct ForecastCurrentResponse: Decodable {
    /// Observation timestamp (`yyyy-MM-dd'T'HH:mm` in the location timezone).
    let time: String?
    /// Air temperature at 2 meters in Celsius.
    let temperature2m: Double?
    /// WMO weather interpretation code.
    let weatherCode: Int?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case weatherCode = "weather_code"
    }
}
