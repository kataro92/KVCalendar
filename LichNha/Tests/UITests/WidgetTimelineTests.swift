import XCTest

final class WidgetTimelineTests: XCTestCase {
    func testWidgetDeepLinkOpensTargetDay() {
        let app = XCUIApplication()
        app.launchArguments = [
            "--uitesting",
            "--open-url", "lichnha://day/2026-10-15",
        ]
        app.launch()
        let solar = app.descendants(matching: .any)["solar-day"]
        XCTAssertTrue(solar.waitForExistence(timeout: 8))
        XCTAssertTrue(solar.label.contains("15"))
        XCTAssertTrue(app.buttons["today-button"].waitForExistence(timeout: 4))
    }

    func testLateRefreshDoesNotCaptionFutureAsToday() {
        let morning = WidgetTimelineProbe.vietnamDate(year: 2026, month: 9, day: 2, hour: 10)
        let late = WidgetTimelineProbe.vietnamDate(year: 2026, month: 9, day: 3, hour: 0, minute: 30)
        XCTAssertTrue(WidgetTimelineProbe.isToday(civilDay: 2, month: 9, year: 2026, now: morning))
        XCTAssertFalse(WidgetTimelineProbe.isToday(civilDay: 2, month: 9, year: 2026, now: late))
        XCTAssertTrue(WidgetTimelineProbe.isToday(civilDay: 3, month: 9, year: 2026, now: late))
    }
}

private enum WidgetTimelineProbe {
    static func vietnamDate(year: Int, month: Int, day: Int, hour: Int, minute: Int = 0) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh")!
        var parts = DateComponents()
        parts.year = year
        parts.month = month
        parts.day = day
        parts.hour = hour
        parts.minute = minute
        return calendar.date(from: parts)!
    }

    static func isToday(civilDay: Int, month: Int, year: Int, now: Date) -> Bool {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh")!
        let parts = calendar.dateComponents([.year, .month, .day], from: now)
        return parts.year == year && parts.month == month && parts.day == civilDay
    }
}
