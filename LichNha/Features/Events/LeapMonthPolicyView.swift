import SwiftUI
import PersonalCore

struct LeapMonthPolicyView: View {
    @Binding var policy: LeapMonthPolicy
    var month: Int

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            Text("Tháng nhuận")
                .font(.headline)
            Text(PersonalEventCopy.leapPolicySentence(policy, month: month))
                .font(.subheadline)
                .foregroundStyle(DesignTokens.inkSecondary)
            ForEach(LeapMonthPolicy.allCases, id: \.self) { item in
                Button {
                    policy = item
                } label: {
                    HStack {
                        Text(label(item))
                            .multilineTextAlignment(.leading)
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
                .accessibilityIdentifier("leap-policy-\(item.rawValue)")
            }
        }
        .accessibilityElement(children: .contain)
    }

    private func label(_ item: LeapMonthPolicy) -> String {
        let name = PersonalEventCopy.lunarMonthName(month)
        switch item {
        case .regularMonth:
            return "Chỉ tháng \(name) thường"
        case .leapMonth:
            return "Chỉ tháng \(name) nhuận"
        case .both:
            return "Cả tháng thường và tháng nhuận"
        case .substitute:
            return "Năm không nhuận thì dùng tháng thường"
        }
    }
}
