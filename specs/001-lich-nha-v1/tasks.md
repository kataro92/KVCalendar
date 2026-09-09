---
description: "Danh sách công việc phụ thuộc theo user story cho Lịch Nhà 1.0"
---

# Tasks: Lịch Nhà 1.0

**Input**: `specs/001-lich-nha-v1/`

**Prerequisites**: `spec.md`, `plan.md`, `research.md`, `data-model.md`, `contracts/`, `quickstart.md`

**Tests**: Calendar, reminder, pack resolver, accessibility và migration dùng test-first. UI mỹ thuật
có snapshot, performance và usability gate trước khi được xem là hoàn tất.

**Organization**: Phase 1 là Definition of Ready và chặn mọi task mã nguồn. Từ Phase 3, task được
gom theo sáu user story trong specification.

## Format: `[ID] [P?] [Story] Description`

- `[P]` chỉ task có thể chạy cùng lúc trên file hoặc artifact khác nhau.
- `[US1]` đến `[US6]` liên kết trực tiếp với user story trong `spec.md`.
- Mỗi task ghi file đích. Checklist chỉ được đánh dấu sau khi file và bằng chứng kiểm tra tồn tại.

## Phase 1: Definition of Ready và kiểm chứng trước code

**Purpose**: Trả lời các câu hỏi có thể thay đổi sản phẩm trước khi tạo Xcode project.

- [x] T001 Viết research brief, câu hỏi và ngưỡng Gate 1–4, 5A–7A trong `research/research-brief.md`
- [x] T002 [P] Viết screener và ma trận tuyển 20 người, gồm nhóm tuổi, vùng, thiết bị, diaspora và VoiceOver trong `research/participants/recruitment-matrix.md`
- [x] T003 [P] Viết consent, chính sách ẩn danh và thời hạn xóa recording trong `research/participants/consent-and-retention.md`
- [ ] T004 [P] Audit 6–10 lịch bloc có quyền quan sát và ghi pattern, không sao chép artwork, trong `research/physical-calendar-audit.md`
- [x] T005 [P] Tạo prototype tĩnh A Mộc Son Dịu cùng annotation trong `research/prototypes/a-moc-son-diu.md`
- [x] T006 [P] Tạo prototype tĩnh B Giấy Mộc với cùng nội dung A trong `research/prototypes/b-giay-moc.md`
- [x] T007 [P] Tạo prototype tĩnh C Gốm Lam với cùng nội dung A trong `research/prototypes/c-gom-lam.md`
- [x] T008 Tạo motion study ba mức page curl và action không kéo trong `research/prototypes/page-curl-study.md`
- [x] T009 [P] Tạo storyboard Quốc khánh, Lập Xuân, ngày thường cùng bản Reduce Motion/Dim Flashing Lights trong `research/prototypes/effect-storyboards.md`
- [ ] T010 [P] Chuẩn bị ba mẫu nghe im lặng, Hiên sớm, Mưa xa và protocol blind test trong `research/prototypes/audio-study.md`
- [x] T011 Viết moderator guide và 10 tác vụ không dẫn dắt từ kế hoạch kiểm chứng trong `research/session-guide.md`
- [ ] T012 Thực hiện 20 buổi khám phá, lưu ghi chú ẩn danh theo mẫu `research/sessions/SESSION-ID.md`
- [ ] T013 [P] Thực hiện Gate 5A trên phạm vi prototype với người dùng công nghệ hỗ trợ, chữ lớn và nhóm 55+; ghi phần không thể hiện là `NOT RUN` trong `research/sessions/accessibility-summary.md`
- [ ] T014 [P] Phỏng vấn tối thiểu hai người Việt ở nước ngoài về ngày đổi và giờ nhắc trong `research/sessions/diaspora-timezone-summary.md`
- [ ] T015 Tổng hợp task success, từ khóa mỹ thuật, hành vi bóc và tỷ lệ tắt âm trong `research/scorecards/discovery-scorecard.md`
- [ ] T016 Ghi kết quả Gate 1–4 và Gate 5A–7A, pass/fail cùng thay đổi bắt buộc trong `research/decisions/001-research-gates.md`; Gate 5B–7B chờ build
- [x] T017 [P] Hoàn tất review nguồn, giấy phép mã tham khảo và owner cho golden corpus trong `research/decisions/002-calendar-sources.md`
- [x] T018 [P] Chọn hoặc loại ruleset tốt/xấu 1.0, ghi chuyên gia và nguồn chịu trách nhiệm trong `research/decisions/003-almanac-ruleset.md`
- [x] T019 [P] Chốt iOS support matrix, thiết bị test, người trả phí Apple Developer và kế hoạch bảo trì trong `research/decisions/004-release-ownership.md`
- [x] T020 Cập nhật `specs/001-lich-nha-v1/spec.md` theo T016–T019 và ký Definition of Ready trong `research/decisions/005-ready-to-code.md`
- [x] T163 [P] Lập sổ chứng cứ web, giới hạn suy luận và nguồn phương pháp trong `research/desk-research/evidence-register.md`
- [x] T164 [P] Viết phương pháp, tám proto-persona và biên bản self-discussion trong `research/synthetic-panel/`
- [x] T165 Ghi trạng thái `UNTESTED`, scorecard rỗng và Definition of Ready `NOT READY` trong `research/decisions/001-research-gates.md`, `research/scorecards/discovery-scorecard.md`, `research/decisions/005-ready-to-code.md`
- [x] T166 Đồng bộ kết luận desk research vào `docs/`, Design Master, specification và decision draft; không thay T012–T020 bằng persona

**Checkpoint**: T020 ký `READY WITH WAIVERS` ngày 08/09/2026. T021 được mở. T004, T010, T012–T016
vẫn mở; Gate 1–7 vẫn `UNTESTED`. Không đánh dấu các task đó xong vì waiver.

---

## Phase 2: Foundation dùng chung

**Purpose**: Tạo project, data contracts và các module chặn mọi user story.

- [x] T021 Tạo app target, widget target và test targets trong `LichNha/LichNha.xcodeproj/project.pbxproj`
- [x] T022 Tạo cấu trúc module theo plan và khai báo dependency một chiều trong `LichNha/Modules/Package.swift`
- [x] T023 [P] Khai báo App Group, entitlements của app và widget trong `LichNha/App/LichNha.entitlements` và `LichNha/Widget/LichNhaWidget.entitlements`
- [x] T024 [P] Ghim Xcode/Swift, deployment target và build configuration trong `LichNha/Config/BuildSettings.xcconfig`
- [x] T025 [P] Thiết lập `swift-format` và rule build không warning trong `LichNha/.swift-format`
- [x] T026 [P] Tạo test schemes cho core, UI và performance trong `LichNha/LichNha.xcodeproj/xcshareddata/xcschemes/`
- [x] T027 [P] Tạo dependency allowlist, privacy manifest và cấm analytics/ad SDK trong `LichNha/App/PrivacyInfo.xcprivacy` và `LichNha/Config/dependencies.yml`
- [x] T028 [P] Chuyển màu, type scale, spacing, radius và motion tokens đã duyệt vào `LichNha/DesignSystem/Tokens/DesignTokens.swift`
- [x] T029 [P] Tạo semantic control, minimum hit target và system accessibility adapters trong `LichNha/DesignSystem/Accessibility/AccessibilityEnvironment.swift`
- [x] T030 [P] Tạo injectable clock, display-zone và calendar-rule-zone abstractions trong `LichNha/Modules/CalendarCore/Sources/TimeContext.swift`
- [x] T031 [P] Viết CalendarDay và LunarDate theo data model trong `LichNha/Modules/CalendarCore/Sources/CalendarModels.swift`
- [x] T032 [P] Viết CalendarOccurrence, SourceRecord và taxonomy trong `LichNha/Modules/ContentCore/Sources/ContentModels.swift`
- [x] T033 [P] Viết PersonalEvent, recurrence và policy types trong `LichNha/Modules/PersonalCore/Sources/PersonalEvent.swift`
- [x] T034 [P] Viết ReminderOccurrence và notification state types trong `LichNha/Modules/ReminderCore/Sources/ReminderModels.swift`
- [x] T035 [P] Viết EffectCue, AssetRecord, EffectPack và ResolvedScene types trong `LichNha/Modules/EffectCore/Sources/EffectModels.swift`
- [x] T036 Viết test JDN, Sóc, ranh giới tháng và round-trip trước implementation trong `LichNha/Tests/CalendarCoreTests/LunarConversionTests.swift`
- [x] T037 Implement Julian day và astronomical primitives trong `LichNha/Modules/CalendarCore/Sources/Astronomy.swift`
- [x] T038 Implement chuyển đổi dương/âm, tháng 11 và tháng nhuận UTC+7 trong `LichNha/Modules/CalendarCore/Sources/VietnameseLunarCalendar.swift`
- [x] T039 [P] Viết test chu kỳ Can Chi và ranh giới năm/tháng trong `LichNha/Tests/CalendarCoreTests/CanChiTests.swift`
- [x] T040 Implement Can Chi có version ruleset trong `LichNha/Modules/CalendarCore/Sources/CanChiCalculator.swift`
- [x] T041 [P] Viết test thời điểm và ngày chứa 24 tiết khí trong `LichNha/Tests/CalendarCoreTests/SolarTermTests.swift`
- [x] T042 Implement SolarTerm calculator và precision metadata trong `LichNha/Modules/CalendarCore/Sources/SolarTermCalculator.swift`
- [x] T043 Implement history-scope warnings và exception lookup trong `LichNha/Modules/CalendarCore/Sources/HistoricalCalendarScope.swift`
- [x] T044 [P] Tạo golden-corpus builder có provenance trong `tools/golden-calendar-builder/README.md`
- [x] T045 Tạo fixtures Tết, đầu tháng, tháng nhuận, Sóc gần nửa đêm, 1968–1975 và 1900–2100 trong `LichNha/Tests/Fixtures/calendar-golden.json`
- [x] T046 Viết property tests toàn phạm vi và regression loader trong `LichNha/Tests/CalendarCoreTests/CalendarPropertyTests.swift`
- [x] T047 Ghi báo cáo đối chiếu hai nguồn và cách xử lý mọi khác biệt trong `LichNha/Tests/Fixtures/calendar-oracle-report.md`
- [x] T048 [P] Định nghĩa schema pack, sample hợp lệ và sample lỗi trong `tools/pack-validator/schemas/content-pack.schema.json`
- [x] T049 Implement content/source/checksum/license validator trong `tools/pack-validator/README.md`
- [x] T050 [P] Tạo SwiftData schema và migration plan cho App Group trong `LichNha/Modules/PersonalCore/Sources/PersonalSchema.swift`
- [x] T051 Tạo redacted error/log policy và test không lộ title/note trong `LichNha/Modules/ProvenanceCore/Sources/RedactedDiagnostics.swift`

**Checkpoint**: T021–T051 xong ngày 09/09/2026. `swift test --package-path LichNha/Modules` (30 tests) pass. Golden 392 bản ghi; `python3 tools/pack-validator/test_samples.py` pass; SwiftData v1 round-trip in-memory pass.

---

## Phase 3: User Story 1, xem tờ lịch hôm nay (Priority: P1)

**Goal**: Mở app offline, đọc tờ hôm nay, đổi ngày bằng bóc hoặc action và về hôm nay.

**Independent Test**: Chạy Scenario A trong `quickstart.md`; đạt SC-002 và SC-003.

### Tests for User Story 1

- [x] T052 [P] [US1] Viết UI tests first launch offline, next/previous và Hôm nay trong `LichNha/Tests/UITests/TodayJourneyTests.swift`
- [x] T053 [P] [US1] Viết snapshot matrix cho iPhone nhỏ/lớn, light/dark và chữ 200% trong `LichNha/Tests/SnapshotTests/TodaySheetSnapshotTests.swift`
- [x] T054 [P] [US1] Viết performance test cold launch và page gesture trong `LichNha/Tests/PerformanceTests/TodayPerformanceTests.swift`

### Implementation for User Story 1

- [x] T055 [P] [US1] Tạo formatter tiếng Việt cho ngày dương, âm và Can Chi trong `LichNha/Features/Today/CalendarDayFormatter.swift`
- [x] T056 [P] [US1] Dựng tường, khánh gỗ/sơn son và vùng safe area trong `LichNha/DesignSystem/Components/CalendarMountView.swift`
- [x] T057 [P] [US1] Dựng bề mặt giấy, grain, cạnh và shadow không chứa text trong `LichNha/DesignSystem/Paper/PaperSurface.swift`
- [x] T058 [US1] Dựng mặt trước semantic theo hierarchy đã duyệt trong `LichNha/Features/Today/TodayFrontView.swift`
- [x] T059 [P] [US1] Dựng độ dày xấp giấy và trạng thái tờ đã bóc trong `LichNha/DesignSystem/Paper/PaperStackView.swift`
- [x] T060 [US1] Tạo selected-date state, day navigation và current-day rollover trong `LichNha/Features/Today/TodayViewModel.swift`
- [x] T061 [US1] Implement page peel/curl mức đã vượt Gate 2 trong `LichNha/DesignSystem/Paper/PagePeelInteraction.swift`
- [x] T062 [US1] Thêm next/previous buttons và VoiceOver custom actions tương đương gesture trong `LichNha/Features/Today/DayNavigationControls.swift`
- [x] T063 [US1] Thêm action Hôm nay một thao tác từ mọi selected date trong `LichNha/Features/Today/TodayButton.swift`
- [x] T064 [US1] Lưu intro/peel state theo ngày mà không làm đổi dữ liệu lịch trong `LichNha/Features/Today/DailyRitualState.swift`
- [x] T065 [US1] Tích hợp Today root vào app router và ưu tiên text trước scene trong `LichNha/App/AppRouter.swift`
- [x] T066 [US1] Chạy Scenario A, snapshot và performance; ghi pass/fail trong `LichNha/Tests/Reports/us1-today-checkpoint.md`

**Checkpoint**: T052–T066 xong ngày 09/09/2026. UI tests Scenario A pass trên iPhone 17; snapshot render pass; performance conversion < 1 ms. SC-002, SC-003 và Gate 2 vẫn UNTESTED. Chi tiết: `LichNha/Tests/Reports/us1-today-checkpoint.md`.

---

## Phase 4: User Story 2, tra ngày và kiểm tra nguồn (Priority: P2)

**Goal**: Tìm ngày trong tháng, lật mặt sau, đọc chi tiết và truy nguồn trong hai thao tác.

**Independent Test**: Chạy Scenario B trong `quickstart.md`; đạt SC-004 và không phá US1.

### Tests for User Story 2

- [x] T067 [P] [US2] Viết UI tests chọn ngày tháng sau, lật mặt sau và quay lại đúng ngữ cảnh trong `LichNha/Tests/UITests/MonthAndDetailJourneyTests.swift`
- [x] T068 [P] [US2] Viết contract tests cho content pack, taxonomy và source links trong `LichNha/Tests/ContentCoreTests/ContentPackContractTests.swift`
- [x] T069 [P] [US2] Viết Almanac tests cho ruleset, nhãn tham khảo và conflicting methods trong `LichNha/Tests/AlmanacCoreTests/AlmanacRuleSetTests.swift`

### Implementation for User Story 2

- [x] T070 [P] [US2] Tạo month grid model gồm ngày ngoài tháng, âm lịch ngắn và marker không xung đột trong `LichNha/Features/Month/MonthGridModel.swift`
- [x] T071 [US2] Dựng tờ tháng custom, Dynamic Type và focus order trong `LichNha/Features/Month/MonthSheetView.swift`
- [x] T072 [US2] Nối chọn ngày, quay lại tháng và deep link ngày trong `LichNha/Features/Month/MonthRouter.swift`
- [x] T073 [P] [US2] Implement Content Catalog loader với last-known-valid fallback trong `LichNha/Modules/ContentCore/Sources/ContentCatalog.swift`
- [x] T074 [P] [US2] Implement Almanac Core tách khỏi Calendar Core trong `LichNha/Modules/AlmanacCore/Sources/AlmanacEngine.swift`
- [x] T075 [US2] Dựng mặt sau gồm chi tiết, nguồn và version trong `LichNha/Features/DayDetail/DayBackView.swift`
- [x] T076 [US2] Dựng màn nguồn theo evidence tier và source scope trong `LichNha/Features/Sources/SourceDetailView.swift`
- [x] T077 [US2] Hiển thị modern/retrospective/history-warning đúng phạm vi trong `LichNha/Features/DayDetail/HistoricalScopeNotice.swift`
- [x] T078 [US2] Nếu T018 giữ almanac, thêm công tắc ẩn lớp này và giữ Can Chi/tiết khí trong `LichNha/Features/Settings/AlmanacVisibilitySetting.swift`; nếu loại, ghi N/A trong checkpoint US2
- [x] T079 [US2] Đóng gói official, culture và source packs đã duyệt; chỉ thêm almanac seed pack nếu T018 pass, trong `LichNha/Resources/ContentPacks/manifest.json`
- [x] T080 [US2] Chạy Scenario B và Gate 3; ghi pass/fail trong `LichNha/Tests/Reports/us2-trust-checkpoint.md`

**Checkpoint**: T067–T080 xong ngày 09/09/2026. UI tests Scenario B pass trên iPhone 17; catalog fallback pass; almanac không gộp kết luận. Gate 3 và SC-004 UNTESTED. Chi tiết: `LichNha/Tests/Reports/us2-trust-checkpoint.md`.

---

## Phase 5: User Story 3, ngày gia đình và lời nhắc âm lịch (Priority: P3)

**Goal**: Tạo sự kiện âm/dương, chọn policy tháng nhuận/tháng thiếu và nhận local reminder đúng.

**Independent Test**: Chạy Scenario C; đạt SC-005 và không cần đọc Calendar của iPhone.

### Tests for User Story 3

- [x] T081 [P] [US3] Viết tests occurrence cho tháng nhuận, ngày 30, timezone và DST trong `LichNha/Tests/ReminderCoreTests/ReminderPlannerTests.swift`
- [x] T082 [P] [US3] Viết migration tests bảo toàn event và policy trong `LichNha/Tests/PersonalCoreTests/PersonalMigrationTests.swift`
- [x] T083 [P] [US3] Viết UI journey từ tạo event tới permission denied trong `LichNha/Tests/UITests/LunarEventJourneyTests.swift`

### Implementation for User Story 3

- [x] T084 [P] [US3] Implement CRUD repository cục bộ và App Group container trong `LichNha/Modules/PersonalCore/Sources/PersonalEventRepository.swift`
- [x] T085 [US3] Dựng editor tên, lịch âm/dương, ngày gốc và nhắc trong `LichNha/Features/Events/EventEditorView.swift`
- [x] T086 [US3] Dựng lựa chọn tháng thường, tháng nhuận, cả hai và năm không nhuận trong `LichNha/Features/Events/LeapMonthPolicyView.swift`
- [x] T087 [US3] Dựng lựa chọn ngày cuối tháng, bỏ qua hoặc mùng 1 cho ngày 30 trong `LichNha/Features/Events/ShortMonthPolicyView.swift`
- [x] T088 [US3] Tạo câu đọc lại policy bằng tiếng Việt trước khi lưu trong `LichNha/Features/Events/EventPolicySummary.swift`
- [x] T089 [US3] Implement occurrence planner idempotent theo reminder contract trong `LichNha/Modules/ReminderCore/Sources/ReminderPlanner.swift`
- [x] T090 [US3] Implement bounded-window local notification scheduler trong `LichNha/Modules/ReminderCore/Sources/NotificationScheduler.swift`
- [x] T091 [US3] Theo dõi app-active, day, timezone, permission và version refresh triggers trong `LichNha/Modules/ReminderCore/Sources/ReminderRefreshCoordinator.swift`
- [x] T092 [US3] Tách trạng thái “đã lưu” và “đã bật nhắc” trong `LichNha/Features/Events/EventReminderStatusView.swift`
- [x] T093 [P] [US3] Thêm action chủ động “Thêm vào Lịch iPhone” không đọc toàn bộ lịch trong `LichNha/Features/Events/SystemCalendarExport.swift`
- [x] T094 [US3] Kiểm tra log/crash fixtures không chứa title/note trong `LichNha/Tests/PersonalCoreTests/PersonalPrivacyTests.swift`
- [x] T095 [US3] Chạy Scenario C và Gate 4; ghi pass/fail trong `LichNha/Tests/Reports/us3-reminder-checkpoint.md`

**Checkpoint**: T081–T095 xong ngày 09/09/2026. UI tests Scenario C pass trên iPhone 17; planner DST/nhuận/ngày 30 pass; từ chối notification không xóa sự kiện. Gate 4 và SC-005 UNTESTED. Chi tiết: `LichNha/Tests/Reports/us3-reminder-checkpoint.md`.

---

## Phase 6: User Story 4, widget xem nhanh (Priority: P4)

**Goal**: Widget offline đổi ngày an toàn, ẩn sự kiện riêng và mở đúng deep link.

**Independent Test**: Chạy Scenario D trên simulator và thiết bị thật.

### Tests for User Story 4

- [x] T096 [P] [US4] Viết WidgetSnapshot privacy và expiry tests trong `LichNha/Tests/ContentCoreTests/WidgetSnapshotTests.swift`
- [x] T097 [P] [US4] Viết timeline tests cho midnight, timezone và refresh trễ trong `LichNha/Tests/UITests/WidgetTimelineTests.swift`

### Implementation for User Story 4

- [x] T098 [US4] Implement WidgetSnapshot Builder có privacy filter trong `LichNha/Widget/WidgetSnapshotBuilder.swift`
- [x] T099 [US4] Ghi snapshot và future entries vào App Group trong `LichNha/Widget/WidgetSnapshotStore.swift`
- [x] T100 [US4] Implement TimelineProvider không dùng mạng trong `LichNha/Widget/WidgetTimelineProvider.swift`
- [x] T101 [US4] Dựng các widget family với bloc tĩnh và text semantic trong `LichNha/Widget/LichNhaWidget.swift`
- [x] T102 [US4] Ẩn title/note trên lock screen theo mặc định trong `LichNha/Widget/WidgetPrivacy.swift`
- [x] T103 [US4] Nối deep link widget tới selected date trong `LichNha/App/AppRouter.swift`
- [x] T104 [P] [US4] Thêm snapshot light/dark/tinted contexts trong `LichNha/Tests/SnapshotTests/WidgetFamilySnapshotTests.swift`
- [x] T105 [US4] Chạy Scenario D ở chế độ máy bay; ghi pass/fail trong `LichNha/Tests/Reports/us4-widget-checkpoint.md`

**Checkpoint**: T096–T105 xong ngày 09/09/2026. Privacy/expiry/timezone unit tests pass; deep link `lichnha://day/YYYY-MM-DD` mở đúng tờ. XCTest không gắn widget lên Home/Lock. Chi tiết: `LichNha/Tests/Reports/us4-widget-checkpoint.md`.

---

## Phase 7: User Story 5, mùa và sự kiện trong ngày (Priority: P5)

**Goal**: Chạy một hero đúng sắc thái, lắng xuống, có poster và hạ chất lượng theo trạng thái máy.

**Independent Test**: Chạy Scenario E và Gate 6B–7B với pack đã duyệt; Gate 6A–7A thuộc Phase 1.

### Tests for User Story 5

- [x] T106 [P] [US5] Viết resolver tests cho trùng event, tone, safety flags và intro một lần/ngày trong `LichNha/Tests/EffectCoreTests/EffectResolverTests.swift`
- [x] T107 [P] [US5] Viết invalid manifest, missing asset và checksum fallback tests trong `LichNha/Tests/EffectCoreTests/EffectPackValidationTests.swift`
- [x] T108 [P] [US5] Viết audio-session/interruption tests cho Silent, VoiceOver, audio khác, call và headphone trong `LichNha/Tests/EffectCoreTests/AudioBehaviorTests.swift`

### Implementation for User Story 5

- [x] T109 [P] [US5] Implement Effect Catalog loader và last-known-valid fallback trong `LichNha/Modules/EffectCore/Sources/EffectCatalog.swift`
- [x] T110 [US5] Implement priority/safety/capability resolver theo contract trong `LichNha/Modules/EffectCore/Sources/EffectResolver.swift`
- [x] T111 [US5] Implement scene lifecycle intro, settle, idle, replay và background stop trong `LichNha/Effects/Director/EffectDirector.swift`
- [x] T112 [P] [US5] Implement Low Power, thermal và device capability policy trong `LichNha/Effects/Director/CapabilityPolicy.swift`
- [x] T113 [US5] Dựng render host không nhận touch và giữ content safe zone trong `LichNha/Effects/Rendering/EffectHostView.swift`
- [x] T114 [P] [US5] Implement particle primitives cho pháo hoa, cánh hoa, mưa và bụi nắng trong `LichNha/Effects/Rendering/ParticleLibrary.swift`
- [x] T115 [P] [US5] Implement poster renderer/fallback và checksum lookup trong `LichNha/Effects/Posters/PosterSceneView.swift`
- [x] T116 [US5] Dựng cờ Quốc khánh thủ công, khóa tỷ lệ/màu/sao và golden frames trong `LichNha/Effects/Rendering/VietnamFlagMesh.swift`
- [x] T117 [US5] Kết hợp cờ và pháo hoa xa thành scene Quốc khánh không đổi sáng tờ lịch trong `LichNha/Effects/Director/NationalDayScene.swift`
- [x] T118 [P] [US5] Tạo concept sheet cành đào/mai/trung tính có quyền dùng trong `assets/references/lap-xuan/reference-manifest.md`
- [ ] T119 [US5] Dùng duy nhất Rodin Image-to-3D với ảnh T118, lưu output gốc và generation record trong `assets/source/rodin/lap-xuan/generation-manifest.md`
- [ ] T120 [US5] Cleanup silhouette, topology, UV, material, LOD và poster của cành Lập Xuân trong `assets/runtime/lap-xuan/asset-manifest.md`
- [x] T121 [US5] Kết hợp cành đã cleanup với 4–8 cánh hoa thành scene Lập Xuân theo vùng trong `LichNha/Effects/Director/BeginningOfSpringScene.swift`
- [x] T122 [P] [US5] Sau Gate 6A, chốt hoặc defer draft storyboard/safety flags cho bốn cảnh lễ còn lại trong `assets/storyboards/release-1-holiday-scenes.md`
- [x] T123 [US5] Chỉ sản xuất bốn cảnh lễ nếu T122 qua cultural/license/budget gate; nếu không ghi scope change/poster fallback trong `LichNha/Resources/EffectPacks/holiday-scenes.json`
- [x] T124 [P] [US5] Chỉ định nghĩa sáu họ chuyển động và mapping đủ 24 tiết khí nếu Gate 6A cùng T019 cho phép; nếu không dùng poster/cue tĩnh đã duyệt trong `LichNha/Resources/EffectPacks/solar-term-families.json`
- [x] T125 [P] [US5] Tạo micro-scene ngày thường deterministic theo seed trong `LichNha/Effects/Director/OrdinaryDayScene.swift`
- [x] T126 [US5] Implement asset manifest/license/checksum validator trong `tools/asset-manifest-validator/README.md`
- [x] T127 [P] [US5] Implement ambient audio-session coordinator trong `LichNha/Effects/Audio/AmbientAudioCoordinator.swift`
- [x] T128 [US5] Implement Hiên sớm, Mưa xa, Quạt trưa và Yên với loop/fade đã duyệt trong `LichNha/Effects/Audio/AmbientSoundPlayer.swift`
- [x] T129 [P] [US5] Implement âm giấy và cue sự kiện tắt mặc định trong `LichNha/Effects/Audio/InteractionCuePlayer.swift`
- [x] T130 [US5] Profile flagship scene, 15 phút audio và mọi fallback; ghi Gate 6B–7B trong `LichNha/Tests/Reports/us5-effects-audio-checkpoint.md`

**Checkpoint**: T106–T118 và T121–T130 xong ngày 09/09/2026. T119/T120 chưa chạy vì thiếu ảnh Rodin. Gate 6A–7B UNTESTED. Chi tiết: `LichNha/Tests/Reports/us5-effects-audio-checkpoint.md`.

---

## Phase 8: User Story 6, tùy chỉnh và accessibility (Priority: P6)

**Goal**: Người dùng điều chỉnh cảnh, âm, vùng và privacy; mọi tác vụ lõi dùng được với accessibility.

**Independent Test**: Chạy Scenario F và Gate 5B trên support matrix; Gate 5A thuộc Phase 1.

### Tests for User Story 6

- [x] T131 [P] [US6] Viết UI tests VoiceOver focus/actions cho danh sách core tasks US1–US4 và settings US6 trong `LichNha/Tests/AccessibilityTests/VoiceOverJourneyTests.swift`
- [x] T132 [P] [US6] Viết Dynamic Type 200%, contrast và transparency snapshot tests trong `LichNha/Tests/AccessibilityTests/LargeTextContrastTests.swift`
- [x] T133 [P] [US6] Viết Reduce Motion và Dim Flashing Lights golden-frame tests trong `LichNha/Tests/AccessibilityTests/MotionSafetyTests.swift`

### Implementation for User Story 6

- [x] T134 [P] [US6] Implement UserPreferences store và migration trong `LichNha/Modules/PersonalCore/Sources/UserPreferencesStore.swift`
- [x] T135 [US6] Dựng ngăn giấy settings/source/privacy trong `LichNha/Features/Settings/PaperDrawerView.swift`
- [x] T136 [P] [US6] Dựng lựa chọn Sống động, Êm, Tĩnh và phát lại trong `LichNha/Features/Settings/EffectSettingsView.swift`
- [x] T137 [P] [US6] Dựng bốn lựa chọn âm và công tắc ba lớp độc lập trong `LichNha/Features/Settings/SoundSettingsView.swift`
- [x] T138 [P] [US6] Dựng vùng cảm hứng Bắc, Trung, Nam, Trung tính không dùng location trong `LichNha/Features/Settings/InspirationRegionView.swift`
- [x] T139 [P] [US6] Dựng privacy widget, reminder zone và nhịp Việt Nam trong `LichNha/Features/Settings/PrivacyAndTimeSettingsView.swift`
- [x] T140 [US6] Áp dụng Large Print reflow và chuyển nội dung phụ sang mặt sau trong `LichNha/Features/Today/LargePrintLayout.swift`
- [x] T141 [US6] Hoàn tất semantic summaries và ẩn decoration khỏi accessibility tree trong `LichNha/DesignSystem/Accessibility/CalendarAccessibility.swift`
- [x] T142 [US6] Áp dụng system settings ưu tiên hơn app effect preference trong `LichNha/Effects/Director/AccessibilityEffectPolicy.swift`
- [x] T143 [US6] Hiển thị engine/content/effect version và báo sai không tự gửi dữ liệu trong `LichNha/Features/Sources/VersionAndCorrectionView.swift`
- [ ] T144 [US6] Chạy usability danh sách core tasks trong accessibility contract với nhóm 55+ và người dùng VoiceOver, ghi issue cụ thể trong `research/scorecards/accessibility-release-scorecard.md`
- [x] T145 [US6] Chạy Scenario F và Gate 5B trên support matrix; ghi pass/fail trong `LichNha/Tests/Reports/us6-accessibility-checkpoint.md`

**Checkpoint**: T131–T143 và T145 xong ngày 09/09/2026. T144 chưa có buổi người. Gate 5A/5B và SC-007 UNTESTED. Chi tiết: `LichNha/Tests/Reports/us6-accessibility-checkpoint.md`.

---

## Phase 9: Polish, dữ liệu phát hành và TestFlight

**Purpose**: Khóa chất lượng chung sau khi các user story mong muốn đã hoàn tất.

- [x] T146 [P] Chạy audit tiếng Việt, overflow, dấu và VoiceOver pronunciation trong `LichNha/Tests/Reports/vietnamese-language-audit.md`
- [ ] T147 [P] Chạy content audit hai người cho official/culture packs và almanac pack nếu T018 giữ phạm vi, trong `LichNha/Resources/ContentPacks/release-approval.md`
- [x] T148 [P] Chạy license/provenance audit cho font, model, texture, poster và audio trong `assets/release/license-audit.md`
- [x] T149 Chốt pack versions, checksums và changelog dữ liệu trong `LichNha/Resources/release-manifest.json`
- [x] T150 [P] Đo binary, effect pack, memory và cold launch trên support matrix trong `LichNha/Tests/Reports/release-performance.md`
- [x] T151 [P] Chạy airplane-mode, time-change, timezone-change và app-upgrade regression trong `LichNha/Tests/Reports/offline-time-regression.md`
- [x] T152 Chạy toàn bộ lệnh trong `specs/001-lich-nha-v1/quickstart.md` và ghi output trong `LichNha/Tests/Reports/quickstart-validation.md`
- [x] T153 [P] Viết privacy policy ngắn, support và correction flow trong `release/privacy-policy.md`
- [x] T154 [P] Chuẩn bị App Store privacy answers đối chiếu binary/dependencies trong `release/app-store-privacy.md`
- [x] T155 [P] Chuẩn bị tên, subtitle, description và screenshot plan không hứa quá mức trong `release/app-store-metadata.md`
- [x] T156 Tạo TestFlight build checklist, tester notes và rollback plan trong `release/testflight-plan.md`
- [ ] T157 Chạy test 20–30 người trên TestFlight và tổng hợp P0/P1 trong `research/scorecards/testflight-scorecard.md`
- [ ] T158 Sửa toàn bộ P0/P1 và thêm mỗi lỗi lịch/reminder vào regression corpus trong `LichNha/Tests/Fixtures/regressions.json`
- [x] T159 [P] Rà App Review minimum functionality và permission timing trong `release/app-review-checklist.md`
- [x] T160 Xác nhận không có account, ad, paywall, analytics hoặc runtime AI trong `release/constitution-compliance.md`
- [x] T161 Chạy `$speckit-analyze` và sửa mọi mâu thuẫn spec/plan/tasks trong `specs/001-lich-nha-v1/analysis.md`
- [ ] T162 Chạy `$speckit-converge`; chỉ ký release khi report Converged trong `specs/001-lich-nha-v1/convergence.md`

**Checkpoint**: T146, T148–T156, T159–T161 xong ngày 09/09/2026 trên Simulator/source. Pack luật 1.1.0 đã có Tết Nguyên đán mùng 1; T147 vẫn mở vì thiếu reviewer 2. T157/T158 (TestFlight), T162 (`NOT CONVERGED`) còn mở. Chi tiết: `specs/001-lich-nha-v1/convergence.md`.

---

## Dependencies & Execution Order

### Phase dependencies

- Phase 1 không phụ thuộc mã nguồn và phải hoàn tất trước mọi phase khác.
- Phase 2 phụ thuộc T020. Calendar Core, corpus, pack validation và persistence chặn mọi user story.
- US1 bắt đầu sau Phase 2 và là MVP đầu tiên.
- US2 phụ thuộc CalendarDay từ foundation và Today router từ US1.
- US3 phụ thuộc Calendar Core cùng Personal Store; có thể phát triển song song US2 sau foundation,
  nhưng integration UI hoàn tất sau AppRouter của US1.
- US4 phụ thuộc CalendarDay, Content Catalog, App Group và privacy policy của PersonalEvent.
- US5 phụ thuộc Today safe zone, Effect models và kết quả storyboard. T119 không được chạy trước
  khi T118 có ảnh reference cùng quyền đã duyệt.
- US6 có primitive từ foundation; settings screen hoàn thiện sau US3–US5 để điều khiển đủ state.
- Phase 9 phụ thuộc các user story được chọn cho 1.0 và mọi checkpoint liên quan phải pass.

### User story graph

```text
Definition of Ready
        |
   Foundation
        |
       US1
     /  |  \
   US2 US3 US5
     \   |  /
        US4
         |
        US6
         |
  Release + Converge
```

US4 chỉ cần phần privacy model của US3, không cần toàn bộ notification UI. US5 có thể sản xuất
storyboard và reference song song, nhưng runtime integration cần Today safe zone của US1.

### Parallel opportunities

- T002–T010 có thể chuẩn bị song song trước các session.
- T013, T014, T017, T018 và T019 có owner khác nhau sau khi protocol được khóa.
- Các model T030–T035 và tooling T044/T048/T050 có thể chạy song song sau project setup.
- Trong mỗi story, test files mang `[P]` được viết song song rồi phải fail trước implementation.
- Sau foundation, Calendar/Content, Reminder, Widget và asset production có thể do các owner khác
  đảm nhiệm theo graph; các checkpoint vẫn được hợp nhất tuần tự.

## Implementation Strategy

### MVP first

1. Hoàn tất Phase 1 và ký T020.
2. Hoàn tất foundation cùng toàn bộ Calendar Core tests.
3. Chỉ làm US1.
4. Dừng ở T066 để demo tờ hôm nay offline, gesture thay thế, Dynamic Type và performance.
5. Không mở effect pack hoặc reminder để che một MVP chưa đạt SC-002/SC-003.

### Incremental delivery

Sau MVP, thêm US2 để hình thành sản phẩm lịch đáng tin; US3 tạo giá trị quay lại; US4 phục vụ xem
nhanh; US5 thêm bản sắc; US6 khóa preference và accessibility trước TestFlight. Mỗi checkpoint có
thể đưa story về nghiên cứu mà không làm hỏng các story đã pass.

## Notes

- Task `[P]` chỉ song song khi owner không sửa cùng file.
- Mọi task Rodin bắt buộc có ảnh tham chiếu đã duyệt; Text-to-3D không bao giờ là task thay thế.
- Không đưa `.env`, ảnh người tham gia, tên ngày giỗ thật hoặc recording vào pack hay test fixture.
- Repo dùng Git trên branch `main` và theo dõi `origin`. Không force-push, đổi lịch sử hoặc chuyển task thành issue nếu chủ dự án chưa yêu cầu.
