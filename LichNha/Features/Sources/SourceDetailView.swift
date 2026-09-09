import SwiftUI
import ContentCore

struct SourceDetailView: View {
    var source: SourceRecord
    var onClose: () -> Void

    var body: some View {
        NavigationStack {
            List {
                LabeledContent("Tên", value: source.title)
                LabeledContent("Mức chứng cứ", value: evidenceName(source.evidenceTier))
                LabeledContent("Phạm vi", value: source.scope)
                if let publisher = source.publisher {
                    LabeledContent("Cơ quan / tác giả", value: publisher)
                }
                LabeledContent("Truy cập", value: source.accessedAt)
                LabeledContent("Giấy phép", value: licenseName(source.licenseStatus))
                if let url = source.url {
                    LabeledContent("Đường dẫn", value: url)
                }
            }
            .navigationTitle("Nguồn")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Đóng", action: onClose)
                        .accessibilityIdentifier("close-source")
                }
            }
        }
        .accessibilityIdentifier("source-detail")
    }

    private func evidenceName(_ tier: EvidenceTier) -> String {
        switch tier {
        case .computed: "Tính toán"
        case .official: "Văn bản chính thức"
        case .cultural: "Văn hóa"
        case .traditional: "Truyền thống"
        case .personal: "Cá nhân"
        }
    }

    private func licenseName(_ status: LicenseStatus) -> String {
        switch status {
        case .publicRecord: "Văn bản công"
        case .publicDomain: "Phạm vi công cộng"
        case .licensed: "Có giấy phép"
        case .original: "Tác phẩm của dự án"
        case .restricted: "Hạn chế, không phát hành"
        }
    }
}
