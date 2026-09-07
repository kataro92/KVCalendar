# Bộ proto-persona cho walkthrough

Tất cả nhân vật dưới đây là hư cấu. Họ không phải người tham gia nghiên cứu, không đại diện cho tỉnh/thành, giới hay nhóm tuổi được gắn vào card. Không trích lời họ như lời người dùng.

## P1 — Linh, 20 tuổi, sinh viên

- **Việc cần làm:** liếc ngày âm trước khi đi học; đôi lúc mở app khi đang học.
- **Điều kiện:** thời gian chú ý ngắn; có thể đang nghe nhạc từ app khác.
- **Rủi ro cần soi:** intro dài, audio chen vào, số âm/dương lẫn thứ bậc.
- **Nguồn:** E04–E06, E15–E16.
- **Câu hỏi mở:** một nghi thức bóc có đủ giá trị để quay lại hằng ngày không?

## P2 — Nam, 29 tuổi, kỹ sư

- **Việc cần làm:** xem widget, kiểm tra ngày âm và nguồn khi có khác biệt giữa hai lịch.
- **Điều kiện:** ưu tiên offline, tốc độ và dữ liệu không rời máy.
- **Rủi ro cần soi:** claim chính xác tuyệt đối, provenance khó tìm, widget chỉ đẹp nhưng thiếu ngày âm.
- **Nguồn:** E01–E04, E07–E09.
- **Câu hỏi mở:** nhãn nguồn ngắn tăng tin tưởng hay chỉ thêm tải nhận thức?

## P3 — Vy, 25 tuổi, làm thiết kế

- **Việc cần làm:** dùng một lịch mang bản sắc Việt nhưng vẫn hợp màn hình chính và gu tối giản.
- **Điều kiện:** nhạy với màu bão hòa, sticker/chibi và texture giả.
- **Rủi ro cần soi:** pastel thành app trẻ em; sơn son–vàng đồng lặp lại đối thủ; họa tiết dồn dập.
- **Nguồn:** E03–E06 và Design Master.
- **Câu hỏi mở:** ngưỡng “dễ thương vừa đủ” chỉ có thể tìm bằng test so sánh trực tiếp.

## P4 — Mai, 27 tuổi, sống tại California

- **Việc cần làm:** xem ngày âm để nhớ việc gia đình ở Việt Nam nhưng nhận nhắc theo giờ địa phương.
- **Điều kiện:** Việt Nam có thể đã sang ngày mới; California có DST.
- **Rủi ro cần soi:** UI không nói rõ “hôm nay ở đây/hôm nay ở Việt Nam”; đổi chế độ làm mutate event hoặc giờ nhắc.
- **Nguồn:** E07, E13–E14.
- **Câu hỏi mở:** default local hay “Nhịp Việt Nam” chưa được người diaspora xác nhận.

## P5 — Hùng, 43 tuổi, người giữ lịch gia đình

- **Việc cần làm:** tạo ngày giỗ lặp theo lịch âm và hiểu app sẽ làm gì ở tháng nhuận/tháng thiếu.
- **Điều kiện:** quy ước có thể khác giữa gia đình; không muốn app tự nhận một cách là đúng.
- **Rủi ro cần soi:** preselect mơ hồ, câu “đúng phong tục”, notification bị từ chối nhưng UI làm người dùng tưởng event mất.
- **Nguồn:** E08, E10 và reminder contract.
- **Câu hỏi mở:** gia đình chọn tháng thường/tháng nhuận và ngày 29/30 thế nào?

## P6 — An, 31 tuổi, người lập kế hoạch thận trọng

- **Việc cần làm:** xem ngày tốt/xấu như thông tin văn hóa, không muốn lời khuyên cá nhân hóa quyết định thay mình.
- **Điều kiện:** cần biết ruleset và mức chắc chắn nhưng không muốn mặt trước thành bảng dữ liệu.
- **Rủi ro cần soi:** ngôn ngữ tuyệt đối, không có nút tắt, ruleset không owner.
- **Nguồn:** quyết định product safety, E01–E04.
- **Câu hỏi mở:** người dùng thật dùng thông tin này để tham khảo hay ra quyết định?

## P7 — Mai Anh, 64 tuổi, cần chữ lớn

- **Việc cần làm:** đọc ngày dương/âm, sang ngày và quay về hôm nay mà không học lại một phong cách khác.
- **Điều kiện:** Dynamic Type 200%, Increase Contrast; có thể không kéo góc giấy chính xác.
- **Rủi ro cần soi:** text bị clip, icon không nhãn, gesture là đường duy nhất, card cố giữ chiều cao.
- **Nguồn:** tín hiệu review E04, HIG và Design Master.
- **Câu hỏi mở:** chỉ test trên thiết bị và với người thật mới biết interface này có dùng được.

## P8 — Quân, 23 tuổi, nhạy với âm/chuyển động

- **Việc cần làm:** xem ngày trong không gian yên, kể cả dịp có scene mạnh.
- **Điều kiện:** bật Reduce Motion hoặc Silent; có thể tháo tai nghe giữa phiên.
- **Rủi ro cần soi:** autoplay, flash, particle qua số ngày, control tắt âm ẩn.
- **Nguồn:** E15–E16, HIG và accessibility contract.
- **Câu hỏi mở:** mức chuyển động nào gây khó chịu cho người dùng thật?

## Ma trận phủ

| Rủi ro | Persona dẫn | Persona đối trọng |
|---|---|---|
| Nghi thức bóc vs xem nhanh | P1 | P2, P7 |
| Pastel/hiệu ứng vs trưởng thành và dễ đọc | P3 | P7, P8 |
| Nguồn chi tiết vs mặt trước yên | P2 | P6 |
| UTC+7 vs ngày/giờ địa phương | P4 | P5 |
| Quy ước ngày giỗ | P5 | P4 |
| Ngày tốt/xấu | P6 | P2 |
| Âm nền vs quyền được im lặng | P1 | P8 |
| UI riêng vs accessibility | P3 | P7 |
