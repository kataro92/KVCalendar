import Foundation
import Testing
import EffectCore

struct EffectModelTests {
    @Test func textTo3DIsNotAGenerationMethod() {
        #expect(GenerationMethod.imageTo3D != .manual)
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(GenerationMethod.self, from: Data(#""textTo3D""#.utf8))
        }
    }
}
