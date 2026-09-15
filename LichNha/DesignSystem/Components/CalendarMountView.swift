import SwiftUI

struct CalendarMountView<Backdrop: View, Content: View>: View {
    var backdrop: Backdrop
    var compact: Bool
    var headerTitle: String?
    var headerAction: (() -> Void)?
    var headerIdentifier: String?
    @ViewBuilder var content: () -> Content

    init(
        compact: Bool = false,
        headerTitle: String? = nil,
        headerAction: (() -> Void)? = nil,
        headerIdentifier: String? = nil,
        @ViewBuilder backdrop: () -> Backdrop,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backdrop = backdrop()
        self.compact = compact
        self.headerTitle = headerTitle
        self.headerAction = headerAction
        self.headerIdentifier = headerIdentifier
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .top) {
            WallPlasterView()
            backdrop
                .allowsHitTesting(false)
            VStack(spacing: 0) {
                BlocHeaderView(
                    title: headerTitle,
                    action: headerAction,
                    identifier: headerIdentifier
                )
                .padding(.horizontal, compact ? 0 : 18)
                content()
                    .padding(.horizontal, compact ? 0 : 16)
                    .padding(.bottom, 16)
            }
            .padding(.horizontal, compact ? 0 : 0)
            .padding(.top, compact ? 0 : 12)
            .safeAreaPadding(.top)
            .frame(maxWidth: compact ? .infinity : .infinity)
        }
    }
}

extension CalendarMountView where Backdrop == Color {
    init(
        compact: Bool = false,
        headerTitle: String? = nil,
        headerAction: (() -> Void)? = nil,
        headerIdentifier: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            compact: compact,
            headerTitle: headerTitle,
            headerAction: headerAction,
            headerIdentifier: headerIdentifier,
            backdrop: { Color.clear },
            content: content
        )
    }
}

struct BlocHeaderView: View {
    var title: String?
    var action: (() -> Void)?
    var identifier: String?
    var fill: Color = DesignTokens.wood
    var motionActive: Bool = false
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        let textured = PaperLegibility.showsTexture(
            reduceTransparency: reduceTransparency,
            increasedContrast: colorSchemeContrast == .increased,
            boldText: false
        )
        let khanh = VStack(spacing: 0) {
            ZStack {
                HangingCordMotion(active: motionActive && !reduceMotion)
                KhanhArch()
                    .fill(fill)
                if textured {
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.22),
                            Color.clear,
                            Color.black.opacity(0.28),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(KhanhArch())
                    WoodGrain()
                        .opacity(0.55)
                        .clipShape(KhanhArch())
                }
                HStack {
                    BrassRivet()
                    Spacer()
                    if let title {
                        HStack(spacing: 6) {
                            Text(title)
                                .font(.system(.subheadline, design: .rounded).weight(.bold))
                                .foregroundStyle(DesignTokens.paper)
                                .tracking(0.3)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                            if action != nil {
                                Image(systemName: "chevron.down")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(DesignTokens.paper.opacity(0.85))
                                    .accessibilityHidden(true)
                            }
                        }
                    }
                    Spacer()
                    BrassRivet()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 2)
                Circle()
                    .fill(DesignTokens.bronzeDeep.opacity(0.38))
                    .frame(width: 8, height: 8)
                    .overlay(Circle().stroke(DesignTokens.bronzeLight.opacity(0.65), lineWidth: 1))
                    .offset(y: -24)
                    .accessibilityHidden(true)
            }
            .frame(height: DesignTokens.headerHeight)
            WoodRailStrip(textured: textured)
                .frame(height: DesignTokens.headerRail)
                .padding(.horizontal, 5)
                .offset(y: -1)
        }
        .compositingGroup()
        .shadow(color: .black.opacity(textured ? 0.28 : 0.12), radius: textured ? 10 : 0, y: textured ? 5 : 0)

        Group {
            if let action {
                Button(action: action) {
                    khanh
                }
                .buttonStyle(.plain)
                .lichNhaHitTarget()
                .accessibilityLabel(title.map { "Xem tháng, \($0)" } ?? "Xem tháng")
                .accessibilityIdentifier(identifier ?? "month-button")
            } else {
                khanh
                    .accessibilityHidden(true)
            }
        }
    }
}

private struct HangingCordMotion: View {
    var active: Bool

    var body: some View {
        Group {
            if active {
                TimelineView(.animation(minimumInterval: 1.0 / 20.0)) { timeline in
                    let time = timeline.date.timeIntervalSinceReferenceDate
                    HangingCord()
                        .stroke(DesignTokens.wood.opacity(0.62), style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .frame(width: 70, height: 34)
                        .rotationEffect(.degrees(sin(time * 1.7) * 1.4 + sin(time * 0.61) * 0.6), anchor: .top)
                        .offset(y: -25)
                }
            } else {
                HangingCord()
                    .stroke(DesignTokens.wood.opacity(0.62), style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .frame(width: 70, height: 34)
                    .offset(y: -25)
            }
        }
        .accessibilityHidden(true)
    }
}

struct WoodRailStrip: View {
    var textured: Bool

    var body: some View {
        Capsule()
            .fill(DesignTokens.woodLight)
            .overlay {
                if textured {
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.28),
                            Color.clear,
                            Color.black.opacity(0.18),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(Capsule())
                }
            }
            .overlay {
                Capsule()
                    .stroke(Color.black.opacity(0.12), lineWidth: 0.5)
            }
            .accessibilityHidden(true)
    }
}

struct KhanhArch: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let shoulder: CGFloat = 24
        let bottom: CGFloat = 7
        path.move(to: CGPoint(x: rect.minX + bottom, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.maxY - bottom),
            control: CGPoint(x: rect.minX, y: rect.maxY)
        )
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + shoulder))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + shoulder, y: rect.minY + 10),
            control: CGPoint(x: rect.minX + 3, y: rect.minY + 10)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.midX - 26, y: rect.minY + 6),
            control: CGPoint(x: rect.minX + 48, y: rect.minY + 8)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.midX + 26, y: rect.minY + 6),
            control: CGPoint(x: rect.midX, y: rect.minY - 7)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - shoulder, y: rect.minY + 10),
            control: CGPoint(x: rect.maxX - 48, y: rect.minY + 8)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY + shoulder),
            control: CGPoint(x: rect.maxX - 3, y: rect.minY + 10)
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottom))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - bottom, y: rect.maxY),
            control: CGPoint(x: rect.maxX, y: rect.maxY)
        )
        path.closeSubpath()
        return path
    }
}

private struct HangingCord: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + 3, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.minY + 2),
            control: CGPoint(x: rect.minX + 13, y: rect.minY + 5)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - 3, y: rect.maxY),
            control: CGPoint(x: rect.maxX - 13, y: rect.minY + 5)
        )
        return path
    }
}

struct WoodGrain: View {
    var body: some View {
        Canvas { context, size in
            for index in 0..<16 {
                let y = size.height * (0.10 + CGFloat(index) * 0.055)
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addQuadCurve(
                    to: CGPoint(x: size.width, y: y + 0.8),
                    control: CGPoint(
                        x: size.width * 0.5,
                        y: y + (index.isMultiple(of: 2) ? 3.2 : -2.4)
                    )
                )
                context.stroke(
                    path,
                    with: .color(.black.opacity(0.14)),
                    lineWidth: index.isMultiple(of: 3) ? 1.1 : 0.6
                )
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}

struct BrassRivet: View {
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [DesignTokens.bronzeLight, DesignTokens.bronze, DesignTokens.bronzeDeep],
                    center: .topLeading,
                    startRadius: 1,
                    endRadius: 11
                )
            )
            .frame(width: DesignTokens.brassSize, height: DesignTokens.brassSize)
            .overlay {
                Circle()
                    .stroke(Color.black.opacity(0.18), lineWidth: 0.6)
            }
            .overlay(alignment: .topLeading) {
                Circle()
                    .fill(Color.white.opacity(0.35))
                    .frame(width: 5, height: 5)
                    .offset(x: 3, y: 3)
            }
            .accessibilityHidden(true)
    }
}

struct MountedPaperPage<Content: View>: View {
    @ViewBuilder var content: () -> Content
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast

    var body: some View {
        let textured = PaperLegibility.showsTexture(
            reduceTransparency: reduceTransparency,
            increasedContrast: colorSchemeContrast == .increased,
            boldText: false
        )
        VStack(alignment: .leading, spacing: DesignTokens.spaceMD) {
            content()
        }
        .padding(.horizontal, 18)
        .padding(.top, 22)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            UnevenRoundedRectangle(
                topLeadingRadius: 2,
                bottomLeadingRadius: DesignTokens.radiusSheet,
                bottomTrailingRadius: DesignTokens.radiusSheet,
                topTrailingRadius: 2,
                style: .continuous
            )
            .fill(DesignTokens.paper)
            .overlay {
                if textured {
                    PaperGrain()
                        .opacity(0.46)
                        .clipShape(UnevenRoundedRectangle(
                            topLeadingRadius: 2,
                            bottomLeadingRadius: DesignTokens.radiusSheet,
                            bottomTrailingRadius: DesignTokens.radiusSheet,
                            topTrailingRadius: 2,
                            style: .continuous
                        ))
                }
            }
            .shadow(color: .black.opacity(textured ? 0.16 : 0), radius: 14, y: 8)
        }
        .overlay(alignment: .top) {
            HStack(spacing: 5) {
                ForEach(0..<15, id: \.self) { _ in
                    Capsule()
                        .fill(DesignTokens.wood.opacity(0.15))
                        .frame(maxWidth: 14, maxHeight: 1)
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 8)
            .accessibilityHidden(true)
        }
    }
}

struct PaperSection<Content: View>: View {
    var title: String
    var symbol: String? = nil
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            HStack(spacing: 8) {
                if let symbol {
                    Image(systemName: symbol)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(DesignTokens.son)
                        .accessibilityHidden(true)
                }
                Text(title)
                    .font(.system(.headline, design: .rounded).weight(.bold))
                    .foregroundStyle(DesignTokens.ink)
            }
            content()
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignTokens.chipFill.opacity(0.58), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(DesignTokens.wood.opacity(0.12), lineWidth: 0.7)
        }
    }
}
