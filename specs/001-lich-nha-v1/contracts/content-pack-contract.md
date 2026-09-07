# Content pack contract

## Pack header

Mỗi pack có `schemaVersion`, `packVersion`, `publishedAt`, `effectiveRange`, `minimumAppVersion`,
`recordsChecksum` và hai release approvals.

## Required records

- SourceRecord.
- CalendarOccurrence với taxonomy rõ.
- AlmanacRuleSet và AlmanacEntry nếu bật lớp lịch truyền thống.
- Editorial item nếu có, kèm tác giả, quyền, editor và reviewer.

## Validation

- ID duy nhất và reference không gãy.
- Record chính thức có văn bản, phạm vi năm/đối tượng/vùng và ngày công bố.
- `isDayOff` không được suy ra chỉ từ tên ngày.
- Content restricted, thiếu license, thiếu version hoặc không có source bị từ chối.
- Mọi URL nguồn có snapshot/metadata đủ để audit; link hỏng không tự làm record thành đúng.
- Pack không chứa PersonalEvent hoặc dữ liệu người tham gia nghiên cứu.

## Failure behavior

Nếu pack mới không pass schema/checksum, app tiếp tục dùng pack hợp lệ gần nhất đi cùng binary và
hiển thị version đó. Lỗi một editorial item không được làm mất CalendarDay.
