# App Store metadata — bản nháp

**Trạng thái:** `DRAFT · chưa dán Connect`
**Ngày soạn:** 07/09/2026; đối chiếu binary 09/09/2026
**Ngôn ngữ gốc:** Tiếng Việt
**Tên phát hành:** chưa chốt.

Không dán nội dung này vào App Store Connect trước khi build có đủ tính năng được nhắc tới và các claim đã qua checklist ở cuối file.

## Bộ metadata ứng viên

| Trường | Nội dung ứng viên | Trạng thái |
|---|---|---|
| Tên | **Lịch Nhà** | Tên làm việc; cần tra cứu tên và owner duyệt |
| Subtitle | **Lịch âm trong nếp nhà** | Cần kiểm tra giới hạn ký tự hiện hành |
| Primary category | Utilities | Cần owner xác nhận trong App Store Connect |
| Secondary category | Lifestyle | Tùy chọn; cần owner xác nhận |
| Promotional text | **Một tờ lịch Việt dịu mắt, mở ra là thấy hôm nay.** | Chỉ dùng nếu màn Today đã hoàn chỉnh |
| Keywords ứng viên | `lịch âm,lịch việt,ngày âm,lịch bloc,ngày giỗ,tiết khí` | Rà trùng lặp, độ dài và trademark trước khi nhập |

## Mô tả ứng viên

Lịch Nhà đưa dáng quen của một quyển lịch bloc Việt Nam lên iPhone. Mở ứng dụng là thấy tờ hôm nay với ngày dương, ngày âm và thông tin cần đọc trước; phần giải thích và nguồn nằm ở mặt sau khi bạn muốn tra kỹ hơn.

Bạn có thể xem tháng, đổi ngày, lưu ngày gia đình theo lịch âm hoặc dương, đặt lời nhắc cục bộ và xem ngày nhanh trên widget. Với ngày lễ hoặc tiết khí, không gian quanh tờ lịch có thể đổi bằng một cảnh ngắn rồi lắng xuống; luôn có bản tĩnh và chế độ giảm chuyển động.

Lịch Nhà được thiết kế để hoạt động offline, không cần tài khoản, không quảng cáo và không có paywall. Dữ liệu sự kiện cá nhân nằm trên thiết bị. Âm nền mặc định là **Yên**; Hiên sớm, tiếng giấy và cue sự kiện chỉ phát khi bạn chủ động bật.

Nội dung lịch truyền thống, nếu có trong build phát hành, chỉ để tham khảo và phải kèm nguồn, phương pháp cùng phạm vi áp dụng. Phạm vi năm chính xác chỉ được ghi sau khi bộ ngày chuẩn và hai đường đối chiếu đã pass.

## Claim guardrail

| Claim | Quy tắc xuất bản | Bằng chứng cần có |
|---|---|---|
| “đầu tiên”, “duy nhất”, “không app nào khác” | **Cấm dùng** | Thị trường đã có sản phẩm với các lời hứa tương tự |
| “giúp tập trung”, “học tốt hơn”, “white noise có lợi” | **Cấm dùng** | Không có bằng chứng cho lợi ích phổ quát; Gate 7 chưa chạy |
| “chính xác tuyệt đối” hoặc “đúng cho mọi thời kỳ” | **Cấm dùng** | Lịch sử và oracle có giới hạn |
| “vạn niên” như claim không giới hạn | **Cấm dùng** | Phải ghi phạm vi năm đã test thay cho cách nói mở |
| “miễn phí, không quảng cáo, không paywall” | Chỉ publish khi đúng toàn bộ build và mô hình vận hành | Audit binary, StoreKit/IAP config và cam kết owner |
| “không cần tài khoản” | Chỉ publish khi không có sign-in hay account dependency | Flow audit và dependency audit |
| “dùng offline” | Chỉ publish cho các chức năng đã pass airplane-mode | T151 và quickstart output |
| “dữ liệu nằm trên thiết bị” | Chỉ publish sau data-flow audit | Binary, network, App Group, log và SDK audit |
| “1900–2100” | Chỉ publish nếu đó là phạm vi corpus đã pass | T017, golden corpus, property/regression tests |
| “phong tục Việt Nam” | Ghi rõ phạm vi và tránh đại diện cho mọi gia đình/vùng | Nguồn, content reviewer và language audit |

## Kịch bản screenshot

App Store Connect hiện nhận từ một đến mười screenshot. Kích thước và device class phải kiểm tra lại lúc upload trong [Screenshot specifications](https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications/). Bộ dưới đây có tám ảnh dọc; chưa có ảnh nào được chụp.

| Thứ tự | Headline dự kiến | Màn hình/build state phải chụp | Điều cần thấy | Điều không được dựng giả |
|---:|---|---|---|---|
| 1 | **Một tờ lịch cho hôm nay** | Today, ngày fixture đã qua golden corpus | Số ngày dương lớn, ngày âm rõ, khánh–giấy–son của Mộc Son Dịu | Kết quả lịch chưa kiểm chứng, badge giải thưởng |
| 2 | **Đọc nhanh, tra nguồn khi cần** | Mặt trước rồi mặt sau của cùng ngày | Thứ bậc thông tin và đường tới nguồn/version | Nguồn không có trong build |
| 3 | **Cả tháng vẫn giữ dáng giấy** | Month sheet có ngày tràn, rằm/mùng một và ngày lễ | Grid custom, ngày chọn, Dynamic Type chuẩn | Dashboard/tab bar không tồn tại |
| 4 | **Ngày nhà, nhớ theo cách nhà mình** | Tạo sự kiện âm lịch bằng dữ liệu fixture | Policy tháng nhuận/tháng thiếu được đọc lại | Tên hoặc ngày giỗ của người thật |
| 5 | **Liếc widget là biết ngày** | Widget thật ở trạng thái light/dark hoặc tinted đã pass | Ngày dương/âm và privacy mặc định | Animation trong widget hoặc lịch tương lai sai |
| 6 | **Mùa ghé qua, rồi lắng xuống** | Một scene đã ship và poster Reduce Motion tương ứng | Hiệu ứng nằm ngoài content safe zone | Cờ do AI tạo, cảnh chưa có trong pack |
| 7 | **Mặc định là Yên** | Sound settings ở trạng thái first launch | Yên đang chọn; Hiên sớm là opt-in | Lời hứa tăng tập trung hoặc autoplay giả |
| 8 | **Chữ lớn vẫn là Lịch Nhà** | Today ở chữ 200% và VoiceOver-ready state | Reflow, action thay gesture, tương phản đọc được | Overlay mô phỏng accessibility chưa chạy |

### Quy tắc art direction cho screenshot

- Chụp UI thật từ build đã chọn; lớp headline bên ngoài chỉ giải thích, không làm giả control.
- Giữ một tiêu điểm mỗi ảnh. Caption ngắn, cỡ đọc được trên thumbnail và tương phản tối thiểu 4.5:1.
- Dùng pastel ít bão hòa, giấy ngà và đỏ son làm điểm nhấn; không thêm sticker chibi, emoji hay clay button để “trẻ hóa”.
- Không crop sai Quốc kỳ, không dùng artwork đối thủ và không để dữ liệu gia đình thật trong ảnh.
- Xuất `.png`, `.jpg` hoặc `.jpeg` theo kích thước Apple đang nhận; không dùng alpha. Kiểm tra lại yêu cầu tại ngày upload.

## App Review notes ứng viên

```
Lịch Nhà không có tài khoản, quảng cáo, In-App Purchase hoặc backend.
Mọi chức năng cốt lõi chạy offline. Dữ liệu demo trong review là fixture.
Âm nền mặc định Yên; reviewer có thể bật Hiên sớm tại [đường dẫn màn hình].
Để thử lời nhắc: [các bước sẽ điền theo build].
Để thử widget và deep link: [các bước sẽ điền theo build].
Không cần demo account.
```

## Điều kiện chuyển khỏi `DRAFT`

- Tên, subtitle, category, support URL và marketing URL có owner.
- Mọi tính năng trong description tồn tại trong binary gửi review.
- Privacy copy khớp `app-store-privacy.md` và policy đã công bố.
- Airplane, reminder, widget, accessibility và performance report đã chạy trên máy thật (Simulator 09/09 chưa đủ).
- Screenshot lấy từ build thật, đúng device class và không chứa dữ liệu riêng.
- Metadata được rà theo [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) hiện hành.
