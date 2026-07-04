import Foundation

/// Cached current weather for one world clock entry.
struct WeatherSnapshot: Equatable {
    /// Current air temperature stored in Celsius regardless of display unit.
    let temperatureCelsius: Double
    /// Open-Meteo WMO weather interpretation code.
    let weatherCode: Int
    /// When this snapshot was fetched from the API.
    let fetchedAt: Date
}
