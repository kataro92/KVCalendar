# Đồng ý tham gia, ẩn danh và thời hạn xóa recording

**Ngày**: 2026-09-07  
**Áp dụng**: mọi buổi T012–T014  
**Recording và export thô**: chỉ đặt trong `research/raw/` và `research/recordings/` (đã có trong `.gitignore`). Không commit, không gửi chat công cụ AI, không upload cloud nếu người tham gia chưa đồng ý riêng cho việc đó.

## 1. Thông tin phải nói trước khi bấm ghi

Đọc to, tiếng Việt, trước khi hỏi “anh/chị đồng ý chứ?”. Không rút thành “nghiên cứu app lịch, được không?”.

Chúng tôi đang kiểm tra bản vẽ và prototype của một ứng dụng lịch. Buổi khoảng 45 đến 60 phút. Bạn có thể dừng bất cứ lúc nào, không cần giải thích. Việc dừng không ảnh hưởng quà cảm ơn đã hứa.

Chúng tôi sẽ hỏi cách bạn đang xem ngày âm, rồi nhờ bạn làm vài việc trên bản thử. Không có câu trả lời đúng. Chúng tôi không cài app theo dõi lên máy bạn.

Nếu bạn đồng ý, chúng tôi có thể ghi âm giọng và quay màn hình prototype. Không bắt buộc ghi. Nếu không ghi, moderator chỉ viết ghi chú.

Báo cáo dùng mã (ví dụ P07, S03), không dùng họ tên. Ngày giỗ, tên người mất, địa chỉ, số điện thoại không vào báo cáo. Trích dẫn chỉ dùng khi bạn đồng ý và đã xóa mốc nhận dạng.

Recording sẽ xóa trong 90 ngày sau khi nhóm ghi quyết định Gate 1–7, hoặc sớm hơn nếu bạn yêu cầu. Ghi chú ẩn danh có thể giữ lại trong hồ sơ dự án.

Quà cảm ơn đưa vì bạn đã dành thời gian, không phụ thuộc việc bạn khen hay chê bản thử.

Hỏi lần lượt, ghi có/không:

1. Tham gia buổi?
2. Ghi âm giọng?
3. Quay màn hình prototype (không quay mặt nếu video gọi, trừ khi họ muốn)?
4. Cho phép trích dẫn ẩn danh trong báo cáo nội bộ?
5. Cho phép đưa đoạn ghi chú đã ẩn danh vào công cụ AI/cloud? Mặc định là không.

## 2. Mẫu đồng ý viết (ngắn)

Người tham gia và moderator mỗi người giữ một bản. Có thể là giấy hoặc PDF trên máy dự án, không bỏ vào Git.

```
Mã người: P__
Mã buổi: S__
Ngày buổi:
Hình thức: tại nhà / video

Tôi đã nghe mục đích buổi, quyền dừng, cách ẩn danh và thời hạn xóa recording.
- Tham gia: có / không
- Ghi âm: có / không
- Quay màn hình: có / không
- Trích dẫn ẩn danh nội bộ: có / không
- Đưa ghi chú ẩn danh lên công cụ AI/cloud: có / không (mặc định không)

Ký tên hoặc xác nhận miệng (ghi giờ):
Moderator:
```

Với người 16–17 tuổi: cần thêm đồng ý của cha mẹ hoặc người giám hộ trước buổi.

## 3. Ẩn danh khi ghi chép

| Được ghi trong `research/sessions/` | Không được ghi |
|---|---|
| Mã P, mã S, nhóm tuổi, vùng Bắc/Trung/Nam/nước ngoài | Họ tên, SĐT, email, handle mạng xã hội |
| Loại máy (ví dụ “iPhone nhỏ, iOS 17”) | Số serial, Apple ID |
| “ngày giỗ tháng Tám âm, policy tháng nhuận: cả hai” | Tên người mất, năm mất, địa chỉ giỗ |
| Câu trích đã cắt mốc nhận dạng | Ảnh mặt, ảnh bàn thờ, ảnh lịch nhà có địa chỉ |

Tên file buổi: `S01.md`, `S02.md`, … không gắn họ tên.

## 4. Thời hạn xóa

| Loại | Nơi lưu | Xóa khi |
|---|---|---|
| Audio/video raw | `research/recordings/` trên đĩa cục bộ, không Git | 90 ngày sau ngày ghi `research/decisions/001-research-gates.md`, hoặc ngay khi người tham gia yêu cầu |
| Ảnh lịch giấy (nếu có quyền) | `research/raw/physical-calendars/` | Cùng hạn recording, trừ khi consent ghi giữ nội bộ lâu hơn cho audit T004 |
| Ghi chú ẩn danh | `research/sessions/` | Giữ trong hồ sơ dự án |
| Screener có SĐT | ngoài Git, file riêng của moderator | Xóa 30 ngày sau khi khóa mẫu hoặc sau buổi, lấy mốc nào đến trước |

Khi xóa: xóa file, xóa thùng rác, ghi một dòng trong `research/raw/deletion-log.md` (file này cũng không commit): mã S, loại file, ngày xóa. Không ghi đường dẫn máy cá nhân của người tham gia.

## 5. Việc moderator không được làm

- Cài profile MDM, analytics, hoặc bản build có telemetry lên máy người tham gia.
- Chụp lịch treo trong nhà nếu chủ nhà chưa cho.
- Đưa recording vào dịch vụ nhận dạng giọng, dịch máy, hoặc chat AI.
- Hứa sản phẩm sẽ ra App Store vào một ngày cụ thể.
- Đổi quà cảm ơn theo mức độ khen concept.
