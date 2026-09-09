# Constitution compliance (T160)

Ngày rà: **09/09/2026**
Build: Debug Simulator `0.1.0` (1), scheme LichNha
Trạng thái: **SOURCE REVIEWED** — chưa ký archive App Store

Bảng này đối chiếu source, PrivacyInfo và binary Debug. Nó không thay Gate 1–7 hay `$speckit-converge`.

| Nguyên tắc | Bằng chứng 09/09/2026 | Kết luận |
|---|---|---|
| I. Miễn phí, không ads/paywall/account/sale data | Không `StoreKit`, Firebase, ads SDK. `Package.swift` chỉ module local. `NSPrivacyTracking` false, collected types rỗng | `CODE REVIEWED` |
| II. Đúng lịch, có phạm vi/nguồn/version | Golden tests pass; official 1.1.0 có Tết mùng 1; T147 reviewer 2 và T017 oracle người chưa có | `PARTIAL` |
| III. Mộc Son Dịu + accessibility | UI tests nút 44 pt; T144/Gate 5B UNTESTED | `UNTESTED` người |
| IV. Offline và local-only | Không `URLSession`/`WKWebView` trong app code. Pack trong bundle. T151 airplane máy thật `NOT RUN` | `CODE REVIEWED` |
| V. Kiểm chứng trước mở rộng | T020 waivers; Gate 1–7 UNTESTED | `WAIVED FOR CODE` |
| Rodin image-reference only | Không API key, không runtime call; T119 `NOT RUN` | `CODE REVIEWED` |
| Quốc kỳ dựng tay | `VietnamFlagMesh`; test 2:3 và sao năm cánh | `CODE REVIEWED` |
| Asset provenance | T148 HOLD; không file âm / mesh 3D | `HOLD` |

## Quét 09/09/2026

- `URLSession`, `WKWebView`, `StoreKit`, Firebase, Sentry, OpenAI: không có trong `LichNha/` trừ DTD `http://www.apple.com` của plist.
- Quyền: UserNotifications khi bật nhắc; EventKit chỉ từ “Thêm vào Lịch iPhone”. Không Contacts/Location/Photos/Camera/Mic.
- `PrivacyInfo.xcprivacy`: UserDefaults `CA92.1`. SwiftData có thể cần reason API bổ sung trên archive; chưa đối chiếu Privacy Report của Xcode Organizer.
- App Group `group.vn.lichnha.app`. Performance test unsigned log `client is not entitled`.

Không ghi `PASS` phát hành. Owner chưa ký.
