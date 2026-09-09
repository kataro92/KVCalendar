import Foundation

/// Sóc (new moon) on the UTC+7 civil day that contains it, for golden corpus and tests.
public enum LunarNewMoon {
    public static func k(containing civil: CivilDate) -> Int {
        Astronomy.kFromDayNumber(
            Astronomy.julianDayNumber(day: civil.day, month: civil.month, year: civil.year)
        )
    }

    public static func civilDate(k: Int) -> CivilDate {
        Astronomy.civilDate(fromJulianDayNumber: Astronomy.newMoonDay(k: k))
    }

    /// Hours after local midnight of the UTC+7 date that contains this Sóc.
    public static func hoursAfterLocalMidnight(k: Int) -> Double {
        let shifted = Astronomy.newMoonJulianDate(k: k) + 0.5 + Astronomy.vietnamOffsetHours / 24
        return (shifted - floor(shifted)) * 24
    }
}
