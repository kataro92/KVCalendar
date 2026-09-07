# Definition of Ready — trạng thái hiện tại

Ngày đánh giá: **07/09/2026**
Quyết định: **NOT READY**

Tài liệu sản phẩm có thể tiếp tục hoàn thiện, nhưng T021 trở đi chưa được bắt đầu.

## Checklist

| Điều kiện | Trạng thái | Bằng chứng/thiếu hụt |
|---|---|---|
| Spec, plan, contracts và backlog tồn tại | Đạt ở mức tài liệu | `specs/001-lich-nha-v1/` |
| Desk research và sổ chứng cứ | Đạt | `research/desk-research/evidence-register.md` |
| Persona mô phỏng có ranh giới | Đạt | `research/synthetic-panel/` |
| 20 buổi nghiên cứu người thật | Chưa đạt | T012 chưa chạy |
| Vòng 55+/VoiceOver | Chưa đạt | T013 chưa chạy |
| Diaspora validation | Chưa đạt | T014 chưa chạy |
| Gate 1–4 và 5A–7A | Chưa đạt | mọi research gate `UNTESTED` |
| Audit 6–10 lịch bloc vật lý | Chưa đạt | T004 còn mở |
| Audio stimuli/protocol hoàn chỉnh | Chưa đạt | T010 còn mở |
| Golden corpus, oracle, license và owner | Chưa đạt | T017 còn mở |
| Ruleset tốt/xấu hoặc quyết định loại khỏi 1.0 | Chưa đạt | T018 còn mở |
| Support matrix, phí và maintenance owner | Chưa đạt | T019 còn mở |

## Rủi ro đã giảm nhưng chưa đóng

- bỏ claim “đầu tiên/duy nhất”;
- phân tách UTC+7, ngày hiển thị và giờ notification;
- mặc định phát hành an toàn cho audio là Yên khi chưa có Gate 7;
- không áp một thông lệ giỗ thành rule toàn quốc;
- ghi chính xác giới hạn của Lập Xuân, pháo hoa và lịch lịch sử.

## Điều kiện ký

Chỉ đổi trạng thái sau khi T016–T019 có owner và bằng chứng, spec được cập nhật theo quyết định thật, các blocker trên được đóng và chủ dự án ký T020. Không ký có điều kiện bằng dữ liệu persona tổng hợp.

Gate 5B–7B không phải điều kiện trước T020 vì cần implementation, thiết bị và asset thật; chúng vẫn
là cổng bắt buộc trước release và không được xem là pass từ vòng `A`.
