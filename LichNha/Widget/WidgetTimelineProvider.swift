import WidgetKit
import SwiftUI
import CalendarCore
import ContentCore

struct LichNhaEntry: TimelineEntry {
    let date: Date
    let snapshot: WidgetSnapshot
    let isToday: Bool
}

struct WidgetTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> LichNhaEntry {
        makeEntry(now: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (LichNhaEntry) -> Void) {
        completion(makeEntry(now: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<LichNhaEntry>) -> Void) {
        let now = Date()
        let zone = loadedZone()
        let stored = WidgetSnapshotStore.load()?.snapshots ?? []
        let dates = WidgetTimelinePlanning.timelineDates(from: now, zone: zone, dayCount: 3)
        var entries: [LichNhaEntry] = []
        for civil in dates {
            let snapshot = stored.first(where: { $0.civilDate == civil }) ?? fallbackSnapshot(civil: civil, now: now, zone: zone)
            let start = entryDate(for: civil, zone: zone, now: now)
            entries.append(
                LichNhaEntry(
                    date: start,
                    snapshot: snapshot,
                    isToday: WidgetTimelinePlanning.isToday(snapshot, now: start, zone: zone)
                )
            )
        }
        let reload = WidgetTimelinePlanning.nextMidnight(
            after: now,
            civil: TimeContext(displayZone: zone, deliveryZone: zone, now: { now }).today(in: zone),
            zone: zone
        )
        completion(Timeline(entries: entries, policy: .after(reload)))
    }

    private func makeEntry(now: Date) -> LichNhaEntry {
        let zone = loadedZone()
        let stored = WidgetSnapshotStore.load()?.snapshots ?? []
        let fallback = fallbackSnapshot(
            civil: TimeContext(displayZone: zone, deliveryZone: zone, now: { now }).today(in: zone),
            now: now,
            zone: zone
        )
        let snapshot = WidgetTimelinePlanning.snapshotForDisplay(
            stored: stored,
            now: now,
            zone: zone,
            fallback: fallback
        )
        return LichNhaEntry(
            date: now,
            snapshot: snapshot,
            isToday: WidgetTimelinePlanning.isToday(snapshot, now: now, zone: zone)
        )
    }

    private func loadedZone() -> TimeZoneIdentifier {
        if let raw = WidgetSnapshotStore.load()?.displayZone {
            return TimeZoneIdentifier(raw)
        }
        return .vietnam
    }

    private func fallbackSnapshot(civil: CivilDate, now: Date, zone: TimeZoneIdentifier) -> WidgetSnapshot {
        let day = (try? VietnameseLunarCalendar.calendarDay(
            civil: civil,
            displayTimeZone: zone
        )) ?? CalendarDay(
            civilDate: civil,
            displayTimeZone: zone,
            calendarRuleZone: .vietnam,
            weekday: 1,
            lunarDate: LunarDate(day: 1, month: 1, year: civil.year, isLeapMonth: false, ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion),
            canChi: CanChi(
                day: StemBranch(stemIndex: 0, branchIndex: 0),
                month: StemBranch(stemIndex: 0, branchIndex: 0),
                year: StemBranch(stemIndex: 0, branchIndex: 0)
            ),
            solarTerm: nil,
            historyScope: .modern,
            occurrenceIDs: [],
            engineVersion: VietnameseLunarCalendar.ruleSetVersion,
            warnings: []
        )
        return ContentCore.WidgetSnapshotBuilder.dateOnly(day: day, now: now, displayZone: zone)
    }

    private func entryDate(for civil: CivilDate, zone: TimeZoneIdentifier, now: Date) -> Date {
        let tz = TimeZone(identifier: zone.rawValue) ?? TimeZone(secondsFromGMT: 7 * 3600)!
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = tz
        var parts = DateComponents()
        parts.year = civil.year
        parts.month = civil.month
        parts.day = civil.day
        parts.hour = 0
        parts.minute = 1
        let start = calendar.date(from: parts) ?? now
        return max(start, now)
    }
}
