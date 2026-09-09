# US2 Trust checkpoint (T080)

Ngày: 09/09/2026. Simulator: iPhone 17.

## Tự động

Scenario B trên máy: pass.

- `--date 2026-09-02` hiện Quốc khánh (ngày nghỉ theo luật), mở mặt sau, mở nguồn BLLĐ 2019, đóng, về tờ ngày.
- Từ tờ hôm nay mở tháng, Tháng sau, chọn ngày 15, Hôm nay-context: Quay lại tháng.
- `--date 1972-04-30` mặt sau có nhãn ngoại lệ 1968–1975. Pack official chỉ hiệu lực 2026–2100 nên không gán BLLĐ 2019 cho năm 1972.

Almanac: ba phương pháp tách khối, nhãn “tham khảo theo lịch truyền thống”, Sát Chủ chưa kết luận. Công tắc tắt cả lớp; Can Chi và tiết khí còn. `swift test --package-path LichNha/Modules` 36 tests pass. UI tests US1 vẫn pass.

## Cổng người

Gate 3 và SC-004: UNTESTED. Chưa đo người dùng có nhầm lễ truyền thống với ngày nghỉ hay không.

## Kết luận

US2 đủ demo tờ tháng, mặt sau, nguồn và lớp truyền thống tách riêng. Bước tiếp: User Story 3 (sự kiện gia đình và nhắc âm lịch).
