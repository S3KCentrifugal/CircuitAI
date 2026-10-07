# Juno shots near the Shore to Shore map edge

Date: 2026-10-04. D-196; unresolved report KI-499.

**The reported off-map shot has not been reproduced. No firing-policy fix is claimed or applied.** The two earlier Shore 8v8 performance logs contain 85 Juno launches; their logged aim points are all inside the map. Two supplied projectile tests add 24 launches across Armada, Cortex and Legion. None of those tracked missiles left the map; the repeat also observed all 12 actual explosion centers inside it.

The [performance review](2026-10-04-skirmishai-performance-review.md) contains all nine ranked optimization proposals, measurements, limitations and equivalence checks. It was committed with its evidence as `dda34d6d`. Juno targeting is a separate correctness investigation; it is not a measured CPU hotspot or an additional performance recommendation.

## Existing safeguards and the remaining concern

[SuperTask.cpp](../../src/circuit/task/static/SuperTask.cpp) selects a known sensor, a suspected jammer, or a fog target in that order. `CanAimStrategic` rejects non-finite, negative and out-of-map coordinates and checks allied target reservations. Known-sensor selection, fog selection and `ExecuteAttack` use that guard; `OnLaunch` checks the existing INV-095 promise. Selected Juno targets become explicit ground-attack orders through [CircuitUnit.cpp](../../src/circuit/unit/CircuitUnit.cpp). Adding another identical bounds check would not explain this observation.

`SelectSuspectedJammer` calls `CorrectPosition(probe)` before validating its candidate. Consequently an inferred probe beyond an edge can become a valid point only 1–2 elmos inside it. Three of the 85 recorded shots were that close to an edge. This explains a plausible source of edge aim points, but does not establish that those missiles actually exploded outside. The logs round aim coordinates and do not record projectile motion or impact centers.

Shore's dimensions in the running game were **15,360 × 3,072 elmos**. The engine's `StarburstLauncher` and `StarburstProjectile` separate the assigned ground target from the missile's flight and collision. BAR's `gfx_explosion_lights.lua` forwards real explosion positions to the LuaUI `VisibleExplosion` callback, used by the repeat observer. The source trace used the local read-only Recoil and BAR reference repositories; runtime evidence is pinned to the installed versions below. An area effect can extend over a map boundary even when its center is valid. That is a possible explanation, not a diagnosis of the user's particular sighting.

## Evidence

| Observation | Launches | Outside aim / flight / explosion |
| --- | ---: | --- |
| D-195 discovery, ordinary AI decisions | 54 | 0 logged aims outside; flight and impact not observed |
| D-195 corrected-roster control | 31 | 0 logged aims outside; flight and impact not observed |
| Initial supplied edge test | 12 | 0 tracked flights outside; disappearance position is not treated as impact |
| Supplied repeat with explosion callback | 12 | 0 tracked flights outside; 12/12 explosion centers inside |

The initial [report and retained evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/juno-edge-d196/2026-10-04/20261004T224559Z-8522f4df/README.md) ran four game minutes. Its checks assert startup, launch and projectile observation, not twelve measured impacts. The [repeat](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/juno-edge-impacts/2026-10-04/20261004T225027Z-e148b0f6/README.md) ran 2.2 minutes and requires exactly twelve launches, twelve tracked projectiles, twelve observed explosions and zero outside flight/impact observations. Both original reports are PASS, with no script or runtime invariant failures; neither proves the reported bug absent in general.

Both use `Shore_to_Shore_V3`, BAR `Beyond All Reason test-31479-433a460`, Recoil `2026.07.04` and DLL SHA256 `d28b4dcb6a319109509202639ac142a919bbae93669a466b5ecab4cc1cc4d450`. Actual scripts, observer hashes, start scripts and pinned build identity are in each bundle. The source tree includes earlier uncommitted AIR/SEA work; HEAD alone does not reconstruct this DLL. No native rebuild or production policy edit was made for this investigation.

The supplied fixture creates twelve Junos on the spectator team and supplies stockpiles. Each faction fires once at each of `(1857,1)`, `(2088,3070)`, `(1857,128)` and `(15358,1536)`. These test north/south edges, a northern inset and a long-range eastern edge shot. Cheats/full visibility and spectator order permission are fixture-only. The two AIR teams are background participants; **this is a weapon-mechanics test, not an AI target-choice or normal-economy benchmark**. The northern/southern points reproduce coordinates found in the ordinary AI logs. Western-edge shots, all possible source positions, other maps and the user's exact match are not covered.

Each compact `juno-observations.json` retains exact tagged log lines and the original infolog hash; `fixture-source.json` retains that run's observer source. Raw logs remain in the categorized local archive. The screenshots show the tested boundaries and timing, but do not independently prove impact coordinates; the explosion callback supplies that evidence.

![East edge just after the three eastern Juno impacts](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/benchmarks/records/shared/combat/juno-edge-impacts/2026-10-04/20261004T225027Z-e148b0f6/screen_2026-10-04_22-50-03-693.png)

## Reproduction and next verification

Use [juno_edge_probe.lua](../../tools/playtest/widgets/juno_edge_probe.lua) with [shared/combat/juno-edge-probe](../../tools/playtest/checks/shared/combat/juno-edge-probe.json). Allocate a fresh `shared/combat` supplied run using `storage.py`, then stage this widget with `playtest.py stage`, `--roles AIR --role AIR --side armada --map Shore_to_Shore_V3 --map-file data/script/src/maps/shore_to_shore.as --minutes 2.2 --speed 3`. Use the pinned DLL, check script/DLL parity before launch, and watch with those checks. The fixture expects AI teams 0/1 and spectator team 2; do not use it with a different roster. Suggested screenshots: `0.70@1800@1857:120,0.80@1800@2088:2950,1.13@1800@15200:1536`.

For the original report, correlate the replay timestamp and launcher with its AI aim, projectile target and actual impact. If an AI aim is outside, repair the bounds conversion or command path and verify all sensor/fog branches plus nuclear/launcher non-regression. If only inferred edge shots waste their pulse, consider rejecting off-map inference probes before clamping and scoring useful in-map coverage; keep known edge jammers targetable. If flight leaves the map despite a valid aim, characterize the weapon trajectory before choosing a script/configurable inference inset. A blanket 450/700-elmo exclusion would knowingly prevent attacks on real edge jammers and is not justified by these tests.

No change to targeting, cooldowns, allied coordination or other static weapons is made pending that evidence. KI-499 remains open.
