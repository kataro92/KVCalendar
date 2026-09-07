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

Không phát hành nếu US1, US2 hoặc US3 không hoàn thành được bằng VoiceOver, chữ 200%, Reduce
Motion hoặc Increase Contrast trên thiết bị mục tiêu.
