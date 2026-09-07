# Accessibility requirements review — Lịch Nhà

**Ngày**: 2026-09-07
**Loại tài liệu**: review yêu cầu và cognitive walkthrough trên hồ sơ
**Trạng thái**: `T013 NOT RUN` — `Gate 5A–5B UNTESTED`

## 1. Ranh giới của lượt review

Lượt này đối chiếu Design Master, spec, UI state contract, accessibility contract, effect contract,
quickstart và task plan. Nó kiểm xem requirement có đủ chỗ cho một giao diện custom hay chưa. Nó
không thao tác được VoiceOver trên app, không đo vùng chạm thật, không quan sát người 55+, không thử
Dynamic Type trên màn hình nhỏ và không kiểm cảm giác chuyển động.

Vì chưa có app hoặc functional prototype, mọi cột implementation/device/user đều là `NOT RUN`.
Tài liệu không thay `research/sessions/accessibility-summary.md` của T013, scorecard T144 hoặc báo
cáo Gate 5B ở T145.

Nguyên tắc giữ lại từ tra cứu UI/UX: tương tác kéo phải có cách hoàn thành không kéo. Với Lịch Nhà,
đó là button/accessibility action một chạm, không phải chỉ thêm hướng dẫn cách bóc tờ chính xác hơn.

## 2. Ma trận yêu cầu

| Khu vực | Yêu cầu đã viết | Khoảng trống cần đóng | Spec review | Implementation | Device/user |
|---|---|---|---|---|---|
| Tờ ngày | Summary gồm thứ/ngày dương, ngày âm, sự kiện/tiết khí; decoration ẩn khỏi tree | Chưa có chuỗi mẫu để kiểm cách VoiceOver đọc số, Can Chi và cờ tháng nhuận | `DOCUMENTED` | `NOT RUN` | `NOT RUN` |
| Thứ tự focus | Summary → Can Chi → nội dung phụ → action; overlay trở về state trước | Chưa nói focus đi đâu sau bóc ngày, lật mặt, đóng sheet và lỗi permission | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Bóc/vuốt | Có nút và accessibility action tương đương | Chưa kiểm discoverability, tên action và việc hai đường cho cùng selectedDate | `DOCUMENTED` | `NOT RUN` | `NOT RUN` |
| Vùng chạm | Tối thiểu 44 × 44 pt, focus rõ | Chưa có layout thật để đo, nhất là góc bóc, nút loa và ô ngày nhỏ | `DOCUMENTED` | `NOT RUN` | `NOT RUN` |
| Picker custom | Dải giấy/bộ số phải có adjustable semantics và đọc giá trị đầy đủ | Chưa có contract cho increment/decrement, min/max và lỗi ngày không hợp lệ | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Dynamic Type | 200%, reflow; thông tin phụ chuyển mặt sau trước khi giảm cỡ ngày | “200%” chưa được map sang content-size categories và màn hình support matrix | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Contrast/transparency | Nền đặc dưới chữ, giảm texture, tăng biên, không dùng màu làm tín hiệu duy nhất | Chưa có token/cặp màu đo ở normal, dark và increased contrast | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Reduce Motion | Curl/parallax/rơi/xoáy đổi thành dissolve/poster; action vẫn đủ nghĩa | Chưa có tiêu chí focus/announcement khi animation bị bỏ | `DOCUMENTED` | `NOT RUN` | `NOT RUN` |
| Dim Flashing Lights | Pháo hoa có phiên bản không flash, không chỉ hạ opacity | Storyboard chưa phải kiểm tra luminance/flash trên thiết bị | `DOCUMENTED` | `NOT RUN` | `NOT RUN` |
| Low Power/thermal | Hạ particle/LOD rồi poster, không giảm độ đọc | Không thuộc Gate 5 riêng nhưng phải phối hợp với accessibility state | `DOCUMENTED` | `NOT RUN` | `NOT RUN` |
| Âm thanh | Không là kênh duy nhất; VoiceOver chặn auto-start; tắt trong một thao tác | Chưa có thông báo trạng thái cho VoiceOver khi bật/tắt/fade; audio runtime chưa tồn tại | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Haptic | Không là kênh thông tin duy nhất | Chưa nói phản hồi thay thế khi haptic tắt/không hỗ trợ | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Month sheet | Ô ngày activate được, quay lại đúng ngữ cảnh | Chưa có thứ tự đọc theo tuần, nhãn ngày ngoài tháng, selected/today state | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Event editor | Label/state/hint; policy được đọc lại bằng tiếng Việt | Chưa có error summary, focus vào lỗi đầu, cách đọc ngày âm nhuận/ngày 30 | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Widget | Nội dung tối thiểu, deep link và privacy | Accessibility label, reading order, tinted/high-contrast state chưa có trong contract | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Nguồn/phương pháp | Tìm trong hai thao tác; version và nhãn tham khảo | Chưa kiểm heading/group navigation và mức dài có gây quá tải đọc | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Failure states | Lịch chính còn đọc được; pack lỗi dùng poster; permission không chặn lưu | Chưa có announcement, focus recovery và câu lỗi cụ thể | `PARTIAL` | `NOT RUN` | `NOT RUN` |
| Input thay thế | Semantics cho button/switch/picker đã nêu | Chưa có explicit pass cho Voice Control, Switch Control hoặc keyboard access nơi phù hợp | `PARTIAL` | `NOT RUN` | `NOT RUN` |

`DOCUMENTED` chỉ có nghĩa requirement đã xuất hiện trong hồ sơ. Nó không phải pass accessibility.

## 3. Findings

| ID | Mức | Phát hiện | Hành động trước khi triển khai/ship |
|---|---|---|---|
| AX-01 | `HIGH` | Accessibility contract chặn release khi US1–US3 thất bại, trong khi SC-007 nói mọi tác vụ cốt lõi và T131 dự kiến US1–US4. Scenario F còn gồm tạo event và tắt âm. | Lập một danh sách core tasks duy nhất. Dùng cùng danh sách cho contract, UI tests, vòng người dùng và release gate. |
| AX-02 | `HIGH` | T013 là vòng trước code; T145 là verification trên build. Cả hai đang được gọi bằng Gate 5 mà không phân biệt mức bằng chứng. | Đặt tên `Gate 5 research` và `Gate 5 release`, hoặc hai checkpoint tương đương. Cả hai hiện `NOT RUN`; vòng sớm không ký thay vòng release. |
| AX-03 | `HIGH` | UI dùng component custom nên hình thức có thể tách khỏi semantics: con dấu, chốt gỗ, dải giấy và tờ lịch không tự mang role/value/action đúng. | Mỗi component cần semantic contract và test riêng; giữ control/text native làm lớp tương tác dù renderer custom. |
| AX-04 | `MEDIUM` | Focus sau chuyển ngày, mở/đóng mặt sau, sheet, drawer và permission dialog chưa được quy định. | Thêm focus destination và announcement cho từng transition; không để focus quay về phần tử đã biến mất. |
| AX-05 | `MEDIUM` | Large Text mới nói “200%” và thứ tự cắt nội dung, chưa chỉ rõ các Accessibility Size thực tế hoặc màn hình nhỏ nhất. | T019 chốt support matrix; test mọi named size cần hỗ trợ, portrait nhỏ nhất và chuỗi tiếng Việt dài. Không coi snapshot một cỡ là đủ. |
| AX-06 | `MEDIUM` | Month sheet và picker âm lịch chưa có đầy đủ selected/today/leap/invalid semantics. | Định nghĩa label, value, selected state, adjustable actions, wrap behavior và error message trước T070/T084. |
| AX-07 | `MEDIUM` | Reduce Motion/Dim Flashing Lights đã có fallback concept nhưng chưa có tiêu chí đo flash, focus và độ đọc khi scene đổi tier. | T133 dùng golden frame chỉ như một lớp; vẫn cần kiểm trên thiết bị và walkthrough với người nhạy chuyển động. |
| AX-08 | `MEDIUM` | Widget chưa nằm trong accessibility release contract dù là User Story độc lập. | Quyết định rõ widget thuộc core task; thêm label/order/contrast/privacy check ở T100–T105 và T145 nếu có. |
| AX-09 | `MEDIUM` | Âm thanh có policy thận trọng nhưng chưa có semantic feedback cho trạng thái Yên/đang phát/bị hệ thống chặn. | Nút loa phải đọc label, value và lý do không phát khi hữu ích; không phát cue chỉ để báo thành công. Gate 7A–7B vẫn `UNTESTED`. |
| AX-10 | `LOW` | Chuỗi ngày, Can Chi, tiết khí và tên tháng dài có rủi ro phát âm/ngắt cụm không tự nhiên. | T146 audit trên VoiceOver tiếng Việt và lưu danh sách pronunciation issue; không sửa bằng cách biến text thành ảnh. |

## 4. Walkthrough dự đoán, không phải usability result

| Tác vụ | Đường semantic dự kiến | Điều phải quan sát ở T013/T145 | Trạng thái |
|---|---|---|---|
| Đọc hôm nay | Focus vào summary tờ ngày, sau đó đọc chi tiết theo nhu cầu | Có hiểu dương/âm và tháng nhuận không; summary có quá dài không | `UNTESTED` |
| Sang ngày kế | Action “Ngày kế” hoặc nút tương đương | Action có dễ tìm; focus và announcement chuyển đúng ngày | `UNTESTED` |
| Về hôm nay | Nút Hôm nay một thao tác | Có được đọc disabled khi đã ở hôm nay; không phụ thuộc curl | `UNTESTED` |
| Mở tháng và chọn ngày | Nút Xem tháng → grid có nhãn đầy đủ → activate | Thứ tự tuần, state hôm nay/đã chọn và ngày ngoài tháng | `UNTESTED` |
| Xem nguồn | Xem chi tiết → nhóm tham khảo → nguồn/phương pháp | Có tìm trong hai thao tác mà không phải nghe toàn bài trước | `UNTESTED` |
| Tạo ngày giỗ | Editor → lịch âm → policy → câu đọc lại → lưu | Cờ nhuận/ngày 30 dễ hiểu; lỗi đưa focus đúng; permission denial không làm tưởng mất event | `UNTESTED` |
| Tắt âm | Nút loa/toggle một thao tác | Label/value đổi ngay; không cần nghe âm để biết trạng thái | `UNTESTED` |
| Dùng cảnh giảm hiệu ứng | System setting đã bật trước khi mở ngày | Poster giữ sắc thái; không có flash/curl cưỡng bức; ngày vẫn đọc trước scene | `UNTESTED` |
| Mở từ widget | Widget label → deep link đúng ngày | Lock-screen privacy và focus trong app sau deep link | `UNTESTED` |

Không được chuyển bất kỳ dòng nào sang pass từ cognitive walkthrough này.

## 5. Bộ bằng chứng tối thiểu cho T013

T013 cần một prototype có thể thao tác ở mức phù hợp, không chỉ ảnh tĩnh, cùng ghi chú ẩn danh từ
participant thật theo consent. Vòng này phải ít nhất kiểm:

- người dùng VoiceOver hoàn thành đọc hôm nay, đổi ngày, về hôm nay, mở tháng và tìm nguồn;
- người dùng chữ lớn hoàn thành cùng task trên iPhone dọc nhỏ mà không mất trường ngày chính;
- một luồng event âm gồm tháng nhuận/ngày 30 và notification denial;
- action không kéo cho mọi gesture bóc, lật và mở ngăn;
- Reduce Motion, Increase Contrast và Reduce Transparency trên cùng nội dung;
- khả năng tắt âm một thao tác mà không cần nghe để xác nhận;
- issue log cụ thể, mức nghiêm trọng, điều kiện tái hiện và quyết định sửa.

Nếu prototype vòng sớm chưa thể hiện widget, audio session hoặc custom control thật, ghi phạm vi đó
là `NOT RUN`; không suy ra pass từ storyboard. Người 55+ không thay participant dùng VoiceOver, và
một participant dùng VoiceOver cũng không đại diện cho mọi người khiếm thị.

## 6. Tiêu chí giữ Gate 5A–5B ở trạng thái hiện tại

Tại thời điểm viết:

- chưa có `research/sessions/accessibility-summary.md` với phiên người dùng thật;
- chưa có app để chạy VoiceOver, Dynamic Type, Reduce Motion hay Increase Contrast;
- chưa có support matrix đã chốt;
- chưa có test report T145 trên thiết bị mục tiêu.

Vì vậy `T013 NOT RUN`, `T144 NOT RUN`, `T145 NOT RUN` và `Gate 5A–5B UNTESTED`. Requirements review này
chỉ tạo backlog để vòng kiểm chứng thật có oracle rõ hơn; nó không mở khóa T020.

## 7. Follow-up trong đặc tả

Sau review, accessibility contract đã có một danh sách core tasks dùng chung; Gate 5 được tách thành
5A trước code và 5B trên build; T131/T144/T145 cùng Large Text contract đã được đồng bộ. AX-01,
AX-02 và phần requirement của AX-05/AX-08/AX-09 được xử lý ở mức tài liệu. Các kết quả implementation,
device và user vẫn `NOT RUN`; không đổi trạng thái T013, T144, T145 hoặc Gate 5A–5B.
