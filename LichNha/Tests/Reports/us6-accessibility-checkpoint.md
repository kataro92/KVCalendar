# US6 Accessibility checkpoint (T145)

Ngày: 09/09/2026. Simulator: iPhone 17.

## Tự động

Preferences: bản mới Yên, giấy/cue tắt, widget ẩn. Tắt hết âm xóa cả ba lớp. Legacy `almanacLayerEnabled` được chuyển sang store. Reduce Motion, Dim Flashing Lights và Low Power hạ cảnh về Tĩnh mà không sửa lựa chọn đã lưu.

UI: ngăn giấy Cài đặt, Sống động/Êm/Tĩnh, bốn lớp âm, vùng cảm hứng không GPS, privacy widget, giờ nhắc, phiên bản pack và hướng dẫn báo sai không gửi dữ liệu máy. Can Chi rời mặt trước từ Dynamic Type `.accessibility2`. Giấy bỏ grain khi Reduce Transparency, Increase Contrast hoặc chữ đậm.

`swift test --package-path LichNha/Modules`: 81 tests pass. iOS CalendarCore: 15 XCTest + 81 Swift Testing pass, gồm LargeTextContrast và MotionSafety. UI tests: 11 pass, gồm VoiceOverJourney (nút, không kéo; Tắt hết âm).

XCUITest không bật VoiceOver hệ thống. Chữ 200% và Increase Contrast trên máy thật chưa chạy.

## Cổng người

Gate 5A: UNTESTED (Phase 1). Gate 5B: UNTESTED. T144 scorecard chưa có buổi. SC-007 UNTESTED. Không ghi PASS.

## Kết luận

US6 đủ store, settings và semantics cho Scenario F trên Simulator. Phát hành vẫn chờ Gate 5B.
