import SwiftUI
import PersonalCore

struct PaperDrawerView: View {
    @Bindable var session: AppSession

    var body: some View {
        CalendarMountView {
            ScrollView {
                VStack(alignment: .leading, spacing: DesignTokens.spaceLG) {
                    Text("Cài đặt")
                        .font(.title2.weight(.semibold))
                        .accessibilityIdentifier("settings-title")
                    EffectSettingsView(session: session)
                    SoundSettingsView(session: session)
                    InspirationRegionView(session: session)
                    PrivacyAndTimeSettingsView(session: session)
                    Toggle("Hiện lớp lịch truyền thống", isOn: Binding(
                        get: { session.almanacVisible },
                        set: { session.setAlmanacVisible($0) }
                    ))
                    .lichNhaHitTarget()
                    .tint(DesignTokens.wood)
                    .accessibilityIdentifier("almanac-toggle")
                    VersionAndCorrectionView(session: session)
                    Button("Đóng cài đặt") { session.closeSettings() }
                        .lichNhaHitTarget()
                        .buttonStyle(PaperControlStyle())
                        .accessibilityIdentifier("close-settings")
                }
                .padding(.bottom, 24)
            }
        }
        .accessibilityIdentifier("paper-drawer")
    }
}
