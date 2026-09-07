# 08 — Hệ đạo diễn theo mùa và sự kiện

Phiên bản tài liệu: 0.1
Trạng thái: đặc tả sản phẩm và pipeline asset, chưa triển khai mã nguồn
Giả định tên công cụ người dùng nêu: **“elenevlab” = ElevenLabs**

## 1. Quyết định sản phẩm

Lịch Nhà nên có một **“hệ đạo diễn theo ngày”**: cùng một quyển lịch, nhưng ánh sáng, đạo cụ, chuyển động rất nhỏ và âm thanh tùy chọn thay đổi theo ngày lễ, tiết khí, mùa và sự kiện riêng. Đây không phải skin đổi màu và cũng không phải một game 3D toàn màn hình.

Trải nghiệm đúng là:

- mở ngày thường: tờ lịch thở rất nhẹ bằng ánh sáng và một chi tiết mùa;
- mở ngày đặc biệt: có một khoảnh khắc 2–4 giây đủ để nhận ra ngày đó;
- sau khoảnh khắc đầu: cảnh lắng xuống để người dùng đọc lịch;
- ngày dày sự kiện: có một chủ đề chính, các sự kiện còn lại hiện bằng dấu/kẹp nhỏ;
- mọi hiệu ứng có bản tĩnh tương đương, không che hoặc thay thế thông tin ngày.

Tên khái niệm nội bộ đề xuất: **Nhịp Nhà**. Người dùng chỉ thấy nhãn tự nhiên như “Không khí hôm nay”, không cần biết có một “effect engine”.

## 2. “Đẹp” trong hệ hiệu ứng nghĩa là gì

Hiệu ứng đạt yêu cầu khi nó làm người dùng nghĩ “hôm nay là một ngày khác” nhưng sau 5 giây vẫn còn cảm giác đang đứng trước quyển lịch quen trong nhà.

### Năm nguyên tắc

1. **Ngày là nhân vật chính.** Số ngày, ngày âm và sự kiện luôn đọc được trong suốt hiệu ứng.
2. **Một ngày, một khoảnh khắc.** Chỉ một cảnh chủ đạo tự chạy; không xếp pháo hoa, hoa rơi, đèn lồng và confetti cùng lúc.
3. **Chuyển động có hồi kết.** Intro ngắn rồi cảnh về trạng thái nghỉ; không bắt GPU chạy hoạt cảnh lớn vô hạn.
4. **Chất Việt đến từ quan sát cụ thể.** Gió trên lá cờ, bóng cành trên giấy, ánh đèn hiên và vật liệu thật quan trọng hơn việc phủ đỏ–vàng hoặc dùng rồng ở mọi nơi.
5. **Trang trọng đúng chỗ.** Quốc kỳ, ngày tưởng niệm, nghi lễ và biểu tượng tín ngưỡng không được biến thành đồ chơi, phần thưởng hoặc hạt trang trí.

### Những dấu hiệu thất bại

- giống màn hình chờ game hơn một quyển lịch;
- hiệu ứng chạy mỗi lần đổi qua lại ngày và nhanh chóng gây mệt;
- pháo hoa sáng che số ngày hoặc làm chữ rung;
- 3D bóng nhựa, khác phong cách giấy–gỗ–sơn mài;
- mọi ngày đều có cánh hoa nên ngày đặc biệt không còn đặc biệt;
- dùng tuyết, lá phong hoặc sakura như một ký hiệu mùa mặc định cho toàn Việt Nam;
- âm nền bật đột ngột, không có nút tắt ngay hoặc vẫn phát khi Silent/VoiceOver/audio khác đang hoạt động.

## 3. Mô hình năm lớp

Một cảnh ngày được ghép từ tối đa năm lớp độc lập. Không phải ngày nào cũng dùng đủ năm lớp.

| Thứ tự | Lớp | Ví dụ | Quy tắc |
|---:|---|---|---|
| 1 | Không gian nền | ánh nắng tháng Chín trên tường, sắc trời đầu xuân | rất nhẹ, không làm đổi độ tương phản giấy |
| 2 | Nhịp mùa/vùng | bóng lá, mưa hiên, hơi ấm, cánh đồng xa | một lớp duy nhất; có bản Bắc/Trung/Nam/trung tính |
| 3 | Đạo cụ trên khánh | cờ mini, cành đào, đèn ông sao, mặt trống đồng | không đè lên tờ; live 3D hoặc ảnh dựng sẵn |
| 4 | Khoảnh khắc sự kiện | pháo hoa, nụ nở, vệt sáng, cánh hoa | intro 2–4 giây; tự dừng |
| 5 | Vi chi tiết trên tờ | dấu son, góc minh họa, sợi chỉ, bóng hoa | tĩnh hoặc gần tĩnh; không vào vùng chữ chính |

Thứ tự hiển thị thực tế phải bảo vệ khả năng đọc:

1. tường và ánh sáng;
2. hiệu ứng mùa phía sau;
3. khánh cùng đạo cụ;
4. tờ giấy và toàn bộ text chức năng;
5. một lượng hạt tiền cảnh rất thưa, bị cắt khỏi “vùng an toàn nội dung”;
6. nút/semantic controls luôn ở trên cùng.

## 4. Nhịp thời gian của một cảnh

### 4.1. Chu kỳ đề xuất

| Pha | Thời lượng mục tiêu | Nội dung |
|---|---:|---|
| Nhận diện | 0–300 ms | tờ ngày xuất hiện ngay; không chờ tải cảnh |
| Mở cảnh | 0.3–3.5 s | khoảnh khắc đặc trưng: pháo hoa, cành nở, đèn sáng |
| Lắng | 3.5–8 s | hạt giảm, đạo cụ trở về nhịp rất nhẹ |
| Nghỉ | sau 8–12 s | phần lớn animation dừng; chỉ còn ảnh/ánh sáng tĩnh |
| Gió thoảng tùy chọn | mỗi 15–30 s | cờ/cành lay 1–1.5 s ở biên độ thấp, chỉ khi app vẫn foreground và máy khỏe |

Người dùng không phải đợi pha nào kết thúc mới chạm, bóc lịch hoặc mở mặt sau. Khi họ bắt đầu thao tác, hiệu ứng trang trí giảm ngay để ưu tiên gesture giấy.

### 4.2. Khi nào tự chạy

- chỉ tự chạy intro của **ngày hiện tại**, tối đa một lần trong ngày lịch cục bộ;
- mở lại app cùng ngày đi thẳng vào pha lắng/nghỉ;
- khi duyệt ngày quá khứ/tương lai, mặc định hiện “bưu thiếp tĩnh” của cảnh;
- một con dấu nhỏ “Xem không khí ngày này” cho phép phát lại theo yêu cầu;
- qua nửa đêm, app đổi ngày và cảnh mới được quyền chạy một lần;
- trạng thái “đã xem” chỉ lưu cục bộ, không phải streak và không tạo áp lực quay lại.

### 4.3. Âm thanh và haptic

- âm nền tập trung, phản hồi giấy và cue sự kiện là ba lớp độc lập;
- bản cài mới mặc định Yên; “Hiên sớm” chỉ fade in sau khi người dùng chủ động chọn, nội dung ngày đã hiện và app ở tiền cảnh;
- âm giấy và cue sự kiện tắt mặc định; một cảnh chỉ có tối đa một cue ngắn;
- không tự phát nền khi Silent, VoiceOver hoặc audio ưu tiên khác đang hoạt động;
- pháo hoa không tạo chuỗi haptic; haptic vẫn dành chủ yếu cho hành động bóc giấy;
- mọi thông tin truyền đạt bằng âm thanh đều có nhãn/hình tương ứng.

## 5. Hai cảnh flagship

### 5.1. Quốc khánh 2/9 — “Cờ trên hiên”

### Dàn cảnh

1. Tờ lịch và nội dung ngày xuất hiện trước.
2. Ánh nắng ấm lướt rất nhẹ trên gỗ khánh trong 400–600 ms.
3. Hai hoặc ba chùm pháo hoa đỏ–vàng nở **phía sau khánh**, lệch vùng số ngày; tổng thời gian khoảng 2.5–3.2 giây. Đây là liên tưởng lễ hội: địa phương có tổ chức hay không còn tùy quyết định thực tế, app không mô tả pháo hoa như sự kiện diễn ra ở mọi nơi.
4. Một lá cờ Việt Nam nhỏ gắn vào cạnh khánh đón một nhịp gió, sau đó lắng xuống.
5. Dấu son “Quốc khánh” giữ lại trên tờ; không còn hạt sáng liên tục.

Nếu người dùng bật âm thanh: chỉ nghe 2–3 tiếng pháo hoa ở xa, như vọng từ ngoài phố vào trong nhà; không tiếng súng sắc, không đám đông, không nhạc và không lời nói.

### Quy tắc bất khả xâm phạm với Quốc kỳ

Điều 13 Hiến pháp 2013 xác định Quốc kỳ là hình chữ nhật, chiều rộng bằng hai phần ba chiều dài, nền đỏ và ngôi sao vàng năm cánh ở giữa. Sắc lệnh số 5 năm 1945 cho hình học chi tiết hơn: nếu chiều dài là `a`, chiều rộng là `2/3a`; bán kính từ tâm tới đỉnh lồi của sao là `1/5a`, tới góc lõm là `1/10a`; tâm sao trùng tâm cờ và một đỉnh quay thẳng lên. Asset gốc phải dựng tay theo hai nguồn: [Hiến pháp 2013](https://vanban.chinhphu.vn/hien-phap-nam-2013/chuong-i-che-do-chinh-tri-10052990), [Sắc lệnh số 5](https://vbpl.vn/TW/Pages/vbpq-print.aspx?ItemID=819).

Văn bản dùng mô tả đỏ tươi/vàng tươi, không cho mã sRGB/hex. Màu số là master asset được duyệt, không gọi là “mã màu pháp định”.

- hình học lá cờ phải được dựng thủ công, không giao cho AI 3D tự quyết tỷ lệ;
- texture phẳng gốc đúng tỷ lệ `2:3`, sao ở tâm, không crop, mirror, đổi màu hoặc thêm logo;
- biến dạng vải chỉ tạo sóng mềm; ở mọi khung hình vẫn nhận ra đầy đủ lá cờ và ngôi sao;
- không dùng cờ làm confetti, mảnh vỡ, tờ giấy bị xé, nút bấm, phần thưởng hay vật có thể kéo/vứt;
- không để UI, pháo hoa hoặc mép màn hình che ngôi sao;
- lá cờ không tham gia hiệu ứng bóc tờ và không rơi khỏi khánh;
- artwork phải được một người Việt kiểm tra trên ảnh tĩnh lẫn toàn bộ animation trước phát hành.

### Bản giảm hiệu ứng

- **Reduce Motion:** cờ đứng yên; ánh sáng crossfade; pháo hoa là ba cụm màu nước tĩnh mờ dần.
- **Dim Flashing Lights:** không có chớp trắng hoặc thay đổi sáng tối nhanh; thay bằng quầng đỏ–vàng mềm, không nhấp nháy.
- **Low Power/thermal cao:** ảnh dựng sẵn của cờ và khánh, không live 3D; tối đa một fade.
- **VoiceOver:** một mô tả gọn trong phần sự kiện: “Không khí Quốc khánh: cờ Việt Nam trên khánh lịch và pháo hoa phía xa.” Không đọc từng chùm pháo.

### 5.2. Lập Xuân — “Nụ đầu hiên”

### Dàn cảnh

1. Bóng một nhành cây hiện rất nhẹ lên mép tường.
2. Hai hoặc ba nụ đào mở trong 1.2–1.8 giây; không làm cả cây “mọc” từ hư không.
3. Bốn đến tám **cánh hoa** (không phải cả lá) trôi theo đường cong, một vài cánh đáp lên vùng trống của tờ rồi tan mờ.
4. Cành chỉ lay một lần, sau đó trở thành minh họa tĩnh.
5. Mặt trước ghi rõ “Lập Xuân · bắt đầu lúc …” nếu engine có thời điểm chuyển tiết đủ tin cậy.

Lập Xuân là tiết khí thiên văn, không phải cam kết rằng thời tiết ở mọi vùng đã chuyển sang xuân. Vì vậy hiệu ứng được ghi là “cảm hứng Lập Xuân”, không giả làm thời tiết thật.

### Bản theo vùng

- **Miền Bắc:** nhành đào, ánh sáng se lạnh, giấy ngà hơi xanh ở nền ngoài tờ.
- **Miền Trung:** nhành cây mảnh và ánh sáng sau mưa; tránh biến thành “Tết cung đình” mặc định.
- **Miền Nam:** hoa mai vàng hoặc chồi non, ánh nắng ấm hơn.
- **Trung tính:** nụ cây nét mực và hạt sáng, không gắn một loài hoa cụ thể.

Người dùng tự chọn vùng/chất mùa trong cài đặt. Không xin GPS và không suy vùng từ dữ liệu cá nhân.

### Phân vai kỹ thuật

- cành/khúc gỗ có thể tạo phôi từ concept sheet đã duyệt bằng Rodin Image-to-3D, rồi retopo và dựng ánh sáng;
- cánh hoa là sprite/mesh 2D instanced chạy theo quỹ đạo có seed;
- hiệu ứng nụ nở nên là vài frame/morph được kiểm soát bởi họa sĩ, không gọi AI lúc runtime;
- âm thanh tùy chọn chỉ là xào xạc rất nhỏ, không thêm chim hót như một cliché nếu không qua test thực địa.

## 6. Ma trận nội dung đề xuất

Không nên tạo 365 scene nặng khác nhau. “Theo từng ngày” được giải bằng một thư viện cảnh có trigger chính xác cộng biến thiên thủ tục có kiểm soát.

### 6.1. Gói 1.0 khả thi

| Nhóm | Phạm vi | Cách làm |
|---|---:|---|
| Cảnh lễ flagship | 6 cảnh | dàn dựng riêng, intro + static fallback |
| 24 tiết khí | 24 cue dữ liệu, 6 họ hiệu ứng | thay màu, ánh sáng, loài cây/vật liệu theo cue; Lập Xuân là cue riêng chất lượng cao |
| Mùa theo vùng | 4 cấu hình | Bắc, Trung, Nam, Trung tính; không cần 4 bộ asset hoàn toàn khác |
| Ngày âm quan trọng | 6–8 cue | rằm, mùng một, Tết, Trung Thu, Đoan Ngọ…; mức độ khác nhau |
| Sự kiện cá nhân | 3 cue | sinh nhật, kỷ niệm, ngày giỗ/tưởng nhớ |
| Ngày thường | 12–18 vi cảnh | bóng lá, ấm trà, cửa gỗ, mưa hiên, trăng… luân phiên theo seed ngày |

Mục tiêu có điều kiện cho 1.0 là khoảng **40–55 cue** dùng chung 15–20 hệ asset, không phải 365
video hoặc 365 mô hình 3D. Gate 6A, cultural/license review và ngân sách T019 quyết định có đạt
scope này hay chỉ ship flagship/poster rồi dời cảnh mở rộng.

### 6.2. Cảnh lễ nên ưu tiên

| Ngày/cụm ngày | Hình ảnh đề xuất | Chuyển động | Sắc thái |
|---|---|---|---|
| Tết Nguyên đán | đào/mai, giấy hồng điều, ánh đèn hiên | một nụ nở + dải giấy lay | ấm, sum họp |
| Giỗ Tổ Hùng Vương | hoa văn trống đồng nguyên bản, ánh đồng | hoa văn hiện dần như dập nổi | trang trọng, không tạo tượng nhân vật |
| 30/4 | nắng sớm, dải son, cờ nhỏ đúng chuẩn | một nhịp cờ, không confetti | trang trọng, sáng |
| Quốc khánh 2/9 | cờ trên hiên, pháo hoa xa | intro flagship | hân hoan, tiết chế |
| Trung Thu | đèn ông sao, bóng trăng trên giấy | đèn sáng lên, bóng dịch rất ngắn | gia đình, trẻ thơ nhưng không hoạt hình hóa app |
| Tết Ông Công Ông Táo | bóng cá chép nét mực, bếp ấm | một vệt bơi trên phần tường | phong tục, không giải thích như sự thật lịch sử |

Danh mục và cách thể hiện cần được biên tập văn hóa. Với ngày tưởng niệm, ngày giỗ và nội dung tín ngưỡng, mặc định ưu tiên ánh sáng, hoa ép hoặc hoa văn tĩnh; không tự phát pháo hoa/confetti.

### 6.3. Họ hiệu ứng cho 24 tiết khí

| Họ | Ví dụ cue | Ngôn ngữ hình ảnh |
|---|---|---|
| Nảy mầm | Lập Xuân, Vũ Thủy, Kinh Trập | nụ/chồi, giọt nước, bóng đất ẩm |
| Trong sáng | Xuân Phân, Thanh Minh, Cốc Vũ | ánh sáng dịu, mưa bụi, một cánh hoa |
| Nắng lớn | Lập Hạ, Tiểu Mãn, Mang Chủng, Hạ Chí | bóng nắng, lá rộng, sắc lúa; không heat-wave che chữ |
| Chuyển gió | Tiểu Thử, Đại Thử, Lập Thu | gió hiên, mây mực, độ ấm màu thay đổi |
| Thu lắng | Xử Thử, Bạch Lộ, Thu Phân, Hàn Lộ, Sương Giáng | hạt sương, bóng lúa/cúc, một lá khô có kiểm soát |
| Ấm trong nhà | Lập Đông, Tiểu Tuyết, Đại Tuyết, Đông Chí, Tiểu Hàn, Đại Hàn | ánh đèn, hơi trà, gỗ trầm; không mặc định tuyết rơi ở Việt Nam |

Tên tiết khí là dữ kiện thiên văn; artwork là diễn giải mỹ thuật. Phần nguồn phải tách hai thứ này.

### 6.4. Ngày thường vẫn có “hơi thở”

Mỗi ngày thường chọn một vi cảnh từ thư viện dựa trên `ngày + vùng + chủ đề`, với seed xác định. Cùng một ngày luôn cho cùng bố cục trên một thiết bị/theme; không đổi ngẫu nhiên mỗi lần mở.

Biến thiên an toàn gồm:

- góc và độ dài bóng cửa sổ;
- một trong vài nhành lá nguyên bản;
- vị trí dấu son trong vùng cho phép;
- 0–3 hạt bụi sáng hoặc giọt mưa ngoài tờ;
- sắc độ tường trong khoảng đã kiểm tương phản.

Không dùng ID người dùng làm seed và không cần máy chủ.

## 7. Xử lý khi nhiều sự kiện trùng nhau

Một ngày có thể đồng thời là ngày nghỉ, tiết khí, rằm và sinh nhật. Hệ thống không được cộng tất cả hoạt cảnh.

### Thứ tự mặc định

1. ngày quốc gia/ngày nghỉ hoặc sự kiện công cộng trọng yếu;
2. lễ truyền thống lớn theo âm lịch;
3. tiết khí;
4. ngày kỷ niệm biên tập;
5. sự kiện cá nhân;
6. không khí mùa/ngày thường.

Thứ tự không phải phán xét giá trị cá nhân; nó chỉ ngăn xung đột hình ảnh. Người dùng có thể chạm dòng “Hôm nay có 3 dấu mốc” để chọn bưu thiếp của sự kiện khác.

### Luật phối cảnh

- tối đa **một hero effect**;
- tối đa **một ambient layer** tương thích;
- tối đa **hai micro accent** tĩnh;
- sự kiện cá nhân hiện bằng kẹp/sợi chỉ nhỏ nếu đã có hero công cộng;
- cue “tưởng niệm/trang nghiêm” khóa mọi confetti và âm thanh hân hoan;
- không phối nếu hai cue cùng chiếm khánh hoặc có bảng màu xung đột;
- resolver dựa vào ID và metadata, không so chuỗi tên hiển thị.

## 8. Đặc tả một effect cue

Mỗi cue cần một hồ sơ dữ liệu có version. Đây là schema khái niệm, chưa phải code.

| Nhóm trường | Nội dung tối thiểu |
|---|---|
| Nhận dạng | `effect ID`, tên nội bộ, version, owner |
| Trigger | lịch dương/âm/tiết khí/sự kiện cá nhân, ngày hoặc khoảng ngày, múi giờ hiển thị |
| Độ ưu tiên | hero/ambient/accent; trọng số; nhóm loại trừ; cue tương thích |
| Dàn cảnh | intro, settle, idle, replay, static poster; thời lượng từng pha |
| Bố cục | vùng neo, vùng cấm che chữ, safe area theo kích thước máy |
| Asset | model/texture/sprite/audio/haptic IDs, LOD và checksum |
| Biến thiên | seed inputs, khoảng position/rotation/velocity/màu đã duyệt |
| Accessibility | mô tả ý nghĩa, bản Reduce Motion, bản Dim Flashing Lights, trạng thái decorative |
| Hiệu năng | device tier tối thiểu, particle/triangle/texture budget, bản low power |
| Văn hóa | nguồn sự kiện, vùng áp dụng, nhãn trang nghiêm/tín ngưỡng/Quốc kỳ, reviewer |
| Quyền | tác giả, công cụ/model, prompt/input provenance, gói thuê bao, điều khoản, ngày tạo |
| Vòng đời | ngày hiệu lực, ngày hết hiệu lực nếu có, data-pack version, changelog |

Ngày nghỉ thay đổi theo năm không được tự kích hoạt chỉ vì tên ngày giống năm trước. Trigger phải trỏ đến occurrence chính thức đã có nguồn/version trong Content Catalog.

## 9. Dùng Rodin 3D đúng vai trò

Trong dự án này, Rodin chỉ được dùng ở chế độ **Image-to-3D** với ảnh tham chiếu đã duyệt. Text-to-3D và lượt tạo chỉ có prompt chữ bị cấm. Rodin có thể xuất `glb`, `usdz`, `fbx`, `obj`, `stl`; Gen-2.5 có PBR/Shaded/Hybrid và nhiều mức số mặt: [Rodin Gen-2.5 API](https://docs.hyper3d.ai/en/api-specification/rodin-gen2-5). Apple coi USD là định dạng ưu tiên của RealityKit trên các nền tảng của họ: [Apple — Bringing SceneKit projects to RealityKit](https://developer.apple.com/documentation/realitykit/bringing-your-scenekit-projects-to-realitykit).

### 9.1. Rodin nên làm

- phôi khánh gỗ, đầu ốc, núm đồng, chân đèn từ concept/ảnh nguyên bản;
- cành đào/mai, ấm trà, đèn ông sao, đèn lồng, đạo cụ hiên nhà từ reference đã duyệt;
- relief/đạo cụ trống đồng từ artwork **nguyên bản**, qua reviewer văn hóa;
- nhiều góc nhìn để họa sĩ chọn và render thành sprite 2.5D;
- bản high-detail dùng làm nguồn bake normal/ambient-occlusion cho bản nhẹ.

### 9.2. Rodin không nên làm

- Text-to-3D hoặc bất kỳ lượt tạo nào chỉ có prompt chữ;
- tự sinh Quốc kỳ hoặc quyết định hình học ngôi sao;
- pháo hoa, mưa, cánh hoa, khói và các hạt có số lượng lớn;
- chữ Việt, Can Chi, ngày tháng hoặc logo;
- cả căn phòng 3D chạy liên tục;
- model tải/generate trực tiếp trên iPhone;
- nội dung tôn giáo/nhân vật lịch sử mà không có art direction và duyệt con người.

### 9.3. Chiến lược hybrid

| Loại asset | Bản production ưu tiên | Lý do |
|---|---|---|
| Cờ mini | mesh phẳng dựng tay + shader/animation sóng nhẹ; cột cờ có thể từ ảnh duyệt → Rodin Image-to-3D | giữ chuẩn Quốc kỳ và nhẹ |
| Cành đào/mai | ảnh/concept duyệt → Rodin Image-to-3D → cleanup → render/bake 2.5D; live 3D chỉ nếu parallax tạo khác biệt thật | tán/cành 3D dễ quá nặng |
| Đèn ông sao/đèn lồng | live 3D low-poly hoặc sprite nhiều góc | phản sáng nhỏ tạo chiều sâu tốt |
| Trống đồng/khánh | model nguồn → bake normal/texture lên mặt phẳng hoặc mesh rất thấp | giữ vật liệu, giảm triangle |
| Pháo hoa/cánh hoa/mưa | particle 2D/Canvas/Metal, atlas nguyên bản | nhiều phần tử, cần điều khiển chính xác |
| Tờ giấy | custom mesh/shader riêng | phải bám gesture và accessibility UI |

### 9.4. Pipeline Rodin đề xuất

1. Họa sĩ tạo concept sheet nguyên bản: trước, 3/4, cạnh và sau khi cần; chốt tỷ lệ và bảng vật liệu.
2. Chỉ dùng reference mà dự án sở hữu hoặc được phép dùng; không dùng ảnh lịch đối thủ làm source.
3. Mở Image-to-3D và tải 1–5 ảnh đã duyệt. Khi dùng nhiều ảnh, đặt ảnh rõ vật liệu nhất đầu tiên theo hướng dẫn hiện hành của Rodin.
4. Prompt chữ, nếu có, chỉ bổ sung tỷ lệ hoặc vật liệu đã thấy trong ảnh; không dùng làm đầu vào duy nhất.
5. Rodin tạo phôi, ưu tiên Quad/low hoặc extra-low khi phù hợp; không coi output là production-ready.
6. Mở trong Blender/công cụ DCC để sửa silhouette, topology, normals, UV, scale, pivot và mặt khuất.
7. Giảm số material, atlas texture, bake chi tiết; tạo LOD0/LOD1/static poster.
8. So phong cách với Mộc Son Dịu: roughness mờ, cạnh mềm, pastel tiết chế, không bóng nhựa; xuất master có thể biên tập và USDZ, rồi kiểm tra trên máy thật.
9. Lưu reference ID, cấu hình tạo, provenance/license manifest trước khi asset được merge vào pack.

Tài liệu Rodin liệt kê preset Gen-2.5 Quad khoảng 18.000 mặt ở medium, 8.000 ở low và 4.000 ở extra-low; Raw cao hơn rất nhiều. Đó là preset đầu ra của dịch vụ, **không phải ngân sách app**. Mục tiêu khởi điểm của Lịch Nhà:

- một đạo cụ live nổi bật: khoảng 4.000–8.000 tam giác sau cleanup;
- toàn bộ phần live 3D đang thấy: không quá khoảng 20.000–25.000 tam giác;
- một hoặc hai material cho mỗi đạo cụ;
- texture 512–1024 px cho đạo cụ nhỏ; 2K chỉ khi profile chứng minh cần;
- mọi model có static poster; chất lượng cuối dựa trên profile máy thật, không dựa con số bàn giấy.

### 9.5. Quyền và dữ liệu Rodin

Trang pricing hiện mô tả quyền export/sử dụng phụ thuộc gói và Terms cũng nói private/commercial use phụ thuộc subscription plan; vì vậy phải kiểm tra **gói tại thời điểm tạo/xuất** và điều khoản trước release: [Hyper3D Pricing](https://hyper3d.ai/pricing?lang=en), [Hyper3D Terms](https://hyper3d.ai/legal/terms).

Đây là yêu cầu quản trị quyền cho dự án, không phải ý kiến pháp lý; trước phát hành thương mại nên nhờ người có chuyên môn rà lại nếu điều khoản hoặc plan không rõ.

Chính sách lưu dữ liệu ngày 03/08/2026 của **Rodin API** nói payload và output API được giữ 7 ngày trên active systems, không dùng train, không xuất bản vào public Assets và không chia cho người dùng khác; chính sách này không mặc nhiên áp dụng cho mọi giao diện web/sản phẩm khác: [Rodin API Data Retention Policy](https://docs.hyper3d.ai/en/legal/data-retention-policy).

Khuyến nghị:

- dùng Rodin như công cụ sản xuất trước release, không nhúng API key vào app;
- không upload dữ liệu cá nhân, ảnh nhà/người hoặc artwork chưa đủ quyền;
- lưu local ảnh đầu vào được phép, checksum/reference ID, prompt phụ, seed nếu có, output gốc và bản đã chỉnh;
- lưu bằng chứng gói thuê bao/điều khoản tại ngày xuất;
- luôn duyệt tương đồng/bản quyền; output AI có thể không độc quyền và nhà cung cấp không bảo đảm không xâm phạm.

## 10. Dùng ElevenLabs đúng vai trò

ElevenLabs Sound Effects tạo Foley/ambient từ mô tả, điều khiển thời lượng và looping; tài liệu hiện nêu tối đa 30 giây, MP3 cho mọi effect và WAV 48 kHz cho effect không loop: [ElevenLabs — Sound effects](https://elevenlabs.io/docs/overview/capabilities/sound-effects).

### 10.1. Bộ âm thanh 1.0

| Cue | Độ dài ship mục tiêu | Vai trò |
|---|---:|---|
| Hiên sớm | 60–120 s sau khi biên tập | nền tập trung opt-in: pink noise nhẹ, room tone và lá xa |
| Mưa xa | 60–120 s sau khi biên tập | nền tập trung thay thế, không sấm/giọt sắc |
| Quạt trưa | 60–120 s sau khi biên tập | nền dải thấp mềm, không lộ chu kỳ motor |
| xé tờ giấy mỏng | 0.18–0.35 s | phản hồi bóc lịch |
| giấy lật/đáp | 0.25–0.6 s | lật mặt sau/mở tháng |
| pháo hoa xa | 2.5–3.5 s | Quốc khánh, chỉ khi bật âm |
| vải cờ lay nhẹ | 0.8–1.5 s | có thể trộn rất nhỏ vào cảnh 2/9 |
| cánh hoa/nhành cây | 0.8–1.5 s | Lập Xuân, gần như Foley |
| mưa ngoài hiên ngắn | 4–8 s | preview hoặc cue cảnh, không dùng thay master Mưa xa |
| đèn/tre/gỗ nhỏ | 0.3–1 s | vài tương tác vật thể, dùng rất ít |

Âm giấy thật tự thu vẫn nên là ứng viên A. ElevenLabs là ứng viên B và là cách tạo nhanh nhiều biến thể; blind test quyết định bản ship. Nền noise được tạo/lọc bằng công cụ audio có tham số rõ, rồi trộn với Foley hoặc phôi ElevenLabs. Không lặp trực tiếp một output AI ngắn.

### 10.2. Prompt mẫu để tạo phôi âm

Các prompt nên cụ thể, không đòi cả một “bản nhạc” trong một câu:

- `Close-miked tear of one thin 60 gsm paper calendar sheet along a perforated top edge, gentle and dry, quiet small room, 0.3 seconds, no music, no voice.`
- `Three distant celebratory fireworks heard from inside a quiet Vietnamese home, warm and restrained, no crowd, no music, 3 seconds.`
- `A small cotton flag moving in a mild breeze, subtle soft cloth flutter, no strong wind, no pole clank, 1.2 seconds.`
- `A few peach blossom petals brushing thin paper, extremely delicate rustle, intimate dry room, no birds, no music, 1 second.`
- `Soft rain beyond a tiled veranda, distant and calm, no thunder, no people, seamless room perspective, 6 seconds.`

Quy trình chọn: tạo nhiều biến thể → nghe trên loa iPhone ở âm lượng thấp → loại tiếng quá cinematic/sắc → cắt và fade → normalize tương đối giữa cue → thử cùng haptic và animation → export asset cuối.

### 10.3. Quyền ElevenLabs

Một app phát hành công khai, dù tải miễn phí và không quảng cáo, vẫn nên được xử lý như **production/commercial distribution** cho mục đích cấp phép. Help Center hiện nói gói free không có commercial license; các gói trả phí có commercial license nếu không dùng Beta Services, và nội dung tạo trong thời gian thuê bao trả phí có thể tiếp tục dùng theo điều khoản: [ElevenLabs — publishing generated content](https://help.elevenlabs.io/hc/en-us/articles/13313564601361-Can-I-publish-the-content-I-generate-on-the-platform).

Ngoài ra, Prohibited Use Policy cấm phân phối/khai thác output Sound Effects như file âm thanh độc lập hoặc thư viện sound; việc nhúng làm thành phần của trải nghiệm app phải vẫn tuân Terms và policy hiện hành: [ElevenLabs Prohibited Use Policy](https://elevenlabs.io/use-policy), [ElevenLabs Terms](https://elevenlabs.io/terms-of-use).

Trước khi ship mỗi file cần lưu:

- prompt và ngày tạo;
- model/feature, trạng thái Beta hay production;
- account/gói thuê bao dùng lúc tạo;
- file gốc và file đã biên tập;
- hash, asset ID và các effect cue sử dụng;
- bản Terms/Service-Specific Terms/Prohibited Use Policy đã kiểm;
- người nghe duyệt và kết quả kiểm tra không chứa giọng nói/nhạc ngoài ý muốn.

Không gọi ElevenLabs từ app. Như vậy người dùng không cần mạng/tài khoản, app không chịu phí theo lượt, không lộ API key và lời hứa offline vẫn đúng.

## 11. Render trên iOS

Khuyến nghị trước vẫn giữ: **SwiftUI làm cấu trúc và text; Canvas/Metal cho particle và biến dạng giấy; RealityKit chỉ cho một số đạo cụ 3D nhỏ**. Không chuyển toàn app sang Godot/Three.js chỉ vì có nhiều hiệu ứng.

### Vai trò từng lớp công nghệ

| Lớp | Kỹ thuật phù hợp | Ghi chú |
|---|---|---|
| Text/ngày/nút | SwiftUI semantic views | giữ Dynamic Type, VoiceOver và thao tác |
| Giấy/bóng/texture | Shape, image, Canvas, shader có giới hạn | không nhúng chữ vào texture |
| Fireworks/petals/rain | particle 2D bằng Canvas/Metal hoặc SpriteKit overlay nếu prototype chứng minh tốt hơn | vùng hạt không nhận touch |
| Đạo cụ 3D | RealityKit/USDZ | tối đa rất ít entity; có poster 2D fallback |
| Cờ lay | mesh dựng tay + vertex deformation/clip đã duyệt | không dùng cloth simulation tổng quát |
| Audio/haptic | AVFoundation/system audio + Core Haptics | asset local; silent mode và settings chi phối |
| Widget | ảnh/vector tĩnh cùng art direction | Widget không cố mô phỏng cảnh động |

Apple lưu ý Canvas không có interactivity/accessibility riêng cho từng phần tử, nên toàn bộ nội dung/chức năng vẫn cần semantic overlay/views thật. USD là định dạng ưu tiên trong RealityKit; Rodin có thể xuất USDZ nhưng asset vẫn phải qua cleanup và profile.

### Vì sao không dùng game engine toàn màn hình

- scene chỉ là trang trí quanh một utility app giàu text và form;
- VoiceOver, Dynamic Type, widget, notification và lifecycle vẫn là lõi;
- game engine không tự giải bài toán pin, input form và accessibility;
- một overlay particle + một prop 3D đạt phần lớn hiệu quả thị giác với ít rủi ro hơn;
- nếu prototype riêng bằng Godot tạo được particle đẹp, có thể dùng nó để **tiền dựng/bake asset**, không nhất thiết ship runtime Godot.

## 12. Ba mức chất lượng và ngân sách

Các con số dưới đây là target ban đầu để profile, không phải giới hạn chính thức của Apple.

| Hạng | Sống động | Êm | Tĩnh |
|---|---|---|---|
| Mặc định | máy đủ khả năng, không Low Power/Reduce Motion | Low Power, thermal fair hoặc người dùng chọn | Reduce Motion/Dim Flashing Lights cần thiết hoặc người dùng tắt |
| Hero intro | 2–4 s | 0.8–1.5 s, ít hạt | crossfade/poster |
| Hạt thấy cùng lúc | khoảng 80–150 | khoảng 20–50 | 0 |
| Live 3D | tối đa 1–2 prop nhỏ | tối đa 1 prop hoặc baked | không |
| Idle | dừng sau 8–12 s | dừng sau 4–6 s | tĩnh |
| Âm nền | Yên ở bản cài mới; phát lựa chọn đã được người dùng bật | ít lớp hơn nếu đang phát | theo lựa chọn âm riêng; không phụ thuộc Reduce Motion |
| Âm giấy/cue sự kiện | tắt mặc định | tắt | tắt |

Mục tiêu chung:

- thời gian tới nội dung ngày không tăng; scene khởi động sau khi text sẵn sàng;
- gesture giấy giữ 60 fps trên thiết bị thấp nhất được hỗ trợ;
- khi effect không đạt frame budget, hạ tầng phải tự giảm hạt/LOD chứ không giảm độ đọc;
- không render animation khi app background, tờ bị che hoặc màn hình đã chuyển sang mặt sau;
- Low Power Mode: giảm display updates/animation; thermal serious: dừng particle và live 3D; critical: tắt toàn bộ trang trí động;
- effect pack 1.0 đặt ngân sách tăng dung lượng tải khoảng 40–60 MB, chỉ nâng sau khi đo chất lượng và kích thước asset thật;
- không tải pack bắt buộc từ mạng trong 1.0; tất cả cảnh cốt lõi hoạt động ở chế độ máy bay.

Apple cho phép ứng dụng đọc trạng thái Low Power Mode và khuyến nghị giảm animation/display updates khi hệ thống cần tiết kiệm hoặc máy nóng: [Responding to power notifications](https://developer.apple.com/documentation/xcode/responding-to-power-notifications).

## 13. Accessibility và an toàn chuyển động

Apple khuyến nghị khi Reduce Motion bật, tránh animation lớn, đặc biệt hiệu ứng giả lập chiều sâu; với chuyển động có ý nghĩa có thể dùng fade/highlight/color shift thay thế: [Reduced Motion evaluation criteria](https://developer.apple.com/help/app-store-connect/manage-app-accessibility/reduced-motion-evaluation-criteria), [SwiftUI `accessibilityReduceMotion`](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/accessibilityReduceMotion).

### Ma trận fallback bắt buộc

| Điều kiện | Điều chỉnh |
|---|---|
| Reduce Motion | bỏ parallax, rơi/xoáy, zoom và page curl mạnh; dùng poster + dissolve ngắn |
| Dim Flashing Lights | bỏ flash trắng, chớp lặp và tương phản sáng tối nhanh; pháo hoa thành bloom màu nước |
| Reduce Transparency | tắt blur/translucency khiến chữ kém rõ; dùng nền đặc |
| Increase Contrast | giảm texture/ánh sáng trên giấy; viền đối tượng rõ hơn |
| VoiceOver | một mô tả ý nghĩa cho cả cảnh; ẩn từng particle/đạo cụ trang trí |
| Large Text | hiệu ứng không chiếm vùng nội dung mở rộng; có thể biến mất hoàn toàn |
| Âm thanh tắt/silent | không mất thông tin hoặc phản hồi duy nhất |

Apple có environment value cho lựa chọn Dim Flashing Lights và hướng dẫn điều chỉnh animation có thể kiểm soát: [Flashing lights](https://developer.apple.com/documentation/MediaAccessibility/flashing-lights), [`accessibilityDimFlashingLights`](https://developer.apple.com/documentation/swiftui/environmentvalues/accessibilitydimflashinglights).

Hiệu ứng pháo hoa phải được test riêng với các tiêu chí:

- không strobe trắng toàn màn hình;
- không nháy lặp nhanh ở ngoại vi;
- không đổi độ sáng của tờ lịch;
- không làm rung/scale số ngày;
- có bản không flash được duyệt bằng mắt, không chỉ giảm opacity của cùng animation.

## 14. Cài đặt người dùng

Trong ngăn giấy, thêm nhóm “Không khí ngày” với ngôn ngữ dễ hiểu:

- **Sống động** — intro đầy đủ một lần/ngày, sau đó lắng;
- **Êm** — ít hạt, ít chiều sâu, thời lượng ngắn;
- **Tĩnh** — minh họa và màu ngày, không chuyển động;
- **Theo cài đặt iPhone** — luôn là ràng buộc ưu tiên; Reduce Motion có thể hạ về Tĩnh dù app đang chọn Sống động;
- **Âm nền tập trung** — Yên, Hiên sớm, Mưa xa hoặc Quạt trưa; bản cài mới chọn Yên cho tới khi Gate 7 có dữ liệu;
- **Âm giấy** — tắt mặc định;
- **Cue sự kiện** — tắt mặc định, không tự bật theo âm nền;
- **Vùng cảm hứng** — Bắc, Trung, Nam, Trung tính; chọn tay, không dùng vị trí;
- **Phát lại hiệu ứng** — action ở từng tờ ngày, không phải công tắc autoplay vô hạn.

Khuyến nghị lần mở đầu: Sống động trên máy đủ khả năng nhưng âm là Yên. Sau khi người dùng chủ động chọn Hiên sớm, âm chỉ fade in khi thiết bị không ở Silent, VoiceOver không đọc và không có audio khác cần ưu tiên. Nút âm luôn thấy trên màn hình lịch. Nếu Reduce Motion đang bật, vào thẳng Tĩnh nhưng không tự thay đổi lựa chọn âm của người dùng.

## 15. Quy trình nghệ thuật và duyệt nội dung

Mỗi cảnh đi qua tám cổng:

1. **Nguồn ngày:** trigger đúng loại lịch, múi giờ và version.
2. **Ý niệm:** một câu mô tả cảm xúc, không liệt kê asset.
3. **Storyboard:** intro–settle–idle–static trong các khung chính.
4. **Art direction:** màu/vật liệu/vùng; tránh cliché và sao chép.
5. **Asset production:** Rodin Image-to-3D từ ảnh đã duyệt/ElevenLabs/đồ họa tự làm với provenance.
6. **Cultural review:** ít nhất một reviewer Việt phù hợp chủ đề/vùng; Quốc kỳ và ngày trang nghiêm kiểm riêng.
7. **Device/accessibility review:** máy thấp, dark/high contrast, Reduce Motion, Dim Flashing Lights, VoiceOver.
8. **License gate:** chỉ pack asset có manifest đầy đủ mới được đưa vào release.

### Hồ sơ asset tối thiểu

| Trường | Ví dụ |
|---|---|
| Asset ID | `prop_peach_branch_north_01` |
| Tác giả/owner | tên người tạo và người duyệt |
| Nguồn đầu vào | concept sheet nội bộ, ảnh tự chụp, giấy phép |
| Công cụ | Rodin Gen-2.5 / ElevenLabs Sound Effects / Blender / thu thật |
| Reference/prompt phụ/seed/model | ID ảnh và quyền; prompt bổ sung nguyên văn; ngày tạo và version nếu có; không có lượt text-only |
| Gói/quyền | plan lúc tạo, Terms snapshot, hạn chế |
| Biên tập | retopo, paint-over, mix, trim, normalize |
| File | master, LOD, texture, audio, poster, checksum |
| Phạm vi | effect IDs, platform, phiên bản app |
| Duyệt | mỹ thuật, văn hóa, accessibility, pháp lý |

## 16. Prototype và kiểm chứng trước code production

### Prototype A — Quốc khánh

- ba mức: poster tĩnh, particle 2D + cờ 2D, particle + cờ live mesh;
- test 8–12 người Việt ở ít nhất hai nhóm tuổi;
- hỏi: nhận ra ngày gì trước khi đọc chữ không, có trang trọng không, cờ có đúng không, chữ có bị che không;
- đo thời gian quay lại đọc ngày và mức khó chịu vì flash/chuyển động.

### Prototype B — Lập Xuân

- so sánh đào Bắc, mai Nam và phiên bản trung tính;
- test “cánh hoa 4–8” với “mưa hoa dày” để xác nhận ngưỡng tiết chế;
- hỏi xem cảnh nói “đầu xuân” hay chỉ giống theme Tết;
- kiểm tra người dùng có hiểu đây là cảm hứng tiết khí chứ không phải thời tiết thật.

### Prototype C — ngày thường

- cho dùng 7 ngày liên tiếp với 5 vi cảnh;
- đo lúc nào chuyển động trở nên phiền hoặc mất mới lạ;
- test intro chỉ một lần/ngày so với mỗi lần mở;
- kiểm tra thời gian mở, pin và nhiệt trên thiết bị mục tiêu.

### Cổng quyết định

Một cảnh chỉ vào 1.0 nếu:

- ít nhất 80% người thử nhận ra đúng sắc thái/sự kiện hoặc mô tả gần đúng;
- 90% đọc được ngày dương và âm trong 5 giây dù cảnh đang chạy;
- không ai phát hiện lỗi Quốc kỳ hoặc biểu tượng nhạy cảm sau review chuyên biệt;
- bản Reduce Motion/Dim Flashing Lights vẫn đẹp và truyền được ý nghĩa;
- không làm tụt dưới target frame trên thiết bị thấp nhất;
- asset license manifest đầy đủ;
- âm thanh được ít nhất 70% người bật thử đánh giá là “nhẹ/vừa”, không giật mình.

## 17. Phạm vi khuyến nghị

### Bắt buộc cho 1.0

- Effect Director + resolver và manifest versioned;
- Quốc khánh và Lập Xuân ở mức flagship;
- 4 cảnh lễ lớn khác;
- 24 tiết khí dùng 6 họ chuyển động có biến thể;
- ngày thường có vi cảnh tĩnh/nhẹ theo seed;
- ba mức Sống động/Êm/Tĩnh;
- Reduce Motion, Dim Flashing Lights, Low Power và static poster;
- asset/license provenance cho Rodin và ElevenLabs;
- toàn bộ asset chạy offline; bản cài mới chọn Yên, âm giấy và cue sự kiện tắt mặc định.

### Nên hoãn sau 1.0

- tải thêm theme pack qua mạng;
- scene 3D toàn phòng hoặc AR;
- weather thật theo vị trí;
- người dùng tự nhập prompt sinh scene;
- TTS đọc lời hay nhân vật dẫn chuyện;
- hiệu ứng riêng cho đủ 365 ngày;
- marketplace asset/chủ đề;
- livestream hoặc nội dung được cập nhật từ server.

## 18. Kết luận

ElevenLabs và Rodin giúp nâng chất lượng, nhưng lợi thế không nằm ở việc “có AI”. Lợi thế là một hệ đạo diễn biết **ngày nào cần vui, ngày nào cần lắng, cái gì được chuyển động và lúc nào phải dừng**.

Quyết định thiết kế mạnh nhất là:

- 2/9: pháo hoa là particle 2D; cờ là mesh dựng tay; Rodin Image-to-3D chỉ hỗ trợ cột/khánh từ ảnh đã duyệt; ElevenLabs tạo bản nháp âm pháo xa;
- Lập Xuân: cành được tạo phôi bằng Rodin Image-to-3D từ concept đã duyệt; cánh hoa là particle; hiệu ứng có biến thể vùng;
- mọi thứ generate trước, được người duyệt, đóng gói local;
- không dùng AI/runtime network, không phá lời hứa miễn phí–offline;
- vẻ đẹp nằm ở nhịp mở–lắng–nghỉ, không ở số polygon hay số hạt.
