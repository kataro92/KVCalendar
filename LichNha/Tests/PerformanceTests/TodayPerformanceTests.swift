import XCTest
import CalendarCore
@testable import LichNha

final class TodayPerformanceTests: XCTestCase {
    func testTodayConversionPerformance() {
        measure {
            let context = TimeContext(displayZone: .vietnam, deliveryZone: .vietnam)
            _ = try? AppRouter.today(in: context)
        }
    }

    func testThirtyDayWalkPerformance() {
        measure {
            var civil = CivilDate(year: 2024, month: 2, day: 10)
            for _ in 0..<30 {
                civil = civil.adding(days: 1)
                _ = try? VietnameseLunarCalendar.calendarDay(
                    civil: civil,
                    displayTimeZone: .vietnam
                )
            }
        }
    }
}
