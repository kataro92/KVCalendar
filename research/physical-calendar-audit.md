# Audit lịch bloc vật lý

**Ngày mở file**: 2026-09-07  
**Trạng thái**: biểu mẫu và quyền quan sát đã sẵn; **chưa có 6 mẫu đã xem**. T004 chỉ được đánh dấu xong khi bảng mẫu có ít nhất 6 dòng “đã quan sát”, mỗi dòng có nguồn/quyền, và mục pattern đã viết từ các dòng đó.

Mục tiêu là pattern dùng chung (tỷ lệ, thứ tự chữ, chỗ mắt dừng), không phải một tờ để copy. Cấm chụp hoặc mô tả artwork để tái tạo họa tiết, mascot, hay bố cục độc quyền của nhà xuất bản.

## 1. Quyền trước khi xem

Với mỗi bộ lịch, moderator ghi một trong bốn nguồn quyền:

1. Lịch trong nhà người tham gia, họ cho xem và (nếu chụp) cho chụp mặt tờ không có thông tin nhà.
2. Lịch do dự án mua, hóa đơn giữ ngoài Git.
3. Lịch thư viện/bảo tàng/cơ quan, có điều kiện xem tại chỗ.
4. Không có quyền: không mở, không chụp, không ghi họa tiết.

Ảnh chỉ để đo tỷ lệ và thứ tự thông tin. Crop bỏ tên shop, QR quảng cáo, và chữ ký họa sĩ nếu không có phép. Ảnh để `research/raw/physical-calendars/`, không commit.

## 2. Phiếu một mẫu

Nhân bản khối dưới cho CAL-01 đến CAL-10.

```
ID: CAL-__
Năm in:
Nhà xuất bản (ghi để nội bộ, không đưa vào UI app):
Nguồn quyền: (1/2/3)
Kích thước khánh (rộng × cao, mm):
Kích thước ruột tờ (rộng × cao, mm):
Tỷ lệ khánh / (khánh+ruột) theo chiều cao:
Định lượng giấy nếu biết:
Màu giấy ruột:
Cỡ tương đối số ngày dương so với chiều cao tờ (% ước lượng):
Thứ tự thông tin từ trên xuống:
Màu Chủ nhật / ngày lễ (mô tả, không lấy mã Pantone của nhà in):
Cách ghi ngày âm:
Cách ghi Can Chi:
Cách ghi tiết khí:
Nội dung đáy tờ (loại: thơ / phong tục / quảng cáo / trống):
Cơ chế: xé gáy keo / ốc / lò xo / khác:
Mức họa tiết (ít / vừa / dày): không mô tả họa tiết để vẽ lại
Người xem thích nhìn chỗ nào trước (nếu có người nhà chỉ):
Phần họ nói không bao giờ đọc:
Ảnh nội bộ: có / không, tên file raw:
Người ghi / ngày:
```

## 3. Sổ mẫu

| ID | Năm | Quyền | Đã quan sát | Pattern đã mã hóa |
|---|---|---|---|---|
| CAL-01 | | | chưa | |
| CAL-02 | | | chưa | |
| CAL-03 | | | chưa | |
| CAL-04 | | | chưa | |
| CAL-05 | | | chưa | |
| CAL-06 | | | chưa | |
| CAL-07 | | | chưa | |
| CAL-08 | | | chưa | |
| CAL-09 | | | chưa | |
| CAL-10 | | | chưa | |

Cần 6 mẫu xong mới viết mục 4. 10 mẫu nếu tuyển được, không bắt đủ 10 để mở Gate 1.

## 4. Pattern (điền sau khi có ≥6 mẫu)

Mỗi dòng pattern phải chỉ ra ID mẫu nào ủng hộ. Không viết “lịch Việt thường làm X” nếu chưa đếm được trên mẫu.

| Pattern | Số mẫu có | Số mẫu không | Việc prototype A/B/C phải thử |
|---|---:|---:|---|
| *(chưa có dữ liệu)* | | | |

Việc cần tách khi mã hóa:

- số dương có phải điểm đọc đầu không;
- ngày âm nằm dưới số dương hay bên lề;
- khánh có mang thông tin tháng/năm hay chỉ trang trí;
- quảng cáo đáy tờ có đẩy mắt xuống không;
- Chủ nhật có dựa mỗi màu đỏ không.

## 5. Việc không làm

- Không dựng khánh Lịch Nhà theo silhouette một bộ đang bán.
- Không đưa ảnh mẫu vào Figma production hoặc repo public.
- Không dùng lịch app đối thủ làm “mẫu vật lý”.
