# Chính sách quyền riêng tư — bản nháp

**Trạng thái:** `SOURCE REVIEWED · chưa công bố`
**Ngày soạn:** 07/09/2026; rà source 09/09/2026
**Tên sản phẩm:** Lịch Nhà là tên làm việc, chưa phải tên phát hành.

Đây là nội dung dự kiến cho phiên bản 1.0, chưa phải chính sách đã công bố. Chỉ phát hành văn bản sau khi đối chiếu với source code, dependency, privacy manifest, binary và cấu hình App Store Connect của đúng build gửi duyệt.

## Nội dung dự kiến công bố

### Lịch Nhà lưu gì

Lịch Nhà được thiết kế để dùng mà không cần tài khoản. Ứng dụng không có quảng cáo, gói nâng cấp hay paywall.

Ngày gia đình, ghi chú, lựa chọn nhắc, thiết lập hiển thị, trạng thái tờ lịch và tùy chọn âm thanh được lưu trên thiết bị. App và widget có thể dùng vùng App Group của iOS để chia sẻ đúng phần dữ liệu cần cho widget và lời nhắc. Widget trên màn hình khóa mặc định không hiện tên hoặc ghi chú sự kiện riêng.

Âm nền ở trạng thái **Yên** khi cài mới. Hiên sớm, tiếng giấy và cue sự kiện chỉ phát sau khi người dùng chủ động bật; lựa chọn này cũng được lưu cục bộ.

### Dữ liệu không gửi về máy chủ của Lịch Nhà

Kiến trúc 1.0 không có backend, tài khoản, SDK quảng cáo hay SDK analytics. Lịch Nhà không bán dữ liệu và không dùng dữ liệu để theo dõi người dùng giữa các ứng dụng hoặc website.

Ứng dụng không gọi AI lúc chạy. Rodin, ElevenLabs hoặc công cụ tạo asset khác chỉ được dùng trong quá trình sản xuất bằng đầu vào do dự án sở hữu hoặc có quyền dùng; chúng không nhận ngày gia đình, ghi chú hay dữ liệu trên thiết bị của người dùng.

Những câu trên là cam kết thiết kế. Chúng chỉ trở thành tuyên bố phát hành sau khi audit binary xác nhận không có endpoint, SDK hoặc hành vi truyền dữ liệu ngoài phạm vi đã ghi.

### Quyền hệ thống

- **Thông báo:** chỉ được hỏi khi người dùng chủ động bật một lời nhắc. Từ chối quyền không chặn việc xem lịch hoặc lưu sự kiện.
- **Lịch iPhone:** luồng dự kiến là hành động chủ động “Thêm vào Lịch iPhone” qua giao diện hệ thống hoặc quyền ghi tối thiểu. Lịch Nhà không cần đọc toàn bộ lịch của người dùng.
- **Danh bạ, vị trí, ảnh, camera và microphone:** không thuộc phạm vi 1.0.

Quyền cuối cùng và câu mô tả quyền phải được kiểm tra trên build phát hành. Nếu phạm vi thay đổi, chính sách này phải đổi trước khi gửi review.

### Dữ liệu do người dùng chủ động đưa ra ngoài ứng dụng

Khi người dùng xuất dữ liệu, thêm một sự kiện sang Lịch iPhone, dùng share sheet hoặc gửi báo lỗi, dữ liệu sẽ đi tới nơi họ chọn và có thể chịu chính sách của dịch vụ đó. Lịch Nhà không tự gửi tên ngày giỗ, ghi chú, ảnh màn hình hoặc log.

Luồng báo lỗi phải cho người dùng xem và sửa nội dung trước khi gửi. Mẫu hỗ trợ nhắc họ xóa tên thật, ngày giỗ thật và thông tin gia đình không cần thiết.

### Lưu giữ và xóa

Trong thiết kế hiện tại, dữ liệu cá nhân nằm trên thiết bị cho tới khi người dùng xóa từng mục, dùng chức năng xóa dữ liệu của ứng dụng hoặc gỡ ứng dụng. Cách App Group, backup thiết bị và dữ liệu đã xuất hoạt động phải được kiểm tra trên bản cài thật trước khi công bố hướng dẫn xóa cuối cùng.

Không có tài khoản máy chủ để yêu cầu xóa từ xa. Nếu một kênh hỗ trợ nhận email hoặc tệp do người dùng tự gửi, owner hỗ trợ phải công bố thời hạn giữ và cách yêu cầu xóa riêng cho kênh đó.

### Trẻ em

Lịch Nhà không được định vị cho Kids Category và không yêu cầu người dùng khai tuổi. Age rating cuối cùng phải dựa trên nội dung thật của build và effect pack.

### Liên hệ và sửa dữ liệu lịch

- Email hỗ trợ: `[OWNER TO FILL]`
- Trang hỗ trợ: `[URL TO FILL]`
- Privacy Policy URL: `[URL TO FILL]`
- Ngày chính sách có hiệu lực: `[RELEASE DATE TO FILL]`

Báo lỗi lịch cần kèm ngày dương, kết quả đang thấy, phiên bản engine/content pack và nguồn đối chiếu nếu có. Không gửi tên người thân hoặc ghi chú riêng.

## Kiểm tra trước khi công bố

| Mục | Trạng thái |
|---|---|
| Source/dependency không có ads, paywall, account, analytics hoặc runtime AI | `CODE REVIEWED` 09/09/2026 |
| Network và data-flow audit khớp nội dung trên | `CODE REVIEWED` (không URLSession); traffic máy thật `NOT RUN` |
| Privacy manifest khớp API/dependency thật | `PARTIAL` UserDefaults CA92.1; archive Privacy Report `NOT RUN` |
| Xóa dữ liệu và gỡ app đã thử trên thiết bị | `NOT RUN` |
| Widget lock-screen không lộ title/note mặc định | `UNIT TEST`; Home/Lock thật `NOT RUN` |
| Luồng notification và Calendar permission đúng thời điểm | `UI TEST` Simulator; máy thật `NOT RUN` |
| Support/retention owner đã điền và ký | `BLOCKED` |
| Privacy Policy URL mở được trong app và App Store Connect | `NOT RUN` |

Apple yêu cầu iOS app có Privacy Policy URL, khai đúng cách xử lý dữ liệu và giữ câu trả lời cập nhật. Đối chiếu lại [App Review Guidelines, mục 5.1](https://developer.apple.com/app-store/review/guidelines/) và [Manage app privacy](https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy/) ở mỗi lần phát hành.
