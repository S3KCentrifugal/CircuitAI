# SEA forward mex expansion and protection

## Diagnosis and change

The normal compact-economy path prioritized the first construction ship's mexes
only inside a fixed 2400-elmo circle around its starting shipyard. Moving-radius
priority existed later in the optional experimental build path. After the home
search emptied, optional converters, assistance and other native work could take
over. Changing the shared SEA/TACTICAL ladder would affect another role.

[SeaExpansion](../../data/script/src/manager/sea_expansion.as) now runs before
both SEA economy paths. Near home it first preserves the 2400-elmo home search;
then the primary construction ship searches 3600 elmos around its current
position, without an income cutoff. With three T1 ships, the secondary
can expand too. Other ships retain home economy/build-power work; T2 constructors
retain upgrades/capital work. Metal maps retain the existing field-mex behavior.
Native claims, occupied spots, allied territory, terrain and buildability remain
authoritative.

- Reject known surface/underwater threat on the direct approach, sampled every
  128 elmos. Destinations must also clear hostile weapon range plus 256 elmos.
  Unidentified sonar contacts use a conservative 600-elmo weapon range.
- Beyond the homeward part of the sea, require 600 metal of allied combat ships
  within 1000 elmos in the same water body. The boundary compares squared distance
  to our start with 0.36 times squared distance to the nearest enemy start.
- Recheck T1 construction ships once per second. If exposed, detach only
  that worker and issue one homeward MOVE under a native 30-second WAIT when its
  starting shipyard remains safe/reachable. This includes native support ships,
  not just the two designated expanders. Incomplete frames remain recoverable.
- Preserve player, retreat, external and enemy-reclaim ownership. Retry rejected
  proposals after ten seconds; successful construction permits the next claim
  immediately. Removal/role exit clears worker state.
- Remote groups of two or more mexes receive a torpedo launcher. At +30 metal/s
  they can add a surface tower; observed air pressure enables floating AA.
  Standing buildings, frames and pending orders count toward local coverage.
  Purchases must fit ten seconds of income plus bank, retaining 50 metal.
  Native placement still respects allied reserved layouts.

## Gameplay grounding

BAR's [naval guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare)
describes naval constructor build power, underwater mex value, torpedo defense
against submarines, and floating towers against surface ships/hovers. It also
explains why ranged ships can defeat static defenses. This supports expansion
behind the navy with limited cluster fortification. The numeric thresholds here
are AI tuning, not universal PvP build orders. All three faction constructor
build edges were checked against the shared unit catalogs and runtime CanBuild/
IsAvailable checks. No UnitDef classifications or non-SEA policy changed.

## Performance and ownership

No native rebuild or new path solver is needed. Task selection scans the existing
mex ledger twice (O(M)), at most three defense types and legal sea contacts (O(C)).
The corridor scan is O(distance/128), bounded by the configured search radii.
Native mex selection retains its spot sorting/reachability work; this is not an
O(1) placement query. Near home, an empty home query may be followed by one wider
query. Keeping these separate prevents the native pending-task-first rule from
adopting distant work ahead of unclaimed home mexes. The periodic safety monitor
visits an event-maintained roster of B T1 ships, reacquires live IDs and checks
the shared C-contact snapshot: O(B*C) once per second. A single owned-unit census
adopts an existing army on activation; subsequent add/remove events maintain it.
Threat checks issue no commands; only danger transitions issue a withdrawal MOVE.
There is no per-frame movement micro, global rate limiter or claimed FPS gain.

## Verification

The pinned native DLL is D-216 `45eb0f2e89a285e3`; this change is AngelScript-only.
Natural Glacial games use three SEA players per side, all factions, ordinary
resources, seed 1881001 and experimental_balanced. The observer grants no vision,
resources or gameplay commands. The first candidate expanded but lost workers
at the middle; it was rejected. Its original results remain archived.

Final-code comparisons at frame 27900 (15.5 minutes), summed over six SEA players:

| Metric | Old compact/balanced | Final compact/balanced | Old full experimental/hard | Final full experimental/hard |
| --- | ---: | ---: | ---: | ---: |
| Standing mexes | 73 | 81 | 86 | 77 |
| Mexes farther than 2400 elmos from own start | 26 | 34 | 39 | 33 |
| Completed naval defenses, including home defenses | 7 | 11 | 8 | 17 |
| Construction ship losses | 0 | 0 | 3 | 0 |
| Explicit expansion withdrawal orders | 0 | 7 | 0 | 35 |

The normal compact path gained eight standing mexes and eight beyond the old
radius. The harder full-experimental run retained fewer mexes but lost no
constructors, versus three lost by the control. That safety/territory tradeoff
is part of the result, not an across-the-board economy improvement. Individual
players do not all improve: final compact team 0 held 15 versus the control's 16.
Its allies also claim the same sea. These are single-seed natural games with
asynchronous pathing, not a controlled win-rate or deterministic guarantee.

Six measurable final compact withdrawals moved 1247-1755 elmos homeward; one
order lacked a complete matching observation window. All 35 measurable harder
run withdrawals moved homeward (788-1695 elmos). Nine compact and five full-path
completed defenses correlate spatially with earlier forward-cluster orders.
The analyzer requires matching team/definition and completion within 256 elmos
of the planned cluster anchor; this is spatial evidence, not a native task-ID
join. The main checks independently require forward mex completion, a cluster
fort order, a completed torpedo defense and no script/invariant/crash markers.

Final [Supreme Isthmus / experimental_terrible regression](../benchmarks/records/sea/economy/mex-safe-supreme/2026-10-06/20261006T092445Z-e07e151d/README.md)
passed the runtime/ship-egress checks. At 15.5 minutes its two SEA players held
18 and 19 mexes, seven each beyond 2400 elmos, with no constructor losses. No
new controller fortification completion was correlated on that map during this
window; Glacial supplies that coverage. All three experimental profiles loaded
the final policy in rendered games. No resources or combat units were spawned.

Final comparison evidence:

- [Old compact control](../benchmarks/records/sea/economy/mex-expansion-control/2026-10-06/20261006T084921Z-f89a79b7/README.md)
  and [final compact policy](../benchmarks/records/sea/economy/mex-safe-default/2026-10-06/20261006T092229Z-a0d447ad/README.md).
- [Old full-experimental control](../benchmarks/records/sea/economy/mex-migrated-control/2026-10-06/20261006T092356Z-478eceba/README.md)
  and [final full-experimental policy](../benchmarks/records/sea/economy/mex-expansion-safe/2026-10-06/20261006T092230Z-77106a02/README.md).

Rejected/intermediate observations are retained, not overwritten:

- [Initial aggressive candidate](../benchmarks/records/sea/economy/mex-expansion-candidate/2026-10-06/20261006T083502Z-cce5165b/README.md)
  passed smoke checks but lost four construction ships; escort/withdrawal was added.
- [Wide-query experimental failure](../benchmarks/records/sea/economy/mex-expansion-migrated/2026-10-06/20261006T090203Z-705e6f0e/README.md)
  missed team 0's ten-minute frontier target. Restoring the local opening ahead
  of native distant-task adoption produced the
  [passing home-first run](../benchmarks/records/sea/economy/mex-expansion-homefirst/2026-10-06/20261006T091234Z-586cc3c3/README.md).
  Four extra support ships were still lost; safety coverage was then extended
  from two designated expansion workers to all T1 construction ships.
- An earlier Supreme watcher reported a premature exit despite a complete game
  log. Its [original failure](../benchmarks/records/sea/economy/mex-expansion-supreme/2026-10-06/20261006T085240Z-2c43b1b8/README.md)
  and [completed-log assessment](../benchmarks/records/sea/economy/mex-expansion-supreme/2026-10-06/20261006T085706Z-79453cbf/README.md)
  are separate records. KI-524 tracks the watcher defect. Reassessments of one
  game are not additional matches.

Validation: the full native/AngelScript test runner passed; the SEA math suite
contains 20 passing tests, including threat/escort boundaries and two-resource
fortification funding. Script/DLL API parity (310 members), role-document
markers, invariant checks, test-index freshness, Python compilation and
`git diff --check` passed. Existing repository-wide failures remain: 170 unit
helper findings (KI-473/KI-481) and eight links to the missing hover document
(KI-404); none is introduced by this policy.

The required development output is
`C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`:
matching D-216 DLL/debug symbols and the complete current data tree. The native
binary did not change for D-217. The live BAR installation is not modified.

Reproduce with `tools/playtest/run_sea.py --map glacial --legacy --minutes 15
--speed 12 --profile experimental_balanced --expansion-observer --checks
sea/economy/mex-expansion.json --dll <pinned DLL>`.

Definitions: [case](../../tools/playtest/cases/sea/economy/mex-expansion-glacial.json),
[checks](../../tools/playtest/checks/sea/economy/mex-expansion.json),
[observer](../../tools/playtest/widgets/sea_expansion_watch.lua),
[analyzer](../../tools/playtest/analyze_sea_expansion.py),
[math tests](../../tests/sea_math_tests.as).

## Limits

The conservative direct-corridor screen is not the engine's actual coastal path.
Hidden enemies can still ambush workers. A rejected nearest candidate can defer
another safe route until later; KI-523 records that limit. Allied defenses do not
count toward this controller's optional fortification coverage. Save/load-specific
frontier acceptance and Internet APM measurements have not been run.
