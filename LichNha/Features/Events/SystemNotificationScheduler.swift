import Foundation
import UserNotifications
import ReminderCore

final class SystemNotificationScheduler: NotificationScheduling, @unchecked Sendable {
    func authorizationStatus() async -> NotificationAuthorization {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        switch settings.authorizationStatus {
        case .authorized, .ephemeral:
            return .authorized
        case .provisional:
            return .provisional
        case .denied:
            return .denied
        case .notDetermined:
            return .notRequested
        @unknown default:
            return .notRequested
        }
    }

    func requestAuthorization() async -> NotificationAuthorization {
        _ = try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        return await authorizationStatus()
    }

    func pendingIdentifiers() async -> Set<String> {
        let requests = await UNUserNotificationCenter.current().pendingNotificationRequests()
        return Set(requests.map(\.identifier))
    }

    func add(_ notification: PlannedNotification) async throws {
        let content = UNMutableNotificationContent()
        content.title = "Lịch Nhà"
        content.body = notification.title
        content.sound = .default
        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: notification.fireAt
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        try await UNUserNotificationCenter.current().add(request)
    }

    func remove(identifiers: Set<String>) async {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: Array(identifiers))
    }
}
