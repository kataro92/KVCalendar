# Audit tính nhất quán trước triển khai — Lịch Nhà 1.0

**Ngày rà soát**: 2026-09-07
**Trạng thái**: `PRE-IMPLEMENTATION AUDIT` — `T161 NOT RUN`
**Kết luận ngắn**: Hồ sơ đủ để tiếp tục chuẩn bị nghiên cứu, nhưng `T020 NOT READY`; không được bắt
đầu T021 hoặc task triển khai về sau.

## 1. Phạm vi và giới hạn

Đây là lượt đọc chéo `spec.md`, `plan.md`, `tasks.md`, data model, quickstart, checklist, các
contract và hồ sơ desk research hiện có. Mục đích là tìm chỗ chưa nhất quán trước khi tốn chi phí
cho prototype và implementation.

Tài liệu này không phải lần chạy `$speckit-analyze` cuối ở T161. Nó cũng không thay T012–T020,
không có kết quả người dùng, thiết bị, TestFlight, binary hay corpus lịch. T161 phải được chạy lại
sau khi implementation và các báo cáo release tồn tại; không đánh dấu T161 từ tài liệu này.

Quy ước mức độ:

- `CRITICAL`: trái nguyên tắc hoặc có thể mở khóa triển khai sai.
- `HIGH`: có thể làm hai phần của sản phẩm thực hiện theo hai cách khác nhau.
- `MEDIUM`: chưa chặn toàn bộ dự án nhưng cần chốt trước task liên quan.
- `LOW`: làm rõ để giảm hiểu nhầm hoặc chi phí kiểm thử.

## 2. Ảnh chụp trạng thái

| Hạng mục | Trạng thái tại thời điểm rà soát | Ý nghĩa |
|---|---|---|
| Gate 1–4 và 5A–7B | `UNTESTED` | Chưa có participant/prototype/device evidence |
| T012–T016 | `NOT RUN` | Chưa có nghiên cứu trực tiếp và synthesis |
| T017–T019 | `NOT COMPLETE` | Nguồn lịch, ruleset truyền thống và release ownership chưa chốt |
| T020 | `NOT READY` | Definition of Ready chưa ký |
| T021–T160 | `NOT STARTED` | Bị checkpoint T020 chặn |
| T161 | `NOT RUN` | Audit cuối phải chạy lại sau implementation |
| T162 | `NOT RUN` | Chưa có cơ sở kết luận Converged |

Các checkbox T163–T166 chỉ xác nhận artifact desk research đã được soạn. Chúng không đổi trạng thái
bất kỳ research/release gate nào.

## 3. Phát hiện cần xử lý

| ID | Mức | Vị trí | Phát hiện | Cách xử lý đề nghị |
|---|---|---|---|---|
| A-01 | `CRITICAL` | `plan.md` — Constitution Check | Bảng ghi “Kiểm chứng trước mở rộng” là `PASS` và post-design là `PASS có điều kiện`, trong khi Gate 1–7 đều `UNTESTED`, T012–T020 còn mở. Cách ghi này có thể bị hiểu là đã qua gate. | Đổi về `NOT READY/BLOCKED` cho tới T020. Nếu bảng chỉ kiểm kiến trúc tài liệu, đổi tên cột và nói rõ nó không phải research gate. |
| A-02 | `HIGH` | `accessibility-contract.md`, SC-007, T131–T145 | Release gate trong contract chỉ nêu US1–US3. SC-007 yêu cầu mọi tác vụ cốt lõi; T131 lại bao phủ US1–US4, còn Scenario F có tạo event và tắt âm. Phạm vi gate không trùng nhau. | Định nghĩa một danh sách “core tasks” duy nhất rồi tham chiếu từ contract, Scenario F, T131, T144 và T145. Widget/deep link, settings và event editor phải được quyết định rõ có thuộc Gate 5 hay không. |
| A-03 | `HIGH` | T013/T020 và T144/T145 | Gate 5 xuất hiện vừa như bằng chứng trước code, vừa như gate release. Gate 6–7 cũng có vòng prototype và vòng chạy trên build. Hiện chưa có tên riêng cho hai mức bằng chứng, nên một scorecard sớm có thể bị tái dùng nhầm. | Tách `research validation` khỏi `release verification`. Mỗi mức có artifact, sample/device và quyền ký riêng; cả hai hiện đều `NOT RUN`. |
| A-04 | `HIGH` | FR-021, Assumptions, T122–T124 | FR-021 bắt buộc bốn cảnh lễ và sáu họ chuyển động trong 1.0, nhưng Assumptions chỉ cho sản xuất sau khi flagship vượt gate. Nếu flagship không vượt, đặc tả không nói 1.0 bị hoãn, cắt scope hay dùng poster. | Thêm nhánh quyết định sau Gate 6: sản xuất tiếp, chỉ ship flagship/poster, hoặc dời scene mở rộng. Không bắt đầu T122–T124 trước quyết định đó. |
| A-05 | `HIGH` | FR-011, T018, content contract | Lớp tốt/xấu là requirement bắt buộc, trong khi T018 vẫn phải chọn hoặc loại ruleset và owner. Nếu T018 chọn loại, FR-011 cùng User Story 2 phải đổi; nếu giữ, thiếu owner/source vẫn chặn. | Ghi FR-011 là phạm vi có điều kiện cho tới T018, hoặc chọn ruleset có owner trước T020. Không ship nội dung tổng hợp từ nhiều nguồn mâu thuẫn. |
| A-06 | `MEDIUM` | User Story 4 | Lý do ưu tiên widget khẳng định tình huống “xem nhanh buổi sáng”. Desk research hiện không có bằng chứng buổi sáng là bối cảnh chính. | Viết trung tính là “xem nhanh mà không mở app”; giữ thời điểm sử dụng làm câu hỏi T012/T014. |
| A-07 | `MEDIUM` | FR-002, Large Text contract, Gate 3 | Can Chi ngắn bị khóa cứng ở mặt trước và vẫn được giữ ở 200%, trong khi câu hỏi “trường nào phải thấy” chưa được Gate 3 kiểm chứng. | Coi thứ tự hiện tại là hypothesis của prototype. Sau Gate 3, cho phép chuyển Can Chi xuống mặt sau nếu độ đọc hoặc reflow cần ưu tiên. |
| A-08 | `MEDIUM` | `CalendarDay`, `UI state`, reminder contract | Mô hình đã tách rule zone, display zone và delivery zone, nhưng `selectedDate` chưa được định kiểu rõ là civil date hay instant. DST gap/overlap cũng chưa có disambiguation policy. | Khóa `selectedDate` thành date-only; định nghĩa cách tạo “today” từ display zone. Bổ sung policy cho giờ local không tồn tại/trùng trước T081/T091. |
| A-09 | `MEDIUM` | `plan.md`, SC-009, T150 | Các số 40–60 MB, triangle budget và frame target đang giống cam kết đã chốt dù chưa có support matrix hoặc profile máy thật. | Gắn nhãn `provisional budget`; T019 chọn thiết bị, T150 mới xác nhận hoặc sửa. Không dùng các số này làm kết quả hiệu năng. |
| A-10 | `MEDIUM` | SC-010, FR-028, audio docs | SC-010 mô tả điều kiện để Hiên sớm có thể thành mặc định có điều kiện. FR-028 và luật dự án hiện chọn Yên cho bản cài mới tới khi có dữ liệu. Không mâu thuẫn trực tiếp, nhưng dễ bị đọc thành kế hoạch chắc chắn đổi default. | Giữ Yên là release default. Sau Gate 7 chỉ “cân nhắc”, không tự động đổi; cần decision record riêng. Gate 7 hiện `UNTESTED`. |
| A-11 | `LOW` | checklist `requirements.md` | Checklist ghi toàn bộ requirement “có thể kiểm tra và không mơ hồ”, nhưng A-02, A-04, A-05 và A-08 vẫn để lại ranh giới chưa chốt. | Khi xử lý các finding trên, chạy lại checklist; không dùng checklist vòng đầu làm Definition of Ready. |

## 4. Bao phủ requirement ở mức kế hoạch

Đặc tả hiện có 36 functional requirement và 12 success criteria. Bảng dưới chỉ kiểm xem đã có nơi
dự kiến thực hiện/kiểm tra; nó không nói implementation đã tồn tại hay tiêu chí đã đạt.

| Nhóm requirement | Task/artifact dự kiến | Trạng thái bằng chứng |
|---|---|---|
| FR-001–006: hôm nay, mặt trước/sau, bóc và tháng | T052–T066, T070–T072, Scenario A | `NOT RUN` |
| FR-007–011: Calendar Core, taxonomy, nguồn, almanac | T030–T049, T067–T080, T017–T018 | `NOT RUN`; owner/ruleset còn mở |
| FR-012–016: event âm/dương và reminder | T081–T095, Scenario C | `NOT RUN` |
| FR-017–018: widget, privacy và offline | T096–T105, T151, Scenario D | `NOT RUN` |
| FR-019–029: effect, asset, Rodin và audio | T106–T130, T150, Scenario E | `NOT RUN`; mở rộng scene phụ thuộc Gate 6 |
| FR-030–032: semantics và chế độ hệ thống | T131–T145, Scenario F | `NOT RUN` |
| FR-033–036: local-only, không quảng cáo, version, regression | T143, T147–T160 | `NOT RUN` |
| SC-001–005, SC-008, SC-010 | T012–T016, T144 và các scorecard về sau | `UNTESTED` |
| SC-006, SC-009, SC-011, SC-012 | Corpus, test, profile, airplane-mode, TestFlight và release audit | `NOT RUN` |

Không thấy functional requirement nào hoàn toàn không có task dự kiến. Điểm yếu hiện tại là phạm vi
và thứ tự bằng chứng, không phải thiếu tên task.

## 5. Thứ tự đóng finding

1. Sửa cách ghi Constitution Check để không tạo tín hiệu mở khóa sai.
2. Chốt nghĩa của “core tasks” và tách Gate 5–7 ở vòng nghiên cứu khỏi verification lúc release.
3. Giải quyết T017–T019, đặc biệt ruleset tốt/xấu và support matrix.
4. Dùng T012–T016 để sửa FR-002, bối cảnh widget và nhánh phạm vi effect.
5. Chốt semantics date-only, DST gap/overlap trước khi thiết kế Reminder Core.
6. Chỉ ký T020 sau khi các thay đổi trên được phản ánh vào spec/plan/tasks.
7. Chạy lại audit đầy đủ ở T161; báo cáo này không được dùng để bỏ qua bước đó.

## 6. Quyết định tại thời điểm audit

`NO-GO FOR IMPLEMENTATION`.

Quyết định này không đánh giá ý tưởng tốt hay xấu. Nó chỉ phản ánh rằng những bằng chứng có quyền
mở khóa implementation chưa tồn tại: Gate 1–4 và 5A–7B `UNTESTED`, T012–T016 `NOT RUN`, T017–T019 chưa
hoàn tất và T020 `NOT READY`.

## 7. Follow-up sau audit

Các sửa đổi tài liệu cùng ngày đã xử lý đường mâu thuẫn, không thay đổi kết luận `NO-GO`:

| Finding | Sửa trong tài liệu | Trạng thái |
|---|---|---|
| A-01 | Đổi Constitution Check thành design check; bỏ toàn bộ `PASS` sớm và ghi `NOT READY` | `RESOLVED IN DOCS` |
| A-02 | Accessibility contract định nghĩa một danh sách core tasks; T131/T144/T145 tham chiếu cùng phạm vi | `RESOLVED IN DOCS` |
| A-03 | Tách Gate 5A–7A trước code khỏi Gate 5B–7B trên build | `RESOLVED IN DOCS` |
| A-04 | FR-021 và T122–T124 có nhánh ship mở rộng, poster fallback hoặc defer sau Gate 6A/T019 | `RESOLVED IN DOCS` |
| A-05 | FR-011 cùng US2 trở thành conditional scope của T018 | `RESOLVED IN DOCS` |
| A-06 | Lý do widget bỏ giả định “buổi sáng” | `RESOLVED IN DOCS` |
| A-07 | FR-002 và Large Text contract cho phép chuyển Can Chi xuống mặt sau sau Gate 3 | `RESOLVED IN DOCS` |
| A-08 | Thêm `CivilDate`, ba time zone và policy deterministic cho DST gap/overlap | `RESOLVED IN DOCS · POLICY PROVISIONAL` |
| A-09 | Performance/asset/triangle numbers được gắn nhãn ngân sách prototype | `RESOLVED IN DOCS` |
| A-10 | SC-010 yêu cầu decision record; đạt ngưỡng không tự đổi default Yên | `RESOLVED IN DOCS` |
| A-11 | Checklist được ghi rõ là quality review, không phải Definition of Ready | `RESOLVED IN DOCS` |

`RESOLVED IN DOCS` chỉ nói đặc tả không còn tự mâu thuẫn ở điểm đó. Implementation, validation và
owner tương ứng vẫn `NOT RUN` hoặc `BLOCKED`.
