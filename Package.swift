// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MacClockWidget",
    platforms: [
        .macOS(.v13)
    ],
    targets: [
        .executableTarget(
            name: "MacClockWidget",
            path: "Sources/MacClockWidget",
            linkerSettings: [
                .linkedFramework("ServiceManagement")
            ]
        )
    ]
)
