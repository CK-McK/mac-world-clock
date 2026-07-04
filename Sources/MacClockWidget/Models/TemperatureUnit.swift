import Foundation

/// User-facing temperature display unit for weather rows.
enum TemperatureUnit: String, Codable, CaseIterable, Identifiable {
    /// Degrees Celsius.
    case celsius
    /// Degrees Fahrenheit.
    case fahrenheit

    /// Stable identifier for SwiftUI pickers.
    var id: String { rawValue }

    /// Short label shown in the configure panel segmented control.
    var pickerLabel: String {
        switch self {
        case .celsius: return "Celsius"
        case .fahrenheit: return "Fahrenheit"
        }
    }
}
