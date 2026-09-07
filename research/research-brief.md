# Research brief: Lịch Nhà, vòng khám phá trước code

**Ngày**: 2026-09-07  
**Phạm vi**: Gate 1–4 và Gate 5A–7A trong `docs/06-ke-hoach-kiem-chung.md`
**Không làm trong vòng này**: project Xcode, mã ứng dụng, asset production, gọi Rodin/ElevenLabs runtime.

Vòng này trả lời xem người dùng có nhận ra, đọc được, thao tác được và tin được một lịch bloc số hay không. Điểm “đẹp” trung bình không đủ để mở Phase 2.

## 1. Câu hỏi nghiên cứu

Mỗi câu hỏi gắn một giả thuyết trong kế hoạch kiểm chứng. Câu hỏi phụ chỉ dùng khi câu chính chưa đủ dữ liệu để ghi pass/fail.

| ID | Câu hỏi chính | Giả thuyết | Gate |
|---|---|---|---|
| Q1 | Người tham gia gọi đây là gì trong 10 giây đầu, trước khi nghe tên sản phẩm? | H1, H8, H11 | 1 |
| Q2 | Họ mô tả cảm giác bằng từ nào: nhà, gia đình, truyền thống, trẻ, dịu, sến, trẻ con, khó đọc? | H1, H8, H11 | 1 |
| Q3 | Trong năm giây, họ đọc đúng ngày dương và ngày âm không? | H3, H4 | 3, 6 |
| Q4 | Họ chỉ đúng chỗ để xem tháng và xem chi tiết mà không được gợi ý không? | H4, H5 | 3 |
| Q5 | Họ sang ngày kế bằng cách nào: kéo góc, vuốt, nút, hay không tìm ra? | H2, H5 | 2 |
| Q6 | Nút/action thay thế (Ngày sau, Ngày trước, Hôm nay) có dùng được khi không kéo được không? | H2, H5 | 2, 5 |
| Q7 | Page curl có bị gọi là chậm, say, hoặc “trò chơi” không? | H2 | 2 |
| Q8 | Trường nào trên mặt trước bị hỏi thêm? Có phải cùng một trường ở nhiều người không? | H4 | 3 |
| Q9 | Câu “tham khảo theo lịch truyền thống” được hiểu là dữ kiện, lời khuyên, hay bảo đảm? | H7 | 3 |
| Q10 | Họ tìm nguồn của giờ hoàng đạo trong bao nhiêu thao tác? | H7 | 3 |
| Q11 | Họ tạo được ngày giỗ 12 tháng Tám âm, nhắc trước 3 ngày lúc 8 giờ, rồi giải thích lại rule tháng nhuận vừa chọn không? | H6, H10 | 4 |
| Q12 | Khi từ chối notification, họ có nghĩ sự kiện đã mất, hoặc app đã đọc lịch iPhone, không? | H6, H9 | 4 |
| Q13 | VoiceOver, chữ 200%, Reduce Motion, Increase Contrast có hoàn thành được tác vụ cốt lõi không? | H5 | 5 |
| Q14 | Khi cảnh Quốc khánh hoặc Lập Xuân chạy, họ còn đọc đúng ngày và nhận đúng sắc thái không? | (US5) | 6 |
| Q15 | Có ai phát hiện lỗi Quốc kỳ, ngôi sao, hoặc dùng biểu tượng thiếu trang trọng không? | (US5) | 6 |
| Q16 | Trong 10 giây đầu, nhóm 16–34 tắt Hiên sớm không? Sau 10–15 phút họ giữ, đổi hay tắt? | H12 | 7 |
| Q17 | Im lặng, Hiên sớm và Mưa xa khác nhau thế nào ở kết quả tác vụ ngắn, mệt tai, và loa máy so với tai nghe? | H12 | 7 |

Câu hỏi mở trong buổi tại nhà (trước khi đưa prototype) lấy đúng danh sách trong `docs/06-ke-hoach-kiem-chung.md` mục 3. Không hỏi “bạn có thích app miễn phí này không?” và không đưa danh sách feature để tick.

## 2. Mẫu và cách lấy

Tối thiểu 20 buổi khám phá. Hạn ngạch, screener và chỗ trống ghi trong `research/participants/recruitment-matrix.md`.

- 14 người thuộc nhóm chính 16–34 tuổi (6 người 16–22, 8 người 23–34).
- 3 người 35–54; 3 người 55–75 (accessibility, không dùng điểm thẩm mỹ của nhóm này để chọn concept).
- Ít nhất 2 người Việt đang ở ngoài Việt Nam.
- Ít nhất 1 người dùng VoiceOver hoặc có thị lực kém.
- Bạn bè làm thiết kế/công nghệ không quá 5/20.

Buổi 45–60 phút tại nhà hoặc video. Prototype A/B/C đưa sau khi đã xem lịch họ đang dùng và, nếu có, lịch bloc giấy trong nhà. Thứ tự A/B/C đảo theo `research/session-guide.md`.

## 3. Artifact phải có trước buổi đầu

| Task | File | Dùng để |
|---|---|---|
| T001 | `research/research-brief.md` | Câu hỏi và ngưỡng |
| T002 | `research/participants/recruitment-matrix.md` | Tuyển người |
| T003 | `research/participants/consent-and-retention.md` | Đồng ý, ẩn danh, xóa recording |
| T004 | `research/physical-calendar-audit.md` | Pattern lịch giấy; không copy artwork |
| T005–T007 | `research/prototypes/a-moc-son-diu.md`, `b-giay-moc.md`, `c-gom-lam.md` | So sánh mỹ thuật cùng nội dung |
| T008 | `research/prototypes/page-curl-study.md` | Ba mức bóc và action không kéo |
| T009 | `research/prototypes/effect-storyboards.md` | Quốc khánh, Lập Xuân, ngày thường |
| T010 | `research/prototypes/audio-study.md` | Im lặng / Hiên sớm / Mưa xa |
| T011 | `research/session-guide.md` | Moderator và 10 tác vụ |

Ghi chú buổi dùng mẫu `research/sessions/SESSION-ID.md`. Recording nằm ngoài Git, xem T003.

## 4. Ngưỡng Gate 1–4 và 5A–7A

Lấy đúng ngưỡng đã chốt trong `docs/06-ke-hoach-kiem-chung.md` và `specs/001-lich-nha-v1/spec.md` (SC-001 đến SC-010). Không hạ ngưỡng trong lúc chạy buổi.

### Gate 1, concept

Đi tiếp nếu:

- ít nhất 16/20 nhận ra lịch bloc hoặc lịch xé mà không được nói trước;
- ít nhất 14/20 mô tả cảm giác tích cực gắn với nhà, gia đình hoặc truyền thống;
- không nhóm tuổi nào xem concept là khó đọc hơn lịch app thường một cách hệ thống.

Nếu không đạt: giữ số lớn và giấy, giảm khánh và hiệu ứng; ghi thay đổi bắt buộc vào `research/decisions/001-research-gates.md`.

Concept thắng ở nhóm 16–34 cần được họ gọi là Việt, trẻ, dịu và rõ. “Dễ thương” được phép tăng. “Trẻ con”, “đồ chơi”, “sến”, “dành cho người cao tuổi” không được thành mô tả chi phối.

### Gate 2, gesture

Đi tiếp nếu:

- ít nhất 80% sang ngày kế không cần hướng dẫn;
- ít nhất 90% dùng được nút hoặc action thay thế;
- thời gian trung vị dưới 3 giây;
- không quá 10% báo khó chịu vì chuyển động.

Nếu gesture vui nhưng chậm: vuốt ngắn là mặc định, page curl là nghi thức tùy chọn.

WCAG 2.2 yêu cầu thao tác kéo do app kiểm soát phải có cách một con trỏ khác (nút hoặc menu). Prototype phải có “Ngày sau”, “Ngày trước”, “Hôm nay” với vùng chạm 44 pt; không được để kéo góc là đường duy nhất.

### Gate 3, thông tin

Đi tiếp nếu:

- 90% đọc đúng ngày dương và ngày âm trong 5 giây;
- không quá 20% đòi cùng một trường bị thiếu trên mặt trước;
- ít nhất 70% hiểu “tham khảo theo lịch truyền thống” không phải bảo đảm khoa học;
- nguồn tìm được trong hai thao tác.

Ba câu test tin cậy (cùng dữ kiện, khác lời):

1. “Ngày tốt, nên khai trương.”
2. “Theo lịch truyền thống: thuận cho khai trương.”
3. “Tham khảo theo quy tắc Hoàng đạo A: khai trương; xem cách tính.”

Khuyến nghị hiện tại: câu 2 rút gọn trên mặt trước, câu 3 ở mặt sau. Gate 3 được phép đổi khuyến nghị này.

### Gate 4, ngày giỗ

Đi tiếp nếu:

- 80% hoàn thành không trợ giúp;
- 80% giải thích lại đúng rule tháng nhuận họ vừa chọn;
- 100% hiểu event đã lưu dù notification bị từ chối;
- không ai nghĩ app đã đọc danh bạ hoặc lịch hệ thống nếu chưa xin quyền.

### Gate 5A, accessibility research

Không gọi thiết kế là sẵn sàng code nếu prototype không có action thay gesture, reflow chữ lớn và
đường semantic hợp lý cho các tác vụ nó thể hiện. Tác vụ chưa thể hiện được ghi `NOT RUN`; Gate 5B
trên build vẫn bắt buộc trước phát hành.

### Gate 6A, concept hiệu ứng

Đi tiếp nếu:

- 90% vẫn đọc đúng ngày dương/âm trong 5 giây khi cảnh chạy;
- ít nhất 80% nhận đúng sắc thái Quốc khánh và Lập Xuân;
- không participant hay reviewer phát hiện lỗi Quốc kỳ hoặc dùng biểu tượng thiếu trang trọng;
- bản Reduce Motion và Dim Flashing Lights vẫn đọc được ý nghĩa, không trông như bản hỏng;
- intro một lần/ngày được ưa hơn autoplay lặp và không gây khó chịu hệ thống;
- mỗi asset thử nghiệm (nếu có) có provenance. Vòng này dùng storyboard tĩnh; không ship model.

Hiệu năng máy thấp nhất, poster và fallback runtime thuộc Gate 6B sau implementation.

### Gate 7A, preference và mệt âm thanh

Chỉ cân nhắc đổi Hiên sớm từ opt-in thành bật có điều kiện nếu:

- không quá 25% nhóm chính (16–34) tắt trong 10 giây đầu;
- đa số không báo mệt tai hoặc mất tập trung sau 10–15 phút;
- kết quả tác vụ ngắn không giảm có hệ thống so với im lặng;
- nút tắt được tìm và dùng trong một thao tác.

Nếu không đạt: âm nền còn là opt-in. Không dùng câu “tăng tập trung” hay “điều trị” trong prototype, câu hỏi, hay ghi chú.

Silent, VoiceOver, interruption, tháo tai nghe và route change thuộc Gate 7B trên build.

## 5. Cách ghi pass/fail

- Đơn vị Gate 1, 2, 3, 4, 6A, 7A là người tham gia đã hoàn thành phần tương ứng, không phải “cảm giác của moderator”.
- Gate 5A là fail khi một tác vụ trong phạm vi prototype không xong trên cấu hình đã cam kết; phần chưa có prototype giữ `NOT RUN`.
- Thiếu người (dưới 20 buổi, hoặc thiếu hạn ngạch VoiceOver/diaspora) thì Gate chưa được ghi pass.
- Kết quả A ghi vào `research/scorecards/discovery-scorecard.md` rồi mới sang `research/decisions/001-research-gates.md`. Gate 5B–7B có report riêng sau implementation.

## 6. Việc cố ý chưa quyết ở vòng này

Sáu quyết định sản phẩm trong `README.md` (tên phát hành, iPhone/iPad, phạm vi năm, tốt/xấu trên mặt chính, mức hiệu ứng/âm mặc định, người trả phí Apple Developer) chỉ được chốt sau T016–T019. Research brief không được tự chọn giúp.

Calendar Core, golden corpus và ruleset tốt/xấu là T017–T018. Prototype dùng fixture chữ, ghi rõ không phải output engine.
