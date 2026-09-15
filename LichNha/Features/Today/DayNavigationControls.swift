import SwiftUI

struct PaperControlStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.subheadline, design: .rounded).weight(.semibold))
            .foregroundStyle(DesignTokens.ink)
            .padding(.horizontal, 13)
            .frame(minHeight: DesignTokens.minHitTarget)
            .background(
                Capsule()
                    .fill(DesignTokens.paper.opacity(configuration.isPressed ? 0.72 : 0.96))
            )
            .overlay(
                Capsule()
                    .stroke(DesignTokens.wood.opacity(0.22), lineWidth: 0.8)
            )
            .shadow(color: .black.opacity(0.05), radius: 3, y: 1)
    }
}

struct PaperPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.body, design: .rounded).weight(.bold))
            .foregroundStyle(DesignTokens.paper)
            .frame(maxWidth: .infinity, minHeight: DesignTokens.minHitTarget)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(DesignTokens.son.opacity(configuration.isPressed ? 0.78 : 1))
            )
            .overlay(alignment: .top) {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.white.opacity(0.18), lineWidth: 1)
            }
            .shadow(color: DesignTokens.sonDeep.opacity(0.22), radius: 7, y: 4)
    }
}

struct PaperStepperButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.weight(.semibold))
            .foregroundStyle(DesignTokens.ink)
            .frame(width: DesignTokens.minHitTarget, height: DesignTokens.minHitTarget)
            .background(
                Circle().fill(DesignTokens.paper.opacity(configuration.isPressed ? 0.65 : 0.96))
            )
            .overlay(Circle().stroke(DesignTokens.wood.opacity(0.16), lineWidth: 0.8))
    }
}

struct DayNavigationControls: View {
    var showsToday: Bool
    var onPrevious: () -> Void
    var onToday: () -> Void
    var onNext: () -> Void

    var body: some View {
        HStack(spacing: DesignTokens.spaceSM) {
            Button(action: onPrevious) {
                Image(systemName: "chevron.left")
                    .frame(width: 20)
            }
                .lichNhaHitTarget()
                .accessibilityLabel("Ngày trước")
                .accessibilityIdentifier("previous-day")
            if showsToday {
                Button("Hôm nay", action: onToday)
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("today-button")
            }
            Button(action: onNext) {
                Image(systemName: "chevron.right")
                    .frame(width: 20)
            }
                .lichNhaHitTarget()
                .accessibilityLabel("Ngày sau")
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
            Button(action: onDetail) {
                Image(systemName: "text.justify.left")
                    .frame(width: 20)
            }
                .lichNhaHitTarget()
                .accessibilityLabel("Xem chi tiết")
                .accessibilityIdentifier("detail-button")
            Button(action: onReplay) {
                Image(systemName: "sparkles")
                    .frame(width: 20)
            }
                .lichNhaHitTarget()
                .accessibilityLabel("Phát lại cảnh ngày")
                .accessibilityIdentifier("replay-scene")
            if let returnToMonth {
                Button(action: returnToMonth) {
                    Image(systemName: "calendar")
                        .frame(width: 20)
                }
                    .lichNhaHitTarget()
                    .accessibilityLabel("Quay lại tháng")
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
        HStack(spacing: 8) {
            compactToggle(isOn: ambientOn) {
                Toggle(isOn: Binding(get: { ambientOn }, set: onAmbient)) {
                    HStack(spacing: 6) {
                        Image(systemName: ambientOn ? "speaker.wave.2" : "speaker.slash")
                            .font(.footnote.weight(.medium))
                            .accessibilityHidden(true)
                        Text(ambientOn ? "Âm nền" : "Yên")
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
            compactToggle(isOn: keepAwake) {
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
        .padding(5)
        .foregroundStyle(DesignTokens.chromeInk.opacity(0.86))
        .frame(maxWidth: .infinity)
        .background(DesignTokens.paper.opacity(reduceTransparency ? 0.96 : 0.74), in: Capsule())
        .overlay(Capsule().stroke(DesignTokens.wood.opacity(0.13), lineWidth: 0.7))
        .shadow(color: .black.opacity(reduceTransparency ? 0 : 0.06), radius: 8, y: 3)
    }

    private func compactToggle<Content: View>(
        isOn: Bool,
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .toggleStyle(.button)
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, minHeight: DesignTokens.minHitTarget)
            .padding(.horizontal, 8)
            .background(
                Capsule()
                    .fill(isOn ? DesignTokens.peach.opacity(0.72) : Color.clear)
            )
            .overlay {
                if isOn {
                    Capsule().stroke(DesignTokens.son.opacity(0.16), lineWidth: 0.7)
                }
            }
            .opacity(reduceTransparency ? 1 : 0.92)
    }
}

struct HomeActionDock: View {
    var onPrevious: () -> Void
    var onDetail: () -> Void
    var onExpand: () -> Void
    var onReplay: () -> Void
    var onNext: () -> Void

    var body: some View {
        HStack(spacing: 2) {
            dockButton("chevron.left", label: "Ngày trước", identifier: "previous-day", action: onPrevious)
            dockButton("text.justify.left", label: "Xem chi tiết", identifier: "detail-button", action: onDetail)
            dockButton("ellipsis", label: "Hiện thêm thao tác", identifier: "reveal-tools", action: onExpand)
            dockButton("sparkles", label: "Phát lại cảnh ngày", identifier: "replay-scene", action: onReplay)
            dockButton("chevron.right", label: "Ngày sau", identifier: "next-day", action: onNext)
        }
        .padding(5)
        .background(DesignTokens.paper.opacity(0.94), in: Capsule())
        .overlay(Capsule().stroke(DesignTokens.wood.opacity(0.17), lineWidth: 0.8))
        .shadow(color: .black.opacity(0.08), radius: 9, y: 4)
    }

    private func dockButton(
        _ systemName: String,
        label: String,
        identifier: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.subheadline.weight(systemName == "ellipsis" ? .bold : .medium))
                .foregroundStyle(systemName == "sparkles" ? DesignTokens.son : DesignTokens.ink)
                .frame(width: DesignTokens.minHitTarget, height: DesignTokens.minHitTarget)
                .background(
                    Circle().fill(systemName == "ellipsis" ? DesignTokens.peach.opacity(0.46) : Color.clear)
                )
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
        .accessibilityIdentifier(identifier)
    }
}

struct TodayChromeHeader: View {
    var onSettings: () -> Void

    var body: some View {
        ZStack {
            Text("Lịch Nhà")
                .font(.system(size: 19, weight: .bold, design: .rounded))
                .foregroundStyle(DesignTokens.chromeInk)
                .tracking(0.6)
                .accessibilityAddTraits(.isHeader)
            HStack {
                Spacer()
                Button(action: onSettings) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.body.weight(.medium))
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
        .overlay(alignment: .bottom) {
            Capsule()
                .fill(DesignTokens.son.opacity(0.52))
                .frame(width: 26, height: 2)
                .offset(y: 2)
                .accessibilityHidden(true)
        }
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
