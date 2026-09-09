import Testing
import AlmanacCore
import CalendarCore

struct AlmanacRuleSetTests {
    @Test func versionOneKeepsThreeNamedMethods() {
        let set = AlmanacCatalog.version1
        #expect(set.methods.count == 3)
        #expect(set.methods.map(\.id) == ["hoang-hac-dao", "luc-dieu", "sat-chu-tho-tu"])
    }

    @Test func entriesStaySplitAndReferenceOnly() throws {
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 9, day: 2),
            displayTimeZone: .vietnam
        )
        let entries = AlmanacEngine.entries(for: day)
        let methods = Set(entries.map(\.methodID))
        #expect(methods == ["hoang-hac-dao", "luc-dieu", "sat-chu-tho-tu"])
        #expect(entries.allSatisfy { $0.isReferenceOnly })
        #expect(AlmanacEngine.fusedVerdict(from: entries) == nil)
        #expect(entries.contains { $0.methodID == "sat-chu-tho-tu" && $0.label.contains("chưa khóa") })
        #expect(entries.filter { $0.methodID == "hoang-hac-dao" }.count == 12)
        #expect(AlmanacEngine.referenceLabel == "tham khảo theo lịch truyền thống")
    }

    @Test func conflictingMethodsDoNotCollapse() throws {
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2024, month: 2, day: 10),
            displayTimeZone: .vietnam
        )
        let entries = AlmanacEngine.entries(for: day)
        let hoang = entries.filter { $0.methodID == "hoang-hac-dao" }
        let luc = entries.filter { $0.methodID == "luc-dieu" }
        #expect(!hoang.isEmpty)
        #expect(luc.count == 1)
        #expect(hoang.contains { $0.label.contains("Hoàng Đạo") })
        #expect(hoang.contains { $0.label.contains("Hắc Đạo") })
        #expect(AlmanacEngine.fusedVerdict(from: hoang + luc) == nil)
    }
}
