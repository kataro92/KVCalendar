import Foundation

/// Hand-built flag geometry. Internal color master, not a statutory color code.
public enum VietnamFlagGeometry {
    /// Fly (width) over hoist (height) when the flag is displayed horizontally.
    public static let flyOverHoist: Double = 1.5
    public static let fieldRed = (red: 218.0 / 255.0, green: 37.0 / 255.0, blue: 29.0 / 255.0)
    public static let starYellow = (red: 1.0, green: 1.0, blue: 0.0)
    public static let starPointCount = 5
    public static let outerRadiusOverHoist = 0.3
    public static let innerRadiusRatio = (3.0 - sqrt(5.0)) / 2.0

    public struct Point: Hashable, Sendable {
        public var x: Double
        public var y: Double
    }

    public static func flagSize(hoist: Double) -> (width: Double, height: Double) {
        (hoist * flyOverHoist, hoist)
    }

    public static func starCenter(width: Double, height: Double) -> Point {
        Point(x: width / 2, y: height / 2)
    }

    /// Ten vertices of a filled five-point star, starting at the upward outer tip.
    /// Y grows downward to match UIKit/SwiftUI.
    public static func starVertices(width: Double, height: Double) -> [Point] {
        let center = starCenter(width: width, height: height)
        let outer = height * outerRadiusOverHoist
        let inner = outer * innerRadiusRatio
        var points: [Point] = []
        points.reserveCapacity(10)
        for i in 0..<starPointCount {
            let outerAngle = -Double.pi / 2 + Double(i) * 2 * Double.pi / Double(starPointCount)
            let innerAngle = outerAngle + Double.pi / Double(starPointCount)
            points.append(Point(x: center.x + cos(outerAngle) * outer, y: center.y + sin(outerAngle) * outer))
            points.append(Point(x: center.x + cos(innerAngle) * inner, y: center.y + sin(innerAngle) * inner))
        }
        return points
    }

    public static func isPointingUp(_ vertices: [Point]) -> Bool {
        guard let first = vertices.first else { return false }
        return vertices.allSatisfy { $0.y >= first.y - 1e-9 }
    }

    public static func allVerticesInsideFlag(_ vertices: [Point], width: Double, height: Double) -> Bool {
        vertices.allSatisfy { point in
            point.x >= 0 && point.x <= width && point.y >= 0 && point.y <= height
        }
    }
}
