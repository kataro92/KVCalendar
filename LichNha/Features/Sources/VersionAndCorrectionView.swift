import SwiftUI
import CalendarCore
import ContentCore
import EffectCore
import AlmanacCore

struct VersionAndCorrectionView: View {
    var session: AppSession

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            LabeledContent("Công cụ lịch", value: VietnameseLunarCalendar.ruleSetVersion)
            LabeledContent("Nội dung", value: session.catalog?.activeVersionLabel ?? "chưa đọc pack")
            LabeledContent("Hiệu ứng", value: session.effectCatalog?.versionLabel ?? "chưa đọc pack")
            LabeledContent("Lịch truyền thống", value: "\(AlmanacEngine.ruleset.id) · \(AlmanacEngine.ruleset.version)")
            Text("Nếu ngày nghỉ hoặc ngày âm sai, gửi email cho chủ app với ngày dương, ngày âm bạn thấy, và nguồn bạn đối chiếu. Không gửi tên sự kiện gia đình, ghi chú hay ảnh màn hình có thông tin riêng.")
                .font(.footnote)
                .foregroundStyle(DesignTokens.inkSecondary)
            Text("Không có nút gửi tự động. App không đính kèm dữ liệu máy.")
                .font(.footnote)
                .foregroundStyle(DesignTokens.inkSecondary)
                .accessibilityIdentifier("correction-guidance")
        }
        .accessibilityIdentifier("version-correction")
    }
}
