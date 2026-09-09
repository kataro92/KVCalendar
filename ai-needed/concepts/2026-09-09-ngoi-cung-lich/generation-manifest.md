# Generation manifest — Ngồi cùng lịch

- Asset group: LN-CONCEPT-20260909-01.
- Ngày tạo: 2026-09-09, Asia/Bangkok.
- Tool: image_gen tích hợp; tạo ảnh và chỉnh ảnh bằng prompt.
- Model/version, seed: không được công cụ công bố; không suy đoán.
- Người yêu cầu: chủ dự án trong task hiện tại. Người vận hành: Codex.
- Nguồn: brief nguyên bản từ yêu cầu người dùng và tài liệu Lịch Nhà. Không dùng ảnh đối thủ hoặc ảnh ngoài dự án.
- Owner/quyền: tạo cho dự án Lịch Nhà; chủ thể quyền và điều khoản phát hành chưa được con người kiểm chứng. rights_status: pending.
- Phạm vi: concept nghiên cứu nội bộ. output_status: draft; production: HOLD.
- Reviewer con người: chưa có. AI visual review: đã xem các ảnh; nhận xét trong phan-tich-giao-dien.md.
- Bản bàn giao chọn: 01-nang-ben-ban-v1, 02-mua-ngoai-hien-v2, 03-dem-hoc-bai-v2.
- Chỉnh sửa: v2 mưa/đêm loại đạo cụ phòng, giảm texture, đổi số sans-serif, làm rõ toggle; không sửa ảnh bằng công cụ khác.
- Cleanup/LOD/UV: không áp dụng cho concept raster. Poster runtime, accessibility, hiệu năng, kiểm tra văn hóa và quyền phát hành: chưa duyệt.
- Rodin: không sử dụng. Nếu tạo 3D về sau, bắt buộc ảnh đã duyệt → Image-to-3D; không dùng prompt chữ đơn độc.

## Lượt tạo và input

- 01-nang-ben-ban-v1: generate từ prompt, input image/hash: không có. Output gốc: C:\Users\Ryzen5-PC\.codex\generated_images\01a0846a-6847-7ff0-8b1a-860cf838bd9e\exec-484314b5-e266-4a6c-9809-e3f5052a9268.png.
- 02-mua-ngoai-hien-v1: generate từ prompt, input image/hash: không có. Output gốc: C:\Users\Ryzen5-PC\.codex\generated_images\01a0846a-6847-7ff0-8b1a-860cf838bd9e\exec-49c5395a-a143-4747-8fd4-f0e62ca8f261.png.
- 03-dem-hoc-bai-v1: generate từ prompt, input image/hash: không có. Output gốc: C:\Users\Ryzen5-PC\.codex\generated_images\01a0846a-6847-7ff0-8b1a-860cf838bd9e\exec-9e86b13a-60e1-4ef1-9b8d-f310fd641072.png.
- 02-mua-ngoai-hien-v2: edit từ 02-mua-ngoai-hien-v1.png, input hash xem bảng bên dưới. Output gốc: C:\Users\Ryzen5-PC\.codex\generated_images\01a0846a-6847-7ff0-8b1a-860cf838bd9e\exec-8b2b0bda-36a8-41d2-a5a6-6c2b3158fabc.png.
- 03-dem-hoc-bai-v2: edit từ 03-dem-hoc-bai-v1.png, input hash xem bảng bên dưới. Output gốc: C:\Users\Ryzen5-PC\.codex\generated_images\01a0846a-6847-7ff0-8b1a-860cf838bd9e\exec-af0379d0-c9c6-4db0-a0b5-9ed880feec24.png.

## SHA-256

| File | SHA-256 |
|---|---|
| 01-nang-ben-ban-v1.png | 9AECFCF6F0719E85674319E45E20B28F3A8F8EAB794940D24C2B26B0F87982B3 |
| 02-mua-ngoai-hien-v1.png | C5A54B28D8F2B904933F72BF7A28528F311DB1137EE6773DA6516270FDFCD473 |
| 02-mua-ngoai-hien-v2.png | 08D4C0E0B0EAABEEB8623F8E5F9935634978C9DBA9C30F8CCD6A46BE0F92FE7E |
| 03-dem-hoc-bai-v1.png | 7742092B0983EB37B2D9CCE2E0D2043D42646FE7EEF585EDB8D443614EFAF34F |
| 03-dem-hoc-bai-v2.png | E94824BAE4E7B086AE06782DB24A65C466500FD07F3BFFAD64AAB4180037BD8E |
| phan-tich-giao-dien.md | 69222479724F8A4FDB5288F9282D10AA2D122BA5C0E66B016407F56D5827D36F |
| prompts-v1.md | 79A8BA50139823E57EF8979ACBDF46D6792456C4FDFCC5A626BCC8B2C3FEC163 |

Các ảnh trong workspace là bản sao nguyên byte từ output công cụ. Prompt đầy đủ và đường dẫn input được giữ trong prompts-v1.md. Nội dung ngày là dữ liệu minh họa, không dùng làm dữ liệu lịch.

