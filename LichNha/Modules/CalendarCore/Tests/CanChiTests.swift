import Testing
@testable import CalendarCore

struct CanChiTests {
    @Test func year1984IsGiapTy() {
        let year = CanChiCalculator.year(lunarYear: 1984)
        #expect(year.name == "Giáp Tý")
    }

    @Test func tet1984DayStemBranch() throws {
        let civil = CivilDate(year: 1984, month: 2, day: 2)
        let lunar = try VietnameseLunarCalendar.lunarDate(from: civil)
        let cc = CanChiCalculator.canChi(civil: civil, lunar: lunar)
        #expect(cc.year.name == "Giáp Tý")
        #expect(cc.month.branchName == "Dần")
    }

    @Test func monthThree2004IsMauThin() {
        let month = CanChiCalculator.month(lunarYear: 2004, lunarMonth: 3, isLeap: false)
        #expect(month.name == "Mậu Thìn")
    }
}
