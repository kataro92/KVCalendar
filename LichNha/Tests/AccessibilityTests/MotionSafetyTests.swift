import XCTest
import PersonalCore
import EffectCore
@testable import LichNha

final class MotionSafetyTests: XCTestCase {
    func testSystemReduceMotionOverridesVividWithoutChangingPreference() {
        let preference = MotionPreference.vivid
        let still = AccessibilityEffectPolicy.resolvedLevel(
            preference: preference,
            capability: EffectCapabilitySnapshot(reduceMotion: true)
        )
        let dimmed = AccessibilityEffectPolicy.resolvedLevel(
            preference: preference,
            capability: EffectCapabilitySnapshot(dimFlashingLights: true)
        )
        let lowPower = AccessibilityEffectPolicy.resolvedLevel(
            preference: preference,
            capability: EffectCapabilitySnapshot(lowPower: true)
        )
        XCTAssertEqual(still, .still)
        XCTAssertEqual(dimmed, .still)
        XCTAssertEqual(lowPower, .still)
        XCTAssertEqual(preference, .vivid)
    }

    func testGentleStaysWhenSystemAllowsMotion() {
        let level = AccessibilityEffectPolicy.resolvedLevel(
            preference: .gentle,
            capability: EffectCapabilitySnapshot()
        )
        XCTAssertEqual(level, .gentle)
    }
}
