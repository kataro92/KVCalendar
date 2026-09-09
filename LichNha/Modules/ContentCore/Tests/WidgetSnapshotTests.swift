import Foundation
import Testing
import CalendarCore
import ContentCore

struct WidgetSnapshotTests {
    @Test func privateTitleStaysOffSnapshotWhenHidden() throws {
        let day = try sampleDay(CivilDate(year: 2026, month: 9, day: 2))
        let snapshot = WidgetSnapshotBuilder.build(
            day: day,
            publicTitles: ["Quốc khánh"],
            personal: [
                WidgetPersonalInput(title: "Giỗ ông Nội", notes: "ghi chú mật", privacyRaw: "hidden"),
            ],
            now: Date(timeIntervalSince1970: 1_788_307_200),
            displayZone: .vietnam
        )
        #expect(snapshot.publicOccurrenceLabel == "Quốc khánh")
        #expect(snapshot.personalHomeLabel == nil)
        #expect(WidgetPrivacyFilter.containsPrivateContent(snapshot, title: "Giỗ ông Nội", notes: "ghi chú mật") == false)
        #expect(snapshot.deepLink == "lichnha://day/2026-09-02")
    }

    @Test func genericMarkerDoesNotCopyTitle() throws {
        let day = try sampleDay(CivilDate(year: 2026, month: 9, day: 2))
        let snapshot = WidgetSnapshotBuilder.build(
            day: day,
            publicTitles: [],
            personal: [WidgetPersonalInput(title: "Sinh nhật Lan", privacyRaw: "genericMarker")],
            now: Date(timeIntervalSince1970: 1_788_307_200),
            displayZone: .vietnam
        )
        #expect(snapshot.personalHomeLabel == "Ngày gia đình")
        #expect(snapshot.personalHomeLabel != "Sinh nhật Lan")
        #expect(WidgetPrivacyFilter.visiblePersonalLabel(snapshot.personalHomeLabel, lockScreen: true) == nil)
        #expect(WidgetPrivacyFilter.visiblePersonalLabel(snapshot.personalHomeLabel, lockScreen: false) == "Ngày gia đình")
    }

    @Test func lockScreenDropsPublicTitlePersonalEvenIfStored() {
        #expect(WidgetPrivacyFilter.visiblePersonalLabel("Sinh nhật Lan", lockScreen: true) == nil)
    }

    @Test func expiryIsNextMidnightInDisplayZone() throws {
        let day = try sampleDay(CivilDate(year: 2026, month: 9, day: 2))
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh")!
        var parts = DateComponents()
        parts.year = 2026
        parts.month = 9
        parts.day = 2
        parts.hour = 22
        parts.minute = 10
        let now = calendar.date(from: parts)!
        let snapshot = WidgetSnapshotBuilder.build(
            day: day,
            publicTitles: [],
            personal: [],
            now: now,
            displayZone: .vietnam
        )
        let expiry = snapshot.expiresAfter
        #expect(calendar.component(.day, from: expiry) == 3)
        #expect(calendar.component(.hour, from: expiry) == 0)
        #expect(calendar.component(.minute, from: expiry) == 1)
        #expect(expiry > now)
    }

    @Test func lateRefreshDoesNotTreatTomorrowAsToday() throws {
        let today = try sampleDay(CivilDate(year: 2026, month: 9, day: 2))
        let tomorrow = try sampleDay(CivilDate(year: 2026, month: 9, day: 3))
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh")!
        var parts = DateComponents()
        parts.year = 2026
        parts.month = 9
        parts.day = 2
        parts.hour = 10
        let morning = calendar.date(from: parts)!
        let todaySnap = WidgetSnapshotBuilder.build(
            day: today, publicTitles: ["Quốc khánh"], personal: [], now: morning, displayZone: .vietnam
        )
        let tomorrowSnap = WidgetSnapshotBuilder.build(
            day: tomorrow, publicTitles: ["Không phải hôm nay"], personal: [], now: morning, displayZone: .vietnam
        )
        parts.day = 3
        parts.hour = 0
        parts.minute = 30
        let late = calendar.date(from: parts)!
        let shown = WidgetTimelinePlanning.snapshotForDisplay(
            stored: [todaySnap, tomorrowSnap],
            now: late,
            zone: .vietnam,
            fallback: tomorrowSnap
        )
        #expect(shown.civilDate == CivilDate(year: 2026, month: 9, day: 3))
        #expect(WidgetTimelinePlanning.isToday(todaySnap, now: late, zone: .vietnam) == false)
        #expect(WidgetTimelinePlanning.isToday(tomorrowSnap, now: late, zone: .vietnam) == true)
        #expect(WidgetTimelinePlanning.isToday(tomorrowSnap, now: morning, zone: .vietnam) == false)
    }

    @Test func timezoneChangeUsesDisplayZoneForToday() throws {
        let ny = TimeZoneIdentifier("America/New_York")
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: ny.rawValue)!
        var parts = DateComponents()
        parts.year = 2026
        parts.month = 9
        parts.day = 1
        parts.hour = 22
        let eveningNY = calendar.date(from: parts)!
        let dates = WidgetTimelinePlanning.timelineDates(from: eveningNY, zone: ny, dayCount: 2)
        #expect(dates[0] == CivilDate(year: 2026, month: 9, day: 1))
        let vietnamDates = WidgetTimelinePlanning.timelineDates(from: eveningNY, zone: .vietnam, dayCount: 1)
        #expect(vietnamDates[0] == CivilDate(year: 2026, month: 9, day: 2))
    }

    @Test func storeRoundTripOmitsNotes() throws {
        let day = try sampleDay(CivilDate(year: 2026, month: 9, day: 2))
        let snapshot = WidgetSnapshotBuilder.build(
            day: day,
            publicTitles: ["Quốc khánh"],
            personal: [WidgetPersonalInput(title: "Giỗ", notes: "bí mật", privacyRaw: "hidden")],
            now: Date(timeIntervalSince1970: 1_788_307_200),
            displayZone: .vietnam
        )
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try WidgetSnapshotStore.save(
            WidgetSnapshotFile(displayZone: TimeZoneIdentifier.vietnam.rawValue, snapshots: [snapshot]),
            to: directory
        )
        let loaded = try WidgetSnapshotStore.load(from: directory)
        let encoded = String(data: try JSONEncoder().encode(loaded), encoding: .utf8) ?? ""
        #expect(!encoded.contains("bí mật"))
        #expect(loaded.snapshots[0].publicOccurrenceLabel == "Quốc khánh")
    }

    private func sampleDay(_ civil: CivilDate) throws -> CalendarDay {
        try VietnameseLunarCalendar.calendarDay(civil: civil, displayTimeZone: .vietnam)
    }
}
