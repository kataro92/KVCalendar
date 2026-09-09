import Foundation
import PersonalCore

enum DailyRitualState {
    private static var suite: UserDefaults {
        UserDefaults(suiteName: PersonalSchema.appGroupID) ?? .standard
    }

    static func hasPeeled(on civilDay: String) -> Bool {
        suite.bool(forKey: "peeled-" + civilDay)
    }

    static func markPeeled(on civilDay: String) {
        suite.set(true, forKey: "peeled-" + civilDay)
    }

    static func hasSeenEffectIntro(on civilDay: String, cueID: String) -> Bool {
        suite.bool(forKey: introKey(civilDay, cueID))
    }

    static func markEffectIntro(on civilDay: String, cueID: String) {
        suite.set(true, forKey: introKey(civilDay, cueID))
    }

    private static func introKey(_ civilDay: String, _ cueID: String) -> String {
        "effect-intro-\(civilDay)-\(cueID)"
    }
}
