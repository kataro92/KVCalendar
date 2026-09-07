# Draft — support matrix và quyền sở hữu phát hành

Ngày cập nhật: **07/09/2026**
Trạng thái: **BLOCKED — chưa có tên owner, thiết bị test và nguồn phí**
Liên kết task: T019 vẫn để mở.

## Phương án kỹ thuật đang dùng để lập kế hoạch

| Mục | Phương án tạm | Cần ai chốt |
|---|---|---|
| Nền tảng 1.0 | iPhone dọc, iOS 17 trở lên; iPad ở vòng sau | product + engineering owner |
| Thiết bị thấp nhất | một iPhone thật chạy đúng iOS thấp nhất được hỗ trợ | engineering owner |
| Thiết bị màn nhỏ | ít nhất một iPhone màn hình nhỏ để test layout/chữ | QA owner |
| Thiết bị hiện hành | một iPhone đời mới để test hiệu ứng/ProMotion nếu có | QA owner |
| Accessibility | VoiceOver, chữ 200%, Reduce Motion, Increase Contrast, Dim Flashing Lights | accessibility reviewer |
| Múi giờ | Asia/Ho_Chi_Minh; ít nhất một zone có DST; biên lệch ngày Việt Nam/local | Calendar Core owner |
| Offline | airplane mode cho app, widget, reminder và pack | QA owner |

Tên model cụ thể chưa được điền vì dự án chưa có inventory thiết bị. Simulator không thay cho test audio, haptic, hiệu năng, nhiệt, widget và accessibility trên máy thật.

## Owner bắt buộc trước T020

| Trách nhiệm | Owner | Trạng thái |
|---|---|---|
| trả phí Apple Developer hằng năm | Chưa chỉ định | `BLOCKED` |
| giữ tài khoản, certificate và quyền App Store Connect | Chưa chỉ định | `BLOCKED` |
| duyệt Calendar Core/golden corpus | Chưa chỉ định | `BLOCKED` |
| duyệt ruleset tốt/xấu nếu ship | Chưa chỉ định | `BLOCKED` |
| duyệt văn hóa/Quốc kỳ/cảnh trang nghiêm | Chưa chỉ định | `BLOCKED` |
| xử lý báo lỗi dữ liệu và phát hành bản sửa | Chưa chỉ định | `BLOCKED` |
| review privacy label theo binary | Chưa chỉ định | `BLOCKED` |

## Cam kết vận hành cần ký

- ứng dụng miễn phí cho người tải, không quảng cáo, paywall hay bán dữ liệu;
- không thêm SDK analytics/ads chỉ để bù chi phí mà không sửa lại lời hứa và privacy review;
- có lịch kiểm tra data pack ngày nghỉ hằng năm;
- có kênh nhận báo lỗi lịch và thời gian phản hồi dự kiến;
- giữ source/provenance của font, artwork, Rodin và ElevenLabs;
- có người thay thế nếu owner chính không còn duy trì.

[Apple Developer Program](https://developer.apple.com/programs/) hiện là chi phí của nhà phát triển và có thể thay đổi; phải kiểm tra lại tại thời điểm đăng ký/gia hạn. Tài liệu này không tự chỉ định người trả phí.

## Điều kiện hoàn tất T019

Điền tên/role có trách nhiệm, inventory thiết bị, deployment target cuối, nguồn phí tối thiểu một năm, chu kỳ bảo trì và phương án bàn giao tài khoản. Cho tới đó, đây chỉ là khung quyết định.
