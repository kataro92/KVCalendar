import SwiftUI

struct PaperControlStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.weight(.medium))
            .foregroundStyle(DesignTokens.ink)
            .padding(.horizontal, 12)
            .frame(minHeight: DesignTokens.minHitTarget)
            .background(
                Capsule()
                    .fill(DesignTokens.chipFill.opacity(configuration.isPressed ? 0.7 : 0.92))
            )
            .overlay(
                Capsule()
                    .stroke(DesignTokens.wood.opacity(0.2), lineWidth: 1)
            )
    }
}

struct DayNavigationControls: View {
    var showsToday: Bool
    var onPrevious: () -> Void
    var onToday: () -> Void
    var onNext: () -> Void

    var body: some View {
        HStack(spacing: DesignTokens.spaceSM) {
            Button("Ngày trước", action: onPrevious)
                .lichNhaHitTarget()
                .accessibilityIdentifier("previous-day")
            if showsToday {
                Button("Hôm nay", action: onToday)
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("today-button")
            }
            Button("Ngày sau", action: onNext)
                .lichNhaHitTarget()
                .accessibilityIdentifier("next-day")
        }
        .buttonStyle(PaperControlStyle())
        .frame(maxWidth: .infinity)
    }
}

struct TodayActionRow: View {
    var onDetail: () -> Void
    var onReplay: () -> Void
    var returnToMonth: (() -> Void)?

    var body: some View {
        HStack(spacing: DesignTokens.spaceSM) {
            Button("Xem chi tiết", action: onDetail)
                .lichNhaHitTarget()
                .accessibilityIdentifier("detail-button")
            Button("Phát lại", action: onReplay)
                .lichNhaHitTarget()
                .accessibilityLabel("Phát lại cảnh ngày")
                .accessibilityIdentifier("replay-scene")
            if let returnToMonth {
                Button("Quay lại tháng", action: returnToMonth)
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("back-to-month")
            }
        }
        .buttonStyle(PaperControlStyle())
    }
}

struct AmbientKeepAwakeBar: View {
    var ambientOn: Bool
    var keepAwake: Bool
    var onAmbient: (Bool) -> Void
    var onKeepAwake: (Bool) -> Void
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    var body: some View {
        HStack(spacing: 10) {
            chip {
                Toggle(isOn: Binding(get: { ambientOn }, set: onAmbient)) {
                    HStack(spacing: 6) {
                        Image(systemName: ambientOn ? "speaker.wave.2" : "speaker.slash")
                            .font(.footnote.weight(.medium))
                            .accessibilityHidden(true)
                        Text(ambientOn ? "Âm nền · Bật" : "Âm nền · Tắt")
                            .font(.system(.footnote, design: .rounded).weight(.medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                }
                .tint(DesignTokens.khanh)
                .accessibilityLabel("Âm nền")
                .accessibilityValue(ambientOn ? "Bật" : "Tắt")
                .accessibilityIdentifier("ambient-toggle")
            }
            chip {
                Toggle(isOn: Binding(get: { keepAwake }, set: onKeepAwake)) {
                    HStack(spacing: 6) {
                        Image(systemName: "sun.max")
                            .font(.footnote.weight(.medium))
                            .accessibilityHidden(true)
                        Text("Giữ sáng")
                            .font(.system(.footnote, design: .rounded).weight(.medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                }
                .tint(DesignTokens.khanh)
                .accessibilityLabel("Giữ sáng")
                .accessibilityValue(keepAwake ? "Bật" : "Tắt")
                .accessibilityIdentifier("keep-awake-toggle")
            }
        }
        .foregroundStyle(DesignTokens.chromeInk)
    }

    private func chip<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .lichNhaHitTarget()
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
            .background {
                if reduceTransparency {
                    Capsule().fill(DesignTokens.paper.opacity(0.94))
                } else {
                    Capsule().fill(.ultraThinMaterial)
                }
            }
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(reduceTransparency ? 0 : 0.45), lineWidth: 0.8)
            )
            .overlay(
                Capsule()
                    .stroke(DesignTokens.ink.opacity(0.08), lineWidth: 0.6)
            )
            .shadow(color: .black.opacity(0.07), radius: 8, y: 2)
            .clipShape(Capsule())
    }
}

struct TodayChromeHeader: View {
    var onSettings: () -> Void

    var body: some View {
        ZStack {
            Text("Lịch Nhà")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(DesignTokens.chromeInk)
                .accessibilityAddTraits(.isHeader)
            HStack {
                Spacer()
                Button(action: onSettings) {
                    Image(systemName: "gearshape")
                        .font(.body.weight(.light))
                        .foregroundStyle(DesignTokens.chromeInk)
                        .frame(width: DesignTokens.minHitTarget, height: DesignTokens.minHitTarget)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Cài đặt")
                .accessibilityIdentifier("settings-button")
            }
        }
        .padding(.horizontal, 10)
    }
}

struct FamilyClipButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "paperclip")
                .font(.body.weight(.medium))
                .foregroundStyle(DesignTokens.wood)
                .rotationEffect(.degrees(38))
                .frame(width: DesignTokens.minHitTarget, height: DesignTokens.minHitTarget)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Ngày gia đình")
        .accessibilityIdentifier("events-button")
    }
}
