import SwiftUI
import XCTest
import CalendarCore
import ContentCore
@testable import LichNha

@MainActor
final class WidgetVisualSnapshotTests: XCTestCase {
    func testBlocRendersLightDarkAndTinted() throws {
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 9, day: 2),
            displayTimeZone: .vietnam
        )
        let snapshot = WidgetSnapshotBuilder.build(
            day: day,
            publicTitles: ["Quốc khánh"],
            personal: [WidgetPersonalInput(title: "Giỗ ông Nội", privacyRaw: "hidden")],
            now: Date(timeIntervalSince1970: 1_788_307_200),
            displayZone: .vietnam
        )
        let schemes: [ColorScheme] = [.light, .dark]
        for scheme in schemes {
            let home = WidgetBlocView(snapshot: snapshot, isToday: true, lockScreen: false, compact: false)
                .frame(width: 158, height: 158)
                .environment(\.colorScheme, scheme)
            assertRendered(home, label: "home-\(scheme)")

            let lock = WidgetBlocView(snapshot: snapshot, isToday: false, lockScreen: true, compact: true)
                .frame(width: 158, height: 72)
                .environment(\.colorScheme, scheme)
            assertRendered(lock, label: "lock-\(scheme)")
        }
        let tinted = WidgetBlocView(snapshot: snapshot, isToday: true, lockScreen: false, compact: false)
            .frame(width: 338, height: 158)
            .environment(\.colorScheme, .light)
            .tint(DesignTokens.son)
        assertRendered(tinted, label: "tinted")
    }

    func testHiddenPersonalTitleIsNotOnHomeBlocIdentifier() throws {
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 9, day: 2),
            displayTimeZone: .vietnam
        )
        let snapshot = WidgetSnapshotBuilder.build(
            day: day,
            publicTitles: ["Quốc khánh"],
            personal: [WidgetPersonalInput(title: "Giỗ ông Nội", notes: "ghi chú", privacyRaw: "hidden")],
            now: Date(),
            displayZone: .vietnam
        )
        XCTAssertNil(snapshot.personalHomeLabel)
        XCTAssertEqual(snapshot.publicOccurrenceLabel, "Quốc khánh")
    }

    private func assertRendered<V: View>(_ view: V, label: String) {
        let renderer = ImageRenderer(content: view)
        renderer.scale = 1
        let image = renderer.uiImage
        XCTAssertNotNil(image, label)
        XCTAssertGreaterThan(image?.size.width ?? 0, 0, label)
        XCTAssertGreaterThan(image?.size.height ?? 0, 0, label)
    }
}
