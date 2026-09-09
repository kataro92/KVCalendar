import XCTest
import CalendarCore
@testable import LichNha

final class MonthGridModelTests: XCTestCase {
    func testSeptember2026HasThirtyDaysAndMondayStart() throws {
        let cells = try MonthGridModel.cells(year: 2026, month: 9)
        XCTAssertEqual(cells.count, 42)
        let inMonth = cells.filter(\.isInMonth)
        XCTAssertEqual(inMonth.count, 30)
        XCTAssertEqual(inMonth.first?.civil.day, 1)
        let day15 = inMonth.first { $0.civil.day == 15 }
        XCTAssertNotNil(day15)
        XCTAssertTrue(day15?.lunarDay ?? 0 > 0)
        XCTAssertFalse(MonthGridModel.shortLunar(day15!).isEmpty)
    }

    func testMarkersDoNotShareOneHolidayConcept() throws {
        XCTAssertNotEqual(MonthMarker.statutory, MonthMarker.traditional)
        XCTAssertNotEqual(MonthMarker.statutory, MonthMarker.solarTerm)
    }

    func testDeepLinkParsesCivilDate() {
        let url = URL(string: "lichnha://day/2026-09-02")!
        XCTAssertEqual(MonthRouter.civil(fromDeepLink: url), CivilDate(year: 2026, month: 9, day: 2))
    }
}
