# Lịch Nhà — màn hình lịch với nhạc nền theo ngày

Ngày sửa: 09/09/2026. Trạng thái: concept theo yêu cầu đã làm rõ; chưa triển khai ứng dụng.

## Yêu cầu đã chốt trong trao đổi

Lịch Nhà có nhạc nền mặc định theo ngày. Người dùng mở ứng dụng để xem quyển lịch bloc và có thể để điện thoại mở trên bàn trong lúc học hoặc làm việc. Nhạc là thành phần của cảnh ngày, tự phát khi mở ứng dụng; người dùng không phải chọn bài hoặc bắt đầu một phiên nghe.

Màn hình chờ là trạng thái ở yên của không gian lịch chính. Không cần màn hình nghe nhạc riêng hoặc chế độ “Ngồi cùng lịch”. Giao diện chỉ giữ điều khiển bật/tắt âm nền và tùy chọn giữ màn hình sáng.

Chỉ dẫn này của người dùng thay thế cách hiểu trong phân tích v1 về chọn nhạc, nút phát và hẹn giờ. Nó cũng thay thế mặc định Yên trong tài liệu cũ đối với hướng concept mới. Các gate kiểm thử chưa được đánh dấu đạt; README, Design Master và Spec Kit cần đồng bộ quyết định này ở bước đặc tả, trước khi triển khai.

## Đánh giá giao diện dành cho người trẻ

Đánh giá dựa trên README, Design Master và tài liệu UX/âm thanh, không phải kiểm thử ứng dụng chạy được. Mức độ phù hợp với người 16–34 tuổi vẫn là giả thuyết thiết kế.

Giấy, gỗ, son và hai ốc đồng giúp nhận ra lịch bloc Việt Nam. Để giao diện trẻ hơn, giảm vân gỗ và hoa văn khánh, giữ con số sans-serif lớn, màu pastel ít bão hòa và một minh họa nhỏ. Lịch ở giữa màn hình với khoảng trống rộng, không bị bộ điều khiển nhạc chiếm chỗ.

Tờ lịch vẫn cần đủ thứ, ngày/tháng/năm dương và ngày/tháng âm. Thông tin truyền thống chi tiết nằm ở mặt sau. Khi người dùng để máy yên, các công cụ tra cứu phụ có thể thu lại; chạm một lần gọi lại. Mọi gesture có thao tác chạm và VoiceOver tương đương.

Bố cục concept gồm tên Lịch Nhà phía trên, quyển bloc ở giữa và hai điều khiển nhỏ phía dưới: “Âm nền · Bật/Tắt” và “Giữ sáng”. Không có tên bài, danh sách nhạc, nút chuyển bài, thanh tiến trình hoặc hẹn giờ nghe.

## Nhạc là một phần của cảnh ngày

Ứng dụng chọn nhạc từ gói nội dung offline gắn với ngày/cảnh đã biên tập. “Theo ngày” không đòi hỏi 365 bản nhạc khác nhau; cách phân bổ nhạc cho ngày thường, mùa và sự kiện cần chốt trong đặc tả nội dung.

Nhạc vào nhẹ sau khi tờ lịch xuất hiện và lặp êm ở âm lượng nền. Khi đổi cảnh có đổi nhạc, tránh cắt âm đột ngột. Đề xuất giữ nhạc theo hôm nay khi người dùng chỉ lướt tra ngày khác, để việc tra cứu không liên tục đổi âm; đây là hành vi cần thử, chưa phải yêu cầu đã chốt.

Người dùng có thể tắt âm ngay tại màn hình lịch. Ứng dụng nhớ trạng thái tắt ở lần mở sau. Mặc định bật không có nghĩa ghi đè lựa chọn của người dùng. Tiếp tục tôn trọng Silent, VoiceOver và audio đang phát từ ứng dụng khác theo quy tắc dự án.

Tách nhạc nền khỏi âm giấy và cue sự kiện; hai lớp sau vẫn tắt mặc định. Không đưa tiếng lật lịch hoặc cue lễ hội vào bản nhạc lặp. Giữ màn hình sáng là tùy chọn của màn hình lịch, không phụ thuộc phiên nghe hoặc bộ hẹn giờ. Khi rời ứng dụng, bỏ yêu cầu giữ sáng và dừng âm nền; nghe ở nền không nằm trong yêu cầu này.

Chưa tạo bản thu âm. Nội dung âm cần được thử nghe, kiểm quyền phân phối offline và kiểm tra pin/nhiệt trước khi phát hành. Không tuyên bố nhạc làm tăng hiệu quả học tập.

## Ba concept hiện hành

| Concept | Hình ảnh | Một hiệu ứng nhẹ đề xuất |
|---|---|---|
| Nắng bên bàn | Giấy kem, khánh son, nền phấn ấm | Bóng lá dịch chậm ngoài vùng chữ |
| Mưa ngoài hiên | Ngọc dịu, gỗ sáng, minh họa tách trà | Vệt mưa rất thưa ở mép; bản ảnh v3 hiện thể hiện nền tĩnh |
| Đêm học bài | Tím than, son trầm và giấy giảm sáng | Ánh sáng đổi rất nhẹ hoặc giữ tĩnh |

Tên trên dùng phân biệt hướng mỹ thuật, không phải tên bài nhạc hay danh sách chọn trong ứng dụng. Nắng bên bàn là hướng chính đề xuất vì giữ rõ màu son và giấy của Lịch Nhà.

Mỗi cảnh có tối đa một hiệu ứng chính. Không cho chuyển động đi qua số ngày hoặc lịch âm. Reduce Motion và Low Power dùng poster tĩnh; tôn trọng Dim Flashing Lights. Không tự bóc lịch hoặc thêm equalizer chuyển động.

## Kiểm tra ảnh và giới hạn

Ba ảnh v3 đã bỏ trình nghe nhạc, tiêu đề chế độ riêng và đưa lịch về vùng giữa. Giữ ảnh cũ chỉ để truy xuất, không dùng chúng làm hướng triển khai.

Dữ liệu “17”, “THÁNG CHÍN”, “Âm lịch · 08” là minh họa bố cục, không xác nhận quan hệ âm–dương. Màn hình hoàn chỉnh phải bổ sung thứ, năm và tháng âm. Font và chữ cần dựng lại theo Design Master; không dùng chữ raster trong app.

Các nút âm nền giữa ba ảnh chưa đồng nhất hoàn toàn: bản nắng có toggle, hai bản còn lại là nút có nhãn trạng thái. Đây là biến thể concept; khi dựng giao diện cần chọn một cách điều khiển thống nhất. Chữ lớn, VoiceOver, tương phản, vùng chạm 44 pt và độ sáng giấy buổi tối chưa thể xác nhận từ ảnh.

Tra cứu UI/UX trước đó giữ nguyên tắc Reduced Motion và hạn chế số phần tử chuyển động; kết quả Hero/Testimonials/CTA dành cho web bị loại. Văn bản được rà ở ngữ cảnh docs, giữ lời mô tả cụ thể.

Ảnh hiện hành: [Nắng bên bàn](01-nang-ben-ban-v3.png), [Mưa ngoài hiên](02-mua-ngoai-hien-v3.png), [Đêm học bài](03-dem-hoc-bai-v3.png).

Hồ sơ chỉnh sửa: [prompt](prompts-v2-ambient.md), [manifest](generation-manifest-v3.md). Chưa tạo code, nhạc, animation hoặc model Rodin.
