# AIR ordered building rules

`AirRules::MakeTask` is a total dispatcher for a valid owned builder while
`Air.ExperimentalBuild` is enabled. A successful action ends evaluation;
otherwise the next action is tried. Every construction action rechecks current
capability, queue and reservation state. Economy observations are cached once
per second; existing construction stays assigned.

| Order | Rule | Purpose |
| --- | --- | --- |
| 1 | current construction | Finish committed work before choosing another project |
| 2 | `recovery.resume`, `recovery.assist`, `recovery.energy` | Recover an energy order, finish energy or add quickly payable supply during a sustained stall |
| 2a | `project.resume` | Reassign an owned orphan order before adding another project |
| 3 | `opening.mex`, `opening.energy` | Three nearby mexes and initial energy before the starter |
| 4 | `transport.plant`, `opening.plant` | Recover or build the T1 air plant, retaining transport capability |
| 5 | `mex.upgrade`, `mex.expand` | Use capable gifted/owned T2 builders; expand safe reachable mexes |
| 6 | `production.support`, `storage.buffer` | Fund actual factory BP and the first wind buffer without starvation |
| 6a | `transition.bay` | Admit a funded first T2 package before the moving T1 energy-growth target can starve it |
| 7 | `energy.assist`, `energy.grow` | Supply aircraft demand and T1 economy growth |
| 8 | `intel.radar`, `defence.flak` | Radar and bounded T2 AA against observed aircraft |
| 9 | `storage.metal` | Save income needed for a funded T2 package |
| 10 | `production.bay` | Fund first T2 or one additional independent bay |
| 11 | `storage.energy`, `surplus.convert` | Buffer fluctuations; convert only surplus with metal capacity |
| 12 | `service.queued` | Explicit native repair, defence and radar service |
| 13 | `project.assist`, `production.assist`, `wait` | Useful nearby work, short factory guard, or bounded retry |

The factory recruiter separately prioritizes allied transport obligations, then
constructor recovery, scouting, an immediate fighter screen, economic builders,
the full interception floor, a finite T1 strike, heavies and escorted waves.
Task priority controls engine resource priority; admission gates and available
build power also limit competing spending.

This sequence deliberately keeps the T1 utility plant when T2 starts. It has no
TECH rush chain, gantry ladder, dense reactor block or automatic lab reclaim.
Turning the feature off returns AIR to its existing legacy dispatcher.

See [building actions](air_build.md), [AIR integration](air.md),
[implementation/evidence](../air-management.md).

<!-- source: data/script/src/roles/air_rules.as; blob: 4f00ea4e370629b17550452c6b99df96445965fd; lines: 109 -->
