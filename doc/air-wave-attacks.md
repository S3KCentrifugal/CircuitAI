Experimental AIR now uses [D-171 committed operations](air-committed-operations-plan.md):
offensive sorties keep attacking, all available fighters escort them, and
income gates bomber production. The historical modes and return behavior
below remain available to legacy callers.

# Air wave attacks

**D-162 experimental AIR override.** The legacy description below applies to
`ExperimentalBuild=false`. Enabled AIR uses home staging routes, ordinary
lethal bomber pools and the [D-163 campus/mission policy](air-campus-strike-design.md).
The first T2 wave draws once from a configurable 10-20 range after two completed
AFUS. Later sorties use target health and padded corridor risk; the eight-aircraft
minimum never waives that requirement. A separate income/energy/build-power
funded reserve keeps production ahead of sorties.
After sortie completion, heavy losses increase a saved resistance multiplier
(bounded at 3 by default); good survival relaxes it. A below-25% survival raid
excludes its 640-elmo target region for five minutes, with up to eight regions.
These are AIR settings, not fixed native priorities. Temporary region memory
resets on role initialization; the learned multiplier is saved.
Three reusable T1 bombers can form an independent raid. Requested transports,
required crews and emergency defense precede discretionary strikes.

Native flight-policy opt-in bounds fronts to 1,320 elmos, with 180-elmo lanes
and 240-elmo ranks. Slots are assigned nearby after the joining window. Arrival
is latched within 600 elmos and cleared outside 1,200 to accommodate fixed-wing
orbits; 80% must be ready. The timeout allows distance/speed transit plus the
script's settling time. Incomplete assembly returns home. Target selection includes economic enemy
data, estimates health feasibility and samples the entire route. Actual
lethal weapon release (or an attributed lethal hit for scripted beams), target disappearance, pass completion and a 35% loss
threshold control return to staging. Returned survivors remain in the
immutable evaluation cohort. This does not change static AA behavior.

Phoenix budgeting inspects its lethal heat-ray mount rather than its zero-damage
targeting/sound mounts. Its nominal sweep upper bound still uses the configured
pass fraction; release observations never assume that every sweep tick hits.
See [measured results](air-enhancement-results.md) for faction-specific evidence.

EMP timing, Liche pairs, coordinated target reservations, fighter sweeps and
radar-plane missions remain in the [reviewed plan](air-enhancement-review.md).


**D-147 update.** Enabled AIR reserves a separate home-fighter cohort before
wave holds. `WaveAvoidHomeFocus` selects the nearest participating enemy start
when no ground opposition is observed or the combat focus is absent/near home.
An explicit STRIKE/DEEP target still overrides that fallback. This avoids
carpeting the home runway in an AIR duel without changing TECH or the six wave
methods. The [controlled sortie](benchmarks/air-management.md) launched 24
bombers and independently observed their damage to enemy targets.

How an AIR-role T2 bomber wave is sized, how it forms up, and the six
methods it attacks with. The hold-and-release machinery that gathers a wave
is in [`roles/air.md`](roles/air.md#t2-bomber-waves); target ranking for the
native bomb task the survivors fall back to is in
[`bomber-targeting.md`](bomber-targeting.md).

Decision: [D-045](decisions.md#d-045--bomber-waves-scale-with-income-form-lines-and-attack-by-one-of-six-methods).

## Contents

- [Wave size](#wave-size)
- [The run](#the-run)
- [Attack methods](#attack-methods)
- [The attack vector](#the-attack-vector)
- [Native task](#native-task)
- [Configuration](#configuration)
- [Logs](#logs)
- [Known limits](#known-limits)

## Wave size

A wave launches when the hold has `Required()` bombers (and the escort
`FightersFor(Required())`, or the hold timed out):

```text
incomeFloor = floor(minMetalIncome10s / BomberWaveIncomeStep) x BomberWaveSizePerIncomeStep
Required    = min(max(nextWaveSize, incomeFloor), BomberWaveMaxSize)
```

With the defaults (100 / 50): at +100 metal a wave is at least 50 bombers,
at +200 at least 100, at +300 at least 150. `nextWaveSize` is the survival
growth from the previous wave (unchanged, see `roles/air.md`), so a wave
that keeps losing bombers can still be larger than the floor; it can never
be smaller. Production (`MakeProductionTask`) builds toward the same
`Required()`.

## The run

Every bomber of the launched wave is given one native `CAirWaveTask`
carrying the plan; escorts fly `TaskF::Guard` on the wave's bombers as
before. The task runs one state machine:

| State | What happens | Ends when |
| --- | --- | --- |
| FORMING | Each bomber is dealt a slot on a line abreast at the stand-off point, perpendicular to the attack vector, `WaveLaneSpacing` apart, and flies to it | 75% of the living wave is within 128 elmos of its slot, or `WaveFormTimeoutSeconds` |
| HOLDING | (FEINT only) the formed line waits | `WaveFeintHoldSeconds` |
| ATTACKING | Carpet: every bomber attack-moves down its own lane, through the aim and `WaveOverrun` past it, so the wave releases on what it crosses and keeps going. Strike: every bomber attacks the chosen unit | Half the wave is past the aim (carpet), the target is gone (strike), or 150 s |
| DONE | The task aborts itself; each survivor is handed the native bomb task **once** (`mopUp`) for the leftovers, then rejoins the hold | - |

Bombers do not scatter when hit (`OnUnitDamaged` is a no-op); a formation
exists not to. A bomber that goes idle mid-run is re-issued its order.

## Attack methods

Each launch draws one method by the `WaveWeight*` weights (a weight of 0
removes a method). The point of the mix is that a human cannot set up for
the last wave's approach.

| Method | Aim | Approach | Shape | Surprise value |
| --- | --- | --- | --- | --- |
| **CARPET** | the combat focus (`GetCombatFocusPos`) | straight along base -> aim | one line, lanes parallel to the base->front line | the default: mass through the front |
| **FLANK** | the combat focus | rotated `WaveFlankMinDeg..MaxDeg` (55-95) to a random side | one line | the front's AA faces the wrong way; the line crosses the front sideways |
| **PINCER** | the combat focus | two lines at +/- `WavePincerDeg` (45) | two lines, bombers dealt alternately | AA must split; the two carpets cross behind the front |
| **STRIKE** | one unit: the highest-cost static >= `WaveStrikeMinStaticCost` or a T3 (`heavy`) mobile, value discounted by distance from our base | the quietest of 12 sampled bearings (threat map) | one line, then every bomber attacks the unit | a fusion, AFUS, LRPC, nuke or Titan dies to one pass; the bearing avoids the AA belt |
| **DEEP** | the qualifying static **farthest from our base** | quietest sampled bearing | one line, then attack the unit | the rear economy, not the front |
| **FEINT** | the combat focus | straight | one line, **held on the line** for `WaveFeintHoldSeconds` | the enemy pulls fighters and AA to the formed line; the carpet comes when they have committed |

STRIKE and DEEP fall back to CARPET when nothing qualifies, and log why.
Survivors of every method mop up with the native bomb task, whose FOCUS /
AREA target ranking is `bomber-targeting.md`.

## The attack vector

`ComputeLines` in `CAirWaveTask`:

1. `baseDir` = unit vector from our base position to the aim.
2. The bearing is `bearingDeg` rotated from `baseDir` (CARPET 0, FLANK
   +/-55..95, PINCER +/-45 for the two groups, FEINT 0). `999`
   (`Task::WAVE_SMART_BEARING`) means **sample**: 12 bearings around the
   aim, threat read at the stand-off point and at the midpoint of the
   run-in for a bomber of the wave (`CThreatMap::GetThreatAt` after
   `SetThreatType`), lowest total wins, ties toward frontal. A bearing that
   is quiet at range but crosses a battery is therefore not chosen.
3. For each group: `dir` = the bearing's unit vector (direction of travel);
   line centre = `aim - dir x WaveFormDistance`; slot `k` of the group sits
   at `centre + perp x lane(k) x WaveLaneSpacing`, lanes dealt 0, +1, -1,
   +2, -2 ... so any wave size centres on the line; end point of lane `k` =
   slot + `dir x (WaveFormDistance + WaveOverrun)`. The lanes are parallel,
   so the attack-move is a carpet of width `(n-1) x spacing` through the
   aim.

## Native task

`CAirWaveTask` (`src/circuit/task/fighter/AirWaveTask.h/.cpp`),
`IFighterTask::FightType::WAVE`, made by `aiMilitaryMgr.Enqueue(TaskF::Wave())`
and cast with `cast<CAirWaveTask>(cast<IFighterTask>(t))`. Script API:

```angelscript
void SetPlan(int mode, const AIFloat3& in aim, float formDistance, float spacing, float overrun,
             int formTimeout, int holdFrames, float bearingDeg, int groups);
bool PickStrikeTarget(const AIFloat3& in from, int preference, float minStaticCost, bool includeHeavy);
int GetState() const;         // PLANNED 0, FORMING 1, HOLDING 2, ATTACKING 3, DONE 4
int GetMode() const;          // Task::WaveMode
AIFloat3 GetAim() const;
int GetStrikeTargetId() const;
float GetBearingDeg() const;  // the bearing actually used
int GetFormedCount() const;
```

`Task::WaveMode` is `CARPET 0, FLANK, PINCER, STRIKE, DEEP, FEINT`
(`task.as`), the same numbers as `CAirWaveTask::EMode`. Membership is the
script's: `CanAssignTo` accepts any flying unit.

## Configuration

`Global::RoleSettings::Air` (`data/script/src/global.as`):

| Setting | Default | Meaning |
| --- | --- | --- |
| `BomberWaveIncomeStep` | 100 | metal income per size step |
| `BomberWaveSizePerIncomeStep` | 50 | bombers added to the floor per step |
| `WaveWeightCarpet` / `Flank` / `Pincer` / `Strike` / `Deep` / `Feint` | 3 / 2 / 1 / 2 / 1 / 1 | draw weights |
| `WaveFormDistance` | 1400 | stand-off from the aim to the line, elmos |
| `WaveLaneSpacing` | 96 | between lanes, elmos |
| `WaveOverrun` | 900 | the lanes run this far past the aim |
| `WaveFormTimeoutSeconds` | 45 | attack anyway if the line is not formed |
| `WaveFlankMinDeg` / `WaveFlankMaxDeg` | 55 / 95 | FLANK bearing range |
| `WavePincerDeg` | 45 | PINCER: each line this far off the base->aim line |
| `WaveFeintHoldSeconds` | 25 | FEINT: hold on the formed line |
| `WaveStrikeMinStaticCost` | 2500 | STRIKE/DEEP: statics at or above this qualify (T3 mobiles always) |

## Logs

Script, level 1: `[AIR][Waves] Wave N launched (target 100 reached (income
floor 100)) ...`, `[AIR][Waves] Wave N method=FLANK aim=(x,z) bearing=-72
bombers=100 standoff=1400 spacing=96`, `STRIKE: no qualifying target ...;
carpeting the front instead`, `Wave N run over; survivors mop up on the
native bomb task`. Native, unconditional: `WAVE: strike target armafus(id)
cost 9000 at (x, z), preference 0`, `WAVE: carpet lines ready: aim (x, z)
bearing +0 deg, 1 group(s), stand-off 1400, spacing 96, 100 units`,
`WAVE: line formed with 87 of 100 after 31 s; attacking`, `WAVE: hold over
after 25 s; attacking`, `WAVE: run over (half the wave is past the aim)
with 63 survivors; releasing to native bombing`.

## Known limits

1. **Not Played.** The geometry, the state machine and the mop-up hand-off
   have not been run in a match.
2. **The line is flat.** Slots are on one line at one altitude; a wave
   larger than the front is a wide line, not a column of lines. `PINCER` is
   the only multi-line method.
3. **Escorts are not part of the formation.** Fighters guard individual
   bombers as before, so they arrive with the line but do not hold a
   position in it.
4. **The aim of a carpet is one point.** `GetCombatFocusPos` is the AI's
   own combat focus; with no combat it is the map centre.
5. **Strike targets are chosen by cost and mobility**, not by what the
   bombers can kill in one pass; the native bomb task's kill-feasibility
   test applies only to the mop-up.
