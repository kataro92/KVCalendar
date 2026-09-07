# Reminder contract

## Planner input

- PersonalEvent đã lưu.
- Calendar engine/ruleset version.
- Cửa sổ planning được cấu hình.
- Trạng thái notification permission.
- Current date, calculation zone và delivery zone.

## Planner output

- Danh sách ReminderOccurrence cụ thể, sắp theo delivery time.
- Trạng thái event: saved, reminders active, permission denied, needs refresh hoặc planning error.
- Câu giải thích tự nhiên về leap-month và short-month policy.

## Rules

- Không dùng Gregorian repeating trigger cho event âm.
- Không sửa hoặc xóa PersonalEvent khi permission bị từ chối.
- Leap-month và day-30 policy phải được áp dụng trước khi schedule.
- Thay đổi event, timezone, system date, permission hoặc app/engine version làm occurrence cũ stale.
- Planner hủy identifier cũ trước khi thay bằng occurrence mới; thao tác lặp phải idempotent.
- Title/note người dùng không xuất hiện trong log hoặc error payload.
- Ghép `targetCivilDate` với giờ local bằng IANA `deliveryZone`, không dùng offset cố định cho recurrence.
- Nếu giờ local không tồn tại do DST gap, mặc định tạm là dời tới instant hợp lệ kế tiếp trong cùng
  ngày và ghi `timeAdjustment`; nếu không còn giờ hợp lệ trong ngày thì occurrence fail, event vẫn lưu.
- Nếu giờ local xuất hiện hai lần do DST overlap, mặc định tạm là instant sớm hơn và chỉ schedule
  một occurrence. Một override explicit phải được lưu trong `dstResolutionPolicy`.
- Mọi điều chỉnh DST phải nhìn thấy trong chi tiết reminder và có thể được Gate 4/T014 sửa trước
  implementation; không dựa vào default ngầm của thư viện ngày giờ.

## Independent checks

Mỗi occurrence phải round-trip về LunarDate dự kiến, đúng cờ nhuận, đúng delivery zone và không
trùng system identifier. Boundary test gồm năm nhuận âm, tháng 29 ngày, DST ở nơi người dùng sống,
timezone đổi và permission thay đổi ngoài app.

Fixture tối thiểu gồm một DST gap, một DST overlap, đổi zone sau khi schedule và một zone không có
DST. Kết quả phải deterministic qua lần chạy lại cùng tzdata/rule version.
