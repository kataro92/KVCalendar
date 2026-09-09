import SwiftUI
import XCTest
import CalendarCore
@testable import LichNha

@MainActor
final class TodaySheetSnapshotTests: XCTestCase {
    func testFormatterMatrixKeepsSolarNumberFirst() throws {
        let day = try frozenDay()
        XCTAssertEqual(CalendarDayFormatter.solarDay(day), "10")
        XCTAssertEqual(CalendarDayFormatter.weekday(day), "Thứ Bảy")
        XCTAssertEqual(CalendarDayFormatter.solarMonthYear(day), "Tháng 2 năm 2024")
        XCTAssertTrue(CalendarDayFormatter.lunar(day).contains("tháng 1"))
        XCTAssertFalse(CalendarDayFormatter.canChiDay(day).isEmpty)
    }

    func testFrontSheetRendersCompactLargeLightDarkAndHugeType() throws {
        let day = try frozenDay()
        let widths: [CGFloat] = [320, 430]
        let schemes: [ColorScheme] = [.light, .dark]
        let types: [DynamicTypeSize] = [.large, .accessibility2]
        for width in widths {
            for scheme in schemes {
                for type in types {
                    let view = TodayFrontView(day: day)
                        .frame(width: width, height: 520)
                        .environment(\.dynamicTypeSize, type)
                        .environment(\.colorScheme, scheme)
                    let renderer = ImageRenderer(content: view)
                    renderer.scale = 1
                    let image = renderer.uiImage
                    XCTAssertNotNil(image, "width=\(width) scheme=\(scheme) type=\(type)")
                    XCTAssertGreaterThan(image?.size.width ?? 0, 0)
                    XCTAssertGreaterThan(image?.size.height ?? 0, 0)
                }
            }
        }
    }

    private func frozenDay() throws -> CalendarDay {
        try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2024, month: 2, day: 10),
            displayTimeZone: .vietnam
        )
    }
}
