# US4 Widget checkpoint (T105)

Ngày: 09/09/2026. Simulator: iPhone 17.

## Tự động

Privacy và expiry: pass. Snapshot mặc định `hidden` không ghi title/note cá nhân. Lock screen luôn ẩn nhãn riêng. `genericMarker` chỉ hiện “Ngày gia đình”. Quốc khánh vẫn là sự kiện công khai.

Timeline: “Hôm nay” chỉ khi civil date trùng ngày display zone lúc render. Refresh trễ sau nửa đêm không gắn nhãn hôm nay cho snapshot ngày trước. Đổi zone NY/VN cho ra hai “hôm nay” khác nhau. Deep link `lichnha://day/2026-10-15` mở tờ ngày 15.

`swift test --package-path LichNha/Modules`: 55 tests pass. UI tests US1–US4: 9 tests pass. ImageRenderer light/dark/tinted của `WidgetBlocView` pass.

XCTest không gắn widget lên màn hình chính hay khóa. Chưa bật Airplane Mode trên máy; widget không gọi mạng, chỉ đọc snapshot cục bộ và Calendar Core.

## Cổng người

Scenario D trên thiết bị thật: UNTESTED. Cần thêm widget bằng tay, khóa máy, qua nửa đêm, rồi chạm widget.

## Kết luận

US4 đủ snapshot App Group, ẩn sự kiện riêng, và deep link. Bước tiếp: User Story 5 (cảnh ngày và âm).
