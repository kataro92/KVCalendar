# Definition of Ready

Ngày đánh giá: **08/09/2026**
Quyết định: **READY WITH WAIVERS**

Chủ dự án yêu cầu bắt đầu T021 trong khi một số cổng nghiên cứu người thật chưa chạy. Implementation được mở. Gate 1–7 vẫn `UNTESTED`. Không cổng nào được ghi PASS từ persona hay từ waiver này.

## Checklist

| Điều kiện | Trạng thái | Bằng chứng |
|---|---|---|
| Spec, plan, contracts, backlog | Đạt | `specs/001-lich-nha-v1/` |
| Desk research | Đạt | `research/desk-research/evidence-register.md` |
| Persona mô phỏng có ranh giới | Đạt; không thay người thật | `research/synthetic-panel/` |
| 20 buổi người thật (T012) | **WAIVED** | Chủ dự án, 08/09/2026 |
| Gate 5A 55+/VoiceOver (T013) | **WAIVED cho T020**; Gate 5B vẫn chặn release | T013 còn mở |
| Diaspora (T014) | **WAIVED cho T020** | Policy tạm trong spec Assumptions |
| Gate 1–4, 5A–7A (T016) | **WAIVED cho T020**; bảng gate vẫn `UNTESTED` | `research/decisions/001-research-gates.md` |
| Audit 6–10 lịch bloc (T004) | **WAIVED cho T020** | Biểu mẫu còn trống |
| File âm Hiên sớm / Mưa xa (T010) | **WAIVED cho T020**; mặc định phát hành Yên | Protocol đã có, WAV chưa có |
| Nguồn lịch + owner (T017) | Đạt ở mức owner | `research/decisions/002-calendar-sources.md` |
| Ruleset tốt/xấu (T018) | Đạt: giữ 1.0, ba phương pháp tách | `research/decisions/003-almanac-ruleset.md` |
| Support matrix + phí (T019) | Đạt ở mức owner/phí; máy thật chưa kê | `research/decisions/004-release-ownership.md` |

## Việc waiver không cho phép

- Đánh dấu T004, T010, T012–T016 là hoàn tất.
- Đổi `UNTESTED` thành `PASS`.
- Bỏ Gate 5B–7B, golden corpus, cultural review Quốc kỳ, hay TestFlight.
- Ship almanac pack khi chưa khóa ấn bản thần sát và test vector.

## Ký

Người ký: chủ dự án
Ngày: 08/09/2026
Phạm vi mở: T021 trở đi trên branch hiện tại
Phạm vi không mở: tuyên bố đã kiểm chứng người dùng
