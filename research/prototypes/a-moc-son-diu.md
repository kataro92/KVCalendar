# Prototype tĩnh A: Mộc Son Dịu

**Ngày**: 2026-09-07  
**Fidelity**: annotation cho giấy/Figma tĩnh, vòng 1. Không phải asset production.  
**Cùng nội dung với B và C**: khối “Fixture chữ” bên dưới.

Tra cứu UX dùng cho annotation này: thao tác kéo phải có nút một chạm; Reduce Motion thiết kế từ đầu; vùng chạm iOS 44 pt; mỗi cảnh tối đa một chuyển động chính. Các gợi ý web (Hero–CTA, palette xanh marketing, Outfit/Work Sans) không dùng.

## Fixture chữ (giống B, C)

Mọi ngày âm, Can Chi và câu truyền thống dưới đây là chữ mẫu để so sánh layout. Không phải output Calendar Core.

| Trường | Giá trị trên tờ |
|---|---|
| Thứ | Thứ Ba |
| Ngày dương | 8 |
| Tháng · năm | Tháng 9 · 2026 |
| Ngày âm | Mùng 17 tháng 7 |
| Can Chi gọn | Năm Bính Ngọ · ngày Giáp Tý |
| Sự kiện / tiết khí | (trống; không bịa ngày lễ) |
| Dòng truyền thống | Theo lịch truyền thống: giờ thìn–tỵ (tham khảo) |
| Mẩu đáy | Hiên nhà còn ẩm sương. |

Trạng thái: hôm nay, chưa bóc, light mode, Dynamic Type cỡ lớn mặc định. Máy khung: iPhone dọc, safe area ~390×844 pt.

## Vật liệu

- Tường phấn `#EADFD5`, vữa rất nhẹ, không ảnh phòng.
- Khánh gỗ sữa `#6B4F46`, cao 16–20% màn hình, sơn mài mờ, một họa tiết tâm (hồi văn tối giản hoặc quạt giấy), không logo giả.
- Hai ốc đồng `#C79A58` hơi lớn hơn tỷ lệ thật, không phải nút trừ khi cả vùng tháng–năm có nhãn.
- Tờ giấy kem `#FFF8E8`, tỷ lệ gần 2:3, rộng 86–90% safe area.
- Xấp giấy: 4–7 mép đáy và cạnh phải.
- Mực `#332B2B`, mực phụ `#6D5C5C`, Chủ nhật/dấu dùng son `#B83A45` kèm chữ “Chủ nhật”, không chỉ đổi màu.
- Minh họa: tối đa một chim sẻ hoặc ấm trà nét tròn ở đáy tờ; không chibi, không clay.

## Bố cục tờ (tỷ lệ cao 100)

```
0–13   Thứ Ba                    Tháng 9 · 2026
13–50  8
50–53  ──── nét son mảnh ────
53–66  Mùng 17 tháng 7
       Năm Bính Ngọ · ngày Giáp Tý
66–84  Theo lịch truyền thống: giờ thìn–tỵ (tham khảo)
84–100 Hiên nhà còn ẩm sương.
```

Số `8` chiếm khoảng 33–38% chiều cao tờ, Be Vietnam Pro, tabular. Mẩu đáy: EB Garamond. Lề trái/phải ≥8% chiều rộng tờ. Không hộp cho từng trường.

## Điều khiển trên khung (vùng 44 pt)

| Điều khiển | Vị trí | Semantics | Ghi chú test |
|---|---|---|---|
| Tháng/năm | trên khánh / ốc | Button “Mở lịch tháng” | Tác vụ “chỉ nơi xem tháng” |
| Tờ (chạm giữa) | mặt giấy | Button “Xem mặt sau” | Tác vụ chi tiết |
| Tai giấy góc phải dưới | góc tờ | không phải đường duy nhất | chỉ affordance kéo |
| Ngày sau | ngăn giấy hoặc cạnh phải | Button | bắt buộc, Gate 2 |
| Ngày trước | đối xứng | Button | bắt buộc |
| Hôm nay | hiện khi không ở hôm nay | Button | ẩn trên fixture này |
| Loa nền | trên không gian lịch | Button, state Bật/Tắt | bản cài mới Yên; Hiên sớm chỉ phát sau lựa chọn và im lặng nếu Silent/VoiceOver |
| Kẹp sự kiện | mép phải tờ | Button “Sự kiện ngày này” | số lượng 0 |

Kéo góc không được là cách duy nhất sang ngày kế (WCAG 2.2 kéo phải có thay thế một con trỏ).

## Annotation cho vòng 1 (không giải thích trước)

Moderator không nói “số lớn là dương”. Sau 3 giây, ghi từ họ dùng cho vật thể (bloc, lịch xé, app, tranh). Sau 5 giây, hỏi dương/âm.

Chỗ kỳ vọng:

1. Mắt vào `8` trước.
2. Ngày âm là dòng lớn thứ hai dưới nét son.
3. Tháng: chạm “Tháng 9 · 2026” trên khánh.
4. Chi tiết: chạm giữa tờ hoặc “Xem mặt sau” trong ngăn.

Cỡ chữ 200%: ẩn mẩu đáy và dòng giờ trước; giữ thứ, số dương, tháng năm, ngày âm, Can Chi năm.

Reduce Motion: annotation ghi “không minh họa góc giấy nhấp”; chuyển cảnh bằng fade 120–180 ms khi sang vòng 2.

## So với B và C

A giữ khánh, son, ốc đồng. Nếu nhóm 16–34 gọi A là “cúng”, “cụ”, “trẻ con”, Gate 1 phải ghi và giảm họa tiết tâm, không đổ lỗi người dùng.

## Việc chưa có trên file này

Frame Figma, texture chụp, font file nhúng. Buổi T012 cần bản vẽ theo annotation này, cùng fixture chữ, trước khi coi vòng 1 đủ fidelity.
