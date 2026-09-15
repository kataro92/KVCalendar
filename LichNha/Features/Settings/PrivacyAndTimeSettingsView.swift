import SwiftUI
import CalendarCore
import PersonalCore

struct PrivacyAndTimeSettingsView: View {
    @Bindable var session: AppSession

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            Text("Ngày âm luôn theo lịch Việt UTC+7. Đổi múi giờ máy không sửa một ngày đã mở.")
                .font(.footnote)
                .foregroundStyle(DesignTokens.inkSecondary)
            Text("Widget mặc định")
                .font(.subheadline.weight(.semibold))
            PaperChoiceButton(title: "Ẩn sự kiện riêng", selected: session.preferences.widgetPrivacy == .hidden, identifier: "privacy-hidden") {
                session.updatePreferences { $0.widgetPrivacy = .hidden }
            }
            PaperChoiceButton(title: "Chỉ hiện “Ngày gia đình”", selected: session.preferences.widgetPrivacy == .genericMarker, identifier: "privacy-generic") {
                session.updatePreferences { $0.widgetPrivacy = .genericMarker }
            }
            PaperChoiceButton(title: "Hiện tên công khai", selected: session.preferences.widgetPrivacy == .publicTitle, identifier: "privacy-public") {
                session.updatePreferences { $0.widgetPrivacy = .publicTitle }
            }
            Text("Giờ nhắc")
                .font(.subheadline.weight(.semibold))
            PaperChoiceButton(
                title: "Việt Nam (UTC+7)",
                selected: session.preferences.deliveryZoneRaw == TimeZoneIdentifier.vietnam.rawValue,
                identifier: "delivery-vietnam"
            ) {
                session.updatePreferences { $0.deliveryZoneRaw = TimeZoneIdentifier.vietnam.rawValue }
            }
            PaperChoiceButton(
                title: "Theo giờ máy",
                selected: session.preferences.deliveryZoneRaw != TimeZoneIdentifier.vietnam.rawValue,
                identifier: "delivery-device"
            ) {
                session.updatePreferences {
                    $0.deliveryZoneRaw = TimeZone.current.identifier
                }
            }
            Text("Nhịp Việt Nam: quy tắc âm lịch khóa UTC+7, không theo GPS.")
                .font(.footnote)
                .foregroundStyle(DesignTokens.inkSecondary)
                .accessibilityIdentifier("vietnam-rhythm-note")
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("privacy-time-settings")
    }
}
