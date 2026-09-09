import Foundation
import SwiftData
import CalendarCore

public enum PersonalSchemaV1: VersionedSchema {
    public static var versionIdentifier: Schema.Version { Schema.Version(1, 0, 0) }
    public static var models: [any PersistentModel.Type] { [PersonalEventRecord.self] }
}

public enum PersonalSchema {
    public static let version = 1
    public static let appGroupID = "group.vn.lichnha.app"

    public static func makeContainer() throws -> ModelContainer {
        let configuration = ModelConfiguration(
            "LichNhaPersonalEvents",
            schema: Schema(versionedSchema: PersonalSchemaV1.self),
            groupContainer: .identifier(appGroupID)
        )
        return try ModelContainer(
            for: Schema(versionedSchema: PersonalSchemaV1.self),
            migrationPlan: PersonalSchemaMigration.self,
            configurations: configuration
        )
    }

    public static func applicationSupportStoreURL() -> URL {
        let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("LichNhaPersonal", isDirectory: true)
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        return directory.appendingPathComponent("events.store")
    }

    public static func makeApplicationSupportContainer(reset: Bool = false) throws -> ModelContainer {
        let url = applicationSupportStoreURL()
        if reset {
            let directory = url.deletingLastPathComponent()
            try? FileManager.default.removeItem(at: directory)
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        }
        let configuration = ModelConfiguration(
            schema: Schema(versionedSchema: PersonalSchemaV1.self),
            url: url
        )
        return try ModelContainer(
            for: Schema(versionedSchema: PersonalSchemaV1.self),
            migrationPlan: PersonalSchemaMigration.self,
            configurations: configuration
        )
    }

    public static func makeInMemoryContainer() throws -> ModelContainer {
        let configuration = ModelConfiguration(
            schema: Schema(versionedSchema: PersonalSchemaV1.self),
            isStoredInMemoryOnly: true
        )
        return try ModelContainer(
            for: Schema(versionedSchema: PersonalSchemaV1.self),
            migrationPlan: PersonalSchemaMigration.self,
            configurations: configuration
        )
    }
}

@Model
public final class PersonalEventRecord {
    @Attribute(.unique) public var id: String
    public var title: String
    public var notes: String?
    public var calendarBasisRaw: String
    public var originYear: Int
    public var originMonth: Int
    public var originDay: Int
    public var originIsLeapMonth: Bool
    public var recurrenceRaw: String
    public var leapMonthPolicyRaw: String
    public var shortMonthPolicyRaw: String
    public var reminderEnabled: Bool
    public var reminderLeadDays: Int
    public var reminderHour: Int
    public var reminderMinute: Int
    public var deliveryZoneRaw: String
    public var dstPolicyRaw: String
    public var widgetPrivacyRaw: String
    public var createdAt: Date
    public var updatedAt: Date
    public var schemaVersion: Int

    public init(
        id: String,
        title: String,
        notes: String? = nil,
        calendarBasis: EventCalendarBasis,
        originYear: Int,
        originMonth: Int,
        originDay: Int,
        originIsLeapMonth: Bool = false,
        recurrence: Recurrence,
        leapMonthPolicy: LeapMonthPolicy,
        shortMonthPolicy: ShortMonthPolicy,
        reminderEnabled: Bool,
        reminderLeadDays: Int = 3,
        reminderHour: Int = 8,
        reminderMinute: Int = 0,
        deliveryZoneRaw: String = TimeZoneIdentifier.vietnam.rawValue,
        dstPolicyRaw: String = DSTResolutionPolicy.gapNextValidOverlapEarlier.rawValue,
        widgetPrivacyRaw: String = WidgetPrivacy.hidden.rawValue,
        createdAt: Date = Date(timeIntervalSince1970: 0),
        updatedAt: Date = Date(timeIntervalSince1970: 0)
    ) {
        self.id = id
        self.title = title
        self.notes = notes
        self.calendarBasisRaw = calendarBasis.rawValue
        self.originYear = originYear
        self.originMonth = originMonth
        self.originDay = originDay
        self.originIsLeapMonth = originIsLeapMonth
        self.recurrenceRaw = recurrence.rawValue
        self.leapMonthPolicyRaw = leapMonthPolicy.rawValue
        self.shortMonthPolicyRaw = shortMonthPolicy.rawValue
        self.reminderEnabled = reminderEnabled
        self.reminderLeadDays = reminderLeadDays
        self.reminderHour = reminderHour
        self.reminderMinute = reminderMinute
        self.deliveryZoneRaw = deliveryZoneRaw
        self.dstPolicyRaw = dstPolicyRaw
        self.widgetPrivacyRaw = widgetPrivacyRaw
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.schemaVersion = PersonalSchema.version
    }

    public convenience init(event: PersonalEvent) {
        let originYear: Int
        let originMonth: Int
        let originDay: Int
        let originIsLeap: Bool
        switch event.calendarBasis {
        case .lunar:
            let lunar = event.originLunarDate
            originYear = lunar?.year ?? 2024
            originMonth = lunar?.month ?? 1
            originDay = lunar?.day ?? 1
            originIsLeap = lunar?.isLeapMonth ?? false
        case .solar:
            let civil = event.originCivilDate
            originYear = civil?.year ?? 2024
            originMonth = civil?.month ?? 1
            originDay = civil?.day ?? 1
            originIsLeap = false
        }
        self.init(
            id: event.id,
            title: event.title,
            notes: event.notes,
            calendarBasis: event.calendarBasis,
            originYear: originYear,
            originMonth: originMonth,
            originDay: originDay,
            originIsLeapMonth: originIsLeap,
            recurrence: event.recurrence,
            leapMonthPolicy: event.leapMonthPolicy,
            shortMonthPolicy: event.shortMonthPolicy,
            reminderEnabled: event.reminderPolicy.enabled,
            reminderLeadDays: event.reminderPolicy.leadDays,
            reminderHour: event.reminderPolicy.hour,
            reminderMinute: event.reminderPolicy.minute,
            deliveryZoneRaw: event.deliveryZone.rawValue,
            dstPolicyRaw: event.dstResolutionPolicy.rawValue,
            widgetPrivacyRaw: event.widgetPrivacy.rawValue,
            createdAt: event.createdAt,
            updatedAt: event.updatedAt
        )
    }

    public func apply(_ event: PersonalEvent) {
        title = event.title
        notes = event.notes
        calendarBasisRaw = event.calendarBasis.rawValue
        switch event.calendarBasis {
        case .lunar:
            originYear = event.originLunarDate?.year ?? originYear
            originMonth = event.originLunarDate?.month ?? originMonth
            originDay = event.originLunarDate?.day ?? originDay
            originIsLeapMonth = event.originLunarDate?.isLeapMonth ?? false
        case .solar:
            originYear = event.originCivilDate?.year ?? originYear
            originMonth = event.originCivilDate?.month ?? originMonth
            originDay = event.originCivilDate?.day ?? originDay
            originIsLeapMonth = false
        }
        recurrenceRaw = event.recurrence.rawValue
        leapMonthPolicyRaw = event.leapMonthPolicy.rawValue
        shortMonthPolicyRaw = event.shortMonthPolicy.rawValue
        reminderEnabled = event.reminderPolicy.enabled
        reminderLeadDays = event.reminderPolicy.leadDays
        reminderHour = event.reminderPolicy.hour
        reminderMinute = event.reminderPolicy.minute
        deliveryZoneRaw = event.deliveryZone.rawValue
        dstPolicyRaw = event.dstResolutionPolicy.rawValue
        widgetPrivacyRaw = event.widgetPrivacy.rawValue
        updatedAt = event.updatedAt
        schemaVersion = PersonalSchema.version
    }

    public func asPersonalEvent() -> PersonalEvent {
        let basis = EventCalendarBasis(rawValue: calendarBasisRaw) ?? .lunar
        let lunar = LunarDate(
            day: originDay,
            month: originMonth,
            year: originYear,
            isLeapMonth: originIsLeapMonth,
            ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
        )
        let civil = CivilDate(year: originYear, month: originMonth, day: originDay)
        return PersonalEvent(
            id: id,
            title: title,
            notes: notes,
            calendarBasis: basis,
            originCivilDate: basis == .solar ? civil : nil,
            originLunarDate: basis == .lunar ? lunar : nil,
            recurrence: Recurrence(rawValue: recurrenceRaw) ?? .yearly,
            leapMonthPolicy: LeapMonthPolicy(rawValue: leapMonthPolicyRaw) ?? .regularMonth,
            shortMonthPolicy: ShortMonthPolicy(rawValue: shortMonthPolicyRaw) ?? .lastDayOfMonth,
            reminderPolicy: ReminderPolicy(
                enabled: reminderEnabled,
                leadDays: reminderLeadDays,
                hour: reminderHour,
                minute: reminderMinute
            ),
            calculationZone: .vietnam,
            deliveryZone: TimeZoneIdentifier(deliveryZoneRaw),
            dstResolutionPolicy: DSTResolutionPolicy(rawValue: dstPolicyRaw) ?? .gapNextValidOverlapEarlier,
            widgetPrivacy: WidgetPrivacy(rawValue: widgetPrivacyRaw) ?? .hidden,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}

/// Version 1 is the first App Group store. Later versions must keep id, title and origin fields.
public enum PersonalSchemaMigration: SchemaMigrationPlan {
    public static var schemas: [any VersionedSchema.Type] { [PersonalSchemaV1.self] }
    public static var stages: [MigrationStage] { [] }
}

public enum PersonalMigrationPlan {
    public static let current = PersonalSchema.version
}
