#!/usr/bin/env python3
"""Write Lịch Nhà effect packs with canonical checksums. No network."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DEST = ROOT / "LichNha" / "Resources" / "EffectPacks"
SOLAR_NAMES = [
    "Xuân phân", "Thanh minh", "Cốc vũ", "Lập hạ",
    "Tiểu mãn", "Mang chủng", "Hạ chí", "Tiểu thử",
    "Đại thử", "Lập thu", "Xử thử", "Bạch lộ",
    "Thu phân", "Hàn lộ", "Sương giáng", "Lập đông",
    "Tiểu tuyết", "Đại tuyết", "Đông chí", "Tiểu hàn",
    "Đại hàn", "Lập xuân", "Vũ thủy", "Kinh trập",
]


def sha256_canonical(value) -> str:
    blob = json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False).encode("utf-8")
    return hashlib.sha256(blob).hexdigest()


def asset_checksum(asset_id: str) -> str:
    return hashlib.sha256(asset_id.encode("utf-8")).hexdigest()


def poster(asset_id: str, source: str = "procedural-poster") -> dict:
    return {
        "id": asset_id,
        "kind": "poster",
        "sourceReference": source,
        "generationMethod": "manual",
        "checksum": asset_checksum(asset_id),
        "licenseStatus": "original",
    }


def finish(pack: dict) -> dict:
    payload = {"assets": pack["assets"], "cues": pack["cues"]}
    pack["recordsChecksum"] = sha256_canonical(payload)
    return pack


def cue(
    cue_id: str,
    tone: str,
    priority: int,
    poster_id: str,
    occurrence: str | None = None,
    term: int | None = None,
    **flags,
) -> dict:
    item = {
        "id": cue_id,
        "tone": tone,
        "priority": priority,
        "allowsAutoPlay": flags.get("allowsAutoPlay", True),
        "nationalFlag": flags.get("nationalFlag", False),
        "solemn": flags.get("solemn", False),
        "noConfetti": flags.get("noConfetti", False),
        "noAudio": flags.get("noAudio", False),
        "posterOnly": flags.get("posterOnly", False),
        "fallbackPosterID": poster_id,
    }
    if occurrence is not None:
        item["triggerOccurrenceID"] = occurrence
    if term is not None:
        item["triggerSolarTermIndex"] = term
    return item


seed = finish(
    {
        "schemaVersion": "1",
        "packVersion": "lich-nha-fx-1",
        "cues": [
            cue(
                "cue-quoc-khanh",
                "festive-solemn",
                100,
                "poster-quoc-khanh",
                occurrence="quoc-khanh",
                nationalFlag=True,
                noConfetti=True,
            ),
            cue(
                "cue-lap-xuan",
                "quiet-spring",
                80,
                "poster-lap-xuan",
                term=21,
            ),
            cue(
                "cue-ordinary",
                "quiet-house",
                1,
                "poster-ordinary",
            ),
        ],
        "assets": [
            poster("poster-quoc-khanh", "hand-built-flag-geometry"),
            poster("poster-lap-xuan", "procedural-branch-pending-rodin"),
            poster("poster-ordinary", "procedural-window-wash"),
        ],
    }
)

holiday = finish(
    {
        "schemaVersion": "1",
        "packVersion": "lich-nha-fx-holidays-deferred",
        "cues": [
            cue(
                "cue-tet-nguyen-dan",
                "warm-new-year",
                70,
                "poster-tet",
                occurrence="tet-nguyen-dan",
                posterOnly=True,
            ),
            cue(
                "cue-hung-kings",
                "solemn",
                70,
                "poster-hung-kings",
                occurrence="gio-to-hung-vuong",
                solemn=True,
                noConfetti=True,
                noAudio=True,
                posterOnly=True,
            ),
            cue(
                "cue-april-30",
                "calm-morning",
                70,
                "poster-april-30",
                occurrence="giai-phong-30-4",
                nationalFlag=True,
                noConfetti=True,
                posterOnly=True,
            ),
            cue(
                "cue-mid-autumn",
                "quiet-lantern",
                70,
                "poster-mid-autumn",
                occurrence="trung-thu",
                posterOnly=True,
            ),
        ],
        "assets": [
            poster("poster-tet", "deferred-gate-6a"),
            poster("poster-hung-kings", "deferred-gate-6a"),
            poster("poster-april-30", "deferred-gate-6a"),
            poster("poster-mid-autumn", "deferred-gate-6a"),
        ],
    }
)

term_cues = []
term_assets = []
for index, name in enumerate(SOLAR_NAMES):
    poster_id = f"poster-term-{index}"
    term_cues.append(
        cue(
            f"cue-term-{index}",
            "static-term",
            20,
            poster_id,
            term=index,
            posterOnly=True,
            allowsAutoPlay=False,
        )
    )
    term_assets.append(poster(poster_id, f"static-solar-term:{name}"))

solar = finish(
    {
        "schemaVersion": "1",
        "packVersion": "lich-nha-fx-terms-static",
        "cues": term_cues,
        "assets": term_assets,
    }
)

manifest = {
    "packs": [
        {"id": "effect-seed", "file": "effect-seed.json"},
        {"id": "holiday-scenes", "file": "holiday-scenes.json"},
        {"id": "solar-term-families", "file": "solar-term-families.json"},
    ]
}


def write(name: str, payload: dict) -> None:
    DEST.mkdir(parents=True, exist_ok=True)
    path = DEST / name
    path.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"wrote {path}")


def main() -> None:
    write("effect-seed.json", seed)
    write("holiday-scenes.json", holiday)
    write("solar-term-families.json", solar)
    write("manifest.json", manifest)


if __name__ == "__main__":
    main()
