import Foundation

/// Formats weather temperatures and maps Open-Meteo WMO codes to SF Symbols.
enum WeatherFormatting {

    /// Formats a Celsius temperature for display in both metric and imperial units.
    ///
    /// - Parameter celsius: Stored temperature in degrees Celsius.
    /// - Returns: Rounded integer string such as `"22°C / 72°F"`.
    static func formattedBothTemperatures(celsius: Double) -> String {
        let celsiusRounded = Int(celsius.rounded())
        let fahrenheitRounded = Int(fahrenheit(fromCelsius: celsius).rounded())
        return "\(celsiusRounded)°C / \(fahrenheitRounded)°F"
    }

    /// Returns a VoiceOver-friendly label announcing both Celsius and Fahrenheit values.
    ///
    /// - Parameter celsius: Stored temperature in degrees Celsius.
    /// - Returns: Plain-language string such as `"22 degrees Celsius, 72 degrees Fahrenheit"`.
    static func formattedBothTemperaturesAccessibility(celsius: Double) -> String {
        let celsiusRounded = Int(celsius.rounded())
        let fahrenheitRounded = Int(fahrenheit(fromCelsius: celsius).rounded())
        return "\(celsiusRounded) degrees Celsius, \(fahrenheitRounded) degrees Fahrenheit"
    }

    /// Converts Celsius to Fahrenheit using the standard linear formula.
    ///
    /// - Parameter celsius: Temperature in degrees Celsius.
    /// - Returns: Equivalent temperature in degrees Fahrenheit.
    static func fahrenheit(fromCelsius celsius: Double) -> Double {
        celsius * 9.0 / 5.0 + 32.0
    }

    /// Converts Fahrenheit to Celsius using the standard linear formula.
    ///
    /// - Parameter fahrenheit: Temperature in degrees Fahrenheit.
    /// - Returns: Equivalent temperature in degrees Celsius.
    static func celsius(fromFahrenheit fahrenheit: Double) -> Double {
        (fahrenheit - 32.0) * 5.0 / 9.0
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
