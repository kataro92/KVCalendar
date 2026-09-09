import XCTest

@MainActor
final class TodayJourneyTests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--uitesting"]
        app.launch()
    }

    func testFirstLaunchShowsSolarAndLunarDate() {
        XCTAssertTrue(app.descendants(matching: .any)["solar-day"].waitForExistence(timeout: 8))
        XCTAssertTrue(app.descendants(matching: .any)["lunar-day"].exists)
        XCTAssertTrue(app.buttons["next-day"].exists)
        XCTAssertTrue(app.buttons["previous-day"].exists)
        XCTAssertFalse(app.buttons["today-button"].exists)
    }

    func testNextPreviousAndReturnToday() {
        let solar = app.descendants(matching: .any)["solar-day"]
        XCTAssertTrue(solar.waitForExistence(timeout: 8))
        let original = solar.label

        app.buttons["next-day"].tap()
        XCTAssertTrue(solar.waitForExistence(timeout: 4))
        let nextLabel = solar.label
        XCTAssertNotEqual(nextLabel, original)
        XCTAssertTrue(app.buttons["today-button"].waitForExistence(timeout: 2))

        app.buttons["previous-day"].tap()
        XCTAssertEqual(solar.label, original)
        XCTAssertFalse(app.buttons["today-button"].exists)

        app.buttons["next-day"].tap()
        app.buttons["today-button"].tap()
        XCTAssertEqual(solar.label, original)
        XCTAssertFalse(app.buttons["today-button"].waitForExistence(timeout: 1))
    }
}
