import CryptoKit
import Foundation
import Testing
@testable import CalendarCore

private struct GoldenFile: Codable {
    var schemaVersion: String
    var engineVersion: String
    var recordsChecksum: String
    var records: [GoldenRecord]
}

private struct GoldenRecord: Codable {
    var civilYear: Int
    var civilMonth: Int
    var civilDay: Int
    var lunarYear: Int
    var lunarMonth: Int
    var lunarDay: Int
    var isLeapMonth: Bool
    var sourceKind: String
    var sourceNote: String
    var timezone: String
    var engineVersion: String
}

struct CalendarPropertyTests {
    @Test func roundTripSelectedDays1900To2100() throws {
        let years = [1900, 1930, 1968, 1975, 1976, 2004, 2012, 2020, 2023, 2100]
        for year in years {
            for month in [1, 2, 6, 11, 12] {
                let civil = CivilDate(year: year, month: month, day: 1)
                let lunar = try VietnameseLunarCalendar.lunarDate(from: civil)
                let back = try VietnameseLunarCalendar.civilDate(from: lunar)
                #expect(back == civil)
            }
        }
    }

    @Test func gregorianMonthStartsRoundTripAcrossPublishedRange() throws {
        for year in 1900...2100 {
            for month in 1...12 {
                let civil = CivilDate(year: year, month: month, day: 1)
                let lunar = try VietnameseLunarCalendar.lunarDate(from: civil)
                let back = try VietnameseLunarCalendar.civilDate(from: lunar)
                #expect(back == civil)
            }
        }
    }

    @Test func consecutiveDaysStayAdjacentOnLunarMonth() throws {
        for year in [1901, 1968, 1975, 2004, 2024, 2099] {
            var civil = CivilDate(year: year, month: 1, day: 1)
            var previous = try VietnameseLunarCalendar.lunarDate(from: civil)
            let end = CivilDate(year: year, month: 12, day: 31)
            civil = civil.adding(days: 1)
            while civil <= end {
                let lunar = try VietnameseLunarCalendar.lunarDate(from: civil)
                if lunar.day == 1 {
                    #expect(previous.day == 29 || previous.day == 30)
                } else {
                    #expect(lunar.day == previous.day + 1)
                    #expect(lunar.month == previous.month)
                    #expect(lunar.isLeapMonth == previous.isLeapMonth)
                }
                previous = lunar
                civil = civil.adding(days: 1)
            }
        }
    }

    @Test func sampledRoundTripEvery17Days() throws {
        var civil = CivilDate(year: 1900, month: 1, day: 1)
        while civil.isInPublishedRange {
            let lunar = try VietnameseLunarCalendar.lunarDate(from: civil)
            #expect(try VietnameseLunarCalendar.civilDate(from: lunar) == civil)
            civil = civil.adding(days: 17)
        }
    }

    @Test func lunarMonthLengthIs29Or30() throws {
        let lunar = try VietnameseLunarCalendar.lunarDate(
            from: CivilDate(year: 2024, month: 2, day: 10)
        )
        #expect((1...30).contains(lunar.day))
        #expect((1...12).contains(lunar.month))
    }

    @Test func goldenCorpusMatchesEngine() throws {
        let file = try loadGolden()
        #expect(file.engineVersion == VietnameseLunarCalendar.ruleSetVersion)
        #expect(file.recordsChecksum == checksum(file.records))
        #expect(!file.records.isEmpty)

        var kinds = Set<String>()
        var sawTet = false
        var sawLeap = false
        var sawHistorical = false
        var sawSoc = false
        var saw1900 = false
        var saw2100 = false

        for record in file.records {
            kinds.insert(record.sourceKind)
            let civil = CivilDate(year: record.civilYear, month: record.civilMonth, day: record.civilDay)
            let lunar = try VietnameseLunarCalendar.lunarDate(from: civil)
            #expect(lunar.year == record.lunarYear)
            #expect(lunar.month == record.lunarMonth)
            #expect(lunar.day == record.lunarDay)
            #expect(lunar.isLeapMonth == record.isLeapMonth)
            #expect(record.timezone == "UTC+7")
            #expect(record.engineVersion == VietnameseLunarCalendar.ruleSetVersion)

            if record.lunarDay == 1 && record.lunarMonth == 1 && !record.isLeapMonth {
                sawTet = true
            }
            if record.isLeapMonth && record.lunarDay == 1 {
                sawLeap = true
            }
            if record.civilYear >= 1968 && record.civilYear <= 1975 {
                sawHistorical = true
            }
            if record.sourceKind.contains("soc-near-midnight") {
                sawSoc = true
            }
            if record.civilYear == 1900 { saw1900 = true }
            if record.civilYear == 2100 { saw2100 = true }
        }

        #expect(kinds.contains("published-example"))
        #expect(sawTet)
        #expect(sawLeap)
        #expect(sawHistorical)
        #expect(sawSoc)
        #expect(saw1900)
        #expect(saw2100)
    }

    @Test func publishedExamplesKeepKnownCivilDates() throws {
        let file = try loadGolden()
        let published = file.records.filter { $0.sourceKind == "published-example" }
        #expect(published.contains { $0.civilYear == 1984 && $0.civilMonth == 2 && $0.civilDay == 2 })
        #expect(published.contains { $0.civilYear == 2004 && $0.civilMonth == 3 && $0.civilDay == 21 })
        #expect(published.contains { $0.civilYear == 1983 && $0.civilMonth == 12 && $0.civilDay == 4 })
    }

    @Test func historyScopeMarks1968To1975() {
        let date = CivilDate(year: 1972, month: 4, day: 30)
        #expect(HistoricalCalendarScope.scope(for: date) == .documentedException)
        #expect(HistoricalCalendarScope.scope(for: CivilDate(year: 1976, month: 1, day: 1)) == .modern)
    }
}

private func loadGolden() throws -> GoldenFile {
    let data = try Data(contentsOf: goldenURL())
    return try JSONDecoder().decode(GoldenFile.self, from: data)
}

private func goldenURL() throws -> URL {
    #if SWIFT_PACKAGE
    if let bundled = Bundle.module.url(
        forResource: "calendar-golden",
        withExtension: "json",
        subdirectory: "Fixtures"
    ) {
        return bundled
    }
    #endif
    let nearby = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent()
        .appendingPathComponent("Fixtures/calendar-golden.json")
    guard FileManager.default.fileExists(atPath: nearby.path) else {
        throw CalendarCoreError.missingSource("calendar-golden.json")
    }
    return nearby
}

private func checksum(_ records: [GoldenRecord]) -> String {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.sortedKeys]
    let data = try! encoder.encode(records)
    let digest = SHA256.hash(data: data)
    return digest.map { String(format: "%02x", $0) }.joined()
}
