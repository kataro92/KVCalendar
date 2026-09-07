# Calendar contract

## Mục đích

Calendar Core là nguồn duy nhất cho chuyển đổi dương/âm, Can Chi và tiết khí. UI, widget, reminder
và Effect Director không tự cài lại công thức.

## Inputs

- Civil date trong phạm vi 1900–2100.
- Calendar rule zone, mặc định lịch Việt UTC+7.
- Display zone dùng để xác định ngày hiện tại hoặc ngày chứa thời điểm tiết khí.
- Engine/data version được yêu cầu hoặc version hiện hành.

## Outputs

- `CalendarDay` đầy đủ hoặc lỗi có kiểu.
- Chuyển đổi LunarDate sang 0, 1 hoặc nhiều civil-date candidate khi policy chưa đủ.
- Metadata gồm engine version, history scope, warning IDs và source IDs.

## Invariants

- Dương → âm → dương trả đúng ngày trong phạm vi hỗ trợ.
- Tháng âm chỉ có 29 hoặc 30 ngày; năm âm có 12 hoặc 13 tháng và tối đa một tháng nhuận.
- Ngày Can Chi lặp theo chu kỳ 60.
- Engine không truy cập mạng, storage cá nhân, UI, notification hoặc Effect Catalog.
- Ngày trước 1976 không được trả về như dữ kiện hiện đại nếu record cần cảnh báo lịch sử.

## Error cases

Ngoài phạm vi, LunarDate không tồn tại, cờ nhuận sai, source/version không có và dữ liệu pack hỏng
phải trả lỗi riêng. Không được sửa input im lặng.
