# Implementation Plan: Lịch Nhà 1.0

**Branch**: `001-lich-nha-v1` (logical feature ID; repository chưa dùng Git) | **Date**: 2026-09-07 | **Spec**: [spec.md](spec.md)

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

**Performance Goals**: Nội dung ngày xuất hiện trong một giây ở cold launch trên máy thấp nhất;
gesture tờ giấy giữ 60 fps; scene khởi động sau nội dung; widget không cần mạng

**Constraints**: Core offline; không backend, account, ad/paywall hoặc runtime AI; lịch Việt UTC+7;
asset pack dự kiến tăng 40–60 MB; live 3D tối đa 1–2 prop và khoảng 20.000–25.000 tam giác cùng lúc;
mọi cảnh có poster, reduced-motion và low-power fallback

**Scale/Scope**: Phạm vi ngày 1900–2100; sáu user story; hai scene flagship, bốn cảnh lễ khác,
sáu họ chuyển động cho 24 tiết khí; một ngôn ngữ phát hành chính là tiếng Việt

## Constitution Check

*GATE: Phải đạt trước Phase 0 và được kiểm lại sau Phase 1.*

| Gate | Kết quả trước Phase 0 | Bằng chứng |
|---|---|---|
| Lời hứa miễn phí, không quảng cáo, không login | PASS | Không có backend, ad SDK, paywall hoặc account trong scope |
| Dữ liệu lịch có nguồn và test | PASS có điều kiện | Calendar Core, Source Record và golden corpus là foundation; implementation chờ owner/corpus |
| Bản sắc riêng cùng accessibility | PASS có điều kiện | Semantic SwiftUI tách khỏi Canvas/effect; Gate 1–7 vẫn phải chạy |
| Riêng tư và offline | PASS | App Group local, pack cục bộ, widget snapshot đã lọc, không telemetry |
| Kiểm chứng trước mở rộng | PASS | Phase nghiên cứu nằm trước setup mã và có task/go-no-go riêng |
| Rodin chỉ Image-to-3D | PASS | Pipeline asset yêu cầu concept sheet đã duyệt; Text-to-3D bị cấm |
| Quốc kỳ dựng và duyệt thủ công | PASS | Cờ không thuộc pipeline tạo sinh; có review frame-by-frame |

**Post-design re-check**: PASS có điều kiện. Không có vi phạm kiến trúc. Điều kiện còn lại là hoàn
tất nghiên cứu người dùng, corpus lịch, ruleset truyền thống, quyền asset và nguồn phí phát hành.

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
