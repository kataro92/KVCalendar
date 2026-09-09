# Báo cáo đối chiếu nguồn lịch (T047)

Ngày: 09/09/2026. Engine: `lich-nha-cal-1`. Phạm vi công bố: dương lịch 1900–2100, quy tắc UTC+7.

## Nguồn đang dùng

Quy tắc Sóc, tháng 11 (chứa Đông chí) và tháng nhuận lấy từ bài [Hồ Ngọc Đức, 2008](https://www.xemamlich.uhm.vn/calrules.html). Engine viết lại công thức; không chép mã JavaScript gốc.

Ba mốc đã in trong bài đó khớp engine và nằm trong `calendar-golden.json` với `sourceKind=published-example`:

- 4/12/1983: Sóc trước Đông chí, đầu tháng 11 năm 1983
- 2/2/1984: mùng 1 Tết Giáp Tý
- 21/3/2004: mùng 1 tháng 2 nhuận

## Nguồn thứ hai không dùng làm oracle

Hong Kong Observatory công bố lịch âm theo UTC+8. Lịch Nhà neo UTC+7 / 105°E. Khác ngày quanh Sóc gần nửa đêm là hệ quả múi giờ, không phải lỗi cần “chọn bên HKO”.

Không có engine độc lập thứ hai trong repo (không nhúng mã Hồ Ngọc Đức, không gọi API lịch). Các bản ghi `engine-self*` và `soc-near-midnight*` khóa hồi quy của chính `lich-nha-cal-1`. Chúng chưa phải xác nhận kép.

## Cách xử lý khác biệt

Khi một nguồn ngoài in khác engine:

1. Kiểm tra múi giờ. UTC+8 vs UTC+7 gần nửa đêm: giữ UTC+7, ghi chú trong `sourceNote`.
2. Năm 1968–1975: gắn `documentedException`. Không chọn một lịch miền làm “đúng” khi chưa có bản in đối chiếu từng ngày.
3. Trước 1976 (trừ 1968–1975): nhãn hồi chiếu thiên văn, không tuyên bố lịch pháp định thống nhất.
4. Ca `published-example` lệch engine: dừng phát hành corpus, sửa engine hoặc hạ ca đó khỏi nhóm published.

Owner corpus: chủ dự án (T019). Checksum SHA-256 của mảng `records` phải khớp test `goldenCorpusMatchesEngine`.
