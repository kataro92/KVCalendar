# Data Model: Lịch Nhà 1.0

Mô hình tách dữ kiện tính toán, nội dung có nguồn, dữ liệu cá nhân và cách trình bày. UI không tự
suy luận ngày âm, sự kiện hoặc effect từ chuỗi hiển thị.

## CivilDate và TimeContext

`CivilDate` là bộ ba năm–tháng–ngày dương lịch, không kèm giờ, offset, instant hoặc timezone. Nó là
kiểu của `selectedDate`, `CalendarDay.civilDate` và `ReminderOccurrence.targetCivilDate`.

`TimeContext` giữ ba khái niệm không được trộn: `calendarRuleZone` tính lịch Việt, `displayZone`
suy ra Hôm nay từ instant hiện tại và `deliveryZone` ghép giờ local cho reminder. Đổi display zone
không mutate CivilDate đã chọn hay event gốc.

## CalendarDay

Đại diện cho một ngày được chuẩn hóa để app, widget và reminder cùng dùng.

| Field | Nội dung | Validation |
|---|---|---|
| `civilDate` | Ngày dương không kèm giờ | Hợp lệ trong 1900–2100 |
| `displayTimeZone` | Múi giờ quyết định “hôm nay” | IANA identifier hợp lệ |
| `calendarRuleZone` | Múi giờ tính lịch Việt | Cố định UTC+7 cho ruleset hiện đại |
| `weekday` | Thứ | Dẫn xuất từ civil date |
| `lunarDate` | Ngày, tháng, năm âm và cờ nhuận | Round-trip được về civil date |
| `canChi` | Ngày, tháng, năm | Theo version engine |
| `solarTerm` | Tiết khí đang hiệu lực và thời điểm đổi nếu đủ tin cậy | Có source/version |
| `historyScope` | Modern, retrospective hoặc documented exception | Bắt buộc trước 1976 |
| `occurrenceIDs` | Các occurrence áp dụng | ID tồn tại trong pack hoặc personal store |

CalendarDay không chứa đoạn văn biên tập, file asset hoặc trạng thái notification.

## LunarDate

| Field | Nội dung | Validation |
|---|---|---|
| `day` | 1–30 | Không vượt độ dài tháng |
| `month` | 1–12 | Bắt buộc |
| `year` | Năm âm | Nằm trong phạm vi convert đã duyệt |
| `isLeapMonth` | Tháng nhuận hay thường | Chỉ true khi năm có đúng tháng nhuận đó |
| `ruleSetVersion` | Version engine | Không rỗng |

Hai LunarDate cùng số ngày/tháng/năm nhưng khác `isLeapMonth` là hai giá trị khác nhau.

## CalendarOccurrence

| Field | Nội dung | Validation |
|---|---|---|
| `id` | ID ổn định | Duy nhất, không dựa vào tên hiển thị |
| `title` | Tên tiếng Việt | Không rỗng, hỗ trợ Unicode |
| `taxonomy` | Nghỉ theo luật, lịch năm cụ thể, kỷ niệm, lễ âm, địa phương hoặc cá nhân | Enum đóng |
| `calendarBasis` | Dương, âm hoặc thời điểm tiết khí | Bắt buộc |
| `start` / `end` | Ngày hay khoảng ngày | Start không sau end |
| `audience` | Nhóm được áp dụng | Bắt buộc cho lịch nghỉ năm cụ thể |
| `region` | Toàn quốc hoặc địa bàn | Không gán toàn quốc cho lễ địa phương |
| `isDayOff` | Có phải ngày nghỉ | Chỉ có nghĩa với taxonomy phù hợp |
| `tone` | Hân hoan, ấm, trang trọng, tưởng niệm hoặc trung tính | Dùng cho resolver, không dùng làm taxonomy |
| `safetyFlags` | National flag, religious, solemn, no confetti, no audio | Danh sách có kiểm soát |
| `sourceID` | Nguồn căn cứ | Bắt buộc trừ sự kiện cá nhân |
| `packVersion` | Version data pack | Bắt buộc với occurrence đóng gói |

## SourceRecord

| Field | Nội dung | Validation |
|---|---|---|
| `id` | ID ổn định | Duy nhất |
| `title` | Tên tài liệu hoặc nguồn | Không rỗng |
| `url` | Địa chỉ kiểm chứng | HTTPS khi nguồn có URL |
| `evidenceTier` | Tính toán, chính thức, văn hóa, truyền thống hoặc cá nhân | Khớp loại record sử dụng |
| `publisher` | Cơ quan/tác giả | Bắt buộc nếu biết |
| `publishedAt` / `accessedAt` | Mốc nguồn | ISO date |
| `scope` | Năm, vùng, đối tượng, hệ quy tắc | Không rỗng |
| `licenseStatus` | Public record, public domain, licensed, original hoặc restricted | Restricted không được ship |
| `contentHash` | Checksum bản đã duyệt | Bắt buộc ở release pack |

## AlmanacRuleSet và AlmanacEntry

`AlmanacRuleSet` lưu ID, tên phương pháp, nguồn, phiên bản, phạm vi và trạng thái được phép hiển
thị. `AlmanacEntry` liên kết một CalendarDay với phân loại hoàng/hắc đạo, giờ hoàng đạo và dòng
nên/tránh ngắn.

Validation:

- Mọi entry phải chỉ tới một ruleset được duyệt.
- Tất cả nội dung hiển thị có nhãn tham khảo.
- Không có phần trăm khoa học giả hoặc cá nhân hóa theo ngày sinh trong 1.0.
- Khi hai ruleset mâu thuẫn, UI không được trộn chúng thành một kết luận duy nhất.

## PersonalEvent

| Field | Nội dung | Validation |
|---|---|---|
| `id` | ID cục bộ | Duy nhất |
| `title` | Tên sự kiện | Không rỗng; không ghi vào log |
| `notes` | Ghi chú tùy chọn | Không đưa sang widget mặc định |
| `calendarBasis` | Âm hoặc dương | Bắt buộc |
| `originDate` | Ngày gốc | Hợp lệ theo calendar basis |
| `recurrence` | Không lặp hoặc hằng năm | 1.0 không cần rule phức tạp hơn |
| `leapMonthPolicy` | Tháng thường, tháng nhuận, cả hai hoặc quy tắc thay thế | Bắt buộc với event âm liên quan tháng nhuận |
| `shortMonthPolicy` | Ngày cuối tháng, bỏ qua hoặc mùng 1 tháng sau | Bắt buộc nếu ngày âm là 30 |
| `reminderPolicy` | Bật/tắt, trước bao lâu, giờ giao | Không đồng nghĩa permission đã cấp |
| `calculationZone` | Quy tắc lịch | Mặc định lịch Việt UTC+7 |
| `deliveryZone` | Giờ giao thông báo | Local device hoặc zone người dùng chọn |
| `dstResolutionPolicy` | Gap: giờ hợp lệ kế tiếp; overlap: instant sớm hơn, hoặc override đã chọn | Provisional; luôn deterministic và có thể giải thích |
| `widgetPrivacy` | Public title, generic marker hoặc hidden | Mặc định hidden trên lock screen |
| `createdAt` / `updatedAt` | Audit cục bộ | Không rời thiết bị |

State: Draft → Saved. Saved có thể chuyển Active, Archived hoặc Deleted. Notification status là
một trục riêng: NotRequested → Authorized/Denied; Authorized có Scheduled, NeedsRefresh hoặc Error.

## ReminderOccurrence

Một lần giao cụ thể được sinh từ PersonalEvent, không thay thế event gốc.

| Field | Nội dung | Validation |
|---|---|---|
| `id` | ID deterministic theo event và occurrence | Không trùng trong cửa sổ |
| `eventID` | PersonalEvent nguồn | Phải tồn tại |
| `targetCivilDate` | Ngày dương đã convert | Round-trip theo policy |
| `deliveryDateTime` | Timestamp giao | Theo delivery zone |
| `timeAdjustment` | Không đổi, DST gap→giờ kế tiếp, overlap→instant sớm/muộn | Bắt buộc nếu giờ local không ánh xạ một-một |
| `sourceRuleVersion` | Version engine/policy | Bắt buộc |
| `status` | Planned, scheduled, delivered, cancelled, failed hoặc stale | Transition hợp lệ |
| `systemIdentifier` | ID notification nếu đã schedule | Chỉ có ở trạng thái Scheduled trở đi |

State transition: Planned → Scheduled → Delivered. Event/settings/timezone thay đổi đưa occurrence
về Stale, sau đó Cancelled và sinh occurrence mới. Permission bị từ chối tạo Planned/Failed nhưng
không xóa PersonalEvent.

## EffectCue và EffectPack

EffectCue gồm `id`, trigger bằng occurrence/solar-term ID, tone, priority, region variants, hero,
ambient, accent, audio cue, safe zone và fallback IDs. Cue có các cờ `allowsAutoPlay`,
`nationalFlag`, `solemn`, `noConfetti`, `noAudio`.

EffectPack gồm schema version, pack version, min app version, danh sách cue, AssetRecord, checksum
và release approval. Pack chỉ Active khi mọi reference tồn tại và license gate pass.

Resolver state: Unresolved → ResolvedLive, ResolvedGentle hoặc ResolvedStatic. Asset thiếu,
accessibility, Low Power hoặc thermal state chỉ được hạ chất lượng; chúng không được làm mất
CalendarOccurrence.

## AssetRecord

| Field | Nội dung | Validation |
|---|---|---|
| `id` | ID asset | Duy nhất |
| `kind` | Model, texture, sprite, poster hoặc audio | Enum đóng |
| `sourceReference` | Ảnh/concept/recording gốc | Có quyền và checksum |
| `generationMethod` | Manual, captured, Image-to-3D hoặc sound generation | Text-only 3D bị cấm |
| `toolAndVersion` | Công cụ sản xuất | Không dùng làm runtime dependency |
| `editHistory` | Cleanup, retopo, paint-over, mix, normalize | Không rỗng với asset tạo sinh |
| `licenseEvidence` | Gói, Terms snapshot, quyền xuất bản | Phải pass trước release |
| `files` | Master, runtime variants, LOD và poster | Mỗi model phải có poster |
| `review` | Mỹ thuật, văn hóa, accessibility, pháp lý | Cờ quốc gia cần review chuyên biệt |
| `checksum` | Hash từng file ship | Khớp pack manifest |

## UserPreferences

Chứa effect level, inspiration region, ambient sound choice, paper sound, event cue, display day
zone, reminder delivery zone, almanac visibility, large print choice và widget privacy. System
accessibility settings luôn có độ ưu tiên cao hơn preference cảnh, nhưng không tự thay đổi lựa chọn
đã lưu của người dùng.

## WidgetSnapshot

Snapshot gồm civil date, weekday, lunar date, short occurrence label đã lọc, theme tokens, deep link,
generatedAt và expiresAfter. Nó không chứa notes hoặc event title khi privacy policy không cho phép.

## Relationships

- CalendarDay có nhiều CalendarOccurrence và tối đa một SolarTerm đang hiệu lực.
- CalendarOccurrence liên kết một SourceRecord; EffectCue tham chiếu occurrence bằng ID.
- PersonalEvent sinh nhiều ReminderOccurrence nhưng vẫn tồn tại độc lập với chúng.
- EffectPack có nhiều EffectCue và AssetRecord; mọi cue chỉ dùng asset trong pack đã duyệt.
- UserPreferences chi phối Effect Resolver, Reminder Planner và WidgetSnapshot Builder.
- WidgetSnapshot lấy dữ liệu đã chuẩn hóa từ CalendarDay, Content Catalog và PersonalEvent privacy.
