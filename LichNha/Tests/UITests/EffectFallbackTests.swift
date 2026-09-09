import XCTest

@MainActor
final class EffectFallbackTests: XCTestCase {
    func testNationalDayKeepsReadableDateAndReplay() {
        let app = XCUIApplication()
        app.launchArguments = ["--uitesting", "--date", "2026-09-02"]
        app.launch()
        XCTAssertTrue(app.descendants(matching: .any)["solar-day"].waitForExistence(timeout: 8))
        XCTAssertTrue(app.descendants(matching: .any)["lunar-day"].exists)
        XCTAssertTrue(app.buttons["replay-scene"].exists)
        app.buttons["replay-scene"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["solar-day"].exists)
    }
}
