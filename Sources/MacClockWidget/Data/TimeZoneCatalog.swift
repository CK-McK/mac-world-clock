import Foundation

/// Static curated catalog of major world cities and their IANA timezones.
enum TimeZoneCatalog {

    /// All catalog entries sorted by region, then city name.
    static let all: [TimeZoneCatalogEntry] = [
        // Americas
        TimeZoneCatalogEntry(city: "New York", country: "United States", timeZoneIdentifier: "America/New_York", region: "Americas"),
        TimeZoneCatalogEntry(city: "Los Angeles", country: "United States", timeZoneIdentifier: "America/Los_Angeles", region: "Americas"),
        TimeZoneCatalogEntry(city: "Chicago", country: "United States", timeZoneIdentifier: "America/Chicago", region: "Americas"),
        TimeZoneCatalogEntry(city: "Denver", country: "United States", timeZoneIdentifier: "America/Denver", region: "Americas"),
        TimeZoneCatalogEntry(city: "Phoenix", country: "United States", timeZoneIdentifier: "America/Phoenix", region: "Americas"),
        TimeZoneCatalogEntry(city: "Anchorage", country: "United States", timeZoneIdentifier: "America/Anchorage", region: "Americas"),
        TimeZoneCatalogEntry(city: "Honolulu", country: "United States", timeZoneIdentifier: "Pacific/Honolulu", region: "Americas"),
        TimeZoneCatalogEntry(city: "Toronto", country: "Canada", timeZoneIdentifier: "America/Toronto", region: "Americas"),
        TimeZoneCatalogEntry(city: "Vancouver", country: "Canada", timeZoneIdentifier: "America/Vancouver", region: "Americas"),
        TimeZoneCatalogEntry(city: "Montreal", country: "Canada", timeZoneIdentifier: "America/Montreal", region: "Americas"),
        TimeZoneCatalogEntry(city: "Calgary", country: "Canada", timeZoneIdentifier: "America/Edmonton", region: "Americas"),
        TimeZoneCatalogEntry(city: "Halifax", country: "Canada", timeZoneIdentifier: "America/Halifax", region: "Americas"),
        TimeZoneCatalogEntry(city: "Mexico City", country: "Mexico", timeZoneIdentifier: "America/Mexico_City", region: "Americas"),
        TimeZoneCatalogEntry(city: "Guadalajara", country: "Mexico", timeZoneIdentifier: "America/Mexico_City", region: "Americas"),
        TimeZoneCatalogEntry(city: "Cancún", country: "Mexico", timeZoneIdentifier: "America/Cancun", region: "Americas"),
        TimeZoneCatalogEntry(city: "São Paulo", country: "Brazil", timeZoneIdentifier: "America/Sao_Paulo", region: "Americas"),
        TimeZoneCatalogEntry(city: "Rio de Janeiro", country: "Brazil", timeZoneIdentifier: "America/Sao_Paulo", region: "Americas"),
        TimeZoneCatalogEntry(city: "Brasília", country: "Brazil", timeZoneIdentifier: "America/Sao_Paulo", region: "Americas"),
        TimeZoneCatalogEntry(city: "Manaus", country: "Brazil", timeZoneIdentifier: "America/Manaus", region: "Americas"),
        TimeZoneCatalogEntry(city: "Buenos Aires", country: "Argentina", timeZoneIdentifier: "America/Argentina/Buenos_Aires", region: "Americas"),
        TimeZoneCatalogEntry(city: "Santiago", country: "Chile", timeZoneIdentifier: "America/Santiago", region: "Americas"),
        TimeZoneCatalogEntry(city: "Lima", country: "Peru", timeZoneIdentifier: "America/Lima", region: "Americas"),
        TimeZoneCatalogEntry(city: "Bogotá", country: "Colombia", timeZoneIdentifier: "America/Bogota", region: "Americas"),
        TimeZoneCatalogEntry(city: "Caracas", country: "Venezuela", timeZoneIdentifier: "America/Caracas", region: "Americas"),
        TimeZoneCatalogEntry(city: "Quito", country: "Ecuador", timeZoneIdentifier: "America/Guayaquil", region: "Americas"),
        TimeZoneCatalogEntry(city: "La Paz", country: "Bolivia", timeZoneIdentifier: "America/La_Paz", region: "Americas"),
        TimeZoneCatalogEntry(city: "Montevideo", country: "Uruguay", timeZoneIdentifier: "America/Montevideo", region: "Americas"),
        TimeZoneCatalogEntry(city: "Asunción", country: "Paraguay", timeZoneIdentifier: "America/Asuncion", region: "Americas"),
        TimeZoneCatalogEntry(city: "San José", country: "Costa Rica", timeZoneIdentifier: "America/Costa_Rica", region: "Americas"),
        TimeZoneCatalogEntry(city: "Panama City", country: "Panama", timeZoneIdentifier: "America/Panama", region: "Americas"),
        TimeZoneCatalogEntry(city: "Havana", country: "Cuba", timeZoneIdentifier: "America/Havana", region: "Americas"),
        TimeZoneCatalogEntry(city: "Kingston", country: "Jamaica", timeZoneIdentifier: "America/Jamaica", region: "Americas"),
        TimeZoneCatalogEntry(city: "San Juan", country: "Puerto Rico", timeZoneIdentifier: "America/Puerto_Rico", region: "Americas"),

        // Europe
        TimeZoneCatalogEntry(city: "London", country: "United Kingdom", timeZoneIdentifier: "Europe/London", region: "Europe"),
        TimeZoneCatalogEntry(city: "Dublin", country: "Ireland", timeZoneIdentifier: "Europe/Dublin", region: "Europe"),
        TimeZoneCatalogEntry(city: "Paris", country: "France", timeZoneIdentifier: "Europe/Paris", region: "Europe"),
        TimeZoneCatalogEntry(city: "Berlin", country: "Germany", timeZoneIdentifier: "Europe/Berlin", region: "Europe"),
        TimeZoneCatalogEntry(city: "Munich", country: "Germany", timeZoneIdentifier: "Europe/Berlin", region: "Europe"),
        TimeZoneCatalogEntry(city: "Amsterdam", country: "Netherlands", timeZoneIdentifier: "Europe/Amsterdam", region: "Europe"),
        TimeZoneCatalogEntry(city: "Brussels", country: "Belgium", timeZoneIdentifier: "Europe/Brussels", region: "Europe"),
        TimeZoneCatalogEntry(city: "Zurich", country: "Switzerland", timeZoneIdentifier: "Europe/Zurich", region: "Europe"),
        TimeZoneCatalogEntry(city: "Vienna", country: "Austria", timeZoneIdentifier: "Europe/Vienna", region: "Europe"),
        TimeZoneCatalogEntry(city: "Rome", country: "Italy", timeZoneIdentifier: "Europe/Rome", region: "Europe"),
        TimeZoneCatalogEntry(city: "Milan", country: "Italy", timeZoneIdentifier: "Europe/Rome", region: "Europe"),
        TimeZoneCatalogEntry(city: "Madrid", country: "Spain", timeZoneIdentifier: "Europe/Madrid", region: "Europe"),
        TimeZoneCatalogEntry(city: "Barcelona", country: "Spain", timeZoneIdentifier: "Europe/Madrid", region: "Europe"),
        TimeZoneCatalogEntry(city: "Lisbon", country: "Portugal", timeZoneIdentifier: "Europe/Lisbon", region: "Europe"),
        TimeZoneCatalogEntry(city: "Stockholm", country: "Sweden", timeZoneIdentifier: "Europe/Stockholm", region: "Europe"),
        TimeZoneCatalogEntry(city: "Oslo", country: "Norway", timeZoneIdentifier: "Europe/Oslo", region: "Europe"),
        TimeZoneCatalogEntry(city: "Copenhagen", country: "Denmark", timeZoneIdentifier: "Europe/Copenhagen", region: "Europe"),
        TimeZoneCatalogEntry(city: "Helsinki", country: "Finland", timeZoneIdentifier: "Europe/Helsinki", region: "Europe"),
        TimeZoneCatalogEntry(city: "Warsaw", country: "Poland", timeZoneIdentifier: "Europe/Warsaw", region: "Europe"),
        TimeZoneCatalogEntry(city: "Prague", country: "Czech Republic", timeZoneIdentifier: "Europe/Prague", region: "Europe"),
        TimeZoneCatalogEntry(city: "Budapest", country: "Hungary", timeZoneIdentifier: "Europe/Budapest", region: "Europe"),
        TimeZoneCatalogEntry(city: "Athens", country: "Greece", timeZoneIdentifier: "Europe/Athens", region: "Europe"),
        TimeZoneCatalogEntry(city: "Istanbul", country: "Turkey", timeZoneIdentifier: "Europe/Istanbul", region: "Europe"),
        TimeZoneCatalogEntry(city: "Moscow", country: "Russia", timeZoneIdentifier: "Europe/Moscow", region: "Europe"),
        TimeZoneCatalogEntry(city: "Kyiv", country: "Ukraine", timeZoneIdentifier: "Europe/Kyiv", region: "Europe"),
        TimeZoneCatalogEntry(city: "Bucharest", country: "Romania", timeZoneIdentifier: "Europe/Bucharest", region: "Europe"),
        TimeZoneCatalogEntry(city: "Belgrade", country: "Serbia", timeZoneIdentifier: "Europe/Belgrade", region: "Europe"),
        TimeZoneCatalogEntry(city: "Reykjavik", country: "Iceland", timeZoneIdentifier: "Atlantic/Reykjavik", region: "Europe"),

        // Africa
        TimeZoneCatalogEntry(city: "Cairo", country: "Egypt", timeZoneIdentifier: "Africa/Cairo", region: "Africa"),
        TimeZoneCatalogEntry(city: "Johannesburg", country: "South Africa", timeZoneIdentifier: "Africa/Johannesburg", region: "Africa"),
        TimeZoneCatalogEntry(city: "Cape Town", country: "South Africa", timeZoneIdentifier: "Africa/Johannesburg", region: "Africa"),
        TimeZoneCatalogEntry(city: "Lagos", country: "Nigeria", timeZoneIdentifier: "Africa/Lagos", region: "Africa"),
        TimeZoneCatalogEntry(city: "Nairobi", country: "Kenya", timeZoneIdentifier: "Africa/Nairobi", region: "Africa"),
        TimeZoneCatalogEntry(city: "Casablanca", country: "Morocco", timeZoneIdentifier: "Africa/Casablanca", region: "Africa"),
        TimeZoneCatalogEntry(city: "Accra", country: "Ghana", timeZoneIdentifier: "Africa/Accra", region: "Africa"),
        TimeZoneCatalogEntry(city: "Addis Ababa", country: "Ethiopia", timeZoneIdentifier: "Africa/Addis_Ababa", region: "Africa"),
        TimeZoneCatalogEntry(city: "Tunis", country: "Tunisia", timeZoneIdentifier: "Africa/Tunis", region: "Africa"),
        TimeZoneCatalogEntry(city: "Algiers", country: "Algeria", timeZoneIdentifier: "Africa/Algiers", region: "Africa"),
        TimeZoneCatalogEntry(city: "Dar es Salaam", country: "Tanzania", timeZoneIdentifier: "Africa/Dar_es_Salaam", region: "Africa"),
        TimeZoneCatalogEntry(city: "Kampala", country: "Uganda", timeZoneIdentifier: "Africa/Kampala", region: "Africa"),

        // Asia
        TimeZoneCatalogEntry(city: "Tokyo", country: "Japan", timeZoneIdentifier: "Asia/Tokyo", region: "Asia"),
        TimeZoneCatalogEntry(city: "Seoul", country: "South Korea", timeZoneIdentifier: "Asia/Seoul", region: "Asia"),
        TimeZoneCatalogEntry(city: "Beijing", country: "China", timeZoneIdentifier: "Asia/Shanghai", region: "Asia"),
        TimeZoneCatalogEntry(city: "Shanghai", country: "China", timeZoneIdentifier: "Asia/Shanghai", region: "Asia"),
        TimeZoneCatalogEntry(city: "Hong Kong", country: "China", timeZoneIdentifier: "Asia/Hong_Kong", region: "Asia"),
        TimeZoneCatalogEntry(city: "Taipei", country: "Taiwan", timeZoneIdentifier: "Asia/Taipei", region: "Asia"),
        TimeZoneCatalogEntry(city: "Singapore", country: "Singapore", timeZoneIdentifier: "Asia/Singapore", region: "Asia"),
        TimeZoneCatalogEntry(city: "Bangkok", country: "Thailand", timeZoneIdentifier: "Asia/Bangkok", region: "Asia"),
        TimeZoneCatalogEntry(city: "Jakarta", country: "Indonesia", timeZoneIdentifier: "Asia/Jakarta", region: "Asia"),
        TimeZoneCatalogEntry(city: "Manila", country: "Philippines", timeZoneIdentifier: "Asia/Manila", region: "Asia"),
        TimeZoneCatalogEntry(city: "Kuala Lumpur", country: "Malaysia", timeZoneIdentifier: "Asia/Kuala_Lumpur", region: "Asia"),
        TimeZoneCatalogEntry(city: "Ho Chi Minh City", country: "Vietnam", timeZoneIdentifier: "Asia/Ho_Chi_Minh", region: "Asia"),
        TimeZoneCatalogEntry(city: "Hanoi", country: "Vietnam", timeZoneIdentifier: "Asia/Ho_Chi_Minh", region: "Asia"),
        TimeZoneCatalogEntry(city: "Mumbai", country: "India", timeZoneIdentifier: "Asia/Kolkata", region: "Asia"),
        TimeZoneCatalogEntry(city: "New Delhi", country: "India", timeZoneIdentifier: "Asia/Kolkata", region: "Asia"),
        TimeZoneCatalogEntry(city: "Bangalore", country: "India", timeZoneIdentifier: "Asia/Kolkata", region: "Asia"),
        TimeZoneCatalogEntry(city: "Karachi", country: "Pakistan", timeZoneIdentifier: "Asia/Karachi", region: "Asia"),
        TimeZoneCatalogEntry(city: "Dhaka", country: "Bangladesh", timeZoneIdentifier: "Asia/Dhaka", region: "Asia"),
        TimeZoneCatalogEntry(city: "Colombo", country: "Sri Lanka", timeZoneIdentifier: "Asia/Colombo", region: "Asia"),
        TimeZoneCatalogEntry(city: "Kathmandu", country: "Nepal", timeZoneIdentifier: "Asia/Kathmandu", region: "Asia"),
        TimeZoneCatalogEntry(city: "Dubai", country: "United Arab Emirates", timeZoneIdentifier: "Asia/Dubai", region: "Asia"),
        TimeZoneCatalogEntry(city: "Abu Dhabi", country: "United Arab Emirates", timeZoneIdentifier: "Asia/Dubai", region: "Asia"),
        TimeZoneCatalogEntry(city: "Riyadh", country: "Saudi Arabia", timeZoneIdentifier: "Asia/Riyadh", region: "Asia"),
        TimeZoneCatalogEntry(city: "Doha", country: "Qatar", timeZoneIdentifier: "Asia/Qatar", region: "Asia"),
        TimeZoneCatalogEntry(city: "Kuwait City", country: "Kuwait", timeZoneIdentifier: "Asia/Kuwait", region: "Asia"),
        TimeZoneCatalogEntry(city: "Tehran", country: "Iran", timeZoneIdentifier: "Asia/Tehran", region: "Asia"),
        TimeZoneCatalogEntry(city: "Jerusalem", country: "Israel", timeZoneIdentifier: "Asia/Jerusalem", region: "Asia"),
        TimeZoneCatalogEntry(city: "Tel Aviv", country: "Israel", timeZoneIdentifier: "Asia/Jerusalem", region: "Asia"),
        TimeZoneCatalogEntry(city: "Baghdad", country: "Iraq", timeZoneIdentifier: "Asia/Baghdad", region: "Asia"),
        TimeZoneCatalogEntry(city: "Tashkent", country: "Uzbekistan", timeZoneIdentifier: "Asia/Tashkent", region: "Asia"),
        TimeZoneCatalogEntry(city: "Almaty", country: "Kazakhstan", timeZoneIdentifier: "Asia/Almaty", region: "Asia"),
        TimeZoneCatalogEntry(city: "Baku", country: "Azerbaijan", timeZoneIdentifier: "Asia/Baku", region: "Asia"),
        TimeZoneCatalogEntry(city: "Yerevan", country: "Armenia", timeZoneIdentifier: "Asia/Yerevan", region: "Asia"),
        TimeZoneCatalogEntry(city: "Tbilisi", country: "Georgia", timeZoneIdentifier: "Asia/Tbilisi", region: "Asia"),
        TimeZoneCatalogEntry(city: "Ulaanbaatar", country: "Mongolia", timeZoneIdentifier: "Asia/Ulaanbaatar", region: "Asia"),
        TimeZoneCatalogEntry(city: "Vladivostok", country: "Russia", timeZoneIdentifier: "Asia/Vladivostok", region: "Asia"),
        TimeZoneCatalogEntry(city: "Yekaterinburg", country: "Russia", timeZoneIdentifier: "Asia/Yekaterinburg", region: "Asia"),

        // Oceania
        TimeZoneCatalogEntry(city: "Sydney", country: "Australia", timeZoneIdentifier: "Australia/Sydney", region: "Oceania"),
        TimeZoneCatalogEntry(city: "Melbourne", country: "Australia", timeZoneIdentifier: "Australia/Melbourne", region: "Oceania"),
        TimeZoneCatalogEntry(city: "Brisbane", country: "Australia", timeZoneIdentifier: "Australia/Brisbane", region: "Oceania"),
        TimeZoneCatalogEntry(city: "Perth", country: "Australia", timeZoneIdentifier: "Australia/Perth", region: "Oceania"),
        TimeZoneCatalogEntry(city: "Adelaide", country: "Australia", timeZoneIdentifier: "Australia/Adelaide", region: "Oceania"),
        TimeZoneCatalogEntry(city: "Auckland", country: "New Zealand", timeZoneIdentifier: "Pacific/Auckland", region: "Oceania"),
        TimeZoneCatalogEntry(city: "Wellington", country: "New Zealand", timeZoneIdentifier: "Pacific/Auckland", region: "Oceania"),
        TimeZoneCatalogEntry(city: "Fiji", country: "Fiji", timeZoneIdentifier: "Pacific/Fiji", region: "Oceania"),
        TimeZoneCatalogEntry(city: "Port Moresby", country: "Papua New Guinea", timeZoneIdentifier: "Pacific/Port_Moresby", region: "Oceania"),
        TimeZoneCatalogEntry(city: "Guam", country: "United States", timeZoneIdentifier: "Pacific/Guam", region: "Oceania"),

        // Pacific
        TimeZoneCatalogEntry(city: "UTC", country: "Coordinated Universal Time", timeZoneIdentifier: "UTC", region: "Pacific"),
        TimeZoneCatalogEntry(city: "Midway Island", country: "United States", timeZoneIdentifier: "Pacific/Midway", region: "Pacific"),
        TimeZoneCatalogEntry(city: "Pago Pago", country: "American Samoa", timeZoneIdentifier: "Pacific/Pago_Pago", region: "Pacific"),
        TimeZoneCatalogEntry(city: "Tahiti", country: "French Polynesia", timeZoneIdentifier: "Pacific/Tahiti", region: "Pacific"),
        TimeZoneCatalogEntry(city: "Kiritimati", country: "Kiribati", timeZoneIdentifier: "Pacific/Kiritimati", region: "Pacific"),
    ]

    /// Region display order for grouped catalog lists.
    static let regionOrder = ["Americas", "Europe", "Africa", "Asia", "Oceania", "Pacific"]

    /// Returns catalog entries grouped by region in ``regionOrder``.
    ///
    /// - Returns: Dictionary mapping region name to sorted catalog entries.
    static func groupedByRegion() -> [String: [TimeZoneCatalogEntry]] {
        Dictionary(grouping: all, by: \.region)
    }

    /// Finds the first catalog entry matching an IANA timezone identifier.
    ///
    /// - Parameter timeZoneIdentifier: IANA timezone identifier to look up.
    /// - Returns: Matching catalog entry, or `nil` when not found.
    static func entry(forTimeZoneIdentifier timeZoneIdentifier: String) -> TimeZoneCatalogEntry? {
        all.first { $0.timeZoneIdentifier == timeZoneIdentifier }
    }

    /// Filters catalog entries by a diacritic-insensitive search query.
    ///
    /// Matches against city, country, display name, timezone identifier, and region.
    ///
    /// - Parameter query: User search text; empty query returns all entries.
    /// - Returns: Filtered catalog entries sorted by region then city.
    static func filtered(by query: String) -> [TimeZoneCatalogEntry] {
        let matching = all.filter { $0.matchesSearch(query) }
        return sortedByRegionThenCity(matching)
    }

    /// Sorts catalog entries by ``regionOrder``, then city name within each region.
    ///
    /// - Parameter entries: Catalog rows to sort.
    /// - Returns: Entries ordered for grouped list display.
    private static func sortedByRegionThenCity(_ entries: [TimeZoneCatalogEntry]) -> [TimeZoneCatalogEntry] {
        entries.sorted {
            if $0.region == $1.region {
                return $0.city.localizedCaseInsensitiveCompare($1.city) == .orderedAscending
            }
            let leftIndex = regionOrder.firstIndex(of: $0.region) ?? Int.max
            let rightIndex = regionOrder.firstIndex(of: $1.region) ?? Int.max
            return leftIndex < rightIndex
        }
    }
}
