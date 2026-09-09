# App Review checklist — bản nháp

**Trạng thái:** `DRAFT · chưa submit`
**Ngày đối chiếu nguồn:** 07/09/2026; rà Simulator 09/09/2026
**Build/version:** `0.1.0` (1) Debug — không phải archive gửi duyệt
**Reviewer:** chưa chỉ định.

Checklist này dựa trên [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) của Apple, bản trang ghi cập nhật 08/06/2026, cùng tài liệu App Store Connect hiện hành. Quy định có thể đổi; reviewer phải đọc lại nguồn vào ngày submit. Một ô chỉ được đánh dấu sau khi có bằng chứng từ đúng archive gửi duyệt.

## A. Quyền sở hữu và hồ sơ phát hành

- [ ] `NOT RUN` — Account Holder, người trả phí hằng năm và người giữ certificate/App Store Connect đã được chỉ định.
- [ ] `NOT RUN` — Tên phát hành đã tra cứu; icon, tên và metadata không dùng brand/tài sản của app khác.
- [ ] `NOT RUN` — Support URL và Privacy Policy URL công khai, mở được không cần đăng nhập.
- [ ] `NOT RUN` — Contact của App Review đang hoạt động.
- [ ] `NOT RUN` — Age rating, category, copyright và quyền phát hành theo vùng đã điền đúng.

## B. App completeness và minimum functionality

- [ ] `NOT RUN` — Archive cài được, không crash, không có placeholder, dead link hoặc nội dung “coming soon”.
- [ ] `NOT RUN` — Today, month, mặt sau/nguồn, personal event, local reminder và widget hoạt động như metadata mô tả.
- [ ] `NOT RUN` — App tự hoạt động, không cần cài app khác và không phải web wrapper hay một tờ lịch tĩnh.
- [ ] `NOT RUN` — Reviewer dùng được toàn bộ luồng mà không cần account hoặc demo login.
- [ ] `NOT RUN` — Tính năng khó thấy có bước thử cụ thể trong App Review notes.
- [ ] `NOT RUN` — Airplane-mode, timezone, midnight rollover và upgrade regression đã pass.

Mục này đối chiếu đặc biệt với Guideline 2.1 về app completeness và 4.2 về minimum functionality; số mục phải được kiểm tra lại khi submit.

## C. Metadata và screenshot

- [ ] `NOT RUN` — Tên, subtitle, description, keyword và screenshot khớp đúng binary.
- [ ] `NOT RUN` — Không dùng claim “đầu tiên”, “duy nhất”, “chính xác tuyệt đối” hoặc phạm vi “vạn niên” không giới hạn.
- [ ] `NOT RUN` — Không nói Hiên sớm/white noise giúp tập trung, học hoặc làm việc tốt hơn.
- [ ] `NOT RUN` — Claim miễn phí, không quảng cáo/paywall/account chỉ xuất hiện sau audit tương ứng.
- [ ] `NOT RUN` — Screenshot là UI thật, không chứa tính năng giả, ngày chưa kiểm chứng hoặc dữ liệu gia đình thật.
- [ ] `NOT RUN` — Screenshot đúng file type/device size đang được App Store Connect nhận và không có alpha.

## D. Privacy và data minimization

- [ ] `NOT RUN` — Privacy policy trong app và App Store Connect mô tả dữ liệu, mục đích, lưu giữ/xóa và bên thứ ba đúng với build.
- [ ] `NOT RUN` — App Store Privacy answers khớp source, dependency, privacy manifest, traffic và binary.
- [ ] `NOT RUN` — Không có account, ads, paywall, IAP, analytics, tracking hoặc crash-upload SDK ngoài phạm vi đã duyệt.
- [ ] `NOT RUN` — Không có runtime AI, API key hay upload dữ liệu người dùng tới Rodin, ElevenLabs hoặc dịch vụ tạo sinh.
- [ ] `NOT RUN` — Personal event title/note không xuất hiện trong log, crash fixture hoặc widget lock screen mặc định.
- [ ] `NOT RUN` — Export, share và correction flow chỉ gửi sau hành động chủ động, cho xem nội dung trước.
- [ ] `NOT RUN` — Nếu audit phát hiện data collection, privacy label đã khai đủ cả partner SDK; không giữ đáp án “không thu thập”.

Guideline 5.1 yêu cầu privacy policy dễ tìm, data minimization và purpose string rõ. Apple cũng yêu cầu privacy answers ở cấp app bao gồm hành vi của third-party partner: [Manage app privacy](https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy/).

## E. Quyền hệ thống

- [ ] `NOT RUN` — Notification permission chỉ hỏi sau khi người dùng chủ động bật nhắc; từ chối vẫn dùng lịch và lưu event được.
- [ ] `NOT RUN` — Calendar access chỉ xuất phát từ “Thêm vào Lịch iPhone”; dùng system UI hoặc quyền ghi tối thiểu, không đọc toàn bộ lịch nếu không cần.
- [ ] `NOT RUN` — Purpose string mô tả đúng hành động và dữ liệu.
- [ ] `NOT RUN` — Không xin Contacts, Location, Photos, Camera, Microphone, Health hoặc Bluetooth trong phạm vi 1.0.
- [ ] `NOT RUN` — Không dùng notification để gửi marketing; lời nhắc là local và do người dùng tạo.
- [ ] `NOT RUN` — Không bắt người dùng bật permission để xem nội dung cốt lõi.

## F. Dữ liệu lịch, nội dung và quyền tài sản

- [ ] `NOT RUN` — Golden corpus, oracle report và mọi khác biệt nguồn đã được owner ký.
- [ ] `NOT RUN` — Phạm vi lịch sử và năm công bố khớp engine; ngày trước 1976 có nhãn phù hợp.
- [ ] `NOT RUN` — Nếu có tốt/xấu, ruleset, nguồn, nhãn tham khảo và nút tắt đã qua gate; nếu chưa đủ thì field bị loại khỏi build/metadata.
- [ ] `NOT RUN` — Official/culture/almanac packs có hai reviewer và version/checksum.
- [ ] `NOT RUN` — Font, texture, poster, audio, model và ảnh tham chiếu có license/provenance.
- [ ] `NOT RUN` — Không dùng screenshot, artwork hoặc asset của đối thủ.
- [ ] `NOT RUN` — Quốc kỳ và ngôi sao được dựng, đo và duyệt thủ công; không crop hoặc animate làm biến dạng biểu tượng.
- [ ] `NOT RUN` — Asset Rodin bắt đầu từ ảnh tham chiếu có quyền qua Image-to-3D; không có Text-to-3D.

## G. Audio, effect và accessibility

- [ ] `NOT RUN` — First launch mặc định **Yên**; Hiên sớm, âm giấy và cue sự kiện là opt-in.
- [ ] `NOT RUN` — Audio tôn trọng Silent, VoiceOver, audio khác, interruption, call và headphone.
- [ ] `NOT RUN` — Mỗi ngày tối đa một hero; intro lắng xuống và không che vùng đọc.
- [ ] `NOT RUN` — Reduce Motion, Dim Flashing Lights, Low Power, thermal fallback và poster tĩnh hoạt động.
- [ ] `NOT RUN` — VoiceOver, chữ 200%, Increase Contrast, focus và vùng chạm 44 pt đã được test.
- [ ] `NOT RUN` — Gesture bóc/lật có nút và accessibility action tương đương.

## H. Monetization và lời hứa miễn phí

- [ ] `NOT RUN` — App Store price là Free và không có In-App Purchase/subscription được cấu hình.
- [ ] `NOT RUN` — Source/binary không có paywall, quảng cáo, offer wall hoặc đường dẫn bán tính năng số.
- [ ] `NOT RUN` — Không khóa widget, reminder, effect hay accessibility sau một nâng cấp trả phí.
- [ ] `BLOCKED` — Owner đã ký nguồn phí Apple Developer và kế hoạch bảo trì mà không dựa vào ads/paywall.

## I. App Review notes dự kiến

Điền đường dẫn thật trong build trước khi submit:

```
Lịch Nhà hoạt động không cần tài khoản; không có quảng cáo hoặc In-App Purchase.
Core calendar và content packs nằm trong app, không cần mạng.

Test local reminder:
1. Tờ hôm nay → Ngày gia đình → Thêm ngày gia đình.
2. Đặt tên fixture, chọn Âm lịch, bật nhắc, Lưu.
3. Từ chối quyền nếu hệ thống hỏi; sự kiện vẫn còn trong danh sách.

Test widget/deep link:
1. Thêm widget Lịch Nhà từ bộ widget.
2. Mở lichnha://day/2026-10-15 (ghi trong App Review notes khi submit archive).

Test effect và audio:
1. Mở ngày 2/9/2026 (Quốc khánh) từ tháng hoặc --date nếu debug.
2. Âm ở Yên khi cài mới (Cài đặt).
3. Bật Hiên sớm tại Cài đặt → Âm; Tắt hết âm một thao tác.

Không cần demo account, backend hoặc phần cứng ngoài iPhone hỗ trợ.
```

## J. Release sign-off

| Nhóm bằng chứng | File/ID build | Kết luận | Người ký |
|---|---|---|---|
| Functional + minimum functionality | Chưa có | `NOT RUN` | Chưa chỉ định |
| Calendar/reminder/offline | Chưa có | `NOT RUN` | Chưa chỉ định |
| Privacy + dependency + binary | Chưa có | `NOT RUN` | Chưa chỉ định |
| Content + culture + license | Chưa có | `NOT RUN` | Chưa chỉ định |
| Accessibility + performance | Chưa có | `NOT RUN` | Chưa chỉ định |
| Metadata + screenshots | Chưa có | `NOT RUN` | Chưa chỉ định |

Không gửi App Review nếu còn P0/P1, còn dòng `NOT RUN` bắt buộc hoặc metadata mô tả thứ chưa có trong build.
