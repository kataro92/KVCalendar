# Storyboard hiệu ứng: Quốc khánh, Lập Xuân, ngày thường

**Ngày**: 2026-09-07  
**Fidelity**: khung tĩnh + ghi chú chuyển động. Không render pháo hoa production, không Rodin, không cờ tạo sinh.

Mỗi cảnh: tờ lịch và chữ xuất hiện trước. Tối đa một intro. Vùng an toàn: không hạt/đạo cụ cắt số dương, ngày âm, dòng sự kiện. Quốc kỳ không qua AI.

Nội dung tờ cho storyboard lễ **không** dùng fixture Thứ Ba 8/9. Ghi rõ ngày cảnh. Ngày thường dùng đúng fixture A/B/C.

## 1. Quốc khánh 2/9, “Cờ trên hiên”

Thứ tự khung (thời gian từ lúc tờ đã đọc được):

| Khung | Thời điểm | Hình | Chữ trên tờ (cố định) |
|---|---|---|---|
| N0 | 0 ms | Tường ấm, khánh gỗ, tờ 2/9 | Thứ Tư · 2 · Tháng 9 · 2026 · ngày âm fixture của 2/9 khi có engine; tạm để trống số âm nếu chưa có |
| N1 | 400–600 ms | Ánh nắng lướt trên gỗ khánh | không đổi chữ |
| N2 | 0,6–3,2 s | 2–3 chùm pháo đỏ–vàng **sau khánh**, lệch khỏi số ngày | Dấu son “Quốc khánh” |
| N3 | chồng N2 | Cờ Việt Nam nhỏ trên cạnh khánh, một nhịp gió, rồi đứng | Cờ 2:3, sao vàng năm cánh giữa nền đỏ; không crop, không confetti cờ |
| N4 | sau 8–12 s | Poster: cờ đứng, không hạt | chữ giữ nguyên |

Cue sự kiện (nếu người bật): 2–3 tiếng pháo xa. Nền Hiên sớm không đổi beat theo lễ. Haptic không theo pháo.

Giọng VoiceOver thêm một câu ở sự kiện: “Không khí Quốc khánh: cờ Việt Nam trên khánh lịch và pháo hoa phía xa.” Không đọc từng chùm.

### Reduce Motion

Cờ đứng từ N0. N1 là crossfade ánh sáng. N2 thành ba cụm màu nước tĩnh mờ dần. Không lay cờ.

### Dim Flashing Lights

Không chớp trắng, không nhịp sáng tối nhanh. Pháo = quầng đỏ–vàng mềm, ổn định. Poster N4 dùng luôn nếu Dim Flashing Lights bật từ đầu.

### Low Power

Ảnh bake cờ + khánh, tối đa một fade. Không live 3D.

### Fail nếu

Ngôi sao bị che, cờ sai tỷ lệ, pháo đi qua số `2`, người xem nói “game” hoặc “bắn pháo trong nhà”.

## 2. Lập Xuân, “Nụ đầu hiên”

Dùng ngày Lập Xuân của năm test (điền UTC+7 khi T042 có). Trên storyboard ghi nhãn “Lập Xuân · cảm hứng tiết khí, không phải dự báo thời tiết”.

| Khung | Thời điểm | Hình |
|---|---|---|
| L0 | 0 ms | Tờ ngày + chữ tiết khí “Lập Xuân · bắt đầu lúc …” nếu có giờ tin cậy |
| L1 | ngay sau | Bóng nhành trên mép tường, ngoài tờ |
| L2 | 1,2–1,8 s | 2–3 nụ mở; cành không mọc từ không khí |
| L3 | chồng L2 | 4–8 cánh hoa (không cả lá) theo đường cong; vài cánh đáp vùng trống rồi tan |
| L4 | sau intro | Cành tĩnh; 0 hạt |

Vùng: Bắc đào se lạnh; Trung cành mảnh sau mưa; Nam mai hoặc chồi; trung tính nụ mực. Người chọn vùng trong cài đặt, không GPS. Buổi vòng 1 chiếu bản trung tính trừ khi người đã nói vùng.

Rodin: cấm trên storyboard này. Ảnh tham chiếu cành thuộc T118 sau T020.

### Reduce Motion

L0 + cành tĩnh + 1–2 cánh đã đáp, không bay. Crossfade bóng nhành.

### Dim Flashing Lights

Không hạt sáng nhấp. Cánh hoa nếu còn thì opacity thấp, không nhấp.

### Low Power

Poster L4 từ đầu.

### Fail nếu

Sakura/lá phong, cả cây nở rộ, cánh che số ngày, “Tết cung đình” mặc định cho mọi vùng.

## 3. Ngày thường (fixture Thứ Ba 8)

| Khung | Thời điểm | Hình |
|---|---|---|
| D0 | 0 ms | Tờ fixture A (hoặc B/C theo nhánh concept) |
| D1 | 0,3–2 s | Một vi cảnh: bóng cửa sổ hoặc một nhành lá, seed cố định theo ngày |
| D2 | lắng | Vi cảnh đứng; không intro lặp khi mở lại cùng ngày |

Không pháo, không cánh hoa. Intro tối đa một lần/ngày hiện tại. Ngày quá khứ/tương lai: postcard tĩnh; có con dấu “Xem không khí ngày này”.

### Reduce Motion / Dim Flashing Lights / Low Power

D0 + poster bóng cửa sổ. Không parallax theo gyroscope.

## 4. Phiếu ghi buổi

| Mã S | Cảnh | Đọc đúng dương/âm trong 5 s? | Sắc thái họ nói | RM/DFL còn hiểu ngày? | Flag / biểu tượng sai? | Trang trọng / nhà / game |
|---|---|---|---|---|---|---|
| | Quốc khánh | | | | | |
| | Lập Xuân | | | | | |
| | Ngày thường | | | | | |

Gate 6 cần 90% đọc đúng khi cảnh chạy và 80% đúng sắc thái Quốc khánh + Lập Xuân. Một lỗi Quốc kỳ là fail cổng, không lấy trung bình.
