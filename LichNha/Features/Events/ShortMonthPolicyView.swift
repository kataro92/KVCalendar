import SwiftUI
import PersonalCore

struct ShortMonthPolicyView: View {
    @Binding var policy: ShortMonthPolicy

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            Text("Ngày 30 của tháng thiếu")
                .font(.headline)
            Text(PersonalEventCopy.shortMonthSentence(policy))
                .font(.subheadline)
                .foregroundStyle(DesignTokens.inkSecondary)
            ForEach(ShortMonthPolicy.allCases, id: \.self) { item in
                Button {
                    policy = item
                } label: {
                    HStack {
                        Text(label(item))
                        Spacer()
                        if policy == item {
                            Text("Đã chọn")
                                .font(.footnote)
                        }
                    }
                    .foregroundStyle(DesignTokens.ink)
                    .padding(.horizontal, 12)
                    .frame(minHeight: DesignTokens.minHitTarget)
                    .background(
                        policy == item ? DesignTokens.jade.opacity(0.55) : DesignTokens.peach.opacity(0.35),
                        in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                    )
                }
                .lichNhaHitTarget()
                .accessibilityIdentifier("short-policy-\(item.rawValue)")
            }
        }
        .accessibilityElement(children: .contain)
    }

    private func label(_ item: ShortMonthPolicy) -> String {
        switch item {
        case .lastDayOfMonth:
            return "Nhắc ngày cuối tháng"
        case .skip:
            return "Bỏ qua năm đó"
        case .firstOfNext:
            return "Nhắc mùng 1 tháng sau"
        }
    }
}
