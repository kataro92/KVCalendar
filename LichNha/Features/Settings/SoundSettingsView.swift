import SwiftUI
import PersonalCore

struct SoundSettingsView: View {
    @Bindable var session: AppSession

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            Text("Ứng dụng bắt đầu ở chế độ Yên và luôn tôn trọng nút im lặng, VoiceOver cùng âm thanh đang phát.")
                .font(.footnote)
                .foregroundStyle(DesignTokens.inkSecondary)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                PaperChoiceButton(title: "Yên", selected: session.preferences.ambient == .yen, identifier: "ambient-yen") {
                    session.updatePreferences { $0.ambient = .yen }
                }
                PaperChoiceButton(title: "Hiên sớm", selected: session.preferences.ambient == .hienSom, identifier: "ambient-hien-som") {
                    session.updatePreferences { $0.ambient = .hienSom }
                }
                PaperChoiceButton(title: "Mưa xa", selected: session.preferences.ambient == .muaXa, identifier: "ambient-mua-xa") {
                    session.updatePreferences { $0.ambient = .muaXa }
                }
                PaperChoiceButton(title: "Quạt trưa", selected: session.preferences.ambient == .quatTrua, identifier: "ambient-quat-trua") {
                    session.updatePreferences { $0.ambient = .quatTrua }
                }
            }
            Toggle("Âm giấy", isOn: binding(\.paperCuesEnabled))
                .lichNhaHitTarget()
                .accessibilityIdentifier("paper-cues-toggle")
            Toggle("Âm báo ngày đặc biệt", isOn: binding(\.eventCuesEnabled))
                .lichNhaHitTarget()
                .accessibilityIdentifier("event-cues-toggle")
            Button("Chuyển về Yên") {
                session.updatePreferences { $0.silenceAllAudio() }
            }
            .lichNhaHitTarget()
            .buttonStyle(PaperControlStyle())
            .accessibilityIdentifier("silence-all-audio")
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("sound-settings")
    }

    private func binding(_ keyPath: WritableKeyPath<UserPreferences, Bool>) -> Binding<Bool> {
        Binding(
            get: { session.preferences[keyPath: keyPath] },
            set: { value in
                session.updatePreferences { $0[keyPath: keyPath] = value }
            }
        )
    }
}
