import AppKit
import Foundation
import UniformTypeIdentifiers

/// Errors produced while decoding or validating a world clock backup file.
enum WorldClockBackupError: LocalizedError {
    /// The file could not be read from disk.
    case readFailed
    /// The file is not valid JSON or does not match the backup envelope.
    case invalidFormat
    /// The backup declares an unsupported ``WorldClockBackupDocument/schemaVersion``.
    case unsupportedSchemaVersion(Int)
    /// The backup contains no usable city entries.
    case emptyEntries
    /// One or more entries failed validation (missing fields or unknown timezone).
    case invalidEntries(String)

    /// Human-readable description shown in the configure panel.
    var errorDescription: String? {
        switch self {
        case .readFailed:
            return "Could not read the selected file."
        case .invalidFormat:
            return "Invalid backup file. Expected JSON with schemaVersion and entries."
        case .unsupportedSchemaVersion(let version):
            return "Unsupported backup version (\(version)). Update World Clock and try again."
        case .emptyEntries:
            return "Backup contains no cities to import."
        case .invalidEntries(let detail):
            return detail
        }
    }
}

/// Outcome of presenting the backup save panel.
enum WorldClockBackupExportResult {
    /// The user saved a backup file successfully.
    case saved
    /// The user dismissed the save panel without saving.
    case cancelled
    /// Writing the file failed.
    case failed(String)
}

/// Encodes, decodes, and validates world clock city list backups; presents macOS file panels.
enum WorldClockBackupService {

    /// Default filename (without extension) suggested in the save panel.
    static let defaultFilename = "world-clock-cities"

    /// Encodes entries into pretty-printed JSON backup data.
    ///
    /// - Parameter entries: Current city list to export.
    /// - Returns: UTF-8 JSON data for the backup envelope.
    /// - Throws: ``EncodingError`` when serialization fails.
    static func encodeBackup(from entries: [WorldClockEntry]) throws -> Data {
        let document = WorldClockBackupDocument.make(from: entries)
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(document)
    }

    /// Decodes and validates backup JSON into normalized world clock entries.
    ///
    /// - Parameter data: Raw JSON read from a backup file.
    /// - Returns: Validated entries in backup order, deduplicated and capped at ``WorldClockStore/maxEntries``.
    /// - Throws: ``WorldClockBackupError`` when the payload is invalid.
    static func decodeBackup(from data: Data) throws -> [WorldClockEntry] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        guard let document = try? decoder.decode(WorldClockBackupDocument.self, from: data) else {
            throw WorldClockBackupError.invalidFormat
        }

        guard document.schemaVersion == WorldClockBackupDocument.currentSchemaVersion else {
            throw WorldClockBackupError.unsupportedSchemaVersion(document.schemaVersion)
        }

        guard !document.entries.isEmpty else {
            throw WorldClockBackupError.emptyEntries
        }

        return try normalizeImportedEntries(document.entries)
    }

    /// Presents a save panel and writes the current city list to the chosen JSON file.
    ///
    /// - Parameter entries: Entries to export.
    /// - Returns: Save outcome — cancelled, saved, or failed with a message.
    @MainActor
    static func exportToFile(entries: [WorldClockEntry]) -> WorldClockBackupExportResult {
        let panel = NSSavePanel()
        panel.title = "Export City List"
        panel.message = "Save your World Clock city list as JSON for backup."
        panel.nameFieldStringValue = "\(defaultFilename).json"
        panel.allowedContentTypes = [.json]
        panel.canCreateDirectories = true
        panel.isExtensionHidden = false

        guard panel.runModal() == .OK, let url = panel.url else {
            return .cancelled
        }

        do {
            let data = try encodeBackup(from: entries)
            try data.write(to: url, options: .atomic)
            return .saved
        } catch {
            return .failed("Export failed: \(error.localizedDescription)")
        }
    }

    /// Presents an open panel and returns validated entries from the chosen JSON file.
    ///
    /// - Returns: `.success` with normalized entries, `.failure` with a validation or I/O error,
    ///   or `nil` when the user cancelled the panel.
    @MainActor
    static func importFromFile() -> Result<[WorldClockEntry], WorldClockBackupError>? {
        let panel = NSOpenPanel()
        panel.title = "Import City List"
        panel.message = "Choose a World Clock JSON backup to restore your city list."
        panel.allowedContentTypes = [.json]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true

        guard panel.runModal() == .OK, let url = panel.url else {
            return nil
        }

        guard let data = try? Data(contentsOf: url) else {
            return .failure(.readFailed)
        }

        do {
            let entries = try decodeBackup(from: data)
            return .success(entries)
        } catch let error as WorldClockBackupError {
            return .failure(error)
        } catch {
            return .failure(.invalidFormat)
        }
    }

    /// Validates, deduplicates, and caps imported entries for persistence.
    ///
    /// - Parameter entries: Raw entries from the backup document.
    /// - Returns: Sanitized entries ready for ``WorldClockStore/setEntries(_:)``.
    /// - Throws: ``WorldClockBackupError/invalidEntries(_:)`` when validation fails.
    private static func normalizeImportedEntries(_ entries: [WorldClockEntry]) throws -> [WorldClockEntry] {
        var seenTimeZones = Set<String>()
        var normalized: [WorldClockEntry] = []

        for (index, entry) in entries.enumerated() {
            let displayName = entry.displayName.trimmingCharacters(in: .whitespacesAndNewlines)
            let timeZoneIdentifier = entry.timeZoneIdentifier.trimmingCharacters(in: .whitespacesAndNewlines)

            guard !displayName.isEmpty else {
                throw WorldClockBackupError.invalidEntries("Entry \(index + 1) is missing a display name.")
            }

            guard !timeZoneIdentifier.isEmpty else {
                throw WorldClockBackupError.invalidEntries("Entry \(index + 1) is missing a timezone identifier.")
            }

            guard TimeZone(identifier: timeZoneIdentifier) != nil else {
                throw WorldClockBackupError.invalidEntries(
                    "Entry \(index + 1) has an unknown timezone: \(timeZoneIdentifier)."
                )
            }

            guard seenTimeZones.insert(timeZoneIdentifier).inserted else {
                continue
            }

            normalized.append(
                WorldClockEntry(
                    id: entry.id,
                    displayName: displayName,
                    timeZoneIdentifier: timeZoneIdentifier
                )
            )

            if normalized.count >= WorldClockStore.maxEntries {
                break
            }
        }

        guard !normalized.isEmpty else {
            throw WorldClockBackupError.emptyEntries
        }

        return normalized
    }
}
