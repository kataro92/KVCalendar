import SwiftUI
import PersonalCore

struct EffectSettingsView: View {
    @Bindable var session: AppSession

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            Text("Cảnh ngày")
                .font(.headline)
            Text("Giảm chuyển động, làm mờ đèn nhấp nháy, chế độ nguồn điện thấp và nhiệt máy được ưu tiên hơn lựa chọn này. Lựa chọn vẫn được nhớ.")
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
            .buttonStyle(.bordered)
            .tint(DesignTokens.wood)
            .accessibilityIdentifier("settings-replay-scene")
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("effect-settings")
    }
}
