import SwiftUI

struct PagePeelInteraction: ViewModifier {
    /// Gate 2 is UNTESTED. Drag is a cheap peel; next/previous buttons remain required.
    var reduceMotion: Bool
    var onNext: () -> Void
    var onPrevious: () -> Void

    @State private var drag: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .offset(x: reduceMotion ? 0 : drag * 0.15)
            .rotation3DEffect(
                .degrees(reduceMotion ? 0 : Double(drag / 18)),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.6
            )
            .gesture(
                DragGesture(minimumDistance: 24)
                    .onChanged { value in
                        guard !reduceMotion else { return }
                        drag = value.translation.width
                    }
                    .onEnded { value in
                        let width = value.translation.width
                        if width < -80 {
                            onNext()
                        } else if width > 80 {
                            onPrevious()
                        }
                        drag = 0
                    }
            )
            .animation(reduceMotion ? nil : .easeOut(duration: DesignTokens.motionPage), value: drag)
    }
}

extension View {
    func lichNhaPagePeel(
        reduceMotion: Bool,
        onNext: @escaping () -> Void,
        onPrevious: @escaping () -> Void
    ) -> some View {
        modifier(PagePeelInteraction(reduceMotion: reduceMotion, onNext: onNext, onPrevious: onPrevious))
    }
}
