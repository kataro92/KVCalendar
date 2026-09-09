import XCTest

final class LunarEventJourneyTests: XCTestCase {
    func testCreateLunarEventWhenNotificationDenied() {
        let app = XCUIApplication()
        app.launchArguments = [
            "--uitesting",
            "--deny-notifications",
            "--reset-personal-store",
            "--date", "2026-09-09",
        ]
        app.launch()

        XCTAssertTrue(app.buttons["events-button"].waitForExistence(timeout: 8))
        app.buttons["events-button"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["event-list"].waitForExistence(timeout: 4))
        app.buttons["add-event-button"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["event-editor"].waitForExistence(timeout: 4))

        let title = app.textFields["event-title-field"]
        XCTAssertTrue(title.waitForExistence(timeout: 2))
        title.tap()
        title.typeText("Ngày giỗ mẫu")
        app.descendants(matching: .any)["event-editor"].firstMatch.tap()

        setStepper(app, field: "lunar-day-field", to: 12)
        setStepper(app, field: "lunar-month-field", to: 8)
        app.buttons["recurrence-yearly"].tap()
        app.buttons["leap-policy-regularMonth"].tap()

        let summary = app.descendants(matching: .any)["policy-summary"]
        XCTAssertTrue(summary.waitForExistence(timeout: 2))
        XCTAssertTrue(summary.label.contains("tháng Tám"))
        XCTAssertTrue(summary.label.contains("trước 3 ngày"))
        XCTAssertTrue(summary.label.contains("Chỉ tháng Tám thường"))

        app.buttons["save-event"].tap()
        let saved = app.descendants(matching: .any)["event-saved-status"]
        XCTAssertTrue(saved.waitForExistence(timeout: 6))
        XCTAssertTrue(saved.label.contains("Đã lưu"))
        let reminder = app.descendants(matching: .any)["reminder-status"]
        XCTAssertTrue(reminder.waitForExistence(timeout: 2))
        XCTAssertTrue(reminder.label.contains("Chưa bật nhắc"))
        XCTAssertTrue(reminder.label.contains("vẫn còn"))
        XCTAssertTrue(app.buttons["export-iphone-calendar"].exists)

        app.buttons["close-editor"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["event-list"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.staticTexts["Ngày giỗ mẫu"].waitForExistence(timeout: 4))
    }

    func testEventRemainsAfterRelaunch() {
        let first = XCUIApplication()
        first.launchArguments = [
            "--uitesting",
            "--deny-notifications",
            "--reset-personal-store",
            "--date", "2026-09-09",
        ]
        first.launch()
        XCTAssertTrue(first.buttons["events-button"].waitForExistence(timeout: 8))
        first.buttons["events-button"].tap()
        first.buttons["add-event-button"].tap()
        let title = first.textFields["event-title-field"]
        XCTAssertTrue(title.waitForExistence(timeout: 4))
        title.tap()
        title.typeText("Ngày giỗ mẫu")
        first.descendants(matching: .any)["event-editor"].firstMatch.tap()
        setStepper(first, field: "lunar-day-field", to: 12)
        setStepper(first, field: "lunar-month-field", to: 8)
        first.buttons["save-event"].tap()
        XCTAssertTrue(first.descendants(matching: .any)["event-saved-status"].waitForExistence(timeout: 6))
        first.terminate()

        let second = XCUIApplication()
        second.launchArguments = [
            "--uitesting",
            "--deny-notifications",
            "--date", "2026-09-09",
        ]
        second.launch()
        XCTAssertTrue(second.buttons["events-button"].waitForExistence(timeout: 8))
        second.buttons["events-button"].tap()
        XCTAssertTrue(second.staticTexts["Ngày giỗ mẫu"].waitForExistence(timeout: 6))
    }

    private func setStepper(_ app: XCUIApplication, field: String, to target: Int) {
        let value = app.descendants(matching: .any)[field]
        XCTAssertTrue(value.waitForExistence(timeout: 2))
        var current = Int(value.label) ?? 0
        var guardCount = 0
        while current < target, guardCount < 40 {
            app.buttons["\(field)-plus"].tap()
            current += 1
            guardCount += 1
        }
        while current > target, guardCount < 40 {
            app.buttons["\(field)-minus"].tap()
            current -= 1
            guardCount += 1
        }
        XCTAssertEqual(Int(value.label) ?? current, target)
    }
}
