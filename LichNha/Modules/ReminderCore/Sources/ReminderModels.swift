import Foundation
import CalendarCore
import PersonalCore

public struct ReminderOccurrence: Hashable, Sendable, Codable, Identifiable {
    public var id: String
    public var eventID: String
    public var targetCivilDate: CivilDate
    public var deliveryDateTime: Date
    public var status: ReminderStatus
    public var sourceRuleVersion: String
    public var timeAdjustment: TimeAdjustment
    public var systemIdentifier: String?

    public init(
        id: String,
        eventID: String,
        targetCivilDate: CivilDate,
        deliveryDateTime: Date,
        status: ReminderStatus,
        sourceRuleVersion: String,
        timeAdjustment: TimeAdjustment = .none,
        systemIdentifier: String? = nil
    ) {
        self.id = id
        self.eventID = eventID
        self.targetCivilDate = targetCivilDate
        self.deliveryDateTime = deliveryDateTime
        self.status = status
        self.sourceRuleVersion = sourceRuleVersion
        self.timeAdjustment = timeAdjustment
        self.systemIdentifier = systemIdentifier
    }
}

public enum ReminderStatus: String, Hashable, Sendable, Codable {
    case planned
    case scheduled
    case delivered
    case cancelled
    case failed
    case stale
}

public enum TimeAdjustment: String, Hashable, Sendable, Codable {
    case none
    case dstGapNextValid
    case dstOverlapEarlier
}

public enum ReminderEventStatus: String, Hashable, Sendable, Codable {
    case saved
    case remindersActive
    case permissionDenied
    case needsRefresh
    case planningError
}

public enum NotificationAuthorization: String, Hashable, Sendable, Codable {
    case notRequested
    case authorized
    case denied
    case provisional
}

public struct ReminderPlan: Hashable, Sendable {
    public var occurrences: [ReminderOccurrence]
    public var eventStatus: ReminderEventStatus
    public var policySummary: String

    public init(
        occurrences: [ReminderOccurrence],
        eventStatus: ReminderEventStatus,
        policySummary: String
    ) {
        self.occurrences = occurrences
        self.eventStatus = eventStatus
        self.policySummary = policySummary
    }
}

public enum RefreshReason: String, Hashable, Sendable {
    case appActive
    case dayChange
    case timeZoneChange
    case permissionChange
    case engineVersionChange
}
