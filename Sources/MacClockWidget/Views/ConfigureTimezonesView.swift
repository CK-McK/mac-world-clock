import SwiftUI

/// Inline configure panel for searching, adding, removing, and reordering world clock cities.
///
/// Embedded inside ``ExpandedClockView`` rather than presented as a sheet so that
/// add/remove/reorder interactions do not dismiss the ``MenuBarExtra`` window.
/// City changes persist immediately via ``WorldClockStore`` so selections survive app restart
/// even when the panel is closed without tapping Done.
struct ConfigureTimezonesView: View {
    @ObservedObject var store: WorldClockStore

    /// Called when the user cancels or finishes, returning to the world-clock list.
    var onDismiss: () -> Void

    @StateObject private var launchAtLogin = LaunchAtLoginService()
    @State private var searchText = ""
    /// Snapshot taken when the panel opens; Cancel restores this list.
    @State private var entriesSnapshot: [WorldClockEntry] = []
    /// User-visible backup action feedback (export/import success or error).
    @State private var backupMessage: String?
    @State private var backupMessageIsError = false

    private let sheetWidth: CGFloat = 420
    private let sheetHeight: CGFloat = 520

    var body: some View {
        VStack(spacing: 0) {
            selectedSection
            Divider()
            catalogSection
            Divider()
            footer
        }
        .frame(width: sheetWidth, height: sheetHeight)
        .onAppear {
            entriesSnapshot = store.entries
            launchAtLogin.refreshFromSystemStatus()
        }
    }

    /// Whether the user has entered non-whitespace catalog search text.
    private var isCatalogSearchActive: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    /// List of currently selected cities with reorder, swipe-delete, and per-row remove buttons.
    private var selectedSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Selected Cities")
                    .font(.headline)
                Spacer()
                Text("\(store.entries.count)/\(WorldClockStore.maxEntries)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.top, 12)

            if store.entries.isEmpty {
                Text("No cities selected. Add cities from the catalog below.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
            } else {
                List {
                    ForEach(store.entries) { entry in
                        selectedRow(entry)
                    }
                    .onMove(perform: moveEntries)
                    .onDelete(perform: deleteEntries)
                }
                .listStyle(.inset(alternatesRowBackgrounds: true))
                .frame(minHeight: 120, maxHeight: 180)
            }
        }
    }

    /// Catalog grouped by region for adding new cities, with inline search.
    private var catalogSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Add City")
                .font(.headline)
                .padding(.horizontal, 12)
                .padding(.top, 8)

            catalogSearchField

            if isCatalogSearchActive && groupedCatalogSections().isEmpty {
                Text("No cities match \"\(searchText.trimmingCharacters(in: .whitespacesAndNewlines))\".")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
            } else {
                List {
                    ForEach(groupedCatalogSections(), id: \.region) { section in
                        Section(section.region) {
                            ForEach(section.entries) { catalogEntry in
                                catalogRow(catalogEntry)
                            }
                        }
                    }
                }
                .listStyle(.inset(alternatesRowBackgrounds: true))
            }
        }
    }

    /// Prominent inline search field for filtering the add-city catalog.
    ///
    /// Placed above the catalog list so search stays visible inside the
    /// ``MenuBarExtra`` panel (`.searchable` alone is unreliable without a navigation stack).
    private var catalogSearchField: some View {
        HStack(spacing: 6) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("Search cities or countries", text: $searchText)
                .textFieldStyle(.plain)
            if isCatalogSearchActive {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.borderless)
                .accessibilityLabel("Clear search")
            }
        }
        .padding(8)
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 12)
        .padding(.bottom, 4)
    }

    /// Renders one selected-city row with a remove action.
    ///
    /// - Parameter entry: Persisted entry to display.
    /// - Returns: A list row with a remove button matching catalog row styling.
    private func selectedRow(_ entry: WorldClockEntry) -> some View {
        HStack {
            Text(entry.displayName)
            Spacer()
            Button {
                store.remove(ids: [entry.id])
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.borderless)
            .accessibilityLabel("Remove \(entry.displayName)")
        }
    }

    /// Renders one catalog row with an add action.
    ///
    /// - Parameter catalogEntry: Catalog city to display.
    /// - Returns: A list row with add button state reflecting capacity and duplicates.
    private func catalogRow(_ catalogEntry: TimeZoneCatalogEntry) -> some View {
        let isSelected = store.contains(timeZoneIdentifier: catalogEntry.timeZoneIdentifier)
        let atCapacity = store.entries.count >= WorldClockStore.maxEntries

        return HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(catalogEntry.displayName)
                Text(catalogEntry.timeZoneIdentifier)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.secondary)
            } else {
                Button("Add") {
                    addCatalogEntry(catalogEntry)
                }
                .disabled(atCapacity)
            }
        }
    }

    /// Footer with launch-at-login toggle, backup actions, cancel, and done.
    private var footer: some View {
        VStack(spacing: 8) {
            launchAtLoginToggle
            backupControls

            HStack {
                Button("Cancel") {
                    store.setEntries(entriesSnapshot)
                    onDismiss()
                }
                .keyboardShortcut(.cancelAction)

                Spacer()

                Button("Done") {
                    onDismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding(12)
    }

    /// Export and import buttons with status text for backup operations.
    private var backupControls: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 12) {
                Button("Export…") {
                    exportCityList()
                }
                .accessibilityHint("Save the current city list as a JSON backup file")

                Button("Import…") {
                    importCityList()
                }
                .accessibilityHint("Restore cities from a JSON backup file")

                Spacer()
            }

            if let backupMessage {
                Text(backupMessage)
                    .font(.caption2)
                    .foregroundStyle(backupMessageIsError ? Color.red : Color.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// Toggle for registering the app as a login item via ``SMAppService/mainApp``.
    private var launchAtLoginToggle: some View {
        VStack(alignment: .leading, spacing: 2) {
            Toggle(
                "Launch at login",
                isOn: Binding(
                    get: { launchAtLogin.isEnabled },
                    set: { launchAtLogin.setEnabled($0) }
                )
            )
            .toggleStyle(.switch)
            .disabled(!launchAtLogin.canManage)
            .accessibilityHint(
                launchAtLogin.canManage
                    ? "Starts World Clock automatically when you log in"
                    : "Requires the .app bundle from scripts/build-app.sh"
            )

            if !launchAtLogin.canManage {
                Text("Requires .app bundle (scripts/build-app.sh)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            } else if let message = launchAtLogin.lastErrorMessage {
                Text(message)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// Adds a catalog entry to the persisted store when not duplicate and under capacity.
    ///
    /// - Parameter catalogEntry: Catalog row to add.
    private func addCatalogEntry(_ catalogEntry: TimeZoneCatalogEntry) {
        store.add(from: catalogEntry)
    }

    /// Removes persisted entries at the given offsets.
    ///
    /// - Parameter offsets: Index set from list onDelete.
    private func deleteEntries(at offsets: IndexSet) {
        let ids = Set(offsets.map { store.entries[$0].id })
        store.remove(ids: ids)
    }

    /// Reorders persisted entries via drag-and-drop.
    ///
    /// - Parameters:
    ///   - source: Source indices from the list.
    ///   - destination: Destination index from the list.
    private func moveEntries(from source: IndexSet, to destination: Int) {
        var entries = store.entries
        entries.move(fromOffsets: source, toOffset: destination)
        store.setEntries(entries)
    }

    /// Writes the current city list to a user-chosen JSON file via the system save panel.
    private func exportCityList() {
        switch WorldClockBackupService.exportToFile(entries: store.entries) {
        case .saved:
            backupMessage = "City list exported."
            backupMessageIsError = false
        case .cancelled:
            break
        case .failed(let message):
            backupMessage = message
            backupMessageIsError = true
        }
    }

    /// Restores cities from a user-chosen JSON backup via the system open panel.
    private func importCityList() {
        guard let result = WorldClockBackupService.importFromFile() else {
            return
        }

        switch result {
        case .success(let entries):
            store.setEntries(entries)
            backupMessage = "Imported \(entries.count) \(entries.count == 1 ? "city" : "cities")."
            backupMessageIsError = false
        case .failure(let error):
            backupMessage = error.localizedDescription
            backupMessageIsError = true
        }
    }

    /// Builds region-grouped catalog sections respecting the current search filter.
    ///
    /// - Returns: Ordered sections with catalog entries per region.
    private func groupedCatalogSections() -> [(region: String, entries: [TimeZoneCatalogEntry])] {
        let filtered = TimeZoneCatalog.filtered(by: searchText)
        let grouped = Dictionary(grouping: filtered, by: \.region)
        return TimeZoneCatalog.regionOrder.compactMap { region in
            guard let entries = grouped[region], !entries.isEmpty else { return nil }
            let sorted = entries.sorted {
                $0.city.localizedCaseInsensitiveCompare($1.city) == .orderedAscending
            }
            return (region: region, entries: sorted)
        }
    }
}
