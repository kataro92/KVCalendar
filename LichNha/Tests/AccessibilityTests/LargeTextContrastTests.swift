import SwiftUI
import XCTest
import CalendarCore
import ContentCore
@testable import LichNha

@MainActor
final class LargeTextContrastTests: XCTestCase {
    func testHugeTypeMovesCanChiOffTheFront() throws {
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 9, day: 2),
            displayTimeZone: .vietnam
        )
        XCTAssertTrue(LargePrintLayout.showsSecondaryOnFront(.large))
        XCTAssertFalse(LargePrintLayout.showsSecondaryOnFront(.accessibility2))
        XCTAssertEqual(LargePrintLayout.solarDayPointSize(.accessibility3), 48)
        XCTAssertFalse(PaperLegibility.showsTexture(
            reduceTransparency: true,
            increasedContrast: false,
            boldText: false
        ))
        XCTAssertFalse(PaperLegibility.showsTexture(
            reduceTransparency: false,
            increasedContrast: true,
            boldText: false
        ))
        XCTAssertTrue(PaperLegibility.showsTexture(
            reduceTransparency: false,
            increasedContrast: false,
            boldText: false
        ))

        let compact = TodayFrontView(day: day, occurrences: [], personalTitles: [])
            .frame(width: 320, height: 640)
            .environment(\.dynamicTypeSize, .accessibility3)
        let renderer = ImageRenderer(content: compact)
        renderer.scale = 1
        XCTAssertNotNil(renderer.uiImage)
        XCTAssertGreaterThan(renderer.uiImage?.size.width ?? 0, 0)
    }

    func testSummaryKeepsSolarLunarAndEvent() throws {
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 9, day: 2),
            displayTimeZone: .vietnam
        )
        let occurrence = CalendarOccurrence(
            id: "quoc-khanh",
            title: "Quốc khánh",
            taxonomy: .statutoryHoliday,
            calendarBasis: "solar",
            sourceID: "bllld-2019-d112",
            packVersion: "1.0.0",
            isDayOff: true,
            solarMonth: 9,
            solarDay: 2
        )
        let summary = CalendarAccessibility.sheetSummary(
            day: day,
            occurrences: [occurrence],
            personalTitles: []
        )
        XCTAssertTrue(summary.contains("ngày dương 2"))
        XCTAssertTrue(summary.contains("Âm lịch"))
        XCTAssertTrue(summary.contains("Quốc khánh"))
    }
}
