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

## Quy trình ủy quyền Codex / Cursor

- Codex là agent chính, điều phối công việc và chịu trách nhiệm cuối cùng. Codex sở hữu UI/UX, mỹ thuật, style, layout, chữ, màu, khoảng cách, animation, asset, icon, responsive/adaptive layout, phần trình bày accessibility, interaction polish, kiểm thử UI, đọc screenshot, visual QA, tích hợp, regression và review cuối.
- Cursor CLI là worker triển khai cho phần logic phi thị giác đủ lớn khi việc ủy quyền giúp giảm ngữ cảnh mà không tăng chi phí phối hợp. Cursor không phải owner UI, người quyết định kiến trúc hay reviewer cuối.
- Trước việc không tầm thường, Codex phân loại nội bộ là `VISUAL`, `LOGIC` hoặc `MIXED`. `VISUAL` do Codex làm. `LOGIC` chỉ giao Cursor khi vượt ngưỡng bên dưới. `MIXED` phải tách: Codex giữ presentation; Cursor chỉ nhận phần logic đã cô lập.

### Ngưỡng ủy quyền

- Codex tự làm import, prop wiring, event handler nhỏ, data mapping hiển nhiên, UI-local state, glue code và thay đổi logic rất nhỏ.
- Dùng Cursor cho business/domain logic nhiều file, thuật toán, state phi thị giác không tầm thường, API/service/repository, persistence, validation, parsing, data transformation, caching, import/export, utility dùng lại, unit test nặng logic hoặc refactor lớn.
- Không gọi Cursor cho nhiều việc vụn. Gom một phần logic nhất quán thành một task hẹp, có điểm hoàn tất rõ.

### Cách gọi Cursor CLI

- Dùng non-interactive mode từ workspace hiện tại:

  ```bash
  agent -p "<task>" --output-format text
  ```

- Prompt phải nêu mục tiêu, file/thư mục liên quan, hành vi mong đợi, ràng buộc kiến trúc, file được sửa, vùng cấm sửa, test cần chạy và tiêu chí hoàn tất. Không đưa bối cảnh mỹ thuật không cần thiết vào prompt logic.
- Dùng khung sau và điền đường dẫn cụ thể:

  ```text
  You are the logic implementation worker for this task.

  OBJECTIVE
  <logic objective>

  RELEVANT FILES
  <paths>

  EXPECTED BEHAVIOR
  <requirements>

  ARCHITECTURAL CONSTRAINTS
  <project-specific constraints>

  YOU MAY MODIFY
  <allowed paths>

  DO NOT MODIFY
  <UI / unrelated paths>

  If UI changes appear necessary, do not implement them.
  Report them back to Codex.

  TESTING
  Add or update focused tests and run relevant tests.

  COMPLETION
  Report:
  - changed files
  - implementation summary
  - test results
  - anything Codex must integrate

  Keep the report concise.
  ```

### Bảo vệ UI và công việc đang có

- Khi giao logic, mặc định cấm Cursor sửa stylesheet, layout, màu, chữ, khoảng cách, animation, icon, asset, visual markup và presentation component. Nếu logic đang nằm trong view, ưu tiên yêu cầu trích sang hook, service, utility, repository, domain hoặc state module phi thị giác; Codex tự nối lại vào UI.
- Không giao trọn một feature UI chỉ vì feature đó có logic. Ngoại lệ cho phép Cursor chạm file UI phải được Codex giới hạn rõ theo từng file và từng thay đổi logic, không trao quyền quyết định phần nhìn.
- Giữ nguyên thay đổi chưa commit và kiến trúc hiện hành. Không reset, bỏ hay revert việc không thuộc task; không dọn code ngoài phạm vi. Trước khi hoàn tác, phân biệt thay đổi có sẵn của người dùng, thay đổi của Codex và thay đổi do Cursor tạo.

### Review sau ủy quyền

- Không nhận output Cursor theo mặc định. Sau mỗi lần giao, Codex kiểm `git status`, danh sách file đổi, `git diff --stat` và diff liên quan; xác nhận Cursor đúng phạm vi và không làm hỏng việc đang dở.
- Codex chạy lại test liên quan, typecheck/lint/build khi phù hợp, tích hợp logic, chạy UI bị ảnh hưởng, đọc screenshot, tiếp tục polish và kiểm regression. Chỉ Codex kết luận trạng thái cuối.
- Để tiết kiệm token, sau khi Cursor xong chỉ đọc trước danh sách file đổi, diff summary, đoạn diff liên quan và output test. Không đọc lại file lớn không đổi nếu không cần; tránh trao đổi nhiều vòng khi một prompt đầy đủ có thể giải quyết task.

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
