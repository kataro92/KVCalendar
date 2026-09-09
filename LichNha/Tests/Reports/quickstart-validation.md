# Quickstart validation (T152)

Ngày: 09/09/2026. Simulator iPhone 17 `3CB6389C-9B36-46CE-92DE-44BE9142F622`.

`quickstart.md` trước đây gọi scheme `LichNhaCoreTests` / `LichNhaUITests` và `iPhone 15`. Đã sửa thành lệnh thật: `CalendarCore`, `LichNha -only-testing:LichNhaUITests`, `LichNhaPerformance`.

## Lệnh tự động

| Lệnh | Kết quả 09/09/2026 |
|---|---|
| `swift test --package-path LichNha/Modules` | 81 tests pass |
| `python3 tools/pack-validator/test_samples.py` | pack validator samples ok |
| `validate.py` official / culture / almanac-seed | ok cả ba |
| `asset-manifest-validator/validate.py` ba effect pack + Rodin manifest | ok |
| `xcodebuild test -scheme CalendarCore` | TEST SUCCEEDED (15 XCTest + 81 Swift Testing) |
| `xcodebuild test -scheme LichNha -only-testing:LichNhaUITests` | 11 tests pass (lượt US6 cùng ngày) |
| `xcodebuild test -scheme LichNhaPerformance` | 2 tests pass |

## Scenario A–F

Simulator: A–C, E (một phần), F (nút, không VoiceOver hệ thống) đã có UI test. D (widget trên Home/Lock) UNTESTED. Performance máy thật UNTESTED.

Không có tài khoản, paywall hay lỗi mạng trong UI test.

## Kết luận

Runbook tự động khớp project. Kịch bản người và máy thật vẫn mở.
