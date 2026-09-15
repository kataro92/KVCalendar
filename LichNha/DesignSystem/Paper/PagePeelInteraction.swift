import SwiftUI

struct PagePeelInteraction: ViewModifier {
    /// Gate 2 is UNTESTED. Drag is a cheap peel; next/previous buttons remain required.
    var reduceMotion: Bool
    var onNext: () -> Void
    var onPrevious: () -> Void

    @State private var drag: CGFloat = 0

    private var peelProgress: CGFloat {
        min(abs(drag) / 180, 1)
    }

    private var peelDirection: CGFloat {
        drag < 0 ? -1 : 1
    }

    func body(content: Content) -> some View {
        content
            .offset(x: reduceMotion ? 0 : drag * 0.15)
            .offset(y: reduceMotion ? 0 : -peelProgress * 2.5)
            .scaleEffect(reduceMotion ? 1 : 1 - peelProgress * 0.012)
            .rotation3DEffect(
                .degrees(reduceMotion ? 0 : Double(peelDirection * peelProgress * 5.5)),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.6
            )
            .shadow(
                color: .black.opacity(reduceMotion ? 0 : 0.06 + Double(peelProgress) * 0.10),
                radius: reduceMotion ? 0 : 8 + peelProgress * 5,
                x: reduceMotion ? 0 : -peelDirection * peelProgress * 2,
                y: reduceMotion ? 0 : 5
            )
            .overlay {
                if !reduceMotion && peelProgress > 0.02 {
                    LinearGradient(
                        colors: [
                            .white.opacity(0),
                            .white.opacity(0.10 * peelProgress),
                            .white.opacity(0)
                        ],
                        startPoint: peelDirection < 0 ? .leading : .trailing,
                        endPoint: peelDirection < 0 ? .trailing : .leading
                    )
                    .blendMode(.screen)
                    .allowsHitTesting(false)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 24)
                    .onChanged { value in
                        guard !reduceMotion else { return }
                        let raw = value.translation.width
                        let limited = min(abs(raw), 220)
                        let resisted = pow(limited, 0.88)
                        drag = (raw < 0 ? -1 : 1) * resisted
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
            .animation(reduceMotion ? nil : .interactiveSpring(response: 0.34, dampingFraction: 0.86), value: drag)
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
