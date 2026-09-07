# 05 — Khả thi kỹ thuật và lộ trình

Tài liệu này đưa ra quyết định kiến trúc ở mức sản phẩm, chưa phải thiết kế mã nguồn.

## 1. Khuyến nghị công nghệ

**Chọn native iOS: Swift + SwiftUI cho app và widget; dùng custom drawing/Metal shader có giới hạn cho tờ giấy và particle; RealityKit chỉ cho một số đạo cụ 3D nhỏ; Core Haptics cho cảm giác; UserNotifications cho nhắc; lưu trữ cục bộ trong App Group.**

“Native” không có nghĩa phải dùng giao diện form mặc định. SwiftUI hỗ trợ custom shape, compositing, mask, transform, text rendering và Canvas; Apple mô tả Canvas dành cho đồ họa 2D động giàu chi tiết: [SwiftUI Canvas](https://developer.apple.com/documentation/swiftui/canvas), [Drawing and graphics](https://developer.apple.com/documentation/swiftui/drawing-and-graphics). Shader của SwiftUI có thể tạo distortion/layer effect khi cần: [SwiftUI layerEffect](https://developer.apple.com/documentation/swiftui/view/layereffect%28_%3Amaxsampleoffset%3Aisenabled%3A%29).

### Lý do chọn

- chỉ nhắm iOS ở giai đoạn đầu;
- WidgetKit, local notification, accessibility, Dynamic Type, haptics và lifecycle là phần lõi chứ không phải add-on;
- app utility cần mở nhanh, nhỏ, ít pin và hoạt động nhiều năm;
- native giảm số bridge/plugin và rủi ro maintenance;
- UI vẫn có thể vẽ hoàn toàn riêng;
- semantic accessibility dễ giữ hơn khi text/control cốt lõi là SwiftUI views.

## 2. So sánh lựa chọn

Thang 1–5; điểm là đánh giá cho đúng sản phẩm này, không phải chất lượng tổng quát của framework.

| Giải pháp | Mỹ thuật riêng | Widget/notification | Accessibility | Nhẹ/bền | Đa nền tảng | Kết luận |
|---|---:|---:|---:|---:|---:|---|
| SwiftUI + Metal hạn chế | 5 | 5 | 5 | 5 | 1 | **Khuyến nghị** |
| Flutter | 5 | 3 | 4 | 3 | 5 | Tốt nếu Android là mục tiêu gần |
| React Native + Skia | 5 | 3 | 3–4 | 3 | 5 | Hợp đội mạnh React, nhưng tăng bridge và native work |
| Godot | 5 | 1–2 | 2 | 2 | 5 | Quá giống game engine cho một utility app |
| Three.js trong WebView | 4 | 1–2 | 2 | 2 | 5 | Tích hợp iOS và widget kém, không đáng đổi |

### Flutter

Flutter có custom rendering mạnh; Impeller hiện là renderer mặc định và duy nhất được hỗ trợ trên iOS theo tài liệu hiện tại: [Flutter — Impeller](https://docs.flutter.dev/perf/impeller). Tuy nhiên widget, EventKit, App Group, notification edge cases và một số accessibility behavior vẫn cần phần native. Nếu sau khi prototype có cam kết Android trong 3–6 tháng, Flutter trở thành phương án số hai.

### React Native + Skia

React Native Skia cung cấp Canvas và renderer riêng hiệu năng cao; tài liệu mô tả cả retained/immediate mode và high-bit-depth surface trên iOS: [React Native Skia — Canvas](https://shopify.github.io/react-native-skia/docs/canvas/overview/). React Native có accessibility APIs và custom actions, nhưng khác biệt iOS/Android vẫn cần xử lý: [React Native — Accessibility](https://reactnative.dev/docs/accessibility.html). Chọn hướng này chỉ khi đội hiện có năng lực React Native rõ rệt và chấp nhận viết extension Swift cho widget.

### Godot

Godot xuất được iOS qua Xcode, nhưng luồng phát triển vẫn phải export project, plugin iOS riêng và C# support còn được tài liệu gọi là experimental ở một số tình huống: [Godot — Exporting for iOS](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html). Engine phù hợp game/scene hơn form nhập, widget, Dynamic Type và VoiceOver của app lịch; không có lợi thế đủ lớn.

### Three.js/WebView

Page curl 3D có thể đẹp, nhưng đổi lại là startup, bộ nhớ, bridge dữ liệu, accessibility và widget phức tạp. Một tờ giấy 2.5D không cần scene 3D đầy đủ; dùng GPU shader nhỏ ở native hợp lý hơn.

## 3. Chiến lược render

### Không vẽ tất cả trong một Canvas

Apple lưu ý SwiftUI Canvas không cung cấp interactivity/accessibility cho từng element và phù hợp hơn với hình vẽ phức tạp không dựa chủ yếu vào text. Vì thế:

- **text, nút, trường ngày, sự kiện:** SwiftUI views thật;
- **paper grain, cạnh giấy, bóng, hoa văn không tương tác:** Canvas/shape/image;
- **page deformation trong lúc kéo:** shader/distortion hoặc layer transform;
- **accessibility tree:** luôn dựa trên views/semantic overlay, không dựa vào bitmap;
- **ảnh share:** render offscreen từ cùng design tokens, không chụp UI tùy tiện.

### Page curl theo ba mức

1. **Prototype rẻ:** tờ nghiêng, mask cong và shadow động; không shader phức tạp.
2. **Bản production đề xuất:** mesh/distortion effect cho mặt trước/sau + shadow, chỉ chạy trong gesture.
3. **Không khuyến nghị ban đầu:** mô phỏng giấy 3D/physics engine đầy đủ.

Cổng quyết định: nếu mức 1 đã được người dùng gọi là “bóc lịch thật” và đạt 60 fps, không cần mức 2. Mỹ thuật tốt quan trọng hơn số polygon.

## 4. Các khối hệ thống

| Khối | Trách nhiệm | Quy tắc phụ thuộc |
|---|---|---|
| Calendar Core | dương/âm, tháng nhuận, Can Chi, tiết khí | Thuần cục bộ, deterministic, không UI |
| Almanac Core | giờ/ngày truyền thống theo ruleset | Tách khỏi Calendar Core, có version/nguồn |
| Content Catalog | ngày lễ, văn hóa, câu/nghệ thuật | Bundle versioned, có license metadata |
| Effect Director | chọn hero/ambient/accent theo ngày, vùng, priority và accessibility/power state | Deterministic, asset local, không AI runtime |
| Asset Catalog | model, sprite, texture, audio, LOD/poster và provenance | Bundle versioned; chỉ nhận asset qua license gate |
| Personal Store | sự kiện, thiết lập, trạng thái bóc | Chỉ trên máy/App Group |
| Reminder Planner | occurrence âm/dương, cửa sổ notification | Không sửa event gốc; có timezone policy |
| Today Experience | tờ trước/sau, gesture, month sheet | Đọc model đã chuẩn hóa |
| Widget Extension | snapshot/timeline, deep link | Dữ liệu tối thiểu qua App Group |
| Export/Import | backup chủ động | Không server; validate schema/version |
| Provenance | nguồn, version, changelog | Truy cập từ từng trường cần thiết |

## 5. Lưu trữ và chia sẻ giữa app/widget

SwiftData hoặc Core Data đều khả thi; lựa chọn cuối phụ thuộc deployment target và kinh nghiệm đội. Apple có mẫu dùng App Group để app và widget chia sẻ SwiftData store: [Adopting SwiftData for a Core Data app](https://developer.apple.com/documentation/CoreData/adopting-swiftdata-for-a-core-data-app).

Khuyến nghị:

- App Group chứa settings, event occurrence đã tính trước và widget snapshot;
- bundle lịch/văn hóa là read-only resource;
- widget không tự chạy logic biên tập phức tạp nếu app đã chuẩn bị được;
- personal store có schema version và migration test;
- không đưa ghi chú người dùng vào log/crash report.

## 6. Widget

WidgetKit dùng timeline entries và hệ thống quyết định thời điểm render; refresh không được bảo đảm đúng chính xác từng giây. Apple khuyến nghị chuẩn bị trước dữ liệu cho các thời điểm dự đoán được và chỉ reload khi nội dung thật sự đổi: [Keeping a widget up to date](https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date/), [TimelineProvider](https://developer.apple.com/documentation/widgetkit/timelineprovider).

Chiến lược:

- tạo entries qua vài ngày tại mốc nửa đêm theo local display timezone;
- snapshot có đủ dữ kiện ngày, không truy cập mạng;
- khi event/settings đổi, app ghi snapshot và yêu cầu reload đúng kind;
- test việc hệ thống cập nhật trễ; widget vẫn không được hiển thị ngày tương lai sai nhãn;
- dùng deep link nhỏ, ổn định;
- không animation bóc giấy trong widget; chỉ dùng ngôn ngữ tĩnh của bloc.

## 7. Notification và lịch hệ thống

### Local notifications

`UNCalendarNotificationTrigger` hỗ trợ giao thông báo theo thành phần ngày/giờ và lặp; Apple mô tả đây là trigger cho local notification ở ngày/giờ xác định: [UNCalendarNotificationTrigger](https://developer.apple.com/documentation/usernotifications/uncalendarnotificationtrigger).

Với lịch âm, không dùng một repeating trigger cố định theo Gregorian. Reminder Planner phải:

- tính các occurrence âm → dương trong cửa sổ tương lai;
- lập local notification cho occurrence cụ thể;
- làm mới cửa sổ khi app active/date/timezone/settings thay đổi;
- phát hiện permission off và không báo giả “đã nhắc”.

### EventKit — tùy chọn sau lõi

Nếu chỉ muốn cho người dùng xuất một sự kiện sang Calendar, iOS 17+ cho phép trình bày editor hệ thống mà không cần đọc lịch. Nếu app cần lưu trực tiếp, chỉ xin write-only; full access chỉ khi thật sự đọc tất cả events. Nguồn: [Apple — Accessing Calendar using EventKit](https://developer.apple.com/documentation/eventkit/accessing-calendar-using-eventkit-and-eventkitui).

Khuyến nghị 1.0: sự kiện thuộc app; có hành động chủ động “Thêm vào Lịch iPhone” qua UI hệ thống. Không đọc lịch người dùng.

## 8. Riêng tư và bảo mật

### Mô hình đe dọa vừa đủ

- người cầm máy có thể thấy tên ngày giỗ/ghi chú;
- widget trên lock screen có thể lộ sự kiện;
- file backup có thể bị chia sẻ nhầm;
- log/debug snapshot có thể chứa nội dung cá nhân;
- dependency analytics có thể biến claim “không thu thập” thành sai.

### Biện pháp

- widget privacy mặc định chỉ hiện ngày, không hiện tên event trên lock screen;
- có tùy chọn ẩn sự kiện khi thiết bị khóa;
- export cảnh báo và có thể mã hóa bằng mật khẩu trong giai đoạn sau;
- log chỉ dùng ID/hash cục bộ, không tên/ghi chú;
- dependency allowlist; không SDK quảng cáo/analytics;
- privacy manifest và App Store answers kiểm tra ở mỗi release;
- privacy policy ngắn, nói cả dữ liệu không thu thập.

Apple yêu cầu iOS app có Privacy Policy URL và khai practices trong App Store Connect ngay cả khi chọn “không thu thập”: [Manage app privacy](https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy/).

## 9. App Store và chi phí

### Miễn phí cho người dùng không đồng nghĩa chi phí phát hành bằng 0

Apple Developer Program hiện là **99 USD mỗi năm**; tài khoản miễn phí chỉ đủ dùng Xcode/test cá nhân, còn phân phối App Store cần membership. Một số tổ chức phi lợi nhuận, giáo dục hoặc chính phủ đủ điều kiện có thể xin miễn phí. Nguồn: [Apple Developer Program](https://developer.apple.com/programs/whats-included/), [Choosing a Membership](https://developer.apple.com/support/compare-memberships/).

### Ngân sách tối thiểu

- bắt buộc: Apple Developer 99 USD/năm (hoặc nội tệ/fee waiver nếu đủ điều kiện);
- bắt buộc thực tế: máy Mac chạy Xcode để build/sign/release;
- nên có: iPhone thấp nhất và ít nhất một iPhone OLED/notch khác để test;
- tùy chọn: domain/trang tĩnh cho privacy/support;
- không cần: backend, database cloud, ad SDK, analytics subscription.

### Rủi ro review

Apple yêu cầu app có đủ utility, vượt quá web wrapper và metadata phản ánh đúng chức năng; chính sách riêng tư và data minimization cũng bắt buộc: [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/).

Lịch Nhà có đủ “minimum functionality” nếu 1.0 gồm calendar engine, interaction, month view, reminders, widget và personal events. Không nộp một prototype chỉ có một tờ ngày tĩnh.

## 10. Deployment target

Khuyến nghị khởi động với **iOS 17 trở lên**, rồi xác nhận bằng dữ liệu thiết bị mục tiêu trước khi code.

Lợi ích:

- EventKit access model rõ hơn;
- SwiftUI/shader APIs mới hơn;
- giảm nhánh tương thích;
- đủ cho widget hiện đại.

Đánh đổi: có thể bỏ lại iPhone của một bộ phận người lớn tuổi. Trước khi chốt, vẫn cần một nhóm accessibility 55+ dùng thiết bị thật và ghi phiên bản iOS; nhóm này kiểm tra khả năng sử dụng, không quyết định phong cách mặc định. Nếu cần iOS 16, page curl và data stack phải có fallback rõ.

## 11. Lộ trình đề xuất

Ước lượng dưới đây cho một nhóm nhỏ gồm 1 iOS engineer, 1 product designer/illustrator bán thời gian và 1 content reviewer; không phải cam kết tiến độ.

### Giai đoạn 0 — kiểm chứng trước code, 3–4 tuần

- phỏng vấn/quan sát tối thiểu 20 người, trong đó 14 người thuộc nhóm chính 16–34 tuổi;
- chụp/đo 6–10 mẫu lịch bloc có quyền quan sát;
- prototype chuyển động bằng Figma/Principle/After Effects hoặc công cụ tương đương;
- test ba mức page curl và Large Print;
- storyboard/test tĩnh ba cảnh: Quốc khánh, Lập Xuân và ngày thường; chốt luật intro–lắng–nghỉ;
- so sánh ba mức pastel/dễ thương và blind test im lặng, Hiên sớm, Mưa xa;
- chốt mặt trước/mặt sau;
- cổng quyết định: ít nhất 80% nhận ra cách lật và 70% thích concept hơn lịch grid thường.

### Giai đoạn 1 — lõi lịch và trust, 2–3 tuần

- đặc tả thuật toán/nguồn/phạm vi;
- tạo golden corpus và ruleset;
- rà soát lịch sử/múi giờ;
- schema sự kiện âm/dương;
- cổng quyết định: toàn bộ bộ chuẩn pass, khác biệt được giải thích.

### Giai đoạn 2 — vertical slice, 4–5 tuần

- tờ hôm nay thật;
- gesture bản tối thiểu;
- mặt sau;
- theme Mộc Son Dịu;
- vertical slice “Nhịp Nhà” với một scene particle, một prop 3D/poster và resolver hai sự kiện trùng;
- VoiceOver + Reduce Motion từ đầu;
- chạy trên iPhone thật;
- cổng quyết định: 60 fps và task success theo kế hoạch test.

### Giai đoạn 3 — product complete, 4–6 tuần

- tờ tháng và đổi ngày;
- personal events, lunar repeat edge cases;
- notifications;
- widget;
- settings/source/privacy;
- import/export tối thiểu nếu vào phạm vi;
- cổng quyết định: offline, timezone, accessibility và regression pass.

### Giai đoạn 4 — effect pack, polish và TestFlight, 5–7 tuần

- hoàn thiện shader/haptic/audio và effect pack sau khi UX ổn;
- import asset đã cleanup từ Rodin, âm đã duyệt từ ElevenLabs/thu thật; khóa provenance/license manifest;
- artwork và license manifest;
- localization tiếng Việt, App Store metadata;
- test 20–30 người, tập trung 55+;
- content audit hai người;
- fix crash/performance;
- cổng quyết định: không bug P0/P1, không lỗi golden data, privacy answers khớp binary.

Asset production cho “Nhịp Nhà” bắt đầu ngay sau gate storyboard và chạy song song giai đoạn 2–3; không đợi đến giai đoạn 4 mới tạo toàn bộ cảnh.

### Tổng thực tế

Khoảng **18–25 tuần** cho bản 1.0 có effect pack đạt chất lượng với nhóm trên. Nếu một người làm cả code, design, 3D/audio và nội dung, nên dự trù 7–10 tháng. Khi cần giảm lịch, giữ hai cảnh flagship + static fallback và giảm số vi cảnh; không cắt review dữ liệu, quyền asset hay accessibility.

## 12. Rủi ro và giảm thiểu

| Rủi ro | Xác suất | Tác động | Giảm thiểu |
|---|---|---|---|
| Page curl giật/nặng | Trung bình | Cao | Prototype ba mức; shader chỉ trong gesture; fallback Reduce Motion |
| Hiệu ứng biến app thành game/che ngày | Trung bình | Cao | Một hero; intro ngắn rồi nghỉ; content safe zone; usability gate |
| Particle/3D nóng máy, hao pin | Trung bình | Cao | LOD/poster; giới hạn live prop; Low Power/thermal degradation; profile máy thật |
| Thể hiện Quốc kỳ sai/thiếu trang trọng | Thấp nếu review | Rất cao | Asset dựng tay theo Hiến pháp; không AI-generate cờ; cultural review frame-by-frame |
| Asset AI thiếu quyền sử dụng | Trung bình | Cao | Lưu plan/Terms/prompt/input provenance; không dùng Beta/free output sai phạm vi; license gate |
| Sai lịch/tháng nhuận | Trung bình | Rất cao | Golden corpus, independent oracle, version engine |
| UI đẹp nhưng khó dùng | Trung bình | Cao | Test không hướng dẫn, nút thay thế cho gesture |
| Người lớn tuổi không đọc được | Cao nếu không test | Cao | Large Print từ vertical slice, test thiết bị thật |
| Ngày nghỉ thay đổi | Cao theo năm | Trung bình | Official data pack versioned, không hard-code logic |
| Nội dung vi phạm bản quyền | Trung bình | Cao | Asset/content manifest và review giấy phép |
| Lời hứa miễn phí không bền | Trung bình | Cao | Chốt nguồn 99 USD/năm trước release, công khai cam kết |
| Scope phình thành app tử vi | Cao | Cao | Non-goals và product gate rõ |
| Widget cập nhật trễ | Trung bình | Trung bình | Timeline chuẩn bị trước, test ngoài debugger, nhãn an toàn |
| Dữ liệu sự kiện bị lộ | Thấp–trung bình | Cao | Local only, lock screen privacy, no content logs |

## 13. Definition of ready to code

Chỉ bắt đầu implementation khi đủ:

- 20 buổi nghiên cứu người dùng thật hoàn tất theo ma trận tuyển; persona tổng hợp không được tính vào mẫu;
- concept Mộc Son Dịu và một phương án dự phòng đã được test;
- mặt trước/mặt sau chốt bằng content hierarchy;
- motion prototype được test trên iPhone thật;
- phạm vi năm và lịch sử được duyệt;
- golden date corpus có owner;
- ruleset “tốt/xấu” có nguồn hoặc bị loại khỏi 1.0;
- mọi font/artwork mẫu có hướng cấp phép;
- storyboard Quốc khánh/Lập Xuân, ma trận fallback và ngân sách effect đã qua test;
- pipeline Rodin/ElevenLabs có asset manifest, quyền dùng và owner duyệt;
- người chịu phí Apple Developer và maintenance đã xác định;
- backlog 1.0 không chứa các mục “sẽ quyết sau” ảnh hưởng kiến trúc.
