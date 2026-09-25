#!/usr/bin/env bash
# Package a built SMRTBARb library as the release archive of its platform.
#
#   tools/release/package.sh <SkirmishAI.dll | libSkirmishAI.so> <out_dir> [<debug file>]
#
# SMRTBARb is this fork's alias of BARb. The platform follows the library:
# SkirmishAI.dll is Windows (a .zip), libSkirmishAI.so is Linux (a .tar.gz, the
# usual Linux archive; it keeps file modes). The archive holds the folder the
# game loads, unpacked into <BAR>/data/engine/<engine>/AI/Skirmish/:
#
#   SMRTBARb/stable/AIInfo.lua        packaging/SMRTBARb/AIInfo.lua (shortName/name SMRTBARb)
#   SMRTBARb/stable/AIOptions.lua     data/AIOptions.lua
#   SMRTBARb/stable/SkirmishAI.dll    the build (Linux: libSkirmishAI.so)
#   SMRTBARb/stable/config/           data/config
#   SMRTBARb/stable/script/           data/script
#   SMRTBARb/stable/SMRTBARb_VERSION.txt  version, platform, commit, engine commit
#
# SMRTBARB_CHANNEL=test|prod adds the channel to the version (v1.958-test).
#
# Output: <out_dir>/SMRTBARb-v<version>-<platform>.<zip|tar.gz>, and
# SMRTBARb-v<version>-<platform>-dbg.<zip|tar.gz> when a debug file is given
# (crash symbolizing: keep it next to the library of the same build).
set -euo pipefail

usage="usage: package.sh <SkirmishAI.dll | libSkirmishAI.so> <out_dir> [<debug file>]"
lib="${1:?$usage}"
out="${2:?$usage}"
dbg="${3:-}"

case "$(basename "$lib")" in
  SkirmishAI.dll)    platform=windows; ext=zip ;;
  libSkirmishAI.so)  platform=linux;   ext=tar.gz ;;
  *) echo "error: $lib is neither SkirmishAI.dll nor libSkirmishAI.so" >&2; exit 1 ;;
esac

root="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
version="$("$root/tools/release/version.sh")"
# the release channel (test / prod), from the environment: part of every file name
if [ -n "${SMRTBARB_CHANNEL:-}" ]; then version="${version}-${SMRTBARB_CHANNEL}"; fi
commit="$(git -C "$root" rev-parse HEAD)"
engine="$(tr -d ' \r\n' < "$root/.github/recoil-engine.ref" 2>/dev/null || echo unknown)"

size=$(wc -c < "$lib")
if [ "$size" -gt $((50 * 1024 * 1024)) ]; then
  echo "error: $lib is $size bytes: an unstripped build; split the debug info first" >&2
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

# archive <dir> <entry> <file>: the platform's archive
archive() {
  if [ "$ext" = zip ]; then
    mkzip "$1" "$2" "$3"
  else
    tar --owner=0 --group=0 --numeric-owner -C "$1" -czf "$3" "$2"
  fi
}

stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT
dst="$stage/SMRTBARb/stable"
mkdir -p "$dst"
cp "$root/packaging/SMRTBARb/AIInfo.lua" "$dst/AIInfo.lua"
cp "$root/data/AIOptions.lua" "$dst/AIOptions.lua"
cp "$lib" "$dst/$(basename "$lib")"
cp -r "$root/data/config" "$dst/config"
cp -r "$root/data/script" "$dst/script"
find "$dst" -name '__pycache__' -type d -prune -exec rm -rf {} +
cat > "$dst/SMRTBARb_VERSION.txt" <<EOF
SMRTBARb v${version}
platform ${platform}
commit ${commit}
engine ${engine}
EOF

mkdir -p "$out"
out="$(cd "$out" && pwd)"
name="SMRTBARb-v${version}-${platform}.${ext}"
rm -f "$out/$name"
archive "$stage" SMRTBARb "$out/$name"
echo "$out/$name"

if [ -n "$dbg" ]; then
  dbgname="SMRTBARb-v${version}-${platform}-dbg.${ext}"
  rm -f "$out/$dbgname"
  mkdir -p "$stage/dbg/SMRTBARb/stable"
  cp "$dbg" "$stage/dbg/SMRTBARb/stable/$(basename "$dbg")"
  archive "$stage/dbg" SMRTBARb "$out/$dbgname"
  echo "$out/$dbgname"
fi
