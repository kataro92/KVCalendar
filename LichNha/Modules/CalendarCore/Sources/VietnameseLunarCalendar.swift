import Foundation

public enum VietnameseLunarCalendar {
    public static let ruleSetVersion = Astronomy.engineVersion
    public static let offsetHours = Astronomy.vietnamOffsetHours

    public static func lunarDate(from civil: CivilDate) throws -> LunarDate {
        guard civil.isInPublishedRange else { throw CalendarCoreError.outOfRange(civil) }
        let tz = offsetHours
        let dayNumber = Astronomy.julianDayNumber(day: civil.day, month: civil.month, year: civil.year)
        let k = Astronomy.kFromDayNumber(dayNumber)
        var monthStart = Astronomy.newMoonDay(k: k + 1, offsetHours: tz)
        if monthStart > dayNumber {
            monthStart = Astronomy.newMoonDay(k: k, offsetHours: tz)
        }
        var a11 = lunarMonth11(solarYear: civil.year)
        var b11 = a11
        let lunarYear: Int
        if a11 >= monthStart {
            lunarYear = civil.year
            a11 = lunarMonth11(solarYear: civil.year - 1)
        } else {
            lunarYear = civil.year + 1
            b11 = lunarMonth11(solarYear: civil.year + 1)
        }
        let lunarDay = dayNumber - monthStart + 1
        let diff = (monthStart - a11) / 29
        var lunarLeap = false
        var lunarMonth = diff + 11
        if b11 - a11 > 365 {
            let leapMonthDiff = leapMonthOffset(a11: a11)
            if diff >= leapMonthDiff {
                lunarMonth = diff + 10
                if diff == leapMonthDiff {
                    lunarLeap = true
                }
            }
        }
        if lunarMonth > 12 {
            lunarMonth -= 12
        }
        var year = lunarYear
        if lunarMonth >= 11 && diff < 4 {
            year -= 1
        }
        return LunarDate(
            day: lunarDay,
            month: lunarMonth,
            year: year,
            isLeapMonth: lunarLeap,
            ruleSetVersion: ruleSetVersion
        )
    }

    public static func civilDate(from lunar: LunarDate) throws -> CivilDate {
        let tz = offsetHours
        let a11: Int
        let b11: Int
        if lunar.month < 11 {
            a11 = lunarMonth11(solarYear: lunar.year - 1)
            b11 = lunarMonth11(solarYear: lunar.year)
        } else {
            a11 = lunarMonth11(solarYear: lunar.year)
            b11 = lunarMonth11(solarYear: lunar.year + 1)
        }
        var off = lunar.month - 11
        if off < 0 { off += 12 }
        if b11 - a11 > 365 {
            let leapOff = leapMonthOffset(a11: a11)
            var leapMonth = leapOff - 2
            if leapMonth < 0 { leapMonth += 12 }
            if lunar.isLeapMonth && lunar.month != leapMonth {
                throw CalendarCoreError.invalidLunarDate(lunar)
            }
            if lunar.isLeapMonth || off >= leapOff {
                off += 1
            }
        } else if lunar.isLeapMonth {
            throw CalendarCoreError.invalidLunarDate(lunar)
        }
        let k = Int(floor(0.5 + (Double(a11) - Astronomy.epochJD) / Astronomy.synodicMonth))
        let monthStart = Astronomy.newMoonDay(k: k + off, offsetHours: tz)
        let civil = Astronomy.civilDate(fromJulianDayNumber: monthStart + lunar.day - 1)
        guard civil.isInPublishedRange else { throw CalendarCoreError.outOfRange(civil) }
        return civil
    }

    public static func calendarDay(
        civil: CivilDate,
        displayTimeZone: TimeZoneIdentifier,
        timeContext: TimeContext? = nil
    ) throws -> CalendarDay {
        let lunar = try lunarDate(from: civil)
        let canChi = CanChiCalculator.canChi(civil: civil, lunar: lunar)
        let weekday = weekdayIndex(civil)
        let scope = HistoricalCalendarScope.scope(for: civil)
        var warnings: [String] = []
        if scope != .modern {
            warnings.append(HistoricalCalendarScope.warningID)
        }
        return CalendarDay(
            civilDate: civil,
            displayTimeZone: displayTimeZone,
            calendarRuleZone: timeContext?.calendarRuleZone ?? .vietnam,
            weekday: weekday,
            lunarDate: lunar,
            canChi: canChi,
            solarTerm: SolarTermCalculator.termStartingOn(civil),
            historyScope: scope,
            occurrenceIDs: [],
            engineVersion: ruleSetVersion,
            warnings: warnings
        )
    }

    static func lunarMonth11(solarYear: Int) -> Int {
        let tz = offsetHours
        let off = Astronomy.julianDayNumber(day: 31, month: 12, year: solarYear) - 2_415_021
        let k = Int(floor(Double(off) / Astronomy.synodicMonth))
        var nm = Astronomy.newMoonDay(k: k, offsetHours: tz)
        if Astronomy.majorSolarTerm(jdn: nm, offsetHours: tz) >= 9 {
            nm = Astronomy.newMoonDay(k: k - 1, offsetHours: tz)
        }
        return nm
    }

    static func leapMonthOffset(a11: Int) -> Int {
        let tz = offsetHours
        let k = Int(floor((Double(a11) - Astronomy.epochJD) / Astronomy.synodicMonth + 0.5))
        var i = 1
        var arc = Astronomy.majorSolarTerm(jdn: Astronomy.newMoonDay(k: k + i, offsetHours: tz), offsetHours: tz)
        var last = 0
        repeat {
            last = arc
            i += 1
            arc = Astronomy.majorSolarTerm(
                jdn: Astronomy.newMoonDay(k: k + i, offsetHours: tz),
                offsetHours: tz
            )
        } while arc != last && i < 14
        return i - 1
    }

    public static func leapMonthNumber(inLunarYear year: Int) -> Int? {
        for month in 1...12 {
            let probe = LunarDate(
                day: 1,
                month: month,
                year: year,
                isLeapMonth: true,
                ruleSetVersion: ruleSetVersion
            )
            if (try? civilDate(from: probe)) != nil {
                return month
            }
        }
        return nil
    }

    public static func months(inLunarYear year: Int) -> [(month: Int, isLeap: Bool)] {
        let leap = leapMonthNumber(inLunarYear: year)
        var result: [(Int, Bool)] = []
        for month in 1...12 {
            result.append((month, false))
            if leap == month {
                result.append((month, true))
            }
        }
        return result
    }

    public static func daysInMonth(year: Int, month: Int, isLeap: Bool) throws -> Int {
        let start = LunarDate(
            day: 1,
            month: month,
            year: year,
            isLeapMonth: isLeap,
            ruleSetVersion: ruleSetVersion
        )
        let startCivil = try civilDate(from: start)
        let next = nextMonth(year: year, month: month, isLeap: isLeap)
        let nextCivil = try civilDate(from: next)
        let startJDN = Astronomy.julianDayNumber(day: startCivil.day, month: startCivil.month, year: startCivil.year)
        let nextJDN = Astronomy.julianDayNumber(day: nextCivil.day, month: nextCivil.month, year: nextCivil.year)
        return nextJDN - startJDN
    }

    public static func nextMonth(year: Int, month: Int, isLeap: Bool) -> LunarDate {
        let yearMonths = months(inLunarYear: year)
        if let index = yearMonths.firstIndex(where: { $0.month == month && $0.isLeap == isLeap }),
           index + 1 < yearMonths.count {
            let next = yearMonths[index + 1]
            return LunarDate(
                day: 1,
                month: next.month,
                year: year,
                isLeapMonth: next.isLeap,
                ruleSetVersion: ruleSetVersion
            )
        }
        return LunarDate(day: 1, month: 1, year: year + 1, isLeapMonth: false, ruleSetVersion: ruleSetVersion)
    }

    static func weekdayIndex(_ civil: CivilDate) -> Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: Int(offsetHours * 3600))!
        var parts = DateComponents()
        parts.calendar = calendar
        parts.timeZone = calendar.timeZone
        parts.year = civil.year
        parts.month = civil.month
        parts.day = civil.day
        guard let date = parts.date else { return 1 }
        return calendar.component(.weekday, from: date)
    }
}
