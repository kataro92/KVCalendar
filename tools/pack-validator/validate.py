#!/usr/bin/env python3
"""Validate Lịch Nhà content packs. No network. Exit 0 if valid."""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path

REQUIRED_HEADER = (
    "schemaVersion",
    "packVersion",
    "publishedAt",
    "effectiveRange",
    "minimumAppVersion",
    "recordsChecksum",
    "approvals",
    "sources",
    "occurrences",
)


def sha256_canonical(value) -> str:
    blob = json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False).encode("utf-8")
    return hashlib.sha256(blob).hexdigest()


def fail(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


def validate(pack: dict) -> None:
    for key in REQUIRED_HEADER:
        if key not in pack:
            fail(f"missing header field: {key}")
    if not isinstance(pack["approvals"], list) or len(pack["approvals"]) < 2:
        fail("need two release approvals")
    sources = pack["sources"]
    occurrences = pack["occurrences"]
    if not isinstance(sources, list) or not isinstance(occurrences, list):
        fail("sources and occurrences must be lists")
    payload = {"sources": sources, "occurrences": occurrences, "almanac": pack.get("almanac")}
    expected = sha256_canonical(payload)
    if pack["recordsChecksum"] != expected:
        fail(f"checksum mismatch: got {pack['recordsChecksum']} expected {expected}")
    source_ids = set()
    for source in sources:
        for field in ("id", "title", "evidenceTier", "scope", "licenseStatus"):
            if field not in source:
                fail(f"source missing {field}")
        if source["id"] in source_ids:
            fail(f"duplicate source id {source['id']}")
        source_ids.add(source["id"])
        if source["licenseStatus"] == "restricted":
            fail(f"restricted source cannot ship: {source['id']}")
        if "url" in source and source["url"] and not str(source["url"]).startswith("https://"):
            fail(f"source url must be https: {source['id']}")
    occ_ids = set()
    for occ in occurrences:
        for field in ("id", "title", "taxonomy", "sourceID", "packVersion", "isDayOff"):
            if field not in occ:
                fail(f"occurrence missing {field}")
        if occ["id"] in occ_ids:
            fail(f"duplicate occurrence id {occ['id']}")
        occ_ids.add(occ["id"])
        if occ["taxonomy"] == "personal":
            fail("pack must not contain personal events")
        if occ["sourceID"] not in source_ids:
            fail(f"occurrence {occ['id']} references missing source")
        if occ["taxonomy"] == "statutoryHoliday" and "legalCitation" not in occ:
            fail(f"official occurrence needs legalCitation: {occ['id']}")
    almanac = pack.get("almanac")
    if almanac is not None:
        methods = almanac.get("methods") or []
        ids = [item.get("id") for item in methods]
        allowed = {"hoang-hac-dao", "luc-dieu", "sat-chu-tho-tu"}
        extra = [item for item in ids if item not in allowed]
        if extra:
            fail(f"unknown almanac method: {extra}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("path")
    args = parser.parse_args()
    path = Path(args.path)
    pack = json.loads(path.read_text(encoding="utf-8"))
    validate(pack)
    print(f"ok {path}")


if __name__ == "__main__":
    main()
