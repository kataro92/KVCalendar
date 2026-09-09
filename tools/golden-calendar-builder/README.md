# Golden calendar builder

Sinh `calendar-golden.json` từ Calendar Core. Mỗi bản ghi có `sourceKind`, `sourceNote`, múi UTC+7 và checksum SHA-256 của mảng `records` (JSON sorted keys).

```bash
swift run --package-path tools/golden-calendar-builder golden-calendar-builder \
  LichNha/Tests/Fixtures/calendar-golden.json
cp LichNha/Tests/Fixtures/calendar-golden.json \
  LichNha/Modules/CalendarCore/Tests/Fixtures/calendar-golden.json
```

`sourceKind`:

- `published-example`: ca đã in trong [Hồ Ngọc Đức 2008](https://www.xemamlich.uhm.vn/calrules.html)
- `engine-self`: giá trị `lich-nha-cal-1`, chờ oracle độc lập (xem `calendar-oracle-report.md`)
- `engine-self-historical`: cùng engine, ngày 1900–1975 (nhãn hồi chiếu / 1968–1975)
- `soc-near-midnight` / `soc-near-midnight-historical`: Sóc cách nửa đêm UTC+7 dưới 30 phút

Owner ký corpus: chủ dự án. Builder không lấy lịch Hồng Kông (UTC+8) làm chuẩn Việt Nam.
