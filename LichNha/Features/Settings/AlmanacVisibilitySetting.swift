import Foundation
import PersonalCore

enum AlmanacVisibilitySetting {
    static var isEnabled: Bool {
        get { UserPreferencesStore.makeShared().load().almanacVisible }
        set {
            let store = UserPreferencesStore.makeShared()
            var prefs = store.load()
            prefs.almanacVisible = newValue
            store.save(prefs)
        }
    }
}
