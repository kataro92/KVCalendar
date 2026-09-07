# Sổ chứng cứ nghiên cứu bàn giấy

Ngày khóa lát cắt: **07/09/2026**
Phạm vi: thị trường iOS Việt Nam, lịch âm Việt Nam, âm nền, biểu tượng và phương pháp persona tổng hợp.

File này không thay `docs/07-nguon-tham-khao.md`. Nó nối từng nguồn với một nhận định có thể dùng trong quyết định sản phẩm. Số sao, giá, lịch sử phiên bản và khai báo riêng tư trên App Store chỉ đúng tại ngày chụp. Đánh giá công khai là mẫu tự chọn, không đại diện cho toàn bộ người dùng.

## Cách đọc

- `OBS`: quan sát trực tiếp từ nguồn.
- `INF`: suy luận của nhóm từ một hoặc nhiều `OBS`.
- `HYP`: giả thuyết cần kiểm tra với người thật hoặc prototype.
- `DEC`: quyết định của chủ dự án hay quy tắc an toàn; không được trình bày như phát hiện người dùng.
- `P`: nguồn chính thức, văn bản gốc hoặc nghiên cứu gốc/tổng quan có bình duyệt.
- `S`: nguồn chuyên môn thứ cấp.
- `M`: metadata hoặc tuyên bố của nhà cung cấp.
- `U`: đánh giá công khai do người dùng tự đăng.

## Thị trường và hành vi gián tiếp

| ID | Loại | Chứng cứ | Điều được phép suy ra | Điều không được suy ra |
|---|---|---|---|---|
| E01 | OBS · M | [Lịch Việt](https://apps.apple.com/vn/app/id585253443) và [Vạn Niên Lịch](https://apps.apple.com/vn/app/id1071624317) đều có lượng đánh giá lớn, quảng cáo hoặc gói trả phí ở lát cắt hiện tại | Category lịch Việt trên iOS đã tồn tại lâu; quảng cáo/paywall là vấn đề cạnh tranh có thật | DAU, retention, tuổi người dùng hoặc mức thích lịch bloc |
| E02 | OBS · U | Các trang đánh giá của [Vạn Niên Lịch](https://apps.apple.com/vn/app/id1071624317?platform=iphone&see-all=reviews) và [Lịch Việt](https://apps.apple.com/vn/app/id585253443?platform=iphone&see-all=reviews) có phản ánh trực tiếp về quảng cáo | “Không quảng cáo” giải quyết một nỗi đau được ghi nhận | Tỷ lệ người dùng bỏ app vì quảng cáo hoặc willingness-to-pay |
| E03 | OBS · M | [Lịch Việt Full](https://apps.apple.com/vn/app/id6769069192) tuyên bố miễn phí, không quảng cáo/IAP, offline, không thu thập dữ liệu; lịch sử bản mô tả đỏ son–vàng đồng và lịch bloc | Các lời hứa này không còn là điểm độc nhất; phải bỏ claim “đầu tiên” | Chất lượng thực tế hay product–market fit; app có rất ít đánh giá tại ngày chụp |
| E04 | OBS · M/U | [vLunar](https://apps.apple.com/vn/app/id1531851878) có UI hiện đại, widget/Watch và lịch sự kiện; [Lịch Âm Việt Nam Lunar](https://apps.apple.com/vn/app/id6477778908) có widget, Lock Screen/Watch và nhắc âm lịch | Widget và nhắc âm lịch là mức kỳ vọng cơ bản; gọn/đẹp/privacy cũng đã có đối thủ | Một checklist dài sẽ làm người dùng chọn Lịch Nhà |
| E05 | INF | Widget/Watch/Lock Screen hỗ trợ xem nhanh; yêu cầu ngày giỗ/reminder xuất hiện trong review và version history | Có thể dựng walkthrough cho hai ngữ cảnh “liếc nhanh” và “chuẩn bị việc gia đình” | Thời điểm mở app thật trong ngày hoặc nghi thức tại bàn thờ |
| E06 | OBS · S | [DataReportal Digital 2025: Vietnam](https://datareportal.com/reports/digital-2025-vietnam), [UNICEF: Disrupting Harm in Viet Nam](https://www.unicef.org/innocenti/media/4181/file/DH-Viet-Nam-Report-2022.pdf) và [Q&Me về Tết 2022](https://qandme.net/vi/baibaocao/ky-vong-cua-nguoi-viet-vao-dip-tet-2022.html) cho bối cảnh dùng internet/smartphone và ý nghĩa gia đình–phong tục | Truyền thống và đời sống số có thể cùng tồn tại như bối cảnh thiết kế | Nhu cầu iOS, lịch âm, pastel, bóc lịch hoặc hiệu ứng của nhóm 16–34 |

## Lịch, múi giờ và văn hóa

| ID | Loại | Chứng cứ | Điều được phép suy ra | Điều không được suy ra |
|---|---|---|---|---|
| E07 | OBS · P | [Quyết định 134/2002/QĐ-TTg](https://vbpl.vn/TW/Pages/vbpq-toanvan.aspx?ItemID=21982) lấy múi giờ thứ 7 làm giờ chính thức của Việt Nam | Calendar ruleset hiện đại dùng UTC+7; ngày dân sự thiết bị và giờ notification là lớp khác | Người ở nước ngoài muốn UI đổi ngày theo UTC+7 |
| E08 | OBS · P/S | [Bản tin VAST 02/2019](https://isdi.vast.vn/bantin/BantinKHCN022019.pdf), [quy tắc lịch Việt](https://www.xemamlich.uhm.vn/calrules_en.html) và [VNCal](https://www.xemamlich.uhm.vn/vncal.html) mô tả Sóc, Khí, tháng nhuận và lịch sử khác biệt 1968–1975 | Tháng có 29/30 ngày; lịch sử trước 1976 cần nhãn; phạm vi 1900–2100 là phạm vi tính toán đã kiểm thử, không phải toàn bộ “lịch chính thức” | Một thuật toán đơn giản đã đủ làm oracle duy nhất |
| E09 | OBS · P | [Hong Kong Observatory — 24 Solar Terms](https://www.hko.gov.hk/en/gts/time/24solarterms.htm) và [Solar Term](https://www.hko.gov.hk/en/gts/astronomy/Solar_Term.htm) mô tả 24 phần 15°, Trung khí và thời điểm tiết khí | Lập Xuân là mốc thiên văn; bảng HKO cần đổi UTC+8 sang UTC+7 khi đối chiếu | Lập Xuân bảo đảm thời tiết hay hoa nở giống nhau khắp Việt Nam |
| E10 | OBS · S | [Báo Giác Ngộ về giỗ trong năm nhuận](https://m.giacngo.vn/cung-tieu-tuong-va-huy-nhat-vao-nam-nhuan-post76652.html) ghi một thông lệ Phật giáo cho tháng trùng tên | Có thể giải thích đây là một lựa chọn được ghi nhận và cho gia đình đổi | Quy tắc phổ quát cho mọi gia đình; cách xử lý ngày 30 tháng thiếu |
| E11 | OBS · P | [Hiến pháp 2013, Điều 13](https://vanban.chinhphu.vn/hien-phap-nam-2013/chuong-i-che-do-chinh-tri-10052990) và [Sắc lệnh số 5](https://vbpl.vn/TW/Pages/vbpq-print.aspx?ItemID=819) quy định Quốc khánh, tỷ lệ cờ và hình học sao | Hero scene Quốc khánh chỉ gắn ngày 2/9; asset cờ phải dựng tay theo hình học nguồn | Mã màu số là “mã pháp định”; ngày nghỉ liền kề là một Quốc khánh thứ hai |
| E12 | OBS · P | [Nghị định 137/2020/NĐ-CP](https://vbpl.vn/TW/Pages/vbpq-toanvan.aspx?ItemID=146476) cho phép tổ chức pháo hoa nổ dịp 2/9 và để địa phương quyết định theo thực tế | Pháo hoa xa là liên tưởng mỹ thuật hợp lý cho scene | Mọi địa phương đều bắn pháo hoa |
| E13 | OBS · S | [Luận án University of Adelaide về thờ cúng tổ tiên](https://digital.library.adelaide.edu.au/bitstream/2440/115378/2/TranThiNien2018_PhD.pdf) cho thấy việc thực hành vẫn tồn tại trong cộng đồng Việt ở nước ngoài | Có lý do để giữ scenario diaspora và ngày gia đình | Người diaspora thích “hôm nay” local hay UTC+7; giờ nhắc họ muốn |
| E14 | DEC + HYP | Calendar ruleset dùng UTC+7; “hôm nay” và reminder mặc định theo địa phương; có tùy chọn “Nhịp Việt Nam”; timezone lưu bằng ID [IANA](https://data.iana.org/time-zones/tz-link.html) | Đây là policy có thể triển khai và test các biên DST/ngày lệch | Đây là nhu cầu đã được người diaspora xác nhận |

## Âm thanh và nền tảng

| ID | Loại | Chứng cứ | Điều được phép suy ra | Điều không được suy ra |
|---|---|---|---|---|
| E15 | OBS · P | [Meta-analysis 2024](https://pubmed.ncbi.nlm.nih.gov/38428577/) gồm 13 nghiên cứu/N=335 ở nhóm ADHD hoặc triệu chứng chú ý cao; hiệu quả nhỏ, trong khi nhóm đối chứng không ADHD có kết quả âm | Không có cơ sở cho mặc định phổ quát hay lời hứa tăng tập trung; release an toàn nên opt-in nếu chưa test | “Hiên sớm” chắc chắn có lợi hoặc có hại cho người dùng Lịch Nhà |
| E16 | OBS · P | [Apple HIG — Playing audio](https://developer.apple.com/design/human-interface-guidelines/playing-audio) và [Audio Session Guidelines](https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/AudioGuidelinesByAppType/AudioGuidelinesByAppType.html) yêu cầu hành vi hợp tác cho audio không thiết yếu | Tôn trọng Silent/audio khác; control phải rõ; audio do người dùng bấm phát có ranh giới khác autoplay | Bao nhiêu người sẽ tắt nền trong 10 giây |

## Persona tổng hợp và giới hạn phương pháp

| ID | Loại | Chứng cứ | Điều được phép suy ra | Điều không được suy ra |
|---|---|---|---|---|
| E17 | OBS · S | [Nielsen Norman Group — Synthetic Users](https://www.nngroup.com/articles/synthetic-users/) xem synthetic users phù hợp để tạo giả thuyết, không thay quyết định từ người thật | Dùng panel để tìm mâu thuẫn, câu hỏi và case biên | Dùng câu trả lời mô phỏng như usability finding |
| E18 | OBS · P | [Whose Personae?](https://ojs.aaai.org/index.php/AIES/article/download/36553/38691/40628) rà 63 nghiên cứu và chỉ ra thiếu minh bạch về population, representativeness và ecological validity | Mỗi persona phải nêu nguồn, phạm vi, giới hạn và khả năng tái tạo | Persona mang tuổi/vùng tự động đại diện nhóm đó |
| E19 | OBS · P | [De Paoli, User personas, ideation and LLMs](https://doi.org/10.1016/j.ijhcs.2025.103690) dùng dữ liệu từ 26 phỏng vấn thật và cảnh báo bias, stereotype, factual error | LLM có thể hỗ trợ ideation dưới giám sát; panel KVCalendar yếu hơn vì chưa có transcript thật | LLM tự tạo ra bằng chứng nghiên cứu người dùng |
| E20 | INF + DEC | Ba nhánh phản biện độc lập: thị trường, lịch/văn hóa và synthetic panel; agent chính đối chiếu lại nguồn và giữ gate thật mở | Giảm nguy cơ một persona áp đặt một câu trả lời duy nhất | Tính độc lập thống kê, representative sample hoặc consensus người dùng |

## Kết luận từ sổ chứng cứ

Ba quyết định có thể khóa mà không cần giả làm nghiên cứu hành vi:

1. bỏ mọi claim “đầu tiên/duy nhất”; định vị bằng chất lượng của nghi thức bloc, độ tin cậy và sự yên tĩnh;
2. giữ UTC+7 ở Calendar Core, nhưng tách khỏi ngày dân sự và notification của thiết bị;
3. nếu chưa có Gate 7A–7B với người thật, bản phát hành giữ **Yên** làm âm mặc định; Hiên sớm chỉ là opt-in. Prototype vẫn có thể thử phương án bật có điều kiện để đo phản ứng sau này.

Các câu về thói quen bóc, ngữ cảnh, ngày tốt/xấu, ngưỡng pastel/họa tiết, tập quán gia đình, tỷ lệ tắt âm và usability người lớn tuổi vẫn là `UNTESTED`.
