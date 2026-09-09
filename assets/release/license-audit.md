# License và provenance audit (T148)

Ngày: 09/09/2026
Trạng thái: `HOLD` cho phát hành. Binary Debug Simulator đã rà; chưa có archive App Store.

Một hàng chỉ `APPROVED` khi có file, checksum, giấy phép và reviewer. Lượt này ghi đúng những gì đang nằm trong app.

## Ledger

| Asset/nhóm | File | SHA-256 file | Quyền | Review | Trạng thái |
|---|---|---|---|---|---|
| Font UI | San Francisco / New York hệ thống (`.system`, `.serif`) | n/a | Apple system | không nhúng Be Vietnam Pro / EB Garamond / Bitter | `IN BINARY` |
| Content packs | `LichNha/Resources/ContentPacks/*.json` | xem `LichNha/Resources/release-manifest.json` | văn bản công / original theo từng source | validator pass; T147 blocker | `HOLD` |
| Effect packs | `LichNha/Resources/EffectPacks/*.json` | xem release-manifest | original / manual | validator pass; Rodin chưa chạy | `HOLD` |
| Quốc kỳ / sao | `VietnamFlagMesh.swift` | n/a (code) | dựng tay theo hình học 2:3 | test hình học pass; Gate 6 UNTESTED | `CODE` |
| Poster Quốc khánh / Lập Xuân / ngày thường | Canvas/code, checksum trong pack | checksum pack | original | không phải ảnh bitmap | `CODE` |
| Cành Lập Xuân 3D | chưa có mesh | n/a | Rodin Image-to-3D chờ ảnh tham chiếu | T119 `NOT RUN` | `NOT CREATED` |
| Âm Hiên sớm / Mưa xa / Quạt trưa | không có file trong bundle | n/a | — | player trả silent | `NOT CREATED` |
| Texture giấy | `PaperSurface` Canvas grain | n/a | procedural | Reduce Transparency tắt grain | `CODE` |
| Be Vietnam Pro / EB Garamond / Bitter | không có trong binary | n/a | OFL nếu sau này nhúng | chưa subset | `NOT IN BINARY` |

`generationMethod: textTo3D` không decode. Manifest Rodin `assets/source/rodin/lap-xuan/generation-manifest.md` ghi `NOT RUN`.

## Cổng trước release

Hàng `HOLD`, `NOT CREATED` hoặc T147 thiếu reviewer 2 chặn App Review. T148 là audit, không phải giấy phép đã đủ.
