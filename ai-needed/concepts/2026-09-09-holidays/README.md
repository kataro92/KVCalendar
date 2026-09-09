# Demo Tết và Quốc khánh

Ngày tạo: 09/09/2026. Concept tĩnh, chưa phải asset production.

- Tết: hoa đào hồng, nền hồng ấm và hai bao lì xì; nhành hoa nằm ngoài chữ. Hướng chuyển động là một nhành đào lay nhẹ, các cánh hoa/bao lì xì còn lại đứng yên.
- Quốc khánh: nền trời sớm, lịch ngày 02 tháng Chín và một lá cờ phía trên. Nếp biên vải gợi trạng thái phấp phới; ngôi sao giữ nguyên hình và chiều. Đây là ảnh tĩnh, chưa có animation.
- Âm nền mặc định gắn với ngày theo chỉ dẫn mới của người dùng. Chỉ có bật/tắt âm nền và giữ sáng, không có trình nghe nhạc.
- Cả hai tiếp tục hướng Mộc Son Dịu và đối tượng 16–34 tuổi. Mỗi cảnh tối đa một hiệu ứng chính; Reduce Motion/Low Power có poster tĩnh.

## Quốc kỳ dựng thủ công

Công cụ tạo ảnh chỉ tạo tờ lịch và nền không có cờ/ngôi sao. Cờ, cột, màu và ngôi sao được xác định bằng hình học riêng, sau đó ghép lên nền theo quy tắc AGENTS.md. Không đưa bản có cờ trở lại mô hình tạo sinh.

Tỷ lệ mặt cờ gốc 3:2; tâm sao ở giữa; bán kính ngoài bằng 1/5 chiều dài; năm đỉnh ngoài, một đỉnh hướng thẳng lên. Nếp vải chỉ tác động đường biên; ngôi sao không bị warp. Nguồn đối chiếu: [Bộ Văn hóa, Thể thao và Du lịch](https://bvhttdl.gov.vn/Pages/chi-tiet.aspx?url=/huong-dan-su-dung-quoc-ky-quoc-huy-quoc-ca-chan-dung-chu-tich-ho-chi-minh-3747.htm) và [Cổng thông tin Chính phủ](https://chinhphu.vn/quoc-ky-quoc-huy-quoc-ca-tuyen-ngon-68378).

Màu số đỏ #DA251D và vàng #FFFF00 là swatch chọn thủ công cho demo, không khẳng định là mã hex pháp định. File đo và SVG giữ hình học để duyệt. Codex đã kiểm tỷ lệ, đỉnh sao và xem ảnh ghép; chưa có con người duyệt văn hóa/màu/hiệu năng, nên trạng thái production vẫn HOLD.

## Giới hạn để dựng giao diện

Tết dùng ví dụ 17 tháng Hai, mùng Một tháng Giêng năm 2026; ảnh chưa hiện năm/thứ. Quốc khánh chưa có ngày âm. Đây không phải bộ dữ liệu lịch đã kiểm chứng. Bản UI cần dựng chữ thật theo Design Master, bổ sung dữ liệu thiếu và kiểm Dynamic Type, VoiceOver, tương phản, vùng chạm 44 pt. Không dùng raster này làm giao diện tương tác.

Ảnh chọn: [Tết](04-tet-hoa-dao-v1.png), [Quốc khánh](05-quoc-khanh-v1.png). Nền Quốc khánh chưa ghép cờ chỉ là intermediate. Prompt và output gốc được giữ trong hồ sơ. Không tạo nhạc, mã ứng dụng, model Rodin hoặc chạy gate triển khai.

