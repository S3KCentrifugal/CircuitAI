# SEA mex opening and seaplane transition

The first construction ship must try safe, reachable nearby metal spots before
discretionary economy or factory assistance. Use the existing primary-constructor
identity, not the lowest engine unit ID. Reuse native mex task ownership,
occupancy, allied territory and ship reachability checks; a construction ship
cannot traverse land to another sea. Finish structures already started. Once
there is no eligible local spot, resume the normal economy ladder, including
converters. Keep the shared SEA/TACTICAL ladder unchanged.

After a completed T2 shipyard, SEA's next new factory is its faction's seaplane
platform. Preserve resource funding, availability and recovery of a lost T1
yard. Block discretionary alternative factories until the platform exists or
is committed. Older map objectives must use this same admission path.

Plan platforms with the existing persistent footprint reservations. Aircraft
need no ship exit corridor; ordinary shipyards retain their corridor validation.
Reserve twenty reachable naval-turret slots before admitting the platform and
include it in the existing income/workload-based support calculation. Register
missing Legion platform metadata only on the SEA instance. Keep all policy in
AngelScript. Testing additionally exposed native T1 production suppression of
platforms after T2; MakeFactoryTask(factory, keepActive) is the generic mechanism
used only by SEA platforms. Shared JSON and other roles remain unchanged.

Verification: actual AngelScript VM boundary tests; API/invariant checks; isolated
Supreme Isthmus fixtures observing actual mex construction before converters,
T2 completion before platform admission, reserved support reach, completed
platform and aircraft production. Exercise normal compact and experimental
builder paths and all three faction definitions. Follow with an ordinary-resource
Supreme opening. Preserve failed runs and distinguish supplied acceptance tests
from natural economy benchmarks.

## Supplied acceptance results

All runs use Supreme Isthmus v1.7, experimental_balanced and the pinned BAR
test-31479-433a460 content. The final native build is
`aff90f713fc9746a` (SHA-256 prefix). These tests supply capital, an opening yard,
one fusion and a T2 yard at 2:00; completion times are not natural tech timings.
The tested SEA's builders and factories retain their production decision paths.

| Test | First ship's mex | Platform complete | First aircraft | Reachable support / actual assistance | Result |
| --- | --- | --- | --- | --- | --- |
| Armada, compact | 1:08 | 3:11 | 3:29, armsehak | 31 valid reserved slots; 2 turrets assisting at 3:15 | [PASS](benchmarks/records/sea/economy/seaplane-armada/2026-10-05/20261005T234754Z-d6159754/report.md) |
| Cortex, experimental | 1:08 | 3:44 | 4:15, corsb | 20 slots; 13 turrets in range, assistance observed at 5:30 | [PASS](benchmarks/records/sea/economy/seaplane-cortex/2026-10-05/20261005T235010Z-46bbe5e4/report.md) |
| Legion, compact | 1:06 | 2:41 | 3:07, legspbomber | 27 slots; 3 turrets assisting at 3:05 | [PASS](benchmarks/records/sea/economy/seaplane-legion/2026-10-05/20261005T235230Z-e9622520/report.md) |

Original failures remain available:
[incomplete support footprint](benchmarks/records/sea/economy/seaplane-armada/2026-10-05/20261005T233655Z-c427166b/report.md)
and [native post-T2 production suppression](benchmarks/records/sea/economy/seaplane-armada/2026-10-05/20261005T233946Z-f770abc8/report.md).
The first failure's observer only required a mex after first-ship completion;
the subsequent observer ties completed mexes and aircraft to their actual
creating builder/factory IDs. No failed verdict was overwritten.

## Performance and scope

The native production exception adds one boolean decision, with no scan or extra
command. DefaultMakeTask still passes false; only SEA platforms opt in. Mex
selection reuses the native bounded spot query on builder decisions, not a new
per-frame scan. Support capacity checks stop once enough valid slots are found;
placement searches retain their existing candidate budgets. No APM throttle or
combat policy change was introduced. These acceptance runs are not an FPS
benchmark or proof of late-game performance improvement.

Full multi-sea
isolation, save/load, blocked-site recovery under enemy pressure, and every game
content restriction remain outside this fixture's coverage. Restricted/unavailable
platform definitions do not block other factory purchases. Shared native task
ownership, allied reservations and the TACTICAL constructor ladder are retained.

## Ordinary-resource economy

The compact/default Armada run completed its first ship's first mex at 3:02,
reached 17 mexes by about 12:30 and 19 by 20:30, while continuing tidal and
converter production. It did not reach T2 within thirty minutes, so the
[natural transition check failed](benchmarks/records/sea/economy/seaplane-armada-eco/2026-10-05/20261005T235701Z-9cc771f4/report.md).
There was no platform opportunity; this is not a successful end-to-end natural
transition. At 29:00 the observer recorded +56.4 metal income but only 42/5050
stored metal. The shared helper accepts an 800-metal setting but disables its
bank check (`mcOk=true`), so low storage alone does not explain missing T2
admission. Native MEX/GEO/ENERGY work can bypass the role ladder. That precedence
is unchanged; this run does not isolate it from downstream admission/access.
The broader economic-timing issue remains tracked under KI-228.

The thirty-minute ordinary-resource Armada experimental run
[passed](benchmarks/records/sea/economy/seaplane-armada-eco/2026-10-06/20261006T000505Z-0f0085f6/report.md):
first-ship mex 3:22, T2 yard 13:16, platform admission 16:04, platform completion
17:22, actual turret assistance 17:30, first platform bomber (`armsb`) 17:47.
Thirty valid reserved turret slots were within platform reach; three completed
turrets were in range, two assisting, at the support observation. This verifies
the transition without supplied capital, not every map or economy setting.
The two natural runs are different economy modes, not a paired old/new
performance comparison; only the AI seed was pinned, not the engine RNG.

## Checks and reproduction

- Native build and deployed DLL/script parity: 304 used API members, zero findings.
- Actual AngelScript VM: ten SEA policy test functions, zero failures.
- Invariant and role-document checks: zero findings.
- Documentation links retain eight existing missing `roles/hover.md` links
  (KI-404); unit-helper validation retains 167 existing findings (KI-481/KI-473).
- Every published evidence bundle retains original verdicts, source pins and a
  screenshot; publication hashes were checked. Raw games remain in their
  isolated categorized directories.

Run `tools/playtest/run_sea_transition.py --dll <built DLL> --side armada`
for supplied acceptance. Use `--side cortex --experimental` or `--side legion`
for the other tested variants. Add `--natural --minutes 30` for ordinary resources;
add `--experimental` to exercise the opt-in economic migration. Scenarios and
checks are indexed under SEA/economy in the [test catalog](testing/index/sea.md).
