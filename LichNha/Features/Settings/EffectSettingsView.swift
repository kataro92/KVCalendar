import SwiftUI
import PersonalCore

struct EffectSettingsView: View {
    @Bindable var session: AppSession

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            Text("Máy sẽ tự giảm hiệu ứng khi bạn bật Giảm chuyển động, Giảm đèn nhấp nháy hoặc Chế độ nguồn điện thấp.")
                .font(.footnote)
                .foregroundStyle(DesignTokens.inkSecondary)
            HStack {
                PaperChoiceButton(title: "Sống động", selected: session.preferences.motion == .vivid, identifier: "effect-vivid") {
                    session.updatePreferences { $0.motion = .vivid }
                }
                PaperChoiceButton(title: "Êm", selected: session.preferences.motion == .gentle, identifier: "effect-gentle") {
                    session.updatePreferences { $0.motion = .gentle }
                }
                PaperChoiceButton(title: "Tĩnh", selected: session.preferences.motion == .still, identifier: "effect-still") {
                    session.updatePreferences { $0.motion = .still }
                }
            }
            Button("Phát lại cảnh ngày") {
                session.pendingReplay = true
                session.closeSettings()
            }
            .lichNhaHitTarget()
            .buttonStyle(PaperControlStyle())
            .accessibilityIdentifier("settings-replay-scene")
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("effect-settings")
    }
}
