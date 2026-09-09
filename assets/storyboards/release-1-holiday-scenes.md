# Storyboard bốn cảnh lễ 1.0

**Trạng thái:** `DRAFT · HOLD`
**Ngày soạn:** 07/09/2026
**Phạm vi:** bốn cảnh ngoài Quốc khánh và Lập Xuân; chưa có asset production.

Tài liệu chọn bốn ứng viên đã có trong `docs/08-he-dao-dien-theo-ngay.md`: Tết Nguyên đán, Giỗ Tổ Hùng Vương, ngày 30/4 và Trung Thu. Tết Ông Công Ông Táo chưa vào nhóm này vì cần một vòng nguồn và cultural review riêng cho nội dung tín ngưỡng.

## Luật chung

- Scene chỉ bắt đầu sau khi nội dung ngày đã hiện; tối đa một hero intro 2–4 giây rồi về trạng thái nghỉ.
- **Content-safe zone** là hợp của vùng số ngày dương, thứ/tháng/năm, ngày âm, dòng sự kiện và semantic controls. Mask này bám layout thật, mở rộng theo Dynamic Type; nếu không còn khoảng trống, bỏ lớp trang trí thay vì thu chữ.
- Không particle, bóng động hoặc thay đổi độ sáng đi qua content-safe zone. Tờ lịch không rung, scale hoặc đổi độ tương phản theo scene.
- Reduce Motion dùng poster đã duyệt và dissolve ngắn; không parallax, xoay, nở hình hoặc page curl do scene.
- Dim Flashing Lights bỏ flash, flicker, đổi sáng tối nhanh và peak trắng. Đây là bản dựng riêng, không chỉ giảm opacity của animation gốc.
- Cue sự kiện là một bus riêng, **tắt mặc định và chỉ phát khi người dùng bật**. Cue không mang thông tin duy nhất, dừng khi app ra nền và nhường audio ưu tiên khác.
- Visual, âm và model đều đóng gói offline. Mỗi asset cần owner, nguồn đầu vào, quyền, công cụ/version, bước biên tập, checksum và reviewer.
- Rodin là tùy chọn sản xuất trước release. Nếu dùng, đầu vào bắt buộc là ảnh/concept dự án sở hữu hoặc được cấp phép qua **Image-to-3D**; text-to-3D bị cấm. Output phải cleanup, LOD/bake, làm poster và profile trên máy thật.

## Scene 1 — Tết Nguyên đán: “Nếp nhà đầu năm”

**Tone:** ấm, sum họp, tươi nhưng không ồn. Giấy kem, hồng đào hoặc vàng mai ít bão hòa; son chỉ làm nhịp nhỏ.

**Nguồn và trigger**

- `effectId`: `holiday.tet-nguyen-dan.day-01`.
- Trigger ứng viên: ngày `01/01` âm lịch do Calendar Core UTC+7 trả về; occurrence phải mang engine version và provenance từ golden corpus.
- Scene chỉ chạy ngày mùng Một, không kéo dài theo toàn bộ lịch nghỉ từng năm. [Bộ luật Lao động 45/2019/QH14](https://datafiles.chinhphu.vn/cpp/files/vbpq/2019/12/45.signed.pdf) xác nhận Tết Âm lịch là ngày nghỉ nhưng không thay Calendar Oracle. [Bảo tàng Lịch sử Quốc gia](https://baotanglichsu.vn/VI/Articles/3096/6039/lich-su-va-mot-so-phong-tuc-ngay-tet-nguyen-djan.html) được dùng làm bối cảnh văn hóa, không làm nguồn asset.

**Khung hình và vùng an toàn**

- Một nhành nhỏ neo ngoài góc trên của tờ; dải giấy hồng điều nằm sau khánh, không rủ xuống vùng chữ.
- Vùng giữa tờ và toàn bộ dòng ngày âm được giữ trống. Ở Large Text, nhành chuyển hẳn ra tường hoặc biến mất.

**Motion**

1. Nội dung ngày đứng yên trước.
2. Một nụ mở có kiểm soát và dải giấy nhận đúng một nhịp gió.
3. Sau intro, cành và dải giấy đứng yên; không mưa hoa, lì xì bay hoặc confetti.

**Fallback an toàn**

- Reduce Motion: poster với nụ đã nở; chỉ dissolve từ màu ngày thường sang sắc đầu năm.
- Dim Flashing Lights: ánh hiên ổn định, không nháy đèn hoặc quét highlight trên tờ.
- Audio cue opt-in: một tiếng giấy/lá rất nhẹ, một lần; không pháo, nhạc, lời chúc hay tiếng người.

**Vùng và giới hạn văn hóa**

- Dùng lựa chọn vùng do người dùng đặt: đào cho Bắc, mai cho Nam, nhành chồi trung tính; phương án miền Trung phải được reviewer địa phương duyệt. Không suy vùng từ GPS.
- Không trình bày một loài hoa, mâm cúng, trang phục hoặc phong tục gia đình như chuẩn chung cả nước. Tránh chữ Hán trang trí, rồng/chibi và motif vay mượn không có nguồn.

**Rodin:** nhành hoặc đạo cụ gỗ có thể dùng Image-to-3D từ concept sheet nguyên bản đã duyệt. Cánh hoa, chữ và dải giấy là đồ họa kiểm soát bởi họa sĩ; không dùng Rodin.

## Scene 2 — Giỗ Tổ Hùng Vương: “Dấu đồng nguồn cội”

**Tone:** trang trọng, lắng, hướng về cội nguồn. Đồng mờ và nâu gỗ; không vàng bóng hoặc không khí lễ hội kiểu phần thưởng.

**Nguồn và trigger**

- `effectId`: `holiday.hung-kings-commemoration`.
- Trigger ứng viên: ngày `10/03` âm lịch do Calendar Core UTC+7 trả về. Điều 112 [Bộ luật Lao động 45/2019/QH14](https://datafiles.chinhphu.vn/cpp/files/vbpq/2019/12/45.signed.pdf) là nguồn ngày nghỉ và tên sự kiện; việc đổi âm–dương vẫn phụ thuộc oracle đã duyệt.
- Không kích hoạt theo ngày nghỉ bù hoặc chuỗi nghỉ liền kề.

**Khung hình và vùng an toàn**

- Một relief vòng đồng nguyên bản nằm trên khánh hoặc phần tường phía sau; không in hoa văn dưới chữ.
- Mép relief dừng trước biên tờ. Không có tượng, chân dung hoặc nhân vật hư cấu cạnh ngày.

**Motion**

1. Ánh sáng xiên rất nhẹ làm relief hiện dần như dập nổi.
2. Ánh sáng dừng ở khánh; relief không xoay và không phát hạt.
3. Trạng thái nghỉ là một dấu đồng mờ, không hoạt cảnh lặp.

**Fallback an toàn**

- Reduce Motion: poster relief tĩnh; không quét sáng.
- Dim Flashing Lights: một mức sáng cố định, không lóe kim loại hoặc đổi tương phản nền.
- Audio cue opt-in: một âm chạm gỗ/đồng khô, nhỏ, một lần; không mô phỏng trống nghi lễ, cồng chiêng, nhạc lễ hoặc lời khấn.

**Vùng và giới hạn văn hóa**

- Không tạo tượng Vua Hùng, cảnh tế lễ hoặc huyền sử như tái hiện lịch sử. Không dùng scene để giải thích nguồn gốc dân tộc bằng một dị bản duy nhất.
- Motif phải do dự án thiết kế và được chuyên gia/reviewer văn hóa đối chiếu; không sao chép hoa văn hiện vật, ảnh bảo tàng hoặc vector thương mại chưa có quyền. Trước review, chỉ gọi là “relief vòng đồng”, không gán niên đại hay hiện vật cụ thể.

**Rodin:** relief/đạo cụ đồng chỉ được thử bằng Image-to-3D từ artwork nguyên bản có hồ sơ quyền. Ưu tiên bake normal/texture lên mesh thấp; output Rodin không được xem là bản sao khảo cổ chính xác.

## Scene 3 — Ngày 30/4: “Nắng sớm bình yên”

**Tone:** trang trọng, sáng và bình tĩnh. Trọng tâm là ngày dân sự và không khí yên; không mô phỏng chiến trận hay ăn mừng phô trương.

**Nguồn và trigger**

- `effectId`: `holiday.victory-day.april-30`.
- Trigger: ngày dương lịch `30/04` trong display timezone đã cấu hình, từ occurrence có version của Content Catalog. Điều 112 [Bộ luật Lao động 45/2019/QH14](https://datafiles.chinhphu.vn/cpp/files/vbpq/2019/12/45.signed.pdf) là nguồn tên “Ngày Chiến thắng” và ngày nghỉ.
- Không kích hoạt theo ngày nghỉ bù, ngày liền kề hoặc chỉ vì tên sự kiện giống nhau.

**Khung hình và vùng an toàn**

- Một dải nắng sớm nằm trên tường sau khánh. Cờ nhỏ neo cạnh khánh, không chạm tờ và không đè semantic controls.
- Cờ luôn hiện trọn hình, không crop, mirror, che sao, xé hoặc dùng làm texture/particle.

**Motion**

1. Nắng lên rất nhẹ phía sau khánh, không đổi độ sáng tờ lịch.
2. Cờ nhận một nhịp gió đã keyframe và dừng.
3. Không pháo hoa, confetti, máy bay, vũ khí, đội hình hoặc silhouette chiến đấu.

**Fallback an toàn**

- Reduce Motion: cờ và dải nắng là poster tĩnh; không vertex deformation.
- Dim Flashing Lights: không quét nắng, bloom hoặc chớp; nền giữ một màu sáng ổn định.
- Audio cue opt-in: một nhịp gió hiên ngắn; không quốc ca, tiếng đám đông, tiếng nổ hoặc âm thanh quân sự.

**Vùng và giới hạn văn hóa**

- Dùng đúng tên sự kiện từ Content Catalog, không thêm khẩu hiệu hoặc diễn giải chính trị không có nguồn/reviewer.
- Quốc kỳ phải dựng, đo và duyệt thủ công theo [Hiến pháp 2013, Điều 13](https://vanban.chinhphu.vn/hien-phap-nam-2013/chuong-i-che-do-chinh-tri-10052990) và [Sắc lệnh số 5](https://vbpl.vn/TW/Pages/vbpq-print.aspx?ItemID=819). Mã màu là master asset nội bộ đã duyệt, không tự gọi là mã pháp định.

**Rodin:** cấm dùng Rodin cho cờ, ngôi sao, chữ hoặc hình học biểu tượng. Rodin chỉ có thể hỗ trợ cột/khánh từ ảnh tham chiếu đã duyệt; chuyển động cờ dùng mesh dựng tay và keyframe được kiểm từng khung.

## Scene 4 — Trung Thu: “Trăng qua hiên giấy”

**Tone:** êm, gần gũi gia đình, có chút ký ức tuổi thơ nhưng vẫn thuộc cùng ngôn ngữ Mộc Son Dịu.

**Nguồn và trigger**

- `effectId`: `holiday.mid-autumn`.
- Trigger ứng viên: ngày `15/08` âm lịch do Calendar Core UTC+7 trả về; occurrence mang engine version. [Viện Từ điển học và Bách khoa thư Việt Nam](https://bachkhoatoanthu.vass.gov.vn/noidung/tudien/Lists/GiaiNghia/View_Detail.aspx?ItemID=5643) là nguồn bối cảnh rằng Trung Thu diễn ra vào rằm tháng Tám và có tục rước đèn; không phải nguồn ảnh.
- Đây là lễ truyền thống, không gắn nhãn “ngày nghỉ theo luật”.

**Khung hình và vùng an toàn**

- Một đèn ông sao nhỏ treo ngoài mép khánh; bóng trăng chỉ nằm trên tường, không phủ tờ giấy.
- Không đặt mặt trăng, ánh đèn hoặc đồ chơi vào vùng số ngày. Large Text dùng poster chỉ còn silhouette đèn ở ngoài tờ.

**Motion**

1. Đèn ấm lên từ từ, không bật sáng đột ngột.
2. Bóng đèn dịch một cung ngắn rồi dừng; không lắc vô hạn.
3. Không rải sao, bánh, mặt nạ hoặc nhân vật chibi quanh màn hình.

**Fallback an toàn**

- Reduce Motion: poster đèn đã sáng và bóng tĩnh.
- Dim Flashing Lights: bỏ pha tăng sáng; dùng màu đèn ổn định, không flicker hoặc tương phản trăng–tối nhanh.
- Audio cue opt-in: một tiếng giấy tre nhẹ, một lần; không tiếng trẻ em, trống lân, nhạc hoặc tiếng phố lặp.

**Vùng và giới hạn văn hóa**

- Scene không khẳng định trăng thật đang tròn, trời quang hoặc mọi nơi tổ chức cùng một nghi thức. Hình trăng chỉ là diễn giải mỹ thuật của rằm tháng Tám.
- Không biến toàn giao diện thành đồ chơi trẻ em. Hình dáng đèn, vật liệu và cách gọi cần reviewer văn hóa; không sao chép mẫu đèn thương mại hoặc ảnh di sản chưa có quyền.

**Rodin:** đèn có thể là low-poly hoặc sprite bake từ phôi Image-to-3D dùng concept sheet nguyên bản nhiều góc. Không dùng text-to-3D; ánh sáng, bóng và hạt nếu có được dựng có kiểm soát ngoài Rodin.

## Cổng bỏ `HOLD`

Mỗi scene phải có đủ các mục sau trước khi được gọi là “chốt”:

1. source occurrence và event ID đã có version; trigger âm lịch đối chiếu golden corpus;
2. concept sheet/reference do dự án sở hữu hoặc có giấy phép;
3. asset/audio manifest có checksum, Terms snapshot và phạm vi sử dụng;
4. cultural reviewer phù hợp ký duyệt; cờ 30/4 có review biểu tượng riêng;
5. storyboard thường, Reduce Motion, Dim Flashing Lights, Large Text và poster được duyệt bằng mắt;
6. prototype chứng minh nội dung ngày vẫn đọc được, không gây khó chịu và không vượt ngân sách máy thấp nhất.

Hiện chưa có concept sheet, asset, audio, license manifest, reviewer hoặc kết quả test máy/người thật cho bốn scene. Tài liệu này **không hoàn tất T122** và không mở T123.

Ngày truy cập các nguồn ngoài dự án: 07/09/2026. URL nguồn chỉ hỗ trợ dữ kiện nêu cạnh chúng; không cấp quyền sử dụng hình ảnh, âm thanh hoặc hoa văn trên các trang đó.

## Quyết định T122 (09/09/2026)

Gate 6A vẫn `UNTESTED` (chưa có buổi người, chưa có máy trong inventory T019). T122 chọn **defer**: bốn cảnh lễ giữ storyboard `DRAFT · HOLD`, không sản xuất motion 1.0.

T123 ghi poster fallback trong `LichNha/Resources/EffectPacks/holiday-scenes.json`. Cue `posterOnly`, không intro sống. Không đánh dấu Gate 6A PASS.

