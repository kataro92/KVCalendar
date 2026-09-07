# Quickstart validation: Lịch Nhà 1.0

Tài liệu này là runbook kiểm tra end-to-end sau khi các task triển khai tương ứng hoàn tất. Trước
đó, nó dùng để xác nhận mỗi task có một đích kiểm tra rõ.

## Prerequisites

- macOS và stable Xcode đã được ghi trong build manifest.
- Ít nhất một simulator iOS 17 và iPhone thấp nhất trong support matrix.
- Một iPhone thật thuộc tier thấp cùng một iPhone OLED/notch khác.
- Golden calendar corpus, pack fixtures và asset manifest fixtures đã được duyệt.
- Không dùng tài khoản, backend hoặc mạng cho các kịch bản cốt lõi.

## Automated checks

Từ repository root, sau khi Xcode project được tạo:

```bash
xcodebuild test -project LichNha/LichNha.xcodeproj -scheme LichNhaCoreTests -destination 'platform=iOS Simulator,name=iPhone 15'
xcodebuild test -project LichNha/LichNha.xcodeproj -scheme LichNha -destination 'platform=iOS Simulator,name=iPhone 15'
xcodebuild test -project LichNha/LichNha.xcodeproj -scheme LichNhaUITests -destination 'platform=iOS Simulator,name=iPhone 15'
```

Expected: calendar golden/property/regression tests pass; pack validator rejects invalid source,
checksum and license fixtures; UI tests pass without network.

## Scenario A: First launch and today

1. Enable Airplane Mode and remove prior app data.
2. Launch the app without granting optional permissions.
3. Read solar date, lunar date, weekday and event.
4. Move to the next day using the peel gesture, then use the button/action.
5. Jump to another month and return with Hôm nay.

Expected: calendar text appears within the launch target, both navigation methods agree and Hôm nay
takes one action. No login, paywall, ad or network error appears.

## Scenario B: Trust and historical date

1. Open a date with a sourced official occurrence.
2. Open a traditional almanac detail and its source.
3. Open a fixture in 1968–1975 that differs by historical source.

Expected: taxonomy and day-off status are distinct; traditional content says “tham khảo”; source is
reachable in two actions; historical warning names the scope without claiming false precision.

## Scenario C: Lunar family event

1. Create an annual event for lunar day 12, month 8, reminder three days early at 08:00.
2. Exercise the leap-month fixture and select one policy.
3. Exercise lunar day 30 in a 29-day target month.
4. Deny notification permission, relaunch, then change device timezone.

Expected: the app repeats the selected policies in Vietnamese, preserves the event after denial,
marks reminder state accurately and rebuilds occurrences without changing the Vietnamese calendar
rule zone.

## Scenario D: Widget privacy

1. Add each supported widget family.
2. Seed one public holiday and one private event.
3. Lock the device, cross midnight, then tap the widget.

Expected: private title/note stays hidden by default; the timeline does not label a future date as
today when refresh is late; deep link opens the correct sheet.

## Scenario E: Effect and audio fallback

1. Run fixtures for Quốc khánh, Lập Xuân, overlapping events and a normal day.
2. Repeat with Sống động, Êm, Tĩnh, Reduce Motion, Dim Flashing Lights and Low Power.
3. Start music in another app, enable Silent and VoiceOver, place a call and remove headphones.

Expected: one hero at most; text remains readable; flag geometry and star stay correct; poster works
offline; Hiên sớm never competes with VoiceOver or other priority audio; paper/event cues remain off
until enabled.

## Scenario F: Large text and VoiceOver

1. Set text to 200%, Increase Contrast and Reduce Transparency.
2. Complete today, month lookup, source lookup, event creation and sound-off tasks.
3. Repeat core navigation using VoiceOver without gestures that require dragging.

Expected: all core tasks complete, focus order matches the accessibility contract and no primary
date field is clipped or represented only by an image.

## Physical-device performance pass

Profile cold launch, page curl, flagship effect and 15-minute ambient playback on the lowest device.
Record frame pacing, thermal state, relative battery change, memory and time to readable calendar
text. A failed target moves the scene down through particle/LOD tiers to the static poster; it does
not permit reducing text quality or removing accessibility semantics.
