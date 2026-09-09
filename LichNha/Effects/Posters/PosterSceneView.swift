import SwiftUI
import EffectCore

struct PosterSceneView: View {
    var posterID: String?

    var body: some View {
        switch posterID {
        case "poster-quoc-khanh":
            HStack {
                Spacer()
                VietnamFlagMesh(hoist: 22)
                    .padding(.trailing, 28)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        case "poster-lap-xuan":
            SpringBranchSilhouette()
                .stroke(DesignTokens.wood.opacity(0.55), lineWidth: 2)
                .frame(width: 70, height: 90)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, 18)
                .padding(.top, 8)
        case "poster-ordinary":
            WindowWash()
                .fill(Color.white.opacity(0.08))
                .frame(width: 54, height: 36)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.trailing, 36)
                .padding(.top, 12)
        default:
            Color.clear
        }
    }
}

struct SpringBranchSilhouette: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + 4, y: rect.maxY - 6))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.midY),
            control: CGPoint(x: rect.minX + 8, y: rect.midY + 10)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - 8, y: rect.minY + 10),
            control: CGPoint(x: rect.midX + 12, y: rect.minY + 18)
        )
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX + 16, y: rect.midY - 22),
            control: CGPoint(x: rect.midX + 4, y: rect.midY - 8)
        )
        return path
    }
}

struct WindowWash: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path(roundedRect: rect, cornerRadius: 3)
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
