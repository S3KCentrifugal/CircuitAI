# AIR plan review and implementation contract

2026-10-01. Reviewed against CircuitAI `75e1056b`, BAR `1d267c20d1`,
Recoil `92efda5e60`, and the installed simulation game recorded in each run.
This is the implementation contract for [the proposal](air-enhancement-plan.md).
It is written before production changes. Proposed constants are tuning inputs,
not established PvP optima.

## Evidence audit

| Findings | Verdict and correction |
| --- | --- |
| A1–A3, A11 | Confirmed ordering/measurement defects. Home quota blocks strike allocation; all observed aircraft veto strikes; adding overlapping role costs double counts. Use unique enemy IDs and actual weapon domains. Armed fighter/scout hybrids must still count. A contact being harmless does not mean it should be ignored by interceptors. |
| A4–A6 | Confirmed launch and accounting defects. Timeout retains the same bomber minimum; returned aircraft disappear from the live-wave ledger; loss-driven multiplication always grows. Keep a launch cohort separate from current task ownership and use a funded, bounded schedule. Never equate returned units with dead units. |
| A7 | The 20-turret gate is intentional and retained. The cited 31–37 minute T2 timings predate later fixes. D-148 final runs reached T2 around 10–12 minutes and fusion around 19–20 minutes; D-155 already built a second lab. KI-442 explicitly records demand exceeding energy supply. A metal bank alone does not prove a factory bottleneck. |
| A8 | Confirmed: general DEFEND tasks may select the front. Use owned fixed staging routes with explicit fire/idle state and restore state when ownership changes. Test real held-unit positions and damage, not only assignment logs. |
| A9–A10 | Correct roster/grouping limits, but Legion Mosquito is a gunship and Martyr is a suicide aircraft. Do not relabel either as an ordinary reusable bomber. Start with separate ordinary T1/T2 bomber groups; specialist packages need separate pass/EMP evidence. |
| F1–F2 | Width grows as `(n-1)*spacing` (50 at 96 = 4,704 elmos). Bounded ranks are appropriate. Nominal 180 spacing is a candidate, not a guarantee against shared flak damage: collision volumes, vertical separation and actual flight paths matter. |
| F3–F5 | Wanted-speed wrapper is inactive and arrival-order slots are poor. Do not promise speed matching from an unavailable command. Gate launch on an assembly region; bound ranks and stagger departure for different aircraft types. Point-hover assumptions do not hold for fixed-wing aircraft. |
| F6–F11 | Confirmed limitations of two-point bearing samples, random method, own-squad focus, single-target overkill, escort pursuit, absent abort/egress, and unrestricted mop-up. Full route exposure matters; an apparently safe stand-off behind enemy defenses is not a safe route. Use enemy contacts, cost/health feasibility and explicit return ownership. |
| Additional finding from first combat test | `PickStrikeTarget` scans only `GetHostileDatas`, excluding peaceful economic structures held in `GetPeaceDatas`. The first supplied T1 fleet stayed parked despite solar/wind targets; T2 launched as soon as flak appeared. Include both known snapshots for experimental strikes, preserving the legacy scan. This is a target-discovery bug, not a lack of bombing resources. |
| F12 | Explicit aircraft state control is needed. Changing static AA to return-fire without a targeting controller would suppress useful fire against passing bombers; reject this change. Other static weapons remain untouched. |
| F13 | Opening-only scouting is insufficient. Replace lost scouts on a bounded budget and gather fresh contact evidence. Unknown territory is not proven clear. Radar support must remain useful without relying on omniscient fixture vision. |
| G1–G2 | Gadget priorities and negative long-range distance factor are present in the pinned sources. They are conditional automatic-target preferences, not guarantees of locks, free escort shots, or empty stockpiles. Enemy commands, projectile travel, reload and mixed contacts matter. Scout bait remains an experimental fixture, not a required production tactic. |
| G3–G4 | Flak is an area threat. Stiletto's 6,000 EMP and 20-second weapon cap do not guarantee 20 seconds of stun on every tower: actual damage/falloff, max health, resistance and EMP decay determine duration. Keep EMP separate from lethal damage. |
| G5–G8 | Released projectiles can still land after aircraft death, but preserving survivors matters too. Turn/release geometry depends on loaded definitions and terrain. Landed aircraft remain targetable by AA and ground LOS/radar; landing is not invisibility. |
| G9–G14, appendices | Treat raw damage, healing, explosion and patch values as source-specific inputs. Raw burst damage is an upper bound, not a measured single-target pass. Liche commander damage differs. Legion Phoenix needs an actual firing-pass measurement. Do not infer fleet kill counts or universal survival from these tables. |

The claim that no natural wave has *ever* launched is unsupported by a finite
set of archived runs. The old cited run establishes only that that run produced
121 T2 fighters, 24 bombers and no captured bomber damage. Current-head natural
baseline and matched reruns are required.

## PvP interpretation

The official [air warfare guide](https://www.beyondallreason.info/guide/basics-of-air-warfare)
supports energy-heavy production, team scouting/transport duties, fighter
screens, and flak-aware formations. Its discussion of bait-resistant manual
AA control does not justify disabling automated fire. The official
[early raids guide](https://www.beyondallreason.info/guide/early-air-raids)
supports scouting first, selecting exposed economy, allocating bombers by the
target and treating the first pass as decisive. Its 500-energy recommendation
describes a land-to-air transition, not a requirement to delay this dedicated
AIR role's opening scout or emergency fighters. Guide bomber counts are
illustrations; loaded unit stats and measured passes take precedence.

## Decisions and protected behavior

1. Keep TECH's build/reclaim rules, shared layout reservations, transport-first
   admission, the three-constructor opener, mex-before-fusion, home economy
   bounds, and 20 completed turrets per existing T2 factory unchanged.
2. Do not replace a 60-fighter ceiling with an arbitrary 25-fighter ceiling.
   Keep an emergency home floor, then share funded discretionary production
   between air control and strikes. Threat growth may require large screens.
   Count other-tier defenders by value, not as equivalent aircraft.
3. Reject the proposed share arithmetic: its examples do not match its
   equations and counts are not resource shares. Use a deterministic bounded
   interleave, explicitly described as order allocation; separately constrain
   sustained metal/energy funding. During a serious home deficit defense wins;
   no guaranteed bomber minimum overrides an ongoing emergency.
4. Do not impose a blind 30-second end to raid defense. Unarmed scouts do not
   veto bomber production, but one lethal bomber near the core still matters.
   Compare armed intrusion value with available home defense.
5. Replace income-floor and loss-multiplier launch blockers for experimental
   AIR only. Plan small feasible first sorties and gradual growth bounded by
   actual available resources/build power. A deadline makes an eligible sortie
   due; it never invents a target or waives required escort safety.
6. A funded rate is `min(factory rate, metal budget/costM, energy budget/costE)`.
   For a 18,500-energy Hailstorm, 1,964 E/s at a 65% production share funds at
   most 4.14 per minute before other aircraft consume that share. More factories
   cannot remove that bottleneck. Count queued commitments and construction
   needs before increasing production, staffing or reactor demand.
7. Reuse native route/wave tasks via opt-in controls. Default native tasks and
   static weapon state remain unchanged. All tactical thresholds stay in script
   or configuration; pure geometry/selection helpers receive explicit inputs.
8. Stage, assemble, attack, egress and return are distinct ownership states.
   Maintain an immutable cohort for each evaluation. Do not launch a second
   cohort over the bookkeeping of one still in flight. No automatic native
   mop-up after an experimental sortie.

## Implementation order and acceptance

### A. Measurement, production and ownership

- Add unique observed armed-air and armed-contact queries without changing
  existing generic enemy-cost consumers. Correct Stormbringer's erroneous
  experimental air-threat classification, retaining its lethal surface weapon.
- Extract tested pure functions for shares, defense deficit, funded wave size,
  cadence and finite formation geometry. Transport and emergency crew/fighter
  work precede discretionary allocations.
- Fix independent survival history and bounded home staging. T1 reusable
  bombers get their own small raid pool. ISR replacement and specialist support
  must not starve constructor recovery, fighters or requested transports.
- Log decision reasons, desired/actual counts, M/E funding, queue and held
  counts so economy/combat coupling is inspectable.

### B. Controlled strike execution

- Add opt-in aircraft state control and bounded rank geometry. Explicitly
  restore task-owned settings on removal/role change.
- Score known enemy targets, assembly/ingress/egress exposure, and feasible
  loaded damage. Do not aim carpets at allied ground leaders. Use observable
  target disappearance, pass completion and loss thresholds to return survivors.
- Verify target contact availability, finite positions, map bounds, damage,
  casualty accounting, hold safety and actual formation spread in rendered
  early, mid and late fixtures. Test Armada, Cortex and Legion separately.
- Specialized EMP, Liche, bait and multi-element time-on-target tactics follow
  measured pass calibration. They must not be advertised as implemented merely
  because a roster or table names them.

### C. Economy and comparative games

- Retain a current-head, fixed-seed, zero-handicap baseline. Then repeat with
  matching map/game/factions/opponents and changed AIR only where feasible.
- Report windows 0–10, 10–25 and 25–50 minutes: income, energy shortage, full
  metal duration, construction/production work, lab/nano/constructor counts,
  fusion timing, completed aircraft, sortie cadence, damage and losses.
- Run gifted-constructor and sustained late-capacity fixtures separately from
  natural economy. Their spawned assets cannot count as natural milestones.
- Show screenshots while running. Preserve every failed run and invariant.
  Fix regressions before interpreting better combat output as an improvement.
- Run pure/native tests, runtime script compilation, API/DLL parity, invariant
  and documentation checks. Publish matching DLL/debug/data to the mandated
  engine build output, then commit locally. No push per the owner's latest
  preference.

## Evidence boundary

The build-08 natural game still had no fusion after 34 minutes despite finishing
its owned mex upgrades at 15:06. Continuous production kept the bank below an
additional 500-metal threshold. Remove that redundant first-reactor threshold:
the existing conservative 180-second metal/energy funding checks, committed
construction costs, recovery veto and completed-mex requirement remain. A
healthy income must be able to fund its first reactor while factories operate.
Repeat the natural and donated-constructor cases; a funding projection alone
does not establish the 20-minute completion target.

The Legion fixture found two additional failures. Mosquitos inherited generic
DEFEND admission and never raided unarmed economy before flak appeared; assign
this light gunship to the existing threat-aware native RAID task under AIR only.
Phoenix's representative mount can be a zero-damage targeting/sound weapon.
Strike budgeting must inspect its loaded lethal mounts without changing global
UnitDef/static classification. The pinned Phoenix script emits its heat ray
once per simulation frame for `sweepfire_firetime`; use that nominal upper bound
with the existing conservative pass fraction, then measure actual damage. This
is not a claim that every sweep tick hits one target. The heat-ray definition
lists 17 energy per shot, but that is not proof of a charge per emitted tick:
the pinned COB `EmitSfx` path calls `CWeapon::Fire(true)` directly, bypassing
`UpdateFire`'s resource deduction. The fixture's bank stayed full during sweeps.
Do not budget an assumed 17 energy per scripted tick; aircraft construction
energy remains real. The official
[Phoenix reference](https://www.beyondallreason.info/unit/legphoenix) confirms
the strafing heat-ray role; the pinned script defines the actual mechanics.
The repeated Legion fixture then demonstrated real heat-ray damage but no
weapon-fired notification for the script-emitted beam. Use a positive,
non-paralyzing enemy-damage event attributed to an owned wave aircraft as a
second release observation. Keep the first observation only, so conventional
bombers retain their earlier weapon-fired timing. This prevents a confirmed
Phoenix attack from immediately U-turning when its target dies; it does not
infer a shot from an attack command or alter any static weapon controller.

Controlled Cortex runs exposed a further assembly error: a single 45-second
deadline included transit from home to a flanking assembly point. The native
opt-in now adds the slowest assigned aircraft's distance/speed transit estimate
before applying the script's settling allowance. Arrival is latched inside
400 elmos and cleared outside 800 to accommodate fixed-wing orbits; the 80%
readiness requirement and loss abort remain. This requires rendered verification.

The final Armada fixture still failed late assembly (10 of 18 ready after
75 seconds). Recoil's fixed-wing controller explicitly warns that the UnitDef
turn radius can be much smaller than a plane's actual turning circle. Test a
600-elmo arrival region (about 2.3 seconds of Blizzard flight) with the existing
80% quorum, unique bounded slots, transit allowance and loss abort unchanged.
This is a rendezvous tolerance, not a claim of point-hover precision. Keep the
failed 400-elmo run and repeat the identical three-stage checks before adopting
the setting.

The matched candidate reproduced KI-443: flying constructors receive hundreds
of idle callbacks while attached to existing wind frames. Releasing the worker
after exhausted retries was tried and rejected: workers reselected the same
task. Correlating IDs with observer completion events revealed that frames 5583
and 165 were already complete. Multiple construction tasks can adopt one frame;
only the registered owner receives completion. Under AIR's existing
`experimentalAirDirect` opt-in, finish the registered owner once and retire
duplicate construction owners on the completion event. Preserve the building;
do not rerun its build chain for duplicates. TECH retains the existing path.
Verify workers move on to useful new construction, with no stale-task loop.

Passing controlled encounters establishes capability. A few AI-versus-AI
matches establish behavior under those conditions, not unbeatable human-PvP
strength or a global optimum. Benchmark confidence requires repeat seeds,
factions, maps, human opponents and equal resources. Report actual improvements,
regressions and unfinished specialist work explicitly.

The final benchmark audit found that earlier natural/gift/capacity fixtures
pinned only `FixedRNGSeed`; CircuitAI's separate `random_seed` fell back to wall
clock. The controlled strike fixtures also lacked explicit seeds. Preserve
their observed results but do not claim reproducible paired comparisons.
Both fixture preparers now pin engine and AI RNGs; new strike fixtures record
seed and assembly override in their manifest. Repeat final calibration with
explicit seeds, and use multiple seeds for any later strength comparison.

The capacity fixture's opening observer reported INV-079 at frame 690 because
a supplied advanced constructor framed the T1 plant while the commander still
had its earlier mex order (issued at frame 521). The observer only began command
tracking after the factory existed. Track the pre-factory command as well, so
an unchanged earlier order is not mislabeled as a new one. Keep every new
post-factory mex command forbidden, preserve the failed run, and repeat the
capacity fixture. This corrects observer chronology, not production policy.

### Final formation calibration

Armada case 13 and seed-1621 case 14 passed the unchanged three-stage checks
at radius 600. Adopt 600 in script, retaining 80% readiness, 180-elmo lanes,
240-elmo ranks and the original travel-plus-settle deadline. This changes
arrival tolerance, not terrain or weapons. Cortex/Legion receive the same
seeded regression. The full fifty-minute natural case remains FAIL for
existing TECH invariants and brief constructor locality excursions (KI-460);
first fusion at 19:03 and four waves are measured outcomes, not full acceptance.
See [results](air-enhancement-results.md) for retained failure history.
