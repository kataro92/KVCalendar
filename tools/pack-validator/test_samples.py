#!/usr/bin/env python3
"""Exit 0 only if valid pack passes and invalid packs fail."""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
VALIDATE = ROOT / "validate.py"
SAMPLES = ROOT / "samples"


def run(path: Path) -> int:
    result = subprocess.run(
        [sys.executable, str(VALIDATE), str(path)],
        capture_output=True,
        text=True,
    )
    return result.returncode


def main() -> None:
    valid = run(SAMPLES / "valid.json")
    if valid != 0:
        print("expected valid.json to pass", file=sys.stderr)
        raise SystemExit(1)
    for name in (
        "invalid-missing-source.json",
        "invalid-restricted-license.json",
        "invalid-checksum.json",
    ):
        code = run(SAMPLES / name)
        if code == 0:
            print(f"expected {name} to fail", file=sys.stderr)
            raise SystemExit(1)
    print("pack validator samples ok")


if __name__ == "__main__":
    main()
