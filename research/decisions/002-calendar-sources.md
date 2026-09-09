# 002 — Nguồn lịch và Calendar Oracle

**Trạng thái:** `ACCEPTED · OWNER ĐÃ CHỈ ĐỊNH; CORPUS VẪN PHẢI XÂY Ở T044–T047`
**Ngày rà soát:** 08/09/2026
**Liên kết task:** T017
**Calendar Data Owner / Golden Corpus Owner:** chủ dự án (ký T019/T020)

## Quyết định

Calendar Core tự triển khai lịch Việt hiện đại UTC+7. Không copy mã Hồ Ngọc Đức cho tới khi giấy phép được xác nhận bằng văn bản. Không dùng `Calendar.Identifier.chinese` làm nguồn sự thật. “Hôm nay” trên thiết bị và giờ nhắc là lớp sản phẩm riêng; chúng không đổi quy tắc lịch.

Hai đường đối chiếu bắt buộc trước khi công bố độ chính xác:

1. Golden corpus do owner ký, mỗi bản ghi có provenance.
2. Một đường tính Sóc và tiết khí độc lập với công thức đã cài (thiên văn / nguồn thứ hai). Mọi sai khác ghi nguyên nhân và quyết định xử lý.

Chuyên gia lịch pháp độc lập vẫn thiếu. Owner nhận trách nhiệm phát hành với nhãn phạm vi 1900–2100 và cảnh báo hồi chiếu 1900–1975. T047 không được đánh dấu xong nếu chưa có báo cáo sai khác.

## Bậc thang nguồn

| Nguồn | Vai trò | Giới hạn | Quyền |
|---|---|---|---|
| [Quyết định 134/2002/QĐ-TTg](https://vbpl.vn/TW/Pages/vbpq-toanvan.aspx?ItemID=21982) | Giờ chính thức Việt Nam = múi giờ thứ 7 | Không mô tả thuật toán âm lịch | Văn bản pháp quy; không đóng gói toàn văn nếu không cần |
| [Bản tin VAST 02/2019](https://isdi.vast.vn/bantin/BantinKHCN022019.pdf) | Sóc, Khí, tháng 29/30, tháng nhuận, ca gần nửa đêm | Không phải bộ checksum; dữ liệu phê duyệt khi đó tới 2030 | Chưa thấy giấy phép tái phân phối bảng; dùng để đối chiếu, không nhúng PDF |
| [Hồ Ngọc Đức — quy tắc](https://www.xemamlich.uhm.vn/calrules_en.html), [VNCal](https://www.xemamlich.uhm.vn/vncal.html) | Mô tả kỹ thuật; khác biệt 1968–1975 | Không phải nguồn nhà nước | Không sao chép code; giấy phép mã chưa xác nhận |
| [Hong Kong Observatory — 24 Solar Terms](https://www.hko.gov.hk/en/gts/time/24solarterms.htm) | Định nghĩa thiên văn tiết khí | Giờ Hong Kong UTC+8 | Đối chiếu thời điểm, không phải oracle ngày âm Việt |
| [IANA Time Zone Database](https://data.iana.org/time-zones/tz-link.html) | ID múi giờ, lịch sử DST | Không xác định lịch âm | Public domain theo trang dự án |

Ngày truy cập URL gốc: 07/09/2026; rà soát vai trò owner: 08/09/2026.

## Golden corpus tối thiểu

T044–T047 phải có provenance từng bản ghi: ngày dương, âm kỳ vọng, cờ nhuận, múi giờ, nguồn, phiên bản, người duyệt, checksum.

Nhóm bắt buộc: Tết; đầu/cuối tháng; tháng 29 và 30 ngày; năm nhuận hai tháng trùng tên; Sóc hoặc chuyển tiết gần nửa đêm UTC+7; sai khác 1968–1975; ca biên 1900–2100.

File corpus chưa tồn tại ở thời điểm T017. Owner đã chỉ định; việc xây và ký giá trị kỳ vọng thuộc Phase 2.

## Điều T017 đóng / còn mở

Đóng: owner dữ liệu, owner corpus, hai đường đối chiếu, cấm copy mã chưa rõ phép, UTC+7.

Còn mở: chuyên gia độc lập; giấy phép Hồ Ngọc Đức bằng văn bản; file corpus; báo cáo oracle T047.
