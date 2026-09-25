#!/usr/bin/env bash
# Package a built SkirmishAI.dll as the SMRTBARb release zip.
#
#   tools/release/package.sh <SkirmishAI.dll> <out_dir> [SkirmishAI.dbg]
#
# SMRTBARb is this fork's alias of BARb. The zip holds the folder the game loads,
# unzipped into <BAR>/data/engine/<engine>/AI/Skirmish/:
#
#   SMRTBARb/stable/AIInfo.lua        packaging/SMRTBARb/AIInfo.lua (shortName/name SMRTBARb)
#   SMRTBARb/stable/AIOptions.lua     data/AIOptions.lua
#   SMRTBARb/stable/SkirmishAI.dll    the build
#   SMRTBARb/stable/config/           data/config
#   SMRTBARb/stable/script/           data/script
#   SMRTBARb/stable/SMRTBARb_VERSION.txt  version, commit, engine commit
#
# Output: <out_dir>/SMRTBARb-v<version>.zip, and SMRTBARb-v<version>-dbg.zip when a
# .dbg is given (crash symbolizing: keep it next to the DLL of the same build).
set -euo pipefail

dll="${1:?usage: package.sh <SkirmishAI.dll> <out_dir> [SkirmishAI.dbg]}"
out="${2:?usage: package.sh <SkirmishAI.dll> <out_dir> [SkirmishAI.dbg]}"
dbg="${3:-}"

root="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
version="$("$root/tools/release/version.sh")"
commit="$(git -C "$root" rev-parse HEAD)"
engine="$(tr -d ' \r\n' < "$root/.github/recoil-engine.ref" 2>/dev/null || echo unknown)"

size=$(wc -c < "$dll")
if [ "$size" -gt $((50 * 1024 * 1024)) ]; then
  echo "error: $dll is $size bytes: an unstripped build; split the debug info first" >&2
  exit 1
fi

# zip <dir> <entry> <zipfile>: zip where available (CI), Python's zipfile otherwise
mkzip() {
  if command -v zip > /dev/null 2>&1; then
    (cd "$1" && zip -qr "$3" "$2")
  else
    python - "$1" "$2" "$3" <<'PY'
import os, sys, zipfile
base, entry, out = sys.argv[1], sys.argv[2], sys.argv[3]
with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
    for d, _, files in os.walk(os.path.join(base, entry)):
        for f in files:
            full = os.path.join(d, f)
            z.write(full, os.path.relpath(full, base).replace(os.sep, "/"))
PY
  fi
}

stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT
dst="$stage/SMRTBARb/stable"
mkdir -p "$dst"
cp "$root/packaging/SMRTBARb/AIInfo.lua" "$dst/AIInfo.lua"
cp "$root/data/AIOptions.lua" "$dst/AIOptions.lua"
cp "$dll" "$dst/SkirmishAI.dll"
cp -r "$root/data/config" "$dst/config"
cp -r "$root/data/script" "$dst/script"
find "$dst" -name '__pycache__' -type d -prune -exec rm -rf {} +
cat > "$dst/SMRTBARb_VERSION.txt" <<EOF
SMRTBARb v${version}
commit ${commit}
engine ${engine}
EOF

mkdir -p "$out"
out="$(cd "$out" && pwd)"
zipname="SMRTBARb-v${version}.zip"
rm -f "$out/$zipname"
mkzip "$stage" SMRTBARb "$out/$zipname"
echo "$out/$zipname"

if [ -n "$dbg" ]; then
  dbgzip="SMRTBARb-v${version}-dbg.zip"
  rm -f "$out/$dbgzip"
  mkdir -p "$stage/dbg/SMRTBARb/stable"
  cp "$dbg" "$stage/dbg/SMRTBARb/stable/SkirmishAI.dbg"
  mkzip "$stage/dbg" SMRTBARb "$out/$dbgzip"
  echo "$out/$dbgzip"
fi
