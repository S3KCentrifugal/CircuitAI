#!/usr/bin/env bash
# SMRTBARb release version: MAJOR.MINOR.
#   MAJOR - the number in SMRTBARb_VERSION at the repo root (edit it by hand for a
#           breaking release).
#   MINOR - the number of commits on the current branch (git rev-list --count HEAD),
#           so every commit raises the minor version by itself, with nothing to
#           commit back.
# Prints e.g. "1.952". Needs the full history (actions/checkout fetch-depth: 0).
set -euo pipefail
root="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
major="$(tr -d ' \r\n' < "$root/SMRTBARb_VERSION")"
minor="$(git -C "$root" rev-list --count HEAD)"
echo "${major}.${minor}"
