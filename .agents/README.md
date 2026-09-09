# Cấu hình AI cục bộ của KVCalendar

Thư mục này giữ kỹ năng bên thứ ba và quy trình riêng của dự án. Codex có thể nhận kỹ năng đặt trong `.agents/skills`; các rule dành cho Cursor nằm ở `.cursor/rules`.

## Kỹ năng đã cài

- `avoid-ai-writing`: rà văn xuôi để bớt công thức, dài dòng và giọng quảng cáo.
- `ui-ux-pro-max`: tra cứu pattern UI/UX, typography, màu, accessibility và stack guidance.
- `speckit-*`: constitution, specification, plan, task breakdown, analysis, implementation và
  convergence theo GitHub Spec Kit 1.0.4.

Kỹ năng mới cài được nhận từ lượt làm việc kế tiếp. Nguồn, commit và giấy phép nằm trong [SOURCES.md](SOURCES.md).

## Quy trình của dự án

- [Rodin: ảnh tham chiếu sang 3D](workflows/rodin-image-to-3d.md)
- [Rà UI/UX](workflows/ui-ux-review.md)
- [Rà văn phong](workflows/writing-review.md)
- [Ảnh hiện trạng UI](workflows/capture-current-ui.md)

## Feature Spec Kit hiện hành

- [Hiến pháp dự án](../.specify/memory/constitution.md)
- [Đặc tả Lịch Nhà 1.0](../specs/001-lich-nha-v1/spec.md)
- [Kế hoạch kỹ thuật](../specs/001-lich-nha-v1/plan.md)
- [Danh sách task](../specs/001-lich-nha-v1/tasks.md)

Không chạy task mã nguồn trước checkpoint T020 trong `tasks.md`.

Không sửa trực tiếp thư mục của kỹ năng đã cài. Nếu cần quy ước riêng, bổ sung vào `workflows/`, `AGENTS.md` hoặc `.cursor/rules/`. Việc nâng phiên bản phải có chủ ý, ghi lại commit mới và đọc thay đổi trước khi thay thế bản đang dùng.
