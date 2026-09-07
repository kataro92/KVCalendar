# Research: Lịch Nhà 1.0

Tài liệu này gom các quyết định kỹ thuật đã có đủ bằng chứng để lập kế hoạch. Các câu hỏi cần người
dùng thật vẫn nằm trong `docs/06-ke-hoach-kiem-chung.md` và được đưa vào đầu `tasks.md`.

## Nền tảng

**Decision**: Dùng native iOS với Swift và SwiftUI; iPhone, iOS 17 trở lên cho 1.0.

**Rationale**: Widget, local notification, Dynamic Type, VoiceOver, haptic, audio session và vòng
đời ứng dụng là phần lõi. Native giảm bridge, startup và công việc bảo trì trong một sản phẩm chỉ
nhắm iOS ở giai đoạn đầu.

**Alternatives considered**: Flutter và React Native có renderer tùy biến tốt nhưng vẫn cần native
cho widget cùng edge case hệ thống. Godot và Three.js/WebView tăng chi phí accessibility, memory và
lifecycle so với lợi ích của một scene trang trí nhỏ.

## Phân lớp render

**Decision**: Dùng semantic views cho chữ, control và form; Canvas/shape/shader cho giấy, bóng,
particle và page deformation; RealityKit chỉ cho 1–2 prop nhỏ.

**Rationale**: Canvas không cung cấp interactivity hoặc accessibility cho từng element. Tách lớp
giữ được giao diện riêng mà không biến ngày tháng thành bitmap. Page curl bắt đầu bằng mask,
transform và shadow; chỉ nâng lên shader khi prototype mức thấp không đạt cảm giác hoặc frame rate.

**Alternatives considered**: Vẽ cả màn hình bằng một Canvas hoặc dùng engine 3D toàn màn hình.
Hai hướng này làm text scaling, VoiceOver, input và widget khó kiểm soát hơn.

## Calendar Core

**Decision**: Viết Calendar Core deterministic theo lịch Việt UTC+7, dùng mô tả thuật toán đã kiểm
giấy phép làm tài liệu tham chiếu, không dùng `Calendar.Identifier.chinese` làm nguồn sự thật.

**Rationale**: Lịch Việt có thể khác lịch Trung Quốc ở ngày Sóc gần nửa đêm. Engine cần tách khỏi
UI, content và ruleset tốt/xấu để test round-trip, tháng nhuận, tiết khí và Can Chi độc lập.

**Alternatives considered**: API lịch từ xa bị loại vì offline, riêng tư và rủi ro nguồn thay đổi.
Port mã ngẫu nhiên bị loại nếu không có giấy phép, corpus và đối chiếu độc lập.

## Lịch sử và múi giờ

**Decision**: Công bố 1900–2100. Từ 1976 dùng lịch Việt hiện đại UTC+7; giai đoạn 1900–1975 có
nhãn hồi chiếu cùng ngoại lệ lịch sử. “Hôm nay” theo ngày địa phương, có tùy chọn nhịp Việt Nam;
notification mặc định theo giờ địa phương.

**Rationale**: Cách tính lịch, ranh giới ngày hiển thị và giờ giao thông báo là ba quyết định khác
nhau. Tách chúng giúp người ở nước ngoài theo lịch Việt mà vẫn nhận nhắc theo đời sống nơi ở.

**Alternatives considered**: Dùng múi giờ thiết bị cho toàn bộ engine hoặc buộc mọi người theo
UTC+7. Cả hai làm sai một trong hai nhu cầu.

## Lưu trữ

**Decision**: Dùng SwiftData trong App Group cho Personal Event và preference; data pack là bundle
JSON chỉ đọc, có schema version và checksum; widget đọc snapshot đã chuẩn bị.

**Rationale**: iOS 17 là deployment target dự kiến. SwiftData đủ cho dữ liệu cá nhân nhỏ và hỗ trợ
migration/test. Tách pack chỉ đọc giúp sửa nội dung mà không thay schema cá nhân.

**Alternatives considered**: Core Data vẫn khả thi nếu thử nghiệm App Group của SwiftData không
ổn định trên target đã chọn. SQLite trực tiếp không có lợi ích đủ lớn cho quy mô này. Cloud database
trái với lời hứa offline và không tài khoản.

## Reminder

**Decision**: Sinh occurrence âm sang ngày dương trong một cửa sổ hữu hạn; làm mới khi app active,
ngày/múi giờ/quyền/settings/app version đổi. Event và trạng thái notification tách nhau.

**Rationale**: Lịch âm không thể dùng một Gregorian repeating trigger cố định. Cửa sổ có giới hạn
cho phép tôn trọng giới hạn pending notification của hệ thống mà không đánh mất event gốc.

**Alternatives considered**: Lưu ngày dương của năm hiện tại hoặc lập trigger lặp trực tiếp. Cả hai
sai ở năm kế, tháng nhuận hoặc tháng thiếu.

## Widget

**Decision**: Widget dùng timeline entries đã chuẩn bị, dữ liệu tối thiểu trong App Group, poster
tĩnh và deep link. Nội dung sự kiện cá nhân bị ẩn trên lock screen theo mặc định.

**Rationale**: Hệ thống quyết định lịch refresh; widget không nên chạy engine nội dung nặng hoặc
dựa vào mạng. Snapshot cho vài ngày giúp hiển thị có nghĩa khi refresh đến muộn.

**Alternatives considered**: Animation bóc giấy và scene live trong widget bị loại. Chúng không hợp
giới hạn WidgetKit và không cải thiện việc xem nhanh.

## Effect Director và asset

**Decision**: Resolver deterministic chọn một hero effect theo event ID, tone, priority, vùng và
trạng thái máy. Asset ship local; mỗi model có LOD và poster. Rodin chỉ tạo phôi từ ảnh tham chiếu
đã duyệt qua Image-to-3D. Quốc kỳ được dựng tay.

**Rationale**: Occurrence cho biết ngày gì, Effect Cue cho biết cách thể hiện. Tách hai pack tránh
để lỗi hình ảnh làm mất dữ liệu lịch và cho phép fallback tĩnh. Reference-first giữ silhouette,
vật liệu, quyền và chi tiết văn hóa trong vòng duyệt của dự án.

**Alternatives considered**: So khớp tên sự kiện, runtime generation, Text-to-3D và scene 3D toàn
phòng đều bị loại vì độ tin cậy, pin, accessibility hoặc provenance.

## Âm thanh

**Decision**: Tách nền tập trung, phản hồi giấy và cue sự kiện. Bản cài mới chọn Yên; Hiên sớm là
ứng viên prototype và chỉ phát sau khi người dùng chủ động chọn. Âm giấy và cue sự kiện tắt. Audio
session phải mix, tôn trọng Silent, VoiceOver, cuộc gọi và audio khác.

**Rationale**: Bằng chứng về white/pink noise không cho phép hứa tăng tập trung cho mọi người.
Gate nghiên cứu quyết định sau này có đủ cơ sở đổi Hiên sớm từ opt-in thành bật có điều kiện hay không.

**Alternatives considered**: Nhạc, lời nói, loop ngắn hoặc tự tăng âm lượng bị loại vì dễ gây mất
tập trung và xung đột với hành vi hệ thống.

## Desk research và persona tổng hợp

**Decision**: Dùng desk research cùng proto-persona để tìm mâu thuẫn, case biên và phương án
prototype có thể đảo ngược. Không dùng chúng làm participant, quote, tỷ lệ, usability result hoặc
Gate 1–7.

**Rationale**: Không có người dùng thật ở vòng hiện tại. Nguồn phương pháp cho thấy synthetic users
phù hợp hơn với hypothesis generation và cần công bố population, grounding cùng ecological validity.
Sổ chứng cứ, phương pháp và self-discussion nằm trong `research/desk-research/` và
`research/synthetic-panel/`.

**Alternatives considered**: Điền session/scorecard giả hoặc xem phản hồi LLM như consensus bị loại
vì tạo certainty không có bằng chứng và có thể che stereotype.

## Kiểm thử và phát hành dữ liệu

**Decision**: TDD cho Calendar Core, Reminder Core, pack resolver và migration. Mỗi bug lịch thành
regression fixture. Data pack qua schema validation, golden/property tests, preview ngẫu nhiên và
hai người duyệt trước release.

**Rationale**: Sai lịch và sai reminder có tác động cao hơn lỗi trang trí. Kiểm thử theo module và
contract cho phép khóa các ranh giới trước khi UI hoàn thiện.

**Alternatives considered**: Chỉ kiểm vài ngày lễ hoặc so theo “đa số website”. Hai cách không tìm
được lỗi ranh giới và không giải thích được khác biệt nguồn.
