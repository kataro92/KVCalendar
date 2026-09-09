import Foundation
import CalendarCore
import PersonalCore

@MainActor
public final class ReminderRefreshCoordinator {
    public private(set) var lastReason: RefreshReason?
    public private(set) var lastPlans: [String: ReminderPlan] = [:]
    public private(set) var lastEngineVersion: String = VietnameseLunarCalendar.ruleSetVersion
    public var permission: NotificationAuthorization

    private let repository: PersonalEventRepository
    private let scheduler: any NotificationScheduling

    public init(
        repository: PersonalEventRepository,
        scheduler: any NotificationScheduling,
        permission: NotificationAuthorization = .notRequested
    ) {
        self.repository = repository
        self.scheduler = scheduler
        self.permission = permission
    }

    public func requestPermission() async -> NotificationAuthorization {
        permission = await scheduler.requestAuthorization()
        return permission
    }

    public func refresh(
        reason: RefreshReason,
        now: Date = Date(),
        windowStart: CivilDate? = nil,
        windowEnd: CivilDate? = nil
    ) async throws {
        lastReason = reason
        if reason == .permissionChange {
            permission = await scheduler.authorizationStatus()
        }
        let events = try repository.allEvents()
        let start = windowStart ?? Self.civil(from: now).adding(days: -1)
        let end = windowEnd ?? start.adding(days: 31 * ReminderPlanner.defaultWindowMonths)
        var plans: [String: ReminderPlan] = [:]
        var combined: [ReminderOccurrence] = []
        for event in events {
            var plan = ReminderPlanner.plan(
                event: event,
                windowStart: start,
                windowEnd: end,
                permission: permission
            )
            if lastEngineVersion != VietnameseLunarCalendar.ruleSetVersion {
                plan.eventStatus = .needsRefresh
            }
            plans[event.id] = plan
            combined.append(contentsOf: plan.occurrences)
        }
        let titles = Dictionary(uniqueKeysWithValues: events.map { ($0.id, $0.title) })
        let scheduled = try await NotificationScheduler.replace(
            combined,
            on: scheduler,
            permission: permission,
            now: now,
            titles: titles
        )
        let scheduledIDs = Set(scheduled.map(\.id))
        for id in plans.keys {
            let mapped = plans[id]!.occurrences.map { item -> ReminderOccurrence in
                scheduled.first(where: { $0.id == item.id }) ?? item
            }
            plans[id]!.occurrences = mapped
            if permission == .denied, plans[id]!.eventStatus != .saved {
                plans[id]!.eventStatus = .permissionDenied
            }
            _ = scheduledIDs
        }
        lastPlans = plans
        lastEngineVersion = VietnameseLunarCalendar.ruleSetVersion
    }

    private static func civil(from date: Date) -> CivilDate {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: TimeZoneIdentifier.vietnam.rawValue) ?? TimeZone(secondsFromGMT: 7 * 3600)!
        let parts = calendar.dateComponents([.year, .month, .day], from: date)
        return CivilDate(year: parts.year!, month: parts.month!, day: parts.day!)
    }
}
