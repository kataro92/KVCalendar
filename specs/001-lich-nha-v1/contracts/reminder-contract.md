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

## Independent checks

Mỗi occurrence phải round-trip về LunarDate dự kiến, đúng cờ nhuận, đúng delivery zone và không
trùng system identifier. Boundary test gồm năm nhuận âm, tháng 29 ngày, DST ở nơi người dùng sống,
timezone đổi và permission thay đổi ngoài app.
