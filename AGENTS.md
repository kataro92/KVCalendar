# Hướng dẫn cho AI agent

## Phạm vi hiện tại

- T020 đã ký `READY WITH WAIVERS` (08/09/2026). Được tạo mã ứng dụng và project Xcode theo `specs/001-lich-nha-v1/tasks.md` từ T021. Không đánh dấu T012–T016 hay Gate 1–7 là pass. Không tạo asset production Rodin/ElevenLabs khi chưa có ảnh tham chiếu đã duyệt.
- Sản phẩm có tên làm việc **Lịch Nhà**: lịch bloc Việt Nam trên iOS, miễn phí, không quảng cáo, không paywall, không đăng nhập và dùng được offline. Nhóm chính là người 16–34 tuổi quan tâm lịch âm và văn hóa Việt; người lớn tuổi vẫn được hỗ trợ như một yêu cầu accessibility, không phải định vị trung tâm.
- Trước khi sửa tài liệu, đọc `README.md` và các tài liệu liên quan trong `docs/`. Với quyết định giao diện, đọc thêm `design-system/lich-nha/MASTER.md`.
- Mã gốc và tài liệu dự án: Apache License 2.0 (`LICENSE`, `NOTICE`). Không đổi giấy phép skill trong `.agents/skills/` hay Spec Kit trong `.specify/`.
- Không đọc hoặc dùng `.env` nếu công việc không đòi hỏi và người dùng chưa cho phép.

## Kỹ năng cục bộ bắt buộc

- Việc về UI/UX: đọc `.agents/skills/ui-ux-pro-max/SKILL.md`, chạy truy vấn nhỏ nhất có ích, rồi đối chiếu kết quả với hướng **Mộc Son Dịu**. Kết quả chung chung của kỹ năng không được tự động thay thế ngôn ngữ sản phẩm.
- Viết hoặc sửa văn xuôi hướng người đọc: đọc `.agents/skills/avoid-ai-writing/SKILL.md` và `references/patterns.md`. Chọn giọng `docs` hoặc `technical`, sửa tối thiểu, giữ nguyên dữ kiện, bảng, trích dẫn và URL.
- Không dùng công cụ phát hiện văn bản AI để kết luận ai là tác giả. Chỉ xem nó như tín hiệu biên tập.
- Với tiếng Việt, áp dụng nguyên tắc về nhịp, độ cụ thể và cấu trúc; không dịch máy móc danh sách từ cấm tiếng Anh.
- Không chỉnh nội dung trong `.agents/skills/`; đây là bản cài từ bên thứ ba. Ghi bổ sung của dự án nằm trong `.agents/workflows/`, `.cursor/rules/` hoặc tài liệu dự án.

## Quy trình Spec Kit

- Spec Kit được ghim ở phiên bản 1.0.4, tích hợp Codex dưới `.agents/skills/speckit-*` và hạ tầng nằm trong `.specify/`.
- Với feature mới hoặc thay đổi phạm vi đáng kể, đi theo thứ tự `$speckit-constitution` → `$speckit-specify` → `$speckit-clarify` khi cần → `$speckit-plan` → `$speckit-tasks` → `$speckit-analyze` → `$speckit-implement` → `$speckit-converge`.
- Feature tổng hiện tại là `specs/001-lich-nha-v1/`. Đọc `spec.md`, `plan.md`, `tasks.md` và artifact liên quan trước khi triển khai.
- T020 đã xác nhận Definition of Ready có waiver. Checkbox task phải phản ánh bằng chứng trong file đích, không đánh dấu theo ước lượng. T012–T016 chỉ đánh dấu khi buổi/file thật tồn tại.
- Sau mỗi lát UI nhìn thấy được: chụp Simulator vào `LichNha/Tests/Screenshots/current/` (ghi đè, không giữ lịch sử, không viết báo cáo kèm ảnh). Dùng `tools/capture-current-ui.sh`.
- Repository dùng Git, branch `main` theo dõi `origin` trên GitHub. Không force-push, đổi lịch sử hoặc chuyển task thành issue nếu người dùng chưa yêu cầu.

## Luật thiết kế

- Giao diện theo hướng **Mộc Son Dịu**: lịch bloc bằng giấy/gỗ/sơn son, phối pastel ít bão hòa, hình khối mềm và hơi dễ thương nhưng không giống app trẻ em, claymorphism hoặc sticker chibi dày đặc.
- Dùng chi tiết dễ thương ở tỷ lệ, góc bo, minh họa nhỏ và chuyển động; không làm suy yếu thứ bậc ngày dương, ngày âm hoặc độ tương phản.
- Vẫn dùng semantics nền tảng: VoiceOver, Dynamic Type, focus rõ, vùng chạm tối thiểu 44 pt và thao tác thay thế cho mọi gesture kéo/bóc.
- Mỗi cảnh ngày có tối đa một hiệu ứng chính. Luôn có Reduce Motion, Dim Flashing Lights, Low Power và poster tĩnh.
- Quốc kỳ và ngôi sao phải dựng, đo và duyệt thủ công; không cho mô hình tạo sinh quyết định hình học, màu, crop hoặc chuyển động làm biến dạng biểu tượng.
- Tách ba lớp âm: nền tập trung, phản hồi giấy và cue sự kiện. Khi chưa có Gate 7 với người thật, bản phát hành mặc định Yên; Hiên sớm là opt-in/ứng viên prototype, âm giấy và cue sự kiện tắt mặc định. Luôn tôn trọng Silent, VoiceOver và audio đang phát từ ứng dụng khác.

## Luật Rodin

- Chỉ dùng quy trình **ảnh tham chiếu → Image-to-3D**. `Text-to-3D` và đầu vào chỉ có prompt chữ bị cấm trong dự án.
- Ảnh tham chiếu phải do dự án tạo, sở hữu hoặc có giấy phép; không lấy màn hình, artwork hay lịch của đối thủ làm nguồn.
- Prompt chữ, nếu giao diện cho phép, chỉ là chỉ dẫn phụ sau khi đã tải ảnh; nó không được là đầu vào duy nhất.
- Rodin chỉ tạo phôi. Mọi output phải qua sửa silhouette, topology, UV, material, scale, LOD, poster tĩnh, kiểm tra văn hóa, quyền và hiệu năng.
- Không gọi Rodin lúc app chạy và không đưa API key vào ứng dụng.
- Lưu manifest cho từng asset: nguồn ảnh, chủ sở hữu/quyền, công cụ và phiên bản, ngày tạo, output gốc, các bước biên tập, reviewer và phạm vi sử dụng.
- Artifact bàn giao cho AI đặt trong `ai-needed/`; giữ input/output có version và hash, Rodin Image-to-3D từ ảnh tham chiếu là bắt buộc, và không gọi model lúc runtime.
