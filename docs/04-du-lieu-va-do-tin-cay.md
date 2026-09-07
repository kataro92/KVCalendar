# 04 — Dữ liệu lịch và độ tin cậy

Đây là phần có rủi ro lớn nhất của sản phẩm. Một tờ lịch đẹp nhưng sai ngày âm, tháng nhuận, giờ hoặc ngày nghỉ sẽ làm mất niềm tin ngay lập tức.

## 1. Chính sách sản phẩm về “đúng”

Không dùng một chữ “chính xác” chung cho mọi trường. Mỗi loại dữ liệu có bản chất khác nhau:

| Tầng | Ví dụ | Loại bằng chứng | Cách trình bày |
|---|---|---|---|
| A — tính toán/xác định | ngày dương, thứ, ngày âm, tháng nhuận, Can Chi, tiết khí | thuật toán lịch/thiên văn, múi giờ, test vectors | Hiển thị như dữ kiện; có phạm vi và phiên bản |
| B — pháp lý/chính thức | ngày nghỉ, lịch hoán đổi, làm bù | văn bản nhà nước theo từng năm | Nhãn “Nghỉ lễ chính thức”, liên kết nguồn, ngày cập nhật |
| C — văn hóa/biên tập | ngày kỷ niệm, lễ hội, ca dao, phong tục | nguồn văn hóa, biên tập, giấy phép | “Ngày kỷ niệm”, “Theo phong tục…”, nguồn tác phẩm |
| D — lịch truyền thống | hoàng/hắc đạo, giờ tốt, trực, hướng xuất hành | quy tắc/trường phái lịch dân gian | Luôn ghi “tham khảo”, nêu phương pháp, không hứa kết quả |
| E — cá nhân | ngày giỗ, sinh nhật, ghi chú | người dùng nhập | Chỉ lưu trên máy, không dùng làm dữ liệu phân tích |

## 2. Lịch âm Việt Nam là âm–dương lịch thiên văn

Theo tài liệu của Hồ Ngọc Đức, các nguyên tắc chính gồm:

1. ngày đầu tháng âm là ngày chứa điểm Sóc (new moon);
2. năm thường có 12 tháng, năm nhuận có 13 tháng;
3. Đông chí luôn nằm trong tháng 11 âm;
4. ở năm có 13 tháng, tháng nhuận là tháng đầu tiên sau Đông chí không chứa Trung khí;
5. tính lịch Việt Nam hiện đại theo kinh tuyến 105° Đông/múi giờ UTC+7.

Nguồn gốc và công thức chi tiết: [Hồ Ngọc Đức — Thuật toán tính âm lịch](https://www.xemamlich.uhm.vn/calrules.html).

### Hệ quả kỹ thuật

- Không dùng `Calendar.Identifier.chinese` của Foundation làm nguồn sự thật cho lịch Việt. Apple chỉ định danh lịch Trung Quốc; lịch Việt có thể khác do múi giờ.
- Phải truyền/chốt múi giờ tính lịch một cách chủ ý, không lấy ngầm múi giờ hiện tại của máy cho phần lịch Việt.
- Ngày đầu tháng phụ thuộc thời điểm Sóc quy đổi sang ngày địa phương. Sai vài phút gần nửa đêm có thể làm lệch cả ngày đầu tháng.
- Tháng nhuận không đơn giản là “cứ ba năm một lần”; phải tìm tháng không có Trung khí theo quy tắc.
- Can Chi là trường dẫn xuất riêng; phải kiểm thử độc lập thay vì coi “đổi ngày đúng” là đủ.

Hong Kong Observatory giải thích rằng lịch âm có thể lệch một ngày giữa các nguồn khi thuật toán thiên văn hoặc chuẩn giờ khác nhau, nhất là khi Sóc gần nửa đêm: [HKO — Calendar discrepancies](https://www.hko.gov.hk/en/Observatorys-Blog/101741/Which-day-is-the-Tuen-Ng-Festival-for-this-year-2013).

## 3. Múi giờ và lịch sử

### 3.1. Lịch hiện đại

Việt Nam hiện dùng UTC+7 quanh năm và không đổi giờ mùa hè: [Timeanddate — Vietnam time zone](https://www.timeanddate.com/time/zone/vietnam). Đối với ngày hiện đại, engine công bố là “Lịch Việt UTC+7”.

### 3.2. Ngày lịch sử không đơn giản

Tài liệu VNCal lưu ý:

- nguyên tắc lịch Việt hiện đại mới được áp dụng thống nhất toàn quốc từ 1976;
- lịch lịch sử có thể khác lịch thiên văn hồi chiếu do múi giờ và độ chính xác công thức;
- giai đoạn 1968–1975 có thể khác giữa miền Bắc (UTC+7) và miền Nam (lịch Trung Quốc/UTC+8);
- ví dụ 13/12/1974 tương ứng 1/11 âm ở miền Bắc nhưng 30/10 âm ở miền Nam.

Nguồn: [Hồ Ngọc Đức — Vietnamese lunar calendar](https://www.xemamlich.uhm.vn/vncal.html).

### Quyết định đề xuất cho 1.0

- Công bố phạm vi tra cứu **1900–2100**.
- Với ngày từ 1976 trở đi: dùng lịch Việt hiện đại UTC+7.
- Với 1900–1975: hiển thị nhãn “lịch thiên văn hồi chiếu”; khi tạo ngày kỷ niệm lịch sử, hỏi vùng/nguồn ngày gốc nếu ngày nằm trong tập có khả năng chênh.
- Chuẩn bị một bảng ngoại lệ hoặc chế độ “lịch pháp định/lịch sử” trước khi hứa hỗ trợ chính xác ngày sinh/giỗ trước 1976 trên toàn quốc.
- Nếu chưa hoàn thiện lịch sử, không cho tạo nhắc lặp từ ngày âm trước 1976 mà không hiện cảnh báo giải thích.

Phạm vi 1900–2100 là lựa chọn sản phẩm, không phải giới hạn bắt buộc của thuật toán. Bản JavaScript tham khảo của Hồ Ngọc Đức công bố phạm vi 1800–2199, nhưng tài liệu cũng nói thuật toán đơn giản hóa có độ chính xác thấp hơn chương trình đầy đủ; vì thế không nên lấy phạm vi rộng làm claim marketing khi chưa kiểm thử.

## 4. Nguồn sự thật và cách triển khai dữ liệu

### 4.1. Calendar Engine

Nguồn tham khảo khởi đầu là mô tả thuật toán Hồ Ngọc Đức, dựa trên Julian Day Number, tính Sóc, kinh độ Mặt Trời, tháng 11 và tháng nhuận. Tuy nhiên không sao chép mù một port ngẫu nhiên.

Quy trình bắt buộc:

1. đọc và ghi lại nguồn/công thức gốc;
2. kiểm tra giấy phép của mọi mã tham khảo trước khi sử dụng;
3. viết triển khai riêng hoặc dùng thư viện có giấy phép tương thích;
4. tạo bộ ngày chuẩn độc lập;
5. đối chiếu ít nhất hai nguồn, điều tra mọi khác biệt;
6. đóng băng phiên bản engine và data release;
7. công khai phạm vi hỗ trợ và các ngoại lệ đã biết.

### 4.2. Không dùng API web làm lõi

Lịch hôm nay, đổi ngày, Can Chi, tiết khí và nhắc phải tính được trên máy. API web tạo bốn rủi ro: mất mạng, nguồn đổi, theo dõi request và chi phí vận hành. Có thể dùng dịch vụ ngoài trong giai đoạn QA để đối chiếu, không dùng làm runtime dependency.

### 4.3. Tách engine và nội dung

- **Engine** tạo dữ kiện dẫn xuất từ ngày/múi giờ.
- **Official dataset** chứa ngày nghỉ/hoán đổi theo văn bản.
- **Culture dataset** chứa lễ truyền thống, kỷ niệm, mô tả và nguồn.
- **Almanac ruleset** chứa quy tắc dân gian và tên phương pháp.
- **Editorial deck** chứa câu/mẩu nội dung theo giấy phép.
- **Personal store** chứa dữ liệu người dùng, không đi cùng các bundle trên.

Tách như vậy giúp sửa một ngày nghỉ hoặc một câu sai mà không làm thay đổi thuật toán âm lịch.

## 5. Ngày lễ, ngày nghỉ và ngày kỷ niệm

Không dùng một nhãn “ngày lễ” cho mọi thứ.

### Taxonomy bắt buộc

- **Ngày nghỉ theo luật:** quyền nghỉ hưởng lương ở cấp quốc gia.
- **Lịch nghỉ/hoán đổi năm cụ thể:** cách bố trí cho một nhóm đối tượng; có thể có ngày làm bù.
- **Ngày kỷ niệm quốc gia:** có ý nghĩa nhưng không mặc nhiên là ngày nghỉ.
- **Lễ truyền thống theo âm lịch:** Tết Đoan Ngọ, Trung Thu, Vu Lan…; có thể khác theo cộng đồng.
- **Lễ hội địa phương:** có địa bàn và khoảng thời gian, không gán cả nước.
- **Sự kiện cá nhân:** do người dùng tạo.

### Vì sao phải version theo năm

Ngày nghỉ thực tế có thể có ngày liền kề, nghỉ bù và hoán đổi ngày làm việc. Ví dụ nguồn Chính phủ về Quốc khánh 2026 mô tả lịch nghỉ 5 ngày cho công chức/viên chức nhờ hoán đổi, trong khi người lao động doanh nghiệp có phương án khác: [Thông báo lịch nghỉ Quốc khánh 2026](https://xaydungchinhsach.chinhphu.vn/thong-bao-lich-nghi-le-quoc-khanh-2026-119260729092042494.htm).

Tại mốc nghiên cứu 07/09/2026, nguồn Chính phủ còn ghi Ngày Văn hóa Việt Nam 24/11 là ngày nghỉ mới, làm tổng số ngày nghỉ hưởng lương thay đổi: [Chính phủ — ngày nghỉ năm 2026](https://xaydungchinhsach.chinhphu.vn/lich-nghi-le-quoc-khanh-2-9-va-ngay-van-hoa-viet-nam-24-11-2026-119260504103718299.htm). Đây là ví dụ cho thấy hard-code một danh sách “vĩnh viễn” là sai về mô hình.

### Trường dữ liệu tối thiểu cho một occurrence chính thức

- tên hiển thị;
- loại taxonomy;
- ngày bắt đầu/kết thúc;
- hệ lịch của căn cứ;
- nhóm áp dụng;
- địa bàn;
- có nghỉ hay không;
- có nghỉ bù/làm bù hay không;
- văn bản/số hiệu/URL;
- ngày công bố;
- phiên bản data pack;
- ghi chú biên tập.

### Mapping từ occurrence sang hiệu ứng

Content Catalog và Effect Catalog phải tách nhau. Occurrence cho biết **ngày gì**; effect cue chỉ cho biết **thể hiện thế nào**.

- mapping dùng event ID ổn định, không dùng chuỗi tên tiếng Việt;
- mỗi mapping có `tone`: hân hoan, ấm, trang trọng, tưởng niệm hoặc trung tính;
- các cờ an toàn như `nationalFlag`, `religious`, `solemn`, `noConfetti`, `noAudio` chi phối resolver;
- ngày nghỉ/hoán đổi chỉ kích hoạt scene nếu occurrence chính thức của năm đó có nguồn và đang hiệu lực;
- ngày kỷ niệm có thể có effect dù không nghỉ, nhưng UI không được làm người dùng hiểu nhầm là ngày nghỉ;
- effect pack có version riêng; sửa hình/âm không làm đổi kết quả Calendar Core;
- một lỗi asset không được làm mất tên/ngày sự kiện; fallback cuối cùng luôn là mặt lịch tĩnh.

## 6. Can Chi, tiết khí và pha trăng

### Can Chi

Hiển thị ngày, tháng và năm theo quy tắc đã công bố. Kiểm thử riêng:

- chu kỳ 60 ngày;
- ranh giới năm âm;
- tháng nhuận mang tên tháng trước + “nhuận”;
- ranh giới tháng âm;
- cách gọi giờ Tý quanh nửa đêm.

### Tiết khí

Tách hai mức:

- tên tiết khí đang hiệu lực trong ngày;
- thời điểm chuyển tiết chính xác tới giờ/phút, chỉ hiển thị nếu engine và test oracle đủ độ chính xác.

Không đồng nhất “tiết khí” với dự báo thời tiết ở Việt Nam. 24 tiết khí có nguồn gốc từ hệ thiên văn/khí hậu vùng Đông Á và là thông tin lịch, không phải dự báo khí tượng tại vị trí người dùng.

Với hiệu ứng, cue như Lập Xuân gắn vào **ngày chứa thời điểm chuyển tiết trong múi giờ hiển thị**. Nếu bản engine chỉ đủ tin cậy ở độ phân giải ngày, không được in một giờ/phút giả chính xác. Artwork phải mang nhãn biên tập/cảm hứng vùng, không trở thành bằng chứng thiên văn hay khí tượng.

### Pha trăng

Ngày âm không phải ảnh chính xác tuyệt đối của pha trăng tại mọi giờ. Nếu có hình mặt trăng, ghi là minh họa hoặc tính pha theo timestamp cụ thể; không dùng một bộ 30 icon rồi gọi là thiên văn chính xác.

## 7. Ngày/giờ tốt xấu và nội dung phong tục

### Nguyên tắc biên tập

- gọi là “lịch truyền thống” hoặc “tham khảo dân gian”;
- nêu rõ ruleset/tác giả/ấn bản nếu có;
- không tổng hợp nhiều website rồi chọn kết quả tùy ý;
- không chấm điểm phần trăm kiểu khoa học nếu phương pháp không có nền tảng tương ứng;
- không cá nhân hóa theo ngày sinh trong 1.0;
- không đưa lời khuyên y tế, pháp lý, tài chính;
- khi hai phương pháp mâu thuẫn, không giấu: hiển thị khác biệt hoặc bỏ khỏi giao diện chính;
- cho người dùng tắt toàn bộ lớp này.

### Phạm vi 1.0 khuyến nghị

- Can Chi;
- tiết khí;
- ngày hoàng đạo/hắc đạo theo một ruleset có nguồn;
- giờ hoàng đạo;
- một mục “nên/tránh theo lịch truyền thống” cực ngắn nếu có nguồn biên tập chắc chắn.

Hoãn trực, Nhị thập bát tú, sao tốt/xấu, hướng xuất hành và hệ thống chọn việc cho đến khi có chuyên gia nội dung chịu trách nhiệm.

## 8. Nội dung “mỗi ngày một mẩu”

### Nguồn được phép

- ca dao/tục ngữ ở dạng tác phẩm dân gian, đối chiếu văn bản và không sao chép chú giải hiện đại;
- tác phẩm đã hết thời hạn bảo hộ sau khi được rà soát pháp lý;
- nội dung do đội ngũ tự viết;
- tác phẩm được cấp phép rõ ràng;
- minh họa nguyên bản/được cấp phép.

### Không dùng

- danh ngôn không rõ tác giả/nguồn;
- thơ, bài hát, đoạn văn hiện đại lấy từ Internet;
- “mẹo sức khỏe” không qua thẩm định;
- hình ảnh từ Google Images, sàn thương mại hoặc lịch bloc mẫu;
- mô tả lễ hội copy từ báo/website;
- nội dung AI chưa được kiểm chứng và biên tập.

### Metadata nội dung

- ID ổn định;
- văn bản;
- tác giả/nguồn;
- tình trạng bản quyền/giấy phép;
- người biên tập;
- người duyệt;
- chủ đề/mùa/ngày phù hợp;
- ngày tạo/sửa;
- version;
- ghi chú độ nhạy văn hóa.

## 9. Mô hình nhắc lịch âm

### Hai khái niệm thời gian khác nhau

- **Múi giờ tính lịch:** mặc định Lịch Việt UTC+7.
- **Múi giờ giao thông báo:** mặc định giờ địa phương của thiết bị.

Ví dụ người Việt ở California có thể muốn ngày giỗ được xác định theo lịch Việt nhưng chuông reo lúc 8:00 sáng California. UI phải nói được điều này bằng câu tự nhiên.

### Chính sách tháng nhuận

Mỗi sự kiện âm lặp năm phải lưu:

- số tháng;
- tháng thường hay nhuận ở ngày gốc;
- xử lý khi năm có tháng cùng số nhuận;
- xử lý khi năm không có tháng nhuận;
- xử lý ngày 30 ở tháng chỉ có 29 ngày.

Không chỉ lưu ngày dương đã quy đổi của năm hiện tại; nếu làm vậy, sự kiện sẽ sai năm sau.

### Lập lịch cục bộ

Không giả định iOS cho phép lên lịch vô hạn. App duy trì một cửa sổ occurrence sắp tới, làm mới khi:

- app mở/foreground;
- qua ngày mới;
- người dùng đổi sự kiện;
- múi giờ hoặc ngày hệ thống đổi;
- app được nâng cấp;
- quyền thông báo thay đổi.

Sự kiện vẫn tồn tại nếu notification không được cấp; UI phân biệt “đã lưu” và “đã bật nhắc”.

## 10. Bộ kiểm thử chuẩn

### 10.1. Golden dates

Bộ chuẩn phải gồm tối thiểu:

- Tết Nguyên Đán cho mọi năm trong phạm vi;
- tất cả ngày bắt đầu tháng âm;
- tất cả tháng nhuận và ngày đầu/cuối tháng nhuận;
- ngày trước/sau Sóc gần nửa đêm;
- Đông chí và tháng 11;
- mọi lần chuyển tiết khí;
- ngày 29/30 tháng Chạp;
- ngày 29/2 dương lịch;
- ranh giới 31/12–1/1;
- mốc có khác biệt Việt–Trung;
- tập lịch sử 1968–1975 theo miền/nguồn.

### 10.2. Properties

- dương → âm → dương trả đúng ngày trong toàn phạm vi hỗ trợ;
- âm hợp lệ → dương → âm giữ ngày/tháng/năm và cờ nhuận;
- tháng âm dài 29 hoặc 30 ngày;
- năm âm có 12 hoặc 13 tháng;
- chỉ một tháng nhuận trong năm nhuận;
- ngày trong tuần tăng tuần hoàn;
- Can Chi ngày lặp đúng 60;
- không có ngày 0, tháng 0 hoặc occurrence trùng vô lý.

### 10.3. Đối chiếu độc lập

- nguồn A: triển khai/website Hồ Ngọc Đức;
- nguồn B: bảng lịch đã xuất bản hoặc chuyên gia lịch pháp độc lập;
- nguồn C: dữ liệu chính thức cho ngày nghỉ;
- kiểm tra thủ công các khác biệt, không dùng “đa số thắng” tự động.

### 10.4. Regression corpus

Mọi bug người dùng báo và mọi đính chính nội dung phải trở thành một test hoặc fixture cố định trước khi phát hành bản sửa.

## 11. Quy trình xuất bản dữ liệu

1. Người biên tập tạo/sửa record kèm nguồn.
2. Reviewer nội dung kiểm tra câu chữ, taxonomy và bản quyền.
3. Reviewer lịch/pháp lý kiểm tra trường chuyên môn.
4. Tool validate phát hiện trùng, ngày không hợp lệ, link nguồn thiếu, version thiếu.
5. Chạy golden/property/regression tests.
6. Sinh bản xem trước một tháng ngẫu nhiên và các dịp Tết.
7. Hai người duyệt release.
8. Gắn version và checksum; bundle vào app.
9. Ghi changelog người dùng đọc được.

## 12. Cơ chế đính chính

- trang “Nguồn & phiên bản” hiển thị engine version, official data version, culture data version;
- form báo sai cho phép copy thông tin kỹ thuật nhưng không tự gửi dữ liệu cá nhân;
- changelog ghi cụ thể ngày/trường đã sửa;
- nếu lỗi ảnh hưởng nhắc, app tính lại occurrence sau update và báo một lần;
- không xóa/sửa sự kiện người dùng khi cập nhật data pack;
- với tranh luận trường phái, ghi rõ đây là khác biệt nguồn thay vì gọi một bên “sai”.
