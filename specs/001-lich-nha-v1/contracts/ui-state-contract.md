# UI state contract

## Root states

- `todayFront`: tờ trước của ngày được chọn.
- `dayBack`: chi tiết và nguồn của cùng ngày.
- `monthSheet`: tháng chứa ngày được chọn.
- `eventEditor`: tạo hoặc sửa PersonalEvent.
- `paperDrawer`: settings, source/version, privacy và sound/effect choices.

Mọi state giữ `selectedDate`; đóng overlay trở về state trước. Action Hôm nay luôn đưa selectedDate
về current display date và state `todayFront`.

## Required actions

| Action | Gesture | Non-gesture/VoiceOver equivalent |
|---|---|---|
| Ngày kế/trước | Bóc hoặc vuốt | Nút và accessibility action |
| Mặt trước/sau | Lật có chuyển động | Nút “Xem chi tiết” / “Quay lại tờ ngày” |
| Mở tháng | Kéo/ngăn giấy nếu có | Nút “Xem tháng” |
| Chọn ngày | Chạm ô ngày | Accessibility activate |
| Về hôm nay | Không phụ thuộc gesture | Nút “Hôm nay” một thao tác |
| Tắt nền | Chạm control hiện trên tờ | Labeled toggle/button một thao tác |

## Loading and failure

Text CalendarDay dùng dữ liệu cục bộ và phải có trước scene. Pack hiệu ứng hỏng chỉ chuyển poster.
Pack nội dung phụ hỏng giữ ngày dương/âm và hiển thị source/version hiện dùng. Không có state bắt
người dùng đăng nhập, kết nối mạng hoặc cấp quyền mới xem lịch.

## Large text

Ở chữ 200%, thứ tự giữ lại trên mặt trước là thứ, ngày dương, tháng/năm, ngày/tháng âm, Can Chi
ngắn và sự kiện/tiết khí. Almanac cùng editorial chuyển sang mặt sau trước khi giảm cỡ số ngày.
