import Foundation

public enum CanChiCalculator {
    public static let version = Astronomy.engineVersion

    public static func canChi(civil: CivilDate, lunar: LunarDate) -> CanChi {
        CanChi(
            day: day(of: civil),
            month: month(lunarYear: lunar.year, lunarMonth: lunar.month, isLeap: lunar.isLeapMonth),
            year: year(lunarYear: lunar.year)
        )
    }

    public static func day(of civil: CivilDate) -> StemBranch {
        let jdn = Astronomy.julianDayNumber(day: civil.day, month: civil.month, year: civil.year)
        return StemBranch(stemIndex: jdn + 9, branchIndex: jdn + 1)
    }

    public static func year(lunarYear: Int) -> StemBranch {
        StemBranch(stemIndex: lunarYear + 6, branchIndex: lunarYear + 8)
    }

    public static func month(lunarYear: Int, lunarMonth: Int, isLeap: Bool) -> StemBranch {
        // Leap months reuse the index of the named month.
        let m = lunarMonth
        let stem = (lunarYear * 12 + m + 3) % 10
        let branch = (m + 1) % 12
        _ = isLeap
        return StemBranch(stemIndex: stem, branchIndex: branch)
    }
}
