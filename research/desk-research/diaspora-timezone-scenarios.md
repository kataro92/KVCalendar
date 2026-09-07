# Desk scenarios: người Việt ở nước ngoài và múi giờ

**Ngày**: 2026-09-07
**Loại tài liệu**: desk scenario và test-oracle draft
**Trạng thái**: `T014 NOT RUN` — mọi Gate 1–7 `UNTESTED`

## 1. Tài liệu này dùng để làm gì

Các scenario dưới đây thử độ nhất quán của mô hình thời gian trước khi phỏng vấn người Việt ở nước
ngoài. Chúng giúp moderator có tình huống cụ thể để hỏi và giúp kỹ thuật chuẩn bị fixture. Chúng
không cho biết người dùng muốn policy nào, không phải session research và không thay T014.

Không có quote, tỷ lệ, preference hay usability result trong tài liệu này. Khi một hành vi chưa có
quyết định, cột expected ghi `OPEN` thay vì tự điền một mặc định có vẻ hợp lý.

## 2. Ba chiếc đồng hồ không được trộn

| Khái niệm | Vai trò | Policy hiện hành | Mức chắc chắn |
|---|---|---|---|
| `calendarRuleZone` | Tính lịch âm Việt Nam, Sóc, tiết khí và round-trip | UTC+7; dùng identifier ổn định như `Asia/Ho_Chi_Minh` cho ruleset hiện đại | `DEC` — contract kỹ thuật |
| `displayZone` | Quyết định ngày nào được gọi là “hôm nay” | Múi giờ nơi người dùng đang sống; có lựa chọn Nhịp Việt Nam | `HYP/PROVISIONAL` — T014 chưa kiểm chứng |
| `deliveryZone` | Quyết định giờ local để giao reminder | Múi giờ thiết bị hoặc IANA zone do người dùng chọn | `HYP/PROVISIONAL` — cần hỏi và test DST |

`civilDate` và `selectedDate` nên là ngày không kèm giờ. Instant hiện tại chỉ được dùng để suy ra
“hôm nay” theo `displayZone`; nó không được lén đổi ngày người dùng đã chọn. Với một civil date đã
chọn, Calendar Core áp dụng ruleset UTC+7 để trả dữ liệu lịch Việt cho chính ngày đó.

Đối với event âm, thứ tự là:

1. áp dụng policy tháng nhuận/tháng thiếu;
2. đổi ngày âm mục tiêu sang `targetCivilDate` bằng ruleset UTC+7;
3. ghép giờ local với `deliveryZone`;
4. xử lý DST, quyền thông báo và thay đổi zone;
5. không sửa event gốc nếu occurrence phải lập lại.

## 3. Scenario matrix

Các mốc dưới đây chỉ dùng để kiểm ranh giới ngày/múi giờ. Tài liệu không tự khẳng định ngày âm cụ
thể; giá trị lịch âm phải đến từ corpus/engine đã được duyệt.

| ID | Tình huống | Dữ liệu đầu vào | Expected có thể kiểm trên giấy | Điều còn `OPEN` |
|---|---|---|---|---|
| TZ-01 | Ở Hà Nội, hai nhịp trùng nhau | 00:30 ngày 07-09-2026 tại `Asia/Ho_Chi_Minh` | Local Today và Nhịp Việt Nam cùng là civil date 07-09-2026; calendar rule vẫn UTC+7 | Không có preference result |
| TZ-02 | California còn ở ngày hôm trước | Cùng instant với TZ-01, tương ứng 10:30 ngày 06-09-2026 ở `America/Los_Angeles` | Local Today là 06-09; Nhịp Việt Nam là 07-09. Đổi nhịp chỉ đổi current display date, không mutate event | Người dùng muốn nhịp nào làm mặc định; cách báo hai ngày để không rối |
| TZ-03 | Berlin còn ở ngày hôm trước | Cùng instant với TZ-01, tương ứng 19:30 ngày 06-09-2026 ở `Europe/Berlin` | Kết quả ngày giống nguyên tắc TZ-02; không hard-code offset vì Berlin có DST | Nhãn timezone cần hiện ở đâu |
| TZ-04 | Giờ nhắc rơi vào DST gap | Reminder đặt 02:30 ngày 14-03-2027 ở `America/New_York` | Planner phải nhận ra 02:30 local không tồn tại; không được âm thầm tạo timestamp bằng offset cố định | Dời tới instant hợp lệ kế tiếp, hỏi lại, hay báo lỗi có thể sửa |
| TZ-05 | Giờ nhắc bị lặp trong DST overlap | Reminder đặt 01:30 ngày 01-11-2026 ở `America/New_York` | Planner phải chọn occurrence sớm hoặc muộn một cách deterministic, lưu được policy và không schedule hai lần | Chọn lần thứ nhất hay thứ hai; UI có cần giải thích không |
| TZ-06 | Đi du lịch sau khi đã lập nhắc | Event được tạo ở `America/Los_Angeles`, thiết bị chuyển sang `Asia/Tokyo` | Occurrence cũ thành `stale`; system identifier cũ bị hủy trước khi lập occurrence mới; lunar anchor không đổi | Reminder “đi theo người” hay giữ zone đã chọn phải do preference quyết định |
| TZ-07 | Bật/tắt Nhịp Việt Nam | Đang xem hôm nay ở California trong khoảng hai ngày lệch nhau | Action đổi nhịp cập nhật “hôm nay”; event, origin date và occurrence đã lưu không tự đổi | Có cần confirmation khi màn hình nhảy sang ngày khác |
| TZ-08 | Đang xem một ngày lịch sử | `selectedDate` là 30-04-1975; người dùng đổi display zone | Ngày đã chọn vẫn là 30-04-1975. Chỉ action Hôm nay mới tính lại từ instant hiện tại; nhãn hồi chiếu vẫn áp dụng | Cách giải thích lịch sử không thuộc T014 |
| TZ-09 | Qua nửa đêm khi app/widget chưa refresh | Widget snapshot được tạo trước 00:00 local và mở sau 00:00 | Snapshot có `generatedAt`/expiry, không gọi ngày tương lai hoặc quá khứ là “hôm nay”; deep link truyền civil date rõ ràng | Refresh budget thực tế chỉ kiểm được bằng WidgetKit/build |
| TZ-10 | Người dùng đổi giờ hệ thống thủ công | System date/time thay đổi khi app ở background | Khi active lại, occurrence bị đánh dấu cần làm mới; engine version và event gốc không đổi | Ngưỡng chống schedule lặp cần test implementation |
| TZ-11 | Quyền notification bị từ chối | Event đã lưu, delivery zone hợp lệ, permission `Denied` | PersonalEvent còn nguyên; UI phân biệt “đã lưu” với “chưa thể nhắc”; không xin quyền lặp vô hạn | Cách diễn đạt phải test comprehension ở Gate 4 |
| TZ-12 | Ngày 30 âm gặp tháng thiếu ở zone có DST | Event âm ngày 30, target year có tháng 29 ngày | Áp dụng `shortMonthPolicy` trước khi ghép delivery time; timezone không được tự chọn thay policy gia đình | Default policy không được suy từ persona; T012/T014 cần hỏi |
| TZ-13 | Event tháng nhuận và gia đình ở hai nước | Event có `isLeapMonth`/`leapMonthPolicy`; người tạo và người được nhắc ở hai zone | Engine phân biệt tháng thường/nhuận; mỗi delivery occurrence dùng đúng zone đã chọn; không biến tập quán thành quy tắc quốc gia | 1.0 không có sync, nên chưa có shared-family semantics |
| TZ-14 | Zone đổi tên hoặc database cập nhật | Store giữ IANA identifier thay vì offset | Lập lại occurrence từ identifier và rule version; không lưu UTC offset cố định làm nguồn sự thật | Migration policy cần fixture khi implementation bắt đầu |

## 4. Invariant cho test về sau

- Cùng một `civilDate` và `calendarRuleZone` phải cho cùng CalendarDay dù thiết bị đang ở đâu.
- Đổi `displayZone` không được sửa PersonalEvent, origin date hoặc calendar rule version.
- Đổi `deliveryZone` chỉ làm occurrence cũ stale và sinh lịch giao mới; không convert lại ý nghĩa
  ngày âm bằng zone giao.
- Giờ địa phương không tồn tại hoặc xuất hiện hai lần phải đi qua policy công khai, không dựa vào
  hành vi mặc định ngầm của thư viện ngày giờ.
- Mọi lịch giao dùng IANA zone và instant tuyệt đối sau khi resolve; không lưu một offset cố định
  cho recurrence dài hạn.
- Permission denial, lỗi schedule hoặc thiếu refresh không được xóa event.
- Widget, app và reminder phải dùng cùng civil-date identity; chuỗi hiển thị không được dùng làm
  khóa dữ liệu.
- Nhịp Việt Nam là lựa chọn hiển thị. Nó không phải lý do để đổi `calendarRuleZone`, vì ruleset
  vốn đã là UTC+7.

Các invariant này là contract candidate. Trạng thái runtime của chúng là `NOT RUN` cho tới khi có
test ở T081, T091, T095 và T151.

## 5. Câu hỏi cho T014

Không hỏi “UTC+7 hay local tốt hơn?”. Đưa tình huống cụ thể và hỏi cách họ dự đoán sản phẩm hoạt
động:

1. Khi California là tối 6/9 nhưng Việt Nam đã là 7/9, “Hôm nay” trên tờ nên là ngày nào? Vì sao?
2. Nếu app có Nhịp Việt Nam, họ có hiểu đây là đổi tờ đang thấy chứ không đổi cách tính lịch âm
   không?
3. Nhắc ngày giỗ lúc 08:00 nên theo nơi họ đang ở, nơi event được tạo, hay giờ Việt Nam?
4. Khi đi du lịch một tuần, họ muốn reminder đi theo máy hay giữ zone ban đầu?
5. Nếu một giờ nhắc không tồn tại do DST, họ muốn app dời giờ, hỏi lại hay báo không lập được?
6. Gia đình ở Việt Nam và người ở nước ngoài có cần thấy cùng một civil date cùng lúc, hay cần cùng
   một ngày địa phương?
7. Họ có cần thấy nhãn `Giờ địa phương`/`Nhịp Việt Nam` thường trực, hay chỉ khi hai ngày lệch nhau?
8. Tên zone nào dễ hiểu hơn: thành phố, UTC offset hay cả hai? Kiểm tra lại khi DST đổi.

T014 chỉ được đánh dấu sau khi có ít nhất hai người Việt ở nước ngoài thật theo recruitment plan,
ghi chú có consent và synthesis không làm lộ thông tin cá nhân. Desk scenario này không đáp ứng
điều kiện đó.

## 6. Decision log tạm

| Quyết định | Trạng thái |
|---|---|
| Calendar rules theo UTC+7 | `ADOPT` ở mức contract |
| “Hôm nay” local + tùy chọn Nhịp Việt Nam | `PROTOTYPE` — chưa được T014 xác nhận |
| Reminder mặc định theo local delivery zone | `PROTOTYPE` — chưa được T014 xác nhận |
| DST gap/overlap policy | `HOLD` — cần quyết định trước Reminder Core |
| Default cho tháng nhuận/ngày 30 thiếu | `HOLD` — không có default quốc gia |
| Gate 1–7 | `UNTESTED` |
| T014 | `NOT RUN` |
