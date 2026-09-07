# 11 — Nghiên cứu tổng hợp và persona mô phỏng

Ngày tổng hợp: **07/09/2026**
Trạng thái: **nghiên cứu bàn giấy hoàn tất; nghiên cứu hành vi chưa thực hiện**

## 1. Điều tài liệu này làm và không làm

Không có người dùng thật ở vòng này. Nhóm đã đối chiếu thị trường, nguồn lịch/văn hóa, hướng dẫn nền tảng và nghiên cứu về âm thanh; sau đó dùng tám proto-persona để rà mâu thuẫn. Cách làm này giúp chọn phương án prototype ít rủi ro và chỉ ra câu hỏi còn thiếu. Nó không tạo dữ liệu hành vi.

Không có câu nói, tỷ lệ hay “đa số persona” nào được xem là phát hiện người dùng. Gate 1–7, T012–T016 và T020 vẫn chưa đạt. Phương pháp, persona, chứng cứ và biên bản phản biện nằm ở:

- `research/desk-research/evidence-register.md`;
- `research/synthetic-panel/method.md`;
- `research/synthetic-panel/personas.md`;
- `research/synthetic-panel/deliberation.md`.

## 2. Điều đã thay đổi sau khi nghiên cứu lại

### Bỏ claim “đầu tiên”

Đã có app tuyên bố miễn phí, không quảng cáo, offline và dùng ngôn ngữ sơn mài/lịch bloc. Lịch Nhà không nên tự nhận là app đầu tiên hoặc duy nhất. Điểm khác biệt cần kiểm chứng là độ sâu của nghi thức bóc, cấu trúc nguồn dễ hiểu, accessibility và cảm giác yên tĩnh nhất quán.

### Âm nền chuyển từ default dự kiến thành ứng viên prototype

Meta-analysis hiện có không ủng hộ white/pink noise như một lợi ích phổ quát. Khi chưa chạy Gate 7, mặc định phát hành ít rủi ro là **Yên**; Hiên sớm chỉ phát sau khi người dùng chủ động chọn. Prototype vẫn thử “bật có điều kiện” để đo tỷ lệ tắt, mệt và xung đột audio về sau. Không dùng lời hứa “tăng tập trung”.

### Tách ba loại thời gian

- lịch âm Việt Nam được tính theo UTC+7;
- “hôm nay” mặc định theo ngày dân sự nơi thiết bị đang ở;
- notification mặc định theo timezone ID địa phương, có xử lý DST.

“Nhịp Việt Nam” là tùy chọn xem ngày theo `Asia/Ho_Chi_Minh`. Đây là policy tạm để prototype, chưa phải sở thích đã được người Việt ở nước ngoài xác nhận.

### Không áp một phong tục gia đình thành mặc định quốc gia

Nguồn tìm được chỉ ghi một thông lệ cho giỗ trong tháng trùng tên tháng nhuận; chưa có căn cứ đủ mạnh cho ngày 30 của tháng thiếu. App phải cho từng gia đình chọn, đọc lại lựa chọn bằng câu rõ và không dùng nhãn “đúng phong tục”.

## 3. Trả lời tạm thời 11 câu hỏi cần nghiên cứu trực tiếp

`Cao/Vừa/Thấp` dưới đây là độ chắc của **quyết định thiết kế tạm**, không phải xác suất người dùng đồng ý.

| # | Trả lời ở vòng này | Trạng thái | Mức |
|---|---|---|---|
| 1 | Bóc là đường giàu cảm xúc nhưng không được là đường bắt buộc. Giữ chạm/vuốt và action accessibility tương đương. Chưa biết người dùng có muốn bóc hằng ngày. | `PROTOTYPE` + `HUMAN GATE` | Vừa cho guardrail; không có cho hành vi |
| 2 | Thiết kế cho ba ngữ cảnh: liếc nhanh, tra/lập kế hoạch và chuẩn bị việc gia đình. Không khẳng định buổi sáng hay trước bàn thờ là ngữ cảnh chính. | `PROTOTYPE` | Thấp |
| 3 | Mặt trước giữ ngày dương, thứ, ngày âm và tối đa một dòng sự kiện/tiết khí. Can Chi đầy đủ, tốt/xấu, phương pháp và nguồn ở mặt sau. | `PROTOTYPE` | Vừa |
| 4 | Tốt/xấu chỉ là tham khảo, không cá nhân hóa, có ruleset/nguồn và có thể tắt. Nếu chưa có chuyên gia chịu trách nhiệm, loại khỏi 1.0 thay vì dùng dữ liệu không rõ. Chưa biết người thật dùng để tham khảo hay quyết định. | `HOLD` + `HUMAN GATE` | Cao cho safety; không có cho hành vi |
| 5 | Pastel nằm ở nền/điểm nhấn ít bão hòa; mỗi tờ có một tiêu điểm minh họa. Tránh chibi phủ màn hình, nút clay, sticker dày và màu kẹo. Ngưỡng cụ thể vẫn phải so A/B/C. | `PROTOTYPE` | Vừa |
| 6 | Không có default được gọi là đúng. Với tháng nhuận và tháng thiếu, người dùng chọn policy cho từng sự kiện; “ngày cuối tháng” chỉ là gợi ý tiện dụng. | `ADOPT` + `HUMAN GATE` | Cao cho guardrail; thấp cho default |
| 7 | Calendar Core dùng UTC+7; “hôm nay” và reminder theo local; có Nhịp Việt Nam. Không mutate event khi đổi nhịp. Default này vẫn cần người diaspora kiểm tra. | `PROVISIONAL` + `HUMAN GATE` | Vừa |
| 8 | Không thể biết Hiên sớm giúp hay làm mất tập trung, càng không thể ước lượng tỷ lệ tắt. Bản phát hành để Yên cho tới khi Gate 7 có dữ liệu; Hiên sớm là opt-in/ứng viên test. | `ADOPT` cho fallback + `HUMAN GATE` | Cao cho thận trọng; không có cho preference |
| 9 | Chất Việt đến từ cấu trúc khánh–xấp giấy–số lớn, vật liệu và một motif có chọn lọc; đỏ son chỉ là điểm nhấn. Không thể xác định ranh “sến” bằng web. | `PROTOTYPE` + `HUMAN GATE` | Vừa |
| 10 | Dùng progressive disclosure: nhãn ngắn ở tờ/mặt sau, chi tiết nguồn và phương pháp ở trang nguồn. Chưa thể nói điều này làm tăng trust. | `PROTOTYPE` + `HUMAN GATE` | Vừa |
| 11 | Giữ cùng ngôn ngữ trẻ nhưng cho nội dung reflow, chữ 200%, nhãn rõ, vùng chạm 44 pt và action thay gesture. Chỉ test trên thiết bị với người thật mới xác nhận dùng được. | `ADOPT` cho requirement + `HUMAN GATE` | Cao cho requirement; không có cho usability |

## 4. Hướng sản phẩm sau vòng desk research

Giữ concept **Mộc Son Dịu** và ba prototype A/B/C. Kết quả tra cứu UI/UX ủng hộ ba guardrail đã có:

- kéo/bóc cần action một chạm tương đương;
- text thiết yếu phải wrap, stack hoặc mở được bản đầy đủ, không clip để giữ card đều;
- dùng soft pastel với tương phản có kiểm soát; không chuyển sang claymorphism hay Gen Z maximalism.

Mặt chính vẫn là một tờ lịch, không thêm tab bar/dashboard chỉ vì đối thủ có nhiều tính năng. Widget và reminder là mức kỳ vọng cơ bản, không phải thông điệp định vị.

## 5. Câu trả lời văn hóa và dữ liệu đã đủ chắc để viết contract

- UTC+7 là ruleset của lịch Việt hiện đại; bảng tiết khí UTC+8 phải đổi múi giờ trước khi làm oracle.
- Lập Xuân là thời điểm thiên văn, không phải dự báo thời tiết. Đào/mai là diễn giải mỹ thuật theo vùng.
- Scene Quốc khánh chỉ kích hoạt ngày 2/9. Ngày nghỉ liền kề không trở thành một “Quốc khánh thứ hai”.
- Quốc kỳ và sao được dựng tay theo văn bản gốc; mã màu số là master asset của dự án, không gọi là mã pháp định.
- Pháo hoa là liên tưởng hợp lý nhưng không được nói mọi địa phương đều tổ chức.
- Phạm vi 1900–2100 là phạm vi tính toán đã kiểm thử. Ngày trước 1976 cần nhãn lịch sử/hồi chiếu; không gọi toàn bộ là lịch chính thức.

## 6. Phần phát triển bằng tài liệu đã làm tới đâu

Hồ sơ hiện đã có tầm nhìn, UX/art direction, dữ liệu, kiến trúc, contracts, effect/audio pipeline, Spec Kit, research instruments, sổ chứng cứ và panel mô phỏng. Các decision file có thể soạn trước được điền ở trạng thái draft hoặc blocked.

Phần không thể hoàn tất chỉ bằng Markdown:

- quan sát lịch bloc vật lý đủ mẫu có quyền;
- phiên test với 20 người, vòng 55+/VoiceOver và diaspora;
- audio mẫu nghe, motion/interactive prototype và test trên thiết bị;
- chuyên gia/owner chịu trách nhiệm ruleset tốt/xấu và golden corpus;
- quyết định người trả phí Apple Developer cùng cam kết bảo trì;
- kiểm thử thuật toán, hiệu năng, accessibility và App Store binary.

Do đó trạng thái đúng là **document-ready, build-not-ready**. Hoàn tất tài liệu không đồng nghĩa được bắt đầu T021.

## 7. Quyết định cần chủ dự án chốt

1. Chấp nhận mặc định phát hành là **Yên**, còn Hiên sớm là lựa chọn opt-in cho tới khi có Gate 7.
2. Nếu không tìm được chuyên gia và ruleset có license/owner rõ, chấp nhận loại “tốt/xấu” khỏi 1.0.
3. Chọn người chịu phí Apple Developer, review dữ liệu và lịch bảo trì tối thiểu.
4. Quyết định khi nào có thể tuyển mẫu nhỏ đầu tiên; nếu tiếp tục không có người thật, giữ các gate ở trạng thái chưa kiểm chứng thay vì hạ ngưỡng.
