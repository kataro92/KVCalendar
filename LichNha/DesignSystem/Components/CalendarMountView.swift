import SwiftUI

struct CalendarMountView<Backdrop: View, Content: View>: View {
    var backdrop: Backdrop
    @ViewBuilder var content: () -> Content

    init(
        @ViewBuilder backdrop: () -> Backdrop,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backdrop = backdrop()
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .top) {
            DesignTokens.wall
                .ignoresSafeArea()
            backdrop
                .allowsHitTesting(false)
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(DesignTokens.wood)
                    .frame(height: 56)
                    .overlay {
                        HStack {
                            Circle().fill(DesignTokens.bronze).frame(width: 14, height: 14)
                            Spacer()
                            Circle().fill(DesignTokens.bronze).frame(width: 14, height: 14)
                        }
                        .padding(.horizontal, 28)
                    }
                    .padding(.horizontal, 24)
                    .accessibilityHidden(true)
                content()
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
            }
            .padding(.top, 8)
            .safeAreaPadding(.top)
        }
    }
}

extension CalendarMountView where Backdrop == Color {
    init(@ViewBuilder content: @escaping () -> Content) {
        self.init(backdrop: { Color.clear }, content: content)
    }
}
