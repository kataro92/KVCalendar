# Offline và thời gian (T151)

Ngày: 09/09/2026.

## Đã chạy (tự động)

Module tests: timezone display zone, DST gap → instant kế, DST overlap → instant sớm hơn, delivery zone không đổi ngày âm, widget expiry nửa đêm, refresh trễ không gắn “Hôm nay” cho ngày cũ. Schema SwiftData v1; chưa có migration stage. Preference store schema 1, migrate `almanacLayerEnabled`.

UI tests US1–US6 trên Simulator không gọi mạng. Pack nằm trong bundle.

## Chưa chạy

| Kịch bản | Trạng thái |
|---|---|
| Airplane Mode trên iPhone thật, cài mới, Scenario A–F | `NOT RUN` |
| Đổi giờ hệ thống / qua nửa đêm trên máy | `NOT RUN` |
| Đổi múi giờ máy khi đang mở tờ ngày | unit test có; máy thật `NOT RUN` |
| Nâng cấp app (v0 → v1 store) | chưa có bản cũ trên TestFlight; schema mới tinh |

SC-011 UNTESTED trên thiết bị.

## Kết luận

Hành vi lịch/reminder/widget có test đơn vị. Không ghi airplane-mode pass.
