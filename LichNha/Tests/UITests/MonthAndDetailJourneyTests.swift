import XCTest

final class MonthAndDetailJourneyTests: XCTestCase {
    func testMonthSelectDay15AndReturn() {
        let app = XCUIApplication()
        app.launchArguments = ["--uitesting", "--date", "2026-09-02"]
        app.launch()

        XCTAssertTrue(app.descendants(matching: .any)["solar-day"].waitForExistence(timeout: 8))
        XCTAssertTrue(app.descendants(matching: .any)["front-occurrence-quoc-khanh"].exists)

        app.buttons["month-button"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["month-sheet"].waitForExistence(timeout: 4))
        app.buttons["next-month"].tap()
        let day15 = app.descendants(matching: .any)["day-cell-15"]
        XCTAssertTrue(day15.waitForExistence(timeout: 4))
        day15.tap()
        XCTAssertTrue(app.descendants(matching: .any)["solar-day"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.staticTexts["solar-day"].label.contains("15"))
        XCTAssertTrue(app.buttons["back-to-month"].exists)
        app.buttons["back-to-month"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["month-sheet"].waitForExistence(timeout: 4))
    }

    func testDayBackSourceAndHistoricalNotice() {
        let app = XCUIApplication()
        app.launchArguments = ["--uitesting", "--date", "2026-09-02"]
        app.launch()
        XCTAssertTrue(app.buttons["detail-button"].waitForExistence(timeout: 8))
        app.buttons["detail-button"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-back"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.descendants(matching: .any)["almanac-reference-label"].exists)
        XCTAssertTrue(app.descendants(matching: .any)["occurrence-quoc-khanh"].exists)
        app.buttons["source-link-quoc-khanh"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["source-detail"].waitForExistence(timeout: 4))
        app.buttons["close-source"].tap()
        app.buttons["back-to-day"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["solar-day"].waitForExistence(timeout: 4))
    }

    func testHistoricalScopeOn1972() {
        let app = XCUIApplication()
        app.launchArguments = ["--uitesting", "--date", "1972-04-30"]
        app.launch()
        XCTAssertTrue(app.buttons["detail-button"].waitForExistence(timeout: 8))
        app.buttons["detail-button"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["history-notice"].waitForExistence(timeout: 4))
    }
}
