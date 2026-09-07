# Motion study: ba mức page curl và action không kéo

**Ngày**: 2026-09-07  
**Dùng trong**: vòng 2, sau khi A/B/C tĩnh đã chạy.  
**Không làm trong file này**: shader production, physics giấy 3D, haptic trên TestFlight.

Mỗi mức dùng cùng tờ fixture (Thứ Ba 8 / Mùng 17 tháng 7). Người tham gia không nghe tên mức. Thứ tự mức đảo theo `session-guide.md`.

WCAG 2.2: kéo do app điều khiển phải có cách một con trỏ khác. Mọi mức dưới đây đều gắn cùng bộ nút; khác nhau chỉ ở chuyển động.

## Action không kéo (bắt buộc trên mọi mức)

| Action | Cách hiện | VoiceOver | Reduce Motion |
|---|---|---|---|
| Ngày sau | Button 44 pt, nhãn “Ngày sau” | custom action trên tờ | slide hoặc dissolve 120–180 ms |
| Ngày trước | Button 44 pt, “Ngày trước” | custom action | như trên |
| Bóc tờ hôm nay | Button, chỉ khi đang ở hôm nay chưa bóc | “Bóc tờ hôm nay” | dissolve; không xé |
| Hôm nay | Button, chỉ khi selected date ≠ hôm nay | “Về hôm nay” | như trên |
| Xem mặt sau | Button + chạm giữa tờ | “Xem chi tiết ngày” | flip tắt, crossfade |

Không để “kéo góc” là hàng duy nhất trên tờ. Không dùng hover. Không delay 300 ms giả lập.

## Mức 1, nghiêng và mask (prototype rẻ)

- Chạm góc phải dưới: góc nhấc 2–4 px trong 70–100 ms; ốc gần như đứng.
- Kéo: tờ nghiêng theo ngón, mask cong mềm, bóng sát mép; tờ dưới lộ đúng tỷ lệ kéo.
- Ngưỡng: ~42% chiều cao tờ hoặc fling nhanh. Hoàn tất 450–650 ms. Trả tờ 220–320 ms.
- Không mesh, không shader distortion, không hạt giấy.
- Haptic: một transient lúc qua ngưỡng, một lúc tờ rời. Không rung theo ngón.

Đo: nhận ra “bóc lịch”, thời gian tới ngày kế, khó chịu 1–5, fps trên máy thấp nhất.

Nếu mức 1 đã được gọi là “bóc lịch thật” và giữ 60 fps, không bắt buộc nâng mức 2 cho 1.0.

## Mức 2, biến dạng mặt tờ (đề xuất production nếu mức 1 yếu)

- Mặt trước/sau có distortion theo đường chéo từ ốc tới ngón.
- Mặt sau tối hơn và ít bão hòa trong lúc kéo.
- Cùng ngưỡng, cùng thời lượng hoàn tất/trả tờ, cùng nút thay thế.
- Chỉ chạy distortion trong gesture; khi nghỉ về texture tĩnh.
- Vẫn cấm hạt nổ và spring mạnh.

Đo thêm: chữ có đọc được lúc đang cong không; có ai thấy “trò 3D” không.

## Mức 3, giấy 3D đầy đủ (không khuyến nghị 1.0)

Ghi lại chỉ để khỏi bị thử lén trong buổi:

- cloth/physics, xé gáy, hàng trăm lớp giấy.
- Loại vì startup, pin, VoiceOver, và chữ thành bitmap.

Nếu có clip tham khảo nội bộ, không chiếu cho người tham gia như phương án chọn.

## Ma trận chạy buổi

Mỗi người làm “sang ngày mai” hai lần: một lần không gợi ý, một lần chỉ được nói “dùng cách khác, không kéo”. Ghi mức đang chiếu.

| Người | Thứ tự mức | Lần 1 (kéo, không hướng dẫn) | Lần 2 (nút/action) | Khó chịu 1–5 | Ghi chú |
|---|---|---|---|---|---|
| *(điền Sxx)* | | thành công / gợi ý / fail | | | |

Gate 2 tính trên cách họ **thành công**, không bắt phải thích curl. Median thời gian lấy từ lần không hướng dẫn.

## Reduce Motion

Cả ba mức, khi máy bật Reduce Motion: không curl. Ngày sau/trước là slide hoặc dissolve 120–180 ms. Nút không đổi nhãn. Storyboard Reduce Motion của cảnh ngày nằm ở `effect-storyboards.md`, tách khỏi gesture giấy.
