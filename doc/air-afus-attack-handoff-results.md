# AFUS bomber handoff validation

2026-10-03. Implements the [handoff plan](air-afus-attack-handoff-plan.md).
The operation controller previously held fire while moving to the target's
formation slots, then waited for arrival before issuing ATTACK. It also kept
traveling to lower-priority targets after a nearby AFUS became visible.

The new opt-in policy replaces the final travel leg with ATTACK and interrupts
a committed offensive run for a nearby, currently LOS-visible AFUS. It keeps
that target until it disappears or loses visibility. Early final approach is
also enabled for defensive sorties; AFUS interruption is offensive-only.
Native defaults remain disabled, so other callers/roles retain their policy.

## Measurements

All runs use Recoil `2026.07.04`, BAR `test-31479-433a460`, fixed seed 1651,
rendered 1280x720 arenas with actual screenshots. Economy and construction are
frozen; aircraft, targets, energy and radar coverage are supplied. These are
targeting regressions, not full-game economy or win-rate tests. The first two
tests use full LOS to isolate command sequencing; the Cortex test uses normal
LOS/radar.

| Run | Profile / visibility | Bombers / escorts in observed wave | Local visible AFUS to all bomber ATTACK orders | First bomber damage after local visibility | AFUS death after local visibility | Result |
| --- | --- | --- | --- | --- | --- | --- |
| `d176-baseline` Legion, old DLL | balanced / global | 3 / 0 | 16.33 s | 4.67 s (collateral before target handoff) | 30.80 s | Expected FAIL, INV-121 |
| `d176-legion` | balanced / global | 3 / 0 | 0.33 s | 4.33 s | 14.37 s | PASS, continued storage cleanup |
| `d176-armada` | hard / global, AFUS appears at 90 s | 14 / 32 | 0.33 s | 5.77 s | 9.67 s | PASS, escorts retained and cleanup continued |
| `d176-cortex`, final DLL | terrible / normal LOS, AFUS appears at 90 s | 14 / 32 at launch | 0.33 s | 4.53 s | 7.60 s | PASS, cleanup continued; surviving escorts remained owned |

Times use engine simulation frames at 30 Hz. The observer samples every five
frames, separately from the native task scheduler. A visible contact here
means actual team LOS within 1,800 elmos of the surviving bomber cohort centre.
It is not the time any scout first saw the distant building. ATTACK orders do
not imply instantaneous weapon release; aircraft turn, approach and reload.
The baseline's early collateral damage demonstrates why first damage alone
would have missed this targeting defect.

The baseline and fixed Legion cases supplied the same forces, but the first
small cleanup wave launched before fighter creation completed. The reveal
fixture instead supplies fighters first and records all 32 staying with the
raid. Fixed tests record exactly one AFUS attack transition per observed
target. Seeded games are not asserted bit-for-bit deterministic across
asynchronous scheduling, game speed or binary changes.

![Baseline AFUS visible while the raid continued to another building](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d176/baseline-visible.png)

![Legion Phoenixes firing on approach](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d176/legion-afus.png)

![Armada hitting the newly revealed AFUS with its escorts](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d176/armada-afus.png)

![Cortex striking under normal LOS/radar](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d176/cortex-afus.png)

Supreme Isthmus `d176-defense` uses the final DLL with Legion/balanced and
normal LOS. The five-bomber defensive wave received ATTACK at frame 2504
(83.47 s), at a distance of 1,216 elmos. It first damaged the Shiva at frame
2650 (88.33 s), began returning after the threat cleared at frame 2909
(96.97 s), and all five reached home at frame 3287 (109.57 s). Defensive
return remains separate from committed offense.
The strict eight-minute defensive report passed with no invariant, script,
fixture or crash failures. All four fixed rendered runs passed their complete
checks; the baseline deliberately fails the new handoff invariant.

![Defensive Phoenixes attacking the Shiva](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d176/defensive-shiva.png)

## Cost and regression scope

The reactive path makes one pass over live known contacts and one bomber-centre
pass. It performs no per-candidate route search, threat-map integration or
enemy-by-aircraft loop. Definition lookup uses the small configured priority
map; the excluded-region list is capped at eight. Once attacking a qualifying
visible target, it skips the scan. Orders are emitted on the target/phase
transition, with existing empty-queue recovery retained; there is no command
refresh timer or reaction rate limit.

Observed AIR command peaks in the fixed Legion, Armada and Cortex fixtures were
1,199, 1,432 and 1,743 commands/minute respectively, including spawned-unit setup,
held pools, scouts, wall fighters and escorts. These supplied cases do not
establish a late-game FPS/APM bound (KI-474 remains). No AFUS retarget churn,
T1 ground targeting, offensive return, landing, or escort-owner violation
appeared in those strict reports.

## Reproduction and artifacts

Use [the initial fixture](../tools/playtest/cases/air/combat/afus-handoff-glitters.json)
or [the reveal fixture](../tools/playtest/cases/air/combat/afus-reveal-glitters.json)
with [the arena runner](../tools/playtest/air_arena.py). The
[engine observer](../tools/playtest/widgets/air_arena.lua),
[strict checks](../tools/playtest/checks/air/combat/air_afus_handoff.json) and
[timing auditor](../tools/playtest/audit_afus_handoff.py) are checked in.
The [evidence manifest](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/d176-afus-handoff.json) records full DLL,
debug, data and log hashes, overrides, measured contacts, command counts and
key log excerpts for all five runs.

```powershell
python tools/playtest/air_arena.py run --dir build-theatres/afus-check --case afus-reveal-glitters --map "All That Glitters v2.2.3" --side cortex --profile experimental_terrible --visibility radar --dll build-theatres/d176-build-2/SkirmishAI.dll --data build-theatres/d176-data --minutes 6 --speed 3 --wall-minutes 8
python tools/playtest/audit_afus_handoff.py build-theatres/afus-check
```

The data snapshot starts from verified D-175 data and overlays only the two
changed AIR script files; concurrent unrelated map work is excluded. Baseline
DLL SHA-256 starts `411a8924354ef767`; first fixed build starts
`4451cf3acfa3be16`. The final reviewed build starts `0b8b08be87bbadef`, adding
only live-wrapper validation and preservation of disappeared-target counts
when interruption bypasses ordinary retarget accounting. API and AIR policy
are identical between the two fixed builds.

All native suites and 288 AngelScript arithmetic assertions passed. Added
geometry assertions cover final-leg versus assembly/search, disabled policy,
priority threshold, radar-only, mobile and out-of-radius candidates. All three
profiles compile against declarations exported by the running new DLL.
Runtime loads are covered by the faction/profile cases above. API, invariant
and role-reference checks pass. Documentation links retain eight pre-existing
missing `hover.md` links (KI-404); this change introduces none.

Published the final stripped DLL, matching debug file and all 312 pinned data
files together to
`C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`.
Every copied file hash matches the tested snapshot; script/DLL API parity
passes there. The live game installation was not modified.
