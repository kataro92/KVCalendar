import Foundation
import ContentCore

enum WidgetPrivacy {
    static func isLockScreenFamily(_ family: String) -> Bool {
        family.contains("accessory")
    }

    static func personalLabel(from snapshot: WidgetSnapshot, lockScreen: Bool) -> String? {
        WidgetPrivacyFilter.visiblePersonalLabel(snapshot.personalHomeLabel, lockScreen: lockScreen)
    }
}
