import AppKit

/// Application delegate that configures menu-bar-only lifecycle behavior.
///
/// Sets the activation policy to `.accessory` so the app runs exclusively
/// from the menu bar without appearing in the Dock.
final class AppDelegate: NSObject, NSApplicationDelegate {

    /// Called once after launch; hides the Dock icon for menu-bar-only operation.
    ///
    /// - Parameter notification: The standard launch notification from AppKit.
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
    }
}
