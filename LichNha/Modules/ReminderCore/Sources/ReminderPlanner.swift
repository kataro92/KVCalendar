import Foundation
import CalendarCore
import PersonalCore

public enum ReminderPlanner {
    public static let defaultWindowMonths = 18

    public static func plan(
        event: PersonalEvent,
        windowStart: CivilDate,
        windowEnd: CivilDate,
        permission: NotificationAuthorization,
        engineVersion: String = VietnameseLunarCalendar.ruleSetVersion
    ) -> ReminderPlan {
        let targets = targetCivilDates(event: event, windowStart: windowStart, windowEnd: windowEnd)
        var occurrences: [ReminderOccurrence] = []
        for target in targets {
            let deliveryCivil = target.adding(days: -event.reminderPolicy.leadDays)
            guard deliveryCivil >= windowStart.adding(days: -1), deliveryCivil <= windowEnd else { continue }
            let clock = DeliveryClock.instant(
                civil: deliveryCivil,
                hour: event.reminderPolicy.hour,
                minute: event.reminderPolicy.minute,
                zoneIdentifier: event.deliveryZone,
                policy: event.dstResolutionPolicy
            )
            let identifier = occurrenceID(eventID: event.id, target: target, leadDays: event.reminderPolicy.leadDays)
            if clock.failed {
                occurrences.append(
                    ReminderOccurrence(
                        id: identifier,
                        eventID: event.id,
                        targetCivilDate: target,
                        deliveryDateTime: Date(timeIntervalSince1970: 0),
                        status: .failed,
                        sourceRuleVersion: engineVersion,
                        timeAdjustment: clock.adjustment
                    )
                )
                continue
            }
            occurrences.append(
                ReminderOccurrence(
                    id: identifier,
                    eventID: event.id,
                    targetCivilDate: target,
                    deliveryDateTime: clock.date,
                    status: .planned,
                    sourceRuleVersion: engineVersion,
                    timeAdjustment: clock.adjustment
                )
            )
        }
        occurrences.sort { $0.deliveryDateTime < $1.deliveryDateTime }
        let status: ReminderEventStatus
        if !event.reminderPolicy.enabled {
            status = .saved
        } else if permission == .denied {
            status = .permissionDenied
        } else if occurrences.contains(where: { $0.status == .failed }) {
            status = .planningError
        } else if permission == .authorized || permission == .provisional {
            status = .remindersActive
        } else {
            status = .saved
        }
        return ReminderPlan(
            occurrences: occurrences,
            eventStatus: status,
            policySummary: PersonalEventCopy.policySummary(event)
        )
    }

    public static func targetCivilDates(
        event: PersonalEvent,
        windowStart: CivilDate,
        windowEnd: CivilDate
    ) -> [CivilDate] {
        switch event.calendarBasis {
        case .solar:
            return solarTargets(event: event, windowStart: windowStart, windowEnd: windowEnd)
        case .lunar:
            return lunarTargets(event: event, windowStart: windowStart, windowEnd: windowEnd)
        }
    }

    public static func occurrenceID(eventID: String, target: CivilDate, leadDays: Int) -> String {
        let month = String(format: "%02d", target.month)
        let day = String(format: "%02d", target.day)
        return "ln-rem.\(eventID).\(target.year)-\(month)-\(day).d\(leadDays)"
    }

    private static func solarTargets(
        event: PersonalEvent,
        windowStart: CivilDate,
        windowEnd: CivilDate
    ) -> [CivilDate] {
        guard let origin = event.originCivilDate else { return [] }
        if event.recurrence == .none {
            return origin >= windowStart && origin <= windowEnd ? [origin] : []
        }
        var dates: [CivilDate] = []
        for year in (windowStart.year - 1)...(windowEnd.year + 1) {
            guard let civil = gregorianDate(year: year, month: origin.month, day: origin.day) else { continue }
            if civil >= windowStart && civil <= windowEnd {
                dates.append(civil)
            }
        }
        return dates
    }

    private static func lunarTargets(
        event: PersonalEvent,
        windowStart: CivilDate,
        windowEnd: CivilDate
    ) -> [CivilDate] {
        guard let origin = event.originLunarDate else { return [] }
        var years: [Int] = []
        if event.recurrence == .none {
            years = [origin.year]
        } else {
            years = Array((windowStart.year - 1)...(windowEnd.year + 1))
        }
        var dates: [CivilDate] = []
        for year in years {
            for candidate in leapCandidates(origin: origin, year: year, policy: event.leapMonthPolicy) {
                if let civil = resolveShortMonth(
                    year: year,
                    month: candidate.month,
                    isLeap: candidate.isLeap,
                    day: origin.day,
                    policy: event.shortMonthPolicy
                ) {
                    if event.recurrence == .none && year != origin.year { continue }
                    if civil >= windowStart && civil <= windowEnd {
                        dates.append(civil)
                    }
                }
            }
        }
        return dates.sorted()
    }

    private static func leapCandidates(
        origin: LunarDate,
        year: Int,
        policy: LeapMonthPolicy
    ) -> [(month: Int, isLeap: Bool)] {
        let leap = VietnameseLunarCalendar.leapMonthNumber(inLunarYear: year)
        let month = origin.month
        switch policy {
        case .regularMonth:
            return [(month, false)]
        case .leapMonth:
            return leap == month ? [(month, true)] : []
        case .both:
            var result = [(month, false)]
            if leap == month {
                result.append((month, true))
            }
            return result
        case .substitute:
            if leap == month {
                return origin.isLeapMonth ? [(month, true)] : [(month, false)]
            }
            return [(month, false)]
        }
    }

    private static func resolveShortMonth(
        year: Int,
        month: Int,
        isLeap: Bool,
        day: Int,
        policy: ShortMonthPolicy
    ) -> CivilDate? {
        guard let days = try? VietnameseLunarCalendar.daysInMonth(year: year, month: month, isLeap: isLeap) else {
            return nil
        }
        if day <= days {
            let lunar = LunarDate(
                day: day,
                month: month,
                year: year,
                isLeapMonth: isLeap,
                ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
            )
            return try? VietnameseLunarCalendar.civilDate(from: lunar)
        }
        guard day == 30, days == 29 else { return nil }
        switch policy {
        case .skip:
            return nil
        case .lastDayOfMonth:
            let lunar = LunarDate(
                day: 29,
                month: month,
                year: year,
                isLeapMonth: isLeap,
                ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
            )
            return try? VietnameseLunarCalendar.civilDate(from: lunar)
        case .firstOfNext:
            let next = VietnameseLunarCalendar.nextMonth(year: year, month: month, isLeap: isLeap)
            return try? VietnameseLunarCalendar.civilDate(from: next)
        }
    }

    private static func gregorianDate(year: Int, month: Int, day: Int) -> CivilDate? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 7 * 3600)!
        var parts = DateComponents()
        parts.calendar = calendar
        parts.timeZone = calendar.timeZone
        parts.year = year
        parts.month = month
        parts.day = day
        guard let date = calendar.date(from: parts) else { return nil }
        let actual = calendar.dateComponents([.year, .month, .day], from: date)
        guard actual.year == year, actual.month == month, actual.day == day else { return nil }
        return CivilDate(year: year, month: month, day: day)
    }
}

public enum DeliveryClock {
    public static func instant(
        civil: CivilDate,
        hour: Int,
        minute: Int,
        zoneIdentifier: TimeZoneIdentifier,
        policy: DSTResolutionPolicy
    ) -> (date: Date, adjustment: TimeAdjustment, failed: Bool) {
        let zone = TimeZone(identifier: zoneIdentifier.rawValue) ?? TimeZone(secondsFromGMT: 7 * 3600)!
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = zone
        let matches = matchingInstants(civil: civil, hour: hour, minute: minute, calendar: calendar)
        switch matches.count {
        case 0:
            if let next = nextValidInstant(civil: civil, hour: hour, minute: minute, calendar: calendar) {
                return (next, .dstGapNextValid, false)
            }
            return (Date(timeIntervalSince1970: 0), .dstGapNextValid, true)
        case 1:
            return (matches[0], .none, false)
        default:
            _ = policy
            return (matches[0], .dstOverlapEarlier, false)
        }
    }

    private static func matchingInstants(
        civil: CivilDate,
        hour: Int,
        minute: Int,
        calendar: Calendar
    ) -> [Date] {
        guard let start = startOfDay(civil: civil, calendar: calendar) else { return [] }
        let end = start.addingTimeInterval(26 * 3600)
        var results: [Date] = []
        var cursor = start
        while cursor < end {
            let parts = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: cursor)
            if parts.year == civil.year, parts.month == civil.month, parts.day == civil.day,
               parts.hour == hour, parts.minute == minute {
                results.append(cursor)
                cursor = cursor.addingTimeInterval(60)
                continue
            }
            cursor = cursor.addingTimeInterval(60)
        }
        return results
    }

    private static func nextValidInstant(
        civil: CivilDate,
        hour: Int,
        minute: Int,
        calendar: Calendar
    ) -> Date? {
        guard let start = startOfDay(civil: civil, calendar: calendar) else { return nil }
        let end = start.addingTimeInterval(24 * 3600)
        let targetMinutes = hour * 60 + minute
        var cursor = start.addingTimeInterval(TimeInterval(targetMinutes * 60))
        while cursor < end {
            let parts = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: cursor)
            if parts.year == civil.year, parts.month == civil.month, parts.day == civil.day {
                let actual = (parts.hour ?? 0) * 60 + (parts.minute ?? 0)
                if actual >= targetMinutes {
                    return cursor
                }
            }
            cursor = cursor.addingTimeInterval(60)
        }
        return nil
    }

    private static func startOfDay(civil: CivilDate, calendar: Calendar) -> Date? {
        var parts = DateComponents()
        parts.year = civil.year
        parts.month = civil.month
        parts.day = civil.day
        parts.hour = 0
        parts.minute = 0
        parts.second = 0
        return calendar.date(from: parts)
    }
}
