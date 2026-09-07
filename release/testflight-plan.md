# Kế hoạch TestFlight 1.0 — bản nháp

**Trạng thái:** `DRAFT · NOT RUN`
**Ngày soạn:** 07/09/2026
**Build:** chưa có
**Liên kết backlog:** T156 là tài liệu này; T157 vẫn cần 20–30 người thật.

TestFlight dùng để tìm lỗi build và kiểm tra các luồng đã định nghĩa. Nó không thay nghiên cứu khám phá T012–T016, không biến persona mô phỏng thành người dùng và không mở khóa T020.

## 1. Điều kiện trước khi mời tester

- T020 đã ký bằng bằng chứng thật.
- Calendar golden/property tests và reconciliation report đã pass.
- Các checkpoint của user story có trong build đã pass trên simulator và thiết bị thật tương ứng.
- Privacy policy, App Store Privacy worksheet và dependency audit đã được cập nhật theo build.
- Không có ads, paywall, In-App Purchase, account, analytics hoặc runtime AI.
- First launch ở trạng thái âm **Yên**; Hiên sớm, âm giấy và cue sự kiện là opt-in.
- P0/P1 nội bộ đã về 0 trước external beta.

Mọi dòng trên hiện là `NOT RUN`.

## 2. Owner và kênh

| Vai trò | Trách nhiệm | Người phụ trách |
|---|---|---|
| Release owner | Chọn build, ký checklist, expire build lỗi | Chưa chỉ định |
| Test lead | Tuyển mẫu, quota, consent, session ID | Chưa chỉ định |
| Calendar owner | Phân loại lỗi ngày, nguồn và regression corpus | Chưa chỉ định |
| Accessibility reviewer | VoiceOver, chữ 200%, motion/flash | Chưa chỉ định |
| Privacy reviewer | Feedback, screenshot, log và retention | Chưa chỉ định |
| Feedback email | Nhận phản hồi TestFlight | `[EMAIL TO FILL]` |

Không dùng tên người tham gia làm tên file hoặc issue công khai.

## 3. Các vòng phát hành

### Vòng 0 — smoke nội bộ

2–5 người có quyền App Store Connect, trên ít nhất thiết bị thấp nhất, màn nhỏ và thiết bị hiện hành trong support matrix. Chỉ mở vòng kế khi install, cold launch, Today, month, reminder, widget và crash-free smoke đều đạt.

### Vòng 1 — external hẹp

8–12 người, ưu tiên phủ iOS/device/timezone và VoiceOver trước. Dùng invitation riêng để dễ dừng khi có lỗi dữ liệu hoặc privacy.

### Vòng 2 — external mục tiêu

20–30 người thật theo T157. Nhóm chính vẫn là 16–34; bổ sung 55+, VoiceOver, người giữ ngày gia đình và ít nhất hai timezone ngoài Việt Nam. Đây là quota nghiên cứu có chủ đích, không phải mẫu đại diện dân số.

Apple yêu cầu beta description, feedback email và test information cho external testing; build external đầu tiên có thể cần TestFlight App Review. Kiểm tra lại [TestFlight overview](https://developer.apple.com/help/app-store-connect/test-a-beta-version/testflight-overview) và [Provide test information](https://developer.apple.com/help/app-store-connect/test-a-beta-version/provide-test-information) lúc tạo nhóm.

## 4. Build checklist

| Mục | Trạng thái |
|---|---|
| Version/build number, commit SHA và release manifest được ghi | `NOT RUN` |
| Archive đúng signing, App Group và widget entitlement | `NOT RUN` |
| Export compliance được trả lời theo binary thật | `NOT RUN` |
| Privacy manifest và App Store Privacy worksheet đã đối chiếu | `NOT RUN` |
| Dependency/secret scan sạch, không runtime AI hoặc API key | `NOT RUN` |
| Không account, ads, paywall, IAP hoặc analytics | `NOT RUN` |
| Golden corpus, reminder, timezone và offline regression pass | `NOT RUN` |
| VoiceOver, chữ 200%, Reduce Motion và Dim Flashing Lights pass | `NOT RUN` |
| First launch mặc định Yên; audio khác không bị chiếm | `NOT RUN` |
| Widget lock screen ẩn title/note mặc định | `NOT RUN` |
| Beta description, What to Test, feedback email và review notes đã điền | `NOT RUN` |
| Known issues không chứa workaround che lỗi P0/P1 | `NOT RUN` |

## 5. Tester notes ứng viên

### Beta description

> Lịch Nhà là bản thử nghiệm lịch bloc Việt Nam trên iPhone. Bản này tập trung vào tờ hôm nay, tra tháng và nguồn, ngày gia đình, lời nhắc cục bộ, widget, cảnh theo ngày và accessibility. Ứng dụng không cần tài khoản; âm mặc định là Yên.

### What to Test

1. Mở app khi bật airplane mode; đọc ngày dương và ngày âm.
2. Sang ngày bằng kéo/bóc, sau đó làm lại bằng nút hoặc VoiceOver action.
3. Về Hôm nay từ một ngày khác.
4. Chọn ngày ở tờ tháng, mở mặt sau và tìm nguồn/version.
5. Tạo một sự kiện **giả lập**, thử policy tháng nhuận và ngày 30 tháng thiếu; không nhập thông tin gia đình thật ở beta.
6. Bật lời nhắc, từ chối quyền rồi bật lại; kiểm tra app phân biệt “đã lưu” và “đã bật nhắc”.
7. Thêm widget, đổi ngày/múi giờ theo kịch bản và mở deep link.
8. Xem một scene ngày lễ, bật Reduce Motion/Dim Flashing Lights/Low Power và so với poster.
9. Xác nhận first launch là Yên. Chỉ sau đó mới bật Hiên sớm; báo nếu âm lấn át audio khác hoặc khó tắt.
10. Thử chữ 200%, VoiceOver, Increase Contrast và thao tác một tay.

### Cách gửi lỗi lịch

Gửi ngày dương fixture, kết quả thấy được, kết quả mong đợi, timezone, phiên bản engine/content pack và nguồn đối chiếu. Không gửi tên người thân, ngày giỗ thật hay ghi chú riêng. Lỗi lịch/reminder phải vào regression corpus sau khi được xác minh.

## 6. Ma trận theo dõi

| Trục | Giá trị tối thiểu cần phủ | Trạng thái |
|---|---|---|
| iOS | deployment target thấp nhất + bản hiện hành | `NOT RUN` |
| Thiết bị | màn nhỏ, thiết bị thấp nhất, thiết bị hiện hành | `NOT RUN` |
| Timezone | `Asia/Ho_Chi_Minh`, một zone có DST, một case lệch ngày Việt Nam/local | `NOT RUN` |
| Accessibility | VoiceOver, chữ 200%, Reduce Motion, Increase Contrast, Dim Flashing Lights | `NOT RUN` |
| Power/network | Low Power, thermal fallback, airplane mode | `NOT RUN` |
| Widget | Home Screen, Lock Screen nếu support, light/dark/tinted | `NOT RUN` |
| Audio | Yên, opt-in Hiên sớm, Silent, audio khác, call/headphone | `NOT RUN` |

## 7. Phân loại lỗi và quyền dừng

| Mức | Ví dụ | Xử lý |
|---|---|---|
| P0 | Sai ngày hàng loạt, mất dữ liệu, lộ ghi chú, crash launch, cờ sai nghiêm trọng | Dừng test, expire build, thông báo tester và điều tra ngay |
| P1 | Reminder sai, widget sai ngày, task lõi không hoàn tất, accessibility blocker | Không mở rộng mẫu; sửa và regression trước build mới |
| P2 | Lỗi layout có workaround, hiệu ứng giật cục bộ, copy khó hiểu | Ghi owner và mốc sửa; đánh giá lại trước App Review |
| P3 | Polish nhỏ không ảnh hưởng task | Gom theo component; không để che P0/P1 |

External beta chỉ kết thúc khi P0/P1 bằng 0, mọi lỗi lịch/reminder đã có regression và scorecard T157 nêu rõ mẫu số cùng dữ liệu thiếu.

## 8. Rollback

1. Release owner dừng phân phối hoặc expire build có P0/P1 trong App Store Connect.
2. Thông báo ngắn cho tester: build nào bị dừng, dữ liệu nào có nguy cơ, hành động an toàn cần làm. Không đoán nguyên nhân.
3. Nếu một build trước còn hiệu lực và không có lỗi liên quan, gán lại build đó cho nhóm; nếu không, dừng test tới build sửa.
4. Bảo toàn database fixture/log đã redacted và thêm regression trước khi upload lại.
5. Không sửa metadata để che khác biệt của binary.

## 9. Biên bản kết thúc

| Mục | Kết quả |
|---|---|
| Build cuối | `NOT RUN` |
| Số người hợp lệ / được mời | `0 / 0` |
| P0 / P1 còn mở | `NOT RUN` |
| Calendar/reminder regressions đã thêm | `NOT RUN` |
| Accessibility blockers | `NOT RUN` |
| Privacy incidents | `NOT RUN` |
| Release owner ký | `BLOCKED` |
