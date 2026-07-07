import SwiftUI

/// Main menu bar panel listing configured world clocks with a configure action.
struct ExpandedClockView: View {
    @StateObject private var store = WorldClockStore()
    @StateObject private var weatherService = WeatherService()
    @State private var isShowingConfigure = false

    private let panelWidth: CGFloat = 380
    private let configurePanelWidth: CGFloat = 420

    var body: some View {
        Group {
            if isShowingConfigure {
                ConfigureTimezonesView(
                    store: store,
                    onDismiss: closeConfigure
                )
            } else {
                mainPanel
            }
        }
        .frame(width: isShowingConfigure ? configurePanelWidth : panelWidth)
    }

    /// World-clock list, empty state, and configure entry point.
    private var mainPanel: some View {
        VStack(spacing: 0) {
            if store.entries.isEmpty {
                emptyState
            } else {
                clockList
            }

            if let allFailedMessage = weatherService.allFailedMessage {
                Text(allFailedMessage)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 4)
            }

            Divider()
                .padding(.top, store.entries.isEmpty ? 12 : 4)

            panelFooter
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .onAppear {
            weatherService.refreshIfNeeded(for: store.entries)
        }
        .onChange(of: store.entries) { entries in
            weatherService.refreshIfNeeded(for: entries)
        }
    }

    /// Returns from inline configure mode to the world-clock list without closing the panel.
    private func closeConfigure() {
        isShowingConfigure = false
        weatherService.refreshIfNeeded(for: store.entries)
    }

    /// Scrollable list of configured cities with periodic live updates.
    private var clockList: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(store.entries) { entry in
                        CityRowView(
                            entry: entry,
                            date: context.date,
                            weather: weatherService.snapshot(for: entry.id)
                        )
                    }
                }
                .padding(.vertical, 4)
            }
            .frame(maxHeight: 360)
        }
    }

    /// Shown when no cities are configured.
    private var emptyState: some View {
        VStack(spacing: 8) {
            Text("No cities configured")
                .font(.headline)
            Text("Add up to 10 cities to track world times.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }

    /// Footer with temperature converter and configure entry point.
    private var panelFooter: some View {
        VStack(spacing: 8) {
            TemperatureConverterView()
            configureButton
        }
        .padding(.top, 8)
    }

    /// Opens the inline timezone configuration panel.
    private var configureButton: some View {
        Button("Configure…") {
            isShowingConfigure = true
        }
        .buttonStyle(.borderless)
        .frame(maxWidth: .infinity, alignment: .center)
        .keyboardShortcut(",", modifiers: .command)
    }
}
