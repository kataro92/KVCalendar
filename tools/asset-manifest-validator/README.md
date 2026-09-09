# Asset manifest validator

Công cụ kiểm tra gói hiệu ứng và hồ sơ Rodin, chạy offline.

```
python3 tools/asset-manifest-validator/validate.py \
  LichNha/Resources/EffectPacks/effect-seed.json \
  LichNha/Resources/EffectPacks/holiday-scenes.json \
  LichNha/Resources/EffectPacks/solar-term-families.json \
  assets/source/rodin/lap-xuan/generation-manifest.md
```

Lệnh ghi pack seed:

```
python3 tools/asset-manifest-validator/write_effect_packs.py
```

Từ chối pack nếu checksum sai, license `restricted`, model không có poster, Image-to-3D thiếu ảnh tham chiếu, Quốc kỳ không phải `manual`, hoặc có `textTo3D`.
