# Feature Specification: Lịch Nhà 1.0

**Feature Branch**: Không áp dụng; repository chưa dùng Git

**Created**: 2026-09-07

**Status**: Sẵn sàng cho kế hoạch, còn chặn triển khai bởi các cổng nghiên cứu

**Input**: Ứng dụng lịch bloc Việt Nam trên iPhone, miễn phí, không quảng cáo, không paywall,
không đăng nhập, hoạt động offline, có mỹ thuật Mộc Son Dịu, hiệu ứng theo mùa/ngày và âm nền
nhẹ. Rodin chỉ dùng ảnh tham chiếu với Image-to-3D.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Xem tờ lịch hôm nay (Priority: P1)

Một người trẻ mở ứng dụng và nhận ra ngay hình ảnh lịch bloc quen thuộc. Họ đọc được ngày dương,
ngày âm, thứ và sự kiện nổi bật mà không cần đăng nhập hoặc đi qua màn hình thiết lập.

**Why this priority**: Đây là lời hứa ngắn nhất của sản phẩm và là lát cắt MVP nhỏ nhất có giá
trị. Mọi chức năng khác phụ thuộc vào việc tờ hôm nay đọc nhanh, đúng và tạo cảm giác muốn quay lại.

**Independent Test**: Mở ứng dụng ở chế độ máy bay trên một ngày có dữ liệu chuẩn. Người thử đọc
đúng ngày dương, ngày âm và sự kiện trong năm giây, sau đó sang ngày kế và quay về hôm nay bằng
cả gesture lẫn action thay thế.

**Acceptance Scenarios**:

1. **Given** ứng dụng vừa cài và thiết bị không có mạng, **When** người dùng mở ứng dụng,
   **Then** tờ hôm nay xuất hiện trước cảnh nền và hiển thị đủ thứ, ngày dương, tháng/năm dương,
   ngày/tháng âm cùng dấu tháng nhuận khi có.
2. **Given** tờ hôm nay đang mở, **When** người dùng bóc hoặc vuốt tờ,
   **Then** ứng dụng sang đúng ngày kế và cho cảm giác tờ giấy có mặt trước, mặt sau và độ dày.
3. **Given** người dùng không thể hoặc không muốn kéo, **When** họ dùng nút hay accessibility
   action tương đương, **Then** kết quả đổi ngày giống gesture.
4. **Given** người dùng đang xem một ngày xa, **When** họ chọn Hôm nay,
   **Then** ứng dụng trở về ngày hiện tại trong một thao tác.

---

### User Story 2 - Tra ngày và kiểm tra nguồn (Priority: P2)

Người dùng mở tờ tháng, chọn một ngày dương hoặc âm, lật mặt sau để đọc chi tiết và kiểm tra nguồn
của thông tin truyền thống. Họ phân biệt được ngày nghỉ chính thức, ngày kỷ niệm và nội dung tham
khảo.

**Why this priority**: Lịch chỉ hữu ích lâu dài khi hỗ trợ lập kế hoạch và cho phép người dùng kiểm
tra vì sao một trường dữ liệu được hiển thị.

**Independent Test**: Từ tờ hôm nay, tìm ngày 15 của tháng kế, xác định ngày âm, mở chi tiết giờ
hoàng đạo và tìm nguồn trong tối đa hai thao tác.

**Acceptance Scenarios**:

1. **Given** người dùng mở tờ tháng, **When** họ chọn một ô ngày,
   **Then** ứng dụng mở đúng tờ ngày và giữ ngữ cảnh để quay lại tháng.
2. **Given** một ngày có tháng nhuận, ngày nghỉ hoặc tiết khí,
   **When** người dùng xem mặt trước và mặt sau,
   **Then** từng loại thông tin có nhãn đúng và không bị gộp thành một khái niệm “ngày lễ”.
3. **Given** một nhận định tốt/xấu, **When** người dùng mở nguồn,
   **Then** họ thấy nhãn tham khảo, tên phương pháp, phiên bản và nguồn áp dụng.
4. **Given** ngày nằm trong giai đoạn 1900–1975,
   **When** người dùng xem chi tiết,
   **Then** ứng dụng hiện phạm vi lịch thiên văn hồi chiếu và cảnh báo chênh lịch sử khi cần.

---

### User Story 3 - Tạo ngày gia đình và lời nhắc âm lịch (Priority: P3)

Người dùng tạo ngày giỗ, sinh nhật hoặc sự kiện gia đình theo lịch âm hay dương. Ứng dụng giải
thích tháng nhuận và tháng thiếu bằng câu đời thường, lưu sự kiện dù quyền thông báo bị từ chối và
không đọc lịch hệ thống.

**Why this priority**: Lời nhắc gia đình là lý do quay lại có giá trị hơn nội dung giải trí hoặc tử
vi, nhưng nó cần Calendar Core và chính sách thời gian ổn định trước.

**Independent Test**: Tạo ngày giỗ 12 tháng Tám âm, nhắc trước ba ngày lúc 8:00, chọn quy tắc
tháng nhuận, từ chối notification và xác nhận sự kiện vẫn tồn tại với trạng thái nhắc đúng.

**Acceptance Scenarios**:

1. **Given** người dùng nhập sự kiện âm lặp hằng năm,
   **When** tháng cùng số có cả tháng thường và tháng nhuận,
   **Then** ứng dụng yêu cầu hoặc đọc lại lựa chọn tháng thường, tháng nhuận hay cả hai.
2. **Given** sự kiện đặt ngày 30 âm và năm kế có tháng tương ứng chỉ 29 ngày,
   **When** occurrence được tính,
   **Then** ứng dụng áp dụng đúng lựa chọn ngày cuối tháng, bỏ qua hoặc mùng 1 tháng sau.
3. **Given** người dùng từ chối quyền thông báo,
   **When** họ lưu sự kiện,
   **Then** sự kiện vẫn được lưu và trạng thái phân biệt rõ “đã lưu” với “đã bật nhắc”.
4. **Given** múi giờ thiết bị thay đổi,
   **When** ứng dụng hoạt động lại,
   **Then** ngày âm vẫn theo lịch Việt UTC+7 còn giờ giao thông báo theo chính sách người dùng đã
   chọn.

---

### User Story 4 - Xem lịch nhanh từ widget (Priority: P4)

Người dùng xem ngày dương, ngày âm và sự kiện công khai từ widget mà không cần mở ứng dụng. Tên
sự kiện riêng tư không xuất hiện trên màn hình khóa theo mặc định.

**Why this priority**: Widget phục vụ tình huống xem nhanh buổi sáng và giúp ứng dụng hữu ích ngay
cả khi nghi thức bóc lịch không được dùng mỗi ngày.

**Independent Test**: Thêm widget, qua mốc đổi ngày, kiểm tra light/dark/tinted và mở đúng tờ ngày
từ deep link trong khi thiết bị không có mạng.

**Acceptance Scenarios**:

1. **Given** widget đã được thêm, **When** ngày đổi và hệ thống cấp lượt cập nhật,
   **Then** widget hiển thị ngày mới từ dữ liệu cục bộ.
2. **Given** màn hình khóa đang hiển thị widget,
   **When** hôm nay có sự kiện cá nhân,
   **Then** tên hoặc ghi chú riêng tư bị ẩn theo mặc định.
3. **Given** người dùng chạm widget,
   **When** ứng dụng mở,
   **Then** họ đến đúng tờ ngày được chọn.

---

### User Story 5 - Cảm nhận mùa và sự kiện trong ngày (Priority: P5)

Người dùng thấy một cảnh ngắn, tiết chế và đúng sắc thái theo ngày. Quốc khánh có cờ Việt Nam được
dựng đúng cùng pháo hoa xa; Lập Xuân có cành đào, mai hoặc bản trung tính. Ngày thường vẫn có hơi
thở nhẹ rồi dừng để người dùng đọc và làm việc.

**Why this priority**: Đây là điểm khác biệt cảm xúc của Lịch Nhà, nhưng chỉ được mở rộng sau khi
tờ lịch, dữ liệu và accessibility đã ổn định.

**Independent Test**: Dùng gói cảnh cục bộ cho Quốc khánh, Lập Xuân và một ngày thường; kiểm tra
mỗi cảnh ở Sống động, Êm, Tĩnh, Reduce Motion, Dim Flashing Lights và chế độ máy bay.

**Acceptance Scenarios**:

1. **Given** hôm nay có nhiều sự kiện, **When** cảnh được chọn,
   **Then** chỉ một hero effect chạy và resolver áp dụng đúng độ ưu tiên, sắc thái cùng cờ an toàn.
2. **Given** người dùng đã xem intro hôm nay,
   **When** họ mở lại ứng dụng,
   **Then** intro không tự lặp; họ có thể phát lại bằng một action chủ động.
3. **Given** Reduce Motion, Dim Flashing Lights, Low Power hoặc giới hạn nhiệt đang áp dụng,
   **When** cảnh xuất hiện,
   **Then** ứng dụng dùng bản fallback đã duyệt mà không làm mất tên hoặc ngày sự kiện.
4. **Given** cảnh dùng đạo cụ hoặc âm thanh tạo sinh,
   **When** pack được duyệt phát hành,
   **Then** mỗi asset có reference, quyền, lịch sử biên tập, poster và reviewer; không asset nào
   được tạo từ đầu vào chỉ có mô tả chữ.

---

### User Story 6 - Điều chỉnh trải nghiệm và dùng với accessibility (Priority: P6)

Người dùng chọn mức chuyển động, vùng cảm hứng, cỡ chữ, tương phản và ba lớp âm độc lập. Người
dùng VoiceOver hoặc chữ 200% hoàn thành mọi tác vụ cốt lõi mà không phải đổi sang một giao diện có
phong cách hoàn toàn khác.

**Why this priority**: Các lựa chọn này hoàn thiện sản phẩm và là điều kiện phát hành. Semantic và
fallback phải có từ lát cắt đầu, dù màn hình cài đặt đầy đủ được hoàn thiện sau.

**Independent Test**: Hoàn thành luồng xem ngày, đổi ngày, xem nguồn, tạo ngày giỗ và tắt âm bằng
VoiceOver, chữ 200%, Increase Contrast và Reduce Motion trên iPhone nhỏ nhất được hỗ trợ.

**Acceptance Scenarios**:

1. **Given** VoiceOver đang chạy, **When** người dùng mở tờ ngày,
   **Then** thông tin được đọc theo thứ tự ngày dương, ngày âm, sự kiện, nội dung phụ và action.
2. **Given** chữ ở mức 200%, **When** tờ ngày hiển thị,
   **Then** nội dung chính không bị cắt; nội dung phụ chuyển sang mặt sau trước khi số ngày bị thu nhỏ.
3. **Given** audio khác đang phát, thiết bị ở Silent hoặc VoiceOver đang đọc,
   **When** ứng dụng mở,
   **Then** Hiên sớm không tranh audio và không tự phát sai điều kiện.
4. **Given** người dùng tắt Hiên sớm, âm giấy hoặc cue sự kiện,
   **When** họ mở lại ứng dụng,
   **Then** từng lựa chọn được nhớ độc lập và không làm mất phản hồi hình ảnh bắt buộc.

### Edge Cases

- Ngày âm không tồn tại trong năm đích, gồm ngày 30 của tháng thiếu.
- Tháng cùng số xuất hiện hai lần vì tháng nhuận hoặc không có tháng nhuận ở năm sau.
- Sóc, tiết khí hoặc đổi ngày xảy ra gần nửa đêm UTC+7 trong khi thiết bị ở múi giờ khác.
- Ngày trước 1976 có khác biệt nguồn miền Bắc, miền Nam hoặc lịch hồi chiếu.
- Ngày nghỉ chính thức được công bố hoặc sửa sau khi bản ứng dụng đã phát hành.
- Hai sự kiện cùng ngày có sắc thái xung đột, ví dụ hân hoan và tưởng niệm.
- Widget bị hệ thống cập nhật trễ hoặc chưa từng nhận snapshot từ app.
- Quyền notification bị tắt ngoài Settings sau khi reminder đã được lập.
- Người dùng đổi ngày, giờ, múi giờ hoặc vùng cảm hứng khi app đang không hoạt động.
- Thiết bị bật đồng thời Reduce Motion, Increase Contrast, Reduce Transparency và chữ lớn.
- App bị gián đoạn bởi cuộc gọi, tháo tai nghe, audio ứng dụng khác hoặc khóa màn hình.
- Asset cảnh bị thiếu, hỏng checksum hoặc không phù hợp capability của thiết bị.
- Tên sự kiện và ghi chú rất dài, có dấu tiếng Việt hoặc ký tự ngoài bảng chữ cái Latin.
- Cờ Việt Nam bị mirror, crop, che ngôi sao hoặc đặt trong vùng particle.
- Lần mở đầu không có mạng và toàn bộ quyền tùy chọn đều bị từ chối.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Ứng dụng PHẢI mở thẳng vào tờ của ngày hiện tại mà không yêu cầu tài khoản,
  onboarding bắt buộc hoặc mạng.
- **FR-002**: Mặt trước PHẢI hiển thị thứ, ngày dương, tháng/năm dương, ngày/tháng âm, cờ tháng
  nhuận, Can Chi ngắn và sự kiện hay tiết khí nổi bật khi có.
- **FR-003**: Mặt sau PHẢI chứa chi tiết lịch, thông tin truyền thống, nguồn, phương pháp và phiên
  bản phù hợp với ngày đang xem.
- **FR-004**: Người dùng PHẢI đổi ngày bằng bóc/vuốt và bằng action một chạm tương đương.
- **FR-005**: Người dùng PHẢI về hôm nay từ mọi trạng thái xem ngày trong tối đa một thao tác.
- **FR-006**: Ứng dụng PHẢI có tờ tháng để chọn ngày và quay lại đúng ngữ cảnh trước đó.
- **FR-007**: Hệ lịch Việt PHẢI được tính với quy tắc UTC+7 và không dùng lịch Trung Quốc làm
  nguồn sự thật.
- **FR-008**: Phạm vi công bố PHẢI là 1900–2100; ngày 1900–1975 PHẢI có nhãn hồi chiếu và cảnh
  báo khi nguồn lịch sử có thể khác.
- **FR-009**: Dữ liệu ngày nghỉ, ngày kỷ niệm, lễ truyền thống, lễ hội địa phương và sự kiện cá
  nhân PHẢI có taxonomy riêng.
- **FR-010**: Mọi dữ liệu không do người dùng nhập và không suy ra trực tiếp từ ngày PHẢI có
  source ID, phiên bản, phạm vi áp dụng và trạng thái quyền phù hợp.
- **FR-011**: Ngày/giờ tốt xấu PHẢI được ghi là tham khảo, nêu ruleset và có thể tắt toàn bộ lớp
  lịch truyền thống.
- **FR-012**: Ứng dụng PHẢI cho phép tạo, sửa và xóa sự kiện âm hoặc dương được lưu trên máy.
- **FR-013**: Sự kiện âm lặp PHẢI lưu quy tắc tháng nhuận, tháng thiếu, múi giờ tính lịch và múi
  giờ giao thông báo.
- **FR-014**: Trước khi lưu sự kiện có quy tắc âm lịch, ứng dụng PHẢI đọc lại lựa chọn bằng câu
  tiếng Việt tự nhiên.
- **FR-015**: Việc từ chối notification KHÔNG ĐƯỢC làm mất sự kiện; trạng thái lưu và trạng thái
  nhắc PHẢI tách biệt.
- **FR-016**: Reminder PHẢI được tính thành các occurrence cụ thể trong một cửa sổ tương lai và
  làm mới khi ngày, múi giờ, quyền, cài đặt hoặc phiên bản app thay đổi.
- **FR-017**: Widget PHẢI dùng dữ liệu cục bộ, có deep link ổn định và ẩn nội dung sự kiện cá
  nhân trên màn hình khóa theo mặc định.
- **FR-018**: Mọi chức năng cốt lõi, dữ liệu lịch và cảnh phát hành PHẢI hoạt động ở chế độ máy bay.
- **FR-019**: Effect Director PHẢI chọn tối đa một hero effect theo event ID, loại lịch, múi giờ,
  vùng cảm hứng, độ ưu tiên và trạng thái accessibility/power.
- **FR-020**: Hero intro chỉ ĐƯỢC tự chạy một lần cho mỗi ngày hiện tại; trạng thái nghỉ và action
  phát lại PHẢI tồn tại.
- **FR-021**: Quốc khánh và Lập Xuân PHẢI có scene flagship, poster tĩnh và bản giảm hiệu ứng đã
  duyệt. Bản 1.0 PHẢI có thêm bốn cảnh lễ lớn và sáu họ chuyển động cho 24 tiết khí.
- **FR-022**: Mỗi cảnh PHẢI giữ vùng an toàn cho nội dung và không làm đổi độ sáng, rung hoặc
  scale số ngày.
- **FR-023**: Cờ Việt Nam và ngôi sao PHẢI được dựng, đo và duyệt thủ công; không được dùng làm
  particle, crop, mirror, xé hoặc che.
- **FR-024**: Mọi đạo cụ 3D tạo sinh chỉ ĐƯỢC bắt đầu từ ảnh tham chiếu đã duyệt. Đầu vào chỉ có
  mô tả chữ bị cấm.
- **FR-025**: Mọi model, ảnh, texture và âm thanh PHẢI có manifest nguồn, quyền, công cụ, phiên
  bản, bước biên tập, reviewer, checksum và phạm vi dùng trước khi vào release pack.
- **FR-026**: Ứng dụng KHÔNG ĐƯỢC gọi dịch vụ tạo sinh lúc chạy và không được chứa khóa truy cập
  của các dịch vụ sản xuất asset.
- **FR-027**: Ba lớp âm nền, âm giấy và cue sự kiện PHẢI có công tắc cùng trạng thái riêng; âm
  giấy và cue sự kiện mặc định tắt.
- **FR-028**: Hiên sớm chỉ ĐƯỢC fade in sau khi nội dung hiện và khi Silent, VoiceOver cùng audio
  khác cho phép; người dùng PHẢI tắt được trong một thao tác.
- **FR-029**: Ứng dụng KHÔNG ĐƯỢC tuyên bố âm nền giúp điều trị hoặc tăng tập trung.
- **FR-030**: Mọi điều khiển PHẢI có nhãn, trạng thái, focus, vùng chạm tối thiểu 44 pt và thứ tự
  VoiceOver hợp lý.
- **FR-031**: Mọi tác vụ cốt lõi PHẢI dùng được với chữ 200%, Reduce Motion, Increase Contrast,
  Reduce Transparency và Dim Flashing Lights.
- **FR-032**: Ứng dụng PHẢI dừng hoặc giảm cảnh theo Low Power và thermal state mà không giảm độ
  đọc của tờ lịch.
- **FR-033**: Dữ liệu cá nhân PHẢI chỉ lưu trên máy hoặc vùng chia sẻ app/widget, không được đưa
  vào log, analytics hoặc crash attachment.
- **FR-034**: Ứng dụng KHÔNG ĐƯỢC chứa SDK quảng cáo, analytics nhận dạng người dùng, paywall
  hoặc luồng đăng nhập.
- **FR-035**: Người dùng PHẢI xem được phiên bản engine, data pack, culture pack và effect pack,
  cùng hướng dẫn báo sai mà không tự gửi dữ liệu cá nhân.
- **FR-036**: Mọi lỗi lịch hay nội dung đã sửa PHẢI được thêm vào regression corpus trước bản phát
  hành kế tiếp.

### Key Entities *(include if feature involves data)*

- **Calendar Day**: Một ngày dương cùng ngày âm, cờ nhuận, Can Chi, tiết khí, phạm vi lịch sử và
  các occurrence áp dụng.
- **Calendar Occurrence**: Ngày nghỉ, ngày kỷ niệm, lễ truyền thống, lễ hội địa phương hoặc sự kiện
  cá nhân; có hệ lịch, thời gian, địa bàn, nhóm áp dụng, nguồn và sắc thái.
- **Almanac Entry**: Nội dung tốt/xấu theo một ruleset có nguồn, phiên bản và nhãn tham khảo.
- **Personal Event**: Sự kiện do người dùng nhập, gồm lịch âm/dương, quy tắc lặp, tháng nhuận,
  tháng thiếu, quyền riêng tư và lời nhắc.
- **Reminder Occurrence**: Một lần nhắc dương lịch cụ thể được sinh từ Personal Event trong cửa sổ
  lập lịch.
- **Effect Cue**: Chỉ dẫn cảnh theo event ID, tone, priority, cờ an toàn, hero, ambient, accent và
  fallback.
- **Asset Record**: Model, ảnh, texture, poster hoặc audio cùng provenance, quyền, phiên bản,
  checksum, LOD và trạng thái duyệt.
- **User Preferences**: Mức cảnh, vùng cảm hứng, ba lớp âm, cỡ chữ, riêng tư widget và chính sách
  thời gian.
- **Source Record**: Nguồn, loại bằng chứng, ngày truy cập, phạm vi, phiên bản và license.
- **Widget Snapshot**: Dữ liệu ngày tối thiểu đã lọc riêng tư để widget hiển thị offline.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Ít nhất 16/20 người trong vòng khám phá nhận ra đây là lịch bloc hoặc lịch xé mà
  không được nói trước; ít nhất 14/20 liên hệ tích cực với nhà, gia đình hoặc truyền thống.
- **SC-002**: Ít nhất 90% người thử đọc đúng ngày dương và ngày âm trong năm giây, cả khi cảnh
  đang chạy.
- **SC-003**: Ít nhất 80% đổi sang ngày kế không cần hướng dẫn, ít nhất 90% dùng được action thay
  thế; thời gian trung vị dưới ba giây và không quá 10% báo khó chịu vì chuyển động.
- **SC-004**: Không quá 20% người thử cùng yêu cầu một trường bị thiếu ở mặt trước; ít nhất 70%
  hiểu nhãn “tham khảo theo lịch truyền thống”; nguồn được tìm trong tối đa hai thao tác.
- **SC-005**: Ít nhất 80% hoàn thành luồng ngày giỗ không trợ giúp và giải thích đúng quy tắc tháng
  nhuận; 100% hiểu sự kiện vẫn được lưu khi notification bị từ chối.
- **SC-006**: Toàn bộ golden dates, properties và regression corpus trong phạm vi công bố đạt kết
  quả; mọi khác biệt nguồn được giải thích và phê duyệt thay vì chọn tự động theo đa số.
- **SC-007**: Không tác vụ cốt lõi nào thất bại với VoiceOver, chữ 200%, Reduce Motion hoặc
  Increase Contrast trên thiết bị mục tiêu.
- **SC-008**: Ít nhất 80% nhận đúng sắc thái của Quốc khánh và Lập Xuân; không reviewer nào phát
  hiện lỗi Quốc kỳ hoặc biểu tượng nhạy cảm.
- **SC-009**: Cảnh giữ tốc độ mục tiêu trên thiết bị thấp nhất, có fallback đẹp và không làm thời
  gian tới nội dung ngày tăng lên.
- **SC-010**: Hiên sớm chỉ còn mặc định có điều kiện nếu không quá 25% nhóm chính tắt trong 10
  giây đầu, đa số không báo mệt hay mất tập trung sau 10–15 phút và kết quả tác vụ không giảm có hệ
  thống so với im lặng.
- **SC-011**: Mọi chức năng cốt lõi, widget snapshot và scene đã phát hành hoàn thành bài kiểm tra
  chế độ máy bay mà không mất dữ liệu hoặc hiển thị ngày sai.
- **SC-012**: Bản TestFlight cuối không còn lỗi P0/P1, không còn lỗi golden data và toàn bộ câu trả
  lời App Store Privacy khớp với binary cùng dependency đã phát hành.

## Assumptions

- Tên “Lịch Nhà” là tên làm việc; đổi tên không làm thay đổi phạm vi chức năng.
- Bản 1.0 ưu tiên iPhone dọc và dự kiến hỗ trợ iOS 17 trở lên. iPad được đánh giá sau khi lõi
  iPhone đạt cổng chất lượng.
- Phạm vi lịch công bố là 1900–2100 với chính sách lịch sử đã nêu; không dùng từ “vạn niên” để
  ngụ ý vô hạn.
- Người dùng sống ngoài Việt Nam mặc định xem “hôm nay” theo ngày địa phương, tính ngày âm bằng
  lịch Việt UTC+7 và nhận thông báo theo giờ địa phương; họ có thể chọn nhịp đổi ngày theo Việt Nam.
- App không có backend, tài khoản hoặc sync cloud trong 1.0. Export/import chủ động chỉ vào 1.0
  nếu cổng phạm vi và riêng tư được duyệt trước implementation.
- EventKit chỉ dùng cho hành động chủ động thêm một sự kiện qua giao diện hệ thống; ứng dụng không
  đọc toàn bộ lịch iPhone.
- Hiên sớm là mặc định có điều kiện của prototype, chưa phải mặc định phát hành. Gate âm thanh
  quyết định giữ mặc định hay chuyển sang opt-in.
- Bốn cảnh lễ ngoài Quốc khánh và sáu họ tiết khí chỉ được sản xuất sau khi hai flagship cùng cảnh
  ngày thường vượt qua gate storyboard và usability.
- Chi phí Apple Developer và duy trì phát hành do chủ dự án hoặc nguồn tài trợ công khai chi trả;
  chi phí này không chuyển thành quảng cáo hay paywall.
