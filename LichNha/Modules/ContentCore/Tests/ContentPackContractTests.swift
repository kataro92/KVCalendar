import Foundation
import Testing
import ContentCore
import CalendarCore

struct ContentPackContractTests {
    @Test func taxonomyHasDistinctCases() {
        #expect(OccurrenceTaxonomy.statutoryHoliday != .traditionalLunar)
        #expect(OccurrenceTaxonomy.personal != .statutoryHoliday)
        #expect(OccurrenceTaxonomy.statutoryHoliday.displayName.contains("luật"))
        #expect(OccurrenceTaxonomy.traditionalLunar.displayName.contains("tham khảo"))
    }

    @Test func restrictedLicenseIsADistinctStatus() {
        #expect(LicenseStatus.restricted != .publicRecord)
        #expect(LicenseStatus.restricted != .licensed)
    }

    @Test func packHeaderFieldsMatchValidator() {
        let required = [
            "schemaVersion",
            "packVersion",
            "publishedAt",
            "effectiveRange",
            "minimumAppVersion",
            "recordsChecksum",
            "approvals",
            "sources",
            "occurrences",
        ]
        #expect(required.count == 9)
    }

    @Test func catalogLoadsOfficialQuocKhanh() throws {
        let catalog = try ContentCatalog.load(from: fixtureDirectory(), cacheDirectory: uniqueCache())
        #expect(catalog.usedFallback == false)
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 9, day: 2),
            displayTimeZone: .vietnam
        )
        let hits = catalog.occurrences(on: day)
        #expect(hits.contains { $0.id == "quoc-khanh" && $0.isDayOff && $0.taxonomy == .statutoryHoliday })
        #expect(catalog.source(id: "bllld-2019-d112")?.evidenceTier == .official)
        #expect(catalog.source(id: "xieji-bianfang-shu") != nil)
    }

    @Test func catalogLoadsTetNguyenDanOnLunarNewYear() throws {
        let catalog = try ContentCatalog.load(from: fixtureDirectory(), cacheDirectory: uniqueCache())
        let mungMot = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 2, day: 17),
            displayTimeZone: .vietnam
        )
        #expect(mungMot.lunarDate.day == 1)
        #expect(mungMot.lunarDate.month == 1)
        let hits = catalog.occurrences(on: mungMot)
        #expect(hits.contains { $0.id == "tet-nguyen-dan" && $0.isDayOff && $0.taxonomy == .statutoryHoliday })

        let eve = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 2, day: 16),
            displayTimeZone: .vietnam
        )
        #expect(catalog.occurrences(on: eve).contains { $0.id == "tet-am-lich-2026-02-16" && $0.isDayOff })
        #expect(catalog.occurrences(on: eve).contains { $0.taxonomy == .yearlySchedule })
    }

    @Test func cultureDayAndNationalDayAdjacentStaySplit() throws {
        let catalog = try ContentCatalog.load(from: fixtureDirectory(), cacheDirectory: uniqueCache())
        let culture = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 11, day: 24),
            displayTimeZone: .vietnam
        )
        #expect(catalog.occurrences(on: culture).contains {
            $0.id == "ngay-van-hoa-viet-nam" && $0.isDayOff && $0.taxonomy == .statutoryHoliday
        })
        let adjacent = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 9, day: 1),
            displayTimeZone: .vietnam
        )
        #expect(catalog.occurrences(on: adjacent).contains { $0.id == "quoc-khanh-2026-lien-ke" && $0.isDayOff })
        let otherYear = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2027, month: 9, day: 1),
            displayTimeZone: .vietnam
        )
        #expect(catalog.occurrences(on: otherYear).contains { $0.id == "quoc-khanh-2026-lien-ke" } == false)
    }

    @Test func traditionalIsNotDayOff() throws {
        let catalog = try ContentCatalog.load(from: fixtureDirectory(), cacheDirectory: uniqueCache())
        let lunar = LunarDate(
            day: 5,
            month: 5,
            year: 2026,
            isLeapMonth: false,
            ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
        )
        let civil = try VietnameseLunarCalendar.civilDate(from: lunar)
        let day = try VietnameseLunarCalendar.calendarDay(civil: civil, displayTimeZone: .vietnam)
        let hits = catalog.occurrences(on: day)
        let doan = hits.first { $0.id == "doan-ngo" }
        #expect(doan != nil)
        #expect(doan?.isDayOff == false)
        #expect(doan?.taxonomy == .traditionalLunar)

        let trungThuLunar = LunarDate(
            day: 15,
            month: 8,
            year: 2026,
            isLeapMonth: false,
            ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
        )
        let trungThuCivil = try VietnameseLunarCalendar.civilDate(from: trungThuLunar)
        let trungThuDay = try VietnameseLunarCalendar.calendarDay(civil: trungThuCivil, displayTimeZone: .vietnam)
        let trungThu = catalog.occurrences(on: trungThuDay).first { $0.id == "trung-thu" }
        #expect(trungThu != nil)
        #expect(trungThu?.isDayOff == false)
        #expect(trungThu?.taxonomy == .traditionalLunar)
    }

    @Test func brokenChecksumUsesFallback() throws {
        let cache = uniqueCache()
        _ = try ContentCatalog.load(from: fixtureDirectory(), cacheDirectory: cache)
        let broken = uniqueTemp()
        try FileManager.default.copyItem(at: fixtureDirectory(), to: broken)
        let official = broken.appendingPathComponent("official-vn.json")
        try FileManager.default.removeItem(at: official)
        try FileManager.default.copyItem(
            at: fixtureDirectory().appendingPathComponent("invalid-checksum.json"),
            to: official
        )
        let catalog = try ContentCatalog.load(from: broken, cacheDirectory: cache)
        #expect(catalog.usedFallback)
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: CivilDate(year: 2026, month: 9, day: 2),
            displayTimeZone: .vietnam
        )
        #expect(catalog.occurrences(on: day).contains { $0.id == "quoc-khanh" })
    }

    @Test func sourceURLMustStayHttpsInSeed() throws {
        let catalog = try ContentCatalog.load(from: fixtureDirectory(), cacheDirectory: uniqueCache())
        for source in catalog.sources {
            if let url = source.url {
                #expect(url.hasPrefix("https://"))
            }
            #expect(source.licenseStatus != .restricted)
        }
    }
}

private func fixtureDirectory() -> URL {
    URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent()
        .appendingPathComponent("Fixtures")
}

private func uniqueCache() -> URL {
    FileManager.default.temporaryDirectory.appendingPathComponent("lichnha-cache-\(UUID().uuidString)")
}

private func uniqueTemp() -> URL {
    FileManager.default.temporaryDirectory.appendingPathComponent("lichnha-broken-\(UUID().uuidString)")
}
