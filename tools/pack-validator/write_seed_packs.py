#!/usr/bin/env python3
"""Write seed content packs with canonical checksums. No network."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DEST = ROOT / "LichNha" / "Resources" / "ContentPacks"
FIXTURES = [
    ROOT / "LichNha" / "Modules" / "ContentCore" / "Tests" / "Fixtures",
    ROOT / "LichNha" / "Tests" / "ContentCoreTests" / "Fixtures",
]


def sha256_canonical(value) -> str:
    blob = json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False).encode("utf-8")
    return hashlib.sha256(blob).hexdigest()


def finish(pack: dict) -> dict:
    payload = {
        "sources": pack["sources"],
        "occurrences": pack["occurrences"],
        "almanac": pack.get("almanac"),
    }
    pack["recordsChecksum"] = sha256_canonical(payload)
    return pack


def source(sid, title, url, tier, publisher, scope, license_status, seed):
    row = {
        "id": sid,
        "title": title,
        "evidenceTier": tier,
        "publisher": publisher,
        "accessedAt": "2026-09-09",
        "scope": scope,
        "licenseStatus": license_status,
        "contentHash": hashlib.sha256(seed).hexdigest(),
    }
    if url:
        row["url"] = url
    return row


def occ(oid, title, taxonomy, basis, source_id, pack_version, is_day_off, **fields):
    row = {
        "id": oid,
        "title": title,
        "taxonomy": taxonomy,
        "calendarBasis": basis,
        "sourceID": source_id,
        "packVersion": pack_version,
        "isDayOff": is_day_off,
        "region": "toan-quoc",
    }
    row.update(fields)
    return row


official_sources = [
    source(
        "bllld-2019-d112",
        "Bộ luật Lao động 45/2019/QH14, Điều 112",
        "https://vbpl.moj.gov.vn/TW/Pages/vbpq-thuoctinh.aspx?ItemID=139264",
        "official",
        "Quốc hội",
        "Toàn quốc, ngày nghỉ lễ Tết theo luật đang hiệu lực",
        "publicRecord",
        b"bllld-2019-d112",
    ),
    source(
        "nq-28-2026-qh16",
        "Nghị quyết 28/2026/QH16, Điều 2 (Ngày Văn hóa Việt Nam)",
        "https://xaydungchinhsach.chinhphu.vn/lich-nghi-le-quoc-khanh-2-9-va-ngay-van-hoa-viet-nam-24-11-2026-119260504103718299.htm",
        "official",
        "Quốc hội",
        "24/11 dương lịch, hiệu lực từ 01/7/2026",
        "publicRecord",
        b"nq-28-2026-qh16",
    ),
]
official_occurrences = [
    occ(
        "tet-duong-lich",
        "Tết Dương lịch",
        "statutoryHoliday",
        "solar",
        "bllld-2019-d112",
        "1.1.0",
        True,
        legalCitation="Bộ luật Lao động 45/2019/QH14 Điều 112 điểm a",
        solarMonth=1,
        solarDay=1,
    ),
    occ(
        "tet-nguyen-dan",
        "Tết Nguyên đán",
        "statutoryHoliday",
        "lunar",
        "bllld-2019-d112",
        "1.1.0",
        True,
        legalCitation="Bộ luật Lao động 45/2019/QH14 Điều 112 điểm b: Tết Âm lịch 05 ngày; mùng 1 là ngày danh xưng. Ngày cụ thể còn lại do Thủ tướng quyết định hằng năm.",
        lunarMonth=1,
        lunarDay=1,
        lunarIsLeap=False,
    ),
    occ(
        "giai-phong-30-4",
        "Ngày Chiến thắng",
        "statutoryHoliday",
        "solar",
        "bllld-2019-d112",
        "1.1.0",
        True,
        legalCitation="Bộ luật Lao động 45/2019/QH14 Điều 112 điểm c (30/4 dương lịch)",
        solarMonth=4,
        solarDay=30,
    ),
    occ(
        "quoc-te-lao-dong",
        "Ngày Quốc tế Lao động",
        "statutoryHoliday",
        "solar",
        "bllld-2019-d112",
        "1.1.0",
        True,
        legalCitation="Bộ luật Lao động 45/2019/QH14 Điều 112 điểm d",
        solarMonth=5,
        solarDay=1,
    ),
    occ(
        "quoc-khanh",
        "Quốc khánh",
        "statutoryHoliday",
        "solar",
        "bllld-2019-d112",
        "1.1.0",
        True,
        legalCitation="Bộ luật Lao động 45/2019/QH14 Điều 112 điểm đ; Hiến pháp 2013 Điều 13. Ngày 2/9; ngày liền kề 1/9 hoặc 3/9 do thông báo từng năm.",
        solarMonth=9,
        solarDay=2,
    ),
    occ(
        "gio-to-hung-vuong",
        "Giỗ Tổ Hùng Vương",
        "statutoryHoliday",
        "lunar",
        "bllld-2019-d112",
        "1.1.0",
        True,
        legalCitation="Bộ luật Lao động 45/2019/QH14 Điều 112 điểm e (10/3 âm lịch)",
        lunarMonth=3,
        lunarDay=10,
        lunarIsLeap=False,
    ),
    occ(
        "ngay-van-hoa-viet-nam",
        "Ngày Văn hóa Việt Nam",
        "statutoryHoliday",
        "solar",
        "nq-28-2026-qh16",
        "1.1.0",
        True,
        legalCitation="Nghị quyết 28/2026/QH16 Điều 2; hiệu lực 01/7/2026",
        solarMonth=11,
        solarDay=24,
    ),
]

official = finish(
    {
        "schemaVersion": "1",
        "packVersion": "1.1.0",
        "publishedAt": "2026-09-09",
        "effectiveRange": {"from": 2026, "to": 2100},
        "minimumAppVersion": "0.1.0",
        "approvals": ["owner", "pending-second-reviewer"],
        "sources": official_sources,
        "occurrences": official_occurrences,
        "almanac": None,
    }
)

schedule_2026_sources = [
    source(
        "tb-9441-bnv-2026",
        "Thông báo 9441/TB-BNV, Bộ Nội vụ, lịch nghỉ Tết Âm lịch và Quốc khánh 2026",
        "https://xaydungchinhsach.chinhphu.vn/thong-bao-lich-nghi-le-quoc-khanh-2026-119260729092042494.htm",
        "official",
        "Bộ Nội vụ",
        "Năm 2026; công chức, viên chức. Doanh nghiệp chọn phương án theo Điều 112 khoản 3.",
        "publicRecord",
        b"tb-9441-bnv-2026",
    ),
]
schedule_2026_occurrences = [
    occ(
        "tet-am-lich-2026-02-16",
        "Tết Nguyên đán",
        "yearlySchedule",
        "solar",
        "tb-9441-bnv-2026",
        "1.0.0",
        True,
        legalCitation="TB 9441/TB-BNV: 05 ngày luật từ 29 tháng Chạp Ất Tỵ đến mùng 4 tháng Giêng Bính Ngọ (16–20/2/2026). Bản ghi này là 16/2 (29 Chạp).",
        solarYear=2026,
        solarMonth=2,
        solarDay=16,
        audience="Công chức, viên chức; doanh nghiệp chọn một trong ba phương án 5 ngày Tết",
    ),
    occ(
        "tet-am-lich-2026-02-18",
        "Tết Nguyên đán",
        "yearlySchedule",
        "solar",
        "tb-9441-bnv-2026",
        "1.0.0",
        True,
        legalCitation="TB 9441/TB-BNV: 18/2/2026, mùng 2 tháng Giêng. Mùng 1 nằm ở pack luật (tet-nguyen-dan).",
        solarYear=2026,
        solarMonth=2,
        solarDay=18,
        audience="Công chức, viên chức; doanh nghiệp chọn một trong ba phương án 5 ngày Tết",
    ),
    occ(
        "tet-am-lich-2026-02-19",
        "Tết Nguyên đán",
        "yearlySchedule",
        "solar",
        "tb-9441-bnv-2026",
        "1.0.0",
        True,
        legalCitation="TB 9441/TB-BNV: 19/2/2026, mùng 3 tháng Giêng.",
        solarYear=2026,
        solarMonth=2,
        solarDay=19,
        audience="Công chức, viên chức; doanh nghiệp chọn một trong ba phương án 5 ngày Tết",
    ),
    occ(
        "tet-am-lich-2026-02-20",
        "Tết Nguyên đán",
        "yearlySchedule",
        "solar",
        "tb-9441-bnv-2026",
        "1.0.0",
        True,
        legalCitation="TB 9441/TB-BNV: 20/2/2026, mùng 4 tháng Giêng.",
        solarYear=2026,
        solarMonth=2,
        solarDay=20,
        audience="Công chức, viên chức; doanh nghiệp chọn một trong ba phương án 5 ngày Tết",
    ),
    occ(
        "quoc-khanh-2026-lien-ke",
        "Quốc khánh (ngày liền kề)",
        "yearlySchedule",
        "solar",
        "tb-9441-bnv-2026",
        "1.0.0",
        True,
        legalCitation="TB 9441/TB-BNV: 1/9/2026 là ngày liền kề trước 2/9 cho công chức, viên chức. Doanh nghiệp chọn 1/9 hoặc 3/9.",
        solarYear=2026,
        solarMonth=9,
        solarDay=1,
        audience="Công chức, viên chức. Doanh nghiệp: 1/9 hoặc 3/9",
    ),
    occ(
        "quoc-khanh-2026-lam-bu",
        "Làm bù (hoán đổi Quốc khánh 2026)",
        "yearlySchedule",
        "solar",
        "tb-9441-bnv-2026",
        "1.0.0",
        False,
        legalCitation="TB 9441/TB-BNV: hoán đổi thứ Hai 31/8 sang thứ Bảy 22/8/2026. Không phải ngày nghỉ lễ Điều 112.",
        solarYear=2026,
        solarMonth=8,
        solarDay=22,
        audience="Công chức, viên chức",
    ),
]

schedule_2026 = finish(
    {
        "schemaVersion": "1",
        "packVersion": "1.0.0",
        "publishedAt": "2026-09-09",
        "effectiveRange": {"from": 2026, "to": 2026},
        "minimumAppVersion": "0.1.0",
        "approvals": ["owner", "pending-second-reviewer"],
        "sources": schedule_2026_sources,
        "occurrences": schedule_2026_occurrences,
        "almanac": None,
    }
)

culture_sources = [
    source(
        "folk-tet-doan-ngo",
        "Tết Đoan Ngọ trong lịch dân gian Việt Nam",
        "https://www.xemamlich.uhm.vn/calrules.html",
        "cultural",
        "tham khảo văn hóa, không phải lịch pháp định",
        "Lễ âm dân gian, không suy ra ngày nghỉ",
        "original",
        b"folk-tet-doan-ngo",
    ),
    source(
        "folk-trung-thu",
        "Rằm tháng Tám / Tết Trung thu, lễ dân gian",
        None,
        "cultural",
        "biên tập Lịch Nhà theo lịch dân gian Việt Nam, không phải văn bản ngày nghỉ",
        "Lễ âm 15/8, không suy ra ngày nghỉ",
        "original",
        b"folk-trung-thu",
    ),
    source(
        "folk-vu-lan",
        "Rằm tháng Bảy / Vu Lan, lễ dân gian",
        None,
        "cultural",
        "biên tập Lịch Nhà theo lịch dân gian Việt Nam, không phải văn bản ngày nghỉ",
        "Lễ âm 15/7, không suy ra ngày nghỉ",
        "original",
        b"folk-vu-lan",
    ),
]
culture_occurrences = [
    occ(
        "doan-ngo",
        "Tết Đoan Ngọ",
        "traditionalLunar",
        "lunar",
        "folk-tet-doan-ngo",
        "1.1.0",
        False,
        lunarMonth=5,
        lunarDay=5,
        lunarIsLeap=False,
    ),
    occ(
        "trung-thu",
        "Tết Trung thu",
        "traditionalLunar",
        "lunar",
        "folk-trung-thu",
        "1.1.0",
        False,
        lunarMonth=8,
        lunarDay=15,
        lunarIsLeap=False,
    ),
    occ(
        "vu-lan",
        "Vu Lan",
        "traditionalLunar",
        "lunar",
        "folk-vu-lan",
        "1.1.0",
        False,
        lunarMonth=7,
        lunarDay=15,
        lunarIsLeap=False,
    ),
]

culture = finish(
    {
        "schemaVersion": "1",
        "packVersion": "1.1.0",
        "publishedAt": "2026-09-09",
        "effectiveRange": {"from": 1900, "to": 2100},
        "minimumAppVersion": "0.1.0",
        "approvals": ["owner", "pending-second-reviewer"],
        "sources": culture_sources,
        "occurrences": culture_occurrences,
        "almanac": None,
    }
)

almanac = finish(
    {
        "schemaVersion": "1",
        "packVersion": "1.0.0-draft",
        "publishedAt": "2026-09-09",
        "effectiveRange": {"from": 1900, "to": 2100},
        "minimumAppVersion": "0.1.0",
        "approvals": ["owner", "pending-second-reviewer"],
        "sources": [
            source(
                "xieji-bianfang-shu",
                "Hiệp Kỷ Biện Phương Thư (協紀辨方書), 1739",
                "https://chinaknowledge.de/Literature/Daoists/xiejibianfangshu.html",
                "traditional",
                "Ulrich Theobald / chinaknowledge.de mô tả văn bản Tứ Khố",
                "Khung thần sát và giờ Hoàng/Hắc; không phải lịch pháp định Việt Nam",
                "publicDomain",
                b"xieji-bianfang-shu",
            ),
            source(
                "xiao-liuren-folk",
                "Tiểu Lục Nhâm / Lục Diệu dân gian",
                "https://www.master-insight.com/article/32868",
                "traditional",
                "khảo về truyền thuyết Gia Cát; UI không ghi Khổng Minh là tác giả",
                "Nhãn dân gian, không phải lịch pháp định",
                "original",
                b"xiao-liuren-folk",
            ),
        ],
        "occurrences": [],
        "almanac": {
            "rulesetId": "lich-nha-truyen-thong-1",
            "version": "1.0.0-draft",
            "methods": [
                {"id": "hoang-hac-dao", "displayName": "Giờ Hoàng Đạo / Hắc Đạo"},
                {"id": "luc-dieu", "displayName": "Lục Diệu (dân gian)"},
                {"id": "sat-chu-tho-tu", "displayName": "Sát Chủ / Thọ Tử"},
            ],
        },
    }
)

manifest = {
    "packs": [
        {"id": "official-vn", "file": "official-vn.json", "kind": "official"},
        {"id": "official-schedule-2026", "file": "official-schedule-2026.json", "kind": "yearly-schedule"},
        {"id": "culture-vn", "file": "culture-vn.json", "kind": "culture"},
        {"id": "almanac-seed", "file": "almanac-seed.json", "kind": "almanac"},
    ]
}

invalid = json.loads(json.dumps(official))
invalid["recordsChecksum"] = "0" * 64


def write(path: Path, obj) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


for dest in [DEST, *FIXTURES]:
    write(dest / "official-vn.json", official)
    write(dest / "official-schedule-2026.json", schedule_2026)
    write(dest / "culture-vn.json", culture)
    write(dest / "almanac-seed.json", almanac)
    write(dest / "manifest.json", manifest)

for fixture in FIXTURES:
    write(fixture / "invalid-checksum.json", invalid)

print("wrote packs", DEST)
for fixture in FIXTURES:
    print("wrote fixtures", fixture)
