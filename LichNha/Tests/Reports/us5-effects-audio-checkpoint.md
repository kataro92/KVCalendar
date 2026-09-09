# US5 Effects and audio checkpoint (T130)

Ngày: 09/09/2026. Simulator: iPhone 17.

## Tự động

Resolver: một hero khi trùng sự kiện; tone trang trọng chặn confetti/audio; Reduce Motion ra poster nhưng giữ cue; intro một lần/ngày trừ replay. Pack sai checksum bị từ chối; cache last-known-valid vẫn tải được. Quốc kỳ 3:2, sao năm cánh hướng lên, nằm trong hình chữ nhật. `textTo3D` không decode.

Âm: mặc định Yên, giấy và cue sự kiện tắt. Silent, VoiceOver, audio khác, cuộc gọi và rút tai nghe đều chặn phát. File Hiên sớm / Mưa xa / Quạt trưa chưa có trong bundle; player trả về silent.

`swift test --package-path LichNha/Modules`: 77 tests pass. UI tests US1–US5: 10 tests pass, gồm Quốc khánh 2/9/2026 đọc được ngày và nút Phát lại.

Validator: `python3 tools/asset-manifest-validator/validate.py` pass trên ba pack và generation-manifest.

## Rodin

T118 có concept sheet gốc. Ảnh tham chiếu chưa chụp. T119 `NOT RUN`. T120 chưa có phôi để cleanup. Scene Lập Xuân dùng nhánh vẽ tay và cánh hoa Canvas.

## Cổng người và máy

Gate 6A, 6B, 7A, 7B: UNTESTED. Chưa profile flagship trên máy thật, chưa chạy 15 phút ambient, chưa buổi người. Không ghi PASS.

T122 defer bốn cảnh lễ vì Gate 6A chưa chạy. T123/T124 là poster tĩnh.

## Kết luận

US5 đủ resolver, cờ thủ công, poster, Yên mặc định và replay. Bước tiếp: User Story 6 (cài đặt và accessibility).
