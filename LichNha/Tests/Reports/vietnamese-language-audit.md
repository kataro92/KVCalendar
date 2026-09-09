# Audit tiếng Việt (T146)

Ngày: 09/09/2026. Simulator: iPhone 17. Không bật VoiceOver hệ thống.

## Phạm vi

Chuỗi giao diện trong `LichNha/Features`, `DesignSystem`, widget và tóm tắt VoiceOver. Không audit comment kỹ thuật trong module.

## Kết quả

Chữ giao diện là tiếng Việt, có dấu. Ngày dương dùng `minimumScaleFactor` 0.5; Can Chi rời mặt trước từ Dynamic Type `.accessibility2`. Tóm tắt tờ ngày giữ thứ, ngày dương, âm lịch, tiết khí và sự kiện.

Sửa trong lượt này:

- Nhãn “Engine” / “Almanac” / “Ruleset” đổi thành Công cụ lịch, Lịch truyền thống, Bộ quy tắc.
- Gợi ý VoiceOver ô tháng không còn raw English (`statutory`, `traditional`).
- Tiêu đề cột T2–CN có spoken name Thứ Hai…Chủ Nhật.
- Giấy phép nguồn dùng câu tiếng Việt, không in `publicRecord`.
- Cài đặt cảnh dùng tên tiếng Việt cho giảm chuyển động, làm mờ đèn nhấp nháy và chế độ nguồn điện thấp.

## Còn mở

VoiceOver trên máy thật chưa đọc Can Chi và tiết khí. Overflow pixel chưa khóa PNG. Tên phương pháp almanac (Hoàng Đạo, Lục Diệu) cần buổi người T144.

## Kết luận

Audit chuỗi Simulator xong. Không tuyên bố SC-007.
