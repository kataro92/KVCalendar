# 06 — Kế hoạch kiểm chứng trước khi code

Mục tiêu của giai đoạn này không phải hỏi người dùng “bạn có thích ý tưởng không?”. Mục tiêu là quan sát xem họ có nhận ra, đọc được, thao tác được và tin được trải nghiệm lịch bloc số hay không.

## 1. Những giả thuyết phải kiểm chứng

| ID | Giả thuyết | Nếu sai thì sao |
|---|---|---|
| H1 | Hình thức lịch bloc tạo cảm giác quen thuộc/ấm hơn lịch app thông thường | Đổi định vị hoặc giảm skeuomorphism |
| H2 | Động tác bóc tờ mang giá trị nghi thức, không chỉ là gimmick | Giữ swipe nhanh, page curl chỉ là tùy chọn |
| H3 | Người dùng hiểu số lớn là dương lịch và dòng dưới là âm lịch | Sửa thứ bậc/nhãn |
| H4 | Mặt trước có thể tối giản mà vẫn đủ thông tin | Đưa đúng trường thiếu lên, không thêm tất cả |
| H5 | Người 55+ thao tác được với affordance không dùng tab bar chuẩn | Thêm nhãn/nút rõ hoặc đổi IA |
| H6 | Widget và nhắc ngày giỗ quan trọng hơn thư viện tử vi/nội dung | Ưu tiên roadmap theo kết quả |
| H7 | Nhãn nguồn và “tham khảo” tăng tin tưởng mà không gây rối | Điều chỉnh độ sâu/trình bày provenance |
| H8 | Mộc Son Dịu được nhìn là Việt và trẻ, không sến hoặc giả cổ | Giảm chi tiết truyền thống nặng và thử biến thể vật liệu khác |
| H9 | Local-only là lợi ích người dùng hiểu và coi trọng | Giữ vì nguyên tắc dù marketing ít nhấn mạnh |
| H10 | Quy tắc tháng nhuận có thể giải thích bằng ngôn ngữ đời thường | Viết lại luồng hoặc nhờ chuyên gia nội dung |
| H11 | Người 16–34 tuổi thấy Mộc Son Dịu trẻ và dễ thương vừa đủ, không giống app trẻ em | Giảm pastel/nhân vật hoặc đổi tỷ lệ minh họa |
| H12 | Hiên sớm đủ dịu để làm nền học/làm việc và không bị tắt ngay | Đổi soundscape hoặc đưa âm nền về opt-in |

## 2. Mẫu nghiên cứu

Tối thiểu 20 người ở vòng khám phá:

- 6 người 16–22 tuổi, có quan tâm tới lịch âm, thiết kế hoặc văn hóa Việt;
- 8 người 23–34 tuổi, gồm người đi làm và người sống xa gia đình;
- 3 người 35–54 tuổi, có trách nhiệm nhớ việc gia đình;
- 3 người 55–75 tuổi để kiểm tra accessibility, không dùng điểm thẩm mỹ của nhóm này để thay định vị chính.

Cân bằng thêm nếu có thể:

- Bắc/Trung/Nam;
- nam/nữ và vai trò gia đình;
- người có/không dùng lịch bloc giấy;
- thiết bị nhỏ/lớn, iOS cũ/mới;
- ít nhất 2 người Việt đang sống ngoài Việt Nam, tuyển trong các nhóm tuổi trên;
- ít nhất một người dùng VoiceOver hoặc có thị lực kém.

Không dùng bạn bè làm thiết kế/công nghệ cho quá một phần tư mẫu; họ dễ hiểu prototype hơn người thật.

## 3. Nghiên cứu bối cảnh

### Buổi 45–60 phút tại nhà hoặc gọi video

1. Hỏi họ đang xem ngày âm ở đâu, yêu cầu mở đúng app/cách đang dùng.
2. Quan sát đường đi tới ngày âm, ngày giỗ hoặc tháng khác.
3. Hỏi lần gần nhất quảng cáo/paywall làm họ khó chịu; tránh câu hỏi dẫn dắt.
4. Nếu có lịch bloc, nhờ họ chỉ những phần xem hằng ngày và cách bóc.
5. Nhờ kể một lần phải nhớ ngày giỗ/rằm/lễ và cách họ đang nhắc.
6. Đưa 3–4 tờ lịch vật lý khác nhau; yêu cầu xếp “dễ đọc”, “đẹp”, “giống nhà mình”.
7. Chỉ sau đó mới đưa concept app.

### Câu hỏi gợi mở

- “Sáng nay cô/chú/anh/chị biết ngày âm bằng cách nào?”
- “Trên tờ lịch này mắt nhìn vào đâu đầu tiên?”
- “Thông tin nào không bao giờ đọc?”
- “Khi app nói ngày tốt/xấu, mình tin tới mức nào? Vì sao?”
- “Nếu ngày giỗ rơi vào tháng nhuận, nhà mình thường xử lý thế nào?”
- “Điều gì làm một ứng dụng miễn phí trở nên đáng ngờ?”
- “Nếu chỉ giữ ba thông tin trên mặt tờ, sẽ giữ gì?”

### Không hỏi

- “Bạn có thích app không quảng cáo này không?”
- “Bạn có thấy giao diện này đẹp không?” như câu duy nhất;
- “Bạn sẽ dùng mỗi ngày chứ?”;
- danh sách feature để họ tick mong muốn mà không buộc ưu tiên.

## 4. Audit lịch bloc vật lý

Thu thập/quan sát 6–10 bộ khác nhau, không sao chép artwork. Ghi bằng bảng:

- năm, nhà xuất bản, kích thước;
- tỷ lệ khánh/ruột;
- định lượng và màu giấy nếu biết;
- cỡ tương đối số ngày;
- thứ tự thông tin;
- màu Chủ nhật/ngày lễ;
- cách thể hiện ngày âm, Can Chi, tiết khí;
- loại nội dung đáy tờ;
- cơ chế xé/gáy/ốc;
- mức họa tiết;
- điểm người dùng thích/không đọc;
- ảnh chỉ dùng nội bộ nghiên cứu, ghi nguồn/quyền.

Kết quả cần là **pattern**, không phải một mẫu để copy.

## 5. Ba prototype cần làm

### A — Mộc Son Dịu, vật lý rõ

- khánh gỗ/sơn mài;
- giấy ngà, son đỏ;
- page curl có góc bóc;
- nội dung mặt trước tối giản.

### B — Giấy Mộc, ít trang trí

- không khánh lớn;
- xấp giấy và typography là chính;
- chuyển động nhanh hơn;
- dành để biết người dùng thích cấu trúc hay chỉ thích trang trí.

### C — Gốm Lam, truyền thống hiện đại

- nền trắng xanh, nét gốm tối giản;
- không đỏ–vàng làm màu chính;
- cùng layout và gesture A;
- kiểm tra xem “chất Việt” có cần son đỏ không.

Mỗi prototype phải có cùng nội dung để so sánh mỹ thuật công bằng.

## 6. Fidelity theo vòng

### Vòng 1 — paper/Figma tĩnh

Kiểm tra nhận diện và thứ bậc. Không giải thích trước.

Tác vụ:

- nói hôm nay dương/âm là ngày nào;
- tìm tiết khí/sự kiện;
- chỉ nơi sẽ chạm để xem tháng;
- chỉ nơi sẽ chạm để xem chi tiết.

### Vòng 2 — motion prototype

Kiểm tra page curl, lật mặt sau, tháng và ngăn giấy.

Đồng thời dựng ba motion study riêng, chưa tích hợp production:

- Quốc khánh: pháo hoa + cờ, bản không flash và poster tĩnh;
- Lập Xuân: đào/mai/trung tính, 4–8 cánh hoa;
- ngày thường: intro một lần/ngày và trạng thái nghỉ.

Tác vụ:

- sang ngày mai;
- quay về hôm nay;
- xem ngày âm của một ngày trong tháng sau;
- tìm nguồn của “giờ hoàng đạo”;
- tăng cỡ chữ.

### Vòng 3 — functional prototype không production

Chỉ sau khi A/B/C có hướng thắng. Kiểm tra:

- gesture latency trên iPhone thật;
- Reduce Motion;
- VoiceOver order/actions;
- notification permission timing;
- widget hierarchy;
- luồng sự kiện tháng nhuận.

## 7. Kịch bản usability test

Không nói tên nút hoặc hướng dẫn thao tác. Đọc từng tình huống:

1. “Hãy cho tôi biết hôm nay âm lịch là ngày nào.”
2. “Bạn muốn xem ngày mai có sự kiện gì.”
3. “Bạn đã lật sang một ngày xa. Hãy về hôm nay.”
4. “Hãy xem ngày 15 tháng sau là ngày bao nhiêu âm.”
5. “Gia đình có ngày giỗ 12 tháng Tám âm. Hãy đặt nhắc trước 3 ngày lúc 8 giờ.”
6. “Ngày này là tháng nhuận. Hãy chọn cách bạn muốn app nhắc ở các năm sau.”
7. “Hãy kiểm tra app dựa vào đâu để nói giờ này là giờ hoàng đạo.”
8. “Chữ đang nhỏ. Hãy làm nó dễ đọc hơn.”
9. “Bạn không muốn tiếng giấy. Hãy tắt.”
10. “Không muốn app hiện tên ngày giỗ trên màn hình khóa. Hãy chỉnh.”

Sau mỗi task hỏi ngắn:

- “Bạn nghĩ điều gì vừa xảy ra?”
- “Bạn chờ thấy gì nhưng không thấy?”
- “Có điều gì làm bạn không tin không?”

## 8. Cách đo

### Định lượng

- task success: hoàn thành/hoàn thành có gợi ý/thất bại;
- thời gian tới thông tin đầu tiên;
- số lần chạm sai;
- số người nhận ra gesture không gợi ý;
- số người tìm được “Hôm nay”;
- comprehension tháng nhuận;
- cỡ chữ nhỏ nhất họ thấy thoải mái;
- preference A/B/C kèm lý do;
- motion sickness/khó chịu 1–5.
- thời gian người dùng quay lại đọc ngày sau khi intro bắt đầu;
- tỷ lệ nhận đúng sự kiện/sắc thái trước khi đọc nhãn;
- số người thấy hiệu ứng “trang trọng”, “giống nhà” hay “giống game/quảng cáo”;
- tỷ lệ tắt âm nền trong 10 giây đầu và lựa chọn giữ/đổi/tắt sau 10–15 phút;
- mức dễ chịu, mất tập trung và mệt tai với loa máy và tai nghe;
- frame pacing, nhiệt và mức pin tương đối trong bài chạy cảnh lặp có kiểm soát.

### Định tính

Mã hóa phát biểu theo:

- quen thuộc;
- trang trọng/tinh tế;
- trẻ, dịu và dễ thương;
- sến/giả cổ;
- trẻ con/đồ chơi;
- dễ đọc;
- rõ hành động;
- tin dữ liệu;
- riêng tư;
- giá trị nghi thức;
- mong muốn tính năng ngoài scope.

Không chọn concept chỉ vì điểm “đẹp” trung bình; xem lý do và khác biệt nhóm tuổi.

## 9. Cổng quyết định

### Gate 1 — concept

Đi tiếp nếu:

- ít nhất 16/20 người nhận ra đây là lịch bloc/lịch xé mà không được nói trước;
- ít nhất 14/20 mô tả cảm giác tích cực gắn với nhà/gia đình/truyền thống;
- không nhóm tuổi nào xem là khó đọc hơn lịch app thường một cách hệ thống.

Nếu không: giữ ý tưởng số lớn/giấy nhưng giảm khánh và hiệu ứng.

### Gate 2 — gesture

Đi tiếp nếu:

- ít nhất 80% sang ngày kế không cần hướng dẫn;
- ít nhất 90% có thể dùng nút/action thay thế;
- median task dưới 3 giây;
- không quá 10% báo khó chịu vì chuyển động.

Nếu gesture vui nhưng chậm: giữ nó như nghi thức tùy chọn, vuốt ngắn là mặc định.

### Gate 3 — thông tin

Đi tiếp nếu:

- 90% đọc đúng ngày dương/âm trong 5 giây;
- không quá 20% đòi một trường giống nhau bị thiếu trên mặt trước;
- ít nhất 70% hiểu “tham khảo theo lịch truyền thống” không phải bảo đảm khoa học;
- nguồn có thể được tìm trong hai thao tác.

### Gate 4 — ngày giỗ

Đi tiếp nếu:

- 80% hoàn thành không trợ giúp;
- 80% giải thích lại đúng rule tháng nhuận họ vừa chọn;
- 100% hiểu event đã lưu dù notification bị từ chối;
- không người nào nghĩ app đã đọc danh bạ/lịch hệ thống nếu nó chưa xin quyền.

### Gate 5 — accessibility

Không phát hành nếu bất kỳ tác vụ cốt lõi nào không hoàn thành bằng VoiceOver, chữ 200%, Reduce Motion hoặc Increase Contrast.

### Gate 6 — hiệu ứng theo ngày

Đi tiếp nếu:

- 90% vẫn đọc đúng ngày dương/âm trong 5 giây khi cảnh chạy;
- ít nhất 80% nhận đúng sắc thái của cảnh Quốc khánh và Lập Xuân;
- không participant/reviewer phát hiện lỗi Quốc kỳ hoặc cách dùng biểu tượng thiếu trang trọng;
- bản Reduce Motion và Dim Flashing Lights vẫn đẹp, không mất ý nghĩa;
- cảnh không làm gesture tờ giấy tụt dưới target frame trên máy thấp nhất;
- intro một lần/ngày được ưa thích hơn autoplay lặp và không gây khó chịu hệ thống;
- mỗi asset thử nghiệm dự kiến ship có provenance/license record hoàn chỉnh.

### Gate 7 — âm nền tập trung

Giữ Hiên sớm ở trạng thái bật có điều kiện nếu:

- không quá 25% nhóm chính tắt trong 10 giây đầu;
- đa số không báo mệt tai hoặc mất tập trung sau 10–15 phút;
- không làm giảm kết quả tác vụ ngắn một cách có hệ thống so với im lặng;
- Silent, VoiceOver, audio khác, tháo tai nghe và cuộc gọi đều cho hành vi đúng;
- nút tắt được tìm thấy và dùng trong một thao tác.

Nếu không đạt, âm nền vẫn có thể tồn tại như lựa chọn opt-in. Không dùng lời hứa “tăng tập trung”.

## 10. Test ngôn ngữ “tin cậy”

So sánh ba cách ghi cùng thông tin:

- “Ngày tốt — nên khai trương”;
- “Theo lịch truyền thống: thuận cho khai trương”;
- “Tham khảo theo quy tắc Hoàng đạo A: khai trương; xem cách tính”.

Đo:

- người dùng hiểu mức chắc chắn thế nào;
- câu nào không quá dài;
- nguồn có làm tăng tin hay gây áp lực;
- người dùng có nhầm với lời khuyên cá nhân hóa không.

Khuyến nghị ban đầu là phương án thứ ba ở mặt sau, phương án thứ hai rút gọn ở mặt trước.

## 11. Test mỹ thuật với từ khóa bắt buộc

Cho người tham gia tự chọn 5 từ trước, sau đó mới cho chọn trong danh sách:

- Việt Nam;
- gia đình;
- ấm;
- tinh tế;
- trẻ;
- dịu;
- dễ thương;
- pastel;
- rõ;
- cổ;
- hiện đại;
- sến;
- nặng nề;
- đồ chơi;
- trẻ con;
- dành cho người cao tuổi;
- khó đọc;
- đáng tin.

Concept thắng cần được nhóm 16–34 mô tả là Việt, trẻ, dịu và rõ. “Dễ thương” được phép tăng; “trẻ con”, “đồ chơi”, “sến” và “dành cho người cao tuổi” không được trở thành mô tả chi phối.

## 12. Test âm nền

Mỗi người trong nhóm chính thử im lặng, Hiên sớm và Mưa xa với cùng loại tác vụ ngắn; đảo thứ tự giữa người tham gia. Không nói trước âm nào “tốt cho tập trung”. Ghi lại lựa chọn, hành vi tắt âm, kết quả tác vụ và cảm nhận sau phiên.

Thử riêng trên loa iPhone và tai nghe. Kiểm tra mối nối loop, transient, mức xì ở dải cao, âm trầm bị mất trên loa nhỏ và cảm giác lặp sau 10–15 phút.

## 13. Kết quả đầu ra của nghiên cứu

Trước khi code phải có:

- research brief và tiêu chí tuyển người;
- biên bản/ghi chú ẩn danh từng buổi;
- bảng pattern của lịch vật lý;
- video/ảnh prototype có quyền lưu;
- scorecard task;
- synthesis theo nhóm tuổi/vùng;
- quyết định concept kèm bằng chứng;
- danh sách thay đổi PRD;
- các câu hỏi chưa giải được;
- decision log có ngày và owner.

## 14. Quy tắc đạo đức và riêng tư khi nghiên cứu

- xin đồng ý trước khi ghi âm/quay;
- không ghi tên thật ngày giỗ hoặc thông tin gia đình vào báo cáo;
- người tham gia có thể dừng bất cứ lúc nào;
- không cài profile theo dõi lên máy cá nhân;
- quà cảm ơn không phụ thuộc việc khen concept;
- xóa recording theo thời hạn đã thông báo;
- chỉ dùng trích dẫn ẩn danh với sự đồng ý;
- không đưa dữ liệu nghiên cứu vào công cụ AI/cloud nếu chưa có đồng ý phù hợp.
