import SwiftUI

/// Displays one configured city with live time and offset from local time.
struct CityRowView: View {
    /// The persisted world clock entry to render.
    let entry: WorldClockEntry
    /// The instant used for time and offset calculations.
    let date: Date

    /// Resolves the entry's IANA timezone, falling back to the current timezone when invalid.
    private var timeZone: TimeZone {
        TimeZone(identifier: entry.timeZoneIdentifier) ?? .current
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text(entry.displayName)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 6) {
                dayNightIcon
                Text(TimeFormatting.formattedTime(in: timeZone, at: date))
                    .monospacedDigit()
                Text(TimeFormatting.formattedOffset(fromLocalTo: timeZone, at: date))
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            .font(.body)
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
    }

    /// Sun or moon icon reflecting daytime vs nighttime in the row's timezone.
    private var dayNightIcon: some View {
        let isDaytime = TimeFormatting.isDaytime(in: timeZone, at: date)
        return Image(systemName: TimeFormatting.dayNightSymbolName(in: timeZone, at: date))
            .font(.caption)
            .foregroundStyle(isDaytime ? Color.orange : Color.secondary)
            .accessibilityHidden(true)
    }

    /// Builds a VoiceOver label combining city, time, offset, and day/night period.
    private var accessibilityDescription: String {
        let time = TimeFormatting.formattedTime(in: timeZone, at: date)
        let offset = TimeFormatting.formattedOffset(fromLocalTo: timeZone, at: date)
        let period = TimeFormatting.isDaytime(in: timeZone, at: date) ? "daytime" : "nighttime"
        return "\(entry.displayName), \(time), \(offset), \(period)"
    }
}
