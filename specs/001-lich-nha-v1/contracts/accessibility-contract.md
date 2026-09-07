# Accessibility contract

## Semantic order

Mỗi tờ ngày là một nhóm có summary: thứ và ngày dương, ngày âm, sự kiện/tiết khí. Sau summary là
Can Chi, nội dung phụ và các action. Particle, paper grain và prop trang trí bị ẩn khỏi accessibility
tree; toàn cảnh có tối đa một mô tả ý nghĩa.

## Controls

- Vùng chạm tối thiểu 44 × 44 pt.
- Mỗi control có label, value/state, hint khi cần và focus order ổn định.
- Không dùng màu, chuyển động, haptic hoặc âm thanh làm kênh thông tin duy nhất.
- Gesture kéo/bóc luôn có button hoặc accessibility action tương đương.

## System settings

- Reduce Motion bỏ parallax, curl mạnh, rơi/xoáy và dùng dissolve/poster.
- Dim Flashing Lights dùng pháo hoa bloom không flash; không chỉ hạ opacity bản cũ.
- Reduce Transparency dùng nền đặc phía sau text.
- Increase Contrast giảm texture trên giấy và tăng biên cần thiết.
- Large Text mở rộng vùng nội dung hoặc chuyển phần phụ sang mặt sau.
- VoiceOver chặn âm nền auto-start và ẩn từng particle.

## Release gate

Danh sách tác vụ cốt lõi dùng chung cho spec, test và scorecard:

1. đọc thứ, ngày dương, ngày âm và sự kiện/tiết khí của hôm nay;
2. sang ngày trước/sau bằng action không kéo và về Hôm nay trong một thao tác;
3. mở tháng, chọn một ngày và quay lại đúng ngữ cảnh;
4. mở mặt sau, tìm nguồn/phương pháp trong tối đa hai thao tác;
5. tạo/sửa một event âm gồm policy tháng nhuận/ngày 30 và hiểu trạng thái lưu/notification;
6. đọc widget và mở đúng ngày bằng deep link, không lộ nội dung riêng tư;
7. đổi mức hiệu ứng và đưa mọi lớp âm về Yên trong một thao tác.

Gate 5A là review với prototype trước code; phần prototype không thể hiện phải ghi `NOT RUN`.
Gate 5B là release verification. Không phát hành nếu bất kỳ tác vụ trên thất bại bằng VoiceOver,
chữ 200%, Reduce Motion hoặc Increase Contrast trên thiết bị mục tiêu. Scene safety còn phải đạt
Gate 6B; audio session còn phải đạt Gate 7B.
