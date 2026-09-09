import EffectCore
import PersonalCore

enum AccessibilityEffectPolicy {
    static func resolvedLevel(
        preference: MotionPreference,
        capability: EffectCapabilitySnapshot
    ) -> EffectLevel {
        if capability.forcesPoster {
            return .still
        }
        switch preference {
        case .vivid: return .vivid
        case .gentle: return .gentle
        case .still: return .still
        }
    }

    static func mapsPreferenceWithoutMutating() -> Bool {
        true
    }
}
