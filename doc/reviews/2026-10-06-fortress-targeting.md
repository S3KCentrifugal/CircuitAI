# Flying fortress target preference

## Diagnosis and plan

Dragon (`corcrwh`) and Tyrannus (`legfort`) use the ordinary squad attack and
defend selectors. Those selectors rank eligible contacts largely by distance;
Dragon's optional `anti_heavy` role does not replace that main task. AIR's
base-response group also retains an incumbent with a 25,000-point bonus, which
can retain a cheap raider ahead of an expensive attacker. Finally, the shared
priority-fire function is a stub: a queued movement leg leaves weapons on
automatic targeting until the attack command starts.

Implement a per-definition JSON opt-in with a minimum preferred metal cost.
Keep native eligibility, threat, path and fog checks. Prefer a qualifying nearby
contact over spam, but bound the detour: within weapon range, or at most twice
the distance to the ordinary target. Commanders and anti-air qualify regardless
of cost. Cheap contacts remain the fallback. Keep different targeting policies
in separate ordinary squads. Enable BAR priority fire only for opted-in units,
retain automatic fire for other weapons, and cancel owned priorities at task
handover. AIR base defense gets a separate heavy-air target group using the
same JSON opt-in, without changing its ordinary gunship/bomber groups.

The [Dragon](https://www.beyondallreason.info/unit/corcrwh) and
[Tyrannus](https://www.beyondallreason.info/unit/legfort) have multiple surface
weapons plus dedicated AA. Local game definitions and the shared unit knowledge
base confirm those mount categories and different ranges. Favoring substantial
targets is a policy inference, not a claim that their splash weapons should
never shoot swarms. Do not force hold-fire or replace their range/movement rules.

## Verification planned

Use supplied combat forces with actual AI orders: nearby cheap bots plus an
expensive ground target, cheap-only cleanup, and AIR base-defense ownership.
Compare baseline and candidate with identical spawns, seed and visibility;
record actual damage attribution and priority commands, not just kills. Include
both factions, target death/fallback, and retained AA fire. Native tests cover
the bounded preference and fallback. Run the existing native suite, actual
engine script loading, invariant/API checks, and preserve screenshots/results.

Performance contract: candidate ranking adds constant work to existing scans,
with no extra global enemy scan or periodic controller. Priority commands are
issued on changes or after a command that cancels them, never on every frame.
No FPS or network improvement is claimed from asymptotic analysis alone.


## Implemented and played

The opt-in is `"target_min_cost": 300` in the existing `corcrwh` and `legfort`
entries of active behavior profiles. Zero disables it; no new attribute or
hardcoded native unit roster was added. Unconfigured units retain their old
target selection and the priority-fire stub remains inactive for them.
AIR's new fourth defense group uses the same opt-in, with metal cost,
commander/AA weighting and proportional retention. Ordinary gunships, fighters,
bombers, production, retreat, weapon statistics and ranged movement stay intact.

The native scan's maximum weapon radius is a tactical search bound, not proof
that every weapon can fire there. The engine checks each mount's category,
arc and range. Short-range surface guns may still shoot spam when the preferred
target is outside their own reach; dedicated AA remains automatic. Cheap-only
contacts remain valid cleanup targets. This is a preference, not hold-fire.

BAR consumes custom priority commands before the observer's UnitCommand hook.
Therefore its zero priority-command counter does **not** prove no targeting.
The analysis uses the replicated `unitTargetID` during movement, task target
selection for direct AIR defense attacks, and actual damage. Direct ATTACK
has precedence over the optional priority list and can correctly show a nil
`unitTargetID`. Five analyzer tests guard those distinctions, missing AA damage,
friendly-only damage and events after the observation cutoff.

All 17 rendered supplied-force observations passed their original engine
checks and the final semantic checks. Twelve use the candidate, five the
baseline. All three experimental profiles load successfully. Ten reusable
cases cover both factions, a fragile scout screen, a durable T1 tank screen,
spam-only fallback, AIR base defense and simultaneous enemy aircraft. These
are two-minute controlled combats on All That Glitters, with legal sensors and
the same seed/spawns per comparison; they are not full economy or win-rate tests.

### Paired measurements

Damage is the observer's reported amount, including any overkill; it is not
metal efficiency. Timing is from game start (forces begin spawning at 10 s).

| Case | Baseline first heavy damage | Candidate first heavy damage | Baseline first heavy kill | Candidate first heavy kill | Heavy damage by 30 s, old → new |
| --- | ---: | ---: | ---: | ---: | ---: |
| fortress-legfort-mixed | 15.4 s | 15.5 s | 32.4 s | 27.4 s | 10,332 → 9,582 |
| fortress-corcrwh-mixed | 16.3 s | 16.2 s | 30.3 s | 24.7 s | 13,185 → 13,397 |
| fortress-legfort-screen | 15.0 s | 14.9 s | 51.9 s | 25.9 s | 2,734 → 9,280 |
| fortress-corcrwh-screen | 20.3 s | 15.5 s | 36.3 s | 26.9 s | 2,872 → 12,501 |
| fortress-legfort-defense | 17.7 s | 15.3 s | 31.1 s | 24.5 s | 7,011 → 11,058 |

The first Tyrannus fragile-screen trial killed its first heavy tank earlier
but the second later than baseline. Do not turn target preference into a claim
of universal DPS/clear-time improvement. The durable-screen and direct-defense
cases establish the requested priority; fallback and AA cases establish the
important exceptions. Neither fortress died in these cases.

### Immutable observations

Each link preserves the original checks/verdict, exact DLL/data hashes,
scenario, screenshot and final `fortress-measurements-v5.json`. Raw logs/replays
remain at the recorded paths. Earlier analysis versions are retained where
they exist; v5 distinguishes direct attack ownership and excludes friendly
damage from the engagement acceptance check.

| Case | Build / profile | Behavioral result | Evidence |
| --- | --- | --- | --- |
| fortress-corcrwh-mixed | baseline / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-corcrwh-mixed/2026-10-06/20261006T060823Z-f6d39cd9/README.md) |
| fortress-legfort-defense | baseline / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-legfort-defense/2026-10-06/20261006T061129Z-9b383801/README.md) |
| fortress-corcrwh-screen | baseline / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-corcrwh-screen/2026-10-06/20261006T062346Z-eb7043ed/README.md) |
| fortress-legfort-screen | baseline / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-legfort-screen/2026-10-06/20261006T062241Z-6f4916e3/README.md) |
| fortress-legfort-mixed | baseline / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-legfort-mixed/2026-10-06/20261006T060423Z-3be039f6/README.md) |
| fortress-corcrwh-mixed | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-corcrwh-mixed/2026-10-06/20261006T062051Z-ad909fa4/README.md) |
| fortress-corcrwh-aa | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-corcrwh-aa/2026-10-06/20261006T063216Z-ab92746b/README.md) |
| fortress-corcrwh-defense | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-corcrwh-defense/2026-10-06/20261006T063112Z-91b83196/README.md) |
| fortress-corcrwh-defense | ranged / experimental_terrible | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-corcrwh-defense/2026-10-06/20261006T063423Z-29e36613/README.md) |
| fortress-corcrwh-screen | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-corcrwh-screen/2026-10-06/20261006T062905Z-3f2c17d1/README.md) |
| fortress-corcrwh-spam | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-corcrwh-spam/2026-10-06/20261006T063008Z-028736d1/README.md) |
| fortress-legfort-aa | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-legfort-aa/2026-10-06/20261006T062801Z-38c46b7f/README.md) |
| fortress-legfort-defense | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-legfort-defense/2026-10-06/20261006T062657Z-c11997ad/README.md) |
| fortress-legfort-defense | ranged / experimental_hard | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-legfort-defense/2026-10-06/20261006T063319Z-fb3df314/README.md) |
| fortress-legfort-screen | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-legfort-screen/2026-10-06/20261006T062450Z-3b391d34/README.md) |
| fortress-legfort-spam | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-legfort-spam/2026-10-06/20261006T062554Z-613feb5d/README.md) |
| fortress-legfort-mixed | ranged / experimental_balanced | PASS | [Original evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-legfort-mixed/2026-10-06/20261006T061819Z-b999413e/README.md) |

### Build and checks

Candidate DLL SHA-256:
`9507e1c6b5eda75d3c4e7668f2eb052a3e82a672289e2dbd68b1b9337f368edb`.
Baseline DLL SHA-256:
`f224e17dc3c6f79801ee31fc755d49165c96cd0b022a5c5cffa70488363111ed`.

The complete native suite passed on repeat, including nine new target-preference
checks. Its first attempt hit the existing KI-518 AngelScript reference-count
assertion in the unchanged TECH differential fixture; the isolated retry and
full repeat passed. No assertion or workload was disabled. Script API,
invariant, role-document and analyzer checks pass. Unit-helper validation still
reports the pre-existing 170 findings; documentation validation still reports
the eight KI-404 links to the missing hover reference.

The required development output contains matching DLL/debug symbols plus all
330 data files; all 332 hashes were compared. The live game installation was
not updated. Source/build checks and the first/repeated native results are in
[validation evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/fortress-corcrwh-defense/2026-10-06/20261006T063423Z-29e36613/fortress-validation.json).

Selection remains O(E) over the existing eligible contacts, with constant
extra state and no extra whole-map pass. Opted-in attack squads examine low
influence groups too, so a valuable structure cannot be skipped by the old
"already found a stronger group" shortcut. Other squads retain that shortcut.
AIR adds one rank calculation to its existing contact census. There are no new
per-frame controllers or per-frame target commands. These small fixtures do
not prove a late-game FPS bound or multiplayer network cost.

The old root/easy/medium/hard Cortex profiles name the archaic `corcrw` rather
than the current `corcrwh`; their roster migration is not included (KI-522).
All experimental profiles used by the custom AIR role contain the current
Dragon and are covered by this fix. Additional fortress variants require
their own weapon/fixture review before opting in.

Test definitions: [case index](../testing/index/shared.md),
[native test](../../tests/target_preference_test.cpp),
[semantic analyzer](../../tools/playtest/fortress_report.py),
[analyzer tests](../../tools/playtest/test_fortress_report.py).
