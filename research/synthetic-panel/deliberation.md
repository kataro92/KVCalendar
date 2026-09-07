# Biên bản hội đồng persona tổng hợp

**Ngày chạy:** 07/09/2026
**Phạm vi:** 11 câu hỏi nghiên cứu trực tiếp trong `docs/01-nghien-cuu-thi-truong.md`
**Đầu vào:** `research/desk-research/evidence-register.md`, `research/synthetic-panel/method.md`, `research/synthetic-panel/personas.md`, Design Master và feature spec 1.0
**Trạng thái:** desk research đã thực hiện; Gate 1–7 chưa kiểm thử

Hội đồng này dùng tám proto-persona P1–P8 để tìm xung đột trong đặc tả. Các persona không phải người tham gia nghiên cứu. Biên bản không chứa lời thoại giả, số phiếu, tỷ lệ đồng thuận hoặc kết quả usability mô phỏng.

Mỗi nhận định mang một nhãn:

- `OBS`: quan sát trực tiếp từ nguồn trong evidence register;
- `INF`: suy luận có đường dẫn về một hoặc nhiều `OBS`;
- `HYP`: giả thuyết để mang đi test;
- `DEC`: quyết định sản phẩm hoặc guardrail;
- `OPEN`: chưa có bằng chứng để chọn.

Mức chứng cứ dùng đúng định nghĩa trong `method.md`: **Cao**, **Vừa**, **Thấp**, **Không có**. Mức này đánh giá nền chứng cứ, không phải xác suất người dùng đồng ý.

## Vòng 1: walkthrough riêng theo 11 câu hỏi

### Q1. Người dùng có muốn bóc mỗi ngày hay chỉ thích nhìn kiểu lịch bloc?

- `OBS · Vừa`: App Store và tài liệu lịch bloc cho thấy hình thức bloc đã được nhiều sản phẩm dùng. Không nguồn nào quan sát tần suất bóc trên điện thoại. Xem E03–E05.
- `INF · Vừa`: Cử chỉ bóc có thể tạo khác biệt cảm xúc, nhưng widget và xem nhanh mới là mức kỳ vọng cơ bản của category.
- `HYP · Thấp`: P1 có thể xem bóc là một nghi thức ngắn. P2 và P7 ưu tiên đọc ngày hoặc dùng nút. P3 có thể chú ý hiệu ứng ở lần đầu nhưng không chắc lặp hằng ngày.
- `DEC · Cao`: Bóc không được là đường duy nhất. Luôn có Ngày trước, Ngày sau và Hôm nay bằng thao tác chạm cùng accessibility action.
- `OPEN · Không có`: Chưa biết người dùng có chủ động bóc, dùng bao lâu rồi bỏ, hay chỉ thích vật thể bloc ở trạng thái tĩnh.

### Q2. Người dùng xem lịch trong bối cảnh nào?

- `OBS · Vừa`: Review và version history hỗ trợ hai tình huống gián tiếp: liếc qua widget và chuẩn bị ngày gia đình. Không có quan sát tại nhà, bàn thờ, lớp học hoặc nơi làm việc. Xem E04–E06.
- `INF · Vừa`: Walkthrough cần phủ nhiều nhịp sử dụng thay vì giả định mọi phiên đều bắt đầu vào buổi sáng.
- `HYP · Thấp`: P1 soi phiên mở ngắn khi đi học; P2 soi luồng widget và tra nguồn; P5 soi việc gia đình; P4 soi chênh ngày giữa hai múi giờ; P8 soi phiên cần yên tĩnh.
- `DEC · Vừa`: Prototype phải có ít nhất ba kịch bản riêng: liếc nhanh, tra một ngày để lập kế hoạch và chuẩn bị một việc gia đình.
- `OPEN · Không có`: Chưa biết bối cảnh nào xuất hiện thường xuyên nhất hoặc có tình huống trước bàn thờ hay không.

### Q3. Thông tin nào phải ở mặt trước, trường nào có thể ở mặt sau?

- `OBS · Vừa`: Lịch bloc và widget trên thị trường thường đặt ngày dương, ngày âm và thứ ở lớp nhìn nhanh; nhiều app đưa Can Chi, tiết khí, tốt/xấu và sự kiện vào phần sâu hơn. Đây là cấu trúc sản phẩm, chưa phải ưu tiên của người dùng Lịch Nhà. Xem E03–E05.
- `INF · Vừa`: Số ngày dương, thứ, tháng/năm, ngày âm và một dòng sự kiện là bộ khung hợp lý để thử trước. Nguồn, ruleset và nội dung dài phù hợp với mặt sau.
- `HYP · Thấp`: P2 cần ngày âm và dấu nguồn; P5 cần nhận ra sự kiện gia đình nhưng có rủi ro riêng tư; P6 muốn tóm tắt tốt/xấu; P7 cần ít trường để giữ chữ lớn; P4 cần dấu chênh múi giờ khi có liên quan.
- `DEC · Cao`: Số ngày và ngày âm giữ thứ bậc cao hơn decoration. Nội dung phụ phải reflow sang mặt sau trước khi thu nhỏ hai trường này.
- `OPEN · Không có`: Chưa biết Can Chi, tiết khí, tốt/xấu hay sự kiện là trường thứ tư người dùng muốn thấy nhất.

### Q4. “Ngày tốt/xấu” được dùng để tham khảo hay để ra quyết định?

- `OBS · Vừa`: Đối thủ chào bán luồng chọn ngày cho cưới hỏi, khai trương và các việc lớn. Marketplace không cho biết người dùng làm theo kết quả đến mức nào. Xem E01–E04.
- `INF · Vừa`: Sản phẩm phải chịu được cả người chỉ tò mò và người xem thông tin này trước một quyết định thật.
- `HYP · Thấp`: P6 dùng như thông tin văn hóa; P5 có thể đối chiếu với nếp nhà; P2 muốn kiểm tra khi hai nguồn lệch. Các hướng này cố ý không được hợp nhất thành một hành vi “điển hình”.
- `DEC · Cao`: Dùng nhãn “tham khảo theo lịch truyền thống”, nêu ruleset và owner, cho tắt lớp almanac. Không viết lời khuyên cá nhân hóa hoặc ngôn ngữ bảo đảm kết quả.
- `OPEN · Không có`: Chưa biết người dùng đặt trọng số bao nhiêu cho lớp này, và mặt trước có cần dòng tóm tắt hay không.

### Q5. Pastel và mức dễ thương nào là tinh tế, mức nào giống app trẻ em?

- `OBS · Vừa`: Free/no-ads/offline, sơn son và hình thức bloc đã xuất hiện ở đối thủ. Không có dữ liệu công khai đáng tin về sở thích pastel của nhóm 16–34. Xem E03, E06.
- `INF · Vừa`: Mộc Son Dịu không thể khác biệt chỉ bằng son đỏ, vàng đồng hoặc chữ “truyền thống”. Tỷ lệ, khoảng trắng, vật liệu, minh họa và chuyển động phải tạo thành một hệ thống riêng.
- `HYP · Thấp`: P3 chấp nhận pastel ít bão hòa, bề mặt mờ và một minh họa nhỏ; P7 cần bố cục giữ được chữ lớn; P8 phản đối mascot hoặc chi tiết chuyển động liên tục; P1 soi khả năng dùng cạnh bàn học.
- `DEC · Vừa`: Tiếp tục so sánh Mộc Son Dịu, Giấy Mộc và Gốm Lam. Loại claymorphism dày, chibi phủ màn hình, palette kẹo và sticker xếp thành dashboard.
- `OPEN · Không có`: Chưa có ngưỡng màu, kích thước minh họa hoặc lượng họa tiết được người trẻ gọi là “vừa đủ”.

### Q6. Gia đình xử lý giỗ ở tháng nhuận hoặc ngày 30 của tháng thiếu thế nào?

- `OBS · Vừa`: Lịch Việt có tháng 29 hoặc 30 ngày. E10 ghi một thông lệ Phật giáo cho giỗ trong tháng trùng tên của năm nhuận. Nguồn này không đại diện mọi gia đình và không giải quyết ngày 30 của tháng thiếu.
- `INF · Cao`: Một default mang tên “đúng phong tục” sẽ biến một thông lệ thành quy tắc phổ quát.
- `HYP · Thấp`: P5 cần chọn giữa tháng thường, tháng nhuận hoặc cả hai; với ngày 30, gia đình có thể chọn ngày cuối tháng, bỏ năm đó hoặc chuyển sang mùng 1. Đây là các nhánh thiết kế, không phải tập quán đã quan sát.
- `DEC · Cao`: Lưu policy rõ ràng, đọc lại lựa chọn trước khi lưu và cho sửa. Không tự chọn policy theo vùng, tuổi hoặc tôn giáo suy đoán.
- `OPEN · Không có`: Chưa biết cách nào phổ biến, cách gọi nào dễ hiểu và khi nào người dùng muốn hỏi người lớn trong nhà trước khi lưu.

### Q7. Người sống ngoài Việt Nam muốn ngày đổi theo nơi ở hay UTC+7?

- `OBS · Cao`: UTC+7 là giờ chính thức dùng cho ruleset lịch Việt hiện đại. Cộng đồng Việt ở nước ngoài vẫn duy trì thực hành gia đình, nhưng nguồn không ghi preference về ngày hiển thị hoặc giờ nhắc. Xem E07, E08, E13.
- `INF · Cao`: Calendar ruleset, ngày dân sự đang hiển thị và giờ giao notification là ba lớp khác nhau. Gộp chúng vào một timezone sẽ tạo lỗi quanh nửa đêm và DST.
- `HYP · Thấp`: P4 cần ngày hiện tại theo California nhưng có thể muốn xem “Nhịp Việt Nam” khi phối hợp với gia đình. P5 quan tâm ngày nghi lễ theo lịch Việt hơn vị trí thiết bị.
- `DEC · Vừa`: Giữ UTC+7 trong Calendar Core; lưu notification zone bằng ID IANA; policy “hôm nay local, có Nhịp Việt Nam” vẫn là quyết định tạm thời theo E14.
- `OPEN · Không có`: Chưa biết default nào ít gây nhầm nhất, cách đặt tên hai nhịp ngày và cách người dùng hiểu ngày âm khi hai nơi đã khác ngày.

### Q8. Nền “Hiên sớm” giúp dễ chịu hay làm mất tập trung?

- `OBS · Cao`: Meta-analysis E15 không ủng hộ lợi ích phổ quát của white/pink noise. Apple yêu cầu audio không thiết yếu tôn trọng Silent, audio khác và thao tác người dùng. Không nguồn nào đo “Hiên sớm”.
- `INF · Cao`: Không có cơ sở cho autoplay mặc định hoặc lời hứa tăng tập trung khi Gate 7 chưa chạy.
- `HYP · Thấp`: P1 có thể dùng âm trong lúc học nếu tự bật; P8 cần yên và control trực tiếp; P2 có thể đang nghe nội dung khác. Các persona chỉ xác định case cần thử.
- `DEC · Cao`: Release giữ **Yên** làm âm mặc định; Hiên sớm chỉ opt-in nếu chưa có Gate 7A–7B với người thật. Âm giấy và cue sự kiện tiếp tục tắt mặc định. Mọi bus tuân thủ Silent, VoiceOver, interruption và headphone route.
- `OPEN · Không có`: Tỷ lệ tắt trong 10 giây, mức mệt tai, khả năng nhận ra loop và tác động lên tác vụ đều chưa biết.

### Q9. Mức họa tiết nào tạo cảm giác Việt mà không bị “sến”?

- `OBS · Vừa`: Khánh, xấp giấy, ốc và thứ bậc số ngày là pattern của lịch bloc. Sơn son và vàng đồng không còn là dấu hiệu riêng của Lịch Nhà. Xem E03, E04.
- `INF · Vừa`: Bản sắc có thể đến từ cấu trúc vật thể, chất liệu và nhịp sử dụng trước khi thêm motif. Nhiều biểu tượng cùng lúc làm tăng nguy cơ trang trí du lịch hoặc giả cổ.
- `HYP · Thấp`: P3 soi phương án một motif có chọn lọc; P7 soi độ đọc khi texture bị bỏ; P1 soi minh họa giấy cắt nhỏ; P8 soi particle và chuyển động ngoại vi.
- `DEC · Vừa`: Giữ nguyên tắc “một tờ, một điểm”. Quốc kỳ, vật phẩm thờ cúng và biểu tượng nhạy cảm không được biến thành mascot hoặc decoration lặp.
- `OPEN · Không có`: Chưa biết motif nào gợi Việt Nam cho nhóm chính, chi tiết nào bị gọi là sến và sự khác nhau giữa người lớn lên ở các vùng.

### Q10. Nguồn và phương pháp làm tăng tin tưởng hay gây rối?

- `OBS · Vừa`: Nghiên cứu transparency cho thấy lượng thông tin phù hợp phụ thuộc tác vụ và tải nhận thức. E18–E19 cũng yêu cầu minh bạch về nguồn của persona. Chưa có nghiên cứu tương ứng với lịch âm Việt Nam.
- `INF · Vừa`: Progressive disclosure hợp với xung đột giữa lượt xem nhanh và nhu cầu kiểm tra phương pháp.
- `HYP · Thấp`: P2 muốn mở nguồn khi lịch lệch; P6 cần ruleset và mức chắc chắn; P7 cần mặt trước ít chữ; P5 cần phân biệt ngày chính thức với nội dung phong tục.
- `DEC · Vừa`: Prototype một nhãn ngắn ở mặt trước, chi tiết nguồn/ruleset/version ở mặt sau và trang nguồn đầy đủ. Không dùng huy hiệu nguồn như bằng chứng rằng nội dung chắc chắn đúng.
- `OPEN · Không có`: Chưa biết nhãn nào được hiểu đúng, người dùng có tìm nguồn không và nguồn làm tăng trust hay chỉ tạo cảm giác nặng.

### Q11. Người lớn tuổi có dùng được giao diện trẻ mà không đổi toàn bộ phong cách không?

- `OBS · Cao`: Apple yêu cầu text scaling, VoiceOver, thao tác thay thế và thông tin không phụ thuộc một kênh cảm nhận. Review thị trường có tín hiệu về chữ và lịch tháng cho người lớn tuổi. Xem E04 và tài liệu HIG đã dẫn trong Design Master.
- `INF · Vừa`: Custom art direction có thể giữ lại nếu semantic controls, reflow và focus order nằm ngoài lớp vẽ trang trí.
- `HYP · Thấp`: P7 soi chữ 200%, Increase Contrast, nút có nhãn và độ chính xác khi chạm. P3 là đối trọng để tránh biến accessibility thành một theme hình ảnh khác.
- `DEC · Cao`: Giữ cùng ngôn ngữ Mộc Son Dịu; reflow nội dung, ẩn decoration khỏi accessibility tree và cung cấp action không kéo. Canvas hoặc scene không được giữ semantics cốt lõi.
- `OPEN · Không có`: Chưa biết người 55+ hoặc người dùng VoiceOver có hoàn thành tác vụ, hiểu IA và thấy giao diện thoải mái hay không.

## Vòng 2: ma trận mâu thuẫn

Không có “bên thắng” trong vòng này. Mỗi dòng ghi phần đã có thể khóa và phần cần giữ mở.

| Mâu thuẫn | Persona soi chính | Phần còn đứng vững | Bất đồng chưa giải | Mức chứng cứ |
|---|---|---|---|---|
| Nghi thức bóc với tốc độ xem nhanh | P1 đối chiếu P2, P7 | Bóc là optional path; nút và widget không phụ thuộc cử chỉ | Giá trị lặp hằng ngày của nghi thức | Cao cho thao tác thay thế; Không có cho preference |
| Mặt trước yên với nhiều trường lịch | P2, P5, P6, P7 | Ngày dương và ngày âm giữ ưu tiên; nguồn dài ở mặt sau | Can Chi, tiết khí hay tốt/xấu có ở mặt trước không | Vừa |
| Pastel/dễ thương với vẻ trưởng thành | P3 đối chiếu P7, P8 | Tương phản, khoảng trắng và một điểm nghệ thuật giữ nguyên | Ranh giới pastel và kích thước minh họa | Thấp |
| Nguồn chi tiết với tải nhận thức | P2, P6 đối chiếu P7 | Thử progressive disclosure | Câu nhãn và độ sâu người dùng muốn | Vừa cho hướng prototype; Không có cho hiệu quả |
| UTC+7 với “hôm nay” địa phương | P4 đối chiếu P5 | Tách ruleset, display day và notification zone | Default và tên gọi hai nhịp ngày | Cao cho kiến trúc thời gian; Thấp cho policy UX |
| Một quy tắc giỗ với nếp riêng từng nhà | P5 | Cho chọn, đọc lại và sửa policy | Default tháng nhuận/ngày thiếu | Cao cho guardrail; Không có cho tập quán phổ biến |
| Không khí âm thanh với quyền được im lặng | P1 đối chiếu P8, P2 | Tôn trọng hệ thống, control trực tiếp và bus tách biệt | Mức dễ chịu, loop fatigue, lựa chọn lần sau | Cao cho audio behavior; Không có cho preference |
| Scene sự kiện với độ đọc và sự trang trọng | P3 đối chiếu P7, P8 | Một hero, safe zone, Reduce Motion và poster | Cường độ scene được chấp nhận | Cao cho safety; Thấp cho mỹ thuật |
| Pháo hoa Quốc khánh với tính đúng ngữ cảnh | P3, P8 | Cờ dựng tay theo nguồn pháp lý; pháo hoa chỉ là lớp liên tưởng | Có nên dùng pháo hoa mặc định khi không phải nơi nào cũng tổ chức | Cao cho hình học cờ; Vừa cho liên tưởng; Không có cho preference |
| Lập Xuân thiên văn với hình ảnh hoa nở | P3, P4 | Ghi Lập Xuân là mốc tiết khí; không mô tả như dự báo thời tiết | Đào, mai hay cảnh trung tính theo vùng cảm hứng | Cao cho dữ kiện thiên văn; Thấp cho art direction |
| Định vị người trẻ với accessibility người lớn tuổi | P3 đối chiếu P7 | Một design language, nhiều cách tương tác và reflow | Usability thật ở chữ lớn/VoiceOver | Cao cho requirement; Không có cho task success |
| Sự kiện riêng trên widget với xem nhanh | P2, P5 | Ẩn tên/ghi chú trên Lock Screen theo mặc định | Mức preview người dùng muốn trên Home Screen | Vừa |

## Vòng 3: quyết định sau phản biện

### Adopt

Các quyết định dưới đây có nguồn đủ mạnh hoặc là guardrail ít hối tiếc:

| Quyết định | Căn cứ | Confidence |
|---|---|---|
| Bỏ claim “đầu tiên”, “duy nhất” và mọi câu ngụ ý free/no-ads/offline hay sơn son là lợi thế chưa có đối thủ | E01–E04 | Cao |
| Xem widget và reminder âm lịch là mức kỳ vọng cơ bản, không phải điểm khác biệt trung tâm | E04–E05 | Vừa |
| Gesture bóc luôn có action chạm tương đương; semantics cốt lõi không nằm trong scene/Canvas | HIG, Design Master | Cao |
| Calendar Core dùng UTC+7; display day và notification zone là lớp riêng | E07–E09, E14 | Cao |
| Không có một default mang tên “đúng phong tục” cho giỗ tháng nhuận hoặc ngày 30 tháng thiếu | E08, E10 | Cao |
| Tốt/xấu là lớp tham khảo có ruleset, owner, source và công tắc tắt | Product safety, spec | Cao |
| Quốc kỳ được dựng và duyệt thủ công theo nguồn pháp lý; không tạo sinh, mirror, crop hoặc làm particle | E11 | Cao |
| Lập Xuân được mô tả là mốc thiên văn, không dùng như lời khẳng định thời tiết hay hoa nở | E09 | Cao |
| Nếu Gate 7 chưa có dữ liệu người thật, âm nền phát hành là opt-in; âm giấy và cue sự kiện tắt mặc định | E15–E16 | Cao |

### Prototype

Các hướng sau đủ cơ sở để dựng phương án so sánh, chưa đủ để chọn default lâu dài:

| Phương án cần dựng | Điều cần soi | Confidence |
|---|---|---|
| Bloc tĩnh, bóc nhẹ và bóc rõ với cùng nội dung | Nhận diện hành động, thời gian, khó chịu và giá trị nghi thức | Thấp |
| Ba mặt trước có mật độ khác nhau | Trường người dùng tìm đầu tiên và trường có thể đẩy ra sau | Thấp |
| Mộc Son Dịu, Giấy Mộc và Gốm Lam | Trẻ, Việt, dịu, rõ; đồng thời soi “trẻ con”, “sến”, “giả cổ” | Thấp |
| Nhãn provenance ngắn, provenance ở mặt sau và trang nguồn | Comprehension và số thao tác tìm nguồn | Vừa |
| “Hôm nay tại đây” với tùy chọn “Nhịp Việt Nam” | Mental model quanh nửa đêm và DST | Thấp |
| Chọn tháng thường, tháng nhuận, cả hai; ba policy cho ngày 30 | Ngôn ngữ đọc lại, khả năng sửa và mức do dự | Thấp |
| Quốc khánh có pháo hoa xa và biến thể tĩnh trang trọng | Độ đọc, liên tưởng đúng và mức trang trọng | Thấp |
| Lập Xuân có đào, mai và bản trung tính | Nhận diện tiết khí mà không biến thành dự báo thời tiết theo vùng | Thấp |
| Yên, Hiên sớm và Mưa xa trong blind test | Hành vi tắt, mệt tai, loop và ảnh hưởng tới tác vụ | Không có trước test |

### Hold

Chưa đưa các điểm này thành claim, default hoặc mở rộng production:

- Không nói người 16–34 thích pastel, cute hoặc bóc lịch.
- Không nói người dùng mở lịch chủ yếu vào buổi sáng, trước bàn thờ hoặc trong lúc học.
- Không đưa tốt/xấu lên mặt trước chỉ vì đối thủ có.
- Không chọn một policy giỗ theo tháng nhuận/ngày thiếu cho mọi gia đình.
- Không mô tả local-day policy của diaspora như nhu cầu đã xác nhận.
- Không tự bật Hiên sớm trong bản phát hành khi chưa có Gate 7.
- Không sản xuất bốn cảnh lễ và sáu họ tiết khí trước khi hai flagship cùng ngày thường qua review.
- Không dùng số persona, số ý kiến mô phỏng hoặc cách viết của agent để tạo “consensus”.

### Human gate

Những kết luận sau chỉ được nâng khỏi `OPEN` bằng người thật, prototype quan sát được hoặc kiểm thử trên thiết bị:

- tần suất và giá trị của hành động bóc;
- bối cảnh sử dụng thực tế;
- thứ tự trường ở mặt trước;
- mức ảnh hưởng của tốt/xấu lên quyết định;
- ranh pastel, dễ thương, Việt, sến và trẻ con;
- quy ước giỗ của từng gia đình;
- preference ngày local/UTC+7 của diaspora;
- cảm giác, mệt tai và hành vi tắt âm;
- trust/comprehension khi thấy nguồn;
- task success với người 55+, VoiceOver, chữ 200% và motor accessibility;
- nhận diện, độ đọc và sự trang trọng của scene Quốc khánh/Lập Xuân;
- frame pacing, nhiệt, pin và audio interruption trên thiết bị thật.

## Trạng thái Gate 1–7

| Gate | Trạng thái | Panel đã hỗ trợ gì | Bằng chứng còn thiếu |
|---|---|---|---|
| Gate 1: concept | **UNTESTED** | Xác định ba concept và từ khóa phản biện | Nhận diện không gợi ý và mô tả tự do từ người thật |
| Gate 2: gesture | **UNTESTED** | Khóa yêu cầu action thay thế; liệt kê xung đột nghi thức/tốc độ | Task success, thời gian, lỗi chạm và khó chịu trên prototype tương tác |
| Gate 3: thông tin | **UNTESTED** | Đề xuất ba mức mật độ và progressive disclosure | Đọc đúng trong 5 giây, trường bị thiếu và comprehension nhãn tham khảo |
| Gate 4: ngày giỗ | **UNTESTED** | Ngăn một policy giả làm phong tục chung; chuẩn bị các nhánh lựa chọn | Hoàn thành luồng, cách gia đình xử lý và mental model khi từ chối notification |
| Gate 5A: accessibility research | **UNTESTED** | Rà requirement, semantics và thao tác thay thế trên giấy | Người dùng VoiceOver/55+, build có semantics thật, chữ 200% và thiết bị cho Gate 5B |
| Gate 6A: effect research | **UNTESTED** | Rà tính đúng của cờ, Lập Xuân và giới hạn pháo hoa; giữ fallback | Nhận diện sắc thái, độ đọc, cultural review và performance máy thật cho Gate 6B |
| Gate 7A: audio research | **UNTESTED** | Giữ Yên là release default an toàn; rà audio behavior | File nghe, blind test 10–15 phút, hành vi tắt và test interruption cho Gate 7B |

Không task T012–T016 nào được đánh dấu hoàn tất từ biên bản này. T020 và Definition of Ready vẫn bị chặn cho tới khi có bằng chứng đúng loại hoặc chủ dự án sửa rõ quy trình gate. Kết quả hiện tại chỉ đủ để cập nhật giả thuyết, thu hẹp prototype và loại các claim không có căn cứ.
