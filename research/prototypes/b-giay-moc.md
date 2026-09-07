# Prototype tĩnh B: Giấy Mộc

**Ngày**: 2026-09-07  
**Fidelity**: annotation giấy/Figma tĩnh, vòng 1. Không phải asset production.  
**Cùng nội dung với A và C**: fixture chữ giống `a-moc-son-diu.md`.

B trả lời: người ta thích cấu trúc tờ giấy, hay chỉ thích khánh và son. Cùng hierarchy, cùng gesture dự kiến, ít trang trí.

## Fixture chữ (giống A, C)

| Trường | Giá trị trên tờ |
|---|---|
| Thứ | Thứ Ba |
| Ngày dương | 8 |
| Tháng · năm | Tháng 9 · 2026 |
| Ngày âm | Mùng 17 tháng 7 |
| Can Chi gọn | Năm Bính Ngọ · ngày Giáp Tý |
| Sự kiện / tiết khí | (trống) |
| Dòng truyền thống | Theo lịch truyền thống: giờ thìn–tỵ (tham khảo) |
| Mẩu đáy | Hiên nhà còn ẩm sương. |

Trạng thái: hôm nay, chưa bóc, light, iPhone dọc.

## Vật liệu

- Tường `#EADFD5` gần phẳng, gần như không vữa.
- Không khánh lớn. Tháng–năm nằm trên một thanh giấy mỏng phía trên xấp, hoặc in nhỏ đầu tờ.
- Không ốc đồng nổi. Gáy chỉ là mép xám ấm, bóng tiếp xúc sát.
- Tờ `#FFF8E8` vẫn 2:3, 86–90% bề rộng. Xấp 4–7 mép, đây là tín hiệu “bloc” còn lại.
- Mực `#332B2B` / `#6D5C5C`. Dấu ngày dùng mực đậm + chữ, son `#B83A45` chỉ còn một gạch ngắn nếu Chủ nhật (fixture này là Thứ Ba nên không son).
- Không minh họa chim/mèo. Đáy tờ chỉ còn câu serif.
- Chuyển động (vòng 2): nhanh hơn A; bóc mục tiêu về phía dưới khoảng 450 ms, không nhấc góc 4 px.

## Bố cục tờ

Cùng mốc 0–13 / 13–50 / 50–53 / 53–66 / 66–84 / 84–100 như A. Đường phân cách là hairline mực, không hoa văn son.

```
0–13   Thứ Ba                    Tháng 9 · 2026
13–50  8
50–53  ────────
53–66  Mùng 17 tháng 7
       Năm Bính Ngọ · ngày Giáp Tý
66–84  Theo lịch truyền thống: giờ thìn–tỵ (tham khảo)
84–100 Hiên nhà còn ẩm sương.
```

## Điều khiển (44 pt)

Cùng tập nút A: tháng, mặt sau, ngày sau/trước, hôm nay, loa, kẹp. Tháng không “nằm trên gỗ”; nhãn phải viết rõ “Mở lịch tháng” vì mất ốc như mỏ neo.

Tai giấy vẫn có, mảnh hơn A, để Gate 2 đo gesture trên cùng affordance.

## Annotation vòng 1

Câu hỏi thêm so với A, sau khi họ xếp “dễ đọc / đẹp / giống nhà”:

- “Thiếu cái gì so với lịch treo tường không?”
- Nếu họ không gọi là bloc: ghi fail tín hiệu xấp giấy, không tự giải thích “đó là mép tờ”.

Cỡ 200% và Reduce Motion: cùng luật A.

## Rủi ro cần đo

Nếu B thắng A ở “dễ đọc” nhưng thua xa ở “giống nhà”, Gate 1 không được chọn B chỉ vì điểm đọc. Ghi cả hai trục.
