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
            DesignTokens.wall
                .ignoresSafeArea()
            backdrop
                .allowsHitTesting(false)
            VStack(spacing: 0) {
                BlocHeaderView(
                    title: headerTitle,
                    action: headerAction,
                    identifier: headerIdentifier
                )
                .padding(.horizontal, compact ? 0 : 24)
                content()
                    .padding(.horizontal, compact ? 0 : 20)
                    .padding(.bottom, 16)
            }
            .padding(.horizontal, compact ? 0 : 0)
            .padding(.top, compact ? 0 : 8)
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
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast

    var body: some View {
        let textured = PaperLegibility.showsTexture(
            reduceTransparency: reduceTransparency,
            increasedContrast: colorSchemeContrast == .increased,
            boldText: false
        )
        let khanh = VStack(spacing: 0) {
            ZStack {
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
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(DesignTokens.paper)
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
                .padding(.horizontal, 18)
                .padding(.bottom, 3)
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
        let top: CGFloat = 20
        let bottom: CGFloat = 5
        path.move(to: CGPoint(x: rect.minX + bottom, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.maxY - bottom),
            control: CGPoint(x: rect.minX, y: rect.maxY)
        )
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + top))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + top, y: rect.minY + 5),
            control: CGPoint(x: rect.minX, y: rect.minY + 6)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - top, y: rect.minY + 5),
            control: CGPoint(x: rect.midX, y: rect.minY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY + top + 2),
            control: CGPoint(x: rect.maxX, y: rect.minY + 6)
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
