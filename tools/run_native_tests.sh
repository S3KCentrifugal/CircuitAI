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
tests=(layout_ranking_test base_layout_geometry_test local_reservations_test lane_solver_test strategic_targeting_test terrain_route_test air_geometry_test metal_field_test enemy_reclaim_policy_test)
cmd=""
for t in "${tests[@]}"; do
    extra=""
    if [ "$t" = lane_solver_test ] || [ "$t" = terrain_route_test ]; then extra="/src/src/circuit/terrain/LaneSolver.cpp"; fi
	cmd="$cmd x86_64-w64-mingw32-g++ -std=c++20 -O1 -Wall -Wextra -static -pthread -I/src/src -I/src/src/circuit /src/tests/$t.cpp $extra -o /out/$t.exe || exit 1;"
done
cmd="$cmd x86_64-w64-mingw32-g++ -std=c++20 -O1 -static -DAS_MAX_PORTABILITY -DANGELSCRIPT_EXPORT -I/src/src/lib/angelscript/include -I/src/src/lib/angelscript/add_on/scriptarray /src/tests/production_math_test.cpp /src/src/lib/angelscript/add_on/scriptarray/scriptarray.cpp /src/src/lib/angelscript/source/*.cpp -o /out/production_math_test.exe || exit 1;"
MSYS2_ARG_CONV_EXCL='*' docker run --rm -v "$REPO:/src:ro" -v "$(cd "$OUT" && { pwd -W 2>/dev/null || pwd; }):/out" --entrypoint sh "$IMAGE" -c "$cmd" || { echo "run_native_tests: compile failed" >&2; exit 1; }
rc=0
for t in "${tests[@]}"; do
	if ! "$OUT/$t.exe"; then
		echo "run_native_tests: $t FAILED" >&2
		rc=1
	fi
done
"$OUT/production_math_test.exe" "$REPO/data/script/src/helpers/production_math.as" "$REPO/tests/production_math_tests.as" || rc=1
"$OUT/production_math_test.exe" "$REPO/data/script/src/helpers/placement_math.as" "$REPO/tests/placement_math_tests.as" || rc=1
"$OUT/production_math_test.exe" "$REPO/data/script/src/helpers/amphibious_math.as" "$REPO/tests/amphibious_math_tests.as" || rc=1
"$OUT/production_math_test.exe" "$REPO/data/script/src/helpers/air_math.as" "$REPO/tests/air_math_tests.as" || rc=1
"$OUT/production_math_test.exe" "$REPO/data/script/src/helpers/build_power_math.as" "$REPO/tests/build_power_math_tests.as" || rc=1
"$OUT/production_math_test.exe" "$REPO/data/script/src/helpers/metal_math.as" "$REPO/tests/metal_math_tests.as" || rc=1
"$OUT/production_math_test.exe" "$REPO/data/script/src/helpers/team_share_math.as" "$REPO/tests/team_share_math_tests.as" || rc=1
"${PYTHON:-python}" "$REPO/tools/knowledge/check_performance_policy.py" --runner "$OUT/production_math_test.exe" --output "$OUT/performance-policy" || rc=1
"${PYTHON:-python}" "$REPO/tools/knowledge/check_weapon_work.py" --runner "$OUT/production_math_test.exe" --output "$OUT/weapon-policy" || rc=1
exit $rc
