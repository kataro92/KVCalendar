// swift-tools-version: 6.0
// SPDX-License-Identifier: Apache-2.0

import PackageDescription

let package = Package(
    name: "LichNhaModules",
    defaultLocalization: "vi",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "CalendarCore", targets: ["CalendarCore"]),
        .library(name: "AlmanacCore", targets: ["AlmanacCore"]),
        .library(name: "ContentCore", targets: ["ContentCore"]),
        .library(name: "PersonalCore", targets: ["PersonalCore"]),
        .library(name: "ReminderCore", targets: ["ReminderCore"]),
        .library(name: "EffectCore", targets: ["EffectCore"]),
        .library(name: "ProvenanceCore", targets: ["ProvenanceCore"]),
    ],
    targets: [
        .target(name: "ProvenanceCore", path: "ProvenanceCore/Sources"),
        .target(name: "CalendarCore", path: "CalendarCore/Sources"),
        .target(
            name: "AlmanacCore",
            dependencies: ["CalendarCore"],
            path: "AlmanacCore/Sources"
        ),
        .target(
            name: "ContentCore",
            dependencies: ["CalendarCore", "ProvenanceCore"],
            path: "ContentCore/Sources"
        ),
        .target(
            name: "PersonalCore",
            dependencies: ["CalendarCore"],
            path: "PersonalCore/Sources"
        ),
        .target(
            name: "ReminderCore",
            dependencies: ["CalendarCore", "PersonalCore"],
            path: "ReminderCore/Sources"
        ),
        .target(
            name: "EffectCore",
            dependencies: ["CalendarCore", "ContentCore"],
            path: "EffectCore/Sources"
        ),
        .testTarget(
            name: "CalendarCoreTests",
            dependencies: ["CalendarCore"],
            path: "CalendarCore/Tests",
            resources: [.copy("Fixtures")]
        ),
        .testTarget(
            name: "AlmanacCoreTests",
            dependencies: ["AlmanacCore"],
            path: "AlmanacCore/Tests"
        ),
        .testTarget(
            name: "ContentCoreTests",
            dependencies: ["ContentCore"],
            path: "ContentCore/Tests",
            resources: [.copy("Fixtures")]
        ),
        .testTarget(
            name: "PersonalCoreTests",
            dependencies: ["PersonalCore", "ProvenanceCore", "CalendarCore"],
            path: "PersonalCore/Tests"
        ),
        .testTarget(
            name: "ReminderCoreTests",
            dependencies: ["ReminderCore", "PersonalCore", "CalendarCore"],
            path: "ReminderCore/Tests"
        ),
        .testTarget(
            name: "EffectCoreTests",
            dependencies: ["EffectCore"],
            path: "EffectCore/Tests"
        ),
    ]
)
