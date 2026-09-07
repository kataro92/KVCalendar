# 10 — Mộc Son Dịu và âm nền tập trung

Trạng thái: quyết định sản phẩm để đưa vào prototype, chưa triển khai mã nguồn hoặc tạo asset production.
Ngày cập nhật: 07/09/2026.

## 1. Định vị mới

Lịch Nhà được thiết kế trước cho người 16–34 tuổi có quan tâm đến lịch âm, ngày lễ và nếp sống Việt. Đây có thể là học sinh, sinh viên, người mới đi làm hoặc người sống xa gia đình. Họ dùng điện thoại thành thạo, chú ý tới thẩm mỹ và không muốn một ứng dụng lịch mang vẻ mê tín, quá trang nghiêm hoặc dành riêng cho người cao tuổi.

Người lớn tuổi vẫn phải đọc và thao tác được. Đây là tiêu chuẩn về khả năng tiếp cận, không còn là giọng hình ảnh chính của sản phẩm.

Ba tình huống cần thử trước:

- mở nhanh để xem ngày âm, tiết khí hoặc ngày lễ;
- để lịch trên bàn khi học hay làm việc;
- xem hiệu ứng theo ngày rồi quay lại nội dung trong vài giây.

## 2. “Dễ thương” ở mức nào

Tên nội bộ của hướng hình ảnh là **Mộc Son Dịu**. Nền tảng vẫn là lịch bloc, giấy, gỗ, sơn son và đồng. Sắc pastel, nét cong và chuyển động nhỏ làm vật thể trẻ hơn.

Nét dễ thương đến từ:

- hai ốc lịch hơi lớn hơn tỷ lệ thực một chút, cạnh được bo mềm;
- khánh có đường cong đơn giản thay cho phù điêu nặng;
- minh họa nhỏ như chim sẻ, mèo nằm bên hiên, ấm trà, mầm cây hoặc đám mây giấy;
- một phản ứng ngắn khi chạm, chẳng hạn cành rung nhẹ hoặc mèo hé mắt rồi nằm yên;
- màu nước và giấy cắt lớp mỏng, không phải nhựa 3D bóng.

Mỗi tờ chỉ dùng một nhân vật hoặc một cụm minh họa. Không gắn mặt cười lên Mặt Trời, Mặt Trăng, vật phẩm thờ cúng, Quốc kỳ hoặc biểu tượng văn hóa nhạy cảm.

Các hướng bị loại:

- claymorphism với nút dày, bóng kép và cảm giác đồ chơi;
- chibi/kawaii phủ toàn màn hình;
- palette kẹo có độ bão hòa cao;
- mascot liên tục nói chuyện hoặc che nội dung lịch;
- sticker, badge và card bo tròn xếp thành dashboard.

## 3. Hệ màu pastel trưởng thành

Pastel dùng cho nền, vật liệu phụ và minh họa. Chữ vẫn dùng màu đậm; không đặt chữ nhỏ bằng màu pastel.

| Vai trò | Màu khởi điểm | Cách dùng |
|---|---|---|
| Giấy kem | `#FFF8E8` | mặt tờ ngày |
| Mực chính | `#332B2B` | chữ và số; tương phản khoảng 13.05:1 trên giấy kem |
| Mực phụ | `#6D5C5C` | thông tin thứ cấp; khoảng 5.95:1 trên giấy kem |
| Son trẻ | `#B83A45` | Chủ nhật, ngày lễ, con dấu; khoảng 5.32:1 trên giấy kem |
| Son đậm | `#7C3040` | pressed/high contrast |
| Hồng đào | `#F8D8CF` | vùng sáng mùa xuân, không dùng làm chữ |
| Hồng sen | `#EAB7C3` | minh họa và accent nhỏ |
| Ngọc non | `#C6DED5` | nền phụ, ngày cá nhân |
| Trời sớm | `#C9E1EC` | không khí sáng và ngày thường |
| Tím sương | `#D9D0E8` | biến thể chiều/tối |
| Vàng nếp | `#F4E3A7` | điểm sáng nhỏ, không thay màu Quốc kỳ |
| Gỗ sữa | `#6B4F46` | khánh lịch sáng hơn hướng cũ |
| Tường phấn | `#EADFD5` | nền ứng dụng |

Các tỷ lệ trên được tính từ mã màu phẳng để sàng lọc ban đầu. Prototype phải đo lại sau khi có texture, alpha, dark mode và trạng thái pressed.

## 4. Chữ và hình

Be Vietnam Pro tiếp tục là chữ chính vì bộ dấu tiếng Việt và độ đọc đã phù hợp. Không đổi toàn bộ sang font tròn kiểu trẻ em. Sự mềm mại đến từ weight vừa, tracking thoáng, con số lớn và khung vật thể.

EB Garamond chỉ dùng cho mẩu văn hóa ngắn. Nếu thử nghiệm cho thấy nó làm giao diện già hơn, dùng Bitter hoặc Be Vietnam Pro cho cả phần này. Không đưa font display mới vào trước khi kiểm tra đủ dấu tiếng Việt, tabular figures, giấy phép và Dynamic Type.

Minh họa dùng nét 1.25–1.75 pt, đầu nét tròn, bề mặt mờ và bóng tiếp xúc nhỏ. Vật thể 3D cần cạnh bevel mềm; độ bóng kim loại chỉ nằm ở ốc/kẹp đồng. Quy trình Rodin vẫn là ảnh tham chiếu sang Image-to-3D, không dùng Text-to-3D.

## 5. Ba lớp âm thanh

Âm thanh được tách để người dùng có thể giữ nền tập trung mà không phải nghe tiếng pháo hoặc tiếng giấy.

| Lớp | Mặc định ở bản cài mới | Hành vi |
|---|---|---|
| Âm nền tập trung | Yên | chỉ bắt đầu sau khi người dùng chọn một nền, tờ lịch đã hiện; fade in chậm, chỉ chạy ở tiền cảnh |
| Phản hồi giấy | Tắt | tiếng lật/xé ngắn khi bóc hoặc mở tờ |
| Cue sự kiện | Tắt | pháo hoa xa, vải lay, cành cây hoặc âm nghi lễ đã duyệt |

Khi người dùng đã chọn một nền, app vẫn không phát nếu iPhone đang ở Silent, VoiceOver đang bật, cuộc gọi hoặc ghi âm đang hoạt động, hay một ứng dụng khác đang phát audio không nên bị cạnh tranh. Nút loa nằm ngay trên không gian lịch, có vùng chạm 44 pt, trạng thái rõ và nhớ lựa chọn của người dùng.

Âm nền không truyền thông tin. Tắt âm không làm mất dấu sự kiện, phản hồi thao tác hoặc nội dung ngày.

## 6. Hiên sớm là lựa chọn, không phải lời hứa tập trung

White noise thật có năng lượng trên toàn dải tần và thường nghe như tiếng xì. Nó không phải lựa chọn dễ chịu cho mọi người. Một tổng quan hệ thống năm 2024 tìm thấy lợi ích nhỏ của white/pink noise trong các bài kiểm tra ở trẻ em và người trẻ có ADHD hoặc triệu chứng chú ý cao, nhưng hiệu quả âm ở nhóm đối chứng không ADHD. Lịch Nhà không được quảng cáo âm nền là cách tăng tập trung hay điều trị: [PubMed, DOI 10.1016/j.jaac.2023.12.014](https://pubmed.ncbi.nlm.nih.gov/38428577/).

Nền đầu tiên để prototype là **Hiên sớm**:

- lõi pink noise rất nhẹ thay cho tiếng xì trắng sáng;
- room tone ấm, gió qua lá ở xa và gần như không có transient;
- không nhạc, không lời, không chuông, không chim hót lặp lại;
- không đổi theo ngày lễ để người dùng học hoặc làm việc không bị gián đoạn.

Bốn lựa chọn đầu tiên:

1. **Yên:** mặc định bản cài mới cho tới khi Gate 7 có dữ liệu người thật.
2. **Hiên sớm:** pink noise ấm và lá xa, ứng viên prototype chính.
3. **Mưa xa:** mưa đều ngoài hiên, không sấm và không giọt rơi sắc.
4. **Quạt trưa:** dải thấp mềm gần brown noise, không có tiếng motor lặp rõ.

Tên trong UI mô tả khung cảnh, không hứa tác dụng sức khỏe.

## 7. Hành vi âm thanh trên iOS

Trong tiền cảnh, âm nền phù hợp với audio session loại `ambient`: loại này trộn được với audio khác, dừng theo Ring/Silent và không tiếp tục khi khóa màn hình. Đây cũng là cách Apple mô tả âm thanh không thiết yếu: [Apple, AVAudioSession.Category.ambient](https://developer.apple.com/documentation/avfaudio/avaudiosession/category-swift.struct/ambient), [Apple HIG, Playing audio](https://developer.apple.com/design/human-interface-guidelines/playing-audio).

Nếu hệ thống báo audio chính từ ứng dụng khác đang chạy, Lịch Nhà coi nền tập trung là audio phụ và không tự bật. Apple cung cấp `secondaryAudioShouldBeSilencedHint` cho đúng trường hợp này: [Apple Developer Documentation](https://developer.apple.com/documentation/avfaudio/avaudiosession/secondaryaudioshouldbesilencedhint).

Một chế độ “Ngồi cùng lịch” có thể được thử sau. Người dùng phải chủ động bấm phát và chọn 25 hoặc 50 phút trước khi âm tiếp tục ở nền/khóa màn hình. Đây là media playback do người dùng khởi tạo, tách khỏi âm tự chạy khi mở app.

Khi tai nghe bị tháo, âm dừng ngay. Sau cuộc gọi, ứng dụng chỉ tiếp tục nếu phiên trước là do người dùng chủ động bắt đầu; âm tự chạy ở tiền cảnh không tự hồi lại.

## 8. Thông số prototype âm thanh

Các con số dưới đây là điểm bắt đầu để blind test, không phải chuẩn phát hành:

- master nguồn ở 48 kHz, giữ bản WAV có thể biên tập;
- mỗi loop dài 60–120 giây và không có mối nối nghe thấy;
- fade in 1.5–2.5 giây, fade out 0.5–1 giây;
- app gain khởi điểm 15%, có slider riêng và không tự nâng âm lượng hệ thống;
- không có transient bất ngờ; cue sự kiện không được trộn vào nền khi công tắc cue đang tắt;
- kiểm tra loa iPhone, tai nghe có dây/Bluetooth, mono, âm lượng hệ thống thấp và cao.

WHO khuyến nghị nghe dưới mức trung bình 80 dB và giới hạn thời gian khi mức âm tăng. Ứng dụng không thể suy ra chính xác dB tại tai từ một file âm thanh, vì còn phụ thuộc thiết bị, tai nghe và âm lượng hệ thống. Vì vậy app giữ master dịu, không tự tăng volume và dẫn người dùng tới cài đặt an toàn của hệ thống thay vì tuyên bố “an toàn tuyệt đối”: [WHO, Safe listening](https://www.who.int/news-room/questions-and-answers/item/deafness-and-hearing-loss-safe-listening).

## 9. Tạo và duyệt audio

ElevenLabs có thể tạo phôi cho gió, mưa và tiếng giấy. White/pink/brown noise nền nên được tạo hoặc lọc bằng công cụ audio có tham số rõ, sau đó sound designer trộn với Foley tự thu. Không dùng một output AI ngắn rồi lặp trực tiếp vì dấu lặp sẽ lộ trong phiên học.

Mỗi file lưu nguồn, prompt nếu có, model/version, gói sử dụng, Terms tại ngày tạo, các bước mix, loudness đo được, người duyệt và checksum. App chỉ chứa bản đã duyệt, không gọi dịch vụ tạo âm lúc chạy.

## 10. Kiểm chứng với người trẻ

Prototype cần ít nhất 12 người trong nhóm chính, chia giữa 16–22 và 23–34 tuổi. Bài test âm nền dùng thiết kế within-subject: mỗi người làm cùng loại tác vụ ngắn trong im lặng, Hiên sớm và Mưa xa; thứ tự được đảo để giảm thiên lệch.

Ghi nhận:

- tỷ lệ tắt âm trong 10 giây đầu;
- mức dễ chịu, mất tập trung và mệt tai sau 10–15 phút;
- khả năng đọc ngày dương/âm khi hiệu ứng đang chạy;
- lựa chọn giữ âm, đổi âm hay tắt cho lần mở sau;
- khác biệt giữa loa máy và tai nghe.

Không giữ mặc định bật nếu hơn 25% người thử tắt ngay hoặc nếu nền làm kết quả tác vụ giảm có hệ thống. Cũng không dùng điểm “dễ thương” trung bình làm quyết định duy nhất: người thử phải vẫn nhận ra lịch bloc Việt Nam và đọc đúng thông tin chính.

Cho tới khi test này được thực hiện, không suy ra tỷ lệ tắt từ persona tổng hợp và không tự phát Hiên sớm ở bản phát hành.
