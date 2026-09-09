# Pack validator

Kiểm schema header, checksum SHA-256, license và reference của content pack. Không gọi mạng. Không cần thư viện Python ngoài stdlib.

```bash
python3 tools/pack-validator/write_samples.py
python3 tools/pack-validator/test_samples.py
python3 tools/pack-validator/validate.py tools/pack-validator/samples/valid.json
```

`validate.py` từ chối pack thiếu header, thiếu 2 approval, checksum sai, `licenseStatus=restricted`, URL không https, occurrence `taxonomy=personal`, sourceID không tồn tại, ngày lễ thiếu `legalCitation`, và method almanac ngoài `hoang-hac-dao` / `luc-dieu` / `sat-chu-tho-tu`.

Mẫu nằm ở `samples/`. Schema: `schemas/content-pack.schema.json`.
