import Combine
import Foundation
import ServiceManagement

/// Manages launch-at-login registration for the main app using ``SMAppService/mainApp``.
///
/// Persists the user's preference in ``UserDefaults``. ``SMAppService`` registration
/// requires running inside a proper `.app` bundle (see ``isRunningInAppBundle``).
final class LaunchAtLoginService: ObservableObject {

    /// UserDefaults key for the launch-at-login preference.
    private static let preferenceKey = "launchAtLoginEnabled"

    /// User's launch-at-login preference; reflects persisted state and registration attempts.
    @Published private(set) var isEnabled: Bool

    /// Human-readable error from the most recent register or unregister attempt, if any.
    @Published private(set) var lastErrorMessage: String?

    private let defaults: UserDefaults

    /// Creates the service, defaulting launch-at-login to off, and applies a stored preference on launch.
    ///
    /// - Parameter defaults: User defaults suite for the launch-at-login preference.
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        if defaults.object(forKey: Self.preferenceKey) == nil {
            defaults.set(false, forKey: Self.preferenceKey)
        }
        self.isEnabled = defaults.bool(forKey: Self.preferenceKey)
        if isEnabled {
            applyRegistration(enabled: true, revertOnFailure: false)
        }
    }

    /// Whether the process runs inside a `.app` bundle, which ``SMAppService`` requires.
    var isRunningInAppBundle: Bool {
        Bundle.main.bundleURL.pathExtension == "app"
    }

    /// Whether the UI may offer launch-at-login controls (requires an app bundle).
    var canManage: Bool {
        isRunningInAppBundle
    }

    /// Updates launch-at-login from the settings toggle.
    ///
    /// - Parameter enabled: `true` to register; `false` to unregister.
    func setEnabled(_ enabled: Bool) {
        guard enabled != isEnabled else { return }
        defaults.set(enabled, forKey: Self.preferenceKey)
        isEnabled = enabled
        applyRegistration(enabled: enabled, revertOnFailure: true)
    }

    /// Refreshes ``isEnabled`` from ``SMAppService/mainApp`` when system state diverges.
    ///
    /// Call when the panel appears so approval changes in System Settings are reflected.
    func refreshFromSystemStatus() {
        let systemEnabled = SMAppService.mainApp.status == .enabled
        guard systemEnabled != isEnabled else { return }
        isEnabled = systemEnabled
        defaults.set(systemEnabled, forKey: Self.preferenceKey)
        lastErrorMessage = nil
    }

    /// Registers or unregisters the main app with Service Management.
    ///
    /// - Parameters:
    ///   - enabled: `true` to register; `false` to unregister.
    ///   - revertOnFailure: When `true`, reverts ``isEnabled`` and UserDefaults on failure.
    private func applyRegistration(enabled: Bool, revertOnFailure: Bool) {
        guard canManage else {
            if enabled {
                lastErrorMessage =
                    "Launch at login requires the .app bundle. Build with scripts/build-app.sh."
            }
            if revertOnFailure {
                revertPreference(to: false)
            }
            return
        }

        let service = SMAppService.mainApp
        if enabled {
            do {
                try service.register()
                lastErrorMessage = nil
            } catch {
                lastErrorMessage = friendlyMessage(for: error)
                if revertOnFailure {
                    revertPreference(to: false)
                }
            }
        } else {
            service.unregister { [weak self] error in
                guard let self else { return }
                DispatchQueue.main.async {
                    if let error {
                        self.lastErrorMessage = self.friendlyMessage(for: error)
                        if revertOnFailure {
                            self.revertPreference(to: true)
                        }
                    } else {
                        self.lastErrorMessage = nil
                    }
                }
            }
        }
    }

    /// Reverts the stored preference and published state without re-triggering registration.
    ///
    /// - Parameter enabled: Value to restore.
    private func revertPreference(to enabled: Bool) {
        defaults.set(enabled, forKey: Self.preferenceKey)
        isEnabled = enabled
    }

    /// Returns a concise, user-facing description for Service Management errors.
    ///
    /// - Parameter error: Error from ``SMAppService/register()`` or ``SMAppService/unregister(completionHandler:)``.
    /// - Returns: Localized error text suitable for the settings UI.
    private func friendlyMessage(for error: Error) -> String {
        let description = error.localizedDescription
        if description.isEmpty {
            return "Could not update launch at login."
        }
        return description
    }
}
