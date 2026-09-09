import Foundation
import Testing
@testable import CalendarCore

struct LunarConversionTests {
    @Test func julianDayNumberFor1Jan2000() {
        let jdn = Astronomy.julianDayNumber(day: 1, month: 1, year: 2000)
        #expect(jdn == 2_451_545)
    }

    @Test func tet1984IsSecondOfFebruary() throws {
        let lunar = try VietnameseLunarCalendar.lunarDate(
            from: CivilDate(year: 1984, month: 2, day: 2)
        )
        #expect(lunar.day == 1)
        #expect(lunar.month == 1)
        #expect(lunar.isLeapMonth == false)
        #expect(lunar.year == 1984)
    }

    @Test func monthEleven1983Starts4December() throws {
        let lunar = try VietnameseLunarCalendar.lunarDate(
            from: CivilDate(year: 1983, month: 12, day: 4)
        )
        #expect(lunar.day == 1)
        #expect(lunar.month == 11)
        #expect(lunar.year == 1983)
    }

    @Test func tet2024() throws {
        let lunar = try VietnameseLunarCalendar.lunarDate(
            from: CivilDate(year: 2024, month: 2, day: 10)
        )
        #expect(lunar.day == 1)
        #expect(lunar.month == 1)
        #expect(lunar.isLeapMonth == false)
        #expect(lunar.year == 2024)
    }

    @Test func leapMonthTwo2004Starts21March() throws {
        let lunar = try VietnameseLunarCalendar.lunarDate(
            from: CivilDate(year: 2004, month: 3, day: 21)
        )
        #expect(lunar.day == 1)
        #expect(lunar.month == 2)
        #expect(lunar.isLeapMonth == true)
        #expect(lunar.year == 2004)
    }

    @Test func roundTripTetAndLeap() throws {
        let samples = [
            CivilDate(year: 1984, month: 2, day: 2),
            CivilDate(year: 2004, month: 3, day: 21),
            CivilDate(year: 2024, month: 2, day: 10),
            CivilDate(year: 2025, month: 1, day: 29),
        ]
        for civil in samples {
            let lunar = try VietnameseLunarCalendar.lunarDate(from: civil)
            let back = try VietnameseLunarCalendar.civilDate(from: lunar)
            #expect(back == civil)
        }
    }

    @Test func socHoursStayInsideLocalDay() {
        let k = LunarNewMoon.k(containing: CivilDate(year: 2024, month: 2, day: 10))
        let hours = LunarNewMoon.hoursAfterLocalMidnight(k: k)
        #expect(hours >= 0 && hours < 24)
    }

    @Test func outOfRangeRejected() {
        #expect(throws: CalendarCoreError.self) {
            try VietnameseLunarCalendar.lunarDate(from: CivilDate(year: 1899, month: 1, day: 1))
        }
    }
}
