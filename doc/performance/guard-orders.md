# Builder guard command correction (D-223)

KI-533 is a CircuitAI native task issue. Script-side task reuse does not stop
`CBGuardTask::Execute` or `OnUnitIdle` from sending the same GUARD again.

Before:

```cpp
unit->GetUnit()->Guard(vip->GetUnit(), options);
```

After, before the clearance move or GUARD is submitted:

```cpp
unit->CmdPriority(ClampPriority());
if (KeepGuard(unit, "execute")) return true;
// Existing clearance MOVE and GUARD path follows unchanged.
```

The live engine queue decides whether the intent still exists. A valid matching
GUARD may follow the engine's single-target REPAIR, internal displacement MOVE
or the task's finite right-mouse clearance MOVE. A different target, conflicting
command, malformed parameters, changed modifier or expired order permits immediate
recovery. Empty queues are never suppressed. The task first checks its ownership
and reacquires the target. No timer, last-target cache or role policy is added.

The direct C callback adapter avoids generated wrapper/parameter allocations.
It inspects O(Q) commands, stopping at the first guard or conflict; ordinary queues
have one/two entries. Storage is O(1). The optional `CIRCUIT_VERIFY_GUARD` diagnostic
uses a separate wrapper read to audit skipped commands and logs native sends/skips.
It is disabled by default and must be off for CPU timing.

## Verification

- [Queue predicate tests](../../tests/guard_command_test.cpp): active/pending
  guard, factory repair, clearance, conflict, expiry boundary, target change and
  same-frame queue mutation.
- [Actual callback adapter tests](../../tests/guard_callback_test.cpp): command
  modifiers, copied parameter counts, malformed/oversized/nonfinite values,
  engine expiry boundary and 100,000 fresh reads.
- [Rendered game runner](../../tools/playtest/run_guard_regression.py): natural
  Glacial SEA plus supplied Supreme task-admission/recovery fixtures, pinned
  engine/content/seed/DLL and independent synchronized command observer.
- [Native runner](../../tools/run_native_tests.sh) and
  [callback runner](../../tools/run_guard_tests.sh) are reproducible regression checks.

The full native/VM suite passes, including 27 queue predicate checks. The actual
C-ABI adapter passes 30 checks and 100,000 fresh reads. Script/DLL API parity and
the invariant register pass. The documentation link checker retains the eight
pre-existing missing `roles/hover.md` links (KI-404); no new broken link was found.

## Played results

Ten-minute normal-fog Glacial runs use the same engine, content, seed, roles,
settings and observation horizon. Team 0 issues **42 GUARD orders before and 1
after (97.6% fewer)**. Both complete 10 mobile units. The candidate's native
diagnostic records 233 suppressed Execute attempts across all six AIs, with no
INV-163 failures. Team 0's total non-Lua orders are 1,565 before and 1,908 after;
the game states diverge, and this is **not** an overall APM or FPS improvement.

The final supplied Supreme fixture passes production assistance, actual STOP
recovery, target switching, following a physically moving constructor, target
destruction/reassignment and continuing ship production. The fixed constructor
receives five GUARD orders: initial admission, STOP recovery and three intentional
target changes. STOP reaches the engine at frame 2102; OnUnitIdle sends immediately
in that frame and the observer sees GUARD again at 2105 (three simulation frames).
The candidate completes 18 mobile units in the five-minute supplied window.

Earlier fixture records are retained with their original verdicts. The first
version collided with SEA's deliberate idle-assist cleanup and used spectator
LuaUI STOP/MOVE requests that never reached the units. Its one-time queue samples
could pass accidentally while repeated task admission was occurring. The second
observer also incorrectly treated `fromLua` as identifying LuaUI orders. These
are fixture defects, not evidence to change SEA gameplay. The final fixture
exempts only explicitly owned test guards from cleanup, sends STOP/MOVE through
the existing AI API, waits for the synchronized STOP event and requires more
than 100 elmos of actual target displacement. Ordinary games keep all role policy.

No FPS or internet-network improvement is claimed. Runtime coverage is SEA on
Glacial/Supreme plus the shared native queue tests; exhaustive cross-role matches,
save/load, direct player takeover and transfer fixtures were not run here.

## Archived evidence

| Scenario | Baseline GUARD orders | Fixed GUARD orders | Verification |
| --- | ---: | ---: | --- |
| Glacial, ordinary economy (10 minutes) | 42 | 1 | [Baseline](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/guard-baseline-natural/2026-10-07/20261007T022319Z-fcc3debd/report.md), [Fixed](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/guard-candidate-natural/2026-10-07/20261007T023003Z-453bb819/report.md) |
| Supreme, final recovery fixture (5 minutes) | 102 | 5 | [Baseline](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/guard-base-recovery-v4/2026-10-07/20261007T024642Z-c2f4c053/report.md), [Fixed](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/guard-fixed-recovery-v4/2026-10-07/20261007T024442Z-0b83606f/report.md) |

The final matched Supreme runs both complete 18 mobile units. Guard orders fall
from 102 to 5 (95.1%); the repeated same-target order in the fixed run is the
required STOP recovery. Overall orders in this supplied fixture fall from 1,451
to 1,294; this is a fixture result, not a whole-match or multiplayer forecast.

[All trials, counts and raw log hashes](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/guard-orders.json),
[native/VM and C-callback output](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/guard-orders-tests.txt).
Failed fixture iterations retain their original verdicts and pins in the
benchmark catalog. Setup/build errors occurred before a game in three attempts
(missing test configuration directory, unstripped candidate rejected by staging,
overlong scenario slug); no partial attempt is counted as a completed game.

The stripped DLL and matching symbols were published with all 336 unchanged
production data files to the required development output. DLL SHA-256:
`48e4995544486f4a96ab469969d779ffce672fb496195c643066611023e6f715`.
The live BAR installation was not modified.
