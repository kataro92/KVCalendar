# Ma trận chức năng → ảnh concept

Ngày: 09/09/2026. Đối chiếu README, spec/plan/tasks, UI contracts, docs02/03/08/10, quyết định T018, mã Features/Widget và ảnh Simulator current. Không sửa mã ứng dụng.

Chỉ dẫn người dùng trong task được ưu tiên: nhạc nền tự phát theo ngày; chỉ bật/tắt, không trình nghe nhạc. Giữ sáng là tùy chọn màn hình chính. Không tạo ảnh động.

Trạng thái trong bảng phân biệt bằng chứng hiện có với thiết kế bổ sung. Không coi checkbox là kiểm chứng giao diện. Export/import còn điều kiện; search, converter, monthly-reminder và circular-widget chưa có màn View tương ứng trong mã đã đọc. Gate 1–7 còn UNTESTED. Cảnh mở rộng là concept, không phải chấp thuận release.

| ID | Chức năng / trạng thái | Nguồn | Trạng thái |
|---|---|---|---|
| 01-hom-nay | Tờ hôm nay đầy đủ | US1; FR001–005, FR027; TodayFrontView; user âm nền | hiện có + sửa âm nền |
| 02-man-hinh-nghi | Màn hình để trên bàn | US1/US5; user màn hình chờ và âm nền | yêu cầu trực tiếp |
| 03-lat-ngay-va-lan-dau | Lần đầu, lật ngày, hoàn tác | US1; docs02 §4.1–4.2, §5 | hiện có; polish theo tài liệu |
| 04-lich-thang | Lưới tháng 42 ô | US2; FR006; MonthGridModel; docs02 §4.4 | hiện có |
| 05-chon-thang-va-tim-kiem | Đi tới tháng và tìm ngày/sự kiện | US2; docs02 ngăn giấy/tìm; MonthSheet | picker theo tài liệu; tìm kiếm chưa có UI |
| 06-doi-am-duong | Đổi ngày âm–dương | US2; docs02 §4.5 | đặc tả; chưa có View |
| 07-ngay-khong-hop-le | Ngày không tồn tại và ngoài phạm vi | FR008; docs02 §4.5; CalendarCore | edge cases cần thiết |
| 08-mat-sau-ngay | Mặt sau, phân loại sự kiện | US2; FR003,009,010; DayBackView | hiện có |
| 09-lich-truyen-thong | Ba phương pháp truyền thống | FR011; decision003; AlmanacCore | hiện có; pack chưa duyệt release |
| 10-nguon-va-phien-ban | Nguồn và báo sai | FR010,035; SourceDetailView; VersionAndCorrectionView | hiện có |
| 11-loi-du-lieu-va-lich-su | Cảnh báo lịch sử và dự phòng | FR008,018,032; UI-state loading failure | hiện có + edge states |
| 12-ngay-gia-dinh | Danh sách và danh sách trống | FR012; EventListView | hiện có |
| 13-tao-ngay-gio | Tạo sự kiện âm lịch | FR012–014; EventEditorView | hiện có; polish |
| 14-quy-tac-thang-nhuan | Quy tắc tháng nhuận | FR013–014; LeapMonthPolicyView | hiện có |
| 15-quy-tac-ngay-30 | Ngày 30 trong tháng thiếu | FR013–014; ShortMonthPolicyView | hiện có |
| 16-sinh-nhat-va-nhac-mot-lan | Sự kiện dương và nhắc một lần | FR012; docs02 §4.6 | hiện có |
| 17-xac-nhan-va-quyen-thong-bao | Xác nhận lưu và quyền thông báo | FR014–015; EventReminderStatusView | hiện có |
| 18-sua-xoa-va-ban-nhap | Sửa, xóa và giữ bản nháp | FR012; docs02 navigation draft | CRUD có trong core; UI xóa cần bổ sung |
| 19-nhac-ram-mung-mot | Nhắc rằm và mùng một | docs02 §4.7; recurrence monthly | đặc tả; chưa có màn riêng |
| 20-chia-se-va-lich-iphone | Chia sẻ tờ ngày và xuất một sự kiện | docs02 §4.1/§6; SystemCalendarExport | EventKit hiện có; chia sẻ theo tài liệu |
| 21-widget-man-hinh-chinh | Widget nhỏ, vừa, sáng/tối/tinted | FR017; LichNhaWidget; docs02 §4.8 | hiện có; chi tiết medium theo đặc tả |
| 22-widget-khoa-va-du-phong | Widget khóa, riêng tư và dữ liệu cũ | FR017; WidgetPrivacy; timeline tests | hiện có; circular theo tài liệu |
| 23-ngan-giay-cai-dat | Ngăn giấy điều hướng/cài đặt | US6; PaperDrawerView; docs02 §4.10 | hiện có + bổ sung lối vào |
| 24-hinh-thuc-vung-va-hieu-ung | Hình thức, mức cảnh và vùng | FR019,030–032; EffectSettings/InspirationRegion; docs02 | hiện có + controls đặc tả |
| 25-am-nen-theo-ngay | Âm nền và âm bị tạm ngưng | user override; FR027; SoundSettings | sửa khác code theo yêu cầu |
| 26-rieng-tu-va-mui-gio | Riêng tư và chính sách thời gian | FR013,016,017,033; PrivacyAndTimeSettings | hiện có + nhịp ngày theo spec |
| 27-sao-luu-khoi-phuc | Xuất/nhập dữ liệu — phạm vi có điều kiện | docs02 §4.10; spec assumptions export/import | chưa chốt v1; không coi hiện có |
| 28-tro-giup-va-quyen-rieng-tu | Trợ giúp, giới thiệu và quyền riêng tư | docs02 onboarding/settings; FR034–035 | tài liệu + chức năng nguồn hiện có |
| 29-chu-lon-va-tinh | Accessibility trong tác vụ thực | FR030–032; LargePrintLayout; a11y contract | bắt buộc |
| 30-tet-va-lap-xuan | Tết và Lập Xuân có đầy đủ thao tác | US5; docs08; storyboard Tết; user pink peach | scene đề xuất; static |
| 31-quoc-khanh | Quốc khánh và nhiều dấu mốc | US5; FR019–023; user flag | flag thủ công sau sinh nền |
| 32-canh-le-va-tiet-khi | Cảnh lễ còn lại và sáu họ tiết khí | US5; FR021; docs08 §6.2–6.3 | phạm vi cảnh có điều kiện; static |

## Kiểm mô tả trước khi tạo

- Từng ảnh đã xác định màn hình, dữ liệu nhập, kết quả, nút quay lại và trạng thái đặc biệt; không dùng prompt chỉ có tên chức năng.
- Lịch tháng dùng 7 cột, 6 hàng và ngày tràn; ngày chọn khác ký hiệu hôm nay. Dữ liệu tháng lấy theo ảnh current/month, không tuyên bố oracle độc lập.
- Mẫu ngày chính 08/09/2026 lấy từ ảnh Simulator: 27/7 âm, Ất Dậu, Bạch Lộ. Converter dùng fixture 25/07/2025 → 01/06 nhuận; corpus ghi engine-self.
- Các kết luận almanac chưa duyệt được trình bày là đang chờ dữ liệu; không bịa kết quả tốt/xấu để trang trí. Ba phương pháp không gộp.
- Sự kiện tên người là dữ liệu hư cấu cho thiết kế. Tháng nhuận, tháng thiếu và quyền thông báo có ảnh riêng; từ chối thông báo không mất event.
- Widget khóa mặc định không lộ tên riêng; trạng thái snapshot cũ không ghi Hôm nay.
- Lớp âm bị hệ thống ngăn không làm thay đổi preference đã lưu. Reduce Motion không tự tắt nhạc.
- Cờ chỉ được ghép thủ công vào plate31; ảnh reference không chứa cờ. Không tạo logo hoặc biểu tượng quốc gia bằng mô hình.
- Chữ trên ảnh là tham chiếu bố cục, copy chính xác nằm trong prompt. Những sai lệch ảnh phải được ghi trong review trước bàn giao.

## Ngoài phạm vi

Không có tài khoản, paywall, quảng cáo, analytics, mạng xã hội, dự báo thời tiết, tử vi cá nhân, thư viện văn khấn, đọc toàn bộ Lịch iPhone, thư viện nhạc, đồng bộ cloud hoặc gọi AI lúc runtime. Không cần một màn lỗi mất mạng cho lõi offline.

