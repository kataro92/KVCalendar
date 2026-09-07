# UI state contract

## Root states

- `todayFront`: tờ trước của ngày được chọn.
- `dayBack`: chi tiết và nguồn của cùng ngày.
- `monthSheet`: tháng chứa ngày được chọn.
- `eventEditor`: tạo hoặc sửa PersonalEvent.
- `paperDrawer`: settings, source/version, privacy và sound/effect choices.

Mọi state giữ `selectedDate: CivilDate`, chỉ gồm năm–tháng–ngày và không mang giờ, instant hay múi
giờ. Đóng overlay trở về state trước. Action Hôm nay lấy instant hiện tại qua `displayTimeZone` để
tạo current display `CivilDate`, rồi đặt state `todayFront`. Đổi múi giờ không được mutate một
selectedDate lịch sử; chỉ action Hôm nay mới tính lại ngày hiện tại.

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

Ở chữ 200%, thứ tự giữ lại trên mặt trước là thứ, ngày dương, tháng/năm, ngày/tháng âm và sự
kiện/tiết khí. Can Chi, almanac cùng editorial chuyển sang mặt sau trước khi giảm cỡ số ngày.
