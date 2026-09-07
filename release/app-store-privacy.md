# App Store Privacy — worksheet bản nháp

**Trạng thái:** `DRAFT · NOT RUN`
**Ngày soạn:** 07/09/2026
**Kết luận App Store Connect:** chưa chọn.

Apple yêu cầu câu trả lời ở cấp ứng dụng phản ánh cả code của dự án lẫn đối tác/SDK được tích hợp. Phương án mong muốn là **“No, we do not collect data from this app”**, nhưng không được chọn phương án đó trước khi audit đúng binary phát hành.

Nguồn quy trình kiểm tra ngày 07/09/2026: [Manage app privacy](https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy/). Privacy Policy URL vẫn là trường bắt buộc cho iOS ngay cả khi kết luận là không thu thập.

## Data-flow dự kiến

| Dữ liệu/chức năng | Nơi xử lý dự kiến | Có rời thiết bị qua code Lịch Nhà? | Cần xác minh trên build |
|---|---|---:|---|
| Ngày dương/âm, Can Chi, tiết khí | Bundle và Calendar Core cục bộ | Không | Không có API/network fallback |
| Tên ngày gia đình và ghi chú | Personal Store trên thiết bị | Không | Log, crash report, backup và migration không lộ nội dung |
| Cài đặt, vùng cảm hứng, trạng thái bóc, tùy chọn âm | Store cục bộ/App Group; âm mặc định **Yên** | Không | Chỉ field tối thiểu được chia sẻ cho widget |
| Lời nhắc | Reminder Core và local notification | Không qua server dự án | Nội dung notification, quyền và reschedule behavior |
| Widget snapshot | App Group cục bộ | Không | Lock screen ẩn title/note mặc định |
| Thêm vào Lịch iPhone | System UI hoặc quyền ghi tối thiểu sau hành động người dùng | Có thể đi vào calendar account do người dùng chọn; không về Lịch Nhà | Không xin full read nếu không cần; purpose string/flow đúng |
| Báo lỗi | Người dùng xem rồi tự gửi qua kênh đã chọn | Chỉ khi người dùng chủ động | Nội dung mặc định không kèm title/note/log nhạy cảm |
| Export/share | Tệp hoặc share sheet do người dùng khởi tạo | Chỉ tới đích người dùng chọn | Cảnh báo nội dung và metadata của file |
| Rodin/ElevenLabs/AI | Chỉ trong pipeline sản xuất asset, ngoài runtime | Không | Không có SDK, API key, endpoint hay upload runtime |

## Câu trả lời dự kiến, chưa được publish

| Câu hỏi | Phương án dự kiến | Trạng thái |
|---|---|---|
| Developer hoặc third-party partner có thu thập dữ liệu từ app không? | **Không**, nếu binary audit xác nhận mọi data flow ở trên chỉ cục bộ hoặc do người dùng chủ động xuất | `NOT RUN` |
| App có tracking không? | **Không**; không có ads, cross-app/site tracking hoặc device graph trong phạm vi 1.0 | `NOT RUN` |
| Có dùng dữ liệu cho quảng cáo/marketing bên thứ ba không? | **Không** | `NOT RUN` |
| Có account data không? | **Không**; ứng dụng không có đăng nhập/tài khoản | `NOT RUN` |
| Có analytics trong app không? | **Không** theo kiến trúc dự kiến | `NOT RUN` |
| Có crash/diagnostic SDK bên thứ ba không? | **Không** theo dependency allowlist dự kiến | `NOT RUN` |

Nếu audit tìm thấy bất kỳ dữ liệu nào được truyền khỏi thiết bị và phù hợp định nghĩa “collect” của Apple, phải đổi câu trả lời sang **Có**, khai đủ data type, purpose, linkage và tracking. Không được sửa cách diễn đạt để né khai báo.

## Binary và dependency audit

| Kiểm tra | Owner | Trạng thái | Bằng chứng cần lưu |
|---|---|---|---|
| Liệt kê Swift Package/CocoaPods/framework nhúng | `[TO FILL]` | `NOT RUN` | Lockfile, build graph, dependency allowlist |
| Tìm ads, StoreKit/IAP, attribution và tracking SDK | `[TO FILL]` | `NOT RUN` | Dependency + symbol/string scan |
| Tìm analytics, crash upload, telemetry và remote config | `[TO FILL]` | `NOT RUN` | Source/binary/network scan |
| Tìm endpoint, `URLSession`, WebSocket và upload task | `[TO FILL]` | `NOT RUN` | Source scan và traffic capture |
| Kiểm tra log không có title/note | `[TO FILL]` | `NOT RUN` | Privacy tests và redacted sample |
| Kiểm tra App Group/widget payload tối thiểu | `[TO FILL]` | `NOT RUN` | Snapshot schema và device inspection |
| Kiểm tra notification content/permission timing | `[TO FILL]` | `NOT RUN` | UI test và device recording |
| Kiểm tra EventKit scope và purpose string | `[TO FILL]` | `NOT RUN` | Entitlement/API scan và denied-flow test |
| Kiểm tra không có runtime AI/API key | `[TO FILL]` | `NOT RUN` | Secret scan, dependency scan, network test |
| Kiểm tra privacy manifest và required-reason APIs | `[TO FILL]` | `NOT RUN` | `PrivacyInfo.xcprivacy` + archive report |
| So App Store answers với đúng version/build | `[TO FILL]` | `NOT RUN` | App Store Connect export/screenshot |

## Quyền và dữ liệu không được thêm âm thầm

- Không Contacts, Location, Photos, Camera, Microphone, Health hoặc Bluetooth trong phạm vi 1.0.
- Notification chỉ xin sau hành động bật nhắc.
- Calendar chỉ xuất theo hành động chủ động; không đọc toàn bộ lịch nếu không có feature đã duyệt riêng.
- Không ATT prompt nếu không có tracking. Nếu phạm vi tracking thay đổi, phải quay lại product/privacy review trước implementation.

## Ký phát hành

| Vai trò | Người ký | Ngày | Kết luận |
|---|---|---|---|
| Engineering owner | Chưa chỉ định | — | `NOT RUN` |
| Privacy reviewer | Chưa chỉ định | — | `NOT RUN` |
| App Store Connect Account Holder/App Manager | Chưa chỉ định | — | `NOT RUN` |

Không publish privacy answers cho tới khi cả ba vai trò cùng đối chiếu bản policy, binary, dependency và Product Page Preview.
