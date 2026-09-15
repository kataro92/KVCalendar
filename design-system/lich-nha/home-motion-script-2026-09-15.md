# Kịch bản motion trang hôm nay — Lịch Nhà

## Ý đồ

Trang hôm nay cần có cảm giác một tờ lịch bloc đang ở trong căn phòng thật: giấy có trọng lượng, nắng và gió chỉ lay rất nhẹ ở rìa khung. Chuyển động là lớp không khí, không tranh sự chú ý với ngày dương, ngày âm và lời nhắc.

Ngôn ngữ chung: **Gió nhẹ trong góc lịch**. Mỗi cảnh chỉ có một hiệu ứng chính; các chi tiết còn lại đứng yên để mắt có điểm tựa.

## Nhịp chung

| Mốc | Trạng thái | Quy tắc |
| --- | --- | --- |
| 0–250 ms | Vật liệu ổn định | Giấy, bóng và khung vào vị trí; không bật sáng. |
| 250–1.800 ms | Intro | Hiệu ứng chính xuất hiện theo một hướng, không đi qua vùng chữ. |
| Sau 1.800 ms | Lắng | Chỉ còn một chuyển động ambient rất chậm, có khoảng nghỉ dài. |
| Chạm/kéo | Đọc lịch | Không tự phát thêm hiệu ứng; thao tác bóc lịch vẫn là tín hiệu chính. |
| Replay | Xem lại | Chạy lại intro một lần, sau đó quay về lắng. |

Vùng an toàn của ngày dương, ngày âm và lời nhắc luôn sạch. Hiệu ứng được cắt ở rìa cảnh; không để lá, cánh hoa hay burst xuyên qua nội dung.

## Kịch bản theo cảnh

### Ngày thường — lá theo gió

- 2–3 lá giấy màu mộc son xuất hiện lệch ở góc trên và dưới, bay chéo 3–5 giây, xoay nhẹ ±12° và có nhịp lắc không đều.
- Intro có một lượt bay thưa; sau đó mỗi 6–10 giây mới có một lá lướt qua. Không dùng loop đồng bộ.
- Lá nằm ngoài vùng chữ và không vượt quá độ tương phản của tiêu đề. Bóng lá tĩnh là poster fallback.

### Lập Xuân — cành và cánh hoa

- Cành giữ tĩnh ở góc; một nhóm 6–8 cánh hoa rơi lệch hướng trong 1,8–3,5 giây.
- Sau intro chỉ giữ 1–2 cánh hoa thỉnh thoảng trôi; không biến thành tuyết hoa liên tục.

### Quốc khánh — pháo hoa giấy

- Tối đa 2–3 burst nét giấy, xuất hiện lệch nhau trong 2,5 giây; tia ngắn, mờ dần, không chớp toàn màn hình.
- Poster có tia tĩnh và wash hồng đào; không để burst chạm cờ hoặc chữ.

## Khả năng tiếp cận và hiệu năng

- Reduce Motion: bỏ chuyển động và intro, giữ poster tĩnh cùng bóng giấy.
- Dim Flashing Lights: không dùng pulse, nhấp nháy hoặc đổi độ sáng đột ngột.
- Low Power / nhiệt cao: chuyển sang nhịp thưa hoặc poster; không chạy hạt liên tục.
- VoiceOver và thao tác thay thế không phụ thuộc vào animation; mọi vùng tương tác vẫn tối thiểu 44 pt.
- Seed cố định theo ngày để mỗi lần mở có bố cục ổn định, tránh cảm giác hỗn loạn.

## Phạm vi lát đầu tiên

Lát đầu triển khai chuyển động lá bằng Canvas/SwiftUI với silhouette vẽ thủ công, chưa cần model 3D hay asset sinh thành. Khi có asset PNG lá trong suốt, giữ nguyên quỹ đạo và thay renderer; không thay đổi kịch bản hoặc vùng an toàn.

## Tiêu chí duyệt

- Có thể đọc toàn bộ ngày và lời nhắc trong 2 giây đầu mà không bị vật thể che.
- Chỉ một hiệu ứng chính đang chuyển động trong mỗi cảnh.
- Ảnh poster tĩnh vẫn có chủ đề khi Reduce Motion bật.
- Không có lỗi nhấp nháy, lá lặp đồng bộ, hoặc chuyển động xuyên qua vùng chữ.
