import XCTest
import CalendarCore
@testable import LichNha

final class CalendarDayFormatterTests: XCTestCase {
    func testVietnameseLabelsForTet2024() throws {
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2024, month: 2, day: 10),
            displayTimeZone: .vietnam
        )
        XCTAssertEqual(CalendarDayFormatter.solarDay(day), "10")
        XCTAssertEqual(CalendarDayFormatter.weekday(day), "Thứ Bảy")
        XCTAssertEqual(CalendarDayFormatter.lunar(day), "Âm lịch 1 tháng 1")
        XCTAssertTrue(CalendarDayFormatter.canChiDay(day).contains(" "))
    }

    func testLeapMonthLabel() throws {
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2004, month: 3, day: 21),
            displayTimeZone: .vietnam
        )
        XCTAssertTrue(CalendarDayFormatter.lunar(day).contains("nhuận"))
    }
}

@MainActor
final class TodayViewModelTests: XCTestCase {
    func testNextPreviousAndTodayWithFrozenClock() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh")!
        let frozen = calendar.date(from: DateComponents(year: 2024, month: 2, day: 10, hour: 9))!
        let context = TimeContext(displayZone: .vietnam, deliveryZone: .vietnam, now: { frozen })
        let model = TodayViewModel(timeContext: context)
        XCTAssertEqual(model.selectedDate, CivilDate(year: 2024, month: 2, day: 10))
        XCTAssertTrue(model.isViewingToday)

        model.goToNextDay()
        XCTAssertEqual(model.selectedDate, CivilDate(year: 2024, month: 2, day: 11))
        XCTAssertFalse(model.isViewingToday)

        model.goToPreviousDay()
        XCTAssertEqual(model.selectedDate, CivilDate(year: 2024, month: 2, day: 10))

        model.goToNextDay()
        model.goToToday()
        XCTAssertEqual(model.selectedDate, CivilDate(year: 2024, month: 2, day: 10))
        XCTAssertTrue(model.isViewingToday)
    }
}
