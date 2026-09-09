# 07 — Nguồn tham khảo

Ngày truy cập chung: **07/09/2026**. Với nguồn động như App Store, Apple documentation và văn bản theo năm, cần kiểm tra lại trước khi bắt đầu triển khai và trước mỗi lần phát hành.

## 1. Thang đánh giá nguồn

- **P — Primary:** tài liệu chính thức của Apple, tác giả thuật toán, văn bản/cổng Chính phủ, repository/font upstream.
- **M — Marketplace:** App Store/product listing; hữu ích để biết tuyên bố và metadata hiện tại nhưng nội dung do nhà phát triển tự khai.
- **S — Secondary:** báo, nhà bán/in lịch, bài tổng hợp; hữu ích cho pattern thị trường, không dùng làm nguồn sự thật thuật toán/pháp lý.
- **U — User signal:** đánh giá công khai; có giá trị định tính nhưng không đại diện toàn bộ người dùng.

## 2. Lịch âm Việt Nam và thiên văn

### Hồ Ngọc Đức — Thuật toán tính âm lịch

- URL: https://www.xemamlich.uhm.vn/calrules.html
- Loại: P
- Dùng cho: quy luật Sóc, Trung khí, tháng 11, tháng nhuận, kinh tuyến 105° Đông/UTC+7, JDN, Can Chi.
- Lưu ý: tác giả nói thuật toán trình bày đã đơn giản hóa và kém chính xác hơn chương trình đầy đủ; trang sửa lần cuối 2008. Không coi đây là oracle duy nhất.

### Hồ Ngọc Đức — Vietnamese lunar calendar / VNCal

- URL: https://www.xemamlich.uhm.vn/vncal.html
- Loại: P
- Dùng cho: khác biệt lịch hiện đại/lịch lịch sử, miền Bắc–miền Nam 1968–1975, Việt Nam–Trung Quốc, phạm vi bản JavaScript 1800–2199.
- Lưu ý: cần đối chiếu thêm nguồn lịch pháp định cho ngày trước 1976.

### Hồ Ngọc Đức — JavaScript calendar

- URL: https://www.xemamlich.uhm.vn/JavaScript/vncal_js.html
- Loại: P
- Dùng cho: tham khảo implementation/bảng 1800–2199 và oracle phát triển.
- Lưu ý: phải kiểm tra giấy phép cụ thể trước khi sao chép mã; tốt nhất chỉ dùng để đối chiếu nếu giấy phép không rõ.

### Hong Kong Observatory — Calendar discrepancies

- URL: https://www.hko.gov.hk/en/Observatorys-Blog/101741/Which-day-is-the-Tuen-Ng-Festival-for-this-year-2013
- Loại: P (cơ quan thiên văn)
- Dùng cho: giải thích vì sao thuật toán/chuẩn giờ khác nhau có thể làm lệch ngày Sóc, nhất là gần nửa đêm.
- Lưu ý: nói về lịch Trung Quốc/Hong Kong; dùng cho nguyên lý, không làm oracle lịch Việt.

### Timeanddate — Vietnam time zone

- URL: https://www.timeanddate.com/time/zone/vietnam
- Loại: S uy tín
- Dùng cho: xác nhận UTC+7 hiện tại và không DST.
- Lưu ý: khi cần claim pháp lý/lịch sử, ưu tiên văn bản tiêu chuẩn nhà nước.

## 3. Văn bản và ngày nghỉ

### Cơ sở dữ liệu văn bản pháp luật — Bộ luật Lao động 45/2019/QH14

- URL: https://vbpl.moj.gov.vn/TW/Pages/vbpq-thuoctinh.aspx?ItemID=139264
- Loại: P
- Dùng cho: căn cứ ngày nghỉ theo luật và Điều 112 tại phiên bản tương ứng.
- Lưu ý: kiểm tra hiệu lực/sửa đổi tại thời điểm release; không hard-code danh sách qua nhiều năm.

### Cổng Chính phủ — lịch nghỉ Quốc khánh 2026

- URL: https://xaydungchinhsach.chinhphu.vn/thong-bao-lich-nghi-le-quoc-khanh-2026-119260729092042494.htm
- Loại: P
- Dùng cho: ví dụ khác biệt ngày nghỉ theo luật và lịch bố trí/hoán đổi cho từng nhóm.

### Cổng Chính phủ — ngày nghỉ năm 2026 và Ngày Văn hóa Việt Nam

- URL: https://xaydungchinhsach.chinhphu.vn/lich-nghi-le-quoc-khanh-2-9-va-ngay-van-hoa-viet-nam-24-11-2026-119260504103718299.htm
- Loại: P
- Dùng cho: bằng chứng rằng tập ngày nghỉ có thể thay đổi, cần data pack theo năm.
- Lưu ý: trước phát hành phải dẫn trực tiếp nghị quyết/văn bản gốc nếu dùng làm dữ liệu chính thức.

## 4. Apple — thiết kế, accessibility và nền tảng

### Human Interface Guidelines — Accessibility

- URL: https://developer.apple.com/design/human-interface-guidelines/accessibility
- Loại: P
- Dùng cho: Dynamic Type/custom scaling, cỡ chữ, tương phản, VoiceOver, không dựa một phương thức cảm nhận.

### Human Interface Guidelines — Typography

- URL: https://developer.apple.com/design/human-interface-guidelines/typography
- Loại: P
- Dùng cho: custom font vẫn phải dễ đọc và phản ứng với cỡ chữ/accessibility.

### Human Interface Guidelines — Playing haptics

- URL: https://developer.apple.com/design/human-interface-guidelines/playing-haptics
- Loại: P
- Dùng cho: haptic có quan hệ nhân–quả, nhất quán, bổ trợ và không lạm dụng.

### Core Haptics

- URL: https://developer.apple.com/documentation/corehaptics
- Loại: P
- Dùng cho: pattern transient/continuous, intensity/sharpness, AHAP.

### SwiftUI Canvas

- URL: https://developer.apple.com/documentation/swiftui/canvas
- Loại: P
- Dùng cho: custom drawing và giới hạn: không có interactivity/accessibility cho từng phần tử Canvas.

### SwiftUI Drawing and graphics

- URL: https://developer.apple.com/documentation/swiftui/drawing-and-graphics
- Loại: P
- Dùng cho: shapes, effects, Canvas và custom rendering.

### SwiftUI layerEffect

- URL: https://developer.apple.com/documentation/swiftui/view/layereffect%28_%3Amaxsampleoffset%3Aisenabled%3A%29
- Loại: P
- Dùng cho: đánh giá page deformation bằng shader.

### WidgetKit — TimelineProvider

- URL: https://developer.apple.com/documentation/widgetkit/timelineprovider
- Loại: P
- Dùng cho: timeline entries, refresh policy và ngân sách refresh.

### WidgetKit — Keeping a widget up to date

- URL: https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date/
- Loại: P
- Dùng cho: chuẩn bị dữ liệu trước và reload đúng lúc.

### UserNotifications — UNCalendarNotificationTrigger

- URL: https://developer.apple.com/documentation/usernotifications/uncalendarnotificationtrigger
- Loại: P
- Dùng cho: local notification theo thành phần ngày/giờ.

### EventKit — Accessing Calendar

- URL: https://developer.apple.com/documentation/eventkit/accessing-calendar-using-eventkit-and-eventkitui
- Loại: P
- Dùng cho: iOS 17+ write-only/full access và luồng editor không cần app đọc lịch.

### SwiftData/Core Data + App Group sample

- URL: https://developer.apple.com/documentation/CoreData/adopting-swiftdata-for-a-core-data-app
- Loại: P
- Dùng cho: chia sẻ store giữa app và widget qua App Group.

### App Review Guidelines

- URL: https://developer.apple.com/app-store/review/guidelines/
- Loại: P
- Dùng cho: minimum functionality, metadata, privacy, data minimization và quảng cáo.

### Apple Developer Program

- URL: https://developer.apple.com/programs/whats-included/
- URL bổ sung: https://developer.apple.com/support/compare-memberships/
- Loại: P
- Dùng cho: phí 99 USD/năm, khả năng tài khoản miễn phí, fee waiver có điều kiện.

### App Store Connect — Manage app privacy

- URL: https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy/
- Loại: P
- Dùng cho: Privacy Policy URL và khai “không thu thập”/data practices.

### SwiftUI — accessibilityReduceMotion

- URL: https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/accessibilityReduceMotion
- Loại: P
- Dùng cho: phát hiện Reduce Motion; tránh animation lớn/giả lập chiều sâu và chọn static/crossfade fallback.

### App Store Connect — Reduced Motion evaluation criteria

- URL: https://developer.apple.com/help/app-store-connect/manage-app-accessibility/reduced-motion-evaluation-criteria
- Loại: P
- Dùng cho: đánh giá parallax, multi-axis/ongoing motion, thay thế chuyển động trang trí bằng fade/highlight/color shift.

### Apple — Flashing lights

- URL: https://developer.apple.com/documentation/MediaAccessibility/flashing-lights
- URL bổ sung: https://developer.apple.com/documentation/swiftui/environmentvalues/accessibilitydimflashinglights
- Loại: P
- Dùng cho: Dim Flashing Lights và fallback riêng cho cảnh pháo hoa/chớp sáng.

### Apple — Responding to power notifications

- URL: https://developer.apple.com/documentation/xcode/responding-to-power-notifications
- Loại: P
- Dùng cho: giảm display updates/animation ở Low Power Mode và thermal serious/critical.

### Apple — Bringing SceneKit projects to RealityKit

- URL: https://developer.apple.com/documentation/realitykit/bringing-your-scenekit-projects-to-realitykit
- Loại: P
- Dùng cho: lựa chọn RealityKit cho đạo cụ 3D nhỏ và USD làm định dạng nội dung ưu tiên trên nền tảng Apple.

## 5. Font và giấy phép

### Be Vietnam Pro

- URL: https://github.com/bettergui/BeVietnamPro
- Loại: P (upstream)
- Giấy phép: OFL-1.1 theo repository.
- Dùng cho: UI, nhãn, số ngày; typeface do đội ngũ Việt thiết kế và xử lý dấu tiếng Việt.

### EB Garamond trong Google Fonts

- URL: https://github.com/google/fonts/blob/main/ofl/ebgaramond/METADATA.pb
- Loại: P (distribution upstream Google Fonts)
- Giấy phép: OFL; metadata ghi subset Vietnamese.
- Dùng cho: nội dung văn hóa/quote.

### Bitter trong Google Fonts

- URL: https://github.com/google/fonts/blob/main/ofl/bitter/METADATA.pb
- Loại: P
- Giấy phép: OFL; metadata ghi subset Vietnamese.
- Dùng cho: phương án serif màn hình dễ đọc hơn.

## 6. App Store — đối thủ và tín hiệu người dùng

### Lịch Việt — Lich Viet JSC

- URL: https://apps.apple.com/vn/app/l%E1%BB%8Bch-v%E1%BA%A1n-ni%C3%AAn-2026-l%E1%BB%8Bch-vi%E1%BB%87t/id585253443
- Loại: M + U
- Dùng cho: bề rộng tính năng, quảng cáo/gói dịch vụ trong history, widget/Watch, App Privacy tự khai.

### Vạn Niên Lịch

- URL: https://apps.apple.com/vn/app/v%E1%BA%A1n-ni%C3%AAn-l%E1%BB%8Bch/id1616628435
- Loại: M + U
- Dùng cho: giá Premium tại mốc khảo sát, breadth, nhận xét giao diện và lỗi nội dung.

### Lịch Vạn Niên — Phan Hanh

- URL: https://apps.apple.com/vn/app/id1071624317
- URL review: https://apps.apple.com/vn/app/id1071624317?platform=iphone&see-all=reviews
- Loại: M + U
- Dùng cho: quy mô category tại lát cắt, IAP bỏ quảng cáo, review về quảng cáo và thử nghiệm Pomodoro/nhạc nền trong version history.
- Lưu ý: rating count không phải active users; review tự chọn không đại diện dân số.

### Lịch Vạn Niên Việt — Lịch 2026

- URL: https://apps.apple.com/vn/app/l%E1%BB%8Bch-v%E1%BA%A1n-ni%C3%AAn-vi%E1%BB%87t-l%E1%BB%8Bch-2026/id6757463234
- Loại: M + U
- Dùng cho: reminder, widget, Siri, offline, IAP pricing.

### Âm Lịch VN

- URL: https://apps.apple.com/vn/app/%C3%A2m-l%E1%BB%8Bch-vn/id1661259378
- Loại: M + U
- Dùng cho: giá trị của lightweight/no ads và yêu cầu widget/reminder từ đánh giá.

### A Lịch Việt

- URL: https://apps.apple.com/vn/app/a-l%E1%BB%8Bch-vi%E1%BB%87t-l%E1%BB%8Bch-h%C3%A0ng-ng%C3%A0y/id1439040335?l=vi
- Loại: M + U
- Dùng cho: no-ads claim, nhu cầu chữ/lịch tháng cho người lớn tuổi và tùy biến widget.

### Lịch Việt Full

- URL: https://apps.apple.com/vn/app/l%E1%BB%8Bch-vi%E1%BB%87t-full/id6769069192
- Loại: M + U
- Dùng cho: đối thủ trực tiếp về free/no ads/offline, sơn mài/lịch bloc và xử lý ngày lễ mới.

### Lịch Việt: Lịch Âm, Vạn Niên

- URL: https://apps.apple.com/vn/app/l%E1%BB%8Bch-vi%E1%BB%87t-l%E1%BB%8Bch-%C3%A2m-v%E1%BA%A1n-ni%C3%AAn/id6758592547
- Loại: M + U
- Dùng cho: UX nhắc âm lịch, leap-month options, widget/privacy claims và độ rộng feature.

### Lunar Xinh

- URL: https://apps.apple.com/vn/app/lunar-xinh-lunar-calendar/id6759712122?platform=ipad
- Loại: M
- Dùng cho: art direction mặt trăng/ánh sáng, offline, widget và IAP.

### vLunar

- URL: https://apps.apple.com/vn/app/id1531851878
- Loại: M + U
- Dùng cho: giao diện gọn/hiện đại, widget, Watch, event, GMT+7 claim và tín hiệu review “đẹp, tiện”.
- Lưu ý: metadata, IAP và review không cho biết tuổi, retention hoặc hành vi thực tế.

### Lịch Âm Việt Nam Lunar

- URL: https://apps.apple.com/vn/app/id6477778908
- Loại: M + U
- Dùng cho: widget/Lock Screen/Watch, reminder âm lịch và version history về tháng nhuận/ngày 30.

## 7. Lịch bloc vật lý

### Thế Giới In Ấn — nội dung lịch bloc

- URL: https://thegioiinan.com/faq/648/tong-hop-mau-lich-bloc-2026-dep-nhat-nhan-in-tu-1-cuon-tro-len.html
- Loại: S (nhà in)
- Dùng cho: cấu trúc 365/366 tờ và các trường thường có: dương/âm, Can Chi, tiết khí, giờ, sự kiện, danh ngôn, minh họa.

### Thế Giới Lịch Xuân — mẫu bloc siêu đại

- URL: https://thegioilichxuan.vn/bloc-sieu-dai-ha-noi-thu-phap.html
- Loại: S (nhà bán)
- Dùng cho: khánh/áo/ruột/hộp, ốc, giấy 64 gsm, kích thước 20 × 30 cm.

### FAHASA — bloc Đại Việt Á

- URL: https://www.fahasa.com/2026-dva24-bloc-dai-dac-biet-17x24-viet-nam-tuoi-dep-bloc-mang-co-2-oc-am-duong.html
- Loại: S (nhà bán sách)
- Dùng cho: giấy ruột 60 gsm, ốc âm dương, nội dung/sự hiện diện trong không gian nhà.

### Thanh Niên — lịch bloc 2014

- URL: https://thanhnien.vn/lich-bloc-2014-da-dang-mau-ma-185387933.htm
- Loại: S (báo)
- Dùng cho: bằng chứng lịch bloc lâu nay kết hợp tiện ích nội dung, chất liệu và hình thức.

## 8. Framework thay thế

### Flutter — Impeller

- URL: https://docs.flutter.dev/perf/impeller
- Loại: P
- Dùng cho: đánh giá renderer hiện tại của Flutter trên iOS.

### React Native Skia — Canvas

- URL: https://shopify.github.io/react-native-skia/docs/canvas/overview/
- Loại: P
- Dùng cho: khả năng custom 2D renderer/high bit depth.

### React Native — Accessibility

- URL: https://reactnative.dev/docs/accessibility.html
- Loại: P
- Dùng cho: VoiceOver/TalkBack, custom actions và khác biệt nền tảng.

### Godot — Exporting for iOS

- URL: https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html
- Loại: P
- Dùng cho: yêu cầu macOS/Xcode, export workflow, renderer/plugin considerations.

## 9. Biểu tượng quốc gia

### Quốc hội — Hiến pháp 2013, Điều 13

- URL: https://quochoi.vn/content/tintuc/Lists/News/Attachments/30174/Hien%20phap%202013.pdf
- Loại: P
- Dùng cho: đặc điểm Quốc kỳ — hình chữ nhật, chiều rộng bằng hai phần ba chiều dài, nền đỏ, sao vàng năm cánh ở giữa — và ngày Quốc khánh 2/9.
- Lưu ý: đặc tả animation còn cần review văn hóa/frame-by-frame; không giao AI tự dựng hoặc biến dạng biểu tượng ngoài kiểm soát.

## 10. Rodin, ElevenLabs và asset tạo sinh

### Hyper3D — Rodin Gen-2.5 API

- URL: https://docs.hyper3d.ai/en/api-specification/rodin-gen2-5
- Loại: P (tài liệu nhà cung cấp)
- Dùng cho: luồng Image-to-3D, số ảnh tham chiếu, quy tắc ảnh vật liệu, GLB/USDZ/FBX/OBJ/STL, PBR/Shaded/Hybrid, preset face count, texture và output controls.
- Quyết định của dự án: chỉ dùng ảnh tham chiếu đã duyệt qua Image-to-3D; không dùng Text-to-3D hoặc prompt chữ làm đầu vào duy nhất.
- Lưu ý: preset dịch vụ không phải performance budget iOS; model phải cleanup, LOD/bake và profile.

### Hyper3D — Pricing và Terms

- URL: https://hyper3d.ai/pricing?lang=en
- URL bổ sung: https://hyper3d.ai/legal/terms
- Loại: P (tuyên bố/điều khoản nhà cung cấp)
- Dùng cho: export và commercial/private use phụ thuộc plan/điều khoản hiện hành; nghĩa vụ sở hữu quyền đối với prompt/reference.
- Lưu ý: lưu bằng chứng plan/Terms tại thời điểm tạo/xuất và kiểm lại trước release; không coi output AI là mặc nhiên độc quyền/không xâm phạm.

### Hyper3D — Rodin API Data Retention Policy

- URL: https://docs.hyper3d.ai/en/legal/data-retention-policy
- Loại: P
- Dùng cho: chính sách API hiệu lực 03/08/2026: payload/output giữ 7 ngày trên active systems, không dùng train, không public vào Assets, không chia cho người dùng khác.
- Lưu ý: chỉ áp dụng Rodin API theo chính trang; không suy rộng sang mọi UI/sản phẩm Hyper3D.

### ElevenLabs — Sound Effects

- URL: https://elevenlabs.io/docs/overview/capabilities/sound-effects
- URL API: https://elevenlabs.io/docs/api-reference/text-to-sound-effects/convert
- Loại: P (tài liệu nhà cung cấp)
- Dùng cho: Foley/ambient từ prompt, duration/looping, giới hạn 30 giây và output MP3/WAV được công bố.

### ElevenLabs — quyền xuất bản và điều khoản

- URL: https://help.elevenlabs.io/hc/en-us/articles/13313564601361-Can-I-publish-the-content-I-generate-on-the-platform
- URL Terms: https://elevenlabs.io/terms-of-use
- URL Prohibited Use Policy: https://elevenlabs.io/use-policy
- Loại: P (tuyên bố/điều khoản nhà cung cấp)
- Dùng cho: gói free không có commercial license; paid plan có commercial license nếu không dùng Beta theo điều kiện; cấm khai thác Sound Effects output ở dạng file/thư viện âm thanh độc lập.
- Lưu ý: coi phát hành app là production distribution; lưu plan, ngày tạo, trạng thái Beta, prompt/output và Terms snapshot cho từng asset.

## 11. Âm nền và an toàn nghe

### Apple — Playing audio và Ambient category

- URL: https://developer.apple.com/design/human-interface-guidelines/playing-audio
- URL kỹ thuật: https://developer.apple.com/documentation/avfaudio/avaudiosession/category-swift.struct/ambient
- Loại: P
- Dùng cho: audio không thiết yếu nên tôn trọng Ring/Silent; category `ambient` trộn với audio khác và không chạy khi khóa màn hình.
- Lưu ý: nền tự phát của Lịch Nhà chỉ chạy ở tiền cảnh và phải có nút tắt trực tiếp.

### Apple — Secondary audio hint

- URL: https://developer.apple.com/documentation/avfaudio/avaudiosession/secondaryaudioshouldbesilencedhint
- Loại: P
- Dùng cho: nhận biết audio chính không trộn được từ ứng dụng khác và tắt âm nền phụ.

### JAACAP — white/pink noise và attention

- URL: https://pubmed.ncbi.nlm.nih.gov/38428577/
- DOI: 10.1016/j.jaac.2023.12.014
- Loại: P (systematic review và meta-analysis; 13 nghiên cứu, 335 người ở phân tích ADHD/elevated symptoms)
- Dùng cho: lợi ích nhỏ ở trẻ em/người trẻ có ADHD hoặc triệu chứng chú ý cao; kết quả âm ở nhóm đối chứng không ADHD.
- Lưu ý: không dùng để quảng cáo Hiên sớm như công cụ tăng tập trung, điều trị hoặc phù hợp với mọi người.

### WHO — Safe listening

- URL: https://www.who.int/news-room/questions-and-answers/item/deafness-and-hearing-loss-safe-listening
- Loại: P (hướng dẫn sức khỏe công cộng)
- Dùng cho: mức nghe trung bình dưới 80 dB, ảnh hưởng của cường độ/thời lượng và nguyên tắc không tự tăng volume.
- Lưu ý: app không thể suy ra chính xác dB tại tai chỉ từ mức gain của file; cần tránh tuyên bố an toàn tuyệt đối.

## 12. Nguồn bổ sung cho vòng nghiên cứu tổng hợp

### Quyết định 134/2002/QĐ-TTg

- URL: https://vbpl.vn/TW/Pages/vbpq-toanvan.aspx?ItemID=21982
- Loại: P
- Dùng cho: múi giờ thứ 7 là giờ chính thức của Việt Nam; thay nguồn phổ thông ở quyết định Calendar Core.

### Bản tin VAST 02/2019

- URL: https://isdi.vast.vn/bantin/BantinKHCN022019.pdf
- Loại: P/S (cơ quan khoa học và ý kiến chuyên gia)
- Dùng cho: Sóc, Khí, tháng 29/30, tháng nhuận, biên gần nửa đêm và giới hạn dữ liệu lịch đã được duyệt tại thời điểm bài viết.
- Lưu ý: không suy rộng phạm vi được duyệt lúc đó thành chứng nhận chính thức cho 1900–2100.

### Hong Kong Observatory — 24 tiết khí

- URL: https://www.hko.gov.hk/en/gts/time/24solarterms.htm
- URL thời điểm theo năm: https://www.hko.gov.hk/en/gts/astronomy/Solar_Term.htm
- Loại: P
- Dùng cho: 24 phần 15°, Trung khí và oracle thời điểm.
- Lưu ý: bảng HKO dùng UTC+8; phải đổi sang UTC+7 trước khi đối chiếu ngày Việt Nam.

### Sắc lệnh số 5 về Quốc kỳ

- URL: https://vbpl.vn/TW/Pages/vbpq-print.aspx?ItemID=819
- Loại: P
- Dùng cho: tỷ lệ cờ, tâm và bán kính đỉnh lồi/góc lõm của sao.
- Lưu ý: văn bản không cho mã sRGB/hex; màu số là master asset do dự án duyệt.

### Nghị định 137/2020/NĐ-CP

- URL: https://vbpl.vn/TW/Pages/vbpq-toanvan.aspx?ItemID=146476
- Loại: P
- Dùng cho: căn cứ dùng pháo hoa như liên tưởng dịp 2/9.
- Lưu ý: địa phương quyết định theo thực tế; không nói mọi nơi đều bắn.

### Báo Giác Ngộ — giỗ trong năm nhuận

- URL: https://m.giacngo.vn/cung-tieu-tuong-va-huy-nhat-vao-nam-nhuan-post76652.html
- Loại: S
- Dùng cho: một thông lệ trong bối cảnh Phật giáo về tháng trùng tên.
- Lưu ý: không coi là phong tục phổ quát; chưa có nguồn đủ mạnh cho ngày 30 tháng thiếu.

### IANA time-zone database

- URL: https://data.iana.org/time-zones/tz-link.html
- Loại: P cho triển khai
- Dùng cho: lưu timezone ID và xử lý DST của notification/ngày dân sự.
- Lưu ý: không trả lời preference của người Việt ở nước ngoài.

### Nielsen Norman Group — Synthetic Users

- URL: https://www.nngroup.com/articles/synthetic-users/
- Loại: S
- Dùng cho: synthetic users hỗ trợ hypothesis/desk research nhưng không thay dữ liệu người thật hay quyết định cuối.

### Whose Personae? Synthetic Persona Experiments in LLM Research

- URL: https://ojs.aaai.org/index.php/AIES/article/download/36553/38691/40628
- Loại: P (review 63 nghiên cứu)
- Dùng cho: yêu cầu minh bạch về task/population, empirical grounding, ecological validity, reproducibility và generalizability.

### De Paoli — User personas, ideation and large language models

- URL DOI: https://doi.org/10.1016/j.ijhcs.2025.103690
- URL bản tác giả: https://rke.abertay.ac.uk/ws/files/101920220/DePaoli_UserPersonas_Published_2025.pdf
- Loại: P
- Dùng cho: LLM hỗ trợ ideation dưới giám sát; nguy cơ bias, stereotype và factual error.
- Lưu ý: nghiên cứu dùng 26 phỏng vấn thật làm đầu vào; panel KVCalendar yếu hơn vì chưa có transcript.

### Bối cảnh người trẻ và truyền thống

- URL DataReportal: https://datareportal.com/reports/digital-2025-vietnam
- URL UNICEF: https://www.unicef.org/innocenti/media/4181/file/DH-Viet-Nam-Report-2022.pdf
- URL Q&Me: https://qandme.net/vi/baibaocao/ky-vong-cua-nguoi-viet-vao-dip-tet-2022.html
- Loại: S
- Dùng cho: bối cảnh sử dụng internet/smartphone và ý nghĩa gia đình–phong tục.
- Lưu ý: không chứng minh nhu cầu iOS, lịch âm, pastel, hiệu ứng hoặc bóc lịch của nhóm 16–34.

## 13. Nguồn không được dùng làm “sự thật”

- kết quả tìm kiếm hình ảnh;
- bài SEO “xem ngày tốt” không nêu phương pháp;
- app đối thủ tự nhận “chính xác nhất”;
- đánh giá đơn lẻ;
- Wikipedia cho ngày nghỉ/pháp luật hiện hành;
- lịch Trung Quốc dùng UTC+8 để kiểm tra lịch Việt;
- một thư viện GitHub không rõ test/license/maintenance;
- văn bản pháp luật cũ đã hết hiệu lực.

## 14. Việc cần bổ sung trước phát hành (không còn chặn T021)

- nguồn lịch pháp định Việt Nam cho các mốc 1900–1975;
- chuyên gia độc lập cho ruleset hoàng đạo (T018 đã có owner, chưa có chuyên gia);
- văn bản gốc mới nhất cho từng data pack ngày nghỉ;
- danh mục ca dao/tục ngữ cùng xác nhận tình trạng quyền;
- test oracle độc lập thứ hai và golden corpus (T044–T047);
- thống kê thiết bị/iOS của nhóm người dùng mục tiêu;
- kiểm tra khả dụng tên “Lịch Nhà” và tra cứu nhãn hiệu;
- license review trước khi nhúng mã thuật toán, font hoặc artwork;
- cultural review Quốc kỳ, ngày trang nghiêm, hình ảnh tín ngưỡng;
- xác nhận quyền thương mại Rodin/ElevenLabs trước khi ship;
- blind test Hiên sớm/Mưa xa/im lặng (T010/Gate 7A vẫn mở).

## 15. Nguồn lịch truyền thống (T018, 08/09/2026)

### Hiệp Kỷ Biện Phương Thư

- URL: http://chinaknowledge.de/Literature/Daoists/xiejibianfangshu.html
- Loại: P/S (mục lục Tứ Khố, không phải nguyên văn đủ 36 quyển)
- Dùng cho: khung năm hoàn thành 1739, giám tu, vai trò chuẩn hóa lịch chú.
- Lưu ý: bản dịch Nxb. Mũi Cà Mau 2002 còn bản quyền; không copy lời dịch.

### Nguyễn Công Việt — Nhị thập bát tú trong lịch pháp Hán Nôm

- URL: https://nghiencuulichsu.com/2016/08/10/so-luoc-ve-nhi-thap-bat-tu-trong-tai-lieu-lich-phap-han-nom/
- Loại: P (Tạp chí Hán Nôm số 1 (80), 2007)
- Dùng cho: phân biệt lịch pháp định triều Nguyễn và thông thư dân gian; Khâm thiên giám.
- Lưu ý: không biến Lịch Nhà thành lịch Khâm thiên giám.

### Tiểu Lục Nhâm / lục diệu

- URL: https://www.master-insight.com/article/32868
- Loại: S
- Dùng cho: gắn Gia Cát Lượng/Lý Thuần Phong là truyền thuyết; tên học thuật gần nhất là 小六壬.
- Lưu ý: không dùng làm oracle bảng giờ; chỉ để viết nhãn UI.

### Nguồn không dùng cho almanac

- bài SEO “xem ngày tốt” không nêu ấn bản;
- bảng Sát Chủ/Thọ Tử trên blog phong thủy khi các bảng lệch nhau;
- tuyên bố của app lịch thương mại.
