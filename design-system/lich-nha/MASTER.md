# Lịch Nhà — Design Master

Trạng thái: định hướng được duyệt để làm prototype; chưa phải thông số production.  
Ngày cập nhật: 07/09/2026.

## 1. Lời hứa thị giác

Mở ứng dụng phải nhận ra ngay một quyển lịch bloc đang treo trong nhà Việt, trước khi nhận ra đây là giao diện iPhone. Khánh, hai ốc đồng, xấp giấy và tờ hôm nay vẫn là vật thể chính. Pastel dịu, tỷ lệ mềm và một minh họa nhỏ làm trải nghiệm trẻ hơn mà không biến nó thành app trẻ em.

Tên phong cách: **Mộc Son Dịu**.

- Mộc: gỗ, giấy, ánh sáng phòng, bề mặt mờ và dấu vết sử dụng rất nhẹ.
- Son: màu đỏ làm nhịp cho ngày, dấu và dịp quan trọng; không phủ đỏ toàn màn hình.
- Dịu: pastel ít bão hòa, cạnh mềm, chuyển động nhỏ và âm nền không lời.
- Nhà: gần gũi, không cung đình hóa hoặc biến phong tục thành đồ trang trí du lịch.

## 2. Người dùng ưu tiên

- Nhóm chính là người 16–34 tuổi quan tâm lịch âm, ngày lễ và văn hóa Việt nhưng quen thẩm mỹ mobile hiện đại.
- Họ có thể mở lịch để tra nhanh, đặt cạnh bàn học/làm việc hoặc chia sẻ một tờ ngày đẹp.
- Nhóm 35–54 tuổi cần nhắc ngày gia đình là nhóm phụ.
- Người lớn tuổi vẫn được test cho chữ lớn, thao tác và VoiceOver; đây là yêu cầu accessibility, không phải định vị hình ảnh.

Thiết kế bắt đầu từ iPhone dọc nhỏ. iPad và ngang là bước sau, không phải lý do để thu nhỏ trải nghiệm trên điện thoại.

## 3. Thứ bậc của màn hình hôm nay

1. Số ngày dương.
2. Thứ, tháng và năm.
3. Ngày tháng âm.
4. Sự kiện hoặc tiết khí đang có hiệu lực.
5. Can Chi và thông tin truyền thống có nguồn.
6. Mẩu văn hóa hoặc minh họa nhỏ.

Hiệu ứng không nằm trong thứ bậc nội dung. Nó tạo không khí quanh tờ lịch rồi lắng xuống.

## 4. Vật liệu và hình khối

- Nền là tường/vữa/gỗ rất nhẹ; không dùng ảnh phòng khách toàn màn hình.
- Khánh cao khoảng 16–20% màn hình, có silhouette riêng, sơn mài mờ và một họa tiết trung tâm.
- Tờ giấy gần tỷ lệ 2:3, rộng khoảng 86–90% safe area trên iPhone dọc.
- Xấp giấy chỉ cần 4–7 mép được vẽ có chủ ý. Không mô phỏng hàng trăm tờ thật.
- Bóng tiếp xúc sát vật thể; không dùng quầng gradient lớn hoặc glassmorphism.
- Hai ốc/kẹp có thể lớn hơn tỷ lệ thật một chút. Minh họa dùng nét tròn, màu nước hoặc giấy cắt lớp mỏng.
- Một tờ chỉ có một điểm nghệ thuật. Khoảng trắng quan trọng hơn số họa tiết.

Tránh: thẻ bo tròn xếp tầng, dashboard nhiều ô, claymorphism dày, màu kẹo, chibi phủ màn hình, vàng bóng, texture giả cổ dày và hoạt cảnh kiểu game reward.

## 5. Màu chủ đạo

| Vai trò | Màu khởi điểm | Cách dùng |
|---|---|---|
| Giấy kem | `#FFF8E8` | nền tờ ngày |
| Mực | `#332B2B` | nội dung chính |
| Mực phụ | `#6D5C5C` | nội dung phụ |
| Son trẻ | `#B83A45` | Chủ nhật, dấu, điểm nhấn |
| Son đậm | `#7C3040` | pressed/high contrast |
| Hồng đào | `#F8D8CF` | mùa xuân và vùng sáng |
| Hồng sen | `#EAB7C3` | artwork nhỏ |
| Ngọc non | `#C6DED5` | nền phụ/sự kiện cá nhân |
| Trời sớm | `#C9E1EC` | không khí ngày thường |
| Tím sương | `#D9D0E8` | biến thể chiều/tối |
| Vàng nếp | `#F4E3A7` | điểm sáng nhỏ |
| Gỗ sữa | `#6B4F46` | khánh, ngăn |
| Đồng | `#C79A58` | ốc/kẹp, không dùng cho chữ nhỏ |
| Tường phấn | `#EADFD5` | nền trung tính ấm |

Mã màu là điểm xuất phát. Mọi cặp chữ/nền phải được đo ở trạng thái thường, tối và tương phản cao.

## 6. Chữ

- Be Vietnam Pro: số ngày, thứ, nhãn và thao tác.
- EB Garamond: ca dao, mẩu văn hóa và đoạn ngắn mang tính biên tập.
- Bitter là phương án thay nếu EB Garamond tạo cảm giác quá xa lạ khi thử với người Việt.
- Số ngày dùng tabular figures. Nội dung chức năng không dùng chữ thư pháp.
- Body hướng tới 17 pt, không dưới 11 pt; hỗ trợ Dynamic Type bằng cách đổi bố cục thay vì ép chữ.
- Kiểm tra đủ dấu tiếng Việt và các chuỗi dài như “Tháng Mười Một”, “Không có dữ liệu nguồn”.

## 7. Component

| Chức năng | Hình thức | Yêu cầu nền tảng |
|---|---|---|
| Button | con dấu, thẻ giấy hoặc miếng đồng | button semantics, focus rõ, vùng chạm 44 pt |
| Toggle | chốt gỗ có chữ Bật/Tắt | switch semantics, không chỉ dựa màu/vị trí |
| Picker | bộ số hoặc dải giấy | adjustable semantics, đọc giá trị đầy đủ |
| Dialog | tờ giấy đặt lên lịch | focus đúng và có cách đóng rõ |
| Menu | ngăn giấy kéo ra | thứ tự đọc hợp lý, hỗ trợ bàn phím nếu có |

Giao diện hệ điều hành sở hữu như bàn phím, quyền truy cập, share sheet và bộ chọn ảnh vẫn dùng UI hệ thống.

## 8. Tương tác và chuyển động

- Kéo góc giấy bám ngón tay, vùng gần ốc gần như cố định, mặt sau tối hơn nhẹ.
- Bóc tờ mục tiêu 450–650 ms; trả tờ 220–320 ms; không nổ hạt hoặc dùng spring quá mạnh.
- Mọi gesture có action thay thế cho VoiceOver và người không kéo chính xác được.
- Mỗi cảnh ngày: tối đa một intro 2–4 giây, một ambient layer và hai accent tĩnh.
- Intro chỉ tự chạy một lần mỗi ngày. Khi người dùng đọc/chạm/kéo, cảnh lắng hoặc dừng.
- Không để particle đi qua số ngày, lịch âm và dòng sự kiện.
- Nền “Hiên sớm” bật có điều kiện, fade in sau nội dung và không phá Silent/VoiceOver/audio khác. Âm giấy và cue sự kiện tắt mặc định.

## 9. Âm nền tập trung

- Mặc định: Hiên sớm, lõi pink noise rất nhẹ với room tone và lá xa; không nhạc, lời, chuông hoặc chim lặp.
- Nút loa luôn có trên màn hình lịch, vùng chạm 44 pt, có label/state và nhớ lựa chọn.
- Âm nền chỉ tự chạy ở tiền cảnh. Một chế độ background 25/50 phút, nếu làm, phải do người dùng bấm phát.
- Ba bus tách biệt: nền tập trung, phản hồi giấy và cue sự kiện.
- Tắt âm không được làm mất thông tin hay phản hồi cần thiết.
- Thông số và test plan: `../../docs/10-moc-son-diu-va-am-nen.md`.

## 10. Chế độ an toàn

- Reduce Motion: thay bóc/lật bằng dissolve hoặc slide 120–180 ms; cảnh dùng poster tĩnh hoặc chuyển động rất nhẹ.
- Dim Flashing Lights: bỏ chớp sáng, thay pháo hoa bằng vệt sáng ổn định và poster.
- Low Power: hạ particle, dừng ambient 3D và dùng texture/bake.
- VoiceOver: tờ ngày có bản tóm tắt; artwork decorative bị ẩn khỏi cây accessibility.
- High Contrast: bỏ texture dưới chữ, tăng outline và không dùng màu làm tín hiệu duy nhất.

## 11. Cảnh theo ngày

- Quốc khánh: pháo hoa 2D có giới hạn, cờ mini dựng tay và duyệt từng khung; Rodin chỉ có thể hỗ trợ cột/khánh từ ảnh tham chiếu.
- Lập Xuân: cành đào/mai lấy từ concept sheet đã duyệt qua Image-to-3D, sau đó cleanup và có thể bake 2.5D; cánh hoa là particle điều khiển riêng.
- Ngày trang nghiêm: ưu tiên ánh sáng, màu và trạng thái tĩnh; không mặc định dùng pháo, confetti hoặc âm thanh lớn.
- Ngày thường: vi cảnh nhỏ theo mùa, không cố tạo một màn biểu diễn mới mỗi lần mở.

## 12. Rodin và asset tạo sinh

Rodin chỉ nhận ảnh tham chiếu qua Image-to-3D. Text-to-3D bị cấm. Output luôn là phôi và phải qua cleanup, LOD/bake, poster, kiểm tra quyền, văn hóa và hiệu năng. Quốc kỳ, ngôi sao, chữ Việt và logo không đi qua Rodin.

Quy trình đầy đủ: `../../.agents/workflows/rodin-image-to-3d.md`.

## 13. Kết quả tra cứu UI/UX đã xử lý

Hai lượt tra cứu design system chung cho “cultural calendar tactile editorial” và “young cultural calendar cute pastel” đều trả về cấu trúc web Hero–Features–CTA, Minimalism, palette xanh dương–xanh lá, Outfit/Work Sans, hover và GSAP. Các phần này bị loại vì dành cho web marketing và làm mất bản sắc lịch bloc.

Tìm kiếm hẹp hơn giữ lại Soft UI Evolution, micro-interaction, pastel có độ tương phản và Be Vietnam Pro. Claymorphism, neumorphism, tactile jelly và bộ chữ dành cho trẻ em bị loại. Mộc Son Dịu lấy bề mặt mềm và phản hồi chạm nhỏ, không lấy nút dày, bóng kép hoặc bounce kiểu đồ chơi.

Hai kết quả UX được giữ:

- thao tác kéo phải có lựa chọn một chạm;
- Reduce Motion cần được thiết kế ngay từ đầu, với rất ít phần tử chuyển động đồng thời.

Hướng dẫn SwiftUI được giữ ở mức nguyên tắc: đọc `accessibilityReduceMotion`, dùng accessibility label/action và giữ semantic view thật ngay cả khi phần nhìn được vẽ custom.

## 14. Cổng duyệt một màn hình

- Có nhận ra lịch bloc trong ba giây không?
- Người 16–34 tuổi thấy trẻ và dễ thương vừa đủ, hay thấy giống app cho trẻ em/người cao tuổi?
- Số ngày dương và ngày âm có đọc được trong năm giây khi cảnh chạy không?
- Có chi tiết nào giống dashboard, form hoặc theme iOS đại trà không?
- Chữ Việt có vỡ dấu, ép dòng hoặc quá nhỏ ở Dynamic Type lớn không?
- Mọi thao tác kéo/vuốt có cách làm bằng chạm và VoiceOver không?
- Reduce Motion, Dim Flashing Lights, Low Power và poster tĩnh có đẹp như một trạng thái chủ ý không?
- Asset có nguồn, quyền, reviewer và bản tối ưu cho máy thật chưa?
