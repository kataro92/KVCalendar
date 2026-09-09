# Release performance (T150)

Ngày: 09/09/2026. Máy đo: Simulator iPhone 17, Debug.

Ngân sách prototype trong plan (40–60 MB pack, 60 fps scene) vẫn là ngân sách, không phải kết quả phát hành. Support matrix máy thật: UNTESTED.

## Simulator

| Hạng mục | Số đo | Ghi chú |
|---|---|---|
| `LichNha.app` Debug | ~30 MB | Gồm XCTest/Testing.framework vì test host; không phải App Store thinned |
| Executable `LichNha` | 39 KB | Phần lớn logic nằm ở `.debug.dylib` (~2.6 MB) và module frameworks |
| ContentPacks trong app | 20 KB | JSON |
| EffectPacks trong app | 28 KB | JSON, không mesh/audio |
| Widget `.appex` | 536 KB | |
| Module frameworks (Calendar/Content/Personal/…) | ~3 MB cộng | Không ads SDK |
| Cold launch tới `solar-day` (UI test) | < 8 s chờ | Gồm boot simulator; chưa Instruments time-to-text |
| `testTodayConversionPerformance` | ~0.012–0.104 ms / lần | `LichNhaPerformance` |
| `testThirtyDayWalkPerformance` | ~0.11–0.25 ms / 30 ngày | cùng scheme |

Cảnh Quốc khánh / Lập Xuân chưa profile frame pacing, nhiệt hay pin. Hiên sớm không có file nên không đo 15 phút ambient.

Khi đo performance với `CODE_SIGN_IDENTITY=-`, log App Group `client is not entitled`. Widget/store trên máy thật cần signing thật.

## Máy thật

iPhone thấp nhất trong support matrix: chưa đo. SC-009 UNTESTED.

## Kết luận

Pack hiệu ứng hiện tại rất nhỏ vì chưa có 3D/audio. Không dùng số Debug Simulator làm kích thước App Store.
