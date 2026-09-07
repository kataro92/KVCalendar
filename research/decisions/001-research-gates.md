# Trạng thái Gate 1–4 và Gate 5A–7B

Ngày cập nhật: **07/09/2026**
Kết luận: **NOT RUN — không có participant hoặc prototype chạy được**

Desk research và persona tổng hợp không được tính vào mẫu. Bảng này ghi trạng thái trung thực, không phải kết quả pass/fail của T016.

| Gate | Cần đo | Bằng chứng hiện có | Trạng thái | Việc còn thiếu |
|---|---|---|---|---|
| 1 — concept | nhận diện lịch bloc, cảm giác nhà/gia đình, độ đọc | mô tả A/B/C và desk audit | `UNTESTED` | visual prototype cùng nội dung; người thật |
| 2 — gesture | sang ngày, action thay thế, thời gian, khó chịu | đặc tả ba mức page curl | `UNTESTED` | interactive prototype; thiết bị; quan sát |
| 3 — thông tin | đọc ngày dương/âm, trường thiếu, hiểu nhãn nguồn | hierarchy và giả thuyết progressive disclosure | `UNTESTED` | prototype mặt trước/sau; comprehension test |
| 4 — ngày giỗ | tạo event, hiểu policy tháng nhuận/tháng thiếu | contract và nguồn cho một thông lệ; chưa có đồng thuận phổ quát | `UNTESTED` | flow prototype; người giữ lịch gia đình |
| 5A — accessibility research | action thay gesture, reflow và đường semantic trong phạm vi prototype | design requirements và contract | `UNTESTED` | prototype; người dùng công nghệ hỗ trợ/55+ |
| 5B — accessibility release | toàn bộ core tasks bằng VoiceOver/chữ 200%/cài đặt hệ thống | core-task list | `UNTESTED` | semantic build; support matrix; device/user review |
| 6A — effect concept | độ đọc, sắc thái, văn hóa, Reduce Motion | storyboard và nguồn Quốc kỳ/Lập Xuân | `UNTESTED` | motion prototype; người thật; cultural reviewer |
| 6B — effect release | hiệu năng, asset/provenance và fallback runtime | ngân sách prototype | `UNTESTED` | production asset/build; profiling thiết bị |
| 7A — audio research | tỷ lệ tắt, mệt/mất tập trung, task result | literature review và protocol; chưa có audio stimuli | `UNTESTED` | audio mẫu và blind test |
| 7B — audio release | Silent, VoiceOver, interruption, route và background | audio contract/plan | `UNTESTED` | native build và iPhone support matrix |

## Kết luận tạm không phụ thuộc preference

- Mọi gesture có action thay thế.
- Quốc kỳ dựng tay; scene có fallback tĩnh và cài đặt an toàn.
- Tốt/xấu là tham khảo hoặc bị loại nếu không có ruleset owner.
- Release giữ **Yên** nếu Gate 7A–7B chưa chạy; Hiên sớm chỉ là ứng viên prototype.
- UTC+7 là Calendar Core; UI day và reminder timezone được tách riêng.

## Không được làm

- không đổi `UNTESTED` thành `PASS` dựa trên persona;
- không điền tỷ lệ, thời gian hay quote giả;
- không đánh dấu T012–T016 hoặc T020;
- không dùng bảng này làm giấy phép bắt đầu code.
