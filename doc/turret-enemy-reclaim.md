# Construction turret enemy reclaim

D-184, 2026-10-03. Implementation and verification record.

## Behavior

Every AI-controlled, completed construction turret that can reclaim gives
visible, reclaimable enemies in its build reach precedence over other AI
work. This includes land/floating variants, Extra Units and all roles/profiles.
Factories and mobile constructors retain their existing policies. Player
control remains authoritative. Enemy denial remains enabled at full metal
storage and while the economy is stalling.

The shared native factory manager checks its registered assistants every
15 game frames (half a second), staggered by AI ID. It retains a valid current
target, otherwise uses the engine's spatial query and chooses the closest
eligible enemy, with unit ID breaking distance ties. Role target preferences
do not exclude enemies, but actual LOS, current allegiance, neutrality,
reclaimability, death and the game's `ignoredByAI` flag are checked. Reach uses
the loaded turret's build distance, target model radius and its 2D/3D range mode.
The BAR roster uses the engine's default model-based buildee radius.

An enemy-mode static reclaim task uses priority NOW, replaces the engine
command immediately, and does not yield to resource fullness, repair,
friendly recycling or a `no_disrupt` factory binding. Ordinary commands are
not refreshed while that target stays valid. Idle/rejected commands are
revalidated with a one-second retry interval; target changes do not wait for
that retry interval. No mobile pursuit is ordered.

The task stores an enemy ID, not a borrowed pointer. Loss of visibility,
death, capture, leaving reach or disabling the policy releases the task and
stops its old command. The turret returns to normal role decisions. Assignment
removes the old manager's idle membership as well as its task membership,
including TECH turrets temporarily borrowed by Builder for recycling. Existing
static-task destruction, transfer and final-assignee cleanup is reused.

Policy controls are `economy.turret_enemy_reclaim` (default true for every
profile) and the runtime AngelScript property
`aiFactoryMgr.enemyReclaimEnabled`. `IUnitTask.IsEnemyReclaim()` identifies the
temporary exception to ordinary factory-duty and friendly-reclaim invariants.
No new save format is introduced: the temporary response is reconstructed
from current assistants and observations, like other native factory service
tasks. Save/load is not claimed verified by the fixture.

## Implementation and ownership

- [Factory manager](../src/circuit/module/FactoryManager.cpp) owns observations,
  admission and release; its [header](../src/circuit/module/FactoryManager.h)
  exposes the policy and diagnostic count.
- [Static reclaim task](../src/circuit/task/static/ReclaimTask.cpp) and
  [header](../src/circuit/task/static/ReclaimTask.h) own the enemy command;
  ordinary wreck reclaim is unchanged.
- [Task identity](../src/circuit/task/UnitTask.h),
  [assignment protection](../src/circuit/module/TaskModule.cpp) and
  [friendly-reclaim pull](../src/circuit/module/BuilderManager.cpp) preserve
  enemy priority. Player takeover can still replace it.
- [Factory bindings](../src/circuit/script/FactoryScript.cpp),
  [task binding](../src/circuit/script/InitScript.cpp) and
  [JSON](../data/config/economy.json) keep policy controllable from scripts/config.
- [Pure eligibility/range rules](../src/circuit/task/static/EnemyReclaimPolicy.h)
  have [standalone tests](../tests/enemy_reclaim_policy_test.cpp), wired into
  [CMake](../tests/CMakeLists.txt) and the
  [native test runner](../tools/run_native_tests.sh).
- The [shared economy callback](../data/script/src/manager/economy.as) reports
  INV-128 if an eligible response failed admission. The
  [TECH invariant checks](../data/script/src/manager/invariants.as) exclude
  active enemy reclaim from normal factory duty. See the
  [invariant register](invariants.md) and [actor matrix](actor-matrix.md).

## Reproducible supplied test

Allocate a new shared/combat/turret-enemy-reclaim directory with
`tools/playtest/storage.py`, then run
[prepare_turret_reclaim.py](../tools/playtest/prepare_turret_reclaim.py) with
`--dir`, `--dll` and `--profile`. Launch and watch that exact directory using
[turret_enemy_reclaim](../tools/playtest/checks/shared/combat/turret_enemy_reclaim.json).
The [widget](../tools/playtest/widgets/turret_reclaim.lua) supplies and damages
friendly repair sites, supplies enemy constructors (stationary storage targets
for legacy profiles), measures real engine
commands/health, and captures the first interruption. All modifications to
production policy are confined to the isolated staged copy and declared in
`turret-fixture.json`. This is a combat fixture, not a natural economy benchmark.

Required observations: all twelve variants repair first, interrupt within
2.5 game seconds of the supplied enemy, physically reclaim it, and resume
repair. No sustained same-target command spam, script errors or invariant
failures are accepted. Experimental cases exercise six successive role
handoffs; legacy profiles retain their native policy through six repetitions
(the phase labels do not switch legacy roles). The experimental fixture also
checks capture, neutrality, range exit and re-entry, turret removal and player
takeover. Its opponent is set to FRONT inside the staged script because the
local widget cannot change the opposing AI's role. Frozen TECH construction
would correctly violate the ordinary opening invariant after five minutes.

Run the watcher under the engine's owning account: a restricted process lookup
can otherwise falsely report an engine exit. Keep failed fixture runs; do not
replace their reports when adjusting setup geometry or deadlines.

## Results

Built and Played with Recoil 2026.07.04, BAR test-31479-433a460 and Supreme
Isthmus v1.7. Final stripped DLL SHA-256 prefix: `3ecbc2deecda41e7`.

| Profile | Result | Physical reclaim / return to repair | Evidence |
| --- | --- | --- | --- |
| experimental_balanced | PASS, 9 game minutes | 72 / 72 | [Report, hashes and screenshot](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/turret-enemy-reclaim/2026-10-04/20261004T005115Z-3979c9d5/README.md) |
| experimental_hard | PASS, 9 game minutes | 72 / 72 | [Report, hashes and screenshot](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/turret-enemy-reclaim/2026-10-04/20261004T005137Z-0fb8e491/README.md) |
| experimental_terrible | PASS, 9.5 game minutes | 72 / 72 | [Report, hashes and screenshot](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/turret-enemy-reclaim/2026-10-04/20261004T005339Z-a7e2a378/README.md) |
| hard (legacy) | PASS, 9.5 game minutes | 72 / 72 | [Report, hashes and screenshot](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/turret-enemy-reclaim/2026-10-04/20261004T005926Z-00846d17/README.md) |

All 216 experimental responses occurred with metal exactly at storage capacity.
The command observer saw 18–30 frames (0.6–1.0 seconds) from enemy spawn to
reclaim. Every target lost health, was fully reclaimed, and its turret returned
to repair. All six Extra Units variants were marked `no_disrupt` in the staged
script. Capture, neutrality, range exit/re-entry, turret destruction and player
control passed in each experimental profile. No fixture, invariant or script
failure occurred; no target exceeded the four-command failure threshold.
Legacy hard also completed 72 reclaims and repair resumptions at full storage.
Its fixture removes other initial units to prevent normal expansion/combat from
altering the supplied arena, while turret decisions remain entirely native.
The first legacy attempt, which allowed that expansion, is retained as FAIL;
it did not observe one fourth-repetition target being reclaimed. The other
legacy difficulties were not individually simulated. All four successful
records are indexed in the [shared benchmark catalog](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/index/shared.md);
the [machine-readable catalog](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/catalog.json) preserves older evidence.

The complete native test suite passed, including 20 new eligibility/range
checks. JSON/Python parsing, script/API parity (277 used members), invariant
practice and whitespace checks passed. The documentation checker still reports
the eight existing missing `roles/hover.md` links (KI-404). The storage migration
checker reports its documented pre-D-181 `air_build_power.json` hash mismatch
(KI-492); historical results and images remain unchanged.

Earlier setup attempts are retained locally under
`build-theatres/games/shared/combat/turret-enemy-reclaim/supreme/`. They exposed
too few water sites, insufficient time for supplied T2 targets, a too-short
repair acquisition interval, the frozen opponent's factory invariant, and an
invalid supplied lab position. These led to fixture corrections, not relaxed
production invariants. The final cases use T1 targets, fifteen seconds for
normal repair acquisition and the unchanged 2.5-second interruption deadline.

This establishes supplied local-defense behavior, not a PvP strength/FPS
benchmark or save/load validation. Interruption of repair and factory-bound
duty was played; interruption of every possible construction/guard/recycling
task is supported by the shared task transfer but not individually simulated.

The stripped DLL, matching DBG and active data were published together to
`C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`,
and API parity there passed. The live BAR installation was not modified.
