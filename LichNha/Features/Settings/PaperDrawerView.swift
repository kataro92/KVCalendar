import SwiftUI
import PersonalCore

struct PaperDrawerView: View {
    @Bindable var session: AppSession

    var body: some View {
        CalendarMountView(headerTitle: "CÀI ĐẶT") {
            ScrollView {
                MountedPaperPage {
                    Text("Chỉnh Lịch Nhà theo nhịp của bạn")
                        .font(.system(.title3, design: .rounded).weight(.bold))
                        .foregroundStyle(DesignTokens.ink)
                        .accessibilityIdentifier("settings-title")
                    PaperSection(title: "Cảnh ngày", symbol: "sparkles") {
                        EffectSettingsView(session: session)
                    }
                    PaperSection(title: "Âm thanh", symbol: "speaker.wave.2") {
                        SoundSettingsView(session: session)
                    }
                    PaperSection(title: "Vùng cảm hứng", symbol: "map") {
                        InspirationRegionView(session: session)
                    }
                    PaperSection(title: "Riêng tư và giờ", symbol: "hand.raised") {
                        PrivacyAndTimeSettingsView(session: session)
                    }
                    PaperSection(title: "Lịch truyền thống", symbol: "scroll") {
                        Toggle("Hiện trên mặt sau tờ lịch", isOn: Binding(
                            get: { session.almanacVisible },
                            set: { session.setAlmanacVisible($0) }
                        ))
                        .lichNhaHitTarget()
                        .tint(DesignTokens.son)
                        .accessibilityIdentifier("almanac-toggle")
                    }
                    PaperSection(title: "Phiên bản và báo sai", symbol: "info.circle") {
                        VersionAndCorrectionView(session: session)
                    }
                    Button("Đóng cài đặt") { session.closeSettings() }
                        .lichNhaHitTarget()
                        .buttonStyle(PaperControlStyle())
                        .accessibilityIdentifier("close-settings")
                }
                .padding(.top, 6)
                .padding(.bottom, 24)
            }
        }
        .accessibilityIdentifier("paper-drawer")
    }
}
