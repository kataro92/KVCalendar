# 002 — Nguồn lịch và Calendar Oracle

**Trạng thái:** `DRAFT · HOLD`
**Ngày rà soát:** 07/09/2026
**Phạm vi:** lịch âm Việt Nam hiện đại, 24 tiết khí, múi giờ và bộ ngày chuẩn.

## Quyết định tạm thời

Chưa chọn được một nguồn đủ thẩm quyền, phạm vi và điều kiện sử dụng để làm Calendar Oracle duy nhất. Lịch Nhà chỉ được triển khai Calendar Core sau khi có ít nhất hai đường kiểm chứng độc lập, người chịu trách nhiệm dữ liệu và golden corpus có provenance.

UTC+7 là múi giờ tính lịch Việt Nam hiện đại. “Hôm nay” trên thiết bị và giờ gửi nhắc là lớp sản phẩm riêng; chúng không được âm thầm thay đổi quy tắc lịch.

## Bậc thang nguồn đang có

| Nguồn | Vai trò được phép | Giới hạn | Quyền sử dụng |
|---|---|---|---|
| [Quyết định 134/2002/QĐ-TTg](https://vbpl.vn/TW/Pages/vbpq-toanvan.aspx?ItemID=21982), ban hành 14/10/2002 | Căn cứ pháp lý rằng giờ chính thức của Việt Nam là múi giờ thứ 7 | Không mô tả thuật toán âm lịch | Chưa rà soát điều khoản tái phân phối dữ liệu trích xuất |
| [Bản tin VAST 02/2019](https://isdi.vast.vn/bantin/BantinKHCN022019.pdf) | Tài liệu chuyên môn về Sóc, Khí, tháng 29/30 ngày, tháng nhuận và các ca nhạy gần nửa đêm | Không phải bộ dữ liệu chuẩn có checksum; bài viết cho biết dữ liệu được phê duyệt khi đó chỉ đến năm 2030 | Chưa thấy giấy phép cho việc đóng gói hoặc tái phân phối |
| [Hồ Ngọc Đức — quy tắc tính lịch](https://www.xemamlich.uhm.vn/calrules_en.html) và [VNCal](https://www.xemamlich.uhm.vn/vncal.html) | Mô tả kỹ thuật độc lập; tham chiếu lịch sử khác biệt 1968–1975 | Không phải nguồn nhà nước; không được dùng làm bằng chứng duy nhất | Chưa xác minh giấy phép mã và dữ liệu; không sao chép code |
| [Hong Kong Observatory — 24 Solar Terms](https://www.hko.gov.hk/en/gts/time/24solarterms.htm) và [Solar Term](https://www.hko.gov.hk/en/gts/astronomy/Solar_Term.htm) | Đối chiếu định nghĩa thiên văn và thời điểm tiết khí | Bảng dùng giờ Hong Kong UTC+8; không phải oracle ngày âm Việt Nam | Chưa rà soát quyền tái phân phối bảng |
| [IANA Time Zone Database](https://data.iana.org/time-zones/tz-link.html) | ID múi giờ và lịch sử DST cho ngày dân sự/notification | Không xác định lịch âm | Trang dự án nêu tz database thuộc public domain |

Ngày truy cập các URL trên: 07/09/2026. Độ tin cậy cao cho văn bản pháp luật và định nghĩa thiên văn trong đúng phạm vi của chúng; trung bình cho việc chuyển thành quy tắc sản phẩm cho đến khi có chuyên gia duyệt. Không nguồn nào ở bảng trên tự nó là golden oracle.

## Cách đối chiếu đề xuất

1. Calendar Core ghi rõ phiên bản quy tắc, múi giờ tính và độ chính xác thời điểm.
2. Kết quả được so với một corpus có giá trị kỳ vọng do owner ký; không lấy biểu quyết đa số giữa các website.
3. Một đường tính thiên văn độc lập kiểm tra Sóc và tiết khí. Sai khác phải được lưu cùng nguyên nhân, nguồn và quyết định xử lý.
4. Dữ liệu lịch sử trước 1976 phải có nhãn phạm vi. Giai đoạn 1968–1975 cần phân biệt nguồn/lịch sử vùng, không giả vờ chỉ có một ngày âm duy nhất.

## Golden corpus tối thiểu

Corpus phải có provenance cho từng bản ghi: ngày dương, kết quả âm kỳ vọng, cờ nhuận, múi giờ, nguồn, phiên bản nguồn, người duyệt và checksum. Các nhóm bắt buộc gồm:

- Tết, đầu/cuối tháng âm, tháng 29 và 30 ngày;
- năm có tháng nhuận và hai tháng trùng tên;
- Sóc hoặc chuyển tiết gần nửa đêm UTC+7;
- các sai khác lịch sử 1968–1975;
- các ca biên trong toàn phạm vi năm công bố.

Hiện chưa có file corpus, giá trị kỳ vọng đã ký, checksum hoặc báo cáo sai khác. Danh sách trên là phạm vi cần xây, không phải bằng chứng rằng các ca đã được xác nhận.

## Điều còn thiếu để bỏ `HOLD`

- **Calendar Data Owner:** chưa chỉ định người chịu trách nhiệm nguồn, version và quyết định khi có sai khác.
- **Golden Corpus Owner:** chưa chỉ định người ký giá trị kỳ vọng và quản lý thay đổi.
- **Chuyên gia độc lập:** chưa có người có chuyên môn lịch pháp Việt Nam nhận review phạm vi 1900–2100 và các ca lịch sử.
- **Giấy phép:** chưa có kết luận bằng văn bản cho mã/dữ liệu Hồ Ngọc Đức, bảng VAST/HKO và quyền đóng gói trong ứng dụng.
- **Oracle:** chưa có nguồn thứ hai độc lập với phạm vi và độ chính xác đã chốt.
- **Artifact:** chưa có corpus có provenance, checksum và báo cáo reconciliation.

Tài liệu này mới là draft review. Nó **không hoàn tất T017** và không phải phê duyệt để bắt đầu implementation.
