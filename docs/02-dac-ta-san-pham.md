# 02 — Đặc tả sản phẩm

Phiên bản tài liệu: 0.1
Phạm vi: iPhone, bản đầu tiên
Tên làm việc: Lịch Nhà

## 1. Mục tiêu phiên bản 1.0

Trong lần mở đầu tiên, không cần tài khoản hay cấu hình, người dùng phải thấy ngay một tờ lịch đẹp và đọc được:

- thứ và ngày dương;
- ngày/tháng âm;
- tháng/năm dương;
- sự kiện hoặc tiết khí đáng chú ý;
- Can Chi hoặc một dòng thông tin lịch truyền thống ngắn là giả thuyết prototype; Gate 3 có thể
  chuyển chúng sang mặt sau trước khi giảm cỡ ngày chính.

Bản phát hành mặc định Yên cho tới khi Gate 7 có dữ liệu người thật. Khi người dùng chủ động chọn “Hiên sớm”, nền chỉ được fade in sau khi nội dung hiện, thiết bị không ở Silent, VoiceOver không bật và không có audio khác cần ưu tiên. Nút âm phải thấy và chạm được ngay, không giấu trong cài đặt.

Trong dưới hai phút, họ phải có thể:

- xem ngày khác;
- quay về hôm nay;
- mở lịch tháng;
- tạo một ngày giỗ/nhắc lịch âm;
- hiểu app miễn phí, offline và nguồn dữ liệu ở đâu.

## 2. Kiến trúc trải nghiệm

Không dùng tab bar mặc định. Ứng dụng có một “không gian lịch” duy nhất với các lớp vật thể:

| Lớp | Vai trò | Cách mở |
|---|---|---|
| Khánh lịch | Mốc năm/tháng, mở lịch tháng | Chạm phần đầu/miếng đồng tháng–năm |
| Tờ trước | Hôm nay hoặc ngày đang chọn | Chạm nội dung, vuốt/bóc góc |
| Mặt sau tờ | Chi tiết lịch và nguồn | Lật tờ hoặc chạm “Xem mặt sau” |
| Kẹp giấy bên phải | Sự kiện/nhắc của ngày | Chạm kẹp có số lượng |
| Ngăn giấy dưới | Đổi ngày, tìm, cài đặt, nguồn | Kéo thanh gỗ/giấy phía dưới |
| Tờ gấp tháng | Lưới tháng và danh sách sự kiện | Mở từ khánh hoặc ngăn giấy |

Mọi chức năng đều có nhãn đọc được bởi VoiceOver và có đường truy cập không phụ thuộc gesture ẩn.

## 3. Mô hình điều hướng

### Trạng thái gốc

“Hôm nay” luôn là gốc. Khi app được mở lại sau một ngày mới, nó tự về hôm nay, trừ khi người dùng đang ở giữa luồng soạn sự kiện chưa lưu.

### Nguyên tắc quay lại

- một thao tác đưa từ mặt sau về mặt trước;
- một thao tác đưa từ ngày bất kỳ về hôm nay;
- đóng tờ tháng trả về đúng ngày vừa chọn;
- đóng ngăn giấy không làm mất trạng thái;
- nút/gesture Back hệ thống vẫn hoạt động dù không được vẽ theo kiểu navigation bar mặc định.

### Deep link

Widget và thông báo mở đúng ngày/sự kiện liên quan. Luôn có dấu hiệu rõ “đang xem ngày khác” và nút “Về hôm nay”.

## 4. Màn hình và trạng thái

## 4.1. Tờ hôm nay

### Mục đích

Trả lời “hôm nay là ngày nào?” ngay lập tức và tạo cảm giác đang nhìn một tờ lịch vật lý.

### Thông tin mặt trước theo thứ tự

1. Thứ trong tuần.
2. Số ngày dương cực lớn.
3. Tháng và năm dương.
4. Ngày âm, gồm dấu “nhuận” khi có.
5. Can Chi ngày/tháng/năm ở dạng gọn nếu Gate 3 cho thấy còn đủ chỗ; nếu không, chuyển mặt sau.
6. Tiết khí hoặc ngày lễ/sự kiện nổi bật.
7. Giờ hoàng đạo chỉ xuất hiện nếu T018 duyệt ruleset; đặt ở mặt sau với nhãn “tham khảo”.
8. Một mẩu nội dung biên tập ngắn: ca dao, tục ngữ, kiến thức hoặc minh họa nguyên bản.
9. Không khí ngày nằm quanh/đằng sau tờ, không được chiếm một trường nội dung hay che các mục 1–8.

Nếu không đủ không gian ở cỡ chữ lớn, ưu tiên 1–4 và 6. Can Chi cùng nội dung 7–8 chuyển sang mặt sau; không giảm chữ xuống dưới ngưỡng đọc được.

### Hành động

- kéo góc dưới sang trái/lên để bóc sang ngày kế;
- vuốt phải để xem ngày trước;
- chạm giữa tờ để lật mặt sau;
- chạm tháng/năm để mở tháng;
- chạm kẹp ghi chú để xem/tạo sự kiện;
- chạm nút “Hôm nay” khi đang ở ngày khác;
- nhấn giữ tờ để mở menu hành động: chia sẻ, tạo nhắc, đi tới ngày.

### Trạng thái đặc biệt

- **Hôm nay chưa bóc:** mép tờ phẳng, bóng xấp giấy rõ.
- **Đã bóc:** tờ hôm nay không biến mất; app hiển thị trạng thái nghi thức, có thể xem lại trong chồng giấy cũ.
- **Đang xem tương lai:** không cho gọi hành động là “bóc”; dùng “lật xem” để tránh phá ẩn dụ.
- **Ngày lễ:** dấu son và một viền trang trọng, không biến toàn trang thành banner.
- **Rằm/mùng một:** biểu tượng pha trăng nhỏ cộng chữ; không chỉ dùng màu.
- **Offline:** không cần nhãn vì đây là trạng thái bình thường.

## 4.2. Động tác bóc tờ

### Chuỗi tương tác

1. Ngón tay chạm vùng góc/mép dưới: góc giấy nhấc 2–4 px, bóng thay đổi.
2. Kéo: tờ bám ngón tay, cong theo hướng kéo; tờ kế lộ ra đúng tỷ lệ.
3. Qua ngưỡng khoảng 42% chiều cao hoặc vận tốc đủ nhanh: tờ rời, mép xé rung rất nhẹ.
4. Chưa qua ngưỡng: giấy đàn hồi về vị trí cũ.
5. Hoàn tất: haptic mềm, âm giấy cực nhỏ nếu người dùng đã bật.
6. Trong khoảng ngắn sau đó có hành động “Hoàn tác”.

### Quy tắc

- animation hoàn tất mục tiêu 450–650 ms; không bắt người dùng chờ;
- âm giấy thuộc lớp phản hồi riêng và tắt mặc định; nền tập trung không gắn với thao tác bóc;
- chỉ một haptic khi hoàn tất, không rung liên tục theo ngón tay;
- Reduce Motion đổi thành trượt/crossfade ngắn, giữ nguyên ý nghĩa;
- VoiceOver có actions “Ngày trước”, “Ngày sau”, “Bóc tờ hôm nay”, “Xem chi tiết”.

## 4.3. Mặt sau — Chi tiết ngày

Mặt sau giống phần in nhỏ ở sau tờ hoặc một tờ chú giải, không giống form/card iOS.

### Nhóm thông tin

- **Lịch:** dương, âm, thứ, số ngày trong tháng âm, tháng nhuận.
- **Can Chi:** giờ hiện tại, ngày, tháng, năm; giải thích ngắn khi chạm.
- **Thiên văn:** tiết khí hiện tại và thời điểm chuyển tiết khi có dữ liệu.
- **Lịch truyền thống:** ngày hoàng/hắc đạo, các giờ, trực và thông tin khác nếu bộ dữ liệu được duyệt.
- **Ngày lễ/sự kiện:** phân biệt “ngày nghỉ chính thức”, “ngày kỷ niệm”, “lễ truyền thống”, “sự kiện cá nhân”.
- **Nguồn:** nút “Nguồn & cách tính”, phiên bản dữ liệu và ngày cập nhật.

### Ngôn ngữ bắt buộc

- Nội dung dân gian dùng “Theo lịch truyền thống…”, “Tham khảo…”, “Một số lịch ghi…”.
- Không dùng “chắc chắn”, “đảm bảo may mắn”, “xui xẻo”, “không được làm”.
- Nếu các trường phái khác nhau, trình bày khác biệt hoặc bỏ trường đó khỏi 1.0.

## 4.4. Tờ tháng

### Hình thức

Một tờ giấy gấp mở ra từ khánh lịch. Không dùng date picker mặc định làm giao diện chính. Lưới 7 cột vẫn giữ vì quen thuộc và hiệu quả.

### Nội dung mỗi ô

- ngày dương là số chính;
- ngày âm nhỏ ở góc, chỉ ghi tháng khi là mùng một hoặc chuyển tháng;
- chấm/ký hiệu khác hình cho ngày lễ, sự kiện cá nhân, rằm/mùng một;
- ngày ngoài tháng giảm độ đậm nhưng vẫn đọc được;
- ngày chọn có khung con dấu; hôm nay có dấu sợi chỉ/ghim riêng, không cùng một ký hiệu.

### Điều hướng

- vuốt ngang đổi tháng;
- chạm tên tháng mở “bánh xe năm” vẽ riêng;
- nút rõ “Hôm nay”;
- danh sách sự kiện tháng nằm dưới lưới, có thể kéo tờ dài xuống;
- cỡ chữ lớn chuyển sang tuần/danh sách thay vì ép 7 cột quá nhỏ.

## 4.5. Đổi ngày âm–dương

### Mục tiêu

Chọn một ngày ở một hệ lịch và thấy ngày tương ứng ở hệ kia, không cần hiểu tháng nhuận trước.

### Giao diện

Hai tờ giấy đặt cạnh/đè nhẹ lên nhau: “Dương lịch” và “Âm lịch”. Người dùng xoay ba trục ngày–tháng–năm bằng bộ số thiết kế riêng, nhưng vẫn có nhãn, focus và điều khiển accessibility chuẩn.

### Yêu cầu

- âm lịch phải có lựa chọn tháng thường/tháng nhuận khi năm đó có nhuận;
- ngày không tồn tại bị vô hiệu hóa kèm giải thích;
- kết quả hiển thị Can Chi và ngày trong tuần;
- một chạm để “Xem tờ ngày này” hoặc “Tạo nhắc”.

## 4.6. Ngày giỗ và sự kiện cá nhân

### Dữ liệu tối thiểu

- tên sự kiện;
- hệ lịch: dương hoặc âm;
- ngày, tháng, năm gốc tùy chọn;
- lặp: không, hằng năm, hằng tháng cho rằm/mùng một;
- giờ nhắc và khoảng báo trước;
- ghi chú tùy chọn;
- chính sách tháng nhuận;
- chính sách khi ngày 30 không tồn tại;
- trạng thái thông báo.

### Luồng tạo nhanh

1. Từ tờ ngày, chạm kẹp giấy.
2. Chọn một trong ba mẫu: “Ngày giỗ”, “Sinh nhật/kỷ niệm”, “Nhắc một lần”.
3. Ngày hiện tại được điền sẵn theo đúng hệ lịch của mẫu.
4. Chỉ hỏi những lựa chọn biên khi chúng thật sự có thể xảy ra.
5. Màn hình xác nhận viết bằng câu tự nhiên, ví dụ: “Nhắc ngày 12 tháng Tám âm lịch hằng năm, trước 3 ngày lúc 8:00”.
6. Sau khi người dùng bấm lưu mới xin quyền thông báo nếu chưa có.

### Tháng nhuận

Không âm thầm tự quyết. Các lựa chọn có giải thích:

- tháng thường hằng năm;
- chỉ tháng nhuận khi năm có tháng đó nhuận;
- cả tháng thường và tháng nhuận;
- nếu năm không có tháng nhuận: bỏ qua hoặc dùng tháng thường.

Mặc định cho ngày giỗ nhập từ tháng thường: chỉ tháng thường. Nếu ngày gốc được đánh dấu tháng nhuận, bắt buộc người dùng xác nhận chính sách.

### Ngày 30 của tháng thiếu

Cho chọn:

- nhắc ngày cuối tháng (gợi ý tiện dụng, không phải quy tắc phong tục);
- bỏ qua năm đó;
- nhắc mùng một tháng sau.

Ứng dụng phải lặp lại lựa chọn bằng câu tự nhiên trước khi lưu.

## 4.7. Nhắc rằm và mùng một

- công tắc riêng cho mùng một và rằm;
- báo đúng ngày hoặc trước 1–3 ngày;
- giờ do người dùng chọn;
- mặc định tắt, không tự xin quyền;
- không dùng ngôn ngữ gây sợ hãi hoặc tạo áp lực cúng lễ;
- toàn bộ lịch thông báo được tính trên thiết bị và được làm mới theo cửa sổ an toàn của iOS.

## 4.8. Widget

Widget không thể tái tạo mọi animation, nhưng phải nhận ra là cùng một sản phẩm.

### Small — Tờ hôm nay

- số ngày dương lớn;
- thứ/tháng;
- ngày âm;
- nền giấy và hai chấm “ốc đồng” tối giản.

### Medium — Bloc + sắp tới

- bên trái là tờ hôm nay;
- bên phải 2–3 sự kiện/nhắc gần nhất;
- không hiển thị ghi chú nhạy cảm khi người dùng bật chế độ riêng tư.

### Lock Screen

- inline: “T2 · 26/7 ÂL”;
- circular: số ngày dương và ngày âm nhỏ;
- rectangular: thứ, ngày dương, ngày âm, sự kiện gần nhất tùy chọn.

### Quy tắc

- chạm mở đúng ngày;
- chuẩn bị timeline ngày kế tiếp từ trước, không phụ thuộc mạng;
- cung cấp high-contrast rendering;
- không nhồi hoa văn gây mất đọc ở kích thước nhỏ.

## 4.9. Hệ “Không khí ngày”

- ngày hiện tại được phép tự chạy một hero intro 2–4 giây tối đa một lần/ngày;
- ngày khác chỉ hiện poster tĩnh, có action phát lại theo yêu cầu;
- resolver chỉ chọn một hero, một ambient và tối đa hai accent tĩnh khi nhiều sự kiện trùng;
- Quốc khánh, Tết, ngày trang nghiêm, tiết khí và sự kiện cá nhân có metadata sắc thái để không phối sai;
- hiệu ứng không chặn điều hướng, không làm chậm nội dung ngày và dịu ngay khi người dùng chạm tờ;
- 24 tiết khí dùng cue theo thời điểm chuyển tiết/múi giờ; artwork được ghi là cảm hứng mùa, không phải dự báo thời tiết;
- mỗi cue có intro, settle, idle, static poster, Reduce Motion/Dim Flashing Lights fallback, asset/license IDs và version;
- toàn bộ model, sprite và audio nằm cục bộ; Rodin/ElevenLabs chỉ dùng trước release, không có AI generation runtime;
- chi tiết đầy đủ: [08 — Hệ đạo diễn theo mùa và sự kiện](08-he-dao-dien-theo-ngay.md).

Âm thanh có ba lớp độc lập:

- nền tập trung mặc định Yên; “Hiên sớm” chỉ chạy sau khi người dùng chủ động chọn, ở tiền cảnh và fade in sau nội dung;
- phản hồi giấy tắt mặc định;
- cue sự kiện tắt mặc định, kể cả khi nền tập trung đang chạy;
- nếu Silent, VoiceOver hoặc audio ưu tiên khác đang hoạt động, nền không tự phát;
- đặc tả đầy đủ: [10 — Mộc Son Dịu và âm nền tập trung](10-moc-son-diu-va-am-nen.md).

## 4.10. Ngăn giấy — Cài đặt và nguồn

Các lựa chọn được nhóm trên “thẻ giấy” vẽ riêng, không dùng danh sách Settings mặc định về mặt hình thức.

Nhóm thiết lập:

- chữ: chuẩn, lớn, rất lớn;
- không khí ngày: Sống động, Êm, Tĩnh; cài đặt accessibility của hệ thống luôn được ưu tiên;
- vùng cảm hứng: Bắc, Trung, Nam, Trung tính; chọn tay, không xin vị trí;
- âm nền tập trung: Yên, Hiên sớm, Mưa xa hoặc Quạt trưa; bản cài mới chọn Yên cho tới khi Gate 7 cho phép đổi;
- âm giấy: tắt mặc định;
- cue sự kiện: tắt mặc định, không tự bật theo âm nền;
- haptic: bật nhẹ mặc định, tắt khi thiết bị/setting không phù hợp;
- chủ đề khánh lịch;
- màu cuối tuần;
- múi giờ tính lịch và múi giờ nhắc;
- widget privacy;
- xuất/nhập dữ liệu;
- quyền thông báo/lịch;
- nguồn, giấy phép nội dung, chính sách riêng tư, phiên bản dữ liệu.

## 5. Onboarding

Không dùng carousel giới thiệu.

### Lần mở đầu

- vào thẳng tờ hôm nay;
- mép dưới chuyển động một lần rất nhẹ với chữ “Kéo để lật ngày”;
- sau khi người dùng thực hiện hoặc bỏ qua, gợi ý biến mất;
- một kẹp giấy có nhãn “Thêm ngày giỗ” nhưng không nhấp nháy;
- không xin notification, calendar, tracking hoặc location.

### Gợi ý theo thời điểm

- mở lịch tháng lần đầu: chỉ chỉ dẫn cách về hôm nay;
- lưu nhắc đầu tiên: giải thích và xin notification;
- mở widget hướng dẫn trong ngăn giấy khi người dùng chủ động chọn;
- mọi gợi ý chỉ xuất hiện một lần và có thể xem lại ở trợ giúp.

## 6. Quyền hệ thống

| Quyền | Bản 1.0 | Thời điểm hỏi | Phương án khi từ chối |
|---|---|---|---|
| Thông báo | Cần cho nhắc | Sau khi người dùng bấm lưu nhắc đầu tiên | Sự kiện vẫn lưu; hiển thị cách bật lại |
| Calendar | Không cần cho lõi; chỉ khi xuất sự kiện | Khi người dùng chọn “Thêm vào Lịch iPhone” | Cho chia sẻ file hoặc chỉ giữ trong app |
| Ảnh | Không xin toàn thư viện | Chỉ dùng system picker nếu chọn ảnh khánh sau này | Dùng chủ đề có sẵn |
| Vị trí | Không dùng | Không hỏi | Tiết khí/lịch theo cấu hình, không theo GPS |
| Tracking | Không dùng | Không hỏi | Không có ATT vì không tracking |

Nếu thêm EventKit, ưu tiên luồng Apple cho phép người dùng tự lưu một event qua editor hệ thống mà app không cần đọc toàn bộ lịch. Màn hình hệ thống là ngoại lệ hợp lý đối với yêu cầu “phong cách riêng”: đó là ranh giới quyền riêng tư do iOS sở hữu, không nên giả dạng.

## 7. Yêu cầu phi chức năng

### Hiệu năng

- tờ hôm nay xuất hiện tức thời từ dữ liệu cục bộ;
- gesture bám ngón tay ở 60 fps trên thiết bị thấp nhất;
- không tải ảnh mạng ở màn hình chính;
- texture nhỏ, tile được, tránh ảnh nền độ phân giải quá mức;
- hiệu ứng chỉ khởi động sau khi nội dung ngày đã sẵn sàng, tự dừng phần nặng sau 8–12 giây;
- Low Power/thermal state tự hạ particle, LOD hoặc chuyển sang poster tĩnh;
- thời gian khởi động lạnh mục tiêu dưới 1 giây tới nội dung trên thiết bị mục tiêu thực tế.

### Offline và độ bền

- toàn bộ lịch và nội dung lõi dùng được ở chế độ máy bay ngay lần mở đầu;
- sự kiện lưu cục bộ;
- app đổi ngày đúng sau khi qua nửa đêm, đổi múi giờ hoặc mở lại sau nhiều ngày;
- widget có dữ liệu dự phòng cho các ngày kế tiếp;
- lỗi dữ liệu không làm mất sự kiện cá nhân.

### Accessibility

- VoiceOver, Voice Control và Switch Control cho mọi tác vụ cốt lõi;
- vùng chạm tối thiểu 44 × 44 pt;
- không có thông tin chỉ phân biệt bằng đỏ/xanh;
- cỡ chữ nội dung không dưới 11 pt; ưu tiên 17 pt cho văn bản thân;
- hỗ trợ phóng chữ ít nhất 200% qua Dynamic Type hoặc chế độ riêng;
- độ tương phản văn bản nhỏ tối thiểu 4.5:1, văn bản lớn/đậm tối thiểu 3:1;
- Reduce Motion, Reduce Transparency, Increase Contrast;
- Dim Flashing Lights; pháo hoa có bản không flash, không chớp cả tờ lịch;
- lời đọc ngày phải theo thứ tự tự nhiên tiếng Việt.

### Riêng tư

- không tài khoản;
- không máy chủ cho dữ liệu cá nhân;
- không SDK quảng cáo, analytics, crash reporter bên thứ ba;
- log không chứa tên sự kiện/ghi chú;
- export chỉ khi người dùng chủ động, file có cảnh báo dữ liệu cá nhân;
- trang privacy policy vẫn bắt buộc dù app không thu thập dữ liệu.

## 8. Tiêu chí chấp nhận 1.0

### Hôm nay

- đúng ngày dương/âm trong múi giờ cấu hình;
- không cần mạng;
- đọc được ở cỡ chữ rất lớn mà không cắt trường cốt lõi;
- người dùng có thể qua ngày mới bằng gesture và action truy cập.

### Lịch tháng

- 42 ô đúng thứ tự tuần;
- thể hiện ngày tràn, rằm, mùng một, ngày lễ và sự kiện bằng ký hiệu không xung đột;
- chọn ngày và quay về hôm nay không quá hai thao tác.

### Nhắc âm lịch

- round-trip ngày gốc đúng;
- có chính sách tháng nhuận và tháng thiếu;
- tính lại các lần nhắc tương lai sau thay đổi múi giờ/thiết lập;
- từ chối quyền không làm mất event.

### Widget

- cập nhật khi qua ngày trong điều kiện hệ thống cho phép;
- không hiển thị nhầm sự kiện riêng ở chế độ privacy;
- chạm mở đúng deep link;
- dễ đọc ở light/dark/tinted widget contexts.

### Nội dung và nguồn

- mỗi trường không suy ra trực tiếp từ thuật toán phải có nguồn/phiên bản;
- ngày nghỉ chính thức khác ngày kỷ niệm;
- nội dung dân gian có nhãn tham khảo;
- không có tài sản chưa rõ giấy phép.

### Hiệu ứng ngày

- hero intro tự chạy không quá một lần cho mỗi ngày hiện tại;
- mọi ngày vẫn đọc và thao tác được khi cảnh đang chạy;
- trigger dùng event ID/loại lịch/múi giờ, không so tên hiển thị;
- ngày có nhiều sự kiện không chạy chồng nhiều hero;
- Reduce Motion, Dim Flashing Lights, Low Power và thiết bị yếu có fallback đã duyệt;
- Quốc kỳ đúng tỷ lệ/đặc điểm, không crop, mirror, che sao, xé hoặc dùng làm hạt trang trí;
- mọi asset Rodin/ElevenLabs có provenance và quyền sử dụng được kiểm trước release;
- app không gọi dịch vụ tạo sinh và vẫn đủ cảnh trong chế độ máy bay.

## 9. Danh sách không làm trong bản đầu

- đăng nhập/sync cloud;
- đọc lịch iPhone;
- tự động chọn ngày “hợp tuổi”;
- video/audio dài;
- weather, tide, lottery, exchange rate;
- thư viện văn khấn;
- thay thế hoàn toàn ứng dụng Calendar cho công việc;
- cộng đồng hoặc mạng xã hội;
- 3D room, camera AR hoặc character animation.
