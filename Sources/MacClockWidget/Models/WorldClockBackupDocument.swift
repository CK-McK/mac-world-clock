import Foundation

/// JSON backup envelope for a world clock city list export.
///
/// Wraps persisted ``WorldClockEntry`` values with a schema version and export
/// timestamp so imports can validate structure and reject unsupported formats.
struct WorldClockBackupDocument: Codable, Equatable {
    /// Supported backup schema version written by current app releases.
    static let currentSchemaVersion = 1

    /// Backup format version; importers must recognize this value.
    let schemaVersion: Int
    /// UTC timestamp when the backup file was created.
    let exportedAt: Date
    /// Selected cities in display order (max 10 when exported from the app).
    let entries: [WorldClockEntry]

    /// Creates a backup document for the given city list.
    ///
    /// - Parameter entries: Current persisted entries to include in the backup.
    /// - Returns: A document tagged with the current schema version and export time.
    static func make(from entries: [WorldClockEntry]) -> WorldClockBackupDocument {
        WorldClockBackupDocument(
            schemaVersion: currentSchemaVersion,
            exportedAt: Date(),
            entries: entries
        )
    }
}
