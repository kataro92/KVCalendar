# 03 — Định hướng UX và mỹ thuật

## 1. Ý tưởng chủ đạo: “Mộc Son Dịu”

Lịch Nhà không mô phỏng một món đồ cổ quý hiếm. Nó gợi lại quyển lịch bloc vẫn treo trong nhà Việt, nhưng được làm trẻ hơn bằng pastel ít bão hòa, đường cong mềm và minh họa nhỏ. Cảm giác cần đạt là ấm, thân thuộc, hơi dễ thương và vẫn đủ sạch để đọc nhanh.

Bốn từ khóa:

- **Thân thuộc:** nhận ra là lịch bloc trước khi đọc tên app.
- **Trẻ:** hợp với người 16–34 tuổi, không tạo cảm giác ứng dụng dành cho người cao tuổi.
- **Dịu:** pastel nằm ở nền và artwork; chữ, số và trạng thái vẫn đủ tương phản.
- **Có nhịp:** ngày đặc biệt được phép có một khoảnh khắc sống động rồi nhanh chóng lắng; không banner, thẻ bay hoặc hiệu ứng lớn chạy liên tục.

Các điều cần tránh:

- “cung đình hóa” mọi màn hình bằng rồng, vàng bóng và chữ thư pháp;
- texture giả cũ quá mạnh làm app giống đạo cụ sân khấu;
- claymorphism, màu kẹo và nhân vật chibi làm sản phẩm giống app trẻ em;
- mô phỏng vật lý nặng nề khiến xem ngày chậm hơn lịch thường.

## 2. Cấu trúc vật thể

### 2.1. Bức tường

Là background toàn màn hình, không phải wallpaper ảnh. Dùng texture vữa rất nhẹ với các biến thể tường phấn, trời sớm, ngọc non hoặc nâu tối. Parallax tối đa 2–4 px và tắt khi Reduce Motion.

### 2.2. Khánh lịch

Phần cứng phía sau bloc, cao khoảng 16–20% màn hình. Hình dáng độc quyền của sản phẩm, không sao chép khánh lịch đang bán. Có thể lấy cảm hứng từ:

- đường cong cửa gỗ Việt;
- hình quạt giấy mở;
- họa tiết hồi văn tối giản;
- lớp sơn mài mờ hoặc gỗ sữa, không gương bóng;
- một phù điêu/hoa văn duy nhất ở tâm.

Khánh không dùng logo doanh nghiệp giả như lịch quảng cáo. Tên sản phẩm nhỏ hoặc biểu tượng nhà nằm trên miếng đồng/thẻ giấy.

### 2.3. Hai ốc/kẹp đồng

Là neo thị giác và giải thích xấp giấy được gắn ra sao. Có viền mờ, vết xước siêu nhẹ và bóng tiếp xúc. Không biến thành nút nếu không có affordance rõ; nếu dùng mở tờ tháng, cả vùng header phải chạm được và có nhãn.

### 2.4. Xấp giấy

Tỷ lệ gần 2:3, rộng khoảng 86–90% vùng an toàn trên iPhone dọc. Cần có:

- 4–7 đường mép giấy ở đáy và cạnh phải, không render hàng trăm lớp;
- bóng tiếp xúc sát khánh và bóng mềm lên tường;
- mép cắt không hoàn hảo 0,5–1 px;
- biến thiên texture cực nhỏ giữa các ngày;
- độ dày giảm theo tiến độ năm nhưng không làm layout nhảy.

### 2.5. Tờ trước

Giấy ngà gần trắng, đủ sạch để đọc. Texture chỉ được thấy khi nhìn kỹ; không đặt nhiễu sau chữ nhỏ. Góc dưới bên phải có một “tai giấy” rất nhẹ khi người dùng chưa biết cách bóc.

## 3. Bố cục tờ ngày

### Khung tỷ lệ

Với tờ có chiều cao 100 đơn vị:

| Vùng | Tỷ lệ gợi ý | Nội dung |
|---|---:|---|
| Đầu tờ | 0–13 | Thứ, tháng/năm, dấu ngày lễ |
| Ngày chính | 13–50 | Số ngày dương |
| Đường phân cách | 50–53 | Nét son mảnh/hoa văn ngắn |
| Lịch âm | 53–66 | Ngày tháng âm, Can Chi năm |
| Thông tin ngày | 66–84 | Can Chi ngày, tiết khí, giờ tham khảo |
| Mẩu mỗi ngày | 84–100 | Câu ngắn hoặc minh họa nhỏ |

Đây là tỷ lệ khởi đầu để prototype, không phải pixel spec. Cỡ chữ và safe area quyết định cuối cùng.

### Thứ bậc

1. **Số ngày dương**: chiếm khoảng 33–38% chiều cao tờ, nét đậm, tabular numerals.
2. **Thứ**: chữ hoa nhỏ hơn nhưng tương phản rõ; Chủ nhật dùng son + nhãn, không chỉ đổi màu.
3. **Ngày âm**: lớn thứ hai; “Mùng Một”, “Rằm” có thể dùng chữ thay số nhỏ để tạo nhịp.
4. **Sự kiện/tiết khí**: một dòng nổi bật, không quá hai dòng.
5. **Can Chi/giờ**: cỡ đọc thoải mái, không giống chú thích pháp lý.
6. **Mẩu mỗi ngày**: serif, nhịp dòng rộng; bị ẩn trước tiên ở cỡ chữ lớn.

### Khoảng trắng

Ít nhất 8% chiều rộng tờ ở mỗi cạnh. Không dùng viền hộp cho từng trường. Nhóm thông tin bằng khoảng cách, baseline và một đường son duy nhất.

## 4. Hệ màu

### 4.1. Chủ đề chính — Mộc Son Dịu

| Vai trò | Màu gợi ý | Ghi chú |
|---|---|---|
| Giấy kem | `#FFF8E8` | Mặt tờ ngày |
| Mực | `#332B2B` | Chữ/số chính; khoảng 13.05:1 trên giấy kem |
| Mực phụ | `#6D5C5C` | Khoảng 5.95:1 trên giấy kem |
| Son trẻ | `#B83A45` | Chủ nhật, dấu; khoảng 5.32:1 trên giấy kem |
| Son đậm | `#7C3040` | High contrast/pressed state |
| Hồng đào | `#F8D8CF` | Mùa xuân và vùng bắt sáng |
| Hồng sen | `#EAB7C3` | Minh họa/accent nhỏ |
| Ngọc non | `#C6DED5` | Nền phụ, sự kiện cá nhân |
| Trời sớm | `#C9E1EC` | Không khí ngày thường |
| Tím sương | `#D9D0E8` | Biến thể chiều/tối |
| Vàng nếp | `#F4E3A7` | Điểm sáng nhỏ, không dùng cho Quốc kỳ |
| Gỗ sữa | `#6B4F46` | Khánh và ngăn |
| Đồng | `#C79A58` | Ốc/kẹp, không dùng cho chữ nhỏ |
| Tường phấn | `#EADFD5` | Nền trung tính ấm |

Màu là hướng thị giác ban đầu. Tất cả cặp foreground/background phải được đo tương phản thực tế; không coi mã màu này là đã đạt chuẩn trước khi kiểm tra.

### 4.2. Chế độ tối — “Đèn khuya”

Không đảo màu âm bản. Bối cảnh trở thành tường tím nâu than; khánh gỗ trầm; giấy chuyển sang nâu đen ấm với mực kem. Pastel chỉ còn như sắc phản quang rất nhỏ. Ánh sáng giống đèn bàn thấp, không có quầng gradient lớn.

### 4.3. Tương phản cao

- bỏ texture dưới chữ;
- giấy gần trắng/đen rõ;
- mực phụ đổi thành mực chính;
- trạng thái có thêm hình/viền, không chỉ đổi sắc;
- shadow trang trí giảm, outline vật thể tăng.

## 5. Typography

### 5.1. Cặp chữ khuyến nghị

- **Be Vietnam Pro** cho số ngày, thứ, nhãn và thao tác. Đây là typeface mã nguồn mở do đội ngũ Việt thiết kế, có dấu tiếng Việt được chăm chút và giấy phép OFL. Nguồn: [Be Vietnam Pro](https://github.com/bettergui/BeVietnamPro).
- **EB Garamond** cho ca dao, mẩu văn hóa và đoạn đọc dài ngắn. Bộ Google Fonts có subset Vietnamese và giấy phép OFL. Nguồn: [EB Garamond metadata](https://github.com/google/fonts/blob/main/ofl/ebgaramond/METADATA.pb).

Phương án thay thế nếu EB Garamond quá “Tây” khi thử nghiệm: **Bitter**, một serif tối ưu cho màn hình, có subset Vietnamese và OFL. Nguồn: [Bitter metadata](https://github.com/google/fonts/blob/main/ofl/bitter/METADATA.pb).

### 5.2. Quy tắc

- số ngày dùng tabular figures để không nhảy chiều rộng;
- không dùng chữ thư pháp cho nội dung chức năng;
- chữ thư pháp/triện chỉ là artwork, tối đa một cụm ngắn, luôn có text thay thế;
- kiểm tra toàn bộ dấu kép tiếng Việt: Ắ, Ằ, Ẳ, Ẵ, Ặ, Ế, Ề, Ể, Ễ, Ệ, Ố, Ồ, Ổ, Ỗ, Ộ, Ớ, Ờ, Ở, Ỡ, Ợ, Ứ, Ừ, Ử, Ữ, Ự;
- body mặc định hướng tới 17 pt; không dưới 11 pt;
- custom font phải scale theo Dynamic Type hoặc chế độ chữ của app;
- ở cỡ Accessibility, đổi layout thay vì thu chữ/ép dòng.

Apple khuyến nghị custom font vẫn phải hỗ trợ hành vi tương đương Dynamic Type và nhấn mạnh độ đọc ở nhiều cỡ: [Apple HIG — Typography](https://developer.apple.com/design/human-interface-guidelines/typography).

## 6. Hoa văn và minh họa

### Nguyên tắc “một tờ, một điểm”

Mỗi tờ chỉ có một điểm nghệ thuật: một cành lá, một khung cảnh nét mực hoặc một hoa văn. Không ghép nhiều biểu tượng may mắn.

Độ dễ thương đến từ tỷ lệ và hành vi, không phải số sticker. Hai ốc lịch có thể lớn hơn tỷ lệ thật một chút; chim sẻ, mèo hiên, ấm trà hoặc mầm cây được vẽ bằng nét tròn và chỉ phản ứng một lần ngắn. Không nhân cách hóa Quốc kỳ, Mặt Trăng, Mặt Trời hoặc vật phẩm tín ngưỡng.

### Hệ chủ đề ban đầu

1. **Bốn mùa quanh nhà:** hoa bưởi, sen, cốm/lúa, cúc/trà — minh họa mới, không sao chép tranh.
2. **Nếp nhà:** hiên, ấm trà, cửa gỗ, sân gạch, mái ngói — chi tiết nhỏ, không biến thành tranh phong cảnh lớn.
3. **Dấu thời gian:** trăng, mưa, nắng, lá — dùng cho tiết khí và nhịp mùa.

### Cách làm

- ưu tiên minh họa vector/bitmap nguyên bản do họa sĩ tạo;
- texture chụp/tạo riêng, giữ hồ sơ nguồn;
- mọi artwork có ID, tác giả, giấy phép, ngày nhận và phạm vi sử dụng;
- không lấy hình từ kết quả tìm kiếm, lịch bloc thương mại hoặc app đối thủ;
- nếu dùng AI để tạo phôi, phải biên tập lại, kiểm tra quyền sử dụng và không mô phỏng tên tuổi họa sĩ còn sống.

## 7. Chuyển động

### 7.1. Vật lý của giấy

Tờ không phải tấm nhựa. Đặc tính chuyển động:

- mép kéo trễ nhẹ so với ngón tay;
- vùng gần ốc gần như cố định;
- độ cong lớn nhất dọc đường chéo từ điểm kẹp tới ngón tay;
- mặt sau tờ hơi tối và ít bão hòa;
- bóng đổ thay đổi theo góc cong;
- lúc rời có một dao động nhỏ rồi biến mất xuống dưới, không nổ hạt giấy.

### 7.2. Nhịp thời gian

| Tương tác | Thời lượng mục tiêu | Cảm giác |
|---|---:|---|
| Nhấc góc khi chạm | 70–100 ms | Tức thì |
| Hoàn tất bóc | 450–650 ms | Mềm, có trọng lượng |
| Hủy và trả tờ | 220–320 ms | Đàn hồi nhẹ |
| Lật mặt sau | 280–420 ms | Giấy xoay, không phải card flip casino |
| Mở tờ tháng | 320–480 ms | Tờ gấp bung ra |
| Mở ngăn giấy | 260–360 ms | Trượt có ma sát |

### 7.3. Quy tắc tiết chế

- không animation tự chạy liên tục **trên tờ**; cảnh ngày chỉ hoạt động quanh/đằng sau tờ và phải về trạng thái nghỉ;
- không bắt người dùng bóc hết nhiều ngày để đến ngày mong muốn;
- vuốt liên tục nhiều ngày chuyển sang animation ngắn;
- Reduce Motion dùng dissolve/slide 120–180 ms;
- không dùng parallax khi máy di chuyển nếu phải xin quyền hoặc gây say chuyển động.

### 7.4. “Nhịp Nhà” — chuyển động theo ngày

- tối đa một hero intro 2–4 giây, một ambient layer và hai accent tĩnh;
- intro tự chạy tối đa một lần cho ngày hiện tại; ngày quá khứ/tương lai dùng poster trừ khi người dùng yêu cầu phát lại;
- khi người dùng chạm/kéo tờ, particle và đạo cụ lập tức dịu hoặc dừng;
- pháo hoa, hoa rơi, mưa và gió không được đi qua vùng chữ chính;
- hiệu ứng mùa có phiên bản Bắc/Trung/Nam/trung tính, chọn tay và không dùng GPS;
- Quốc kỳ là asset dựng/duyệt thủ công, không phải vật liệu trang trí có thể xé, crop hoặc biến thành hạt;
- mọi cảnh có poster tĩnh, Reduce Motion, Dim Flashing Lights và Low Power fallback;
- đặc tả đầy đủ nằm tại [08 — Hệ đạo diễn theo mùa và sự kiện](08-he-dao-dien-theo-ngay.md).

## 8. Haptic và âm thanh

Core Haptics cho phép tạo pattern xúc giác riêng; Apple khuyến nghị haptic phải có quan hệ nhân–quả rõ, bổ trợ hình/âm và không lạm dụng: [Apple — Playing haptics](https://developer.apple.com/design/human-interface-guidelines/playing-haptics), [Core Haptics](https://developer.apple.com/documentation/corehaptics).

### Pattern đề xuất

- chạm góc: không rung;
- qua ngưỡng bóc: transient mềm, cường độ thấp;
- tờ rời: một transient rất ngắn, sắc hơn một chút;
- chọn ngày trên lưới: selection feedback chuẩn hoặc pattern tương đương;
- lỗi/ngày không tồn tại: không dùng rung “cảnh báo nặng”; phản hồi mềm kèm giải thích.

### Âm thanh

- nền tập trung “Hiên sớm” bật có điều kiện ở bản cài mới, fade in sau khi tờ lịch đã đọc được;
- “Hiên sớm” dùng pink noise rất nhẹ, room tone ấm và lá xa; không nhạc, lời, chuông hoặc transient;
- không tự phát khi máy ở Silent, VoiceOver đang bật hoặc audio khác cần được ưu tiên;
- nút tắt/mở nền nằm ngay trên không gian lịch, có vùng chạm 44 pt và nhớ lựa chọn;
- clip giấy 120–250 ms thuộc lớp riêng và tắt mặc định;
- âm cảnh ngày là cue riêng, tối đa một đoạn ngắn và tắt mặc định;
- không phát phản hồi giấy trên mỗi vuốt tháng;
- đặc tả âm, hành vi iOS và kế hoạch test nằm tại [10 — Mộc Son Dịu và âm nền tập trung](10-moc-son-diu-va-am-nen.md).

## 9. Component ngôn ngữ riêng

Không dùng hình thức mặc định, nhưng mỗi component vẫn có semantics tương đương.

| Chức năng | Hình thức Lịch Nhà | Semantics |
|---|---|---|
| Button | Con dấu, thẻ giấy, miếng đồng | Button với label và state |
| Toggle | Chốt gỗ trượt có chữ Bật/Tắt | Switch; không chỉ dựa vào vị trí/màu |
| Picker | Bộ số quay/ba dải giấy | Adjustable control, đọc giá trị |
| Text field | Dòng viết trên giấy có nhãn cố định | Text field chuẩn, focus rõ |
| Modal | Tờ giấy đặt lên lịch, nền tường dịu xuống | Dialog/sheet semantics, focus trap |
| Menu | Ngăn giấy kéo ra | Menu/list semantics, thứ tự focus đúng |
| Progress | Độ dày xấp giấy + nhãn ngày trong năm | Progress value, không bắt buộc để thao tác |

Các cảnh báo quyền, share sheet, bàn phím, bộ chọn ảnh và UI do hệ điều hành sở hữu vẫn dùng giao diện hệ thống. Giả dạng chúng bằng custom UI làm giảm niềm tin và có thể gây vấn đề accessibility.

## 10. Accessibility như một lớp thiết kế

Apple nêu bốn đặc tính của giao diện accessible: trực quan, có thể cảm nhận, thích nghi và hỗ trợ công nghệ trợ năng. HIG cũng khuyến nghị phóng chữ ít nhất 200%, cỡ mặc định 17 pt trên iOS, tối thiểu 11 pt và tương phản 4.5:1 cho chữ nhỏ: [Apple HIG — Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility).

### VoiceOver

Tờ ngày là một vùng tóm tắt đầu tiên:

> “Thứ Hai, ngày 7 tháng 9 năm 2026 dương lịch. Ngày 26 tháng Bảy năm Bính Ngọ âm lịch. Đang xem hôm nay.”

Actions:

- ngày trước;
- ngày sau;
- bóc tờ hôm nay;
- xem chi tiết;
- mở lịch tháng;
- thêm nhắc.

Thông tin chi tiết là các heading thật theo thứ tự, không đọc hoa văn/texture. Artwork mang nghĩa phải có mô tả; artwork trang trí bị ẩn.

### Dynamic Type và Large Print Mode

- Standard: đầy đủ mặt trước.
- Large: ẩn mẩu mỗi ngày, giữ thông tin lịch.
- Extra Large: số ngày, thứ, ngày âm và sự kiện; các trường khác ở mặt sau.
- Accessibility sizes: chuyển tờ tháng thành danh sách tuần/ngày.

### Màu và tương phản

- Chủ nhật có chữ “CN” hoặc “Chủ nhật”, không chỉ đỏ.
- Ngày nghỉ có dấu biểu tượng + nhãn.
- Hôm nay và ngày đang chọn dùng hai hình dạng khác nhau.
- Texture và ánh sáng không được kéo tương phản chữ xuống dưới chuẩn.

### Motion

- tôn trọng Reduce Motion ngay lần mở;
- không parallax, không curl mạnh ở chế độ này;
- trạng thái ngày vẫn đổi bằng layout và lời đọc;
- không bắt thực hiện gesture kéo chính xác; luôn có action/nút.

## 11. Hình thức theo thiết bị

### iPhone dọc — ưu tiên 1.0

Bloc ở giữa, khánh chiếm đầu, ngăn giấy ở đáy. Đây là hình thức gần lịch treo nhất và dùng một tay được.

### iPhone ngang

Không kéo bloc dàn ngang. Đặt bloc bên trái khoảng 44%, mặt sau/agenda bên phải. Nếu chưa làm tốt, bản 1.0 có thể chỉ tối ưu dọc nhưng vẫn không vỡ khi xoay.

### iPad — giai đoạn sau

Không phóng to iPhone. Có thể dùng bố cục một góc tường: bloc thật kích thước vừa ở trái, tờ tháng hoặc ghi chú ở phải. Đây là cơ hội cho “không gian nhà”, nhưng không nên cản bản iPhone.

## 12. Icon và App Store art direction

### Icon

Không dùng số ngày động trong icon. Biểu tượng đề xuất:

- silhouette khánh lịch tối giản;
- một tờ giấy ngà với góc bóc;
- dấu son hình mái nhà hoặc chữ “L” trừu tượng;
- bảng màu son–ngà–gỗ, nhận ra ở 32 px.

Tránh: lịch lưới generic, chữ “2026”, 12 con giáp chật, rồng vàng hoặc icon quá giống đối thủ.

### Screenshots App Store

Chuỗi kể chuyện 5 ảnh:

1. “Mở là thấy hôm nay.” — màn lịch chính.
2. “Bóc một ngày, như ở nhà.” — khoảnh khắc page curl.
3. “Âm dương rõ ràng, có nguồn.” — mặt sau.
4. “Nhớ ngày giỗ, kể cả tháng nhuận.” — luồng nhắc.
5. “Miễn phí. Không quảng cáo. Không tài khoản.” — widget + privacy.

Không dùng claim “chính xác nhất”; dùng “có nguồn và được kiểm thử”.

## 13. Definition of beautiful

Giao diện chỉ được coi là đẹp khi đạt đồng thời:

- nhìn 1 giây nhận ra lịch bloc Việt;
- số ngày đọc được ở khoảng cách cánh tay;
- không trường nào trông như card dashboard;
- texture không làm chữ bẩn;
- animation theo tay, không lag;
- chuyển sang cỡ chữ 200% vẫn có bố cục có chủ ý;
- light, dark và high contrast đều giống cùng một sản phẩm;
- minh họa có nguồn/quyền rõ;
- người dùng 20–35 tuổi gọi là tinh tế và người 55+ gọi là dễ dùng trong test định tính.
