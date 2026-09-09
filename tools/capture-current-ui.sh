#!/usr/bin/env bash
# Capture current Simulator UI into LichNha/Tests/Screenshots/current/. Overwrites. No history.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/LichNha/Tests/Screenshots/current"
BUNDLE="vn.lichnha.app"
SIM="${LICH_NHA_SIMULATOR_ID:-3CB6389C-9B36-46CE-92DE-44BE9142F622}"
WAIT="${LICH_NHA_SCREENSHOT_WAIT:-3}"

mkdir -p "$DEST"
find "$DEST" -name '*.png' -delete

xcrun simctl boot "$SIM" >/dev/null 2>&1 || true
open -a Simulator --args -CurrentDeviceUDID "$SIM" >/dev/null 2>&1 || true
xcrun simctl bootstatus "$SIM" -b >/dev/null

capture() {
  local name="$1"
  shift
  local tmp
  tmp="$(mktemp /tmp/lichnha-ui.XXXXXX)"
  xcrun simctl terminate "$SIM" "$BUNDLE" >/dev/null 2>&1 || true
  xcrun simctl launch "$SIM" "$BUNDLE" --deny-notifications "$@" >/dev/null
  sleep "$WAIT"
  xcrun simctl io "$SIM" screenshot "$tmp" >/dev/null
  cp "$tmp" "$DEST/${name}.png"
  rm -f "$tmp"
}

capture today --date 2026-09-08
capture quoc-khanh --date 2026-09-02
capture month --date 2026-09-02 --screen month
capture detail --date 2026-09-02 --screen detail
capture events --date 2026-09-08 --screen events --reset-personal-store
capture editor --date 2026-09-08 --screen editor --reset-personal-store --deny-notifications
capture settings --date 2026-09-08 --screen settings

xcrun simctl terminate "$SIM" "$BUNDLE" >/dev/null 2>&1 || true
ls -1 "$DEST"/*.png
