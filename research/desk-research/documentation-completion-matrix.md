# Ma trận hoàn tất phần tài liệu

Ngày rà soát: **07/09/2026**
Phạm vi: `README.md`, `docs/`, `design-system/lich-nha/`, `research/` và toàn bộ backlog `specs/001-lich-nha-v1/tasks.md`.

## Cách đọc

Ma trận tách trạng thái của **tệp tài liệu** khỏi trạng thái của **công việc mà tệp đó phải chứng minh**:

- `ĐÃ XONG`: nội dung tài liệu đã tồn tại và đáp ứng phần việc viết đã nêu. Với task có checkbox, trạng thái này bám theo backlog hiện tại; ma trận không tự đổi checkbox.
- `SOẠN ĐƯỢC NGAY`: có thể viết một bản dùng được bằng desk research, quyết định sản phẩm hoặc mẫu biểu, không cần app chạy.
- `BẢN NHÁP/BIỂU MẪU`: tệp đã có hoặc có thể tạo, nhưng chưa có dữ liệu thật để kết luận.
- `BỊ CHẶN`: muốn hoàn tất đúng nghĩa phải có người tham gia, chuyên gia, owner, asset có quyền, app chạy hoặc thiết bị thật.
- `REPORT SAU TRIỂN KHAI`: đuôi `.md` chỉ là nơi ghi bằng chứng. Viết trước một báo cáo trống không hoàn tất task.

Tài liệu này là sổ kiểm kê, không phải bằng chứng Gate 1–7 và không mở khóa T020.

## 1. Hồ sơ nền hiện có

| Nhóm | Artifact | Trạng thái tài liệu | Giới hạn cần giữ |
|---|---|---|---|
| Định hướng và đặc tả | `README.md`, `docs/00` đến `docs/11` | `ĐÃ XONG` ở mức đặc tả/desk research | Tên Lịch Nhà vẫn là tên làm việc; các quyết định có owner chưa được ký |
| Tổng hợp nghiên cứu | `docs/11-nghien-cuu-tong-hop-va-persona-mo-phong.md` | `ĐÃ XONG` ở mức desk research | Không biến câu trả lời tạm thành phát hiện người dùng |
| Art direction | `design-system/lich-nha/MASTER.md` | `ĐÃ XONG` ở mức định hướng prototype | Chưa phải token, asset hoặc thông số production |
| Spec Kit | `spec.md`, `plan.md`, `research.md`, `data-model.md`, `contracts/`, `quickstart.md`, `tasks.md` | `ĐÃ XONG` ở mức planning | Không có code, test output hoặc build để chứng minh implementation |
| Chứng cứ web | `research/desk-research/evidence-register.md` | `ĐÃ XONG` cho vòng desk research hiện tại | Mọi câu hỏi hành vi vẫn mang nhãn `UNTESTED` |
| Persona mô phỏng | `research/synthetic-panel/method.md`, `personas.md` | `ĐÃ XONG` cho phương pháp và proto-persona | Không có mẫu số, tỷ lệ, quote hoặc ký Gate từ persona |
| Biên bản phản biện persona | `research/synthetic-panel/deliberation.md` | `ĐÃ XONG` ở mức cognitive walkthrough; self-discussion không phải transcript phỏng vấn | Không dùng quote, tỷ lệ hoặc consensus persona |

## 2. Audit T001–T020

| Task | Artifact đã quan sát | Phần tài liệu hiện tại | Có thể làm tiếp chỉ bằng tài liệu | Điều chặn hoàn tất task | Phân loại trung thực |
|---|---|---|---|---|---|
| T001 | `research/research-brief.md` | Brief, câu hỏi và Gate 1–4/5A–7A đã có; backlog đang đánh dấu xong | Không cần thêm để đóng phần viết | Không có | `ĐÃ XONG` |
| T002 | `research/participants/recruitment-matrix.md` | Screener và quota 20 người đã có; chưa điền người thật | Có thể cập nhật kênh tuyển hoặc tiêu chí loại nếu phạm vi đổi | Việc tuyển người thuộc T012–T014, không thuộc điều kiện viết T002 | `ĐÃ XONG` |
| T003 | `research/participants/consent-and-retention.md` | Consent, ẩn danh, recording và retention đã có | Chỉ cần cập nhật khi công cụ/lưu trữ đổi | Owner nghiên cứu phải vận hành đúng lúc có session | `ĐÃ XONG` |
| T004 | `research/physical-calendar-audit.md` | Biểu mẫu có sẵn; 10 dòng đều chưa quan sát, phần pattern chưa có dữ liệu | Có thể lập danh sách nguồn tiếp cận và cách đo | 6–10 lịch bloc vật lý có quyền quan sát; ảnh/ghi chép gốc | `BẢN NHÁP · BỊ CHẶN BỞI MẪU THẬT/QUYỀN` |
| T005 | `research/prototypes/a-moc-son-diu.md` | Backlog đánh dấu xong; hiện là paper-prototype/annotation bằng Markdown | Có thể bổ sung checklist dựng frame | Muốn dùng cho test thị giác cần frame/image thật, font và texture hợp lệ | `ĐÃ XONG THEO BACKLOG · CHƯA CÓ VISUAL PROTOTYPE` |
| T006 | `research/prototypes/b-giay-moc.md` | Backlog đánh dấu xong; cùng mức mô tả tĩnh như A | Có thể bổ sung checklist dựng frame đồng nội dung | Frame/image thật để so sánh công bằng | `ĐÃ XONG THEO BACKLOG · CHƯA CÓ VISUAL PROTOTYPE` |
| T007 | `research/prototypes/c-gom-lam.md` | Backlog đánh dấu xong; cùng mức mô tả tĩnh như A | Có thể bổ sung checklist dựng frame đồng nội dung | Frame/image thật để so sánh công bằng | `ĐÃ XONG THEO BACKLOG · CHƯA CÓ VISUAL PROTOTYPE` |
| T008 | `research/prototypes/page-curl-study.md` | Ba mức chuyển động và action thay thế đã được đặc tả | Có thể hoàn thiện storyboard/frame timing | Prototype tương tác và thiết bị mới đo được gesture, khó chịu và thời gian | `ĐÃ XONG PHẦN STUDY DOC · GATE 2 BỊ CHẶN` |
| T009 | `research/prototypes/effect-storyboards.md` | Storyboard chữ cho Quốc khánh, Lập Xuân, ngày thường và fallback đã có | Có thể dựng frame minh họa có quyền sau này | Cultural review, motion prototype và thiết bị mới xác nhận Gate 6 | `ĐÃ XONG PHẦN STORYBOARD DOC · GATE 6 BỊ CHẶN` |
| T010 | `research/prototypes/audio-study.md` | Protocol và thông số mẫu đã có; WAV và manifest chưa có | Có thể hoàn thiện phiếu chấm, quy tắc randomize và log mẫu | Hai loop audio đạt chuẩn, provenance, kiểm tra tai, Silent/VoiceOver/audio khác trên iPhone | `BẢN NHÁP · BỊ CHẶN BỞI ASSET/DEVICE` |
| T011 | `research/session-guide.md` | Moderator guide và 10 task đã có | Có thể sửa sau pilot, nhưng không cần cho phần viết ban đầu | Không có | `ĐÃ XONG` |
| T012 | `research/sessions/SESSION-ID.md` | Chỉ có mẫu ghi buổi | Không thể điền kết quả giả; chỉ có thể quản lý lịch tuyển/session ID | 20 người thật, consent và quan sát | `BỊ CHẶN BỞI NGƯỜI THẬT` |
| T013 | `research/sessions/accessibility-summary.md` | Chưa có tệp kết quả; đã có requirements review desk | Có thể dùng `research/desk-research/accessibility-design-review.md` để chuẩn bị, không ghi session giả | Người dùng VoiceOver, nhóm 55+, prototype semantic và thiết bị | `BỊ CHẶN BỞI NGƯỜI THẬT/DEVICE` |
| T014 | `research/sessions/diaspora-timezone-summary.md` | Chưa có tệp kết quả; đã có scenario matrix desk | Có thể dùng `research/desk-research/diaspora-timezone-scenarios.md` để chuẩn bị, không ghi session giả | Ít nhất hai người Việt ở nước ngoài | `BỊ CHẶN BỞI NGƯỜI THẬT` |
| T015 | `research/scorecards/discovery-scorecard.md` | Template có mẫu số 0 và `NOT RUN` | Cấu trúc scorecard đã làm hết mức có thể | Dữ liệu hợp lệ từ T012–T014 | `BẢN NHÁP · BỊ CHẶN BỞI NGƯỜI THẬT` |
| T016 | `research/decisions/001-research-gates.md` | Gate 1–4 và 5A–7B được tách; tất cả `UNTESTED` | Có thể duy trì guardrail tạm; không được ghi pass/fail | Prototype, session, thiết bị và reviewer của từng Gate | `BẢN NHÁP · BỊ CHẶN BỞI T012–T015` |
| T017 | `research/decisions/002-calendar-sources.md` | Candidate sources, giới hạn, corpus tối thiểu và quy trình đối chiếu đã được draft | Desk review hiện đã đi tới `HOLD`; có thể chuẩn bị mẫu license memo/corpus schema | Calendar Data Owner, Golden Corpus Owner, chuyên gia lịch pháp, kết luận giấy phép, oracle thứ hai và corpus thật | `BẢN NHÁP · BỊ CHẶN BỞI EXPERT/OWNER/DATA` |
| T018 | `research/decisions/003-almanac-ruleset.md` | Draft đề xuất loại tốt/xấu khỏi 1.0 khi chưa đủ nguồn | Owner có thể chốt phương án “không ship” bằng văn bản; nếu muốn ship cần đặc tả ruleset riêng | Product owner; nếu ship còn cần ruleset owner, chuyên gia, license và corpus | `SOẠN ĐƯỢC NGAY ĐỂ OWNER QUYẾT · CHƯA HOÀN TẤT` |
| T019 | `research/decisions/004-release-ownership.md` | Support matrix tạm và bảng trách nhiệm đã có, mọi owner còn trống | Có thể điền proposal về role và chu kỳ bảo trì | Người trả phí, người giữ tài khoản, owner dữ liệu/văn hóa/privacy, inventory thiết bị thật và cam kết bảo trì | `BẢN NHÁP · BỊ CHẶN BỞI OWNER/DEVICE` |
| T020 | `research/decisions/005-ready-to-code.md` | Báo cáo hiện ghi `NOT READY` và liệt kê blocker | Tài liệu đã phản ánh đúng trạng thái; chỉ cập nhật lại sau quyết định thật | T004, T010 và T016–T019 phải đóng; chủ dự án ký | `BỊ CHẶN · KHÔNG ĐƯỢC KÝ` |

### Trạng thái tối đa trung thực của Phase 1 lúc này

- T001–T003, T005–T009 và T011 đã hoàn tất theo backlog.
- T004 và T010 có protocol nhưng thiếu vật chứng/asset và kiểm tra thật.
- T012–T014 chưa chạy; vì vậy T015–T016 chỉ được giữ ở dạng template/`UNTESTED`.
- T017–T019 đã có draft giúp owner quyết định, nhưng chưa có người chịu trách nhiệm và bằng chứng để đóng.
- T020 phải giữ `NOT READY`. Persona mô phỏng, desk research hoặc một cuộc tranh luận giữa agent không thay được điều kiện này.

## 3. Tài liệu có thể tiếp tục làm ngay

Các mục sau hữu ích trong một sprint chỉ viết tài liệu. Nếu task còn phụ thuộc phase, owner hoặc implementation, tạo bản nháp không đồng nghĩa được đánh dấu xong.

| Ưu tiên | Task | Artifact | Mức có thể làm ngay | Điểm dừng bắt buộc |
|---:|---|---|---|---|
| 1 | ngoài backlog | `research/synthetic-panel/deliberation.md` | Đã ghi câu hỏi, phản biện, mâu thuẫn và quyết định tạm từ các proto-persona | Không ghi quote, tỷ lệ hoặc pass Gate |
| 2 | T018 | `research/decisions/003-almanac-ruleset.md` | Chủ dự án có thể phê duyệt phương án loại lớp tốt/xấu khỏi 1.0 | Nếu vẫn muốn ship, phải dừng chờ expert/license/owner |
| 3 | T122 | `assets/storyboards/release-1-holiday-scenes.md` | Đã có draft storyboard, tone, content safe zone, Reduce Motion và Dim Flashing Lights cho bốn lễ còn lại | Chưa được gọi là “chốt” trước cultural/license review |
| 4 | T153 | `release/privacy-policy.md` | Đã có policy dự kiến: offline, không account/ads/analytics, support và correction flow | Bản phát hành phải đối chiếu binary, dependency và hoạt động dữ liệu thật |
| 5 | T155 | `release/app-store-metadata.md` | Đã có subtitle, description, keyword/claim guardrail và screenshot script | Tên phát hành, screenshot thật và claim cuối cần owner duyệt |
| 6 | T156 | `release/testflight-plan.md` | Đã có checklist build, nhóm tester, notes, rollback và xử lý P0/P1 | Build ID, signing, thiết bị và owner chỉ điền khi có build |
| 7 | T159 | `release/app-review-checklist.md` | Đã có checklist minimum functionality/permission timing | Chỉ audit được khi flow và permission prompt đã chạy |
| 8 | T146 | `LichNha/Tests/Reports/vietnamese-language-audit.md` | Soạn checklist từ ngữ, dấu, overflow và phát âm | Không ghi kết quả trước UI, chuỗi localized và VoiceOver thật |
| 9 | T148 | `assets/release/license-audit.md` | Đã có ledger cho font, texture, model, poster, audio, nguồn và quyền | Không thể approve khi asset/license chưa tồn tại |
| 10 | T154 | `release/app-store-privacy.md` | Đã có worksheet câu hỏi và mapping dự kiến theo kiến trúc | Câu trả lời cuối phải đọc binary/dependency/SDK thực tế |
| 11 | T160 | `release/constitution-compliance.md` | Đã có traceability matrix từ constitution tới yêu cầu/test dự kiến | Không thể “xác nhận không có” SDK/account/paywall/runtime AI trước khi audit code và binary |
| 12 | T161 | `specs/001-lich-nha-v1/analysis.md` | Đã có audit **pre-implementation**; finding follow-up đã ghi | T161 ở Phase 9 còn phải chạy lại sau mọi thay đổi và artifact release |

Ba README ở T044, T049 và T126 cũng có thể được viết trước như design note cho công cụ. Tuy nhiên, mô tả task dùng các động từ “tạo” hoặc “implement”; README không thay cho builder/validator chạy được, test và output của chúng.

## 4. Những tệp `.md` không thể dùng để hoàn tất sớm implementation

| Task | Report/manifest đích | Bằng chứng phải tồn tại trước khi viết kết luận |
|---|---|---|
| T044 | `tools/golden-calendar-builder/README.md` | Builder chạy được, input/output, provenance và ví dụ đã kiểm tra |
| T047 | `calendar-oracle-report.md` | Hai đường oracle độc lập, golden corpus và reconciliation của mọi sai khác |
| T049 | `tools/pack-validator/README.md` | Validator content/source/checksum/license chạy được và test sample lỗi |
| T066 | `us1-today-checkpoint.md` | App US1, Scenario A, snapshot và performance output |
| T080 | `us2-trust-checkpoint.md` | App US2, Scenario B và dữ liệu Gate 3 |
| T095 | `us3-reminder-checkpoint.md` | Reminder implementation, Scenario C, timezone/DST/device output và Gate 4 |
| T105 | `us4-widget-checkpoint.md` | Widget chạy trên simulator lẫn thiết bị thật trong airplane mode |
| T118 | `reference-manifest.md` | Concept sheet thật có quyền dùng; manifest chỉ ghi provenance, không thay cho ảnh |
| T119 | `generation-manifest.md` | Lượt Rodin **Image-to-3D** dùng ảnh T118 và output gốc; text-to-3D vẫn bị cấm |
| T120 | `asset-manifest.md` | Mesh đã cleanup, UV/material/LOD/poster, checksum và review |
| T126 | `tools/asset-manifest-validator/README.md` | Validator chạy được, fixture và test checksum/license |
| T130 | `us5-effects-audio-checkpoint.md` | Flagship scenes, 15 phút audio, fallback, profile máy thật và Gate 6–7 |
| T144 | `accessibility-release-scorecard.md` | Usability 55+/VoiceOver với session hợp lệ và issue cụ thể |
| T145 | `us6-accessibility-checkpoint.md` | Scenario F, support matrix, semantic app và Gate 5 |
| T146 | `vietnamese-language-audit.md` | Chuỗi UI thật, layout các cỡ chữ và pronunciation trên VoiceOver |
| T147 | `release-approval.md` | Content packs thật và hai reviewer con người độc lập |
| T148 | `license-audit.md` | Asset/font/model/audio thật cùng bằng chứng quyền và provenance |
| T150 | `release-performance.md` | Binary và effect pack trên đủ support matrix |
| T151 | `offline-time-regression.md` | App cài được; các lượt airplane/timezone/time-change/upgrade đã chạy |
| T152 | `quickstart-validation.md` | Output nguyên bản của toàn bộ lệnh quickstart trên code hiện hành |
| T157 | `testflight-scorecard.md` | Build TestFlight và 20–30 người tham gia thật |
| T160 | `constitution-compliance.md` | Audit source, dependency, binary, runtime và dữ liệu phát hành |
| T161 | `analysis.md` | Lần analyze cuối trên spec/plan/tasks đã phản ánh implementation và release |
| T162 | `convergence.md` | Toàn bộ bằng chứng release; report thật sự trả về `Converged` |

Mỗi report có thể có template trước, nhưng trạng thái phải là `NOT RUN`, không có số đo giả và không có chữ `PASS` nếu chưa chạy.

## 5. Blocker theo loại bằng chứng

### Người thật

- T012–T016: nghiên cứu khám phá, accessibility, diaspora, scorecard và Gate.
- T144–T145: usability/accessibility sau khi có app semantic.
- T157: TestFlight 20–30 người.

Desk research và proto-persona chỉ giúp chọn task/case cần thử. Chúng không thay mẫu nghiên cứu.

### Chuyên gia và reviewer

- T017: chuyên gia lịch pháp cùng owner của oracle/golden corpus.
- T018: ruleset owner và chuyên gia nếu lớp tốt/xấu vẫn ở 1.0.
- T116, T122, T147–T148: reviewer văn hóa, Quốc kỳ, nội dung và giấy phép.

### Thiết bị, app hoặc asset thật

- T010: audio mẫu và hành vi native trên iPhone.
- T066, T080, T095, T105, T130, T145–T152: test output, snapshot, performance, offline, timezone, VoiceOver và binary.
- T118–T120: ảnh tham chiếu có quyền, lượt Image-to-3D và asset đã cleanup.

### Chủ dự án và quyền chịu trách nhiệm

- Chốt có loại lớp tốt/xấu khỏi 1.0 hay không.
- Chỉ định người trả phí Apple Developer, giữ App Store Connect/certificate và bảo trì.
- Chỉ định owner cho Calendar Core, golden corpus, văn hóa, privacy và correction flow.
- Chốt tên phát hành, support matrix và thiết bị có thể mượn/mua để kiểm thử.

## 6. Kết luận cho sprint chỉ làm tài liệu

Kho tài liệu đã đủ để gọi là **document-ready**: tầm nhìn, UX, dữ liệu, kiến trúc, contracts, backlog, protocol, evidence register và các quyết định tạm đều đã có. Phần còn lại chia thành hai nhóm rõ ràng:

1. Có thể soạn ngay các plan, checklist, template và policy draft ở mục 3.
2. Phải giữ `NOT RUN`, `UNTESTED`, `HOLD` hoặc `BLOCKED` cho mọi artifact cần người thật, chuyên gia, owner, asset, app hoặc thiết bị.

Ngay cả khi hoàn thành toàn bộ bản nháp ở mục 3, trạng thái đúng vẫn là **build-not-ready** cho đến khi T020 được ký bằng bằng chứng thật. Các report implementation ở Phase 2–9 không được tạo sẵn để làm backlog trông hoàn chỉnh.
