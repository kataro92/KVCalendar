import Foundation
import SwiftData
import Testing
import PersonalCore
import CalendarCore

struct PersonalMigrationTests {
    @Test func schemaVersionIsOne() {
        #expect(PersonalSchema.version == 1)
        #expect(PersonalSchema.appGroupID == "group.vn.lichnha.app")
        #expect(PersonalMigrationPlan.current == 1)
        #expect(PersonalSchemaMigration.schemas.count == 1)
        #expect(PersonalSchemaMigration.stages.isEmpty)
    }

    @Test func inMemoryStoreRoundTripsOriginFields() throws {
        let container = try PersonalSchema.makeInMemoryContainer()
        let context = ModelContext(container)
        let record = PersonalEventRecord(
            id: "gio-to-sample",
            title: "Giỗ",
            notes: "không đưa ra log",
            calendarBasis: .lunar,
            originYear: 2024,
            originMonth: 8,
            originDay: 12,
            originIsLeapMonth: false,
            recurrence: .yearly,
            leapMonthPolicy: .regularMonth,
            shortMonthPolicy: .lastDayOfMonth,
            reminderEnabled: true
        )
        context.insert(record)
        try context.save()

        let found = try context.fetch(FetchDescriptor<PersonalEventRecord>())
        #expect(found.count == 1)
        #expect(found[0].id == "gio-to-sample")
        #expect(found[0].originYear == 2024)
        #expect(found[0].originMonth == 8)
        #expect(found[0].originDay == 12)
        #expect(found[0].schemaVersion == 1)
        #expect(found[0].asPersonalEvent().leapMonthPolicy == .regularMonth)
        #expect(found[0].asPersonalEvent().reminderPolicy.hour == 8)
    }

    @Test @MainActor func repositoryPreservesPolicyAcrossUpsert() throws {
        let repository = PersonalEventRepository(container: try PersonalSchema.makeInMemoryContainer())
        var event = PersonalEvent(
            id: "policy-keep",
            title: "Ngày giỗ mẫu",
            notes: "ghi chú riêng",
            calendarBasis: .lunar,
            originLunarDate: LunarDate(
                day: 12,
                month: 8,
                year: 2024,
                isLeapMonth: false,
                ruleSetVersion: "lich-nha-cal-1"
            ),
            recurrence: .yearly,
            leapMonthPolicy: .both,
            shortMonthPolicy: .firstOfNext,
            reminderPolicy: ReminderPolicy(enabled: true, leadDays: 3, hour: 8, minute: 0),
            deliveryZone: TimeZoneIdentifier("America/New_York")
        )
        try repository.upsert(event)
        event.leapMonthPolicy = .substitute
        event.updatedAt = Date(timeIntervalSince1970: 10)
        try repository.upsert(event)
        let loaded = try #require(try repository.event(id: "policy-keep"))
        #expect(loaded.leapMonthPolicy == .substitute)
        #expect(loaded.shortMonthPolicy == .firstOfNext)
        #expect(loaded.reminderPolicy.leadDays == 3)
        #expect(loaded.deliveryZone.rawValue == "America/New_York")
        #expect(loaded.title == "Ngày giỗ mẫu")
        try repository.delete(id: "policy-keep")
        #expect(try repository.event(id: "policy-keep") == nil)
    }
}
