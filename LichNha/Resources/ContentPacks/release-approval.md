# Content pack release approval (T147)

Ngày: 09/09/2026
Trạng thái: `BLOCKED` — reviewer 1 đã rà lại pack 1.1.0 / lịch năm 2026. Thiếu reviewer thứ hai.

T018 giữ almanac seed trong 1.0 với nhãn tham khảo. Pack `almanac-seed.json` vẫn `1.0.0-draft`.

## Reviewer 1 (kỹ thuật, 09/09/2026, lượt 2)

Validator `tools/pack-validator/validate.py` pass trên `official-vn.json`, `official-schedule-2026.json`, `culture-vn.json`, `almanac-seed.json`. Hai chuỗi approval trong JSON là placeholder `owner` / `pending-second-reviewer`, không phải chữ ký người.

| Pack | Việc thấy | Vấn đề |
|---|---|---|
| official-vn 1.1.0 | Tết Dương lịch 1/1; Tết Nguyên đán mùng 1 âm; Ngày Chiến thắng 30/4; 1/5; Quốc khánh 2/9; Giỗ Tổ 10/3 âm; Ngày Văn hóa Việt Nam 24/11 (`isDayOff` true, NQ 28/2026/QH16 qua cổng Chính phủ) | NQ 28 chưa dẫn bản VBPL/công báo gốc. Phạm vi pack `2026–2100`; engine vẫn 1900–2100 |
| official-schedule-2026 1.0.0 | 16, 18–20/2/2026 (Tết CCVC; mùng 1 ở pack luật); 1/9/2026 liền kề Quốc khánh; 22/8/2026 làm bù, `isDayOff` false | Chỉ mã hóa phương án CCVC. Doanh nghiệp chọn 1/9 hoặc 3/9; không ghi 29–31/8 là ngày lễ Điều 112 |
| culture-vn 1.1.0 | Đoan Ngọ 5/5 âm; Trung thu 15/8 âm; Vu Lan 15/7 âm; cả ba `isDayOff: false` | Trung thu và Vu Lan chưa có URL nguồn; reviewer văn hóa chưa ký |
| almanac-seed 1.0.0-draft | Ba phương pháp tách, Sát Chủ / Thọ Tử chưa khóa | Gate 3 UNTESTED; không được coi là ấn bản phát hành |

`holiday-scenes.json` vẫn gắn `tet-nguyen-dan` và `trung-thu`. Cảnh Tết chỉ mùng Một. Không gộp kết luận almanac.

## Reviewer 2

Chưa chỉ định. Không ghi APPROVED.

## Kết luận

Pack luật đã có các ngày danh xưng Điều 112 và Tết Nguyên đán mùng 1. Lịch nghỉ đủ năm 2026 vẫn phụ thuộc pack lịch năm và đối tượng. T147 chưa xong vì thiếu reviewer thứ hai.
