# 003 — Ruleset ngày/giờ tốt xấu

**Trạng thái:** `ACCEPTED · GIỮ TRONG 1.0, BA PHƯƠNG PHÁP TÁCH RIÊNG`
**Ngày rà soát:** 08/09/2026
**Liên kết task:** T018
**Ruleset Owner:** chủ dự án (ký T019/T020)

## Quyết định

1.0 giữ lớp lịch truyền thống ở mặt sau, widget không, có thể tắt toàn bộ. Mặt trước không in một nhãn “tốt/xấu” tổng hợp. Can Chi và tiết khí ở Calendar Core, không thuộc lớp này.

Ba phương pháp được phép hiển thị, mỗi phương pháp một khối, một `methodId`, một nguồn. UI không trộn chúng thành một kết luận hay một màu tín hiệu.

| methodId | Tên hiển thị | Việc được làm | Việc không được làm |
|---|---|---|---|
| `hoang-hac-dao` | Giờ Hoàng Đạo / Hắc Đạo | 12 canh giờ, 6 cát / 6 hung theo 12 thiên thần | Không gọi là kết quả thiên văn hay pháp định |
| `luc-dieu` | Lục Diệu (dân gian) | Sáu cung Đại An, Lưu Niên, Tốc Hỷ, Xích Khẩu, Tiểu Cát, Không Vong theo tháng/ngày/giờ âm | Không ghi “Khổng Minh tính” như sự kiện lịch sử |
| `sat-chu-tho-tu` | Sát Chủ / Thọ Tử | Cờ kỵ theo chi ngày và tháng âm, sau khi khóa bảng từ một ấn bản đã đặt tên | Không lấy bảng từ blog tử vi hay app đối thủ |

Nhãn bắt buộc: “tham khảo theo lịch truyền thống”. Có công tắc tắt cả lớp. Không điểm phần trăm, không lời khuyên y tế/tài chính/pháp lý/hôn nhân/tang lễ, không cá nhân hóa theo ngày sinh.

## Nguồn học thuật và văn bản gốc

Ngày truy cập URL: 08/09/2026. Blog “xem ngày tốt” không vào cột nguồn chịu trách nhiệm.

### Hiệp Kỷ Biện Phương Thư (協紀辨方書)

Bộ 36 quyển, hoàn thành 1739, giám tu Doãn Lộc (允祿), Mai Cốc Thành, Hà Quốc Tông; còn gọi Khâm định. Có trong Tứ Khố toàn thư. Ulrich Theobald mô tả đây là sách triều đình dùng để sửa lịch chú cũ theo Can Chi, ngũ hành và thiên tượng: [(Qinding) Xieji bianfang shu](http://chinaknowledge.de/Literature/Daoists/xiejibianfangshu.html).

Đây là nguồn khung cho giờ Hoàng/Hắc đạo và thần sát trong 1.0. Engine tự cài quy tắc đã đối chiếu, không nhúng văn bản dịch hiện đại.

Bản dịch tiếng Việt Vũ Hùng và Lê Bình (Nxb. Mũi Cà Mau, 2002, dịch từ Cổ tịch Thượng Hải 1995) còn bản quyền. Dùng để đối chiếu nội bộ. Không copy lời dịch vào pack hay UI.

### Lịch pháp Việt Nam, Khâm thiên giám

Nguyễn Công Việt (Viện Nghiên cứu Hán Nôm) phân biệt hai lớp: lịch pháp định triều Nguyễn (`Đại Nam hiệp kỷ lịch`, `Khâm định vạn niên thư`) và thông thư dân gian (`Ngọc hạp thông thư`, `Hiệp kỷ biện phương`, `Ngọc hạp toản yếu`). Ông cũng ghi vua Càn Long sai Mai Cốc Thành tu chỉnh thành Hiệp kỷ biện phương thư 36 quyển. Bài: [Sơ lược về Nhị thập bát tú trong tài liệu lịch pháp Hán Nôm](https://nghiencuulichsu.com/2016/08/10/so-luoc-ve-nhi-thap-bat-tu-trong-tai-lieu-lich-phap-han-nom/) (Tạp chí Hán Nôm số 1 (80), 2007). Cùng tác giả: “Sơ lược về 24 Tiết khí trong Đại Nam hiệp kỷ lịch”, Tạp chí Hán Nôm số 6 (73), 2005.

Lịch Nhà không giả làm lịch Khâm thiên giám. Lớp almanac là tham khảo dân gian có nguồn, không phải văn bản pháp định.

### Lục Diệu / Tiểu Lục Nhâm (小六壬)

Tên học thuật gần nhất là Tiểu Lục Nhâm, không phải Lục Nhâm đại thức (三式). Gắn với Gia Cát Lượng hay Lý Thuần Phong là truyền thuyết; bài khảo của Phan Lạc Đức ghi không có chứng cứ, và lục diệu chưa thấy trong lịch chú Đường sơ: [小六壬的前世今生](https://www.master-insight.com/article/32868). Hiệp Kỷ Biện Phương Thư có nhắc “小六壬” khi bàn thần sát (dẫn lại trong các bài khảo về 小六壬); chưa đối chiếu nguyên văn quyển tương ứng trong Tứ Khố trước khi ghi chú UI.

Vì thế UI dùng “Lục Diệu (dân gian)”. Không viết “Khổng Minh Lục Diệu” như bằng chứng tác giả.

### Sát Chủ và Thọ Tử (Thụ Tử)

Đây là thần sát theo tháng âm và chi ngày, nằm trong hệ thông thư chứ không phải một nhánh của Lục Diệu. Bảng trên website phong thủy hiện đại lệch nhau từng chi. 1.0 chỉ ship sau khi một bảng đã khóa khớp một ấn bản đặt tên (Hiệp Kỷ Biện Phương Thư hoặc một bản Ngọc hạp có provenance), có test vector, và không lấy từ app thương mại.

## Hợp đồng hiển thị

- Mặt trước: không có dòng “ngày tốt/ngày xấu” gộp. Có thể có marker trung tính “có giờ Hoàng Đạo” nếu người dùng bật lớp và Dynamic Type còn chỗ; Gate 3 chưa chạy nên mặc định để mặt sau.
- Mặt sau: từng phương pháp một mục, nguồn, version, `rulesetId`.
- Khi hai phương pháp trái nhau, hiện cả hai. Không chọn “cái đúng hơn”.
- Tắt lớp: biến mất khỏi mặt lịch, chi tiết, tìm kiếm, notification và hiệu ứng.
- Màu đỏ/xanh không phải tín hiệu duy nhất. VoiceOver đọc tên phương pháp và nhãn tham khảo.

## Cổng còn mở sau T018

T018 chốt phạm vi và owner. Các cổng sau vẫn bắt buộc trước khi pack almanac vào binary phát hành:

| Cổng | Trạng thái 08/09/2026 |
|---|---|
| Ruleset Owner | Chủ dự án |
| Ấn bản cụ thể cho từng bảng thần sát | Chưa khóa file; T069/T074/T079 |
| Chuyên gia độc lập lịch pháp/văn hóa | Chưa có; T147 không được bỏ |
| Giấy phép | Tự triển khai quy tắc; không copy dịch 2002 hay website |
| Corpus expected output | Chưa có; AlmanacCoreTests |
| Bằng chứng người dùng hiểu nhãn “tham khảo” | Gate 3 `UNTESTED`; giữ nhãn và công tắc |

## Ruleset 1.0

- `rulesetId`: `lich-nha-truyen-thong-1`
- `version`: `1.0.0-draft` cho tới khi corpus và ấn bản thần sát khóa
- Phạm vi ngày: cùng Calendar Core, 1900–2100, Can Chi theo engine UTC+7
- Không dùng `Calendar.Identifier.chinese` để suy giờ Hoàng Đạo
