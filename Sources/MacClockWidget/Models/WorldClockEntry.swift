import Foundation

/// A user-selected world clock row persisted in ``WorldClockStore``.
struct WorldClockEntry: Identifiable, Codable, Equatable, Hashable {
    /// Stable identifier used for list identity and persistence.
    let id: UUID
    /// Human-readable city and country label (e.g. "Tokyo, Japan").
    let displayName: String
    /// IANA timezone identifier (e.g. "Asia/Tokyo").
    let timeZoneIdentifier: String

    /// Creates a world clock entry with the given properties.
    ///
    /// - Parameters:
    ///   - id: Unique row identifier; a new UUID is generated when omitted.
    ///   - displayName: City and country label shown in the panel.
    ///   - timeZoneIdentifier: IANA timezone identifier for time calculations.
    init(id: UUID = UUID(), displayName: String, timeZoneIdentifier: String) {
        self.id = id
        self.displayName = displayName
        self.timeZoneIdentifier = timeZoneIdentifier
    }
}
