# Lịch Nhà — concept Ngồi cùng lịch

Ngày: 09/09/2026. Trạng thái: đề xuất thiết kế và ảnh concept, chưa phải đặc tả triển khai hoặc asset production.

## Nhận định về giao diện hiện tại

Lịch Nhà nên có một chế độ đặt điện thoại cạnh bàn học hoặc bàn làm việc: quyển lịch bloc ở giữa, nhạc không lời do người dùng chọn, một hiệu ứng nhẹ ở nền. Tên đề xuất là **Ngồi cùng lịch**. “Màn hình chờ” trong yêu cầu được hiểu là màn hình ở lại lâu bên trong ứng dụng, không phải màn hình tải hay màn hình khóa hệ thống.

Đánh giá này dựa trên README, Design Master và tài liệu UX/âm thanh của dự án. Repository đang ở giai đoạn nghiên cứu; chưa có giao diện chạy được để kiểm thử. Những nhận định về độ trẻ trung là giả thuyết thiết kế, chưa có xác nhận từ người dùng 16–34 tuổi.

| Thành phần hiện tại | Nhận định | Đề xuất cho chế độ Ngồi cùng lịch |
|---|---|---|
| Giấy, gỗ, son và hai ốc đồng | Nhận diện lịch bloc Việt Nam rõ, nên giữ | Giảm tương phản vân gỗ, khánh mỏng và bề mặt mờ |
| Tờ lịch rộng 86–90% safe area | Hợp với xem ngày gần; dễ chiếm hết không gian khi thêm nhạc | Thử rộng 66–74%, vẫn để ngày dương là phần lớn nhất |
| Sáu tầng thông tin trên tờ | Có ích khi tra cứu, nhiều hơn nhu cầu nhìn từ bàn | Giữ ngày dương, thứ/tháng/năm và ngày tháng âm; chi tiết mở bằng chạm |
| Nút điều khiển giả vật liệu | Có bản sắc nhưng khó nhận ra nếu quá cách điệu | Nút phát/tạm dừng dùng biểu tượng quen thuộc, tên và trạng thái rõ |
| Hiên sớm, Mưa xa, Quạt trưa | Tài liệu đang tập trung vào tiếng môi trường | Bổ sung lựa chọn nhạc không lời riêng theo yêu cầu mới |
| Cảnh theo ngày | Tạo lý do khám phá khi mở lịch | Trong phiên nghe, giữ cảnh ổn định; không chen hiệu ứng lễ hội |

Muốn trẻ hơn, ưu tiên số ngày sans-serif rõ, khoảng trống, màu ngọc/đào/tím ít bão hòa và minh họa nhỏ. Giảm hoa văn khánh, giả cổ và chữ biên tập trên mặt trước. Không cần thêm mascot hoặc gamification để thể hiện đối tượng trẻ.

## Hai cách dùng trong cùng ứng dụng

**Xem hôm nay:** mở vào tờ lịch, tra ngày nhanh, mở tháng, nhắc ngày gia đình hoặc xem mặt sau. Có nút “Ngồi cùng lịch” dễ nhận ra. Tiếp tục dùng một không gian lịch chính theo Design Master.

**Ngồi cùng lịch:** lịch thu gọn vừa đủ để có khoảng thở, bộ nhạc ở dưới. Khi người dùng ở yên, các công cụ tra cứu phụ có thể thu lại; nút tạm dừng vẫn dễ tìm. Chạm một lần để gọi lại điều khiển, không yêu cầu kéo chính xác. Đây là hành vi đề xuất để thử, chưa phải thay đổi đã chốt vào spec.

Bố cục dọc gồm tên chế độ và nút quay lại ở trên; lịch ở vùng giữa; tên nhạc, phát/tạm dừng, âm lượng và hẹn giờ ở dưới. “Giữ màn hình sáng” nằm ngoài tờ lịch và có trạng thái bật/tắt rõ. Chữ lớn được phép làm bố cục xếp lại; không thu nhỏ chữ chỉ để giữ tỷ lệ concept.

## Phiên nghe khi học hoặc làm việc

1. Người dùng mở Ngồi cùng lịch và chọn một bản nhạc không lời hoặc tiếng môi trường.
2. Bấm Phát để bắt đầu. Bản cài mới vẫn ở Yên; không tự phát âm khi mở ứng dụng.
3. Có thể bật Giữ màn hình sáng cho phiên hiện tại, chọn 25 phút, 50 phút hoặc tự dừng. Các mốc là lựa chọn tiện dụng, không phải cam kết tăng tập trung.
4. Có thể tạm dừng, thay âm lượng hoặc kết thúc mà không rời màn hình lịch.
5. Khi hết hẹn giờ, âm nhỏ dần rồi dừng, bỏ yêu cầu giữ sáng của phiên để máy trở lại cách tự khóa bình thường. Không phát chuông đột ngột theo mặc định.

Nhạc gợi ý để thử nghe: piano thưa nốt, guitar nhẹ hoặc ambient không lời; tránh lời hát và thay đổi âm lượng bất ngờ. Đây là brief âm thanh, không có bản thu được tạo trong đợt concept này. Tên các cảnh trong ảnh là tên gợi ý, không phải bài nhạc đã tồn tại.

Nhạc, tiếng môi trường, âm giấy và cue sự kiện cần điều khiển độc lập. Khi đang học, tiếng giấy/cue sự kiện tiếp tục tắt mặc định. Giữ các yêu cầu của dự án về Silent, VoiceOver và audio từ ứng dụng khác; không giành âm thanh đang phát. Nghe khi khóa máy hoặc chuyển sang ứng dụng khác cần đặc tả riêng; bộ concept hiện tại chỉ thể hiện sử dụng khi mở ứng dụng.

Nhạc sử dụng trong bản phát hành cần có quyền phân phối offline. Việc giữ màn hình sáng và phát âm liên tục cần thử pin, nhiệt và khả năng đọc khi đặt điện thoại xa mắt trước khi chốt hành vi.

## Ba cảnh được chọn

| Concept | Hình ảnh | Chuyển động đề xuất | Vai trò |
|---|---|---|---|
| Nắng bên bàn | Giấy kem, khánh son, nền phấn ấm | Một bóng lá dịch rất chậm ngoài vùng chữ | Hướng chính đề xuất, giữ bản sắc Mộc Son Dịu |
| Mưa ngoài hiên | Nền ngọc dịu, gỗ sáng, minh họa tách trà | Vài vệt mưa ở mép màn hình; bóng nền đứng yên | Biến thể mát và nhẹ hơn cho ban ngày |
| Đêm học bài | Nền tím than, son trầm, giấy ấm | Một vùng sáng đổi cường độ rất nhẹ, hoặc giữ tĩnh | Biến thể buổi tối; phải thử giảm độ sáng giấy |

Mỗi cảnh tối đa một hiệu ứng chính. Không có chuyển động đi qua ngày dương/ngày âm, không tự bóc lịch trong phiên, không có equalizer nhảy liên tục. Reduce Motion và Low Power dùng poster tĩnh. Dim Flashing Lights luôn được tôn trọng; không đưa nhấp nháy vào các cảnh này.

## Đánh giá bộ ảnh bàn giao

Ảnh thể hiện đúng trọng tâm: bloc ở giữa, ngày lớn và bộ nhạc tách khỏi tờ. Bản mưa/đêm v1 có quá nhiều vật dụng phòng; v2 đã bỏ chúng, giảm vân vật liệu và đưa số ngày về sans-serif. Các v1 được giữ để truy xuất, không phải bản được đề xuất.

Ảnh vẫn chưa phải màn hình hoàn chỉnh: dữ liệu “17”, “THÁNG CHÍN”, “Âm lịch · 08” chỉ dùng thử bố cục, không xác nhận quan hệ âm–dương. Bản dựng giao diện cần bổ sung thứ, năm và tháng âm đầy đủ. Các font tạo trong ảnh chưa chứng minh là Be Vietnam Pro; chữ và biểu tượng phải được dựng lại theo hệ thiết kế.

Tờ giấy trong bản đêm còn khá sáng. Trước khi duyệt, giảm độ sáng giấy nhưng giữ tương phản chữ, thử ở phòng tối. Cỡ tiêu đề, hình minh họa và bộ nhạc cũng cần cân lại trên iPhone nhỏ để lịch không bị đẩy quá cao. Vùng chạm tối thiểu 44 pt, Dynamic Type và VoiceOver chưa thể xác nhận từ ảnh raster.

## Phạm vi và bước tiếp theo

Đợt này chỉ tạo phân tích, prompt và concept art. Không tạo app, project Xcode, nhạc, animation hoặc model Rodin. Không thay Design Master hoặc đánh dấu task/gate đã hoàn tất. Yêu cầu nhạc và giữ màn hình sáng được ghi ở đây để đưa qua luồng Spec Kit trước khi triển khai.

Tra cứu UI/UX tổng quát “ambient calendar focus mobile” trả về Hero/Testimonials/CTA và phong cách SaaS, không phù hợp nên bị loại. Truy vấn hẹp “reduced motion ambient animation” trong miền UX trả về Reduced Motion, Excessive Motion và Duration Timing. Giữ nguyên tắc giảm chuyển động, áp dụng giới hạn một hiệu ứng của dự án; không nhận thời lượng chung làm thông số đã kiểm chứng.

Văn bản được rà theo ngữ cảnh docs, giọng technical: diễn đạt cụ thể, không suy diễn hiệu quả học tập, không dùng detector để kết luận tác giả.

Ảnh chọn: [Nắng bên bàn](01-nang-ben-ban-v1.png), [Mưa ngoài hiên](02-mua-ngoai-hien-v2.png), [Đêm học bài](03-dem-hoc-bai-v2.png).

Hồ sơ: [prompt đầy đủ](prompts-v1.md) và [manifest](generation-manifest.md).
