#!/bin/bash
# Run the rush benchmark for each objective given, headless, tech vs tech, and
# record each run:  bash tools/playtest/bench_loop.sh fusion afus [speed]
# Minutes per objective = target + 6 so a miss still shows its real time.
cd /c/bardev/s3k-CircuitAI || exit 1
SPEED=${SPEED:-8}
declare -A MIN=( [t2]=13 [fusion]=18 [afus]=24 [nuke]=23 [gantry]=22 [titan]=32 )
for obj in "$@"; do
  python tools/playtest/playtest.py stop >/dev/null 2>&1
  echo "=== $obj ($(date +%H:%M:%S))"
  python tools/playtest/playtest.py run --headless --roles TECH --speed "$SPEED" --checks "rush_$obj" \
      --set "RushObjective=\"$obj\"" --minutes "${MIN[$obj]}" --keep-going 2>&1 | grep -E "Verdict|Game time|report:"
  R=$(ls -d /c/bardev/barb-playtest/runs/* | tail -1)
  python tools/playtest/benchmark.py record "$R" --objective "$obj" --note "${NOTE:-bench loop}" 2>&1 | head -12
  grep -c "ERR  :" "$R/infolog.txt" | sed 's/^/script ERR lines: /'
done
echo "=== done ($(date +%H:%M:%S))"
