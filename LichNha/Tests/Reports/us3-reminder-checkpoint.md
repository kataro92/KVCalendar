# US3 Reminder checkpoint (T095)

Ngày: 09/09/2026. Simulator: iPhone 17.

## Tự động

Scenario C trên máy: pass.

- Tạo ngày giỗ mẫu, âm lịch ngày 12 tháng Tám, lặp hằng năm, nhắc trước 3 ngày lúc 8:00, policy tháng thường.
- Màn hình đọc lại bằng tiếng Việt trước khi lưu.
- `--deny-notifications`: sự kiện vẫn lưu; nhãn tách “Đã lưu trên máy này” và “Chưa bật nhắc. Quyền thông báo bị từ chối; sự kiện vẫn còn.”
- Nút “Thêm vào Lịch iPhone” có mặt; UI test không mở EventKit và không đọc lịch hệ thống.
- Relaunch không `--reset-personal-store`: sự kiện còn.

Planner: tháng nhuận 2004 (thường / nhuận / cả hai / năm không nhuận), ngày 30 tháng thiếu, DST gap/overlap `America/New_York`, đổi delivery zone không đổi ngày âm UTC+7. Scheduler idempotent. Log/error không chứa title/note.

`swift test --package-path LichNha/Modules`: 48 tests pass. UI tests US1+US2+US3: 7 tests pass trên iPhone 17.

Store Simulator: file Application Support (`events.store`). App Group `group.vn.lichnha.app` vẫn là đường production trên máy thật. Tên store `LichNhaPersonalEvents` để tránh schema v1 cũ thiếu cột nhắc.

## Cổng người

Gate 4 và SC-005: UNTESTED. Chưa đo người dùng có hiểu policy tháng nhuận và trạng thái từ chối thông báo hay không.

## Kết luận

US3 đủ tạo sự kiện âm/dương, chọn policy, lưu khi bị từ chối notification. Bước tiếp: User Story 4 (widget).
