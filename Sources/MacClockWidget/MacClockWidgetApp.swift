import SwiftUI

/// Entry point for the Mac World Clock menu bar application.
///
/// Presents a clock icon in the menu bar that opens an expanded world-clock
/// panel on click. Uses ``AppDelegate`` to hide the Dock icon via
/// `.accessory` activation policy.
@main
struct MacClockWidgetApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        MenuBarExtra {
            ExpandedClockView()
        } label: {
            Image(systemName: "clock")
        }
        .menuBarExtraStyle(.window)
    }
}
