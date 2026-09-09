import Testing
@testable import CalendarCore

struct SolarTermTests {
    @Test func winterSolsticeIsNamedDongChi() {
        var found: SolarTermOccurrence?
        for day in 19...23 {
            let civil = CivilDate(year: 2024, month: 12, day: day)
            if let term = SolarTermCalculator.termStartingOn(civil), term.name == "Đông chí" {
                found = term
            }
        }
        #expect(found != nil)
        #expect(found?.precision == .day)
    }

    @Test func lapXuanFallsInEarlyFebruary2024() {
        var found = false
        for day in 3...6 {
            let civil = CivilDate(year: 2024, month: 2, day: day)
            if SolarTermCalculator.termStartingOn(civil)?.name == "Lập xuân" {
                found = true
            }
        }
        #expect(found)
    }
}
