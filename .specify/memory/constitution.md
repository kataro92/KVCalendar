<!--
Sync Impact Report
- Version: template -> 1.0.0
- Added principles: Lời hứa sản phẩm; Đúng lịch và truy nguyên được; Bản sắc riêng đi cùng
  accessibility; Riêng tư và offline; Kiểm chứng trước khi mở rộng
- Added sections: Ràng buộc nền tảng và asset; Quy trình và cổng chất lượng
- Removed sections: none; template placeholders were replaced
- Deferred items: none
-->
# Hiến pháp Lịch Nhà

## Core Principles

### I. Lời hứa sản phẩm không được pha loãng

Lịch Nhà PHẢI là lịch bloc Việt Nam dành trước hết cho người 16–34 tuổi quan tâm lịch âm và
văn hóa Việt. Phiên bản cốt lõi PHẢI miễn phí cho người dùng, không quảng cáo, không paywall,
không đăng nhập và không bán dữ liệu. Một thay đổi vi phạm lời hứa này không được xem là tối ưu
kinh doanh thông thường; nó cần sửa hiến pháp và sự chấp thuận rõ ràng của chủ dự án.

### II. Dữ liệu lịch phải đúng, có phạm vi và truy nguyên được

Mọi ngày âm, tháng nhuận, Can Chi, tiết khí, ngày lễ và thông tin truyền thống PHẢI có nguồn,
phương pháp, múi giờ, phạm vi năm và phiên bản dữ liệu. Lịch Việt hiện đại dùng quy tắc UTC+7;
ngày hiện tại và giờ nhắc có thể theo múi giờ thiết bị nhưng không được làm thay đổi hệ tính lịch.
Nội dung tốt/xấu PHẢI được ghi là tham khảo theo truyền thống. Không được công bố độ chính xác
trước khi bộ golden dates, property tests và đối chiếu độc lập đạt yêu cầu đã ghi trong đặc tả.

### III. Bản sắc riêng phải đi cùng accessibility

Giao diện PHẢI giữ ngôn ngữ Mộc Son Dịu: lịch giấy, gỗ, sơn son, pastel ít bão hòa và nét dễ
thương trưởng thành. Số ngày và thông tin lịch luôn có ưu tiên cao hơn cảnh nền. Mọi tương tác tùy
biến PHẢI có semantics, VoiceOver, Dynamic Type, vùng chạm tối thiểu 44 pt và phương án không
dùng gesture. Mọi hiệu ứng PHẢI có Reduce Motion, Dim Flashing Lights, Low Power và poster tĩnh.
Một màn hình đẹp nhưng làm giảm khả năng đọc hoặc buộc người dùng kéo, bóc hay nghe âm thanh
để hoàn tất tác vụ sẽ không được duyệt.

### IV. Chức năng cốt lõi phải riêng tư và chạy offline

Xem lịch, đổi ngày, tra cứu, ngày giỗ, nhắc lịch âm, widget và cảnh đã phát hành PHẢI dùng được
không cần mạng. Dữ liệu cá nhân mặc định chỉ nằm trên thiết bị hoặc vùng chia sẻ app/widget do
hệ thống quản lý. Không được đưa khóa dịch vụ vào ứng dụng, gọi AI lúc chạy app hoặc thêm
telemetry nhận dạng cá nhân. Mọi quyền hệ thống PHẢI được xin tại thời điểm có ngữ cảnh và việc từ
chối không được làm hỏng luồng xem lịch.

### V. Kiểm chứng trước khi mở rộng

Mỗi phần việc PHẢI bắt đầu từ kết quả người dùng cần đạt, tiêu chí chấp nhận và cách kiểm tra độc
lập. Nhóm dự án PHẢI hoàn thành các cổng concept, gesture, thứ bậc thông tin, ngày giỗ,
accessibility, hiệu ứng và âm nền trước khi gọi phạm vi tương ứng là sẵn sàng phát triển. Tính mới
lạ không thay thế bằng chứng. Nếu một thử nghiệm thất bại, task phải quay lại nghiên cứu hoặc sửa
đặc tả thay vì tiếp tục đánh bóng phần triển khai.

## Ràng buộc nền tảng và asset

- Phạm vi 1.0 ưu tiên iPhone; iPad là phần việc riêng sau khi lõi trên iPhone đạt cổng chất lượng.
- SwiftUI đảm nhiệm cấu trúc và accessibility. Kỹ thuật render khác chỉ được dùng cho lớp vật lý
  hoặc cảnh nền khi có ngân sách hiệu năng, fallback và lý do được ghi trong plan.
- Mỗi cảnh ngày có tối đa một hiệu ứng chính. Âm nền, âm giấy và cue sự kiện là ba lớp độc lập;
  không lớp nào được che thông tin hay ép người dùng nghe.
- Rodin chỉ được dùng theo chuỗi ảnh tham chiếu đã duyệt sang Image-to-3D. Text-to-3D bị cấm.
- Quốc kỳ, ngôi sao, logo và chữ Việt phải được dựng và duyệt thủ công. Mô hình tạo sinh không
  được quyết định hình học, màu, crop hoặc chuyển động của biểu tượng quốc gia.
- Mỗi asset phải có manifest về nguồn, quyền, công cụ, phiên bản, biên tập, reviewer và phạm vi
  sử dụng. Asset thiếu quyền hoặc provenance không được đưa vào bản phát hành.

## Quy trình và cổng chất lượng

1. Dùng chuỗi Spec Kit: constitution, specify, clarify khi cần, plan, tasks, analyze, implement và
   converge. Mỗi feature chỉ được chuyển bước khi artifact trước không còn placeholder hoặc điểm
   chưa rõ gây ảnh hưởng đến phạm vi.
2. Giai đoạn hiện tại chỉ tạo nghiên cứu, đặc tả, kế hoạch và task. Không tạo mã ứng dụng, project
   Xcode, prototype chạy được hoặc asset production nếu chủ dự án chưa yêu cầu rõ.
3. Mỗi user story phải kiểm tra được độc lập. Task triển khai phải ghi file đích, phụ thuộc và tiêu
   chí hoàn tất; task nghiên cứu phải ghi câu hỏi, mẫu thử, dữ liệu cần thu và ngưỡng ra quyết định.
4. Thay đổi UI phải đối chiếu `design-system/lich-nha/MASTER.md`. Thay đổi dữ liệu lịch phải đối
   chiếu `docs/04-du-lieu-va-do-tin-cay.md`. Thay đổi asset phải đối chiếu
   `docs/09-quy-trinh-ai-va-asset.md`.
5. Trước phát hành, các kiểm thử lịch, múi giờ, tháng nhuận, notification, VoiceOver, Dynamic Type,
   Reduce Motion, hiệu năng và offline phải vượt qua tiêu chí trong spec và quickstart.

## Governance

Hiến pháp này là nguồn quyết định cao nhất cho plan và task của Spec Kit. `AGENTS.md` và các rule
cục bộ có thể bổ sung hướng dẫn nhưng không được nới lỏng các nguyên tắc trên. Mỗi lần sửa phải
ghi lý do, tác động đến spec/plan/task hiện có và kế hoạch chuyển đổi nếu có.

Phiên bản dùng semantic versioning: MAJOR khi bỏ hoặc đổi nghĩa một nguyên tắc; MINOR khi thêm
nguyên tắc hoặc mở rộng nghĩa vụ; PATCH khi chỉ làm rõ câu chữ. Mọi lần review feature phải kiểm
tra Constitution Check trước nghiên cứu kỹ thuật và sau khi hoàn tất thiết kế. Ngoại lệ chỉ có hiệu
lực khi được ghi trong Complexity Tracking của plan, có người chịu trách nhiệm và ngày xem lại.

**Version**: 1.0.0 | **Ratified**: 2026-09-07 | **Last Amended**: 2026-09-07
