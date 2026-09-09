import SwiftUI
import ReminderCore

struct EventReminderStatusView: View {
    var saved: Bool
    var reminderEnabled: Bool
    var permission: NotificationAuthorization
    var eventStatus: ReminderEventStatus?

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            Text(savedText)
                .font(.headline)
                .accessibilityIdentifier("event-saved-status")
            Text(reminderText)
                .font(.subheadline)
                .foregroundStyle(DesignTokens.inkSecondary)
                .accessibilityIdentifier("reminder-status")
        }
        .padding(DesignTokens.spaceSM)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignTokens.jade.opacity(0.4), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .accessibilityElement(children: .contain)
    }

    private var savedText: String {
        saved ? "Đã lưu trên máy này." : "Chưa lưu."
    }

    private var reminderText: String {
        if !saved {
            return "Chưa có lời nhắc."
        }
        if !reminderEnabled {
            return "Không bật nhắc."
        }
        if eventStatus == .permissionDenied || permission == .denied {
            return "Chưa bật nhắc. Quyền thông báo bị từ chối; sự kiện vẫn còn."
        }
        if permission == .authorized || permission == .provisional || eventStatus == .remindersActive {
            return "Đã bật nhắc."
        }
        return "Đã lưu. Chưa xin quyền thông báo."
    }
}
