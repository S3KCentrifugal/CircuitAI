# AIR management implementation evidence — 2026-09-30

D-147 implements the [AIR controller](../air-management.md). These are local
headless simulations and executable policy tests, not a PvP win-rate study.
All games use Supreme Isthmus v1.7, BAR `test-31450-6562fb1`, Recoil
`recoil_2026.07.04`, fixed engine seed 930146, zero income bonus and requested
20x speed. Runtime role is verified from the AI startup log.

## Builds and isolation

| Build | SHA-256 prefix | Purpose |
| --- | --- | --- |
| Baseline | `40d6a99f177610aa` | Before AIR implementation, with matching baseline data |
| build-02 | `de7332f1563747e3` | Early integration/control tests |
| build-03 | `0a1e703afb9b2533` | Flying-builder approach and physical BP corrections |
| build-04 | `4455871a7febabbc` | Final native binary: persistent local dimensions rotate once; dead recruit orders excluded |

Build-04 is 7,568,026 bytes, stripped, with matching `SkirmishAI.dbg`. The
mandatory Recoil build output contains this DLL, its symbols and current
`data/`. The live BAR installation was not changed. Individual game write
directories, reports, staged scripts and logs are under repository
`build-theatres/air/`; build snapshots are pinned separately from that output.
The data evolved between tests; rows below state which behavior each proves.

## Results

| Run / archived log directory | Profile / faction | Result and observed behavior |
| --- | --- | --- |
| `capacity-final/runs/20260930-121623` | balanced / Cortex, build-03, 50 min | PASS `air_capacity`: T2 at 9.49 min; 20 live nanos on a T2 bay by 14.8; six T2 plants at 38.1; eight by 50. Wave of 300 bombers/52 escorts launched at 42.33. Four real nano deaths at frame 18032, followed by rebuilt support. |
| `natural-final/runs/20260930-121215` | hard / Armada, build-03, 40 min | Opening/safety checks PASS, but diagnostic economy stalled in T1. This exposed missing owned-order recovery and transition priority; it is not accepted transition evidence. |
| `natural-v8/runs/20260930-122309` | hard / Armada, build-04, 45 min | PASS opening/safety; no injections. T1 at 3.6; scout order 4.2; fighter order 4.5. T2 ordered at 30.20, completed 31.79; 11 T2 mexes completed; five starter nanos and eight T2 support nanos. AFUS under construction by 39.75, not completed before stop. |
| `switch-final/runs/20260930-120731` | terrible / Legion, build-03, 12 min | PASS: AIR→TECH at 3 min, TECH→AIR at 6, AIR→FRONT at 9. No script, crash or invariant violations. |
| `transport-final/runs/20260930-121802` | balanced / Cortex AIR with allied TECH and SUPPORT, build-04, 15 min | Both deliveries verified; overall FAIL because TECH invariant forbids remain enabled. See below. |
| `tech-fixed-old/runs/20260930-114009` | balanced / Cortex TECH, baseline, 8 min | FAIL INV-001. Pinned baseline already has failures. |
| `tech-fixed-new/runs/20260930-114310` | balanced / Cortex TECH, build-02, 8 min | FAIL INV-019. Same initial `chain.next` commander/input trace; later timing differs. |
| `tech-final/runs/20260930-122036` | balanced / Cortex TECH, build-04, 8 min | FAIL INV-004; no compile/crash errors. No AIR policy or AIR layout activation. |
| `attack-final/runs/20260930-122601` | balanced / Armada, build-04, controlled sortie, 8 min | Diagnostic FAIL: bombers launched and damaged enemies, but absent ground intelligence still selected map centre. The final policy additionally treats an unobserved ground front as a fallback condition. |
| `legion-capacity/runs/20260930-122929` | terrible / Legion, build-04, 50 min | Six T2 at 29.4 min, ten by 50; multiple 20-nano banks; four induced nano losses and replacement. Wave 300 bombers/342 escorts launched at 45.15. Overall FAIL solely because the shared check required launch by 44; no script/crash/invariant violation. |
| `attack-v2/runs/20260930-122824` | balanced / Armada, build-04, controlled sortie, 8 min | PASS: 24 bombers launched at 0.43 toward participating enemy start (10129,541); bomber damage began at 1.53 and captured 6,922 damage across 32 events. One observer-hook gap at 1.64 was detected and restored. |
| `legacy-final/runs/20260930-123915` | balanced / Cortex, build-04, AIR feature disabled, 8 min | PASS: T1 plant completed at 1.27; new layout stayed disabled; no script/crash/invariant failures. |
| `natural-v9/runs/20260930-123950` | hard / Armada, build-04, 55 min | Opening/safety PASS but no T2: the 12-by-12 coastal placement search exhausted useful energy candidates. Final `AirLayout::Place` expands across 24 rings/samples and uses per-definition retry backoff. |
| `natural-v10/runs/20260930-124635` | hard / Armada, build-04, 55 min | FAIL reactor deadline at 54; T2 completed 33.85, first T2 mex 37.11, AFUS still under construction at stop. No script/crash/invariant failures; captured T1 fighter damage 30,209, T2 fighter 70,019 and bomber 1,084. This prompted ordinary fusion before first AFUS. |
| `natural-extended/runs/20260930-125936` | hard / Armada, build-04, 70 min, before fusion-first change | FAIL reactor deadline; T2 38.19, first T2 mex 39.73. T2 plant lost 53.55 and replaced 59.70; replacement lost 67.70, commander 67.85 and remaining base destroyed. First AFUS frame was destroyed before completion. No script/crash/invariant violation. Extending the game did not establish reactor completion or a competitive win. |
| `natural-fusion/runs/20260930-130217` | hard / Armada, build-04, final policy, 60 min | T2 36.87, first T2 mex 38.22, ordinary fusion 56.13; 14 upgraded mexes completed and ten support nanos on T2. FAIL only the unchanged 54-minute reactor deadline (2.13 min late). No script/crash/invariant violation or observer gap. |

Legion needed the full escort ratio against substantial observed enemy air;
Cortex's wave needed fewer escorts. The 44-minute deadline is left unchanged
and its miss retained, rather than retroactively calling that scorecard green.
The final natural run also includes bounded T1 builder growth and the expanded
economy placement search. Its `air_transition` check requires actual T2, mex
upgrade and reactor completion, rather than only an opening.
The first AFUS admitted from a large metal bank took too long for AIR's small
construction crew. The final policy requires completed reactor income before
AFUS, choosing ordinary fusion first; unfinished frames do not satisfy the gate.
That change completed a reactor in the final game but did not meet the existing
timing benchmark; KI-436 retains the remaining performance work.

### Transport priority

The fixture uses the real allied `AiSendMessage` protocol, calling
`Ferry::RequestTransport` plus a duplicate at one minute from TECH and SUPPORT.
It changes only staged test scripts. AIR team 0:

| Event | TECH team 1 | SUPPORT team 2 |
| --- | --- | --- |
| Request admitted | frame 1802 | frame 1803 |
| One `corvalk` ordered | frame 4385 | frame 6353 |
| Finished transport | frame 5238 | frame 7206 |
| Arrived and transferred | frame 5610 / 3.12 min | frame 7650 / 4.25 min |

Exactly one order and one transfer were logged for each requestor despite
duplicates. The first plant's first order was the owed transport. Its current
recruit can finish before the next obligation. This proves FIFO for one AIR
provider with two requestor roles, not provider election across allied AIR
teams (KI-219).

The combined run reports TECH INV-001, INV-019 and INV-008. One INV-001 credits
a transferred `armatlas` to a retiring factory; production/transfer logs show
it came from AIR (KI-435). Other TECH findings remain KI-427. No forbid was
removed or scoped away to produce a green scorecard.

### Economy, losses and attacks

The natural 45-minute game finishes at approximately +164 metal/+801 energy,
with an advanced reactor still being built. Its 0.5-second observer samples
recorded no bank below one resource unit, although AIR's more conservative
energy recovery state was entered during T2 growth. Fighter damage was 42,495
from T1 and 750 from T2 in captured events. This establishes continued combat
and a funded transition, not an optimized competitive transition time.

The final 60-minute game built 121 T2 fighters and 24 T2 bombers, with observed
fighter damage of 38,274 from T1 and 117,184 from T2. No bomber damage was
captured in that game; the controlled attack fixture proves outbound bombing.
The last complete resource sample at 60.17 minutes was +140.6 metal/+2,285.9
energy, with no sampled zero-resource interval. A trailing partial log record
is ignored by the summarizer. Ordinary fusion completed and AFUS was then under
construction; natural growth beyond one T2 plant was not established here.

Capacity fixtures give two T2 constructors, 36 AFUS, 80 advanced converters and
storage. They test construction/support when supplied, not natural growth.
Cortex observed 150 completed nanos, four induced losses, multiple 20-nano
banks and eight completed T2 plants. Twenty ordinary nanos plus the factory
provide 4,600 physical work/second. No script/crash/invariant failure was logged
and sampled banks never reached zero.

Damage and wave intent are distinct. Cortex captured fighter/heavy-air damage,
but its damage hook was replaced at 14.72 minutes; it cannot prove later bomber
damage. The final observer reinstalls its hook and reports coverage gaps. It
forwards the complete engine call-in because BAR's widget dispatcher omits
attacker arguments. Damage totals are lower bounds over captured events of
at least 20 damage, excluding EMP.

First idle is measured only after factory completion and separately from
subsequent idle and the previous unit's construction time. These are 0.5-second
samples of effective behavior, including scheduler latency, not isolated
engine animation measurements. Earlier cold observations included factory
construction and must not be used for calibration. The configured warm-gap
prior remains 0.5 seconds; no universal optimum or automatic adaptation is
claimed.

With sampled banks above 500 metal and 1,000 energy, `natural-v10` recorded two
first-idle observations (median 1.0 s, maximum 1.5 s) and 389 subsequent gaps
(median 2.0 s, maximum 115.5 s). Legion's supplied-economy run recorded 11 first
gaps (median 44 s) and 1,065 subsequent gaps (median 4.5 s). Sub-0.5-second
observations were conservatively binned at 0.5 s. These include policy waits,
unit quotas and scheduling; full banks alone do not isolate the animation.
They show why the 0.5-second model prior still needs calibration (KI-220),
not that a Legion air pad intrinsically takes 44 seconds to start.

## Executable checks

`tools/run_native_tests.sh` passed the native and AngelScript suites. After
adding the strict map-edge case, the AS runner passed all 28 tests executing
the actual `production_math.as` through vendored AngelScript. Native results
were 76 layout-ranking checks, base geometry tests and eight lane-solver suites
including concurrent solvers.
AS cases cover throughput, mixed batches, invalid inputs, funding, support
limits, bay offsets, map bounds and six/eight/twelve-plant capacity admission.

The DLL registration check covers 239 used members with zero findings. Role
docs and invariant-practice checks pass. Unit-helper validation retains the
two pre-existing TECH sonar reachability findings (KI-425); the informational
`armdfly` combat-list gap is unchanged. Documentation links retain eight
pre-existing links to the missing hover document (KI-404).

TECH policy files, layout/eco planner, all JSON profiles and `data_sample/`
have an empty diff against the planning baseline. Native additions are new
observations/reservation methods and an opt-in flying-builder approach flag
defaulting false. Shared dispatch changes are AIR-gated. Exact game trajectory
equality is not claimed: the same engine seed does not fix every native worker
or random timing source, and baseline games already violate TECH invariants.
No TECH behavior was changed to hide those failures.

## Reproduction and limits

Use `stage`, `prepare_air_check.py --scenario natural|loss|transport|switch|attack`,
`launch --headless`, then `watch --role AIR --checks <name> --keep-going`.
Pin DLL, game/map/profile/faction, an absolute isolated directory and bounded
game/wall times. The watcher must receive `--role AIR`; its TECH default
otherwise misses team 0. Run the script API check before launch.
`summarize_air.py <log> --output <json>` produces observed counts, states,
per-bay peaks, transport events and damage without changing verdicts.

Remaining limits: no complete save/load round trip (KI-209), exhaustive
all-map/poor-wind/content-option matrix, repeated PvP win-rate comparison, or
0–40-nano saturation matrix for every faction and mix. This capacity policy
fills funded useful support up to 20 then adds bays; it is not the proposed
global marginal-capital optimizer. Floating/seaplane campus templates and
dedicated naval reactor precincts are not introduced. Capabilities remain
checked at every order; non-air factories retain native production fallback.
Broader TECH refactoring is deferred to protect current behavior.
