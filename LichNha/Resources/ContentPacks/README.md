# Content packs seed

Bốn gói đi kèm binary:

- `official-vn.json` 1.1.0: ngày nghỉ mang tên trong Điều 112 và Ngày Văn hóa Việt Nam 24/11. Tết Nguyên đán chỉ gắn mùng 1 âm (`tet-nguyen-dan`) để khớp effect pack. Năm ngày Tết còn lại và ngày liền kề Quốc khánh nằm ở pack lịch năm.
- `official-schedule-2026.json` 1.0.0: bố trí 2026 theo TB 9441/TB-BNV (công chức, viên chức). Không gộp hoán đổi cuối tuần vào Điều 112.
- `culture-vn.json` 1.1.0: Đoan Ngọ, Trung thu, Vu Lan; `isDayOff` luôn false.
- `almanac-seed.json` 1.0.0-draft: ba phương pháp tách. Gate 3 vẫn UNTESTED.

Checksum SHA-256 do `tools/pack-validator/write_seed_packs.py` ghi. Không chứa sự kiện cá nhân. Chuỗi approval `owner` / `pending-second-reviewer` không phải chữ ký người; T147 còn mở.

Sát Chủ / Thọ Tử chỉ có nhãn “chưa khóa ấn bản”; engine không kết luận.
