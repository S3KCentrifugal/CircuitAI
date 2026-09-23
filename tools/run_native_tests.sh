#!/usr/bin/env bash
# D-094: compile and run the standalone native unit tests (tests/*_test.cpp)
# with the Recoil build container's MinGW compiler, then run the executables on
# the Windows host. Exit 0 when every test passes.
#
#   bash tools/run_native_tests.sh
#
# The tests include only engine-free headers (BaseLayoutGeometry.h,
# LayoutRanking.h), so no engine, wrapper or AI build is needed.
set -u
REPO="$(cd "$(dirname "$0")/.." && { pwd -W 2>/dev/null || pwd; })"
OUT="${TMPDIR:-${TEMP:-/tmp}}/circuit-native-tests"
mkdir -p "$OUT"
IMAGE="$(docker images --format '{{.Repository}}:{{.Tag}}' | grep recoil-build-amd64-windows | head -1)"
if [ -z "$IMAGE" ]; then
	echo "run_native_tests: the recoil-build-amd64-windows image is not present (run a docker build once)" >&2
	exit 2
fi
tests=(layout_ranking_test base_layout_geometry_test)
cmd=""
for t in "${tests[@]}"; do
	cmd="$cmd x86_64-w64-mingw32-g++ -std=c++20 -O1 -Wall -Wextra -static -I/src/src /src/tests/$t.cpp -o /out/$t.exe || exit 1;"
done
MSYS2_ARG_CONV_EXCL='*' docker run --rm -v "$REPO:/src:ro" -v "$(cd "$OUT" && { pwd -W 2>/dev/null || pwd; }):/out" --entrypoint sh "$IMAGE" -c "$cmd" || { echo "run_native_tests: compile failed" >&2; exit 1; }
rc=0
for t in "${tests[@]}"; do
	if ! "$OUT/$t.exe"; then
		echo "run_native_tests: $t FAILED" >&2
		rc=1
	fi
done
exit $rc
