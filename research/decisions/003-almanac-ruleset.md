# 003 — Ruleset ngày/giờ tốt xấu

**Trạng thái:** `DRAFT · HOLD — đề xuất không đưa vào 1.0`
**Ngày rà soát:** 07/09/2026

## Quyết định an toàn

Chưa có bộ quy tắc hoàn chỉnh, nguồn chịu trách nhiệm, ruleset owner hoặc chuyên gia độc lập. Vì vậy, Lịch Nhà không nên phát hành nội dung ngày/giờ tốt xấu trong 1.0. Các fixture chữ ở prototype chỉ dùng để kiểm tra bố cục, không phải kết quả lịch thật.

`HOLD` chỉ được gỡ khi toàn bộ cổng ở cuối tài liệu đạt. Nếu không đạt trước khi khóa phạm vi, loại trường hoàng/hắc đạo, giờ tốt/xấu và lời khuyên liên quan khỏi mặt trước, mặt sau, widget, notification và chia sẻ của 1.0.

## Hợp đồng hiển thị nếu được duyệt ở phiên bản sau

- Nội dung chỉ là **tham khảo theo lịch truyền thống**, không phải dự báo, bảo đảm hay căn cứ chuyên môn.
- Mặt trước chỉ có nhãn ngắn, trung tính. Lý do, phương pháp, nguồn và phiên bản nằm ở phần chi tiết theo progressive disclosure.
- Người dùng tìm được “Nguồn & cách tính” trong tối đa hai thao tác; đây là yêu cầu cần kiểm thử, chưa phải kết quả đã xác nhận.
- Không dùng điểm phần trăm, xếp hạng tuyệt đối, ngôn ngữ gây sợ hãi hoặc mệnh lệnh như “phải”, “cấm”, “chắc chắn”.
- Không cá nhân hóa quyết định y tế, tài chính, pháp lý, hôn nhân hoặc tang lễ từ ruleset này.
- Không dùng đỏ/xanh làm tín hiệu duy nhất. Nhãn chữ phải đọc được bằng VoiceOver và ở Dynamic Type lớn.
- Có công tắc tắt toàn bộ lớp “Lịch truyền thống”. Khi tắt, lớp này không xuất hiện ở mặt lịch, chi tiết, widget, notification, tìm kiếm hay hiệu ứng.
- Mỗi kết quả lưu `rulesetId`, phiên bản, nguồn và giải thích đủ để tái tạo. Cùng đầu vào và phiên bản phải cho cùng kết quả.

## Cổng để chọn ruleset

1. Có **Ruleset Owner** được nêu tên, chịu trách nhiệm nội dung, phiên bản và xử lý mâu thuẫn.
2. Có nguồn/ấn bản cụ thể và phạm vi trường được trích; không ghép ngầm nhiều trường phái.
3. Có ý kiến bằng văn bản của chuyên gia phù hợp về lịch pháp và thực hành văn hóa Việt Nam.
4. Có kết luận giấy phép cho việc trích, chuyển thể và phân phối offline.
5. Có đặc tả xác định được bằng test, corpus ca chuẩn, provenance và quy trình thay đổi phiên bản.
6. Có review ngôn ngữ để người đọc hiểu đây là tham khảo, cùng test accessibility và khả năng tắt.

## Khoảng trống hiện tại

| Hạng mục | Trạng thái |
|---|---|
| Ruleset/ấn bản được chọn | Chưa có |
| Ruleset Owner | Chưa có |
| Chuyên gia chịu trách nhiệm review | Chưa có |
| Giấy phép nguồn và dữ liệu dẫn xuất | Chưa có kết luận |
| Corpus và expected outputs | Chưa có |
| Chính sách khi các trường phái mâu thuẫn | Chưa có |
| Bằng chứng người dùng hiểu nhãn “tham khảo” | Chưa có người dùng thật |

Các tài liệu sản phẩm hiện còn đề xuất một dòng tốt/xấu trên mặt trước. Đề xuất đó phải được xem là chưa duyệt và nhường cho quyết định `HOLD` này cho đến khi T018 có đủ owner, chuyên gia và nguồn chịu trách nhiệm.

Tài liệu này **không hoàn tất T018**. Nó ghi phương án giảm rủi ro trong lúc chưa có bằng chứng, không phải phê duyệt một ruleset.
