# 00 — Định hướng sản phẩm

## 1. Tuyên ngôn

**Lịch Nhà là quyển lịch bloc Việt Nam dành cho iPhone: đẹp như một vật trong nhà, nhanh như một widget, đáng tin như một công cụ ngày tháng.**

Sản phẩm không cố nhét mọi thứ liên quan tới tử vi, bói toán, thời tiết, xổ số và tin tức vào cùng một nơi. Nó tập trung vào ba việc:

1. Cho người dùng biết hôm nay là ngày nào — dương lịch, âm lịch và thông tin truyền thống cần thiết — trong chưa đầy một giây.
2. Giữ lại nghi thức rất Việt Nam: nhìn tờ lịch, bóc một ngày đã qua, đọc một câu ngắn và cảm nhận thời gian trôi.
3. Giúp gia đình không quên ngày giỗ, rằm, mùng một, lễ Tết và sự kiện riêng mà không đánh đổi sự riêng tư.

## 2. Vấn đề thật cần giải quyết

Nỗi khó chịu “quảng cáo hoặc phải nâng cấp” là điểm khởi đầu, nhưng không đủ làm chiến lược dài hạn. Tại thời điểm nghiên cứu đã có ứng dụng trên App Store tự mô tả là miễn phí, không quảng cáo và offline. Nếu chỉ bỏ quảng cáo rồi làm lại giao diện lịch tháng thông thường, sản phẩm sẽ nhanh chóng trở thành một bản sao ít tính năng hơn.

Vấn đề sâu hơn là:

- ứng dụng lịch âm hiện nay thường giống một cổng nội dung; ngày tháng bị bao quanh bởi rất nhiều dịch vụ;
- thông tin “tốt/xấu” thường được trình bày như kết quả chắc chắn, trong khi phương pháp và nguồn ít khi hiện rõ;
- hình thức “đậm chất Việt” dễ bị giản lược thành đỏ–vàng, rồng, hoa mai và họa tiết dày đặc;
- người dùng lớn tuổi cần chữ to và thao tác dễ, nhưng UI nhiều tab/thẻ nhỏ tạo gánh nặng;
- widget và nhắc lịch âm là nhu cầu thực dụng mạnh, nhưng nếu làm muộn sẽ khiến app chính dù đẹp vẫn ít được dùng hằng ngày.

## 3. Định vị

### Câu định vị

Dành cho người Việt muốn xem ngày âm hằng ngày mà không bị quảng cáo làm phiền, Lịch Nhà là ứng dụng lịch bloc số tái tạo cảm giác quyển lịch treo tường quen thuộc, đồng thời cung cấp dữ liệu có nguồn, nhắc ngày giỗ và widget riêng tư, offline.

### Không định vị là

- “siêu ứng dụng phong thủy”;
- nơi đọc tin, xem video, nghe nhạc, xổ số hoặc thời tiết;
- công cụ đưa ra quyết định cưới hỏi, y tế, tài chính hay pháp lý;
- bản sao giao diện hoặc nội dung của Lịch Việt, Vạn Niên Lịch hay một nhà xuất bản lịch bloc;
- trò mô phỏng 3D nặng máy chỉ để gây ấn tượng; hiệu ứng theo ngày là một lớp đạo diễn ngắn quanh quyển lịch, không phải game scene toàn màn hình.

## 4. Năm nguyên tắc không thương lượng

### 4.1. Hôm nay là trung tâm

Mở ứng dụng đi thẳng vào tờ hôm nay. Không splash quảng cáo, không onboarding nhiều trang, không bảng tin. Thời gian tới nội dung hữu ích đầu tiên phải dưới một giây trên thiết bị mục tiêu.

### 4.2. Vật lý có chủ đích

Giấy, mép xé, bóng đổ, độ dày và phản hồi rung đều phục vụ ẩn dụ “lịch bloc”. Không làm vật lý để khoe kỹ thuật. Một người chưa từng dùng app vẫn phải đoán được cách lật/bóc và cách quay lại.

### 4.3. Sự thật và truyền thống được phân biệt

Ngày dương, ngày âm, tiết khí, ngày nghỉ chính thức và nội dung dân gian không cùng một mức chắc chắn. UI, ngôn ngữ và trang nguồn phải nói rõ khác biệt đó.

### 4.4. Miễn phí là lời hứa sản phẩm

Không quảng cáo, không thuê bao, không mua trong ứng dụng, không bán dữ liệu, không tính năng “Pro”. Nếu sau này cần tài trợ, chỉ dùng tài trợ công khai không làm thay đổi trải nghiệm và không thu thập dữ liệu người dùng.

### 4.5. Trẻ trong thẩm mỹ, rộng trong khả năng tiếp cận

Hình ảnh và giọng sản phẩm được thiết kế trước cho người 16–34 tuổi quan tâm lịch âm Việt Nam. Người lớn tuổi vẫn phải đọc và thao tác được; người dùng VoiceOver vẫn có đầy đủ hành động. Accessibility mở rộng khả năng sử dụng nhưng không biến giao diện mặc định thành “chế độ cho các cụ”.

## 5. Đối tượng và việc cần làm

Đây là **giả thuyết phân khúc**, cần xác nhận bằng nghiên cứu người dùng trước khi code.

### Nhóm chính A — người trẻ đưa lịch âm vào đời sống số

Khoảng 16–34 tuổi, quen điện thoại, để ý thẩm mỹ và muốn hiểu ngày âm, tiết khí, ngày lễ hoặc nếp nhà mà không phải dùng một app rối, nặng màu mê tín hoặc dành cho người cao tuổi.

Việc cần làm:

- xem ngày âm trong vài giây;
- hiểu ngắn gọn ý nghĩa một ngày lễ hoặc tiết khí;
- đặt lịch cạnh bàn học/làm việc như một vật nền dễ chịu;
- dùng widget và chia sẻ một tờ lịch đẹp mà không có watermark quảng cáo;
- đặt nhắc ngày gia đình khi cần, không phải học thuật ngữ lịch pháp trước.

### Nhóm phụ B — người giữ nhịp gia đình

Thường từ 35–54 tuổi, chịu trách nhiệm nhớ ngày giỗ, lễ cúng, rằm/mùng một và lịch gia đình.

Việc cần làm:

- nhìn nhanh ngày âm hôm nay và ngày sắp tới;
- đặt nhắc lặp theo âm lịch mà không phải quy đổi mỗi năm;
- tin rằng app không âm thầm thu thập thông tin gia đình;
- chia sẻ thông tin ngày cho người thân mà không cần tài khoản.

### Nhóm accessibility C — người lớn tuổi dùng iPhone

Không nhất thiết quen gesture hoặc thuật ngữ công nghệ.

Việc cần làm:

- số ngày thật lớn;
- vùng chạm rộng, chữ rõ, không có biểu tượng bí hiểm;
- luôn có nút “Hôm nay” và đường lui;
- có chế độ chữ lớn, giảm chuyển động và bỏ âm thanh;
- không bị ép cấp quyền ngay lần mở đầu.

## 6. Đề xuất giá trị

| Trụ cột | Giá trị cho người dùng | Cách chứng minh |
|---|---|---|
| Cảm giác | “Đây là quyển lịch trong nhà tôi, không phải một dashboard.” | Prototype bóc lịch, test nhận diện không cần giải thích |
| Nhanh | Mở là thấy ngày, widget nhìn một lần là hiểu | Đo thời gian tới nội dung, test 5 giây |
| Tin | Biết dữ liệu nào là thiên văn, pháp lý, biên tập hay dân gian | Nhãn nguồn, phiên bản dữ liệu, bài kiểm thử công khai |
| Riêng tư | Không cần tài khoản, không gửi ngày giỗ lên máy chủ | Kiến trúc offline, App Privacy “không thu thập” nếu thực tế đúng |
| Trọn vẹn | Không quảng cáo, paywall hoặc giới hạn sự kiện | Không tích hợp ad/IAP SDK, lời hứa công khai |

## 7. Phạm vi đề xuất

### Bản 1.0 — phải có

- tờ lịch hôm nay với ngày dương lớn, ngày âm, thứ, tháng/năm, Can Chi, tiết khí hoặc sự kiện nổi bật;
- “Nhịp Nhà”: hiệu ứng mùa/sự kiện có intro ngắn, trạng thái nghỉ và poster tĩnh; tối thiểu có cảnh flagship Quốc khánh, Lập Xuân cùng một gói ngày lễ/24 tiết khí đã duyệt;
- chuyển ngày bằng vuốt và bóc tờ; có nút/ngữ nghĩa tương đương cho accessibility;
- xem tháng dạng tờ gấp, chọn ngày và quay lại hôm nay;
- mặt sau chi tiết ngày với giờ hoàng đạo, Can Chi, tiết khí và nội dung tham khảo có nguồn;
- đổi âm ↔ dương;
- sự kiện cá nhân theo dương hoặc âm, lặp hằng năm, xử lý tháng nhuận/ngày 30 rõ ràng;
- nhắc rằm, mùng một, ngày giỗ và sự kiện cá nhân bằng thông báo cục bộ;
- widget màn hình chính và màn hình khóa tối thiểu cho “hôm nay”;
- chế độ chữ lớn, Reduce Motion, VoiceOver, tương phản cao;
- hoạt động offline, không tài khoản, không analytics bên thứ ba;
- trang “Nguồn và phương pháp”.

### Sau 1.0 — chỉ làm khi lõi đã tốt

- iPad với bố cục “lịch treo trong gian phòng” hoặc split view;
- nhiều khánh lịch/chủ đề do họa sĩ Việt Nam thực hiện;
- chia sẻ ảnh tờ lịch có watermark nhỏ của app, không kèm dữ liệu riêng;
- sao lưu/khôi phục mã hóa do người dùng chủ động xuất file;
- Apple Watch complication;
- gói dữ liệu ngày lễ theo tỉnh/vùng hoặc cộng đồng Việt ở nước ngoài;
- thư viện câu chuyện văn hóa đã được biên tập và cấp phép.

### Không đưa vào roadmap mặc định

- quảng cáo, IAP, thuê bao;
- tử vi cá nhân, lá số, thần số học, gieo quẻ, giải mộng;
- tin tức, video feed, xổ số, tỷ giá, thời tiết;
- social feed, tài khoản, streak gây nghiện;
- AI tạo lời phán “tốt/xấu” theo hồ sơ cá nhân;
- xin quyền danh bạ, vị trí hoặc lịch hệ thống khi chưa có hành động rõ ràng từ người dùng.

## 8. Thước đo thành công

Do định hướng không thu thập analytics, số đo sản phẩm nên đến từ TestFlight tự nguyện, khảo sát và dữ liệu tổng hợp không gắn danh tính chỉ khi người dùng chủ động đồng ý. Bản phát hành chính không cần telemetry.

### Chỉ số trải nghiệm trước phát hành

- 90% người thử tìm đúng ngày âm hôm nay trong 5 giây.
- 85% hiểu cách chuyển sang ngày mai mà không cần hướng dẫn bằng lời.
- 80% tạo được một ngày giỗ lặp âm lịch và giải thích được cách app xử lý tháng nhuận.
- 100% tác vụ cốt lõi hoàn thành bằng VoiceOver trong checklist nội bộ.
- Không lỗi đối chiếu trong bộ ngày chuẩn đã duyệt.
- Màn hình hôm nay đạt 60 fps trên thiết bị thấp nhất trong phạm vi hỗ trợ; động tác kéo bám ngón tay, không giật.

### Dấu hiệu giá trị sau phát hành

- người dùng tự đặt widget mà không cần hỗ trợ;
- phản hồi nhắc tới cảm giác “giống lịch ở nhà”, “dễ đọc”, “không làm phiền” và “tin cậy”;
- tỷ lệ lỗi nội dung báo về thấp và mọi lỗi có quy trình đính chính minh bạch;
- sản phẩm không cần tăng mức thu thập dữ liệu để duy trì.

## 9. Quyết định chiến lược khuyến nghị

1. **Tên làm việc:** Lịch Nhà — ngắn, ấm, không hứa quá mức “vạn niên”. Cần kiểm tra tên App Store và nhãn hiệu trước phát hành.
2. **Hình thức:** lịch bloc dọc 2D/2.5D có vật lý tinh tế; không làm không gian 3D toàn cảnh.
3. **Nền tảng:** native iOS trước để đạt widget, notification, accessibility và hiệu năng tốt.
4. **Phạm vi dữ liệu:** 1900–2100 công bố rõ; không giấu giới hạn.
5. **Nội dung:** mặt trước ít, mặt sau sâu; tránh biến tờ lịch thành bảng điều khiển.
6. **Riêng tư:** local-first, không tài khoản và không SDK quảng cáo/analytics.
7. **Mỹ thuật:** “Mộc Son Dịu” — lịch bloc giấy/gỗ với pastel ít bão hòa, nét cong và minh họa nhỏ; hơi dễ thương nhưng không trẻ con.
8. **Chuyển động và âm:** một hero effect tối đa, tự chạy một lần/ngày rồi lắng; nền “Hiên sớm” bật có điều kiện ở tiền cảnh, âm giấy/cue sự kiện tắt; mọi cảnh có Reduce Motion/static fallback.
