import SwiftUI

/// Displays one configured city with live time, weather, and offset from local time.
struct CityRowView: View {
    /// The persisted world clock entry to render.
    let entry: WorldClockEntry
    /// The instant used for time and offset calculations.
    let date: Date
    /// Cached weather for this row, when available.
    let weather: WeatherSnapshot?
    /// User-selected temperature display unit.
    let temperatureUnit: TemperatureUnit

    /// Resolves the entry's IANA timezone, falling back to the current timezone when invalid.
    private var timeZone: TimeZone {
        TimeZone(identifier: entry.timeZoneIdentifier) ?? .current
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text(entry.displayName)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 6) {
                if let weather {
                    weatherSegment(for: weather)
                }
                dayNightIcon
                Text(TimeFormatting.formattedTime(in: timeZone, at: date))
                    .monospacedDigit()
                Text(TimeFormatting.formattedOffset(fromLocalTo: timeZone, at: date))
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            .font(.body)
            .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
    }

    /// Renders the weather icon and formatted temperature for a snapshot.
    ///
    /// - Parameter weather: Cached weather data for this row.
    /// - Returns: Compact weather segment placed before the day/night icon.
    private func weatherSegment(for weather: WeatherSnapshot) -> some View {
        HStack(spacing: 3) {
            Image(systemName: WeatherFormatting.symbolName(forWeatherCode: weather.weatherCode))
                .font(.caption)
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)
            Text(WeatherFormatting.formattedTemperature(celsius: weather.temperatureCelsius, unit: temperatureUnit))
                .font(.caption)
                .foregroundStyle(.secondary)
                .monospacedDigit()
        }
    }

    /// Sun or moon icon reflecting daytime vs nighttime in the row's timezone.
    private var dayNightIcon: some View {
        let isDaytime = TimeFormatting.isDaytime(in: timeZone, at: date)
        return Image(systemName: TimeFormatting.dayNightSymbolName(in: timeZone, at: date))
            .font(.caption)
            .foregroundStyle(isDaytime ? Color.orange : Color.secondary)
            .accessibilityHidden(true)
    }

    /// Builds a VoiceOver label combining city, weather, time, offset, and day/night period.
    private var accessibilityDescription: String {
        let time = TimeFormatting.formattedTime(in: timeZone, at: date)
        let offset = TimeFormatting.formattedOffset(fromLocalTo: timeZone, at: date)
        let period = TimeFormatting.isDaytime(in: timeZone, at: date) ? "daytime" : "nighttime"
        if let weather {
            let temperature = WeatherFormatting.formattedTemperature(
                celsius: weather.temperatureCelsius,
                unit: temperatureUnit
            )
            let condition = WeatherFormatting.conditionDescription(forWeatherCode: weather.weatherCode)
            return "\(entry.displayName), \(temperature), \(condition), \(time), \(offset), \(period)"
        }
        return "\(entry.displayName), \(time), \(offset), \(period)"
    }
}
