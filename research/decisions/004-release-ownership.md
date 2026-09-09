# 004 — Support matrix và quyền sở hữu phát hành

**Trạng thái:** `ACCEPTED · OWNER VÀ NGUỒN PHÍ ĐÃ CHỈ ĐỊNH; INVENTORY MÁY THẬT VẪN THIẾU`
**Ngày rà soát:** 08/09/2026
**Liên kết task:** T019
**Người ký:** chủ dự án

## Nền tảng 1.0

| Mục | Quyết định |
|---|---|
| Thiết bị | iPhone dọc. iPad ngoài 1.0 |
| Deployment | iOS 17 trở lên |
| Swift / Xcode lúc mở implementation | Swift 6.3.x, Xcode 26.5 (gim lại trong `BuildSettings.xcconfig`) |
| Simulator | Đủ cho logic và UI layout. Không thay test audio, haptic, widget, nhiệt, VoiceOver trên máy thật |

Máy thật chưa có model trong inventory. Owner cam kết có ít nhất một iPhone chạy đúng iOS thấp nhất được hỗ trợ trước T150 (hiệu năng) và trước Gate 5B/7B. Tên model điền vào bảng này khi máy có mặt.

## Owner

| Trách nhiệm | Owner | Trạng thái |
|---|---|---|
| Trả phí Apple Developer hằng năm (99 USD, kiểm tra lại lúc đăng ký) | Chủ dự án | Chỉ định 08/09/2026 |
| Tài khoản, certificate, App Store Connect | Chủ dự án | Chỉ định |
| Calendar Core / golden corpus | Chủ dự án | Chỉ định; corpus chưa có file |
| Ruleset tốt/xấu 1.0 | Chủ dự án | Chỉ định; xem T018 |
| Duyệt văn hóa / Quốc kỳ / cảnh trang nghiêm | Chủ dự án, với cultural review trước scene flagship | Chỉ định tạm; review độc lập vẫn cần trước release |
| Báo lỗi dữ liệu và bản sửa | Chủ dự án | Chỉ định |
| Privacy label theo binary | Chủ dự án | Chỉ định; điền sau khi có binary |

## Cam kết vận hành

- Miễn phí cho người tải. Không quảng cáo, paywall, bán dữ liệu.
- Không thêm SDK analytics/ads để bù 99 USD/năm.
- Data pack ngày nghỉ được rà mỗi năm.
- Kênh báo lỗi lịch sẽ ghi trong phần Nguồn của app; thời gian phản hồi dự kiến điền trước TestFlight.
- Provenance font, artwork, Rodin, ElevenLabs giữ trong manifest.
- Nếu owner chính ngừng duy trì, tài khoản và nguồn phí phải bàn giao trước khi gỡ app khỏi Store.

## Điều T019 đóng / còn mở

Đóng: iPhone / iOS 17, người trả phí, người giữ tài khoản, owner dữ liệu và ruleset.

Còn mở: model máy test cụ thể; Team ID Apple; tên kênh hỗ trợ; người thay thế.
