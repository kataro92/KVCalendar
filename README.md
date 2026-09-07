# KVCalendar — hồ sơ nghiên cứu sản phẩm

Trạng thái: **nghiên cứu và đặc tả, chưa triển khai mã nguồn**
Mốc nghiên cứu thị trường: **07/09/2026**
Tên sản phẩm trong tài liệu: **Lịch Nhà** (tên làm việc, chưa phải tên phát hành)

## Kết luận ngắn

Không nên làm thêm một ứng dụng “lịch âm + tử vi + tin tức” giống thị trường. Hướng có cơ hội tạo khác biệt là một **quyển lịch bloc Việt Nam sống trên iPhone dành trước hết cho người trẻ**: mở app là thấy đúng một tờ của hôm nay, có thể kéo và bóc tờ bằng ngón tay, có độ dày của xấp giấy, tiếng giấy và phản hồi rung rất nhẹ, nhưng vẫn tra tháng, đổi ngày, tạo ngày giỗ và xem widget nhanh được. Hướng “Mộc Son Dịu” giữ chất giấy/gỗ Việt Nam, thêm pastel ít bão hòa, hình khối mềm và minh họa hơi dễ thương. “Nhịp Nhà” làm không khí quanh lịch thay đổi theo mùa, tiết khí và sự kiện rồi lắng xuống để nhường chỗ cho việc đọc.

Cam kết sản phẩm đề xuất:

- miễn phí cho người dùng, không quảng cáo, không gói nâng cấp, không đăng nhập;
- mọi chức năng cốt lõi chạy offline, dữ liệu cá nhân chỉ ở trên máy;
- thông tin lịch có phạm vi, nguồn và phiên bản rõ ràng;
- nội dung phong tục được ghi là “tham khảo theo truyền thống”, không giả làm kết luận khoa học;
- giao diện vẽ riêng theo ngôn ngữ giấy, gỗ, sơn son, đồng và pastel dịu; dễ thương theo kiểu trưởng thành, không giống app trẻ em;
- bản phát hành mặc định **Yên** cho tới khi có kiểm thử âm với người thật; “Hiên sớm” là lựa chọn chủ động và ứng viên prototype, luôn tôn trọng Silent, VoiceOver và audio khác; âm giấy và cue sự kiện tắt mặc định;
- hiệu ứng theo ngày chạy cục bộ, ngắn và có bản tĩnh; không gọi dịch vụ AI hoặc tải cảnh khi sử dụng;
- vẫn tôn trọng VoiceOver, cỡ chữ lớn, Reduce Motion và tương phản — “giao diện riêng” không đồng nghĩa với bỏ khả năng tiếp cận.

Lưu ý tài chính: app có thể miễn phí hoàn toàn với người tải, nhưng phát hành công khai lên App Store vẫn cần tài khoản Apple Developer, hiện là **99 USD/năm**. Đây là chi phí của nhà phát triển, không phải phí người dùng.

## Bộ tài liệu

1. [Định hướng sản phẩm](docs/00-dinh-huong-san-pham.md) — tầm nhìn, quyết định chiến lược, phạm vi và tiêu chí thành công.
2. [Nghiên cứu thị trường và người dùng](docs/01-nghien-cuu-thi-truong.md) — đối thủ, tín hiệu từ đánh giá App Store, giả thuyết người dùng và khoảng trống thị trường.
3. [Đặc tả sản phẩm](docs/02-dac-ta-san-pham.md) — luồng, màn hình, chức năng, trường hợp biên và thứ tự ưu tiên.
4. [Định hướng UX và mỹ thuật](docs/03-ux-va-my-thuat.md) — concept “lịch treo tường”, bố cục tờ lịch, vật liệu, màu, chữ, chuyển động, âm thanh và accessibility.
5. [Dữ liệu lịch và độ tin cậy](docs/04-du-lieu-va-do-tin-cay.md) — lịch âm Việt Nam, múi giờ, nguồn dữ liệu, phân tầng nội dung, nhắc lịch âm và chiến lược kiểm thử.
6. [Khả thi kỹ thuật và lộ trình](docs/05-kha-thi-va-lo-trinh.md) — lựa chọn công nghệ, kiến trúc khái niệm, riêng tư, chi phí, rủi ro và các giai đoạn.
7. [Kế hoạch kiểm chứng](docs/06-ke-hoach-kiem-chung.md) — prototype, nghiên cứu thực địa, usability test và cổng quyết định trước khi code.
8. [Nguồn tham khảo](docs/07-nguon-tham-khao.md) — nguồn đã dùng, thời điểm truy cập và mức độ tin cậy.
9. [Hệ đạo diễn theo mùa và sự kiện](docs/08-he-dao-dien-theo-ngay.md) — cảnh Quốc khánh/Lập Xuân, luật phối nhiều sự kiện, pipeline Rodin/ElevenLabs, hiệu năng, accessibility và kiểm chứng.
10. [Quy trình AI và asset](docs/09-quy-trinh-ai-va-asset.md) — cách dùng kỹ năng AI, quy trình Rodin Image-to-3D, provenance và cổng duyệt asset.
11. [Mộc Son Dịu và âm nền tập trung](docs/10-moc-son-diu-va-am-nen.md) — định vị người trẻ, pastel trưởng thành, ba lớp âm và cách kiểm chứng white/pink noise.
12. [Nghiên cứu tổng hợp và persona mô phỏng](docs/11-nghien-cuu-tong-hop-va-persona-mo-phong.md) — trả lời tạm 11 câu hỏi, giới hạn của nghiên cứu không người thật và trạng thái sẵn sàng.

Hồ sơ chuẩn bị phát hành và audit tài liệu:

- [Sổ chứng cứ web](research/desk-research/evidence-register.md), [ma trận hoàn tất tài liệu](research/desk-research/documentation-completion-matrix.md) và [biên bản self-discussion](research/synthetic-panel/deliberation.md).
- [Decision log Gate](research/decisions/001-research-gates.md), [nguồn lịch](research/decisions/002-calendar-sources.md), [ruleset tốt/xấu](research/decisions/003-almanac-ruleset.md), [quyền phát hành](research/decisions/004-release-ownership.md) và [DoR](research/decisions/005-ready-to-code.md).
- [Storyboard bốn cảnh lễ](assets/storyboards/release-1-holiday-scenes.md), [license ledger](assets/release/license-audit.md), [compliance audit](release/constitution-compliance.md) và các draft trong `release/`.

## Cấu hình cho AI agent

- [AGENTS.md](AGENTS.md) là chỉ dẫn chung và ranh giới của dự án.
- [.agents/README.md](.agents/README.md) liệt kê kỹ năng cục bộ và workflow cần dùng.
- [Design Master](design-system/lich-nha/MASTER.md) là nguồn quyết định UI/UX dài hạn.
- `.cursor/rules/` chứa rule theo loại file cho Cursor và các agent tương thích.

Kỹ năng và GitHub Spec Kit được chốt theo phiên bản trong [.agents/SOURCES.md](.agents/SOURCES.md). Chúng là công cụ hỗ trợ agent, không phải mã của ứng dụng.

## Spec Kit và backlog 1.0

- [Hiến pháp Lịch Nhà](.specify/memory/constitution.md) giữ các nguyên tắc không thương lượng.
- [Specification 1.0](specs/001-lich-nha-v1/spec.md) gom sáu user story và tiêu chí chấp nhận.
- [Implementation plan](specs/001-lich-nha-v1/plan.md) chốt ranh giới module và cách kiểm thử.
- [Tasks 1.0](specs/001-lich-nha-v1/tasks.md) có 166 task theo phụ thuộc. T001–T020 là
  Definition of Ready; chưa được bắt đầu mã nguồn trước khi T020 pass.

## Quyết định nên chốt trước khi bắt đầu code

Các tài liệu đã đưa ra phương án khuyến nghị, nhưng sáu quyết định sau vẫn nên được người chủ sản phẩm duyệt:

1. Dùng tên làm việc **Lịch Nhà** hay chọn một tên khác.
2. Bản đầu chỉ hỗ trợ iPhone hay làm iPad cùng lúc. Khuyến nghị: iPhone trước, iPad ở giai đoạn kế.
3. Phạm vi năm công bố: khuyến nghị **1900–2100**, thay vì dùng chữ “vạn niên” nhưng không nói giới hạn.
4. Có giữ “ngày/giờ tốt xấu” trong 1.0 hay không. Khuyến nghị hiện tại: **HOLD**; nếu T018 không có ruleset, chuyên gia và owner chịu trách nhiệm thì loại khỏi 1.0. Nếu được duyệt sau đó, chỉ đặt nhãn tham khảo ở mặt sau và cho tắt toàn bộ.
5. Mức hiệu ứng và âm mặc định. Khuyến nghị: **Sống động một lần/ngày rồi lắng; bản phát hành mặc định Yên cho tới khi Gate 7 có dữ liệu**, tự hạ về Tĩnh theo Reduce Motion/Low Power; Hiên sớm, âm giấy và cue sự kiện do người dùng chủ động bật.
6. Mô hình duy trì phí Apple Developer 99 USD/năm. Khuyến nghị: chủ dự án tài trợ hoặc tài trợ công khai; tuyệt đối không biến thành quảng cáo/paywall về sau nếu đã dùng lời hứa “miễn phí hoàn toàn”.

## Những việc cố ý chưa làm

- Chưa tạo project Xcode, React, Flutter, Godot hay bất kỳ mã nguồn nào.
- Chưa tạo logo, artwork, texture hoặc prototype tương tác.
- Chưa sao chép dữ liệu, bài viết hay hình ảnh từ app/lịch thương mại.
- Chưa tuyên bố thuật toán đã “chính xác” khi chưa có bộ kiểm thử đối chiếu độc lập.
- Chưa coi persona mô phỏng là người tham gia hoặc dùng chúng để pass Gate 1–7.
