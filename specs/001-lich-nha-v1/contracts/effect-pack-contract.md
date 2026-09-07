# Effect pack contract

## Resolver input

- CalendarDay và occurrence IDs đã chuẩn hóa.
- Tone, safety flags và region preference.
- App effect level: Sống động, Êm hoặc Tĩnh.
- Reduce Motion, Dim Flashing Lights, Reduce Transparency, Increase Contrast, Large Text,
  VoiceOver, Low Power, thermal state và capability tier.
- Trạng thái đã xem hero intro của ngày.

## Resolver output

Đúng một `ResolvedScene` gồm hero hoặc không hero, ambient, accent, poster, audio permission,
content safe zone và lý do fallback. Resolver không trả nhiều hero chạy đồng thời.

## Priority rules

1. Safety và accessibility override mọi lựa chọn mỹ thuật.
2. Sự kiện tưởng niệm hoặc trang trọng chặn confetti/audio khi safety flag yêu cầu.
3. Event ID cụ thể có ưu tiên hơn họ tiết khí; ngày thường chỉ dùng ambient.
4. Intro đã xem chuyển scene sang trạng thái nghỉ, trừ khi người dùng chủ động phát lại.
5. Asset thiếu hoặc checksum sai chuyển sang poster; không xóa nhãn sự kiện.

## Asset gate

- Mọi model có poster và ít nhất một runtime LOD.
- Asset Image-to-3D chỉ nhận reference đã duyệt; manifest thiếu reference bị từ chối.
- Quốc kỳ, ngôi sao, logo và chữ Việt không được lấy từ output tạo sinh.
- Không reference nào được lấy từ screenshot đối thủ hoặc artwork không có quyền.
- Pack hoàn chỉnh phải chạy ở chế độ máy bay.

## Performance behavior

Scene chỉ khởi động sau text, dừng khi app background hoặc tờ bị che. Khi vượt frame/thermal
budget, resolver giảm particle, LOD rồi chuyển poster; không giảm chất lượng text.
