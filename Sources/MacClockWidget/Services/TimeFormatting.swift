import Foundation

/// Formats clock times and offset strings for world clock display.
enum TimeFormatting {

    /// Shared time formatter that respects the user's macOS 12h/24h preference.
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter
    }()

    /// Hour of day (0–23) at which daytime begins for sun/moon indicators.
    private static let daytimeStartHour = 6

    /// Hour of day (0–23) at which nighttime begins for sun/moon indicators.
    private static let nighttimeStartHour = 18

    /// Returns whether the given instant falls in daytime for a timezone (6 AM–6 PM local).
    ///
    /// - Parameters:
    ///   - timeZone: The target timezone.
    ///   - date: The instant to evaluate; defaults to now.
    /// - Returns: `true` from 6:00 through 17:59 local time; `false` otherwise.
    static func isDaytime(in timeZone: TimeZone, at date: Date = Date()) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        let hour = calendar.component(.hour, from: date)
        return hour >= daytimeStartHour && hour < nighttimeStartHour
    }

    /// Returns the SF Symbol name for the day/night indicator at a timezone's local time.
    ///
    /// - Parameters:
    ///   - timeZone: The target timezone.
    ///   - date: The instant to evaluate; defaults to now.
    /// - Returns: `"sun.max.fill"` during daytime, `"moon.fill"` at night.
    static func dayNightSymbolName(in timeZone: TimeZone, at date: Date = Date()) -> String {
        isDaytime(in: timeZone, at: date) ? "sun.max.fill" : "moon.fill"
    }

    /// Returns the current time in the given timezone formatted for display.
    ///
    /// - Parameters:
    ///   - timeZone: The target timezone.
    ///   - date: The instant to format; defaults to now.
    /// - Returns: A locale-aware time string (e.g. "9:08 PM" or "21:08").
    static func formattedTime(in timeZone: TimeZone, at date: Date = Date()) -> String {
        let formatter = timeFormatter
        formatter.timeZone = timeZone
        return formatter.string(from: date)
    }

    /// Computes the offset in minutes between a target timezone and local time at a given instant.
    ///
    /// Handles daylight saving time correctly by using Foundation's timezone offset APIs.
    ///
    /// - Parameters:
    ///   - timeZone: The target timezone.
    ///   - date: The instant at which to evaluate offsets; defaults to now.
    /// - Returns: Difference in minutes (target minus local). Positive means target is ahead.
    static func offsetMinutes(fromLocalTo timeZone: TimeZone, at date: Date = Date()) -> Int {
        let localOffset = TimeZone.current.secondsFromGMT(for: date)
        let targetOffset = timeZone.secondsFromGMT(for: date)
        return (targetOffset - localOffset) / 60
    }

    /// Formats the offset between local time and a target timezone as a parenthesized string.
    ///
    /// - Parameters:
    ///   - timeZone: The target timezone.
    ///   - date: The instant at which to evaluate offsets; defaults to now.
    /// - Returns: A string such as "(+5h)", "(-3h 30m)", or "(same time)".
    static func formattedOffset(fromLocalTo timeZone: TimeZone, at date: Date = Date()) -> String {
        let minutes = offsetMinutes(fromLocalTo: timeZone, at: date)
        return formattedOffset(minutes: minutes)
    }

    /// Formats a minute offset as a parenthesized human-readable string.
    ///
    /// - Parameter minutes: Signed offset in minutes (positive = ahead of local).
    /// - Returns: A string such as "(+5h)", "(-3h 30m)", or "(same time)".
    static func formattedOffset(minutes: Int) -> String {
        if minutes == 0 {
            return "(same time)"
        }

        let sign = minutes > 0 ? "+" : "-"
        let absoluteMinutes = abs(minutes)
        let hours = absoluteMinutes / 60
        let remainder = absoluteMinutes % 60

        if remainder == 0 {
            return "(\(sign)\(hours)h)"
        }
        return "(\(sign)\(hours)h \(remainder)m)"
    }
}
