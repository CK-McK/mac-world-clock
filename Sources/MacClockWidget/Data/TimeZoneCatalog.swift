import Foundation

/// Static curated catalog of major world cities and their IANA timezones.
enum TimeZoneCatalog {

    /// All catalog entries sorted by region, then city name.
    static let all: [TimeZoneCatalogEntry] = [
        // Americas
                TimeZoneCatalogEntry(city: "New York", country: "United States", timeZoneIdentifier: "America/New_York", region: "Americas", latitude: 40.7143, longitude: -74.0060),
                TimeZoneCatalogEntry(city: "Los Angeles", country: "United States", timeZoneIdentifier: "America/Los_Angeles", region: "Americas", latitude: 34.0522, longitude: -118.2437),
                TimeZoneCatalogEntry(city: "Chicago", country: "United States", timeZoneIdentifier: "America/Chicago", region: "Americas", latitude: 41.8500, longitude: -87.6500),
                TimeZoneCatalogEntry(city: "Denver", country: "United States", timeZoneIdentifier: "America/Denver", region: "Americas", latitude: 39.7392, longitude: -104.9847),
                TimeZoneCatalogEntry(city: "Phoenix", country: "United States", timeZoneIdentifier: "America/Phoenix", region: "Americas", latitude: 33.4484, longitude: -112.0740),
                TimeZoneCatalogEntry(city: "Anchorage", country: "United States", timeZoneIdentifier: "America/Anchorage", region: "Americas", latitude: 61.2181, longitude: -149.9003),
                TimeZoneCatalogEntry(city: "Honolulu", country: "United States", timeZoneIdentifier: "Pacific/Honolulu", region: "Americas", latitude: 21.3069, longitude: -157.8583),
                TimeZoneCatalogEntry(city: "Toronto", country: "Canada", timeZoneIdentifier: "America/Toronto", region: "Americas", latitude: 43.7064, longitude: -79.3986),
                TimeZoneCatalogEntry(city: "Vancouver", country: "Canada", timeZoneIdentifier: "America/Vancouver", region: "Americas", latitude: 49.2497, longitude: -123.1193),
                TimeZoneCatalogEntry(city: "Montreal", country: "Canada", timeZoneIdentifier: "America/Montreal", region: "Americas", latitude: 45.5088, longitude: -73.5878),
                TimeZoneCatalogEntry(city: "Calgary", country: "Canada", timeZoneIdentifier: "America/Edmonton", region: "Americas", latitude: 51.0501, longitude: -114.0853),
                TimeZoneCatalogEntry(city: "Halifax", country: "Canada", timeZoneIdentifier: "America/Halifax", region: "Americas", latitude: 44.6427, longitude: -63.5769),
                TimeZoneCatalogEntry(city: "Mexico City", country: "Mexico", timeZoneIdentifier: "America/Mexico_City", region: "Americas", latitude: 19.4285, longitude: -99.1277),
                TimeZoneCatalogEntry(city: "Guadalajara", country: "Mexico", timeZoneIdentifier: "America/Mexico_City", region: "Americas", latitude: 20.6774, longitude: -103.3475),
                TimeZoneCatalogEntry(city: "Cancún", country: "Mexico", timeZoneIdentifier: "America/Cancun", region: "Americas", latitude: 21.1743, longitude: -86.8466),
                TimeZoneCatalogEntry(city: "São Paulo", country: "Brazil", timeZoneIdentifier: "America/Sao_Paulo", region: "Americas", latitude: -23.5475, longitude: -46.6361),
                TimeZoneCatalogEntry(city: "Rio de Janeiro", country: "Brazil", timeZoneIdentifier: "America/Sao_Paulo", region: "Americas", latitude: -22.9064, longitude: -43.1822),
                TimeZoneCatalogEntry(city: "Brasília", country: "Brazil", timeZoneIdentifier: "America/Sao_Paulo", region: "Americas", latitude: -15.7797, longitude: -47.9297),
                TimeZoneCatalogEntry(city: "Manaus", country: "Brazil", timeZoneIdentifier: "America/Manaus", region: "Americas", latitude: -3.1019, longitude: -60.0250),
                TimeZoneCatalogEntry(city: "Buenos Aires", country: "Argentina", timeZoneIdentifier: "America/Argentina/Buenos_Aires", region: "Americas", latitude: -34.6131, longitude: -58.3772),
                TimeZoneCatalogEntry(city: "Santiago", country: "Chile", timeZoneIdentifier: "America/Santiago", region: "Americas", latitude: -33.4569, longitude: -70.6483),
                TimeZoneCatalogEntry(city: "Lima", country: "Peru", timeZoneIdentifier: "America/Lima", region: "Americas", latitude: -12.0432, longitude: -77.0282),
                TimeZoneCatalogEntry(city: "Bogotá", country: "Colombia", timeZoneIdentifier: "America/Bogota", region: "Americas", latitude: 4.6097, longitude: -74.0817),
                TimeZoneCatalogEntry(city: "Caracas", country: "Venezuela", timeZoneIdentifier: "America/Caracas", region: "Americas", latitude: 10.4880, longitude: -66.8792),
                TimeZoneCatalogEntry(city: "Quito", country: "Ecuador", timeZoneIdentifier: "America/Guayaquil", region: "Americas", latitude: -0.2298, longitude: -78.5250),
                TimeZoneCatalogEntry(city: "La Paz", country: "Bolivia", timeZoneIdentifier: "America/La_Paz", region: "Americas", latitude: -16.4897, longitude: -68.1193),
                TimeZoneCatalogEntry(city: "Montevideo", country: "Uruguay", timeZoneIdentifier: "America/Montevideo", region: "Americas", latitude: -34.9033, longitude: -56.1882),
                TimeZoneCatalogEntry(city: "Asunción", country: "Paraguay", timeZoneIdentifier: "America/Asuncion", region: "Americas", latitude: -25.2865, longitude: -57.6470),
                TimeZoneCatalogEntry(city: "San José", country: "Costa Rica", timeZoneIdentifier: "America/Costa_Rica", region: "Americas", latitude: 9.9281, longitude: -84.0907),
                TimeZoneCatalogEntry(city: "Panama City", country: "Panama", timeZoneIdentifier: "America/Panama", region: "Americas", latitude: 8.9936, longitude: -79.5197),
                TimeZoneCatalogEntry(city: "Havana", country: "Cuba", timeZoneIdentifier: "America/Havana", region: "Americas", latitude: 23.1330, longitude: -82.3830),
                TimeZoneCatalogEntry(city: "Kingston", country: "Jamaica", timeZoneIdentifier: "America/Jamaica", region: "Americas", latitude: 17.9970, longitude: -76.7936),
                TimeZoneCatalogEntry(city: "San Juan", country: "Puerto Rico", timeZoneIdentifier: "America/Puerto_Rico", region: "Americas", latitude: 18.4655, longitude: -66.1057),

        // Europe
                TimeZoneCatalogEntry(city: "London", country: "United Kingdom", timeZoneIdentifier: "Europe/London", region: "Europe", latitude: 51.5085, longitude: -0.1257),
                TimeZoneCatalogEntry(city: "Dublin", country: "Ireland", timeZoneIdentifier: "Europe/Dublin", region: "Europe", latitude: 53.3331, longitude: -6.2489),
                TimeZoneCatalogEntry(city: "Paris", country: "France", timeZoneIdentifier: "Europe/Paris", region: "Europe", latitude: 48.8534, longitude: 2.3488),
                TimeZoneCatalogEntry(city: "Berlin", country: "Germany", timeZoneIdentifier: "Europe/Berlin", region: "Europe", latitude: 52.5244, longitude: 13.4105),
                TimeZoneCatalogEntry(city: "Munich", country: "Germany", timeZoneIdentifier: "Europe/Berlin", region: "Europe", latitude: 48.1374, longitude: 11.5755),
                TimeZoneCatalogEntry(city: "Amsterdam", country: "Netherlands", timeZoneIdentifier: "Europe/Amsterdam", region: "Europe", latitude: 52.3676, longitude: 4.9041),
                TimeZoneCatalogEntry(city: "Brussels", country: "Belgium", timeZoneIdentifier: "Europe/Brussels", region: "Europe", latitude: 50.8505, longitude: 4.3488),
                TimeZoneCatalogEntry(city: "Zurich", country: "Switzerland", timeZoneIdentifier: "Europe/Zurich", region: "Europe", latitude: 47.3667, longitude: 8.5500),
                TimeZoneCatalogEntry(city: "Vienna", country: "Austria", timeZoneIdentifier: "Europe/Vienna", region: "Europe", latitude: 48.2085, longitude: 16.3721),
                TimeZoneCatalogEntry(city: "Rome", country: "Italy", timeZoneIdentifier: "Europe/Rome", region: "Europe", latitude: 41.8919, longitude: 12.5113),
                TimeZoneCatalogEntry(city: "Milan", country: "Italy", timeZoneIdentifier: "Europe/Rome", region: "Europe", latitude: 45.4643, longitude: 9.1895),
                TimeZoneCatalogEntry(city: "Madrid", country: "Spain", timeZoneIdentifier: "Europe/Madrid", region: "Europe", latitude: 40.4165, longitude: -3.7026),
                TimeZoneCatalogEntry(city: "Barcelona", country: "Spain", timeZoneIdentifier: "Europe/Madrid", region: "Europe", latitude: 41.3888, longitude: 2.1590),
                TimeZoneCatalogEntry(city: "Lisbon", country: "Portugal", timeZoneIdentifier: "Europe/Lisbon", region: "Europe", latitude: 38.7251, longitude: -9.1498),
                TimeZoneCatalogEntry(city: "Stockholm", country: "Sweden", timeZoneIdentifier: "Europe/Stockholm", region: "Europe", latitude: 59.3294, longitude: 18.0687),
                TimeZoneCatalogEntry(city: "Oslo", country: "Norway", timeZoneIdentifier: "Europe/Oslo", region: "Europe", latitude: 59.9127, longitude: 10.7461),
                TimeZoneCatalogEntry(city: "Copenhagen", country: "Denmark", timeZoneIdentifier: "Europe/Copenhagen", region: "Europe", latitude: 55.6759, longitude: 12.5655),
                TimeZoneCatalogEntry(city: "Helsinki", country: "Finland", timeZoneIdentifier: "Europe/Helsinki", region: "Europe", latitude: 60.1695, longitude: 24.9354),
                TimeZoneCatalogEntry(city: "Warsaw", country: "Poland", timeZoneIdentifier: "Europe/Warsaw", region: "Europe", latitude: 52.2298, longitude: 21.0118),
                TimeZoneCatalogEntry(city: "Prague", country: "Czech Republic", timeZoneIdentifier: "Europe/Prague", region: "Europe", latitude: 50.0755, longitude: 14.4378),
                TimeZoneCatalogEntry(city: "Budapest", country: "Hungary", timeZoneIdentifier: "Europe/Budapest", region: "Europe", latitude: 47.4984, longitude: 19.0404),
                TimeZoneCatalogEntry(city: "Athens", country: "Greece", timeZoneIdentifier: "Europe/Athens", region: "Europe", latitude: 37.9838, longitude: 23.7278),
                TimeZoneCatalogEntry(city: "Istanbul", country: "Turkey", timeZoneIdentifier: "Europe/Istanbul", region: "Europe", latitude: 41.0082, longitude: 28.9784),
                TimeZoneCatalogEntry(city: "Moscow", country: "Russia", timeZoneIdentifier: "Europe/Moscow", region: "Europe", latitude: 55.7520, longitude: 37.6178),
                TimeZoneCatalogEntry(city: "Kyiv", country: "Ukraine", timeZoneIdentifier: "Europe/Kyiv", region: "Europe", latitude: 50.4547, longitude: 30.5238),
                TimeZoneCatalogEntry(city: "Bucharest", country: "Romania", timeZoneIdentifier: "Europe/Bucharest", region: "Europe", latitude: 44.4323, longitude: 26.1063),
                TimeZoneCatalogEntry(city: "Belgrade", country: "Serbia", timeZoneIdentifier: "Europe/Belgrade", region: "Europe", latitude: 44.8040, longitude: 20.4651),
                TimeZoneCatalogEntry(city: "Reykjavik", country: "Iceland", timeZoneIdentifier: "Atlantic/Reykjavik", region: "Europe", latitude: 64.1355, longitude: -21.8954),

        // Africa
                TimeZoneCatalogEntry(city: "Cairo", country: "Egypt", timeZoneIdentifier: "Africa/Cairo", region: "Africa", latitude: 30.0626, longitude: 31.2497),
                TimeZoneCatalogEntry(city: "Johannesburg", country: "South Africa", timeZoneIdentifier: "Africa/Johannesburg", region: "Africa", latitude: -26.2023, longitude: 28.0436),
                TimeZoneCatalogEntry(city: "Cape Town", country: "South Africa", timeZoneIdentifier: "Africa/Johannesburg", region: "Africa", latitude: -33.9258, longitude: 18.4232),
                TimeZoneCatalogEntry(city: "Lagos", country: "Nigeria", timeZoneIdentifier: "Africa/Lagos", region: "Africa", latitude: 6.4541, longitude: 3.3947),
                TimeZoneCatalogEntry(city: "Nairobi", country: "Kenya", timeZoneIdentifier: "Africa/Nairobi", region: "Africa", latitude: -1.2833, longitude: 36.8167),
                TimeZoneCatalogEntry(city: "Casablanca", country: "Morocco", timeZoneIdentifier: "Africa/Casablanca", region: "Africa", latitude: 33.5883, longitude: -7.6114),
                TimeZoneCatalogEntry(city: "Accra", country: "Ghana", timeZoneIdentifier: "Africa/Accra", region: "Africa", latitude: 5.5560, longitude: -0.1969),
                TimeZoneCatalogEntry(city: "Addis Ababa", country: "Ethiopia", timeZoneIdentifier: "Africa/Addis_Ababa", region: "Africa", latitude: 9.0250, longitude: 38.7469),
                TimeZoneCatalogEntry(city: "Tunis", country: "Tunisia", timeZoneIdentifier: "Africa/Tunis", region: "Africa", latitude: 36.8190, longitude: 10.1658),
                TimeZoneCatalogEntry(city: "Algiers", country: "Algeria", timeZoneIdentifier: "Africa/Algiers", region: "Africa", latitude: 36.7323, longitude: 3.0875),
                TimeZoneCatalogEntry(city: "Dar es Salaam", country: "Tanzania", timeZoneIdentifier: "Africa/Dar_es_Salaam", region: "Africa", latitude: -6.8235, longitude: 39.2695),
                TimeZoneCatalogEntry(city: "Kampala", country: "Uganda", timeZoneIdentifier: "Africa/Kampala", region: "Africa", latitude: 0.3163, longitude: 32.5822),

        // Asia
                TimeZoneCatalogEntry(city: "Tokyo", country: "Japan", timeZoneIdentifier: "Asia/Tokyo", region: "Asia", latitude: 35.6895, longitude: 139.6917),
                TimeZoneCatalogEntry(city: "Seoul", country: "South Korea", timeZoneIdentifier: "Asia/Seoul", region: "Asia", latitude: 37.5660, longitude: 126.9784),
                TimeZoneCatalogEntry(city: "Beijing", country: "China", timeZoneIdentifier: "Asia/Shanghai", region: "Asia", latitude: 39.9075, longitude: 116.3972),
                TimeZoneCatalogEntry(city: "Shanghai", country: "China", timeZoneIdentifier: "Asia/Shanghai", region: "Asia", latitude: 31.2222, longitude: 121.4581),
                TimeZoneCatalogEntry(city: "Hong Kong", country: "China", timeZoneIdentifier: "Asia/Hong_Kong", region: "Asia", latitude: 22.3193, longitude: 114.1694),
                TimeZoneCatalogEntry(city: "Taipei", country: "Taiwan", timeZoneIdentifier: "Asia/Taipei", region: "Asia", latitude: 25.0531, longitude: 121.5264),
                TimeZoneCatalogEntry(city: "Singapore", country: "Singapore", timeZoneIdentifier: "Asia/Singapore", region: "Asia", latitude: 1.2897, longitude: 103.8501),
                TimeZoneCatalogEntry(city: "Bangkok", country: "Thailand", timeZoneIdentifier: "Asia/Bangkok", region: "Asia", latitude: 13.7540, longitude: 100.5014),
                TimeZoneCatalogEntry(city: "Jakarta", country: "Indonesia", timeZoneIdentifier: "Asia/Jakarta", region: "Asia", latitude: -6.2146, longitude: 106.8451),
                TimeZoneCatalogEntry(city: "Manila", country: "Philippines", timeZoneIdentifier: "Asia/Manila", region: "Asia", latitude: 14.6042, longitude: 120.9822),
                TimeZoneCatalogEntry(city: "Kuala Lumpur", country: "Malaysia", timeZoneIdentifier: "Asia/Kuala_Lumpur", region: "Asia", latitude: 3.1412, longitude: 101.6865),
                TimeZoneCatalogEntry(city: "Ho Chi Minh City", country: "Vietnam", timeZoneIdentifier: "Asia/Ho_Chi_Minh", region: "Asia", latitude: 10.8230, longitude: 106.6296),
                TimeZoneCatalogEntry(city: "Hanoi", country: "Vietnam", timeZoneIdentifier: "Asia/Ho_Chi_Minh", region: "Asia", latitude: 21.0245, longitude: 105.8412),
                TimeZoneCatalogEntry(city: "Mumbai", country: "India", timeZoneIdentifier: "Asia/Kolkata", region: "Asia", latitude: 19.0728, longitude: 72.8826),
                TimeZoneCatalogEntry(city: "New Delhi", country: "India", timeZoneIdentifier: "Asia/Kolkata", region: "Asia", latitude: 28.6214, longitude: 77.2148),
                TimeZoneCatalogEntry(city: "Bangalore", country: "India", timeZoneIdentifier: "Asia/Kolkata", region: "Asia", latitude: 12.9716, longitude: 77.5946),
                TimeZoneCatalogEntry(city: "Karachi", country: "Pakistan", timeZoneIdentifier: "Asia/Karachi", region: "Asia", latitude: 24.8608, longitude: 67.0104),
                TimeZoneCatalogEntry(city: "Dhaka", country: "Bangladesh", timeZoneIdentifier: "Asia/Dhaka", region: "Asia", latitude: 23.7104, longitude: 90.4074),
                TimeZoneCatalogEntry(city: "Colombo", country: "Sri Lanka", timeZoneIdentifier: "Asia/Colombo", region: "Asia", latitude: 6.9355, longitude: 79.8487),
                TimeZoneCatalogEntry(city: "Kathmandu", country: "Nepal", timeZoneIdentifier: "Asia/Kathmandu", region: "Asia", latitude: 27.7017, longitude: 85.3206),
                TimeZoneCatalogEntry(city: "Dubai", country: "United Arab Emirates", timeZoneIdentifier: "Asia/Dubai", region: "Asia", latitude: 25.0772, longitude: 55.3093),
                TimeZoneCatalogEntry(city: "Abu Dhabi", country: "United Arab Emirates", timeZoneIdentifier: "Asia/Dubai", region: "Asia", latitude: 24.4512, longitude: 54.3970),
                TimeZoneCatalogEntry(city: "Riyadh", country: "Saudi Arabia", timeZoneIdentifier: "Asia/Riyadh", region: "Asia", latitude: 24.6877, longitude: 46.7219),
                TimeZoneCatalogEntry(city: "Doha", country: "Qatar", timeZoneIdentifier: "Asia/Qatar", region: "Asia", latitude: 25.2855, longitude: 51.5310),
                TimeZoneCatalogEntry(city: "Kuwait City", country: "Kuwait", timeZoneIdentifier: "Asia/Kuwait", region: "Asia", latitude: 29.3670, longitude: 47.9743),
                TimeZoneCatalogEntry(city: "Tehran", country: "Iran", timeZoneIdentifier: "Asia/Tehran", region: "Asia", latitude: 35.6944, longitude: 51.4215),
                TimeZoneCatalogEntry(city: "Jerusalem", country: "Israel", timeZoneIdentifier: "Asia/Jerusalem", region: "Asia", latitude: 31.7690, longitude: 35.2163),
                TimeZoneCatalogEntry(city: "Tel Aviv", country: "Israel", timeZoneIdentifier: "Asia/Jerusalem", region: "Asia", latitude: 32.0809, longitude: 34.7806),
                TimeZoneCatalogEntry(city: "Baghdad", country: "Iraq", timeZoneIdentifier: "Asia/Baghdad", region: "Asia", latitude: 33.3406, longitude: 44.4009),
                TimeZoneCatalogEntry(city: "Tashkent", country: "Uzbekistan", timeZoneIdentifier: "Asia/Tashkent", region: "Asia", latitude: 41.2647, longitude: 69.2163),
                TimeZoneCatalogEntry(city: "Almaty", country: "Kazakhstan", timeZoneIdentifier: "Asia/Almaty", region: "Asia", latitude: 43.2525, longitude: 76.9115),
                TimeZoneCatalogEntry(city: "Baku", country: "Azerbaijan", timeZoneIdentifier: "Asia/Baku", region: "Asia", latitude: 40.3777, longitude: 49.8920),
                TimeZoneCatalogEntry(city: "Yerevan", country: "Armenia", timeZoneIdentifier: "Asia/Yerevan", region: "Asia", latitude: 40.1776, longitude: 44.5126),
                TimeZoneCatalogEntry(city: "Tbilisi", country: "Georgia", timeZoneIdentifier: "Asia/Tbilisi", region: "Asia", latitude: 41.6914, longitude: 44.8341),
                TimeZoneCatalogEntry(city: "Ulaanbaatar", country: "Mongolia", timeZoneIdentifier: "Asia/Ulaanbaatar", region: "Asia", latitude: 47.9077, longitude: 106.8832),
                TimeZoneCatalogEntry(city: "Vladivostok", country: "Russia", timeZoneIdentifier: "Asia/Vladivostok", region: "Asia", latitude: 43.1056, longitude: 131.8735),
                TimeZoneCatalogEntry(city: "Yekaterinburg", country: "Russia", timeZoneIdentifier: "Asia/Yekaterinburg", region: "Asia", latitude: 56.8573, longitude: 60.6153),

        // Oceania
                TimeZoneCatalogEntry(city: "Sydney", country: "Australia", timeZoneIdentifier: "Australia/Sydney", region: "Oceania", latitude: -33.8678, longitude: 151.2073),
                TimeZoneCatalogEntry(city: "Melbourne", country: "Australia", timeZoneIdentifier: "Australia/Melbourne", region: "Oceania", latitude: -37.8140, longitude: 144.9633),
                TimeZoneCatalogEntry(city: "Brisbane", country: "Australia", timeZoneIdentifier: "Australia/Brisbane", region: "Oceania", latitude: -27.4679, longitude: 153.0281),
                TimeZoneCatalogEntry(city: "Perth", country: "Australia", timeZoneIdentifier: "Australia/Perth", region: "Oceania", latitude: -31.9522, longitude: 115.8614),
                TimeZoneCatalogEntry(city: "Adelaide", country: "Australia", timeZoneIdentifier: "Australia/Adelaide", region: "Oceania", latitude: -34.9287, longitude: 138.5986),
                TimeZoneCatalogEntry(city: "Auckland", country: "New Zealand", timeZoneIdentifier: "Pacific/Auckland", region: "Oceania", latitude: -36.8485, longitude: 174.7635),
                TimeZoneCatalogEntry(city: "Wellington", country: "New Zealand", timeZoneIdentifier: "Pacific/Auckland", region: "Oceania", latitude: -41.2866, longitude: 174.7756),
                TimeZoneCatalogEntry(city: "Fiji", country: "Fiji", timeZoneIdentifier: "Pacific/Fiji", region: "Oceania", latitude: -18.0000, longitude: 178.0000),
                TimeZoneCatalogEntry(city: "Port Moresby", country: "Papua New Guinea", timeZoneIdentifier: "Pacific/Port_Moresby", region: "Oceania", latitude: -9.4772, longitude: 147.1509),
                TimeZoneCatalogEntry(city: "Guam", country: "United States", timeZoneIdentifier: "Pacific/Guam", region: "Oceania", latitude: 13.4443, longitude: 144.7937),

        // Pacific
                TimeZoneCatalogEntry(city: "UTC", country: "Coordinated Universal Time", timeZoneIdentifier: "UTC", region: "Pacific", latitude: 51.4778, longitude: -0.0015),
                TimeZoneCatalogEntry(city: "Midway Island", country: "United States", timeZoneIdentifier: "Pacific/Midway", region: "Pacific", latitude: 38.4987, longitude: -77.3689),
                TimeZoneCatalogEntry(city: "Pago Pago", country: "American Samoa", timeZoneIdentifier: "Pacific/Pago_Pago", region: "Pacific", latitude: -14.2756, longitude: -170.7020),
                TimeZoneCatalogEntry(city: "Tahiti", country: "French Polynesia", timeZoneIdentifier: "Pacific/Tahiti", region: "Pacific", latitude: -17.5516, longitude: -149.5585),
                TimeZoneCatalogEntry(city: "Kiritimati", country: "Kiribati", timeZoneIdentifier: "Pacific/Kiritimati", region: "Pacific", latitude: 1.8721, longitude: -157.4278),
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

    /// Finds the best catalog match for a persisted world clock entry.
    ///
    /// Prefers an exact ``TimeZoneCatalogEntry/displayName`` match so cities that
    /// share a timezone (e.g. Guadalajara vs Mexico City) resolve to the correct coordinates.
    ///
    /// - Parameter worldClockEntry: User-selected world clock row.
    /// - Returns: Matching catalog entry, or `nil` when not found.
    static func entry(matching worldClockEntry: WorldClockEntry) -> TimeZoneCatalogEntry? {
        all.first { $0.displayName == worldClockEntry.displayName }
            ?? all.first { $0.timeZoneIdentifier == worldClockEntry.timeZoneIdentifier }
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
