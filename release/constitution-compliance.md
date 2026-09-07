# Constitution compliance — pre-implementation

Ngày rà: **07/09/2026**
Trạng thái: **DESIGN REVIEW ONLY — T160 chưa chạy**

Bảng này kiểm traceability của tài liệu. Nó không chứng minh source code, dependency, binary hay hành vi runtime tuân thủ hiến pháp.

| Nguyên tắc | Bằng chứng thiết kế hiện có | Kiểm tra sau implementation | Trạng thái hiện tại |
|---|---|---|---|
| I. Miễn phí, không ads/paywall/account/sale data | README, spec FR-001/002, privacy draft | dependency/binary/network/App Store audit | `DESIGNED` |
| II. Đúng lịch, có phạm vi/nguồn/version | docs04, calendar contract, decision 002 | golden corpus, oracle report, pack validator | `BLOCKED T017` |
| III. Mộc Son Dịu + accessibility | Design Master, accessibility contract, Gate 5 plan | VoiceOver, chữ 200%, Reduce Motion, target 44 pt trên device | `UNTESTED` |
| IV. Offline và local-only | plan, data model, privacy draft | airplane mode, storage, network and privacy-label audit | `UNTESTED` |
| V. Kiểm chứng trước mở rộng | Gate 1–7, backlog checkpoint | session, prototype, device và TestFlight evidence | `BLOCKED T012–T020` |
| Rodin image-reference only | AGENTS, docs09, tasks T118–T120 | manifest và output audit | `DESIGNED` |
| Quốc kỳ dựng tay | docs08 và nguồn pháp lý | asset geometry/frame review | `NOT CREATED` |
| Asset provenance | manifest contract và license template | checksum/license audit trên asset thật | `NOT RUN` |

## Audit tài liệu hiện tại

- Spec/plan/tasks giữ T020 làm checkpoint trước T021.
- Persona tổng hợp không pass gate, không tạo tỷ lệ/quote.
- Bản cài mới chọn Yên cho tới khi Gate 7 có dữ liệu.
- Good/bad ở `HOLD`; không có ruleset mồ côi được phép ship.
- UTC+7 được tách khỏi ngày dân sự và notification timezone.
- Claim “đầu tiên/duy nhất” đã bị loại.

## Việc phải chạy lại ở T160

1. quét dependency, SDK, endpoint và network behavior của binary;
2. đối chiếu privacy manifest/App Store answers với dữ liệu thật;
3. chạy offline, calendar, reminder, widget và accessibility suite;
4. kiểm release pack không có runtime AI/key, Text-to-3D hoặc asset thiếu manifest;
5. đối chiếu mọi ngoại lệ với Complexity Tracking và owner/ngày xem lại;
6. chỉ ghi `PASS` sau khi link được output của từng bước.

Pre-implementation review này không thay `specs/001-lich-nha-v1/convergence.md` hoặc kết quả `$speckit-converge` cuối.
