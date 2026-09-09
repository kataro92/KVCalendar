# Specification Analysis Report (T161)

**Ngày:** 09/09/2026
**Trạng thái:** `POST-IMPLEMENTATION`
**Lệnh:** đọc chéo spec / plan / tasks / constitution / quickstart / reports US1–US6 và Phase 9. `.specify/extensions.yml` không có.

## Findings

| ID | Category | Severity | Location(s) | Summary | Recommendation |
|----|----------|----------|-------------|---------|----------------|
| C1 | Coverage | HIGH | T147, official-vn.json, official-schedule-2026.json | Pack luật 1.1.0 đã có ngày danh xưng Điều 112 và Tết mùng 1; lịch 2026 tách pack | Reviewer 2 chưa ký; NQ 28 còn dẫn cổng Chính phủ |
| C2 | Evidence | HIGH | T012–T016, T144, T157, Gate 1–7 | Code đã có; cổng người và TestFlight vẫn UNTESTED | Không ghi Converged; không submit store |
| C3 | Evidence | HIGH | T119/T120, T148 | Rodin chưa chạy; không mesh/audio trong bundle | Giữ poster 2D; đừng mô tả 3D/âm nền như đã ship |
| C4 | Inconsistency | MEDIUM | quickstart.md (đã sửa 09/09) | Scheme `LichNhaCoreTests` / iPhone 15 không tồn tại | Dùng CalendarCore, LichNha UITests, iPhone 17 |
| C5 | Inconsistency | MEDIUM | plan.md Constitution Check (đã sửa 09/09) | Cột bằng chứng còn nói “binary chưa tồn tại” | Cập nhật CODE REVIEWED / PARTIAL / UNTESTED |
| C6 | Coverage | MEDIUM | T151, SC-011 | Airplane/time/upgrade máy thật chưa chạy | Giữ SC-011 UNTESTED |
| C7 | Ambiguity | LOW | almanac-seed approvals | JSON ghi hai approval giả | Thay bằng tên người khi T147 xong |

Finding A-01–A-11 (07/09) đã `RESOLVED IN DOCS`; bằng chứng người vẫn thiếu.

## Coverage

| Requirement Key | Has Task? | Task IDs | Notes |
|-----------------|-----------|----------|-------|
| FR-001–006 Today/month | yes | T052–T080 | Simulator pass; SC-002/003 UNTESTED |
| FR-007–011 nguồn/almanac | yes | T067–T080, T018 | Almanac draft; Gate 3 UNTESTED |
| FR-012–016 event/reminder | yes | T081–T095 | Simulator pass; SC-005 UNTESTED |
| FR-017–018 widget | yes | T096–T105 | Snapshot pass; widget trên Home UNTESTED |
| FR-019–029 effect/audio | yes | T106–T130 | T119/T120 mở; Yên default |
| FR-030–032 a11y | yes | T131–T145 | T144 mở |
| FR-033–036 privacy/release | yes | T146–T160 | Source reviewed; store chưa |
| SC-006 golden | yes | T030–T049 | Module tests pass; T017 oracle người thiếu |
| SC-009 performance | yes | T150 | Simulator only |
| SC-011 airplane | yes | T151 | Device NOT RUN |
| SC-012 TestFlight | yes | T157–T160 | 0 tester |

**Constitution Alignment Issues:** Không thấy requirement mới trái nguyên tắc I–V. Việc ship khi Gate UNTESTED được T020 waiver; hiến pháp V vẫn yêu cầu cổng trước khi gọi “sẵn sàng phát hành”.

**Unmapped Tasks:** Không.

**Metrics:** 36 FR, 12 SC, ~162 tasks. Coverage FR ≥1 task: 100%. Ambiguity count: 1 (C7). Duplication: 0. Critical constitution conflicts: 0. High evidence gaps: 3.

## Next actions

Không chạy `$speckit-converge` như Converged. Ưu tiên: reviewer 2 (T147), T144, TestFlight vòng 0 sau signing, T119 nếu cần 3D.

Sửa đã làm trong lượt T161: `quickstart.md` lệnh thật; `plan.md` cột bằng chứng constitution.
