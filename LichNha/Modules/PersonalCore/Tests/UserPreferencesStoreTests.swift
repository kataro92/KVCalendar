import Foundation
import Testing
import PersonalCore

struct UserPreferencesStoreTests {
    @Test func freshInstallIsYenWithCuesOff() {
        let store = makeStore()
        let prefs = store.load()
        #expect(prefs.ambient == .yen)
        #expect(prefs.paperCuesEnabled == false)
        #expect(prefs.eventCuesEnabled == false)
        #expect(prefs.motion == .gentle)
        #expect(prefs.inspirationRegion == .neutral)
        #expect(prefs.widgetPrivacy == .hidden)
    }

    @Test func silenceAllAudioClearsEveryLayer() {
        var prefs = UserPreferences.fresh
        prefs.ambient = .hienSom
        prefs.paperCuesEnabled = true
        prefs.eventCuesEnabled = true
        prefs.silenceAllAudio()
        #expect(prefs.ambient == .yen)
        #expect(prefs.paperCuesEnabled == false)
        #expect(prefs.eventCuesEnabled == false)
    }

    @Test func roundTripPersistsIndependentLayers() {
        let store = makeStore()
        var prefs = store.load()
        prefs.ambient = .muaXa
        prefs.paperCuesEnabled = true
        prefs.eventCuesEnabled = false
        prefs.motion = .vivid
        prefs.inspirationRegion = .south
        store.save(prefs)
        let loaded = store.load()
        #expect(loaded.ambient == .muaXa)
        #expect(loaded.paperCuesEnabled)
        #expect(loaded.eventCuesEnabled == false)
        #expect(loaded.motion == .vivid)
        #expect(loaded.inspirationRegion == .south)
    }

    @Test func migratesLegacyAlmanacToggle() {
        let suite = "lich-nha-pref-\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suite)!
        defaults.removePersistentDomain(forName: suite)
        let legacySuite = "lich-nha-legacy-\(UUID().uuidString)"
        let legacy = UserDefaults(suiteName: legacySuite)!
        legacy.removePersistentDomain(forName: legacySuite)
        legacy.set(false, forKey: UserPreferencesStore.legacyAlmanacKey)
        let store = UserPreferencesStore(defaults: defaults, legacyDefaults: legacy)
        #expect(store.load().almanacVisible == false)
    }
}

private func makeStore() -> UserPreferencesStore {
    let suite = "lich-nha-pref-\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suite)!
    defaults.removePersistentDomain(forName: suite)
    return UserPreferencesStore(defaults: defaults, legacyDefaults: defaults)
}
