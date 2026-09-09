# US1 Today checkpoint (T066)

Ngày: 09/09/2026. Simulator: iPhone 17, id `3CB6389C-9B36-46CE-92DE-44BE9142F622`.

## Tự động

Scenario A trên máy: pass. `TodayJourneyTests` mở app, thấy `solar-day` và `lunar-day`, bấm Ngày sau / Ngày trước / Hôm nay. Không hiện login, paywall hay lỗi mạng. Nút Hôm nay chỉ xuất hiện khi đang xem ngày khác.

Snapshot: `TodaySheetSnapshotTests` render tờ 10/02/2024 ở rộng 320 và 430 pt, light/dark, Dynamic Type `large` và `accessibility2`. Ảnh có kích thước > 0. Chưa khóa PNG pixel.

Performance (`LichNhaPerformance`, cùng simulator): chuyển một ngày ~0.02 ms; đi 30 ngày ~0.23 ms. UI test chờ tờ hôm nay dưới 8 giây (gồm khởi động simulator). Chưa đo cold launch trên iPhone thật.

## Cổng người

SC-002, SC-003 và Gate 2: UNTESTED. Peel hiện tại là kéo ngang; nút 44 pt và VoiceOver action là đường chính. Reduce Motion tắt xoay 3D.

Dark mode dùng cùng token giấy kem (`#FFF8E8`), chưa có bảng màu tối riêng.

## Kết luận

US1 đủ demo tờ hôm nay offline trên simulator. Không tuyên bố đạt nghiên cứu người dùng. Bước tiếp: User Story 2 (tra ngày và nguồn).
