import Foundation

/// Formats weather temperatures and maps Open-Meteo WMO codes to SF Symbols.
enum WeatherFormatting {

    /// Formats a Celsius temperature for display in the requested unit.
    ///
    /// - Parameters:
    ///   - celsius: Stored temperature in degrees Celsius.
    ///   - unit: User-facing display unit.
    /// - Returns: Rounded integer string such as `"22°C"` or `"72°F"`.
    static func formattedTemperature(celsius: Double, unit: TemperatureUnit) -> String {
        switch unit {
        case .celsius:
            return "\(Int(celsius.rounded()))°C"
        case .fahrenheit:
            let fahrenheit = celsius * 9.0 / 5.0 + 32.0
            return "\(Int(fahrenheit.rounded()))°F"
        }
    }

    /// Returns an SF Symbol name for an Open-Meteo WMO weather code.
    ///
    /// - Parameter weatherCode: Open-Meteo WMO interpretation code.
    /// - Returns: SF Symbol system name suitable for a compact row icon.
    static func symbolName(forWeatherCode weatherCode: Int) -> String {
        switch weatherCode {
        case 0:
            return "sun.max.fill"
        case 1, 2:
            return "cloud.sun.fill"
        case 3:
            return "cloud.fill"
        case 45, 48:
            return "cloud.fog.fill"
        case 51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82:
            return "cloud.rain.fill"
        case 71, 73, 75, 77, 85, 86:
            return "cloud.snow.fill"
        case 95, 96, 99:
            return "cloud.bolt.rain.fill"
        default:
            return "cloud.fill"
        }
    }

    /// Returns a plain-language condition label for VoiceOver.
    ///
    /// - Parameter weatherCode: Open-Meteo WMO interpretation code.
    /// - Returns: Short accessibility description of the condition.
    static func conditionDescription(forWeatherCode weatherCode: Int) -> String {
        switch weatherCode {
        case 0:
            return "clear"
        case 1, 2:
            return "partly cloudy"
        case 3:
            return "cloudy"
        case 45, 48:
            return "foggy"
        case 51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82:
            return "rainy"
        case 71, 73, 75, 77, 85, 86:
            return "snowy"
        case 95, 96, 99:
            return "stormy"
        default:
            return "cloudy"
        }
    }
}
