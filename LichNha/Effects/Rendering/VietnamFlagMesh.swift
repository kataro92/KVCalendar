import SwiftUI
import EffectCore

struct VietnamFlagMesh: View {
    var hoist: CGFloat = 28

    var body: some View {
        let size = VietnamFlagGeometry.flagSize(hoist: Double(hoist))
        let vertices = VietnamFlagGeometry.starVertices(width: size.width, height: size.height)
        Canvas { context, canvasSize in
            let scaleX = canvasSize.width / size.width
            let scaleY = canvasSize.height / size.height
            context.fill(
                Path(CGRect(origin: .zero, size: canvasSize)),
                with: .color(
                    Color(
                        red: VietnamFlagGeometry.fieldRed.red,
                        green: VietnamFlagGeometry.fieldRed.green,
                        blue: VietnamFlagGeometry.fieldRed.blue
                    )
                )
            )
            var star = Path()
            guard let first = vertices.first else { return }
            star.move(to: CGPoint(x: first.x * scaleX, y: first.y * scaleY))
            for point in vertices.dropFirst() {
                star.addLine(to: CGPoint(x: point.x * scaleX, y: point.y * scaleY))
            }
            star.closeSubpath()
            context.fill(
                star,
                with: .color(
                    Color(
                        red: VietnamFlagGeometry.starYellow.red,
                        green: VietnamFlagGeometry.starYellow.green,
                        blue: VietnamFlagGeometry.starYellow.blue
                    )
                )
            )
        }
        .frame(width: hoist * 1.5, height: hoist)
        .accessibilityIdentifier("vietnam-flag")
        .accessibilityLabel("Quốc kỳ Việt Nam")
    }
}
