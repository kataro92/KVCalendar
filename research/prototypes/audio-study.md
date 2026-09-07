# Nghiên cứu âm: im lặng, Hiên sớm, Mưa xa

**Ngày**: 2026-09-07  
**Trạng thái**: protocol và thông số mẫu đã viết. **File nghe chưa có trong repo** (và không được commit WAV). T010 chỉ đánh dấu xong khi moderator có hai file WAV đạt thông số, kiểm tra tai, và chạy thử Silent/VoiceOver trên máy test.

Không nói với người tham gia âm nào “tốt cho tập trung”. Không ghi trên prototype “tăng tập trung” hay “điều trị”.

## 1. Ba điều kiện

| Mã | Tên UI | File | Nội dung |
|---|---|---|---|
| A0 | Yên | (không file) | Im lặng; loa hệ thống không bị app đụng |
| A1 | Hiên sớm | `research/raw/audio/hien-som-loop.wav` | Pink noise rất nhẹ + room tone ấm + lá xa; không nhạc, lời, chuông, chim lặp, transient |
| A2 | Mưa xa | `research/raw/audio/mua-xa-loop.wav` | Mưa đều ngoài hiên; không sấm, không giọt sắc |

Quạt trưa và cue giấy/sự kiện không vào blind test vòng này.

Nguồn file: Foley tự thu hoặc noise tổng hợp có tham số, mix tay. ElevenLabs nếu dùng chỉ là phôi trước buổi, rồi mix lại; không loop một clip AI ngắn. Ghi provenance trong `research/raw/audio/manifest.md` (ngoài Git).

## 2. Thông số mẫu (điểm bắt đầu, chưa phải chuẩn ship)

- 48 kHz, WAV, mono hoặc stereo giống nhau cho A1 và A2.
- Loop 60–120 s, mối nối không nghe thấy khi lặp 15 phút.
- Fade in 1,5–2,5 s; fade out 0,5–1 s do app (vòng này do công cụ phát).
- Gain buổi: bắt đầu ~15% thang phát; không tự tăng volume hệ thống.
- Đo loa iPhone và tai nghe (có dây hoặc Bluetooth) trên cùng người, thứ tự đảo.

Checklist kỹ thuật trước buổi:

- [ ] A1/A2 phát 30 s, không click ở điểm loop
- [ ] Tắt Silent: A1 không tự kêu
- [ ] VoiceOver bật: A1 không tự kêu
- [ ] Nhạc nền khác đang phát: A1 không tranh
- [ ] Nút loa trên mock: một thao tác, nhãn Bật/Tắt, 44 pt

## 3. Protocol blind test (nhóm chính, ≥12 người 16–34)

Within-subject. Mỗi người làm **cùng loại tác vụ ngắn** dưới ba điều kiện. Tác vụ ngắn: đọc dương/âm của tờ fixture trong 5 giây, rồi sang ngày mai bằng nút (không đo curl ở bài này).

Thứ tự điều kiện: đảo Latin square.

| Khối người | Lần 1 | Lần 2 | Lần 3 |
|---|---|---|---|
| P 16–34 số lẻ | A0 | A1 | A2 |
| P 16–34 số chẵn | A1 | A2 | A0 |
| (xoay thêm nếu >2 người cùng ngày) | A2 | A0 | A1 |

Trình tự một điều kiện (~12–18 phút):

1. Đặt tai nghe hoặc loa máy theo phiếu (nửa mẫu loa, nửa tai nghe trước; rồi đổi nếu còn giờ).
2. Không nói tên âm. Bật điều kiện. Ghi có tắt trong 10 giây đầu không.
3. Tác vụ ngắn ngay phút 0.
4. Để nền chạy. Không bắt họ “thư giãn”. Họ có thể nói chuyện; moderator không tăng volume.
5. Phút 10–15: hỏi dễ chịu, mất tập trung, mệt tai (1–5). Hỏi muốn giữ / đổi / tắt lần mở sau.
6. Fade out. Nghỉ 30–60 s trước điều kiện kế.

Ghi thêm: mối nối loop, xì dải cao, trầm mất trên loa nhỏ, cảm giác lặp.

## 4. Phiếu một người (copy vào session)

```
Mã P / S:
Thiết bị phát: loa máy / tai nghe
Thứ tự: A_ → A_ → A_
Tắt <10s: A0 n/a · A1 có/không · A2 có/không
Đọc đúng dương/âm: A0 · A1 · A2
Sang ngày bằng nút (s): A0 · A1 · A2
Dễ chịu 1–5: ...
Mất tập trung 1–5: ...
Mệt tai 1–5: ...
Lựa chọn lần sau: giữ Hiên sớm / đổi Mưa xa / Yên
Nút tắt tìm được trong một thao tác: có/không
Silent / VO / audio khác: làm / chưa làm trên máy này
```

## 5. Ngưỡng Gate 7A

Tính trên nhóm chính, không gộp 55–75 vào mẫu mặc định âm.

Chỉ cân nhắc đổi Hiên sớm từ opt-in thành bật có điều kiện nếu: ≤25% tắt trong 10 giây đầu; đa số không mệt/mất tập trung sau 10–15 phút; tác vụ ngắn không kém im lặng một cách hệ thống; nút tắt một thao tác; Silent/VO/audio khác đúng protocol. Khi test chưa chạy, bản phát hành chọn Yên.

Nếu không đạt: mặc định Yên, hai bed còn là opt-in.

## 6. Việc chưa xong cho T010

- [ ] Tạo `hien-som-loop.wav` và `mua-xa-loop.wav` theo mục 2
- [ ] Manifest nguồn/quyền/tool
- [ ] Nghe thử 15 phút trên loa iPhone nhỏ
