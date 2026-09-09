// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "GoldenCalendarBuilder",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(path: "../../LichNha/Modules"),
    ],
    targets: [
        .executableTarget(
            name: "golden-calendar-builder",
            dependencies: [
                .product(name: "CalendarCore", package: "Modules"),
            ]
        ),
    ]
)
