import SwiftUI
import XCTest
import EffectCore
@testable import LichNha

@MainActor
final class VietnamFlagSnapshotTests: XCTestCase {
    func testFlagRendersWithExpectedAspect() {
        let flag = VietnamFlagMesh(hoist: 40)
            .frame(width: 60, height: 40)
        let renderer = ImageRenderer(content: flag)
        renderer.scale = 1
        let image = renderer.uiImage
        XCTAssertNotNil(image)
        XCTAssertEqual(image?.size.width, 60)
        XCTAssertEqual(image?.size.height, 40)
        let size = VietnamFlagGeometry.flagSize(hoist: 40)
        XCTAssertEqual(size.width / size.height, 1.5, accuracy: 0.0001)
    }
}
