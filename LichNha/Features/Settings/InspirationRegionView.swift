import SwiftUI
import PersonalCore

struct InspirationRegionView: View {
    @Bindable var session: AppSession

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            Text("Chọn nét vùng miền cho cảnh ngày. Lịch Nhà không dùng vị trí của máy.")
                .font(.footnote)
                .foregroundStyle(DesignTokens.inkSecondary)
            ForEach(InspirationRegion.allCases, id: \.self) { region in
                PaperChoiceButton(
                    title: Self.title(region),
                    selected: session.preferences.inspirationRegion == region,
                    identifier: "region-\(region.rawValue)"
                ) {
                    session.updatePreferences { $0.inspirationRegion = region }
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("inspiration-region")
    }

    static func title(_ region: InspirationRegion) -> String {
        switch region {
        case .north: "Bắc"
        case .central: "Trung"
        case .south: "Nam"
        case .neutral: "Trung tính"
        }
    }
}
