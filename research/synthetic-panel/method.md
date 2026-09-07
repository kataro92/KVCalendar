# Phương pháp hội đồng persona tổng hợp

Ngày thực hiện: **07/09/2026**
Mục đích: tạo giả thuyết và làm cognitive walkthrough khi chưa tuyển được người thật.

## Tên gọi và ranh giới

Trong hồ sơ này, “persona tổng hợp” là một **proto-persona có kiểm soát**. Nó ghép yêu cầu dự án, tín hiệu thị trường và case biên kỹ thuật thành một lăng kính để chất vấn thiết kế. Nó không có ký ức, gia đình, sở thích hay phát ngôn ngoài những gì tài liệu ghi.

Không dùng panel để:

- tạo trích dẫn người dùng;
- đếm phiếu hoặc viết tỷ lệ như “6/8 thích”;
- đo task success, thời gian, mức mệt, độ dễ đọc hoặc hành vi tắt âm;
- xác nhận một phong tục cho cả vùng/độ tuổi;
- pass Gate 1–7, T012–T016 hoặc Definition of Ready;
- thay review của người dùng VoiceOver, người Việt ở nước ngoài, chuyên gia lịch hay reviewer văn hóa.

## Dữ liệu đầu vào

Panel chỉ được đọc các nguồn sau:

1. các quyết định hiện hành trong `docs/`, Design Master và Spec Kit;
2. sổ chứng cứ `research/desk-research/evidence-register.md`;
3. metadata, review và version history App Store, luôn giữ nhãn tự khai/mẫu tự chọn;
4. nguồn pháp lý, thiên văn, lịch và audio được ghi trong sổ chứng cứ;
5. hướng dẫn UI/UX về thao tác thay thế cho dragging, text scaling và soft pastel có tương phản.

Không nhập profile mạng xã hội, dữ liệu cá nhân, ảnh người thật hoặc nhật ký gia đình vào panel.

## Cách tạo persona

Tám persona được chọn theo **tình huống sử dụng và ràng buộc**, không phải theo khuôn mẫu vùng miền. Tuổi, nơi ở và nghề chỉ giúp walkthrough có bối cảnh. Không được suy ra tính cách hay tập quán từ các trường đó.

Mỗi card phải có:

- việc cần hoàn thành;
- điều kiện sử dụng;
- rủi ro thiết kế cần soi;
- nguồn/decision tạo ra rủi ro;
- câu hỏi còn mở.

Không viết “nỗi đau” như thể đã phỏng vấn người đó. Không thêm câu nói trong ngoặc kép.

## Quy trình thảo luận

### Vòng 1 — walkthrough riêng

Mỗi persona đi qua cùng sáu tác vụ: xem hôm nay, sang ngày, mở mặt sau, tạo ngày giỗ, xem scene ngày đặc biệt và xử lý âm nền. Người mô phỏng ghi điểm vướng có thể dự đoán từ tài liệu, không chấm điểm thích/không thích.

### Vòng 2 — đối lập lợi ích

Ghép các nhu cầu dễ xung đột:

- nghi thức bóc với tốc độ xem nhanh;
- pastel/hiệu ứng với độ đọc và vẻ trưởng thành;
- nguồn chi tiết với mặt trước yên;
- lịch Việt UTC+7 với “hôm nay” và reminder địa phương;
- âm nền ấm với quyền được im lặng;
- giao diện riêng với VoiceOver/Dynamic Type.

### Vòng 3 — phản biện chuyên môn

Ba vai phản biện kiểm tra kết quả:

- thị trường: claim nào đã bị đối thủ vô hiệu hóa, đâu chỉ là review signal;
- lịch/văn hóa: claim nào cần nguồn, vùng hay xử lý biên;
- phương pháp: câu nào đang biến persona thành người thật hoặc tạo certainty giả.

Agent chính chỉ giữ kết luận còn đứng vững sau cả ba vòng. Bất đồng được ghi lại, không giải bằng bỏ phiếu.

## Mã hóa kết quả

Mỗi nhận định trong findings mang một nhãn:

- `OBS`: thấy trực tiếp trong nguồn;
- `INF`: suy luận có đường dẫn về `OBS`;
- `HYP`: cần người thật/prototype;
- `DEC`: quyết định chủ dự án hoặc guardrail;
- `OPEN`: chưa đủ bằng chứng để chọn.

Mức chứng cứ:

- **Cao**: nguồn chính thức hoặc ràng buộc an toàn đủ để chốt policy;
- **Vừa**: nhiều tín hiệu gián tiếp cùng hướng, chỉ chốt phương án đảo ngược;
- **Thấp**: giả thuyết hợp lý để mang đi test;
- **Không có**: không được trả lời thay người dùng.

## Tái lập

Một lần chạy lại hợp lệ phải ghi ngày, phiên bản tài liệu, danh sách nguồn, số persona, tác vụ, prompt/role của các reviewer và thay đổi so với lần trước. Vì model có thể cho câu chữ khác, artifact chuẩn là bảng reasoning và trạng thái gate, không phải lời thoại của persona.

## Điều kiện nâng cấp từ giả thuyết thành bằng chứng

Chỉ nâng một kết luận hành vi sau khi có buổi với người thật đúng tiêu chí tuyển, consent, note ẩn danh và scorecard theo `docs/06-ke-hoach-kiem-chung.md`. Khi có dữ liệu thật, persona phải được sửa từ pattern quan sát được; không dùng persona cũ để giải thích ngược dữ liệu trái chiều.
