import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent
SAMPLES = ROOT / "samples"


def sha256_canonical(value) -> str:
    blob = json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False).encode("utf-8")
    return hashlib.sha256(blob).hexdigest()


sources = [
    {
        "id": "qd-134-2002",
        "title": "Quyết định 134/2002/QĐ-TTg",
        "url": "https://vbpl.vn/TW/Pages/vbpq-toanvan.aspx?ItemID=21982",
        "evidenceTier": "official",
        "scope": "UTC+7 modern",
        "licenseStatus": "publicRecord",
    }
]
occurrences = [
    {
        "id": "quoc-khanh-2026",
        "title": "Quốc khánh",
        "taxonomy": "statutoryHoliday",
        "sourceID": "qd-134-2002",
        "packVersion": "1.0.0",
        "isDayOff": True,
        "legalCitation": "Hiến pháp 2013 Điều 13; kiểm tra văn bản năm phát hành",
    }
]
almanac = {
    "rulesetId": "lich-nha-truyen-thong-1",
    "version": "1.0.0-draft",
    "methods": [
        {"id": "hoang-hac-dao"},
        {"id": "luc-dieu"},
        {"id": "sat-chu-tho-tu"},
    ],
}
payload = {"sources": sources, "occurrences": occurrences, "almanac": almanac}
checksum = sha256_canonical(payload)

valid = {
    "schemaVersion": "1",
    "packVersion": "1.0.0",
    "publishedAt": "2026-09-09",
    "effectiveRange": {"from": 2026, "to": 2026},
    "minimumAppVersion": "0.1.0",
    "recordsChecksum": checksum,
    "approvals": ["owner", "second-reviewer"],
    "sources": sources,
    "occurrences": occurrences,
    "almanac": almanac,
}

SAMPLES.mkdir(exist_ok=True)
(SAMPLES / "valid.json").write_text(json.dumps(valid, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

missing = dict(valid)
del missing["sources"]
(SAMPLES / "invalid-missing-source.json").write_text(
    json.dumps(missing, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
)

restricted = json.loads(json.dumps(valid))
restricted["sources"][0]["licenseStatus"] = "restricted"
restricted["recordsChecksum"] = sha256_canonical(
    {
        "sources": restricted["sources"],
        "occurrences": restricted["occurrences"],
        "almanac": restricted["almanac"],
    }
)
(SAMPLES / "invalid-restricted-license.json").write_text(
    json.dumps(restricted, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
)

bad_sum = dict(valid)
bad_sum["recordsChecksum"] = "0" * 64
(SAMPLES / "invalid-checksum.json").write_text(
    json.dumps(bad_sum, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
)
print("wrote samples")
