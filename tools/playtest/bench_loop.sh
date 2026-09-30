#!/bin/bash
# Run the rush benchmark for each objective given, headless, tech vs tech, and
# record each run:  bash tools/playtest/bench_loop.sh fusion afus [speed]
# Minutes per objective = target + 6 so a miss still shows its real time.
cd /c/bardev/s3k-CircuitAI || exit 1
SPEED=${SPEED:-8}
# DLL=<path> tests that build (default: the docker install copy); DIR=<write dir>
# runs in that dir (default: C:/bardev/barb-playtest; one dir per concurrent game)
DIR=${DIR:-C:/bardev/barb-playtest}
declare -A MIN=( [t2]=13 [fusion]=18 [afus]=24 [nuke]=23 [gantry]=22 [titan]=32 )
for obj in "$@"; do
  python tools/playtest/playtest.py stop --dir "$DIR" >/dev/null 2>&1
  echo "=== $obj ($(date +%H:%M:%S))"
  OUT=$(python tools/playtest/playtest.py run --dir "$DIR" ${DLL:+--dll "$DLL"} --headless --roles TECH --speed "$SPEED" \
      --checks "rush_$obj" --set "RushObjective=\"$obj\"" --minutes "${MIN[$obj]}" --keep-going 2>&1)
  printf '%s\n' "$OUT" | grep -E "Verdict|Game time|report:|ERROR"
  # the run folder from this run's own report line (the newest folder can be an older run's)
  R=$(printf '%s\n' "$OUT" | grep 'report:' | sed 's/.*report: //; s/.report\.md$//' | tail -1)
  if [ -z "$R" ]; then echo "no report for $obj: not recorded"; continue; fi
  R=$(cygpath -u "$R")
  python tools/playtest/benchmark.py record "$R" --objective "$obj" --note "${NOTE:-bench loop}" 2>&1 | head -12
  grep -c "ERR  :" "$R/infolog.txt" | sed 's/^/script ERR lines: /'
done
echo "=== done ($(date +%H:%M:%S))"
