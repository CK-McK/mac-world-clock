import Combine
import Foundation

/// Persists and publishes the user's preferred temperature display unit.
///
/// Mirrors ``LaunchAtLoginService`` — changes apply immediately and are not
/// reverted when the configure panel is cancelled.
final class TemperatureUnitPreferences: ObservableObject {

    /// UserDefaults key for the temperature unit preference.
    private static let preferenceKey = "temperatureUnit"

    /// Currently selected display unit for weather temperatures.
    @Published private(set) var unit: TemperatureUnit

    private let defaults: UserDefaults

    /// Creates preferences, defaulting from the system locale on first launch.
    ///
    /// - Parameter defaults: User defaults suite for persistence; `.standard` when omitted.
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        if let raw = defaults.string(forKey: Self.preferenceKey),
           let stored = TemperatureUnit(rawValue: raw) {
            self.unit = stored
        } else {
            let inferred: TemperatureUnit = Locale.current.measurementSystem == .metric ? .celsius : .fahrenheit
            self.unit = inferred
            defaults.set(inferred.rawValue, forKey: Self.preferenceKey)
        }
    }

    /// Updates the display unit and persists immediately.
    ///
    /// - Parameter unit: Desired Celsius or Fahrenheit display.
    func setUnit(_ unit: TemperatureUnit) {
        guard unit != self.unit else { return }
        defaults.set(unit.rawValue, forKey: Self.preferenceKey)
        self.unit = unit
    }
}
