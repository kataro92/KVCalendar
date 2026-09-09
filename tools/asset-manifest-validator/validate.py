#!/usr/bin/env python3
"""Validate Lịch Nhà effect packs and Rodin/asset manifests. No network. Exit 0 if valid."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

FORBIDDEN_METHODS = {"textTo3D", "text-to-3d", "text_to_3d"}
HEX64 = re.compile(r"^[0-9a-f]{64}$")


def sha256_canonical(value) -> str:
    blob = json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False).encode("utf-8")
    return hashlib.sha256(blob).hexdigest()


def fail(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


def validate_pack(pack: dict, path: Path) -> None:
    for key in ("schemaVersion", "packVersion", "recordsChecksum", "cues", "assets"):
        if key not in pack:
            fail(f"{path}: missing {key}")
    payload = {"assets": pack["assets"], "cues": pack["cues"]}
    expected = sha256_canonical(payload)
    if pack["recordsChecksum"] != expected:
        fail(f"{path}: checksum mismatch expected {expected}")
    asset_ids = set()
    for asset in pack["assets"]:
        for field in ("id", "kind", "sourceReference", "generationMethod", "checksum", "licenseStatus"):
            if field not in asset:
                fail(f"{path}: asset missing {field}")
        if asset["id"] in asset_ids:
            fail(f"{path}: duplicate asset {asset['id']}")
        asset_ids.add(asset["id"])
        if asset["licenseStatus"] == "restricted":
            fail(f"{path}: restricted license {asset['id']}")
        method = asset["generationMethod"]
        if method in FORBIDDEN_METHODS:
            fail(f"{path}: text-to-3D is forbidden ({asset['id']})")
        if method == "imageTo3D" and not str(asset.get("sourceReference") or "").strip():
            fail(f"{path}: Image-to-3D asset {asset['id']} needs sourceReference")
        if asset["kind"] == "model" and not asset.get("posterID"):
            fail(f"{path}: model {asset['id']} needs posterID")
        if not HEX64.match(str(asset["checksum"])):
            fail(f"{path}: asset {asset['id']} checksum must be 64 hex chars")
        hay = f"{asset['id']} {asset.get('sourceReference', '')}".lower()
        if any(token in hay for token in ("flag", "quoc-ky", "quốc kỳ")) and method != "manual":
            fail(f"{path}: national flag asset {asset['id']} must be manual")
    cue_ids = set()
    for cue in pack["cues"]:
        for field in ("id", "tone", "priority", "fallbackPosterID"):
            if field not in cue:
                fail(f"{path}: cue missing {field}")
        if cue["id"] in cue_ids:
            fail(f"{path}: duplicate cue {cue['id']}")
        cue_ids.add(cue["id"])
        if cue.get("nationalFlag") and cue["fallbackPosterID"] in asset_ids:
            asset = next(item for item in pack["assets"] if item["id"] == cue["fallbackPosterID"])
            if asset["generationMethod"] != "manual":
                fail(f"{path}: national flag cue {cue['id']} cannot use generative poster")


def validate_generation_markdown(path: Path) -> None:
    text = path.read_text(encoding="utf-8")
    required = ["Trạng thái", "Phương thức", "Ảnh tham chiếu", "Text-to-3D"]
    for heading in required:
        if heading not in text:
            fail(f"{path}: missing required heading {heading}")
    if "NOT RUN" not in text and "Image-to-3D" not in text:
        fail(f"{path}: generation record must state Image-to-3D or NOT RUN")
    lowered = text.lower()
    if "text-to-3d" in lowered and "cấm" not in lowered and "not used" not in lowered and "không" not in text.lower():
        fail(f"{path}: Text-to-3D mentioned without prohibition")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("paths", nargs="+", type=Path)
    args = parser.parse_args()
    for path in args.paths:
        if not path.exists():
            fail(f"missing {path}")
        if path.suffix == ".json":
            pack = json.loads(path.read_text(encoding="utf-8"))
            if "packs" in pack and "cues" not in pack:
                continue
            validate_pack(pack, path)
        elif path.suffix == ".md":
            validate_generation_markdown(path)
        else:
            fail(f"unsupported {path}")
    print("ok")


if __name__ == "__main__":
    main()
