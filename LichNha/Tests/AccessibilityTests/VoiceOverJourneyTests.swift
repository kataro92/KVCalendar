import XCTest

@MainActor
final class VoiceOverJourneyTests: XCTestCase {
    func testCoreTasksHaveButtonsInsteadOfGesturesOnly() {
        let app = XCUIApplication()
        app.launchArguments = ["--uitesting", "--date", "2026-09-02"]
        app.launch()

        XCTAssertTrue(app.descendants(matching: .any)["solar-day"].waitForExistence(timeout: 8))
        XCTAssertTrue(app.descendants(matching: .any)["lunar-day"].exists)
        XCTAssertTrue(app.descendants(matching: .any)["day-summary"].exists)
        XCTAssertTrue(app.buttons["next-day"].exists)
        XCTAssertTrue(app.buttons["previous-day"].exists)
        app.buttons["next-day"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["solar-day"].waitForExistence(timeout: 4))
        app.buttons["previous-day"].tap()
        XCTAssertTrue(app.buttons["month-button"].exists)
        XCTAssertTrue(app.buttons["detail-button"].exists)
        XCTAssertTrue(app.buttons["events-button"].exists)
        XCTAssertTrue(app.buttons["settings-button"].exists)

        app.buttons["month-button"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["month-sheet"].waitForExistence(timeout: 4))
        app.buttons["back-to-day"].tap()

        XCTAssertTrue(app.buttons["detail-button"].waitForExistence(timeout: 4))
        app.buttons["detail-button"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-back"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.buttons["source-link-quoc-khanh"].exists)
        app.buttons["back-to-day"].tap()

        app.buttons["settings-button"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["paper-drawer"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.buttons["silence-all-audio"].waitForExistence(timeout: 4))
        app.buttons["ambient-hien-som"].tap()
        app.buttons["silence-all-audio"].tap()
        XCTAssertTrue(app.buttons["ambient-yen"].exists)
        app.buttons["close-settings"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["solar-day"].waitForExistence(timeout: 4))
    }
}
