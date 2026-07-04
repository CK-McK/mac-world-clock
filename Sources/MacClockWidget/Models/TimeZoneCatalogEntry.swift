import Foundation

/// A curated timezone catalog row used in the configure sheet.
struct TimeZoneCatalogEntry: Identifiable, Hashable {
    /// Stable identifier derived from the timezone identifier.
    var id: String { timeZoneIdentifier }
    /// City name (e.g. "Tokyo").
    let city: String
    /// Country or territory name (e.g. "Japan").
    let country: String
    /// IANA timezone identifier (e.g. "Asia/Tokyo").
    let timeZoneIdentifier: String
    /// Geographic region used for grouped display (e.g. "Asia").
    let region: String

    /// Full display label combining city and country.
    var displayName: String {
        "\(city), \(country)"
    }

    /// Returns whether this catalog row matches a user search query.
    ///
    /// Uses diacritic- and case-insensitive matching across city, country,
    /// combined display name, IANA timezone identifier, and region.
    ///
    /// - Parameter query: Trimmed search text from the configure panel.
    /// - Returns: `true` when the query is empty or matches any searchable field.
    func matchesSearch(_ query: String) -> Bool {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return true }

        let fields = [city, country, displayName, timeZoneIdentifier, region]
        return fields.contains { $0.localizedStandardContains(trimmed) }
    }

    /// Creates a catalog entry for a major city timezone.
    ///
    /// - Parameters:
    ///   - city: City name shown in the UI.
    ///   - country: Country or territory name.
    ///   - timeZoneIdentifier: IANA timezone identifier.
    ///   - region: Region name for grouped lists.
    init(city: String, country: String, timeZoneIdentifier: String, region: String) {
        self.city = city
        self.country = country
        self.timeZoneIdentifier = timeZoneIdentifier
        self.region = region
    }
}
