# Decision record

Why the changes in this repository were made, not just what they were. One
entry per decision that a future reader could reasonably second-guess: the
call, the reasoning, the files it touched, and how far it has actually been
verified.

This is deliberately separate from [`known-issues.md`](known-issues.md), which
records problems that are *open*. A decision lands here once it is made, even
when the work it describes is unverified — and especially when it was later
found to be wrong.

## Contents

- [How to use this record](#how-to-use-this-record)
- [Verification vocabulary](#verification-vocabulary)
- [D-001 — Mobile sensors are rationed one per squad](#d-001--mobile-sensors-are-rationed-one-per-squad)
- [D-002 — The Eight Horses crash: role mask passed as role index](#d-002--the-eight-horses-crash-role-mask-passed-as-role-index)
- [D-003 — `IsSuddenThreat` null guard kept despite being the wrong diagnosis](#d-003--issuddenthreat-null-guard-kept-despite-being-the-wrong-diagnosis)
- [D-004 — Script's `Mask` typedef left at `uint`](#d-004--scripts-mask-typedef-left-at-uint)
- [D-005 — SUPPORT swaps its Juno for the side's tactical launcher](#d-005--support-swaps-its-juno-for-the-sides-tactical-launcher)
- [D-006 — `areaUsable` stops being an absolute veto](#d-006--areausable-stops-being-an-absolute-veto)
- [D-007 — Spam's fusion-era gate is deliberate and stays](#d-007--spams-fusion-era-gate-is-deliberate-and-stays)
- [D-008 — Spam routes run through the combat front](#d-008--spam-routes-run-through-the-combat-front)
- [D-009 — Spam keeps its task rather than an engine factory rally](#d-009--spam-keeps-its-task-rather-than-an-engine-factory-rally)
- [D-010 — The nuke cost floor is a regression, left unfixed pending a decision](#d-010--the-nuke-cost-floor-is-a-regression-left-unfixed-pending-a-decision)
- [D-011 — The transport ferry is native mechanism plus script protocol](#d-011--the-transport-ferry-is-native-mechanism-plus-script-protocol)
- [D-012 — Coordination goes over `AiSendMessage`, never `CallUI`](#d-012--coordination-goes-over-aisendmessage-never-callui)
- [D-013 — AIR flies the transport before transferring ownership](#d-013--air-flies-the-transport-before-transferring-ownership)
- [D-014 — Transports are matched by role mask, not main role](#d-014--transports-are-matched-by-role-mask-not-main-role)
- [D-015 — SEA seeds a TACTICAL ally with one construction ship](#d-015--sea-seeds-a-tactical-ally-with-one-construction-ship)
- [D-016 — The transport request is income-gated and decoupled from the T2 lab](#d-016--the-transport-request-is-income-gated-and-decoupled-from-the-t2-lab)
- [D-017 — Task-dependent orders are applied from the tick, never from a unit-added hook](#d-017--task-dependent-orders-are-applied-from-the-tick-never-from-a-unit-added-hook)
- [D-018 — Cargo state is inferred from height above terrain, not 2D proximity](#d-018--cargo-state-is-inferred-from-height-above-terrain-not-2d-proximity)
- [D-019 — Donation counts are read and written as `int64`](#d-019--donation-counts-are-read-and-written-as-int64)
- [D-020 — A naval unlock must also seed a naval demand](#d-020--a-naval-unlock-must-also-seed-a-naval-demand)
- [D-021 — Spam spreads per unit across a band, converging on the endpoint](#d-021--spam-spreads-per-unit-across-a-band-converging-on-the-endpoint)
- [D-022 — Transports are capped at 0 and the ferry opens one slot](#d-022--transports-are-capped-at-0-and-the-ferry-opens-one-slot)
- [D-023 — A ferry transport gets its native task before any role policy](#d-023--a-ferry-transport-gets-its-native-task-before-any-role-policy)
- [D-024 — Decision lines log at level 1, because level 2 does not exist in a game log](#d-024--decision-lines-log-at-level-1-because-level-2-does-not-exist-in-a-game-log)
- [D-025 — A dictionary `&out` is undefined after a miss; check `exists()` first](#d-025--a-dictionary-out-is-undefined-after-a-miss-check-exists-first)
- [D-026 — AIR spends a floating bank on a ring: build power, plants, energy, gantry](#d-026--air-spends-a-floating-bank-on-a-ring-build-power-plants-energy-gantry)
- [D-027 — Base layout is a plan: native geometry, script zones, shared over the roster](#d-027--base-layout-is-a-plan-native-geometry-script-zones-shared-over-the-roster)
- [D-028 — TECH spends a floating bank before its income-gated ladder; reserve-driven nanos are capped](#d-028--tech-spends-a-floating-bank-before-its-income-gated-ladder-reserve-driven-nanos-are-capped)
- [D-029 — Layout is reservations-first: script pushes the plan, native owns the nano block](#d-029--layout-is-reservations-first-script-pushes-the-plan-native-owns-the-nano-block)
- [D-030 — A squad attacks when it outweighs what it can reach, or when it has waited long enough](#d-030--a-squad-attacks-when-it-outweighs-what-it-can-reach-or-when-it-has-waited-long-enough)
- [D-031 — Siege artillery holds fire for anything but its ordered target](#d-031--siege-artillery-holds-fire-for-anything-but-its-ordered-target)
- [D-032 — EMP ranks large statics first, then everything else by metal cost](#d-032--emp-ranks-large-statics-first-then-everything-else-by-metal-cost)
- [D-033 — Spam decisions log at level 1; the fusion gate is left for the user to call](#d-033--spam-decisions-log-at-level-1-the-fusion-gate-is-left-for-the-user-to-call)
- [D-034 — AIR porcs for air denial, earlier, and on allied clusters](#d-034--air-porcs-for-air-denial-earlier-and-on-allied-clusters)
- [D-035 — A stockpiled shot's floor decays while it waits](#d-035--a-stockpiled-shots-floor-decays-while-it-waits)
- [D-036 — Tactical launchers aim by unit scan, and super statics bypass role policy](#d-036--tactical-launchers-aim-by-unit-scan-and-super-statics-bypass-role-policy)
- [D-037 — Builders focus one energy structure, and unused default tasks are discarded](#d-037--builders-focus-one-energy-structure-and-unused-default-tasks-are-discarded)
- [D-038 — Hovers are never spam](#d-038--hovers-are-never-spam)
- [D-039 — Legion builds its own T2 shipyard](#d-039--legion-builds-its-own-t2-shipyard)
- [D-040 — A unit marked for reclaim is never repaired, by anyone on the team](#d-040--a-unit-marked-for-reclaim-is-never-repaired-by-anyone-on-the-team)
- [D-041 — TECH donates T2 bots by plan, and T2 constructors only on request](#d-041--tech-donates-t2-bots-by-plan-and-t2-constructors-only-on-request)
- [D-042 — The sea-constructor ladder is shared, and TACTICAL runs it](#d-042--the-sea-constructor-ladder-is-shared-and-tactical-runs-it)
- [D-043 — Reservations are built; TECH reserves its labs, a 4x10 nano block and six advanced solars](#d-043--reservations-are-built-tech-reserves-its-labs-a-4x10-nano-block-and-six-advanced-solars)
- [D-044 — The ferry lands on clear ground, parks its cargo, and queues instead of walking](#d-044--the-ferry-lands-on-clear-ground-parks-its-cargo-and-queues-instead-of-walking)
- [D-045 — Bomber waves scale with income, form lines, and attack by one of six methods](#d-045--bomber-waves-scale-with-income-form-lines-and-attack-by-one-of-six-methods)
- [D-046 — SUPPORT never receives an unrequested T2 constructor](#d-046--support-never-receives-an-unrequested-t2-constructor)
- [D-047 — TECH's layout is tighter with solar rows, and its energy table is its own](#d-047--techs-layout-is-tighter-with-solar-rows-and-its-energy-table-is-its-own)
- [D-048 — A nano slot is served only within reach of its factory, and every factory gets a block](#d-048--a-nano-slot-is-served-only-within-reach-of-its-factory-and-every-factory-gets-a-block)
- [D-049 — Start positions are brokered through the host widget (proposal)](#d-049--start-positions-are-brokered-through-the-host-widget-proposal)
- [D-050 — Builders finish what they start, and the TECH plan is laid where the ground is open on both sides](#d-050--builders-finish-what-they-start-and-the-tech-plan-is-laid-where-the-ground-is-open-on-both-sides)
- [D-051 — TECH holds its turrets while the first T2 constructor is paid for, and owns the nano count](#d-051--tech-holds-its-turrets-while-the-first-t2-constructor-is-paid-for-and-owns-the-nano-count)
- [D-052 — A land-locked start never spams](#d-052--a-land-locked-start-never-spams)
- [D-053 — The layout becomes a complex of nano blocks, zones, corridors and routes (proposal)](#d-053--the-layout-becomes-a-complex-of-nano-blocks-zones-corridors-and-routes-proposal)
- [D-054 — TECH's own economy settings wait for +20 metal and +1000 energy](#d-054--techs-own-economy-settings-wait-for-20-metal-and-1000-energy)
- [D-055 — Every factory is planned on the line before it is enqueued, and a served slot is kept](#d-055--every-factory-is-planned-on-the-line-before-it-is-enqueued-and-a-served-slot-is-kept)
- [D-056 — The ferry flies on the engine's load, not on a lift bar](#d-056--the-ferry-flies-on-the-engines-load-not-on-a-lift-bar)
- [D-057 — The nano cluster is the anchor: head strip, spine, flanks tight on both sides](#d-057--the-nano-cluster-is-the-anchor-head-strip-spine-flanks-tight-on-both-sides)
- [D-058 — TECH's economy is a deterministic function of the game's state](#d-058--techs-economy-is-a-deterministic-function-of-the-games-state)
- [D-059 — The 2026-09-20 code review is applied in full](#d-059--the-2026-09-20-code-review-is-applied-in-full)
- [D-060 — TECH layout uses native canonical clusters and an ordered economy module](#d-060--tech-layout-uses-native-canonical-clusters-and-an-ordered-economy-module)
- [D-061 — The team-link widget is a tab beside the player list](#d-061--the-team-link-widget-is-a-tab-beside-the-player-list)
- [D-062 — TECH opens on home metal and scales by regional build power](#d-062--tech-opens-on-home-metal-and-scales-by-regional-build-power)
- [D-063 — The turret box: invisible construction turrets first, the economy packed against them](#d-063--the-turret-box-invisible-construction-turrets-first-the-economy-packed-against-them)
- [D-064 — Experimental build mode: builders stop at the engine's build range](#d-064--experimental-build-mode-builders-stop-at-the-engines-build-range)
- [D-065 — TECH's construction turrets: reclaim first, then the economy under construction in a fixed order](#d-065--techs-construction-turrets-reclaim-first-then-the-economy-under-construction-in-a-fixed-order)
- [D-066 — The experimental build system: a hard split, TECH only, one switch](#d-066--the-experimental-build-system-a-hard-split-tech-only-one-switch)
- [D-067 — TECH's build sequence is one ordered rule table](#d-067--techs-build-sequence-is-one-ordered-rule-table)
- [D-068 — TECH makes no combat unit before the combat gate; packed sites are for structures only](#d-068--tech-makes-no-combat-unit-before-the-combat-gate-packed-sites-are-for-structures-only)
- [D-069 — Turrets beside the nearest lab; the advanced lab where the most build power reaches](#d-069--turrets-beside-the-nearest-lab-the-advanced-lab-where-the-most-build-power-reaches)
- [D-070 — The TECH rush chain: one objective, one computed build order, then the economy](#d-070--the-tech-rush-chain-one-objective-one-computed-build-order-then-the-economy)
- [D-071 — No energy wait for experimental builders; a builder leaving an order is logged](#d-071--no-energy-wait-for-experimental-builders-a-builder-leaving-an-order-is-logged)
- [D-072 — Owner's rules from play: spot ownership, income bonus, deferred reclaim, no pockets, the box grows, upgrades before the fusion](#d-072--owners-rules-from-play-spot-ownership-income-bonus-deferred-reclaim-no-pockets-the-box-grows-upgrades-before-the-fusion)
- [D-073 — The advanced lab where the most turret slots reach it, front first](#d-073--the-advanced-lab-where-the-most-turret-slots-reach-it-front-first)
- [D-074 — A builder never moves once construction has begun; own frames are adopted, never reclaimed; the commander on the first constructor; factory exits kept clear](#d-074--a-builder-never-moves-once-construction-has-begun-own-frames-are-adopted-never-reclaimed-the-commander-on-the-first-constructor-factory-exits-kept-clear)
- [Process decisions](#process-decisions)
- [Maintaining this record](#maintaining-this-record)

## How to use this record

| Field | Meaning |
| --- | --- |
| **ID** | `D-nnn`. Stable for the life of the decision; never reused. |
| **Decision** | What was chosen, in one sentence. |
| **Why** | The reasoning, including the alternative that was rejected and why. |
| **Changes** | Direct links to every file the decision touched. |
| **Status** | See below. Be honest; an unverified change is not a finished one. |

A decision that turns out to be wrong is **not deleted**. It is marked
`Superseded` or `Wrong` and the correction links back to it. The record of a
bad call is more useful than its absence — [D-003](#d-003--issuddenthreat-null-guard-kept-despite-being-the-wrong-diagnosis)
and [D-010](#d-010--the-nuke-cost-floor-is-a-regression-left-unfixed-pending-a-decision)
are both in that shape.

## Verification vocabulary

| Word | Means |
| --- | --- |
| **Built** | Compiles clean in the docker harness. Nothing more. |
| **Checked** | The `tools/knowledge/` validators pass. Static only. |
| **Symbolised** | A crash was resolved against a binary whose md5 matches the build. |
| **Played** | Observed doing the right thing in a real match. |

Almost everything below is Built and Checked. Very little is Played, and the
entries say so.

---

## D-001 — Mobile sensors are rationed one per squad

**Decision.** At most one mobile radar or jammer escorts any squad, and the
scarce ones go to the highest-value squads first.

**Why.** `CSupportTask` walked every `support` unit to the *nearest* squad and
joined it with no cap, so every sensor on the map independently solved the
same problem and reached the same answer — 27 radar bots trailing one
sharpshooter. A squad moves as one body, so a second jammer covers ground the
first already jams and a second radar bot sees what the first sees; BAR's
`separateJammers` means overlapping bubbles do not compound either. What the
extras do add is a clump of unarmed units inside one splash radius.

Ranking is by the squad **leader's** metal cost — the leader is the squad's
most capable unit, so that is a tier ordering without walking every member.
The scarce sensors are then pointed at the best few squads and the pathfinder
picks the nearest of those, because pure value ranking would send a sensor
across the map and pure distance is what caused the pile-up.

**Changes.**
[`SupportTask.cpp`](../src/circuit/task/fighter/SupportTask.cpp) /
[`.h`](../src/circuit/task/fighter/SupportTask.h) (`FindCandidates`),
[`MilitaryManager.h`](../src/circuit/module/MilitaryManager.h) /
[`.cpp`](../src/circuit/module/MilitaryManager.cpp) (`SSensorInfo`,
`IsSensorUnit`, `CountSensors`, `NeedsSensor`, `GetSquadValue`,
`UpdateSensorGuards`), the `"sensor"` block in each
[`behaviour.json`](../data/config/experimental_balanced/behaviour.json),
[`sensor-escort.md`](sensor-escort.md).

**Status.** Built, Checked. Not Played. Surplus sensors park on the base ring,
which is honest but unambitious — [KI-107](known-issues.md).

---

## D-002 — The Eight Horses crash: role mask passed as role index

**Decision.** Add `FactoryProduction::roleTypeCache` alongside
`roleMaskCache`, point `military.as` at it, and bounds-check the two native
accessors.

**Why.** `CEnemyManager::GetEnemyThreat` / `GetEnemyCost` index a 64-entry
array by role **index**. `military.as` read the **mask** cache and passed
that; a mask is `1 << index`, so `"super"` (index 18) arrived as 262 144 and
read two megabytes past the array. Small-index roles read heap garbage without
faulting, which is why the symptom for a long time was a nonsense threat cache
rather than a crash.

The trigger was ours: `FactoryProduction::BuildRoleCaches()` was made
unconditional in this same session *because* the caches were empty and every
threat read zero. That turned a dormant type confusion into a deterministic
crash at the first cache refresh.

The native bounds check is not redundant with the script fix. These two
accessors are script-reachable raw array indices; the guard turns the next
mix-up into a log line naming the accessor and the index instead of a corrupt
read.

**Changes.**
[`factory_production.as`](../data/script/src/manager/factory_production.as),
[`military.as`](../data/script/src/manager/military.as),
[`EnemyManager.h`](../src/circuit/unit/enemy/EnemyManager.h) /
[`.cpp`](../src/circuit/unit/enemy/EnemyManager.cpp) (`IsRoleIndex`),
[KI-106](known-issues.md).

**Status.** Symbolised — deployed md5 matched the build, `ImageBase
0x1e33b0000`, RVA `0x43ef63`. Fix is Built and Checked, not Played.

---

## D-003 — `IsSuddenThreat` null guard kept despite being the wrong diagnosis

**Decision.** Keep the null guard in `CMapManager::IsSuddenThreat`, and record
prominently that it did **not** fix the crash it was written for.

**Why.** `CCircuitAI::EnemyEnterLOS` calls `IsSuddenThreat` *before* the unit
is identified, so a contact previously known only by radar reaches it with a
null `CCircuitDef` that it dereferenced unguarded. Every other consumer
null-checks it. That is a genuine reachable bug and the guard stays on its own
merit.

It was also confidently offered as the cause of the Eight Horses crash, and it
was not — the crash recurred at the same frame, and
[D-002](#d-002--the-eight-horses-crash-role-mask-passed-as-role-index) was the
real cause. The reason the wrong answer looked right was that the deployed DLL
predated the symbols on disk, so the stack could not be resolved and a
plausible path was accepted instead of a proven one.

**The rule this produced:** do not accept a diagnosis from a binary you cannot
symbolise. Record the md5 of every deployed build and keep its `.dbg`.

**Changes.** [`MapManager.cpp`](../src/circuit/map/MapManager.cpp),
[`BombTask.cpp`](../src/circuit/task/fighter/BombTask.cpp) (log deref
hardening), [KI-106](known-issues.md).

**Status.** Built. The guard is unproven in the sense that nothing has been
observed hitting it; the crash it was written for had another cause.

---

## D-004 — Script's `Mask` typedef left at `uint`

**Decision.** Do not change `RegisterTypedef("Mask", "uint")` to `uint64`
right now.

**Why.** `CMaskHandler::Mask` is 64-bit and `TypeMask::mask` is exposed at the
native field's offset, so script reads the low 32 bits. For the twenty
built-in roles that is lossless; every custom role in
[`unit.as`](../data/script/src/unit.as) sits above index 31 and reads **0**.

Nothing in the tree masks on a custom role from script — all 37 `.mask` uses
are built-in roles or attributes — so this is latent, not broken. Changing the
typedef touches all 37 sites and risks narrowing warnings in a tree where
warnings are errors. Doing it inside a crash fix would have mixed an unforced
refactor into an urgent change.

**Changes.** None. Recorded as [KI-108](known-issues.md) with the migration
plan.

**Status.** Deliberate non-change.

---

## D-005 — SUPPORT swaps its Juno for the side's tactical launcher

**Decision.** `Support_PorcChain` replaces the side's Juno in the land porc
chain with `armemp` / `cortron` / `legperdition`. SUPPORT builds no Junos.

**Why.** This looked like a preference between two units competing for a slot
and is not. `DefaultMakeDefence` accumulates cost walking the chain and breaks
past `amountFactor (32-48) × metal income`, so a position is a budget
threshold. The launchers are **already in the default chain twice each**, at
positions 16 and 25 — cumulative 24 865 and 48 025 metal for Armada, needing
an income around 620. No cluster ever reaches them, so the class is never
built by any role. Position 7, the Juno, is at 2 565 and is the last entry a
well-funded cluster does reach.

So the swap is the only slot in which the launcher can exist at all. SUPPORT
was chosen because it disables its own T1 combat production and expects allies
to fight: a stockpiled ranged strike fired from behind its own porc is worth
more to it than a Juno, whose targets — radar, jammers, mines, scout spam — a
forward ally is better placed to handle.

Cost: +960 Armada, +540 Cortex, +590 Legion at position 7, pushing later
entries further out of budget. Accepted explicitly.

**Changes.** [`support.as`](../data/script/src/roles/support.as),
[`porc_helpers.as`](../data/script/src/helpers/porc_helpers.as) (`Replace`,
`ForSide`, the per-side tables),
[`porc-chain.md`](porc-chain.md), [`roles/support.md`](roles/support.md),
[`juno-targets.md`](juno-targets.md).

**Status.** Built, Checked. Not Played.

---

## D-006 — `areaUsable` stops being an absolute veto

**Decision.** `CTerrainManager::CanBeBuiltAt(cdef, pos)` ignores `areaUsable`
when the move type has no usable area anywhere on the map.

**Why.** SEA never built a shipyard on Eight Horses. The engine said the site
was buildable (`enginePossible=1`) and our terrain check said no
(`canBuildHere=0`). `areaUsable` means "this connected area is at least 16% of
the map" — a percentage with no absolute floor — and Eight Horses' water is
two ~4% pools, so no naval area is ever usable and every shipyard probe was
vetoed.

The fix is consistency rather than a new threshold. `GetAlternativeSector`
already degrades this exact test — `area.areaUsable || !largestArea->areaUsable`
— and the three-argument `CanBeBuiltAt` inherits that. The two-argument
overload, the one in the hot path, was the only place treating it as absolute.

Rejected alternative: copying the immobile type's absolute-area escape hatch
(`convertStoP² × sectors >= 1.8e7`). On Eight Horses each pool is ~5.2e6, so
it would not have helped, and inventing a lower constant would change
behaviour on every map to fix one.

This cannot put a shipyard on land — the sector must still belong to a navy
area — and `CFactoryData::GetFactoryToBuild` still refuses to *choose* a
factory whose mobile type is unusable, so only a deliberate AngelScript
`SelectFactoryHandler` reaches it.

**Changes.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp).

**Status.** Built. Not Played.

---

## D-007 — Spam's fusion-era gate is deliberate and stays

**Decision.** `MinMetalIncome` 60 / `MinEnergyIncome` 1500 are unchanged, and
the intent is written at the constant so it is not "corrected" later.

**Why.** This was initially misread as a bug — 1500 energy is several fusions
deep, and the units spam produces cost 30-120 metal each, so the gate looked
far too high. It is not. Below that economy those units are ordinary
front-line combat units and the roles should keep spending them as such; spam
is what a mature economy does with T1 factories it no longer needs for the
front line. That is also why `UnitByFactory` lists only T1 factories.

The real defect was never the threshold: spam activated twice in one game and
**created no route at all**, and nothing between activation and a unit moving
was logged, so the blocking guard could not be identified. Diagnostics were
added instead of changing balance.

**Changes.** [`global.as`](../data/script/src/global.as) (intent comment at
the constants), [`spam.as`](../data/script/src/manager/spam.as) (rejection
reporting, memoised), [`spam-routes.md`](spam-routes.md),
[KI-109](known-issues.md).

**Status.** Built, Checked. The underlying "activated but no route" cause is
**still unknown** — the diagnostics are verbosity 3 and the game that showed
the problem logged at 2.

---

## D-008 — Spam routes run through the combat front

**Decision.** A lane is factory → **front** → backline, and the front is
`CMilitaryManager::GetCombatFocusPos()`: the leader of the strongest ATTACK
squad, falling back to the enemy centroid.

**Why.** Spam's value is crossing the fight — vision and decoy targets where
the shooting already is — and what survives carrying on behind the enemy line.
Routing straight from factory to an enemy start position misses the fight
entirely, which is what the two interpolated 33%/66% waypoints did.

`focus` previously conflated two different things: where the run *ends* (an
enemy start spot, rotating on a 6-minute timer) and where it should *pass
through* (the front, which moves with the fighting). They are now separate,
with the front rebuilt whenever it moves more than `FrontMoveThreshold`.

A native accessor was unavoidable: script could reach neither the fighter
tasks nor the enemy groups. It is the only thing added to the script surface
for this.

In-flight units are sent **direct** to the new destination on a route change
rather than re-running the new lane from its nearest waypoint, which could
walk them backwards to pick the lane up. Newly produced units still get the
full lane, and the lane offset now applies to every waypoint including the
destination so parallel lanes stay parallel.

**Changes.**
[`MilitaryManager.h`](../src/circuit/module/MilitaryManager.h) /
[`.cpp`](../src/circuit/module/MilitaryManager.cpp) (`GetCombatFocusPos`),
[`MilitaryScript.cpp`](../src/circuit/script/MilitaryScript.cpp),
[`RouteTask.h`](../src/circuit/task/fighter/RouteTask.h) /
[`.cpp`](../src/circuit/task/fighter/RouteTask.cpp) (`IssueDirect`),
[`spam.as`](../data/script/src/manager/spam.as) (`UpdateFront`, `BuildRoute`),
[`global.as`](../data/script/src/global.as) (`FrontMoveThreshold`),
[`spam-routes.md`](spam-routes.md).

**Status.** Built, Checked. Not Played, and gated behind
[D-007](#d-007--spams-fusion-era-gate-is-deliberate-and-stays)'s unresolved
"no route created".

---

## D-009 — Spam keeps its task rather than an engine factory rally

**Decision.** Do not move spam to an engine-side factory rally queue with
repeat; keep one `CRouteTask` per factory with units assigned to it.

**Why.** The stated goal was to stop the AI micromanaging spam units. That
goal is already met: `CRouteTask::Update()` returns immediately unless
`dirty`, so steady-state per-frame cost is zero, and the only work is three
move commands issued once per unit.

A factory rally queue would mean leaving spam units **task-less**, and the
military manager would then re-task them into squads — the exact behaviour
spam exists to avoid. The task is what keeps them out of the army.

**Changes.** None.

**Status.** Deliberate non-change, open to revisiting.

---

## D-010 — The nuke cost floor is a regression, left unfixed pending a decision

**Decision.** Record the cause, do **not** change the floor yet.

**Why.** A TECH `corsilo` charged one missile and died without firing:

```
SUPER corsilo: no target | groups=16 inRange=16 bestCost=640 minCost=1500
```

`minCost` 1500 is exactly `crblmssl`'s `metalpershot`. The floor was
`GetWeaponDef()->GetCostM()` — for a stockpile weapon the **per-second
stockpiling rate**, a unit mismatch that produced a tiny floor and behaved
well by accident. Correcting it to `GetCostMShot()` during the Juno work is
dimensionally right and behaviourally wrong: it raised the nuke's floor
**180-fold** (8.33 → 1500) and Juno's 75-fold, and both stopped firing.

Underneath that, the floor is conceptually wrong for a stockpiled weapon at
all: the missile's metal is *already spent*, so comparing it to target value
asks the wrong question. Holding for break-even and dying with the shot in the
tube is the worst outcome available, and the rule selects it.

Not fixed yet because the floor's *meaning* has to be decided first — a plain
revert restores firing but reinstates the unit mismatch, so the weapon fires
at anything. That is a balance call.

**Changes.** [KI-110](known-issues.md) only. The regression itself is in
[`SuperTask.cpp`](../src/circuit/task/static/SuperTask.cpp).

**Status.** Superseded by [D-035](#d-035--a-stockpiled-shots-floor-decays-while-it-waits):
the floor keeps its honest units and decays while the shot waits.

---

## D-011 — The transport ferry is native mechanism plus script protocol

**Decision.** Sequencing lives in a native `CFerryTask`; who carries what,
where, and when lives in `Team::Ferry`.

**Why.** The [architectural rule](intent.md#the-architectural-rule): mechanism
native, policy in script. Load and unload need per-frame state, deadlines and
positional verification — the C++ wrapper exposes no `GetTransporter`, so a
load is inferred from the cargo's position tracking the transport's. None of
that belongs in script. Which ally gets a constructor, and when, is exactly
what script is for.

Deadlines on every state are not defensive padding: transports in Spring fail
to load for reasons the AI cannot observe, and a hung transport is strictly
worse than the walk it replaces. Every failure path falls back to giving the
constructor where it stands.

Heavy transports (`transportsize` 4, no mass cap) rather than light ones (size
3, 750 mass) because a T2 constructor's mass is not in the shared unit cache
and an unverifiable lift is not worth 120 metal. All six come from the T1 air
plant, so AIR can build one immediately. **The heavy choice is superseded** by
[D-022](#d-022--transports-are-capped-at-0-and-the-ferry-opens-one-slot):
reading the engine settled the mass question and the light one carries the
cargo.

**Changes.**
[`FerryTask.h`](../src/circuit/task/fighter/FerryTask.h) /
[`.cpp`](../src/circuit/task/fighter/FerryTask.cpp),
[`CircuitUnit.h`](../src/circuit/unit/CircuitUnit.h) /
[`.cpp`](../src/circuit/unit/CircuitUnit.cpp) (four cargo commands),
[`FighterTask.h`](../src/circuit/task/fighter/FighterTask.h) (`FERRY`),
[`MilitaryManager.cpp`](../src/circuit/module/MilitaryManager.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`ferry.as`](../data/script/src/manager/ferry.as),
[`donation.as`](../data/script/src/manager/donation.as),
[`transport-ferry.md`](transport-ferry.md), [KI-216](known-issues.md).

**Status.** Built, Checked. Played **badly** on the first attempt — see
[D-014](#d-014--transports-are-matched-by-role-mask-not-main-role). Not Played
successfully.

---

## D-012 — Coordination goes over `AiSendMessage`, never `CallUI`

**Decision.** AI-to-AI protocols use `AiSendMessage`. `ai.CallUI` is only a
display mirror.

**Why.** `CallUI` invokes `RecvSkirmishAIMessage` on the LuaUI of the machine
hosting the AI. It is one-way, local to that machine, and never reaches
another AI instance — it cannot carry coordination. `AiSendMessage` is the
channel the roster already uses and `CInitScript::SendMessage` confines it to
one ally team, which is the correct scope for both the ferry and the naval
assist.

Ferry and sea-assist events are still mirrored to the debug widget under their
own topics, because watching a protocol run is worth the two lines.

**Changes.** [`ferry.as`](../data/script/src/manager/ferry.as),
[`sea_assist.as`](../data/script/src/manager/sea_assist.as),
[`team.as`](../data/script/src/manager/team.as) (routing),
[`widget_link.as`](../data/script/src/manager/widget_link.as).

**Status.** Built, Checked. Not Played.

---

## D-013 — AIR flies the transport before transferring ownership

**Decision.** AIR keeps ownership for the flight to TECH's base and transfers
only on arrival, so the hand-over *is* the arrival.

**Why.** The original plan gave the transport to TECH the moment it finished.
That leaves TECH owning a unit on the far side of the map with no task that
knows where to send it — TECH would have to fly it home itself, which is the
problem the ferry exists to avoid, one level up.

The request was also triggered by the T2 lab being **enqueued**. That half
is **superseded** by
[D-016](#d-016--the-transport-request-is-income-gated-and-decoupled-from-the-t2-lab):
enqueue is when TECH plans the lab, not when it builds it, and the transport
arrived far too early. The fly-then-transfer half stands.

**Changes.** [`ferry.as`](../data/script/src/manager/ferry.as),
[`builder.as`](../data/script/src/manager/builder.as) (the T2-lab trigger in
`AiTaskAdded`),
[`unit_helpers.as`](../data/script/src/helpers/unit_helpers.as) (`IsT2Lab`),
[`transport-ferry.md`](transport-ferry.md).

**Status.** Fly-then-transfer: Built, Checked, not Played. Lab-enqueue
trigger: **Wrong**, replaced by D-016.

---

## D-014 — Transports are matched by role mask, not main role

**Decision.** `DefaultMakeTask` tests `cdef->IsRoleTrans()` on the role
**mask**, before the support branch; the main-role map entry is removed.

**Why.** This corrects [D-011](#d-011--the-transport-ferry-is-native-mechanism-plus-script-protocol)'s
first implementation, which failed in a game: the transport flew at the enemy
front instead of being donated, and AIR built transports forever.

Two independent faults:

1. `CFactoryManager`'s constructor runs
   `if (cdef.IsAbleToFly()) setRoles(ROLE_TYPE(AIR))`, overwriting the main
   role of every aircraft **after** the config is read. The
   `{ROLE_TYPE(TRANS), FERRY}` map entry is keyed on main role, so it could
   never match a flying transport — dead code from the moment it was written.
   The mask keeps `TRANS`; only the main role is clobbered.
2. The transports were not tagged at all. `armhvytrans`, `armatlas`,
   `corhvytrans`, `corvalk` had **no entry** in `behaviour.json`, and
   `legatrans` / `leglts` were tagged `["support", "air"]` — which routed them
   into `CSupportTask`, the same path as
   [D-001](#d-001--mobile-sensors-are-rationed-one-per-squad)'s clustering.
   The units were picked from the shared unit cache without checking they
   existed in the AI's own config.

Separately, the one-order latch was missing: `FactoryMakeTask` guarded on
`buildingId >= 0`, set only when the unit *exists*, so every factory idle poll
between the order and the unit popping queued another transport.

Because a missing tag caused this, `IsFerryTransport` now accepts the unit by
the `TRANS` mask **or** by matching `Global::Ferry::TransportBySide`, so the
script setting alone identifies the ferry.

**Changes.**
[`MilitaryManager.cpp`](../src/circuit/module/MilitaryManager.cpp),
[`behaviour.json`](../data/config/experimental_balanced/behaviour.json) and
[`behaviour_leg.json`](../data/config/experimental_balanced/behaviour_leg.json)
in all three experimental profiles,
[`ferry.as`](../data/script/src/manager/ferry.as) (`orderedFrame`,
`IsFerryTransport`),
[`global.as`](../data/script/src/global.as) (`OrderTimeoutSeconds`),
[`transport-ferry.md`](transport-ferry.md).

**Status.** Built, Checked. Not Played since the fix.

---

## D-015 — SEA seeds a TACTICAL ally with one construction ship

**Decision.** At +50 metal income, SEA gives one T1 construction ship to a
TACTICAL ally, once. TACTICAL lifts its shipyard caps when it **owns** a sea
constructor.

**Why.** TACTICAL starts with both shipyard caps at **0** — its only naval
restriction, and correct for a hover role alone. Next to a SEA ally it is
wrong: one construction ship lets TACTICAL expand along the coast beside SEA,
hold shoreline it is already suited to fighting over, and add naval economy
SEA does not have to build itself.

The unlock is keyed on **owning the constructor**, not on receiving the
donation message, because that is the condition that actually matters — a
construction ship arriving any other way should work too. The message is an
announcement.

Caps go to 2 / 1 rather than uncapped: `armcs` also builds land factories, and
the intent is coastal expansion, not restarting the build order on water.

Ties break on lowest team id so two SEA players seed the same ally properly
rather than one each halfway.

**Changes.** [`sea_assist.as`](../data/script/src/manager/sea_assist.as),
[`global.as`](../data/script/src/global.as) (`Global::SeaAssist`),
[`builder.as`](../data/script/src/manager/builder.as) (unit hooks),
[`team.as`](../data/script/src/manager/team.as) (routing),
[`roles/sea.md`](roles/sea.md), [`roles/tactical.md`](roles/tactical.md).

**Status.** Built, Checked. Not Played.

---

## D-016 — The transport request is income-gated and decoupled from the T2 lab

**Decision.** Any role may call `Team::Ferry::RequestTransport()`. TECH does
so on its own when its sliding-minimum metal income clears
`RequestMinMetalIncome` (20) while it owns no transport, and again after
`RequestCooldownSeconds` (180) if that is still true. The T2-lab trigger is
removed.

**Why.** The transport was observed arriving well before TECH started a T2
lab. The trigger in
[D-013](#d-013--air-flies-the-transport-before-transferring-ownership) hooked
`Builder::AiTaskAdded` on a FACTORY task for a T2 lab — but a task is added
when the role **plans** it, and TECH plans its lab long before a builder is
free to start it. "Enqueued" and "started building" are different moments and
the trigger picked the wrong one.

Income is the honest signal for "about to tech", and it makes the protocol
generic: nothing in the request is TECH-specific, so any teammate that wants
a transport can ask, and the receiving side keeps whatever transport arrives
rather than checking who it is.

The cooldown does two jobs. It re-asks when the transport dies, and it
handles AIR being busy: AIR serves one request at a time and **drops** others
rather than queueing them, because a queue is more state than the problem
deserves and the requester will ask again in three minutes anyway.

**Changes.** [`ferry.as`](../data/script/src/manager/ferry.as)
(`RequestTransport`, `_AutoRequest`, receiving branch no longer TECH-only,
AIR logs dropped requests),
[`builder.as`](../data/script/src/manager/builder.as) (trigger removed),
[`global.as`](../data/script/src/global.as) (`RequestMinMetalIncome`,
`RequestCooldownSeconds`), [`transport-ferry.md`](transport-ferry.md),
[`roles/tech.md`](roles/tech.md), [`roles/air.md`](roles/air.md).

**Status.** Checked. Script-only, no rebuild. Not Played.

---

## D-017 — Task-dependent orders are applied from the tick, never from a unit-added hook

**Decision.** Anything that needs a unit's `CFerryTask` — the hold position
on both sides of the hand-over — is applied from `Ferry::Update()`, retried
each tick until it takes. `OnUnitAdded` only records the unit id.

**Why.** The transport was built once and then idled over AIR's base. The
signalling was fine: the log showed the request, AIR's correct read of TECH's
position from the roster, one order, and the unit appearing. What failed was
the single `SetHoldPos` in `OnUnitAdded`.

Natively, `CMilitaryManager`'s `attackerFinishedHandler` assigns a new unit
to the **idle** task and *then* raises the script `UnitAdded` hook; the real
task comes later from `UpdateIdle -> MakeTask`. So the hook runs before the
`CFerryTask` exists, the cast fails, and a one-shot order at that moment is
silently lost. The "flying to" log line printed regardless, which is why the
log looked healthy — it reported intent, not effect.

The general rule that follows: a unit-added hook is the right place to
**remember** a unit and the wrong place to **order** it. Orders that depend
on the task go in the tick with a done-flag, and log only when they took.

Rejected: a native `HasHoldPos()` accessor plus a rebuild. Unnecessary — a
script-side flag per hold is enough, and the fix ships with `script/` alone.

**Changes.** [`ferry.as`](../data/script/src/manager/ferry.as)
(`_ApplyHold`, `buildingHoldApplied`, `transportHoldApplied`, honest logging,
`give` records the id), [`transport-ferry.md`](transport-ferry.md) (trap 4).

**Status.** Checked. Script-only, no rebuild. Not Played. The diagnosis is
grounded in the native ordering
([`MilitaryManager.cpp`](../src/circuit/module/MilitaryManager.cpp),
`attackerFinishedHandler`) and the log, not in a guess.

---

## D-018 — Cargo state is inferred from height above terrain, not 2D proximity

**Decision.** `CFerryTask` decides "loaded" and "landed" from whether the
cargo is lifted off the terrain by more than `FERRY_LIFT_HEIGHT`, with 2D
proximity kept only as a secondary check on the load side.

**Why.** The transport reached the cargo, started the pickup, and left without
it - and the log recorded a clean `delivered`. Both facts have one cause.
[D-011](#d-011--the-transport-ferry-is-native-mechanism-plus-script-protocol)
chose positional verification because the wrapper exposes no
`GetTransporter`, and implemented it as 2D distance. But the transport issues
the load while hovering **directly over** the cargo, so 2D distance is ~0 one
tick later regardless of whether the load has begun; the task advanced to
`TO_DROP`, issued the flight with options `0` - replacing the queue and
cancelling the load - and flew off empty. The "landed" test was the same check
inverted, so a cargo that was never lifted satisfied it at the drop, and
`GiveUnits` ran on a constructor still standing at home.

Height above terrain is the one observable the wrapper does expose that
separates the two states: a lifted ground unit is off the ground, an unlifted
one is not, and neither the approach nor the hover changes that.

The wrong version was reasoned, not careless: "a loaded unit sits at the
transport's position" is true. It is just also true of an unloaded unit under
a hovering transport. The 2D reasoning missed the third dimension the
transport actually moves in.

**Changes.** [`FerryTask.cpp`](../src/circuit/task/fighter/FerryTask.cpp) /
[`.h`](../src/circuit/task/fighter/FerryTask.h) (`IsLifted`,
`FERRY_LIFT_HEIGHT`, both state tests), [`transport-ferry.md`](transport-ferry.md)
(trap 5).

**Status.** Built, Checked. Not Played. The load itself has still never been
observed completing in a game; this is the first version where the test can
in principle report it honestly.

---

## D-019 — Donation counts are read and written as `int64`

**Decision.** Every local that goes through `Team::Donation::givenTo` is
`int64`, and `PickRecipient` logs the count it chose on.

**Why.** Two TECH players each gave both of their planned constructors to the
same ally - the closest one, its team's AIR player - with seven allies on the
roster. It happened in the pre-ferry game too, so the ferry was not the
cause. `PickRecipient` is "closest ally with the fewest so far", and reading
it, the count is written and read with the same key. The fault is in the
AngelScript dictionary add-on, and it is provable from its source:

- `set(key, c + 1)` with an `int` argument binds `set(const string&in,
  const int64&in)` - a widening conversion outranks the `?&in` overload - so
  the value is stored with `m_typeId = INT64`.
- `get(key, c)` with an `int` cannot bind `int64&out` (an `&out` needs the
  exact primitive) and takes `get(const string&in, ?&out)` with `INT32`.
- `CScriptDictValue::Get` returns the value only when `m_typeId == typeId`,
  and its fallback conversions handle a `double` or `int64` *target* only.
  There is no branch for an `INT32` target against a mismatched store. It
  returns `false` and leaves `c` at 0.

So every ally read as never-donated-to, ties went to the closest, and the
closest got everything. Making both sides `int64` makes both binds land on
the typed overloads and the round-trip exact.

The same pattern - `int` locals against `dictionary.get/set` - is worth
grepping for elsewhere; `roleMaskCache` / `roleTypeCache` in
[D-002](#d-002--the-eight-horses-crash-role-mask-passed-as-role-index) use
`int` on both sides and *work*, which is what makes this trap invisible: the
`?` set path stores the given typeId, so `set` via `?` + `get` via `?` matches.
It is specifically `set` binding the `int64` overload that breaks it, and
which overload wins is not visible at the call site.

**Changes.** [`donation.as`](../data/script/src/manager/donation.as)
(`PickRecipient`, both increment sites, the comment at `givenTo`).

**Status.** Checked. Script-only, no rebuild. **Necessary but not
sufficient** - Played, and it changed the failure rather than fixing it: see
[D-025](#d-025--a-dictionary-out-is-undefined-after-a-miss-check-exists-first).
The type mismatch described here was real; the `int64` read then exposed a
second rule of the same add-on.

---

## D-020 — A naval unlock must also seed a naval demand

**Decision.** When TACTICAL gains a sea constructor, `SeaAssist` lifts the
shipyard caps **and** enqueues a T1 shipyard at the ship's own position.

**Why.** [D-015](#d-015--sea-seeds-a-tactical-ally-with-one-construction-ship)
lifted the caps and stopped. In the game the ship arrived, `naval unlocked`
logged, and the ship never moved. A cap is permission; nothing in
`Tactical_BuilderAiMakeTask` or the native default task ever *asks* for a
naval structure, and every task TACTICAL had queued was on land a ship cannot
reach. Permission without demand is an idle unit.

The seed is placed where the ship stands - water it can certainly reach - at
priority NOW so the idle ship takes it on its next task query, with the ship
itself as the representer for the site test so the native area check is
answered by the unit that will do the building. One shipyard is enough: its
own build chain produces the rest.

**Changes.** [`sea_assist.as`](../data/script/src/manager/sea_assist.as)
(`SeedShipyard`, `UnlockNaval` now takes the unit),
[`global.as`](../data/script/src/global.as) (`SeedShake`),
[`roles/tactical.md`](roles/tactical.md), [`roles/sea.md`](roles/sea.md).

**Status.** Checked. Script-only. Not Played.

---

## D-021 — Spam spreads per unit across a band, converging on the endpoint

**Decision.** `CRouteTask::SetLanes(count, spacing, endSpread)` deals each
unit its own lane (0, +1, -1, +2, -2 ...) across the factory's line;
`Global::Spam::UnitLanes` 5, `UnitLaneSpacing` 160, `EndSpread` 0.35.

**Why.** [D-008](#d-008--spam-routes-run-through-the-combat-front)'s lane
offset was per **factory**. One spam factory therefore produced a single-file
column on one line: one shell took several units, and the column's vision was
one unit's vision. The intent was always a band - same path, same endpoint,
but space between units so they are not erased together and so the band sees
its own width as it crosses.

The spread is native, inside the task, because the task already owns the
per-unit order issue (`IssueRoute`, `IssueDirect`) and the lane has to
survive a retarget. The offset is perpendicular to the leg each point is on,
so the band follows the line's bends rather than shearing at corners. The
endpoint offset is scaled down by `EndSpread` because the run is aimed at one
backline: lanes converge most of the way back toward it instead of arriving
as a 1300-elmo line.

Rejected: one `CRouteTask` per lane, round-robined from script. More tasks,
more state, and a retarget would have to touch all of them; the offset is
three lines in `LanePoint`.

**Changes.** [`RouteTask.h`](../src/circuit/task/fighter/RouteTask.h) /
[`.cpp`](../src/circuit/task/fighter/RouteTask.cpp) (`SetLanes`, `AssignTo`,
`LanePoint`, `LaneOf`), [`InitScript.cpp`](../src/circuit/script/InitScript.cpp)
(registration), [`spam.as`](../data/script/src/manager/spam.as) (`RouteFor`),
[`global.as`](../data/script/src/global.as), [`spam-routes.md`](spam-routes.md).

**Status.** Built, Checked. Not Played, and still gated behind
[D-007](#d-007--spams-fusion-era-gate-is-deliberate-and-stays)'s unresolved
"activated but no route".

---

## D-022 — Transports are capped at 0 and the ferry opens one slot

**Decision.** Every transport def is capped at `maxThisUnit = 0` for every
role from the ferry's first tick. AIR raises the def it owes to owned+1 while
a request is open and closes it after the transfer. The default transport is
the **light** one.

**Why.** With the ferry finally working - the log showed two complete runs -
AIR built a second transport that no script line ordered, and it idled over
the advanced air plant. [D-014](#d-014--transports-are-matched-by-role-mask-not-main-role)
gave the transports a `["transport", "air"]` config entry so they would route
to `CFerryTask`; that same entry is what the native recruiter reads to fill
an air plant, so a transport became ordinary air production. A cap is the one
lever that gates *native* building and leaves the ferry's explicit
`TaskS::Recruit` intact: `IsAvailable()` is `maxThisUnit > count`, and the
ferry raises the cap by exactly one for exactly one order.

This is the third time the same lesson has cost a game: a config entry has
more readers than the one you added it for
([D-014](#d-014--transports-are-matched-by-role-mask-not-main-role) for the
main-role override, this for the recruiter).

Light rather than heavy: the mass that
[D-011](#d-011--the-transport-ferry-is-native-mechanism-plus-script-protocol)
could not verify from the unit cache is settled by the engine source -
`mass = GetFloat("mass", cost.metal)` - so a T2 constructor weighs its metal
cost, 410-470, under the light transport's 750. The light one is 68-74 metal
against 190 and the ferry never carries anything heavier. The user's
expectation was a T1 light transport; it turns out to be the right call.

Rejected: dropping the `"air"` tag instead of capping. The main-role override
adds `AIR` natively regardless, so the entry alone still makes the def a
candidate.

**Changes.** [`ferry.as`](../data/script/src/manager/ferry.as) (`_CapAll`,
`_OpenSlot`, `_CloseSlot`, availability test removed from `FactoryMakeTask`,
id captured before the fields are cleared - the `transport -1 arrived` log),
[`global.as`](../data/script/src/global.as) (`TransportBySide` light,
`AllTransportDefs`), [`transport-ferry.md`](transport-ferry.md) (trap 6,
config, the forward-base note).

**Status.** Checked. Script-only, no rebuild. Not Played.

---

## D-023 — A ferry transport gets its native task before any role policy

**Decision.** `Military::AiMakeTask` returns `aiMilitaryMgr.DefaultMakeTask(u)`
for any ferry transport before Spam and before the role's
`MilitaryAiMakeTaskHandler`.

**Why.** The transport reached TECH in every test and TECH never flew a
constructor. The log placed it: `received and reserved; hold pending task` at
f~4400, the hold applied at f~13600, and every donation between them on the
walk path. Both `_ApplyHold` and `TryCarry` require the transport's
`CFerryTask`, and it did not exist, because `Tech_MilitaryAiMakeTask` ends
with `if (metalIncome < 50) return null;` for every military unit. That gate
is right for TECH's army - it does not want early units roaming - and
[D-016](#d-016--the-transport-request-is-income-gated-and-decoupled-from-the-t2-lab)
requests the transport at +20, squarely inside the window it withholds tasks.
The two decisions were each reasonable and together produced a task-less
transport for the exact period the donations happen in. AIR has no such gate,
which is why its half always worked.

A role's military policy is about its army. A transport is not army and is
not spam; the only task that carries is the native one, and no policy should
be able to withhold it. Deciding that once, role-independently, at the top
of the dispatch is the same shape as the Spam and Ferry factory hooks.

Rejected: raising `RequestMinMetalIncome` to 50 to sit outside TECH's gate.
That couples the ferry to one role's threshold and would break the moment
either number moved; it also delays the transport past the first donations.

**Changes.** [`military.as`](../data/script/src/manager/military.as),
[`transport-ferry.md`](transport-ferry.md) (trap 7, message scope),
[`roles/tech.md`](roles/tech.md).

**Status.** Checked. Script-only, no rebuild. Not Played. This is the first
version in which a donation can actually reach `TryCarry` with a live task,
so the load test of [D-018](#d-018--cargo-state-is-inferred-from-height-above-terrain-not-2d-proximity)
has still not been exercised.

---

## D-024 — Decision lines log at level 1, because level 2 does not exist in a game log

**Decision.** Every branch that decides whether a T2 constructor is kept,
given, or ferried - and every reason `TryCarry` refuses - logs at level 1.

**Why.** A game produced four T2 constructors and no donation, with the
transport idle beside them. The log had one `Plan:` line per TECH and
nothing else, and it could not be explained: the `built` counter, the
keep/plan-met exits, `PickRecipient`, `No recipient`, and the
`primaryT2BotConstructor set` line from the builder handler were all level 2,
and `TryCarry` returned false with no log at any level. `define.as` sets
`LOG_LEVEL = 1`. Two hypotheses fit the surviving level-1 facts equally -
the hook ran at most twice, or `PickRecipient` returned -1 - and nothing in
the log could separate them. Rather than pick one and build a fix on it,
this instruments the path so the next game names the branch. **The
four-constructor case is therefore still open**; what is closed is the
possibility of a second uninformative game.

The general rule: anything that explains *why a unit did not do the obvious
thing* is level 1. Level 2 is for volume, not for decisions.

**Changes.** [`donation.as`](../data/script/src/manager/donation.as)
(entry line per constructor; keep/plan-met/no-recipient/pick promoted),
[`ferry.as`](../data/script/src/manager/ferry.as) (`_Refuse` with reasons,
`_Finish` reason), [`transport-ferry.md`](transport-ferry.md),
[`roles/tech.md`](roles/tech.md).

**Status.** Checked, then **Played**: the instrumentation named the branch
on the first game - `PickRecipient -> team -1 (count 1000000 of 7 allies)` -
and [D-025](#d-025--a-dictionary-out-is-undefined-after-a-miss-check-exists-first)
is the fix. The four-constructor case is closed.

---

## D-025 — A dictionary `&out` is undefined after a miss; check `exists()` first

**Decision.** No script code reads a primitive out-parameter from
`dictionary.get` without first checking `exists(key)` (or the return value
before using the variable). `Team::Donation` reads its counts through one
guarded `Count()`.

**Why.** With the level-1 instrumentation of
[D-024](#d-024--decision-lines-log-at-level-1-because-level-2-does-not-exist-in-a-game-log)
in place, the first game answered the four-constructor question directly:
constructor #3 reached `PickRecipient` in both TECH players and it returned
`-1` with `count 1000000 of 7 allies` - the sentinel never beaten, so every
ally's count read as at least a million.

The rule behind it: an AngelScript `&out` argument is passed through a
temporary that is **not initialised**, and that temporary is copied back to
the caller's variable **whether or not the callee wrote it**. So
`int64 c = 0; givenTo.get(key, c);` on a key that does not exist returns
false and leaves `c` as whatever was on the stack. The `= 0` never survives
the call.

This is the second rule of the same add-on to bite the same table.
[D-019](#d-019--donation-counts-are-read-and-written-as-int64) was right that
`set(int)` stored INT64 and `get(int&out)` could not read it - and by making
the read `int64` it made the read *succeed* on existing keys and *undefined*
on missing ones, which every key is until the first donation. Before D-019
the junk happened to read as 0 and the closest ally got everything; after it
the junk read huge and nobody got anything. Same defect, both symptoms.

An audit of every `dictionary.get` in the script tree found three more sites
using a primitive `&out` after a possible miss, one of them serious:

| Site | Effect on a miss |
| --- | --- |
| `porc_policy.as` cluster nano count | every cluster misses the first time; junk above `NanosPerCluster` returned before the first nano was queued - **cluster nanos could silently never be built** |
| `factory.as` per-factory nano count | junk count reported for a factory with no entry |
| `builder.as` track-eligibility flag | junk bool for a builder not yet in the table |

Handle-typed outs (`@x`) are safe - a handle temporary is null-initialised -
and the sites guarded by the return value or iterating `getKeys()` are safe.
String outs default-construct and are safe in practice; `ferry.as`'s side
lookup was guarded anyway.

**Changes.** [`donation.as`](../data/script/src/manager/donation.as)
(`Count`, `Bump`), [`ferry.as`](../data/script/src/manager/ferry.as),
[`porc_policy.as`](../data/script/src/manager/porc_policy.as),
[`factory.as`](../data/script/src/manager/factory.as),
[`builder.as`](../data/script/src/manager/builder.as).

**Status.** Checked. Script-only, no rebuild. The donation half is
diagnosed from a played game; the three audit sites are fixed on the same
evidence but their own symptoms were not observed. Whether a constructor is
then actually *lifted* remains the one thing never yet seen in play
([D-018](#d-018--cargo-state-is-inferred-from-height-above-terrain-not-2d-proximity)).

---

## D-026 — AIR spends a floating bank on a ring: build power, plants, energy, gantry

**Decision.** A late-expansion ladder in the AIR role, gated on floating
metal, placing everything on a ring well outside the core. T2 air
constructors run it before their native default; T1 air constructors run it
before their normal ladder.

**Why.** AIR sat at max metal and did not expand. Reading the role: the T1
policy caps at one T2 air plant and an income-based nano count, and the T2
air constructors had **no policy at all** - `Air_BuilderAiMakeTask` handed
them straight to the native default. Nothing in the role could ever ask for
a second plant, a fusion or a gantry, so a full bank had no outlet.

Three design calls inside it:

- **Floating, not rich.** The gate is `isMetalFull` or a current threshold
  *and* an income floor. A full bank on a dead economy is a different
  problem and this ladder would make it worse.
- **A ring, not a bigger radius.** "Building area" has no setting to turn
  up: `AllyRange` only governs an ally's zone, and placement is anchor plus
  search radius per structure. Anchoring late structures on a ring 1400 out,
  slot by count, is what actually grows the base outward instead of packing
  the core; slot 0 faces the map centre so the first expansion leans toward
  the fight.
- **The gantry is the T3 air step.** The experimental air plant is built
  only by the T3 air constructor, which only the gantry produces. There is
  no shorter route, so the ladder ends at the gantry and leaves gantry
  production to `FactoryProduction`.

Order is build power first because more plants with no nanos is more idle
plants; energy after plants because the plants define the demand; gantry
last because it is the most expensive and the least urgent.

Rejected: raising `MaxT2AircraftPlants` and `NanoMaxCount` globally. That
changes the early game too; the ladder is late-only by construction.

**Changes.** [`air.as`](../data/script/src/roles/air.as)
(`Air_LateExpansion_AiMakeTask`, `Air_IsFloating`, `Air_RingAnchor`,
`Air_ClampToMap`, both hooks), [`global.as`](../data/script/src/global.as)
(`Late*` settings), [`roles/air.md`](roles/air.md).

**Status.** Checked. Script-only, no rebuild. Not Played; the thresholds are
starting points. Watch for `[AIR][Late] ...` lines once a game floats.

---

## D-027 — Base layout is a plan: native geometry, script zones, shared over the roster

**Decision.** Proposed, not built: a `CLayoutPlan` of oriented zones and
reserved lanes, resolved natively against the blocking map; which zones a
role has, their extents, facing and lane widths are a `RoleConfig` delegate;
each teammate publishes its base rectangle and exit corridor over the roster
so every instance builds the same team plan. Full text in
[`base-layout.md`](base-layout.md).

**Why.** Bases clog because three native mechanisms that each make sense
never meet: block-map spacing (correct for explosions, blind to order),
nearest-free site search (a distance spiral from wherever the builder
stands), and per-structure anchors (the constructor's own position). Facing
is "away from the nearest map edge" and never looks at the lane. The nano
class reserves nothing. The result is the spiral you see; FRONT only looks
better because its anchors move forward.

The research settled two things that shape the design. Expert nano blocks
are safe **because a dying nano damages only nanos** (11 in 128) — so the
plan may pack them — while fusions (2 650 in 480) and advanced fusions
(10 600 in 1 280) dictate the energy spacing. And the corridor width is a
number, not a feeling: two T3 units abreast is ~320 elmos, one is 160. Those
facts live in the shared knowledge base, not here.

Three calls inside the proposal:

- **Row-major search inside a rectangle is the core change.** The same
  search in a different order inside a boundary is what turns clouds into
  blocks; it is stage 1 and works before any plan object exists.
- **Lanes only between two things that exist.** A corridor is reserved
  from a production zone to the front, or between two adjacent ally bases,
  never speculatively — that is how build area is kept.
- **Share the base rectangle and exit corridor, not the whole plan.** That
  is all a neighbour needs to stay out of the way and to compute the same
  link lane from its end.

Rejected: a Lua gadget for team layout. The plan is per-AI state resolved
from shared inputs, exactly like the roster; `AiSendMessage` is already
ally-team scoped at both layers.

**Changes.** [`base-layout.md`](base-layout.md) (proposal),
[`../../rjm.bar.docs/knowledge/20-game-mechanics/26-structure-explosions-and-base-spacing.md`](../../rjm.bar.docs/knowledge/20-game-mechanics/26-structure-explosions-and-base-spacing.md)
(game facts), [KI-111](known-issues.md).

**Status.** Proposal only. Nothing built; no code changed. **Superseded**
as the first thing to build by
[D-029](#d-029--layout-is-reservations-first-script-pushes-the-plan-native-owns-the-nano-block):
zones and lanes remain the later stages, reservations come first.

---

## D-028 — TECH spends a floating bank before its income-gated ladder; reserve-driven nanos are capped

**Decision.** `Tech_FloatSpend` runs at the top of both TECH constructor
policies while metal is floating; `ShouldBuildT1Nano`'s reserves branch is
capped at `reserveSurplus` beyond the income target.

**Why.** TECH built construction turrets one after another with nothing to
assist and metal overflowing, and never started the advanced converter or
the silo. Reading the policies gave two independent causes. The T1 nano
rule's reserves branch - metal over 1 000 and energy over 90% - is true on
every idle poll of a floating economy, has nothing to do with demand, and
stops only at `NanoMaxCount` 200. And the whole T2 ladder is income-gated:
converter at 1 200 energy income, fusions and silo at their own floors. A
full bank on a modest income cleared none of them, so the bank sat while the
T1 constructors spent it on nanos.

Two calls:

- **The bank is a justification.** Income gates are right when the question
  is "can I afford to run this"; they are wrong when the metal is already
  banked and idle. The float ladder asks the other question. Energy comes
  before a converter because a converter with nothing to convert is a
  second way to waste the bank.
- **T1 constructors assist rather than build.** They cannot build any of
  the float structures, and a T1 constructor with nothing to do standing
  next to a T2 constructor building a fusion is the definition of wasted
  build power. Guarding it is the existing `AssignWorkerGuard` path the
  ladder had commented out.

The nano cap is a default parameter, so every other role keeps its
behaviour except the runaway.

**Changes.** [`tech.as`](../data/script/src/roles/tech.as)
(`Tech_FloatSpend`, `Tech_IsFloating`, both hooks, the surplus argument),
[`economy_helpers.as`](../data/script/src/helpers/economy_helpers.as)
(`reserveSurplus`), [`global.as`](../data/script/src/global.as)
(`FLOATING METAL`, `NanoReserveSurplus`), [`roles/tech.md`](roles/tech.md).

**Status.** Checked. Script-only, no rebuild. Not Played; the thresholds
are starting points.

---

## D-029 — Layout is reservations-first: script pushes the plan, native owns the nano block

**Decision.** The base-layout proposal is rewritten around **reservations**:
at game start a role pushes the buildings it intends to build; native
reserves their ground in the blocking map, every existing placement search
avoids it, and a construction whose def matches a reservation is placed on
it. The one geometry native computes itself is the nano block; script sets
its size. Full text in [`base-layout.md`](base-layout.md).

**Why.** [D-027](#d-027--base-layout-is-a-plan-native-geometry-script-zones-shared-over-the-roster)
started from zones and lanes. The requirement is more concrete and better:
a role already knows its opener - the lab, its first nanos, its first solar
row - so the plan *is* the build order's footprint, pushed ahead of time. A
reservation is a specific building at a specific place; a zone is a region
with rules. The former is what keeps an initial base clean; the latter is
what organises growth, and it can come later.

Three calls:

- **Native avoids and matches; script decides.** Reservation is a
  `RESERVED` bit in the blocking map, so no search needs to know what a
  reservation is. Matching is on the def (exact, then class), consumed on
  site assignment, released on cancel. Which buildings, where, facing which
  way, and how many nanos are all script - a `LayoutPlanHandler` delegate
  per role.
- **The nano block is the one native geometry.** It depends only on
  footprints and `builddistance` that native already has, it is the same
  for every role, and hand-placing it is exactly the current mess. Script
  chooses the count.
- **Lanes last.** A reserved factory's exit yard already keeps its mouth
  clear; a corridor is a reservation of a class nothing consumes, made only
  between two things that exist.

**Changes.** [`base-layout.md`](base-layout.md) (rewritten, then given a
step-by-step implementation breakdown with files, sizes and proofs).

**Status.** Steps 1-4 built for TECH under [D-043](#d-043--reservations-are-built-tech-reserves-its-labs-a-4x10-nano-block-and-six-advanced-solars);
the other roles, sharing and lanes remain proposal.

---

## D-030 — A squad attacks when it outweighs what it can reach, or when it has waited long enough

**Decision.** Two script-set quotas on `CMilitaryManager`: `attackScale`
(> 0 switches a DEFEND squad's promotion bar from the map-wide
second-strongest enemy group to the strongest group its leader can
**reach**, scaled) and `attackWait` (> 0 promotes any squad that has waited
that long at or above `quota.attack`). Defaults for every role in
`Global::Military` (0.8 / 180 s); SEA sets 0.7 / 120 s.

**Why.** Cruisers massed for most of a game and never attacked; sprinters
and blitz did the same in a TECH base. `UpdateDefenceTasks` re-set every
DEFEND squad's bar to `max(quota.attack, PreMaxGroupThreat)`, and
`PreMaxGroupThreat` is `indices[newK - 2]` of the enemy groups sorted by
influence - the second-strongest group on the whole map, land or sea. SEA's
`quota.attack` is 1, so the threat term always bound, and a naval squad was
waiting to outweigh a land army it could never meet.

The reachable rule uses `CanMoveToPos(leader area, group pos)`, the same
test `CSupportTask` uses to pick squads. The wait cap is the honest
admission that a bar can be unreachable for reasons the AI cannot see: a
wave now beats parity never. Both are 0-means-legacy so the change is opt-in
per role; the global default opts every role in, because the land case was
observed too.

Rejected: lowering `quota.attack`. It is already 1 for SEA; the threat term
is the bar.

**Changes.** [`DefendTask.h`](../src/circuit/task/fighter/DefendTask.h) /
[`.cpp`](../src/circuit/task/fighter/DefendTask.cpp) (`createdFrame`, wait
cap), [`MilitaryManager.h`](../src/circuit/module/MilitaryManager.h) /
[`.cpp`](../src/circuit/module/MilitaryManager.cpp) (reachable bar),
[`MilitaryScript.cpp`](../src/circuit/script/MilitaryScript.cpp)
(`attackWait`, `attackScale`), [`global.as`](../data/script/src/global.as),
[`setup.as`](../data/script/src/setup.as), [`sea.as`](../data/script/src/roles/sea.as),
[`roles/sea.md`](roles/sea.md).

**Status.** Built, Checked. Not Played.

---

## D-031 — Siege artillery holds fire for anything but its ordered target

**Decision.** `CArtilleryTask::AssignTo` puts a `siege`-tagged unit on
**return fire**; `RemoveAssignee` restores fire-at-will.

**Why.** Longbows were shooting boats. `CArtilleryTask` only ever orders
structures - both target passes skip `IsMobile()` - and nothing routes naval
artillery elsewhere, so the AI's orders were already statics-only. What
remained was the engine's fire-at-will on a unit holding position. Return
fire is the one fire state that keeps the ordered target and self-defence
and drops everything else; it is scoped to `siege` so an ordinary artillery
unit is untouched, and undone on leaving the task so retreat and squads
behave as before.

**Changes.** [`ArtilleryTask.cpp`](../src/circuit/task/fighter/ArtilleryTask.cpp),
[`roles/sea.md`](roles/sea.md).

**Status.** Built, Checked. Not Played.

---

## D-032 — EMP ranks large statics first, then everything else by metal cost

**Decision.** `structures_first` becomes a cost floor:
`structures_first_min_cost` (1 500). Structures at or above it keep their
rank above mobiles; cheaper structures and all mobiles are one rank, ordered
by metal cost. A target that cannot be stunned is rejected before ranking,
as before.

**Why.** The request was "after the priority list, the highest-metal-cost
unit except EMP-immune ones". The old `structures_first` put *every*
structure above *every* mobile, so a 1 020-metal wall outranked a 5 000-metal
experimental. The floor keeps the intended "large statics first" and lets
cost decide the rest.

The observation that prompted it - the silo chose hovers over a Dragon
gunship - is not a ranking fault. BAR's `alldefs_post.lua` defines
`EMPABLE = SURFACE and paralyzemultiplier ~= 0`, and `armemp`'s weapon has
`onlytargetcategory = "EMPABLE"`. A VTOL is not SURFACE, so the Dragon is
not a legal target for the silo at all; the hover was the most expensive
thing it *could* hit. No AI change can alter that; it is the weapon.

**Changes.** [`MilitaryManager.h`](../src/circuit/module/MilitaryManager.h)
/ [`.cpp`](../src/circuit/module/MilitaryManager.cpp),
[`SuperTask.cpp`](../src/circuit/task/static/SuperTask.cpp),
[`behaviour.json`](../data/config/experimental_balanced/behaviour.json)
(all three profiles).

**Status.** Built, Checked. Not Played.

---

## D-033 — Spam decisions log at level 1; the fusion gate is left for the user to call

**Decision.** `[Spam] Route created`, `not spamming: <reason>` and the
throttled `Idle: mi=../.. ei=../..` line log at level 1. The activation gate
is unchanged.

**Why.** The report was that Blitz "should be acting as spam by this point".
The newest game had no `[Spam]` line at all - not even `Activated`, which is
level 1 - so spam never activated: the fusion-era gate
([D-007](#d-007--spams-fusion-era-gate-is-deliberate-and-stays), metal 60
and energy 1 500 as sliding minima) was not met. That is the design the
user set; whether "this point in the game" should qualify is a change to
that design, so it is raised here rather than made.

Separately, the diagnostics added in
[D-007](#d-007--spams-fusion-era-gate-is-deliberate-and-stays) were level 2
and 3, and `Route created` was level 2 - all invisible at `LOG_LEVEL 1`
([D-024](#d-024--decision-lines-log-at-level-1-because-level-2-does-not-exist-in-a-game-log)).
KI-109's "activated but no route" could never have been diagnosed from a
log; now it can.

**Changes.** [`spam.as`](../data/script/src/manager/spam.as).

**Status.** Checked. Script-only. The gate question is open.

---

## D-034 — AIR porcs for air denial, earlier, and on allied clusters

**Decision.** AIR registers a `PorcChainHandler` whose land order leads
with flak and long-range AA and repeats them, at the cost of duplicate
ground pieces, with Juno, gates, LRPCs and EMP launchers kept at their
counts; overrides `Global::Porc` in `Air_Init` so full porc arrives mid
game with a bigger budget; and sets a new native flag `porcAllyAA` so the
porc pass visits allied clusters and builds only AA there.

**Why.** The request was more porc from AIR by mid game, flak first then
long-range AA, less anti-ground, everything else maintained, and a lot more
AA on every cluster including teammates'. Reading the default chain
explained why AIR built almost no AA: `armflak` is never referenced by the
`land` sequence, and Mercury sits at position 12 behind ~14 000 cumulative
metal - unreachable in practice ([D-005](#d-005--support-swaps-its-juno-for-the-sides-tactical-launcher)
for why position is a budget threshold). "More frequently" is the cadence
policy in `porc_policy.as`, which is time- and income-gated by
`Global::Porc`; a role can retune those in its Init, so no new mechanism.

Allied clusters needed native work in two places: the porc pass only
iterated clusters this AI owns, and `DefaultMakeDefence` returned on
`IsZoneAlly`. The flag turns the return into an AA-only filter and widens
the iteration. AA-only is the point: an air role's contribution to a
teammate's cluster is air denial, and the teammate's own porc owns the
ground; building ground defence in someone else's zone would double-porc
and fight their layout.

Rejected: raising AA weights in `response.json`. That changes what every
role buys in reaction to enemy air; this is AIR's standing posture, which
is the chain's job.

**Changes.** [`air.as`](../data/script/src/roles/air.as) (`AirLandChain`,
`Air_PorcChain`, `Air_Init` overrides), [`global.as`](../data/script/src/global.as)
(`Porc*` under `RoleSettings::Air`),
[`MilitaryManager.h`](../src/circuit/module/MilitaryManager.h) /
[`.cpp`](../src/circuit/module/MilitaryManager.cpp) (`porcAllyAA`, AA-only
walk, allied cluster iteration),
[`MilitaryScript.cpp`](../src/circuit/script/MilitaryScript.cpp),
[`roles/air.md`](roles/air.md), [`porc-chain.md`](porc-chain.md).

**Status.** Built, Checked (every chain id validates against the cache).
Not Played.

---

## D-035 — A stockpiled shot's floor decays while it waits

**Decision.** A stockpiled super weapon's target floor starts at the full
shot cost the moment a shot is stocked and decays linearly to a minimum
fraction over a patience window; once enough shots are stocked the floor is
the minimum at once. `CMilitaryManager::SStockInfo`, read from a new
`stockpile` block in `behaviour.json` (`patience_seconds` 240,
`min_fraction` 0.25, `full_fire_count` 2).

**Why.** [D-010](#d-010--the-nuke-cost-floor-is-a-regression-left-unfixed-pending-a-decision)
left the nuke floor at the full 1500 `metalpershot` pending a call on what
the floor means. The ICBM report - "no target" with discovered bases, three
missiles stocked before the first fired - is that floor at work: group value
is only what the AI can currently see, and a discovered but unwatched base
reads as a few hundred metal. The two honest readings of the floor were
"the shot's price" and "nothing"; neither is right. The shot is already
paid for, so the floor is a patience: hold for a target worth the shot for
a while, then take the best one available, and with a full tube take
anything. Rejected: reverting to `GetCostM()` (the pre-session behaviour) -
that is a per-second stockpile rate compared against a group's metal, a
unit mismatch that fired at anything by accident.

**Changes.** [`SuperTask.h`](../src/circuit/task/static/SuperTask.h) /
[`.cpp`](../src/circuit/task/static/SuperTask.cpp) (`stockSinceFrame`,
`StockedShotFloor`), [`MilitaryManager.h`](../src/circuit/module/MilitaryManager.h)
/ [`.cpp`](../src/circuit/module/MilitaryManager.cpp) (`SStockInfo`, parse,
CONFIG line), `behaviour.json` x3 (`stockpile` block),
[`launcher-targets.md`](launcher-targets.md#the-floor),
[KI-110](known-issues.md#ki-110--closed-a-stockpiled-super-weapon-holds-its-shot-until-it-dies)
closed.

**Status.** Built, Checked. Not Played.

---

## D-036 — Tactical launchers aim by unit scan, and super statics bypass role policy

**Decision.** Two changes for "Perditions don't fire".

1. A stockpiled super weapon whose range is shorter than the map diagonal
   and that is neither a Juno nor an EMP - Perdition, Catalyst - is aimed by
   a new `CSuperTask::SelectLauncherTarget`: the shared `SelectAreaTarget`
   unit scan, candidates filtered by the weapon's own target category, aim
   points valued by the metal inside the AoE, held to the D-035 floor
   (`SelectAreaTarget` gained a `minValue`). Tunables
   `launcher_mobile_max_age`, `launcher_min_targets`,
   `launcher_structures_first` in the `stockpile` block.
2. `Military::AiMakeTask` routes every immobile def carrying the `super`
   role to `aiMilitaryMgr.DefaultMakeTask` before the role's
   `MilitaryAiMakeTaskHandler` runs, logged at level 1.

**Why.** The log had the answer for both Cortex and Legion launchers, every
minute: `inRange=0` against 8-15 enemy groups. The group scan measures
range to a k-means centroid, and with `1 + sqrt(N)` cells over the whole
map no centroid comes within 2300 of a launcher in one of our clusters. The
same log shows the Armada EMP firing (`EMP armemp(24890): rank=2 ...`),
which is the unit scan the EMP was given for a different reason. Rejected:
raising `KMEANS_BASE_MAX_K` or making the group count range-aware - a
per-weapon scan of units in range is cheap (the EMP already does it) and
does not change what every other consumer of the groups sees.

The second change is the TECH gate: `Tech_MilitaryAiMakeTask` returns null
for everything but a silo below +50 income, so a TECH Juno or Catalyst had
no `CSuperTask` until then. The idle task retries, so this was late rather
than never, but a commandfire static has exactly one possible task and no
role policy should be able to withhold it - the same reasoning as the ferry
guard in [D-023](#d-023--a-ferry-transport-gets-its-native-task-before-any-role-policy).
Not a cause of the Perdition report, which came from SUPPORT (no handler),
but found on the way and worth closing.

**Changes.** [`SuperTask.h`](../src/circuit/task/static/SuperTask.h) /
[`.cpp`](../src/circuit/task/static/SuperTask.cpp) (`SelectLauncherTarget`,
`minValue`, launcher branch in `Update`),
[`MilitaryManager.h`](../src/circuit/module/MilitaryManager.h) /
[`.cpp`](../src/circuit/module/MilitaryManager.cpp) (`SStockInfo` launcher
keys), `behaviour.json` x3, [`military.as`](../data/script/src/manager/military.as)
(super-static guard), [`launcher-targets.md`](launcher-targets.md) (new),
[`roles/support.md`](roles/support.md), [`roles/tech.md`](roles/tech.md),
[`AGENTS.md`](../AGENTS.md).

**Status.** Built, Checked against the log's counters. Not Played.

---

## D-037 — Builders focus one energy structure, and unused default tasks are discarded

**Decision.** Two changes for "TECH builds simultaneous solars and advanced
solars instead of focusing build power".

1. Native: `CBuilderManager::MakeTask` records every task that
   `DefaultMakeTask` *created* during the script call and aborts the ones the
   policy did not return; `IBuilderTask::Reevaluate` calls a new
   `ITaskModule::DiscardUnusedTask` on the task it makes and does not use.
   Tasks `DefaultMakeTask` merely found in the queue, and the mex tasks
   `MakeEconomyTasks` leaves for pickup on purpose, are untouched.
2. Script: `Builder::EnergyBuildTask` tracks the last T1 solar / advanced
   solar / converter the script queued; `Builder::EnqueueAssistEnergy` puts a
   constructor on it with a `Repair` task, up to
   `Tech::EnergyFocusMaxAssists`; `Tech_RedirectEnergyToReactor` tries it
   before every energy rung. The cooldown fallback assists that structure
   too, and its guard timeout drops from 200 s to 30 s.

**Why.** Every role's builder policy pre-creates the native default
(`Builder::MakeDefaultTaskWithLog`) so a mex or geo task can win, then runs
its own ladder. `DefaultMakeTask` is not a query: when it has to, it
**enqueues** what it returns - `UpdateEnergyTasks` adds an ENERGY task,
`MakeBuilderTask` a `Wait`. When the ladder returned its own solar (a
FACTORY-type task, invisible to the native ENERGY count), the native task sat
in `buildTasks` for `ASSIGN_TIMEOUT` and the next idle constructor took it.
With three constructors that was a native solar, a script solar and - the
script's solar rung on cooldown - a script advanced solar, all at once. The
same orphan is made by `IBuilderTask::Reevaluate`, which calls `MakeTask` and
keeps its current task when the kinds match. This is mechanism, so it is
fixed once natively rather than by rewriting six roles' policies; only tasks
created *for the caller* are discarded, because native economy code relies
on side-effect mex tasks being picked up later.

Focus itself is policy. The ladder had one assist rung (reactors); the
generalisation reuses its `Repair` mechanism, whose task ends with the
structure - which is also the answer to "switch to something new quickly when
finishing": the constructor re-plans the frame the solar completes. A guard
on another builder, the previous cooldown behaviour, does not end when that
builder's structure does, which is the stall the user saw.

Rejected: lowering the solar cooldowns (does not stop the native orphan);
making the ladder lazy and calling `DefaultMakeTask` only when needed (loses
the mex-first pre-check every role relies on, and leaves `Reevaluate`'s
orphan in place).

**Changes.** [`TaskModule.h`](../src/circuit/module/TaskModule.h)
(`DiscardUnusedTask`), [`BuilderManager.h`](../src/circuit/module/BuilderManager.h)
/ [`.cpp`](../src/circuit/module/BuilderManager.cpp) (`MakeTask` override,
`DefaultMakeTask` wrapper + `DefaultMakeTaskImpl`, `lastEnqueued`,
`freshDefaults`, throttled `BUILDER: discarded` log),
[`BuilderTask.cpp`](../src/circuit/task/builder/BuilderTask.cpp) (Reevaluate
discard), [`builder.as`](../data/script/src/manager/builder.as)
(`EnergyBuildTask`, `EnergyAssistTasks`, `GetEnergyUnderConstruction`,
`EnqueueAssistEnergy`, `_SetEnergyBuildTask`, cooldown assist/guard, release
in `AiTaskRemoved`), [`global.as`](../data/script/src/global.as)
(`Tech::EnergyFocusAssist`, `EnergyFocusMaxAssists`),
[`tech.as`](../data/script/src/roles/tech.as) (`Tech_RedirectEnergyToReactor`),
[`roles/tech.md`](roles/tech.md#energy-focus),
[`angelscript-references.md`](angelscript-references.md).

**Status.** Built, Checked. Not Played. The behaviour change in (1) applies
to every role.

---

## D-038 — Hovers are never spam

**Decision.** `armsh`, `corsh` and `legsh` lose the `spam` attribute in every
experimental profile, and the hover plants (`armhp`, `corhp`, `leghp`) leave
`Global::Spam::UnitByFactory`.

**Why.** User ruling: hover plants are to produce units normally all game.
Both halves are needed - the attribute is what `Spam::IsSpamDef` routes, and
the factory entry is what makes `Spam::FactoryMakeTask` put the plant on
repeat. Bot labs and vehicle plants keep their spam units unchanged.

**Changes.** `behaviour.json` x3, `behaviour_leg.json` x3 (attribute
removed on the three hovers), [`global.as`](../data/script/src/global.as)
(`UnitByFactory`), [`spam-routes.md`](spam-routes.md).

**Status.** Checked (JSONC valid). Config and script only; no rebuild needed.

---

## D-039 — Legion builds its own T2 shipyard

**Decision.** New `UnitHelpers::GetT2ShipyardForSide` (armada `armasy`,
cortex `corasy`, legion `legadvshipyard`); `Builder::EnqueueT2Shipyard` uses
it instead of its inline map, and SEA's income lab cap covers
`GetAllT2Shipyards()` rather than a literal `{armasy, corasy}`.

**Why.** "Tier 2 Legion sea is not building at all." The inline map sent
Legion to `corasy` on the assumption that Legion shares Cortex's navy. It
does not: game data gives `legnavyconship`, `leganavyconsub` and `legch` the
build option `legadvshipyard`, and none of them can build `corasy`. The
enqueued task was therefore unassignable, waited out its 600 s timeout, and
re-armed the 180 s T2-factory cooldown each time - a silent failure at
level 2 logging. `GetAllT2Shipyards()` and `factory_leg.json` already knew
`legadvshipyard`; only the enqueue path did not. Both callers
(`Sea_T1Constructor_AiMakeTask`, TECH's landlocked water expansion) are
fixed by the one helper.

**Changes.** [`unit_helpers.as`](../data/script/src/helpers/unit_helpers.as)
(`GetT2ShipyardForSide`), [`builder.as`](../data/script/src/manager/builder.as)
(`EnqueueT2Shipyard`), [`sea.as`](../data/script/src/roles/sea.as)
(`Sea_IncomeLabLimits`), [`roles/sea.md`](roles/sea.md#legion-t2-shipyard).

**Status.** Checked. Script only; no rebuild needed. Not Played.

---

## D-040 — A unit marked for reclaim is never repaired, by anyone on the team

**Decision.** Reclaim marks move up to `CAllyTeam`, the one object every AI
on an ally team shares: `MarkReclaim` / `UnmarkReclaim` / `IsReclaimMarked`,
counted per unit id and pruned in `UpdateFriendlyUnits` when the unit is
gone. `CBuilderManager::MarkReclaimUnit`, `RegisterReclaim` and
`UnregisterReclaim` mirror into it, and `IsReclaimUnit` answers true when
this AI **or any teammate** is reclaiming the unit. Every repair and assist
path then refuses or drops such a target: the nano candidate scans
(`CSRepairTask`, `CSReclaimTask`, `CFactoryManager::CreateAssistTask`,
already filtering on `IsReclaimUnit`), the mobile repair task's
`FindUnitToAssist` and `CBRepairTask::Reevaluate` (new checks), the
damaged-building handler, the abandoned-building scan, and a running
`CSRepairTask` whose target gets marked mid-repair.

**Why.** "Allies try to repair buildings that are marked for reclaim." Each
`CBuilderManager` kept its own `reclaimUnits`; a teammate's nanos scanning
friendly units saw a damaged building and repaired it while its owner - or
a script `TaskB::Reclaim` - was taking it down. The two AIs fought over the
structure and the metal never came back. The mark has to be visible where
the repair decision is made, in every AI, which is exactly what `CAllyTeam`
is for (it already holds the shared friendly-unit list). Rejected: an
`AiSendMessage` broadcast from script - the marks are made natively (reclaim
tasks, mex upgrades) and the repair decisions are native, so a script relay
would miss both ends.

**Changes.** [`AllyTeam.h`](../src/circuit/unit/ally/AllyTeam.h) /
[`.cpp`](../src/circuit/unit/ally/AllyTeam.cpp),
[`BuilderManager.h`](../src/circuit/module/BuilderManager.h) /
[`.cpp`](../src/circuit/module/BuilderManager.cpp),
[`task/common/RepairTask.cpp`](../src/circuit/task/common/RepairTask.cpp),
[`task/builder/RepairTask.cpp`](../src/circuit/task/builder/RepairTask.cpp),
[`task/static/RepairTask.cpp`](../src/circuit/task/static/RepairTask.cpp).

**Status.** Built (see change table). Not Played. Applies to every role; no
script lever, by the user's rule "anytime a building is marked for reclaim
it should never be repaired".

---

## D-041 — TECH donates T2 bots by plan, and T2 constructors only on request

**Decision.** `Team::Donation` is split in two. (1) The planned hand-out now
gives the **T2 combat bots** the advanced lab batches (fast T2 bots, or the
amphibious bot on landlocked starts), N drawn once between
`Tech::T2BotDonationMin` (2) and `T2BotDonationMax` (7) with the existing
geometric decay, each to the closest ally with the fewest so far; it never
touches constructors. (2) A **T2 constructor** is given only to a teammate
that asked (`barbdon|conreq`): TECH queues the request, its advanced lab
builds one extra constructor ahead of everything else
(`Team::Donation::FactoryMakeTask`, hooked into `Factory::AiMakeTask` beside
the ferry's), and the next T2 constructor to finish goes to the oldest
requester - flown by the ferry transport when TECH owns one, walked
otherwise. A non-TECH BARb asks automatically once, when it has no T2
constructor and no T2 lab and its income clears
`Global::ConstructorRequest::RequestMinMetalIncome`; roles may also call
`RequestConstructor`.

**Why.** The user's rules: a minimum and maximum on the number of T2 bots
donated (2 / 7), constructors excluded from that process, any teammate's
constructor request always honoured and delivered by air transport when one
is available. The old scheme (keep 2, donate 1..7 constructors, D-019/D-025)
gave constructors to teammates that had not asked and could not ask; the
request protocol reuses the ferry's message shape and the same
`AiSendMessage` channel ([D-023](#d-023--a-ferry-transport-gets-its-native-task-before-any-role-policy)
for its scope). The requester rule is the manager's default so the feature
is live without every role having to opt in; `MaxRequests` 1 keeps it from
draining TECH. Rejected: keeping a "KeepCount" for constructors - with no
automatic constructor donation there is nothing to keep from.

**Changes.** [`donation.as`](../data/script/src/manager/donation.as)
(rewritten), [`tech.as`](../data/script/src/roles/tech.as)
(`Tech_MilitaryAiUnitAdded`, wiring), [`global.as`](../data/script/src/global.as)
(`Tech::T2BotDonation*`, `Global::ConstructorRequest`),
[`factory.as`](../data/script/src/manager/factory.as),
[`team.as`](../data/script/src/manager/team.as), profile `main.as` x3
(`Team::Donation::Update`), [`roles/tech.md`](roles/tech.md#donations-t2-bots-by-plan-constructors-on-request),
[`roles/README.md`](roles/README.md), [`transport-ferry.md`](transport-ferry.md).

**Status.** Checked. Script only. Not Played.

---

## D-042 — The sea-constructor ladder is shared, and TACTICAL runs it

**Decision.** SEA's T1 and T2 construction-ship ladders move out of
`sea.as` into `helpers/sea_constructor_helpers.as` as
`SeaConstructor::T1Ladder` / `T2Ladder` / `AssistPrimary`, parameterised by
a `SeaConstructor::Settings` object; `FromSea()` fills one from
`RoleSettings::Sea`. SEA calls them with its own numbers (no behaviour
change). TACTICAL routes any construction ship it owns to a new
`Tactical_SeaConstructor_AiMakeTask`, which runs the same ladder with SEA's
numbers (`Tactical::SeaConstructorMimicsSea`). Sea constructors are
recognised by the unit-helper lists rather than a name suffix.

**Why.** The ship SEA donates to TACTICAL (`SeaAssist`) had its caps lifted
and one shipyard seeded, then idled: nothing in TACTICAL's builder policy
asked for naval eco or nanos, and every other task it had was on land. The
user asked that it mimic SEA and that the code be reusable, so the policy
is one function with the numbers as data rather than a copy. The suffix
test `"acsub"` was found on the way: Legion's `leganavyconsub` never
matched it, so a Legion T2 sub only ever got the default task.

**Changes.** [`sea_constructor_helpers.as`](../data/script/src/helpers/sea_constructor_helpers.as)
(new), [`sea.as`](../data/script/src/roles/sea.as),
[`tactical.as`](../data/script/src/roles/tactical.as),
[`global.as`](../data/script/src/global.as) (`Tactical::SeaConstructorMimicsSea`),
[`roles/sea.md`](roles/sea.md), [`roles/tactical.md`](roles/tactical.md#naval-unlock),
[`AGENTS.md`](../AGENTS.md).

**Status.** Checked. Script only. Not Played.

---

## D-043 — Reservations are built; TECH reserves its labs, a 4x10 nano block and six advanced solars

**Decision.** The reservation mechanism of [D-029](#d-029--layout-is-reservations-first-script-pushes-the-plan-native-owns-the-nano-block)
steps 1-4 is implemented natively for every role, and TECH is the first
role to push a plan. Native: a `RESERVED` struct bit; a reservation
registry on `CTerrainManager` (`ReserveBuilding`, `ReserveGrid`,
`ReserveNanoBlockAt`, release/query, `reservationMatchRadius`);
`FindBuildSite` serves the nearest unconsumed reservation of the exact def
before any spiral, and hands its facing to the task; tasks restore a
reservation on cancel and finish it on construction start. Script:
`LayoutHelpers`, `RoleConfig::LayoutPlanHandler`, `CCircuitDef::
GetFootprint*`, and `Tech_LayoutPlan`: the T1 and T2 bot labs side by side
with their backs against a 10 x 4 nano block (gap 0), and a row of six
advanced solars behind the block, all facing the map centre. No reservation
left for a def means the existing placement runs unchanged.

**Why.** The user's requirements: at least six reserved advanced solar
sites that an advanced solar always goes to first; a 4 x 10 nano block used
first; the existing placement as the fallback; and the T1 and T2 bot labs
reserved at game start with their backs tight against the block. All four
are one mechanism - "a footprint held for a def, served to the first build
of that def" - so the mechanism went in natively once and the TECH-specific
part is a 60-line plan of data. Two calls that looked like problems were
not: the commander stands on the lab site when the plan is pushed, but the
engine reports a mobile unit as *occupied*, not *blocked*, so the match
holds; and `Setup` runs in the same `AiGetFactoryToBuild` frame as the
native start-factory choice, before it, so the first lab lands on its
reserved site. Matching ignores the search anchor by default
(`LayoutMatchRadius` 0) because the user's rule is "if the bot ever goes to
place one it goes to a reserved location", not "if it happens to be near".
Nano block gap 0 is what players do and what the explosion data allows (a
dying nano hurts only nanos). Rejected: reserving through `block_map.json`
classes - the plan is per game and per role, not per def.

**Changes.** [`BlockingMap.h`](../src/circuit/terrain/BlockingMap.h) /
[`.hpp`](../src/circuit/terrain/BlockingMap.hpp) (`RESERVED`, `IsReserved`),
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h) /
[`.cpp`](../src/circuit/terrain/TerrainManager.cpp) (registry, reserve /
release / match, `FindBuildSite` hook),
[`BuilderTask.h`](../src/circuit/task/builder/BuilderTask.h) /
[`.cpp`](../src/circuit/task/builder/BuilderTask.cpp) (`reservationId`,
`TakeReservation`, restore on cancel, finish on target),
[`FactoryTask.cpp`](../src/circuit/task/builder/FactoryTask.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp) (registrations),
[`layout_helpers.as`](../data/script/src/helpers/layout_helpers.as) (new),
[`role_config.as`](../data/script/src/types/role_config.as),
[`setup.as`](../data/script/src/setup.as), [`global.as`](../data/script/src/global.as)
(`Tech::Layout*`), [`tech.as`](../data/script/src/roles/tech.as)
(`Tech_LayoutPlan`), [`base-layout.md`](base-layout.md#what-is-built),
[`roles/tech.md`](roles/tech.md#base-layout-plan), [`roles/README.md`](roles/README.md),
[`angelscript-references.md`](angelscript-references.md), [`AGENTS.md`](../AGENTS.md),
[KI-111](known-issues.md#ki-111--bases-are-laid-out-by-a-nearest-free-spiral-and-clog).

**Status.** Built (see change table). Not Played. The first game should
show the `RESERVE: grid ...` lines at f=151 and `RESERVE: served armlab`
for the start factory.

---

## D-044 — The ferry lands on clear ground, parks its cargo, and queues instead of walking

**Decision.** `CFerryTask`: the unload is ordered at the nearest clear
footprint for the cargo (`FindLandingSpot`, engine `FindClosestBuildSite`
within 320 elmos of the drop), retried twice with a widening search from
where the transport hovers, and a run that still fails with the cargo in
the air first **sets it down** (new `DUMPING` state, after `FAILED` so the
script's state numbers hold) before latching `FAILED`. `SetCargo` parks the
cargo in a builder `Wait` and stops it. Script `Team::Ferry`: a constructor
that arrives while a run is in flight is queued and flown next
(`queuedCargo`, `_StartNext` from `_Finish`); the queue walks only when the
transport is lost.

**Why.** Played: "the air transport picked up the constructor but doesn't
move, and the unit is transferred before delivery". The log had two
`FERRY: run failed (unload did not take)` and two `load did not take`. The
drop was the recipient's roster start position - its base - and Recoil
refuses an unload onto occupied ground without saying so; after the 20 s
deadline the fallback gave the constructor away while it still hung under
our transport. The load failures were the constructor taking a build order
and walking off mid-approach. Meanwhile every second constructor "walked"
because a run was in flight, against the rule that a transport, when owned,
always delivers. Rejected: raising the unload deadline - the ground does
not clear by waiting.

**Changes.** [`FerryTask.h`](../src/circuit/task/fighter/FerryTask.h) /
[`.cpp`](../src/circuit/task/fighter/FerryTask.cpp), [`ferry.as`](../data/script/src/manager/ferry.as),
[`transport-ferry.md`](transport-ferry.md#failure-paths).

**Status.** Built. Not Played.

---

## D-045 — Bomber waves scale with income, form lines, and attack by one of six methods

**Decision.** (1) A wave must hold `BomberWaveSizePerIncomeStep` (50)
bombers for every `BomberWaveIncomeStep` (100) of sliding-minimum metal
income before it launches - `AirWaves::Required()` raises the survival-grown
target to that floor, and production builds to it. (2) A new native
`CAirWaveTask` (`FightType::WAVE`, `TaskF::Wave()`) carries a script-drawn
plan: form a line abreast at a stand-off perpendicular to the attack
vector, hold if told, then attack-move down parallel lanes through the aim
(carpet) or dive on one chosen unit (strike); when the run is over it aborts
itself and each survivor is handed the plain bomb task once for the mop-up.
(3) `AirWaves::_PlanWave` draws one of six methods by weight - CARPET,
FLANK, PINCER, STRIKE, DEEP, FEINT - documented with their geometry in
[`air-wave-attacks.md`](air-wave-attacks.md). The vector for STRIKE/DEEP is
the quietest of twelve threat-map bearings; FLANK and PINCER rotate the
base->aim line by configured angles.

**Why.** Played: waves launched too small and did not fly as a formation.
The size rule is the user's, verbatim. The formation the native bomb task
already had (`AttackArea`) only appears in AREA mode - a cheap cluster and
no target worth `focus_cost` - so a wave that found one fat target flew as
a stream and one that found nothing flew as a stream; the user's
requirement is a line **before** the advance, every time, then an
attack-move so the wave carpets rather than stacks. Direct strikes on T3 /
big statics / AFUS were the earlier ask; STRIKE and DEEP are those. Six
methods drawn at random are the requested diversity. The task is native
because slots, the threat-sampled bearing and the formed-fraction test need
per-frame unit positions and the threat map; which method, how often, the
distances and the weights are script.

Rejected: forcing `CBombTask` into AREA mode for waves - it still picks its
own aim and bearing per retarget, so it cannot do FLANK, PINCER, FEINT or a
chosen strike; and extending `CRouteTask` - it moves, it does not fight.

**Changes.** [`AirWaveTask.h`](../src/circuit/task/fighter/AirWaveTask.h) /
[`.cpp`](../src/circuit/task/fighter/AirWaveTask.cpp) (new),
[`FighterTask.h`](../src/circuit/task/fighter/FighterTask.h) (`WAVE`),
[`MilitaryManager.cpp`](../src/circuit/module/MilitaryManager.cpp) (Enqueue),
[`InitScript.h`](../src/circuit/script/InitScript.h) / [`.cpp`](../src/circuit/script/InitScript.cpp)
(registration), [`task.as`](../data/script/src/task.as) (`FERRY`, `WAVE`,
`WaveMode`, `TaskF::Wave`), [`air_waves.as`](../data/script/src/manager/air_waves.as)
(`IncomeFloor`, `Required`, `_ChooseMethod`, `_PlanWave`, mop-up),
[`global.as`](../data/script/src/global.as) (`BomberWaveIncomeStep`,
`BomberWaveSizePerIncomeStep`, `Wave*`), [`air-wave-attacks.md`](air-wave-attacks.md)
(new), [`roles/air.md`](roles/air.md#t2-bomber-waves),
[`angelscript-references.md`](angelscript-references.md), [`AGENTS.md`](../AGENTS.md).

**Status.** Built (see change table). Not Played.

---

## D-046 — SUPPORT never receives an unrequested T2 constructor

**Decision.** `Team::Donation::Update` (the automatic constructor request)
skips the SUPPORT role - `Global::ConstructorRequest::AutoRequestFromSupport`
false - as it already skips TECH. An explicit
`Team::Donation::RequestConstructor` from any role, SUPPORT included, is
served exactly as before.

**Why.** User ruling: front-tech (SUPPORT) players tech themselves, so a
T2 constructor sent unasked is one TECH did not need to build; a request is
different and is always honoured. Since D-041 TECH gives constructors only
on request, so the only path to close was the requester's automatic ask.

**Changes.** [`donation.as`](../data/script/src/manager/donation.as)
(`_AutoRequestsForRole`), [`global.as`](../data/script/src/global.as),
[`roles/tech.md`](roles/tech.md).

**Status.** Checked. Script only. Not Played.

---

## D-047 — TECH's layout is tighter with solar rows, and its energy table is its own

**Decision.** (1) `Tech_LayoutPlan` reserves two rows of advanced solars
gap 0 straight behind the nano block and two rows of eight T1 solars
behind those, and slides a refused lab slot sideways/forward
(`_ReserveSliding`) instead of giving it to the spiral; a native refusal
now names the blocked cell and its masks. (2) `CEconomyManager` gains
`SetEnergyCondition(def, limit, metalIncome, energyIncome)` /
`GetEnergyLimit(def)` on the script API, per instance; TECH sets
`aiEconomyMgr.reclEnergyEff` to `Tech::ReclaimEnergyEff` (2.0, native 20)
and, when configured, its own solar / advanced-solar caps in `Tech_Init`.
(3) `Builder::AiUnitAdded` logs every finished construction turret with
the reserved slots still held.

**Why.** Played, first game of D-043: the T2 lab reservation was refused
("ground already blocked or reserved"), so it went to the spiral; the six
advanced-solar slots were consumed within minutes and every later advanced
solar was placed by the native energy base far from the labs - the
"quite far" the user saw; T2 constructors walking there is the waste.
Solars were not in the plan at all. Reclaiming: `ReclaimOldEnergy` fires
when an energy def finishes and reclaims only defs whose score x
`reclEnergyEff` is below the new one's; at the native 20 a solar (0.026)
is never reclaimed for an advanced solar (0.225). `economy.json` cannot
express a per-role value, but the manager is per instance, so a property
and a setter are the lever - no other role changes. The user did not see
nanos: the log shows forty `served armnanotc` sites, so they were placed;
the new finished-nano line settles whether they were built.

**Changes.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp)
(refusal detail), [`EconomyManager.h`](../src/circuit/module/EconomyManager.h) /
[`.cpp`](../src/circuit/module/EconomyManager.cpp) (`SetEnergyCondition`,
`GetEnergyLimit`), [`EconomyScript.cpp`](../src/circuit/script/EconomyScript.cpp),
[`global.as`](../data/script/src/global.as) (`Tech::Layout*`, `ReclaimEnergyEff`,
`EnergyLimit*`), [`tech.as`](../data/script/src/roles/tech.as) (`_ReserveSliding`,
plan rows, `Tech_Init` energy overrides), [`builder.as`](../data/script/src/manager/builder.as)
(nano log), [`base-layout.md`](base-layout.md#what-is-built),
[`roles/tech.md`](roles/tech.md#base-layout-plan), [`angelscript-references.md`](angelscript-references.md).

**Status.** Built (see change table). Not Played.

---

## D-048 — A nano slot is served only within reach of its factory, and every factory gets a block

**Decision.** `CTerrainManager::FindReservedSite` caps the match distance
for an immobile builder def at its `builddistance` + 128 elmos from the
search anchor; for a nano task the anchor is the factory it was asked for.
New `ReserveNanoBlock(CCircuitUnit* factory, nanoDef, cols, rows, gap)`
(script: `aiTerrainMgr.ReserveNanoBlock(CCircuitUnit@, ...)`) lays a block
behind a standing factory. `Tech_FactoryAiUnitAdded` reserves a
`LayoutFactoryNanoCols x Rows` (4 x 2, gap 0) block behind every factory
finished farther than `LayoutStartBlockRadius` (700) from the start.

**Why.** Asked whether a factory could be out of nano range under the
layout: yes, two ways. The start block is tight against the two bot labs
and every slot reaches both (worst corner ~380 elmos to either lab
centre, range 400 plus the lab's radius), but (1) with
`reservationMatchRadius` 0 *every* nano task - for the air plant, a third
lab, a gantry - was served a start-block slot, out of range of the factory
it was for; and (2) a lab whose slot was refused and went to the spiral is
wherever the spiral put it. The reach cap fixes (1) natively for every
role; the per-factory block keeps the other factories' nanos in neat
clusters rather than the spiral; (2) is addressed by D-047's slide search,
whose bound (6 x 32 sideways, then forward) keeps a slid lab within reach
of most of the block.

**Changes.** [`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h) /
[`.cpp`](../src/circuit/terrain/TerrainManager.cpp) (reach cap,
`ReserveNanoBlock`), [`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`global.as`](../data/script/src/global.as) (`Tech::LayoutNanoBlockPerFactory`,
`LayoutFactoryNano*`, `LayoutStartBlockRadius`), [`tech.as`](../data/script/src/roles/tech.as)
(`Tech_FactoryAiUnitAdded`), [`roles/tech.md`](roles/tech.md#base-layout-plan),
[`base-layout.md`](base-layout.md#what-is-built), [`angelscript-references.md`](angelscript-references.md).

**Status.** Built (see change table). Not Played.

---

## D-049 — Start positions are brokered through the host widget (proposal)

**Decision.** Proposal only ([`start-position-control.md`](start-position-control.md)).
The AI should not send `Game_sendStartPosition`; instead the host-side
widget queries each local BARb for its chosen spot (`barb|startpos`, from
the map config's role-tagged `StartSpots`, assigned deterministically by
allied team order) and sends BAR's own `aiPlacedPosition:<team>:<x>:<z>`
LuaRules message, which the game accepts from a player on the AI's side.
Fallback for autohosted AIs: relocate the commander after spawn.

**Why.** The engine path exists (`COMMAND_SEND_START_POS`, server accepts
it for `startpostype=2`) and BARb has `PickStartPos` already, but BAR's
`game_initial_spawn.lua` returns false from `AllowStartPosition` for every
AI team, so the position is discarded on every client and the AI is placed
by the start-point guesser. That is game code and cannot be worked around
from the DLL. BAR does provide `aiPlacedPosition` for human placement of
AIs; the only thing the DLL lacks is a player to send it, and this repo's
widget runs as the host player. Rejected: readying through
`SendStartPosition(true, ...)` (readies the host player, and still
discarded); a game modoption (game change).

**Changes.** [`start-position-control.md`](start-position-control.md) (new),
[`AGENTS.md`](../AGENTS.md).

**Status.** Research only. Nothing built.

---

## D-050 — Builders finish what they start, and the TECH plan is laid where the ground is open on both sides

**Decision.** (1) `Builder::AiMakeTask` returns null - keep the current
task - for a unit on a construction task whose structure already exists,
and `Tech_RedirectEnergyToReactor` (`Tech_IsBuilding`) never redirects a
unit that is on any construction task. (2) `Tech_LayoutPlan` searches: for
the facing toward the map centre and its two flanks, and side offsets
0, +-1..`LayoutSearchTries` x `LayoutSearchStep`, it computes the whole
plan (`_LayoutCandidate`), checks both labs with a native dry run
(`CanReserveBuilding`) and scores the buildable fraction of the ground
under the plan and `LayoutSideMargin` beyond each flank (native
`BuildableFraction`); the best candidate is laid, flank facings paying
`LayoutPerpendicularPenalty`. `_ReserveSliding` slides sideways only.

**Why.** Played (the D-047 build): 12 nano sites served, 2 restored, none
finished, 47 assist tasks - the assist rung answered every native
re-evaluation with a REPAIR task, a different kind from the NANO in
progress, and native swapped the unit; the T1 constructors likewise
flipped between guard, assist and build. The user's report: a turret
started and abandoned, another started, then an advanced solar; T1
constructors "stalled on assisting the factory" and retargeting. A unit
mid-construction must not be re-planned - the game's own build command
finishes the structure if left alone. On the layout: the T2 lab slot had a
mex under it (`RESERVE: refused armalab ... blocker 0x2`), the slide moved
the lab 128 elmos forward and off the block - "too far from the turrets".
The user asked that the block maximise building space on both sides and
avoid terrain blockers; a search over candidate placements scored by the
buildable ground around the plan is the direct form of that, and a mex
field or a cliff under a lab is simply a low-scoring candidate. Facing
stays toward the map centre (the enemy, in practice) unless a flank is
clearly more open. Rejected: sliding the lab forward (breaks "back to the
block"); scoring with the blocking map alone (misses slopes the engine
refuses).

**Changes.** [`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h) /
[`.cpp`](../src/circuit/terrain/TerrainManager.cpp) (`CanReserveBuilding`,
`BuildableFraction`), [`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`builder.as`](../data/script/src/manager/builder.as) (keep a started build),
[`tech.as`](../data/script/src/roles/tech.as) (`Tech_IsBuilding`,
`LayoutCandidate`, `_LayoutCandidate`, `Tech_LayoutPlan` search),
[`global.as`](../data/script/src/global.as) (`Tech::LayoutSearch*`,
`LayoutSideMargin`, `LayoutPerpendicularPenalty`), [`roles/tech.md`](roles/tech.md#base-layout-plan),
[`base-layout.md`](base-layout.md#what-is-built), [`angelscript-references.md`](angelscript-references.md).

**Status.** Built (see change table). Not Played.

---

## D-051 — TECH holds its turrets while the first T2 constructor is paid for, and owns the nano count

**Decision.** The ladder's nano rung is skipped while a T2 bot lab stands
and fewer than `MinimumT2ConstructorBots` T2 constructors exist
(`NanoHoldForFirstT2Constructors`) or while metal in the bank is below
`NanoMinMetalCurrent` (150); `NanoMetalPerUnit` rises from 10 to 15. Native
`CEconomyManager::CheckAssistRequired` gains two per-instance levers on the
script API - `assistNanoEnabled` and `assistNanoIncomeMod` - and TECH sets
the first to false in `Tech_Init`, so every TECH turret comes from the
ladder's count.

**Why.** Played: TECH built too many construction turrets early and
metal-stalled the T2 constructor at its new lab. Two sources fed it: the
ladder (one turret per 10 metal income, plus two on a full bank) and the
native assist path, which hands any factory a HIGH-priority nano the moment
income covers the factory's own draw - blind to what the script is trying
to pay for, and now that the layout serves a reserved slot instantly, no
longer slowed by placement. A turret during that window is metal taken
from the one unit that unlocks the role. The native source is left as a
lever rather than removed: other roles rely on it.

**Changes.** [`EconomyManager.h`](../src/circuit/module/EconomyManager.h) /
[`.cpp`](../src/circuit/module/EconomyManager.cpp) (`assistNanoEnabled`,
`assistNanoIncomeMod`), [`EconomyScript.cpp`](../src/circuit/script/EconomyScript.cpp),
[`global.as`](../data/script/src/global.as) (`Tech::Nano*`, `AssistNano*`),
[`tech.as`](../data/script/src/roles/tech.as) (`Tech_Init`, T1 ladder nano rung),
[`roles/tech.md`](roles/tech.md#construction-turrets-early-d-051), [`angelscript-references.md`](angelscript-references.md).

**Status.** Built (see change table). Not Played.

---

## D-052 — A land-locked start never spams

**Decision.** `Spam::IsEnabled()` is false when `Global::Map::LandLocked`
unless `Global::Spam::AllowLandLocked` (default false); the refusal is
logged once at level 1.

**Why.** TECH on Tundra Continents (both its start spots are flagged
land-locked in `maps/tundra_continents.as`) was building Grunts. Every
other T1 combat source is closed for TECH - `StartCapT1CombatUnits` 0 and
the defs set to ignore - and the bot lab's own batch already switches to
the amphibious AA bot on a land-locked start, so the Grunts were the spam
manager: at the fusion-era gate it puts every listed T1 factory on repeat
regardless of whether the units can leave the island. Spam is a way to
spend a mature economy on units that reach the enemy; on an island they
reach the shore. Rejected: substituting an amphibious spam unit - the T1
labs have none worth a stream, and the role's landlocked expansion
(shipyards, hover plants) is the intended outlet.

**Changes.** [`spam.as`](../data/script/src/manager/spam.as),
[`global.as`](../data/script/src/global.as) (`Spam::AllowLandLocked`),
[`spam-routes.md`](spam-routes.md#settings-globalspam).

**Status.** Checked. Script only; no rebuild needed. Not Played.

---

## D-053 — The layout becomes a complex of nano blocks, zones, corridors and routes (proposal)

**Superseded for TECH by [D-060](#d-060--tech-layout-uses-native-canonical-clusters-and-an-ordered-economy-module).**
The record below is retained because it explains the replaced design and the
reservation mechanisms D-060 kept.

**Decision.** Proposed, not built. The TECH plan is redesigned in
[`layout-design.md`](layout-design.md): a *complex* of a factory line
(labs facing the lane point, backs on a line), a small nano block behind
each factory, a 4-row nano *spine* whose length is measured in 192-elmo
*bays* (4 nano columns = 3 converter columns = 2 fusion columns), a
converter zone on the spine's front flank behind a 176-elmo firebreak and
an advanced-fusion zone tight on its rear flank; every zone is planned
whole at setup and laid in *bands* over time, the early energy (solars, T1
converters, advanced solars, fusions) being *tenants* of the cells their
successors will take after reclaim; *corridors* (exit cones, ring road,
breaks every three bays, the firebreak) are cells no site search may use;
*routes* give a band a dedicated builder with a repeating def; the whole
system is off by JSON default (`layout.enabled`) and switched on per AI
from AngelScript. The user decides the open points listed in the document
before anything is built.

**Why.** The numbers. A nano reaches 400 + the target's radius, so a
4-row block reaches four rows of advanced converters or two of advanced
fusions from every row; a dying nano hurts only nanos, so anything may
stand against a block; but an advanced converter's death kills nanos to
173 elmos and chains through a tight converter zone at any practical
spacing, and an advanced fusion's death kills nanos to 1 212 and another
advanced fusion under 278 - a firebreak works for the converters and is
impossible for the fusions, which therefore go to the rear. Reclaim
returns all metal, so tenancy costs only build time. The current 10 x 4
block over-serves the labs (players assist a T1 lab with 1-3 nanos, a T2
lab with 4-8) and under-serves the economy, its solar rows are dead
ground once reclaimed, it faces the map centre instead of the lane, and
nothing protects a factory's exit before the factory stands. Rejected:
tight converters against the spine (the whole spine dies with the first
converter; kept as a setting for comparison); a separate fusion zone out
of nano reach (built by mobile constructors only; kept as a user
decision); a fully native composer (faster, harder to tune; the split of
geometry native and plan script is recommended).

**Changes.** Design: [`layout-design.md`](layout-design.md) (new),
[`base-layout.md`](base-layout.md) (pointer), `AGENTS.md`, and the
knowledge base's explosion table (a nano's death deals 530 to other
nanos, not 11). Built, at the user's instruction, with the six open points
taken as recommended and every one of them a setting: native
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h) /
[`.cpp`](../src/circuit/terrain/TerrainManager.cpp) (`layoutEnabled` from
`behaviour.json` `layout.enabled`; zones and corridors; `LayBand`,
`ArmGroup`, `ReleaseUnconsumed`, `NextSlot`, `NextBuilt`, `FlatFraction`,
`ReserveExitCone`, `DescribeLayout`; slot lifecycle on `DelBlocker`; pinned
and armed serving in `FindReservedSite`; every `Reserve*` inert while the
flag is off), [`TerrainData.h`](../src/circuit/terrain/TerrainData.h)
(slope map accessors), [`BuilderTask.h`](../src/circuit/task/builder/BuilderTask.h)
/ [`.cpp`](../src/circuit/task/builder/BuilderTask.cpp) and
[`FactoryTask.cpp`](../src/circuit/task/builder/FactoryTask.cpp)
(`PinReservation`, `FinishReservation(id, unitId)`),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp) (the script API,
`aiSetupMgr.GetLanePos`, `AiPinReservation`); `behaviour.json` and
`behaviour_leg.json` in all three profiles (`layout.enabled` false); script
[`manager/layout.as`](../data/script/src/manager/layout.as) (new: the
composer, phases, tenant reclaim, routes, overlay),
[`roles/tech.as`](../data/script/src/roles/tech.as) (`Tech_LayoutPlan`
calls `Layout::Plan`; `Layout::Enable` in `Tech_Init`; `Layout::Update`
from `Tech_EconomyUpdate`; routes first in `Tech_BuilderAiMakeTask`;
`Layout::ReclaimTenantFor` before an advanced converter or fusion;
`Layout::OnFactoryBuilt` for factories away from the complex),
[`global.as`](../data/script/src/global.as) (`Tech::Layout*` rewritten),
[`manager/commands.as`](../data/script/src/manager/commands.as)
(`layout`, `route` verbs),
[`gui_barb_team_link.lua`](../tools/widgets/gui_barb_team_link.lua)
(`/barblayout`, `/barbroute`); docs [`roles/tech.md`](roles/tech.md#base-layout-plan),
[`angelscript-references.md`](angelscript-references.md), `known-issues.md`
(KI-405).

**Status.** Built (see change table). Not Played. The user's constraint -
no other role's placement changes - holds by construction: the native side
does nothing while `layoutEnabled` is false, the JSON default is false, and
only `Tech_Init` sets it.

---

## D-054 — TECH's own economy settings wait for +20 metal and +1000 energy

**Decision.** TECH starts on the shared `economy.json` defaults (native
reclaim efficiency 20, the json energy limits, native assist nanos on) and
applies its own economy settings - `ReclaimEnergyEff` 2.0, `EnergyLimit*`,
`AssistNanoEnabled` false, `AssistNanoIncomeMod` (D-047, D-051) - once the
10-second minimum metal income is at least `EconomySwitchMetalIncome` (20)
and energy income at least `EconomySwitchEnergyIncome` (1000).
`EconomySwitchEnabled` false restores the old behaviour (applied at init).

**Why.** Asked for by the user: the aggressive settings (reclaiming solars
the moment an advanced solar stands, no native assist nanos) suit an
economy that is already rolling; before that the defaults are the safer
opening. The switch is one-way and logged at level 1 at both ends. Nothing
else about TECH's opening changes: the ladder's own gates (D-051's nano
hold, the energy rungs) are script-side and unaffected.

**Changes.** [`tech.as`](../data/script/src/roles/tech.as)
(`Tech_ApplyEconomySettings`, `economySwitched`, the check in
`Tech_EconomyUpdate`), [`global.as`](../data/script/src/global.as)
(`Tech::EconomySwitch*`), [`roles/tech.md`](roles/tech.md#energy-settings-this-role-only).

**Status.** Checked. Script only; deployed with the script tree; no rebuild.
Not Played.

---

## D-055 — Every factory is planned on the line before it is enqueued, and a served slot is kept

**Decision.** Three things. (1) `CBFactoryTask::FindBuildSite` keeps a
served reservation across retries and accepts a served slot without the
front-ground test. (2) The labs' nano blocks go behind the slot actually
reserved (slid or not). (3) Every later land factory gets a slot on the
front line before it is enqueued: the `Builder::Enqueue*` factory helpers
call `Layout::PrepareFactory(def)`, which reserves the next place beside
the outermost factory on the shorter side with its nano block and exit
cone; a factory the spiral still places gets both where it stands.

**Why.** Played: labs sometimes stood against their turrets and sometimes
not. Two native paths explain the "sometimes": the fixed-facing early
return ran on any second `Execute` and moved a lab whose slot had been
served back to the shaken anchor; and `checkFacing` tested the ground a
full footprint in front of a served slot and, refusing it for a rock, left
the slot consumed while the lab went to the spiral. The blocks were laid
at the plan's position, not the slid one. And every factory after the two
labs was placed by the spiral and only *then* given a block (D-048) - a
block that had to fit whatever was behind it. Planning the slot first is
the only way the turrets are known before the factory exists, which is
what the user asked for.

**Changes.** [`FactoryTask.cpp`](../src/circuit/task/builder/FactoryTask.cpp),
[`layout.as`](../data/script/src/manager/layout.as) (`LayFactorySlot`,
`PrepareFactory`, `OnFactoryBuilt` by planned-slot proximity),
[`builder.as`](../data/script/src/manager/builder.as) (eight factory
helpers), [`roles/tech.md`](roles/tech.md#base-layout-plan).

**Status.** Built (see change table). Not Played.

---

## D-056 — The ferry flies on the engine's load, not on a lift bar

**Decision.** `CFerryTask` queues the flight to the drop behind the load
order (shift option), treats any lift (4 elmos, was 24) as loaded, and
treats "on the ground within 1 elmo for two updates running" as landed.

**Why.** Played: team 9's Valkyrie delivered every run; team 10's Atlas
picked its constructor up and never moved (`load retry 1`, `load retry 2`,
`run failed (load did not take)`), and the fallback gave the constructor to
the recipient while it still hung under the transport - the engine does
not detach a unit that changes team. The Atlas holds its load a few elmos
up until told to move, below the old bar; the move was only sent once the
bar was cleared. Rejected: an engine query for the carrier - the wrapper
has none.

**Changes.** [`FerryTask.h`](../src/circuit/task/fighter/FerryTask.h) /
[`.cpp`](../src/circuit/task/fighter/FerryTask.cpp),
[`transport-ferry.md`](transport-ferry.md) (trap 8).

**Status.** Built (see change table). Not Played.

---

## D-057 — The nano cluster is the anchor: head strip, spine, flanks tight on both sides

**Superseded by [D-060](#d-060--tech-layout-uses-native-canonical-clusters-and-an-ordered-economy-module).**

**Decision.** The complex is re-oriented. A *head strip* of two nano rows
runs the whole width behind the front line; both labs (and every later
factory) back onto it with their blocks laid in it. The spine runs back
from the head strip, away from the enemy, and grows a bay at a time in
that direction. The converter zone is tight on one side of the spine
(`LayoutConverterSide`), the fusion zone tight on the other, a storage
strip beside the converters in the first bay; the gaps are settings at 0.
Winds are the fusion zone's first tenant (fusions replace them, advanced
fusions replace those). The site search also tries forward and back
offsets and scores the best few candidates in full.

**Why.** Played (the first D-053 game): the Legion T1 lab stood against a
cliff with no turret near it, T1 converters and advanced solars were
spread across bays 270 elmos behind the labs with empty corridors on both
sides, and the spine - the only nanos the early economy was meant to sit
against - was not armed until +40 metal. The user's requirement is the
opposite: the first construction-turret cluster predetermined at game
start with building space on both sides, and every building tight to it.
The previous shape put the spine last and the eco zone between two
corridors; this one puts the cluster first and the zones on its flanks.
The firebreak the numbers argue for (D-053) is kept as a setting, off.

**Changes.** [`layout.as`](../data/script/src/manager/layout.as) (rewritten
geometry: `ComputeGeometry`, `BayFront`, `HeadBlock`, flank bands laid with
the outward facing, `LayRear`, two-stage siting),
[`global.as`](../data/script/src/global.as) (`LayoutHeadRows`,
`LayoutConverterSide`, `LayoutFusionGap`, `LayoutStorageStrip`,
`LayoutSearchAlongTries`, `LayoutSearchRefine`; `LayoutConverterFirebreak`
0; `LayoutRingRoad` and `LayoutFusionZoneRear` gone),
[`unit_helpers.as`](../data/script/src/helpers/unit_helpers.as) (wind,
storage, geo names by side), [`layout-design.md`](layout-design.md),
[`roles/tech.md`](roles/tech.md#base-layout-plan).

**Status.** Built (see change table). Not Played.

---

## D-058 — TECH's economy is a deterministic function of the game's state

**Decision.** `EcoPlanner::Decide` ([`eco-planner.md`](eco-planner.md))
names the next economy structure from the map's wind range (current wind
and tidal are logged, not decided on), energy and metal income, banks and
storage, what stands, the constructor tiers on the field and what the
asking constructor can build: energy
short - the cheapest metal per E/s the constructor can build and the bank
affords soon; energy floating - a converter; storages by rule; metal
floating - the best-payback energy anyway; else nothing. It runs before the
old solar / converter / fusion rungs of the T1, T2 and commander ladders,
which stay behind `EcoPlannerEnabled` false. D-062 adds a script-controlled
home-mex bootstrap over a narrow native spot/enqueue API; later mex work stays
native. Every
advanced-fusion and advanced-converter choices are now intercepted by D-060's
exact rear-module progression; other structures use normal placement.
Native exposes the map's wind, tidal and metal-spot count to script.

**Why.** Asked for: the fastest economy scaling the meta knows, as one
function that designs the order and re-adjusts it. The meta's numbers
(mex 25 s payback, moho 95 s, wind at a good average the cheapest energy,
advanced solars and fusions equal per E/s, solars twice as dear, an energy
target of 10-25 E per M) reduce to two comparisons - metal per E/s among
affordable options when short, converters when floating - which is what
the function does. Rejected: a fixed build list (does not re-adjust); a
generic ROI over everything including mexes (native already serves mexes
first, and a list that argues with it costs the first 25-second payback).

**Changes.** [`eco_planner.as`](../data/script/src/manager/eco_planner.as)
(new), [`tech.as`](../data/script/src/roles/tech.as) (planner first in the
T1, T2 and commander ladders), [`builder.as`](../data/script/src/manager/builder.as)
(`EnqueueT1Wind`, `EnqueueT1EnergyStorage`, `EnqueueT1MetalStorage`),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp)
(`ai.GetWindMin/Max/Cur`, `GetTidalStrength`, `GetMetalSpotCount`),
[`global.as`](../data/script/src/global.as) (`Tech::Eco*`),
[`eco-planner.md`](eco-planner.md) (new), [`roles/tech.md`](roles/tech.md#the-eco-planner-d-058).

**Status.** Built (see change table). Not Played.

---

## D-059 — The 2026-09-20 code review is applied in full

**Decision.** Every finding of
[`reviews/2026-09-20-uncommitted-code-review.md`](reviews/2026-09-20-uncommitted-code-review.md)
(CR-001 to CR-025) and the three found while verifying it are applied;
the change-by-change account with before/after code is
[`reviews/2026-09-20-code-review-fixes.md`](reviews/2026-09-20-code-review-fixes.md).
Two priorities were re-rated (CR-003 down, CR-013 up) and one finding
turned out to be a gate configuration (CR-025: the repository's files are
committed with CRLF, so `git diff --check` needs `core.whitespace=cr-at-eol`
to see past the carriage returns; nothing was changed in git config).

**Why.** The review verified as accurate on all 25 points; the P1s are a
crash, two unit-loss paths, a friendly-fire path and a planner that hands
the commander a structure it cannot build. Nothing in the set is worth
carrying into a played game.

**Changes.** See the fixes document; native and script, plus the
documentation corrections it lists.

**Status.** Built (see change table). Not Played. The script-side save/load
gap recorded by KI-406 was closed by D-060's named native registry.

---

## D-060 — TECH layout uses native canonical clusters and an ordered economy module

**Progression amended by [D-062](#d-062--tech-opens-on-home-metal-and-scales-by-regional-build-power):**
Supreme reserves four nano rows, rows grow from regional build power, and
converter tranches use measured surplus.

**Decision.** Replace D-053/D-057's script-composed bays, tenants and
unbounded nano spine with dependency-free native geometry for atomic factory
clusters and one compact rear economy module. Experimental JSON permits the
mechanism; only TECH opts in. Script selects candidates and controls build
progression.

**Why.** The previous design repeated footprint/orientation arithmetic in
AngelScript, stored group identity only in script globals, admitted partial
bands, allowed exact pins to fall through to the spiral, and depended on a
large evolving complex that was difficult to verify. The replacement keeps the
repaired reservation handshake from D-059 but makes the native registry
authoritative.

Centres are represented in half-cell units so odd and even rotated footprints
snap exactly. The T1/T2 factory defaults are fixed layouts derived from actual
`CCircuitDef` footprints: two rear nanos for a six-cell T1 lab and six in a
centred `3 x 2` block for a nine-cell T2 lab, with a 20-cell exit rectangle
four cells wider than the factory. The default economy module is one
24x27-cell blast domain (4 AFUS, 24 nanos, 18 advanced converters) or a
12x27 half tier (2/12/9), with no internal gap and a four-cell exterior
access corridor. D-062 lets Supreme reserve a fourth nano row (32/16 nanos).

Full-tier candidates are tried before half-tier candidates over increasing
rear distances (starting with a compact 12-cell front-edge setback) and alternating
side offsets. Each cluster/module preflights
every exact slot and corridor, commits atomically, and rolls back only its own
objects on failure. Module slots remain unarmed and are claimed only through
`EnqueueLayout`. Their canonical order is far-to-near. Policy completes the
factory-specific rear nano groups and then the currently justified module
nano rows before starting one AFUS, four baseline converters, and a fifth
only from measured surplus; only one AFUS frame may be active. Slot selection
filters that order by the asking constructor's reachability.

Required pins never fall back to ordinary placement. A failed pin aborts the
task through its normal lifecycle, allowing policy to retry later. Runtime
role leave aborts all layout-owned tasks before clearing the registry. Named
groups/zones, ordering, claims and factory-line metadata are serialized, and
script adopts restored state by name rather than retaining native IDs.
Factory tasks claim only when activated, because economy planning may hold an
inactive task outside the active task registry. Zone reservation underlays
are counted independently from the visible structure mask so save/load,
destruction and role reset remain balanced.

Rejected: retaining the script composer (too much duplicated geometry and
non-authoritative state); arming module slots for ordinary tasks (allows a
distant slot to be stolen); an unbounded spine (hard to contain and recover);
and hardcoding UnitDef dimensions into coordinate conversion.

The chosen counts follow the shared
[build-power analysis](../../rjm.bar.docs/knowledge/50-economy/51-build-power.md)
and the compact 24-nano/four-AFUS player blueprint documented in
[`layout-design.md`](layout-design.md#meta-basis). The module is deliberately
finite because the shared
[explosion analysis](../../rjm.bar.docs/knowledge/20-game-mechanics/26-structure-explosions-and-base-spacing.md)
shows that AFUS-assisting nanos cannot also be spaced outside the AFUS blast.

**Changes.**
[`BaseLayoutGeometry.h`](../src/circuit/terrain/BaseLayoutGeometry.h),
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h) /
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`BuilderTask.h`](../src/circuit/task/builder/BuilderTask.h) /
[`BuilderTask.cpp`](../src/circuit/task/builder/BuilderTask.cpp),
[`FactoryTask.cpp`](../src/circuit/task/builder/FactoryTask.cpp),
[`BuilderManager.h`](../src/circuit/module/BuilderManager.h) /
[`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp),
[`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`CircuitAI.cpp`](../src/circuit/CircuitAI.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`layout_helpers.as`](../data/script/src/helpers/layout_helpers.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`global.as`](../data/script/src/global.as),
[`eco_planner.as`](../data/script/src/manager/eco_planner.as),
the experimental [`behaviour.json`](../data/config/experimental_balanced/behaviour.json)
family, [`base-layout.md`](base-layout.md), [`layout-design.md`](layout-design.md),
[`roles/tech.md`](roles/tech.md), [`angelscript-references.md`](angelscript-references.md),
and the standalone [`tests`](../tests/CMakeLists.txt).

**Status.** Geometry tests Built and Checked on MSVC. JSON and documentation
checks pass. The full engine integration and in-game behavior are not Played;
see [KI-407](known-issues.md#ki-407--native-tech-layout-refactor-is-not-yet-played).

---

## D-061 — The team-link widget is a tab beside the player list

**Decision.** The floating, draggable window is gone. The widget docks a
two-tab strip ("Player", "AI") on top of the game's bottom-right
player-list stack, the way the list's own modules (unit totals, game info,
music, mascot) stack: it reads the topmost `GetPosition()` of the chain
and sits on it. The AI tab opens a panel of the list's width above the
strip, so it adds to the stack and covers nothing (the first version drew
it over the list, which the user rejected); the Player tab folds it away
and leaves the strip. The widget publishes `WG.barblink.GetPosition()` in
the modules' shape so a further module could stack on it. Inside, Material
3 at compact density: two exposed dropdown
menus side by side, Team (ally team) and AI (name, team colour, role),
and under them the selected AI's status chips and start line, the role
selector as a segmented button in two rows of three, a row of text
buttons (Query, Overlay, Query all) and the event log in whatever height
is left, scrollable; lower sections drop when the list is short.
`/barblink`, Ctrl+Alt+B and the tab itself switch; Escape closes an open
menu, then returns to Player. Without a player list the panel falls back
to a list-sized frame in the corner. The layout overlay (`/barblayout`,
the Overlay button) and route commands (`/barbroute`) are kept; their
wire format is the one `commands.as` and `DescribeLayout` speak.

The widget's layer is -6, below the player list's -4: this game's widget
handler runs `DrawScreen` over its layer-sorted list in reverse and
`MousePress` forwards, so the *lowest* layer is drawn on top and clicked
first. At -2 the first version drew the panel underneath the list and the
tab looked dead.

**Why.** Asked for: the AI details belong with the team details, as a tab
of the same panel, not a separate window. The player list has no tab API
and is a game file (read-only), so the tab strip is a docked module and
the panel covers the list rather than living inside it; this keeps the
game's widget untouched and survives its updates.

**Changes.** [`gui_barb_team_link.lua`](../tools/widgets/gui_barb_team_link.lua)
(rewritten: docking, the strip, the panel), `AGENTS.md`.

**Status.** Built, copied into the local install. Not Played.

---

## D-062 — TECH opens on home metal and scales by regional build power

**Decision.** TECH treats metal and energy as map-wide resources and build
power as a regional resource. On Supreme Isthmus it opens with the nearest
three reachable mexes inside 1,200 elmos, six winds, the T1 bot lab, then one
energy storage. Its mature base reserves four nano rows and builds them
progressively from regional demand; converter count follows measured energy
surplus rather than a hardcoded number.

**Why.** Current Supreme data contains four mexes inside 1,200 elmos, but only
three belong to the tight home cluster. A literal radius rule contradicts the
observed three-mex opener, so the map profile carries both the radius and the
nearest-three cap. Native factory scheduling is held until the mex/wind phases
finish; merely preferring mex tasks in the builder callback cannot stop the
independent factory scheduler.

Storage was duplicated because native and script policy both built it and the
script counted completed structures only. TECH now disables native automatic
storage and includes pending tasks in its one-storage cap. Converter policy
reads each definition's real energy use and metal output, requires a 90% bank
and sustained net surplus, starts with four per AFUS, and permits the fifth
only from remaining surplus.

The old global build-power total could not answer whether a local project had
enough assistance. `GetBuildPowerNear` measures completed assist-capable units
around the named module. Supreme reserves four rows immediately but gates
their construction by metal income and the regional `2.5 BP / M/s` target.
Temporary wind/solar/fusion is placed around the same cluster and is recycled
as better energy completes. Advanced converters also reclaim obsolete T1
converters for TECH even while the bank is full.

Rejected: all four mexes inside the literal radius (delays the intended
Supreme opener); six winds as a generic engine default (map/role policy);
global build-power thresholds (cannot represent locality); building all 32
Supreme nanos before the first AFUS (metal-limited and slower); and assuming
600 E/s without reading the selected converter definition.

**Changes.**
[`EconomyManager.h`](../src/circuit/module/EconomyManager.h) /
[`EconomyManager.cpp`](../src/circuit/module/EconomyManager.cpp),
[`BuilderManager.h`](../src/circuit/module/BuilderManager.h) /
[`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp),
[`EconomyScript.cpp`](../src/circuit/script/EconomyScript.cpp),
[`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp),
[`BaseLayoutGeometry.h`](../src/circuit/terrain/BaseLayoutGeometry.h),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`map_config.as`](../data/script/src/types/map_config.as),
[`supreme_isthmus.as`](../data/script/src/maps/supreme_isthmus.as),
[`global.as`](../data/script/src/global.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`layout.as`](../data/script/src/manager/layout.as),
[`eco_planner.as`](../data/script/src/manager/eco_planner.as),
[`commands.as`](../data/script/src/manager/commands.as),
[`tech-eco-meta.md`](tech-eco-meta.md), [`eco-planner.md`](eco-planner.md),
[`base-layout.md`](base-layout.md), [`layout-design.md`](layout-design.md),
and [`roles/tech.md`](roles/tech.md).

**Status.** Pure geometry tests include the Supreme four-row plan. Native and
AngelScript integration is Built, not Played; see
[KI-408](known-issues.md#ki-408--tech-eco-progression-is-not-yet-played).
**Superseded in part by [D-063](#d-063--the-turret-box-invisible-construction-turrets-first-the-economy-packed-against-them):**
the economy module and the three-mex/six-wind opener are replaced; the
converter surplus rule, native storage off, `GetBuildPowerNear` and the
recycling stay.

---

## D-063 — The turret box: invisible construction turrets first, the economy packed against them

**Decision.** At frame zero, after the native factory pair (D-060), TECH
plans a *turret box*: the flattest, most buildable rectangle directly behind
the pair, sized from the settings (40 x 44 cells, 640 x 704 elmos) and shrunk
or slid until its ground clears `LayoutBoxMinScore`. Inside it, rows of
construction turrets are reserved slot by slot as if they stood already -
the invisible turrets - one row every shelf of 12 cells plus a turret depth,
as many rows as the depth holds (three by default, four on Supreme). A
refused slot is a hole, never a veto. Every economy structure TECH builds
after that (winds, solars, converters, storages, fusions, advanced fusions)
is packed by native onto the free box cells nearest to a turret slot, inside
a turret's reach, and its task is pinned to that footprint: no spiral, no
walk. The turrets themselves go up on demand, nearest the factories first,
when the planner finds the assist build power around the box under
`EcoBuildPowerPerMetal` (8) times the metal income, or metal floating.

The commander's opening is every mex it can reach within `OpeningMexRadius`
(2,000 elmos) of the start, nearest to itself first, before any other
structure. Native's start factory is held until then and released the
moment no open reachable spot is left, at the `OpeningMaxSeconds` deadline
(240 s), or when the commander is lost (R-1 of the D-062 review). The
builder ladder honours a FACTORY default task the moment native asks for it,
with one exception: energy is stalling and the planner has an affordable
solar, wind or advanced solar for this constructor, which goes first.

The next-building function (`EcoPlanner::Decide`) is one ordered rule set
over the economy's state and range: energy draining -> the cheapest energy
per E/s the constructor can build and the box can hold; energy floating ->
a converter the surplus carries; metal floating or build power short -> a
turret on the next planned slot; energy below target -> energy; storage
rules; metal floating with energy ahead -> best-payback energy; else
nothing. An option the box cannot hold within reach is not offered.

**Why.** The last played game (D-060/D-062 code) showed the failure the
owner described: the economy module never fit ("no full or half economy
module fits" at frame 160), so no turret plan existed; the ladder returned
native's default only for MEX/GEO, so the queued start factory starved
behind the layout rungs for six to eight minutes while metal floated near
1,000; the planner's placement was an anchor with a 512-elmo shake, so the
commander walked. The owner's instruction: mexes within 2,000 first, a
pre-computed turret space fitted to the terrain, everything built connected
to those turrets, and a hard cap on walking.

**Trade-offs, stated.** Taking every mex within 2,000 elmos before any energy
spends the commander's 1,000 E bank on mexes (500 E each); the T1 lab then
builds at the commander's 25 E/s unless the stall exception fires. The
explosion gaps (`LayoutConverterNanoGap`, `LayoutFusionNanoGap`) default to
0: an advanced converter's death kills a turret within 173 elmos, a fusion's
within 379 (knowledge base, structure explosions), and the box's 12-cell
shelves cannot hold a converter 173 from every row; density and shared
build power were chosen, as D-060 chose. `GetBuildPowerNear` still counts
constructors passing through the radius (R-4 of the D-062 review).

**Rejected.** Keeping the D-060 economy module (all-or-nothing 24 x 27
cells; it did not fit and left no turret plan). The D-062 opener's fixed
three mexes and six winds (the owner asked for every mex within 2,000 and
no other structure before them). A per-def band layout (D-053/D-057): fixed
grids waste the box on defs never built; the packer gives each def the cells
nearest a turret as it is asked for. Capping the native spiral radius: not
needed once every economy task is pinned; the only spiral left is the
logged no-box fallback within 8 cells of the factory nanos.

**Changes.**
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h) /
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp)
(`PackNearGroup`, `CanPackNearGroup`, `NextSlotAny`, `SetLayoutInt`),
[`EconomyManager.cpp`](../src/circuit/module/EconomyManager.cpp)
(`EnqueueMexWithin` orders by the builder, cap 0 = all),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as) (rewritten: pair + box),
[`eco_planner.as`](../data/script/src/manager/eco_planner.as) (rewritten
`Decide`, `Place`-only execution, the turret rule),
[`tech.as`](../data/script/src/roles/tech.as) (`Opening` rewritten, the
ladder honours FACTORY, the commander's mex cap, the old rungs and the
float spend into the box), [`global.as`](../data/script/src/global.as)
(`Opening*`, `LayoutBox*`, `EcoBuildPower*`, `EcoTurret*`),
[`supreme_isthmus.as`](../data/script/src/maps/supreme_isthmus.as),
[`map_config.as`](../data/script/src/types/map_config.as),
[`layout-design.md`](layout-design.md), [`eco-planner.md`](eco-planner.md),
[`roles/tech.md`](roles/tech.md), [`base-layout.md`](base-layout.md),
[`tech-eco-meta.md`](tech-eco-meta.md),
[`angelscript-references.md`](angelscript-references.md).

**Played once, 2026-09-20 (DLL `d319fa4d...`).** Both Supreme tech starts
found a 40 x 28 box (26 turret slots, 24 laid) behind the pair, winds were
packed 48 elmos from a turret, the lab came 50 s after the opening. The
opening itself failed: four `home mex` orders in nine frames, `complete
after 4 mexes, 5 s`. Cause: native re-asks a busy builder every few seconds
(`IBuilderTask::Update` calls `MakeTask` and swaps only when the kind
differs); every ask made `EnqueueMexWithin` close another spot with a new
task that nobody ran, so the radius was "taken" in five seconds, the three
untaken orders timed out, and the planner started winds after one mex.

**Follow-up (same day).** `EnqueueMexWithin` is idempotent: an untaken mex
order in the radius is handed back before a new spot is closed.
`GetMexTaskCountWithin(center, radius)` counts live mex orders. The opener
answers a re-ask with the mex the commander is on, waits while an order is
pending elsewhere, and completes only when no open spot and no pending
order remain in the radius. The commander is exempt from native's
wait-on-empty-energy rule (`IsRoleComm` in `IBuilderTask::Update`), so the
mexes build at the energy trickle rather than pausing.

**Played again, 2026-09-20 (DLL `2ac9818f...`).** The orders now came one
at a time and nearest first (360, 494, then the first spot again, 944), but
the commander left the second and third mexes half built and both decayed;
the first spot was ordered twice. Cause: `CBMexTask::Reevaluate` aborts a
mex task - assigned, mid-construction, whatever - the moment its spot lies
inside an *ally zone*, a square of about 1,920 elmos around every allied
structure (`SetAllyZoneRange`, TECH's `AllyRange` 1,000). With seven allied
AIs placing their first structures during the opening, home spots fell into
a zone 20 to 30 s after the order; the abort reopened the spot (so it was
re-ordered later) and orphaned the frame. Native's own mex chooser never
picks a spot inside an ally zone, which is why this never showed before.

**Follow-up 2 (same day).** An opening order is exempt from that abort
(`CBMexTask::SetIgnoreAlly`, set by `EnqueueMexWithin`): the spots inside
the radius are this AI's by the opening. `EnqueueMexWithin` also hands back
an untaken half-built order (target set, builder gone) before it opens a
new spot, so a frame is finished before the next is started.

**Played a third time, 2026-09-20 (DLL `2ac9818f...`, before follow-up 2).**
The opening ran in order and the lab came quickly, then the base froze at
one lab and three turrets with +16 metal and 7,800 energy banked. The log:
50 advanced solars packed for 9 served, 56 winds packed for 29 served, 17
turrets served for 3 built, and up to 22 default tasks discarded a minute.
Cause: the same native re-ask. While a constructor walked to its site the
ladder answered every re-ask by running the planner again, which packed
and pinned a new task each time; the same-kind answers were never run
(native keeps the current task and only discards *default* tasks), the
other-kind answers swapped the builder off its half-way turret or wind, and
the phantom queue came back as default tasks the ladder discarded, so
native's mex expansion (`UpdateMetalTasks`, reached only when the default
chooser finds nothing queued) never ran. On top, the energy target of 25 E
per M from +18 metal asked +16 for 456 E - sixty turbines on a 1-19 wind
map - so what metal there was went to energy.

**Follow-up 3 (same day).** The TECH ladder answers a re-ask for a
constructor on any construction task with that task (`Task::BuildType` below
`REPAIR`); only an idle constructor gets a new decision. The energy ratio
ramps from 8 E per M at +5 to 20 at +40 (`EcoEnergyRamp*`), not 25 at +18.

**Follow-up 4 (2026-09-20, Played).** The opening now ran clean through the
second mex; the third stalled repeatedly on an empty energy bank (three
mexes cost 1,500 E against 1,000 banked and 25 E/s) and the fourth order
was the spot 944 elmos out toward an ally. `OpeningMexCap` is 3: the three
reachable spots nearest the start, then the next build step (the planner's
energy, then the factory when native asks).

**Follow-up 5 (2026-09-20, Played).** T1 constructors built eight or more
turrets at once. Three causes: `GetBuildPowerNear` summed the engine's
per-frame build speed (commander 10, turret 6.7) against a per-second
target of 8 per metal, so "BP 10 under 243" never closed; the concurrency
guard counted unstarted orders only, so every constructor started its own
once the first was under way; native's assist nanos stayed on until the
economy switch. Now: build power in workertime units; one turret in flight
(orders plus under construction); a constructor asking meanwhile assists
the turret going up (`assistnano`, `FindUnfinishedNear`); `assistNanoEnabled`
false from `Tech_Init`. Expected scaling: the commander's 300 covers the
target to about +37 metal; then one turret per +25 metal.
Deployed 2026-09-21 as DLL `175cda7a...` with the script tree; parity check clean; not Played.

**Follow-up 6 (2026-09-21, Played).** The opening ran (`complete after 2
mexes, 32 s`: the third-nearest spot was not open) and the commander later
walked to another mex anyway. Cause: the ladder returns any native MEX
default inside `OpeningMexRadius` (2,000) to the commander, opening or not.
Now the commander's cap after the opening is
`CommanderMexRadiusAfterOpening` (600): farther mexes and geos are left to
the constructors, and every skip or take is logged at level 1. Also seen:
the lab was served 80 s after the opening ended, because native's factory
job offers the start factory on its own schedule; two winds went up first.

**Cleanup (same day).** The seam between "what and when" (the planner,
the opening, the ladder) and "where" (the layout) is five calls -
`Layout::Place`, `NanoTask`, `CanPlace`, `CanPlaceTurret`, `BaseCentre` -
and the ladder's old rungs and float spend go through `EcoPlanner::Enqueue`
instead of placing anything themselves. Deleted: `PlanEconomyModule`,
`MakeEconomyModule` and its tests, the script stubs (`HasEconomyModule`,
`MakeModuleTask`, `MakeFactoryNanoTask`, `OnFactoryBuilt`, `Routes`), the
`route` verb and `/barbroute`. Renamed: the build-power settings to
`EcoBuildPower*`, `EcoTurret*`, `EcoMaxConcurrentNanos`. Only TECH reaches
any of it; every other role's placement and order are untouched.

**Status.** Built (follow-up 2 and 3 and the cleanup: DLL and script
deployed 2026-09-20), not Played; see
[KI-409](known-issues.md#ki-409--the-turret-box-and-the-mex-first-opening-are-not-yet-played).
Level-1 lines to watch: `[Layout] turret box ...`, `[TECH][Opening] ...`,
`[Eco] next: ...`, `RESERVE: packed ...`.

---

## D-064 — Experimental build mode: builders stop at the engine's build range

**Decision.** A per-AI mode, off by default, that TECH's script turns on for
its own instance (`aiBuilderMgr.experimentalBuild`): every builder task
treats the engine's own build range - `0.9 x (buildDistance + buildee
model radius)`, Recoil `BuilderCAI::GetBuildRange` / `MoveInBuildRange` -
as its goal; inside `experimentalDirectRange` (1,600 elmos) on safe ground
the AI cancels its own path and hands the engine the construction command
at once, so the engine walks the shortest path to the range disc and
starts; a unit gets one command per engagement (`engaged`), never a second
one on arrival or re-evaluation; construction commands carry no 60 s
timeout. The turret-box packer breaks ties by the asking builder's
position. Theory, research and the alternatives are in
[`experimental-build.md`](experimental-build.md).

**Why.** Played: the commander walked past its second mex and back, and
the nanolathe stopped and restarted. The stock task paths to a grid node
inside `buildDistance` of the site (which can be the site itself), gives a
new build command on every arrival and path re-evaluation (each one
restarts the nanolathe), and its commands expire after 60 s, which a mex at
the energy trickle outlives. The owner asked for a builder that stops at
its build range and moves as little as possible, with freedom to diverge in
C++ but switched on for one role only.

**Rejected.** Potential-field steering (oscillates, and the engine owns
movement); footprint-corner stopping (stops short of what the engine
accepts); a TSP over pending sites (over-engineering); a custom last-hop
waypoint follower (reimplements `MoveInBuildRange` worse). See the table in
the design note.

**Changes.**
[`BuilderManager.h`](../src/circuit/module/BuilderManager.h) (flag, direct
range), [`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp)
(properties), [`BuilderTask.h/.cpp`](../src/circuit/task/builder/BuilderTask.cpp)
(`IsExperimental`, `EngageRange`, `CmdTimeout`, `TryEngage`, the `engaged`
set, `Update`, `OnUnitIdle`, `RemoveAssignee`, `Reevaluate`, `UpdatePath`),
`MexTask.cpp`, `NanoTask.cpp`, `MexUpTask.cpp`, `PylonTask.cpp`,
`GeoTask.cpp` (command timeout through `CmdTimeout`),
[`global.as`](../data/script/src/global.as), [`tech.as`](../data/script/src/roles/tech.as),
[`commands.as`](../data/script/src/manager/commands.as) (snapshot),
[`layout.as`](../data/script/src/manager/layout.as) / [`eco_planner.as`](../data/script/src/manager/eco_planner.as)
(builder-position tie-break), [`experimental-build.md`](experimental-build.md),
[`roles/tech.md`](roles/tech.md), [`angelscript-references.md`](angelscript-references.md).

**Status.** Built, not Played; see
[KI-410](known-issues.md#ki-410--experimental-build-mode-is-not-yet-played).
Every other role keeps the stock builder task: the flag is false unless a
role's `Init` sets it, and the stock code paths are unchanged when it is
false apart from the timeout call going through `CmdTimeout`, which returns
the old value.

---

## D-065 — TECH's construction turrets: reclaim first, then the economy under construction in a fixed order

**Decision.** When a TECH construction turret asks for work
(`Tech_TurretAssist`, the first rung of `Tech_BuilderAiMakeTask` for a
static builder): any structure of ours being reclaimed within the turret's
reach is reclaimed first; otherwise the first structure under construction
within reach in this order gets a HIGH repair task: advanced energy
converter, construction turret, advanced fusion, energy converter, fusion,
advanced solar, solar, wind, then energy storage, metal storage and mex;
otherwise native's default assist takes whatever is in range (the factory).
Reach is decided natively from the turret's build distance and the target's
model radius (`CBuilderManager::FindReclaimTargetFor`, `FindUnfinishedFor`).

**Why.** The owner's order. A reclaim returns its metal only when it ends,
so every turret in reach finishing it together is the fastest return; an
economy structure under construction is income deferred, and the order
above ranks the structures by what they add per second of assist.

**Changes.** [`BuilderManager.h/.cpp`](../src/circuit/module/BuilderManager.cpp)
(the two finders), [`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp),
[`tech.as`](../data/script/src/roles/tech.as) (`Tech_TurretAssist`,
`Tech_T1MexName`), [`roles/tech.md`](roles/tech.md),
[`angelscript-references.md`](angelscript-references.md).

**Status.** Built (DLL `57acdef3...` with D-064, deployed 2026-09-20 with the
script tree; `check_script_api.py --dll` clean), not Played (part of
[KI-410](known-issues.md#ki-410--experimental-build-mode-is-not-yet-played)'s
first game). Only TECH's ladder calls the finders.

---

## D-066 — The experimental build system: a hard split, TECH only, one switch

**Decision.** One per-instance switch, `aiBuilderMgr.experimentalBuild`,
set only by `Tech_Init` from `Tech::ExperimentalBuild`. On, the instance
runs a different system on both axes and never falls back:

- *Sequencing.* `TechBuild::MakeTask` (`roles/tech_build.as`) is the only
  source of work for every TECH builder: turrets (D-065 order, then any
  structure under construction in reach), keep-current, the commander's
  opening, the start factory ordered by the script on its reserved slot,
  mex expansion for constructors (nearest open spot within
  `EcoMexExpandRadius`, allied ground excluded, while income is under
  `EcoMexExpandUntilIncome`), the T2 lab gate, the planner, the role's
  strategic rungs (nukes, anti-nuke, gantry, water factories, T2 constructor
  policy), native's queued defence/sensor/repair orders when the sequence
  reaches them (`FindQueuedTask`), assist the nearest structure under
  construction, guard the primary factory, wait. It never returns null.
  Natively for the instance: `DefaultMakeTask` returns nothing, the
  start-factory and storage jobs are silent, `holdStartFactory` stays on for
  the whole game.
- *Placement.* Native's `FindBuildSite` for the instance serves a planned
  slot (factory pair, turret box, pinned tasks), else packs the free
  footprint nearest the anchor the task named within
  `ExperimentalSearchRadius` (512; the def's block mask respected, the site
  reserved and served) - `PackNearPoint` - and never the stock spiral. Exact
  spots (mex, geo) are untouched.

Off, `Tech_Init` sets nothing of this: no layout, no opening, no planner,
the stock ladder and the stock placement, the same code path as every other
role. Other roles never set the switch.

**Why.** The owner: "The tech role should follow totally different logic
for sequencing buildings and building placement/layout. It should never
fall back to default building sequencing logic or default placement
location selection... all other roles unaffected and even have the ability
to not enable the feature for tech role." Every remaining surprise of the
last days (the fourth mex, the lab 80 s late, two winds before the lab)
came through a native default the ladder still honoured.

**Rejected.** Gating each native generator individually (fragile; the
chooser is the single funnel, so it is closed instead, and the generators
that run on their own schedule are silenced); refusing every unplanned site
outright (defences, silos and gantries name an anchor and need a site near
it; the deterministic pack is our placement, not the spiral); a separate
AI profile (the split must be switchable per role, in script).

**Changes.** [`BuilderManager.h/.cpp`](../src/circuit/module/BuilderManager.cpp)
(`DefaultMakeTask` null, `FindQueuedTask`, `experimentalSearchRadius`,
`FindUnfinishedNear` any-def), [`EconomyManager.h/.cpp`](../src/circuit/module/EconomyManager.cpp)
(`StartFactoryJob` and `UpdateStorageTasks` silent, `EnqueueMexWithin`
ally-aware overload), [`TerrainManager.h/.cpp`](../src/circuit/terrain/TerrainManager.cpp)
(`PackNearPoint`, the branch in `FindBuildSite`), `BuilderScript.cpp`,
`EconomyScript.cpp`, [`roles/tech_build.as`](../data/script/src/roles/tech_build.as)
(new), [`tech.as`](../data/script/src/roles/tech.as) (the split in
`Tech_BuilderAiMakeTask` and `Tech_Init`; the experimental rungs left the
legacy ladder), [`global.as`](../data/script/src/global.as),
[`eco_planner.as`](../data/script/src/manager/eco_planner.as) /
[`layout.as`](../data/script/src/manager/layout.as) (gated by the switch),
[`commands.as`](../data/script/src/manager/commands.as), docs.

**Played once, 2026-09-21 (DLL `165e542d...`).** The sequence held to a
decent economy; three faults. No turret was ever built: the build-power
reading counted the commander (300) and every constructor passing through,
so "BP 262 to 630" never fell under a target of 106 to 178. Winds and
converters were scattered across the box: the packer's only order was
"nearest a turret". Every T2 constructor the advanced lab built was ferried
to an ally (six requests pending), so TECH's own T2 constructor "did
nothing" (parked for the ferry) and the lab built nothing but donations.

**Follow-up 1 (same day).** The turret target compares against static
assist power only (`GetStaticBuildPowerNear`: turrets, not the commander or
constructors). The box packer groups by def: with a standing or planned
structure of the same def in the box, the nearest cell to that group wins,
so winds form one contiguous block and converters another, each still
inside a turret's reach. Donations wait until TECH owns
`DonationKeepT2Constructors` (2) T2 constructors, and a built constructor
stays TECH's while it is at or under that count.

**Played again, 2026-09-21 (DLL `9e5274f9...`).** A clean economy to four
advanced solars, then every T1 constructor ended assisting the factory; no
turret beyond the first, no T2 lab, no converters, two advanced solars
started at once. One cause underneath: metal income never passed +18. The
opening took two mexes (the third-nearest spot was taken), and mex
expansion never claimed another because it asked native for the single
spot nearest the constructor (cap 1) and stopped when that spot was not
open. The T2 lab gate (+18), the converter rules and the turret target all
sat just under their thresholds, the bank fell to zero, the storage rule
looped on an empty bank, and the constructors fell through to the tail of
the sequence (assist, guard). The double advanced solar: "one energy
structure at a time" only counted a structure whose frame existed.

**Follow-up 2 (same day).** Expansion considers every spot inside the
radius nearest the builder first (cap 0); native's cap counts open,
reachable spots nearest the centre, so a taken third spot no longer ends a
three-mex opening at two; an energy structure counts as in progress from
the order on; no storage order under `EcoStorageMinMetalBank` (150) of
metal; expansion and "no open spot" log at level 1.

**Played, 2026-09-21 (DLL `4ba9b805...`).** Both TECH openings ordered four
mexes (360, 494, 944, then 1,866 elmos): the native cap counts the three
nearest *open* spots on every call, so once the first three were ours the
fourth-nearest qualified. **Follow-up 3 (script only):** the opener counts
the distinct spots it has ordered and finishes at `OpeningMexCap`; native is
called uncapped. The native cap stays as it is for expansion.

**Played, 2026-09-21 (follow-up 3 script).** The opening and the lab were
right; then only energy was built. Late state: energy income 601 against
pull 59, bank 7,459 of 7,555, metal +20 with a full bank, and the choice
was "metal storage". Two rules: the converter rule required no energy
structure in progress, which the one-at-a-time count made nearly always
true; and nothing put the T2 lab ahead of storage when metal floats. Mex
expansion had also found no open spot within 2,500 elmos, so converters
and T2 upgrades were the only metal growth left. **Follow-up 4 (script
only):** the planner's order is now stall, T2 lab (gate: +18 metal, 500
energy), converter (bank floating or a surplus of twice a converter's draw,
energy under construction no longer blocking), turret, energy when short
and not floating, storage, best-payback energy.

**Played, 2026-09-21 (follow-up 3).** Three orders, in sequence, at 357,
492 and 947 elmos: the count was right and the third spot was still too
far - it lies outside the home cluster, toward an ally. **Follow-up 5
(script only):** `OpeningMexRadius` is 700, the home cluster; the cap of
three stays for maps where three spots are that close.

**Played, 2026-09-21 (before follow-up 5 reached the install).** After the
opening the commander walked out to finish a fourth mex and then to a radar
4,000 elmos away, and came back. Both came through the sequence's "native
queued orders" rung: native's sensor-guard job queues radars at every
cluster and the watchdog queues repairs of anything unfinished (a
constructor's abandoned mex), and the rung handed them to the commander.
**Follow-up 6 (script only):** the commander never takes queued orders and
assists only within `ExpCommanderHomeRadius` (800) before guarding the
factory; constructors take queued orders only within `ExpOrderRadius`
(2,000) of the base centre.

**Played, 2026-09-21 (follow-ups 5 and 6).** The owner: economic sequence
and placement work well; one glitch on the third mex - the commander
started it, stopped, walked backward, started again, finished, then built
the lab. Two native candidates, both ending in `OnUnitMoveFailed`'s random
256-elmo move that replaces the command queue: the builder watchdog's
"lost" test (standing still with zero resource use outside
`buildDistance + model radius` - true of an energy-stalled nanolathe a
hair outside range) and the engine's own move-failed event (blocked while
walking into range). **Follow-up 7 (native, diagnostics only):** both paths
log at level 1 for an experimental instance (`EXP: watchdog: ... lost on
... dist D, reach R, commands yes/no, waiting yes/no` and `EXP: move
failed: ...`), so the next log names the cause before the behaviour is
changed.

**Played, 2026-09-21 (follow-up 6).** After the T2 lab the T2 constructors
never upgraded a mex: upgrades came only from native's default chooser
(closed for the instance) and from a redirect in the legacy ladder head
that the experimental sequence does not run. **Follow-up 8 (script only):**
the planner's rule 2b - a T2 builder upgrades the nearest owned T1 mex
within `MexUpgradeRadius`, `MexUpgradeMaxConcurrent` at a time, as an exact
spot - right after the T2 lab and before converters.

**Played, 2026-09-21.** Far too much defence of the wrong kind (three
junos among it) and never a fusion - advanced solars kept coming. The
defence came from two native sources the sequence still honoured:
`Tech_AiMakeDefence` handing clusters to native's porc chain (which runs
to junos), and native's own queued defence/radar orders taken by the
queued-orders rung. The energy choice was the ratio: an advanced solar's
4.4 metal per E/s beats a fusion's 4.5. **Follow-up 9 (script only):**
the experimental instance never asks native's porc chain and never takes
native's defence, radar or sonar orders; its base defence is one light
laser and one light AA near the factories once the first turret stands
(`ExpDefenceLLT`, `ExpDefenceAA`); and from `EcoFusionEnergyIncome` (300)
a T2 builder answers "energy" with a fusion (advanced fusion once its metal
gate passes) while T1 builders leave energy to the reactors.

**Played, 2026-09-21.** Three T1 constructors built three advanced solars
in parallel: the "energy draining" rule bypassed the one-at-a-time limit so
a stalling base would not wait, and each asker started its own.
**Follow-up 10 (script only):** draining or short, a builder asking while
an energy structure is going up assists it if its frame is within
`EcoAssistRadius` (1,200) of the builder (`assistenergy`, up to
`EnergyFocusMaxAssists`), and otherwise moves on; nobody starts a second.

**Follow-up 11 (2026-09-21, script only).** Owner's rule: once the T2
lab's construction begins, the T1 bot lab is reclaimed, all idle build power
in range joins, and turrets put reclaim before factory assist. Rung 3b of
the sequence orders the reclaim for every builder within range once the
advanced lab's frame exists (one native task, joined by all); the turret
rung already took reclaims first, and its assist tasks are now 30 s so a
turret switches within that.

**Follow-up 12 (2026-09-21, script only).** Owner's rule: the first T1
bot lab is always reclaimed, so it need not follow the plan; what matters
is that it goes up inside the commander's build range. The commander now
reserves the nearest buildable footprint within `ExpFirstLabRadius` (160)
of itself, the factory task is pinned to it, and once the lab stands an
exit cone (320 elmos, 32 margin) is held in front of it until it is gone,
so nothing is packed where its units come out. The pair's planned T1 slot
is left reserved; a constructor building the first lab still uses it.

**Played, 2026-09-21 (follow-up 12).** Right sequence to the lab, then the
commander "glitched out" several times on the lab and was asked for work
mid-build (`[Eco] next: wind ... by corcom` at 57 s). The lab task was
served once only, so it was not aborted and re-ordered: the commander was
taken off it by the idle path (engine drops the command, two retries, then
removal). The likely trigger is follow-up 12's own placement: ring 0 put the
lab's footprint under the commander, and a factory ordered on top of its
builder cannot start. **Follow-up 13:** the first lab's footprint edge
stays `ExpFirstLabClearance` (32) clear of the commander within
`ExpFirstLabRadius` (224); natively, the income-drop auto-abort (a
>1,000-metal build dropped when average income falls under 60 % of its
order-time value, which fires right after an opening) is off for the
experimental instance, and every idle event on a construction logs
`EXP: idle: ...` so the next game names the trigger.

**Played, 2026-09-21.** T1 constructors stalled after the second turret
with +21 to +24 metal, 350 to 395 energy and a full bank, choosing "metal
storage" every ask: the advanced lab's energy gate was 500, and the metal
storage it kept naming is capped at zero for TECH until the advanced lab
stands, so nothing was built. **Follow-up 14 (script only):**
`MinimumEnergyIncomeForT2Lab` is 250; the storage rules check that the def
is available and buildable before naming it; the lab gate logs
`[Eco] advanced lab waits: ...` once a minute while it holds.

**Played, 2026-09-21 (follow-up 13 DLL).** The diagnostics named the
interruption: `EXP: idle: armcom on armlab ... target yes, fails 1 / 2 / 3`
every five seconds from 154 to 166 elmos, the same on the third mex at 212
and later on winds. The engine drops the construction command when its own
move-into-range goal - the point on the range circle straight toward the
unit - is unreachable, which in a packed base it often is; after three the
task removes the unit and the frame decays. **Follow-up 15 (native):** the
AI chooses the approach point itself (`FindApproachPoint`: a free, walkable
point on the circle nearest the unit's bearing), moves the unit there, and
gives the construction command on arrival; an idle outside the range
re-approaches instead of retrying in place. `EXP: approach: ...` logs each
move.

**Played, 2026-09-21.** The commander rebuilt the T1 lab beside the
advanced lab's frame: the reclaim emptied the T1 lab count and
`StartFactory` only asked "no T1 lab standing or queued". The legacy
ladder's "into T2, no T1 lab" gate had not been carried over.
**Follow-up 16 (script only):** `TechBuild::IntoT2` (advanced lab ordered,
framed or standing) gates `StartFactory` and drives the reclaim rung.

**Status.** Built (follow-up 15 DLL, in the build folder for the owner to
deploy; follow-ups 8 to 14 and 16 script), not Played; see
[KI-411](known-issues.md#ki-411--the-experimental-build-system-is-not-yet-played).

---

## D-067 — TECH's build sequence is one ordered rule table

**Date:** 2026-09-21. **Status:** Built (script only; the build16 DLL
`704a77e2` needs no change). Not Played:
[KI-411](known-issues.md#ki-411--the-experimental-build-system-is-not-yet-played).

**Problem.** Played (D-066 follow-ups): the T1 lab was rebuilt by the
commander while the advanced lab was under construction. The rule "never a
T1 lab once into T2" existed, but the sequence was a hand-written function
of nested ifs in `TechBuild::MakeTask`, and the gate sat inside one rung
(`StartFactory`) where a later edit reordered around it. The user asked for
a decoupled structure that handles every case a player would build a T1
bot lab in, traceably, and for the game understanding behind it to stay
documented.

**When a player builds a T1 bot lab** (researched: the official economy
guide, the 2026 community guide, the knowledge base's openings, team-roles,
spam and scaling pages; written up as
[`77-eco-tech-player.md`](../../rjm.bar.docs/knowledge/70-strategy/77-eco-tech-player.md)):

| Case | TECH does it? |
| --- | --- |
| Game start, for constructors | yes: a throwaway at the commander, reclaimed when the advanced lab begins |
| Every constructor lost and no lab standing | yes: the commander rebuilds one |
| Late game, spam economy on, advanced lab standing | yes: on the pair's slot, `ExpSpamLabs` (1) of them |
| Fighting a T1 front | no: TECH does not fight lane battles |
| A second early lab | no: turrets on one lab and the advanced lab beat two labs |

**Decision.** The sequence is a table (`roles/tech_rules.as`, namespace
`TechRules`): rows of `(key, who, when[], act, note)` evaluated top to
bottom against one context built once per ask; the first row whose mask
and predicates hold and whose act returns a task wins. Predicates are named
functions over the context and reused (`IntoT2` guards both the reclaim row
and, negated, the opening-lab row; `NoConstructors` + `NoLabAtAll` the
recover row; `SpamGate` + `T2LabStands` + `SpamLabsWanted` the spam row).
The acts are the existing `TechBuild` functions and the planner's `Pick*`
pieces, called directly; `EcoPlanner::Next` answers nothing when the
experimental system is on so the legacy strategic rungs the table still
reuses cannot run the planner a second time. `TechBuild::MakeTask` is now
`TechRules::Evaluate` with a 3 s wait if the table returns null (it cannot:
the last row is `wait`). Every winning row logs `[Rule] <key> for <def>
<id> | ...` at level 1 on change, so a played game shows which row chose
what and why.

The row order is the policy: turrets first (D-065), keep-current, the
opening, T1-lab reclaim, T1-lab opening, T1-lab recover, mex expansion
while metal is the bottleneck, energy when draining (assist the one going
up before starting another), the advanced lab, T2 mex upgrades, converters
from measured surplus, turrets, energy when short, storages, energy when
metal floats, spam labs, the legacy strategic rungs, the two-turret
defence, native's repairs, assist, guard, wait.

**Not changed.** Placement (`Layout`, native `PackNearGroup`/`PackNearPoint`),
the acts themselves, the legacy ladder for every other role and for TECH
with the switch off. No native change.

**Files.** [`tech_rules.as`](../data/script/src/roles/tech_rules.as) (new),
[`tech_build.as`](../data/script/src/roles/tech_build.as) (`MakeTask` is the
evaluator; the inline sequence removed),
[`tech.as`](../data/script/src/roles/tech.as) (include),
[`eco_planner.as`](../data/script/src/manager/eco_planner.as) (`Next` silent
in experimental mode), [`global.as`](../data/script/src/global.as)
(`ExpSpamLabs`), [`roles/tech_rules.md`](roles/tech_rules.md) (new),
[`roles/tech_build.md`](roles/tech_build.md), [`roles/tech.md`](roles/tech.md),
[`eco-planner.md`](eco-planner.md), [`roles/README.md`](roles/README.md),
[`../AGENTS.md`](../AGENTS.md), and the knowledge base's
`70-strategy/77-eco-tech-player.md` (new, linked from `75-team-roles.md`
and the README map).

**Played** (headless playtest, 2026-09-21, two AIs, 2 min): `[Rule] table of 27
rules loaded`, `opening.mex` twice, then the first lab traced as
`lab.t1.recover`: the opening act had just marked the opening complete and
the context's flag was stale, so the opening-lab row was skipped and the
recover row (no lab, no constructor) took the same act. Fixed the same day:
`OpeningDone` reads the flag live, and the recover row also requires it.

**What to watch.** `[Rule] lab.t1.opening` once, before the first turret;
`[Rule] lab.t1.reclaim` when `[Rule] lab.t2` has fired; never
`lab.t1.opening` after that; `lab.t1.recover` only with no constructor and
no lab; `lab.t1.spam` only after the advanced lab stands with the spam gate
open.

## D-068 — TECH makes no combat unit before the combat gate; packed sites are for structures only

**Date:** 2026-09-21. **Status:** Built (script + native, build17). Not
Played: [KI-411](known-issues.md#ki-411--the-experimental-build-system-is-not-yet-played).

**Played** (Supreme Isthmus, TECH as Cortex, the D-066 script): at 17
minutes the advanced lab made eleven Fiends and ten Ducks while the user saw
+58 metal. Two findings from the log:

1. `[Eco]` lines put the 10 s income at +87 to +90 a minute earlier, and the
   first Fiend was packed at f=30555, right after the T1 lab reclaim and the
   first mex upgrades: the `T2_RUSH` strategy (on by default) releases the
   rush bots' cap (Fiend) and the amphibious bots' cap (Duck) at
   `MetalIncomeThresholdForEarlyBotLabExpansion` (100) on
   `GetMinMetalIncomeLast10s`, which counts reclaim. The script's batch then
   ordered ten Fiends and native's factory chooser, with Ducks in the
   advanced lab's "support" role, filled the gaps with Ducks. The user's
   rule: a tech player does not build combat units early, and often not mid
   game.
2. Every one of those recruits produced `RESERVE: packed corpyro/coramph
   near ...`: `CRecruitTask` asks `FindBuildSite` for a free spot for the
   unit it builds, and the experimental branch (D-066) packed and reserved a
   footprint for a *mobile* def. Nothing ever stands on such a slot, so the
   registry never forgets it; `[Layout] no room in the turret box` began at
   f=30571, 16 frames after the first one.

**Decision.**

- *Combat gate.* `Tech::ExpCombatMetalIncome` (200; 0 = never) is the one
  income under which TECH's labs make no combat unit while the experimental
  system is on. `Tech_CombatGate(legacy)` raises every legacy gate to it and
  never lowers one: the rush-bot cap release, the T1 scout cap lift (moved to
  the same moment), the T1/T2 bot-lab batches and the vehicle-plant batches.
  Native's factory chooser is covered because the caps stay at zero. The
  moment is logged once at level 1: `[TECH][Factory] combat production
  unlocked at +M metal (gate G)`. Off the switch the legacy gates are
  returned as they were.
- *Packed sites are for structures only.* `CTerrainManager::FindBuildSite`
  takes the D-066 branch only for `!cdef->IsMobile()`; a recruit, rally or
  retreat ask for a mobile def goes to the stock search, as before D-066.

**Why 200.** The knowledge base's scaling page puts +60 metal at the
gantry and +100 to +200 in the late game; the user's rule is "not early,
often not mid". 200 is the legacy `MetalIncomeThresholdForBotLabExpansion`,
so a game without the rush strategy behaves as it did; the rush's 100 no
longer applies to TECH in this mode.

**Files.** [`global.as`](../data/script/src/global.as),
[`tech.as`](../data/script/src/roles/tech.as) (`Tech_CombatGate`,
`Tech_EconomyUpdate`, `Tech_FactoryAiMakeTask`),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`roles/tech.md`](roles/tech.md), [`roles/tech_rules.md`](roles/tech_rules.md),
[`experimental-build.md`](experimental-build.md), and the knowledge base's
`77-eco-tech-player.md`.

**What to watch.** No `RESERVE: packed <mobile def>` line ever; `[TECH][Factory]
combat production unlocked` only past +200 metal; no Fiend, Duck or scout
from a TECH lab before it.

## D-069 — Turrets beside the nearest lab; the advanced lab where the most build power reaches

**Date:** 2026-09-21. **Status:** Built (script only). Not Played:
[KI-411](known-issues.md#ki-411--the-experimental-build-system-is-not-yet-played).

**Request** (owner, after a game with the D-067/D-068 script that was "almost
a perfect build"): construction turrets as close to the closest lab as
possible, to maximise their use; a lab, the first one excepted, placed in
range of the most build power possible while honouring the build constraints.

**Decision.** Two rules in `Layout` (`manager/layout.as`), both switchable:

- *Turret slot* (`ExpTurretNearLab`, true). `Layout::NanoTask` takes a
  completed factory's own rear slot first as before (D-060); for a box slot it
  asks `NextSlotAny` once per standing lab (`Factory::allFactories`) with that
  lab's position as the anchor and keeps the (slot, lab) pair with the
  shortest distance. Off, or with no lab standing, the anchor is the pair's
  centre as before. Level 2: `[Layout] turret slot <id>, <d> from the nearest lab`.
- *Advanced lab site* (`ExpLabSiteRadius`, 480; `ExpLabBuildPowerReach`, 260).
  `Layout::T2LabTask` scores the pair's planned T2 slot by
  `GetStaticBuildPowerNear(slot, reach)` (turrets only, workertime), then
  every reservable footprint (`CanReserveBuilding`: blocks, zones, exit
  cones, the box) on rings two cells apart out to the radius, and orders the
  lab on the pair's slot unless a footprint has strictly more static build
  power in reach - then on that footprint, reserved and pinned, facing as the
  pair. The economy planner's `t2lab` key calls it. Level 1:
  `[Layout] advanced lab on the pair's slot (...)` or `[Layout] advanced lab
  off the pair's slot: (...) has static build power B ..., the slot A`.
  The reach is a nano's build distance plus a lab's radius; the radius keeps
  the lab inside the base. The first lab keeps D-066's rule: at the
  commander, a throwaway.

**Why this shape.** The pair's slot already touches the box's first turret
row, so with turrets placed by the first rule the slot usually wins and
nothing moves; the rule earns its keep when the turrets stand elsewhere
(around the first lab at the commander) and the pair's slot would leave
them idle. Both rules read the world once per order and change no other
placement.

**Files.** [`layout.as`](../data/script/src/manager/layout.as),
[`eco_planner.as`](../data/script/src/manager/eco_planner.as),
[`global.as`](../data/script/src/global.as), [`layout-design.md`](layout-design.md),
[`eco-planner.md`](eco-planner.md), the knowledge base's `77-eco-tech-player.md`.

**What to watch.** `[Layout] turret slot ... from the nearest lab` under
about 250 elmos; the advanced-lab line naming both scores; the turrets that
stand when the advanced lab is ordered all within reach of it.

## D-070 — The TECH rush chain: one objective, one computed build order, then the economy

**Date:** 2026-09-21. **Status:** Built (script only); benchmarked by the
playtest loop, results in [`benchmarks/tech-rush.md`](benchmarks/tech-rush.md).

**Goal set by the owner.** The TECH role must reach every rush milestone at
or under the low end of the realistic range of the knowledge base's rush
table (T2 lab 6:30, fusion 11:30, advanced fusion 18:00, nuke silo 16:30,
gantry 16:00, first T3 26:00; floors 5:26, 9:56, 15:41, 14:17, 13:59, 22:52),
be able to pick a rush objective and put all build planning on it, then
continue with an optimised economy; the build chains are to be calculated
from the map's resources; screenshots at several periods; benchmarks
tracked in markdown.

**Decision.**

- *Calculation.* `rjm.bar.docs/tools/knowledge/rush_sim.py` simulates one
  player second by second from the zero-bonus start and searches openings
  and late tails for the earliest completion of each objective; its winning
  lines are the chains in `roles/tech_chain.as` (solar counts, scaled to
  turbines when the map's effective wind reaches `ChainWindMin`).
- *Execution.* `TechChain` (namespace, `roles/tech_chain.as`) holds the
  chain as cumulative targets and is the `chain.next` row of the rule table
  (D-067), placed after keep-current and the T1-lab reclaim and before every
  economy row: assist the current step's frame, wait for its order, or order
  it through the act that owns the placement; a builder that cannot help gets
  null and the economy rows keep it useful. `Tick` keeps the caps open. Done
  once, the table continues.
- *Objective.* `Tech::RushObjective` (`auto` = the role's pick, `afus`).
  The playtest's `--set RushObjective="..."` sets it per benchmark run.
- *Measurement.* The camera widget logs every structure the team under test
  finishes (`[Playtest] finished <def> team 0 at <min> min`) and its income
  each minute; `tools/playtest/benchmark.py record <run>` turns a run into a
  row of `doc/benchmarks/tech-rush.md` with the best-so-far table; checks
  files `rush_<objective>.json` pass the moment the milestone lands.

**Files.** [`tech_chain.as`](../data/script/src/roles/tech_chain.as) (new),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as) (row, predicate, act),
[`tech.as`](../data/script/src/roles/tech.as) (include, `Init`, `Tick`),
[`global.as`](../data/script/src/global.as) (five settings),
[`roles/tech_chain.md`](roles/tech_chain.md) (new),
[`benchmarks/tech-rush.md`](benchmarks/tech-rush.md) (new, generated),
[`../tools/playtest/benchmark.py`](../tools/playtest/benchmark.py) (new),
[`../tools/playtest/playtest.py`](../tools/playtest/playtest.py) (`--set`),
[`../tools/playtest/widgets/playtest_camera.lua`](../tools/playtest/widgets/playtest_camera.lua),
`tools/playtest/checks/rush_*.json` (new).

**Played** (2026-09-21/22, twelve benchmark loops, headless tech versus
tech on Supreme Isthmus v1.7, speed 8, zero bonus; every run in
[`benchmarks/tech-rush.md`](benchmarks/tech-rush.md)). Every target met
with build19 and the chain as documented in `roles/tech_chain.md`:

| Objective | Target | Achieved | Simulator floor |
| --- | ---: | ---: | ---: |
| T2 lab | 6:30 | 6:14 | 5:26 |
| Fusion | 11:30 | 10:44 | 9:56 |
| Advanced fusion | 18:00 | 14:05 | 15:41 |
| Nuke silo | 16:30 | 12:38 | 14:17 |
| Gantry | 16:00 | 13:19 | 13:59 |
| First T3 | 26:00 | 16:03 | 22:52 |

The late objectives beat the simulator's floors because the economy rows
that run beside the chain (mex expansion by the T1 constructors, T2 mex
upgrades) put the real metal income far above the six-spot simulation.
What the loops fixed on the way, each a decision inside `tech_chain.as`:
the first lab is met once the advanced lab begins (it is reclaimed); a
builder never waits on an order out (an abandoned order stalled the base
five minutes); cheap items build in parallel, dear ones focused; the chain
remembers its own fresh order until the count rises; a builder skips steps
it cannot build and the chain completes only when every target stands
(a T1 constructor running out of steps had ended the chain at 6 min and the
strategic rungs then built a silo instead of the advanced fusion); the
commander keeps the home cluster and the constructors fetch the far spots;
the energy block and the fusion precede the T2 mex upgrades; eight solars
before the advanced lab; no T2 turret (needs the extra-units pack) and no
advanced solars; the fast-assist cap is two during a chain; the legacy
strategic and spam rows sleep during a chain. The native cause of the
two-minute solars was D-071.

**Played by the owner (2026-09-22, Supreme Isthmus):** the commander went
far for a fourth mex before the lab; ten solars on a wind map; energy income
outscaling metal with no converter. Three deterministic rules replaced the
guesses: the home mexes are the opening's (within `OpeningMexRadius` 700, at
most `OpeningMexCap` 3) and the lab follows at once; energy is chosen from
the map's wind numbers (`EnergyChoice`: turbine metal per E/s at the expected
wind against the solar's, a margin, a max-wind floor, a solar first while the
current wind is down); and the `energy.convert` row fires when energy income
passes `EcoEnergyRatioHigh` times the metal income with metal not floating,
granting a T1 converter's draw without a measured surplus.

**What to watch.** `[TECH][Chain] objective ...` at start; `step k/n`
lines advancing in order with every builder on one frame; the benchmark
row's milestone at or under the target.

## D-071 — No energy wait for experimental builders; a builder leaving an order is logged

**Date:** 2026-09-22. **Status:** Built (native, build19) and Played in the
rush benchmarks.

**Found by the benchmarks.** The first lab and the opening solars took two
minutes each in some runs, with no engine event in the log. Two native
diagnostics (`EXP: leave: <unit> off <def> ... fails N` in
`IBuilderTask::RemoveAssignee`, `EXP: swap: <unit> from task type A to B` in
`ITaskModule::AssignTask`) showed the commander leaving the lab order
with `fails 3, target yes`: native's in-range re-evaluation puts a builder
on `CmdWait` while energy is empty (for anything but energy, geo, storage
and reclaim); the wait makes the unit idle, `OnUnitIdle` counts each idle
as a build failure, and the third throws the builder off its order. The
order then sits queued until its timeout.

**Decision.** In the experimental build system (`IsExperimental()`) the
re-evaluation issues no `CmdWait`: the sequence manages energy itself and a
slow build beats an abandoned one. Off the switch nothing changes. The two
diagnostics stay (they print only for experimental builder tasks).

**Files.** [`BuilderTask.cpp`](../src/circuit/task/builder/BuilderTask.cpp),
[`TaskModule.cpp`](../src/circuit/module/TaskModule.cpp).

## D-072 — Owner's rules from play: spot ownership, income bonus, deferred reclaim, no pockets, the box grows, upgrades before the fusion

**Date:** 2026-09-22. **Status:** Built (script + native, build20); benchmarked
after (see `benchmarks/tech-rush.md`).

**Played by the owner (Supreme Isthmus, the D-070 script).** Six findings,
each now a deterministic rule:

1. *A constructor took an ally's mex.* A metal spot belongs to the team whose
   start position is nearest to it (a Voronoi split by start positions).
   Native `CEconomyManager::IsOwnSpot` keeps the allies' start positions
   (fed by the roster, `AddAllyStart`, as allied BARb teams announce
   themselves) and the ally-aware mex enqueue skips spots nearer to an
   ally's start. The chain's mex steps and the expansion row are ally-aware.
2. *Bonus games.* Every playtest and benchmark runs at zero bonus
   (`ai_incomemultiplier=1`, every team `Handicap=0`) as the baseline;
   `--bonus 50` gives team 0 a handicap for a bonus test. The AI reads its
   own bonus deterministically: the engine's per-team income multiplier
   (`ai.GetIncomeMultiplier()`, the lobby's handicap) times the
   `ai_incomemultiplier` modoption. The chain divides its energy counts by
   it (every generator and mex gives more); the economy rows already work
   on measured income, which includes the bonus.
3. *Reclaiming the T1 lab at full metal storage.* Reclaimed metal past the
   cap is lost, so the reclaim waits until the bank has room for the lab's
   metal; the advanced lab's build makes that room, and it is part-built by
   then, as the owner intends.
4. *A constructor walled in by turbines.* Native `LeavesPocket`: a box
   candidate is refused when its footprint would cut the zone's free cells
   into a pocket not connected to the zone's edge (flood fill; planned slots
   count as standing).
5. *Structures scattered when the box was full.* The box grows: when no
   zone has room (or no turret slot is left), `Layout::GrowBox` reserves
   another box of the same width behind the last or beside the first,
   whichever ground scores best (played: behind the Supreme Isthmus base
   nothing scored), with its own turret rows in the same group, up to
   `LayoutBoxMaxExtra` (4); a failed search is retried a minute later. Energy,
   converters, fusions and the advanced lab keep packing tight to the
   turret cluster; the advanced-lab site search also rings the turret
   cluster's centre. Only the first lab is exempt (D-066).
6. *A fusion before the mex upgrades.* The tails put the T2 mex upgrades
   before the fusion (owner's economic rule); the energy block stays ahead
   of both because the upgrades drain 7,700 energy each.

**Files.** [`EconomyManager.h/.cpp`](../src/circuit/module/EconomyManager.cpp),
[`EconomyScript.cpp`](../src/circuit/script/EconomyScript.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`TerrainManager.h/.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`roster.as`](../data/script/src/manager/roster.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`tech_build.as`](../data/script/src/roles/tech_build.as),
[`layout.as`](../data/script/src/manager/layout.as),
[`global.as`](../data/script/src/global.as) (`LayoutBoxMaxExtra`),
[`../tools/playtest/playtest.py`](../tools/playtest/playtest.py) (`--bonus`).

**What to watch.** `[TECH][Chain] objective ... income bonus x1` in a
benchmark and `x1.5` in a `--bonus 50` game; `[Layout] turret box full:
grown by ...`; `[TECH][Build] T1 lab reclaim deferred: metal ...`; no
constructor at an ally's spot.

## D-073 — The advanced lab where the most turret slots reach it, front first

**Date:** 2026-09-22. **Status:** Built (native, build21; script).

**Played by the owner.** With D-069/D-072 the advanced lab landed on the
turret layout but toward the back of the base: the site was scored by
*standing* turrets within reach at a moment when few stood, and the ring
search ranged over free ground outside the box. The owner's rule: the lab
sits on the turret layout, tight, where the most build power reaches it,
and since its units leave for the front late in the game, forward.

**Decision.** Native `PickMost` (dry run) and `PackNearGroupMost` (reserve):
among the free footprints inside a box zone that the packer would consider,
the one reached within `ExpLabBuildPowerReach` by the most slots of the
turret group, standing or planned (every slot becomes a turret), front
first among equals (forward along the layout's facing from the zone's
centre), then nearest a slot; pockets refused (D-072). `Layout::T2LabTask`
scores the pair's planned slot the same way (`CountGroupSlotsWithin`) and
takes the box footprint only when it is reached by strictly more slots;
when no zone has a footprint it grows the box first. The D-069 ring search
over free ground is gone; `ExpLabSiteRadius` is no longer read.

**Files.** [`TerrainManager.h/.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as).

**Played (benchmarks).** The first build reserved the slot as already
served, so the pinned task aborted and the pair's slot rescued it three
minutes later (T2 7:27); fixed the same day (T2 5:38). The box packer also
reserved an advanced-fusion footprint on the box's unflat part, which the
engine refused at serve time; every packer now applies the engine's own
`IsPossibleToBuildAt` before reserving, and the chain's stall guard never
skips the objective step itself.

**What to watch.** `[Layout] advanced lab in the turret layout at (x, z): N
turret slots within 260 reach it, the pair's slot M; front first among
equals` and the native `RESERVE: packed <alab> ... where N slots of group G
reach`.

## D-074 — A builder never moves once construction has begun; own frames are adopted, never reclaimed; the commander on the first constructor; factory exits kept clear

**Date:** 2026-09-22. **Status:** Built (native, build24; script).

**Played by the owner.** The commander kept repositioning after starting
the T1 lab, interrupting the build; the advanced lab was placed facing a
construction turret so its units could not leave. The owner's rules: after
construction has begun a builder does not move at all unless energy hits
zero; the commander always helps the first constructor out of the first
lab, deterministically; a factory is never placed where a structure stands
or a planned structure will stand in its exit.

**Diagnosis (native, three causes).** (1) `Reevaluate`'s in-range branch
moves a builder standing on a "structure" cell 64 elmos away every five
seconds; the first lab's held exit cone (D-066) counts as one, so the
commander standing in front of its lab was moved off it, each move
replacing the build command. (2) After such a drop, `OnUnitIdle` retried
`Execute` with the frame standing but no target: the site was "not
possible" (the frame is there), the pinned reservation was already served,
and the task aborted (`aborting <lab> task after required slot -1 failed`).
(3) When the builder's task had been swapped between the order and the
frame's creation, the frame-created handler reclaimed the fresh frame.

**Decision.**

- *No movement.* `IBuilderTask::Update` returns at once for an experimental
  builder that already holds its build command (`engaged`) on a task whose
  frame exists, while energy is not empty: no re-evaluation, no obstruction
  move, no re-path. A builder newly assigned to a standing frame still gets
  its command (the first cut returned for every assignee and the base idled
  five minutes on a full bank). The engine's own build-range handling stays.
- *Adopt, do not abort or reclaim.* `Execute` takes an own unfinished frame
  of the task's def within four squares of the site as its target before
  any site search; the frame-created handler, when the builder's task does
  not own the frame, gives it to the task that ordered it (same def, same
  site) and never reclaims it.
- *The commander on the first constructor.* `TechChain::CommanderOnFirstConstructor`:
  while the T1 lab stands and no T1 constructor is alive, the commander
  guards (assists) the lab; a count, not a timer.
- *Exits clear.* Native `IsExitClear(def, pos, facing, 320, 32)`: the ground
  in front of a factory footprint, the exit cone's size, holds no structure
  cell and overlaps no planned slot of any group. Applied in `PickMost`
  (the advanced lab in the turret layout), in `PackNearPoint` (gantries and
  labs placed by the stock search) and in the first lab's ring search; the
  advanced lab's exit cone is held once it stands, like the first lab's.

**Files.** [`BuilderTask.cpp`](../src/circuit/task/builder/BuilderTask.cpp),
[`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp),
[`TerrainManager.h/.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`tech_build.as`](../data/script/src/roles/tech_build.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as).

**Played (benchmarks, build25).** T2 lab 6:23, advanced fusion 14:56, both
met; no builder left a started construction in either game; the commander
assisted the lab until the first constructor was out. With the exit rule no
footprint inside the turret box qualifies for the advanced lab (something
always stands or is planned in front of it), so the lab returns to the pair's
planned slot, whose exit is clear by design; the score there counts only the
box's slots, not the pair's own turret block beside it. A few turbine orders
still lose their pinned slot and their frames are left standing for the
sequence to assist (KI-412 keeps the trace).

**What to watch.** No `EXP: leave` of a builder with `target yes`; `EXP:
adopt` / `EXP: frame ... adopted` instead of `aborting ... required slot -1`;
`[TECH][Chain] the commander assists the T1 lab until the first constructor
is out`; the advanced lab's exit cone held; no factory with a turret slot
in front of it.

## D-075 — Build power scales with the bank: a turret whenever metal income outruns spending during a construction

**Date:** 2026-09-22. **Status:** Built (script only, no native change); Played, see below.

**Played (15-minute screenshot game, build25, run `20260922-133909`).** The
advanced fusion was ordered at 11:21 and finished at 15:32 while the metal
bank climbed from 1,280 to 3,398 and energy sat full: the tail was build-power
limited. The playtest widget reported no construction turret because its
`isBuilding` filter needs a yardmap, which BAR's turrets lack (fixed in the
widget); the AI's own `defence.base` gate shows the first turret stood by
11:25. The owner's rule: "If
metal income is higher than metal spending that means one of two things. If
no construction has started (excluding construction turrets) build the next
highest priority building. If there is a building under construction but
metal income is still high that means build a construction turret."

**Diagnosis (KI-413, KI-414).** (1) The chain's two turret frames (step 10,
placed 8:10 and 8:57) were abandoned at 10:10: every builder that asked the
chain while the fusion (step 9, dear) was unfinished was sent to the fusion,
because the step loop meets the fusion before the turrets; the engine's
construction decay killed the frames. (2) At 11:21 the stall guard skipped
the fusion step "made no progress for 120 s" although the fusion had been
under construction since 10:00: `Standing` counts finished units only, so any
dear item that takes longer than `ChainStepStallSeconds` looked stalled.
(3) From 11:21 the turret step was never traced: the cheap branch is silent
when it has nothing to add, so whether a stale queued order or a refused slot
blocked it was invisible. (4) `turret.build` needs the bank at
`EcoFloatMetalPercent` (80 %) of storage to call metal floating; the bank sat
at 33 to 78 % while rising by 700 a minute. (5) The T1 constructors fell to
`defence.base`, which re-ordered a light laser at the factory centre fifteen
times in two minutes; native refused every site ("no site for corrl within
512"), the whole box being held cells.

**Decision.**

1. The owner's rule is a row of its own, `power.turret`, placed before
   `chain.next` so it applies during and after a rush: when the metal bank
   is full for `PowerAheadSeconds` (15) or has risen by `PowerAheadRise`
   (30) over that window (income above spending, read from the bank; see
   below), the bank holds `PowerTurretBankFactor` (1.5) turret costs, energy is not stalling and a
   structure of ours is under construction within `ChainAssistRadius`, the
   builder orders a construction turret on the box slot nearest a lab
   (`Layout::NanoTask`), `PowerTurretsConcurrent` (2) at a time; the rest
   assist the turret going up. The rule stops once static build power near
   the base reaches `PowerBuildPowerPerMetal` (20) workertime per metal/s of
   income (played: without the cap the first game built 45 turrets in the
   three minutes after the advanced fusion, when converters kept a structure
   under construction while income outran the pull). Before the advanced lab
   is under way only a bank full for `PowerAheadSeconds` counts, not a rising
   one (played on build30: a rising bank of 800 sent the commander to a
   turret at 4:00 and the advanced lab came at 7:13). The cap does not apply
   while the metal bank has been full for `PowerAheadSeconds`: a full bank
   with a structure under construction is build power short whatever the
   ratio says (played on build29, run `20260922-202036`: the advanced fusion
   took six minutes at a full 8,000 bank with the rule at its cap). The first half of the rule, nothing under
   construction, is the rows that follow: `chain.next` while a rush runs,
   then the economy rows in their order. Logged as `[TECH][Power] +N metal
   over a pull of P with B banked while <def> is under construction: turret
   by <builder>`; a refused slot as `[TECH][Power] no turret slot`.
2. The chain finishes a cheap step's frame beside the builder before anything
   else: within `ChainNearFrameRadius` (600) of the builder, before the step
   loop, so a dear step further down the chain no longer pulls every builder
   off a turret or a turbine that is a few seconds from done.
3. The stall guard counts a frame under construction as progress: the stall
   clock resets while `GetUnfinishedCount` of the step's def is above zero.
4. The cheap branch says at level 1, when the counts change, why it has
   nothing to add: `nothing to add (unfinished U, queued Q[, pending])`.
5. `Defence` orders each def at most `ExpDefenceMaxOrders` (3) times and
   searches `ExpDefenceRadius` (900) around the factory centre instead of
   native's 512, so a base whose box holds every near cell gets its light
   laser on the box's edge or gives up, never a loop.

**Why the pull, and why not (played on build28).** The engine's metal pull
is the demand of every builder and factory this frame; it is inflated by a
dear build in progress, so during the advanced fusion the bank sat full
for a minute with income under the pull and the rule stayed silent (INV-004
fired four times, run `20260922-193856`). The rule now reads the bank:
`TechBuild::MetalAhead` is true when the bank has sat at
`InvariantFloatPercent` (90 %) of storage for `PowerAheadSeconds` (15) or
risen by `PowerAheadRise` (30) over that window, from a once-a-second
sample in `TechBuild::Tick`. `isMetalFull` and the 80 % float test answer a
different question (is the bank about to overflow) and were the reason
`turret.build` stayed quiet for four minutes of rising bank.

**Files.** [`tech_rules.as`](../data/script/src/roles/tech_rules.as)
(`power.turret`, `MetalAhead`, `StructureBuilding`, `DoPowerTurret`, the
context's `mPull` / `aheadM` / `building`),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as) (near-frame
pre-pass, stall guard, cheap-branch trace),
[`tech_build.as`](../data/script/src/roles/tech_build.as) (`Defence` cap and
radius), [`global.as`](../data/script/src/global.as) (`ChainNearFrameRadius`,
`PowerAheadSeconds`, `PowerAheadRise`, `PowerTurretBankFactor`, `PowerTurretsConcurrent`,
`ExpDefenceMaxOrders`, `ExpDefenceRadius`);
[`tech_rules.md`](roles/tech_rules.md), [`tech_chain.md`](roles/tech_chain.md),
[`tech_build.md`](roles/tech_build.md), KI-413 and KI-414 in
[`known-issues.md`](known-issues.md).

**Played (graphical, run `20260922-142706`, zero bonus, tech vs tech).** T2
lab 5:38, T2 mex 8:01, fusion 11:17, advanced fusion 15:37; turrets at 5:55,
10:14 and 11:44 from the rule, seven more in the half minute after the
advanced fusion, ten in all against the cap; the metal bank stayed between
356 and 585 during the advanced fusion's build (3,398 before); no chain step
skipped; two base-defence orders in the game. Open: after the objective the
bank climbs to 8,098 by 20:00 at +150 metal because nothing dear is ordered
once the chain is done (converters, storages and a T1 lab only), which is
the post-objective priority list, not this rule.

**What to watch.** `[TECH][Power]` lines during the fusion and the advanced
fusion with `finished cornanotc` following them; the metal bank under 1,000
during the tail; no chain step skipped while its frame is under construction;
at most three `base defence:` orders per def.

## D-076 — One lifecycle state per structure; invariants checked in every game; the actor matrix

**Date:** 2026-09-22. **Status:** Built (script; native `CmdStop` binding, build26); Played, see below.

**Played by the owner.** A Lazarus was being built at the T1 bot lab while
a T1 constructor and a construction turret were reclaiming it. The owner's
question: which methodology stops bugs of this shape from repeating.

**Diagnosis.** `ReclaimT1Lab` enqueued the reclaim and kept the lab's id in a
variable only it read. `Tech_FactoryAiMakeTask` still saw a live T1 lab and
kept it producing; the turret rows saw a reclaim in reach and joined. Three
actors, three ideas of what the lab was. The class: from D-063 to D-075 every
decision added a rule inside one actor, none enumerated the other actors on
the same object, and none left a check behind (the commander re-asked off
its lab, D-074; turret frames decayed, D-075; the T1 lab reclaimed at full
storage, D-072; the light-laser loop, D-075). Each was fixed where it was
seen and verified by one log reading.

**Decision.** The practice in
[`practice-invariants.md`](practice-invariants.md), enforced by
`tools/knowledge/check_invariants.py` in the pre-commit hook:

1. **One lifecycle state per structure.** `Lifecycle`
   (`data/script/src/manager/lifecycle.as`): retiring and gone, recorded once
   by the act that decides them, read by every actor. `TechBuild::Tick` retires
   the T1 lab the moment the advanced lab is under way (`IntoT2`); `Retire`
   stops the unit and its queue (`CCircuitUnit::CmdStop`, new script binding),
   so the unit inside the factory is dropped; `Tech_FactoryAiMakeTask` returns
   nothing for a retiring factory; `GuardFactory` and
   `CommanderOnFirstConstructor` refuse a retiring lab; the reclaim rule is the
   only act that targets it, and turrets joining the reclaim is allowed.
   `Tech_FactoryAiUnitRemoved` forgets it. Logged as `[LIFECYCLE] <def> <id>
   retiring: <why>` and `... gone`.
2. **Invariants checked in the game.** `Invariants`
   (`data/script/src/manager/invariants.as`), ticked once a second from the
   role's tick and from its unit-added hooks, logs `[INVARIANT] INV-nnn ...`
   when a promise is broken, one line a minute per subject. Every playtest
   check file forbids that line, so the benchmark loop is the regression
   suite. The register is [`invariants.md`](invariants.md).
3. **The actor matrix.** [`actor-matrix.md`](actor-matrix.md): per object,
   every actor and the state it reads; every rule row of the TECH table must
   appear in it.
4. **Play the fix.** A decision from here on names the run that played it.

**Invariant.** INV-001: a retiring factory produces nothing. INV-002: a frame
of ours under construction has build power on it within
`InvariantFrameSeconds`. INV-003: the chain never skips a step whose frame is
under construction. INV-004: metal does not float while a structure is under
construction and static build power is under the income target. INV-005:
only the throwaway T1 lab is ever retired.

**Played (headless, build26, run of 2026-09-22 18:58).** The practice paid
for itself in its first game: `[LIFECYCLE] corlab 4481 retiring` at 3:57,
then `[INVARIANT] INV-001 a retiring factory produced corck` at 3:59, and
two later `[LIFECYCLE] corlab ... retiring` lines at 16:28 and 21:02 for T1
labs the spam rows had just built. Two causes: (1) `CmdStop` drops the unit
inside the factory (the engine's `CFactory::StopBuild` refunds and kills it)
but native's recruit task still held the factory and re-issued the build on
idle, so the retire now aborts the factory's task first
(`CFactoryManager::AbortTask`, new script binding, build27); (2) the retire
keyed on "the primary T1 lab while the advanced lab is under way", which is
also true of every later spam lab. The throwaway is now decided once: the
lab standing at the moment `IntoT2` first holds (`throwawayLabId`, -2 for
none); only it retires and only it is reclaimed; INV-005 says so.

**Enforcement.** `check_invariants.py` fails a commit when a logged `INV-nnn`
has no register row (or a row has no logger), when a check file does not
forbid `[INVARIANT]`, when a TECH rule key is missing from the actor matrix,
or when a decision from D-076 on has no `**Invariant` paragraph. AGENTS.md
names the practice in the workflow and validation sections.

**Files.** [`lifecycle.as`](../data/script/src/manager/lifecycle.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`tech.as`](../data/script/src/roles/tech.as) (includes, tick, the factory
task maker, the unit hooks), [`tech_build.as`](../data/script/src/roles/tech_build.as)
(`Tick` retires, `GuardFactory`), [`tech_chain.as`](../data/script/src/roles/tech_chain.as)
(`CommanderOnFirstConstructor`, INV-003 at the skip),
[`global.as`](../data/script/src/global.as) (`LifecycleMemorySeconds`,
`Invariant*`), [`InitScript.cpp`](../src/circuit/script/InitScript.cpp)
(`CmdStop`), every `tools/playtest/checks/*.json`,
[`check_invariants.py`](../tools/knowledge/check_invariants.py),
[`.githooks/pre-commit`](../.githooks/pre-commit),
[`practice-invariants.md`](practice-invariants.md),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md),
[`AGENTS.md`](../AGENTS.md), the TECH role documents.

**Played.** Headless, build27, run `20260922-191613`: `[LIFECYCLE] corlab 30286
retiring` at the advanced lab's order, `... gone` after the reclaim, no unit
produced by it after the retire, no `[INVARIANT]` line in nine minutes, two
turrets from the power rule at 4:33 and 4:43. The first build26 game that
printed INV-001 and the double retire is described under **Invariant**.

**What to watch.** `[LIFECYCLE] corlab N retiring` at the advanced lab's
order, no unit finished by that lab after it, no `[INVARIANT]` line in any
benchmark run; a run that prints one names the promise that broke.

## D-077 — Turrets grow outward from the layout's centre; T1 energy is reclaimed once fusion-tier income carries the base

**Date:** 2026-09-22. **Status:** Built (script; native `NextSlotConnected`, `FindOwnNear`, build27); Played once, see below.

**Owner's rules.** "Construction turrets should always start at the center
of the planned layout, and build out connecting to central construction
turrets and moving outward. This way the most buildings are in range of the
build power." And: "when energy income reaches a sufficient level windmills,
solars, and advanced solars should be reclaimed. solars/winds reclaimed at
the same level, and advanced solars reclaimed at a slightly higher level.
Certainly by the time an afus is built all wind/solar/advanced solar should
be reclaimed. Research the tech/eco meta for when to reclaim."

**Meta.** The official economy guide: solars are built early when metal
outruns energy and "you can reclaim them to get all this metal back"; reclaim
returns the full metal cost (`modrules.reclaim`, knowledge base
`77-eco-tech-player.md`). Players on wind maps reclaim the turbine field
once a fusion carries the base, and everything T1 once an advanced fusion
stands, for the metal (40 per turbine, 155 per solar, 370 per advanced
solar) and the space in the middle of the base. The knowledge base section
"When to reclaim energy" holds the facts and sources.

**Decision.**

1. **Turrets from the centre outward.** `NextSlotConnected(group, centre)`
   (native): the first turret takes the box slot nearest the box centre;
   every later one takes the unconsumed slot nearest an already consumed
   slot of the group, ties broken towards the centre (score: four times the
   distance to the nearest taken slot, plus the distance to the centre). The
   cluster is connected and grows outward, so the most structures sit inside
   the build power. `Layout::NanoTask` uses it when `ExpTurretCentreOut`
   (true); off restores D-069's nearest-lab choice.
2. **Energy reclaim by income level.** The `energy.reclaim` row (mobile
   builders, before `power.turret`): once a fusion stands and energy is not
   stalling, winds and solars are reclaimed when energy income without the
   T1 sources covers the pull by `ReclaimT1EnergyMargin` (1.25); advanced
   solars when income without every T1 and advanced-solar source covers it
   by `ReclaimAdvSolarMargin` (1.5); an advanced fusion reclaims all of them
   regardless. Nearest the base centre first (`FindOwnNear`, native), within
   `ReclaimEnergyRadius` (1500), `ReclaimEnergyConcurrent` (2) targets in
   flight. Per-unit output for the sums: solar 20, advanced solar 75,
   turbine the map's expected wind. Native's `ReclaimOldEnergy`
   (`reclEnergyEff`) is switched off under the experimental build so the row
   is the one owner of the decision. Logged as `[TECH][Reclaim] <def> <id>:
   energy +E without T T1 and A adv-solar covers a pull of P (fusion
   stands); by <builder>`.

**Invariant.** INV-006: no wind, solar or advanced solar stands
`InvariantReclaimSeconds` (180) after an advanced fusion does.

**Played (headless, build27, run `20260922-192117`).** Fusion 10:38,
advanced fusion 14:11 (the best so far), `[TECH][Reclaim] corwin ...` from
the fusion on. INV-006 fired at 17:11 with 27 structures standing and the
count rising to 32: two causes, both fixed in the same decision. (1) The
legacy strategic rows and the planner kept ordering advanced solars and
turbines after the advanced fusion (`legacy.strategic` for the T2
constructors; the planner's payback rows), so the field grew while it was
being reclaimed. One owner now: `TechBuild::EnergyAllowed`, registered as
`Global::energyAllowed`, is asked by the shared builder helpers
(`EnqueueT1Solar`, `EnqueueT1AdvancedSolar`, `EnqueueT1Wind`) and by the
planner's `Make`: no wind or solar once a fusion stands, no advanced solar
once an advanced fusion is under way. (2) The reclaim's in-flight memory
held two slots for 90 s each whatever happened to the target, so 28
turbines would have taken twenty minutes; a target that is gone leaves the
memory at once (`ai.GetTeamUnit`) and `ReclaimEnergyConcurrent` is 4.

**Actors.** `energy.reclaim` is added to the actor matrix under the banks
and energy; `Layout::NanoTask` under the turret slot.

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp)
(`NextSlotConnected`), [`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp)
(`FindOwnNear`), [`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`tech_build.as`](../data/script/src/roles/tech_build.as) (`ReclaimEnergy`),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as) (`energy.reclaim`),
[`tech.as`](../data/script/src/roles/tech.as) (`reclEnergyEff` off),
[`invariants.as`](../data/script/src/manager/invariants.as) (INV-006),
[`global.as`](../data/script/src/global.as), [`invariants.md`](invariants.md),
[`actor-matrix.md`](actor-matrix.md), [`layout-design.md`](layout-design.md),
the TECH role documents, the knowledge base.

**What to watch.** `[Layout] turret slot N, D from the box centre
(connected)` with D small for the first and every later turret adjacent to
one that stands; `[TECH][Reclaim]` lines after the fusion, none before; no
`[INVARIANT] INV-006`; the metal from the reclaim landing in the bank with
room for it.

## D-078 — The advanced lab is reclaimed while the advanced fusion is built; every turret in range joins any reclaim at once

**Date:** 2026-09-22. **Status:** Built (script; native `TurretsOnReclaim`, build28); not yet Played.

**Owner's rules.** "The T2 lab should be getting reclaimed whenever an
advanced fusion is under construction, and if the metal storage is available
to store the metal cost of the lab. Also, whenever a reclaim task is issued
by any constructor, all construction turrets in range must immediately stop
and assist with reclaiming."

**Decision.**

1. **The advanced lab retires into the advanced fusion.** `TechBuild::Tick`
   (the owner of the state, D-076) retires `Factory::primaryT2BotLab` the
   moment an advanced fusion frame exists (`AfusUnderWay`) and the metal bank
   has room for the lab's metal (`BankHasRoomFor`, the D-072 rule that
   reclaimed metal past the cap is lost): its native task is aborted, the
   unit stopped, `[LIFECYCLE] coralab N retiring`. The `lab.t2.reclaim` row
   (mobile builders, after `lab.t1.reclaim`) has every builder reclaim it
   while the bank keeps room. `lab.t2` no longer orders an advanced lab once
   an advanced fusion is under way or standing (`NoAfusYet`), and the chain's
   `alab` step counts as met from then on, so the lab is not rebuilt.
2. **Turrets join every reclaim now.** Native `TurretsOnReclaim(targetId,
   margin, apply)`: every construction turret within its build distance plus
   `ReclaimTurretMargin` (48) of the target that is not already reclaiming
   it is taken off its task and put on one shared reclaim of the target.
   `TechBuild::PullTurrets` calls it from every reclaim the role orders (the
   throwaway lab, the advanced lab, the energy structures), once per target
   per 30 s, logged as `[TECH][Reclaim] N turret(s) pulled onto <def> <id>`
   and natively as `EXP: turrets: N join the reclaim of <def>(<id>)`. The
   same call with `apply` false is INV-008's probe.

**Played (headless, build28, run `20260922-193856`).** `[LIFECYCLE]
coralab 432 retiring` during the advanced fusion and `gone` after it; no
turret was ever pulled: `TurretsOnReclaim` recognised a turret by
`IsBuilder`, which is false for a construction turret (no build options).
It reads `IsAbleToAssist` now, as `GetStaticBuildPowerNear` does
(build29).

**Invariant.** INV-007: an advanced lab never stays active while an
advanced fusion is under construction and the bank has room for its metal.
INV-008: every construction turret in range of a reclaim of ours is on it
within `InvariantReclaimJoinSeconds` (10).

**Actors.** The advanced lab's rows in the actor matrix gain the retire and
the reclaim; the turret rows gain the native pull.

**Files.** [`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp)
(`TurretsOnReclaim`), [`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp),
[`tech_build.as`](../data/script/src/roles/tech_build.as) (`IntoAfus`,
`AfusUnderWay`, `BankHasRoomFor`, `PullTurrets`, `ReclaimT2Lab`, the retire
in `Tick`, INV-007), [`tech_rules.as`](../data/script/src/roles/tech_rules.as)
(`lab.t2.reclaim`, `NoAfusYet`), [`tech_chain.as`](../data/script/src/roles/tech_chain.as)
(the `alab` step), [`invariants.as`](../data/script/src/manager/invariants.as)
(INV-008), [`global.as`](../data/script/src/global.as),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md), the
TECH role documents.

**What to watch.** `[LIFECYCLE] coralab N retiring` within seconds of the
advanced fusion frame once the bank has room; `EXP: turrets: N join` on
every reclaim; no `[INVARIANT] INV-007` or `INV-008`; the lab's metal in the
bank, not lost past the cap.

## D-079 — No energy structure while energy floats: the surplus is converted and the AI chases metal

**Date:** 2026-09-22. **Status:** Built (script only); not yet Played.

**Played by the owner.** "Advanced fusion was started with an 1100 energy
surplus. This continues to happen ... The cause needs to be documented and
fixed, so always the AI is chasing metal and energy is sufficient."

**Cause, documented.** Not a race and not a bad reading. The rush chain
(D-070) orders each unmet step the moment a builder is free and the site
exists, with no energy check of any kind: `Next` walks the steps in order
and the energy steps (`wind`, `solar`, `advsolar`, `fusion`, `afus`) were
ordered exactly like a mex or a lab. In run `20260922-192117` the fusion
went down at 8:46 with the bank at 92 % and the advanced fusion at 10:39
with the bank at 98 % and income +545, a minute before the fusion's own
+850 arrived; by 11:00 income was +1,407 over a full 10k bank and stayed
there for four minutes while the advanced fusion was built. The converters
that would have turned that surplus into metal are economy rows
(`energy.convert`), which the chain outranks while it runs: the first T2
converter came at 14:47, after the advanced fusion. The same shape
recurred in every rush game since D-070 because nothing in the design
asked whether energy was needed.

**Decision.** Energy is sufficient when the bank has sat at
`EcoConvertEnergyPercent` (90 %) of storage for `ChainEnergyFloatSeconds`
(15), or is at that level now with income over the pull by more than
`ChainEnergyFloatMax` (300): `TechChain::EnergyFloats`, from a once-a-second
sample in `TechChain::Tick`. A third test, the bank up by `ChainEnergyFloatRise`
(100) over the window with the same surplus, whatever its level, catches
the second a fusion completes (played on build29, runs `20260922-195815`
and `20260922-201105`: the advanced fusion was ordered at 85 % and +1,394,
then at 30 % and climbing +700 the second the fusion finished). A positive
surplus reading is honest: the build in progress can only make it smaller. And a float-gated copy of the converter row,
`energy.convert.float`, sits ahead of `chain.next` in the table, so
floating energy is converted whatever the chain is doing: in that run no
converter went up during the four minutes of the advanced fusion at a full
bank because every builder was the chain's. `PickConverter` orders `ConverterParallel` (3) converters at once while
the float holds and reads the surplus as at least half the income (run
`20260922-201552`: the advanced fusion waited from 11:30 to 15:08 for one
T2 converter ordered one at a time from a pull-inflated surplus). The first
test needs no pull at all; the second catches the moment a fusion completes (played on build29, run
`20260922-195358`: the advanced fusion was ordered fifteen seconds after
the fusion at +1,291, before the bank had been full for fifteen seconds).
The bank is read before the pull: the engine's pull is
inflated by the build in progress (played on build28: the advanced fusion
was ordered at a full 10k bank with the pull above income, and INV-009
read +1,159 over the pull one second later). A full bank means nothing can
spend the income, whatever the pull says. While it holds, no energy structure of any tier is ordered by anyone: the chain's
cheap energy steps are passed over for the step after them, its dear steps
(fusion, advanced fusion) return the builder to the economy rows where
`energy.convert` eats the surplus, and `TechBuild::EnergyAllowed` (the
`Global::energyAllowed` hook, D-077) vetoes every energy def for the planner
and the shared builder helpers. Waiting for need resets the stall guard, so
the fusion step is not skipped for it. Traced as `[TECH][Chain] step k/n
afus 0/1: energy floats (+S over the pull, bank B of C): converters first`.
A T2 converter draws 600 E for 10.3 metal (370 metal, 21,000 energy), a T1
one 70 E for 1 metal (1 metal, 1,250 energy), so the surplus of that game
was two T2 converters and twenty metal a second; the advanced fusion is
ordered once the converters have eaten the surplus and the bank falls.

**Invariant.** INV-009: no energy structure is ordered while energy
floats (a new energy frame appearing after the bank has been full for
`InvariantFloatOrderSeconds`, 45, long enough that the order itself was
made while floating).

**Played (headless, build28, run `20260922-193856`, before the bank-based
definition).** Fusion 11:13, advanced fusion 17:23; INV-009 fired for the
fusion and the advanced fusion (ordered with the pull above income at a
full bank) and for turbines and a solar the same way; INV-004 fired four
times for a full metal bank during the advanced fusion with `power.turret`
silent for the same pull reason. Both definitions now read the bank.

**Files.** [`tech_chain.as`](../data/script/src/roles/tech_chain.as)
(`IsEnergyKey`, `EnergyFloats`, `FloatWhy`, the two gates),
[`tech_build.as`](../data/script/src/roles/tech_build.as) (`EnergyAllowed`),
[`invariants.as`](../data/script/src/manager/invariants.as) (INV-009),
[`global.as`](../data/script/src/global.as) (`ChainEnergyFloatSeconds`, `ChainEnergyFloatMax`, `InvariantFloatOrderSeconds`),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md),
the TECH role documents, the knowledge base.

**What to watch.** `converters first` traces before the fusion and the
advanced fusion, `finished cormmkr` before `finished corafus`, the energy
bank under 90 % when `afus 0/1: ordered` is logged, no `[INVARIANT]
INV-009`, and a later advanced fusion than 14:11 accepted as the price of
not floating: the benchmark row says which.

## D-080 — The endgame plans, the metal ladder after the objective, and the income gates for combat

**Date:** 2026-09-22. **Status:** Built, phase 1 (script); Played, see below. Phase 2 is native and open (KI-417, KI-418).

**Owner's rules.** TECH is largely responsible for ending the game: the
others hold the enemy while TECH builds a massive economy, switching into
combat when the team needs it and back to eco. TECH never produces mobile
combat units until +200 metal a second, or +500 when rushing straight to
the best T3. After the economic objective it follows one of: (A) a nuclear
silo the fastest way, the first shot at the enemy tech location on the
opposite side of the map, then normal targeting; (B) +200 metal, T2 fast
assault units, a new economic objective of +500, then mass T3 with many
turrets; (C) +500 before any combat unit; (D) +300, then an end-game
long-range cannon (Ragnarok, Calamity, Starfall) on safe high ground that
sees beyond the front. From +200 metal T2 construction aircraft are the
mobile build power, built as build power needs grow alongside turrets;
with more than five of them, every land constructor guards an allied land
constructor. This also answers KI-415 (the bank floated to 12k after the
objective because nothing dear was ordered).

**Decision (phase 1, built).**

1. **The plan.** `TechPlan` (`tech_plan.as`): `EndgamePlan` is `nuke`,
   `t2rush`, `t3rush` or `lrpc`; `auto` is deterministic from the team id
   (team 0 nuke, 1 t2rush, 2 t3rush, 3 lrpc, and round), so a lobby with
   several TECH players spreads the plans and the same lobby gives the same
   plan. Logged as `[TECH][Plan] <plan> (combat gate +N metal; ...)`.
2. **The ladder.** When the rush objective stands, the chain loads the
   plan's next phase (`TechPlan::NextPhase`) and keeps running. An `income`
   step is climbed, not built: while the 10-second metal income is under the
   target a builder gets, in order, nothing while energy floats (the
   `energy.convert.float` row converts), the nearest T2 mex upgrade it can
   build, the advanced fusion under construction to assist, or the next
   advanced fusion to order. Phases: nuke = [silo unless it was the
   objective, income 200], [T2 air plant, income 500]; t2rush = [T2 air
   plant, income 200], [income 500, gantry]; t3rush = [T2 air plant, income
   500, gantry]; lrpc = [T2 air plant, income 300, cannon], [income 500].
   The chain's `lab` and `alab` guards, the stall guard and the float gate
   apply as before; `aap` (T2 air plant, `Builder::EnqueueT2AirPlant`) and
   `lrpc` (`Builder::EnqueueLRPC` at the start position, native's site
   search) are new step keys.
3. **The combat gate.** `Tech_CombatGate` reads `TechPlan::CombatGate`:
   `PlanT3RushCombatGate` (500) for t3rush, else `PlanCombatGate` (200);
   `ExpCombatMetalIncome` 0 still means never. Plan B's T2 fast assault
   units are what the factory rows produce once the gate opens; T3 in mass is
   the gantry's production, and the many turrets are D-075's rule at a full
   bank.
4. **Build power from +200.** The T2 air plant's production makes T2
   construction aircraft up to `TechPlan::AirConstructorsWanted`: none under
   `PlanAirConstructorsFromMetal` (200), one per `PlanAirConstructorPerMetal`
   (40) of income, at most `PlanMaxAirConstructors` (12).

**Phase 2 (native, open).** KI-418: the nuke's first shot at the enemy tech
location opposite (the military manager's big-gun dice has no such rule) and
the cannon on high ground with sight beyond the front; KI-417: land
constructors guarding allied constructors (the script cannot see allied
units; a `FindAllyNear` binding is the proposal).

**Played (headless, build29, run `20260922-211142`).** The plan never began:
the chain's turbine steps read as unmet once D-077 had reclaimed the
turbines, so it rebuilt them (INV-009 caught a turbine frame at a full
bank) and never completed. An energy step whose era is over (`TechBuild::EnergyRetired`: wind and
solar once a fusion stands, advanced solar once an advanced fusion is under
way) now counts as met; the first version used the float veto for it and
completed the chain at 9:29 while energy floated. The ladder orders a
second advanced fusion while the metal bank is full (`LadderParallelAfus`,
2): run `20260922-211838` sat at a full 12,700 bank for five minutes
assisting one (INV-011 fired, as it should).

**Played (headless, build29, run `20260922-212555`).** Advanced fusion 15:58,
`complete: objective afus` at 16:24, `plan nuke phase 1: silo 1, income 200`,
the silo at 19:34, three more advanced fusions by 23:53 with converters
between them, 40 turrets, metal income +243 at 24:00 against +150 with a
12k bank floating before D-080. INV-011 fired twice in the first two
minutes of the phase while the silo and the advanced fusion were on order
with no frame yet; the ladder caught up. Phase 2 of the plan (the T2 air
plant and income 500) begins past the 24-minute window of the run. INV-010 flagged Lazarus and fast-assist bots, which are build power;
they are excluded.

**Invariant.** INV-010: no mobile combat unit of ours appears while metal
income is under the plan's gate (commanders, constructors, air
constructors, resurrection and fast-assist bots are build power, not
combat). INV-011: past the objective the metal bank
does not float for `InvariantLadderFloatSeconds` (60) while an income step
of the plan is unmet.

**Files.** [`tech_plan.as`](../data/script/src/roles/tech_plan.as) (new),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as) (income steps,
`Ladder`, `LadderUnmet`, the phase hand-over, `aap` and `lrpc`),
[`tech.as`](../data/script/src/roles/tech.as) (`Tech_CombatGate`, the T2 air
constructor target, `TechPlan::Init`),
[`invariants.as`](../data/script/src/manager/invariants.as) (INV-010,
INV-011), [`global.as`](../data/script/src/global.as) (`EndgamePlan`,
`Plan*`, `InvariantLadderFloatSeconds`), [`tech_plan.md`](roles/tech_plan.md)
(new), [`tech_chain.md`](roles/tech_chain.md), [`tech.md`](roles/tech.md),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md),
[`known-issues.md`](known-issues.md) (KI-415, KI-417, KI-418), the knowledge
base.

**What to watch.** `[TECH][Chain] plan <plan> phase 1: ...` right after
`complete: objective`, `mex upgrade` and `advanced fusion ordered` ladder
traces, the metal bank under 90 % while an income step is unmet, no combat
unit before the gate, T2 construction aircraft from +200, and no
`[INVARIANT] INV-010` or `INV-011`.

## D-081 — The turret cluster is a block of four touching rows filled across, with a forward cluster planned in clear space

**Date:** 2026-09-22. **Status:** Built (script; native `NextSlotConnected` scoring and `IsZoneAlly` binding, build30); Played, see below.

**Owner's rules.** "When building construction turrets in the cluster it
should not just be doing one row at a time, it needs to pack construction
turrets close together. Ideally 4 rows per cluster of construction turrets,
working on all rows concurrently. 3 rows is ok if map space is minimal. A
flat area check around base should be done to determine how big the main
base cluster can be and plan at least one cluster forward in clear space,
reposition if taken by allies."

**Why it ran along one row.** The rows were a turret's depth plus a
twelve-cell shelf apart (D-063's shelf for the structures between rows),
so the nearest free slot to a taken one was always in the same row, and
D-077's adjacency rule followed that row to its end before starting the
next. The shelf also spread the block: 192 elmos of other structures
between every two rows of turrets.

**Decision.**

1. **A block.** `LayoutTurretBlock` (true): the rows touch (the pitch is
   the turret's depth) and the shelf for the other structures lies behind
   the block. `LayoutBoxNanoRows` is 4; the rows come first and the shelf is
   what is left behind them (a first version demanded the shelf too and
   fit no box on Supreme Isthmus: the base scattered), a box under
   `LayoutBoxMinRows` (3) rows is not planned, and INV-012 says so if it
   ever is. The
   flat-area check is D-063's box search, which shrinks the box until the
   ground's flat-and-buildable score clears `LayoutBoxMinScore` (75 %):
   that is what sizes the main cluster.
2. **Filled across.** Native `NextSlotConnected` now scores a free slot by
   its distance to a taken slot plus its distance to the centroid of the
   taken slots, so the block grows outward from its seed across every row
   at once instead of along one. The seed is the nearest standing lab
   (D-069's reason: the first turrets must reach a lab; a first version
   seeded from the box centre, 500 elmos from the labs, and the advanced lab
   slipped to 7:01), the box centre only while no lab stands.
3. **A forward cluster.** `Layout::PlanForwardBox`, called when the main
   box is planned and retried every minute from `Update` while none stands:
   a box of the main box's width `LayoutForwardGapCells` (8) ahead of the
   main box's front, straight ahead or half a box to either side, the best
   ground that scores and is not native's ally zone (`IsZoneAlly`, the
   ground around allied builder structures). Its rows are laid in their own
   turret group, so `NanoTask` takes them only when the main block has no
   free slot, and `GrowBox` grows behind only when both are full.
4. **Repositioned when taken.** `Layout::CheckForward` every ten seconds:
   the forward cluster's centre inside an ally zone releases its group and
   zone and plans again `LayoutForwardStepCells` (12) further forward, up
   to `LayoutForwardTries` (3) times. Logged as `[Layout] forward cluster
   ... taken by an ally: given up` and `[Layout] forward cluster AxD cells at
   (x, z), N cells ahead ...`.

**Invariant.** INV-012: the main turret cluster has at least
`LayoutBoxMinRows` rows. INV-013: a main cluster has a forward cluster
planned within `InvariantForwardSeconds` (120), unless every re-plan was
used up.

**Files.** [`layout.as`](../data/script/src/manager/layout.as)
(`PlanBox`, `GrowBox`, `PlanForwardBox`, `CheckForward`, `NanoTask`,
`CanPlaceTurret`, the restored ints), [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp)
(`NextSlotConnected`), [`InitScript.cpp`](../src/circuit/script/InitScript.cpp)
(`IsZoneAlly`), [`invariants.as`](../data/script/src/manager/invariants.as)
(INV-013), [`global.as`](../data/script/src/global.as),
[`layout-design.md`](layout-design.md), [`invariants.md`](invariants.md),
[`actor-matrix.md`](actor-matrix.md).

**Played (graphical, build30, runs `20260922-220128`, `220819`, `221338`).**
`[Layout] turret box 40x20 cells ... 4 rows, 47 of 52 turret slots` and
`[Layout] forward cluster 40x44 cells at (1216, 10164), 8 cells ahead of the
main cluster, ground 99%: 4 rows, 52 turret slots` in every run; the block
fills across its rows from the lab side. The first two runs lost the
opening (advanced lab 7:13 and 7:01) to a block seeded 500 elmos from the
labs and to the power rule's rising-bank test before the advanced lab;
with the lab seed and the full-bank-only test the third run had the
advanced lab at 6:04, the fusion at 11:31 and 21 turrets by 15:30. No
ally took the forward cluster in a tech-versus-tech game, so the re-plan
is Built, not Played. INV-001 (KI-416) and INV-008 each fired once.

**What to watch.** `[Layout] turret box ... 4 rows`, `[Layout] forward
cluster ...` right after it, turrets appearing in a compact block from the
middle outward in the screenshots, the forward cluster filling once the
block is full, no `[INVARIANT] INV-012` or `INV-013`.

## D-082 — The turret block is placed for the ground around it: a halo of packing space on both sides and behind, scored with the block

**Date:** 2026-09-23. **Status:** Built (script only); Played, see below.

**Played by the owner (screenshot).** Fusions and other structures stood
far from the construction turrets, and the first turrets stood against the
mountain with no build space on that side; offset from the mountain, more
ground would have been in reach of the turrets.

**Cause.** `BoxScore` scored only the block's own footprint (flat fraction
times buildable fraction), so a block flush against a mountain scored the
same as one in the open, and the side search reached at most 16 cells (256
elmos). The box zone was the block plus the strip behind the rows: with
D-081's touching rows a 40x20 box left an 8-cell strip, a fusion did not fit
(`no room for corfus in zone 7`), and it went to the box grown 640 elmos
beside, or through the chain's fallback to native's search around the base
centre.

**Decision.**

1. **The halo.** `LayoutHaloCells` (18, 288 elmos, inside a turret's 400
   reach): the ground the structures will stand on is the block plus a halo
   on both sides and behind it, never in front (the factory pair is there).
   `HaloScore` scores it like the block; `PlanBox` and `GrowBox` rank the
   candidates whose block clears `LayoutBoxMinScore` by the halo's score,
   the block's own score breaking ties, and the zone is reserved with the
   halo (`HaloCentre`, `HaloHalfAcross`, `HaloHalfAlong`). The log says
   `ground N%, halo M%`. `PackNearGroup` packs nearest a turret first, so
   converters, fusions and labs surround the block.
2. **A wider search, beside the pair too.** `LayoutBoxSideStepCells` 6 and
   `LayoutBoxSideTries` 8: the block can move 48 cells (768 elmos) either
   way. Candidates level with or ahead of the pair's rear line
   (`LayoutBoxForwardTries` 4 steps of negative rear) are allowed when the
   side offset clears the pair's span plus `LayoutBoxBesideClearCells` (4):
   a pair with a mountain behind it gets its block beside it in the open.
   Halo scores within `LayoutHaloQuantum` (5 %) tie and the nearer candidate
   wins, so a 2 % better halo does not buy a 500-elmo longer walk.

**Invariant.** INV-014: every economy structure the layout places stands
within `InvariantReachElmos` (450) of a turret slot, and none is ordered
through the chain's fallback outside the layout.

**Files.** [`layout.as`](../data/script/src/manager/layout.as) (`HaloScore`
and the halo helpers, `PlanBox`, `GrowBox`, `Place`),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as) (the fallback),
[`global.as`](../data/script/src/global.as), [`layout-design.md`](layout-design.md),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md).

**Played (graphical, build30, runs `20260922-224209`, `225008`, `225544`).**
With the halo alone the block stayed behind the pair against the mountain
(`side 36, ground 79%, halo 44%`; the advanced lab walked to it at 7:32).
With the beside-the-pair candidates it stood in the open north of the pair:
`turret box 40x44 cells at (640, 9972), rear -16, side 48, ground 95%,
halo 66%`, four rows filling across from the lab side, the converters 48
to 76 elmos from a turret, the energy storage 57, the fusion 64, the
advanced fusion 120, the advanced lab where 16 slots reach it, no
`no room for corfus`, no INV-014. The opening's turbines stay at the start
700 elmos south, where the commander built them, and are reclaimed by
D-077; the advanced lab came at 6:55.

**What to watch.** `[Layout] turret box ... side S` with S away from the
mountain and `halo` above 80 %, the fusion and the converters packed beside
or behind the block in the screenshots, no `no room for corfus`, no
`[INVARIANT] INV-014`.

## D-083 — The main cluster is centred on the start; built turrets outrank planned slots for placement; the placement probe is memoised

**Date:** 2026-09-23. **Status:** Built (script; native `PackCandidates` ranking and probe cap, build31; `PickMost` ranked before tested, build33); Played, see below.

**Played by the owner.** The game froze for about fifteen seconds when an
energy converter was placed, and again at the second. The base spread was
far too high: the farthest buildings a long way apart. The owner's rules:
place buildings in range of construction turrets first, and secondarily
where turrets are planned; do not place the first turrets far from the
starting mexes, centred on them or slightly offset.

**Cause of the freeze.** `Layout::CanPlace` asked native
`CanPackNearGroup` for every energy and converter option of every builder
that asked the planner, several times a second. Each probe walked every
cell of the zone against every turret slot of the group (with D-082's halo:
4,700 cells by 100 slots) and tried up to 400 candidates with the engine's
build test. Tens of probes a second on a large zone stalled the simulation;
a converter's order was where it showed. Not the converter itself.

**Cause of the spread.** D-082 let the block stand beside the pair (700
elmos from the start) while the commander's opening (three mexes, the
throwaway lab, the first turbines) stays at the start: two bases.

**Decision.**

1. **The probe is memoised.** `CanPlace` keeps its answer per def for
   `LayoutCanPlaceMemoSeconds` (2); native's `CanPackNearGroup` tries at
   most forty candidates. The order path (`Place`, `PackNearGroup`) is
   unchanged: it runs once per order.
2. **Built turrets first.** Native `PackCandidates` ranks a candidate by
   its distance to the nearest served slot (a turret that stands or is
   being built); a merely planned slot counts as `PLANNED_SLOT_PENALTY`
   (256 elmos) further than it is. The reach test still admits any slot, so
   a zone with only planned turrets still packs; among candidates, the ones
   in range of real build power win.
3. **The block at the start.** `LayoutBoxAtStart` (true): `PlanBox` centres
   its candidates on the start position (the home mexes around it), offset
   by the side and rear search, never over a pair factory slot
   (`InBlock` with `LayoutBoxPairClearCells` 6), ranked by the halo in
   quanta and then by distance to the start, so the block is centred or
   slightly offset from the starting mexes, and the block grows from the
   start side (`NanoTask` seeds `NextSlotConnected` with the start position;
   played on build31: seeded from the nearest lab, and the advanced lab
   having been placed among the planned slots at the far corner, the block
   grew from that corner 600 elmos from the start). Off, the D-082
   pair-relative search is back.

**The freeze, measured (build32, run `20260922-235412`).** `SLOW:
PackNearGroupMost took 8475 ms`, once, at the advanced lab's placement
(D-073's `PickMost`): it ran the engine's build test, the zone flood fill
and the exit-cone test on every one of the thousands of candidates of the
halo zone before scoring it. The owner saw it as a freeze at a converter
because the converter and the lab were ordered together. The probe memo
(item 1) was right but was not the cost. Build33: `PickMost` scores every
candidate cheaply, sorts, and runs the dear tests down the ranked list
until one passes.

**Invariant.** INV-014 (D-082) still holds; the freeze has no invariant of
its own: a sim stall is the engine's to report. Diagnosis instead: every
layout native over 20 ms logs `SLOW: <function> took N ms` (build32), so
the next stall names its cause (KI-419).

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp)
(`PackCandidates`, `CanPackNearGroup`), [`layout.as`](../data/script/src/manager/layout.as)
(`CanPlace`, `PlanBox`, `InBlock`), [`global.as`](../data/script/src/global.as),
[`layout-design.md`](layout-design.md), [`actor-matrix.md`](actor-matrix.md).

**Played (graphical, build33, runs `20260923-000940` and `001634`).**
`turret box 40x44 cells at (978, 9990), from the start rear -12, side 30,
ground 98%, halo 91%`: the block 500 elmos north-east of the start on the
open plateau, one cluster with the converters, storages, fusion and
advanced fusion 200 to 220 elmos from a built turret, the opening's T1 lab
and turbines at the start; 59 to 60 fps at ten and fourteen minutes where
the D-082 runs had 14 to 33; the advanced lab's placement 205 and 294 ms
where build32 measured 8,475. With D-084 the advanced lab came at 6:39
and the fusion at 11:14.

**What to watch.** Frame rate steady at a converter order; `[Layout] turret
box ... from the start rear R, side S` with small R and S; converters and
the fusion packed next to standing turrets, not next to empty slots; the
farthest structure of the base within a few hundred elmos of the block.

## D-084 — A dear chain order outranks the float-converter and power-turret rows until its frame exists

**Date:** 2026-09-23. **Status:** Built (script only); Played: run `20260923-001634`, the advanced lab ordered 4:21, its first builder at 5:02, finished 6:39 (7:29 before), the bank at zero by 6:00.

**Played (build33, run `20260923-000940`).** The advanced lab was ordered
at 4:31 and its first builder arrived at 6:06; meanwhile the metal bank sat
at 1,399 of 1,400 for two minutes and the builders built converters and
turrets. The `energy.convert.float` row (D-079) and the `power.turret` row
(D-075) sit ahead of `chain.next`, so a full bank and floating energy sent
every builder that asked to them, the order's own assignee included once
it was re-asked. The two rows exist for a base whose chain is waiting on
the float or building a dear frame; neither meant to starve an order that
has no frame yet.

**Decision.** `TechChain::DearOrderPending`: a dear step (cost at or above
`ChainParallelCostM`) with an order out and no frame. While it holds the
two rows do not fire (`NoDearOrderPending`), so the next builder asked takes
the queued order and the frame appears; once the frame exists the rows are
back, which is the D-075 case (a full bank while a structure is under
construction means build power is short).

**Invariant.** INV-015: a dear chain order does not wait more than
`InvariantDearOrderSeconds` (45) for its first builder.

**Files.** [`tech_chain.as`](../data/script/src/roles/tech_chain.as)
(`DearOrderPending`, `DearOrderPendingSeconds`),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as) (the two rows),
[`invariants.as`](../data/script/src/manager/invariants.as) (INV-015),
[`global.as`](../data/script/src/global.as), [`invariants.md`](invariants.md),
[`actor-matrix.md`](actor-matrix.md), [`tech_rules.md`](roles/tech_rules.md),
[`tech_chain.md`](roles/tech_chain.md).

**What to watch.** `alab 0/1: ordered` followed by a frame within a minute
and the bank falling; no `[INVARIANT] INV-015`.

## D-085 — The advanced lab stands where the turrets are, or will be first: served slots weigh three, ties go to the block's seed

**Date:** 2026-09-23. **Status:** Built (script; native `PickMost`, build37); Played: run `20260923-020738`, the
footprint reserved at plan time at (1272, 10376), 495 elmos from the seed with 15 slots within reach, the lab
ordered on it and finished 7:16, the first block turrets 100 to 150 elmos from it, no INV-016.

**Played by the owner (screenshot) and in run `20260923-001634`.** The
advanced lab stood at (1272, 9608), the north edge of the block, while the
first turrets were built at (1160 to 1256, 10232 to 10280), 650 elmos
south: no turret reached it for minutes. D-073 placed the lab where the most
turret *slots* reach, front first among equals; at 4:21 every slot is
planned and the front is the edge away from the start, while D-083 fills
the block from the start side.

**Decision.** Native `PickMost` (the advanced lab's site) counts a served
slot (a turret stands or is being built) three times a planned one, and
breaks ties by nearness to the block's seed instead of the front. The seed
is one function, `Layout::TurretSeed`: the start position when the box is
planned at the start (D-083), else the nearest standing lab; `NanoTask`
fills the block from it and `T2LabTask` passes it to the placement. The
lab therefore stands at the start side of the block, where the first
turrets go, and once turrets stand it stands among them.

**Played (build35, run `20260923-013242`).** The same site, (1272, 9608):
with every slot planned the count alone decided and the far edge is where
the most slots reach; the tie-break never applied, and INV-016 fired. So a
planned slot counts only within `SEED_SLOT_RADIUS` (560 elmos) of the
seed, the slots the block fills first (every planned slot when none is
that near), served slots always. The exit-cone test moved ahead of the
flood fill in the ranked walk (the placement had grown to 942 ms). Build36.
Build36 played (run `20260923-014719`): the 400-try cap of the ranked walk
was spent on the best-ranked sites inside the block, all facing planned
slots and failing the exit test, and the lab fell back to the pair's slot
(INV-016 again). The cap is gone: the exit test is cheap and the flood fill
runs only for sites that pass it. Build37. Build37 played (run
`20260923-020127`): still the fallback, and the log said why: the opening's
twelve turbines had packed along the block's seed-side row, the very
ground the lab needed, so no footprint with a clear exit was left near the
seed. The lab's footprint is therefore reserved when the box is planned,
on empty ground (`Layout::labSlot`, `tech.box.lab_slot`, the same
`PackNearGroupMost` with the seed), and `T2LabTask` orders the lab on it,
pinned; the pair's slot and the search remain the fallbacks.

**Invariant.** INV-016: the advanced lab, once it has stood
`InvariantLabReachSeconds` (90), has static build power within
`ExpLabBuildPowerReach` (260).

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp)
(`PickMost`, `PackNearGroupMost`), [`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as) (`TurretSeed`, `NanoTask`,
`T2LabTask`), [`invariants.as`](../data/script/src/manager/invariants.as)
(INV-016), [`global.as`](../data/script/src/global.as),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md),
[`layout-design.md`](layout-design.md).

**What to watch.** `advanced lab in the turret layout at (x, z)` within a
few hundred elmos of the start, the first block turrets beside it, no
`[INVARIANT] INV-016`.

## D-086 — The home mexes anchor the layout; the advanced lab goes next to a standing turret

**Date:** 2026-09-23. **Status:** Built (script; native `GetMexCentroidWithin`, exit test in `PackNearGroup`, build38); Played: run `20260923-150457`, home centre 78 elmos from the start, box ranked by halo 95 % at 500 elmos from it (the nearer ground is mountain), the lab on its planned slot 120 to 170 elmos from the first block turrets, no INV-016, 60 fps. The advanced lab finished at 7:38, later than D-083's 6:39: the walk to the block. Role-switch fix (script only): `Layout::OnRoleLeave` clears TECH's energy veto and anchors.

**Owner's rules (screenshot of an Armada TECH).** The advanced lab stood far
from the build power. The turrets start at the centre of the layout and
spread from there; the place to start them is near the home mexes, where
most builders are by then, to minimise walking. Whenever a building is
placed, pick the position closest to the construction turrets while
honouring the layout.

**Decision.**

1. **One anchor: the home mexes.** Native `GetMexCentroidWithin(start,
   OpeningMexRadius, OpeningMexCap)` is the centroid of the home mex spots,
   known from the map at setup. `Layout::HomeCentre` (logged once as
   `[Layout] home centre (x, z), D from the start`) is the box search's
   anchor (`PlanBox`), the seed the block fills from (`TurretSeed`, D-081
   and D-083) and the lab's tie-break (D-085). `LayoutSeedAtHomeMexes`
   (true); off, the start position as in D-083.
2. **The lab next to a standing turret.** The footprint reserved at plan
   time (D-085) is kept only while a standing turret is within
   `LayoutLabServedReach` (300). Once a turret stands and none reaches the
   footprint, `T2LabTask` releases it and packs the lab with `PackNearGroup`,
   the packer every economy structure uses: nearest a served turret slot
   (planned slots count 256 elmos further, D-083), ties to the seed, exit
   clear (native `PackNearGroup` now runs the exit test for factories, D-074).
   Logged as `[Layout] advanced lab moved from its planned slot ... next to a
   standing turret`.
3. **Every other building** was already packed nearest a served turret
   (D-083); unchanged.

**Invariant.** INV-016 (D-085) covers it: the advanced lab with no static
build power within reach 90 s after it stands.

**Files.** [`EconomyManager.cpp`](../src/circuit/module/EconomyManager.cpp)
(`GetMexCentroidWithin`), [`EconomyScript.cpp`](../src/circuit/script/EconomyScript.cpp),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp)
(`PackNearGroup` exit test), [`layout.as`](../data/script/src/manager/layout.as)
(`HomeCentre`, `TurretSeed`, `PlanBox`, `T2LabTask`),
[`global.as`](../data/script/src/global.as), [`layout-design.md`](layout-design.md),
[`actor-matrix.md`](actor-matrix.md).

**What to watch.** `home centre` within a few hundred elmos of the start;
the box and the first turret around it; the lab either on its planned slot
with a turret beside it or `moved ... next to a standing turret`; no
INV-016.

## D-087 — Close enough beats best: the block nearest the home mexes among good-enough ground, the lab nearest the seed among well-reached sites

**Date:** 2026-09-23. **Status:** Built (script; native `PickMost` cap, build39); not yet Played.

**Played by the owner.** The game froze and unfroze after the sixth turbine
and the first constructor, and the advanced lab was started far from the
mexes. The owner's install ran build30 with the D-082 script: the 8.5 s
`PickMost` (fixed in build33, D-083) and the box beside the pair (fixed by
D-083 to D-086). Build38 in a sixteen-AI game with four TECH AIs (run
`20260923-151545`) logged no layout call over 20 ms. It still showed the
walk: the box ranked by halo first stood 690 elmos from the home mexes
(`side -42, halo 86%`), one lab site was the most-reached one 1,139 elmos
from the seed, and one TECH found no lab site with a clear exit in the
pair's facing and fell back to the pair's slot with no turret in reach.

**Decision.**

1. **The box**: a halo at `LayoutHaloMin` (70 %) is good enough; among
   good-enough candidates the nearest the home centre wins; only when none
   is good enough does the better halo win.
2. **The lab site** (native `PickMost`): the slot count is capped at
   `LAB_SLOTS_ENOUGH` (8, weighted as before); past it the site nearest the
   seed wins.
3. **The lab fallback**: before the pair's slot, `T2LabTask` packs the lab
   nearest a turret slot with the nearest-turret packer, in the pair's
   facing and then the other three, exit clear. Logged as `[Layout] advanced
   lab nearest a turret slot at (x, z) facing F`.

**Invariant.** INV-016 (D-085) covers the lab; no new invariant.

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp)
(`PickMost`), [`layout.as`](../data/script/src/manager/layout.as) (`PlanBox`
ranking, `T2LabTask` fallback), [`global.as`](../data/script/src/global.as).

**What to watch.** `turret box ... side S` with small S; `advanced lab's
footprint reserved at ... D from the seed` with D a few hundred elmos; no
`advanced lab on the pair's slot`; no `SLOW:` line.

## D-088 — Same-def structures fill a rectangle; the block and its turrets grow from the advanced lab; the lab may face any way

**Date:** 2026-09-23. **Status:** Built (script; native `PackCandidates` centroid, build40); not yet Played.

**Played by the owner (screenshot, D-086 script).** The T1 eco structures
formed an L instead of a filled rectangle; the advanced lab stood nowhere
near the construction turrets, which stood beside the T1 lab. The owner
asked whether those turrets were in the layout, and for a log of the
distance from the nearest turret to the advanced lab: not flush, as the T1
lab's are, means the placement is wrong.

**Causes.** (1) The packer ranked a cell by its distance to the nearest
structure of the same def, which grows a line along whatever it touches
first. (2) The turrets beside the T1 lab are the pair's factory-nano slots,
part of the layout but not of the block; `NanoTask` served them first, so
the first turrets, and the turbines packed nearest a served turret, grew at
the throwaway lab. (3) The advanced lab had to face the pair's direction;
from every site on the home side of the block its exit pointed into
planned turret slots, so only far-edge sites passed (build39 run: 1,099
elmos from the home centre).

**Decision.**

1. Native `PackCandidates` ranks by distance to the centroid of the same-def
   group (standing and planned): the group grows as a filled block.
2. With the block at the home mexes (`LayoutBoxAtStart`) no factory-nano
   slot is served; every turret goes into the block.
3. The advanced lab's site at plan time is searched in all four facings;
   among sites with `LayoutLabMinSlots` (8, weighted) slots in reach, the
   nearest the home centre wins. The block then fills from the lab's
   footprint (`TurretSeed`), so the first turrets stand flush with it.
4. `[Layout] advanced lab N: nearest construction turret D elmos (flush |
   not flush)` is logged whenever the distance changes by 16 or more.

**Invariant.** INV-017: 90 s after the advanced lab stands, the nearest
construction turret is within `LayoutLabFlushElmos` (160, centre to
centre).

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as), [`invariants.md`](invariants.md),
[`layout-design.md`](layout-design.md).

**What to watch.** Turbines and converters as filled rectangles in the
screenshots; `advanced lab's footprint reserved ... D from the home centre`
with D a few hundred; `nearest construction turret ... (flush)`; no INV-017.

## D-089 — Guard tasks are unregistered by the task, not by looking the guarded unit up (crash fix)

**Date:** 2026-09-23. **Status:** Built (native, build42); not yet Played.

**Played by the owner.** The game crashed at 1:39:24 with an access
violation in the AI. The installed DLL was an unstripped 308 MB copy taken
while a build was running, so it carried its own symbols: frame 0
`ITaskModule::DequeueTask` (TaskModule.cpp:103), called from
`CMilitaryManager::UnitDestroyed` (MilitaryManager.cpp:759) on a unit's
death.

**Cause.** `guardTasks` maps a guarded unit to its `CFGuardTask`.
`CMilitaryManager::DequeueTask` removed the entry with
`guardTasks.erase(GetTeamUnit(vipId))`; when the guarded unit had already
left the team (died first, or was given to an ally), `GetTeamUnit` returned
null, nothing was erased, and the entry stayed keyed by the freed unit's
address while the task itself was freed. A later unit allocated at the same
address found the entry when it died and `AbortTask` ran on freed memory.
Not a TECH layout change; the military manager is shared by every role.

**Decision.** `DequeueTask` erases every entry whose task is the one being
dequeued; `UnitDestroyed` erases the entry before aborting its task.

**Invariant.** None in script: a native use-after-free has no in-game
signal before it crashes. The playtests run long all-roles games to reach
the same unit churn.

**Files.** [`MilitaryManager.cpp`](../src/circuit/module/MilitaryManager.cpp).

## D-090 — The pocket test is local and budgeted; the block fills from the advanced lab wherever it stands

**Date:** 2026-09-23. **Status:** Built (native, script; build43); not yet Played.

**Played (build41, run `20260923-160056`).** D-088's rectangle ordering
tried many cells between standing structures first, each rejected by
`LeavesPocket`, which flood-filled the whole halo zone: about 1,100 calls
at 36 to 38 ms, the stutter again. And no lab site reached D-088's eight
slots, so no footprint was reserved; the fallback placed the lab and the
turrets filled from the home centre, 633 to 681 elmos from it (INV-016 and
INV-017 both fired, the log line gave the distance).

**Decision.** `LeavesPocket` flood-fills a window of 8 cells around the
footprint instead of the zone, the window's border counting as open
ground; `PackNearGroup` runs at most 40 pocket tests a call.
`LayoutLabMinSlots` is 4. `TurretSeed` is the advanced lab itself (standing,
or its frame) once it exists, then its reserved footprint, then the home
centre: the turrets fill from the lab however it was placed.

**Invariant.** INV-017 (D-088).

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`layout.as`](../data/script/src/manager/layout.as), [`global.as`](../data/script/src/global.as).

## D-091 — The ferry loads only a finished unit off its factory yard, flies only once the cargo is aboard, and lands only where the cargo can stand

**Date:** 2026-09-23. **Status:** Built (native, build44); not yet Played.

**Played by the owner.** The transport flew to the lab and glitched trying
to lift a unit before it could be picked up; and units were not dropped off,
seen over water and suspected at buildings. The owner's rule: before the
transport leaves to deliver it must be sure the unit is aboard, retrying if
necessary.

**Causes (from the owner's log and `FerryTask.cpp`).**

1. `SetCargo` runs when the donation fires, which can be while the
   constructor is still being built or standing on the lab's yard, and
   `HoldCargo` stops it there. `TO_CARGO` issued the load regardless.
2. The flight to the drop was queued behind the load (shift move, D-056).
   A load the engine refused left the queued move to fly the transport off
   empty; `LOADING` then waited out its 20 s and sent it back.
3. The landing spot came from `FindClosestBuildSite` with the cargo's mobile
   def, which ignores the buildings and water around an ally's start, and
   every retry asked again around the same point: the owner's log shows
   `unload retry 1`, `2`, then `dump retry 4` to `9`, all at (11488, 4720).

**Decision.**

1. `TO_CARGO` waits beside a cargo that is being built (the deadline
   restarts), and walks a cargo standing on a factory's footprint 160 elmos
   off it (`OnFactoryYard`) before the load is ordered.
2. The load is ordered alone; the flight to the drop is ordered only when
   `LOADING` sees the cargo lifted. In `TO_DROP` a cargo on the ground for
   two updates means the load did not hold: back to `TO_CARGO`, within the
   load retries. Logged as `FERRY: cargo N is not aboard; back to load it`.
3. Native `CTerrainManager::FindDropSpot`: rings every 32 elmos around the
   drop, the nearest point whose cell and neighbours are free of structures
   and reservations, that the cargo's move type reaches, not in water for a
   unit that cannot swim, and at least 64 elmos from every spot the engine
   already refused (`refusedDrops`, filled on each unload and dump retry).
   Logged as `FERRY: no standing room ...` when none.

**Invariant.** None in script: the ferry's states are native and already
deadline-bound; the log lines above are the signal.

**Files.** [`FerryTask.cpp`](../src/circuit/task/fighter/FerryTask.cpp),
[`FerryTask.h`](../src/circuit/task/fighter/FerryTask.h),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`transport-ferry.md`](transport-ferry.md).


## D-092 — A factory's exit may cross a layout zone's open ground

**Date:** 2026-09-23. **Status:** Built (native, build45); not yet Played.

**Played (build43, run `20260923-162126`).** `RESERVE: no room for coralab in zone 7 (1210
candidates, 401 tried)` in all four facings; the lab went to the pair's slot and its nearest
turret stood 237 elmos away (INV-017). `IsExitClear` (D-074) rejected every cell with any
struct mark, and `ReserveZone` marks every cell of a zone RESERVED: no lab inside the block's
halo could have a clear exit.

**Decision.** A cell whose only mark is the zone's RESERVED underlay is open ground for the
exit test; standing structures still block it, and planned slots are tested by their
reservations as before. The build that carries it also has D-091's ferry fix (build44 failed
on a missing include in `FerryTask.cpp`, now added).

**Invariant.** INV-017 (D-088).

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp) (`IsExitClear`),
[`FerryTask.cpp`](../src/circuit/task/fighter/FerryTask.cpp) (include).

## D-093 — TECH's economy is placed only by the layout: native's own energy planner is off, and the queue take-over adopts only layout orders

**Date:** 2026-09-23. **Status:** Built (native, build46); not yet Played.

**Played by the owner (screenshot, build43).** The early turbines spread
out instead of growing side by side as a rectangle in the layout, far from
the T1 lab; bots and commanders walk slowly, so the early base cannot
sprawl. The owner's log: every turbine the chain ordered through the layout
packed 48 elmos from the last (`packed armwin at (11480, 2136)`, `(11432,
2136)`, `(11464, 2088)`, ...); the stray ones came from `[TECH][Chain] step
3/11 wind 2/3: takes the queued order`, which adopted a turbine order with
no layout slot, placed by native's point packer 467 elmos from its anchor
(`packed armwin near (11489, 2093) at (11160, 2424), 467 away`), and a
commander walked to one 400 elmos west of the home mexes.

**Cause.** Native's economy planner (`CEconomyManager::MakeEconomyTasks`,
`UpdateEnergyTasks`) still ran for TECH: `MakeCommTask`, `MakeBuilderTask`
and `CreateBuilderTask` call it whenever a native default task is asked
for. D-066 had gated storage and the start factory, not energy. Its orders
went to the builder queue at native's positions, and the chain's queued-order
take-over (D-070) adopted them.

**Decision.** With the experimental build on (TECH only), native's
`MakeEconomyTasks` and `UpdateEnergyTasks` return nothing, and
`FindQueuedTask` never returns an energy, converter, storage or turret order
the layout did not place (`IsLayoutOwned`). Every economy structure of TECH
is placed by `Layout::Place`, which packs same-def structures as a rectangle
nearest a turret (D-083, D-088). Other roles are unaffected.

**Invariant.** INV-014 (D-082): a TECH economy structure ordered outside the
layout.

**Files.** [`EconomyManager.cpp`](../src/circuit/module/EconomyManager.cpp),
[`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp).

## D-094 — The layout's ranking rules live once, in a tested header; the layout script's repeated blocks are helpers

**Date:** 2026-09-23. **Status:** Played (build47: no script error, no stutter, no off-layout turbine; the one INV-017 found a pre-existing gap, D-095).

**Owner's request.** Look for duplication in the new layout code and the
building-sequence code; refactor the experimental code to remove it and make
it reusable, so bugs are easier to find; do not break the sequencing, which
works; write unit tests.

**Survey (native, `TerrainManager.cpp`).** The layout's rules were written
inline, each in the function that used it: the served-versus-planned
turret distance (D-083) and the same-def centroid (D-088) in
`PackCandidates`; the connected block fill (D-077/D-081) with its own
centroid in `NextSlotConnected`; the lab site's weighted slot count, cap and
seed tie-break (D-085/D-087) in `PickMost`; the pocket flood fill (D-072) in
`LeavesPocket`; the ring search and refused-spot test (D-091) in
`FindDropSpot`. Two centroids, three nearest-point loops, three sort
comparators, none testable without the engine.

**Survey (layout script, `layout.as`).** The turret rows were laid by three
copies of one loop (`PlanBox`, `GrowBox`, `PlanForwardBox`), and the copies
had drifted: the forward cluster always laid touching rows whatever
`LayoutTurretBlock` said. The advanced lab was ordered by three copies of the
same enqueue, pin, mark and log block in `T2LabTask`. The box searches ranked
their candidates by three different rules: `PlanBox` by D-087 (nearest
good-enough halo), `GrowBox` by the best halo, `PlanForwardBox` by the best
block score.

**Survey (sequencing: `tech_chain.as`, `tech_rules.as`, `tech_build.as`,
`eco_planner.as`). Reported, not changed (owner: it works).**
1. Three definitions of "energy floats": the rule context's and the
   planner's (bank at `EcoConvertEnergyPercent` now) and the chain's
   `EnergyFloats` (the bank over a 15 s window or the surplus test, D-079).
   `energy.convert` reads the first, `energy.convert.float` the second, so
   the two converter rows can disagree on the same frame.
2. Two definitions of "metal floating": `isMetalFull` or the bank at
   `EcoFloatMetalPercent` (rules, planner) and `TechBuild::MetalFullLong` (90 %
   for 15 s, D-075).
3. `TechBuild::EnergyAllowed` and `EnergyRetired` repeat the same fusion and
   advanced-fusion era test; "standing = count - unfinished" is written out in
   four places.
4. The two lab retirements in `TechBuild::Tick` (abort the native task, then
   `Lifecycle::Retire`) and `ReclaimT1Lab` / `ReclaimT2Lab` share their shape.
Each is a candidate for the same treatment once a change there is wanted;
item 1 is the one most likely to hide a bug.

**Decision.**

1. `src/circuit/terrain/LayoutRanking.h` (engine-free, `circuit::layout_rank`):
   `Centroid`, `NearestSq`, `NextConnected`, `TurretDistanceSq`, `PackKey` and
   `PackBefore`, `Slot`, `WeightedSlots`, `SiteKey`, `MakeSiteKey` and
   `SiteBefore`, `LeavesPocket` on a grid, `RingOrder` and `ClearOf`. The five
   terrain-manager functions gather their inputs from the engine and call
   these; each rule exists once.
2. `layout.as`: `LayRows` lays a box's turret rows (all three callers, the
   forward cluster now honouring `LayoutTurretBlock`); `BetterBox` is the one
   box-ranking rule (D-087), used by `PlanBox` and `GrowBox` (nearness to the
   home centre); `OrderLabOn` orders the advanced lab on a reserved footprint
   (all three sites of `T2LabTask`).
3. Unit tests, `tests/layout_ranking_test.cpp` (49 checks), each named after
   the owner's rule or the played bug it guards: the first turret on the
   seed's side; twelve turrets span three or more of four rows within five
   columns, each touching the block (D-081); served beats planned (D-083);
   twelve same-def structures fill a box of at most 20 cells, no side over
   five (D-088, the L); the pack order; weighted slots near the seed (D-085);
   past eight slots the site nearest the seed wins (D-087, the 1,099-elmo
   lab); pockets; drop-spot rings nearest first and never a refused spot again
   (D-091, the owner's log). `bash tools/run_native_tests.sh` builds them with
   the build container's compiler and runs them; `tests/CMakeLists.txt`
   registers them for `CIRCUIT_BUILD_TESTS`.

**Behaviour.** Native: identical by construction (the same arithmetic,
moved). Script: identical but for the two corrections above (the forward
cluster's rows, `GrowBox` ranking by D-087).

**Invariant.** The unit tests; `run_native_tests.sh` is part of validation
(AGENTS.md).

**Files.** [`LayoutRanking.h`](../src/circuit/terrain/LayoutRanking.h),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`layout_ranking_test.cpp`](../tests/layout_ranking_test.cpp),
[`tests/CMakeLists.txt`](../tests/CMakeLists.txt),
[`run_native_tests.sh`](../tools/run_native_tests.sh),
[`layout-design.md`](layout-design.md), [`AGENTS.md`](../AGENTS.md).

## D-095 — The advanced lab's site is flush with a turret slot before it is near the home centre

**Date:** 2026-09-23. **Status:** Built (native, script; build48); unit-tested; not yet Played.

**Played (build47, D-094's check).** Clean on everything D-094 could have
broken: no script errors, one `SLOW` call per timer (36 ms at most), no
turbine packed off the layout, the box, the lab's planned footprint and the
forward cluster all logged. One violation: `INV-017 the advanced lab's
nearest construction turret is 176 elmos away, not flush (160)`. The lab's
footprint was reserved 16 elmos from the home centre with 9 slots in reach,
but no slot within 160 of it. Build45's lab was flush at 160 by chance: the
D-087 ranking (enough slots, then the nearest the seed) never asked whether a
site touches a slot. The D-094 port of `NextConnected` and the site rule was
checked line by line against the pre-refactor code: the same score, the same
order. The gap predates the refactor.

**Decision.** A lab site gets a `flush` key: a turret slot of the group
(served or planned) within `LayoutLabFlushElmos`. `layout_rank::SiteBefore`
ranks by slots (capped at `LAB_SLOTS_ENOUGH`), then flush, then nearness to
the seed, then nearness to a turret. `PickMost` and `PackNearGroupMost` take
the flush distance from the script (one setting, no native copy). The plan-time
choice among the four facings in `PlanBox` prefers a flush site before a
nearer one; its log line now counts the flush slots.

**Invariant.** INV-017 (unchanged): 90 s after the advanced lab stands its
nearest construction turret is within `LayoutLabFlushElmos`. Unit test
`TestSiteFlushBeforeNearer` (the played 176 against 160).

**Files.** [`LayoutRanking.h`](../src/circuit/terrain/LayoutRanking.h),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`layout_ranking_test.cpp`](../tests/layout_ranking_test.cpp),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md).

## D-096 — Labs face the nearest enemy from the front side of the block, and nothing is packed into a factory's exit

**Date:** 2026-09-23. **Status:** Played (build49 with the script of build50: runs `20260923-184749` and `20260923-185441`).

**Owner's report.** The advanced lab was not facing the front line, stood on
the wrong side of the turret cluster, and was walled in by windmills. A lab
must be able to make units that walk out toward the enemy: later labs make
combat units, and they should flow toward the nearest enemy, with possibly
more than one front.

**Played (build48, run `20260923-174316`).** The pair faced 1 (east, toward
the enemy on Supreme Isthmus); the advanced lab's footprint was reserved at
plan time facing 2 (north), into its own turret column. Two causes:

1. D-088 let the lab take any of the four facings and kept the site nearest
   the home centre. Nothing asked which way the enemy is, or which side of
   the block the lab stands on.
2. The exit was never protected. `IsExitClear` tests the exit once, when the
   site is picked. Nothing kept later structures out of it. A corridor
   (`ReserveZone(..., true)`) holds only cells nobody else holds, and the
   lab's exit lies inside the turret box's zone: even the T1 lab's corridor
   logged `0 of 200 held`. Windmills packed by `PackNearGroup` inside the zone
   could, and did, land in the exit.

**Decision.**

1. The front. `Layout::FrontTarget()` is the nearest seen enemy group whose
   cost is at least `LayoutFrontMinCost` (native `CEnemyManager::GetNearestGroupPos`,
   new binding), else the map centre. `LabFacing()` faces from the home
   centre toward it. `LabFacings()` is that facing, then the two beside it,
   never the one away from the enemy. At plan time the lab takes the first of
   these with a site that enough slots reach. The first order searches (at
   order time) face `LabFacing()`, since an enemy may have been seen by then.
   The D-086 relocation keeps the planned facing.
2. The side. `layout_rank::SiteBefore` gains an `ahead` key between build
   power and flush: a site ahead of the turret slots' centroid along its
   facing, so its units leave away from the block (`AheadOf`, `FacingForward`).
3. The exit. `CTerrainManager::FactoryExitLanes()` lists the exit lane
   (`ExitLaneCells`, the rectangle `IsExitClear` always tested: 320 elmos
   long, 32 elmos of margin a side) of every factory reservation and standing
   factory. `PackCandidates` refuses any footprint that overlaps one, so the
   windmills, converters, fusions and labs the layout packs keep out of
   every exit. This applies only to TECH, because the layout packer is
   TECH's only.

4. The front line (played, run `20260923-184749`: the ranked search alone put
   the lab 726 elmos from the home centre at the block's north end. The
   block's zone ends about 10 elmos past turret row 0, the D-060 factory line,
   so no site in front of the block was inside it). When the block faces the
   front, `ReserveFrontLab` reserves the lab directly in front of the block
   first, its back to turret row 0. It tries from touching the row out to
   `LayoutLabFrontGapCells` (3) cells, slides along the block's width, and
   takes the free, buildable footprint with a clear exit nearest the home
   centre. The ranked search is the fallback.

**Played.** Run `20260923-185441`: `advanced lab on the front line at (1290,
10376) facing 1, 1 cells ahead of turret row 0`. It faces 1, the front is
1, 0 structures stand in its exit lane, and its nearest turret is 112 elmos
(flush). No invariant fired. The screenshot at 12 min shows the lab facing
east with open ground ahead, its turrets behind it, and the windmill block
behind them.

**Invariant.** INV-018: 90 s after the advanced lab stands, it faces
`LabFacing()` and no structure of ours stands in its exit lane
(`CountStructuresInExit`, new binding). The facing, the front and the count
are logged on change. Unit tests `TestSiteAheadOfTheBlock` and
`TestExitLanes`.

**Not in this decision.** Where the units go once they are out is the
military manager's job. Only the exit direction is set here.

**Files.** [`LayoutRanking.h`](../src/circuit/terrain/LayoutRanking.h),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h),
[`EnemyManager.h`](../src/circuit/unit/enemy/EnemyManager.h),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`layout_ranking_test.cpp`](../tests/layout_ranking_test.cpp),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md),
[`layout-design.md`](layout-design.md).

## D-097 — Construction turrets go up one at a time until the metal and the nearby build power pay for more

**Date:** 2026-09-23. **Status:** Played (script; build49's DLL, run `20260923-185441`).

**Owner's report.** Far too many construction turrets were built at once. In
the early game that stalled the economy (the owner's screenshot: five frames
up together). Parallel is right once the economy has grown; before that,
idle constructors should assist the turret going up.

**Cause.** Three paths order a turret: the chain's `nano` step, the
`power.turret` rule and the economy rows' turret pick. Each had its own cap:
the chain one frame per builder for a cheap step, the rule
`PowerTurretsConcurrent` (2) counting frames already started, and the rows
`EcoMaxConcurrentNanos` (1). The rule's count missed orders whose frame had
not started, so five builders asking within a second each passed it. Build48
logged five `turret by corck` orders between frames 8897 and 9313.

**Decision.** One calculation, `Layout::TurretsAllowed()`, enforced where
every turret order passes (`Layout::NanoTask`). With k turrets in flight,
the nearby build power B (mobile and static, within `EcoBuildPowerRadius` of
the base centre, `GetBuildPowerNear`) finishes them in k x T / B seconds
(T = the turret's buildtime, 5300). In that time the bank M and the income I
must pay k x C (C = its metal cost, 230):

- by build power: k <= B x `PowerTurretBatchSeconds` (20) / T, so each
  still finishes fast;
- by metal: k x (C - I x T / B) <= M, so they are paid in full without a
  stall.

The smaller of the two, at least 1, at most `PowerTurretsMax` (8). In flight
means orders not yet started plus frames under construction. A capped
builder assists the turret going up: the rule's `assistnano`, the economy
rows' `assistnano`, and the chain's assist, which now reaches anywhere in
the base when the turret step is capped. `PowerTurretsConcurrent` and
`EcoMaxConcurrentNanos` are gone.

**Worked numbers.** Early: the commander and two constructors, B = 270, so
1 by build power; one turret at a time. Run `20260923-185441` at 9.3 min: B
= 1,290, 4 by build power; a bank of 284 at +29/s gave 2 by metal, then 3
at 395, then 4 at 451. The turrets went up 1, 2, 3, 4 as the bank allowed.

**Played.** Run `20260923-185441`: `turrets: order 1 of 1 allowed (build
power 270 ...)` at 5.9 min; later `order 3 of 4 allowed (build power 1290 (4
by power), bank 451 + 29/s (4 by metal))`. INV-019 did not fire. Earlier run
`20260923-184749`, against build48: the advanced lab finished at 6.47 min
(build48: 7.26). Metal at 10 min was +29.6/s (build48: +24.4). The bank never
floated.

**Invariant.** INV-019: no more turret frames stand unfinished than
`TurretsAllowed()` for `InvariantTurretFlightSeconds` (30).

**Files.** [`layout.as`](../data/script/src/manager/layout.as)
(`TurretsAllowed`, `TurretsInFlight`, `TurretsCapped`, the gate in
`NanoTask`), [`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`eco_planner.as`](../data/script/src/manager/eco_planner.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as), [`invariants.md`](invariants.md),
[`actor-matrix.md`](actor-matrix.md), [`eco-planner.md`](eco-planner.md),
[`roles/tech.md`](roles/tech.md).

## D-098 — The front is the lane the pair faces; a dear frame takes a build-power slot, and a turret going up is finished first

**Date:** 2026-09-23. **Status:** Played (build51, run `20260923-193604`, 16 AIs); script packaged in build52.

**Owner's report.** The layout looked broken; from the owner's start the
factory's right orientation was south but it faced west; a construction
turret and the lab built at once early stall the economy; with metal high,
build power is assisted first.

**Finding (corrected by D-099: the warning below does not name the DLL that runs; the game ran build50): the owner's game ran an old build.** The engine logged
`duplicate Skirmish AI Info found for Skirmish AI SMRTBARb stable` in three
folders (`SMRTBARb`, `SMRTBARb_V1`, `SMRTBARbzzz`) and `using dir
.../SMRTBARbzzz/stable`, a DLL of 09-21 13:45 (sha256 `9e5274f9…`) whose
script has neither D-096 nor D-097. The log's lines are that build's (the
pre-D-094 text `advanced lab in the turret layout at ... front first among
equals`). The folders are the owner's to rename; nothing was written there.

**Still true of the new code.** D-096's front was the straight line to the
map centre: from the north-east start (11437, 1864) that is west, across the
cliffs. The owner's right answer, south, is the lane (native's point on our
side's front line), which the factory pair has always faced.

**Decision.**

1. `Layout::FrontTarget()` is the lane when it is known (more than 100
   elmos from home), else the map centre. A seen enemy group of
   `LayoutFrontMinCost` replaces it only when it is nearer home: a second
   front. The plan log names the lane and the pair's facing.
2. INV-018 compares the lab with the facing it was ordered with
   (`LabPlannedFacing`, saved by `OrderLabOn`), and never away from the
   current front, so a front seen later does not flag a standing lab.
3. Build-power slots. `Layout::TurretSlots()` is D-097's number. Every dear
   frame (`ChainParallelCostM` or more, not a turret) under construction near
   the base takes one slot (native `CBuilderManager::CountUnfinishedNear`, new
   binding). `TurretsAllowed()` is what is left. With one slot, the advanced
   lab under construction leaves no turret. `power.turret`, when capped with
   no turret frame to assist, puts the builder on the structure going up.
4. A turret first. The chain orders a dear step only while a slot is free
   (`Layout::BuildSlotFree()`); otherwise, with a turret frame up, the
   builder finishes that turret (`Layout::TurretFrame()`), and the step is
   ordered with the added power. Cheap steps and the chain's order are
   unchanged.
5. INV-019 compares turret frames with the slots, not with what is left, so
   a turret started before the lab is not a violation once the lab starts.

**Played (run `20260923-193604`, 16 AIs as in the owner's game).** The lane
was known. The north-east TECH base (team 9) logged `the front is (8192,
8192): the labs face 0 (lane (8192, 8192), the pair faces 0)`: south, as the
owner said. The south-west base faced 2. Both advanced labs stood on the
front line, faced the front, and had 0 structures in the exit lane. No
invariant fired. Team 0: the lab was ordered at 2.8 min; at 3.7 min, with
build power 630 (2 slots), `1 dear frames take a slot` left one turret
beside it. The lab finished at 5.70 min, the earliest of the day, with the
bank spent from 1,188 to 18 and no float. `PowerTurretBatchSeconds` (20) is
the setting that decides when two slots exist. At 10 s, the commander and two
constructors would give one slot, and no turret would go up beside the lab.

**Invariant.** INV-018 (facing as ordered, never away, exit lane clear) and
INV-019 (turret frames within the slots), as amended above.

**Files.** [`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp),
[`BuilderManager.h`](../src/circuit/module/BuilderManager.h),
[`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md).

## D-099 — Structures fill the ground within reach of a cluster's turrets, then the next cluster; no reservation in a factory's exit

**Date:** 2026-09-23. **Status:** Built (native, script; build56); unit-tested; played on build54 and build55 (small box).

**Owner's report.** At about +580 metal and +24k energy, the TECH player
stopped building economy; with energy overflowing it should have built more
converters. Then: the box does not need to grow, since buildings beyond it
would be out of the turrets' reach, and there is plenty of buildable ground
around the turrets. Once the ground in range of the turrets is used up,
building moves on to the next closest turret cluster.

**Played (the owner's game, build52; teams 8 and 11).** The two TECH AIs had
packed 130 advanced converters (73 `cormmkr`, 57 `armmmkr`) into their main
boxes. After that, every converter was refused: `no room in the turret boxes
for cormmkr` 1,205 times and `armmmkr` 2,934 times. `GrowBox` found no ground
behind or beside the box scoring 75%. Meanwhile the forward cluster (52
turret slots on 95% flat ground) was offered only turrets, and the ground
around the turrets outside the zone rectangle was never scanned.

**Correction to D-098.** The engine's `duplicate Skirmish AI Info ... using
dir .../SMRTBARbzzz` warning does not name the DLL that runs. The owner's
earlier game ran build50 (it printed D-096's `the front is (6144, 6144): the
labs face 3`), not the 09-21 build as D-098 said. The west facing was D-096's
straight line to the map centre, which D-098 fixed.

**Decision.**

1. The ring. `PackCandidates` scans the zone first. When nothing in the zone
   is left, it scans the ring of ground around the zone out to a turret's
   reach (`Inside` skips what the zone scan covered). A footprint there must
   be free ground, not another plan's zone, not a structure, not in a
   factory's exit, and within reach of a slot. The pocket window is clipped
   to the map, not the zone. The serve-time check holds a reservation that
   stands partly outside its zone by its own mark (played on build53: 542
   reserve-and-drop cycles at one ring site, "ground taken").
2. The next cluster. `Layout::Place` packs the main cluster (its zones and
   their rings), then the forward cluster measured against its own turrets.
   It no longer grows the box. `NanoTask` still grows turret rows when every
   slot is used.
3. Exit lanes at the root. `ReserveBuildingEx` and `CanReserveBuilding`
   refuse any footprint of the layout in a planned or standing factory's exit
   lane, whoever asks. Played on build54: the first lab, reserved at the
   commander, stood in the advanced lab's planned exit (INV-018, one
   structure).
4. The `no room` line is said once per def every 30 s, with how long room
   has been missing.

**Played (build54, box shrunk to 24x16 cells with a 2-cell halo so it fills
within minutes).** 0 `ground taken`, no `no room` line; 28 turbines finished
with 29 reservations (build53: 618). INV-018 still counted the first lab in
the exit lane, which item 3 is for.

**Played (build55, the same small box).** The first lab went to the pair's
own slot, 0 `ground taken`, and the turbines filled the ground around the
turrets outside the box (screenshot, 9 min). INV-018 still counted one
structure: a metal extractor on a map spot south-east of the lab's exit.
5. `CountStructuresInExit` does not count extractors: the spot is the
   map's, and a 3x3 extractor does not wall a lab in (build56).

**Played (build56, 16 AIs, normal box).** Both advanced labs on the front
line, facing the lane, 0 structures in their exit lanes, no script error, no
stutter. INV-016 fired on both TECH teams: the metal never floated, so the
lab (4.98 min) came before any turret, as D-098 wants while build power is
short, and the first turret followed at 9.5 min, 112 elmos from the lab
(flush). INV-016 asked for a standing turret, a timing its D-085 purpose
never meant.
6. INV-016 checks placement: a turret or a planned turret slot within
   `ExpLabBuildPowerReach` of the lab.

**Invariant.** INV-020: the layout does not refuse an economy structure for
lack of room for `InvariantNoRoomSeconds` (120). Unit test
`TestRingSkipsTheZone`.

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`LayoutRanking.h`](../src/circuit/terrain/LayoutRanking.h),
[`layout.as`](../data/script/src/manager/layout.as),
[`global.as`](../data/script/src/global.as),
[`layout_ranking_test.cpp`](../tests/layout_ranking_test.cpp),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md),
[`layout-design.md`](layout-design.md).

## D-100 — Every mex near the start is upgraded before the fusion, unless the metal floats

**Date:** 2026-09-23. **Status:** Played (build57's DLL with this script; benchmark A/B recorded in [`tech-rush.md`](benchmarks/tech-rush.md)).

**Owner's report.** The AI started a fusion before the mexes near it were
upgraded; the fusion would have come sooner with them upgraded.

**Played (the owner's game, build57, teams 8 and 11).** The recipe (D-072)
says `moho 2`: two upgrades, then the fusion. Both AIs upgraded two and
ordered the fusion around 7 min with more mexes still T1.

**Decision.**

1. The moho step's target is every mex of ours within `ChainMohoRadius`
   (2500, the ground the chain's mex steps take), the recipe's count at
   least. It is refreshed on every chain tick and logged when it changes.
   `ChainMohoRadius` 0 restores the recipe's count.
2. While upgrades are pending (`TechChain::MohosPending`), the economy
   rows answer an energy shortage without a fusion or an advanced fusion.
   The chain orders the fusion after the upgrades. Played before this item:
   `energy.short` ordered the fusion with 3 of 8 upgraded, because the
   upgrades' own energy drain made energy short.
3. Unless the metal floats (`TechBuild::MetalFullLong`). Then the upgrades
   are not what the metal waits on: an upgrade in flight keeps its builder,
   the next builder goes on to the next step, and the rows' fusion hold is
   lifted. Played before this item: 9 upgrades one at a time, the fusion at
   15.51 min (12.45 before), 12,747 metal banked.

**Benchmark (headless, zero bonus, Supreme Isthmus, afus objective; one
game each).**

| `ChainMohoRadius` | fusion | first advanced fusion | metal at 15 min | at 20 min |
| --- | --- | --- | --- | --- |
| 0 (the recipe's 2) | 10:29 | 18:38 | +74 | +120 |
| 2500 (this decision) | 15:34 | 17:42 | +99 | +134 |

The fusion comes 5 min later; the advanced fusion, the objective, 56 s
sooner, on a larger income. The owner's rule holds for the objective, not
for the fusion itself: after the advanced lab the fusion is limited by
energy and build power, not metal. One game each is a small sample.

**Seen, not changed.** INV-011 (metal floating past the objective with an
income step unmet) in both variants. INV-010 and INV-015 after the advanced
fusion in the 2500 game.

**Invariant.** INV-021: a fusion frame does not start while a mex within
`ChainMohoRadius` is still T1 with no upgrade under way, unless the metal
floats.

**Files.** [`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`eco_planner.as`](../data/script/src/manager/eco_planner.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md),
[`roles/tech_chain.md`](roles/tech_chain.md),
[`benchmarks/tech-rush.md`](benchmarks/tech-rush.md).

## D-101 — Reclaimed ground is recycled; advanced fusions and converters go in flush sets; a later T1 lab is placed by the layout

**Date:** 2026-09-24. **Status:** Played (build60 and build61; ten benchmark games).

**Owner's request.** Advanced fusions flush against the construction
turrets, with no space. The space of structures TECH reclaims should be
recycled. When the first advanced fusion of a set is queued, reserve up to 2
more in a line moving away from the turrets; after each set (sometimes 1
where space is small) the next starts flush against the turrets again.
Advanced converters the same way, up to 5 a set. The T1 lab rebuilt in its
old footprint is the same bug. With no construction turret of ours on the
map (the start, or a restart after a wipe), a T1 lab may go anywhere;
otherwise it follows the layout. The benchmark to the first advanced fusion
must not suffer.

**Verified cause (the owner's game, build58).** `OnStructureGone` restores a
zone slot for its own def when the structure goes. It was restored 38 times
for turbines, 10 for T1 converters, 2 for solars and 1 for an advanced
solar, each reclaimed on purpose, so their ground stayed held for their own
def. It was also restored for the T1 lab (`armlab at (640, 10224) lost; slot
restored (id 1)`), and when native re-queued a factory after the last one
went (`FactoryManager`, `GetFactoryToBuild(-RgtVector, true, true)`), the
lab was served on it again.

**Decision.**

1. Recycling. Every reclaim task on our own structure (`CBuilderManager`,
   whoever orders it) marks its slot (`MarkSlotRecycled`). When the
   structure goes, the slot is erased, `reclaimed; its ground is free
   again`. A structure lost to the enemy keeps its slot.
2. Flush sets. `PackSet` ranks the packer's candidates by the cells between
   the footprint and the nearest turret slot (`EdgeGap`, 0 = touching), then
   the packer's own order. It reserves the first, then lines up to `count` -
   1 more away from the turret it touches (`SetStep`), stopping at the first
   refused footprint. `Layout::Place` serves the set's next slot
   (`NextSetSlot`) before starting a new set, for advanced fusions
   (`LayoutAfusSetSize` 3) and advanced converters (`LayoutConvSetSize` 5).
   A def not asked for `LayoutSetHoldSeconds` (300) has its unserved set
   slots released (`TickSets`).
3. The T1 lab. `Layout::TurretsStand()`: with a turret standing, a factory
   is placed by the layout (`ReserveFactorySite`: facing the front, nearest
   a turret, exit clear). Native's replacement factory is pinned to that
   slot (`SetResetFactorySlot`, read by `FactoryManager`; played: unpinned,
   native's own search reserved a footprint beside the old lab). The same
   applies to `TechBuild::StartFactory`. With no turret, anywhere.
4. A deadlock D-100 had left (played on the first D-101 run: no advanced
   fusion by 28 min). With the metal floating, the builders go past the
   upgrades. The last upgrade order waited with no frame, D-084's
   pending-order test then blocked the converters, energy floated for 600
   s, and the chain held the advanced fusion for converters (D-079). An
   upgrade is not a pending dear order while the metal floats.

**Played (build60; headless, zero bonus, Supreme Isthmus, afus objective).**
Reclaimed ground freed 65 to 69 times a game; 0 to 2 slots restored (lost
to the enemy). Sets started 0 cells from a turret, except once the flush
ground was used (4 to 5 cells, INV-022). The rebuilt T1 lab went to the
layout's slot `(1168, 9392)`, pinned, and INV-023 stayed silent.

| run | fusion | first advanced fusion |
| --- | --- | --- |
| D-100 (build57 script, one game) | 15:34 | 17:42 |
| D-101 1 (before the pin) | 15:35 | 18:29 |
| D-101 2 | 11:59 | 18:04 |
| D-101 3 | 17:55 | 22:12 |
| D-101 4 | 19:40 | 21:37 |
| D-101 5 | 14:53 | 18:37 |

The median, 18:37, is 55 s after D-100's single game. The two slow games
share one cause, a sequencing interaction rather than the layout. The
chain's fusion order waited with no builder for 2.8 min (INV-015) while
every T2 builder took `mex.upgrade`. With the metal floating, the economy
rows started an advanced fusion first. INV-015 fired in D-100's own
benchmark game too; D-100's longer upgrade list makes it bite more often.
Not fixed here: it is sequencing, which the owner asked to keep; reported
for a decision.

5. A reactor frame is not a reactor (played, windowed run `20260924-001038`:
   the energy-reclaim rule read `afus > 0` from a def count that includes
   frames. An advanced fusion frame with no reactor finished had 29
   turbines reclaimed, energy fell from +704 to +123 with a bank of 1, and
   the frame never finished). `TechBuild::ReactorStands()` counts finished
   fusions and advanced fusions only, for the rule and its predicate. This
   is an older D-077 bug, reachable once D-100 let an advanced fusion start
   early while the metal floats. INV-024.

**Played after item 5 (build61).** Windowed run `20260924-001847`: fusion
11:56, first advanced fusion 16:52, five by 24 min, energy +12,987 at 24
min. The screenshot shows the advanced fusions touching the turret block,
three in a line outward, and converters in rows of five from the turrets.

| build61 run | sets | fusion | first advanced fusion |
| --- | --- | --- | --- |
| `20260924-001847` (windowed) | on | 11:56 | 16:52 |
| `20260924-003349` | on | 17:08 | 20:05 |
| `20260924-003724` | on | 17:57 | 22:59 |
| `20260924-004113` | off (set sizes 1) | 16:49 | 18:50 |
| `20260924-004506` | off (set sizes 1) | 17:25 | 20:29 |

With the sets off the objective is no sooner: the spread is the fusion's
start, the stranded fusion order above, not the layout. Against D-100's
one game (17:42) the median is later; D-100's own spread was never
measured.

**Invariant.** INV-022: a new set's first footprint touches a turret.
INV-024: T1 energy is reclaimed only while a fusion or an advanced fusion
stands finished. INV-023: a T1 lab that is not the first, while a turret stands, has a turret
slot within `ExpLabBuildPowerReach`. Unit test `TestFlushAndSetStep`.

**Files.** [`LayoutRanking.h`](../src/circuit/terrain/LayoutRanking.h),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h),
[`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp),
[`FactoryManager.cpp`](../src/circuit/module/FactoryManager.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`tech_build.as`](../data/script/src/roles/tech_build.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`layout_ranking_test.cpp`](../tests/layout_ranking_test.cpp),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md),
[`layout-design.md`](layout-design.md).

## Process decisions

**No automatic commits.** Nothing in this work was committed by the assistant.
Commit `37146fd0` "Refactor and enhance support for area-effect weapons and
cargo handling" was made by the repository owner and captures D-001 through
D-013.

**Do not accept a diagnosis from a binary you cannot symbolise.** From
[D-003](#d-003--issuddenthreat-null-guard-kept-despite-being-the-wrong-diagnosis).
Record the md5 of every deployed build and keep its `.dbg`; `addr2line`
against mismatched symbols produces a confident, fictional answer.

**Check the AI's own config, not just the game's unit data.** From
[D-014](#d-014--transports-are-matched-by-role-mask-not-main-role). A unit
existing in BAR says nothing about whether this AI has a role entry for it.

**Log effect, not intent.** From
[D-017](#d-017--task-dependent-orders-are-applied-from-the-tick-never-from-a-unit-added-hook).
A line that says "flying to" printed before the order was known to have taken
made a broken hand-over look healthy in the log.

**Decisions log at level 1.** From
[D-024](#d-024--decision-lines-log-at-level-1-because-level-2-does-not-exist-in-a-game-log).
`LOG_LEVEL` is 1; a level-2 explanation of why a unit did nothing is an
explanation nobody will ever read.

**Never trust a dictionary `&out` after a failed `get`.** From
[D-025](#d-025--a-dictionary-out-is-undefined-after-a-miss-check-exists-first).
Check `exists(key)` first, or use the return value; the initialiser on the
variable does not survive the call.

**Deploy `config/` and `script/` with the DLL.** Several of these changes are
config-only or script-only; a DLL-only refresh silently ships stale policy.

## Maintaining this record

Add an entry when a change involved a judgement a reader could reasonably
question — a rejected alternative, a trade accepted on purpose, a deliberate
non-change, or a correction to an earlier decision. Routine work does not need
one.

- Link **every** file the decision touched, with a relative link that
  `tools/knowledge/check_doc_links.py` can resolve.
- State the Status honestly using the
  [vocabulary](#verification-vocabulary). "Built" is not "works".
- When a decision is superseded, mark the old entry and link forward from it;
  never delete it.
- When something here is later found wrong, say so in the entry itself, as
  [D-003](#d-003--issuddenthreat-null-guard-kept-despite-being-the-wrong-diagnosis)
  and [D-010](#d-010--the-nuke-cost-floor-is-a-regression-left-unfixed-pending-a-decision)
  do.
- Keep it in step with [`known-issues.md`](known-issues.md): a decision that
  leaves something open links to the KI, and the KI links back.

## Related

- [`known-issues.md`](known-issues.md) — open problems.
- [`intent.md`](intent.md) — the long-term goals these decisions serve.
- [`../AGENTS.md`](../AGENTS.md) — the repository map and working rules.
