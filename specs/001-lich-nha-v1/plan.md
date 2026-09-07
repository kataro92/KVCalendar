# Implementation Plan: Lịch Nhà 1.0

**Branch**: `main` (feature ID `001-lich-nha-v1`) | **Date**: 2026-09-07 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/001-lich-nha-v1/spec.md`

**Note**: Plan này mô tả kiến trúc dự kiến. Nó không cho phép bắt đầu code trước khi các task
nghiên cứu và Definition of Ready hoàn tất.

## Summary

Lịch Nhà 1.0 là ứng dụng iPhone offline với một tờ lịch bloc làm màn hình chính, công cụ tra ngày,
chi tiết có nguồn, sự kiện âm/dương, local notification, widget và cảnh theo ngày. App dùng native
iOS để giữ tốc độ mở, widget, haptic và accessibility. Text cùng điều khiển là semantic views;
Canvas/shader chỉ vẽ giấy, hạt và biến dạng; RealityKit chỉ hiển thị tối đa vài đạo cụ đã có poster.

Logic lịch, nội dung, hiệu ứng, dữ liệu cá nhân và UI được tách thành các module có thể kiểm thử.
Không có backend hoặc SDK analytics. Data pack và asset pack được đóng gói cục bộ, có version,
checksum và provenance.

## Technical Context

**Language/Version**: Swift 6.x theo stable Xcode được ghim khi bắt đầu implementation

**Primary Dependencies**: SwiftUI, Foundation, WidgetKit, UserNotifications, SwiftData,
AVFoundation, Core Haptics; Canvas/Metal shader có giới hạn; RealityKit chỉ cho prop 3D nhỏ

**Storage**: SwiftData trong App Group cho sự kiện và thiết lập; JSON/resource bundle chỉ đọc cho
calendar, content, source và effect packs; UserDefaults trong App Group cho snapshot nhỏ

**Testing**: Swift Testing cho module thuần; XCTest/XCUITest cho UI, accessibility, widget,
notification và performance; snapshot/reference rendering cho tờ lịch và poster

**Target Platform**: iPhone, iOS 17 trở lên; widget cùng App Group; iPad ngoài phạm vi 1.0

**Project Type**: Native mobile app với một widget extension và các local Swift modules

**Performance Goals (provisional)**: Nội dung ngày xuất hiện trong một giây ở cold launch trên máy
thấp nhất; gesture tờ giấy giữ 60 fps; scene khởi động sau nội dung; widget không cần mạng. T019
phải chốt máy mục tiêu và T150 mới được xác nhận hoặc sửa các ngân sách này.

**Constraints**: Core offline; không backend, account, ad/paywall hoặc runtime AI; lịch Việt UTC+7;
mọi cảnh có poster, reduced-motion và low-power fallback. Các số effect pack 40–60 MB, 1–2 prop
và 20.000–25.000 tam giác là **ngân sách prototype**, không phải kết quả hoặc cam kết phát hành
trước khi T019/T150 hoàn tất.

**Scale/Scope**: Phạm vi ngày 1900–2100; sáu user story; hai scene flagship, bốn cảnh lễ khác,
sáu họ chuyển động cho 24 tiết khí; một ngôn ngữ phát hành chính là tiếng Việt

## Constitution design check

*Bảng này chỉ kiểm kế hoạch có phản ánh hiến pháp hay không. Nó không phải Gate 1–7 và không mở
khóa T020.*

| Gate | Kết quả trước Phase 0 | Bằng chứng |
|---|---|---|
| Lời hứa miễn phí, không quảng cáo, không login | `DOCUMENTED` | Không có backend, ad SDK, paywall hoặc account trong scope; binary chưa tồn tại |
| Dữ liệu lịch có nguồn và test | `BLOCKED T017` | Calendar Core, Source Record và golden corpus là foundation; owner/corpus chưa có |
| Bản sắc riêng cùng accessibility | `UNTESTED` | Semantic SwiftUI tách khỏi Canvas/effect; Gate 1–7 chưa chạy |
| Riêng tư và offline | `DESIGNED` | App Group local, pack cục bộ, widget snapshot đã lọc; runtime chưa kiểm |
| Kiểm chứng trước mở rộng | `BLOCKED T012–T020` | Phase nghiên cứu có task/go-no-go nhưng chưa hoàn tất |
| Rodin chỉ Image-to-3D | `DOCUMENTED` | Pipeline yêu cầu concept sheet đã duyệt; chưa có asset để audit |
| Quốc kỳ dựng và duyệt thủ công | `DOCUMENTED` | Cờ không thuộc pipeline tạo sinh; asset/golden frame chưa tồn tại |

**Post-design re-check**: `NOT READY`. Không phát hiện ý định kiến trúc trái hiến pháp, nhưng các
bằng chứng có quyền mở khóa implementation chưa tồn tại: nghiên cứu người dùng, corpus lịch,
ruleset truyền thống, quyền asset, support matrix và nguồn phí phát hành.

## Project Structure

### Documentation (this feature)

```text
specs/001-lich-nha-v1/
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── checklists/
│   └── requirements.md
├── contracts/
│   ├── accessibility-contract.md
│   ├── calendar-contract.md
│   ├── content-pack-contract.md
│   ├── effect-pack-contract.md
│   ├── reminder-contract.md
│   └── ui-state-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
LichNha/
├── LichNha.xcodeproj/
├── App/
│   ├── LichNhaApp.swift
│   ├── AppEnvironment.swift
│   └── AppRouter.swift
├── Modules/
│   ├── CalendarCore/
│   ├── AlmanacCore/
│   ├── ContentCore/
│   ├── PersonalCore/
│   ├── ReminderCore/
│   ├── EffectCore/
│   └── ProvenanceCore/
├── Features/
│   ├── Today/
│   ├── Month/
│   ├── DayDetail/
│   ├── Events/
│   ├── Settings/
│   └── Sources/
├── DesignSystem/
│   ├── Tokens/
│   ├── Components/
│   ├── Paper/
│   └── Accessibility/
├── Effects/
│   ├── Director/
│   ├── Rendering/
│   ├── Audio/
│   └── Posters/
├── Resources/
│   ├── CalendarPacks/
│   ├── ContentPacks/
│   ├── EffectPacks/
│   ├── Audio/
│   └── Assets.xcassets/
├── Widget/
│   ├── LichNhaWidget.swift
│   ├── WidgetTimelineProvider.swift
│   └── WidgetPrivacy.swift
└── Tests/
    ├── CalendarCoreTests/
    ├── AlmanacCoreTests/
    ├── ContentCoreTests/
    ├── PersonalCoreTests/
    ├── ReminderCoreTests/
    ├── EffectCoreTests/
    ├── AccessibilityTests/
    ├── PerformanceTests/
    ├── SnapshotTests/
    └── UITests/

tools/
├── pack-validator/
├── golden-calendar-builder/
└── asset-manifest-validator/

research/
├── participants/
├── sessions/
├── scorecards/
└── decisions/
```

**Structure Decision**: Một Xcode project chứa app và widget. Logic không phụ thuộc UI nằm trong
các module Swift cục bộ để chạy unit/property tests độc lập. Tool tạo và kiểm data pack nằm ngoài
app target; chúng không được ship trong binary. Research artifact tách khỏi `docs/` để giữ dữ liệu
người tham gia, consent và thời hạn xóa theo quy trình riêng.

## Complexity Tracking

Không có vi phạm cần biện minh. Widget là extension nền tảng bắt buộc; các module cục bộ phản ánh
ranh giới dữ liệu đã có trong đặc tả và không tạo service hay repository layer không cần thiết.
