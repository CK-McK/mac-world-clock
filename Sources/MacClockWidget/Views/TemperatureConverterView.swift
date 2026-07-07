import SwiftUI

/// Bidirectional Celsius and Fahrenheit converter shown in the main panel footer.
struct TemperatureConverterView: View {
    @State private var celsiusText = ""
    @State private var fahrenheitText = ""
    @State private var isSyncing = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Temperature converter")
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack(spacing: 8) {
                temperatureField(
                    text: $celsiusText,
                    unitLabel: "°C",
                    accessibilityLabel: "Celsius"
                )
                .onChange(of: celsiusText) { newValue in
                    syncFromCelsius(newValue)
                }

                Image(systemName: "arrow.left.arrow.right")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)

                temperatureField(
                    text: $fahrenheitText,
                    unitLabel: "°F",
                    accessibilityLabel: "Fahrenheit"
                )
                .onChange(of: fahrenheitText) { newValue in
                    syncFromFahrenheit(newValue)
                }
            }
            .padding(8)
            .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 8))
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
    }

    /// Renders one temperature input with a trailing unit suffix.
    ///
    /// - Parameters:
    ///   - text: Binding to the field's string value.
    ///   - unitLabel: Suffix shown after the field, such as `°C` or `°F`.
    ///   - accessibilityLabel: VoiceOver label for the field.
    /// - Returns: A compact labeled text field row.
    private func temperatureField(
        text: Binding<String>,
        unitLabel: String,
        accessibilityLabel: String
    ) -> some View {
        HStack(spacing: 4) {
            TextField("0", text: text)
                .textFieldStyle(.plain)
                .monospacedDigit()
                .frame(minWidth: 48, maxWidth: .infinity)
                .accessibilityLabel(accessibilityLabel)
            Text(unitLabel)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    /// Updates the Fahrenheit field when Celsius input changes.
    ///
    /// - Parameter newValue: Latest Celsius text field contents.
    private func syncFromCelsius(_ newValue: String) {
        guard !isSyncing else { return }
        isSyncing = true
        defer { isSyncing = false }

        if newValue.isEmpty {
            fahrenheitText = ""
            return
        }

        guard let celsius = parseTemperature(newValue) else { return }

        fahrenheitText = formatTemperature(
            WeatherFormatting.fahrenheit(fromCelsius: celsius)
        )
    }

    /// Updates the Celsius field when Fahrenheit input changes.
    ///
    /// - Parameter newValue: Latest Fahrenheit text field contents.
    private func syncFromFahrenheit(_ newValue: String) {
        guard !isSyncing else { return }
        isSyncing = true
        defer { isSyncing = false }

        if newValue.isEmpty {
            celsiusText = ""
            return
        }

        guard let fahrenheit = parseTemperature(newValue) else { return }

        celsiusText = formatTemperature(
            WeatherFormatting.celsius(fromFahrenheit: fahrenheit)
        )
    }

    /// Parses a locale-aware temperature string into a `Double`.
    ///
    /// - Parameter text: User-entered temperature text.
    /// - Returns: Parsed value, or `nil` when the input is empty or not yet a valid number.
    private func parseTemperature(_ text: String) -> Double? {
        let trimmed = text.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return nil }

        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal

        if let number = formatter.number(from: trimmed) {
            return number.doubleValue
        }

        let normalized = trimmed.replacingOccurrences(of: ",", with: ".")
        return Double(normalized)
    }

    /// Formats a temperature for display with up to one decimal place.
    ///
    /// - Parameter value: Temperature value to format.
    /// - Returns: String such as `"22"` or `"37.5"`.
    private func formatTemperature(_ value: Double) -> String {
        let rounded = (value * 10).rounded() / 10
        if abs(rounded.truncatingRemainder(dividingBy: 1)) < 0.001 {
            return String(Int(rounded.rounded()))
        }

        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: rounded)) ?? String(format: "%.1f", rounded)
    }

    /// Builds a VoiceOver label describing the converter and current values.
    private var accessibilityDescription: String {
        if celsiusText.isEmpty && fahrenheitText.isEmpty {
            return "Temperature converter. Enter a value in Celsius or Fahrenheit."
        }
        if celsiusText.isEmpty {
            return "Temperature converter. \(fahrenheitText) degrees Fahrenheit."
        }
        if fahrenheitText.isEmpty {
            return "Temperature converter. \(celsiusText) degrees Celsius."
        }
        return "Temperature converter. \(celsiusText) degrees Celsius, \(fahrenheitText) degrees Fahrenheit."
    }
}
