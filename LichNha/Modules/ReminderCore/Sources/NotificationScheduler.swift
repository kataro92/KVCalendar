import Foundation
import PersonalCore

public struct PlannedNotification: Hashable, Sendable {
    public var id: String
    public var fireAt: Date
    public var eventID: String
    public var title: String

    public init(id: String, fireAt: Date, eventID: String, title: String = "Ngày gia đình") {
        self.id = id
        self.fireAt = fireAt
        self.eventID = eventID
        self.title = title
    }
}

public protocol NotificationScheduling: AnyObject, Sendable {
    func authorizationStatus() async -> NotificationAuthorization
    func requestAuthorization() async -> NotificationAuthorization
    func pendingIdentifiers() async -> Set<String>
    func add(_ notification: PlannedNotification) async throws
    func remove(identifiers: Set<String>) async
}

public actor InMemoryNotificationScheduler: NotificationScheduling {
    public var authorization: NotificationAuthorization
    public private(set) var pending: [String: PlannedNotification] = [:]

    public init(authorization: NotificationAuthorization = .denied) {
        self.authorization = authorization
    }

    public func setAuthorization(_ value: NotificationAuthorization) {
        authorization = value
    }

    public func authorizationStatus() async -> NotificationAuthorization { authorization }

    public func requestAuthorization() async -> NotificationAuthorization { authorization }

    public func pendingIdentifiers() async -> Set<String> { Set(pending.keys) }

    public func add(_ notification: PlannedNotification) async throws {
        pending[notification.id] = notification
    }

    public func remove(identifiers: Set<String>) async {
        for id in identifiers {
            pending.removeValue(forKey: id)
        }
    }
}

public enum NotificationScheduler {
    public static let maxPending = 60

    public static func bounded(_ occurrences: [ReminderOccurrence], now: Date = Date()) -> [ReminderOccurrence] {
        occurrences
            .filter { $0.status != .failed && $0.deliveryDateTime >= now }
            .sorted { $0.deliveryDateTime < $1.deliveryDateTime }
            .prefix(maxPending)
            .map { $0 }
    }

    public static func replace(
        _ occurrences: [ReminderOccurrence],
        on store: some NotificationScheduling,
        permission: NotificationAuthorization,
        now: Date = Date(),
        titles: [String: String] = [:]
    ) async throws -> [ReminderOccurrence] {
        let previous = await store.pendingIdentifiers()
        guard permission == .authorized || permission == .provisional else {
            await store.remove(identifiers: previous)
            return occurrences.map {
                var copy = $0
                copy.status = $0.status == .failed ? .failed : .planned
                copy.systemIdentifier = nil
                return copy
            }
        }
        let selected = bounded(occurrences, now: now)
        let nextIDs = Set(selected.map(\.id))
        await store.remove(identifiers: previous.subtracting(nextIDs))
        var scheduled: [ReminderOccurrence] = []
        for item in selected {
            try await store.add(
                PlannedNotification(
                    id: item.id,
                    fireAt: item.deliveryDateTime,
                    eventID: item.eventID,
                    title: titles[item.eventID] ?? "Ngày gia đình"
                )
            )
            var copy = item
            copy.status = .scheduled
            copy.systemIdentifier = item.id
            scheduled.append(copy)
        }
        return scheduled
    }
}
