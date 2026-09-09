# Ảnh hiện trạng UI

Sau mỗi lát giao diện nhìn thấy được, chụp Simulator và ghi đè `LichNha/Tests/Screenshots/current/`. Không giữ bản cũ. Không viết báo cáo kèm ảnh trừ khi người dùng hỏi.

```
bash tools/capture-current-ui.sh
```

Cần Simulator đã cài `vn.lichnha.app` (build Debug). Script mở từng màn bằng `--screen` / `--date`, chờ tờ hiện, rồi `simctl io screenshot`.

Tên file theo màn, ví dụ `today.png`, `quoc-khanh.png`, `month.png`. Xóa mọi PNG trong thư mục trước khi chụp lại.
