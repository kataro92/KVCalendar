# License và provenance audit

Trạng thái: **TEMPLATE — chưa có production asset hoặc binary**
Liên kết task: T148 không được đánh dấu trước khi asset thật tồn tại.

## Quy tắc duyệt

Một asset chỉ được chuyển thành `APPROVED` khi có file thật, checksum, nguồn, giấy phép/điều khoản tại ngày nhận, quyền sửa/phân phối trong app, người duyệt và phạm vi dùng. Link trang chủ hoặc câu “AI-generated” không phải bằng chứng quyền.

## Candidate ledger

| Asset/nhóm | Nguồn dự kiến | Quyền hiện biết | File/checksum | Review | Trạng thái |
|---|---|---|---|---|---|
| Be Vietnam Pro | upstream repository trong `docs/07` | OFL-1.1 theo upstream | Chưa có | cần lưu license text và subset audit | `CANDIDATE` |
| EB Garamond | Google Fonts/upstream | OFL theo metadata | Chưa có | cần kiểm tiếng Việt ở weight dùng thật | `CANDIDATE` |
| Bitter | Google Fonts/upstream | OFL theo metadata | Chưa có | phương án thay thế nếu EB Garamond không đạt | `CANDIDATE` |
| Khánh/cành 3D | ảnh concept dự án → Rodin Image-to-3D | phụ thuộc quyền ảnh và plan/Terms lúc tạo | Chưa có | generation + cleanup + LOD + poster | `NOT CREATED` |
| Quốc kỳ/ngôi sao | dựng tay theo nguồn pháp lý | không qua Rodin; artwork mới của dự án | Chưa có | geometry, màu master, crop/motion | `NOT CREATED` |
| Particle pháo/hoa/mưa | atlas/shape dự án tự tạo | chưa có asset | Chưa có | không sao chép pack thương mại | `NOT CREATED` |
| Hiên sớm/Mưa xa | nguồn tham số + Foley/ElevenLabs nếu dùng | phụ thuộc plan, Beta status và Terms lúc tạo | Chưa có | loop, transient, loudness, commercial rights | `NOT CREATED` |
| Texture giấy/gỗ/sơn | tự chụp/tự vẽ hoặc thư viện có license | chưa chọn | Chưa có | không dùng scan lịch thương mại | `NOT CREATED` |
| Ca dao/tục ngữ | corpus cần public-domain/editorial review | chưa chọn | Chưa có | tác giả, bản ghi, dị bản, quyền | `HOLD` |

## Manifest tối thiểu cho từng asset

```text
asset_id:
file:
sha256:
source_url_or_path:
source_owner:
license_or_terms:
terms_snapshot_date:
commercial_use:
modification_allowed:
attribution_required:
reference_image_rights:
tool_and_version:
generation_mode: image-to-3d | manual | procedural | recorded | other
editing_steps:
reviewers:
approved_scope:
expiry_or_recheck_date:
```

`generation_mode: text-to-3d` là không hợp lệ. Với Rodin, manifest phải trỏ tới ảnh tham chiếu có quyền và output gốc. Với ElevenLabs, lưu plan, trạng thái Beta, prompt/output và Terms snapshot; file không được bán/phân phối như thư viện âm độc lập.

## Cổng trước release

- không hàng nào ở release pack mang `UNKNOWN`, `CANDIDATE`, `HOLD` hoặc `NOT CREATED`;
- license text và attribution đi kèm khi bắt buộc;
- quyền của reference image được kiểm riêng với quyền của output;
- mọi biến thể/LOD/poster trỏ về cùng provenance root;
- privacy label khớp công cụ thật được dùng trong app; công cụ chỉ dùng offline production không bị mô tả như SDK runtime;
- hai reviewer kiểm độc lập các asset văn hóa nhạy cảm.

Cho tới khi ledger có file và checksum thật, tài liệu này chỉ là khung audit.
