import Combine
import Foundation

/// Persists and publishes the user's selected world clock entries.
///
/// Stores up to 10 entries in ``UserDefaults`` as JSON. Provides sensible
/// defaults on first launch including local timezone, UTC, and major regions.
final class WorldClockStore: ObservableObject {

    /// Maximum number of cities the user may configure.
    static let maxEntries = 10

    /// UserDefaults key for persisted entries.
    private static let storageKey = "worldClockEntries"

    /// Currently selected world clock entries in display order.
    @Published private(set) var entries: [WorldClockEntry] = []

    private let defaults: UserDefaults

    /// Creates a store backed by the given user defaults suite.
    ///
    /// - Parameter defaults: Defaults suite for persistence; `.standard` when omitted.
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
    }

    /// Replaces all entries after enforcing the maximum count.
    ///
    /// - Parameter newEntries: Desired entry list; truncated to ``maxEntries``.
    func setEntries(_ newEntries: [WorldClockEntry]) {
        entries = Array(newEntries.prefix(Self.maxEntries))
        save()
    }

    /// Appends a catalog entry if the timezone is not already selected and capacity remains.
    ///
    /// - Parameter catalogEntry: Catalog row to add.
    /// - Returns: `true` when the entry was added; `false` if duplicate or at capacity.
    @discardableResult
    func add(from catalogEntry: TimeZoneCatalogEntry) -> Bool {
        guard entries.count < Self.maxEntries else { return false }
        guard !entries.contains(where: { $0.timeZoneIdentifier == catalogEntry.timeZoneIdentifier }) else {
            return false
        }
        let entry = WorldClockEntry(
            displayName: catalogEntry.displayName,
            timeZoneIdentifier: catalogEntry.timeZoneIdentifier
        )
        entries.append(entry)
        save()
        return true
    }

    /// Removes entries matching the given identifiers.
    ///
    /// - Parameter ids: Entry UUIDs to remove.
    func remove(ids: Set<UUID>) {
        entries.removeAll { ids.contains($0.id) }
        save()
    }

    /// Moves an entry from one index to another, updating persisted order.
    ///
    /// - Parameters:
    ///   - source: Source index in the current entries array.
    ///   - destination: Destination index in the entries array.
    func move(from source: Int, to destination: Int) {
        guard entries.indices.contains(source),
              destination >= 0,
              destination <= entries.count else { return }
        let entry = entries.remove(at: source)
        let adjustedDestination = destination > source ? destination - 1 : destination
        entries.insert(entry, at: min(max(adjustedDestination, 0), entries.count))
        save()
    }

    /// Returns whether the given timezone identifier is already in the saved list.
    ///
    /// - Parameter timeZoneIdentifier: IANA timezone identifier to check.
    /// - Returns: `true` when the timezone is already selected.
    func contains(timeZoneIdentifier: String) -> Bool {
        entries.contains { $0.timeZoneIdentifier == timeZoneIdentifier }
    }

    /// Loads entries from UserDefaults or applies defaults on first launch.
    private func load() {
        if let data = defaults.data(forKey: Self.storageKey),
           let decoded = try? JSONDecoder().decode([WorldClockEntry].self, from: data) {
            entries = Array(decoded.prefix(Self.maxEntries))
            return
        }
        entries = Self.defaultEntries()
        save()
    }

    /// Encodes and saves the current entries to UserDefaults.
    private func save() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        defaults.set(data, forKey: Self.storageKey)
    }

    /// Builds the first-launch default city list.
    ///
    /// Includes the user's local timezone (when known), UTC, and representative
    /// cities from the Americas, Europe, and Asia.
    ///
    /// - Returns: Up to five default ``WorldClockEntry`` values.
    static func defaultEntries() -> [WorldClockEntry] {
        var result: [WorldClockEntry] = []
        var usedTimeZones = Set<String>()

        if let localEntry = localDefaultEntry(), usedTimeZones.insert(localEntry.timeZoneIdentifier).inserted {
            result.append(localEntry)
        }

        let preferredIdentifiers = [
            "UTC",
            "America/New_York",
            "Europe/London",
            "Asia/Tokyo"
        ]

        for identifier in preferredIdentifiers {
            guard result.count < maxEntries else { break }
            guard usedTimeZones.insert(identifier).inserted else { continue }

            if let catalogMatch = TimeZoneCatalog.entry(forTimeZoneIdentifier: identifier) {
                result.append(
                    WorldClockEntry(
                        displayName: catalogMatch.displayName,
                        timeZoneIdentifier: catalogMatch.timeZoneIdentifier
                    )
                )
            } else if identifier == "UTC" {
                result.append(
                    WorldClockEntry(
                        displayName: "UTC",
                        timeZoneIdentifier: "UTC"
                    )
                )
            }
        }

        return result
    }

    /// Resolves a display entry for the user's current local timezone.
    ///
    /// - Returns: A catalog-backed entry when available, otherwise a synthetic local entry.
    private static func localDefaultEntry() -> WorldClockEntry? {
        let localIdentifier = TimeZone.current.identifier
        if let catalogMatch = TimeZoneCatalog.entry(forTimeZoneIdentifier: localIdentifier) {
            return WorldClockEntry(
                displayName: catalogMatch.displayName,
                timeZoneIdentifier: catalogMatch.timeZoneIdentifier
            )
        }
        return WorldClockEntry(
            displayName: "Local (\(localIdentifier))",
            timeZoneIdentifier: localIdentifier
        )
    }
}
