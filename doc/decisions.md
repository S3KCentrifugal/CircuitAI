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

**D-160 correction (2026-10-01).** The extra INV-018 requirement that a
completed lab never face away from a later changing front was invalid: a
standing factory cannot rotate. Compare its saved order facing and retain
the physical exit-obstruction check. This supersedes only that moving-front
assertion, not D-098's original placement, reclaim or build-power policy.
See [D-160 results](telchine-beachhead-results.md).

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

## D-102 — Labs are torn down for metal only before the economy is online; a lab comes back only when wanted, the advanced lab first

**Date:** 2026-09-24. **Status:** Played (script; build61's DLL, two benchmark games).

**Owner's rule.** The T1 bot lab need not be rebuilt with 3 or more T1
constructors and under +200 metal/s. For TECH, T1 labs make T1
constructors (and reclaim bots) at the start; from +200 metal/s they make
spam. The advanced lab goes back up before the T1 lab. Labs are torn down
and reclaimed to feed their metal back into the economy; late in the game
that is pointless. A sequencing change, not a layout one.

**Played before (build60).** The T1 lab was reclaimed at about 4 min
(D-066) and the advanced lab at the first advanced fusion (D-078). Native
then saw no factory able to make builders (`CFactoryManager::DisableFactory`)
and queued a T1 lab in the same frame. Once native was declined, the chain's
`lab 1` step, met only while `IntoT2()`, read unmet again and reordered the
T1 lab (INV-025 caught it within 25 s in both games).

**Decision.**

1. `LabEcoOnlineMetalIncome` (200): at or above it (`TechBuild::EcoOnline`)
   no lab is retired for its metal (D-066 and D-078 gated), T1 labs are for
   spam (`lab.t1.spam` needs it), and the advanced lab is rebuilt when none
   stands (`lab.t2` again).
2. Native's replacement factory (`isReset`): `TechBuild::ResetFactory`.
   With `LabRebuildMinT1Cons` (3) or more T1 constructors below the online
   income, none (the role handler returns `none`, `setup.as` returns no
   factory). Otherwise the advanced lab while none stands, else the T1 lab.
3. A T1 lab after the first (`TechBuild::T1LabAllowed`, read by
   `StartFactory`): always for a restart (no constructor of any tier);
   otherwise only with an advanced lab standing, and with fewer than 3 T1
   constructors or the economy online. The chain's lab step is met for good
   once the T2 phase has begun (`WasIntoT2`).

**Played (headless, zero bonus, Supreme Isthmus).** Run `20260924-101238`:
the advanced lab was reclaimed at the second advanced fusion, `last factory
gone: no lab rebuilt (3 T1 constructors, +103 metal under 200)`, no T1 lab
followed, and the advanced lab was rebuilt at 25:58 once income passed 200.
Run `20260924-101630`: the advanced lab stood to the end; no lab was
rebuilt. INV-025 and INV-026 silent in both. The fusion came at 17 to 18
min in both: the stranded fusion order of D-101, not this change. The
rebuilt advanced lab is not flush (INV-017): the front-line site of D-096
is used; open.

**Invariant.** INV-025: a T1 lab frame after the first starts only when a
lab is wanted (fewer than 3 T1 constructors, or the economy online with an
advanced lab up). INV-026: no lab is retired once the economy is online.

**Files.** [`tech_build.as`](../data/script/src/roles/tech_build.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`setup.as`](../data/script/src/setup.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md).

## D-103 — The air labs are built: a T1 air plant and its air constructor first; T2 constructors while the metal bank is over half

**Date:** 2026-09-24. **Status:** Played (script; build62's DLL; windowed runs `20260924-105433`, `20260924-110418`).

**Owner's request.** Screenshots of the air labs being built. Produce T2
constructors whenever metal is over 50%, to a cap of 60.

**Found.** No air lab had ever been built. In every run that reached plan
phase 2, `step 1/2 aap 0/1 made no progress for 120 s: skipped`. The
advanced aircraft plant (`coraap`, `armaap`) is in the build options of the
T1 and T2 air constructors only (`corca`, `coraca`), not of the T2 bot
constructors TECH has. TECH never made a T1 air plant or an air
constructor, so no builder could take the step.

**Decision.**

1. Plan phases: a T1 air plant step (`ap`) before every `aap` step. Both
   air plants are placed by the layout (`Layout::OrderFactory`: a layout
   site, pinned; the old spiral only if the layout has none).
2. The T1 air plant makes one T1 air constructor while we have no air
   constructor (`Tech_FactoryAiMakeTask`); that constructor builds the
   advanced aircraft plant. Waiting for it is not a stall of the `aap` step.
3. T2 constructors: while the metal bank is over `T2ConstructorBankShare`
   (0.5) of storage and T2 constructors (bot and air) are under
   `T2ConstructorCap` (60), the advanced lab (and the advanced aircraft
   plant) makes one. A unit cap under 60 is raised to 60.
4. Tooling: `--shots minute@height@x:z` points the camera at a map position
   (the air plants stand 700 to 900 elmos from the start, outside the
   start-centred frame).

**Played.** Run `20260924-105433`: T1 air plant 26:13, advanced aircraft
plant 28:07; T2 constructors 4 to 30 of 60 by about 22 min, each logged with
the bank. Run `20260924-110418`: T1 air plant 24:41, advanced aircraft plant
25:35, screenshots at 24.0, 24.5, 25.0 and 26.0 min sent to the owner.
INV-028 fired twice in the first run, at 11.3 and 16.9 min (the bank over
half, no T2 constructor added for 60 s); open. The advanced aircraft plant
stands about 250 elmos from the turret block, not flush: open.

**Invariant.** INV-027: the `ap` and `aap` steps are never skipped.
INV-028: with the metal bank over `T2ConstructorBankShare` and an advanced
lab standing, T2 constructors grow within 60 s until `T2ConstructorCap`.

**Files.** [`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`tech_plan.as`](../data/script/src/roles/tech_plan.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`layout.as`](../data/script/src/manager/layout.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`playtest.py`](../tools/playtest/playtest.py),
[`playtest_camera.lua`](../tools/playtest/widgets/playtest_camera.lua),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md).

## D-104 — Every factory stands flush against the construction turrets; air factories in any facing

**Date:** 2026-09-24. **Status:** Played (build64).

**Owner's rule.** All factory types, T1 and T2 air included, stand tight to
the construction turrets; one whole side of the turrets was still open. Air
factories need not face forward: their units fly and are not blocked by
structures.

**Before.** Factories were placed through many paths: the chain, the rule
table, the legacy expansion code in `tech.as`, and native's own orders. Only
the advanced lab's first site (D-096) and the D-101 layout sites asked for
the turrets, and those ranked by distance to a turret centre, not by contact.
The advanced aircraft plant stood about 250 elmos from the block.

**Decision.**

1. One place for all of them. Native's factory task (`CBFactoryTask::FindBuildSite`),
   when TECH's layout is on and the order has no layout slot, pins it to
   `CTerrainManager::PackFactoryFlush`. That takes the footprint with the
   smallest gap to a turret slot (`PickFlushSite`, 0 = touching) over the
   registered clusters (the main cluster's zones and their rings, then the
   forward cluster). A ground factory faces the front, else a side, never
   away, with its exit lane clear. An air factory (one that builds flying
   units, `MakesAircraft`) takes any facing and skips the exit test. Only once
   a turret of ours stands (D-101: the first lab goes anywhere).
2. The script registers the clusters and the front (`Layout::RegisterFactoryZones`,
   each `Layout::Update`). `ReserveFactorySite` (native's replacement factory,
   `StartFactory`, the air plants) uses the same pick.
3. An advanced lab after the first (its front-line footprint used) is ordered
   flush the same way (`T2LabTask`).
4. `PackSet` (D-101) shares `PickFlushSite`.
5. The advanced aircraft plant's step is not a stall while its air
   constructor lives and the plant is not yet framed (played: skipped while
   the constructor walked to the site). If the plant can never be placed the
   step now waits instead of being skipped.

**Played.** Four builds to get there (build64 to build68), each found in play:
build64 placed the air plants and the silo flush, but the rebuilt advanced
lab went through `T2LabTask`'s ranked search (7 cells out, INV-029), now
item 3. build65 put it flush, but against a planned slot of the forward
cluster, 592 elmos from any built turret (INV-016/017): the pick now ranks
touching a turret that stands (or is going up) first, across clusters and
facings. build67: nothing touched a built turret, because the block's open
front side lies outside its zone and the packer scans the ring only when the
zone has nothing left; flush picks for factories now scan the ring always.
Economy sets doing the same took the front side, so only factories scan it
(build68).

Run `20260924-131356` (build68): the nuke silo, the rebuilt advanced lab
(facing the front), and the T1 air plant were each placed `touching a built
one`; the advanced aircraft plant touched a planned slot (0 cells). Every
factory logged 0 cells (the first lab 1, the D-096 front line). INV-016,
INV-017, INV-027 and INV-029 silent; `PackFactoryFlush` 34 ms at most. The
screenshot at 28 min shows the labs and the air plant on the block's
front side, the advanced fusions and converters on the others.

**Invariant.** INV-029: a factory placed while a turret stands is within 1
cell of a turret slot (1, not 0: the D-096 front-line advanced lab stands 1
cell ahead of turret row 0).

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h),
[`FactoryTask.cpp`](../src/circuit/task/builder/FactoryTask.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md),
[`layout-design.md`](layout-design.md).

## D-105 — Metal is spent: labs kept once online or when the advanced fusion is funded; T2 constructors reclaim last; T1 constructors add build power first

**Date:** 2026-09-24. **Status:** Played (build69; six headless games).

**Owner's rules.** T2 constructors reclaim only as a last resort, when no
other unit with build power is in range of the unit being reclaimed;
otherwise they carry on with their build orders. Before reclaiming the
advanced lab, project the metal: current store plus current income over the
advanced fusion's construction; if 85 % or more of the advanced fusion's
cost will have been earned, the reclaim is unnecessary. T1 constructors add
build power before assisting T2 constructions; reclaiming stays the higher
priority. The economy works so well that the metal is not spent fast enough:
analyse and correct. From +200 metal there is no economic reason to reclaim a
factory (later it may go for other reasons: blocked, or its ground rezoned
for economy). Record every requirement of the conversation in this repo and
the docs repo, and keep them current.

**Analysis (build68, run `20260924-131356`).** Metal income climbed from +140
at 17 min to +343 at 31 min; the bank sat at its cap (12,000 to 14,700) from
17 min on. In that window the turrets assisted structures only; the post-
objective plan's `income 500` step waited on `energy floats` and its answer
was more converters, which make metal into a full bank; T2 constructors came
only once the advanced aircraft plant stood (30 min), then drained the bank
from 14,700 to 10,400 in two minutes. And the rebuilt advanced lab was
reclaimed again at about 27 min with income at +309: `EcoOnline` read the
10-second minimum, which dips under 200 at a higher average. Production is
the sink that works; the labs were being taken away from it.

**Decision.**

1. `TechBuild::EcoOnline` is latched: once the 10-second minimum reaches
   `LabEcoOnlineMetalIncome` (200) the economy stays online, so no lab is
   reclaimed for metal from then on (D-102's rule, now holding).
2. `TechBuild::AfusFunded`: bank + income x (1 - progress) x `AfusBuildTime`
   (330,000) / the build power within `AfusProjectionRadius` (600) of the
   advanced fusion frame; covering `AfusFundedShare` (0.85) of its cost keeps
   the advanced lab (D-078 gated). New binding `CCircuitUnit::GetBuildProgress`.
3. `TechBuild::T2MayReclaim`: a T2 constructor (bot or air) takes the T1 lab,
   advanced lab or energy reclaim only when no other build power (native
   `GetBuildPowerNearExcept`, T2 constructors and the target not counted) is
   within `ReclaimOtherPowerRadius` (600) of the target.
4. Rule `power.t1` (T1 constructors, after the reclaim rows): with a dear
   frame (400+ metal) up and room in the turret calculation, a construction
   turret rather than an assist.
5. No converter while the metal bank is full (`MetalFullLong`): the converter
   rows gated, and the chain's converter hold (D-079) lifted then.
6. Rule `turret.factory`: a turret with nothing in reach and the metal bank
   full assists (guards) a producing factory in its 400-elmo reach.
7. Spam labs scale with income: `ExpSpamLabs` at +200, one more per
   `SpamLabMetalStep` (100) above it, up to `SpamLabsMax` (6); they do not
   wait for the post-objective chain once online (its income ladder keeps it
   active for good), and each is ordered flush against the turrets
   (`Layout::OrderFactory`; played: served the pair's old slot, 32 to 45 cells
   out, INV-029).
8. The requirements of the conversation are gathered in
   [`roles/tech-requirements.md`](roles/tech-requirements.md); the game facts
   and played evidence in the docs repo's `77-eco-tech-player.md` (labs as a
   metal bank, the air labs, the turret block, a full bank).

**Played.** Six headless games, tech versus tech, zero bonus, Supreme Isthmus.

| run | items in | first advanced fusion | late bank |
| --- | --- | --- | --- |
| `20260924-141707` | 1-6 | 17:35 | full at 28 to 31 min (+280 to +301) |
| `20260924-142340` | 1-6 | 20:09 | drained to 3,200 at 24 min, full at 31 (+605) |
| `20260924-144525` | 1-7 (spam labs not yet flush) | 17:22 | drains to 7,600 at 26 min, near full at 30 |
| `20260924-144948` | 1-7 (spam labs not yet flush) | 17:22 | drained to 172 at 24 min, near full at 30 |
| `20260924-145840` | 1-8 | 19:43 | team 0's base destroyed at 26 to 27 min (163 units to 64 in a minute, 145 structures lost to the enemy: most likely team 1's first nuke on the compact base) |
| `20260924-150157` | 1-8 | 19:05 | game ended at 22.9 min (cause not read) |

The advanced lab was kept by the projection in every game that reached it
(`bank 5308 + 69/s x 61 s = 9551 against 8245`); the economy latched online
at +200 and no lab was retired after; T2 constructors reached the cap of 60;
`power.t1` fired 40 to 61 times a game. The first advanced fusion: 17:22 to
20:09 (median about 18:30, against 18:37 in D-101's ten games). The bank
still refills late in most games: production is the sink and it is still
short of the income past +300. Open: more production for the late income
(the spam labs make at most one or two before 32 min), INV-028 (T2
constructor production stalls with the bank over half), and the nuke: a TECH
base is one blast domain (the shared page's 26-structure-explosions) and
TECH builds no anti-nuke before the enemy tech's silo fires.

**Invariant.** INV-031: the advanced lab is not retired while the advanced
fusion is funded without it. INV-032: no converter is ordered while the metal
bank is full. INV-026 (D-102) now holds with the latch.

**Files.** [`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp),
[`BuilderManager.h`](../src/circuit/module/BuilderManager.h),
[`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`tech_build.as`](../data/script/src/roles/tech_build.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`eco_planner.as`](../data/script/src/manager/eco_planner.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`roles/tech-requirements.md`](roles/tech-requirements.md),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md).

## D-106 — Teammates' economies are readable from script; TECH gives its overflowing metal to the lowest-filled teammate

**Date:** 2026-09-24. **Status:** Played (build72).

**Owner's request.** Wire in the bindings to see every teammate's economy,
players included, using the existing list of teammates; every economic
detail, available storage included; a function to update one teammate's
state and one for all, run before decisions such as which teammate needs
metal when TECH is about to overflow. TECH: whenever its metal store is over
95%, trigger the team economy check and send metal to whichever teammate is
lowest, filling their storage, up to 20% of TECH's capacity. A fallback so no
metal is lost to overflow when TECH's build power cannot keep up.

**Engine facts (verified in `bar-RecoilEngine`, recorded in the docs repo's
`15-construction-economy-rules.md`).** An AI reads any allied team's
resources, human or AI (`Game_getTeamResource*`; -1 for an enemy without
cheats). It cannot set a share slider (Lua only). It gives resources with
the send-resources command. That command's handler answers -2 (metal) or -3
(energy), and the C bridge turns any non-zero answer into `false` although
the share message has already gone out: the return value is not a result
(played: 40 sends logged as refused).

**Decision.**

1. Native `CEconomyManager` keeps one snapshot per teammate, built on the ally
   team's list (`CAllyTeam::GetTeamIds`, the start script's teams of our
   allyteam, our own team excluded): bank, storage, income, usage, pull,
   share slider, sent, received, excess, and free storage, for metal and
   energy, with the frame of the update and alive (metal income above 0; the
   engine has no dead-team query for an AI). `UpdateTeamEconomy(team)` and
   `UpdateAllTeamEconomy()` refresh it on demand; `GetOwnEco` exposes our own
   fields the script lacked; `SendResourceTo(resource, amount, team)` sends.
   All bound to script.
2. Script `TeamEconomy` (`manager/team_economy.as`): `UpdateTeam`,
   `UpdateAll`, `Count`, `TeamAt`, `Alive`, `Frame`, `Metal`/`Energy(team,
   field)`, `OwnMetal`/`OwnEnergy`, `MetalFill`, `SendMetal`/`SendEnergy`,
   `Describe`.
3. TECH (`TechBuild::ShareOverflow`, each economy tick): with the metal bank
   at `TeamShareMetalAbove` (0.95) of storage or more, at most every
   `TeamShareCheckSeconds` (5), refresh every teammate and give up to
   `TeamShareMetalBudget` (0.20) of our storage, the lowest-filled live
   teammate first, each up to its free storage, gifts under
   `TeamShareMinAmount` (25) not sent. Not before the opening is complete:
   the start bank is the opening's metal (played: 420 metal given away at
   15 s). Each check logs what the engine counts as sent.

**Played.** 16-AI headless games on Supreme Isthmus, zero bonus, the two TECH AIs
(teams 0 and 9) each with seven teammates.

Run `20260924-155346` (build71): every send logged "refused", the engine's
non-zero answer; the first donation went out at 15 s from the start bank.
Run `20260924-160941`: the refusal removed, but the opening's own flag was
already set at 15 s and 420 metal still went out; the gate is now the first
T1 lab standing.

Run `20260924-161847` (build72 + the lab gate): no donation before the first
lab. Team 0 gave 6 times (240 to 680 metal, each to a teammate 0 to 15%
full), team 9 7 times. The arrival is confirmed: `after the donation: we
sent 916; team 8 received 898`, and `we sent 931; team 10 received 508, team
8 received 408`; teammates 0 to 2% full stood at 443 to 753 right after.
About 2% of a gift is lost on the way (916 sent, 898 received), which may
be BAR's resource-sharing tax. The engine's SENT and RECEIVED cover one slow
update, so a read that misses that window shows 0. INV-033 did not fire.

**Invariant.** INV-033: TECH's metal bank does not sit over
`TeamShareMetalAbove` for 60 s while a live teammate has a quarter of our
storage free.

**Files.** [`EconomyManager.cpp`](../src/circuit/module/EconomyManager.cpp),
[`EconomyManager.h`](../src/circuit/module/EconomyManager.h),
[`EconomyScript.cpp`](../src/circuit/script/EconomyScript.cpp),
[`team_economy.as`](../data/script/src/manager/team_economy.as),
[`tech_build.as`](../data/script/src/roles/tech_build.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`roles/tech-requirements.md`](roles/tech-requirements.md),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md).

## D-107 — Two dedicated air constructors, one for advanced converters, one for advanced fusions; the rest and the turrets follow the energy

**Date:** 2026-09-24. **Status:** Played (script; build73's DLL; run `20260924-171343`).

**Owner's rule.** As soon as the first two air constructors are finished,
one is dedicated to building advanced energy converters only, the other to
advanced fusions only; they always build them. The remaining air
constructors build energy converters while energy is overflowing, and switch
at once to assisting the advanced fusion under construction when the
converters do not have enough energy to stay on. Every construction turret
in range of an economy building assists the same way, after its other
priorities such as a reclaim.

**Decision.**

1. The air constructors are the T2 ones (`coraca`, `armaca`, `legaca`): the
   advanced converter and the advanced fusion are T2 structures, not in a T1
   air constructor's build options. `TechBuild::AirConRole` claims the roles
   in the order the air constructors first ask for work (right after
   `keep.current`): the first builds advanced converters, the second advanced
   fusions; a role freed by a death goes to the next one that asks.
2. Rule `air.dedicated`: the dedicated two always order their own structure
   through the layout (converters in sets of 5, advanced fusions flush in sets
   of 3, D-101), assisting a frame of their own kind when the layout has no
   site.
3. Rule `air.flex`, the other T2 air constructors: advanced converters while
   energy floats (`TechChain::EnergyFloats`); the nearest advanced fusion
   frame the moment the converters cannot stay on (`TechBuild::ConvertersStarve`:
   the energy bank under `ConverterStarveEnergyShare` (0.5) of storage, or
   stalling; BAR's conversion level is 75% of storage by default); else the
   normal rows.
4. Turrets (`Tech_TurretAssist`): after the reclaim, the advanced fusion in
   reach first when the converters starve; otherwise the existing order
   (advanced converter first).

The dedicated converter builder builds regardless of the metal bank (the
owner's "always"), which D-105's converter gate does not apply to; its metal
goes to teammates through D-106 when the bank is full in a team game.

**Played.** Run `20260924-171343` (tech versus tech, 36 min): the first T2
air constructor took the converter role at 23:00, the second the advanced
fusions 10 s later; `air.flex` fired 106 times; eight advanced fusions by
28:22 and 116 advanced converters after 25 min; energy +25,900 and metal
+466 at 34 min, the metal bank at its cap (no teammate in a 1v1). Run
`20260924-171703` ended at 22:54: team 0's nuke silo stood at 21:14 and the
game ended with team 0 whole (117 units), the nuke plan's first shot (the
same end at 22:54 as `20260924-150157`). INV-034 silent.

**Invariant.** INV-034: with two or more T2 air constructors, both dedicated
roles are held within 60 s.

**Files.** [`tech_build.as`](../data/script/src/roles/tech_build.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`roles/tech-requirements.md`](roles/tech-requirements.md),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md).

## D-108 — The dedicated air constructors are never interrupted, never capped, and always replaced

*Amended by [D-123](#d-123--an-air-constructor-with-nothing-to-build-builds-defences): with no site in the layout for its structure, a dedicated builder builds defences meanwhile instead of waiting; the role is kept.*

**Date:** 2026-09-24. **Status:** Played (build78; runs `20260924-185830`, no enemy, and `20260924-190045`, tech versus tech; 36 min each, zero bonus, Supreme Isthmus). Advanced fusions: 11 by 33.7 min and 13 by 36.1 min (before: six to seven, the last at about 27 min), one every 60 to 90 s after 25 min; metal +600 and +727, energy +35,200 and +38,000 at 36 min. Both roles taken at 23.8/24.3 and 27.1/27.4 min; five dead slots given up in the first game, none needed in the second; no crash in either. INV-034, INV-035 and INV-036 silent; INV-037 fired once (32.6 min in the first game: ten advanced fusions stood or were building and the next frame came after three minutes).

**Owner's report and rule.** "The tech player does not make more than 6
AFUS, it kind of stalls after 6 shortly after the 20 minute mark. The
economic scaling and placement was almost perfect until that point though,
it seems to over produce energy converters and not place afus." The
advanced-fusion air constructor has one dedicated duty and is not
interrupted by any other process; the second is for energy converters; if
either is destroyed it is replaced and both roles stay filled.

**Causes found in play.**

1. The cap (run `20260924-181224`): TECH starts with every advanced fusion
   capped at `StartCapAdvancedFusionReactors` (0) and the rush chain raises
   the cap only to its step target (1). The dedicated builder checks
   `IsAvailable` (count under `maxThisUnit`), so from the first advanced
   fusion on it logged `waits for corafus: not available (2 of 1)` for the
   rest of the game; the fusions that did go up came from paths that do not
   check the cap. This was the stall at six.
2. The fall-through (run `20260924-171343`): with no site in the layout the
   dedicated builder fell through the rule table to `chain.next`,
   `energy.convert.float` and `power.turret` and was found building a
   converter.
3. The ground: converters (placed far more often) filled every zone; a new
   set of advanced fusions found no flush site and the sets drifted away
   from the turrets.
4. The handover: a builder that took over a role finished its old job first
   (`keep.current` runs before `air.dedicated`); INV-035 caught it.
5. The dead slot (run `20260924-183010`, with the cap lifted): seven advanced
   fusions by 27.8 min, then none for the last nine minutes. The held
   advanced-fusion slot 204 was refused by the engine
   (`RESERVE: pinned slot 204 for corafus cannot be served`); the task
   aborted, the slot was unclaimed and `NextSetSlot` offered it again, to
   every advanced-fusion order, to the end of the game.

**Decision.**

1. `air.dedicated` never falls through: the builder builds its own structure
   through the layout, else assists a frame of its kind, else waits 3 s and
   logs why (`TechBuild::AirDedicated`).
2. A held role's structure is never capped: `TechBuild::LiftCapForRole`
   raises `maxThisUnit` to one past the count before each order and on every
   economy tick while the role is held.
3. Roles are claimed when the unit is built (`ClaimOnBuilt`, from the
   donation hook, which now keeps a dedicated unit); a role whose builder is
   gone passes at once to another T2 air constructor of ours, the advanced
   fusions first (`RefillAirRoles`), and that builder drops a job of another
   kind (`DropOtherJob`, new builder binding `aiBuilderMgr.AbortTask`); with
   none free the advanced aircraft plant makes one whatever the bank or the
   T2 constructor cap.
4. The ground: a new set is looked for in every zone, then the forward zone,
   then the ring round each zone within turret reach (`Layout::PackSetAnywhere`,
   native `PackSet(..., ring)`); while the fusion role is held the next set
   of advanced-fusion ground is reserved ahead (`Layout::HoldAfusSetAhead`,
   retried at most every 10 s).
5. A dead slot: a pinned slot the engine refuses to build on
   `kDeadSlotFails` (3) times is dead (`SReservation::serveFails`, runtime
   only). It is never offered again (`NextSetSlot`), its ground stays held so
   it is not packed again (`ReleaseSetSlots` keeps it), and the set moves on
   or a new one is found. Every refusal now says why (gone, consumed, another
   def, dead, the engine refuses the ground, out of the builder's reach).

**Crash fixed on the way.** The owner's game of build74 crashed at frame
37960 (about 21 min): an access violation at address 0 in
`CAllyUnit::GetPos`, from `CBuilderManager::FindUnfinishedFor` (the turret
assist of D-107, which scans every frame under construction). The map
`unfinishedUnits` was cleared only when a task was dequeued, by the task's
current target: a frame whose task had already gone, or whose task changed
target, stayed as a key after the unit was freed. Now a unit is erased from
it when it finishes or dies, and a dequeued task erases every entry that
points to it. The same crash had ended run `20260924-181224` (build75) at
31.7 min, first read as the end of the game; builds 76 and 77 played three
long games without it.

**The same crash again, in the owner's 16-AI game (build78, frame 43507).**
Erasing on finish and death was not enough: in a team game a key still
outlived its unit (`CCircuitAI` frees a unit as soon as it is marked dead,
and not every way off the team reaches `CBuilderManager::UnitDestroyed`;
the 1v1 tests never exercised them). The fix no longer depends on finding
every path: the scans (`FindUnfinishedFor`, `FindUnfinishedNear`,
`CountUnfinishedNear`, `GetUnfinishedCount`) walk our live team units and
only look the map up by pointer, never dereferencing its keys; a captured
unit is erased (`UnitCaptured`); a new unit erases any stale entry at its
own address (`UnitCreated`: a freed unit's memory can be reused, and its old
entry would complete a dead task); and a dead builder is refused.

The 16-AI check of that fix (run `20260924-194344`, build80) crashed at
25.8 min elsewhere with the same root: `CSRepairTask::Update` called
`CmdWait` on a unit already freed while still in the task's set. Dropping
the unit from its own task when it is freed was not enough (build81 crashed
the same way at 30.2 min, run `20260924-200952`): the freed unit was listed
by a task other than its current one. So at the one place a unit is freed
(`CCircuitAI::DeleteTeamUnit`) it now leaves every task of every task module
(`ITaskModule::ForgetUnitEverywhere` → `IUnitTask::ForgetUnit`), whatever
path took it off the team, and the log says when it was found in a task
other than its own (`D-108: freed unit N was still listed by K task(s) other
than its own`). Played (build82, 16 AIs, run `20260924-202916`): 36 min, no
crash; the line fired twice at 27.9 min, the two units that would have
crashed the game.

**A second crash, found in verification.** Run `20260924-184618` (build77)
crashed at frame 60373 (33.5 min) in `CScoutTask::FallbackScout`, reached
from `CScoutTask::Update` (upstream code, unchanged on this branch). The
scout task called `GetTravelAct()->IsActive()` without the null check the
fighter task has (a unit's travel action is null after `ClearAct()`), and
iterated its own `units` set while `Execute` can move a unit to another task.
Now it iterates a copy, skips a unit that has left, and guards every travel
action call.

**Invariants.** INV-035: a dedicated air constructor never holds a
construction of another kind. INV-036: while a role is held, its structure
is not capped for 10 s. INV-037: while the fusion role is held and the metal
bank is over half full, a new advanced fusion appears at least every 180 s.

**Files.** [`tech_build.as`](../data/script/src/roles/tech_build.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`layout.as`](../data/script/src/manager/layout.as),
[`donation.as`](../data/script/src/manager/donation.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp),
[`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp),
[`ScoutTask.cpp`](../src/circuit/task/fighter/ScoutTask.cpp),
[`roles/tech-layout-and-sequence.md`](roles/tech-layout-and-sequence.md),
[`roles/tech-requirements.md`](roles/tech-requirements.md),
[`invariants.md`](invariants.md), [`actor-matrix.md`](actor-matrix.md).

## D-109 — The land constructors leave the base: mex-cluster defences and a forward spam cluster

**Date:** 2026-09-24. **Status:** Played, partly (build83 to build88; late games reach it after 25 to 38 min).

**Owner's rules.** Once the T2 air constructors are up, every T2 land constructor
builds defences around the mex clusters, long-range AA and flak first. While more
than 5 T1 air constructors are up, every T1 land constructor goes forward to build
defences and T1 bot labs; idle ones build small construction-turret clusters near
the front, not on a lane. A spam cluster layout type: one or more T1 bot labs, each
with two construction turrets directly behind it; the two turrets nearest a lab
always work for it. One spam lab per +100 metal, started only once the T1 land
constructors are free to leave the base. If a tier's air constructors go down, its
land constructors go back to an eco cluster first.

**Decision.** `TechForward` ([`roles/tech_forward.md`](roles/tech_forward.md)):
release switches (T2: both dedicated air roles held; T1: more than
`T1AirReleaseAbove` T1 air constructors, the T1 air plant keeping 6); `fwd.t2.defend`
(long-range AA then flak at every mex cluster outside the base, the rest help or
follow); `fwd.t1` (the spam cluster: a row of labs toward the front, each reserved
with a 2x1 nano block behind it and its exit clear, the first lab choosing the line,
later labs beside it; one heavy AA behind each lab; 2x2 turret pads behind the end
labs); `turret.spam` first among the turret rows; `land.recall` ahead of
`keep.current`. Base spam labs (`lab.t1.spam`) removed. Native: every slot picker
skips a dead slot; approach points avoid reserved ground (builders parked on the
next turret slot and the engine dropped the build).

**Played.** Build85: 13 long-range AA and 13 flak ordered at release; build84 to
build88: rows of 2 to 5 labs, turret pads behind the row. INV-038 caught labs with
1 of 2 turrets before the approach-point fix.

**Invariants.** INV-038, INV-039, INV-040.

**Files.** [`tech_forward.as`](../data/script/src/roles/tech_forward.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`tech_build.as`](../data/script/src/roles/tech_build.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp).

## D-110 — The ferry picks up reliably and neither transport nor cargo is interrupted

**Date:** 2026-09-24. **Status:** Pickup played (build86 on: every run "aboard"); drop-off not yet (diagnostic in build90).

**Owner's report and rule.** The air transport does not pick up the T2 constructor;
the constructor is given an order after the transport was sent. Both units must be
uninterruptible until the drop-off has succeeded.

**Causes found in play.** No delivery in any run. A constructor on a raised factory
pad read as lifted (height above ground), so the flight order replaced the load and
the transport left empty; the run then sat in DUMPING for the rest of the game
("still lifted, not given") with the queue behind it, until the cargo's 600 s hold
expired and TECH gave it economy work. Damage sent the transport home
(`IFighterTask::OnUnitDamaged`) and could retreat the cargo.

**Decision.** Aboard means lifted and following the transport; the load ends only
when the engine finished the load command and the cargo is aboard; the cargo's hold
ignores damage (`CBWaitTask::SetHold`) and the `ferry.cargo` rule keeps it; the run
is not abandoned on damage; area unload (`FERRY_UNLOAD_RADIUS` 256), 45 s unload,
the drop 300 short of the teammate's start. Open: BAR's
`unit_airtransport_load_unload` allows an air unload only within 10 to 15 elmos; our
transports are dropped from the unload within 5 s at cruise height (build90's
`FERRY: unload check` lines, every 5 s of an unload).

**Invariants.** INV-041, INV-042.

**Files.** [`FerryTask.cpp`](../src/circuit/task/fighter/FerryTask.cpp),
[`WaitTask.cpp`](../src/circuit/task/builder/WaitTask.cpp),
[`ferry.as`](../data/script/src/manager/ferry.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as).

## D-111 — Spam labs run on repeat, each on its own lane set as the factory route

**Date:** 2026-09-24. **Status:** Played (build88: both labs on repeat, lanes 0 and 1).

**Owner's report and rule.** The route from the factory is never set, or is cleared
at once; repeat is not put on; each factory correlates directly to a lane.

**Causes.** Native creates every factory with repeat off; a route was a task handed
to each unit, never the factory's own orders; a unit joined the nearest spam lab's
route, and lanes were numbered by creation order; TECH's start caps pinned the spam
unit at 0 ("corak unavailable" from 28 min).

**Decision.** New bindings `CmdRepeat`, `CmdFactoryRoute`. `TechForward::TickSpam`:
each spam lab on repeat, its lane its place in the row (`Spam::SetFactoryLane`), that
lane its factory route, re-applied when routes change (`Spam::routesVersion`), the
spam unit's cap kept open. `Spam`: a repeat factory gets a wait, not another build,
unless it produced nothing for `RepeatStallSeconds`; a unit runs its producer's lane
for good.

**Invariant.** INV-043: a spam unit given its lane stays on it.

**Files.** [`spam.as`](../data/script/src/manager/spam.as),
[`tech_forward.as`](../data/script/src/roles/tech_forward.as),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp).

## D-112 — A teammate's T2 constructor is frozen from birth to drop-off; the ferry verifies what it carries

**Date:** 2026-09-25. **Status:** Played (build93, 16 AIs, run `20260925-105935`, 30 min): 5 runs, every gift aboard on the first load, flown and handed over at its teammate (near the drop); no gift handed over from base, no re-queue, INV-041 and INV-042 silent, no crash. Build91 (before the rise grace) needed a load retry on nearly every run and looped one gift through failed loads (the attempt counter read an int64 as an int; fixed). Open: the engine still abandons our air unloads (D-110), so every run ends in the set-down-near-the-drop fallback.

**Owner's report and rule.** The transport picked up a T2 constructor and delivered it,
but the one delivered was TECH's own and a constructor still at base changed hands:
it looked as if the transport failed to pick up one constructor and grabbed another.
The T2 constructors built for teammates must perform no action and take no order, so
the pickup cannot go wrong.

**Verified in the owner's log (build90, team 12, cargo 26467).** "cargo 26467 aboard"
at pickup; every 5 s check during the drop said 26467 was not aboard while the
transport landed at the drop (it set a unit down there); the run was judged failed
and the script gave 26467, at base, to the teammate. Gifts queued behind a busy
transport had no hold at all and took TECH's economy orders (up to 4 queued), so at
pickup a gift could be working, on a factory pad or among TECH's own T2 constructors;
"aboard" (lifted and near) passes for a unit standing on a raised pad under the
hovering transport.

**Decision.**

1. A gift (in flight or queued) is out of TECH's builder pool: the `ferry.cargo` rule
   (first for every mobile builder) parks it (`Team::Ferry::Park`: a long wait, one
   walk to a spot `ParkDistance` behind our start, gifts `ParkSpacing` apart) until
   its run, when the ferry's native hold takes over. New binding
   `aiBuilderMgr.AssignTask` (a unit leaves its old task, which carries on) and
   `CmdMoveTo`.
2. Aboard means risen: the cargo's height is recorded when the load is issued and it
   must rise `FERRY_RISE` (16) above it, and follow the transport. The load ends only
   when the engine finished the load command; the transport then sets off, and the
   cargo has `FERRY_RISE_GRACE` (4 s) to show aboard before the load counts as failed.
3. A failed run whose cargo is more than `GiveNearDrop` (800) from the drop gives
   nothing: the gift is parked and queued again, `FerryRunAttempts` (2) flights in
   all, then it walks.
4. After every run the transport flies home and unloads whatever it holds there.
5. Crash fixes on the way (build91): `ForgetUnit` is virtual; a builder task's
   traveled / engaged / approaching sets and a fighter task's cowards / shields forget
   a freed unit too.

**Invariant.** INV-041 now covers the queued gifts as well as the one in flight.

**Files.** [`ferry.as`](../data/script/src/manager/ferry.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`FerryTask.cpp`](../src/circuit/task/fighter/FerryTask.cpp),
[`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`UnitTask.h`](../src/circuit/task/UnitTask.h),
[`BuilderTask.h`](../src/circuit/task/builder/BuilderTask.h),
[`FighterTask.h`](../src/circuit/task/fighter/FighterTask.h).

## D-113 — The BARb widget: a floating window with icons that covers nothing, and it hears the AIs again

**Date:** 2026-09-25. **Status:** Played (playtest screenshots, build93).

**Owner's request.** Verify the widget that controls the BARb AIs; overhaul its UI for
a better experience (it conflicts with and covers other UI elements); give every
button a relevant icon.

**Found.**
- The widget docked into the player list's module stack: its tab strip and a 236 px
  panel sat on the stack's top edge, over whatever else stacks there, and without a
  player list it fell back to the screen corner.
- **No widget received any AI message**: BAR's widget handler
  (`luaui/barwidgets.lua`) does not forward the engine's `RecvSkirmishAIMessage`
  callin (not in its `callInLists`, and `RegisterGlobal` refuses engine callin
  names), so announcements, replies and events never arrived. Played: "no
  announcement", no events.
- The `spam` and `seaassist` topics were never handled; two names leaked as globals;
  the menu blur outlived its tab.

**Decision.** [`tools/widgets/gui_barb_team_link.lua`](../tools/widgets/gui_barb_team_link.lua),
rewritten:
- a small launcher (the AI icon) just left of the player list's top-left corner; the
  window floats over the map to its left, never joins the player list's stack, can be
  dragged by its header, keeps its place and is clamped on screen; Ctrl+Alt+B,
  `/barblink`, Escape as before;
- inside: team chips (when more than one ally team has an AI), the AIs as a
  scrollable list (colour, name, role icon), the selected AI's details, a 3x2 role
  grid, the event log (spam and sea-assist events included); spectators see roles
  read-only;
- icons from the game's own art: FRONT `icons/bot_t2.png`, AIR `icons/air.png`, TECH
  `icons/fusion.png`, SEA `icons/ship.png`, SUPPORT `icons/worker.png`, TACTICAL
  `icons/hover.png`, query `advplayerslist/ping.dds`, query all `icons/radar_t2.png`,
  overlay `icons/eye.png`, close `advplayerslist/cross.dds`, teams
  `advplayerslist/ally.dds`, launcher `advplayerslist/cpu.dds`; a missing file falls
  back to text;
- the widget installs LuaUI's `RecvSkirmishAIMessage` global itself (`getfenv(0)`,
  `Script.UpdateCallIn`), restored on shutdown; if a handler ever forwards the
  callin, the widget's own `RecvSkirmishAIMessage` is used instead.

`tools/playtest/playtest.py --extra-widget <file>` stages a widget into the
playtest's own write dir (never the live game's) for screenshots.

**Played.** A TECH 1v1 playtest (spectator view): the launcher and the window beside
the player list, nothing covered; both AIs' announcements, replies and the role
highlight arrived.

**Invariant.** None in the AI: the widget is host-side LuaUI. It is checked by a
playtest screenshot run (`--extra-widget`): the window beside the player list, the
AIs' announcements and replies in its log.

**Files.** [`gui_barb_team_link.lua`](../tools/widgets/gui_barb_team_link.lua),
[`widget_link.as`](../data/script/src/manager/widget_link.as),
[`playtest.py`](../tools/playtest/playtest.py).

## D-114 — Land factories move toward the front in front factory clusters, turrets first

**Date:** 2026-09-25. **Status:** Played. Build93, TECH 1v1, run `20260925-172313` (45 min): every front lab ordered only with its turret block standing, clusters from 32% to 56% toward the front, T2 and T3 clusters planned. Build95, 16 AIs, run `20260925-194132` (45 min, no crash): T1, T2 and T3 clusters built turrets-first (Legion TECH, team 9), one INV-025 (fixed below). Build96, 16 AIs, run `20260925-202445`: the gantry limits held (two gantry clusters in 20 minutes, not four), but the game died at 41 min in a recursion the build94 crash fix had introduced (below); build96 was never released to play. Build97 carries the corrected fix; see the entry's last bullets for its run.

**Owner's rule.** The TECH role (not FRONT/SUPPORT's front tech; the two are
distinct) moves its land factories gradually toward the front. From +200 metal each
new land factory stands at least 20% closer to the front, further as needed: the
first spot that fits a construction turret cluster with the factory. A front factory
cluster is like a base cluster but holds only construction turrets and one lab: T1
two turrets, T2 more, T3 more still. The turret cluster is always built first. Flat
ground where the factory is placeable, away from allied buildings when possible,
close when necessary. With 3 land factories of any tier, the ones in range of the
main base's turret cluster are reclaimed and never rebuilt there; their zones become
economic zones. With no land factory on the map the base may hold one again.

**Decision.** A new module `TechFactories`
([`tech_factories.as`](../data/script/src/roles/tech_factories.as),
[`tech_factories.md`](roles/tech_factories.md)):
- **Routing.** Every TECH land factory order (the layout's `OrderFactory` and
  `T2LabTask`, the chain's `gantry`, the legacy lab paths of `tech.as`) passes
  `TechFactories::Route` first; once the economy is online and a land factory
  stands, front placement replaces the base's. The D-109 spam labs are the T1
  clusters (`TechForward::SpamClusters`); D-109's own spam search is gone.
- **The search.** From `FrontMinShare` (20%) of the way from home toward the front,
  never behind the furthest cluster yet, up to `FrontMaxShare`, in
  `FrontShareStep` steps with `FrontLateralTries` side positions. Every spot needs
  the cluster's ground `FrontMinFlat` flat, the factory reservable and its exit
  clear; pass 1 also wants a ring of `FrontClearCells` round it `FrontRoomyShare`
  buildable and the site outside allied zones; pass 2 drops that room.
- **The block.** T1 2 x 1, T2 2 x 2, T3 3 x 2 turrets directly behind the factory.
- **Turrets first.** The factory is ordered only once every turret of its block
  stands finished. The first played run ordered the lab in the same tick as the
  turrets ("orders corlab for front cluster 1 (its 0 turrets stand)"): the gate only
  asked whether a slot was free, and claimed slots answer no before any frame
  exists. A slot the engine refuses (a dead slot) never fills, so after 240 s
  without turret work the factory goes up behind the turrets that stand, logged.
- **The base's factories.** Rule `lab.base.reclaim`: with `FrontReclaimAtCount` (3)
  land factories on the map, a land factory within `FrontBaseRadius` of the base
  centre is retired and reclaimed (`ReclaimBaseFactory`) and the layout's planned
  factory footprints there are released to the economy
  (`ReleaseBaseFactoryGround`). `Route` never sends a land factory to the base while
  one stands; with none on the map the opening rules place one again.

- **Carrying T2 and T3 clusters.** Rule `lab.front` (after `lab.base.reclaim`):
  any constructor reaching it rebuilds a standing factory's lost turret, plans a
  T2 front cluster when no advanced lab stands, and works an open T2 or T3
  cluster. The first played run of this left the T2 cluster half-built for 7+
  minutes: its only caller was `lab.t2`, far down the table, which the T2
  constructors never reached while metal floated.
- **The advanced lab first (D-102 kept).** Rezoning retires the base's advanced
  lab too, as the rule asks. After that, and while an advanced lab is only a frame,
  no T1 front lab is ordered and no new T1 cluster planned; the T2 cluster comes
  first. Played: 6 INV-025 before this; one more on build95 (a T1 lab ordered
  while the rezoned advanced lab was being reclaimed), so a retiring advanced lab
  no longer counts. The cost the owner should know: T2
  constructor production stops from the rezoning until the front advanced lab
  stands.
- **Losses.** A standing factory's lost turret is rebuilt (played: INV-038, a
  cluster 56% forward lost both turrets). A lost factory is rebuilt at its
  cluster, its footprint reserved again (played: native had forgotten the
  reservation and a lab was ordered at (-1, 0)); if the ground is taken the
  cluster is given up.
- **Other invariants adjusted.** INV-023 and INV-029 exempt a front lab (it stands
  at its own block); INV-026 exempts the rezoning; INV-039's T1 clock starts no
  earlier than the economy online (it fired the tick the economy latched).

- **A crash the rezoning exposed (build93, run `20260925-180954`, F53834).** Access
  violation in `CIdleTask::Update` (`IdleTask.cpp:64`, symbolised with build93's
  `.dbg`) in the frame team 1 rezoned its base. The idle task walked its
  `updateUnits` set with an iterator and called `AssignTask` for each unit;
  `AssignTask` runs the rule table, and `lab.base.reclaim` re-tasks other idle
  units (the retired factory, the turrets pulled onto it), whose `RemoveAssignee`
  erased them from the set under the iterator. The hazard is older (every turret
  pull could hit it); the rezoning hit it squarely. Fixed in
  [`IdleTask.cpp`](../src/circuit/task/IdleTask.cpp): the slice is taken out of
  the set first, and each unit is assigned only while it is still in the idle
  task (build94).

- **The owner's game crashed on build94 (F43291, TECH as team 10).** Access
  violation in `IBuilderTask::Approach` (`BuilderTask.cpp:604`, symbolised with
  build94's `.dbg`; the deployed DLL's md5 matched build94). `lab.front` gave
  `armck 9237`, a T1 land constructor whose tier was recalled (its air
  constructors down, D-109), a turret for the T3 cluster. The task's own
  `Reevaluate` ran the script policy (`MakeTask`); `land.recall` aborted that very
  task, `lab.front` ordered the same turret again, `Reevaluate` kept "the current
  task" (the aborted one), and `Update` walked on with the unit's actions cleared.
  Two fixes: `Reevaluate` stops when the policy dropped its own task (the unit
  takes what the policy made, or stays idle; build power balanced), in
  [`BuilderTask.cpp`](../src/circuit/task/builder/BuilderTask.cpp) (build95);
  and `TechFactories::Work` and `Refill` give no front work to a recalled
  constructor (`TechForward::Recalled`), so the two rows no longer fight.

- **One factory order per cluster.** The factory's order is kept (a new
  `IUnitTask.IsDead()` binding checks it before reuse); while it lives a capable
  builder joins it (at most two), and a new order goes out only once it ended.
  Played on build95: a T2 lab ordered and not started was re-ordered after
  120 s, and the new order could not pin the slot the first one still held.

- **The replaced paths' limits kept.** Played on build95 (16 AIs): team 9
  planned four gantry clusters in 20 minutes; routing had bypassed
  `EnqueueLandGantry`'s cap (`IsAvailable`) and its cooldown, and `Work` lifted
  the cap. A new cluster is now planned only when the replaced path would have
  ordered the factory (`MayPlan`); a gantry's cap is never lifted.

- **The build94 crash fix recursed (build96, F73809).** A recalled T2 land
  constructor's far mex expansion counted as a forward job: `land.recall`
  aborted it, `mex.expand` handed out the same mex, and `Reevaluate` (build96)
  assigned that new task at once; its start re-evaluated, the recall aborted it
  again, 6066 times in one frame until the stack overflowed and the process died
  mid-line. Fixed in build97: `Reevaluate` leaves the unit with the idle task
  (assigned on a later update, never re-entrantly); a mex or mex upgrade is not
  a forward job; the recall aborts one unit's task at most once per 30 s.
- **Duplicate advanced lab, a stalled factory order (build96).** With no land
  factory the base rebuilt its advanced lab (the owner's rule); being a frame, it
  did not count, and `lab.front` planned a second at the front. Now any advanced
  lab, a frame included, means none is needed. That front order then never
  became a frame for 12 minutes while builders cycled round the site (INV-046
  caught it): a factory order with no frame for `FrontClusterStallSeconds` (300 s)
  now gives its cluster up and releases the ground.
- **Dictionary reads.** The new recall throttle, `searchTry` and D-111's
  `factoryRouteVersion` read their frame values as `int64`, the dictionary's
  integer type (D-112's attempt counter). Played logs show the `int` reads of the
  last two worked (one "on repeat" line per spam lab), so this is consistency,
  not a fix.

**Rejected.** Reusing D-109's row-of-labs search: it anchored a fixed distance
forward and packed labs beside each other, so it could not honour "the first spot
20% closer" nor per-tier blocks.

**Invariant.** INV-045 (new): a front cluster's factory frame starts only with its
whole turret block finished. INV-044 (new): with the count reached, no land factory
stands at the base for `FrontBaseReclaimSeconds`. INV-046 (new): an open T2 or T3
cluster has its factory within `FrontClusterOpenSeconds`. INV-038 now covers every
front cluster, not only the spam labs.

**Not this decision.** INV-004, INV-014 and INV-022 (late-game converter and
fusion packing, metal floating) fire at similar rates in 2-AI runs from
2026-09-24, before D-114.

**Files.** [`tech_factories.as`](../data/script/src/roles/tech_factories.as),
[`tech_forward.as`](../data/script/src/roles/tech_forward.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`layout.as`](../data/script/src/manager/layout.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as).

## D-115 — The host commands the AIs it hosts; camera fly-to; role switches played; crash guards

**Date:** 2026-09-25. **Status:** Played (widget checks and a TECH/AIR swap, build98;
the owner's switch chain replayed without a crash, build98). Open: the owner's
build98 crash (below) did not reproduce; build99 adds the reporter that names it
next time.

**Owner's reports and requests.** The widget's buttons were not clickable in the
owner's game; a way to fly the camera to an AI's commander (else its nearest
factory); role swaps tested from 20 minutes into a game, after checking the
widget works.

**Found.**
- The owner hosts AI-only games as a spectator (`[player0] spectator=1`), and
  the widget let only a *player* allied with an AI switch its role (CR-008): for
  a spectator every role button was drawn grey and registered no click.
- The role switch itself (`Commands::SwitchRole`) was wired and working; it had
  simply never been reachable from the owner's seat.

**Decision.**
- [`gui_barb_team_link.lua`](../tools/widgets/gui_barb_team_link.lua): the host
  commands the AIs it hosts (`Spring.GetAIInfo`'s hosting player is this
  client): a spectating host every AI, a playing host its allies only (CR-008
  kept for play). A fly-to button beside the query button, and a double-click on
  an AI's row, move the camera to that AI's commander, else its factory nearest
  its start; only when asked. `WG.barblink` exposes the same paths (`SetRole`,
  `GoTo`, `MayCommand`, `Roster`, `LastReply`).
- [`role_swap_test.lua`](../tools/playtest/widgets/role_swap_test.lua) drives
  them in a playtest: the host check and a fly-to check at 2 min, TECH/AIR
  swaps at 20, 30 and 40 min, and the owner's switch chain (TECH, FRONT, AIR,
  SEA, FRONT at 8.5 to 18.5 min).
- **Crash on the first swap (build97, F36014):** `IBuilderTask::Update` used a
  builder's travel action after `CCircuitUnit::ClearAct` (a unit leaving another
  task) had wiped it; the switch aborts and reassigns many tasks at once. Every
  travel-action use in [`BuilderTask.cpp`](../src/circuit/task/builder/BuilderTask.cpp)
  is guarded now (no travel action: nothing to walk), as `FighterTask` already was.
- **The owner's crash on build98 (F38302, after one AI was switched TECH, FRONT,
  AIR, SEA, FRONT):** an access violation inside the script engine (`asBC_FREE`
  released an object already freed, during `AiMakeTask` from
  `IBuilderTask::Reevaluate`). The engine's trace names no AI and no script line;
  replaying the chain did not crash. [`ScriptManager.cpp`](../src/circuit/script/ScriptManager.cpp)
  now installs a reporter (a Windows vectored exception handler, first in the
  chain, removed with the last AI): an access violation inside a script call
  logs `SCRIPT CRASH` with the team and the script call stack before the engine's
  crash handler runs (build99).
- **Forward pads:** a pad the ground could not hold was kept empty (build98:
  groups 123 and 124 with 0 of 4 slots filled `SpamPadsMax`); now released, and
  retried at most once a minute ([`tech_forward.as`](../data/script/src/roles/tech_forward.as)).

**Played.** Build98, 16 AIs: the spectating host may command all 16; fly-to put
the camera on team 0's commander (0 elmos) in two runs (a third read 1,846 elmos
while the window was in use); TECH/AIR swap at 20 min: both "ok", no crash
(build97 crashed there); a manual switch clicked in the game window completed;
the owner's chain replayed to 30 min without a crash.

**Invariant.** None in the AI for the widget (host-side LuaUI): the playtest
driver's `[RoleSwap]` lines are its check (host may command, camera on the
target, each switch replied "ok"). The crash guards are checked by the swap run.

**Not this decision.** Construction turrets told to "approach" a far site
(`EXP: approach: armnanotc`, over a thousand a game since 2026-09-24): harmless,
the engine ignores a move for a static unit.

**Files.** [`gui_barb_team_link.lua`](../tools/widgets/gui_barb_team_link.lua),
[`role_swap_test.lua`](../tools/playtest/widgets/role_swap_test.lua),
[`BuilderTask.cpp`](../src/circuit/task/builder/BuilderTask.cpp),
[`ScriptManager.cpp`](../src/circuit/script/ScriptManager.cpp),
[`tech_forward.as`](../data/script/src/roles/tech_forward.as),
[`playtest README`](../tools/playtest/README.md).

## D-116 — An advanced lab footprint the engine refuses is given up; the T1 lab waits for a real frame

**Date:** 2026-09-26. **Status:** Built (build101), played for regressions; the refused-site path itself not yet met in play. Build100 (the safety nets alone), partly played. The owner's infolog shows the cause. A headless replay on All That Glitters with an Armada TECH on the northern spot (build100, 16 AIs, 14 min) built the advanced lab, and the throwaway T1 lab was retired only once its frame existed (F6661, order at F5745). The harness starts the AI at the map file's spot (4211, 609), not the owner's (4286, 592), so the layout planned the footprint 144 elmos west, at (4056, 1048), and the engine accepted it: the dead-footprint branch itself is not yet played. In play it logs "[Layout] advanced lab's planned footprint ... refused by the engine (a dead slot)".

**Owner's report.** In the owner's game on All That Glitters (build99) the TECH AI
on one side never built its advanced lab and got stuck; the TECH AI on the other
side played well.

**Found (the owner's infolog).** Team 2 (Armada, the northern TECH spot):
- F153: the layout reserved the advanced lab's footprint at (4200, 1048), slot 63;
- F5335: the engine refused that ground three times ("pinned slot 63 for armalab
  cannot be served: the engine refuses the ground"); the slot went dead (D-108:
  never served again, its ground held) and the order was aborted;
- from F10733, every advanced lab order was pinned to the same dead slot again
  (`Layout::labSlot` still named it; `GetReservationPos` still answers for a dead
  slot) and aborted at once: "no atomic factory cluster fits", "aborting armalab
  task after required slot 63 failed", for 15 minutes (INV-015 every minute);
- F10743: meanwhile the throwaway T1 lab was retired "because the advanced lab is
  under way": `TechBuild::IntoT2` counts a queued order, and the order was queued,
  so team 2 was left with no land factory at all.

Team 3 (Legion, the southern spot) got its advanced lab at F5828 and went on to
the advanced fusion. Both labs have the same 9 x 9 footprint and slope limit; the
map is not a perfect mirror.

**Why the ground was refused (probed in a game on the same map).** At (4200, 1048)
the engine's own test (`Spring.TestBuildOrder`) answers BLOCKED: the footprint's
ground runs from 167.6 to 328.8, a 161-elmo cliff across its east side, against
an allowed 17 (`maxHeightDif`). No feature or unit stood on it. The accepted site
144 elmos west spans 7.9, Legion's 7.1.

**Which logic chose it.** `Layout::ReserveFrontLab` ([`layout.as`](../data/script/src/manager/layout.as))
slides the advanced lab along the turret box's front edge and takes the
candidate nearest the home centre that passes `CanReserveBuilding` and
`IsExitClear`. The box itself is checked for flat ground (`FlatFraction`), the lab
strip ahead of it is not. And the native reservation checks never asked the
engine: `CanReserveBuilding` and `ReserveBuildingEx`
([`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp)) accept a
footprint on `CanBeBuiltAt`, a sector test (is the footprint's centre sector in
a usable movement area), plus the AI's own occupancy grid; the footprint's cells,
their slope and what stands on them are never looked at. The engine's test,
`IsPossibleToBuildAt`, ran only when a builder was sent to the slot. So any plan
could reserve ground the engine will never build on.

**Decision.**
- **The fix at the source:** both native reservation checks (`CanReserveBuilding`,
  `ReserveBuildingEx`) now also ask the engine (`IsEngineBuildable`, i.e.
  `IsPossibleToBuildAt`) once the cheaper checks pass, so no plan reserves ground
  the engine refuses: every reservation path is covered (the front lab, turret
  grids, the packers, D-114's front clusters). The engine's test fails only for
  lasting obstacles (slope, water, structures); units standing there and
  reclaimable features pass. Zone bands and tenant slots, laid over our own
  structures on purpose, skip it. A refusal logs "RESERVE: refused ... the engine
  refuses the ground (slope, water or a structure)".
- **Safety nets**, for ground that becomes unbuildable after it was reserved:
- New native query `CTerrainManager::IsSlotDead` (script `aiTerrainMgr.IsSlotDead`).
- [`layout.as`](../data/script/src/manager/layout.as) `T2LabTask`: a planned
  advanced lab footprint that is dead is given up (logged); the lab goes through
  the normal placement (the footprint most turret slots reach, else nearest a
  turret slot). The dead ground stays held, so it is not chosen again.
- [`tech_build.as`](../data/script/src/roles/tech_build.as): the throwaway T1 lab
  is retired, and reclaimed, only once the advanced lab has begun: a frame or a
  finished lab (`T2Begun`), not an order.

**Invariant.** INV-015 (a dear chain order with no frame for 45 s) caught this in
the owner's game. Build101 on All That Glitters and Supreme Isthmus (16 AIs,
14 min each): no reservation refused by the engine at plan or build time, no dead
slot, the same turret boxes and advanced lab sites as build100, no new slow
calls (the `PackNearGroup` ones predate it).

**Files.** [`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`TerrainManager.h`](../src/circuit/terrain/TerrainManager.h),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`layout.as`](../data/script/src/manager/layout.as),
[`tech_build.as`](../data/script/src/roles/tech_build.as).

## D-117 — Spam labs stand in rows of up to four, their two turrets bound to them, a T3 lane always open

**Date:** 2026-09-26. **Status:** Played (build103 and later, TECH-vs-TECH). Rows began, each with at least one lane. Rows never grew past one lab: a flush neighbour stands in the lab's blocker yard, fixed in [D-119](#d-119--gantries-get-up-to-50-turrets-tech-caps-t2-constructors-and-fast-assist-bots-at-10-spam-labs-are-never-assisted-one-spread-lane-per-spam-lab). That entry also fixes a lane lost after a failed growth (INV-047) and the turrets that were never bound to their lab (INV-048).

**Owner's rule.** For TECH's late-game T1 spam labs: the construction turrets that
belong to a spam cluster are forced to assist its factory; exactly two turrets
per spam lab; labs side by side in rows of up to four where the ground allows,
each with its own two turrets, often a single lab per cluster; they never cramp
the ground so far that T3 cannot get through: the largest T3 must be able to go
from the factories behind these labs to the front line.

**Found.** The turrets were bound only by the first turret row (`turret.spam`):
before the lab stood they took other work, and the reclaim pull
(`TurretsOnReclaim`, D-078) took every turret in reach, spam turrets included.
Each spam lab was placed alone by D-114's search, 2 cells from the next, with no
thought for passage.

**Decision.**
- **Bound turrets.** A T1 cluster's turrets are marked `no_disrupt`; native
  `TurretsOnReclaim` now skips `no_disrupt` units; before their lab exists they
  wait instead of taking other work; once it stands they guard it (repair it
  while it is a frame). Exactly two per lab (`FrontT1TurretCols/Rows` 2 x 1).
- **Rows.** A new T1 cluster first joins an existing spam row at either end
  (`ExtendRow`), side by side (`FrontRowGapCells` 0), up to `FrontRowMaxLabs` (4);
  else it starts a row through D-114's search.
- **T3 lanes.** Beside each end of a row a lane `FrontT3LaneCells` (6) wide, over
  the cluster's whole depth and the same beyond each end, is held as a corridor
  (nothing of ours is placed on it) when its ground is passable
  (`FrontLaneMinFlat` of it flat and free). The largest T3 movement classes
  (HBOT7, HTANK7: Korgoth, Juggernaut and the like) are 7 map squares, 3.5 cells,
  wide. A row needs at least one lane: a place with none is refused, and a row
  grows at an end only while a lane stays open at one end.

- **A crash in the owner's game (build101, F25307).** Construction turrets were
  dying several per frame; `CCircuitAI::DeleteTeamUnit` asks every task to forget
  a dead unit (`ForgetUnitEverywhere`, D-108), and `IBuilderTask::ForgetUnit`
  advanced its update iterator `unitIt` on a freed node (`BuilderTask.h:82`,
  symbolised with build101's `.dbg`). `IUnitTask::Stop` clears the task's
  `units`, but `IBuilderTask` kept `unitIt`, and a stopped task stays listed until
  the update loop drops it. [`BuilderTask.cpp`](../src/circuit/task/builder/BuilderTask.cpp)
  `Stop` now resets `unitIt` (and clears `engaged` and `approaching`); it is the
  only saved iterator into a task's unit set (build103).

**Invariant.** INV-047: every spam row holds a T3 lane, and no structure stands
on a held lane. INV-048: a standing spam lab's turret works for that lab.

**Files.** [`tech_factories.as`](../data/script/src/roles/tech_factories.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp).

## D-118 — The AI draws on the map: an intro, the credits, lettering from BAR's typeface

**Date:** 2026-09-26. **Status:** Played (build105). The owner watched the intro and
asked for the changes below; the `intro_test` widget counted every drawing
received by a spectator. Strokes missing on screen are terrain in front of the
line, not lost messages.

**Current default (2026-09-30).** At the owner's request, automatic match-start
artwork is disabled with `Commands::IntroEnabled = false` in
[`commands.as`](../data/script/src/manager/commands.as). The title, Armada
commander, warning, contributors, glyphs and manual draw commands are retained.
The existing disabled path still marks the intro complete for lane scheduling.
This supersedes automatic playback below; it does not remove the drawing system.

**Default-off verification.** Played all three experimental profiles in the
same isolated Supreme match, one minute, DLL `fcc2c7ea532f9ef3`, run
`build-theatres/intro-disabled/runs/20260930-204542`. All four AI instances
initialize; no intro drawing/credits commands, script errors or invariant lines
occur. The generic smoke report remains FAIL only on its opening-rule log
expectation despite three completed team-0 mexes (KI-440). Invariant practice,
diff checks and published script/DLL API parity pass. The existing eight missing
hover-document links remain KI-404. Matching DLL/symbols/current data are
published to the required build output; no live game folder is changed.

**Owner's requests.** Draw an Armada commander large in the map's centre, with
"Do not spec cheat!" beneath it. Keep it 10 s after it is drawn, then erase it.
Then a contributors list, also held 10 s, then erased. Spectators must see it.
The text must look stylised and hand-drawn in BAR's typography, not typed pings.
Draw a little slower, like a hand, and thicker. The list goes top-left in the
default view, "Contributors" underlined, no border, names without "@".

**Found.**
- An AI's map lines (`Drawer::AddLine`) are a player's map drawing: allies and
  spectators see them in the sender's colour.
- The game server drops a player's map-draw messages once more than 25 arrive
  under 50 ms apart (`GameServer.cpp`). In play, 80 lines in one frame showed 25.
- `EraseNear` erases only lines whose start lies within 100 elmos.

**Decision.**
- A native draw queue ([`CircuitAI.cpp`](../src/circuit/CircuitAI.cpp)):
  `AiQueueLine` / `AiQueuePoint` / `AiQueueErase`, sent in batches paced by
  real time (`AiDrawPace`: at most 20 a batch, at least 55 ms apart).
- Every start is kept, so the erase removes exactly these lines.
- Lettering comes from Exo 2 Bold, the game's UI typeface.
  [`tools/draw/make_glyphs.py`](../tools/draw/make_glyphs.py) flattens and
  simplifies the outlines into
  [`glyphs.as`](../data/script/src/manager/glyphs.as).
- Each stroke is drawn twice side by side (bold) with a small repeatable wobble.
- The intro runs once, from skirmish AI 0 only
  ([`commands.as`](../data/script/src/manager/commands.as) `IntroTick`):
  - the title "SMRTBARb", the commander and the warning at a hand's pace
    (844 strokes in 16 s), then 10 s;
  - an erase, then the credits at double that pace (16 a batch: 2634 strokes
    in 11 s, all received by a spectator), then 10 s;
  - an erase.

**Invariant.** None: drawing changes no game state. The `intro_test` widget
checks what arrives.

**Files.** [`CircuitAI.cpp`](../src/circuit/CircuitAI.cpp),
[`CircuitAI.h`](../src/circuit/CircuitAI.h),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`commands.as`](../data/script/src/manager/commands.as),
[`glyphs.as`](../data/script/src/manager/glyphs.as),
[`make_glyphs.py`](../tools/draw/make_glyphs.py), and the three
`experimental_*/main.as`.

## D-119 — Gantries get up to 50 turrets; TECH caps T2 constructors and fast assist bots at 10; spam labs are never assisted; one spread lane per spam lab

**Date:** 2026-09-26. **Status:** Played. The work ran on build105 and then
build106 (`FindProducedNear`), over many TECH-vs-TECH games of 40 to 45
minutes on Supreme Isthmus, All That Glitters and Glacial Gap. The new
`unit_census` widget counted live units by type every 5 minutes. The last two
games (build106, runs `20260926-215715` and `20260926-215641`) finished without
a crash.
- **Gantry.** Every gantry cluster reserved the full 10 x 5 block. The gantry
  was ordered once 10 of its 50 turrets stood; in one game it finished 38 s
  later. All 50 turret orders were issued.
- **Caps.** Live counts never passed 10 T2 construction bots or 10 fast assist
  bots. The advanced labs made fast assault bots instead, up to 93 alive.
  INV-010 (combat under the gate) did not fire once the advanced lab waited
  under the gate.
- **Spam labs.**
  - INV-049 never fired, so no constructor assisted a spam lab.
  - Rows grew to 2 and 3 labs, and INV-047 was silent.
  - Spam production went from 37 units alive at 40 min to 652 at 45 min
    (Supreme Isthmus) once the labs produced back to back.
  - Turrets are tasked for their own lab. INV-048 went from dozens a game to
    one.
- **Lanes.** 39 to 41 lane assignments a game, 900 elmos apart, centred on the
  moving front.

**Owner's requests.**
- The construction turret cluster for gantries holds up to 50 turrets, and they
  are filled.
- Late game the T2 labs make too many construction bots and fast assist bots
  instead of fast assault bots. Cap both at 10 for TECH.
- Factories assigned as spam never have constructors assisting. The first bot
  lab is not spam (it is often reclaimed); the late T1 labs are placed for spam.
- Each forward T1 spam lab correlates to a lane. Lanes have space between them,
  spread across the active battle front, and run straight to the enemy backline.
- There are still issues with the forward clusters that place labs.

**Found.**
- A gantry's block was 3 x 2.
- The advanced bot lab made T2 constructors up to `T2ConstructorCap` (60, bot
  and air together). Fast assist bots were capped by income (`5 x income/45`,
  50 at the start).
- Three acts put constructors on a spam lab:
  - `fwd.t1` guarded the nearest spam lab, and repaired "anything unfinished" at
    a cluster, which includes the units the lab is producing;
  - `DoTurretFactory` sent any turret to any producing factory in reach;
  - `guard.factory` and the chain's commander step guarded the primary T1 lab
    whatever it was.
- Every spam lab ran lane `n x LaneSpacing` sideways off its own line to the
  focus, so lanes fanned from each lab rather than spreading across the front.
- In play, forward clusters had three faults:
  - **Rows never grew.** The new reason log showed each attempt refused with
    none of our reservations on the spot. `IsSlotFree` refuses any cell a
    structure's blocker covers. An Armada T1 bot lab's blocker
    ([`block_map.json`](../data/config/experimental_hard/block_map.json)
    `fac_bot`) has a 6-cell yard, 3 cells each side of the footprint. A flush
    neighbour (`FrontRowGapCells` 0), or one 2 cells away, stood in it.
  - **A row lost its T3 lane** (INV-047). To try the next place a row lets its
    end lane go. When the place failed, the lane was held again only if the
    ground still passed the passability test, and wrecks or units on it since
    then failed it.
  - **A front cluster's turrets were never bound to their factory.** The rule
    `turret.spam` (D-109, D-114, D-117) never fired in any run on record.
    - Construction turrets are the native factory manager's assistants
      ([`FactoryManager.cpp`](../src/circuit/module/FactoryManager.cpp)
      `assistFinishedHandler`). Their tasks come from `Tech_FactoryAiMakeTask`,
      which fell through to native `CreateAssistTask`: help whatever is under
      construction in reach, else wait.
    - The builder rules only see a turret after a native builder task, such as
      the reclaim pull, has moved it to the builder side. D-117 made spam
      turrets `no_disrupt`, so they were never pulled and never reached the
      rules.
    - A builder task returned for a factory-side unit is refused by
      `ITaskModule::AssignTask` ("refused task of another manager"), and a
      turret has no BUILDER role, so `AssignWorkerGuard` refuses it too.
    - INV-048 was right to fire. It also misread guards: a native guard task
      keeps its target as an id (`CBGuardTask::vipId`), and
      `IBuilderTask.target` is null for it.
  - **Spam labs barely produced.** 6 labs had 37 spam units alive at 40 min,
    and the census found no T1 lab building at any sample.
    - D-111 put each spam lab on repeat and answered its later asks with 20 s
      waits.
    - Native clears a factory's whole build queue whenever a recruit task
      finishes (`CRecruitTask::Finish` then `Cancel`). So the repeat queue
      lasted one unit, and the lab idled until `RepeatStallSeconds` (45)
      ordered the next.

**Decision.**
- **Gantry block.** `FrontT3TurretCols/Rows` is 10 x 5.
  - `Plan` searches with room for the smallest block, then reserves the biggest
    that fits: 10x5, 8x5, 8x4, 6x4, 6x3, 3x2 (`T3Blocks`).
  - The gantry is ordered once `FrontT3TurretsFirst` (10) of its turrets stand.
    A builder that can build it takes that order first.
  - The turret orders go on until every slot is filled. The standing turrets
    build the gantry meanwhile, at 200 build power each.
- **Caps.**
  - `T2BotConstructorCap` 10 caps the T2 construction bots: the D-103 branch
    counts only bot constructors for a bot lab, and the unit cap is clamped each
    economy update. T2 air constructors keep `T2ConstructorCap`, because the
    dedicated roles need them.
  - `FastAssistBotCap` 10 clamps the income-scaled cap, and
    `StartCapFastAssistBots` is now 10.
  - With both capped, the advanced bot lab falls through to the fast assault
    rush. Under the combat gate it now waits; before, it fell to native
    `DefaultMakeTask`, which chose combat (played: Pyros at +91, INV-010).
- **Spam labs never assisted.**
  - `TechFactories::IsSpamLab` names a lab as spam when it belongs to a T1
    front cluster.
  - `fwd.t1` no longer guards spam labs, and repairs only non-mobile unfinished
    things at a spam cluster.
  - `DoTurretFactory`, `GuardFactory` and `CommanderOnFirstConstructor` skip
    spam labs.
  - Every guard of a lab passes through `GuardHelpers::AssignWorkerGuard`, so
    the check sits there: a guard of a spam lab by anything but its own two
    turrets is refused and logged (INV-049).
- **Spread lanes** ([`spam.as`](../data/script/src/manager/spam.as)
  `SetSpreadLanes`, `BuildSpreadRoute`).
  - The axis runs from our start to the focus, the enemy start the runs end
    behind.
  - Each spam lab gets its own lane parallel to the axis, `LaneSpacing` (900)
    apart. The set is centred on the combat front and shifted to stay on the
    map.
  - Labs are sorted by their own sideways place, so routes never cross.
  - Route: the lab, half way to its lane's front point, the front point, then
    straight on to `BehindEnemyDistance` past the focus.
  - `TickSpam` re-spreads when the count of spam labs changes, and every 30 s.
    Every route refresh reuses the lane.
- **Rows.**
  - `FrontRowGapCells` is now 3 (48 elmos): side by side, clear of the
    neighbour's blocker yard.
  - A released end lane is put back without the passability test.
  - A row that cannot grow says why, once a minute.
- **Turrets bound to their factory.** `Tech_FactoryAiMakeTask` sends a
  cluster's own turrets to `TurretFocus(u, true)`, which returns factory-side
  tasks (`TaskS`):
  - repair the factory while it is a frame;
  - else repair the unit it is producing (a mobile frame within
    `LabYardRadius`, 96). This uses the new native `FindProducedNear`
    (build106), because `FindUnfinishedNear` sees only structures raised by
    builder tasks;
  - else wait 2 s.

  A spam lab's turrets wait (5 s) for a lab that is not up yet. A turret on the
  builder side still gets `turret.spam`'s builder tasks: a non-interruptible
  guard, enqueued directly.
- **Spam labs produce back to back.** Repeat is off, and every ask gets the
  next unit (`Spam::FactoryMakeTask`).
- **INV-048 reads the focus.** `TurretFocus` records the lab each turret last
  worked for (`focusOf`) and when (`focusFrame`). A turret works for its lab
  when its last task was for that lab within `FocusFreshSeconds` (30). A
  factory-side turret's tasks last seconds (a unit in production, a 2 s wait),
  so a single sample often finds it idle between two of them.

**Not changed.** On Glacial Gap in a 1v1, TECH's income peaks at +165 with every
mex upgraded. The rush chain waits for +200 for the rest of the game, which is
the owner's S5 gate; combat and spam stay locked and the bank sits full. This
predates D-119 and is left for the owner.

**Invariant.** INV-049: a spam lab is assisted only by its own two turrets
(checked at the one door every guard passes). INV-028 now counts only T2
construction bots, up to `T2BotConstructorCap`.

**Files.** [`tech_factories.as`](../data/script/src/roles/tech_factories.as),
[`tech_forward.as`](../data/script/src/roles/tech_forward.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`tech_build.as`](../data/script/src/roles/tech_build.as),
[`tech_chain.as`](../data/script/src/roles/tech_chain.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`spam.as`](../data/script/src/manager/spam.as),
[`guard_helpers.as`](../data/script/src/helpers/guard_helpers.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`unit_census.lua`](../tools/playtest/widgets/unit_census.lua),
[`BuilderManager.cpp`](../src/circuit/module/BuilderManager.cpp),
[`BuilderScript.cpp`](../src/circuit/script/BuilderScript.cpp).

## D-120 — When the planned layout does not fit, TECH still builds; cramped maps get a measured layout choice

**Date:** 2026-09-27. **Status:** Played (build106, Tundra Continents, 16 AIs,
TECH on the north island). The two fixes are in. The layout choice and the
harbour layout are a proposal, written in
[`roles/tech-cramped-maps.md`](roles/tech-cramped-maps.md).

**Owner's request.** TECH works well on flat maps; find a strategy for cramped
maps such as Tundra Continents. Measure the build area to pick a layout, invent
one if needed, and move to sea or air where the map calls for it.

**Found.**
- On Tundra, TECH had 4 units and +8 metal at 30 minutes.
- The factory pair did not fit the island (`Layout::Plan`), so the fallback
  switched the reservation registry off ("TECH retains normal placement").
  Every TECH placement goes through that registry, so every site was refused.
- With the registry kept on, the start lab still failed: it was ordered on a
  pinned slot, and with no pair the slot is -1.

**Decision.**
- The fallback keeps the registry on and skips only the planned pair and turret
  box ([`layout.as`](../data/script/src/manager/layout.as)).
- The first lab uses the commander ring search in the fallback too, with any
  facing, up to `CrampedFirstLabRadius` (800)
  ([`tech_build.as`](../data/script/src/roles/tech_build.as)).
- Played after both fixes: a lab, constructors, 33 turbines and +460 energy at
  22 minutes, but +13 metal. The island has 3 mexes, and converters, the
  advanced lab and turrets are still placed relative to the pair and box.

**Proposed.** Measure the ground at the start: the largest connected lab patch,
and floatable water against lab ground. Then pick an open, compact or
**harbour** layout. The harbour layout keeps labs and advanced fusions on land
and puts a quay of floating turrets with tidals, floating converters and naval
fusions on the water. An island TECH fights by air (or by sea when no allied SEA
role exists).

**Invariant.** INV-050: a factory stands by `FirstFactorySeconds` (300). The
stall also showed as INV-015 (a dear chain order with no frame).

**Tools.** [`build_area.lua`](../tools/playtest/widgets/build_area.lua) and
[`build_area.py`](../tools/playtest/build_area.py) survey and measure a map's
buildable ground.

**Files.** [`layout.as`](../data/script/src/manager/layout.as),
[`tech_build.as`](../data/script/src/roles/tech_build.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as).

## D-121 — An island TECH builds its land phase on cramped ground, then moves its economy and production to the water

**Date:** 2026-09-27. **Status:** Played (build108 plus scripts), partly.
- **Tundra 1v1 (TECH on both islands, 45 min).**
  - Advanced lab at 3 to 7 min.
  - Harbour at 15 min, then the hover plant and the advanced shipyard.
  - The north island ends with 21 floating advanced converters, floating
    turrets, tidals and a fleet of 66 ships (79k metal).
  - Metal at 44 min: north +278 (was +8 before D-120, +13 after it), south
    +400.
  - No crash; INV-050 and INV-051 silent.
- **Open 1: the fleets dealt no damage.** In a 1v1 their route leads to the
  nearest empty start spot: Spam's focus takes every non-allied spot for an
  enemy.
- **Open 2: in a full 16-AI game the island TECH died at about 26 minutes,**
  shelled by enemy fleets before its advanced shipyard stood. It has no sea
  defence during the land phase.
- **Land maps unaffected.** Supreme Isthmus had no harbour or cramped line;
  its advanced lab came at 6.4 min and +500 metal at 30 min, against 34.3 min
  before.

**Owner's request.**
- Build the harbour layout for Tundra: start with a bot lab, tech up to the T2
  lab, upgrade mexes, then get a fusion down.
- Once two advanced fusions stand, transition to the harbour. Land units can go
  on building, since they will be isolated, but the priority becomes expanding
  the sea economy and pumping out sea units.
- T2 sea units are high priority after the second advanced fusion.
- Land maps must be unaffected.

**Found while building it** (each played on Tundra, 16 AIs):
- **Cramped-ground placement, D-120's fallback with no planned pair.**
  - Economy structures packed within 8 cells of the bare start found no site
    (T1 converters, 1608 times).
  - The advanced lab went "on the pair's slot" (-1).
  - Turrets were never ordered: `NanoTask` and `CanPlaceTurret` required the
    planned layout.
  - Native's packed search gave up after the 400 nearest free cells, all
    slopes on that island.
- **Reach.** A ridge splits the north island. Lab sites across it were "out of
  the builder's reach". Once reach was tested, the site near the first lab had
  often been taken by wind turbines, and a site across the island was refused
  where raiders stood (native serves a pinned slot only away from threat).
- **Metal.** The island has 3 mexes. With the flat ground full, T1 converters
  found no site, and metal stayed at +13 under the advanced lab's +18 gate.
- **Land constructors cannot build the sea economy.** Tidals, floating
  converters, naval fusions, floating turrets and the advanced shipyard need
  construction ships, subs or hover constructors.
- **The T1 shipyard needs water 30 deep,** further out than a land
  constructor's reach ("no site for corsy at all ... reach=0"). Native's search
  for the advanced shipyard also started from the island's middle.
- **A crash, found in play.** A ring point off the map's edge made the native
  reach test index a sector out of range. The D-117 crash reporter named it
  ("SCRIPT CRASH ... Layout::CrampedLabSite").

**Decision.**
- **Cramped ground** (`Layout::fallback`, only when the planned pair does not
  fit):
  - structures are packed within `CrampedPlaceRadius` (640) of the nearest
    lab;
  - turrets go near the labs, as many as the income pays for
    (`CrampedNanoTask`);
  - the advanced lab's footprint is held beside the first lab when that lab is
    placed (`ReserveCrampedLabSlot`: cramped ground's version of the pair),
    else found by a ring search that skips unreachable and off-map points;
  - INV-017 (flush) does not apply there.
- **Native (build107, build108).**
  - `PackNearPoint` tries 2000 candidates, not 400.
  - The script can ask `CanReachAt(builder, pos, range)` (movement areas, no
    threat).
- **The harbour** ([`tech_harbour.as`](../data/script/src/roles/tech_harbour.as),
  [`tech_harbour.md`](roles/tech_harbour.md)), only on a start the map file
  flags land-locked:
  - Before the harbour, the commander puts floating converters on the water
    while energy floats.
  - It begins at the second advanced fusion (owner), or 15 minutes in once an
    advanced lab has stood. On Tundra's north island the second advanced fusion
    never fits within reach, and raids begin around 17 minutes.
  - A land constructor builds a **hover plant** on the island. Its hover
    constructors float out and build the advanced shipyard first, on a site the
    script picks, then floating turrets, tidals and floating converters.
  - Construction subs alternate naval fusions and floating advanced
    converters.
  - The advanced yard pumps cruisers, missile ships and AA ships whatever the
    income (INV-010 exempts them).
  - Land labs make constructors only.
  - Sea builders keep a construction they hold (`TechBuild::KeepCurrent`).
    Played: a hover constructor left the ordered yard for a tidal on every
    re-ask, and neither island's yard was built.
  - Construction subs add floating advanced converters while energy is over
    60% of storage, else a naval fusion.
  - The harbour's unit caps are re-opened after TECH re-applies its limits.
  - Harbour sea units run the advanced yard's route (Spam's route task).
- **Land maps.** `Global::Map::LandLocked` is false there, so no harbour code
  runs, and the cramped paths run only when the planned pair does not fit.
  Played on Supreme Isthmus: no harbour or cramped line in the log.

**Invariant.** INV-051: the advanced shipyard stands or is framed 480 s after
the harbour begins.

**Tools.** [`team_stats.lua`](../tools/playtest/widgets/team_stats.lua) and
[`unit_census.lua`](../tools/playtest/widgets/unit_census.lua) measured each
run.

**Files.** [`tech_harbour.as`](../data/script/src/roles/tech_harbour.as),
[`layout.as`](../data/script/src/manager/layout.as),
[`tech_build.as`](../data/script/src/roles/tech_build.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as),
[`TerrainManager.cpp`](../src/circuit/terrain/TerrainManager.cpp),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp).

## D-122 — A ferried constructor is given as soon as the transport has set it down

**Date:** 2026-09-27. **Status:** Played (build109). Two 16-AI games, Supreme
Isthmus and All That Glitters, 35 min: 18 deliveries. Each unloaded in 2.0 to
6.5 s, with no unload retry and no failed run, and the gift followed within
half a second. Before, in the owner's game, one delivery took over 90 s.

**Owner's report.** When TECH delivers a T2 constructor it does not transfer
the unit right away, and the light transport idles. It transfers eventually,
but that is time the constructor could spend upgrading mexes.

**Found (the owner's infolog, build106).**
- The run entered UNLOADING, and 7 s later the cargo was out: "cargo aboard=0",
  the transport's command queue empty.
- The run still waited 45 s, retried the unload twice and waited again.
- `CFerryTask` counted a delivery only when the cargo stood within 1 elmo of
  the terrain height, or was "not lifted" (under 4 elmos above it) and not
  aboard. The cargo stood higher than that: a pad or a ramp. Only after the
  retries did the run end and the script give the unit.

**Decision.** [`FerryTask.cpp`](../src/circuit/task/fighter/FerryTask.cpp)
also counts the cargo as landed when the engine has finished the unload (the
transport's command queue is empty) and the cargo is not aboard. `IsAboard`
means risen above where the cargo stood and under the transport (D-110, D-112).
The empty queue keeps a cargo still attached during the descent from being
counted, so a unit is never given while it hangs under our transport (D-056).
The transport heads home at once, and the script gives the unit on its next
poll.

**Invariant.** INV-052: a run unloads within `FerryUnloadSeconds` (15)
([`ferry.as`](../data/script/src/manager/ferry.as)).

**Files.** [`FerryTask.cpp`](../src/circuit/task/fighter/FerryTask.cpp),
[`ferry.as`](../data/script/src/manager/ferry.as),
[`global.as`](../data/script/src/global.as).

## D-123 — An air constructor with nothing to build builds defences

**Date:** 2026-09-27. **Status:** Built (build110), played. The fallback fires, but INV-053 still reports air constructors left in the engine's idle state after a finished task (142 spells in a Supreme Isthmus game): an open item, the idle re-ask.

**Owner's report and rule.** Scaling worked well, but once 225 advanced energy
converters were built every air constructor stopped moving. Was the layout
grid exhausted, with no safe places left? Identify the cause. If air
constructors ever get stuck or have nothing to do, never let them do nothing:
always fall back, at the lowest priority, to building defences.

**Found (the owner's infolog, Supreme Isthmus, 35 min, TECH Legion, AI 7).**
- Yes: the layout was full. From about minute 29 the log says "no room within
  reach of any turret cluster for legadveconv" and "for legafus" (INV-020, 94
  s and more), and "advanced fusion set held ahead: no room".
- The two dedicated builders "wait for legafus: no site in the layout". D-108
  lets them do nothing else.
- The other T2 air constructors went to "assist anything under construction".
  With the layout full, nothing was under construction, and they stood still.
- The rule table is asked for these units about 40 times a minute until
  minute 29, and almost never after.

**Decision.** `TechBuild::AirDefence`
([`tech_build.as`](../data/script/src/roles/tech_build.as)):
- first, long-range AA and flak at the mex clusters (D-109's `DefendMexes`);
- else a ring of defences round the base centre, fanned about the direction of
  the front, `AirDefenceRadius` (900) out and `AirDefenceRingStep` further
  every `AirDefenceRingSize` places;
- T2 anti-ground turrets and flak in turn (a T1 air constructor: light lasers
  and heavy AA), at most `AirDefenceMax` (60) of each of six kinds (T2 turrets, flak, long-range AA, T2 artillery; light lasers and heavy AA for T1 air constructors).

TECH's start caps hold land defences at 0; each one is lifted as it is ordered.
It runs from:
- the new lowest row `air.defend`, just above `wait`, for any air
  constructor;
- `AirDedicated`, when the layout has no site for the dedicated structure. The
  role is kept and resumed as soon as a site frees; this amends D-108;
- the rule evaluator, in place of any wait a row hands an air constructor.
  Played: the rush chain's "order out" left one idle for 60 s;
- the rule evaluator, after `AirIdleAsks` (2) asks in a row while the air
  constructor is idle. Played: `chain.next` and `power.turret` kept handing
  one a job it never took up.

**Invariant.** INV-053: no T2 air constructor waits or idles at three samples
in a row, 30 s apart
([`invariants.as`](../data/script/src/manager/invariants.as)).

**Files.** [`tech_build.as`](../data/script/src/roles/tech_build.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`invariants.as`](../data/script/src/manager/invariants.as),
[`global.as`](../data/script/src/global.as).

## D-124 — A nuke launch draws a smiley face over its target; the credits show in 5% of games

**Date:** 2026-09-27. **Status:** Built (build111), played. With full map vision from minute 20 (so the silo has a target), a Legion TECH on Supreme Isthmus launched 6 nukes; all 6 were caught by the weapon-fired event and each drew its face (50 lines, screenshots by [`smiley_watch.lua`](../tools/playtest/widgets/smiley_watch.lua)). Without full vision, TECH 1v1 silos often fire nothing: "SUPER legsilo: no target | groups=1 inRange=0", no enemy seen.

**Owner's report (build110).** No smiley was seen. The owner's game ran
`SMRTBARb\stable\` (build106, `32f6f0ca`, and its older scripts). Build110
and the current scripts had been copied to `SMRTBARb\` itself, which the engine
does not load: an AI runs from `AI/Skirmish/<name>/<version>/`. The hook was
still moved from the stockpile watch to the exact event.

**Owner's request.** Whenever a nuclear missile is launched, the AI draws a
smiley face on the map over the target. The intro's second screen, the
contributors, shows only 5% of the time.

**Decision.**
- **Smiley.** The hook is the engine's weapon-fired event
  ([`CircuitAI.cpp`](../src/circuit/CircuitAI.cpp), build111). The engine
  raises it for every shot fired on an attack command, and a nuke silo
  (`armsilo`, `corsilo`, `legsilo`) fires only on one. The silo's
  `CSuperTask` then draws over its aim.
  [`SuperTask.cpp`](../src/circuit/task/static/SuperTask.cpp) keeps build110's
  stockpile watch as a safety net: a drop in the silo's stockpile draws only
  if the event has not drawn in the last 5 s, and one launch draws one face. `CCircuitAI::DrawSmiley` then puts a face over the target, `SMILEY_RADIUS`
  (400 elmos): its outline, two eyes and a smile, about 50 map lines through
  the paced draw queue of D-118. The target is the attacked unit's position, or
  the aimed ground. Logged as "NUKE: launched ...". The face stays on the map.
- **Credits.** [`commands.as`](../data/script/src/manager/commands.as) rolls
  once a game after the first drawing is erased: under `IntroCreditsPercent`
  (5) the credits follow, else the intro ends. The roll is logged either way.

**Invariant.** None: drawing changes no game state (as D-118).

**Files.** [`SuperTask.cpp`](../src/circuit/task/static/SuperTask.cpp),
[`SuperTask.h`](../src/circuit/task/static/SuperTask.h),
[`CircuitAI.cpp`](../src/circuit/CircuitAI.cpp),
[`CircuitAI.h`](../src/circuit/CircuitAI.h),
[`commands.as`](../data/script/src/manager/commands.as).

## D-125 — TECH weapon clusters: designed, for the owner's review

**Date:** 2026-09-27. **Status:** built as [D-126](#d-126--tech-weapon-clusters-built-found-at-strategic-defence-points-gated-by-income-configured-in-json).

**Owner's request.** A new cluster type, weapon clusters, like the economy and
factory clusters, for TECH only.
- A more advanced selection, from battlefield tactics: where flak and
  long-range AA help, where long-range artillery and LRPCs go, counting the
  range altitude adds.
- A super-cannon cluster (Calamity, Starfall) that follows the enemy's
  composition and behaviour, 20% to 40% behind the front, safe, preferring
  altitude.
- Front clusters keep friendly movement open, and obstruct, endanger and funnel
  the enemy's: spam turrets and high-DPS long-range weapons, and walls round
  whatever fires over them.
- At least 4 construction turrets per cluster.
- No strategically important defensive capability depends on one structure,
  position, weapon class, radar or line.

**Found (research).**
- Height: an LRPC gains 2.5 to 4 elmos of range per elmo of height (BAR sets
  `heightboostfactor` 6 to 8 on them), an ordinary cannon 0.4 to 0.8, a super
  cannon little; beam turrets lose range on hills. Formulas and tables:
  rjm.bar.docs `60-tactics/66-defensive-placement.md`.
- LRPCs, super cannons, flak, long-range AA, silos and anti-nukes fire through
  friendly units; smart artillery lobs over blocks. All can be walled in
  fully. Direct-fire turrets cannot.
- The native AI has threat and influence maps, enemy groups with role costs,
  a path finder and bwem chokepoints, none of them bound to the script; its
  own wall and choke code is commented out.

**Decision.** The design in
[`tech-weapon-clusters.md`](roles/tech-weapon-clusters.md):
- a native battlefield-analysis layer: avenues of approach from path
  density, chokes, friendly lanes, effective range with height, line of
  fire, composition and decaying heatmaps;
- five cluster kinds: kill zone, air defence, artillery, long-range, super
  cannon;
- a need score per kind from composition and behaviour;
- site scoring per kind; walls and funnels; seven redundancy rules as
  invariants;
- coasts and beaches (owner's follow-up): a depth grid, water bodies,
  beach segments and landing routes; beach classes (cliff, wading shelf,
  ship water, deep water, hover beach); a hard torpedo rule (15 deep, in a
  hostile submarine body, no sandbar in the line of fire; the engine
  allows 12, a submarine needs 15); layers from the sea to the beach's
  emergence band;
- the super-cannon cluster (owner's rules): 20% to 40% of its range back
  from an active combat zone; every air constructor on it the moment it is
  framed; metal income +500 to start, ideally +1000; its escort of two
  advanced energy storages, dense forward flak, long-range AA, two plasma
  deflectors and anti-nuke, with a full wall ring. Found: the engine fires a
  salvo only with its whole cost in storage, and a Starfall salvo is
  360,000 energy, so a Starfall needs about 7 storages, not 2. Owner:
  meet its energy requirement, whatever it is; the percentage is of the
  cannon's range. Storage is sized from the weapon's shot cost;
- seven phases, each its own decision.

**Invariant.** None yet: nothing is built. The design proposes seven
(section 6), each shipped with its phase.

Awaiting the owner's answers on the 20% to 40% reading, the weapon budget, and
where to start.

## D-126 — TECH weapon clusters: built, found at strategic defence points, gated by income, configured in JSON

**Date:** 2026-09-28. **Status:** Built (build112 to build114; md5 of build114 `d25051e1`), played in five TECH vs TECH games on Supreme Isthmus, fast-forwarded (up to 60 minutes). Clusters are found from about minute 20 (+200 metal). In the last run: 155 and 206 weapon orders, and the flat-ground range check matched every gun's listed range within 2 elmos. None of INV-054 or INV-057 to INV-061 fired once the super cluster kept its point. Open: no super cannon was framed in the runs after that fix (+500 metal and 25,000 E/s spare came late or not at all), so INV-057 and INV-058 still wait for a played frame; kill zones fill slowly (11 of 47 slots at 40 minutes) and some slots at the base find no site.

**Owner's request.** Make the economic settings configurable in JSON and in the
TECH role. Weapon cluster types are income gated, prioritised by strategic
defence points, and discovered and re-prioritised as the game progresses.
Build all the weapon types and the criteria for their locations, terrain
analysis included. No weapon cluster before +200 metal. The system runs under
the experimental settings, for TECH only, and may later serve other roles.

**Decision.** Built as designed in D-125
([`tech-weapon-clusters.md`](roles/tech-weapon-clusters.md)); what is built is
in [`tech_weapons.md`](roles/tech_weapons.md).
- **Native analysis** (`aiBattle`,
  [`BattleAnalysis.cpp`](../src/circuit/terrain/BattleAnalysis.cpp)). Queries
  only:
  - effective range with height (the engine's formulas, the unit's
    longest-range weapon);
  - approach routes and chokes on the engine's own passability;
  - decaying combat and air heat, and enemy composition by movement class;
  - water bodies, hostile water, beach classes, and the torpedo rule.
- **Script** ([`tech_weapons.as`](../data/script/src/roles/tech_weapons.as)):
  - six kinds (kill zone, air defence, artillery, long range, super cannon,
    coast), found again and re-ranked every 60 s by need x site score;
  - slots shaped per kind: first weapon, 4 construction turrets, the rest,
    walls last;
  - a budget of 25% of income (40% under attack);
  - the owner's super-cannon rules.
- **Settings.** In `Global::RoleSettings::Tech`, overridden by
  [`data/config/weapons.json`](../data/config/weapons.json) (a new config part
  in every profile). The script reads the JSON through
  `aiSetupMgr.ConfigFloat/Int/Bool`, and the config's `weapons` and `lanes`
  sections are kept past the engine's config close.
- **Gate.** `WeaponClustersEnabled` and `ExperimentalBuild`, from +200 metal;
  rows `weapons.super` and `weapons.cluster` in TECH's table only.

**Found in play (Supreme Isthmus, TECH vs TECH, build112 to build114).**
- `out` is reserved in AngelScript, and the script has no `max`/`min`; a Windows
  macro named `near` broke two C++ names.
- The JSON was freed before the script read it (a crash in `LoadSettings`).
- A raid on the base made the base the combat zone, and the LRPC site went
  behind it to the map edge. Fighting within `WeaponBaseRadius` is now base
  defence.
- The Starfall's recorded weapon is a short auxiliary mount: its reach read 1
  to 4. The analysis uses the longest-range weapon.
- A framed Ragnarok's cluster went stale when the combat zone moved, and its
  air builders left (INV-057, 238 times). A cluster with anything framed or
  standing now keeps its point.

**Invariants.** INV-054, INV-057, INV-058, INV-059, INV-060, INV-061.

**Files.** [`BattleAnalysis.cpp`](../src/circuit/terrain/BattleAnalysis.cpp),
[`BattleAnalysis.h`](../src/circuit/terrain/BattleAnalysis.h),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`CircuitAI.cpp`](../src/circuit/CircuitAI.cpp),
[`SetupManager.cpp`](../src/circuit/setup/SetupManager.cpp),
[`ThreatMap.cpp`](../src/circuit/map/ThreatMap.cpp),
[`tech_weapons.as`](../data/script/src/roles/tech_weapons.as),
[`tech_rules.as`](../data/script/src/roles/tech_rules.as),
[`tech.as`](../data/script/src/roles/tech.as),
[`global.as`](../data/script/src/global.as),
[`weapons.json`](../data/config/weapons.json), the profiles' `init.as`.

## D-127 — Lanes between both teams' starts, per movement class, drawn after the intro, recalculated as the front moves

**Date:** 2026-09-28. **Status:** Built (build113, build114), played. Five lanes a side on Supreme Isthmus (2 land, 2 naval, 1 air), drawn after the intro, shown 30 s, erased; recalculated on the front moving. Open: the front flips between the combat heat and the fallback front as heat comes and goes, so lanes recalculate every minute (throttled by `LaneRecalcMinSeconds`); TECH's attack code does not follow lanes yet.

**Owner's request.**
- Lanes are calculated first, at game start, from both teams' start positions.
- They are drawn with symbols that tell naval, air (edging round AA),
  all-terrain (often edge lanes) and land lanes apart, for 30 s after the
  first intro drawing.
- They are cached and recalculated as the front shifts, and TECH plans attacks
  on them.
- They run under the experimental settings, for TECH, maybe other roles later.
- Research the meta for how lanes are identified.
- Separately: speed games up with the set-speed command, slowing down near what
  a test watches.

**Decision.** [`tech-lanes.md`](roles/tech-lanes.md).
- **Classes.** Land, bot, amphibious, hover, all-terrain, naval, air, least
  capable first. Passability is the engine's slope map against each BAR
  movedef class's `maxslope` and depth
  ([`BattleLanes.cpp`](../src/circuit/terrain/BattleLanes.cpp)).
- **Paths.** Diverse paths by penalty, merged within a domain, so an
  all-terrain lane is one only spiders take.
- **Ends.**
  - The start script's playing teams: an AI or a non-spectator player on the
    team; the spectating host's team at (64, 64) was a false start, and is what
    an earlier nuke hit.
  - Else the enemy's start boxes, else every spot not ours.
  - Naval ends: every sea near a start.
- **Drawing.**
  - A symbol per class (tank, walker, chevron over a wave, hovercraft, spider,
    anchor, plane) and each lane's name in BAR's typeface. The glyph table
    gained the letters and digits.
  - Skirmish AI 0 marks the intro's end for every AI (one library).
  - Each TECH draws 2 s after the one before, at the intro's pace: two AIs
    drawing at once lost half their strokes to the server's rate.
  - Shown 30 s, then erased.
- **Recalculation.** When the front moves 1000, or every 180 s, weighing enemy
  threat (air lanes: enemy AA).
- **Attack plan.** `Lanes::BestLane` and `Waypoints`, logged each
  calculation. TECH's attack code adopting them is the next step.
- **Settings.** [`lanes.json`](../data/config/lanes.json) and
  `Global::RoleSettings::Tech` "LANES".
- **Playtests.**
  - `--speed-plan "minute:speed,..."` and `--slow-near-shots`
    (`playtest_camera.lua`).
  - The engine keeps max speed at or above min, so a slow-down sets min first.

**Invariant.** None: lanes order nothing and change no game state.

**Files.** [`BattleLanes.cpp`](../src/circuit/terrain/BattleLanes.cpp),
[`BattleAnalysis.h`](../src/circuit/terrain/BattleAnalysis.h),
[`SetupManager.cpp`](../src/circuit/setup/SetupManager.cpp),
[`SetupData.h`](../src/circuit/setup/SetupData.h),
[`InitScript.cpp`](../src/circuit/script/InitScript.cpp),
[`lanes.as`](../data/script/src/manager/lanes.as),
[`commands.as`](../data/script/src/manager/commands.as),
[`glyphs.as`](../data/script/src/manager/glyphs.as),
[`make_glyphs.py`](../tools/draw/make_glyphs.py),
[`lanes.json`](../data/config/lanes.json),
[`playtest.py`](../tools/playtest/playtest.py),
[`playtest_camera.lua`](../tools/playtest/widgets/playtest_camera.lua).

## D-128 — Water theatres and a read-only lane overlay

**Date:** 2026-09-28. **Status:** Played; final Supreme Isthmus overlay check passed. Separate-widget and automatic-display decisions superseded by D-129 below.

**Request.** Identify Supreme Isthmus's two isolated ponds and two seas
programmatically, improve lane symbols, and mark useful shipyard, tidal and
seaplane opportunities without changing placement.

**Decision.** Reuse `CBattleAnalysis::WaterBody` (conservative 64-elmo,
8-deep connected cells, sourced from the terrain manager), then classify size
and shore affiliation in AngelScript. Affiliation uses proximity to both sides'
actual starts, with a neutral margin; it is an estimate, not military control.
Only a large body reaching both sides can receive a shipyard candidate. Friendly
isolated ponds can receive tidal/seaplane candidates. All markers pass the
existing terrain manager's single-site `BuildableFraction` query. The
shipyard additionally needs a same-body exit corridor. Settings stay in JSON.

**Visuals.** A companion LuaUI widget consumes a versioned, acknowledged local
message stream. It draws coloured, outlined lanes and screen-size symbols,
including naval lines above water. One AI perspective avoids duplicate labels.
It chains the prior UI message callback, preserves the 30-second initial view,
and provides `/barbtheatres` for the cached survey. Without the widget, the
existing map strokes remain. No live-install files are written.

**Alternatives rejected.** Map-specific pond coordinates; classifying navy by
water area alone; rewriting native placement or movement-area heuristics; and
forcing colour/above-water graphics through the engine's monochrome map-draw
messages. None is necessary for this advisory visualisation. Native flood fill,
lane paths, factory selection, reservations and task queues remain unchanged.

**Invariant.** The theatre survey is read-only: no Enqueue, Reserve, Release,
unit-cap or placement-setting calls. The map-specific integration check forbids
a pond shipyard and script/invariant errors. No gameplay invariant is added
because this visualisation changes no gameplay state.

**Verification.** API parity: 210 used members, zero findings against pinned
build114 (`c6057cbd60efaf8d`). Initial live survey found two ponds and two seas
for both TECH sides, two feasible shipyard candidates each, and tidal/seaplane
opportunities only in each side's own pond (map tidal 21 E/s). Final isolated
run `C:/bardev/barb-playtest-theatres-codex/runs/20260928-134645/report.md`
passed at 4.1 game minutes: five lanes, two ponds/two seas, no pond shipyards,
friendly pond opportunities, team-link callback coexistence, automatic expiry,
cached toggle and refresh without reopening. No script or invariant errors.
Overview and pond-detail screenshots were visually inspected. Invariant practice
check passes; doc links retain eight existing missing-hover-document references
(KI-404). An earlier run raised a frameless Legion lab order (INV-015), recorded
as KI-420; it did not recur in the final run and no gameplay fix was attempted.
Resolution, start-distance affiliation and bounded candidate search limits are
detailed in the role document.

**Files.** [water_theatres.as](../data/script/src/manager/water_theatres.as),
[lanes.as](../data/script/src/manager/lanes.as),
[lanes.json](../data/config/lanes.json),
[gui_barb_team_link.lua](../tools/widgets/gui_barb_team_link.lua),
[theatres_supreme.json](../tools/playtest/checks/shared/terrain/theatres_supreme.json),
[theatres_watch.lua](../tools/playtest/widgets/theatres_watch.lua),
[tech-lanes.md](roles/tech-lanes.md),
[script README](../data/script/README.md), [AGENTS.md](../AGENTS.md),
[known issues](known-issues.md).

## D-129 — Strategic surveys in the BARb control panel

**Date:** 2026-09-28. **Status:** Built and Played; integrated-panel and four-player origin checks passed.

**Request and decision.** Replace D-128's separate widget with one integrated
renderer inside the existing BARb control widget. The panel offers selected
player, all permitted local AIs, and immediate hide. A single-player view follows
row selection. Default visibility is off, manual visibility persists, and
recalculation cannot reopen a hidden view. Remove the old automatic lane strokes
and the standalone theatre widget. The existing versioned channel is dispatched
by the control widget, including returning acknowledgements through its LuaUI hook.

**Invariant.** The renderer never computes strategic locations or changes construction; hidden surveys remain hidden when refreshed. The panel and multiplayer fixtures enforce this UI contract alongside the existing gameplay invariant checks.

**AI ownership.** Reuse the native energy manager's filtered geothermal feature
list through two read-only bindings. AngelScript scores enemy-facing terrain
visibility using the actual Cerberus range, and proximity to land lanes; a
conservative threshold distinguishes battery opportunities from power preferences.
The line-of-fire test is straight terrain screening, not ballistic proof. This
is a site assessment even when the inspecting faction cannot build Cerberus.
Terrain flood fill identifies isolated land components, and joined shoreline
edges screened for grade produce continuous defend/assault beach fronts. All
coordinates, classifications and scores originate in CircuitAI/AngelScript.
Lua only projects and draws, with compact geo/island diamonds, hover detail,
stretched beach ribbons and player colours/offsets in all-player view.

**Alternatives rejected.** Widget-side feature scanning or strategic heuristics;
map-specific geo/island coordinates; treating an enemy-side geo as equally useful
after capture; automatically changing build placement. Start-based affiliation,
conservative visibility and isolated dry-land topology are explicitly advisory:
they do not establish ownership, ballistic clearance, resource yield, buildable
landing footprints or time-to-capture. No placement, reservations, construction
orders or role policy is changed by the survey. The command also works on demand
for non-TECH experimental roles. Lane origins use the requesting AI player's
start; territory classification continues to use all allied starts, so selecting
a player does not misclassify an ally's rear water as hostile.

**Verification.** Native target BARb builds; stripped DLL `31153b61d5698386`
has matching debug symbols. API check: 214 members, zero findings. Invariant
practice check: zero findings. First four-minute panel run `20260928-155228`
passed player selection, switch, all, off, persistence and topology checks.
Six geos, 23 islands and eight beach fronts were calculated. The central geo
at (5430,7188) scores 90% forward visibility from player 0 versus 42% at
(6900,5070); player 1 reverses the advantage (28% versus 90%). Final panel run
`C:/bardev/barb-playtest-theatres-panel/runs/20260928-160012/report.md` passed
4.1 game minutes, including an AIR role request and refresh while hidden. Its
single/all-player screenshots were inspected. After changing lane origins to
the individual player, the four-AI TECH/AIR test
`C:/bardev/barb-playtest-theatres-multi/runs/20260928-164931/report.md` passed:
all four surveys arrived and every air lane started within one 128-elmo sample
of its own player's start. Neither final run raised script or invariant errors.
Doc links retain the eight pre-existing missing-hover-document links (KI-404).
No live-install writes. The paired DLL/debug build is under ignored
`build-theatres/`; deploy the new DLL, data and control widget together.

**Files.** [native bindings](../src/circuit/script/InitScript.cpp),
[strategic sites](../data/script/src/manager/strategic_sites.as),
[lanes](../data/script/src/manager/lanes.as),
[commands](../data/script/src/manager/commands.as),
[settings](../data/config/lanes.json),
[control widget](../tools/widgets/gui_barb_team_link.lua),
[watcher](../tools/playtest/widgets/theatres_watch.lua),
[checks](../tools/playtest/checks/shared/terrain/theatres_supreme.json),
[multiplayer watcher](../tools/playtest/widgets/theatres_multi_watch.lua),
[multiplayer checks](../tools/playtest/checks/shared/terrain/theatres_multi.json),
[lane documentation](roles/tech-lanes.md),
[script README](../data/script/README.md),
[API reference](angelscript-references.md), [repository map](../AGENTS.md),
[build-output ignore](../.gitignore).
The D-128 standalone `tools/widgets/gui_barb_theatres.lua` was removed.

## D-130 — Report missing lane replies and ship matching AI data

**Date:** 2026-09-28. **Status:** Mouse controls Played; owner installation pending.

**Finding.** The user's installed control widget matches the repository, but
the installed SMRTBARb command handler has no `theatres` branch and the DLL is
missing 59 current bindings. D-129's playtests used a matched build; their
action-level tests did not exercise mouse press/release. Do not misdiagnose
this as a button callback defect or copy only new scripts over an old DLL.

**Decision.** Track lane requests with a five-second wall-clock deadline and
show an actionable panel/event message if no survey arrives. Also explain
when a selected AI is not hosted locally. Expose read-only button rectangles
for the regression watcher, which now calls the actual widget MousePress and
MouseRelease methods for player/all/off. Prepare a matched, checksummed update
under ignored `build-theatres/release`, including an owner-run installer that
refuses running games, backs up the existing AI and preserves its identity.
No live game files are changed. KI-421 tracks pending owner deployment.

**Invariant.** A lane request must produce a survey or visible failure feedback;
mouse-button tests must traverse press/release rather than call SetTheatres.
This is UI state, not a gameplay invariant; the integration fixture retains its
existing `[INVARIANT]` forbid and `[TheatresCheck] FAIL` checks.

**Verification.** Current API parity: 214 members, zero findings against
`31153b61d5698386`. Run `20260928-180042` in
`C:/bardev/barb-playtest-theatres-click/runs/` passed actual MousePress/MouseRelease
checks for player/all/off, with survey received at frame 1140. It also passed
switch, AIR survey, visibility persistence and hidden refresh checks. The overall
run FAILED because the existing INV-015 frameless order issue (KI-420) recurred;
no script or overlay failures. The first watcher attempt called an unavailable
widget-handler wrapper method; it was corrected to delegate mouse events through
WG to the real widget methods. Timeout feedback is code-reviewed, not exercised
against the live mismatched AI. Installer parses without errors; package checksums
cover 228 files. The installer has not been run against the owner's game.

**Files.** [control widget](../tools/widgets/gui_barb_team_link.lua),
[click watcher](../tools/playtest/widgets/theatres_watch.lua),
[known issues](known-issues.md). Generated owner artifacts:
`build-theatres/release/Install-Theatres.ps1`, `build-theatres/release/SHA256.json`
and `build-theatres/barb-theatres-update.zip`.

**Correction after owner feedback.** A scratch build/archive was insufficient:
the completed build must always be published to
`C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`.
The matched stripped DLL, debug symbols and current active data have now been
staged there; API parity checks 214 members with zero findings. The live game
installation remains separate. This requirement is explicit in
[AGENTS.md](../AGENTS.md) and the [playtest skill](../skills/playtest/SKILL.md).

## D-131 — AI-owned tactical surveys with a controllable teaching overlay

**Call.** Retain route calculation in C++, refresh/tuning/lesson anchors in
AngelScript, and rendering/preferences in Lua. Expose route capability masks and
survey revisions alongside existing geometry. Preserve cliff alternatives by
capability-aware merging and search connected high ground with configurable rise,
detour and route limits. Avoid diagonal corner cutting and measure clearance for
the route's own movement class. Teach scouting and terrain opportunities without
presenting candidates as orders or unobserved territory as safe.

**Why.** A shortest-path-only survey missed Ascendancy's large mountain even
though it produced a nominal all-terrain lane. Map-specific coordinates and Lua
pathfinding were rejected: the same generic survey must remain available to AI
attack planning. Absolute-summit routing was revised after screenshot review to
prefer a cheaper crossing in the upper part of each high-ground region. No attack
task is rewired by this decision. See the [UX review](reviews/2026-09-28-tactical-guide-ux.md)
for three review rounds, failed evidence and validation boundaries.

**Invariant.** INV-062 requires the representative class to be present in the
capability mask and traverse the sampled route after every survey. The widget
does not calculate routes or issue game commands; freezing retains the visible
snapshot until an explicit refresh, and incoming data must not reopen a hidden view.
INV-063 requires enemy destinations for a tactical survey. Profile testing found
that the start parser discarded an entire AI block containing nested OPTIONS;
it now reads direct fields while skipping child sections, retaining Team before
or after OPTIONS. Inferring opponents from arbitrary map spots was rejected when
the actual participating teams are present in the script.
The last screenshot review also rejected twice-nearest-wall distance as a
corridor width: shortest paths hug coasts. Width now measures both sides of a
perpendicular cross-section and puts the choke anchor in its traversable centre,
also checked by INV-062.
Observed-AA testing then found `armflak.GetAirThreat()` was zero before route
calculation. **Rejected after testing:** a temporary engine armor-index lookup
returned the same indices as the existing initializer (vtol 14, subs 13), and
flak threat remained zero. That speculative API/script change was removed.
INV-064 checks nonzero BAR flak AA threat. The native probe confirmed correct
weapon classification and 250 air-armor damage. The actual cause was explicit
zero `air` and `default` threat multipliers in all three experimental profiles.
Restore those two multipliers to 1 for their 47 AA-role definitions (141 entries
across the six base/Legion files). Both are required: enemy damage has a default
damage gate before its air component. Native weapon capabilities still determine
actual AA damage; this does not invent an AA weapon for a multi-role definition.
Keep surface/water tuning unchanged. This also changes ordinary AI AA avoidance,
not just the overlay. Globally resetting every combat unit's tuning was rejected
as an untested balance change; remaining surface/water zeros are KI-424.
The screenshot harness also waits for three rendered frames and one wall-clock
second after moving the camera. Six simulation frames were insufficient at 8x:
the captured terrain could still be flat or incompletely textured. This affects
test capture timing only; schedule captures early enough to finish before quit.

**Status.** Built with MinGW and exercised in isolated engine playtests. Final
map/control/dynamic-threat evidence is recorded in the linked UX review. This is
not independent player usability testing. The default four-player Glacial run
also found the unrelated forward-cluster failure [KI-423](known-issues.md#ki-423--unbuildable-forward-cluster-retries-the-same-search-without-exhausting-attempts).
No live game installation was written. Cached terrain and host-local AI survey
availability remain explicit limitations.

**Files.** [native interface](../src/circuit/terrain/BattleAnalysis.h),
[start parser](../src/circuit/setup/SetupManager.cpp),
[lane mechanism](../src/circuit/terrain/BattleLanes.cpp),
[bindings](../src/circuit/script/InitScript.cpp),
[lane policy](../data/script/src/manager/lanes.as),
[commands](../data/script/src/manager/commands.as),
[settings](../data/config/lanes.json),
[balanced threats](../data/config/experimental_balanced/behaviour.json),
[balanced Legion threats](../data/config/experimental_balanced/behaviour_leg.json),
[hard threats](../data/config/experimental_hard/behaviour.json),
[hard Legion threats](../data/config/experimental_hard/behaviour_leg.json),
[terrible threats](../data/config/experimental_terrible/behaviour.json),
[terrible Legion threats](../data/config/experimental_terrible/behaviour_leg.json),
[regenerated unit report](knowledge/barb-unit-config.md),
[widget](../tools/widgets/gui_barb_team_link.lua),
[UI watcher](../tools/playtest/widgets/tactical_guide_watch.lua),
[threat watcher](../tools/playtest/widgets/tactical_threat_watch.lua),
[screenshot harness](../tools/playtest/widgets/playtest_camera.lua),
[playtest instructions](../tools/playtest/README.md),
[UI checks](../tools/playtest/checks/tactical/strategy/tactical_guide.json),
[threat checks](../tools/playtest/checks/tactical/strategy/tactical_threat.json),
[Ascendancy fixture](../tools/playtest/fixtures/ascendancy.as),
[lane documentation](roles/tech-lanes.md), [API reference](angelscript-references.md),
[invariants](invariants.md), [actors](actor-matrix.md), [issues](known-issues.md),
[UX evidence](reviews/2026-09-28-tactical-guide-ux.md).

## D-132 — Reach a mountain passage before committing to a crawler descent

**Refined by D-133:** retain the smooth high traverse to the far-side exit.

**Correction to D-131.** The owner marked Ascendancy's northern passage and
enemy-facing cliff descent. D-131's centre-ridge candidate was passable but did
not express that tactic; the previous northern-coordinate check was too weak.
Keep the earlier decision and screenshots as evidence of the rejected result.

**Call.** For each major high-ground component, prefer a two-stage candidate:
reach an upper-half staging cell using the configured ordinary tank/bot class,
then follow an all-terrain path toward its actual enemy destination. Require an
ordinary-bot-impassable descending section and a lower bot-passable landing
within the configured drop/run bounds. Require forward progress toward the
destination, enforce the existing weighted detour limit, reject repeated-cell
loops, and retain the generic crest fallback when this tactic is unavailable.
The configured high-ground route count bounds additional descent candidates.
Ordinary route alternatives remain; this does not declare the northern route
universally best or send units along it.

**Why.** Merely increasing uphill cost still found a central zigzag on the
exported Ascendancy terrain. Restricting the approach to ordinary-bot terrain
found the northern passage, followed by the cliff descent. A map-name waypoint
override was rejected. The initial terrain check found a roughly 23,652 weighted
cost route, within the existing 3x detour bound of roughly 25,448.

The first native run exposed an additional ranking error: selecting the
cheapest candidate before checking its joined approach/descent path meant a
looping candidate suppressed every valid descent in that component. Check
approach/suffix intersections before ranking. A generation-marked cell vector
avoids allocating a map-sized visited array per candidate. Native-grid export
also showed why Lua slope sampling is only an exploratory approximation;
the runtime regression uses native published lanes as its authority.

**Policy and display.** JSON controls approach class (`-1` disables), minimum
drop, maximum descent run and minimum progress. AngelScript reapplies these
parameters for each calculation, assigns the passage/descent teaching cue at
the native staging point, and keeps the existing refresh cadence. Lua only
orients the symbol along the published route near that anchor; using the
route's overall middle direction was wrong for a turning cliff approach.

**Invariant.** INV-065 requires a descent anchor to be accessible to the chosen
approach class and belong to a crawler-only lane. Native construction verifies
the approach tree, downhill cliff and lower landing. The Ascendancy runtime
fixture now requires lesson 5, the northern passage and an enemy-side northern
staging anchor, rather than accepting any route that grazes the mountain.

**Verification.** Native build and 218-member DLL/API parity pass. Ascendancy
run `20260928-235127` passes the stronger northern/descent assertions, controls,
refresh and invariant checks. Its selected route reaches z=544 and stages at
(7200, 992), following the northern passage before descending toward the enemy.
The tactical UX review records screenshots and profile regression evidence.
This validates survey geometry, not a completed attack by actual crawler units.

**Files.** [native interface](../src/circuit/terrain/BattleAnalysis.h),
[search](../src/circuit/terrain/BattleLanes.cpp),
[bindings](../src/circuit/script/InitScript.cpp),
[settings](../data/config/lanes.json),
[policy](../data/script/src/manager/lanes.as),
[widget](../tools/widgets/gui_barb_team_link.lua),
[runtime check](../tools/playtest/widgets/tactical_guide_watch.lua),
[invariants](invariants.md), [actors](actor-matrix.md),
[API](angelscript-references.md), [lane guide](roles/tech-lanes.md),
[review](reviews/2026-09-28-tactical-guide-ux.md).

## D-133 — Smooth high-ground traverse before the far-side descent

**Endpoint selection superseded by D-134 when paired steep cliffs are available.**

**Correction to D-132.** The owner's second annotated Ascendancy image shows
that reaching the north passage is insufficient: the route drops too early on
the east and cuts the western approach. D-132's cheap staging-cell objective
and upper-half staging-height requirement caused that behavior. D-132 remains
as the history of the intermediate result.

**Call.** First find the highest ordinary-class-reachable elevation in each
major component within the detour budget. Select a smooth approach within a
configurable band below that elevation (256 elmos by default). Traverse the
same high-ground component with all-terrain movement before descending at 0.9
progress along the source-to-actual-destination vector. The staging point may
be lower than the peak already reached. The approach and traverse add quadratic
absolute-grade cost (weight 8); the intentional final cliff drop does not.

**Why and alternatives.** A shortest ordinary-bot approach to a far eastern
staging point can bypass the mountain entirely. Merely forcing a visited-height
flag can instead create an out-and-back peak visit. Joining an explicit high
approach and a traverse, blocking reuse of the approach, avoids both. Forcing
the absolute maximum reached an isolated bump and caused a small hairpin in the
terrain prototype. The elevation band balances sustained height and smoothness;
zero tolerance remains available. This optimizes grade changes along a route,
not temporal hysteresis between threat-driven recalculations. No map coordinates
or map names enter production code.

**Budget and controls.** The longer traverse requires a default 4x rather than
3x detour allowance. Complete joined paths are checked against actual
travel/uphill/threat cost, separately from the smoothness score. Reject loops
before ranking. Both smoothness and elevation tolerance are native mechanisms
exposed through `SetMountainPathParams` and loaded from active JSON by script.
The existing generic crest fallback remains when no valid tactic is found.

**Invariant.** INV-065 additionally checks the published exit's destination-side
progress; INV-062 retains whole-path class/passability checks.

**Verification.** Native build and 219-member script/DLL parity pass. Engine
geometry, screenshots and profile regressions are recorded in the tactical UX
review. Actual crawler movement/combat and terrain deformation remain outside
this validation.

**Files.** [native interface](../src/circuit/terrain/BattleAnalysis.h),
[search](../src/circuit/terrain/BattleLanes.cpp),
[bindings](../src/circuit/script/InitScript.cpp),
[settings](../data/config/lanes.json), [policy](../data/script/src/manager/lanes.as),
[widget](../tools/widgets/gui_barb_team_link.lua),
[regression](../tools/playtest/widgets/tactical_guide_watch.lua),
[invariant](invariants.md), [actors](actor-matrix.md),
[API](angelscript-references.md), [guide](roles/tech-lanes.md),
[review](reviews/2026-09-28-tactical-guide-ux.md).

## D-134 — Prefer the steep cliff faces at both ends of the passage

**Extended by D-135:** endpoint steepness alone does not prevent long lateral
cliff-face travel on Glacial Gap. The surface and shelf costs supplement it.

**Correction to D-133.** The owner accepts the northern passage but marks more
outward, steeper western/eastern cliff faces. Ordinary-bot access on the west
and cheapest descent on the east still optimize away the walkers' advantage.
Keep D-133's high-passage mechanism as the centre and fallback, not the default
endpoint objective when a paired cliff crossing is available.

**Call.** Search from the high passage toward both bases with positive-cost
all-terrain paths that discount steep bot-impassable downhill edges. Require
an upper-half gate, early qualifying cliff drop/landing, directional progress,
no repeated cells and the complete travel/threat budget. Rank eligible legs by
height-drop-weighted exclusive grade, allowing a 10% quality band before cost
breaks the tie. Reverse the home leg for the source-to-enemy lane, so its ascent
uses the same cliff a reverse-direction attack could descend. Emit both anchors
and quality values; Lua renders two cues and explains the terrain advantage.

**Why and rejected alternatives.** Merely extending a progress threshold does
not reward a steep face. Pure shortest cost still selected the gentler inner
slope. Pure maximum steepness selected remote map-edge bumps for marginal
quality; the band chooses a shorter similarly steep face. A lower cliff alone
could win while the route gently left the upper plateau: the gate-height bound
prevents that. Quality divides by all downhill height, so uphill/downhill
oscillation does not gain a net-drop normalization bonus. The edge discount is
bounded and positive; ordinary lane search defaults remain unchanged.

**Policy and limits.** Active JSON/AngelScript controls the discount, quality
band and upper-height fraction. Zero discount retains D-133. The pair search
is bounded to 16 candidates at each end; if none forms a valid joined crossing,
the existing fallback remains. No map coordinates appear in production search.
The coordinate assertions are confined to the Ascendancy regression fixture.

**Invariant.** INV-066 requires both gates and positive native walker-only
quality at both ends; INV-062/065 retain capability and exit-progress checks.

**Verification.** Terrain prototypes found outward gates near x=1,300 and
x=11,100 and a joined travel cost within the existing 4x budget. The tactical UX
review records the actual engine run, screenshots, API parity and final binary.
This is route-survey validation, not completed walker movement/combat.

**Files.** [native interface](../src/circuit/terrain/BattleAnalysis.h),
[search](../src/circuit/terrain/BattleLanes.cpp),
[bindings](../src/circuit/script/InitScript.cpp),
[settings](../data/config/lanes.json), [policy](../data/script/src/manager/lanes.as),
[widget](../tools/widgets/gui_barb_team_link.lua),
[regression](../tools/playtest/widgets/tactical_guide_watch.lua),
[invariants](invariants.md), [actors](actor-matrix.md),
[API](angelscript-references.md), [guide](roles/tech-lanes.md),
[review](reviews/2026-09-28-tactical-guide-ux.md).

## D-135 — Cross mountain shelves instead of walking along cliff faces

**Call.** Preserve steep endpoint opportunities, but charge all-terrain searches
for mean engine surface slope as well as height change along their direction.
A constant-height line along a cliff is expensive; a flat upper shelf is cheap.
Between gates, additionally penalize descent below the configured peak band.
Expose both weights through JSON, AngelScript and the native binding.

**Why.** The owner's Glacial Gap correction identifies a positional objective:
cross the top and retain places where all-terrain constructors can establish
defenses. Longitudinal grade alone cannot distinguish a flat plateau from
sideways movement across a vertical wall. A first runtime iteration proved that
surface cost alone is insufficient: it selected a valley approach and climbed
only at the far end. Endpoint legs must stay within their own configured
progress band, and the fallback must try a two-ended elevated crossing before
falling back to an ordinary-bot approach. The shelf fallback uses a weighted
multi-source search between upper-band gates, rather than forcing two paths
through one peak waypoint. Short saddles remain traversable: the component and
adjacent land cells are searched with an elevation cost, not an absolute height
wall. The approach cost seeds its entry candidates;
the exit cost completes their ranking. The peak tolerance is not subtracted
again after selecting a reference point in that band. A shelf crossing is not
advertised as a verified steep paired descent. Blocked-region diagonals obey
the same no-corner-cutting rule as movement masks. Physical detour allowance
uses a separate shortest-cost search without the new preference costs.

**Alternatives and scope.** A blanket map-boundary attraction can choose a
cliff face over a usable shelf. Instead terrain determines which edge corridor
is useful; there are no map names or coordinates in production search. Actual
building placement still requires unit-specific footprint, terrain and obstacle
checks. This change does not issue constructor orders. The test independently
probes Legion radar and defense placement within Proteus's construction reach
of the published Glacial Gap routes. This does not certify a continuous chain
of buildings or completed unit movement. Intentional short endpoint legs retain
the steep-cliff cost policy rather than receiving the lateral-traverse penalty.

**Invariant.** Existing INV-062/065/066 retain capability and gate contracts.
The Glacial Gap fixture measures both central mountain traverses for sustained
elevation, surface slope and engine-tested construction positions; merely
touching the northern/southern mountain is insufficient acceptance evidence.

**Verification.** Native compilation and 223-member API parity checked. Final
runtime geometry, screenshots and the matching binary are recorded in the
[tactical review](reviews/2026-09-28-tactical-guide-ux.md).

**Files.** [native interface](../src/circuit/terrain/BattleAnalysis.h),
[search](../src/circuit/terrain/BattleLanes.cpp),
[binding](../src/circuit/script/InitScript.cpp),
[policy](../data/script/src/manager/lanes.as),
[settings](../data/config/lanes.json),
[runtime fixture](../tools/playtest/widgets/tactical_guide_watch.lua),
[API](angelscript-references.md), [guide](roles/tech-lanes.md),
[actors](actor-matrix.md).

## D-136 — A separate factory continuously exploits an accessible mountain flank

**Decision.** At +200 metal (ten-second minimum), TECH orders one additional
advanced bot lab for a connected all-terrain specialist lane. The normal T2 lab
remains separate for constructors and ordinary combat production. Defaults use
the effective Recluse, Termite and Arquebus factory build edges. Production is
continuous after establishment, including income dips; replacement construction
still requires the gate. Air transport is explicitly deferred.

**Why.** A visible lane is not proof that units from this TECH can reach it.
The native query proves land connectivity from the start and the reserved lab
site to the friendly lane end without a distant snap across water. Constructor
reach and footprint/exit checks independently gate construction. The policy
prefers sustained high ground, keeps the factory's theatre stable and owns only
its offspring. Other factories and spam keep their existing decisions. Ordinary
spam's direct retarget would abandon mountain waypoints; a native task option
preserves them and fights only at the final destination. Full grid waypoints
avoid smoothing across cliff cuts. Unit membership uses the creation-event
producer ID, not proximity to a factory producing the same unit.

**Invariant.** INV-067 checks that assigned specialist units retain their route.
The isolated Glacial Gap regression observes factory creation by an AI builder,
income at creation, repeated completed production, and actual high-ground travel
from both sides. Pending build-task ownership prevents duplicate factory orders.
Lifecycle retirement remains authoritative; dedicated labs are excluded from
base reclaim and primary-lab assignment.

**Verification.** Built and played on Glacial Gap from both sides with Armada,
Cortex and Legion. Natural-economy orders occurred at +203/+202 metal; both
streams repeatedly produced and reached the mountain. A separate no-damage
test proved full traversal in both directions and disconnected southern-bank
queries returned empty. Overall playtest reports still fail broader TECH
invariants; see the [evidence and limitations](reviews/2026-09-29-tech-flank-production.md).
No live game installation is modified.

**Accounting and scope.** The dedicated lab is not an economy turret-box
tenant: its independently reachable site is exempt from INV-029, as front
clusters already are. It does not count toward ordinary T2 availability or
base-reclaim factory totals. Otherwise an extra flank lab could suppress normal
lab replacement and accidentally remove the production the owner asked to keep.
The general save/load limitations remain; D-136 reconstruction is KI-426.

**Files.** [policy](../data/script/src/roles/tech_flank.as),
[rules](../data/script/src/roles/tech_rules.as), [TECH](../data/script/src/roles/tech.as),
[reclaim](../data/script/src/roles/tech_factories.as),
[factory hooks](../data/script/src/manager/factory.as),
[military hooks](../data/script/src/manager/military.as),
[normal lab accounting](../data/script/src/roles/tech_build.as),
[economy state](../data/script/src/manager/eco_planner.as),
[runtime invariants](../data/script/src/manager/invariants.as),
[settings](../data/config/lanes.json),
[lane interface](../src/circuit/terrain/BattleAnalysis.h),
[lane query](../src/circuit/terrain/BattleLanes.cpp),
[route interface](../src/circuit/task/fighter/RouteTask.h),
[route commands](../src/circuit/task/fighter/RouteTask.cpp),
[unit](../src/circuit/unit/CircuitUnit.h), [creation](../src/circuit/CircuitAI.cpp),
[bindings](../src/circuit/script/InitScript.cpp),
[runtime watcher](../tools/playtest/widgets/flank_watch.lua),
[checks](../tools/playtest/checks/tech/combat/tech_flank.json),
[traversal checks](../tools/playtest/checks/tech/combat/tech_flank_traversal.json),
[economy fixture](../tools/playtest/widgets/flank_economy_fixture.lua),
[policy guide](roles/tech_flank.md), [TECH guide](roles/tech.md),
[rules guide](roles/tech_rules.md), [factory guide](roles/tech_factories.md), [build guide](roles/tech_build.md),
[API](angelscript-references.md), [invariants](invariants.md), [actors](actor-matrix.md).

## D-137 — Judge Ascendancy flanks by observed combat outcomes

**Decision.** Test the unchanged D-136 production policy on Ascendancy with
explicit TECH roles in isolated data. Identify dedicated combat offspring by
engine producer IDs and their queued mountain route, then count actual kills,
losses, nominal metal values and arrival near the enemy start. Keep normal
damage, ordinary armies and AI visibility. Supply only economy in accelerated
runs, and retain a separate natural-economy observation.

**Why.** Following a line is insufficient evidence of a useful attack. Kills
are credited by the engine's attacker ID, not proximity or team-wide totals.
Metal is nominal UnitDef cost, not reclaimed value or assisted damage credit.
BAR drops attacker arguments in widget UnitDamaged dispatch; a raw observer
can also be replaced by UI call-in updates. Damage totals are consequently
diagnostic only and excluded from the effectiveness conclusion. Full-map
spectator visibility does not grant the AI extra vision.

**Invariant.** Retain the global invariant forbid and require both actual
role=2 snapshots; the harness labels alone are insufficient (KI-428). No route,
production, unit-stat or combat policy was changed for this experiment.

**Verification.** Both sides built and traversed the mountain. Legion's western
stream killed the eastern commander in the first valid accelerated run;
Armada's eastern stream scored kills but did not break through. See the
[played report](reviews/2026-09-29-ascendancy-flank-effectiveness.md) for final
counts, screenshots, fixture limits and unchanged failing overall verdicts.

**Files.** [observer](../tools/playtest/widgets/flank_effectiveness.lua),
[checks](../tools/playtest/checks/shared/combat/flank_effectiveness.json),
[issues](known-issues.md), [report](reviews/2026-09-29-ascendancy-flank-effectiveness.md).

## D-138 — Separate stale deployment from TECH production starvation

**Decision.** Preserve the owner's live-game log, inspect the actual script
load paths and all duplicate native installations, and run a full-team current
build control. Provide a complete owner-installable package with the unique
identity SMRTBARb/flank-20260929. Do not overwrite the live installation or
claim a package update fixes all ordinary production problems.

**Why.** The live game lacks the new flank script, so earlier isolated
playtests cannot validate that installation. Separately, its high-income TECH
shows a real forward-factory delay and constructor-first production. Reducing
constructor caps or reordering the entire build policy based only on that old
run would conflate two causes and undo previously deliberate owner policy.
Unique version metadata avoids the three stable-identity collisions without
deleting or renaming the owner's installations.

**Invariant.** The update is one matching DLL/debug/data set, with explicit
identity metadata. Income, planned clusters and construction orders are not
accepted as evidence of completed combat production. Existing invariant
failures remain failures.

**Verification.** The packaged DLL matches D-136, 225 API members pass, and
all 230 files have a hash manifest. Deployment remains owner work. See the
[investigation](reviews/2026-09-29-live-tech-production.md) and KI-429/430.

**Files.** [issues](known-issues.md),
[investigation](reviews/2026-09-29-live-tech-production.md),
[owner instructions](../build-theatres/tech-production-investigation/INSTALL.md).
No production code changed in this diagnosis.

## D-139 — Verify every faction from both Glacial Gap TECH starts without policy overrides

**Decision.** Run three natural-economy faction mirror matches plus a separate
8v8 control using the current workspace data and pinned D-136 DLL. Do not change
production policy or extend the forward-layout invariant timeout to obtain a
pass. Stop completed mirror matches once all six core production/traversal
observations are met and retain their actual durations and failing raw reports.
Keep the live game installation untouched while the owner uses it concurrently.

**Why.** The owner's separate script/config and DLL copy workflow is valid.
The D-138 filesystem observation was overextended into an explanation for all
reported games. Direct production evidence is needed, and earlier fixture or
timeout-relaxed runs are insufficient for this new validation. Both map sides
matter because their build sites, economy timing and opponents differ.

**Invariant.** A factory order is not completed production. Require an
AI-built factory, at least eight completed routed units spanning five minutes,
and two units reaching the central mountain per faction/side. Keep every global
invariant forbid; wider failures are not relabeled as passes. In full teams,
observe actual TECH IDs 0/9, not an allied FRONT AI at team 1.

**Verification.** All six mirror cases met the core observations with no script
errors or INV-067 violations. The 8v8 control lost its western side before the
gate; eastern TECH remained below +200, so the high-income full-team report
remains unresolved (KI-430). No gameplay code changed. The
[played report](reviews/2026-09-29-glacial-faction-validation.md) records unit
counts, first completion times, raw reports, unchanged failures and input hashes.

**Files.** [report](reviews/2026-09-29-glacial-faction-validation.md),
[corrected investigation](reviews/2026-09-29-live-tech-production.md),
[issues](known-issues.md),
[mirror runner](../build-theatres/faction-validation/run_mirror.py),
[full-team runner](../build-theatres/faction-validation/run_full.py),
[log summary](../build-theatres/faction-validation/summarize.py).

## D-140 — Outcome-based OpenSkill and strict map/settings scorecards

**Decision.** Record scorecards by UTC/local timestamp, map/game content checksums,
engine binary, complete gameplay settings, actual/expected roles and starts,
factions, scenario and tested DLL/data hashes. Keep map/settings cohorts separate,
including Legion enabled versus disabled. The AI build is the experimental
variable and the entrant identity, not a reason to reject matching conditions.
Use pinned OpenSkill Plackett–Luce 6.1.2 for confirmed outcomes only; retain raw
economy/combat/production/reliability diagnostics as separate measures.

**Why.** Combining economy, damage and army size into invented skill points
would reward high-income inactivity or damage farming. Pooling different maps,
content versions, factions or fixtures would obscure regressions. One measured
match is a provisional baseline, not a calibrated public BAR rating. Time limits
are censored; no winner is inferred from leading in resources or killing units.
The in-game calendar is pinned separately from wall-clock timestamps because
BAR can use date options for seasonal content. Start tolerances (64 elmos from
request, 32 between comparisons) are explicit and tested.

**Invariant.** Only a valid engine GameOver callback can produce a rating update.
Invalid/censored evidence and duplicated identical entrants cannot update skill.
Legion on/off, different maps and altered starts cannot silently compare as equal.
Missing/zero-denominator metrics remain null. Evidence changes cannot overwrite
an existing run; schema reinterpretations preserve prior records and are counted
once. Raw gameplay invariant failures stay visible and cannot be hidden by a
successful recorder. All writes remain outside the main game installation.

**Verification.** Nineteen tests pass, including actual library win/draw updates,
censored priors, role/position/content mismatches and comparator settings. The
three requested maps completed 45-minute observations with verified roles, starts,
runtime content checksums and error-free telemetry. None produced a confirmed
outcome, so all three correctly leave OpenSkill priors unchanged. The initial
batch has not exercised a live completed-match rating update. See the
[timestamped index](benchmarks/scorecards/README.md) and
[design/methodology](benchmarks/scorecard-design.md). No AI policy/native code changed.

**Files.** [recorder/model](../tools/playtest/scorecard.py),
[isolated runner](../tools/playtest/scorecard_run.py),
[observer](../tools/playtest/widgets/scorecard_metrics.lua),
[tests](../tools/playtest/test_scorecard.py),
[pinned dependency](../tools/playtest/requirements-scorecard.txt),
[playtest usage](../tools/playtest/README.md),
[methodology](benchmarks/scorecard-design.md),
[scorecard index](benchmarks/scorecards/README.md),
[rating ledger](benchmarks/scorecards/ratings.json), [issues](known-issues.md).

## D-141 — Batch lane rendering to avoid exhausting LuaUI memory

**Problem and evidence.** On 2026-09-29 the owner selected all-player lanes,
then a player name, and lost the entire UI. The installed widget SHA256 matched
the source. At frame 44395 the main infolog records three emergency collections
above 1.2 GB followed by `LUA_ERRMEM` in DrawScreen and LuaUI's 1.5 GiB allocator
limit. There is no widget-specific traceback, so this proves UI exhaustion,
not that a particular mouse callback was the sole cause.

**Decision.** Replace each route segment's closures and temporary colour/point
tables with two GL.LINES batches per route and one shared flat projection buffer.
The generic line primitive also uses a stable callback with arguments. Projection
still runs every frame, so camera motion remains current; lane calculation and
player/all/frozen controls are unchanged. Rejected raising the engine memory
limit or forcing global LuaUI garbage collection from this widget: neither
removes its allocation churn, and global collection affects every widget.

**Invariant.** All-player rendering must have bounded per-frame allocation and
retained state; selecting a player in all mode must preserve all-player visibility.
Batching must preserve route endpoints, air dashes and gaps at clipped vertices,
including a shorter or empty replacement survey. These are LuaUI invariants,
checked by the dedicated Lua fixture and engine watcher rather than the AI's
AngelScript Invariants module.

**Verification.** Three Lua 5.1 tests pass. The same 16-player, nine-lanes-per-player,
400-points-per-lane fixture measured roughly 40 MB of temporary allocation per
frame before this change, versus 80.6 KiB peak after it; retained growth across
120 draws/clicks was 0.1 KiB. This isolates rendering allocation from engine and
other widgets. The hidden graphical engine test and remaining limits are recorded
in the [incident review](reviews/2026-09-29-lane-ui-memory.md). The original
incident has not been replayed; [KI-431](known-issues.md#ki-431--lane-ui-memory-fix-needs-confirmation-in-the-original-session)
tracks that limit. No installed files were modified and no DLL rebuild is needed.

**Files.** [Widget](../tools/widgets/gui_barb_team_link.lua),
[Lua fixture](../tools/playtest/fixtures/lane_ui_mock.lua),
[tests](../tools/playtest/test_lane_ui_memory.py),
[engine watcher](../tools/playtest/widgets/lane_ui_memory_watch.lua),
[engine checks](../tools/playtest/checks/shared/performance/lane_ui_memory.json),
[usage](../tools/playtest/README.md), [incident review](reviews/2026-09-29-lane-ui-memory.md),
[issue register](known-issues.md).

## D-142 — Forbid T1 artillery and celebrate the first super-cannon shot

**Decision.** Respect the owner's no-T1-static-artillery rule in every active
profile and role. `behaviour/<unit>/build: false` vetoes `armguard`, `corpun`,
and `legcluster`; runtime cap increases cannot undo it. Availability excludes
these definitions and construction enqueue rejects them. Repair/reclaim tasks
are outside this check: their task payload does not initialize `buildDef`.

TECH's artillery slots use actual T2 artillery, gated at +300 metal by default;
LRPC and super-cannon gates and energy affordability remain in JSON. There is
no new mandatory build order. Correct the shared T2 helper's swapped
artillery/pop-up classification and AIR's Legion T2 allowance. Preserve the
legacy `art1` array index with empty definitions rather than shift role indices.
Do not alter porcupine array indices or enemy classification.

**Rationale and alternatives.** A zero unit cap alone is insufficient because
forward policy intentionally lifts caps. `ignore` changes enemy classification
and `on` controls activation, so neither is a construction prohibition. Keep
named-unit policy in JSON/AngelScript, not hardcoded native priorities. Include
the Legion veto in base fragments as well as Legion fragments: the definition
can exist even without Legion being selected. Existing/captured buildings are
not deleted.

**Drawing.** An optional `Main::AiSuperWeaponFired` callback observes the actual
engine event for native super-weapon tasks. Script selects Ragnarok, Calamity
and Starfall and queues 32 lowercase `lol` strokes at the aim (or the cannon
when no aim exists), through the nuke smiley's paced line queue. One drawing
per unit ID per AI session prevents repeated salvos flooding the map. Destruction
forgets the ID. JSON controls enablement and letter height. Nuclear smileys are
unchanged. The decision to draw on first shot, not construction or an attack
order, is deliberate; save/load starts a new script session.

**Invariant.** INV-069 checks the three definition vetoes in every profile.
The integration probe raises their caps and directly enqueues construction;
all must remain unavailable and return null. Allowed T2/LRPC/super definitions
must retain permission. Repair tasks must continue normally.

**Status.** Built with matching stripped DLL/debug symbols; verification results
are recorded in [the artillery review](reviews/2026-09-29-artillery-policy.md).
No live-game installation was modified.

**Files.**
- [src/circuit/unit/CircuitDef.h](../src/circuit/unit/CircuitDef.h)
- [src/circuit/module/BuilderManager.cpp](../src/circuit/module/BuilderManager.cpp)
- [src/circuit/module/FactoryManager.cpp](../src/circuit/module/FactoryManager.cpp)
- [src/circuit/script/InitScript.h](../src/circuit/script/InitScript.h)
- [src/circuit/script/InitScript.cpp](../src/circuit/script/InitScript.cpp)
- [src/circuit/CircuitAI.cpp](../src/circuit/CircuitAI.cpp)
- [data/config/weapons.json](../data/config/weapons.json)
- [data/script/src/manager/artillery_policy.as](../data/script/src/manager/artillery_policy.as)
- [data/script/src/setup.as](../data/script/src/setup.as)
- [data/script/src/helpers/unit_helpers.as](../data/script/src/helpers/unit_helpers.as)
- [data/script/src/helpers/defense_helpers.as](../data/script/src/helpers/defense_helpers.as)
- [data/script/src/roles/air.as](../data/script/src/roles/air.as)
- [data/script/src/roles/tech_forward.as](../data/script/src/roles/tech_forward.as)
- [data/script/src/roles/tech_weapons.as](../data/script/src/roles/tech_weapons.as)
- [tools/playtest/fixtures/artillery_probe.as](../tools/playtest/fixtures/artillery_probe.as)
- [tools/playtest/widgets/artillery_fire_watch.lua](../tools/playtest/widgets/artillery_fire_watch.lua)
- [tools/playtest/checks/shared/combat/artillery_fire.json](../tools/playtest/checks/shared/combat/artillery_fire.json)
- [tools/playtest/checks/shared/reliability/artillery_profiles.json](../tools/playtest/checks/shared/reliability/artillery_profiles.json)
- [tools/playtest/prepare_artillery_check.py](../tools/playtest/prepare_artillery_check.py)
- [tools/playtest/README.md](../tools/playtest/README.md)
- [tools/knowledge/barb_report.py](../tools/knowledge/barb_report.py)
- [doc/knowledge/barb-unit-config.md](../doc/knowledge/barb-unit-config.md)
- [doc/invariants.md](../doc/invariants.md)
- [doc/angelscript-references.md](../doc/angelscript-references.md)
- [doc/roles/air.md](../doc/roles/air.md)
- [doc/roles/tech_forward.md](../doc/roles/tech_forward.md)
- [doc/roles/tech_weapons.md](../doc/roles/tech_weapons.md)
- [data/config/behaviour.json](../data/config/behaviour.json)
- [data/config/easy/behaviour.json](../data/config/easy/behaviour.json)
- [data/config/easy/behaviour_leg.json](../data/config/easy/behaviour_leg.json)
- [data/config/experimental_balanced/behaviour.json](../data/config/experimental_balanced/behaviour.json)
- [data/config/experimental_balanced/behaviour_leg.json](../data/config/experimental_balanced/behaviour_leg.json)
- [data/config/experimental_hard/behaviour.json](../data/config/experimental_hard/behaviour.json)
- [data/config/experimental_hard/behaviour_leg.json](../data/config/experimental_hard/behaviour_leg.json)
- [data/config/experimental_terrible/behaviour.json](../data/config/experimental_terrible/behaviour.json)
- [data/config/experimental_terrible/behaviour_leg.json](../data/config/experimental_terrible/behaviour_leg.json)
- [data/config/hard/behaviour.json](../data/config/hard/behaviour.json)
- [data/config/hard/behaviour_leg.json](../data/config/hard/behaviour_leg.json)
- [data/config/hard_aggressive/behaviour.json](../data/config/hard_aggressive/behaviour.json)
- [data/config/hard_aggressive/behaviour_leg.json](../data/config/hard_aggressive/behaviour_leg.json)
- [data/config/medium/behaviour.json](../data/config/medium/behaviour.json)
- [data/config/medium/behaviour_leg.json](../data/config/medium/behaviour_leg.json)
- [data/script/easy/main.as](../data/script/easy/main.as)
- [data/script/experimental_balanced/main.as](../data/script/experimental_balanced/main.as)
- [data/script/experimental_hard/main.as](../data/script/experimental_hard/main.as)
- [data/script/experimental_terrible/main.as](../data/script/experimental_terrible/main.as)
- [data/script/hard/main.as](../data/script/hard/main.as)
- [data/script/hard_aggressive/main.as](../data/script/hard_aggressive/main.as)
- [data/script/medium/main.as](../data/script/medium/main.as)

## D-143 — Arquebus holds weapon range instead of charging along a flank

**Decision.** Enable `behaviour/legsrail/standoff: 0.90` in all seven Legion
profiles. Native unit micro maintains a firing distance based on weapon reach,
conservatively adjusted for elevation, with a five-percent dead band. It holds
position/fire-at-will, moves back when too close, and never appends a fight
command that would pursue the enemy. The same mechanism intercepts ordinary
unit attack orders. Zero is the default for other definitions and disables it.

**Cause.** D-136 reused the spam route task: plain queued moves through every
waypoint, ignoring combat until the last fight command. Thus an Arquebus could
fire while continuing straight toward the target. Ordinary micro also had a
sight-radius-limited firing position followed by attack/fight orders. Moving
Arquebus to the artillery role alone would not fix the dedicated route and
would restrict targets to structures.

**Route ownership.** The route task detects observed, targetable enemies near
weapon range and pauses its queue while using the range controller. It owns
idle events during engagement, so Stop cannot immediately restart the charge.
After contact loss/death it resumes the nearest preserved waypoint; route
revisions cannot override an ongoing engagement. No known enemy means normal
lane traversal. Membership is removed on normal unit removal. No widget logic
or map-specific coordinates participate in production combat decisions.

**Invariant.** INV-067 still checks that flank units retain their dedicated
route task. The combat regression adds a measurable range promise: supplied
Arquebus units in both directions must survive, kill a shorter-range defense
without coming within 600 elmos, then resume beyond the target. Failure is
forbidden by `checks/shared/combat/arquebus.json`; the watcher samples distance and health
once per second. An inaccessible firing ring stops the unit instead of
substituting a close attack. This is not a claim of optimal terrain line of
fire or survival against enemies that outrange or outrun the railgun.

**Verification.** Native build and DLL API parity pass. Engine comparison
results are recorded in [the range review](reviews/2026-09-29-arquebus-range.md).
Played on both Supreme Isthmus sides: the old DLL lost both supplied railguns;
the new DLL destroyed both HLTs and resumed both routes, with minimum sampled
health 2200 and distances 674/627. Natural production and cliff firing geometry
were not exercised by this focused fixture.
Build output contains matching DLL/debug symbols and source data; the owner's
live game installation is not modified.

**Files.**
- [src/circuit/unit/CircuitDef.h](../src/circuit/unit/CircuitDef.h)
- [src/circuit/unit/CircuitUnit.h](../src/circuit/unit/CircuitUnit.h)
- [src/circuit/unit/CircuitUnit.cpp](../src/circuit/unit/CircuitUnit.cpp)
- [src/circuit/module/FactoryManager.cpp](../src/circuit/module/FactoryManager.cpp)
- [src/circuit/task/fighter/RouteTask.h](../src/circuit/task/fighter/RouteTask.h)
- [src/circuit/task/fighter/RouteTask.cpp](../src/circuit/task/fighter/RouteTask.cpp)
- [doc/roles/tech_flank.md](../doc/roles/tech_flank.md)
- [doc/actor-matrix.md](../doc/actor-matrix.md)
- [doc/spam-routes.md](../doc/spam-routes.md)
- [tools/playtest/fixtures/arquebus_route.as](../tools/playtest/fixtures/arquebus_route.as)
- [tools/playtest/widgets/arquebus_watch.lua](../tools/playtest/widgets/arquebus_watch.lua)
- [tools/playtest/checks/shared/combat/arquebus.json](../tools/playtest/checks/shared/combat/arquebus.json)
- [doc/known-issues.md](../doc/known-issues.md)
- [doc/knowledge/barb-unit-config.md](../doc/knowledge/barb-unit-config.md)
- [data/config/easy/behaviour_leg.json](../data/config/easy/behaviour_leg.json)
- [data/config/experimental_balanced/behaviour_leg.json](../data/config/experimental_balanced/behaviour_leg.json)
- [data/config/experimental_hard/behaviour_leg.json](../data/config/experimental_hard/behaviour_leg.json)
- [data/config/experimental_terrible/behaviour_leg.json](../data/config/experimental_terrible/behaviour_leg.json)
- [data/config/hard/behaviour_leg.json](../data/config/hard/behaviour_leg.json)
- [data/config/hard_aggressive/behaviour_leg.json](../data/config/hard_aggressive/behaviour_leg.json)
- [data/config/medium/behaviour_leg.json](../data/config/medium/behaviour_leg.json)

## D-144 — Snapshot-based lane workers with measured main-thread cost

**Decision.** Extract one engine-free `lane::Solver` for synchronous and worker
execution. The main-thread adapter captures observed threats and starts, reuses
an immutable per-AI terrain snapshot, and submits at most one background job.
The scheduler gives later ordinary path jobs priority over queued background
work. Script controls background mode, staggering and refresh frequency.

**Why.** Strategic lane searches run many full-grid passes over stable terrain.
They do not need to block the simulation until finished: the previous complete
lanes remain usable. Starting one OS thread per AI, sharing mutable analysis
objects, or invoking AngelScript on a worker were rejected. Parallelizing each
alternative was rejected because penalty/merge ordering is dependent. The same
solver avoids separate sync/async algorithms drifting apart.

**Ownership.** Worker closures own request/scratch data and immutable terrain,
with no raw AI pointer. The main completion is allocated before enqueue;
worker exceptions are captured, never allowed across the thread entry. The
scheduler's synchronized completion queue hands off the result. Only the main
callback locks the weak owner and swaps the complete lanes. Cancellation marks
an atomic token and invalidates a main-only generation gate without freeing the
admission slot early. Shutdown cannot publish into a destroyed AI.

**Invariant.** INV-070: script finalization observes a new successfully published
generation; cancellation/failed work cannot impersonate one. `Lanes::Poll` and
`Finish` log violations; the native gate additionally rejects duplicate/stale
completion. Tests cover admission, cancellation, independent threat snapshots,
parallel determinism, disconnected water, corner blocking and high ground.

**Deliberate limits.** Terrain snapshots are shared between jobs of one AI,
not globally interned between AIs: measured capture is below one millisecond,
and a cross-instance terrain cache adds identity/invalidation complexity.
Threats must never be shared between teams with different observations. Existing
terrain-grid caching semantics are retained. Script validation, water/site
advisories, overlay publication and `GetLaneRoute`'s connection search remain
main-thread operations. The benchmark includes postprocessing rather than
claiming all strategic survey work is off-thread. Worker completion timing can
change the frame an AI adopts a new route; geometric determinism does not promise
identical whole-match outcomes across thread schedules.

**Verification.** Six standalone lane suites pass, including eight simultaneous
solvers, alongside existing native tests. Integration build and 231-member API
check pass. Sample games, timings, exact settings and any unrelated game failures
are recorded in [lane-worker benchmarks](benchmarks/lane-workers/README.md).

**Files.**
- [LaneSolver.h](../src/circuit/terrain/LaneSolver.h), [LaneSolver.cpp](../src/circuit/terrain/LaneSolver.cpp)
- [BattleAnalysis.h](../src/circuit/terrain/BattleAnalysis.h), [BattleAnalysis.cpp](../src/circuit/terrain/BattleAnalysis.cpp), [BattleLanes.cpp](../src/circuit/terrain/BattleLanes.cpp)
- [Scheduler.h](../src/circuit/scheduler/Scheduler.h), [Scheduler.cpp](../src/circuit/scheduler/Scheduler.cpp), [MultiQueue.h](../src/circuit/util/MultiQueue.h), [MultiQueue.hpp](../src/circuit/util/MultiQueue.hpp)
- [InitScript.cpp](../src/circuit/script/InitScript.cpp), [lanes.as](../data/script/src/manager/lanes.as), [lanes.json](../data/config/lanes.json)
- [balanced main](../data/script/experimental_balanced/main.as), [hard main](../data/script/experimental_hard/main.as), [terrible main](../data/script/experimental_terrible/main.as)
- [lane tests](../tests/lane_solver_test.cpp), [test CMake](../tests/CMakeLists.txt), [test runner](../tools/run_native_tests.sh), [CMakeLists.txt](../CMakeLists.txt)
- [benchmark tool](../tools/playtest/lane_benchmark.py), [observer](../tools/playtest/widgets/lane_benchmark_watch.lua), [checks](../tools/playtest/checks/shared/performance/lane_workers.json)
- [invariants](invariants.md), [actors](actor-matrix.md), [API](angelscript-references.md), [lanes](roles/tech-lanes.md), [known issues](known-issues.md)

## D-145 — Connected mountain traverses, not isolated hill detours

**Decision.** Filter every native all-terrain candidate through the same
connected-elevated-terrain test before publication. Require projected progress
of at least 1024 elmos and 45% of lane endpoint separation on one elevated
component, with rise above the higher endpoint controlled by the existing
high-ground setting. Expose span controls and the resulting qualification to
script. TECH accepts only qualified reachable routes and clears qualification
before every refresh selection.

**Why.** Supreme's small isolated hills were being treated as strategic flanks,
triggering an extra T2 lab and perpetual all-terrain production. Class/movement
capability does not establish tactical value. A map-name blacklist was rejected:
it would hide the same defect on another flat map. Adding disjoint hill spans
or measuring sideways path length was rejected because neither connects the
opposing sides with a mountain traverse. Isolated artillery perches are not
attack lanes; no Vanguard placement policy is introduced here.

**Invariant.** INV-071: every published all-terrain lane crosses one substantial
connected mountain. The native filter checks all generator outputs; script
checks the published qualification. A failed selection also blocks subsequent
flank recruitment until a successful requalification.

**Verification.** Eight native suites pass, including a control that produces
false specialist routes when span thresholds are disabled, rejection of several
disconnected mesas in both directions, retention of a connected ridge, and
rejection of two ridge-end visits joined through the valley.
Build and 233-member API check pass; all three affected experimental profiles
load and publish lanes in BAR. Runtime results are recorded in the
[played review](reviews/2026-09-29-connected-mountain-lanes.md); do not infer
combat effectiveness from route generation alone. KI-434 tracks the incident.

**Deliberate non-change.** Fixed per-faction flank recruitment remains unchanged.
Armada traded poorly in the played matchups; route validity is not a promise of
favorable combat against every counter. Omniscient test kill/loss counters are
not available to recruitment policy. See the played review for measured limits.

**Files.** [solver header](../src/circuit/terrain/LaneSolver.h), [solver](../src/circuit/terrain/LaneSolver.cpp), [native API](../src/circuit/terrain/BattleAnalysis.h), [adapter](../src/circuit/terrain/BattleLanes.cpp), [bindings](../src/circuit/script/InitScript.cpp), [lanes](../data/script/src/manager/lanes.as), [flank policy](../data/script/src/roles/tech_flank.as), [config](../data/config/lanes.json), [unit tests](../tests/lane_solver_test.cpp), [preparer](../tools/playtest/prepare_mountain_regression.py), [income observer](../tools/playtest/widgets/mountain_regression_watch.lua), [archived evidence verifier](../tools/playtest/verify_mountain_regression.py), [run instructions](../tools/playtest/README.md), [Supreme check](../tools/playtest/checks/shared/terrain/mountain_supreme.json), [survey check](../tools/playtest/checks/shared/terrain/mountain_survey.json), [profile load check](../tools/playtest/checks/shared/terrain/mountain_startup.json), [startup request probe](../tools/playtest/widgets/mountain_startup_watch.lua), [invariants](invariants.md), [actors](actor-matrix.md), [script API](angelscript-references.md), [lane reference](roles/tech-lanes.md), [flank reference](roles/tech_flank.md), [issues](known-issues.md).

## D-146 — Plan AIR production bays without changing TECH

**Status.** Proposed design and source analysis only. No implementation,
configuration, unit-test or gameplay changes. Online guidance was inspected on
2026-09-30; no new replay sample or factory-throughput experiment was run.

**Decision.** AIR will use its own T1-first economy states, ordered build rules
and repeatable production bays over the existing native task/reservation
mechanisms. Treat twenty ordinary nanos per T2 air plant as an initial soft
consideration point, measure cold opening separately from warm handoff, and
support six or more plants according to funded production demand. Separate
late reactors from critical production. Preserve existing air scouting,
transport, defence, strike and wave capabilities through explicit integration.

**Reasoning.** Aircraft production needs continuing energy and military
allocation; TECH's AFUS rush, dense economic sets and builder specialisation
are not an AIR economic policy. Existing shared geometry and pinned tasks are
reusable, but native experimental mode also disables economy/storage/start
factory planning, and factory reservation acquisition contains TECH-specific
names. Enabling it without a complete AIR path would remove required work.

**Rejected.** Copying the TECH controller; merely raising the three-plant
ceiling; a mandatory six-plant build order; treating all nanos in range as
available to every plant; broad refactoring of TECH before differential
tests. Extract parameter-only utilities where useful, keeping compatibility
wrappers/defaults. Leave TECH's current code path in place if parity cannot
be demonstrated.

**Invariant.** For identical inputs, TECH keeps its current ordered decisions,
task/site/facing/priority results, reservations and random draws. AIR state,
caps, resource budgets and layout identities belong only to that AI instance
and role. This is a proposed implementation acceptance contract; no new runtime
invariant IDs are claimed by this documentation-only change.

**Open defects.** KI-217 records per-factory nano counts that do not reconcile
losses or cancelled orders. KI-218 records AIR's unreachable explicit mex-first
priority on its T1 caller. Existing KI-209 save/load and KI-427 TECH baseline
failures remain; their presence must not be hidden by the migration tests.

**Files.** [Comprehensive plan](air-layout-and-priority-plan.md),
[issues](known-issues.md), this [decision record](decisions.md), and the separate
[game-only AIR study](../../rjm.bar.docs/knowledge/70-strategy/78-air-pvp-meta.md).

**Verification.** Source trace covers all 42 functions of `air.as`, shared
callback routing, native placement/economy gates and relevant script bindings.
The plan specifies pure-function, lifecycle, geometry, throughput and TECH
differential tests. Documentation validation is recorded in the plan; it does
not verify the proposed runtime behaviour.

## D-147 — AIR owns T1 economy, production bays and transport-first recruitment

**Status.** Built and played on 2026-09-30. The final native DLL is
`4455871a7febabbc` with matching symbols and current data in the mandatory
Recoil build output. The live game installation is unchanged. Full results,
including failed checks and data revisions, are in the
[AIR evidence report](benchmarks/air-management.md).

**Decision.** Enable an independent AIR controller in experimental profiles:
`AirRules` selects ordered actions, `AirBuild` owns tasks, `AirEconomy` observes
income/commitments/owned units, `AirLayout` reserves repeatable production bays,
and `AirProduction` controls finite utility/home quotas and military output.
T1 energy and combat continue until a complete T2 package is funded. T1 mobile
builders grow to six when funded, because factory-bound nanos cannot build a
remote wind field. Keep the T1 plant for transports after T2 arrives.

A starter has up to five rear nanos. Each T2 bay has up to twenty side-bank
slots, with partial banks accepted on cramped terrain and capacity calculated
from actual space. Further plants need sustained spare resources, available
support and funding; twelve is a configurable ceiling. Late reactors search
away from factories. Native persistent single sites share existing claims,
required pins, completion/destruction and serialization; AIR metadata is named
separately. Pure production, funding and geometry arithmetic is reusable and
executes under the real AngelScript runtime in unit tests.

Transport obligations precede optional AIR recruitment and spam. Accept any
allied requestor role, deduplicate active/queued teams, service FIFO, and latch
an order only after enqueue succeeds. Pending recruits, frames and owned units
are counted separately. TECH's requester trigger and cargo protocol stay as
before. Home fighters never enter wave ledgers. With no observed ground front
or a home-area combat focus, new AIR wave planning falls back to an actual
participating enemy start; explicit strike targeting still takes precedence.

**Why these implementation choices.** Reusing TECH's AFUS chain, turret box
or thresholds would change the role's economy and risk TECH behavior. Shared
native mechanisms and small pure helpers remove duplication without migrating
TECH. Script `GetBuildSpeed` exposes physical worker time, not JSON's policy
speed; applying a frame multiplier produced wrong capacity estimates and was
removed. Native completion chains can create unassigned economy orders despite
experimental mode, so AIR reconciles ownership after enqueue and resumes its
own orphan orders. Otherwise a phantom nano or energy job can block all future
work. Flying builders can orbit a ground approach disc; an AIR-only native
lever delegates their final approach to the engine's build command. Negative
rear candidates are rejected before native grid queries. Completed T2 mexes
are reconciled from owned units, including direct native MEX builds. The original
12-ring/12-sample coastal energy search exhausted its candidates while banks
floated; AIR now expands across 24 rings with 24 samples and backs off failed
definitions for three seconds. A transition check requires actual T2, mex
upgrade and reactor completion instead of only a valid opening.
The 55-minute natural run missed its reactor deadline while building its first
AFUS. A large metal bank had admitted that project without established reactor
income. AIR now chooses ordinary fusion first and requires an observed completed
reactor before selecting AFUS. This keeps the initial energy investment within
the smaller AIR construction crew; unfinished reactor frames do not qualify.

**Rejected or deferred.** No general TECH extraction, no sample/profile edits,
no mandatory six-factory order and no unbounded constructor/scout/transport
queue. The first capacity policy fills useful funded support up to twenty
before another bay; a calibrated marginal-capital optimizer, every product's
0–40-nano experiment, floating campus templates and full script save/load are
not claimed. The warm-gap value is a prior, not a measurement of cold startup.
The initial observer incorrectly included factory construction in cold idle;
the final observer starts at completion. Damage collection hooks the complete
LuaUI event and forwards it unchanged, reinstating after dispatcher resets.

**Invariant.** INV-072 separates home/wave fighters; INV-073 keeps one nano
planner; INV-074 bounds published bays; INV-075 prevents duplicate obligations
per provider; INV-076 rejects unowned queued nano work. Existing TECH invariants
and all playtest forbids remain intact. For identical valid inputs TECH keeps
its policy sequence, sites, caps, defaults and random calls. Protected TECH
scripts/configuration are byte-for-byte unchanged; this does not assert equal
emergent matches when AIR changes allied resources or threats.

**Verification.** Native compilation succeeded, registration parity passed
239 used members, 28 executable AS math tests passed, as did 76 ranking checks,
base geometry and eight lane suites. Natural AIR reached T2 while continuing
combat; supplied Cortex/Legion economies exceeded six factories and replaced
real nano losses; role switches passed. A controlled sortie produced observed
bomber damage after the outbound fallback. TECH and mixed-team reports retain
baseline invariant failures. Source checks pass apart from documented existing
hover links and TECH sonar findings. Exact repeated-game equality, full
save/load and competitive win-rate improvement remain unverified.
The final natural run completed ordinary fusion at 56.13 minutes, 2.13 minutes
after the unchanged benchmark; it completed 14 T2 mexes and maintained combat
without script/crash/invariant errors. This functional result does not turn
the deadline scorecard into a pass.

**Open issues.** KI-112 records the native grid query's unchecked caller
contract (AIR is guarded); KI-217/218 retain legacy bookkeeping limitations;
KI-209 covers script persistence; KI-219 covers several AIR providers accepting
one broadcast; KI-220 records warm-gap calibration from observed effective
factory delays; KI-435 covers a gifted transport misattributed by TECH's
retiring-factory invariant; KI-436 retains the natural reactor timing miss.
KI-427 baseline TECH failures are not hidden.

**Files.** The implementation, references, fixtures and tests touched by this
change are linked below; the evidence report distinguishes completed work from
limits and superseded diagnostic runs.

- [data/script/README.md](../data/script/README.md)
- [data/script/src/global.as](../data/script/src/global.as)
- [data/script/src/helpers/production_math.as](../data/script/src/helpers/production_math.as)
- [data/script/src/manager/air_economy.as](../data/script/src/manager/air_economy.as)
- [data/script/src/manager/air_layout.as](../data/script/src/manager/air_layout.as)
- [data/script/src/manager/air_production.as](../data/script/src/manager/air_production.as)
- [data/script/src/manager/air_waves.as](../data/script/src/manager/air_waves.as)
- [data/script/src/manager/builder.as](../data/script/src/manager/builder.as)
- [data/script/src/manager/commands.as](../data/script/src/manager/commands.as)
- [data/script/src/manager/factory.as](../data/script/src/manager/factory.as)
- [data/script/src/manager/ferry.as](../data/script/src/manager/ferry.as)
- [data/script/src/roles/air.as](../data/script/src/roles/air.as)
- [data/script/src/roles/air_build.as](../data/script/src/roles/air_build.as)
- [data/script/src/roles/air_rules.as](../data/script/src/roles/air_rules.as)
- [doc/actor-matrix.md](actor-matrix.md)
- [doc/air-layout-and-priority-plan.md](air-layout-and-priority-plan.md)
- [doc/air-management.md](air-management.md)
- [doc/air-wave-attacks.md](air-wave-attacks.md)
- [doc/angelscript-references.md](angelscript-references.md)
- [doc/base-layout.md](base-layout.md)
- [doc/benchmarks/air-management.md](benchmarks/air-management.md)
- [doc/decisions.md](decisions.md)
- [doc/invariants.md](invariants.md)
- [doc/known-issues.md](known-issues.md)
- [doc/roles/README.md](roles/README.md)
- [doc/roles/air.md](roles/air.md)
- [doc/roles/air_build.md](roles/air_build.md)
- [doc/roles/air_rules.md](roles/air_rules.md)
- [doc/transport-ferry.md](transport-ferry.md)
- [src/circuit/module/BuilderManager.h](../src/circuit/module/BuilderManager.h)
- [src/circuit/script/BuilderScript.cpp](../src/circuit/script/BuilderScript.cpp)
- [src/circuit/script/FactoryScript.cpp](../src/circuit/script/FactoryScript.cpp)
- [src/circuit/script/InitScript.cpp](../src/circuit/script/InitScript.cpp)
- [src/circuit/task/builder/BuilderTask.cpp](../src/circuit/task/builder/BuilderTask.cpp)
- [src/circuit/terrain/TerrainManager.cpp](../src/circuit/terrain/TerrainManager.cpp)
- [src/circuit/terrain/TerrainManager.h](../src/circuit/terrain/TerrainManager.h)
- [tests/CMakeLists.txt](../tests/CMakeLists.txt)
- [tests/production_math_test.cpp](../tests/production_math_test.cpp)
- [tests/production_math_tests.as](../tests/production_math_tests.as)
- [tools/playtest/checks/air/combat/air_attack.json](../tools/playtest/checks/air/combat/air_attack.json)
- [tools/playtest/checks/air/reliability/air_legacy.json](../tools/playtest/checks/air/reliability/air_legacy.json)
- [tools/playtest/checks/air/economy/air_capacity.json](../tools/playtest/checks/air/economy/air_capacity.json)
- [tools/playtest/checks/air/reliability/air_compile.json](../tools/playtest/checks/air/reliability/air_compile.json)
- [tools/playtest/checks/air/economy/air_economy.json](../tools/playtest/checks/air/economy/air_economy.json)
- [tools/playtest/checks/air/reliability/air_switch.json](../tools/playtest/checks/air/reliability/air_switch.json)
- [tools/playtest/checks/air/cooperation/air_transport.json](../tools/playtest/checks/air/cooperation/air_transport.json)
- [tools/playtest/checks/air/economy/air_transition.json](../tools/playtest/checks/air/economy/air_transition.json)
- [tools/playtest/checks/tech/economy/tech_control.json](../tools/playtest/checks/tech/economy/tech_control.json)
- [tools/playtest/playtest.py](../tools/playtest/playtest.py)
- [tools/playtest/prepare_air_check.py](../tools/playtest/prepare_air_check.py)
- [tools/playtest/summarize_air.py](../tools/playtest/summarize_air.py)
- [tools/playtest/widgets/air_fixture.lua](../tools/playtest/widgets/air_fixture.lua)
- [tools/playtest/widgets/air_watch.lua](../tools/playtest/widgets/air_watch.lua)
- [tools/run_native_tests.sh](../tools/run_native_tests.sh)

## D-148 — AIR targets fusion by twenty minutes after every owned mex upgrade

**Date:** 2026-09-30. **Status:** Played: Armada/Cortex meet the target;
Legion finishes 2.5 seconds late after three T2-constructor losses. All three
finish every owned mex upgrade before starting fusion.

**Decision.** The owner's target is a completed first fusion by 20 minutes,
with all owned mexes upgraded before construction begins. The priority is
absolute; the time is an aim, not permission to skip distant, unsafe, gifted,
unfinished or currently reclaiming extractors. Existing reactor frames finish
if a new basic mex arrives afterwards. This supersedes D-147's late reactor
benchmark and the proposed partial-upgrade reactor lane in KI-436.

AIR starts preparation twelve minutes before the target. A separate forecast
buys T2 access when no advanced constructor exists; it no longer waits to fund
the plant, constructor, mexes and support simultaneously. Initial own expansion
is bounded at six mexes and stops during preparation. This prevents creating
new upgrade obligations faster than they can finish. Gifted mexes still count.
The ordinary late-production funding gate is unchanged. T1 assistants and two
T2 builders work on upgrades; optional aircraft pause after the interception
floor. The existing transport-first dispatch remains first.

The access forecast covers 300 seconds at +12 metal/+450 energy. In intermediate
games the 600-energy floor delayed a funded plant with a full bank; fusion
finished 20:50 for Armada and 21:39 for Cortex. The second T2 constructor now
precedes the full T2 fighter quota: previously it arrived at 20:50, too late to
finish the mex obligations. Recovery and cost forecasts remain mandatory.

**Mechanism.** The sole native addition exposes the existing extraction rate
as `GetExtractsMetal`. AIR compares live owned extractor rates with loaded
advanced definitions, avoiding a three-name list that misses cloaked/armed or
underwater variants. Every reactor admission reads current owned units and
pending MEX/MEXUP orders, covering the reclaim-to-frame gap. Upgrade selection
uses actual ownership and per-spot claims without the old 3,500-elmo radius.
AirBuild cancels invalid unstarted reactor orders and blocks their resumption.

**Rejected.** A timer that forces fusion while upgrades remain, a reactor lane
after only initial upgrades, treating queued/unfinished upgrades as complete,
or changing TECH's economy/controller. The target cannot be guaranteed after
combat losses, inaccessible owned mexes or insufficient income.

**Invariant.** INV-077: no AIR reactor is admitted with pending owned mex work.
The independent playtest observer also checks actual reactor-frame creation.
Pure tests cover basic/advanced extraction, queued and unfinished work, and
the fact that passing the target time never overrides the mex gate.
The playtest judge must not accept events whose recorded frame exceeds their
deadline, even when a buffered log read crosses it. Its previous batch-level
check incorrectly accepted Legion's 20:02.5 completion; event-time checks and
six regression tests fix that measurement error without changing gameplay.

**Verification.** Native build `6a963dd33d8a9b1d` succeeded; 38 executable
AngelScript policy tests and six Python watcher regressions passed. Final
natural first fusions: Armada 18:41, Cortex 19:16, Legion 20:02.5. All six owned
mexes were upgraded in each case; no script/crash/invariant errors. The
intermediate gift test completed at 19:09. Legion retains a deadline failure,
recorded in KI-436; the mex gate is never bypassed. Simulation evidence is in
[AIR benchmarks](benchmarks/air-management.md). TECH policy/config remains
unchanged. An initial host compile rejected a mutable definition argument;
the read-only helper now accepts `const CCircuitDef@` and is rechecked in game.

**Files.** [settings](../data/script/src/global.as),
[pure policy](../data/script/src/helpers/production_math.as),
[economy](../data/script/src/manager/air_economy.as),
[production](../data/script/src/manager/air_production.as),
[actions](../data/script/src/roles/air_build.as),
[rules](../data/script/src/roles/air_rules.as),
[binding](../src/circuit/script/InitScript.cpp),
[tests](../tests/production_math_tests.as),
[transition checks](../tools/playtest/checks/air/economy/air_transition.json),
[gift checks](../tools/playtest/checks/air/economy/air_fusion_gift.json),
[fixture preparation](../tools/playtest/prepare_air_check.py),
[fixture](../tools/playtest/widgets/air_fixture.lua),
[observer](../tools/playtest/widgets/air_watch.lua),
[playtest judge](../tools/playtest/playtest.py),
[deadline tests](../tools/playtest/test_playtest_deadlines.py),
[AIR management](air-management.md), [AIR role](roles/air.md),
[action reference](roles/air_build.md), [rule reference](roles/air_rules.md),
[API](angelscript-references.md), [invariants](invariants.md),
[actors](actor-matrix.md), [issues](known-issues.md),
[benchmarks](benchmarks/air-management.md), [decision record](decisions.md).

## D-149 — AIR packs six-wind groups and scales construction from income

**Date:** 2026-09-30. **Status:** Played: compact groups, lost-slot replacement,
earlier turret growth and funded mobile scaling. Exact reactor deadlines still
fail in some contested runs; every owned mex must finish first.

**Decision.** Follow the owner's six-wind request with atomically reserved
3-by-2 groups of touching loaded footprints and a 144-elmo gap between group
bounding circles. Fill holes before opening another group. Native slots own
claims, frames and destruction; `air.wind.*` metadata supports adoption. Use
existing reservation primitives and pure grid arithmetic rather than introducing
a second native placement engine or altering TECH's turret box.

TECH's useful construction principle is eight work/second per metal/second,
with 1.5 times the target while metal floats. AIR applies it to independent
mobile work and production-bay support. Loaded work rates determine constructor
counts; post-T2 shares are 40% T1 and 60% T2, capped at ten/eight. T1 stays useful
for winds and ordinary nanos. Bay support takes the larger of funded aircraft
throughput and an income-based floor, preserving the five/twenty turret bounds.
Funding, recovery and queue accounting still gate actual recruitment/building.

Finish pending nanos and grow support before general fusion-preparation
assistance. Reuse one target selector for mobile builders and idle production
turrets, with actual reach for immobile units. Static repair has no timeout;
the AIR tick aborts economy assistance when the owning plant has a unit frame,
returning its turrets to production. This avoids capturing production support
for an entire long construction project. The existing allied-transport prehook
still runs before AIR recruitment. Immediate fighter coverage precedes funded
workforce growth; the full interception quota follows it.

**Rejected.** Per-wind 96-elmo scattering, one contiguous field without raid
separation, copying TECH's layout, counting factory-bound nanos as mobile work,
fixed constructor thresholds independent of faction work rate, or relaxing the
all-owned-mex gate to meet the fusion clock. TECH policy/settings, JSON, native
code and samples remain unchanged. Legacy AIR remains the explicit old path
(KI-437), not a second copy of this controller.

**Invariant.** INV-078 requires every new AIR wind construction order to belong
to a reserved six-slot cluster. The observer independently checks actual grid
positions and group gaps. INV-076 retains sole ownership of nano construction;
INV-077 still blocks reactors until every owned mex upgrade is complete.

**Corrections found while playing.** The first INV-078 implementation read a
served slot before task assignment; required pins are served later, so the
checker must inspect the planned position first. A Legion replay then showed
repair tasks carry the wind target's definition but no placement slot: only
ENERGY construction belongs in that invariant. Neither correction changes
placement. The reactor observer also misclassified fixture-spawned AFUS as AI
construction; BAR forwards the engine's builder ID, allowing provenance-aware
checks while logging spawns separately. Natural scorecards now require an
observed reactor frame with zero pending mexes. Turret assertions are scoped
to the independent team-0 observer, not another AI's bay log. Failed reports
remain in the [evidence](air-wind-and-build-power.md).

**Verification.** The native ranking, geometry and lane suites and 46 executable
AngelScript policy tests pass. API parity checks 239 used members. Natural
Armada reaches fusion at 18:09.7 and doubles the prior turret count at ten and
twenty minutes. Cortex rebuilds an induced wind loss in the same slot but
finishes fusion at 20:45.2 after three early constructor losses; KI-436 retains
that performance limitation. A supplied-income Legion game reaches ten T1,
eight T2 constructors and twenty turrets by 11:20. It supplies economy and two
advanced constructors and is not evidence of natural late-game income.
Final code completes Legion fusion at 19:10.1; Armada misses at 21:46.5 after
losing its first T2 plant and nine constructors. The final capacity replay has
ten/eight constructors and twenty-three turrets at twelve minutes. Actual nano
construction and return-to-production events are observed. No final run has a
script, crash, invariant or observer error; the timing failure remains explicit.
The [evidence](air-wind-and-build-power.md) records final replays, combat and
stall measurements, diagnostic failures and verification limits. Complete
save/load remains KI-209; no repeated PvP win-rate claim is made.

**Files.** [settings](../data/script/src/global.as),
[pure arithmetic](../data/script/src/helpers/production_math.as),
[layout](../data/script/src/manager/air_layout.as),
[economy](../data/script/src/manager/air_economy.as),
[production](../data/script/src/manager/air_production.as),
[actions](../data/script/src/roles/air_build.as),
[rules](../data/script/src/roles/air_rules.as),
[tests](../tests/production_math_tests.as),
[fixture preparation](../tools/playtest/prepare_air_check.py),
[fixture](../tools/playtest/widgets/air_fixture.lua),
[observer](../tools/playtest/widgets/air_watch.lua),
[cluster checks](../tools/playtest/checks/air/layout/air_clusters.json),
[loss checks](../tools/playtest/checks/air/economy/air_wind_loss.json),
[workforce checks](../tools/playtest/checks/air/economy/air_build_power.json),
[plan and evidence](air-wind-and-build-power.md),
[AIR management](air-management.md), [role settings](roles/air.md),
[action reference](roles/air_build.md), [rule reference](roles/air_rules.md),
[invariants](invariants.md), [actors](actor-matrix.md),
[issues](known-issues.md), [benchmarks](benchmarks/air-management.md),
[decisions](decisions.md).

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

## D-150 — AIR uses commander factory assistance and a growing fighter screen

**Partly superseded by D-151.** The fixed initial-fighter income gate and
strictly local post-crew fallback left a commander guarding an empty factory
in the owner's game. D-151 corrects both; the original decision/evidence remains.

**Decision.** Implement the owner's scout → three completed air constructors
→ fighter opening. Once the first air factory exists, the commander finishes
and guards it, using local energy recovery only when necessary. Flying builders
own remote mex work. Later commander work remains local or assists the factory.
Wind placement tries local holes and a complete local six-slot group before
walking; remote fallback is permitted only before a constructor completes.

The fighter screen starts near the closest allied TECH start (own start when
none is known), widens and advances with live strength, and retracts after
losses. All T1 fighters screen; T2 reserves use income/threat quotas and remain
exclusive with bomber escorts. Each fighter owns a route, distributed across
at most eight patrol cells. Native `SetPatrol` is opt-in and defaults off, so
existing TECH routes retain their behavior. Legion's opening Noctua receives a
scouting route because the shared roster identifies it as the fighter/scout
but its native classification is anti-air, not SCOUT.

**Reasoning / alternative rejected.** Keeping the commander on generic economy
rules permits distant repair and mex work despite fast flying builders. Moving
all fighters together forms a blob instead of a screen. Sharing native patrol
execution avoids another fighter task implementation; script retains every
count, anchor, geometry and timing decision. Initial scout completion is
latched; a scout loss must not continuously reset recruitment. Transport
requests stay above this opening through the existing shared ferry prehook.

**Invariant.** INV-079 forbids new commander mex orders once an air plant exists
and observes scout/crew/fighter completion order. INV-080 keeps screen endpoints
inside the map. INV-072 still excludes simultaneous home and wave membership;
INV-077 still requires all owned mex upgrades before reactor construction.

**Files and verification.** The [design and evidence](air-opening-and-screen.md)
lists implementation files, checks and played results. No TECH policy, JSON
profile, sample tree or unit classification is changed. All 62 arithmetic tests
and native suites pass. Final 25-minute natural Armada/Cortex/Legion games pass
the opening and screen checks with no gameplay invariant failure. Fusion is
20:23.4 / 20:06.7 / 20:22.6, so the exact deadline still fails (KI-436).
The controlled mixed-team fixtures prove screen growth/contraction and
transport delivery but fail TECH invariants: gift provenance in the initial
run (KI-435), and unfinished turret count in the final run (INV-019, KI-427).
Neither is labelled a passing combined test. Recalibrating
reactor timing or changing TECH's diagnostic is deliberately deferred; neither
check was weakened. Commit remains local under the owner's explicit instruction.

## D-151 — AIR leaves idle factories and immediately recruits its first screen

**Decision.** The initial fighter floor follows three completed air constructors
without the normal production income gate. Pending recruitment still prevents
duplicate orders; other defenders count toward the floor, while Legion's
opening scout does not. Transports retain their shared priority prehook.

After the crew, a commander guards only a plant with actual work: an unfinished
plant or a live recruit task, including its pre-frame delay. Local work remains
preferred; an idle factory permits an economy search up to 900 elmos. Assist
the nearest unfinished reachable structure rather than chase an air constructor.
If neither assistance nor energy construction is possible, wait briefly.

**Reasoning / rejected alternative.** The owner's log shows 130 energy income
and over 1,150 stored energy, yet the hard 160-income gate refused fighters.
Removing all production gates would overspend later; only the initial defensive
floor bypasses them, at NORMAL priority below emergency energy construction.
The D-150 local-only fallback repeatedly re-selected an empty factory. Unlimited
commander travel is unnecessary; bounded movement retains the walking-cost
preference while using otherwise idle build power. TECH and native code stay
unchanged. The guard timeout expires, but builder wait preserves the previous
engine command. D-151 therefore explicitly stops that stale guard when no
economy task can be selected; the independent observer caught this during play.

**Invariant.** INV-081 forbids renewing post-crew commander guard on an idle
plant; the game observer checks actual commands after ten idle seconds.
INV-082 requires initial fighter admission, with the observer checking the
first frame within five seconds of crew completion unless a transport intervenes.
INV-077/078/079 retain mex-before-reactor, six-wind placement and no commander
mex orders after a plant exists.

**Files and verification.** [Plan and played evidence](air-idle-factory.md)
tracks the implementation and test results. All 67 pure policy tests pass.
Final 12-minute natural Armada, Cortex and Legion runs pass all opening checks:
first fighter frames arrive 1.07, 1.50 and 1.27 seconds after the third
constructor. The forced-idle fixture passes with actual commander economy
assistance during the pause. No script errors, crashes or invariant violations
occur in these final runs. The initial stale-engine-guard failure is retained
in the evidence. TECH, native code and profile JSON are unchanged; the existing
fusion benchmark limitation is not re-measured by these opening tests.

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


## D-152 � Reserve expansion before fortification; AIR mex-first access and first-mex delivery

**Superseded in part by D-153.** The all-mex T2 lab gate below is historical.
Labs now use sustained income or a full-cost metal bank; the fusion mex gate
remains. See [D-153 validation](allied-layout-air-income-results.md).

**Decision.** Implement the owner's [design](air-tech-expansion-plan.md):
[AIR economy](../data/script/src/manager/air_economy.as),
[AIR layout](../data/script/src/manager/air_layout.as),
[AIR build](../data/script/src/roles/air_build.as) and
[dispatch](../data/script/src/roles/air_rules.as) gate all T2 plants on actual
mex completion and scale T1 conversion without an income ceiling. Hold six
complete T2 turret banks plus two T1 sites; count only real factories as
production capacity. Strict upgrading implies reliance on allied T2 access;
a solo self-tech exception was rejected because it contradicts the request.

Reuse [TECH's factory planner](../data/script/src/roles/tech_factories.as),
with a distinct future state, ahead of
[fortification](../data/script/src/roles/tech_fortifications.as). Existing
spending rules activate future clusters. `defence.fortify` and early defense
share the new action; [weapon clusters](../data/script/src/roles/tech_weapons.as)
order walls first and pin their sites. Reserve exits too; closed asset rings
were rejected because they trap builders and obstruct upgrades.

[Allied roster](../data/script/src/manager/roster.as) appends the first completed
mex anchor compatibly. [Ferry policy](../data/script/src/manager/ferry.as)
uses [native free-ground search](../src/circuit/terrain/TerrainManager.cpp)
with script-selected threat limits; [ferry task](../src/circuit/task/fighter/FerryTask.cpp)
revalidates at landing. A no-safe-site result retains ownership for retry.
The anchor stays latched through mex loss and upgrades. This applies to
controlled AI peers; the protocol cannot report human construction.

**Invariant.** INV-083 forbids premature AIR T2 plant orders; INV-084 requires
complete twenty-turret speculative banks; INV-085 forbids fortification in
friendly lanes; INV-086 forbids a ferry destination over its threat limits.
The [actor matrix](actor-matrix.md) names every new actor.

**Status.** Built, Checked, Played with limits. [Measured results](air-tech-expansion-results.md)
retain every failed and successful scenario. 78 executable pure policy tests,
native geometry/ranking checks, API parity, role docs and invariant-practice
checks pass. Mixed TECH reports still fail global invariants (KI-427); fusion
misses twenty minutes in the measured natural sample (KI-436). Lifecycle and
contested-landing coverage is incomplete (KI-439).

D-152 additional invariant: INV-087 distinguishes a future reservation from an active construction project. Role re-entry discards invalid future IDs and resets fortification caches before adopting native saved claims.

**Further decisions.** A future reservation requires both the caller's
`planNew` authorization and `MayPlan`; treating it as an already-funded project
was rejected. Idle TECH air builders share the finite fortification/weapon
plans instead of keeping the old scattering fallback. Resource protection can
start with T2 access even before a base turret stands. Empty geo perimeters
retry at wider radii rather than being marked protected forever. A ferry landing
checks the cargo movement class at the destination, not connectivity from the
origin; walking off its factory pad retains a separate same-area check.
The engine's 256-elmo area unload remains (D-110); nearest sampled safe ground
is not an exact-coordinate landing guarantee.

**Supporting files.** Configuration and shared arithmetic:
[settings](../data/script/src/global.as), [weapons profile](../data/config/weapons.json),
[layout offsets](../data/script/src/helpers/layout_helpers.as),
[production math](../data/script/src/helpers/production_math.as),
[unit cases](../tests/production_math_tests.as).
TECH wiring: [role](../data/script/src/roles/tech.as),
[actions](../data/script/src/roles/tech_build.as), [rules](../data/script/src/roles/tech_rules.as),
[forward filters](../data/script/src/roles/tech_forward.as),
[invariant actor](../data/script/src/manager/invariants.as), [promises](invariants.md).
Native contract: [terrain header](../src/circuit/terrain/TerrainManager.h),
[ferry header](../src/circuit/task/fighter/FerryTask.h),
[registration](../src/circuit/script/InitScript.cpp), [API reference](angelscript-references.md),
[protocol](transport-ferry.md).
Regression tooling: [expansion checks](../tools/playtest/checks/shared/economy/expansion.json),
[wall checks](../tools/playtest/checks/shared/layout/fortification.json),
[observer](../tools/playtest/widgets/expansion_watch.lua),
[controlled assets](../tools/playtest/widgets/fortification_fixture.lua).
Reviewed role references: [AIR](roles/air.md), [actions](roles/air_build.md),
[sequence](roles/air_rules.md), [TECH](roles/tech.md), [build](roles/tech_build.md),
[factories](roles/tech_factories.md), [forward](roles/tech_forward.md),
[fortification](roles/tech_fortifications.md), [rules](roles/tech_rules.md),
[weapons](roles/tech_weapons.md). [Generated roster/config report](knowledge/barb-unit-config.md)
and [known issues](known-issues.md) updated.

D-152 delivery-race correction: the final natural regression exposed a gift
created before TECH's +20-income transport request. `TryCarry` formerly
returned false, giving it at base 2,219 elmos from AIR's first mex. With an
allied AIR provider, it now requests and queues the constructor until the
carrier/task exists. Existing `ferry.cargo` owns that wait; `AwaitTransportSeconds`
(120) bounds failure to obtain a carrier. No-provider and expired-arrival cases
retain walking fallback. The expansion observer explicitly expects team 0's
handover within 999 elmos in this Supreme scenario; INV-086 still checks the
chosen safe point. Actual queued and delivered positions are recorded in the
final evidence, rather than accepting a log of the chosen target alone.

Final verification: the 45-minute supplied-economy capacity game passes with
eight completed T2 plants, full twenty-nano support banks and a bomber wave.
The final natural game physically delivers both queued gifts near their first
mexes (182/216 elmos) and starts its T2 air plant only after all six upgrades.
Its fusion is still pending at 25 minutes; no 20-minute success is claimed.
The [results](air-tech-expansion-results.md) retain strict overall TECH invariant
failures and unplayed lifecycle limits. The matching DLL, symbols and complete
current data tree are published to the mandatory engine build output; no live
BAR installation is written and the commit stays local as requested.


## D-153 — Allied reservations and income-gated AIR labs

**Decision.** Implement the [recorded plan](allied-layout-air-income-plan.md).
Use one spatial rectangle index in native `CAllyTeam` for all allied slot/zone
owners. Sharing geometry rather than copying role policy avoids a second
reservation ledger over messages. All admissions, ordinary site searches and
build-command retries honor foreign footprints. Full owner cluster envelopes
exclude unrelated defenses, including holes vacated by old structures.
Same-owner overlap is legal for nested slots and zones and releases independently.

AIR and TECH recheck untouched clusters before their first order, release only
that plan if physically blocked, and search again. A native claim/frame or
persisted start locks the cluster. AIR retries reuse the same saved bay key;
a failed relocation does not count as a still-held speculative bay. The Armada
obstruction run exhausted the old 17-ring search, so AIR now exposes
`BaySearchRings=25` (128-elmo steps). The longer search still rejects every
foreign footprint and map-boundary violation. TECH plans
two future clusters per tier without purchasing them or changing its spending
sequence. Its partial economy boxes keep initial terrain holes; treating those
holes as new obstructions was rejected after the first regression. Failed
forward searches now advance their bounded persisted attempt count (KI-423).

Replace only AIR's lab gate: minimum income over a complete fresh ten-second
window >=50 metal/s OR current bank >= loaded lab metal cost. Full-bank orders
precede mex upgrading and bypass existing support/capacity waits, as explicitly
requested. One unfinished plant and the configured cap still apply. Reactors
retain mex completion. Keep transport requests, scout/three-constructor opening,
initial fighters and funded build-power growth ahead of optional strikes.
T1 strikes replenish toward bounded income-scaled targets; Cortex uses Shurikens.
A low-income T2 purchase does not shut the T1 plant off. Energy recovery still
protects the economy; first-fusion preparation alone no longer pauses strikes.

**Invariant.** INV-083 now checks income/full-bank lab admission, superseding its
D-152 mex promise. INV-088 rejects cross-owner reservations and checks pinned
building orders. INV-084 retains complete twenty-slot speculative AIR banks;
INV-087 keeps speculative TECH plans out of active project accounting. The
[actor matrix](actor-matrix.md) and [register](invariants.md) describe ownership.

**Status.** Built, Checked, Played with limits. The [measured results](allied-layout-air-income-results.md)
retain failed iterations and final runs. Native geometry/ranking, eleven shared
index cases and 93 executable AngelScript policy cases pass. Actual games prove
reciprocal exclusion, forced relocation, active-cluster stability, both funding
paths, continued T1 fighters/bombers/Shurikens and constructor production.
Mixed games retain TECH invariant failures (KI-427); the natural fusion still
misses twenty minutes (KI-436). Shared save/load and runtime-role lifecycle
coverage remain incomplete (KI-439). Do not infer a clean PvP benchmark.

**Files.** Shared native mechanism:
[index](../src/circuit/terrain/AlliedReservations.h),
[ally ownership](../src/circuit/unit/ally/AllyTeam.h),
[terrain implementation](../src/circuit/terrain/TerrainManager.cpp),
[terrain contract](../src/circuit/terrain/TerrainManager.h),
[bindings](../src/circuit/script/InitScript.cpp),
[build retries](../src/circuit/task/builder/BuilderTask.cpp),
[mex](../src/circuit/task/builder/MexTask.cpp),
[mex upgrades](../src/circuit/task/builder/MexUpTask.cpp),
[geo](../src/circuit/task/builder/GeoTask.cpp).

Script policy:
[settings](../data/script/src/global.as),
[layout helpers](../data/script/src/helpers/layout_helpers.as),
[production math](../data/script/src/helpers/production_math.as),
[income window](../data/script/src/manager/economy.as),
[AIR economy](../data/script/src/manager/air_economy.as),
[AIR layout](../data/script/src/manager/air_layout.as),
[AIR production](../data/script/src/manager/air_production.as),
[AIR actions](../data/script/src/roles/air_build.as),
[AIR sequence](../data/script/src/roles/air_rules.as),
[TECH economy layout](../data/script/src/manager/layout.as),
[TECH factory plans](../data/script/src/roles/tech_factories.as).

Tests and tooling:
[native cases](../tests/allied_reservations_test.cpp),
[test target](../tests/CMakeLists.txt),
[policy cases](../tests/production_math_tests.as),
[probe](../tools/playtest/allied_layout_probe.as),
[probe preparer](../tools/playtest/prepare_allied_layout_check.py),
[blocker widget](../tools/playtest/widgets/allied_layout_fixture.lua),
[bank fixture](../tools/playtest/widgets/air_income_fixture.lua),
[income fixture](../tools/playtest/widgets/air_sustained_fixture.lua),
[layout checks](../tools/playtest/checks/shared/layout/allied_layout.json),
[bank checks](../tools/playtest/checks/air/economy/air_income.json),
[income checks](../tools/playtest/checks/air/economy/air_sustained.json),
[expansion observer](../tools/playtest/widgets/expansion_watch.lua),
[run instructions](../tools/playtest/README.md).

Reviewed references:
[AIR](roles/air.md), [AIR actions](roles/air_build.md),
[AIR sequence](roles/air_rules.md), [TECH factories](roles/tech_factories.md),
[AIR management](air-management.md), [native layout](base-layout.md),
[API](angelscript-references.md), [known issues](known-issues.md).

## D-154 - AIR and TECH walls leave allied start areas open

**Later requirement:** D-155 supersedes the bank-funded bypass of expansion
support; the first-lab income/full-bank rule remains. See
[support admission](air-support-before-expansion.md).

**Decision.** Use one shared script wall policy, with a configurable 1,200-elmo
base exclusion around the union of known allied starts. Test full footprints,
not just centres, at candidate selection and after native snapping. Advance
TECH lane walls beyond the exclusion, keep forward resource perimeters, and
omit wall rings around rear-base assets. AIR's queued-defense admission uses
the same helper. Late start announcements release invalid unstarted TECH wall
claims; existing frames are preserved. No native change or role build-order
change is needed.

**Why.** The owner wants walls nearer the front, keeping the slow commander's
base and economic/factory expansion open. The old 752/800-elmo lane anchors
were inside the base area. This explicitly supersedes D-152's requirement to
wall every geo and advanced mex. The radius matches the existing front-factory
base-radius default but is independently configurable. Rejected: disabling all
walls (loses forward protection), checking only this AI's start (still clutters
allies), centre-only tests (allow footprint intrusion), and hardcoded native
role policy. Ordinary guns and AA keep their existing placement rules.

**Invariant.** INV-089: AIR and TECH wall construction footprints stay outside
every known allied start's base exclusion. The shared placement audit checks
assigned building tasks once per second, and both controlled checks retain the
global invariant forbid. The new fixture also audits actual wall creation.

**Verification.** Ten geometry cases and the full required native/AS suite
pass. Four-AI games compiled the scripts and verified rear-base exclusion plus
forward geo/mex walls; see the exact run manifests and limitations in the
[design and results](wall-base-exclusion.md). Those games remain strict FAIL
because other TECH invariants fired; no INV-089 or script error occurred.
Save/reload migration and unknown human starts are not claimed verified.

The requested nuke investigation used an unchanged control with
`RushObjective="nuke"`: silo at 18:15, positive stockpile but no target or launch
by 25.1 minutes. `auto` still selects `afus`. Do not silently enable a nuke rush
or change targeting while answering this question: the shared-super dispatch
bypass is documented in KI-418, and the 16:30 timing miss in KI-441.

Files: [shared settings](../data/script/src/global.as),
[JSON radius](../data/config/weapons.json),
[geometry](../data/script/src/helpers/placement_math.as),
[wall policy](../data/script/src/helpers/wall_helpers.as),
[placement audit](../data/script/src/helpers/layout_helpers.as),
[AIR services](../data/script/src/roles/air_rules.as),
[fortifications](../data/script/src/roles/tech_fortifications.as),
[weapon clusters](../data/script/src/roles/tech_weapons.as),
[unit cases](../tests/placement_math_tests.as),
[CTest registration](../tests/CMakeLists.txt),
[test runner](../tools/run_native_tests.sh),
[wall fixture](../tools/playtest/widgets/wall_exclusion_fixture.lua),
[wall checks](../tools/playtest/checks/shared/layout/wall_exclusion.json),
[forward fixture](../tools/playtest/widgets/fortification_fixture.lua),
[forward checks](../tools/playtest/checks/shared/layout/fortification.json),
[playtest reference](../tools/playtest/README.md),
[AIR rule reference](roles/air_rules.md),
[fortification reference](roles/tech_fortifications.md),
[weapon reference](roles/tech_weapons.md),
[actor matrix](actor-matrix.md), [invariants](invariants.md),
[known issues](known-issues.md), and regenerated
[unit configuration report](knowledge/barb-unit-config.md).

## D-155 - AIR completes twenty support turrets per T2 lab before expansion

**Decision.** Additional T2 air labs require every existing T2 lab to be
finished and supported by twenty completed, owned, in-range turrets. A turret
belongs to one nearest live bay. Queued/framed turrets are future capacity,
not admission credit. Recheck gifts, losses and completion on new/resumed
orders and cancel invalid unstarted orders; retain actual frames. New T2
reservations require all twenty slots. The first lab retains D-153's
income/full-bank test; the bank exception no longer bypasses expansion support.

Floating metal raises construction demand by a sixty-second drawdown toward
half storage. Factory production speed cannot offset economy construction
power. When expansion is affordable, existing T2 banks target twenty. Up to
three funded turret projects precede converters during overflow, followed by
assistance; energy recovery and mex upgrades still lead. Funded constructor
growth during overflow does not subtract the full remaining cost of every
large project from a short recruitment forecast. TECH policy is unchanged.

**Why.** The owner explicitly requires twenty completed turrets before the
next T2 lab. The control run built four labs with just two turrets on the first
and none on the others. Full-bank admission bypassed support, unfinished
support counted toward a low dynamic target, and construction growth could
be blocked by whole-project cost accounting. Rejected: crediting queued
support, averaging turrets across labs, bypassing support with stored metal,
unbounded construction concurrency, or increasing TECH's spending targets.
The exact twenty threshold is owner policy; the game meta supports assisting
factories before duplicating them, not a universal twenty-turret optimum.

The test launcher also resolves relative write directories before launching
and matching processes: its engine working directory differs from the caller.
An initial relative-path invocation could not start the intended test; the
corrected launch uses the explicit workspace directory. This resolves KI-438,
verified by launch/targeted-stop boundary probes and live engine lookup. No game-install
configuration is changed.

**Invariant.** INV-090: an additional AIR T2 lab is ordered only after every
existing T2 lab is finished and has twenty completed uniquely assigned support
turrets. Record audits admission; an independent engine observer checks actual
new frames. Both capacity and support checks forbid all invariant violations.

**Verification.** The native suite passes: 76 ranking checks, geometry tests,
eight lane suites, 109 production-policy cases and ten placement-policy cases.
The host compiler caught a const-handle mismatch; corrected before the final
runs. The donated-constructor game finishes fusion at 18:33.7, its second lab
starts with twenty completed turrets, and no script/invariant errors occur.
The strict 14-minute first-lab deadline still fails (KI-436). The capacity
game reaches ten labs and launches a wave, with every observed expansion
properly supported. Its strict run times out at 44.5 of 45 game minutes; all
gameplay expectations and support event checks are met with no script or
invariant errors. Exact manifests and limits are recorded in the
[plan and evidence](air-support-before-expansion.md).
Metal still overflows in the later unboosted economy (KI-442); increased build
power is verified, elimination of overflow is not. Save/load and a full
cross-faction/map matrix were not played for this change.

Files: [settings](../data/script/src/global.as),
[pure policy](../data/script/src/helpers/production_math.as),
[economy](../data/script/src/manager/air_economy.as),
[building actions](../data/script/src/roles/air_build.as),
[ordered rules](../data/script/src/roles/air_rules.as),
[unit tests](../tests/production_math_tests.as),
[observer](../tools/playtest/widgets/air_watch.lua),
[support check](../tools/playtest/checks/air/layout/air_support.json),
[launcher](../tools/playtest/playtest.py),
[playtest guide](../tools/playtest/README.md),
[AIR role](roles/air.md), [building reference](roles/air_build.md),
[rule reference](roles/air_rules.md), [management reference](air-management.md),
[actor matrix](actor-matrix.md), [invariants](invariants.md),
[known issues](known-issues.md), and [plan/results](air-support-before-expansion.md).


## D-156 - AIR keeps its economy local and defends allied airspace with fighters

**Decision.** Apply the pre-written [design](air-local-economy-plan.md) to the
experimental AIR controller. Constructor targets use 24 work/metal, caps 40/24,
and a short recruitment forecast rather than charging a whole unfinished
reactor to the next constructor. Interleave a fighter after two constructor
orders. Permit six funded energy projects and cap incremental assistance by
remaining work. Keep factory support separate, including the strict twenty
completed turrets per existing T2 lab. Constrain new mex expansion to the start
area; keep one worker available for previously owned distant mex upgrades.

The owner explicitly replaces distributed static AA with fighter response.
AIR opts out of shared porc/queued defense and owns bounded base flak, long-range
AA and anti-nuke orders. The anti-nuke keeps its own core covered and chooses the
closest feasible position toward the nearest allied start, using actual loaded
interceptor coverage. Fresh known radar/LOS aircraft snapshots are native
mechanism; territory, threat grouping and dispatch remain script policy.
TECH files and spending behavior are deliberately unchanged. Existing TECH
invariant failures observed in the mixed fixture remain strict whole-game
failures, recorded under KI-427 rather than hidden by an AIR-only verdict.

Optional strikes compare completed available fighter value against known enemy
air (1.25 times), counting home fighters and waiting wave escorts, not escorts
already committed to an attack. The fixed enemy-air cutoff rejected a Cortex
strike despite a superior fighter reserve. Base-defense caps sum all faction
variants: a donated foreign constructor must not bypass the single anti-nuke
limit. Both cases were exposed and corrected in the mixed defense fixtures.

**Alternatives rejected.** Raising constructor caps alone leaves serialized
construction and distributed defense jobs intact. Counting factory turrets as
idle economic work double-counts production capacity. A fixed bomber/gunship
clock ignores air control and resources. Decaying air heat is not a live raid.
Missile travel range is not anti-nuke coverage. Expanding around the current
worker continually moves the home boundary. We keep the all-owned-mex reactor
gate while limiting remote upgrade concurrency; dropping distant owned mexes
from that gate would violate the owner's standing instruction.

**Invariant.** INV-091 bounds AIR static-defense orders to its base; INV-092
bounds new mex expansion to home; INV-093 confines defensive interception targets
to friendly territory; INV-094 retains anti-nuke own-core coverage. INV-077/078/
090 still guard reactor mex completion, six-wind placement and twenty-turret
expansion. The wind audit now resolves framed units through native reservation
identity: Legion's model-midpoint offset made an exact position comparison
incorrect when resuming a damaged wind frame. The independent observer supports
all six possible first-built slots, so parallel building does not invent a
misaligned cluster.

**Verification.** Native build and unit suite pass (76 ranking checks, geometry,
eight lane suites, 128 production and twenty placement cases). The matched
Armada constructor-gift run passes 25 minutes with zero script/invariant lines,
fusion before twenty minutes and all sampled constructors local. The mixed
Armada fixture demonstrates fighter dispatch/damage/return and anti-nuke
completion plus stockpile; its strict report fails TECH invariants and the
since-corrected Legion framed-wind audit. Exact final runs, timings, quantitative
limits and subsequent Cortex checks are in [the results](air-local-economy-plan.md).
Persistent native constructor movement stalls are recorded as KI-443; broad
late overflow remains KI-442. Save/load and a full map matrix are not verified.

Files: [settings](../data/script/src/global.as),
[home geometry](../data/script/src/helpers/air_home.as),
[placement math](../data/script/src/helpers/placement_math.as),
[production math](../data/script/src/helpers/production_math.as),
[economy](../data/script/src/manager/air_economy.as),
[layout](../data/script/src/manager/air_layout.as),
[recruitment](../data/script/src/manager/air_production.as),
[fighter screen](../data/script/src/manager/air_screen.as),
[base defense](../data/script/src/manager/air_defence.as),
[role hooks](../data/script/src/roles/air.as),
[building actions](../data/script/src/roles/air_build.as),
[rules](../data/script/src/roles/air_rules.as),
[native observations](../src/circuit/terrain/BattleAnalysis.cpp),
[native interface](../src/circuit/terrain/BattleAnalysis.h),
[bindings](../src/circuit/script/InitScript.cpp),
[production tests](../tests/production_math_tests.as),
[geometry tests](../tests/placement_math_tests.as),
[fixture preparation](../tools/playtest/prepare_air_check.py),
[fixture](../tools/playtest/widgets/air_fixture.lua),
[observer](../tools/playtest/widgets/air_watch.lua),
[economy checks](../tools/playtest/checks/air/economy/air_local_economy.json),
[defense checks](../tools/playtest/checks/air/combat/air_local_defence.json),
[playtest guide](../tools/playtest/README.md),
[AIR reference](roles/air.md), [actions reference](roles/air_build.md),
[rules reference](roles/air_rules.md), [role index](roles/README.md),
[management](air-management.md), [API reference](angelscript-references.md),
[actor matrix](actor-matrix.md), [invariants](invariants.md),
[known issues](known-issues.md), [plan/results](air-local-economy-plan.md).


## D-157 - Shared sensor priorities, coordinated Junos and per-silo nuclear cooldowns

**Decision.** Follow the owner's explicit order: advanced jammer, jammer,
advanced radar, radar, then other eligible sensors. Read both known-enemy
snapshot pools; non-combat towers were missing from the previous scan. Use
loaded sensor vulnerability/properties plus compatible role extensions and
JSON priorities for every profile. Empty known-target and radar-hole passes
fall back to enemy-facing fog boundaries, without querying hidden enemies.

Ally-team Juno claims cover pending orders and recent confirmed launches.
Observe allied ground commands too, including humans, without controlling
those units. Strategic silos count only immobile structures and keep a
300-second blast-sized location history per physical silo. Different silos
may strike the same place. Histories survive task recreation and allied
transfers; destruction clears nuclear history, while an airborne Juno claim
outlives its launcher. Stop persistent attack orders after a confirmed shot.
Both weapon-fired and stockpile-drop paths share deduplication and accounting.
JSON remains the policy lever. Tactical launchers/EMP keep their selectors.

**Alternatives rejected.** Merely increasing jammer weights cannot recover
targets absent from the candidate pool. An allied/global nuke lock would
violate the explicit per-silo requirement. Recording selection time would
cool down unfired orders; allowing a persistent attack command would bypass
the new history. Blind random map points do not follow the observed fog edge.
The rework option changes Juno effects, but does not supersede the owner's
explicit tower order with scout priority.

**Invariant.** INV-095 checks a confirmed strategic launch against active
Juno claims or that silo's nuclear history. The controlled fixture also audits
mobile-only nuclear withholding, actual launch spacing and separate silo IDs.

**Verification.** See [design and measured results](strategic-targeting-plan.md).
Six focused pure-rule suites cover priorities, mobile rejection, claim release,
overlap, independent silos, multiple remembered areas and the exact expiry
boundary. Save/load persistence and manually changed human orders are not
claimed verified by those tests.

Files: [super task](../src/circuit/task/static/SuperTask.cpp),
[super interface](../src/circuit/task/static/SuperTask.h),
[pure rules](../src/circuit/task/static/StrategicTargeting.h),
[event dispatch](../src/circuit/CircuitAI.cpp),
[policy loading](../src/circuit/module/MilitaryManager.cpp),
[policy settings](../src/circuit/module/MilitaryManager.h),
[ally state](../src/circuit/unit/ally/AllyTeam.h),
[ally lifecycle](../src/circuit/unit/ally/AllyTeam.cpp),
[active profiles](../data/config/),
[unit tests](../tests/strategic_targeting_test.cpp),
[test runner](../tools/run_native_tests.sh),
[fixture preparation](../tools/playtest/prepare_strategic_check.py),
[launch audit](../tools/playtest/audit_strategic_check.py),
[playtest instructions](../tools/playtest/README.md),
[fixture](../tools/playtest/widgets/strategic_fixture.lua),
[Juno checks](../tools/playtest/checks/shared/combat/strategic_juno.json),
[nuclear checks](../tools/playtest/checks/shared/combat/strategic_nuclear.json),
[invariant checker](../tools/knowledge/check_invariants.py),
[Juno reference](juno-targets.md), [actor matrix](actor-matrix.md),
[invariants](invariants.md), [known issues](known-issues.md),
[plan/results](strategic-targeting-plan.md).


## D-158 - Experimental TECH/AIR amphibious waves and secured landfalls

**Decision.** Give owned Telchines and Marauders one shared AngelScript wave
controller, enabled only for experimental TECH/AIR with lanes enabled. Telchines
assemble, cross, regroup on usable dry land and clear local opposition before
advancing. Marauders exploit known economy on the reached landmass first.
Both prefer quiet water approaches and hold/replan if no acceptable route exists.
A timed-out crossing cannot declare a foothold secure. TECH retains these two
unit types instead of splitting their opening wave through combat donation.

Native code supplies reusable point-to-point terrain routes, observed contacts,
underwater weapon coverage and an opt-in hold-position route command. Script
and lanes.json own wave sizes, income gates, target scoring, quorum, dwell time
and allowed threat. The new coverage query gives observed torpedo weapons a
nonzero floor despite zero profile weights; existing threat maps are unchanged.
AIR's aircraft queues and constructor/transport priorities keep their order.
Only already-owned compatible ground factories can supply these waves, behind
economic prerequisites; AIR does not receive a new ground-factory build order.

**Alternatives rejected.** Generic attack groups skip intermediate security;
direct attack orders can chase targets into water. A timeout-only landing admits
stranded units. Tiny dry shoreline samples cannot hold a whole wave, so approach
selection samples a dry square and checks actual surviving-member positions.
Global role or torpedo-profile changes would exceed the requested TECH/AIR scope.

**Invariant.** INV-096 requires a dry, regrouped foothold before onward travel.
The controller's secured latch prevents a stalled crossing from bypassing that
check. Factory production, donations and task lifecycle share the wave ownership
and owned/pending count instead of issuing competing commands. The independent
fixture audit checks actual water entry, distinct unit landfalls, onward progress,
secured waves, combat attribution, guarded approach clearance and role isolation.

**Verification.** See the [plan and measured results](amphibious-operations-plan.md).
The initial plan preceded implementation. Tests cover the pure route and wave
rules; real-engine capability fixtures cover Tundra Continents, Supreme Isthmus
and Serene Caldera, with all three experimental profiles. These are controlled
movement/combat tests with injected units, not competitive win-rate or natural
production benchmarks. Save/load reconstruction and unmodified economic
production remain unplayed; see KI-446. Zero torpedo weights for other native
threat-map users remain separate (KI-447).

Files:

- [data/config/lanes.json](../data/config/lanes.json)
- [data/script/experimental_balanced/main.as](../data/script/experimental_balanced/main.as)
- [data/script/experimental_hard/main.as](../data/script/experimental_hard/main.as)
- [data/script/experimental_terrible/main.as](../data/script/experimental_terrible/main.as)
- [data/script/src/manager/air_production.as](../data/script/src/manager/air_production.as)
- [data/script/src/manager/lanes.as](../data/script/src/manager/lanes.as)
- [data/script/src/manager/military.as](../data/script/src/manager/military.as)
- [data/script/src/roles/air.as](../data/script/src/roles/air.as)
- [data/script/src/roles/tech.as](../data/script/src/roles/tech.as)
- [data/script/src/roles/tech_flank.as](../data/script/src/roles/tech_flank.as)
- [doc/actor-matrix.md](actor-matrix.md)
- [doc/angelscript-references.md](angelscript-references.md)
- [doc/invariants.md](invariants.md)
- [doc/roles/air.md](roles/air.md)
- [doc/roles/tech.md](roles/tech.md)
- [doc/roles/tech_flank.md](roles/tech_flank.md)
- [src/circuit/map/ThreatMap.cpp](../src/circuit/map/ThreatMap.cpp)
- [src/circuit/map/ThreatMap.h](../src/circuit/map/ThreatMap.h)
- [src/circuit/script/InitScript.cpp](../src/circuit/script/InitScript.cpp)
- [src/circuit/task/fighter/RouteTask.cpp](../src/circuit/task/fighter/RouteTask.cpp)
- [src/circuit/task/fighter/RouteTask.h](../src/circuit/task/fighter/RouteTask.h)
- [src/circuit/terrain/BattleAnalysis.cpp](../src/circuit/terrain/BattleAnalysis.cpp)
- [src/circuit/terrain/BattleAnalysis.h](../src/circuit/terrain/BattleAnalysis.h)
- [src/circuit/terrain/BattleLanes.cpp](../src/circuit/terrain/BattleLanes.cpp)
- [src/circuit/terrain/LaneSolver.cpp](../src/circuit/terrain/LaneSolver.cpp)
- [src/circuit/terrain/LaneSolver.h](../src/circuit/terrain/LaneSolver.h)
- [tools/playtest/README.md](../tools/playtest/README.md)
- [tools/run_native_tests.sh](../tools/run_native_tests.sh)
- [data/script/src/helpers/amphibious_math.as](../data/script/src/helpers/amphibious_math.as)
- [data/script/src/manager/amphibious_ops.as](../data/script/src/manager/amphibious_ops.as)
- [doc/amphibious-operations-plan.md](amphibious-operations-plan.md)
- [tests/amphibious_math_tests.as](../tests/amphibious_math_tests.as)
- [tests/terrain_route_test.cpp](../tests/terrain_route_test.cpp)
- [tools/playtest/audit_amphibious_check.py](../tools/playtest/audit_amphibious_check.py)
- [tools/playtest/checks/shared/combat/amphibious.json](../tools/playtest/checks/shared/combat/amphibious.json)
- [tools/playtest/prepare_amphibious_check.py](../tools/playtest/prepare_amphibious_check.py)
- [tools/playtest/widgets/amphibious_fixture.lua](../tools/playtest/widgets/amphibious_fixture.lua)
- [Known issues](known-issues.md).


### D-158 follow-up - Rendered evidence and simulation reporting (2026-10-01)

**Decision.** Honor the owner's standing request for screenshots with ongoing
in-game analysis. Add an opt-in rendered amphibious observer and retain the
headless fixture for automated checks. Capture actual unit positions and landfalls; select nearby units for visibility
but issue no orders. A weapon-hit-trigger prototype missed events in repeats,
so it was removed; combat conclusions use the independent fixture telemetry.
Briefly slow rendering captures to 0.25 game speed and restore the previous
speed. Recoil rejects `setmaxspeed` at or below 0.2, so the initial 0.1 attempt
was ineffective and was corrected. Do not substitute illustrations or route
announcements for gameplay evidence.

**Alternative rejected.** Headless-only success reports and screenshots only
after the run cannot meet the owner's request to inspect behavior as it unfolds.
A new policy change is not justified by screenshot instrumentation alone.

**Verification.** The first rendered Tundra run passed the watcher and independent
audit at 9.4 game minutes: 20/20 distinct landfalls, four secured groups, four
Telchine and twelve Marauder kills, 1,067-elmo minimum underwater clearance from
a live 890-range torpedo tower. Screenshots were shown during the run. One
close-up replay left AIR Marauders unenrolled; retain its failed report and
[KI-448](known-issues.md#ki-448---one-rendered-tundra-repeat-did-not-enroll-air-marauders).
Final camera verification and archive details are in the
[results](amphibious-operations-plan.md). No production behavior changed here.

**Files.** [AGENTS.md](../AGENTS.md),
[playtest guide](../tools/playtest/README.md),
[preparer](../tools/playtest/prepare_amphibious_check.py),
[fixture](../tools/playtest/widgets/amphibious_fixture.lua),
[visual observer](../tools/playtest/widgets/amphibious_visual.lua),
[results](amphibious-operations-plan.md), [known issues](known-issues.md).


### D-159 - Measure natural Telchine timing separately from naval pursuit restraint (2026-10-01)

**Decision.** Run the requested full sixteen-AI Tundra match with ordinary
production/economies, the pinned D-158 DLL and current scripts. Preserve the
existing asymmetric map roster, record it explicitly, and place Legion on both
TECH positions. A read-only observer supplies screenshots and behavioral
updates during the simulation. End competitive metrics at GameOver, not when
the engine later stops: the first persistent coastal hold was post-victory.

**Reasoning.** Landfalls alone do not establish useful combat or strategic
garrison behavior. The natural match completed at 38:37 with seven Telchines,
six distinct landers, two secured stops and zero damage/kills. The +200 metal
gate delayed their first completion until 32:58. Naval-pursuit restraint was
therefore unexercised. Use an explicitly labelled separate controlled encounter:
gift six Telchines, freeze economy/production, leave their orders to the AI,
then retreat an enemy battleship after a verified hit. Spectator godmode grants
only order permission; the fixture orders enemy team 2 and retains read access
to the Telchine queues. No production policy changes are justified solely by
fixing camera/fixture instrumentation; record candidate recruitment and garrison
work as KI-449/KI-450 for scoped implementation and further natural tests.

**Alternatives rejected.** Counting after-victory guards as match impact,
declaring no chase from zero naval encounters, or using supplied units as
natural-production evidence would overstate the result. A nearby cruiser died
before escape, so the final target is tougher and starts at least 520 elmos
from every Telchine. The strict result requires a surviving target beyond
range. Onshore engine-generated ATTACK commands are automatic firing, not
proof of pursuit; the audit checks actual ground height and hold-position state.

**Invariant.** Preserve INV-096's dry regrouping/security requirement and the
global invariant forbid in both new checks. The shore probe additionally
requires 360 dry, hold-position samples, zero submerged naval attack orders
and a live target over 1,000 elmos away. Match audit excludes post-GameOver
frames. No new production invariant is introduced by observer-only tooling.

**Verification.** Natural match archive
`build-theatres/d159-tundra-full/runs/20261001-121509` is FAIL on existing and
newly reproduced TECH invariant categories (65 pre-victory, 121 total), with
no script errors or INV-096. This does not establish every warning's root cause.
Final shore archive `build-theatres/d159-tundra-retreat/runs/20261001-123039`
is PASS: 1,401.1 naval damage, ship alive 1,481 elmos away, 360/360 dry
hold-position samples and no pursuit. Three preliminary probe failures remain
archived and explained. Screenshots were inspected and shown during the runs.
API parity (259 members), Python compilation and invariant-practice checks
pass; eight pre-existing missing-hover-document links remain KI-404.

**Files.** [Analysis and screenshots](tundra-8v8-telchine-analysis.md),
[known issues](known-issues.md),
[playtest guide](../tools/playtest/README.md),
[natural observer](../tools/playtest/widgets/telchine_match_watch.lua),
[GameOver-aware audit](../tools/playtest/audit_telchine_match.py),
[shore preparer](../tools/playtest/prepare_telchine_shore_check.py),
[shore fixture](../tools/playtest/widgets/telchine_shore_fixture.lua),
[match checks](../tools/playtest/checks/shared/combat/telchine_match.json),
[shore checks](../tools/playtest/checks/shared/combat/telchine_shore.json).

### D-160 - Budget Telchines separately and retain shared dry beachheads (2026-10-01)

**Decision.** Add a Telchine admission budget and retained beachhead phase to
the experimental TECH/AIR amphibious controller. Keep ordinary TECH lab
reclaim/rebuild predicates and relative sequencing exact. The owner explicitly
chose the existing cycle over an earlier +80 coastal lab recovery exception,
accepting later units. No ground lab is built for AIR. Marauders keep their
existing gate and raid behavior. Plan written before implementation:
[telchine-beachhead-implementation-plan](telchine-beachhead-implementation-plan.md).

**Reasoning.** The [official unit reference](https://www.beyondallreason.info/unit/legamph)
and local weapon script require dry firing. A secured island is useful as a
staging stop, but moving the entire wave onward leaves valuable allied economy
uncovered. Rank actual completed allied mex/geo/factory assets with observed
naval approaches; keep three dry guards while at least three attackers advance.
Bound groups to two per AI and share sixty-second claims with twenty-second
refresh. Resolve simultaneous claims by team/serial ordering. Loss of asset
value for sixty seconds or a winning allied claim releases the group.

Telchine production uses the existing ten-second income minima, +80 metal,
unit cost plus 300 metal banked, an energy buffer and no stall. Cadence budgets
15% of metal income and 20% of energy income. Values live in lanes.json/script,
not native build orders. Native fallback selection temporarily excludes the
two managed amphibious definitions and restores their caps afterward, so it
can still choose ordinary units without bypassing the shared budget. These
initial shares are not a proven optimal PvP build order. Constructor and ferry
obligations remain ahead of optional combat.

**Alternatives rejected.** Lowering the general TECH +200 gate or rebuilding
its lab early violates the owner's decision. Permanent hold of every wave
would remove assault pressure. Sending guards toward naval unit positions
would submerge units unable to fire. A second movement owner would fight the
route controller: native instead supplies one checked same-manager task
transfer, while script owns member IDs, assignments and priorities. Do not
infer natural combat usefulness from injected encounters or after-victory
landings.

**Corrections from simulation.** Concurrent allied waves could push a landed
wave outside its tight arrival circle and strand it indefinitely in SECURE.
Initial landing still requires the configured quorum within 240 elmos;
subsequent security allows dry dispersal to 360 on the same connected land.
The full eighteen-second dwell and dry landing requirement remain. The final
combined probe waits until all twenty-one attackers clear the three-unit guard
before introducing a naval target. Earlier fixture failures are retained.

The donation consumer accepted naval subs although its producer orders bot
constructors. It now matches the producer's bot roster, preserves dedicated
air constructor claims and gives ferry ownership priority over discretionary
harbour construction. INV-018 now compares a lab with its saved construction
facing rather than requiring it to rotate when the front moves. Real exit
obstructions still fail. Cramped fallback geometry and harbour-specific
support checks are left to KI-451/452, not hidden by relaxed expectations.

**Invariant.** INV-097 requires every retained guard route/unit to remain dry
and every split to leave the minimum assault group. INV-096 retains dry
regroup/security before onward crossing. INV-010 exempts only experimental
Telchines admitted by the separate budget, not ordinary combat or Marauders.
INV-041 still rejects building orders on ferry gifts; INV-018 still checks
saved facing and actual obstruction. Every new check forbids all invariants.

**Verification.** Native/DLL build pin `082783d682ef926e` with matching debug
symbols. Standalone native suites and eighteen amphibious policy tests pass;
API parity checks 265 members. TECH/balanced and AIR/hard independent probes
pass. The final combined terrible-profile probe passes sixteen minutes with
three retained guards, twenty-one onward attackers, two surviving factories,
180 dry hold-position samples and a surviving ship 1,421 elmos away. Its
archive is `build-theatres/d160-allied-beachhead-terrible-03/runs/20261001-134844/`.
The complete run ledger, screenshots, final profile repeats and publication
record are in [results](telchine-beachhead-results.md).

Two natural sixteen-AI runs complete, but strict reports remain FAIL on TECH
invariants. They demonstrate no Telchine damage or kills. The spectator's
extra commander also survives longer than the harness expects, delaying
GameOver after the opposing AI side is eliminated (KI-453). The audit now
records the first all-dead competitive-side census as an upper bound and
warns against treating GameOver as the competitive endpoint. These are
behavior traces, not clean PvP balance evidence. Preserve KI-449/450's natural
verification limits, AIR natural recruitment/save-load KI-446, and all failed
archives. Commit locally; the owner declined pushing.

**Files.** Policy: [amphibious operations](../data/script/src/manager/amphibious_ops.as),
[beach sites/claims](../data/script/src/manager/amphibious_beaches.as),
[pure policy](../data/script/src/helpers/amphibious_math.as),
[settings](../data/config/lanes.json),
[AIR production](../data/script/src/manager/air_production.as),
[TECH](../data/script/src/roles/tech.as),
[donation](../data/script/src/manager/donation.as),
[TECH rules](../data/script/src/roles/tech_rules.as),
[team dispatch](../data/script/src/manager/team.as),
[runtime assertions](../data/script/src/manager/invariants.as).
Mechanisms: [observation source](../src/circuit/terrain/BattleAnalysis.cpp),
[observation declarations](../src/circuit/terrain/BattleAnalysis.h),
[query bindings](../src/circuit/script/InitScript.cpp),
[task transfer](../src/circuit/script/MilitaryScript.cpp).
Tests: [pure cases](../tests/amphibious_math_tests.as),
[shore preparer](../tools/playtest/prepare_telchine_shore_check.py),
[paired match preparer](../tools/playtest/prepare_telchine_match.py),
[fixture](../tools/playtest/widgets/telchine_shore_fixture.lua),
[guard checks](../tools/playtest/checks/shared/combat/telchine_beachhead.json),
[allied checks](../tools/playtest/checks/shared/combat/telchine_allied_beachhead.json),
[match audit](../tools/playtest/audit_telchine_match.py),
[guide](../tools/playtest/README.md),
[seed 1601 audit](telchine-natural-1601.json),
[seed 1602 audit](telchine-natural-1602.json).
Contracts: [API](angelscript-references.md), [invariants](invariants.md),
[actors](actor-matrix.md), [issues](known-issues.md),
[TECH role](roles/tech.md), [AIR role](roles/air.md), [rules reference](roles/tech_rules.md).
Screenshots: [TECH guard](images/d160/tech-guards-after-retreat.png),
[AIR guard](images/d160/air-guards-after-retreat.png),
[natural landing](images/d160/natural-1601-landfall.png),
[allied guard](images/d160/allied-guard-after-retreat.png),
[allied assault](images/d160/allied-assault-final-landfall.png).


### D-161 - Telchine land-first travel and terrain-fitted firing formations

**Decision.** Experimental TECH/AIR Telchines try a strictly dry route first,
then minimize exposed water travel with script-configured cost 6 versus land 1.
Keep Marauder travel, recruitment and TECH's exact lab cycle unchanged. Use
separate dry firing slots: nominal shore spacing 192, land spacing 96, with
terrain-fitted alternatives. The plan was written before implementation in
[telchine-perimeter-plan](telchine-perimeter-plan.md).

**Reasoning.** Telchines cannot fire submerged. A shared guard endpoint caused
clumping, and a majority-passable coarse cell did not establish a usable shore
transition. Reuse the lane solver with optional edge masks, fine loaded
MoveData footprint/slope checks and current allied structure exclusions.
The engine checks ground slope on the seabed too. Script selects formations,
travel costs and objectives; native code supplies routes and per-member
command overrides. Guard claims and island security remain shared owners.

**Alternatives rejected.** Blind lane offsets can place wings in water or on
cliffs. Banning all water prevents island assaults. Changing the general lane
passability rules would affect other roles; the strict query is opt-in.
Changing TECH's lab cycle contradicts the owner's explicit choice. Do not
call controlled encounters PvP win-rate evidence.

**Corrections from testing.** Refresh arrival after assigning late slots;
exclude allied factories from approach routes and search nearby dry ground
when the strategic anchor is occupied. Individual formation arrival is 128
elmos in script and native, accounting for observed idle centres 97-106 elmos
from requested positions. Initial landing quorum and dry-component security
remain exact. Exact-route idle retries are deferred and rate-limited rather
than synchronous or silently discarded. Preserve all failed runs.

**Invariant.** INV-098 requires distinct, dry firing positions and dry
formation connectors. INV-096 still requires a regrouped, secure dry foothold
before onward travel; INV-097 still requires actual retained guards to stay
dry. Independent observers check actual spread, Recoil terrain legality and
naval retreat without pursuit. All check files forbid every invariant.

**Verification.** Played: balanced TECH and hard AIR each passed the strict
16-minute Tundra perimeter/retreat check; terrible TECH passed eight minutes of
Tundra land combat. A strengthened eight-minute Supreme test observed inland
combat after formation deployment. No invariant, illegal terrain target, script
or crash markers in these final runs. Native/pure suites passed, including 18
terrain and 19 amphibious scenarios; 266-member API/DLL parity, role docs and
invariant checks passed. Published matching DLL/debug/data to the required
engine build output. Full archives, failures, hashes and inspected screenshots
are in [the results](telchine-perimeter-results.md).

**Limits and deliberate non-changes.** These are controlled behavior fixtures,
not natural 8v8 recruitment or PvP win-rate benchmarks. Frozen energy limits
combat-value conclusions; inland casualties are reported rather than used to
tune production policy. A unit without a safe individual slot keeps the parent
dry anchor. One initial memory failure remains KI-454; generated shared notes
need correction under KI-455. Fixture evidence limits are KI-456. The accurate game mechanic is recorded in
`../rjm.bar.docs/knowledge/60-tactics/68-telchine-shoreline-tactics.md`
(local knowledge commit `e2e748a`). Existing KI-449/450/453 remain unchanged.

**Files.** [Plan](telchine-perimeter-plan.md),
[controller](../data/script/src/manager/amphibious_ops.as),
[formations](../data/script/src/manager/amphibious_formation.as),
[pure helper](../data/script/src/helpers/amphibious_math.as),
[settings](../data/config/lanes.json),
[route task declarations](../src/circuit/task/fighter/RouteTask.h),
[route task commands](../src/circuit/task/fighter/RouteTask.cpp),
[terrain declarations](../src/circuit/terrain/BattleAnalysis.h),
[terrain queries](../src/circuit/terrain/BattleLanes.cpp),
[fine corridor](../src/circuit/terrain/TerrainCorridor.h),
[solver declarations](../src/circuit/terrain/LaneSolver.h),
[solver](../src/circuit/terrain/LaneSolver.cpp),
[bindings](../src/circuit/script/InitScript.cpp),
[terrain tests](../tests/terrain_route_test.cpp),
[policy tests](../tests/amphibious_math_tests.as),
[preparer](../tools/playtest/prepare_telchine_shore_check.py),
[observer](../tools/playtest/widgets/telchine_shore_fixture.lua),
[perimeter checks](../tools/playtest/checks/shared/combat/telchine_perimeter.json),
[combat checks](../tools/playtest/checks/shared/combat/telchine_land_formation.json),
[inland checks](../tools/playtest/checks/shared/combat/telchine_inland_formation.json),
[playtest guide](../tools/playtest/README.md),
[results](telchine-perimeter-results.md),
[TECH perimeter](images/d161/tech-shore-perimeter.png),
[AIR landfall](images/d161/air-accessible-landfall.png),
[AIR formation](images/d161/air-next-island-formation.png),
[land combat](images/d161/tundra-land-combat.png),
[API](angelscript-references.md), [invariants](invariants.md),
[actors](actor-matrix.md), [TECH](roles/tech.md), [AIR](roles/air.md),
[issues](known-issues.md).


## D-162 - AIR allocates funded strikes and retains explicit sortie ownership

**Date:** 2026-10-01. **State:** Built; simulation verification in progress.

**Decision.** Correct the reviewed AIR plan before implementation. Count unique
observed armed aircraft instead of overlapping role costs; admit bounded strike
orders after transports, initial crew and emergency defense. Forecast the same
order mix in the economy. Keep TECH's sequence, mex-before-reactor and twenty
completed turrets per existing T2 lab. Reject the proposed bank bypass, arbitrary
25-fighter cap, guaranteed bomber share during emergencies, and return-fire-only
static AA. These conflict with protected behavior or lack PvP evidence.

Ordinary T1 raids and T2 waves stage on owned routes. Fund a linear capped
schedule; cadence waives only the schedule, never target feasibility or minimum
escorts. Release a supported subset rather than demanding escorts for the entire
reserve. Preserve an immutable cohort for survival measurement. Specialists
(EMP/Liche) retain native behavior until their payload/timing is modeled.

Native flight policy is opt-in. It scans armed AND peaceful enemy snapshots,
checks loaded damage/health margin, integrates route exposure, bounds ranks and
assigns nearby slots after asynchronous release. Fixed-wing readiness remembers
arrival within an inner radius while requiring continued presence inside twice
that radius; missing assembly returns home. Actual lethal release triggers
straight egress before turning home. Loss abort and return keep task ownership;
there is no autonomous experimental mop-up. This is not speed matching, a full
route solver, multi-target allocation, or proof against hidden AA.

The natural candidate also reproduced KI-443. Releasing exhausted idle workers
was tried and rejected: the same completed wind frames were repeatedly chosen.
Observer IDs proved those structures were complete, with duplicate construction
owners left behind. Under AIR's existing direct-flight opt-in, UnitFinished
finishes the registered owner once and aborts remaining construction owners of
that structure. It preserves the building and avoids duplicate build chains.
TECH keeps its previous path. INV-101 audits completed targets retaining workers.
Assembly also adds distance/speed transit before its script settling allowance;
the earlier fixed deadline could expire before a distant flank was reached.

**Alternatives rejected.** Bigger fixed home quotas and mass factories mask
allocation/energy limits. Income-only waves strand funded bombers. Unbounded
lines, point-hover assembly and immediate U-turns expose aircraft unnecessarily.
A whole-reserve escort requirement reproduces the original launch deadlock.
Changing shared static defaults or TECH rules expands the risk beyond AIR.

**Invariant.** INV-099 counts survivors from immutable launch IDs; INV-100
forbids autonomous DEFEND/BOMB ownership of held experimental bombers. Existing
INV-077/078/083/088/090/091/092/093 preserve reactor, income, layout, support and home
bounds. All simulation checks retain the global invariant forbid. Controlled
fixtures cannot establish natural economy milestones or unbeatable PvP strength.

**Verification.** See the [review](air-enhancement-review.md), corrected
[plan](air-enhancement-plan.md), and [measured results](air-enhancement-results.md). Failed and
interrupted runs remain under build-theatres/d162-*. Pure geometry tests cover
300 distinct slots, extreme finite inputs and loss thresholds. Twenty-eight
AngelScript air-math tests cover funding, defense, interleave, cadence and
escort-limited reserve release, overflow bounds and constant-time sizing. Final run IDs, screenshots and limitations are recorded in the results.

**Files.**
[data/script/src/helpers/air_math.as](../data/script/src/helpers/air_math.as),
[data/script/src/manager/air_economy.as](../data/script/src/manager/air_economy.as),
[data/script/src/manager/air_production.as](../data/script/src/manager/air_production.as),
[data/script/src/manager/air_screen.as](../data/script/src/manager/air_screen.as),
[data/script/src/manager/air_waves.as](../data/script/src/manager/air_waves.as),
[data/script/src/manager/air_raids.as](../data/script/src/manager/air_raids.as),
[data/script/src/roles/air.as](../data/script/src/roles/air.as),
[data/script/src/global.as](../data/script/src/global.as),
[data/config/experimental_balanced/behaviour.json](../data/config/experimental_balanced/behaviour.json),
[data/config/experimental_hard/behaviour.json](../data/config/experimental_hard/behaviour.json),
[data/config/experimental_terrible/behaviour.json](../data/config/experimental_terrible/behaviour.json),
[src/circuit/terrain/BattleAnalysis.h](../src/circuit/terrain/BattleAnalysis.h),
[src/circuit/terrain/BattleAnalysis.cpp](../src/circuit/terrain/BattleAnalysis.cpp),
[src/circuit/unit/CircuitUnit.h](../src/circuit/unit/CircuitUnit.h),
[src/circuit/unit/CircuitUnit.cpp](../src/circuit/unit/CircuitUnit.cpp),
[src/circuit/CircuitAI.cpp](../src/circuit/CircuitAI.cpp),
[src/circuit/script/InitScript.cpp](../src/circuit/script/InitScript.cpp),
[src/circuit/task/fighter/AirGeometry.h](../src/circuit/task/fighter/AirGeometry.h),
[src/circuit/task/fighter/AirWaveTask.h](../src/circuit/task/fighter/AirWaveTask.h),
[src/circuit/task/fighter/AirWaveTask.cpp](../src/circuit/task/fighter/AirWaveTask.cpp),
[src/circuit/module/BuilderManager.cpp](../src/circuit/module/BuilderManager.cpp),
[tests/air_math_tests.as](../tests/air_math_tests.as),
[tests/air_geometry_test.cpp](../tests/air_geometry_test.cpp),
[tools/run_native_tests.sh](../tools/run_native_tests.sh),
[tools/playtest/prepare_air_strike_check.py](../tools/playtest/prepare_air_strike_check.py),
[tools/playtest/widgets/air_strike_fixture.lua](../tools/playtest/widgets/air_strike_fixture.lua),
[tools/playtest/widgets/air_watch.lua](../tools/playtest/widgets/air_watch.lua),
[tools/playtest/checks/air/combat/air_strike_stages.json](../tools/playtest/checks/air/combat/air_strike_stages.json),
[tools/playtest/compare_air_runs.py](../tools/playtest/compare_air_runs.py),
[tools/playtest/prepare_air_economy_check.py](../tools/playtest/prepare_air_economy_check.py),
[tools/playtest/README.md](../tools/playtest/README.md),
[doc/air-enhancement-plan.md](air-enhancement-plan.md),
[doc/air-enhancement-review.md](air-enhancement-review.md),
[doc/air-wave-attacks.md](air-wave-attacks.md),
[doc/roles/air.md](roles/air.md),
[doc/angelscript-references.md](angelscript-references.md),
[doc/invariants.md](invariants.md),
[doc/actor-matrix.md](actor-matrix.md),
[doc/known-issues.md](known-issues.md),
[doc/knowledge/barb-unit-config.md](knowledge/barb-unit-config.md).

D-162 follow-up decisions: Phoenix mount inspection remains local to the opt-in
wave task. Script-emitted heat rays use attributed positive non-paralyzing enemy
damage as a fallback release observation, preserving the first fired timestamp
for ordinary bombers. Legion Mosquitos reuse native RAID rather than DEFEND.
The first-fusion rule drops its additional 500-metal bank veto but retains
owned-mex completion, recovery and 180-second M/E funding with commitments; the
repeat natural game completed Armada fusion at 19:03 after all owned upgrades.
See [results](air-enhancement-results.md), [AIR builder](roles/air_build.md),
[builder policy](../data/script/src/roles/air_build.as) and
[measurement data](benchmarks/air-d162-intermediate.json). The latest sizing
helpers also bound before integer conversion and avoid reserve-length loops;
four adversarial tests cover oversized configuration and fractional escorts.

D-162 final calibration: adopt a script-controlled 600-elmo assembly arrival
radius after Armada's 400-elmo run failed late formation, and the unchanged
600-elmo three-stage test passed unseeded and with engine/AI seed 1621. Keep
80% readiness and deadlines; changing the deadline or ignoring missing aircraft
was rejected. The observer now tracks commander commands before first factory
creation, avoiding a false new-mex allegation when a gifted builder starts the
lab. A focused seeded opening repeat passed. RNG helpers pin both independent
seeds; prior natural measurements remain non-paired. Process-inspection failures
are retained alongside full-log re-observation reports, never silently replaced.
Additional touched files:
[seed preparer](../tools/playtest/prepare_air_check.py),
[opening observer](../tools/playtest/widgets/air_opening_watch.lua),
[opening checks](../tools/playtest/checks/air/economy/air_capacity_opening.json),
[final data](benchmarks/air-d162-final.json),
[results and screenshot evidence](air-enhancement-results.md).

**Final state: Built, Checked, Played (bounded acceptance).** Final seeded
Armada/balanced, Cortex/hard and Legion/terrible three-stage combat fixtures
passed, as did the donated-constructor fusion case and focused gifted-opening
regression. Natural runs completed fifty minutes but remain FAIL for TECH
invariants and the last run's constructor-locality excursion (KI-460). The
supplied capacity case reached six supported T2 labs but exited at 33.6 of
45 intended minutes with an observer failure; it is not a full PASS. KI-457
retains unimplemented specialist/navigation work and loss/crowding calibration.
All evidence, seeds, artifact hash and limitations are in the
[results](air-enhancement-results.md). No TECH rule sequence, static firing
policy, twenty-turret expansion condition or transport-request priority changed.


## D-163 - Dense AIR campus, shared growth objective and target-funded raids

**Refined by D-164.** Five-second guards still allowed repeated production assistance by T2 aircraft. Those workers now retain an economic role, and opening economic/campus reservations prevent the newly diagnosed spatial starvation. TECH policy is unchanged.

2026-10-02. Owner requested six-plus dense T2 production blocks, a sustained
50-metal transition into TECH-style growth, two completed AFUS before mass
bombers, a saved random 10-20 opening, and target/route/resistance-sized raids.
[Design](air-campus-strike-design.md) was written before implementation.

**Call.** Share EcoPlanner's economic choices through an explicit AIR context;
default TECH state/ordering remains unchanged. AIR owns placement, lab admission,
mex prerequisites, support and aircraft budgets. Keep a zero-by-default policy
factory cap, lift AIR profile definition caps only during experimental AIR,
reserve six speculative T2 blocks and expand incrementally. Preserve the twenty
completed uniquely assigned turrets per existing T2 lab before expansion. Failed
support pins remain quarantined and get replacement ground within the same lab's
reach. Flying workers may cross their home disc to assist reactors. Reactor
placement searches that whole disc despite a rear anchor, and maintains campus
separation. Ground gifts keep their travel bound.

Save the first random bomber draw and two-AFUS milestone. Keep replacement stock
separate from each sortie's target budget. Native opt-in mission primitives read
loaded payload/health and known threats; script sets corridor padding, unknown,
army and local-AA reserves and target class. Execute the selected direct/edge
route, nominally synchronize one owner's static attack, then follow latched
return waypoints. T1 reusable bombers select known mexes/wind. Do not claim
multi-owner synchronization or optimal casualty predictions.

**Why and rejected alternatives.** Fixed factory caps contradict the requested
income-scaled campus; infinite up-front reservations steal allied/eco space.
Invoking TECH's chain/executor would alter its exact lab lifecycle or make AIR
build bot labs. Using generic native fallback production would spend on bombers
before the economic milestone. Linear wave growth ignores mission resistance;
forcing the opening draw onto an unaffordable target wastes the force. A timeout
does not waive target funding. Simultaneous return proximity was rejected after
healthy aircraft orbited past one another until timeout. Local AA reserve was
added after an eight-bomber flak package failed. Mission coefficients remain
calibration knobs, not a promise of PvP dominance. Two natural waves were
wiped out at the same defended solar target: the experimental target budget
had discarded survival feedback. Evaluate only completed sorties, persist a
bounded resistance multiplier, and exclude up to eight failed target regions
for a script-configured interval. Native filtering takes script-supplied areas;
it contains no hardcoded target cooldown. Keeping the same budget after a
complete loss was rejected. Temporary areas reset on role initialization;
the learned multiplier persists. The independent log audit checks actual later
target coordinates against active exclusions.

The natural run also diagnosed AIR's interruptible fallback guards: their native
timer is deactivated while assigned. Use non-interruptible five-second guards
(as already used by the commander) so mobile workers reconsider the economy.
After the opening crew, the commander needs a real unfinished aircraft frame,
not merely a recruit-task label. These are AIR policy changes, not native guard
or TECH behavior changes.

**Invariant.** INV-084/088 preserve complete speculative support and reciprocal
allied exclusion; INV-090 preserves completed support before lab expansion.
INV-102 requires the completed AFUS milestone before ordinary bomber orders;
INV-103 funds every actual release and keeps the first at its saved draw.
INV-104 audits fallback guard leases; INV-081 retains the independent commander
idle check. INV-105 independently audits native failed-raid region exclusion. No existing playtest forbid was removed.

**Verification.** Native and AngelScript helper suites passed. The twenty-minute
Armada three-stage combat test passed, including T1 economic attacks, a ten-unit
opening, target-sized edge attacks, destroyed flak/AFUS and actual returns home.
The Cortex bootstrap built both AFUS and six supported labs; its idle-commander
failure remains recorded. The later natural team run finishes its first
fusion at 18.47 minutes and both AFUS at 23.90/26.73. TECH's existing invariant
failures and the T2-lab deadline remain failures. Paired TECH games reached
twelve minutes with the same T1-then-T2 sequence, not identical timing; historical
smoke expectations make both reports FAIL. Full details and final obstruction
test results are in [the evidence report](air-campus-strike-results.md).
Unresolved natural timing is KI-461; combat calibration remains KI-457. Keep
the changes local, without pushing, per the owner's explicit instruction.

**Files.**
[data/script/src/global.as](../data/script/src/global.as),
[data/script/src/helpers/air_math.as](../data/script/src/helpers/air_math.as),
[data/script/src/manager/air_economy.as](../data/script/src/manager/air_economy.as),
[data/script/src/manager/air_growth.as](../data/script/src/manager/air_growth.as),
[data/script/src/manager/air_layout.as](../data/script/src/manager/air_layout.as),
[data/script/src/manager/air_production.as](../data/script/src/manager/air_production.as),
[data/script/src/manager/air_raids.as](../data/script/src/manager/air_raids.as),
[data/script/src/manager/air_waves.as](../data/script/src/manager/air_waves.as),
[data/script/src/manager/eco_planner.as](../data/script/src/manager/eco_planner.as),
[data/script/src/roles/air_build.as](../data/script/src/roles/air_build.as),
[data/script/src/roles/air_rules.as](../data/script/src/roles/air_rules.as),
[doc/actor-matrix.md](actor-matrix.md),
[doc/air-campus-strike-design.md](air-campus-strike-design.md),
[doc/air-campus-strike-results.md](air-campus-strike-results.md),
[doc/air-enhancement-plan.md](air-enhancement-plan.md),
[doc/air-wave-attacks.md](air-wave-attacks.md),
[doc/angelscript-references.md](angelscript-references.md),
[doc/invariants.md](invariants.md),
[doc/known-issues.md](known-issues.md),
[doc/roles/air.md](roles/air.md),
[doc/roles/air_build.md](roles/air_build.md),
[doc/roles/air_rules.md](roles/air_rules.md),
[src/circuit/script/InitScript.cpp](../src/circuit/script/InitScript.cpp),
[src/circuit/task/fighter/AirGeometry.h](../src/circuit/task/fighter/AirGeometry.h),
[src/circuit/task/fighter/AirWaveTask.cpp](../src/circuit/task/fighter/AirWaveTask.cpp),
[src/circuit/task/fighter/AirWaveTask.h](../src/circuit/task/fighter/AirWaveTask.h),
[tests/air_geometry_test.cpp](../tests/air_geometry_test.cpp),
[tests/air_math_tests.as](../tests/air_math_tests.as),
[tools/playtest/air_support_probe.as](../tools/playtest/air_support_probe.as),
[tools/playtest/checks/air/economy/air_growth.json](../tools/playtest/checks/air/economy/air_growth.json),
[tools/playtest/checks/air/layout/air_support_repair.json](../tools/playtest/checks/air/layout/air_support_repair.json),
[tools/playtest/prepare_air_check.py](../tools/playtest/prepare_air_check.py),
[tools/playtest/prepare_air_support_check.py](../tools/playtest/prepare_air_support_check.py),
[tools/playtest/widgets/air_fixture.lua](../tools/playtest/widgets/air_fixture.lua),
[tools/playtest/widgets/air_strike_fixture.lua](../tools/playtest/widgets/air_strike_fixture.lua).

Additional verification files: [playtest guide](../tools/playtest/README.md),
[raid feedback audit](../tools/playtest/audit_air_raid_feedback.py),
[campus screenshot](images/d163/cortex-campus-30min.png),
[edge ingress](images/d163/edge-ingress.png),
[static strike](images/d163/synchronized-flak-attack.png).

Final feedback verification: build 6 Armada combat repeat `d163-strike-feedback/runs/20261002-022342` passed twenty-minute checks.
The independent audit observed three alternate missions during an active
failed-region exclusion and increased then relaxed resistance. The forty-two
minute natural repeat again missed the fusion deadline (21.48 minutes);
the earlier 18.47 result is not a consistency claim. KI-442 metal overflow
remains open. [Feedback audit](benchmarks/air-d163-feedback.json),
[measurements](benchmarks/air-d163.json),
[natural base](images/d163/natural-base-20min.png),
[repaired campus](images/d163/support-repaired-campus.png).

Natural feedback evidence: `d163-team-feedback/runs/20261002-022726`
completed forty-two minutes; both AIR teams logged no role invariants,
while existing TECH/ferry failures kept the full report FAIL. Cortex
built its two AFUS at 27.62/33.01 and launched its saved eleven.
Legion selected four later missions outside active failed regions;
[natural audit](benchmarks/air-d163-natural-feedback.json) passed its
narrow contract. Heavy combat losses remain KI-457, not a solved outcome.


## D-164 - AIR economy workers and separately reserved advanced economy

**Decision.** Exclude advanced aircraft constructors from fallback production
guards and individually reassign an existing builder guard to a one-second
recheck. Leave shared guards alive for their other workers. Keep real unfinished
construction/repair assistance. Use the shared economic chooser unchanged, with
an AIR-only funded surplus-reactor fallback after the two-AFUS milestone.

Reserve four AFUS/eight-converter modules, the starter and at least six future
T2 factory/turret modules during the opening. Native slots and zones enforce
local/allied exclusion; named native state reconstructs module ownership.
Revalidate unused modules before first use and relocate atomically around
physical blockage. Claimed modules remain fixed. A 128-elmo economic search
and half-pitch factory fallback fit terrain while retaining native geometry.

**Reasoning and rejected alternatives.** A short guard timeout alone does not
prevent indefinite renewals. Aborting the whole guard would affect innocent
workers, so use individual assignment. Reservation must precede construction:
waiting until the first lab order let wind and allied expansion consume space.
Two modules and 700-elmo reactor/factory exclusion passed an isolated fixture
but failed the crowded natural team test. Four initial modules, 384-elmo
reactor/factory spacing and 512-elmo reactor spacing preserve more useful room.
Neither spacing is explosion-proof; the owner allows the districts to connect.
Do not weaken TECH reservations, extend AIR's home radius, bypass twenty
completed turrets per existing T2 lab, or change TECH's exact reclaim sequence.

**Invariant.** INV-106 forbids advanced AIR aircraft production guards and
checks individual release. INV-107 requires new AFUS/advanced-converter tasks
to use a complete persistent economic module. INV-108 serializes owned reactor projects without letting unrelated T1 energy
orders block advanced growth. Existing shared placement, reactor-mex, support
and bounded-guard invariants remain active.

An additional natural-run diagnosis showed generic ENERGY queues preventing
AFUS starts with no reactor underway. AIR now reads its own queued/unfinished
reactor projects for this gate; completed targets, small energy and repair
tasks cannot block it. The shared TECH context is deliberately unchanged.

**Verification.** Engine-free AIR policy: 61 tests pass. Rendered controlled
runs confirm actual injected task ownership, release within 30 frames, T1 peer
retention, saved-name module adoption, physical first-use relocation, new
reactors and continued combat-aircraft production. The latest natural opening
reserved all four economic modules and all seven factory bays by twelve game
seconds. Complete evidence and limits, including the intermediate failures,
are in [the results](air-economy-zone-results.md). This is not a claim of optimal
PvP balance or a complete engine save/load round trip. KI-442 and KI-461 remain
tracked in [known issues](known-issues.md).

**Files.**

- Active policy: [data/script/src/global.as](../data/script/src/global.as),
  [data/script/src/helpers/air_math.as](../data/script/src/helpers/air_math.as),
  [data/script/src/manager/air_eco_layout.as](../data/script/src/manager/air_eco_layout.as),
  [data/script/src/manager/air_growth.as](../data/script/src/manager/air_growth.as),
  [data/script/src/manager/air_layout.as](../data/script/src/manager/air_layout.as),
  [data/script/src/roles/air_build.as](../data/script/src/roles/air_build.as),
  [data/script/src/roles/air_rules.as](../data/script/src/roles/air_rules.as).
- Tests: [tests/air_math_tests.as](../tests/air_math_tests.as).
- Simulation tooling: [tools/playtest/README.md](../tools/playtest/README.md),
  [tools/playtest/air_economy_probe.as](../tools/playtest/air_economy_probe.as),
  [tools/playtest/audit_air_economy.py](../tools/playtest/audit_air_economy.py),
  [tools/playtest/checks/air/economy/air_economy_capacity.json](../tools/playtest/checks/air/economy/air_economy_capacity.json),
  [tools/playtest/checks/air/economy/air_economy_natural.json](../tools/playtest/checks/air/economy/air_economy_natural.json),
  [tools/playtest/checks/air/layout/air_economy_zone.json](../tools/playtest/checks/air/layout/air_economy_zone.json),
  [tools/playtest/prepare_air_economy_zone_check.py](../tools/playtest/prepare_air_economy_zone_check.py).
- Documentation and evidence: [doc/actor-matrix.md](actor-matrix.md),
  [doc/air-economy-zone-plan.md](air-economy-zone-plan.md),
  [doc/air-economy-zone-results.md](air-economy-zone-results.md),
  [doc/benchmarks/air-d164-capacity.json](benchmarks/air-d164-capacity.json),
  [doc/benchmarks/air-d164-final-natural.json](benchmarks/air-d164-final-natural.json),
  [doc/benchmarks/air-d164-final-regression.json](benchmarks/air-d164-final-regression.json),
  [doc/benchmarks/air-d164-queue-blocker.json](benchmarks/air-d164-queue-blocker.json),
  [doc/benchmarks/air-d164-regression.json](benchmarks/air-d164-regression.json),
  [doc/decisions.md](decisions.md),
  [doc/images/d164/capacity-19min.png](images/d164/capacity-19min.png),
  [doc/images/d164/final-growth-24min.png](images/d164/final-growth-24min.png),
  [doc/images/d164/growth-24min.png](images/d164/growth-24min.png),
  [doc/images/d164/natural-40min.png](images/d164/natural-40min.png),
  [doc/invariants.md](invariants.md),
  [doc/known-issues.md](known-issues.md),
  [doc/roles/air.md](roles/air.md),
  [doc/roles/air_build.md](roles/air_build.md),
  [doc/roles/air_rules.md](roles/air_rules.md).

## D-165 - Replenishing AIR combat arenas with measured outcomes

**Date.** 2026-10-02.

**Decision.** Add combat-only AIR fixtures under playtest tooling, using the
published native build and staged copies of policy. Supply units, radar, energy
and ammunition; freeze economic construction and waive the documented economic
and escort gates. Keep real target selection, routes, formations, returns,
resistance feedback and home fighter interception. JSON cases, UnitDef overrides,
serial matrices, per-case comparison and an explicit endless/stop lifecycle
provide one reusable harness instead of separate hard-coded unit tests.

**Reasoning and rejected alternatives.** Waiting for a full economy obscures
combat regressions and costs far more time. Issuing widget attack orders would
test the widget rather than AIR. Removing survivors between rounds would hide
return behavior. Global LOS cannot prove radar reaction, and a completed sortie
cannot be inferred from an arbitrary wave timer. The observer retains each
actual task and waits for evaluation before recording its resistance outcome.
BAR regenerates the LuaUI damage dispatcher, so the final observer wraps the
handler method and checks ownership instead of wrapping only the global callin.
Completed cohorts are released, preventing an endless accumulation of retained
wave tables. Bounded audits exclude shutdown overrun and unfinished sorties
remain censored.

Deliberately leave production doctrine unchanged. These samples establish a
measurement baseline and working loss feedback, not an efficient solution to
layered AA. Tuning a scalar until one supplied-force matchup wins would not
establish stronger PvP play. KI-457 remains open. The forward naval fixture
also does not exercise home interception at those targets; a separate covered
naval case changes geography and supplies sonar without changing fighter policy.

**Invariant.** A fixture never commands, teleports or heals a living combat
unit to force an outcome. Only actual launched members contribute to a bomber
cohort; EMP is separate from health damage; completed cohorts do not accumulate
later losses. Fixture checks reject missing units/sites, broken callbacks,
script/crash errors and every existing production invariant. This changes no
production actor or rule, so it adds no production INV identifier.

**Verification.** Fourteen measurement/input tests pass. Seventeen final rendered
observations pass strict checks: the 18-minute T2 radar baseline, twelve
10-minute faction cases, three 8-minute covered naval cases, and an endless
observation beyond its nominal one-minute cutoff to frame 11097. All were
stopped explicitly or by their bounded watcher. The initial failed observer
and its provisional successor remain archived and excluded from final scores.
The final radar baseline shows resistance 1 -> 1.5 -> 2.25 -> 3 and later fusion
kills, with poor exchanges; the layered-AA baseline retains zero-damage failures.
See the evidence and limits in the results. Production data, TECH and the DLL
are unchanged; the mandatory output remains matched to the source data.

**Files.**

- Harness: [runner](../tools/playtest/air_arena.py),
  [read-only probe](../tools/playtest/air_arena_probe.as),
  [widget](../tools/playtest/widgets/air_arena.lua),
  [auditor](../tools/playtest/audit_air_arena.py),
  [tests](../tools/playtest/test_air_arena.py),
  [strict checks](../tools/playtest/checks/air/combat/air_arena.json),
  [run instructions](../tools/playtest/README.md).
- Cases: [T1 economy](../tools/playtest/cases/air/combat/t1-economy.json),
  [T2 interception](../tools/playtest/cases/air/combat/t2-intercept.json),
  [layered AA](../tools/playtest/cases/air/combat/t2-flak.json),
  [gunships](../tools/playtest/cases/air/combat/gunship.json),
  [forward naval](../tools/playtest/cases/air/combat/torpedo.json),
  [covered naval](../tools/playtest/cases/air/combat/torpedo-covered.json).
- Documentation: [plan](air-combat-arena-plan.md),
  [results](air-combat-arena-results.md),
  [measurements](benchmarks/air-d165-arena.json),
  [known issues](known-issues.md), [decision record](decisions.md).
- Original screenshots: [interception](images/d165/t2-intercept.png),
  [fusion strike](images/d165/t2-fusion-strike.png),
  [mex strike](images/d165/t1-mex-strike.png),
  [layered AA](images/d165/layered-aa-strike.png),
  [torpedo strike](images/d165/torpedo-strike.png),
  [Shurikens](images/d165/shuriken-strike.png).


## D-166 - AIR performance review before optimization

**Date.** 2026-10-02 05:04:39 -03:00.

**Decision.** Complete the requested runtime/APM review against AI revision
`2c391ab6` and the trusted Recoil source before changing gameplay. Prioritize
transient AIR task retirement, unchanged-route command suppression, exact
revision-aware economy aggregates, and indexed/budgeted placement and target
queries. Preserve emergency interception, transport requests, bomber mission
budgets, constructor economy work and TECH's existing sequence. Leave the
production implementation unchanged in this review.

**Reasoning.** Source tracing confirms synchronous AI callbacks in the engine
simulation path and networked unit orders. Repeated whole-screen routes create
avoidable orders; empty transient routes can survive losses; several nested
queries multiply with late-game armies and layouts. These justify focused
optimizations, but source operation counts are not measured FPS gains. Existing
D-165 arena outcomes do not measure AI CPU cost, network bursts or relay delay.
The review specifies instrumentation and exact-output/runtime acceptance tests.

**Alternatives rejected.** A blanket slower AIR tick or global APM cap could
delay defense, ferry handoffs and volleys. Changing generic RouteTask lifetime
or SetRoute semantics globally could break persistent Spam and TECH amphibious
routes. Moving live engine/script objects to workers is unsafe. Arbitrary target
shortlists, six-lab caps or stale economy caches could change efficacy. Begin
with exact, opt-in mechanisms and measure before considering those tradeoffs.

**Invariant.** This documentation-only change leaves production code, settings,
TECH actors and all existing invariant contracts unchanged. A future optimization
must retain timely threat reaction, fresh order admission, allied reservation
exclusion, exact TECH lab sequencing and current mission/transport ownership.
No new production invariant ID is introduced before an implementation exists.

**Verification.** Checked the active AIR script graph, recent native air tasks,
shared query/scheduler mechanisms and the pinned engine dispatch/network path.
Independently calculated command-volume and candidate-enumeration examples.
No new game was run and no optimization was Built or Played. KI-462 through
KI-465 remain open; existing KI-419/KI-433/KI-457/KI-461 are not claimed fixed.

**Files.** [Full review](reviews/2026-10-02-air-performance-review.md),
[known issues](known-issues.md), and this [decision record](decisions.md).


## D-167 - Compact AIR lab compounds and shared early-energy retirement

**Decision.** Reserve six total labs per compound: one T1 plus five T2 first, then six T2 per expansion, with no default total cap. Use shared native half-cell geometry and persistent pins, atomic preflight and allied exclusion; keep AIR policy independent. Extract TECH's exact scalar reclaim comparison for AIR and retire early energy behind completed reactors. Preserve the two-AFUS bomber gate pending the user's conflict resolution.

**Reasoning.** Individually searched bays spread production across the base. Flying constructors and factory output allow touching support banks without an internal ground exit lane. The complete first compound must exist before spending; a blocked unused compound relocates together. Existing and gifted occupied legacy bays remain anchored. Finished AFUS permits retirement, while frames cannot substitute for working energy.

**Alternatives rejected.** Calling TECH's controller would alter its lab sequence. Global changes to factory exit semantics could affect ground factories. Six T2 plus a T1 inside one compound would exceed the requested six-lab cluster size. Claiming a twenty-minute bomber deadline from a resource-supplied test would confuse capacity with natural economy.

**Invariant.** INV-109: each new AIR compound publishes exactly six reserved lab sites. INV-110: early energy reclaim requires a completed reactor and the shared TECH permission outside energy stalls. Existing INV-084/090 retain twenty support pins/completed turrets respectively; TECH's actors and sequence remain unchanged.

**Verification.** Built and Checked: native integration, full engine-free suites, API parity, invariant and role checks. Played: two controlled capacity games passed first-use relocation, wind retirement and expansion to eleven T2 labs; all experimental profiles loaded. Natural games missed the twenty-minute T2 wave target and retain full failure verdicts. Runtime lifecycle edges and camera faults remain KI-467/468; natural economy remains KI-461 and commander idle guards KI-466. See [measured results](air-cluster-reclaim-results.md) for exact artifacts and limitations.

**Files.** [Plan](air-cluster-reclaim-plan.md), [geometry](../src/circuit/terrain/BaseLayoutGeometry.h), [terrain declaration](../src/circuit/terrain/TerrainManager.h), [terrain implementation](../src/circuit/terrain/TerrainManager.cpp), [binding](../src/circuit/script/InitScript.cpp), [API](angelscript-references.md), [AIR layout](../data/script/src/manager/air_layout.as), [reclaim](../data/script/src/manager/air_reclaim.as), [AIR build](../data/script/src/roles/air_build.as), [AIR rules](../data/script/src/roles/air_rules.as), [shared math](../data/script/src/helpers/production_math.as), [TECH execution](../data/script/src/roles/tech_build.as), [geometry tests](../tests/base_layout_geometry_test.cpp), [math tests](../tests/production_math_tests.as), [probe](../tools/playtest/air_cluster_probe.as), [fixture setup](../tools/playtest/prepare_air_cluster_check.py), [checks](../tools/playtest/checks/air/layout/air_factory_clusters.json), [invariants](invariants.md), [actors](actor-matrix.md), [AIR reference](roles/air.md), [TECH reference](roles/tech_build.md).


**D-167 implementation refinement.** AIR now owns low-tier energy retirement
exclusively while active, retaining/restoring the prior native setting rather
than allowing two different reclaim policies. Dead owned project handles no
longer hold its reactor serialization gate. All AIR placement callers reject
wind/basic/advanced solar while AFUS stands, preventing a build/reclaim cycle.
Neither defensive change is claimed to explain the first natural run's
reclaimed AFUS. The two-AFUS bomber gate remains deliberately unchanged.

**Additional files.** [Results](air-cluster-reclaim-results.md),
[known issues](known-issues.md), [base layout](base-layout.md),
[AIR action reference](roles/air_build.md), [AIR rule reference](roles/air_rules.md),
[playtest guide](../tools/playtest/README.md),
[economy probe](../tools/playtest/air_economy_probe.as),
[growth check](../tools/playtest/checks/air/economy/air_growth.json),
[expansion check](../tools/playtest/checks/shared/economy/expansion.json),
[natural audit 1](benchmarks/d167-natural-1.json),
[natural audit 2](benchmarks/d167-natural-2.json),
[capacity audit 1](benchmarks/d167-clusters-1.json),
[capacity audit final](benchmarks/d167-final-clusters.json),
[capacity capture 15](images/d167/capacity-15.png),
[capacity capture 24](images/d167/capacity-24.png),
[natural capture 20](images/d167/natural-20.png).


**D-167 final natural repeat.** [Final audit](benchmarks/d167-natural-final.json):
first fusion 17.48 minutes, AFUS 21.95/26.65, all wind gone at 28.6 and seven T2
labs by 38.18. First bomber wave 29.72; twenty bombers with zero escorts, then
zero survivors. Retain the failed timing/efficacy verdict and KI-457/461 rather
than accepting production counts as effective combat. The final all-caller
low-tier energy admission guard was loaded in this natural run.


## D-168 - Metal-map support requires explicit isolation before implementation

**Date.** 2026-10-02.

**Decision.** Retain the metal-map proposal as research with a linked source
review. Do not implement its current contracts verbatim. Require early coherent
mode selection, unchanged false-mode paths, corrected yield units and complete
positional task ownership/persistence before enabling metal-specific policy.
Treat the existing spot-zero cancellation repair separately from the claim that
normal-map behavior is identical.

**Reasoning.** Shared initialization happens before script map setup; the proposed
T1 M/s skeleton income is multiplied by extraction rate again; AIR's candidate
cap is not an opening total; positional upgrades reject -1 on load. These are
concrete code conflicts, not tuning preferences. Economy arithmetic and layout
ownership also need the corrections listed in the review.

**Alternatives rejected.** Implementing the proposal as written would introduce
avoidable startup, production and restore regressions. Rewriting the entire
proposal would obscure which evidence and recommendations were originally
supplied. This review does not approve owner-rule exceptions or change native,
AngelScript, profile or map behavior.

**Invariant.** Preserve existing normal-map rule order, factory/reclaim behavior,
layout pins and converter policies, including existing INV-107/109/110 promises.
Future metal variants need separate applicable checks, not unconditional skips.
No new runtime invariant is introduced by this documentation-only review.

**Verification.** Source review at aacbfc8a against Recoil 92efda5e60 and BAR
1d267c20d1; independent extraction-cell and economy arithmetic checks; audited
three retained headless logs/reports. All retained smoke verdicts remain FAIL.
No new games, binary builds or runtime behavior changes; performance unmeasured.

**Files.** [Proposal](metal-maps-proposal.md),
[source review](reviews/2026-10-02-metal-maps-proposal-review.md),
[known issues KI-469-471](known-issues.md).


## D-169 - Base metal-map recommendations on marginal value and funded workloads

**Date.** 2026-10-02.

**Decision.** Recommend an explicitly enabled metal-field economy whose desired
production, sustainable resource funding and local build capacity are separate.
Keep legacy spot data and normal-mode policy intact; add per-AI mode context and
separate field claims with typed yield and task identity. Resolve F1-F9 through
the revised design before implementation. Treat metal-only exceptions to AIR's
raw-income, upgrade, wind-reclaim and two-AFUS gates as proposed settings, not
owner decisions already made. Preserve TECH's exact lab reclaim/rebuild rules.

**Reasoning.** Actual aircraft costs exceed the proposed generic energy ratio.
On safe free ground, three new T1 mexes are a much cheaper source of the same
additional income as upgrading an existing one. Constant high wind can remain
efficient after AFUS access; space, slots, risk and affordable throughput decide
when compression pays. Rich strips, flat plates and void platforms have different
opportunities. Workload arithmetic and source mechanics justify these decisions;
limited player recordings do not establish optimal timings or winning strategy.
Correct the shared extraction-circle and average-income documentation rather
than propagating those errors into the design.

**Alternatives rejected.** Raw +50 metal as proof that production is funded;
upgrading an unbounded field before power growth; unconditional wind retirement;
one roster-wide energy ratio; overwriting the shared legacy spot catalog with
M/s field nodes; reusing optional instant-build quick-start timings as an ordinary
PvP opening benchmark. Retain the original proposal/review with follow-up links
so the superseded claims and failed tests remain visible.

**Invariant.** Reuse D-168's normal-map, TECH sequence, pin and converter-policy
boundary. Proposed field promises cover lifecycle identity, non-duplicated income,
bounded opening/search work and ammunition-ready defense. No new runtime check
or behavior is claimed by this research change, and existing checks are not
disabled. Arithmetic fixtures do not replace game validation.

**Verification.** Pinned BAR 1d267c20d1 and Recoil 92efda5e60 source inspection;
scalar unit costs cross-checked against the shared cache; reproducible strict
circle, mex-upgrade, energy and bomber/fighter workload arithmetic. Official
map/economy/air pages checked; three player-video identities inspected, transcripts
unavailable, one private Cloud9 game's description and early scene sampled.
No representative competitive replay cohort, new simulation, native build or
runtime performance measurement. Implementation and PvP efficacy remain unverified.

**Files.** [Revised design](metal-maps-revised-design.md),
[original proposal](metal-maps-proposal.md),
[review disposition](reviews/2026-10-02-metal-maps-proposal-review.md),
[arithmetic tool](../tools/knowledge/metal_map_economics.py),
[arithmetic results](benchmarks/metal-map-economics.json),
[known issues](known-issues.md),
[shared gameplay research](../../rjm.bar.docs/knowledge/70-strategy/79-metal-map-pvp.md),
[corrected extraction mechanics](../../rjm.bar.docs/knowledge/20-game-mechanics/27-metal-maps-and-spots.md).


## D-170 - Continuous metal fields, dense AIR/TECH extraction and dedicated opening workers

**Date.** 2026-10-02.

**Decision.** Implement D-168/169 with the owner's subsequent forty-mex amendment.
Native C++ owns detection, extraction-circle arithmetic, shared claims, exact
positional task identities and atomic layout geometry. Script/JSON own budgets,
workload economics, worker assignments, module membership and progression.
All seven active profiles load a separate metal_map fragment. The field branch
requires the published metal-map sentinel plus positive broad/recognized ground;
missing metadata and ordinary finite spot maps keep the existing path.

AIR/TECH preplan five dense eight-mex modules using the same native reservation
engine as labs and economy. Forty is a minimum, not a cap. The first T1 worker
keeps constructing/resuming extraction commitments despite full metal storage;
the second meets power demand. TECH's third starts its initial T2 lab. AIR's
first T2 follows its completed configured fighter screen. Dedicated workers skip
discretionary defense/frontline assignments while ferry ownership, current
construction and TECH's existing lab reclaim rules keep precedence. Later AIR
labs still require twenty completed support turrets per existing T2 lab.

**Reasoning.** Unlimited deposit area changes priorities but does not remove
energy/build-power constraints. Exact extraction circles and maximum-depth claims
prevent synthetic spot accounting and ownership errors. Separate dense modules
reserve usable ground before production/defense expansion. Natural tests exposed
own-blocker rejection, cancellation bypassing shared pin cleanup, a coarse ally
exclusion covering the owner's start, and defense rules stealing the mex worker.
Fix their mechanisms instead of accepting sparse expansion. The forty-mex target
and first-T2 triggers are explicit owner policy, not universal researched timings.

**Alternatives rejected.** Replacing the normal spot catalog; a blanket raw-metal
income gate; continuing to pause initial extraction at a full bank; allowing
converters through profile cap changes; mandatory useful-wind retirement on metal
fields; overlapping allied reservations; forcing six-lab shapes where constrained
platforms cannot fit them; reordering TECH's lab reclaim/rebuild table; hiding
invariant failures behind the focused economic audit. A six-site AIR search may
fall back to atomic three-/one-site metal compounds after 120 seconds, preserving
full support membership. Normal AIR shapes are unchanged.

**Invariant.** INV-111 forbids queued converters, independently checked by actual
Lua unit creation. INV-112 keeps framed mexes at their served module positions.
INV-113 protects dedicated opening workers from discretionary front/defense rows.
INV-114 checks that cancelled unframed mex tasks release served pins after native
cleanup. Every test keeps the full invariant forbid. INV-006/009/021 are explicitly
ordinary-economy promises; metal mode uses its separate energy policy. The normal
branch gains only bounds/spot-zero cancellation repairs and an actual-producer
invariant diagnostic, aside from early false-mode guards.

**Verification.** Built and played. Final DLL 9d1c668474924f01 with matching symbols;
all native/AngelScript policy unit suites pass and 275 used API members match.
Final Nine Metal Islands reaches forty completed mexes on all four AIR/TECH
players at 12:00-15:30, with zero converters. Plate and repeated SpeedMetal games
verify dense expansion under combat, with incomplete forty-mex outcomes after
base losses explicitly retained. Native hard profile passes twenty minutes with
111-147 peak mexes per player and zero converters. Controlled cancellation passes:
pin 247 is released, served again, and followed by eleven more mex completions.
Twenty-minute ordinary Supreme and Glacial comparisons preserve finite spots,
ordinary upgrades/converters and no field-policy entry. Their full invariant
reports, and several metal reports, still fail. No claim of optimal PvP play,
seeded deterministic equivalence, runtime save/load completion, full profile
matrix coverage or measured 8v8 p95/p99/APM performance. See
[results](metal-maps-results.md) and KI-472/473; original failed runs remain.

**Files.** The complete repository change set for the research and implementation
is linked below. Generated binaries and local playtest artifacts are described
in the results, not committed. Shared gameplay-only research remains in the
sibling knowledge repository.

- [data/config/metal_map.json](../data/config/metal_map.json)
- [data/script/README.md](../data/script/README.md)
- [data/script/easy/init.as](../data/script/easy/init.as)
- [data/script/experimental_balanced/init.as](../data/script/experimental_balanced/init.as)
- [data/script/experimental_hard/init.as](../data/script/experimental_hard/init.as)
- [data/script/experimental_terrible/init.as](../data/script/experimental_terrible/init.as)
- [data/script/hard/init.as](../data/script/hard/init.as)
- [data/script/hard_aggressive/init.as](../data/script/hard_aggressive/init.as)
- [data/script/medium/init.as](../data/script/medium/init.as)
- [data/script/src/helpers/metal_math.as](../data/script/src/helpers/metal_math.as)
- [data/script/src/manager/air_eco_layout.as](../data/script/src/manager/air_eco_layout.as)
- [data/script/src/manager/air_economy.as](../data/script/src/manager/air_economy.as)
- [data/script/src/manager/air_layout.as](../data/script/src/manager/air_layout.as)
- [data/script/src/manager/air_reclaim.as](../data/script/src/manager/air_reclaim.as)
- [data/script/src/manager/builder.as](../data/script/src/manager/builder.as)
- [data/script/src/manager/eco_planner.as](../data/script/src/manager/eco_planner.as)
- [data/script/src/manager/invariants.as](../data/script/src/manager/invariants.as)
- [data/script/src/manager/metal_economy.as](../data/script/src/manager/metal_economy.as)
- [data/script/src/manager/metal_layout.as](../data/script/src/manager/metal_layout.as)
- [data/script/src/roles/air_build.as](../data/script/src/roles/air_build.as)
- [data/script/src/roles/air_rules.as](../data/script/src/roles/air_rules.as)
- [data/script/src/roles/tech.as](../data/script/src/roles/tech.as)
- [data/script/src/roles/tech_chain.as](../data/script/src/roles/tech_chain.as)
- [data/script/src/roles/tech_rules.as](../data/script/src/roles/tech_rules.as)
- [data/script/src/setup.as](../data/script/src/setup.as)
- [doc/Profile.md](../doc/Profile.md)
- [doc/actor-matrix.md](../doc/actor-matrix.md)
- [doc/angelscript-references.md](../doc/angelscript-references.md)
- [doc/base-layout.md](../doc/base-layout.md)
- [doc/benchmarks/metal-map-economics.json](../doc/benchmarks/metal-map-economics.json)
- [doc/benchmarks/metal-map-simulations.json](../doc/benchmarks/metal-map-simulations.json)
- [doc/decisions.md](../doc/decisions.md)
- [doc/invariants.md](../doc/invariants.md)
- [doc/knowledge/barb-unit-config.md](../doc/knowledge/barb-unit-config.md)
- [doc/known-issues.md](../doc/known-issues.md)
- [doc/metal-maps-implementation.md](../doc/metal-maps-implementation.md)
- [doc/metal-maps-proposal.md](../doc/metal-maps-proposal.md)
- [doc/metal-maps-results.md](../doc/metal-maps-results.md)
- [doc/metal-maps-revised-design.md](../doc/metal-maps-revised-design.md)
- [doc/reviews/2026-10-02-metal-maps-proposal-review.md](../doc/reviews/2026-10-02-metal-maps-proposal-review.md)
- [doc/roles/air.md](../doc/roles/air.md)
- [doc/roles/air_build.md](../doc/roles/air_build.md)
- [doc/roles/air_rules.md](../doc/roles/air_rules.md)
- [doc/roles/tech.md](../doc/roles/tech.md)
- [doc/roles/tech_chain.md](../doc/roles/tech_chain.md)
- [doc/roles/tech_rules.md](../doc/roles/tech_rules.md)
- [src/circuit/module/BuilderManager.cpp](../src/circuit/module/BuilderManager.cpp)
- [src/circuit/module/EconomyManager.cpp](../src/circuit/module/EconomyManager.cpp)
- [src/circuit/module/EconomyManager.h](../src/circuit/module/EconomyManager.h)
- [src/circuit/module/MetalFieldEconomy.cpp](../src/circuit/module/MetalFieldEconomy.cpp)
- [src/circuit/resource/MetalField.h](../src/circuit/resource/MetalField.h)
- [src/circuit/resource/MetalManager.cpp](../src/circuit/resource/MetalManager.cpp)
- [src/circuit/resource/MetalManager.h](../src/circuit/resource/MetalManager.h)
- [src/circuit/script/EconomyScript.cpp](../src/circuit/script/EconomyScript.cpp)
- [src/circuit/script/InitScript.cpp](../src/circuit/script/InitScript.cpp)
- [src/circuit/task/builder/BuilderTask.cpp](../src/circuit/task/builder/BuilderTask.cpp)
- [src/circuit/task/builder/MexTask.cpp](../src/circuit/task/builder/MexTask.cpp)
- [src/circuit/task/builder/MexTask.h](../src/circuit/task/builder/MexTask.h)
- [src/circuit/task/builder/MexUpTask.cpp](../src/circuit/task/builder/MexUpTask.cpp)
- [src/circuit/task/builder/MexUpTask.h](../src/circuit/task/builder/MexUpTask.h)
- [src/circuit/terrain/TerrainManager.cpp](../src/circuit/terrain/TerrainManager.cpp)
- [src/circuit/terrain/TerrainManager.h](../src/circuit/terrain/TerrainManager.h)
- [src/circuit/unit/ally/AllyTeam.h](../src/circuit/unit/ally/AllyTeam.h)
- [src/circuit/util/GameAttribute.h](../src/circuit/util/GameAttribute.h)
- [tests/CMakeLists.txt](../tests/CMakeLists.txt)
- [tests/metal_field_test.cpp](../tests/metal_field_test.cpp)
- [tests/metal_math_tests.as](../tests/metal_math_tests.as)
- [tools/knowledge/metal_map_economics.py](../tools/knowledge/metal_map_economics.py)
- [tools/playtest/README.md](../tools/playtest/README.md)
- [tools/playtest/audit_metal_check.py](../tools/playtest/audit_metal_check.py)
- [tools/playtest/checks/shared/economy/metal_cancel.json](../tools/playtest/checks/shared/economy/metal_cancel.json)
- [tools/playtest/checks/shared/economy/metal_field.json](../tools/playtest/checks/shared/economy/metal_field.json)
- [tools/playtest/checks/shared/economy/metal_legacy.json](../tools/playtest/checks/shared/economy/metal_legacy.json)
- [tools/playtest/checks/shared/economy/metal_normal_control.json](../tools/playtest/checks/shared/economy/metal_normal_control.json)
- [tools/playtest/checks/shared/economy/metal_normal_tech_control.json](../tools/playtest/checks/shared/economy/metal_normal_tech_control.json)
- [tools/playtest/playtest.py](../tools/playtest/playtest.py)
- [tools/playtest/prepare_metal_check.py](../tools/playtest/prepare_metal_check.py)
- [tools/playtest/widgets/metal_watch.lua](../tools/playtest/widgets/metal_watch.lua)
- [tools/playtest/widgets/playtest_camera.lua](../tools/playtest/widgets/playtest_camera.lua)
- [tools/run_native_tests.sh](../tools/run_native_tests.sh)


## D-171 - Committed AIR operations, stable control groups and income admission

**Call.** Experimental AIR uses opt-in native cohort/route mechanisms controlled
by AngelScript. Offensive bombers remain airborne and attack until exhausted;
all available fighters accompany a sortie and do not peel for a home incursion.
The owner's explicit answer selects this over intercepting with committed
escorts. Newly produced/uncommitted fighters remain home defenders. Defensive
T3 sorties can return and repair. TECH's executor and lab rules are unchanged.

**Reasoning.** Stable route versions, shared wall cells and persistent target
orders remove needless per-aircraft refreshes. Recoil's GiveGroupOrder is a
no-op, so logical groups are not a network-packet reduction by themselves.
An early natural run exposed 3,254 AIR commands in one minute: TrySetIdleMode
and TrySetFireState each emit a command even when unchanged. D-171 sets these
states once on operation entry, not again on every movement leg or target.
No general command rate limiter or delayed emergency decision is added.

Sustained M/E affordability replaces the named two-AFUS bomber gate while the
two-AFUS growth objective remains. A nearby temporary T1 lab avoids forcing
the sole commander to a speculative campus. It is retired when idle, supported
and affordable T2 access has a planned site; transport requests preempt this.
Later T1 recovery uses a planned campus bay. The fighter/radar factory identity
persists while that factory is valid, including when a new lab has a lower ID.

**Alternatives rejected.** A global APM cap would suppress urgent responses.
Moving every unit each tick defeats multiplayer efficiency. Holding excess
T2 fighters at the factory wastes the home wall. Counting intentional losses
as failed return missions suppresses the requested attrition doctrine. Forcing
a large frontline assault into the 10-20 opening raid size can deadlock the
first attack; the random size now applies to the first economy raid, while
frontline and defensive missions have separate payload budgets.

**Invariant.** INV-115 keeps committed escorts with their live operation;
INV-116 forbids offensive RETURNING. INV-093 preserves friendly-territory
interception; INV-102 checks sustained production income; INV-103 checks the
opening economy draw and every mission's payload budget. Existing construction,
transport, twenty-turret expansion, shared reservations and TECH invariants stay
enabled. See the updated actor matrix and invariant register.

Further full-game evidence found paired ATTACK/FIGHT orders. AIR's opt-in
controllers now request only the persistent target; all other callers retain
the native fallback. Legion replacement scouts transfer individually, avoiding
whole-cell aborts. A three-owned-mex gate fixes the opening search-cap mistake;
rotated smaller campuses fit constrained terrain while retaining complete
support and aggregate six-lab planning. Large six-lab compounds stay preferred.

Natural handoff failures also showed that cancelling an AI task does not clear
its engine queue. AIR clears a commander factory guard once before another
action waits for a path, stops a released T2 economy aircraft, and stops current
assignees before cancelling an unstarted building. Changing all native guard
semantics or TECH's builder ownership was rejected as unnecessary scope.

Fighter cells now retain eligible contact IDs before assigning free cells; switching merely because contact indexes or positions move was rejected. The full natural repeat still reaches 3482 aircraft orders/minute, so this is not a universal APM bound. The storage transition fix reserves one pending metal store at a time when a nearly full pre-T2 bank cannot contain the loaded lab cost; lowering the income gate was rejected. INV-118 audits that narrow exception. The first natural Tundra repeat reaches T2 lab at 15.00 minutes after admitting its full bank at M10=16. The camera holds an explicit controller through render settling; the idle observer measures continuous guarding of a completed factory, avoiding false positives while finishing replacement labs.

**Verification.** All three experimental script graphs compile; actual engine
initialization succeeds. Native suites, 83 real AngelScript AIR policy tests,
14 arena-validation tests and five independent audit tests pass. The final
native build passes all five supplied-combat maps plus strict escort-incursion,
defensive-return and blocked-backline cases. Forty-five-minute natural games
were run on the same five non-metal maps; their full failures and repeats are
retained in [the results](air-committed-operations-results.md). A final Legion
natural repeat passes all enabled checks after the guard handoff fix. Normal
economic timing and mixed-role TECH checks are not uniformly clean. Earlier
invalid fixtures, an underfunded defensive case and a wall-time-limited run
are not counted as successful acceptance tests. Save/load and 8v8 FPS remain
unverified.

**References.** [Design and PvP sources](air-committed-operations-plan.md),
[results and screenshots](air-committed-operations-results.md),
[machine-readable evidence](benchmarks/d171-air-operations.json).
Escort lead is not an engine speed lock (KI-475); strike scans retain nested
cost (KI-474), and total command/FPS bounds remain unproven (KI-477). The
optional CIRCUIT_AS_INTERFACE dump and compile-only checker accelerate type/API
feedback without replacing real initialization and gameplay.

**Files touched.**
- [data/script/src/global.as](../data/script/src/global.as)
- [data/script/src/helpers/air_math.as](../data/script/src/helpers/air_math.as)
- [data/script/src/manager/air_economy.as](../data/script/src/manager/air_economy.as)
- [data/script/src/manager/air_growth.as](../data/script/src/manager/air_growth.as)
- [data/script/src/manager/air_layout.as](../data/script/src/manager/air_layout.as)
- [data/script/src/manager/air_operations.as](../data/script/src/manager/air_operations.as)
- [data/script/src/manager/air_production.as](../data/script/src/manager/air_production.as)
- [data/script/src/manager/air_raids.as](../data/script/src/manager/air_raids.as)
- [data/script/src/manager/air_recon.as](../data/script/src/manager/air_recon.as)
- [data/script/src/manager/air_screen.as](../data/script/src/manager/air_screen.as)
- [data/script/src/manager/air_waves.as](../data/script/src/manager/air_waves.as)
- [data/script/src/roles/air.as](../data/script/src/roles/air.as)
- [data/script/src/roles/air_build.as](../data/script/src/roles/air_build.as)
- [data/script/src/roles/air_rules.as](../data/script/src/roles/air_rules.as)
- [doc/actor-matrix.md](../doc/actor-matrix.md)
- [doc/air-committed-operations-plan.md](../doc/air-committed-operations-plan.md)
- [doc/air-committed-operations-results.md](../doc/air-committed-operations-results.md)
- [doc/air-wave-attacks.md](../doc/air-wave-attacks.md)
- [doc/angelscript-references.md](../doc/angelscript-references.md)
- [doc/benchmarks/d171-air-operations.json](../doc/benchmarks/d171-air-operations.json)
- [doc/decisions.md](../doc/decisions.md)
- [doc/images/d171/defensive-return.png](../doc/images/d171/defensive-return.png)
- [doc/images/d171/frontline-strike.png](../doc/images/d171/frontline-strike.png)
- [doc/images/d171/glitters-legion-strike.png](../doc/images/d171/glitters-legion-strike.png)
- [doc/images/d171/tundra-island-strike.png](../doc/images/d171/tundra-island-strike.png)
- [doc/images/d171/tundra-natural-opening.png](../doc/images/d171/tundra-natural-opening.png)
- [doc/images/d171/tundra-natural-t2.png](../doc/images/d171/tundra-natural-t2.png)
- [doc/invariants.md](../doc/invariants.md)
- [doc/known-issues.md](../doc/known-issues.md)
- [doc/roles/air.md](../doc/roles/air.md)
- [doc/roles/air_build.md](../doc/roles/air_build.md)
- [doc/roles/air_rules.md](../doc/roles/air_rules.md)
- [src/circuit/script/InitScript.cpp](../src/circuit/script/InitScript.cpp)
- [src/circuit/script/ScriptManager.cpp](../src/circuit/script/ScriptManager.cpp)
- [src/circuit/task/fighter/AirGeometry.h](../src/circuit/task/fighter/AirGeometry.h)
- [src/circuit/task/fighter/AirWaveTask.cpp](../src/circuit/task/fighter/AirWaveTask.cpp)
- [src/circuit/task/fighter/AirWaveTask.h](../src/circuit/task/fighter/AirWaveTask.h)
- [src/circuit/task/fighter/RouteTask.cpp](../src/circuit/task/fighter/RouteTask.cpp)
- [src/circuit/task/fighter/RouteTask.h](../src/circuit/task/fighter/RouteTask.h)
- [src/circuit/terrain/BattleAnalysis.cpp](../src/circuit/terrain/BattleAnalysis.cpp)
- [src/circuit/terrain/BattleAnalysis.h](../src/circuit/terrain/BattleAnalysis.h)
- [src/circuit/unit/CircuitUnit.cpp](../src/circuit/unit/CircuitUnit.cpp)
- [src/circuit/unit/CircuitUnit.h](../src/circuit/unit/CircuitUnit.h)
- [tests/CMakeLists.txt](../tests/CMakeLists.txt)
- [tests/air_geometry_test.cpp](../tests/air_geometry_test.cpp)
- [tests/air_math_tests.as](../tests/air_math_tests.as)
- [tests/production_math_test.cpp](../tests/production_math_test.cpp)
- [tools/compile_script.cpp](../tools/compile_script.cpp)
- [tools/playtest/README.md](../tools/playtest/README.md)
- [tools/playtest/air_arena.py](../tools/playtest/air_arena.py)
- [tools/playtest/air_arena_probe.as](../tools/playtest/air_arena_probe.as)
- [tools/playtest/cases/air/combat/blocked-backline.json](../tools/playtest/cases/air/combat/blocked-backline.json)
- [tools/playtest/cases/air/combat/committed-home-incursion.json](../tools/playtest/cases/air/combat/committed-home-incursion.json)
- [tools/playtest/cases/air/combat/defensive-t3.json](../tools/playtest/cases/air/combat/defensive-t3.json)
- [tools/playtest/analyze_air_natural.py](../tools/playtest/analyze_air_natural.py)
- [tools/playtest/analyze_air_operations.py](../tools/playtest/analyze_air_operations.py)
- [tools/playtest/checks/air/combat/air_arena.json](../tools/playtest/checks/air/combat/air_arena.json)
- [tools/playtest/checks/air/combat/air_committed_incursion.json](../tools/playtest/checks/air/combat/air_committed_incursion.json)
- [tools/playtest/checks/air/reliability/air_compile.json](../tools/playtest/checks/air/reliability/air_compile.json)
- [tools/playtest/checks/air/combat/air_defensive.json](../tools/playtest/checks/air/combat/air_defensive.json)
- [tools/playtest/checks/air/combat/air_frontline.json](../tools/playtest/checks/air/combat/air_frontline.json)
- [tools/playtest/playtest.py](../tools/playtest/playtest.py)
- [tools/playtest/prepare_air_operations_cases.py](../tools/playtest/prepare_air_operations_cases.py)
- [tools/playtest/run_air_natural.py](../tools/playtest/run_air_natural.py)
- [tools/playtest/test_air_operations.py](../tools/playtest/test_air_operations.py)
- [tools/playtest/widgets/air_arena.lua](../tools/playtest/widgets/air_arena.lua)
- [tools/playtest/widgets/air_command_watch.lua](../tools/playtest/widgets/air_command_watch.lua)
- [tools/playtest/widgets/air_opening_watch.lua](../tools/playtest/widgets/air_opening_watch.lua)
- [tools/playtest/widgets/playtest_camera.lua](../tools/playtest/widgets/playtest_camera.lua)
- [tools/run_native_tests.sh](../tools/run_native_tests.sh)


## D-172 - AIR workforce ownership and first advanced-lab capital

**Decision.** Both aircraft constructor tiers are mobile economy workers;
release inherited native guards individually and clear their engine order.
After the initial screen, give funded missing workers a recruitment turn,
including after two combat orders during an incursion. Attempt the first
eligible advanced lab before optional shared reactor growth. Save its full
loaded cost after the existing eight-minute, +12 metal/+450 energy access
conditions; retain recovery, mex work, transports and immediate defense.
The normal +50 metal/+1200 energy admission or full-bank waiver is unchanged.

**Reasoning.** T1 fallback guards checked neither active production nor engine
order lifetime. Repeated fighter-floor/interception orders preceded workforce
recruitment indefinitely. Shared growth preceded first income-qualified lab
placement; below that income, optional spending never explicitly budgeted lab
capital. BAR's low-build-power aircraft need multiple workers and local turret
support. Increasing only constructor caps would not repair order ownership or
recruitment starvation. Global guard changes and command throttles were rejected;
TECH's exact rules and native semantics are unchanged.

**Invariant.** INV-106 now covers both aircraft tiers. INV-119 requires a
funded workforce turn to recruit an available missing constructor. INV-120
requires an eligible first-lab placement attempt before shared reactor growth,
using fresh counts to avoid a just-completed-lab snapshot race.

**Verification.** 98 AIR and 133 shared math tests; three compiled experimental
profiles; 276 API members checked. Final natural Glacial completed T2 at 12:56,
fusion 13:26, bomber 16:24; final natural Caldera T2 15:31, fusion 19:18,
bomber 20:15. Both aircraft tiers left injected non-interruptible guards in
one second, and allied receipts were confirmed. AIR checks were clean in the
final games; Caldera passed all enabled checks. Mixed TECH reports remain FAIL.
An earlier patrol-boundary report is KI-480. See the results for exact run
paths, hashes, limitations, initial diagnostic failures and screenshots.
No save/load or universal FPS/APM claim. Build output was published with the
matched DLL/debug/data; the live game install was not modified.

**Files.**
- [AIR actions](../data/script/src/roles/air_build.as)
- [AIR rules](../data/script/src/roles/air_rules.as)
- [Economy](../data/script/src/manager/air_economy.as)
- [Growth](../data/script/src/manager/air_growth.as)
- [Recruitment](../data/script/src/manager/air_production.as)
- [AIR arithmetic](../data/script/src/helpers/air_math.as)
- [Settings](../data/script/src/global.as)
- [Math tests](../tests/air_math_tests.as)
- [Role reference](roles/air.md), [actions reference](roles/air_build.md), [rules reference](roles/air_rules.md)
- [Invariants](invariants.md), [actor matrix](actor-matrix.md), [known issues](known-issues.md)
- [Plan](air-workforce-repair-plan.md), [results](air-workforce-repair-results.md)
- [Evidence](benchmarks/d172-air-workforce.json)
- [Baseline image](images/d172/glacial-baseline-5.png), [natural image](images/d172/glacial-natural-20.png), [donation image](images/d172/glacial-donation-20.png)
- [Natural runner](../tools/playtest/run_air_natural.py)
- [Guard fixture preparer](../tools/playtest/prepare_air_workforce.py)
- [Workforce observer](../tools/playtest/widgets/air_workforce_watch.lua)
- [Donation fixture](../tools/playtest/widgets/air_donation_fixture.lua)


## D-173 - Committed AIR cleanup after strategic target exhaustion

**Decision.** Let script supply a bounded fallback list shared by launch and
retargeting. Retain strategic targets and the existing armed-static fallback,
then admit other economy/support, approved heavy ground units and other static
targets. All-mobile cleanup is opt-in; preserve the owner's T1-ground exclusion
until explicitly changed. Keep committed offensive survivors airborne and active;
defensive operations retain their return lifecycle. Hold an unlaunched response
whose known nearby T3 payload exceeds the available bombers.

**Reasoning.** The old advanced operation searched only named strategic and armed
structures, then surveyed starts despite known surviving utility buildings. The
Glitters baseline killed the converter but ignored all three stores. Falling back
through broad unarmed/static classes must exclude primary targets; otherwise a
rejected strategic route or opening-force budget could be bypassed. Hidden contacts
are excluded from attack admission, matching the attack-state visibility contract.
The defensive accumulation guard prevents a cheap cleanup commitment from consuming
an incomplete response. Already committed waves are never recalled.

**Alternatives.** Repeatedly resending idle-mode commands was rejected: baseline
and fixed launched cohorts already report fly mode and no active landing in these
tests. The exact reported late-game landing remains unproven. Putting utility
targets ahead of the existing armed-static fallback was rejected on final review
to preserve frontline assault when backline AA blocks ingress. No TECH, legacy
task or economy policy was changed. No global rate limit was introduced.

**Invariant.** INV-116 now includes independently observed engine flight state
for launched cohorts; defensive return is exempt. The cleanup checks require an
explicit lower-priority selection after primary destruction plus actual damage
and death, allowing incidental earlier splash damage.

**Verification.** Built, Checked, Played. Native and policy suites pass; all three
experimental profiles compile/load; 19 arena/attribution tests pass. Final DLL
Glitters tests pass for Phoenix, Armada and Cortex. Radar-only cleanup admission,
defensive return and blocked-backline artillery cases pass. Failed early fixtures
and the overly strict splash-order check are retained. The final script reorder
is separately exercised by blocked-route and cleanup-only games; the other cases
contain no armed structures. Exact source/build hashes, logs, screenshots and
limits are recorded below. Existing strike-calibration and nested-scan concerns
remain KI-457/KI-474. Matched DLL/debug/data published to the required Recoil build
output; live game installation untouched; concurrent map edits excluded.

**Files.**
- [Wave task](../src/circuit/task/fighter/AirWaveTask.cpp), [API](../src/circuit/task/fighter/AirWaveTask.h), [target filter](../src/circuit/task/fighter/AirGeometry.h), [bindings](../src/circuit/script/InitScript.cpp)
- [Operation policy](../data/script/src/manager/air_operations.as), [advanced waves](../data/script/src/manager/air_waves.as), [T1 raids](../data/script/src/manager/air_raids.as), [settings](../data/script/src/global.as)
- [Native filter tests](../tests/air_geometry_test.cpp)
- [Arena runner](../tools/playtest/air_arena.py), [engine observer/camera](../tools/playtest/widgets/air_arena.lua)
- [Glitters case](../tools/playtest/cases/air/combat/cleanup-glitters.json), [cleanup-only case](../tools/playtest/cases/air/combat/cleanup-only-glitters.json), [defensive case](../tools/playtest/cases/air/combat/defensive-t3.json)
- [Cleanup checks](../tools/playtest/checks/air/combat/air_cleanup.json), [cleanup-only checks](../tools/playtest/checks/air/combat/air_cleanup_only.json), [defensive checks](../tools/playtest/checks/air/combat/air_defensive.json)
- [AIR reference](roles/air.md), [script API](angelscript-references.md), [invariants](invariants.md), [actor matrix](actor-matrix.md), [known issues](known-issues.md)
- [Plan](air-bomber-cleanup-plan.md), [results](air-bomber-cleanup-results.md), [evidence](benchmarks/d173-bomber-cleanup.json)
- [Phoenix screenshot](images/d173/phoenix-cleanup.png), [Cortex screenshot](images/d173/cortex-cleanup.png)


## D-174 - Proposed AIR defense of allied bases against ground infiltration

**Decision (proposal only).** Design an immediate available-force response and
one shared twenty-unit recruitment target for observed ground enemies or hostile
structures near active allied bases. Keep visual reconnaissance and a persistent
incident when radar disappears. Prefer timely suitable gunships, with explicit
Cortex EMP/lethal-damage and Legion stockpile/transport distinctions.

**Reasoning.** This matches the owner's cliff factory/jammer example and the
documented defensive use of Roughneck/Wasp. The existing aircraft intrusion
signal and T3 bomber exception do not cover this class of incursion. Waiting for
twenty before fighting loses time. Repeatedly queuing twenty per observation or
per allied AIR invites economic bait. The recommended target stops new spending
after a confirmed clear sweep; this is a proposed refinement, not a silently
implemented exception to the user's requested batch.

**Alternatives and compatibility.** A broad friendly-half-of-map trigger risks
turning front-line combat into permanent emergency production. Use protected
active base areas, independent of TECH's wall exclusion settings and ground
pathability. Reject an EMP-only twenty-Shuriken response, treating Martyr as a
reusable gunship, and choosing the highest-cost flyer solely by tier. Preserve
the owner's earlier committed-escort and transport-priority choices; immediate
response comes from free/new units. Reuse native snapshots and group command
deduplication; keep force and target priorities in script. No rate cap.

**Invariant (proposed).** One recruitment slot has one owner; active plus framed
and reserved defenders are counted once. Only observed or explicitly remembered
contacts drive an incident, and a disappearing radar blip is not a confirmed
clear. No committed escort, player-owned unit or requested ferry is reassigned.
These promises require runtime checks during implementation; they are not yet
enforced by this documentation-only change.

**Verification.** Checked against current AIR script/native dispatch, shared unit
knowledge, local BAR build options and official unit guidance. No implementation,
new build or simulations in this strategy-only turn. Twenty, radii, memory and
reaction budgets are provisional test inputs, not measured optimal values.
The missing behavior remains [KI-482](known-issues.md).

**Files.** [Proposed response plan](air-allied-base-response-plan.md),
[known issue register](known-issues.md), and this decision record.


## D-175 - One metal overflow donation policy for all six roles

**Date:** 2026-10-03. **Status:** Checked; rendered runtime results recorded in
[the validation report](team-metal-sharing.md).

**Decision.** Move D-106's TECH donation implementation and its one cooldown
into TeamEconomy, invoked once after the shared economy callback's role
adjustment. TECH, AIR, FRONT, SEA, TACTICAL and SUPPORT share at an inclusive
95% storage threshold, budgeting at most 20% of storage every five seconds,
with 25-metal minimum gifts and the same lowest-filled live-ally ordering.
This includes human teammates. Preserve the Tech::TeamShare* setting names as
the sole configuration so existing overrides continue to work for all roles;
reject six copied policies/settings that could drift.

**Opening and ownership.** TECH keeps its original completed T1 bot lab or
WasIntoT2 recovery gate. Other roles latch eligibility on a completed native
factory of any terrain/tier; frames and constructor-only starts cannot donate
their opening bank. The latch survives role changes and factory reclaim/loss
within an instance. TECH's unrelated air-constructor refill/cap/layout upkeep
stays in TechBuild::Tick. The prior lack of script save-state persistence is
unchanged (KI-209); a restored instance reconstructs eligibility from extant
factories/T2 state rather than a serialized historic latch. Save/load during
a factory-free recovery is not established by these tests.

**Invariant.** INV-033 now runs from the shared economy callback for every
role after opening eligibility: the bank does not remain at/above the threshold
for 60 seconds while a live teammate has a quarter of our capacity free. Pure
allocation tests cover exact threshold, opening protection, storage-based budget,
overdraw, recipient capacity, minimum gift and one budget across recipients.

**Scope.** No C++ or UnitDef/profile-classification changes. Legacy profiles
remain on their prior behavior (KI-483). Near-full-team recirculation is a
separate recipient-policy follow-up (KI-484), not silently changed as part of
matching TECH. The test fixture supplies banks and occasional missing factories;
it does not measure natural economy strength. The native/AngelScript suite,
three profile compilations and script/DLL parity pass; see the report for
individual rendered runs and transfer audits.

**Files.** [team economy](../data/script/src/manager/team_economy.as),
[shared callback](../data/script/src/manager/economy.as),
[TECH upkeep](../data/script/src/roles/tech_build.as),
[settings](../data/script/src/global.as),
[invariant checker](../data/script/src/manager/invariants.as),
[allocation arithmetic](../data/script/src/helpers/team_share_math.as),
[allocation tests](../tests/team_share_math_tests.as),
[test runner](../tools/run_native_tests.sh),
[fixture preparer](../tools/playtest/prepare_team_share_check.py),
[fixture widget](../tools/playtest/widgets/team_share_fixture.lua),
[runtime checks](../tools/playtest/checks/shared/cooperation/team_share.json),
[transfer audit](../tools/playtest/audit_team_share.py),
[script guide](../data/script/README.md),
[TECH build reference](roles/tech_build.md),
[layout/sequence reference](roles/tech-layout-and-sequence.md),
[invariant register](invariants.md), [actor matrix](actor-matrix.md),
[known issues](known-issues.md), [plan and results](team-metal-sharing.md).

**D-175 evidence artifacts.** [Audit manifest](benchmarks/d175-team-sharing.json),
[hard screenshot](images/d175/sharing-hard.png),
[terrible screenshot](images/d175/sharing-terrible.png). All six roles sent in
all three rendered profiles; balanced strict PASS, hard/terrible strict FAIL
on KI-427 INV-008. The 196 hard/terrible donation decisions pass their focused
audit. This makes the donation change Played, without claiming the full-match
failures resolved.


## D-176 - Hand bomber attacks off before overflight; interrupt for local visible AFUS

**Date:** 2026-10-03. **Status:** Built, Checked and Played; measurements and
exact binary identities are in the [validation report](air-afus-attack-handoff-results.md).

**Decision.** Experimental AIR enables an early ATTACK handoff before the
last target-centre MOVE leg, plus an offensive-only local priority override.
A stationary allowed target of priority 4 or higher, currently in team LOS
within 1,800 elmos of the bomber cohort centre, interrupts travel/search or a
lower-priority attack. AIR already assigns AFUS priority 4. Native defaults
are disabled; the script owns enabling, priority and radius. Defensive sorties
receive the earlier terminal approach but retain their own T3 policy and
return path. TECH's building sequence and other roles' policy are untouched.

**Why.** The operation path held fire while waiting for an arrival quorum at
the target itself. It did not use the older synchronized strike path. In the
baseline Glitters fixture a visible local AFUS waited 16.33 seconds for ATTACK,
while the wave approached storage first. Independent engine-command observers
measure 0.33 seconds in the Legion, Armada and normal-LOS Cortex fixes. Early
collateral damage in the baseline is why damage alone was insufficient proof.

**Alternatives.** Reject enabling unrestricted fire-at-will (would bypass T1
target exclusions), repeated ATTACK refreshes (command traffic and reset
bombing runs), global AFUS diversion (would abandon edge routes for distant
allied sightings), or waiting at the target for all formation slots. Retain
assembly and intermediate cohort legs; once a visible priority target is
attacked keep it instead of oscillating between nearby reactors. The radius
uses the cohort centre and team LOS, not an expensive enemy-by-aircraft scan.
There is no new rate limit, worker thread or durable task state. Existing
transient-wave save/load limitations remain; existing KI-474 performance and
KI-475 geometric escort limitations are not claimed solved.

**Invariant.** INV-121 prohibits stale formation MOVE after attack handoff.
The production task rejects/logs that transition. The independent arena reads
actual bomber queues and fails when a qualifying AFUS waits more than one
second for all cohort ATTACK orders. INV-115 escort ownership and INV-116
no offensive return/landing remain enforced. Failed/hidden contacts are not
permission to use omniscient target data. A native attack command is not an
instantaneous weapon-fire guarantee.

**Verification.** Native suites and 288 script arithmetic assertions pass;
all three experimental profiles compile against runtime-exported declarations
and load in rendered faction tests. Glitters AFUS destruction and subsequent
cleanup pass for Legion, Armada and Cortex; the normal-LOS Cortex run uses the
final reviewed DLL. Supreme's defensive T3 sortie attacks and returns home.
No full economy or large multiplayer performance claim. Source/data staging
excludes the concurrent unrelated map work. Details and strict verdicts are
recorded in the report rather than inferred from screenshots alone.

**Files.** [Native wave mechanism](../src/circuit/task/fighter/AirWaveTask.cpp),
[wave contract](../src/circuit/task/fighter/AirWaveTask.h),
[geometry policy helpers](../src/circuit/task/fighter/AirGeometry.h),
[native assertions](../tests/air_geometry_test.cpp),
[binding](../src/circuit/script/InitScript.cpp),
[AIR operation policy](../data/script/src/manager/air_operations.as),
[settings](../data/script/src/global.as), [AIR reference](roles/air.md),
[API reference](angelscript-references.md), [actor matrix](actor-matrix.md),
[invariants](invariants.md), [plan](air-afus-attack-handoff-plan.md),
[results](air-afus-attack-handoff-results.md),
[arena observer](../tools/playtest/widgets/air_arena.lua),
[initial fixture](../tools/playtest/cases/air/combat/afus-handoff-glitters.json),
[reveal fixture](../tools/playtest/cases/air/combat/afus-reveal-glitters.json),
[strict checks](../tools/playtest/checks/air/combat/air_afus_handoff.json),
[timing audit](../tools/playtest/audit_afus_handoff.py),
[baseline screenshot](images/d176/baseline-visible.png),
[Legion screenshot](images/d176/legion-afus.png),
[Armada screenshot](images/d176/armada-afus.png),
[Cortex screenshot](images/d176/cortex-afus.png),
[defense screenshot](images/d176/defensive-shiva.png).

**Evidence.** [Pinned build and run manifest](benchmarks/d176-afus-handoff.json).
All four fixed strict reports PASS; the old-DLL baseline fails INV-121 as expected.

## D-177 - Verify edge routes through actual flight without retuning AIR

**Date:** 2026-10-03. **Status:** Checked and Played against the published
D-176 DLL; no production source, script policy or binary change.

**Decision.** Preserve the existing direct/four-edge planner, intermediate
formation legs and local AFUS handoff. Add opt-in fixture observation of the
live bomber cohort crossing a defended corridor, with screenshots and target
damage/destruction. Experimental STRIKE missions can use an edge ingress;
the historical randomized FLANK/PINCER labels are not evidence that this path
is disabled. Do not change gameplay to satisfy a verification-only request.

**Why and alternatives.** A selected `route=edge` log cannot prove the units
flew it. Actual positions on two maps show they did: Supreme west with Armada,
Glitters east with Cortex under normal visibility. Both reached and destroyed
the AFUS after the crossing; local AFUS ATTACK handoff took 0.33 seconds.
Reject retuning threat weights or assuming flak removal alone makes a clear
control. Two initial controls still had an enemy commander near the targets'
exit corridor and failed the direct-crossing expectation. Keep those failures
in the evidence. A corrected control separates the targets from the commander
and the unchanged AI selects and flies direct. This is not a per-candidate
threat-cost attribution or an economy/performance benchmark.

**Invariant.** Existing INV-115 escort ownership, INV-116 offensive commitment
and INV-121 attack handoff remain enforced. The test-only route observer
raises `event=error` if a required flank crosses the configured central band;
strict checks forbid that event and all runtime invariants. It measures cohort
centre every 60 frames, not each aircraft's individual AA clearance. No new
production invariant or actor state is needed because no behaviour changed.

**Verification.** Both defended cases and the corrected clear control pass
rendered 8-10 minute runs. Both discarded control designs remain strict FAIL
for their missing direct crossing. No runtime invariant, script, fixture or
crash failures in any of the five games. Two factions and two experimental
profiles were played, not all maps or legacy randomized attack modes. Existing
KI-474 performance and KI-475 exact escort-speed limitations remain outside
this verification.

**Files.** [Plan, results and reproduction](air-edge-flank-verification.md),
[measurement manifest](benchmarks/d177-air-routes.json),
[read-only route observer](../tools/playtest/widgets/air_arena.lua),
[Supreme fixture](../tools/playtest/cases/air/combat/edge-supreme.json),
[Glitters fixture](../tools/playtest/cases/air/combat/edge-glitters.json),
[clear control](../tools/playtest/cases/air/combat/direct-glitters.json),
[edge checks](../tools/playtest/checks/air/combat/air_edge.json),
[direct checks](../tools/playtest/checks/air/combat/air_direct.json),
[Supreme edge](images/d177/supreme-edge.png),
[Supreme strike](images/d177/supreme-afus.png),
[Glitters edge](images/d177/glitters-edge.png),
[Glitters strike](images/d177/glitters-afus.png),
[direct control](images/d177/glitters-direct.png).


## D-178 - Categorize tests and new evidence while preserving benchmark history

**Date:** 2026-10-03. **Status:** Checked and Played (tooling integration).
No AI policy, UnitDef, native source or production binary change.

**Decision.** Separate reusable cases/checks, local engine working state,
archived observations, immutable compact publications and generated discovery.
Use domain/area/scenario/map folders and UTC IDs with a random suffix for new
games. Move the 97 definitions byte-for-byte with legacy-path aliases. Keep all
70 historical benchmark files, 60 images, scorecard cohorts/ratings and existing
raw game directories unchanged; index them rather than renaming their evidence.
The generic runner retains its explicit/legacy-directory workflow; AIR,
scorecard and rush-loop defaults allocate new categorized games.

**Why and alternatives.** Moving 129,211 files of historical engine state would
break raw evidence paths and add risk without making results more comparable.
Reject a timestamp-only archive name or replacing a rush row with the same ID:
both can lose evidence. Use exclusive allocation, an atomic locked rush-ledger
write, and conflicting-ID rejection. Reject rebuilding scorecards from a reused
working directory when the original archived inputs exist. Preserve the original
manifest and record engine enrichment separately. Scope Git's no-conversion
attribute to new published evidence so its SHA-256 values survive checkout.
Keep generated views/revisions distinct from games; supplied combat is never a
natural-economy or confirmed-win benchmark merely because its checks pass.

**Invariant.** No historical observation or benchmark row is silently replaced.
Identical publication is idempotent; changed evidence, conflicting IDs and live
snapshots are rejected. Archived settings/checks remain tied to the observed
run after restaging. Every nested check continues to forbid runtime invariants.
These are tooling contracts covered by Python tests; no production actor or
new in-game invariant is introduced.

**Verification.** The cutover hash audit passes for all 97 definitions and 130
historical benchmark/image files. The playtest tooling suite covers migration,
aliases, collisions, archive provenance, publication, scorecard conditions and
ratings, and preserved rush rows. A rendered Cortex direct-route arena on All
That Glitters passed strict checks at four game minutes using the unchanged
D-176 DLL: 14 bombers crossed directly and destroyed the AFUS at 2:14. The run
was archived, published with a screenshot, indexed, and published again with
no duplicate or replacement. This verifies the tooling lifecycle, not new
gameplay strength. Full-match economy simulations were not rerun for folder
changes. Historical missing-hover-document links remain KI-404.

**Files.** [Storage design and validation](test-storage.md),
[every moved definition](test-storage-moves.md),
[cutover hash manifest](test-storage-migration.json),
[storage implementation](../tools/playtest/storage.py),
[compatibility aliases](../tools/playtest/storage-aliases.json),
[storage tests](../tools/playtest/test_storage.py),
[watcher](../tools/playtest/playtest.py), [arena runner](../tools/playtest/air_arena.py),
[arena tests](../tools/playtest/test_air_arena.py),
[rush tracker](../tools/playtest/benchmark.py), [rush loop](../tools/playtest/bench_loop.sh),
[scorecard runner](../tools/playtest/scorecard_run.py),
[scorecard archive handling](../tools/playtest/scorecard.py),
[scorecard tests](../tools/playtest/test_scorecard.py),
[strike preparer](../tools/playtest/prepare_air_strike_check.py),
[recursive invariant checker](../tools/knowledge/check_invariants.py),
[case naming](../tools/playtest/cases/README.md),
[check naming](../tools/playtest/checks/README.md),
[runner guide](../tools/playtest/README.md),
[playtest skill](../skills/playtest/SKILL.md),
[repository map](../AGENTS.md), [byte-preservation attributes](../.gitattributes),
[benchmark guide](benchmarks/README.md), [catalog](benchmarks/catalog.json),
[AIR index](benchmarks/index/air.md), [TECH index](benchmarks/index/tech.md),
[FRONT index](benchmarks/index/front.md), [SEA index](benchmarks/index/sea.md),
[TACTICAL index](benchmarks/index/tactical.md), [SUPPORT index](benchmarks/index/support.md),
[shared index](benchmarks/index/shared.md),
[rendered integration evidence](benchmarks/records/air/combat/direct-glitters/2026-10-03/20261003T130427Z-8c8bf821/README.md).
Historical documentation paths were updated in [AFUS results](air-afus-attack-handoff-results.md),
[edge verification](air-edge-flank-verification.md), [idle-factory investigation](air-idle-factory.md),
[opening/screen reference](air-opening-and-screen.md), [issue register](known-issues.md),
[flank review](reviews/2026-09-29-ascendancy-flank-effectiveness.md),
[lanes reference](roles/tech-lanes.md), and earlier entries in this decision record.


## D-179 - AIR opening support, compact factories and LOS-spaced recon (2026-10-03)

**Decision.** Fund two early support turrets after the first three constructors
and initial fighter screen, ahead of extra peacetime aircraft. Preserve demand
when initial support pins are missing so repair can run. Add a saved configurable
1-10 T1 raid (Legion uses Mosquito gunships). Pack AIR lab rows together with
rear support banks and explicit cached bay ownership. Recon uses loaded sight,
a map-centred friendly formation, per-member arrival tracking, synchronized
straight MOVE legs, then nearby-base patrols through one shared native task.
TECH's sequence/geometry, transports, recovery and the metal opening retain
precedence. Existing saved reservations remain valid.

**Why and alternatives.** Lowering the income gate alone could not repair a
starter with no pins: zero pins made its support target zero forever. Only
viable/active support sites reserve a production budget; blocked sites cannot
freeze the factory. Individual edge clamping piles scouts together, so fit a
whole formation, try transverse centring, then reduce spacing if necessary.
Waiting for twenty fixed-wing orbit phases to coincide delayed dispatch for
minutes: each plane must instead visit its slot and remain within the bounded
holding envelope. Avoid repeated corrective orders. C++ provides geometry and
read-only LOS; policy and settings remain in script. The raid draw does not
waive visibility/payload admission or invent a Legion bomber build option.

**Invariants.** INV-122 checks completed crew/support at opening recruitment and
exact transferred bomber count. INV-123 checks complete recon transfer and
straight MOVE route admission. INV-084/109 continue to protect complete support
and reservation ownership. Physical/pure tests verify non-overlap, reach and
twenty turrets credited to each of six advanced labs.

**Verification.** Native suite, 303 pure script tests, 66 tooling tests and
script/DLL parity passed. Final rendered Supreme/Glacial recon fixtures pass:
twenty dispatch together and twenty enter base surveying. Six T2 labs and 120
nanos physically fit. Three natural faction openings complete support and
recruit their batch; Supreme launches it. Full natural verdicts remain FAIL
for existing TECH/ferry invariants. Single-bomber Glacial dispatch is unobserved
(KI-485); human takeover/release remains unplayed (KI-479). No 8v8 strength/FPS
guarantee. [Plan, settings, times and retained evidence](air-opening-recon-plan.md).

**Files.** [Settings](../data/script/src/global.as),
[math](../data/script/src/helpers/air_math.as),
[economy](../data/script/src/manager/air_economy.as),
[layout revision](../data/script/src/manager/air_layout.as),
[production](../data/script/src/manager/air_production.as),
[T1 raids](../data/script/src/manager/air_raids.as),
[recon](../data/script/src/manager/air_recon.as),
[building](../data/script/src/roles/air_build.as),
[rules](../data/script/src/roles/air_rules.as),
[LOS binding](../src/circuit/script/InitScript.cpp),
[geometry](../src/circuit/terrain/BaseLayoutGeometry.h),
[geometry tests](../tests/base_layout_geometry_test.cpp),
[policy tests](../tests/air_math_tests.as),
[fixture preparer](../tools/playtest/prepare_air_recon_check.py),
[probe](../tools/playtest/air_recon_probe.as),
[observer](../tools/playtest/widgets/air_recon_watch.lua),
[checks](../tools/playtest/checks/air/combat/air_recon.json),
[arena compatibility](../tools/playtest/air_arena.py),
[natural-run metadata](../tools/playtest/run_air_natural.py),
[runner guide](../tools/playtest/README.md),
[AIR reference](roles/air.md), [action reference](roles/air_build.md),
[rule reference](roles/air_rules.md), [layout reference](base-layout.md),
[API reference](angelscript-references.md), [invariants](invariants.md),
[actors](actor-matrix.md), [verification gaps](known-issues.md),
[benchmark catalog](benchmarks/catalog.json), [AIR index](benchmarks/index/air.md).


## D-180 - Review AIR build-power allocation before replacing its scaling policy

**Decision.** Record the requested review and recommend a shared spending-gap
signal with role-specific capacity allocation. Make no gameplay changes in this
review. Preserve TECH's exact sequence, thresholds and reclaim rules; do not call
its mutable role state from AIR.

**Reasoning.** AIR shares the chooser but not TECH's bank-trend response or
calculated support batches. Independent targets, broad static counts, budget
holds and assistance horizons can hide useful capacity shortages. The legacy
three-constructor fallback is bypassed. Native recruit priority is a separate
risk requiring an observed reproduction. Raising caps or using income minus
requested pull would leave the interactions unresolved. Usage and transfer
observations already have script bindings; no new resource API is needed.

**Invariant.** Preserve existing ownership, opening, allied reservation,
twenty-support-per-lab and TECH build/reclaim promises. Proposed checks will
ensure a funded reachable shortage is not masked by unavailable support or BP
credited to two concurrent workloads. No new runtime invariant is added before
its behavioral implementation exists.

**Verification.** Source trace and retained D-179 Glacial team-0 telemetry;
133 production and 113 AIR tests pass. Five temporary probes confirm the current
arithmetic, not corrected behavior. No new game ran. Six unresolved findings
are KI-486 through KI-491. Official BAR economy/air guidance informs the plan;
the proposed controller is distinguished from published advice.

**Files.** [Review and correction plan](reviews/2026-10-03-air-build-power-review.md),
[unresolved findings](known-issues.md), and this decision record.


**D-180 donation amendment (2026-10-03).** A positive self-income/spending gap
is not mandatory. Sustained full/refilling storage may fund useful BP despite
negative own or recurring balance, provided a bounded investment and its work
preserve metal/energy reserves if future donations stop. Sample actual transfers
once per engine resource interval; avoid double-counting native receipt-inclusive
income or treating circulation as production. Preserve the existing donation
threshold/percentage and TECH behavior. The review adds two computed runway
examples and the donation-specific test matrix. This is design only, without
new gameplay code, runtime invariants or simulations.


**D-180 implementation-map amendment (2026-10-03).** Map the known fixes to
functions, lifecycle/adoption work, metal-map early-return paths and independent
acceptance checks before implementation. Keep TECH call sites unchanged by
default; shared arithmetic extraction is optional and requires exact outcome
parity. Keep economy support slots separate from the existing reactor/converter
array so old named state and placement semantics survive. Use one sampled
workforce decision with immediate admission deltas instead of independent
budgets that can disagree or double-spend. Reject a global native recruitment
priority rewrite: the task-scoped opt-in remains conditional on a progress-based
reproduction. These choices preserve TECH behavior and bound the AIR repair.

**Verification.** Source tracing covers the mapped callers and current test
helpers; four synthetic regex probes confirm new KI-492. The plan identifies
pure tests, supplied fixtures, five-map natural cohorts, three metal-map
controls, TECH regressions, lifecycle checks, screenshots and 8v8 performance
measurements. These are future acceptance tests, not simulation results.
No gameplay code, runtime invariant or test definition changed in this amendment.
The invariant promises in D-180 remain unchanged.

**Files.** [Expanded plan](reviews/2026-10-03-air-build-power-review.md),
[test-check finding](known-issues.md#ki-492---air-build-power-checks-match-count-prefixes-and-narrow-historical-ranges),
and this decision record.


## D-181 - Fund AIR workforce from useful work and stored capital

**Decision.** Implement the D-180 policy in AIR-owned sampled state and shared
pure arithmetic. Own production and actual usage are distinct from receipts;
future gifts are not forecast. A sustained full/refilling bank can pay for
useful build power while own income is negative, subject to both resource
reserves and outstanding investments. Debit accepted costs and incremental
spending before another callback can spend the same budget. Constructor floors
and ordinary/safety ceilings remain guards; available and arriving workers
reduce the next request. Record real target progress and suppress expansion
behind stalled assignments instead of treating nominal assignment as work.

Remove the opening-bomber/support and first-lab blanket workforce vetoes.
Protect concrete lab capital and opening/transport prerequisites. Place economic
support in twelve separate, atomically reserved pins per AFUS module; preserve
the original nine-slot array and named-state adoption. Exclude those turrets
from factory support and dispatch them to reachable economic frames. AIR asks
for support before shared growth, without changing TECH's chooser or sequence.
Metal-mode AIR already calls these actions; its dedicated opening workers retain
priority. Observe existing construction on AIR role entry so a previous role's
unframed native orders cannot bypass ownership reconciliation.

**Alternatives rejected.** Raising every fixed constructor cap blindly would
buy idle workers without checking energy or useful demand. Requiring positive
own-income balance rejects usable donated capital. Adding receipts to the
native receipt-inclusive average double-counts transfers. Crediting factory
nanos to distant reactors misstates capacity. Appending support to the reactor/
converter slot array breaks its loader and placement indices. Rewriting native
recruit priority globally would affect TECH; observed priority-zero constructors
made progress and finished, so the conditional exception is not implemented.
A matched causal priority experiment remains an explicit verification gap.

**Invariant.** INV-124 requires same-frame two-resource funding for discretionary
workforce admissions, with opening/recovery exceptions explicit. INV-125 keeps
factory and economy support disjoint. INV-126 audits assignment ownership.
Existing INV-076, INV-090, INV-106 and INV-107 continue to protect task ownership,
twenty-per-lab support, guard release and complete economic reservations.

**Verification.** Built and played through the supplied, natural, metal and TECH
matrix. Nineteen pure funding/capacity tests pass; all existing standalone native and
AngelScript suites passed. All three experimental profiles compiled and ran
against the pinned DLL. Physical support, donor cessation, blocked support,
old-state adoption and role handoff have played evidence. Failed initial runs
are retained. See [results and limitations](air-workforce-results.md) for the
final verification extent; no claim of globally optimal or universally
pre-twenty-minute economy is made.

**Files.** Policy:
[workforce](../data/script/src/manager/air_workforce.as),
[arithmetic](../data/script/src/helpers/build_power_math.as),
[settings](../data/script/src/global.as),
[economy](../data/script/src/manager/air_economy.as),
[production](../data/script/src/manager/air_production.as),
[growth](../data/script/src/manager/air_growth.as),
[economy layout](../data/script/src/manager/air_eco_layout.as),
[layout entry](../data/script/src/manager/air_layout.as),
[actions](../data/script/src/roles/air_build.as),
[rules](../data/script/src/roles/air_rules.as).
Tests and evidence:
[math tests](../tests/build_power_math_tests.as),
[CMake](../tests/CMakeLists.txt), [test runner](../tools/run_native_tests.sh),
[fixture runner](../tools/playtest/run_air_workforce.py),
[probe](../tools/playtest/air_workforce_probe.as),
[fixture widget](../tools/playtest/widgets/air_workforce_fixture.lua),
[independent observer](../tools/playtest/widgets/air_workforce_watch.lua),
[budget checks](../tools/playtest/checks/air/economy/air_workforce_budget.json),
[count/progress checks](../tools/playtest/checks/air/economy/air_build_power.json),
[focused audit](../tools/playtest/audit_air_workforce.py),
[metrics](../tools/playtest/workforce_metrics.py),
[metrics tests](../tools/playtest/test_air_workforce.py),
[paired cohort](../tools/playtest/run_air_workforce_cohort.py),
[natural runner](../tools/playtest/run_air_natural.py),
[natural analysis](../tools/playtest/analyze_air_natural.py),
[matched comparison](../tools/playtest/analyze_air_workforce_cohort.py),
[metal/TECH controls](../tools/playtest/run_workforce_regressions.py),
[8v8 controls](../tools/playtest/run_workforce_performance.py),
[performance observer](../tools/playtest/widgets/workforce_perf_watch.lua),
[performance analysis](../tools/playtest/analyze_workforce_performance.py),
[timer contract test](../tools/playtest/test_workforce_perf_watch.py),
[performance checks](../tools/playtest/checks/air/performance/air_workforce_performance.json),
[donation case](../tools/playtest/cases/air/economy/workforce-donations.json),
[six-lab case](../tools/playtest/cases/air/economy/workforce-six-labs.json),
[energy case](../tools/playtest/cases/air/economy/workforce-energy-starved.json),
[lifecycle case](../tools/playtest/cases/air/economy/workforce-lifecycle.json).
Documentation:
[results](air-workforce-results.md), [review](reviews/2026-10-03-air-build-power-review.md),
[AIR](roles/air.md), [actions reference](roles/air_build.md),
[rules reference](roles/air_rules.md), [layout](base-layout.md),
[invariants](invariants.md), [actors](actor-matrix.md), [issues](known-issues.md),
[playtest guide](../tools/playtest/README.md), and this record.


**Final accounting review.** Existing assignments, including travellers and
energy-limited workers, consume newly fundable project demand before another
investment. Delivered progress plus affordable extra spending defines desired
power; current assignments and queued support are subtracted once. Production
turret admissions do not reduce the separate economic shortage, even inside one
snapshot. Tests cover both corrections. Assistance uses delivered power rather
than adding affordable extra capacity repeatedly to the assignment total.

**Evidence handling.** Natural comparisons stop at the earlier AIR removal
frame; an advancing spectator clock after defeat is not live economic evidence.
Initial per-run analyses remain immutable. The version-2 cohort measurements
in the results document supersede their uncensored comparisons. Engine AI timer
measurements cover all AI callbacks, not isolated AIR census CPU time.

**Ownership review.** PLAYER/RETREAT tasks do not cast to builder tasks, but that
does not make their workers available. The final census admits idle task kinds
explicitly; it never releases protected ownership. The lifecycle probe uses
the existing UnitControl API to hold and return a constructor.

Additional verification files: [fixed-population runner](../tools/playtest/run_workforce_scaling.py),
[population widget](../tools/playtest/widgets/workforce_scaling.lua),
[scaling analysis](../tools/playtest/analyze_workforce_scaling.py),
[scaling checks](../tools/playtest/checks/air/performance/air_workforce_scaling.json),
[timer contract test](../tools/playtest/test_workforce_perf_watch.py),
[performance checks](../tools/playtest/checks/air/performance/air_workforce_performance.json),
[initial portable cohort](benchmarks/air-workforce-cohort-2026-10-03.json),
[final portable cohort](benchmarks/air-workforce-final-2026-10-03.json),
and the generated [evidence catalog](benchmarks/catalog.json).

**Final handoff correction.** The strengthened lifecycle run passed PLAYER
ownership but exposed an unassigned native nano left by SUPPORT. A walk of
current unit tasks cannot see it. AIR entry now searches reachable unassigned
nanos through the existing native API before enabling its layout-only filter,
cancels unframed orders and retains frames. The follow-up sixteen-minute
lifecycle game passed every assertion with no invariant or script failure.
The lookup is bounded and entry-only; it does not assign its probe builder.

**Final measurements.** Nineteen policy and 81 tooling tests pass. The final
strengthened lifecycle and both supplied-factory population controls pass.
Natural and TECH whole-game results remain mixed. Serial 8v8 measurements
retain elimination/population caveats; idle-population p99 shows measurable
additional observation cost, so no zero-overhead or FPS guarantee is claimed.
[8v8 evidence](benchmarks/air-workforce-performance-2026-10-03.json),
[final scaling](benchmarks/air-workforce-scaling-2026-10-03.json),
[initial scaling failures](benchmarks/air-workforce-scaling-initial-2026-10-03.json),
and [intermediate control failures](benchmarks/air-workforce-scaling-partial-control-2026-10-03.json)
retain all interpretations separately from the immutable raw publications.

**Published-byte preservation.** The existing publisher emits a terminal blank
line in generated record READMEs. Reformatting immutable publications would
change retained bytes. [Git attributes](../.gitattributes) therefore permit that
format only under benchmark records; source and ordinary documentation retain
strict whitespace checks. No published file is rewritten for formatting.


## D-182 - TECH Telchines require a landlocked start

**Date:** 2026-10-03. **Status:** Played; focused recruitment checks pass, full games retain known TECH invariant failures.

**Decision.** Restrict TECH Telchine recruitment to its own map start's
`LandLocked` flag, including native fallback when amphibious waves are disabled.
The existing ground batch remains Sprinter/Fiend/Hoplite on ordinary starts.
The latest owner instruction narrows D-160's TECH recruitment scope; its
budget and all lab/economy sequencing remain unchanged. AIR and Marauders keep
their existing policies. Already-owned/gifted Telchines keep their controller.

**Reasoning.** The unconditional shared amphibious producer ran before TECH's
correct ground/island selection and could spend the separate +80 budget on
Supreme Isthmus, whose TECH starts are both explicitly not landlocked. Water
elsewhere on a map does not make that start eligible. Gate only recruitment,
not the combat controller needed to use donated or surviving units.

**Alternatives rejected.** A Supreme-only map ban misses other connected
starts. Disabling the whole amphibious controller breaks legitimate island
recruitment, Marauder raids and donated units. Changing the ordinary combat
gate or TECH's exact lab cycle is unnecessary.

**Invariant.** INV-127: a TECH start that is not landlocked never completes a
locally produced Telchine. The unit-added check excludes gifts without a local
producer. Existing INV-010 continues to enforce the ordinary combat gate.

**Files.** [Pure eligibility](../data/script/src/helpers/amphibious_math.as),
[production and native fallback](../data/script/src/manager/amphibious_ops.as),
[runtime invariant](../data/script/src/manager/invariants.as),
[unit tests](../tests/amphibious_math_tests.as),
[observer](../tools/playtest/widgets/tech_t2_start_watch.lua),
[ground check](../tools/playtest/checks/tech/combat/t2_ground_start.json),
[landlocked check](../tools/playtest/checks/tech/combat/t2_landlocked_start.json),
[TECH reference](roles/tech.md), [actor matrix](actor-matrix.md),
[invariant register](invariants.md), [known issues](known-issues.md),
[evidence catalog](benchmarks/catalog.json), [TECH evidence index](benchmarks/index/tech.md)
and [verification report with immutable run records](tech-t2-start-results.md).

**Verification.** Twenty-two pure policy tests and script/DLL API parity pass.
Both TECH instances compiled in the engine. At forty minutes Supreme completed
107 Hoplites and 92 Sprinters, with no Telchines; Tundra completed 22 Telchines
and no Hoplites for Legion. Both focused audits pass. Whole games remain FAIL
for known TECH invariant categories (KI-472), with zero script errors/INV-127.
No new AIR/Marauder or waves-disabled fallback game was run. See the report
for immutable evidence, screenshots and all verification limits.


## D-183 - Investigate first bomber wave starvation without waiving launch budgets

**Date:** 2026-10-03. **Status:** Investigated; existing game evidence and pure
policy checks, no gameplay changes or new simulation.

**Decision.** Record the actual first-wave admission gates and the observed
18/20 Phoenix delay. Recommend bounded funded quota completion and explicit
blocked-state/reconnaissance handling. Preserve current gameplay in this
investigation, which asks why the wave waits and what triggers launch.

**Reasoning.** The matching Supreme game drew 20 and held 18 for roughly
nineteen game minutes before launching. Current production can postpone the
last orders indefinitely. The logs do not name all launch vetoes, so neither
missing escorts nor lack of vision is established as the sole cause. The
owner has not yet confirmed this is the reported match.

**Alternatives rejected.** Merely disabling landing leaves the same wait in
the air. Changing the legacy eight-minute timeout does not affect the
experimental branch. Blind timed release can waive required damage or send
an unfunded raid through known AA; lowering the configured opening quota
conceals its incomplete production rather than coordinating the two owners.

**Invariant.** No new runtime invariant: no behavior fix is shipped. Existing
operation payload/route and committed-escort policies remain unchanged. A
follow-up fix must check bounded readiness progress and exercise physical
assembly, ingress and weapon damage, not just a launch log.

**Files.** [Investigation and evidence](reviews/2026-10-03-air-first-wave-stall.md),
[known issues KI-493 and KI-494](known-issues.md), and this decision record.

**Verification.** 113 existing AIR math tests and six scratch policy probes
pass. The local log records the quota, held pool, resumed bomber production
and 38:48 launch. Current installed policy files match the repository after
newline normalization; the historical match build is not pinned. See the
report for exact evidence, uncertainty and proposed regression cases.


## D-184 - Construction turret enemy reclaim interrupts ordinary AI work

**Date:** 2026-10-03. **Status:** Implemented; build and runtime verification in progress.

**Decision.** Apply the owner's highest-priority enemy reclaim instruction
through the shared native assistant manager, with JSON/script enable controls.
Use actual assist/reclaim capabilities, covering floating and Extra Units
variants without a faction/name allowlist. Retain targets and commands while
valid. Player control remains authoritative; enemy denial overrides
no_disrupt factory bindings and friendly recycling, including at full metal.
This narrows D-078/D-117's ordinary duty rules during a local enemy contact.

**Reasoning.** Idle-only role rows cannot interrupt repair/guard/recycling.
Static wreck reclaim currently yields to repair and full metal, so it needs
a distinct enemy mode. One shared response reaches legacy and experimental
profiles and preserves the original economic behavior once enemies leave.

**Alternatives rejected.** Per-role copies omit legacy and optional variants.
Permanent area reclaim would abandon productive assistance and repeatedly
issue commands. Aborting an entire shared construction task interrupts other
workers unnecessarily; only the affected turret leaves its old assignment.

**Invariant.** INV-128: an eligible turret must take a NOW enemy-reclaim task
before ordinary AI work. Existing friendly-reclaim/factory-duty invariants
yield only during that explicit task. Physical interruption, damage and
resumption are separately checked in the supplied game fixture.

**Files.** [Implementation, all touched source/test files and verification](turret-enemy-reclaim.md),
[API reference](angelscript-references.md), [invariants](invariants.md),
[actor matrix](actor-matrix.md) and this record.

**Verification.** Built, Checked and Played: all three experimental profiles pass twelve variants across six roles (216 physical reclaims and returns to repair), plus capture, neutrality, range exit/re-entry, turret removal and player takeover. Full native tests pass. The implementation record retains exact evidence, legacy coverage and limits; this is not a PvP/FPS benchmark. Required build output is published with matching data and API parity verified.


## D-185 - Regular fusions join AIR's primary bomber targets

**Date:** 2026-10-03. **Status:** Checked and Played in a supplied combat fixture.

**Decision.** Add the three factions' regular land fusions and Armada's real
cloakable fusion to the primary strike roster at x1, below factories' x2.
AFUS stays x4 and advanced converters x3. Reuse existing faction helpers and
the native weighted picker; T1 primary classes, defensive sorties and the
AFUS immediate-diversion threshold stay unchanged.

**Reasoning.** The owner explicitly requests regular fusions after factories
in the primary stage. Previously they were ordinary economy fallback targets,
behind static defenses. The cloakable reactor is also a real regular fusion;
ordinary visibility checks must still admit it. Decoys and submerged reactors
are not added to this land-bomber roster.

**Alternative rejected.** Turning the four weights into strict separate tiers
would change how all existing primary targets trade value against distance and
AA exposure. The request fits the existing weighted primary stage.

**Files.** [Script policy](../data/script/src/manager/air_operations.as),
[current targeting reference](air-wave-attacks.md), and this decision record.

**Invariant.** Existing primary-class exclusion prevents rejected regular fusions
from bypassing admission through the economy fallback. No new lifecycle state
or command path is introduced.

**Verification.** [Rendered Glitters check](benchmarks/records/air/combat/case/2026-10-04/20261004T013840Z-8ec95ae8/README.md)
passes after eight game minutes on experimental_hard. The real picker selected
corfus, legfus and armckfus at preference 5; bomber damage destroyed corfus and
legfus. armfus was supplied but no explicit selection was observed, and armckfus
survived the window. A radar was the initial launch target; this verifies live
primary retargeting, not a controlled pairwise weighting or launch test. All
four roster IDs resolve in the shared unit data. No full economy game was run.
Script/DLL parity and invariant checks pass. Unit-helper validation retains
167 existing findings (KI-481/KI-473); link checking retains eight missing
hover-document links (KI-404), with no findings in this change. Current data was
published beside the matching D-184 DLL/debug pair in the required build output.
The initial sandboxed watcher falsely reported exit while the elevated engine
continued; its partial FAIL archive is retained. Reattaching the watcher with
process access produced the linked completed PASS, without altering that first
archive.


## D-186 - Advanced geos and naval converters follow fusions in AIR's primary roster

**Date:** 2026-10-03. **Status:** Checked and Played in supplied combat.

**Decision.** Keep existing primary weights and add advanced geothermal
powerplants at x0.75, followed by naval advanced energy converters at x0.5.
Reuse GetAdvNavalEnergyConverterNameForSide, independently of land converters'
x3. Geos include the land and naval power variants for all three factions plus
Armada's safe Prude. Geothermal weapons/support platforms retain their existing
classification rather than joining the powerplant list.

**Reasoning.** The owner's order extends D-185's weighted primary stage.
Positive fractional weights preserve its existing value/distance/AA scoring
and the AFUS-only immediate-diversion threshold. The shared API safely skips
missing optional definitions. Naval converters are floating contacts and still
pass ordinary visibility, payload, route and depth admission.

**Alternative rejected.** Raising every existing weight to make room for two
new integers changes AFUS diversion eligibility and relative target scoring.
Treating naval converters as land converters gives them the wrong priority.
Removing the submerged-target filter to admit deep naval geos would also admit
unattackable contacts; that filter remains.

**Invariant.** Primary targets rejected by admission cannot re-enter via a
weaker fallback class. This roster-only change adds no lifecycle state or
per-frame command path. T1 mex/wind and defensive heavy-unit selection remain.

**Files.** [Target roster](../data/script/src/manager/air_operations.as),
[targeting reference](air-wave-attacks.md), and this record.

**Verification.** [Rendered Supreme combat record](benchmarks/records/air/combat/advanced-geo-naval/2026-10-04/20261004T015226Z-44312432/README.md)
passes ten game minutes on experimental_hard. All three land advanced geos and
all three floating naval advanced converters were explicitly selected at
preference 5, took bomber damage and were destroyed. The launched 18-Phoenix
wave killed armageo/corageo/legageo at frames 4893/5232/5394, then
leganavaleconv/coruwmmm/armuwmmm at 6119/6230/6370. Admission also considered
armuwmmm before launch; these weighted scores do not promise strict class
ordering at different distances or visibility. The surviving operation
continued on radar cleanup.

The fixture supplies aircraft, freezes economy and supplies geos on dry land
without vent construction. Its placement override and hash are retained in the
manifest. This verifies combat targeting, not natural geo construction or an
economy benchmark. The safe Prude and naval geo variants were roster-checked,
not physically attacked in this run. No script, invariant or fixture errors
occurred. Script/DLL API parity, invariant and whitespace checks pass. Unit-helper
validation retains 167 baseline findings (KI-481/KI-473), and documentation
checking retains eight missing hover-document links (KI-404); none are in the
changed files. Current data is published with the unchanged matching D-184
DLL/debug pair in the mandatory build output.


## D-187 - Review SEA migration before changing gameplay

**Date:** 2026-10-03. **Status:** Proposal and source review only; not implemented
or played. Baseline CircuitAI `3d8c66d208d7c407e6d22d7d5178049dbbe7ab39`.

**Decision.** Propose an independently gated SEA controller over the existing
native reservation engine, with naval production berths, explicit clear exits,
separate compact economy modules and operational replacement before retiring
old shipyards. Leave gameplay unchanged until this plan is reviewed. Preserve
TECH's exact lab sequence and AIR/TACTICAL behavior.

**Reasoning.** SEA currently combines default-first placement, local constructor
anchors and one-yard/one-explicit-fusion ladders. Merely enabling layout cannot
control all its build paths or prove ships can exit. TECH retires eligible home
land labs at three counted factories, including frames; its forward placement
has a separate sustained +200 gate. Naval replacements need product-specific
navigation and usable capacity, not that count alone.

**Alternatives rejected.** Copy AIR's six-lab/twenty-turret arrangement; reuse
TECH's exact retirement threshold for ships; use ground-only unit terrain routes
for ships; retune the shared naval helper and accidentally change TACTICAL;
combine a fleet-combat rewrite with the placement migration. Reuse pure funding
math and native geometry without merging role state machines.

**Invariant.** This review changes documentation only. Proposed implementation
must reserve exits before filling economy, replan only unused clusters, preserve
required production through replacement, and make every production/assist/reclaim
actor read the same retirement state. New runtime invariants and actor-matrix
entries are implementation deliverables, not claimed present in this review.

**Files touched.** [Migration plan](sea-layout-migration-plan.md),
[known-issue register](known-issues.md) (KI-221 through KI-226, corrections to
KI-213/KI-308), this decision record, and the shared
[naval economy research](../../rjm.bar.docs/knowledge/50-economy/54-naval-economy-planning.md).
The plan maps each proposed implementation file to its verification contract.

**Verification.** Traced active SEA builder/factory/economy/cooperation hooks,
shared helpers, TECH reclaim predicates, AIR/native reservation paths and naval
movement API limits. Checked relevant pinned BAR build options/costs and current
official guides. No simulation, code edit or performance claim. The plan defines
unit/integration cases, rendered supplied scenarios, five-map natural comparisons,
mixed-role regressions and immutable evidence storage. Documentation checks are
reported in the review completion; existing unrelated findings remain visible.


## D-188 - Stage SEA naval layouts and prove harbor handover before rollout

**Date:** 2026-10-04. **Status:** Built, Checked, Symbolised and Played;
acceptance incomplete, default disabled.

**Decision.** Execute D-187 as an opt-in SEA controller over the existing native
reservation engine. Use actual ship product hulls/drafts for atomic berth exits,
six-slot dense economy/support groups, income/package T2 admission, useful
funded workforce, pending-aware fleet deficits and one protected forward
replacement. Retire the original only after equivalent production exists,
a product physically exits, current work drains and storage admits reclaim.

**Reasoning.** Copying TECH's geometry or its lab-count rule cannot certify
ships leaving shallow/narrow water. Keep C++ as geometry/query mechanism and
all naval priorities in script. Preserve disabled SEA, AIR/TECH and the shared
TACTICAL ladder. Native footprint reservations already share allied exclusions.

**Alternatives rejected/corrected.** A compile-only test originally passed an
implementation that built no shipyard; physical opening/egress checks now reject
that. Retaining all native task callbacks crashed on inactive build-chain task
removal (symbolized in CScriptArray); only SEA-owned pinned tasks are retained.
Friendly profile threat weights are zero for ships, so combat roles/value supply
cover instead. Uninitialized water survey, a non-restarting stability timer,
overlapping support pads and canceled claims stuck active were corrected and
played. Native discretionary task creation is deferred where it could starve
naval economy or a selected handover. Cheap coastal land rejection preserves
an eight-full-query budget; indexed unit/berth reconciliation removes the
per-unit full berth scan.

**Deliberate non-change.** Do not enable the feature by default from one favorable
Glacial run. Later paired timings regress and the full acceptance matrix is not
complete. Combat quota retuning, legacy Legion donation behavior, broad transit
networks, auxiliary factory certification and post-retirement replacement-loss
recovery remain open. This is the approved strategy's staged acceptance stop,
not a request for additional permission. KI-221 through KI-230 and KI-423 record
current boundaries; see [results](sea-layout-migration-results.md).

**Invariant.** INV-129 requires same-frame two-resource discretionary workforce admission. INV-130 requires an operational replacement and observed product departure before retirement. Shared layout claims remain atomic and active work never drifts. The independent harbor observer checks actual commands and movement, not only script decisions.

**Verification.** Native/AngelScript suites pass; DLL built with matching symbols.
All experimental profiles loaded in rendered simulations. Glacial supplied
fixtures prove real physical blocker replan and named-state adoption. The
independent observer saw a replacement-produced ship leave before reclaim of
an idle original yard, then observed its removal. Named-state reinitialization
is not engine save/load. Natural baseline/candidate games cover five ordinary
maps with immutable logs, scripts, screenshots and separate scorecards; losses
and regressions remain visible. Both enabled and disabled mixed Glacial controls
hit TECH INV-013, so mixed compatibility is not marked passed. Concurrent games
provide no per-role CPU/FPS result. Default remains false until those gates pass.

**Files.** The implementation, tests, tools and records touched by this stage:

- [data/script/src/global.as](../data/script/src/global.as)
- [data/script/src/helpers/sea_math.as](../data/script/src/helpers/sea_math.as)
- [data/script/src/manager/builder.as](../data/script/src/manager/builder.as)
- [data/script/src/manager/commands.as](../data/script/src/manager/commands.as)
- [data/script/src/manager/factory.as](../data/script/src/manager/factory.as)
- [data/script/src/manager/sea_economy.as](../data/script/src/manager/sea_economy.as)
- [data/script/src/manager/sea_layout.as](../data/script/src/manager/sea_layout.as)
- [data/script/src/roles/sea.as](../data/script/src/roles/sea.as)
- [data/script/src/roles/sea_build.as](../data/script/src/roles/sea_build.as)
- [data/script/src/roles/sea_factories.as](../data/script/src/roles/sea_factories.as)
- [doc/actor-matrix.md](actor-matrix.md)
- [doc/angelscript-references.md](angelscript-references.md)
- [doc/invariants.md](invariants.md)
- [doc/known-issues.md](known-issues.md)
- [doc/roles/README.md](roles/README.md)
- [doc/roles/sea.md](roles/sea.md)
- [doc/roles/sea_build.md](roles/sea_build.md)
- [doc/roles/sea_factories.md](roles/sea_factories.md)
- [doc/sea-layout-migration-plan.md](sea-layout-migration-plan.md)
- [doc/sea-layout-migration-results.md](sea-layout-migration-results.md)
- [src/circuit/script/InitScript.cpp](../src/circuit/script/InitScript.cpp)
- [src/circuit/terrain/BattleAnalysis.h](../src/circuit/terrain/BattleAnalysis.h)
- [src/circuit/terrain/NavalGeometry.h](../src/circuit/terrain/NavalGeometry.h)
- [src/circuit/terrain/TerrainManager.cpp](../src/circuit/terrain/TerrainManager.cpp)
- [src/circuit/terrain/TerrainManager.h](../src/circuit/terrain/TerrainManager.h)
- [tests/CMakeLists.txt](../tests/CMakeLists.txt)
- [tests/naval_geometry_test.cpp](../tests/naval_geometry_test.cpp)
- [tests/sea_math_tests.as](../tests/sea_math_tests.as)
- [tools/knowledge/check_script_api.py](../tools/knowledge/check_script_api.py)
- [tools/playtest/README.md](../tools/playtest/README.md)
- [tools/playtest/analyze_sea.py](../tools/playtest/analyze_sea.py)
- [tools/playtest/cases/sea/economy/migration-natural.json](../tools/playtest/cases/sea/economy/migration-natural.json)
- [tools/playtest/cases/sea/layout/harbor-lifecycle.json](../tools/playtest/cases/sea/layout/harbor-lifecycle.json)
- [tools/playtest/checks/sea/layout/harbor-lifecycle.json](../tools/playtest/checks/sea/layout/harbor-lifecycle.json)
- [tools/playtest/checks/sea/reliability/sea_compile.json](../tools/playtest/checks/sea/reliability/sea_compile.json)
- [tools/playtest/run_sea.py](../tools/playtest/run_sea.py)
- [tools/playtest/run_sea_cohort.py](../tools/playtest/run_sea_cohort.py)
- [tools/playtest/sea_harbor_probe.as](../tools/playtest/sea_harbor_probe.as)
- [tools/playtest/test_analyze_sea.py](../tools/playtest/test_analyze_sea.py)
- [tools/playtest/widgets/sea_harbor_fixture.lua](../tools/playtest/widgets/sea_harbor_fixture.lua)
- [tools/playtest/widgets/sea_watch.lua](../tools/playtest/widgets/sea_watch.lua)
- [tools/run_native_tests.sh](../tools/run_native_tests.sh)

**Published evidence.** [SEA benchmark index](benchmarks/index/sea.md), [catalog](benchmarks/catalog.json) and the [complete comparative results](sea-layout-migration-results.md) link each immutable bundle, its manifest, original checks/verdict and retained screenshots. Transient Windows directory-rename failures were recovered after hash verification; only a byte-identical interrupted-publication duplicate was removed.


## D-189 - SEA capability-based counters, measured migration and carrier ownership (2026-10-04)

**Decision.** Continue D-188 only behind SEA ExperimentalBuild. Add explicit current-contact sampling and pending-aware, actual-weapon counter selection; observed counters precede discretionary build power. Retain opening/recovery workers, a modest fleet screen before saving for the funded T2 package, safe metal expansion, and bounded use of nearby existing workers on capital frames. Separate queued building commitments from immediate factory admissions to remove double reservation. Default rollout remains off because economic/combat non-regression is not established.

**Reasoning.** PvP sea requires surface/underwater/air coverage and protected ranged damage, with wreck-field control. Unit names and fixed T2 quotas cannot express Legion's different weapons. Threat choice runs once per second/at factory admission; it does not rewrite fleet orders. Construction capacity is funded by both resources; an idle shore commander is not available naval expansion power. See the [research/acceptance plan](sea-combat-enhancement-plan.md), [304-definition roster](sea-unit-controls.md) and [native trace](sea-native-trace.md).

**Rejected.** Blanket target-layer maximum-range formations, conditional range changes, broad equivalent-order reuse and attack-only reuse all reduced some orders but lost surface fixtures previously won. They were removed; original native movement remains. No APM cap, global role/profile retune, silently easier benchmark, or smoke-PASS-as-victory claim. First fixed five-map paired cohort showed both improvements and regressions. Later Glacial capital assistance reached T2 11:38/fusion 16:33 but lost productive assets later; historical 10:27/15:31 remain unbeaten.

**Carrier follow-up.** The corrected observer attributes 1,113 first-minute non-Lua orders to Legion drones in a six-destroyer control; the game carrier gadget also orders those drones. A generic native external-control task is explicitly chosen by SEA using carrier_host_unit_id. It issues no commands, yields on host-rule removal, preserves human ownership and has no default role impact. This replaces competing ownership, not urgent-response throttling. Host death/release and command-source fixtures decide acceptance.

**Invariant.** INV-129 two-resource admission, INV-130 verified replacement egress before retirement, INV-131 actual target-layer capability, and INV-132 successful passive ownership transfer. The independent observer measures engine damage, losses, production completion and command sources. Surviving extractors without builders/shipyards do not count as an operational base. Original reports and data/build hashes are retained in immutable [SEA records](benchmarks/index/sea.md).

**Implementation files.** [global settings](../data/script/src/global.as), [SEA delegates](../data/script/src/roles/sea.as), [SeaBuild](../data/script/src/roles/sea_build.as), [SeaFactories](../data/script/src/roles/sea_factories.as), [SeaEconomy](../data/script/src/manager/sea_economy.as), [SeaCombat](../data/script/src/manager/sea_combat.as), [pure math](../data/script/src/helpers/sea_math.as); [BattleAnalysis.cpp](../src/circuit/terrain/BattleAnalysis.cpp)/[header](../src/circuit/terrain/BattleAnalysis.h), [InitScript](../src/circuit/script/InitScript.cpp), [MilitaryScript](../src/circuit/script/MilitaryScript.cpp), [MilitaryManager.cpp](../src/circuit/module/MilitaryManager.cpp)/[header](../src/circuit/module/MilitaryManager.h), [UnitTask](../src/circuit/task/UnitTask.h), [external task.cpp](../src/circuit/task/common/ExternalControlTask.cpp)/[header](../src/circuit/task/common/ExternalControlTask.h).

**Evidence/tool files.** [SEA math tests](../tests/sea_math_tests.as), [roster generator](../tools/knowledge/naval_roster.py), [arena runner](../tools/playtest/sea_arena.py), [arena observer](../tools/playtest/widgets/sea_arena.lua), [combat cohort](../tools/playtest/run_sea_combat.py), [natural runner](../tools/playtest/run_sea.py), [natural cohort](../tools/playtest/run_sea_cohort.py), [combat analyzer](../tools/playtest/analyze_sea_arena.py)/[tests](../tools/playtest/test_analyze_sea_arena.py), [economy analyzer](../tools/playtest/analyze_sea.py)/[tests](../tools/playtest/test_analyze_sea.py), [combat definitions](../tools/playtest/cases/sea/combat/), [checks](../tools/playtest/checks/sea/), [playtest guide](../tools/playtest/README.md), [role guide](roles/sea.md)/[build guide](roles/sea_build.md)/[factory guide](roles/sea_factories.md)/[role matrix](roles/README.md), [API reference](angelscript-references.md), [actor matrix](actor-matrix.md), [invariants](invariants.md), [known issues](known-issues.md). Generated benchmark catalog/index append records without altering older evidence.

**Verification.** Native and AngelScript pure suites passed before the carrier follow-up; seven independent parser tests pass. Fourteen paired supplied combat runs and ten paired natural games on five maps completed, with original failures retained. Rejected movement experiments and subsequent natural repeats are also archived. New carrier task runtime and final-profile/isolation checks are recorded in the final SEA combat results; do not infer those from build success. KI-227/228/230/231/232/233 remain rollout gates. No claim that all naval mechanics or current benchmarks are beaten.


**D-189 Legion registration follow-up.** Hard/terrible profile metadata omit legadvshipyard; completion alone never registered native factory tasks. SEA now explicitly registers missing metadata before construction, retaining existing balanced metadata. The generic mechanism derives the real roster and copies generic lifecycle handlers, with native start/switch importance zero. Global JSON edits were rejected to preserve other roles. The initial gate incorrectly used layout activation before LayoutPlanHandler; it now uses the SEA experimental setting during Sea_Init. Supplied terrible and balanced games physically completed constructors/combat units; the natural terrible game reached yard 11:55, constructor 12:35, naval fusion 18:48 and retained production at 30 minutes. Already-existing yards at runtime role entry and save/load remain unverified. Files: [FactoryManager.cpp](../src/circuit/module/FactoryManager.cpp), [header](../src/circuit/module/FactoryManager.h), [FactoryScript](../src/circuit/script/FactoryScript.cpp), [SEA role](../data/script/src/roles/sea.as), [production case](../tools/playtest/cases/sea/combat/legion-t2-production.json), [physical checks](../tools/playtest/checks/sea/combat/legion-t2-production.json), [API](angelscript-references.md), [trace](sea-native-trace.md).

**D-189 carrier result.** With identical supplied forces and the revised observer, first-minute drone non-Lua commands fell from 1113 to 72; total non-Lua orders from 1598 to 350. Both games lost 130 metal and destroyed 3600 metal. A naturally released drone attacked again after its host died. Forced host deletion destroyed all remaining drones, proving teardown only. No claim that forced deletion proved surviving-drone release. Large-fleet APM remains open.

**D-189 coverage weighting.** T1 destroyers retain full surface value but half-cost underwater coverage in SEA settings: their large surface gun does not contribute to an underwater fight. The supported raid then selected armsub; natural Glacial remained operational at 30 minutes, at a slower 13:29 T2/19:08 fusion timing. This is an experimental trade, not a calibrated DPS model or acceptance win.


**D-189 hybrid AA handoff.** Armada armpt combines scout and AA roles; native priority assigned SCOUT during raids. SEA now assigns native AA on a current air contact and transfers only existing SCOUT tasks. Existing player/retreat/AA tasks are preserved; removed IDs are forgotten and tracked responders return to native selection on role exit. Global behavior/profile edits were rejected to keep other roles unchanged. The initial hard limited-raid prototype lost 0 metal versus 24,910 before the handoff, while eliminating the same 1,390 enemy metal and lowering peak callbacks from 612 to 475. Balanced and terrible repeats lost 2,640 and 1,560 respectively; these profile differences are not same-profile effect estimates. The eight-bomber hard test still destroyed most harbor economy. See the versioned results, not a general zero-loss claim. Files: [SeaCombat](../data/script/src/manager/sea_combat.as), [SEA hook](../data/script/src/roles/sea.as), [settings](../data/script/src/global.as), [role matrix](roles/README.md), [role](roles/sea.md), [trace](sea-native-trace.md), [invariants](invariants.md), [actors](actor-matrix.md), [results](sea-combat-results.md).

**D-189 builder approach follow-up.** Tundra repeatedly changed approaches to two unstarted tidal pins while holding 42 tidals and about +702 energy. Turning off experimental builder travel in a pinned test copy delayed the first yard to 2:35 and lost the base before fifteen minutes; that alternative was rejected. A SEA-only watch now tests unframed economy progress and temporarily excludes stalled slots, preserving factory/frame positions and the shared native movement mechanism. Boundary tests pass; natural Tundra/Glacial verification is recorded in the results. Files: [SeaBuild](../data/script/src/roles/sea_build.as), [SeaLayout](../data/script/src/manager/sea_layout.as), [SeaMath](../data/script/src/helpers/sea_math.as), [settings](../data/script/src/global.as), [tests](../tests/sea_math_tests.as), [plan](sea-combat-enhancement-plan.md), [build guide](roles/sea_build.md), [trace](sea-native-trace.md), [invariants](invariants.md), [actors](actor-matrix.md).

**D-189 fixture correction.** Production fixtures now wait until frame 600 before their first recruitment so supplied constructor creation finishes first. Supported fixtures freeze economic constructors/commanders but permit native recovery-submarine tasks. Previously those boats were also frozen and could obstruct yard exits. Original results remain immutable; new-harness comparisons must run both control and candidate again. This correction does not itself prove that blocked exits caused a particular defeat. Files: [arena runner](../tools/playtest/sea_arena.py), [results](sea-combat-results.md).


**D-189 approach/lane outcome - rejected and removed.** The timeout-only Tundra repeat reached T2 28:16, worse than the preceding 20:00 repeat. Adding 96-elmo service exclusions lost both Tundra and Glacial bases without T2; lanes alone lost Tundra without T2 as well. Neither experiment warrants retention. The preceding SeaBuild/SeaLayout/SeaMath/settings were restored; INV-134 is a retired experimental promise. The original decision above is retained as history. KI-235 remains open, and a controlled access/obstruction fixture is required before another change. [Results](sea-combat-results.md) and the [plan](sea-combat-enhancement-plan.md) retain the evidence and rejected settings.


**D-189 final verification.** Final retained DLL/data parity checked 284 used bindings with zero findings; all 320 data files match required build output. Eight SEA analyzer tests pass, including a truncated-log tail that now reports incomplete evidence instead of crashing or inventing damage. The 107 published SEA records retain original verdicts and have zero publication-hash mismatches. Three final interrupted-publication duplicates were removed only after full byte-hash equality with their existing published destinations and resolved-path containment checks. No engine test processes remained. [Final results](sea-combat-results.md) distinguish observed improvements, rejected experiments and unmet gates; no all-benchmarks-beaten claim.


## D-190 - compact AIR/SEA economy and funded naval factory support

2026-10-04. Owner requested touching advanced converters for AIR/SEA, unchanged
AIR T1 spacing, densely packed SEA T1 economy, and more naval factory build power.

**Decision.** Remove only AIR converter-bank pitch padding. SEA T1/converter
patches use zero footprint gaps and extend sideways as two-row strips, with
per-building persistent reservations and no redundant empty envelope. Preserve
fusion spacing, factory exits, allied exclusion and activated module positions.
Global block-map spacing edits were rejected because they affect other roles.
The previous wider-lane experiment remains rejected; dense strips can be reached
from their perimeter, but this does not establish that all KI-235 path failures
are cured. Existing saved/started plans are not moved to force new spacing.

Reserve 20 support positions initially (configurable, maximum support policy
still 40 turret-equivalents per factory), expanding when funded. Extend support
eligibility to amphibious complexes, floating hover factories and underwater
gantries independently of shipyard tech/handover. Each active product supplies
its actual cost/work ratio. Share the production budget between busy factories,
choose the least-supported fraction first, count completed/framed/queued power
once, and fund the turret plus subsequent consumption using both resources.
Actual banked donations qualify; future gifts are not forecast. Support searches
are keyed by site and size, preventing one harbor from consuming another's retry
window. Include acquired yards in support preplanning. Native turret assistance
and enemy-reclaim ownership are preserved.

**Invariant.** INV-135 requires actual assist reach for every admitted SEA
support pin. INV-136 checks intended grid pitch after native snapping once at
reservation time. INV-129 continues to require same-frame workforce funding.
The independent observer checks completed buildings, rotated footprint shared
edges, and turret guard/repair commands on real factory products.

**Scope/rollout.** No native or profile JSON changes in D190. Other role policies
and AIR T1 source are unchanged from the captured working baseline. SEA
ExperimentalBuild remains false by default because D189's broader gates remain
unmet. No changes to data_sample or combat command throttling.

**Verification.** The [results](dense-economy-results.md) record physical grid
completion, native turret assistance, natural paired maps and exact limits.
Original failed fixture iterations remain immutable. Support tests additionally
exposed a real cross-site search starvation bug, fixed before final comparison.

**Files.** [Plan](dense-economy-plan.md), [AIR economy layout](../data/script/src/manager/air_eco_layout.as),
[SEA layout](../data/script/src/manager/sea_layout.as), [SEA economy](../data/script/src/manager/sea_economy.as),
[SEA build](../data/script/src/roles/sea_build.as), [layout audit](../data/script/src/helpers/layout_helpers.as),
[SEA math](../data/script/src/helpers/sea_math.as), [settings](../data/script/src/global.as),
[math tests](../tests/sea_math_tests.as), [AIR guide](roles/air.md), [SEA guide](roles/sea_build.md),
[invariants](invariants.md), [actors](actor-matrix.md), [runner](../tools/playtest/run_dense_economy.py),
[probe](../tools/playtest/dense_economy_probe.as), [observer](../tools/playtest/widgets/dense_economy_watch.lua),
[AIR case](../tools/playtest/cases/air/layout/dense-converters.json),
[SEA case](../tools/playtest/cases/sea/layout/dense-economy.json),
[support case](../tools/playtest/cases/sea/layout/dense-support.json),
[AIR checks](../tools/playtest/checks/air/layout/dense-converters.json),
[SEA checks](../tools/playtest/checks/sea/layout/dense-economy.json),
[support checks](../tools/playtest/checks/sea/layout/dense-support.json),
[playtest guide](../tools/playtest/README.md).


**D-190 final comparison.** Physical touching-grid and actual shipyard/amphibious
assistance tests pass, as do 24 pure policy tests. Six final 20-minute natural
games have no script/invariant failures. Tundra seed 1902 reaches T2 at 13:47
and +113.8 metal/+1,595 energy by 20 minutes; seed 1881001 loses the candidate
economy while its control remains operational. This is mixed self-play evidence,
not proof of better strength. Keep the existing migration default off; do not
change other roles or claim KI-231/KI-235 closed. Twenty-one immutable observations
and the precise comparison are linked from [results](dense-economy-results.md).
All active data matches the required engine build output; the live install is
untouched. D190 changes exactly seven data files from the captured working tree.


## D-191 - SEA owns compact naval economy placement independently of fleet migration

2026-10-04. The Supreme Isthmus v1.7 screenshot showed scattered converters,
stranded construction turrets and reactors in front of the shipyards.

**Decision.** Enable `CompactEconomy` by default for SEA while retaining the
existing default-off `ExperimentalBuild` production/combat migration. Reuse
native layout geometry through a SEA policy module: reserve a square 4x4 turret
bank and rear naval fusion first, then pack touching T1/advanced converter rows.
Use actual enemy-start facing independently of shipyard exit orientation.
Tidal strips retain D190's touching pitch. Preserve allied exclusions and
actual shipyard/amphibious exits. Never reposition already-started blocks.
A blocked unused block is released and searched again within a bounded radius.

Factory support is range-checked against its actual production target. Economy
support is a distinct block around a fusion. T2 subs request preparation and
T1 constructors provide its initial two turrets; subsequent growth follows
funded useful work. The commander and one T1 ship retain native expansion.
Ordinary guard decisions and null/native fallback are preserved in the compact
adapter; replacing null with Wait regressed mex expansion and was rejected.
Native factory/energy task labels are normalized by the naval UnitDef, leaving
coastal land energy outside the water placement owner.

Keep SEA converters across the T2 transition by disabling native converter-tier
reclaim while this layout owns placement, restoring its prior multiplier on
role exit. The alternatives of reclaiming cheap T1 rows or globally changing
converter/placement defaults were rejected. Require 60% stored energy before
converter admission, above native's 55% unstarted-task cancellation threshold.

A served reservation ID alone does not identify an approaching layout task:
`SeaEconomy::OwnsTask` also recognizes the explicitly pinned task ledger. A
claimed site remains owned while its constructor travels. Never retain every
native task-added handle: a dormant `nextTask` is directly deleted by its
parent's destructor and caused an observed crash. Inspect live unit ownership
for bypass orders; retain only our pinned tasks. Native lifetime repair remains
KI-237. No shared engine movement, combat or TECH/AIR policy changes were made.

**Invariant.** INV-137 checks the complete fusion footprint stays at least
64 elmos behind its harbor on the strategic axis. INV-135 still requires actual
factory support reach, INV-136 covers grid snapping, and INV-129 covers funding.
The fixture independently measures completed touching footprints, turret grid,
actual repair/guard of productive factories/fusion, orphan turrets and retained
T1 converters. Supplied resource timing is not natural economy timing.

**Verification.** See [results](sea-economy-block-results.md) for immutable
original failed attempts, passing supplied Supreme tests, natural comparisons,
source pins, screenshots and remaining limitations. Pure tests cover rear
footprint boundaries and shared funding/support math. Save/load, late role entry,
all factions and a broad competitive rollout remain outside this acceptance.

**Files.** [Plan](sea-economy-block-plan.md), [settings](../data/script/src/global.as),
[SEA role](../data/script/src/roles/sea.as), [build adapter](../data/script/src/roles/sea_build.as),
[layout](../data/script/src/manager/sea_layout.as), [block module](../data/script/src/manager/sea_eco_layout.as),
[economy ownership](../data/script/src/manager/sea_economy.as), [pure math](../data/script/src/helpers/sea_math.as),
[tests](../tests/sea_math_tests.as), [role guide](roles/sea.md), [builder guide](roles/sea_build.md),
[invariants](invariants.md), [actors](actor-matrix.md), [known issues](known-issues.md),
[runner](../tools/playtest/run_sea_economy_block.py), [natural runner](../tools/playtest/run_sea.py),
[probe](../tools/playtest/sea_economy_block_probe.as), [observer](../tools/playtest/widgets/sea_economy_block_watch.lua),
[case](../tools/playtest/cases/sea/layout/economy-block.json), [checks](../tools/playtest/checks/sea/layout/economy-block.json),
[playtest guide](../tools/playtest/README.md), [benchmark index](benchmarks/index/sea.md),
[benchmark catalog](benchmarks/catalog.json).


D191 final verification and geometry correction: the economy envelope starts
outside the factory turret assist disc. An earlier rear envelope overlapped
the last feasible support sites on Supreme, so rear-facing alone was rejected
as insufficient. This is in [SeaEcoLayout](../data/script/src/manager/sea_eco_layout.as).

The [observer](../tools/playtest/widgets/sea_economy_block_watch.lua) now uses
UnitFinished to distinguish retention of completed T1 converters from an
unfinished-frame loss. The earlier strict FAIL remains immutable and KI-238
records the latter; narrowing this assertion does not declare that loss fixed.
Both final supplied movement modes pass all seven positive placement/assist
checks. Natural Supreme (30 minutes) and Glacial (20 minutes) pass runtime
checks but show mixed economy and departure results. No broad non-regression,
strength or natural fusion timing claim follows. Exact IDs, measurements,
failed iterations and screenshots are in [results](sea-economy-block-results.md).


## D-192 - Shared private base clusters and forward SEA harbor planning (2026-10-04)

**Decision.** Keep D153's native allied slot/zone index authoritative; reserve
complete 48-site SEA tidal grids instead of independent six-site patches. Do
not partition ownership by nearest start or add exclusive weapon/mex envelopes.
Route later SEA yards, including shared native fallback proposals, through
enemy-facing pinned berths whose whole rear footprint clears existing and
planned naval economy by 128 elmos. Persist the first-factory history rather
than treating destruction as a new opening. Only the opening is relaxed.

**Reasoning and rejected alternatives.** Coastal start bisectors excluded
usable water and starved rear economy, so that tested partition was removed.
The native index already prevented literal foreign overlap; interleaved small
patches and bypassing yard placement were the missing policy pieces. Opening
land anchors and 1200-elmo later searches could not fit a crowded coast. Use
harbor anchors and a configurable 2400-elmo later radius. Ordinary compact SEA
also needs early future-berth reservations: otherwise an unconstrained opening
at the map edge can make its required rear economy impossible. Preplan two
future T2 sites by default, initially 768 elmos forward, but retain purchase
gates. The low-growth interim natural candidate is rejected despite startup
PASS. Preserve frames, existing claims and native resource-expansion fallback.
Do not retain native dormant-chain handles (KI-237).

**Scope and files.** Policy changes only affect enabled SEA layout paths;
AIR/TECH rules and native production source are unchanged from the turn's
captured baseline. Sources: [settings](../data/script/src/global.as),
[SEA math](../data/script/src/helpers/sea_math.as),
[naval layout](../data/script/src/manager/sea_layout.as),
[capital economy](../data/script/src/manager/sea_eco_layout.as),
[SEA construction](../data/script/src/roles/sea_build.as), and
[shared fallback](../data/script/src/manager/builder.as).
Tests: [native ownership](../tests/allied_reservations_test.cpp),
[SEA predicates](../tests/sea_math_tests.as),
[test runner](../tools/run_native_tests.sh).
Fixtures: [runner](../tools/playtest/run_sea_allied_base.py),
[probe](../tools/playtest/sea_allied_base_probe.as),
[observer](../tools/playtest/widgets/sea_allied_base_watch.lua),
[natural runner](../tools/playtest/run_sea.py),
[mixed case](../tools/playtest/cases/sea/layout/allied-bases-mixed.json),
[supplied case](../tools/playtest/cases/sea/layout/allied-bases-supplied.json),
[mixed checks](../tools/playtest/checks/sea/layout/allied-bases-mixed.json),
[supplied checks](../tools/playtest/checks/sea/layout/allied-bases-supplied.json),
[ordinary checks](../tools/playtest/checks/sea/reliability/sea_compile.json).
Documentation: [plan](sea-allied-base-plan.md), [results](sea-allied-base-results.md),
[role reference](roles/sea_build.md), [actors](actor-matrix.md),
[invariants](invariants.md), [known issues](known-issues.md),
[playtest usage](../tools/playtest/README.md),
[benchmark catalog](benchmarks/catalog.json) and [SEA index](benchmarks/index/sea.md).
The results inventory links every generated immutable evidence bundle.

**Verification.** Checked: full native/policy suite, including 14 shared-index
assertions and eight SEA policy tests; script/DLL parity and invariant/role
documentation checks. Played: real engine reciprocal role reservation probes,
three-neighbour supplied construction, and ordinary Glacial/Supreme games.
Original failures remain immutable, including unrelated TECH invariants.
Supplied yard demand explicitly lifts the income cap; it does not validate
natural tech timing. The exact accepted IDs and measured economy are in the
results document. No FPS, win-rate, save/load or arbitrary coast certification.
Lifecycle coverage remains KI-239; existing throughput concerns KI-231/KI-235
remain. Output is published with the matching D191 DLL/debug symbols; this
change adds no native ABI or binary changes.

**Invariant.** INV-138: every later SEA yard admission is enemy-facing and its
whole footprint is forward of existing/reserved naval economy. INV-088 remains
the shared allied-placement guard; forward weapon/mex footprints retain normal
physical collision checks without new private envelopes.


## D-193 - Timed AIR reconnaissance and immediate allied-base defense

2026-10-04. Built, Checked, Played.

**Decision.** Keep the configured radar wave and recruitment cadence, but
dispatch an available partial or unassembled cohort after ninety seconds of
waiting. Let surviving opening scouts loop. An experimental AIR controller
scans the existing current-visible ground snapshot once per second and admits
free ground-capable aircraft into shared defensive tasks inside 1800 elmos of
participating allied/human starts. Held bombers do not need an offensive wave
minimum, escorts or an AFUS gate to defend. T2 bombers retain heavy-mobile or
structure targets. Production shares one twenty-unit lethal reserve across
plants, including frames and unframed orders. Cortex T1 combines lethal bombers
with a separate small EMP group. Script settings own every policy threshold.

**Why and rejected alternatives.** The radar wall had no deadline. D-174's
ordinary-ground response was still a proposal (KI-482); the existing air
interceptor snapshot excludes land, while defensive T3 bomber selection sits
behind offensive admission. The two-Phoenix baseline made no damaging attack
in seven minutes; the new controller dispatched at first contact. A first
implementation let home-wall replacement fighters starve gunship orders after
transferring defenders out of the home ledger. Ground recruitment now precedes
that routine floor; a real air-emergency deficit retains interception priority.
Do not steal the owner's explicitly committed offensive bombers/escorts.
Preserve transport, recovery and bounded workforce turns. Stable task targets
reuse native command deduplication instead of adding a rate limit. Native code
only exposes IDs/definition IDs from the unchanged ground snapshot.

**Scope.** This is the bounded start-radius portion of D-174, not its full
multi-AIR incident election, live/abandoned-campus model or AA-aware routing.
Those limits remain [KI-482](known-issues.md#ki-482---air-base-response-still-lacks-multi-air-election-and-live-campus-routing).
No TECH/SEA policy change is introduced by D-193. Existing uncommitted work in
those areas is retained. The Glacial natural comparison retains strict FAIL
verdicts for TECH invariant categories also seen in the saved baseline; it is
not an economy/strength improvement claim.

**Files.** [Settings](../data/script/src/global.as),
[pure predicates](../data/script/src/helpers/air_math.as),
[recon](../data/script/src/manager/air_recon.as),
[base response](../data/script/src/manager/air_base_response.as),
[production](../data/script/src/manager/air_production.as),
[operation roster reuse](../data/script/src/manager/air_operations.as),
[raid admission](../data/script/src/manager/air_raids.as),
[wave admission](../data/script/src/manager/air_waves.as),
[factory admission](../data/script/src/manager/factory.as),
[AIR hook](../data/script/src/roles/air.as),
[snapshot declaration](../src/circuit/terrain/BattleAnalysis.h),
[snapshot implementation](../src/circuit/terrain/BattleAnalysis.cpp),
[bindings](../src/circuit/script/InitScript.cpp),
[tests](../tests/air_math_tests.as),
[response runner](../tools/playtest/run_air_response.py),
[observer](../tools/playtest/widgets/air_response_watch.lua),
[natural runner](../tools/playtest/run_air_natural.py),
[arena runner](../tools/playtest/air_arena.py),
[commitment case](../tools/playtest/cases/air/combat/base-response-commitment.json),
[commitment checks](../tools/playtest/checks/air/combat/base-response-commitment.json),
[tool usage](../tools/playtest/README.md), [plan](air-recon-base-defense-plan.md),
[results](air-recon-base-defense-results.md), [role reference](roles/air.md),
[API reference](angelscript-references.md), [actors](actor-matrix.md),
[invariants](invariants.md), [known issues](known-issues.md),
[benchmark catalog](benchmarks/catalog.json), [AIR index](benchmarks/index/air.md).
Results link the generated immutable evidence bundles.

**Verification.** Full native/pure suite passes, including 127 AIR math tests
(fourteen new cases). New DLL/script API parity is 287 members, no findings.
All three experimental profiles compile and run. Supreme fixtures measure
partial/full radar release, two-bomber before/after, all three factions at T1
and T2, outside-radius control and offensive commitment. First detected
Marauder contacts dispatch reserves in the same one-second controller tick;
damage includes flight time. T2 fixtures destroy both twelve-unit pushes. T1
fixtures prove response and damage, not victory over twenty-four T3 units.
Exact timing, APM, failures and screenshots are in the results. Save/load,
manual takeover, cargo/ferry transitions, abandoned starts and coordinated
multi-AIR recruitment have not been certified by these games.

**Invariant.** INV-139 reports silent failed deadline dispatch. INV-140 protects
defensive ownership and transfer success. INV-123 permits deadline-sized
cohorts but retains full-wave geometry/command checks. Every test keeps its
invariant forbid; fixture failures are archived rather than waived.


## D-194 - Safe AIR radar patrols and deterministic naval relief

2026-10-04. Built, Checked, Played; bounded supplied combat, not PvP certification.

**Decision.** Spread waiting radar planes over distinct triangular friendly
patrols, checking padded approach/loop corridors against known AA. Retain safe
assignments; invalidate only affected ones. Preserve full waves and the existing
90-second partial deadline. Add a cached physical AA envelope to the new
corridor API because several profiles zero armed ships' weighted threat.
Do not change shared threat weights or SEA's existing queries.

AIR naval relief compares current observed combat metal within a connected
water body and local sector. Demand is the larger of the total fleet deficit
and submerged-versus-friendly-ASW deficit, multiplied by 1.25 and divided by
the actual compatible torpedo aircraft cost, rounded up and bounded to 2-60.
A 1.25-radius friendly halo prevents a sampled circle from cutting a nearby
formation into false deficits (the original eight-versus-six parity fixture
exposed this). This is a conservative support heuristic, not a combat simulator.
At least an allied fleet or naval factory must anchor the area. Hovers, builders,
other water bodies and remote unsupported enemies do not request relief.

Real factories count ready aircraft, frames and pending recruits once. Full or
90-second partial waves require an observed eligible target, tolerable known AA
and an open-water ingress. Use shared movement/attack tasks and available fighter
escorts; preserve existing offensive commitments. This is defensive support:
survivors return once the local gap disappears. Land-base emergencies retain
priority. An initial diagnosis blamed surface ships for Glacial interruption
and attempted three movement-classification bindings plus INV-143. This was
wrong: a read-only contact probe identified the spectator team's armcom at
(64,64), legitimately inside the base radius. The production classification
change and bindings were removed; INV-143 is retired. The isolated runner now
allies the spectator team instead. Two intermediate binding compile FAILs and
interrupted-combat runs remain archived. Static aiXxx checks alone do not prove
local object methods compile.

**Correction during validation.** A friendly halo alone still produced a
false parity deficit at a different empty grid point. That attempted solution
was rejected. Final sector centers are centroids of observed enemy contacts
in occupied spatial buckets; a second bounded pass gathers nearby allied and
enemy costs around those actual concentrations. Sorting occupied sector keys
makes ties reproducible. The original and halo-only FAILs are preserved.

**Rejected alternatives.** Waiting motionless wastes radar coverage. Giving
new orders to every plane every tick raises APM. Point-only threat checks miss
AA between waypoints. Globally changing zero threat weights affects other roles.
Global fleet totals mix disconnected seas; counting only a rigid sector clips
nearby allied formations. A timer must not send torpedoes through land or known
lethal AA. Cost parity does not justify promising victory. No blunt order rate
limiter, omniscient enemy lookup, unconditional T2 rush or SEA production rewrite.

**Files.** [AIR settings](../data/script/src/global.as),
[pure decisions](../data/script/src/helpers/air_math.as),
[recon](../data/script/src/manager/air_recon.as),
[naval controller](../data/script/src/manager/air_naval_support.as),
[base response](../data/script/src/manager/air_base_response.as),
[escort ownership](../data/script/src/manager/air_operations.as),
[production](../data/script/src/manager/air_production.as),
[role hook](../data/script/src/roles/air.as),
[corridor geometry](../src/circuit/terrain/AirSafety.h),
[native declaration](../src/circuit/terrain/BattleAnalysis.h),
[native implementation](../src/circuit/terrain/BattleAnalysis.cpp),
[bindings](../src/circuit/script/InitScript.cpp),
[native tests](../tests/air_safety_test.cpp),
[policy tests](../tests/air_math_tests.as),
[test CMake](../tests/CMakeLists.txt), [test runner](../tools/run_native_tests.sh),
[simulation runner](../tools/playtest/run_air_naval_support.py),
[observer](../tools/playtest/widgets/air_naval_support_watch.lua),
[analysis](../tools/playtest/analyze_air_naval_support.py),
[usage](../tools/playtest/README.md), [plan](air-patrol-naval-support-plan.md),
[results](air-patrol-naval-support-results.md), [role reference](roles/air.md),
[API reference](angelscript-references.md), [actors](actor-matrix.md),
[invariants](invariants.md), [remaining limits](known-issues.md),
[benchmark catalog](benchmarks/catalog.json), [AIR index](benchmarks/index/air.md).
The results link every immutable evidence bundle and selected screenshots.

**Verification.** Native geometry suite and 145 AIR pure policy tests pass.
Engine fixtures cover three factions/profiles, supplied production and stalls,
submarine mismatch, parity, hovers, disconnected/unsupported fleets, moderate
and heavy AA, physical zero-weight AA, and full/partial recon. Supreme and
Glacial exercise actual torpedo damage. A 20-minute natural AIR/SEA game and
existing bomber-commitment fixture provide integration smoke evidence. Exact
final builds, verdicts, order counts, failed iterations and limits are in the
results. No measured FPS or multiplayer bandwidth guarantee; no sustained
fixed-opponent strength claim. Multi-AIR budgets remain KI-495; pathological
formation admission remains KI-496. No sample-tree, TECH or SEA policy change
is introduced by this decision.

**Invariant.** INV-141 reports rejected radar patrol routes. INV-142 keeps
naval reserve/active ownership disjoint and reports silent launch failures.
INV-143 was a removed diagnostic experiment, not a runtime promise. Existing
INV-123/139 recon and INV-115 escort checks remain active. Every fixture forbids
invariant errors; pure tests cover local membership, deficit and deadline edges.


## D-195 - Evidence-first whole-AI performance review, no gameplay changes

2026-10-04. Measured and Reviewed; optimization proposals await owner selection.

**Decision.** Run a rendered, ordinary-resource 8v8 Shore fixture, separate
normal-speed measurement windows from fast-forward sections, and rank exact
index/data-representation changes ahead of new threading or command policies.
Use the existing D-194 DLL/data unchanged. Record callback elapsed time, FPS,
unit population, command origins, lane timers and targeted instruction samples.
Engine scopes overlap; instruction samples are wall-clock locations, not CPU
cycles or complete call stacks. No specific AngelScript function attribution
or network packet saving is inferred from these measurements.

The first discovery retained the generic harness's extra spectator commander.
After noticing it, preserve that evidence and run a corrected roster control.
Cleanup waits for player information, validates the spectator-only team and
removes only its units with cheats restored off. Two failed guards (early player
information and camera-followed team identity) are retained as failed runs.
A separate command-origin observer conflicted with the existing UnitCommand
hook; remove it and extend the existing observer instead. The short conflicted
control is excluded. These were fixture corrections, not AI policy fixes.

**Rejected alternatives.** Do not optimize AIR by assumption: the late sample
points primarily to layout queries and the highest observed command-minute is
TECH. Do not add an index that already exists, undo stale-pointer safeguards,
call overlapping profiler scopes CPU percentages, claim batching from control
groups, run multiple loaded benchmarks concurrently, or move engine callbacks
and script globals to workers. No APM cap, longer retry delay, weaker threat
checking, altered spacing or frame-work budget is introduced. WPR CPU profiling
was unavailable; its failure and the fallback's limitations are disclosed.

**Files.** [Ranked review](reviews/2026-10-04-skirmishai-performance-review.md),
[scope/FPS observer](../tools/playtest/widgets/skirmish_perf_watch.lua),
[command observer](../tools/playtest/widgets/air_command_watch.lua),
[roster cleanup](../tools/playtest/widgets/perf_spectator_cleanup.lua),
[instruction sampler](../tools/playtest/sample_process_instruction.ps1),
[measurement analyzer](../tools/playtest/analyze_skirmish_performance.py),
[discovery checks](../tools/playtest/checks/shared/performance/skirmish_cpu.json),
[clean checks](../tools/playtest/checks/shared/performance/skirmish_cpu_clean.json),
[playtest usage](../tools/playtest/README.md), [remaining issue](known-issues.md),
[benchmark catalog](benchmarks/catalog.json), [shared index](benchmarks/index/shared.md).
The review links immutable evidence bundles and their screenshots/input hashes.

**Verification.** Analyzer sanity cases and byte comparison of all 321 staged
script/config files pass. Scope and command observers run in-engine; original
invariant FAILs are retained. Main-thread instruction samples resolve against
matching debug symbols; the sampler verifies each thread still belongs to the
selected process and resumes it in finally. The report distinguishes measured
hotspots, source-supported opportunities and unmeasured expected benefit.
No native or active policy code was edited by D-195; no optimization benchmark
or behavior-equivalence PASS is claimed. Existing unrelated broken hover-doc
links remain tracked as KI-404.


**Final evidence correction.** The corrected-roster control's final image
shows the awards overlay; it is already visible at 29.8 minutes. The original
observer lacks GameOver/TeamDied markers, so no exact end frame is claimed and
late control FPS is excluded from competitive comparison. Its earlier sample
does not reproduce the discovery's reservation hotspot. Preserve this result,
add observer lifecycle markers plus a GameOver forbid for future performance
runs, and record KI-498 rather than presenting the control as a matched win.
Those final Lua hooks are source-reviewed and parser-checked, not played. The
final sampler also stops after process exit; the already truncated final sample
retains its failures and only valid instruction locations are analyzed.

**Invariant.** D-195 changes no gameplay policy. Existing gameplay invariant
forbids remain enabled in every performance fixture; failures are retained.
Only measurements from a verified competitive interval qualify as normal-match
comparisons (KI-498). No new runtime gameplay invariant is introduced.

## D-196 - Preserve Juno behavior while separating aim, flight and impact evidence

**Decision.** Record the user's off-map Juno observation as unresolved KI-499;
do not alter production firing without a reproduction. All 85 ordinary Shore
launch aims examined are within bounds. Twelve supplied shots per iteration
remain inside; the second iteration independently observes twelve actual
explosion centers inside the map. This does not establish universal correctness.

**Reasoning and rejected alternative.** Strategic shots already reject invalid
coordinates at selection and execution. The suspected-jammer branch clamps
inferred candidates, which can explain edge aims. Another identical guard or a
blanket edge exclusion would not prove a fix and could suppress real edge jammer
targets. Keep the source trace, exact launch/impact data, and original PASS
reports separately from the unresolved gameplay observation. No behavior change
or performance optimization is implemented.

**Files.** [Investigation and reproduction](reviews/2026-10-04-juno-map-edge-investigation.md),
[performance cross-reference](reviews/2026-10-04-skirmishai-performance-review.md),
[fixture/observer](../tools/playtest/widgets/juno_edge_probe.lua),
[acceptance checks](../tools/playtest/checks/shared/combat/juno-edge-probe.json),
[issue](known-issues.md), [catalog](benchmarks/catalog.json),
[shared index](benchmarks/index/shared.md). The investigation links both immutable
bundles, including observer source, exact tagged log excerpts and screenshots.

**Verification.** Both supplied tests played on Shore with all three factions;
script/DLL parity reports zero findings. The repeat checks twelve launches,
projectiles and explosions and zero outside flight/impact observations. This is
supplied weapon mechanics, not live AI target-selection certification. The
original match and other maps remain unverified. Neither native nor active
AngelScript behavior was changed.

**Invariant.** Existing runtime invariant forbids remain enabled. Juno aim
bounds remain guarded by the existing strategic checks/INV-095; test observations
must distinguish projectile disappearance from a measured explosion. No new
gameplay invariant or claimed gameplay fix is introduced.

## D-197 - Exact occupancy makes allied reservation checks independent of claim count

**Decision.** Replace the shared reservation bucket/member scan with a directly
addressed paged occupancy index. Keep the authoritative owner/kind/ID rectangle
ledger for mutations. A query inspects only intersecting pages and occupied
footprint cells; fixed-footprint work does not grow with reservation count.
No role policy, candidate order, command cadence or buildability rule changes.

**Reasoning.** D-195 identified repeated reservation-tree work in the slowed
Shore run, and the user requested constant-time checking. Stable bucket entry
references would remove a lookup but still scan overlapping claims. Exact
cell owner counts and XOR summaries remove that dependency while retaining own
exclusions and arbitrarily nested claims. Whole-page owner counts avoid costly
raster updates/storage for large aligned interiors; only partial boundaries
need per-cell counts. Mutations remain synchronous on the existing AI thread.
No worker offload or eventually consistent reservation view is introduced.

**Alternatives and limits.** Strict O(1) for arbitrarily large rectangle queries
would move excessive map-wide work into speculative mutations. The supported
contract is constant in claim count for a fixed footprint, explicitly not a
constant-time whole placement search. Exact owner reference counts are retained
instead of booleans or lossy coarse blockers; releasing one slot must not free
its surrounding zone. Sparse partial pages cost more memory and tiny
reserve/release transactions can be slower. The report retains these results.
Local TerrainManager scans and the remaining D-195 recommendations are deferred.

**Files.** [Native index](../src/circuit/terrain/AlliedReservations.h),
[regressions](../tests/allied_reservations_test.cpp),
[frozen legacy reference](../tests/support/allied_reservations_legacy.h),
[benchmark](../tests/allied_reservations_benchmark.cpp),
[rendered runner](../tools/playtest/run_reservation_performance.py),
[results and immutable evidence](layout-reservation-performance.md),
[review follow-up](reviews/2026-10-04-skirmishai-performance-review.md),
[actor matrix](actor-matrix.md), [invariants](invariants.md),
[remaining issue KI-497](known-issues.md), [catalog](benchmarks/catalog.json),
[shared index](benchmarks/index/shared.md), [sea index](benchmarks/index/sea.md).

**Verification.** The complete native suite passes; the current worktree's
reservation suite reports 200,159 checks without failures. Three optimized
old/new benchmark runs establish flat query scaling and record update costs.
The final DLL, symbols and current data are built and published together;
script/API checking reports 295 members and zero findings. Supreme's twelve
directed AIR/TECH/SEA factory/economy exclusions pass without runtime invariants.
The results document retains Shore's full observation and original verdict.
Tests/build include pre-existing dirty AIR/SEA work, identified by input hashes;
this decision's commit alone does not reproduce those unrelated changes.
Sanitizers are unavailable; real save/load and owner teardown are not played.

**Invariant.** INV-088 is unchanged: no foreign allied reservation overlap.
Existing runtime checks stay enabled. Per-owner nested counts, exact half-open
geometry, replacement, release and reconstruction are covered by differential
and oracle tests. Reusing the established invariant avoids a new per-frame
cost solely to check the optimization. Game invariant failures are preserved
and are not relabeled as passing performance results.

## D-198 - Rank remaining performance work by TECH attribution and repeated failures

**Decision.** Re-rank the remaining work using D-197's existing per-team timers,
failed-pack signatures and instruction evidence. Put repeated failed TECH
builder decisions and script allocation/GC ahead of another allied-index rewrite.
Keep local geometry, owned-unit scans, logs, commands, worker work and AIR
queries in the ranked follow-up. No production behavior or diagnostic cadence
is changed, and no new simulation is claimed.

**Reasoning and limits.** TECH team 1 contributes 84.88% of aggregate AI elapsed
time in the last minute; both AIRs contribute 2.30%. Identical failure signatures
occur 647 times for the same T1-converter zone/candidate count. These data
localize the responsible AI and workload, but log gaps are not function timings
and the VM/GC instruction sample predates the final window. Do not claim an
exact function, a leak, purely GC-driven pauses or safe cache equality from
these observations. Reject an AIR-first rewrite, global APM cap, reduced update
cadence or arbitrary worker offload as unsupported responses to this hitch.

**Files.** [Re-ranked report](reviews/2026-10-04-skirmishai-performance-rerank.md),
[derived evidence and source hashes](reviews/2026-10-04-skirmishai-performance-rerank.json),
[historical review link](reviews/2026-10-04-skirmishai-performance-review.md),
[D-197 results follow-up](layout-reservation-performance.md),
[remaining issue KI-497](known-issues.md).

**Verification.** Checked existing observer scope semantics, exact team roles,
per-minute totals and raw failure counts, and re-read current script/native
paths under the AngelScript and BAR-log skills. Individual final-minute AI
scopes total 43.103 s against 43.121 s aggregate. The original benchmark bundles
are unchanged. New analysis contains no new gameplay validation. Documentation
link checking retains only the known missing hover reference (KI-404).

**Invariant.** No gameplay or invariant checker changes. Original FAIL verdicts,
input hashes and evidence limits remain intact. Any later optimization must
preserve INV-088 and exact candidate/rule/task ordering, not trade behavior for
a lower benchmark number.

**Severity and solution follow-up (2026-10-04).** At the user's request, the
[re-ranked report](reviews/2026-10-04-skirmishai-performance-rerank.md) now
defines Low/Medium/High/Extra high and gives all nine items a concrete proposed
change, behavior safeguards and acceptance evidence. Severity rates impact,
not implementation effort or confidence in a fix. The confirmed TECH stall is
Extra high; script churn and local geometry are High; command production is
High provisionally for multiplayer risk, not a proved cause of the local
hitch. Owned-unit scans, diagnostics and worker duplication are Medium; AIR
query scaling and a production observer/UI rewrite are Low on current evidence.
The observer-off control remains necessary from the first experiment.

The alternative of equating command events with packets, promising an FPS
gain, or interpreting every same-frame failure as safely cacheable is rejected.
All recommendations preserve the unresolved attribution and original ranking;
items 1-4 overlap and their benefits cannot be summed. This follow-up touches
only this decision and the linked report. No runtime change or new simulation
is claimed; documentation checks are the applicable verification.


## D-199 - Remove redundant placement and allocation work without changing policy

**Decision.** Remove TECH's discarded CanPlace geometry probe; replace remaining
local slot/envelope scans with an exact sparse occupancy index; reduce owned
energy-array copies and duplicate context counts; remove custom-order parameter
copies through the same synchronous engine bridge. Add opt-in phase/GC
instrumentation and a live index-versus-scan oracle. Preserve every decision
threshold, rule order, candidate ordering, retry opportunity, random call,
command count, option, timeout and update interval.

**Reasoning.** The old admission gate promoted every failed probe to true, so
it could be simplified without guessing whether two failed placements share
all engine inputs. Local occupancy has fully observable mutations and admits
exact indexing. Invocation-owned arrays avoid shared-scratch/reentrancy risks.
The existing engine custom-command bridge consumes temporary parameters before
returning, so stack/span parameters preserve its contract without editing the
generated wrapper or vendor libraries.

**Alternatives rejected.** No whole-placement negative cache across decisions:
engine blockers/reclaim/terrain inputs do not have a complete tracked revision.
No GC tuning, coarser threat updates, new worker-thread engine calls, global
APM limit, or command suppression based only on repeated coordinates/state.
The latter can change queue renewal, timeouts or interaction with external
orders. The command allocation saving therefore does not resolve the unproved
multiplayer traffic risk. Nor does a microbenchmark prove that every late-game
TECH stall has been eliminated. These limits remain in KI-497.

**Files.** The [implementation and measured evidence](reviews/2026-10-04-high-severity-performance-implementation.md)
contains the full affected-file map, before/after examples, benchmark method,
runtime observations and remaining acceptance limits. Supporting contracts are
[this decision](decisions.md), [remaining issues](known-issues.md),
[invariants](invariants.md), [actor matrix](actor-matrix.md),
[script API](angelscript-references.md), and [TECH rules](roles/tech_rules.md).

**Verification.** The complete native suite passes, including 200,038 local
and 200,159 allied reservation checks. Extracted old/new AngelScript bodies
pass 20,000 ranking/filtering cases and 20,000 admission/memo cases. The actual
command adapter passes exact payload/option/timeout/error checks. Isolated
microbenchmarks measure indexed lookup scaling, script-array time/GC objects,
and command temporary allocations. The rebuilt DLL/symbols/data are published
together to the engine development install, with script/API parity checked.
The six-minute Supreme cross-role oracle run passes all twelve directed
exclusions without a runtime invariant. The detailed report retains the initial
compile failure and all full-game FAIL verdicts; final game measurements and
source identities are recorded there. No real engine save/reload, targeted
ownership-transfer scenario or host/peer multiplayer benchmark is claimed.

**Invariant.** INV-144 compares the exact local predicate with the old scan
when explicitly enabled. INV-088 and all existing gameplay checks remain
unchanged. Unit tests cover multiplicity, ignored/consumed slots, boundaries,
replacement, release and reconstruction. The oracle is disabled for timing.
No change to economy/combat policy is accepted as a performance improvement.


**D-199 measured refinement.** Named rule timers subsequently attributed the
remaining late-game cost to TECH weapon work reached through weapons.cluster,
air.defend and idle-air-defense. OutstandingOrders rescanned all weapon slots
for every eligible cluster. Work now shares that pure observation inside one
synchronous invocation, invalidating on dead-slot changes and before every
Order attempt. It skips definition resolution for slots already outside the
unchanged 300-second window. Repeated Work invocations were deliberately not
suppressed: earlier calls can alter slots and tasks. TechForward::Buildable
can also change a definition's cap, so it was not treated as a pure filter.

The extracted original/optimized Work and OutstandingOrders pass 20,000
three-invocation differential cases, including state mutation, an obstruction
clearing and time advancing. The engine-free 32-by-16-slot workload is 18.48x
faster, and an isolated engine fixture retains the real string/UnitDef mapping
for an additional same-input comparison. See the report for exact timings,
profile results and original verdicts. Full reruns lost the original late TECH
workload to combat, so the function-level gain is not presented as proof of
all-game FPS improvement. The new fixture files, runner and checks are listed
in the report; they are never deployed to production data.


## D-200 - Document performance contracts and index test definitions

**Decision.** Preserve D-199's exact behavior optimizations and explain their
complexity, ownership, invalidation and evidence in a shared engineering guide,
linked from the updated AngelScript skill and new C++ skill. Source comments
record paged occupancy and synchronous command borrowing constraints. Generate
categorized test documentation from existing definitions without moving evidence.

**Why.** Future changes need the proof behind an optimization, not only a faster
looking loop. A source inventory is different from a list of passing games.
Duplicating all guidance in every skill or renaming old benchmark directories
was rejected because it invites drift or broken evidence links.

**Invariant.** Documentation and discovery do not change runtime decisions or
rewrite historical results. Catalog records explicitly do not infer execution.

**Files and verification.** [Engineering guide](performance/engineering-guide.md),
[AS skill](../skills/convention-angelscript/SKILL.md), [AS performance reference](../skills/convention-angelscript/references/performance-and-safety.md),
[C++ skill](../skills/convention-cpp/SKILL.md), [agent map](../AGENTS.md),
[local index](../src/circuit/terrain/LocalReservations.h),
[command bridge](../src/circuit/spring/CustomCommand.cpp),
[test generator](../tools/knowledge/index_test_cases.py),
[generator tests](../tools/knowledge/test_index_test_cases.py) and
[generated catalog](testing/README.md). Three generator tests pass; documentation
link check reports only the eight pre-existing KI-404 hover links. The skill
creator's validator passes for all four updated/new skills after PyYAML was installed into an
isolated ignored validation directory; no global Python install changed.

## D-201 - Separate SEA combat from layout and give idle fleets finite objectives

**Decision.** Adaptive combat is SEA-only and independent of ExperimentalBuild.
Use a separate owned-unit census, body-local completed counter counts, recurring
scout procurement and earlier emergency admission after one recovery constructor.
A SEA director groups compatible hulls, searches reachable water, and routes
surface-only cohorts away from observed subs when nearby cover is inadequate.
Native close-contact tasks and existing artillery remain in use.

**Why.** A second blind periodic ATTACK command does not solve no-contact native
fallback. Broad formation/order suppression regressed D-189 fixtures. Reusing
native path/route execution and contact combat isolates the policy while enabling
objective-level regression checks. Zero threat weights are not themselves proof
of an ignored enemy; the independently verified SampleNavalThreat mask bug is
that IsHidden includes IGNORE, bypassing its intended profile exception.

**Invariant.** INV-145: an eligible SEA cohort member must accept its selected
route task. Player, retreat, carrier gadget and AA ownership take precedence.
Only explicitly SEA-managed routes gain naval offset checks and lifetime rules;
other roles retain their existing paths.

**Files.** [Design and acceptance matrix](sea-fleet-rework.md),
[operations](../data/script/src/manager/sea_operations.as),
[procurement](../data/script/src/manager/sea_combat.as),
[SEA role](../data/script/src/roles/sea.as), [factories](../data/script/src/roles/sea_factories.as),
[settings](../data/script/src/global.as), [pure decisions](../data/script/src/helpers/sea_math.as),
[tests](../tests/sea_math_tests.as), [route header](../src/circuit/task/fighter/RouteTask.h),
[route executor](../src/circuit/task/fighter/RouteTask.cpp),
[bindings](../src/circuit/script/InitScript.cpp), [contact sampler](../src/circuit/terrain/BattleAnalysis.cpp),
[arena runner](../tools/playtest/sea_arena.py), [fog case](../tools/playtest/cases/sea/combat/scout-fog.json),
[sub screen case](../tools/playtest/cases/sea/combat/surface-sub-danger.json),
[fog checks](../tools/playtest/checks/sea/combat/sea-fleet-search.json),
[screen checks](../tools/playtest/checks/sea/combat/sea-sub-screen.json),
[invariants](invariants.md), [actor matrix](actor-matrix.md), [role reference](roles/sea.md).

**Verification.** Baseline supplied surface combat on Glacial Gap engages by
0.5 game minutes. Candidate runtime results and limitations will be recorded
in the rework document; source inspection is not a claim of completed gameplay
acceptance.

**D-201 refinements found while playing.** The initial local dictionary census
ignored a failed get output, allowing conversion-temporary garbage to invent
counter coverage. DictIntOr now supplies a fallback after failure and has a real
embedded-dictionary regression. Sonar-only enemies can lack UnitDefs; SEA's own
GetSeaForceCount extension adds legal submerged unknowns (defId=-1, cost=0),
with script-controlled uncertainty credit. AIR keeps its original snapshot.
Threat costs expire after a 30-second memory; hidden locations are never queried.
Utility ships now follow routed cohorts because native SupportTask sees only
ATTACK/DEFEND. Siege is overridden only for immediate underwater screening and
then regains native control. Tracked hybrid AA boats return after a raid expires.
Legion T2 metadata registration follows either SEA combat or economy opt-in.

Additional files: [collection helper](../data/script/src/helpers/collection_helpers.as),
[dictionary regression](../tests/collection_helpers_tests.as),
[VM harness](../tests/production_math_test.cpp), [suite runner](../tools/run_native_tests.sh),
[snapshot header](../src/circuit/terrain/BattleAnalysis.h),
[observer](../tools/playtest/widgets/sea_arena.lua),
[source trace](sea-native-trace.md), [known limits](known-issues.md).
The rework report records original failed builds/checks as well as corrected
fixtures; no all-unit optimality or multiplayer FPS claim follows from them.

**D-201 completed observations.** See the [results report](sea-fleet-rework-results.md): twelve final combat fixtures and three natural twenty-minute games on Glacial, Supreme and Shore, fourteen PASS and one retained Cortex capacity FAIL; an older screen observation is retained separately. Native/VM tests, API, role and invariant checks pass. Existing benchmark evidence (4,985 files) is byte-for-byte preserved. KI-500/501 and unplayed acceptance limits remain explicit; these are not PvP victory or FPS claims.

**D-201 cleanup follow-up.** Final review replaced repeated dead-cohort removeAt with stable O(G) compaction while retaining reverse abort order and survivor order. A separate candidate-10 surface fixture with losses passed; the [results report](sea-fleet-rework-results.md) links its original record. Seventeen observations are now published, with earlier verdicts unchanged.


## D-202 - SEA scouts patrol independently and AA intercepts without merging

**Call.** Adaptive SEA owns one persistent route per scout/AA hull. Idle scouts
lease distinct safe water sectors. Known aircraft in the same connected sea,
including unarmed aircraft and coastal transits, interrupt available AA hulls
into a separated overlapping grid. Priority fire preserves MOVE/patrol queues;
lost contacts clear fire priority immediately, then movement memory expires
back to patrols. Other roles, production and economy retain their behavior.

**Why.** Herring is AA-only in experimental_hard, so the prior scout director
excluded it; the hybrid response admitted Armada alone. Native AA merged boats
to one point and repeatedly replaced idle FIGHT orders. The controlled baseline
recorded no patrol queues and 5,441 team orders in minute two. Persistent routes
and distinct slots address the reported behavior without a global rate limit.
One primary air contact per sea is selected near the protected coast; individual
weapons select nearer legal aircraft in range. Full multi-raid allocation is
not demonstrated. Destination separation cannot prevent all physical path crossings.

**Alternatives rejected.** Changing shared unit roles or native AntiAirTask
would affect other roles. A generic HasSurfToAir test admitted Legion's weak
scout gun but missed scout-first Iapetus metadata; explicit SEA AA admission
with actual AA capability is used. General surface danger includes aircraft,
so using it for interception made AA avoid its own counter target. Interception
instead excludes known naval/sub weapon danger, cached within one census;
patrol admission still checks surface and underwater danger. No omniscient
positions, blanket APM limit or worker-thread engine callbacks are introduced.

**Invariant.** INV-146: one SEA route owns each available scout/AA ship; a failed
transfer is logged, and all checks forbid invariant violations. Sector leases
and target priority release with ownership. Player, carrier and repair retreat
owners remain protected. Native priority-target commands require explicit SEA
control and cancel only the route's target ID. INV-133 is superseded rather
than silently kept as an unreachable old promise. See the
[invariant register](invariants.md) and [actor matrix](actor-matrix.md).

**Implementation.** [SeaPatrol](../data/script/src/manager/sea_patrol.as),
[combat census](../data/script/src/manager/sea_combat.as),
[surface owner exclusion](../data/script/src/manager/sea_operations.as),
[settings](../data/script/src/global.as),
[geometry policy](../data/script/src/helpers/sea_math.as),
[RouteTask](../src/circuit/task/fighter/RouteTask.cpp),
[route declaration](../src/circuit/task/fighter/RouteTask.h),
[bindings](../src/circuit/script/InitScript.cpp),
[VM regressions](../tests/sea_math_tests.as),
[arena runner](../tools/playtest/sea_arena.py),
[physical observer](../tools/playtest/widgets/sea_arena.lua),
[analysis](../tools/playtest/analyze_sea_patrol.py).
New scenario/check files are individually linked in the generated
[SEA test inventory](testing/index/sea.md); the
[catalog](testing/catalog.json), [inventory root](testing/README.md) and
[shared index](testing/index/shared.md) retain their established layout.

**Documentation.** [Design](sea-patrol-air-defense.md),
[results](sea-patrol-air-defense-results.md), [SEA reference](roles/sea.md),
[native trace](sea-native-trace.md), [superseded D-201 boundary](sea-fleet-rework.md),
[script API](angelscript-references.md), [known residuals](known-issues.md),
[benchmark catalog](benchmarks/catalog.json), [SEA evidence index](benchmarks/index/sea.md).
The results link all fifteen immutable evidence bundles, including the original
Legion prototype PASS rejected after detailed review. No older verdict was rewritten.

**Verification: Built and Played.** Twelve native executables and 372 embedded
VM functions pass. Six final Supreme supplied-force cases and a separate normal
20-minute economy game pass across all three experimental profiles. AA fixtures
kill their six/eight aircraft before administrative cleanup; the Herring patrol
fixture records twelve physical patrols at 90 seconds with 488-elmo mean nearest
separation, versus 22.4 in the baseline. First-minute team orders fall from
4,398 to 146. This is a behavior/control change, not measured FPS or packet gain.
Final matched DLL/debug/data were published to the required development output;
the live game installation was not changed. API/role/invariant/index checks pass.
Eight pre-existing missing-hover doc links and 167 existing unit-helper findings
remain. KI-502 records repeated native AA orders outside adaptive SEA. No 8v8
late-game performance or PvP victory claim follows from these fixtures.


## D-203 - Review siege normalization before changing ranged-unit target policy

**Call.** Do not apply the reviewed ten-unit artillery/siege normalization as
an automatic range fix. This decision records a source review. Keep runtime code and
configuration unchanged, and recommend separate target, range, travel and fire
policies plus per-unit acceptance tests.

**Why.** Native artillery excludes mobile targets; siege-tagged artillery uses
return fire and FIGHT travel. This is D-031's intentional structure-bombardment
behavior, not a generic stop-at-first-enemy promise. Reclassifying snipers,
skirmishers and the Mantis carrier can discard essential mobile-target behavior.
Replacing role lists also removes enemy-response classifications, and changing
shared profiles affects land roles as well as any naval users.

**Alternative rejected.** A byte-preserving two-property patch is mechanically
possible but does not satisfy the stated gameplay rationale. Forty-four objects
lack an attribute property, so even literal two-line replacement needs an
insertion rule. Configuration migration must pin the source and destination
versions and verify the actual loaded profile paths.

**Invariant.** Review-only: no runtime behavior, configuration bytes, sample
files or deployed build changes. Any future implementation must preserve naval
D-031 behavior unless explicitly changed and must demonstrate proactive mobile
engagement for units intended to fight armies. No new runtime invariant is
claimed before implementation.

**Files and verification.** The [review](reviews/2026-10-05-siege-classification-request.md)
records all ten units, native/engine/gadget traces, official unit references,
77 definitions across 15 active files, 75 differing objects, newline constraints
and a physical combat verification plan. The [known-issue register](known-issues.md)
adds KI-503 for the already-existing experimental Sheldon mismatch. Checked by
source/data inspection and primary-source research; no simulation or measured
performance improvement is claimed for this proposed change. This decision
file is the third and final documentation surface changed by the review.


**D-203 superseded in priority by D-204.** Its source findings remain valid,
but its emphasis on retaining anti-heavy specialization was too strong relative
to reported bait-induced mass losses. D-204 supersedes that recommendation
priority; no historical finding or decision has been deleted.

## D-204 - Safe range outranks heavy-target preference for ranged support

**Call.** Treat ranged-unit pursuit into repaired static defenses as the primary gameplay failure.
Ranged units, including Sharpshooter and Starlight, must not abandon a safe
firing position to chase a preferred target into repaired static coverage.
Heavy-target preference is subordinate to safe in-range useful fire. Accept
less target specialization if that prevents materially greater losses.

**Reasoning and alternatives.** Source tracing confirms that anti-heavy path
goals can approach within a path cell, normal attack can queue FIGHT at the
target, and squad attack deliberately compresses range/uses a first-row LOS
scout. Existing aggregate threat gates are not a hard per-unit safety contract.
Reject preserving current task labels as an acceptance criterion. Also reject
claiming that adding standoff alone is sufficient: its radial goal is not checked
against other hostile weapons. The exact artillery/siege request remains a
credible conservative experimental candidate, alongside explicit no-pursuit
range control; no winner is claimed without the bait/repair fixture.

**Invariant.** Proposed acceptance: target preference never authorizes pursuit
across the selected ranged unit's safe firing boundary; mobile targets may be
shot from safety. Advancement must still make useful progress. Review-only at
this point, so no new runtime invariant/log or implementation is claimed.

**Files and verification.** Updated the
[review](reviews/2026-10-05-siege-classification-request.md) with the revised
ranking, concrete native paths and baseline/config/no-pursuit comparison plan;
added KI-504 and a KI-503 priority clarification in
[known issues](known-issues.md). This decision records the correction. Checked
against source and official unit guides; the battle is reported evidence,
not a reproduced simulation. Runtime/config/deployed files are unchanged.


## D-205 - Plan an opt-in ranged controller without erasing combat classifications

**Call.** Plan a configured RangedEngagement component inside the existing
artillery task lifecycle, with native and experimental-script admission for
the ten reviewed land definitions. Preserve existing role/attribute lists,
production weights and non-opted artillery behavior. This is an implementation
proposal, not a runtime change or a benchmark-selected winner.

**Reasoning and alternatives.** D-204 requires safe useful fire before heavy
preference. Reusing the artillery task avoids a new task kind and duplicated
lifecycle plumbing, while an explicit branch avoids importing structure-only
selection, return-fire and FIGHT travel into every ranged unit. A per-unit
standoff number alone checks neither other weapons' coverage nor the route.
Changing shared squad or anti-heavy defaults would affect unrelated units.
The uniform artillery/siege configuration remains a controlled comparison.
Native default dispatch alone is insufficient because experimental military
handlers can bypass it, including TECH's low-income combat gate. The proposed
script admission intentionally overrides generic dispatch only for enabled
ranged definitions, including already-built or donated units. Carrier mode
requires its own gadget-interoperability test before enabling Mantis.

**Invariant.** Proposed: safety is an eligibility gate before target value;
a firing target never takes ownership of a pursuit path; one task owns orders;
known coverage constrains the whole approach; useful safe fire and advancement
must occur when available. No new runtime invariant is claimed until built.

**Files and verification.** Added the numbered [implementation plan](ranged-support-implementation-plan.md),
linked it from the [review](reviews/2026-10-05-siege-classification-request.md),
and added the continuation pointer to [KI-503/KI-504](known-issues.md). This
record explains the planned architecture. Checked against native/script source,
local BAR target/carrier gadgets and official unit guides. No native, profile,
script, deployment or simulated behavior changed. Unit tradeoffs and CPU/APM
benefits remain unmeasured until the specified A/B/C fixtures are played.


**D-205 refined by D-206.** Its native component and safety-before-value design
remain. D-206 replaces the separate enable boolean with one attribute and
corrects the proposed precedence over specialist missions; it also adds the
missing sensor-anchor and withdrawal-capability work.

## D-206 - One ranged attribute with capability-aware withdrawal and mission ownership

**Call.** Propose one new `ranged` attribute and four target presets: precision,
skirmish, bombardment and carrier. Preserve existing role/attribute entries,
using the new attribute as the only enable switch. Review every balanced siege
entry, but pilot the ten proposed land units; keep naval/air/static and optional
content on their existing owners. Sharpshooter also reuses `ret_hold` for an
emergency cloaked escape after its fire-state conflict is fixed.

**Reasoning.** Weapon arc, independent aiming, cloak, turning, reverse speed,
reload and explosion geometry are capabilities, not a reason to create many
unit-specific tags. Sharpshooter can aim while moving away; Starlight's frontal
arc and slow turn require earlier committed withdrawal and safe reorientation.
Tactical withdrawal may keep firing, while emergency repair escape has a
different owner and fire policy. Own LOS does not cap a shot supported by legal
allied observations; trajectory clearance still matters. Sensor support needs
cohort anchors because ARTY tasks are not ISquadTask instances. Specialist
routes such as TECH's Recluse/Arquebus flank must retain mission ownership.

**Alternatives rejected.** Do not redefine existing siege globally, replace all
role lists, add sniper/beam/kite/fragile bits, or use ret_fight as kiting. Do not
silently replace a specialist mission with default ranged admission. Do not
claim turret=true proves unrestricted aiming or raw death AoE is its radius.
No exact spacing/retreat percentage is declared optimal without physical tests.

**Invariant and scope.** Proposed only: one command owner, safe useful fire
before value, feasible escape based on real capabilities, stable dispersed
slots, and useful progress rather than permanent idling. No gameplay/config
change or new runtime invariant is claimed. Existing bits and non-opted paths
must remain equivalent when implementation begins.

**Files and verification.** Added the [complete inventory and proposal](reviews/2026-10-05-balanced-siege-attributes.md),
updated the [implementation plan](ranged-support-implementation-plan.md) and
[original review](reviews/2026-10-05-siege-classification-request.md), and recorded
KI-505 through KI-507 in [known issues](known-issues.md). Game mechanics are
recorded in [the shared withdrawal note](../../rjm.bar.docs/knowledge/60-tactics/69-ranged-fire-and-withdrawal.md).
This decision records the refinement. Source checked against CircuitAI
62ff92b2, BAR 1d267c20d1, Recoil 92efda5e60 and official unit/command guides.
Inventory: 46 base/Legion siege entries, five optional Scavenger entries, plus
five new proposal entries. No candidate simulation, damage improvement or
performance gain is claimed. Fixtures cover moving fire, cloak, arcs, blast
spacing, sensors, missions, full salvos, carriers and CPU/APM.


## D-207 - Opt-in ranged land combat with shared observations and independent firing

2026-10-05. The authorized implementation follows D-206: retain classifications,
append one ranged attribute, and specialize positioning, shot choice, withdrawal
and sensor support through JSON-controlled native mechanisms. The ten proposed
land units are the migration scope; existing naval, air and specialist missions
keep their owners. Reject blanket artillery/siege normalization because those
lists also drive counter accounting and discard useful mobile targeting.

**Invariant.** INV-147: an admitted ranged controller has a compatible loaded
weapon (or the explicit carrier adapter). Safety and path validity precede
target value. Movement and shot intent have separate owners; stale path results
cannot order a reassigned unit. Existing production and non-enrolled combat
remain outside this opt-in behavior.

**Implementation and evidence.** The [implementation reference](ranged-combat.md)
links every native/script owner, all JSON controls, research sources, test
runners and known verification limits. Shared spatial snapshots avoid a full
world scan per shooter; loaded weapon geometry is cached per UnitDef. The
path contract requires a full coarse cell even for a precise final firing slot.
The first failed and corrected simulations remain archived. Built and Checked:
C++ integration with warnings, 13 native suites, embedded VM policy tests,
77-entry profile preservation, API parity and measurement/storage regressions.
Played: per-unit combat, bait, closing assault, sensor escort, AA, friendly splash,
energy stall, unrelated death, configuration loading and population stress.
The [benchmark report](benchmarks/ranged-combat.md) is authoritative for exact
builds, passes, retained failures, command/CPU/FPS measurements and limitations.
A passing small fixture is not proof of multiplayer or long-game FPS parity.

**Refinements found in play/review.** Guided missiles use a 2-D ally corridor:
a straight height exemption missed a radar struck after a target died. Escape
estimation allows a half-turn for a forward-facing hull. Starlights forbid
advancing toward unidentified radar contacts while retaining permitted blind
firing. Applying that gate to Sharpshooters reduced bait clearance from nine
targets to four, so their cloaked, turreted approach was restored. A rear-only idle dispersal rule was tried and rejected: Starlight bait
clearance fell from nine targets to two without improving closing survival.
Retain validated formation routes and coverage rechecks; preserve the failed
trial as evidence rather than silently treating the extra restriction as safer.
The latter is a JSON lever, not a hardcoded unit-name exception (INV-149).

**Performance decision.** Replace per-frame ally-wrapper reconstruction with a
sorted reusable legal-ID snapshot; differential checks preserve the old view
(INV-148). Keep engine callbacks on the owning thread and do not impose an APM
ceiling. Shared snapshot cost fell in measured diagnostics, but the richer
controller still has a measured cost over the old behavior. Report that cost,
failed trials and safety/clearance tradeoffs instead of claiming zero FPS impact.

**Evidence tooling.** Publication encountered transient Windows directory
rename denials after copying result bundles. The [publisher](../tools/playtest/storage.py)
now retries only the atomic rename with bounded backoff; it never overwrites
a competing destination or rewrites original evidence. Permanent failure
retains the pending bundle. [Tests](../tools/playtest/test_storage.py) exercise
both outcomes; 20 storage tests passed. This change does not touch runtime AI.
The single-line sensor travel threshold and the stronger two-line coverage
scenario are distinguished in KI-511 and the benchmark report.


## D-208 - Investigate SEA control separately from scouting and shared combat

**Call.** Push the existing ranged work first, then investigate SEA water-control
and coastal-support selection on a separate branch. Retain gameplay policy
unchanged in this investigation; add two reusable Supreme shipyard fixtures,
optional observer-only asset removal/visibility measurements, and a concrete
SEA-only implementation/acceptance plan.

**Why.** A detected yard surviving is not sufficient evidence of a universal
shipyard firing defect. The visible-yard fixture kills at 39.6 seconds; the
short-fog fixture reacquires and kills at 46.2 seconds even though the director
returns to search. Current source lacks persistent static-site objectives,
unfinished-yard admission, strategic shipyard ranking, a target-preserving
contact handoff, explicit surplus shore allocation, and alternate known-target
selection after route failure. The specific reported PvP incident remains
unidentified in available target logs.

**Rejected alternative.** Do not replace the improved scout/AA patrols or
rewrite shared AttackTask priorities based on the report alone. Do not label a
brief lost contact as a reproduced permanent abandonment. Native default
combat already succeeds in both small baseline scenarios.

**Invariant.** No new runtime promise is claimed in this investigation. All
new playtest checks forbid existing invariant violations. Spectator observations
never enter AI policy, and the fixture never commands friendly warships.
Proposed mission invariants belong to the future implementation and its actor
matrix, as listed in the plan.

**Files.** [Investigation and implementation plan](sea-control-investigation.md),
[known issues KI-512 through KI-515](known-issues.md), [SEA reference](roles/sea.md),
[visible-yard case](../tools/playtest/cases/sea/combat/sea-control-visible-yard-supreme.json),
[fog-loss case](../tools/playtest/cases/sea/combat/sea-control-lost-yard-supreme.json),
[visible checks](../tools/playtest/checks/sea/combat/sea-control-visible-yard.json),
[fog checks](../tools/playtest/checks/sea/combat/sea-control-lost-yard.json),
[observer](../tools/playtest/widgets/sea_arena.lua),
[test inventory](testing/README.md), [test catalog](testing/catalog.json),
[SEA test index](testing/index/sea.md), [benchmark catalog](benchmarks/catalog.json),
[SEA evidence index](benchmarks/index/sea.md). The investigation links every
immutable observation bundle, including setup and watcher failures.

**Verification.** Two supplied gameplay cases pass on experimental_balanced,
with snapshots, commands, visibility samples and physical damage/destruction.
Three original failure observations are retained: invalid dry spawn, disk-space
startup failure, and an incomplete watcher that lacked process access. The
complete reattached observation is the same fog game, not another independent
replicate. API parity checks 303 members with zero findings. These runs do not
establish the original PvP incident, front-support correctness, FPS improvement
or a completed SEA fix. No `data/`, native code or profile file was changed.


## D-209 - SEA first-ship mex opening and post-T2 seaplane platform

**Decision.** Use Builder's actual first construction ship identity in both SEA
build paths, attempting native allied-aware reachable mex claims before creating
optional work. Keep the shared SEA/TACTICAL ladder unchanged. After a completed
T2 yard, require a seaplane platform before discretionary further factories.
Reserve its footprint and at least the configured reachable turret capacity.
Share existing valid support slots and reserve only missing capacity. Retry an
uncommitted support-starved platform site, not an active building.

**Why / alternatives.** The normal compact path never ran the experimental
mex-priority branch, and its census selected minimum engine ID rather than the
first ship. Global ladder changes would affect TACTICAL. A ship exit corridor
rejects flying-only factories, so platforms use common footprint reservations.
The first supplied test exposed a permanently short support footprint; requiring
a second whole twenty-slot bank was rejected. The second test completed the
platform but produced no aircraft: native switch importance classifies platforms
as T1 and suppresses their normal combat production after T2. A per-request
keepActive mechanism retains native weights and resource/viability checks without
changing shared JSON, metadata or other roles.

**Invariant.** INV-150 preserves mex task identity and existing ownership. INV-151
requires T2 completion and reachable reserved support at platform admission.
Existing INV-135 checks actual turret assist reach; INV-138 preserves forward
factory separation and INV-088 protects allied reservations.

**Files.** [SEA](../data/script/src/roles/sea.as),
[builder](../data/script/src/roles/sea_build.as),
[factory policy](../data/script/src/roles/sea_factories.as),
[economy](../data/script/src/manager/sea_economy.as),
[layout](../data/script/src/manager/sea_layout.as),
[settings](../data/script/src/global.as),
[math](../data/script/src/helpers/sea_math.as),
[tests](../tests/sea_math_tests.as),
[native manager](../src/circuit/module/FactoryManager.cpp),
[header](../src/circuit/module/FactoryManager.h),
[binding](../src/circuit/script/FactoryScript.cpp),
[API](angelscript-references.md), [invariants](invariants.md),
[actors](actor-matrix.md), [SEA reference](roles/sea.md),
[builder reference](roles/sea_build.md), [factory reference](roles/sea_factories.md),
[plan/results](sea-seaplane-transition.md),
[runner](../tools/playtest/run_sea_transition.py),
[observer](../tools/playtest/widgets/sea_transition_watch.lua),
[case](../tools/playtest/cases/sea/economy/seaplane-transition.json),
[checks](../tools/playtest/checks/sea/economy/seaplane-transition.json).

**Verification.** Native DLL built; 304 script API members checked with zero
findings; ten real-VM SEA policy tests pass. Supreme supplied acceptance passes
for Armada/Legion compact and Cortex experimental. Ordinary-resource Armada
experimental passes through aircraft output at 17:47; the compact game never
reached T2 by thirty minutes (KI-228). Both original supplied failures and the
failed natural run are retained. This is not an FPS or cross-role gameplay
benchmark. Evidence and limitations: [plan/results](sea-seaplane-transition.md);
[natural case](../tools/playtest/cases/sea/economy/seaplane-natural.json),
[natural checks](../tools/playtest/checks/sea/economy/seaplane-natural.json).


## D-210 - Require a funded economy before the SEA seaplane transition

**Decision.** Refine D-209 per the user's correction: a completed T2 yard selects
the next factory type but no longer suffices to admit it. Require minimum income
of 80 metal/s and 1500 energy/s over the shared mature ten-second window, then
uncommitted banks for the full platform cost plus 500 metal/1000 energy. Apply
the existing spending forecast with those reserves protected. Settings remain
SEA-owned; no native or other-role policy changes. Do not cancel existing work.

**Why / alternatives.** A bank gift cannot sustain another production line on
low income. A timer after T2 or another bank-only bypass does not fix that.
Full current-cost funding protects early T2 construction; a sustained income
floor also supports subsequent production. This is conservative tuning, not a
claim of universally optimal PvP timings. The existing unframed-cost scan is
shared by both bank eligibility and funding; other funding callers retain zero
reserves. Keep factory preference separate from affordability and cover native
switch, role and pinned-layout paths.

**Invariant.** INV-152 requires economic eligibility at platform commitment.
INV-150/151 continue to cover first-ship metal, T2 completion and turret capacity.

**Files.** [settings](../data/script/src/global.as),
[math](../data/script/src/helpers/sea_math.as),
[economy](../data/script/src/manager/sea_economy.as),
[layout](../data/script/src/manager/sea_layout.as),
[builder](../data/script/src/roles/sea_build.as),
[factory](../data/script/src/roles/sea_factories.as),
[SEA math tests](../tests/sea_math_tests.as),
[funding tests](../tests/build_power_math_tests.as),
[observer](../tools/playtest/widgets/sea_transition_watch.lua),
[case](../tools/playtest/cases/sea/economy/seaplane-transition.json),
[checks](../tools/playtest/checks/sea/economy/seaplane-transition.json),
[invariants](invariants.md), [actors](actor-matrix.md),
[SEA reference](roles/sea.md), [builder reference](roles/sea_build.md),
[factory reference](roles/sea_factories.md), [known issues](known-issues.md),
[plan/results](sea-seaplane-transition.md), [benchmark catalog](benchmarks/catalog.json),
[test catalog](testing/catalog.json).

**Verification.** Thirteen SEA and twenty funding actual-VM test functions pass.
Supplied Supreme verifies low-income rejection with abundant bank, then funded
admission, aircraft and turret assistance. The natural experimental run has no
platform by thirty minutes; the sampled post-T2 bank never reaches the new
threshold. Retain that failed deadline and the conservative gate, rather than
infer a universal timing goal from one unpaired run; KI-228 records the timing
limitation. No claim of a no-stall guarantee under later attacks/income loss.
Details: [plan/results](sea-seaplane-transition.md). D-209 timings remain historical.


## D-211 - Continuous SEA production and dedicated recovery submarines

**Decision.** SEA no longer pauses its T1 yard deliberately to save for T2.
Its native fallback uses the existing per-request keepActive lever for every
factory tier. Retiring/draining yards, player control, availability and native
resource checks still apply. A resurrection-sub target grows with both fleet
metal and income, with one pending support purchase at a time and the existing
two-resource funding check. Emergency counters retain precedence.

**Reason.** The user requested active labs at every tier, scalable recovery
support, and reclaim during low metal before flagship repair, resurrection,
and ordinary naval repair. The former utility branch requested only one sub;
native recovery inferred resurrection from capability regardless of metal.

**Implementation.** [SEA recovery policy](../data/script/src/manager/sea_recovery.as),
[role dispatch](../data/script/src/roles/sea.as),
[role exit](../data/script/src/roles/sea_build.as),
[production](../data/script/src/roles/sea_factories.as),
[settings](../data/script/src/global.as),
[pure decisions](../data/script/src/helpers/sea_math.as) and their
[VM tests](../tests/sea_math_tests.as). The new optional
[builder query](../src/circuit/module/BuilderManager.cpp) and
[declaration](../src/circuit/module/BuilderManager.h),
[binding](../src/circuit/script/BuilderScript.cpp),
[feature callback](../src/circuit/spring/SpringCallback.cpp) and
[declaration](../src/circuit/spring/SpringCallback.h) select legal safe reachable
work. A transient [task flag](../src/circuit/task/builder/BuilderTask.h) prevents
[resurrection](../src/circuit/task/builder/ResurrectTask.cpp) and
[reclaim](../src/circuit/task/builder/ReclaimTask.cpp) from changing a selected
feature behind the policy. [Reclaim removal](../src/circuit/task/builder/ReclaimTask.h)
releases an empty recovery task immediately. Ordinary tasks keep old behavior.

**Alternatives rejected.** Raising a global UnitDef cap or changing native
recovery defaults would affect other roles. Polling every sub's entire world
through engine wrappers each frame would add unnecessary CPU work. A fixed
sub count would not scale; filling yards with arbitrary units would hide
resource stalls rather than prove productivity. Keeping the old deliberate
T1 saving WAIT conflicts with the updated user requirement.

**Invariant.** INV-153: a SEA recovery sub's dedicated selector assigns only
reclaim, repair, resurrection or standby. Player/retreat/enemy-reclaim ownership
is preserved. Task identity survives normal rechecks; role exit detaches only
that worker. Post-load queries re-adopt current feature work; save/load has
not been played. No new serialized fields are introduced.

**Verification.** Fifteen actual-VM policy tests passed. The Supreme supplied
fixture exercised all four priorities, three recovery subs, and producing T1,
T2 and seaplane factories. Two earlier fixture failures are retained. Full
8v8 results and precise limitations are recorded in the
[design and evidence](sea-recovery-production.md). The
[runner](../tools/playtest/run_sea_recovery.py),
[observer](../tools/playtest/widgets/sea_recovery_watch.lua),
[fixture case](../tools/playtest/cases/sea/economy/sea-recovery-priorities.json),
[fixture checks](../tools/playtest/checks/sea/economy/sea-recovery-priorities.json),
[8v8 case](../tools/playtest/cases/sea/economy/sea-production-8v8.json) and
[8v8 checks](../tools/playtest/checks/sea/economy/sea-production-8v8.json)
are reusable definitions. No win-rate, network APM or old/new FPS claim.

D-211 follow-up: the supplied 8v8 exposed an existing allied-target null dereference
in [repair idle handling](../src/circuit/task/builder/RepairTask.cpp). Resolve
the ally ID just as Execute/Reevaluate already do; abort a missing target.
The [capacity case](../tools/playtest/cases/sea/economy/sea-capacity-8v8.json),
[checks](../tools/playtest/checks/sea/economy/sea-capacity-8v8.json) and
[independent evidence analyzer](../tools/playtest/analyze_sea_recovery.py)
separate injected capacity, natural economy and crash results. See the evidence
document for the exact pins and limitations.

D-211 final admission follow-up: the supplied run left corplat 23071 empty
for 58 seconds as metal income fell to 10/s (initial observed bank 1019).
Expose keepQueued=false in [FactoryManager](../src/circuit/module/FactoryManager.cpp),
[header](../src/circuit/module/FactoryManager.h) and
[script binding](../src/circuit/script/FactoryScript.cpp). SEA opts in through
KeepFactoriesQueued: skip the pre-enqueue resource WAIT, while the existing
recruit task retains energy and metal-priority safeguards. Other roles keep
the default. This matches the requested continuous queue without inventing
resource throughput. Rejected: forcing high priority or removing shared
resource protection. Final repeated evidence is in the D-211 report.

The [analysis regression](../tools/playtest/test_analyze_sea_recovery.py) guards
partial records and differentiates new products, stalls and empty queues.
The final supplied repeat has 950 completions, 2,898 samples, no 15-second
empty queue and a three-second longest observed completed gap. Its strict
FAIL for KI-516 and a destroyed-before-first-product platform is retained.


## D-212 — SEA converts surveyed water control into protected amphibious invasion

**Decision.** Add a SEA-only, script-owned transition: fresh LOS plus sonar coverage of the occupied connected sea, no known water enemies and a quiet interval permit an offshore amphibious complex. An economically funded gantry follows the completed complex and six actual construction turrets. The gantry gets a twelve-turret target. Ordinary ships protect the site; compatible naval contacts and existing scout/AA/player/retreat/carrier owners retain precedence. Amphibious cohorts use real movement-definition routes, assemble by count or timeout, land, then prefer dry routes toward legally observed enemy economy.

**Reasoning.** An empty contact list does not establish control of unscouted water. Assigned patrol destinations are not observations. A shore-facing naval factory planner accepts ship MoveDefs, so amphibious factories need their own ground-route validation while reusing shared persistent reservations. The observation history is lazy native mechanism, while freshness, quiet time, escort value, funding, factory order and products remain script settings.

**Alternatives rejected.** A timer-only victory assumption, spectator/hidden unit inspection, global amphibious classification changes, taking scout/AA ships away from their duties, or instantly constructing a gantry after a lab. Single-position gantry placement failed the first supplied Armada run; a bounded alternating flank/seaward search replaces it. Legion's coastal support rectangle failed despite useful individual pads: retain smaller valid patches instead of discarding every partial fit. Generic role labels are not required a second time after explicit naval-roster eligibility establishes an escort warship.

**Invariant.** INV-154 audits fresh surveyed control and actual combat-ship protection at factory admission. New unframed work is cancelled if that gate closes; already started frames remain investments. Shared native reservation state owns queued/framed/completed/lost construction. The normal lifecycle also prevents invasion production while retiring. Verification does not establish omniscience between the 64-elmo samples or after the observation freshness window.

**Files.** [Controller](../data/script/src/manager/sea_invasion.as), [settings](../data/script/src/global.as), [pure gates](../data/script/src/helpers/sea_math.as), [SEA hooks](../data/script/src/roles/sea.as), [builder admission](../data/script/src/roles/sea_build.as), [factory admission](../data/script/src/roles/sea_factories.as), [ship screen](../data/script/src/manager/sea_operations.as), [scout renewal](../data/script/src/manager/sea_patrol.as), [native observations](../src/circuit/terrain/BattleAnalysis.cpp), [native state](../src/circuit/terrain/BattleAnalysis.h), [sensor-history helper](../src/circuit/terrain/WaterSurvey.h), [bindings](../src/circuit/script/InitScript.cpp), [native tests](../tests/water_survey_test.cpp), [VM tests](../tests/sea_math_tests.as), [native test runner](../tools/run_native_tests.sh), [simulation runner](../tools/playtest/run_sea_invasion.py), [observer](../tools/playtest/widgets/sea_invasion_watch.lua), [positive case](../tools/playtest/cases/sea/combat/amphibious-transition.json), [positive checks](../tools/playtest/checks/sea/combat/amphibious-transition.json), [negative case](../tools/playtest/cases/sea/combat/amphibious-blocked.json), [negative checks](../tools/playtest/checks/sea/combat/amphibious-blocked.json). Contracts are recorded in the [actor matrix](actor-matrix.md), [invariants](invariants.md), [API reference](angelscript-references.md), [SEA reference](roles/sea.md), [builder reference](roles/sea_build.md) and [factory reference](roles/sea_factories.md).

**Verification.** Eighteen actual-VM SEA policy tests and nine native history checks pass. The lifecycle helper also rejects replanning claimed or started slots while recovering missing/exhausted reservations. All three experimental mains compile; real engine fixtures load the new bindings. Supplied faction runs and every failure are described in the [design and evidence](sea-amphibious-transition.md). Natural economy timing, save/load and multiplayer performance are separate, unproven claims. No TECH, AIR or shared profile classification/production policy is changed.

D-212 targeting follow-up: observed economy still wins, but when only map-start hypotheses remain, prefer AIR/TECH backline categories before distance. The weighted nearest score could select a cleared FRONT start beside the landing forever. Reject counting that beach as backline proof: the final observer requires dry position x>9500, z<3500 in the supplied Supreme enemy-base region, logs coordinates and captures the first gantry arrival. Older weaker-check results remain unchanged and are labelled separately in the evidence document.

D-212 support ownership follow-up: SeaBuild's generic production-factory loop retried a 24-pad rectangle every second around the same invasion site already owned by PlanSupport. Skip just the two actual pinned factory identities through GetReservationUnit; other/donated factories and income-based Support construction retain their path. This removes duplicate unsuccessful reservation searches rather than limiting commands or reducing threat response. The final Legion repeat also independently counts six/twelve completed in-range turrets.

D-212 escort lifecycle review: a replanned untouched factory changes the ship-screen goal. Reissue only when that stable goal moves, and use the existing ten-second route-failure retry. Route now takes an optional HOLD flag (false by default) so an interrupted invasion screen cannot leak its movement setting into a later naval objective. Core staging is exercised in the final repeat; dedicated blocked-site/hostile-return lifecycle injections remain future coverage.

D-212 performance qualification: the serial Legion counter stayed at 120 coastal turret-reservation creations and zero served events in both 18-24 minute windows. The ownership overlap is visible in source, but the counter does not identify its caller and does not demonstrate an aggregate gain. The earlier attribution of observed reservation churn to that specific loop is unproven. Keep the owner separation for its maintenance contract; claim no CPU/FPS/APM improvement. Residual work is recorded as KI-519.


## D-213 — Reclaim playtest disk space with verified symbol compression

**Decision.** Apply transparent Windows LZX compression only to uncompressed, unshared debug-symbol files in the local playtest store. Preserve all names, logical bytes, matching build identities, original observations and benchmark records. Expose an explicit dry-run-first maintenance command rather than changing gameplay, changing staging or automatically deleting historical runs.

**Reasoning.** The October 6 audit found 278.74 GiB of debug symbols in a checkout with 321.06 GiB of allocated file data; replays occupied approximately 22 MiB. Each simulation stages another full copy. Symbols are still needed to diagnose old crashes, so their disk representation can change but their contents must not. Four workers bound compression I/O; before/after SHA-256, file identity and modification time verify preservation. Already compressed/sparse files and hard links are left alone, and a game-process check protects ongoing simulations.

**Alternatives rejected.** Deleting raw game folders loses logs and replays not present in compact published evidence. Shared hard-link deduplication is unsafe with stage() copying into existing destination files. Moving archives off-drive would require a separately verified copy and artifact-location mapping; it is unnecessary for the immediate lossless compression pass.

**Invariant.** This is storage maintenance, not gameplay policy: each compressed file retains its path, SHA-256, logical length, identity and last-write timestamp; no original observation or published verdict is removed. Verification failures stop further batches. Existing runtime invariants are unchanged.

**Files and verification.** [Maintenance utility](../tools/playtest/compress_symbols.py), [storage contract](test-storage.md#reducing-windows-disk-usage-without-discarding-evidence), [audit/results](storage-cleanup-2026-10-06.md) and [per-file verification manifest](storage-cleanup-2026-10-06.json). Path-boundary/shared-link checks, 830 real content/identity checks and 7,322 protected benchmark/definition hashes passed; all 379,035 inventoried evidence files retain their identities, lengths and timestamps. Approximately 211.02 GiB was reclaimed without deleting files. The final dry run found zero remaining eligible symbols. Future copy growth remains [KI-520](known-issues.md#ki-520---simulation-staging-replicates-large-uncompressed-symbol-files). No AI implementation, benchmark verdict or live installation is changed.


## D-214 — Fund a bounded land-siege response before ordinary combat batches

**Decision.** Add a shared AngelScript budget helper and a FRONT-only producer for T2 land factories. Known static-defense metal, sustained ten-second income and current military investment determine a budget. Existing units, frames and unframed native recruit tasks all count against it. Constructor production retains precedence; TECH's existing production and caps remain unchanged; landlocked starts retain their amphibious policy. The supported roster is Tremor, Negotiator, Ambassador, Boreas, Sheldon and Thanatos. Incinerator movement, native ranged control and behavior JSON are unchanged.

**Reasoning.** FRONT's usual native response strongly favors assault/heavy investment over artillery. The initial TECH hook proved insufficient: its intentional T2 siege-unit and vehicle-factory caps remain closed. Remove that hook instead of silently lifting those restrictions. A bounded explicit admission fixes that missing response without relying on tiny factory-probability adjustments. Income ramps the dedicated siege share from 20% to 35%; the other bound is 1.25 times observed static metal divided by the native artillery team factor. Military armyCost includes static defenses: this limits investment but does not prove a nearby mobile screen exists. Native fallback can still recruit other artillery, so this is not a hard cap on all artillery production.

**Alternatives rejected.** Do not globally reclassify assault units, loosen fragile ranged-unit approach rules or alter TECH's factory cycle. Isolated and mixed Incinerator fixtures advanced and cleared their targets; they do not establish the cause of the user's reported stall. Picking any affordable siege unit first let cheap rockets consume every small budget increase. Instead select the desired investment mix before checking affordability, allowing ordinary production while saving room in the siege budget for a Tremor. No new periodic scan, timer or combat command is introduced; six pending-recruit lookups cost O(K*Q), K=6 and Q=pending recruit tasks, only at eligible factory decisions.

**Invariant.** INV-155 checks that each successful enqueue is immediately visible as exactly one more live-plus-pending recruit, before a second factory can admit another. No independent script queue or save-state counter is maintained.

**Files.** [Producer](../data/script/src/manager/land_siege.as), [pure budget](../data/script/src/helpers/land_siege_math.as), [settings](../data/script/src/global.as), [FRONT hook](../data/script/src/roles/front.as), [VM tests](../tests/land_siege_math_tests.as), [CMake registration](../tests/CMakeLists.txt), [test runner](../tools/run_native_tests.sh), [arena staging](../tools/playtest/ranged_arena.py), [suite acceptance](../tools/playtest/ranged_benchmark.py), [observer](../tools/playtest/widgets/ranged_arena.lua), [damage/production measurements](../tools/playtest/land_siege_report.py), [acceptance checks](../tools/playtest/checks/shared/combat/land-siege-production.json), [Incinerator case](../tools/playtest/cases/shared/combat/incinerator-front-push.json), [mixed case](../tools/playtest/cases/shared/combat/incinerator-mixed-front.json), [Cortex case](../tools/playtest/cases/shared/combat/land-siege-production-cortex.json), [Armada case](../tools/playtest/cases/shared/combat/land-siege-production-armada.json), [Legion case](../tools/playtest/cases/shared/combat/land-siege-production-legion.json), [Cortex bot case](../tools/playtest/cases/shared/combat/land-siege-production-cortex-bots.json), [Legion bot case](../tools/playtest/cases/shared/combat/land-siege-production-legion-bots.json), [no-static control](../tools/playtest/cases/shared/combat/land-siege-no-static.json). [Invariants](invariants.md), [actor ownership](actor-matrix.md), [FRONT reference](roles/front.md), [TECH reference](roles/tech.md), [test inventory](testing/README.md) and [benchmark catalog](benchmarks/README.md) record the contracts and evidence.

**Verification.** Checked in the actual AngelScript VM and Played with the unchanged D-212 binary. The [design/results report](reviews/2026-10-06-land-siege-response.md) records exact runs, baseline comparison, failures and scope. Supplied economy/held-army production is distinct from natural mid/late-game economy, victory rate or multiplayer performance. The unreproduced Incinerator report is tracked in KI-521; no movement fix is claimed.


## D-215 — Prefer valuable nearby targets for flying fortresses

**Decision.** Add a per-UnitDef JSON `target_min_cost` opt-in, set to 300 for
the reviewed Dragon/Tyrannus definitions in active profiles. Ordinary attack
and defense scans retain eligibility/threat filters and cheap fallback, but
prefer substantial contacts or commanders/AA within firing reach or twice the
ordinary target distance. Keep unlike targeting policies in separate squads.
Enable the formerly inert priority-fire hook only for opted-in definitions;
cancel its owned ID on task handover and invalidate it on STOP. AIR gives these
units a distinct defensive target group, using metal cost, AA/commander weight
and 15% incumbent retention instead of the ordinary group's 25,000 bonus.

**Reasoning.** Proximity selection and queued movement can waste surface fire
on cheap bait. These units have multiple surface mounts plus dedicated AA, so
hold-fire or a blanket ban on cheap targets would suppress useful damage and
self-defense. BAR priority fire leaves movement intact and incompatible
weapons free to acquire targets. The target priority is AI policy, not a game
weapon-stat modification. Research and inference are distinguished in the report.

**Alternatives rejected.** Do not globally change the shared fire stub,
reclassify all aircraft as anti-heavy, suppress all automatic fire, hardcode
unit names in C++, or add per-fortress whole-map/per-frame scans. Do not change
range, retreat, factory production or bomber-wave policy for this targeting fix.

**Invariant.** INV-156 audits that an enrolled AIR defender's target-policy
group matches its definition; the existing player/retreat/commitment invariant
remains. Supplied combat checks valuable-target damage, priority commands,
cheap-only fallback and simultaneous AA, with engine errors/invariants forbidden.

**Files.** [Preference helper](../src/circuit/task/fighter/TargetPreference.h),
[attack](../src/circuit/task/fighter/AttackTask.cpp),
[defense](../src/circuit/task/fighter/DefendTask.cpp),
[definition](../src/circuit/unit/CircuitDef.h),
[config loading](../src/circuit/module/FactoryManager.cpp),
[binding](../src/circuit/script/InitScript.cpp),
[unit fire](../src/circuit/unit/CircuitUnit.cpp),
[unit state](../src/circuit/unit/CircuitUnit.h),
[AIR defense](../data/script/src/manager/air_base_response.as),
[native tests](../tests/target_preference_test.cpp),
[test registration](../tests/CMakeLists.txt),
[runner](../tools/run_native_tests.sh),
[arena](../tools/playtest/ranged_arena.py),
[measurements](../tools/playtest/fortress_report.py).
Opt-ins are in the existing `corcrwh`/`legfort` entries of
[balanced](../data/config/experimental_balanced/behaviour.json),
[balanced Legion](../data/config/experimental_balanced/behaviour_leg.json),
[hard experiment](../data/config/experimental_hard/behaviour.json),
[hard experiment Legion](../data/config/experimental_hard/behaviour_leg.json),
[terrible](../data/config/experimental_terrible/behaviour.json),
[terrible Legion](../data/config/experimental_terrible/behaviour_leg.json),
[aggressive](../data/config/hard_aggressive/behaviour.json),
[aggressive Legion](../data/config/hard_aggressive/behaviour_leg.json),
[easy Legion](../data/config/easy/behaviour_leg.json),
[medium Legion](../data/config/medium/behaviour_leg.json) and
[hard Legion](../data/config/hard/behaviour_leg.json).
[API](angelscript-references.md), [AIR](roles/air.md),
[actors](actor-matrix.md), [invariants](invariants.md),
[unit report](knowledge/barb-unit-config.md), [test inventory](testing/README.md)
and [benchmark catalog](benchmarks/README.md) document the contract.

**Verification.** Evidence and exact limitations are retained in the
[fortress targeting report](reviews/2026-10-06-fortress-targeting.md), including
every supplied case and build identity. No full-game win-rate, late-game FPS
or network-performance claim follows from these controlled combat tests.

D-215 observation detail: BAR consumes priority commands before UnitCommand;
the analyzer therefore uses replicated target IDs while moving and the explicit
AIR defense target/actual damage for direct ATTACK, whose priority rules param
can legitimately be nil. [Analyzer regressions](../tools/playtest/test_fortress_report.py)
guard this distinction and exclude friendly damage from the success criteria.
Ten [case definitions](testing/index/shared.md) produce 17 rendered observations;
all final semantic checks pass. Native tests passed on repeat after KI-518;
the root/easy/medium/hard archaic Dragon coverage gap is recorded as KI-522,
not silently reclassified. This is a deliberate scope limit, not a claim of
all-profile migration. Validation and immutable run links are in the report.


## D-216 — Preserve factory scheduling and give funded T1 pressure one owner

**Decision.** Repeating production owns a persistent native recruit task,
exposed by a default-off script argument. All experimental roles use the shared
economic admission, pump cap, actual producer and MOVE lanes. TECH retains its
opening lab retirement and advanced-lab-before-rebuild sequence, but retiring
an idle lab cannot abort the manager's shared idle state. The spam roster owns
eligibility: JSON's colliding role/attribute name made the old attribute test
miss Pawns. Use actual lobby enemy starts before unused map slots and choose
nearby connected terrain when an endpoint sits on a cliff. Fatboy alone opts
into safe forward staging when no safe firing band exists.

**Reasoning.** The corrected supplied TECH baseline produced no Pawns while
floating about 200 M/s. Cancelling its first idle lab cleared the shared idle
assignee set. Fixing scheduling and queue lifetime yielded production, but
the units still scouted because of the role/attribute collision. Direct
engine observations now verify repeat and enemy-directed MOVE progression.
The Fatboy baseline independently reproduced a known-static coverage rejection
that held one hull at spawn. Moving it to a safe forward staging position
retains the reason for ranged control: no target chasing into static fire.

**Alternatives rejected.** Reissuing build commands every tick hides broken
ownership and adds synchronized commands. Raising only unit caps does not fix
idle scheduling or route assignment. Treating every broad spam-role unit as
disposable would also capture resurrection/support units. Globally relaxing
static avoidance would reintroduce ranged-unit diving. Requiring every SEA
start to build land spam would strand units on water-only starts.

**Invariant.** INV-157: every owned repeating pump has a nonempty reachable
MOVE route. INV-043 retains route ownership; INV-001 retains retirement.
Native abort rejects shared idle/nil/player state and already-dead tasks.
The economic boundaries are pure tested policy; thresholds remain tunable
engineering defaults, not a claimed universal PvP build order.

**Implementation files.**

- [src/circuit/module/TaskModule.h](../src/circuit/module/TaskModule.h)
- [src/circuit/module/TaskModule.cpp](../src/circuit/module/TaskModule.cpp)
- [src/circuit/module/FactoryManager.h](../src/circuit/module/FactoryManager.h)
- [src/circuit/module/FactoryManager.cpp](../src/circuit/module/FactoryManager.cpp)
- [src/circuit/script/FactoryScript.cpp](../src/circuit/script/FactoryScript.cpp)
- [src/circuit/script/InitScript.cpp](../src/circuit/script/InitScript.cpp)
- [src/circuit/task/static/RecruitTask.h](../src/circuit/task/static/RecruitTask.h)
- [src/circuit/task/static/RecruitTask.cpp](../src/circuit/task/static/RecruitTask.cpp)
- [src/circuit/task/fighter/RouteTask.cpp](../src/circuit/task/fighter/RouteTask.cpp)
- [src/circuit/task/fighter/RangedEngagement.cpp](../src/circuit/task/fighter/RangedEngagement.cpp)
- [src/circuit/unit/RangedPolicy.h](../src/circuit/unit/RangedPolicy.h)
- [data/script/src/manager/spam.as](../data/script/src/manager/spam.as)
- [data/script/src/helpers/spam_math.as](../data/script/src/helpers/spam_math.as)
- [data/script/src/manager/builder.as](../data/script/src/manager/builder.as)
- [data/script/src/manager/invariants.as](../data/script/src/manager/invariants.as)
- [data/script/src/roles/tech_build.as](../data/script/src/roles/tech_build.as)
- [data/script/src/roles/tech_forward.as](../data/script/src/roles/tech_forward.as)
- [data/script/src/global.as](../data/script/src/global.as)
- [data/script/src/task.as](../data/script/src/task.as)
- [tools/playtest/ranged_arena.py](../tools/playtest/ranged_arena.py)
- [tools/playtest/widgets/ranged_arena.lua](../tools/playtest/widgets/ranged_arena.lua)
- [tools/playtest/spam_report.py](../tools/playtest/spam_report.py)
- [tools/playtest/test_spam_report.py](../tools/playtest/test_spam_report.py)
- [tests/spam_math_tests.as](../tests/spam_math_tests.as)
- [tests/CMakeLists.txt](../tests/CMakeLists.txt)
- [tools/run_native_tests.sh](../tools/run_native_tests.sh)
- [data/config/behaviour.json](../data/config/behaviour.json)
- [data/config/easy/behaviour.json](../data/config/easy/behaviour.json)
- [data/config/medium/behaviour.json](../data/config/medium/behaviour.json)
- [data/config/hard/behaviour.json](../data/config/hard/behaviour.json)
- [data/config/hard_aggressive/behaviour.json](../data/config/hard_aggressive/behaviour.json)
- [data/config/experimental_balanced/behaviour.json](../data/config/experimental_balanced/behaviour.json)
- [data/config/experimental_hard/behaviour.json](../data/config/experimental_hard/behaviour.json)
- [data/config/experimental_terrible/behaviour.json](../data/config/experimental_terrible/behaviour.json)

**Documentation and verification.** [Investigation and measured results](reviews/2026-10-06-spam-and-fatboy.md),
[spam contract](spam-routes.md), [API](angelscript-references.md),
[TECH](roles/tech.md), [actors](actor-matrix.md), [invariants](invariants.md),
[test index](testing/README.md), [benchmarks](benchmarks/README.md) and the
[unit report](knowledge/barb-unit-config.md) carry the implementation contract.
The investigation records exact pinned runs and outstanding verification
limits. Supplied fixtures are not full-game win-rate or network-FPS evidence.


**Follow-through from construction tests.** `Spam::BuilderMakeTask` defers to
existing construction even before a frame exists: the native builder re-asks
while walking. This prevents abandoning pinned turret work. The older forward
constructor path now uses the same spam budget. Once those labs stood, the
test exposed a separate STOP-only retirement path in
[tech_factories.as](../data/script/src/roles/tech_factories.as); it now cancels
the real recruit/wait first, preserving the original three-factory reclaim
threshold. Updated contracts: [tech_forward](roles/tech_forward.md),
[tech_build](roles/tech_build.md), [tech_factories](roles/tech_factories.md).

The [deployment analyzer](../tools/playtest/deployment_report.py) requires
every supplied Fatboy to advance, and the
[benchmark runner](../tools/playtest/ranged_benchmark.py) invokes the explicit
deployment/production criteria. [Case definitions](testing/index/shared.md)
include all six roles, income loss, TECH construction and the blocked static
line. Original failed observations and revised analyzers are retained; v3
spam analysis requires enemy-directed movement, a complete window and clean
runtime checks. [KI-109](known-issues.md#ki-109--spam-activates-and-then-produces-nothing-and-the-log-cannot-say-why)
links the historical symptom to this diagnosis.

**Final verification.** Seven selectable profiles loaded successfully. All six
experimental roles passed repeat/MOVE tests; final TECH construction tests
passed in balanced and hard, and FRONT construction in terrible. Fatboy
deployment passed in balanced plus easy, medium, hard and hard_aggressive.
The native suite, API/invariant/role-doc checks and output parity passed; the
review records existing unrelated validator findings and full-game limits.

**Persistent owner guard.** `CRecruitTask::CanAssignTo` rejects a second
factory while a repeat task already has an assignee. Clearing its target at
offspring completion must not expose the still-running task as adoptable
work; it has one target pointer and one script owner. The final native build
passed adjacent-lab repeat/lane and TECH construction/retirement regressions.

## D-217 - SEA advances and fortifies mex clusters behind the navy

**Decision.** Give SEA a default-on moving-radius expansion policy before both
its economic paths. Retain native claims/terrain/ally checks and the metal-map
path. One ship expands, a second is eligible after three T1 ships. Other builders
retain economy/upgrades. Fortify remote mex groups with funded torpedo, surface
and observed-air defenses; require naval cover toward the contested front and
withdraw exposed expansion ships.

**Reasoning / alternatives.** The normal path stopped prioritizing mexes beyond
its home radius. Changing the shared constructor ladder would change TACTICAL.
Blindly extending the radius lost workers in the first rendered Glacial candidate,
so it was rejected. Legal weapon buffers, escort admission and an explicit
withdrawal were added. No new global path solver or per-frame MOVE loop is needed.
The conservative corridor screen leaves terrain detours to native movement;
alternate-candidate routing is tracked rather than claimed complete.

**Invariant.** INV-158 requires a native mex task after frontier admission.
Native task claims and ally layouts retain ownership. Player/retreat/external/
enemy-reclaim owners are excluded from handover; unfinished frames remain
recoverable after a threatened worker leaves.

**Files.** [policy](../data/script/src/manager/sea_expansion.as),
[SEA](../data/script/src/roles/sea.as), [builder](../data/script/src/roles/sea_build.as),
[settings](../data/script/src/global.as), [math](../data/script/src/helpers/sea_math.as),
[tests](../tests/sea_math_tests.as), [SEA reference](roles/sea.md),
[builder reference](roles/sea_build.md), [invariants](invariants.md),
[actors](actor-matrix.md), [issues](known-issues.md),
[runner](../tools/playtest/run_sea.py),
[observer](../tools/playtest/widgets/sea_expansion_watch.lua),
[analyzer](../tools/playtest/analyze_sea_expansion.py),
[case](../tools/playtest/cases/sea/economy/mex-expansion-glacial.json),
[checks](../tools/playtest/checks/sea/economy/mex-expansion.json),
[report](reviews/2026-10-06-sea-mex-expansion.md).

**Verification.** Actual embedded-VM loads and rendered natural games; the report
records exact results, immutable evidence and validation limits. The rejected
candidate's worker losses are retained. No whole-game FPS/APM claim is made.

**D-217 follow-up: preserve the local opening.** The first full ExperimentalBuild
run of the wider search missed team 0's ten-minute expansion target, whereas the
preserved old experimental path passed. Native `EnqueueMexWithin` returns pending
work before opening fresh spots. The final policy therefore keeps the old home
query first while the worker is near home, then tries fortification and the
moving frontier. This restores the local-order contract without changing native
selection or other roles. The unchanged acceptance suite then passed at 6.5
minutes. Both failed and passing observations are preserved in the D-217 report;
constructor losses remain reported rather than treating the smoke verdict as
proof that all workers survived.

**D-217 follow-up: protect support ships too.** The corrected full experimental
run passed expansion but lost four extra native-controlled construction ships
beyond the protected workers. Safety monitoring now uses an event-maintained
roster of all SEA T1 ship IDs, seeded once on activation. Expansion allocation
still uses only primary/secondary workers. The alternative of periodically
rescanning every owned unit was rejected; the roster avoids that callback and
retains no borrowed unit handles. This adds O(B*C) safety work once per second
for B construction ships and C legal sea contacts, not per-frame orders.

## D-218 - Recover lost mobile constructors through a queued TECH request

**Decision.** All six experimental roles request a T1 construction bot after
losing their last finished mobile constructor, even with a commander alive.
The normal commander-only opener is exempt. A team losing its commander before
its first constructor may request after 60 seconds. Thresholds and the optional
commander exemption are in `Global::BuilderRecovery`.

The request selects one TECH and stays there until cancellation or refusal.
TECH retains heartbeats while its T1 bot lab is absent; its existing reclaim
and rebuild sequence is unchanged. Production precedes optional T1 spam and
leases exactly one additional constructor slot. Only that factory's matching
finished product becomes a gift. An existing ferry delivers it to the existing
safe first-mex/start drop; otherwise ownership transfers immediately. No new
transport order is required for recovery. Repeated requests are idempotent;
a recipient that rebuilds independently cancels; cancelled episodes reject
late heartbeats. A TECH needing rescue refuses donor selection temporarily.

**Alternatives rejected.** Reusing the old spare-only orphan donor cannot
serve a missing lab and counted static nanos/commanders as recovery. Broadcasting
to every TECH would overproduce. Re-electing the nearest TECH every heartbeat
was found wrong in the first ferry fixture: recovering TECH drew requests away
from the active donor before building a lab. Sticky selection corrects it.
Changing TECH's lab sequence would violate its existing contract.

**Mechanism and performance.** A small optional host LuaUI widget relays
`CallUI` requests into `SendSkirmishAIMessage` on the next GameFrame. This is
actual Lua messaging, distinct from the same-process `AiSendMessage` fallback
used when the widget is absent. Both paths validate allied identity. Neither
reaches an AI hosted on another computer. Constructor availability uses add/remove
callbacks and stable IDs, O(1) count queries; retries occur every 20 seconds.
The once-per-second queue is bounded by allied team count, not army size.
Native tasks still own recruit/ferry unit orders; no per-frame micro was added.

**Invariant.** INV-159: each donor has at most one recovery obligation per
requesting team. A gift has one native owner (recruit/idle preparation/ferry),
and cannot be claimed as the donor's constructor leader.

**Files.** [Controller](../data/script/src/manager/builder_recovery.as),
[pure rules](../data/script/src/helpers/recovery_math.as),
[team dispatch](../data/script/src/manager/team.as),
[builder callbacks](../data/script/src/manager/builder.as),
[factory dispatch](../data/script/src/manager/factory.as),
[repeat spam](../data/script/src/manager/spam.as),
[settings](../data/script/src/global.as), and the Lua hooks in
[balanced](../data/script/experimental_balanced/main.as),
[hard](../data/script/experimental_hard/main.as),
[terrible](../data/script/experimental_terrible/main.as).
[Relay](../tools/widgets/gui_barb_builder_recovery.lua),
[math tests](../tests/recovery_math_tests.as),
[native runner](../tools/run_native_tests.sh), [CMake](../tests/CMakeLists.txt),
[scenario runner](../tools/playtest/run_builder_recovery.py),
[fixture](../tools/playtest/widgets/builder_recovery.lua),
[checks](../tools/playtest/checks/shared/economy/builder-recovery.json),
[invariants](invariants.md), [actors](actor-matrix.md),
[report](reviews/2026-10-06-builder-recovery.md).

**Verification.** See the report for pinned runs and their exact limitations.
The original failed fixtures and compilation error are retained. Save/load and
cross-host coordination are not claimed.


**D-218 verified follow-up.** Three final 8v8 supplied Glacial fixtures pass:
17 real gifts, all six requesting roles, Armada/Cortex/Legion bot menus,
Lua and native messaging, missing/replaced donor lab, cancellation and coastal
ferry delivery. The recovery-only wider landing anchor is retained by
[ferry.as](../data/script/src/manager/ferry.as); existing T2 default anchors are
unchanged. Failed fixtures exposed and corrected donor re-election and the
coastal search radius. Six math tests and the complete native suite pass.
See the report for timing, fixture overrides and immutable evidence links.
[Case: ferry](../tools/playtest/cases/shared/economy/recovery-ferry-lua.json),
[case: lab loss](../tools/playtest/cases/shared/economy/recovery-lab-loss.json),
[case: Legion](../tools/playtest/cases/shared/economy/recovery-legion.json),
[script guide](../data/script/README.md). Unit-sharing refusal remains KI-525;
save/load coverage remains within the existing KI-209 limitation.


## D-219 - SEA rebuilds inland and guards its coast only after losing water

**Decision.** Treat the user's final loss-only condition as the trigger. A gifted
land constructor joins coastal recovery after a previously held home sea loses
its viable own foothold for 30 seconds. A live navy remains naval-first. Require
60 stable seconds to return to naval strategy. Nearest allied SEA starts divide
friendly beaches, including edge approaches. Use a safe inland bot lab, storage,
working energy/mex economy, useful nanos and layered T1/T2 defenses/sensors.

**Reasoning and rejected alternatives.** A timer-only loss or constructor-gift
trigger would divert healthy naval players. Full walls in front of Pit Bulls
would block their shots: preserve central firing/traffic gaps and use staggered
flanks. Ordinary bot constructors cannot lay medium mines; use actual capable
workers instead of inventing that build edge. Storage alone cannot restart an
economy: retain inland mex/energy growth and one dedicated economic worker.

**Invariant.** INV-160: coastal recovery orders are SEA-only, loss-gated and dry;
native reservation/engine checks enforce legal footprints. Existing frames and
player/external/retreat/enemy-reclaim ownership are preserved. Other roles retain
their decisions. Explicit state gating precedes optional spam on this role only.

**Files.** [Controller](../data/script/src/manager/sea_coast.as),
[pure decisions](../data/script/src/helpers/sea_coast_math.as),
[settings](../data/script/src/global.as), [SEA hooks](../data/script/src/roles/sea.as),
[role exit](../data/script/src/roles/sea_build.as),
[builder dispatch](../data/script/src/manager/builder.as),
[factory dispatch](../data/script/src/manager/factory.as),
[spam gate](../data/script/src/manager/spam.as),
[unit tests](../tests/sea_coast_math_tests.as), [test registration](../tests/CMakeLists.txt),
[native runner](../tools/run_native_tests.sh),
[simulation runner](../tools/playtest/run_sea_coast.py),
[fixture](../tools/playtest/widgets/sea_coast.lua),
[case](../tools/playtest/cases/sea/strategy/coastal-fallback.json),
[checks](../tools/playtest/checks/sea/strategy/coastal-fallback.json),
[actor matrix](actor-matrix.md), [invariants](invariants.md),
[role references](roles/sea.md), [build reference](roles/sea_build.md),
[script guide](../data/script/README.md),
[design and results](reviews/2026-10-06-sea-coastal-fallback.md).

**Verification.** Built with the existing matched D-216 binary; six pure state
tests pass. Rendered supplied loss/constructor transfer/retake games and their
immutable original failures are listed in the results report. No natural win-rate,
network performance or complete save/load equivalence claim. KI-526 records the
remaining sea-control/placement limits rather than silently treating them as solved.


**D-219 final ownership and evidence (2026-10-06).** The
[invasion controller](../data/script/src/manager/sea_invasion.as) now suspends
its land waves during fallback; factory plans and existing frames remain.
Competing invasion/coast orders were rejected because a single owner must
command each survivor. On stable naval recovery, cancel only unstarted coastal
proposals. Nanos explicitly assist unfinished land-factory products. The first
T1 coastal turret precedes sensor expansion after an Armada run exposed starvation.

Played: final Armada Supreme and Legion Glacial 25-minute loss arenas, Armada
held-water negative control, and Cortex Supreme retake pass. Invaders take real
defensive damage; this is not proof of complete invasion denial. The natural
10-minute 8v8 Glacial run keeps naval priorities but remains FAIL on TECH
INV-013/019/029 (KI-423/KI-427). Full native/pure-script regression passes.

[Observation analyzer](../tools/playtest/analyze_sea_coast.py) adds immutable
measurements without replacing original verdicts. The
[test catalog](testing/README.md), [SEA test index](testing/index/sea.md),
[machine catalog](testing/catalog.json), [shared test index](testing/index/shared.md),
[benchmark catalog](benchmarks/catalog.json) and [SEA benchmark index](benchmarks/index/sea.md)
index the cases and retained original evidence. The
[result report](reviews/2026-10-06-sea-coastal-fallback.md) links each final
bundle and its screenshots, checks and source-log hashes. KI-526 retains the
remaining control/placement and save/load limits. No native implementation,
global unit classification or non-SEA priority change belongs to D-219.


## D-220 - Measure Metal Plate and Glacial 8v8 costs before changing behavior

**Decision.** Run serial, rendered, natural-resource 16-AI games with a pinned
D-216 DLL/current source data, staged read-only timing wrappers, lifecycle and
command observations, screenshots and matching AI-symbol instruction samples.
Use Metal Plate as dense land stress and Glacial's registered naval mix. Publish
original failures and pin each staged data file. Propose optimizations only;
production behavior is not changed by this investigation.

**Reasoning and rejected alternatives.** Aggregate APM is not proof of redundant
orders, engine parent timers are not individually avoidable CPU, and profiler-off
zeros are unavailable measurements. Do not promise a gain by summing nested
scopes. Unit caps, longer response intervals, fewer scouting runs and global APM
limits would violate the requested equivalence. Moving the VM or engine wrappers
wholesale onto workers would violate ownership/ordering. Keep already optimized
reservation collision lookup; investigate global release scans separately.

**Scope decision.** Metal was explicitly stopped after 30:01 at severe slowdown;
Glacial reached a 60-minute horizon, followed by a 12-minute SEA attribution run.
All 16 teams remained active at the last complete intervals. Neither main game
reached GameOver, so these are not matches completed to victory. A short initial
Metal fixture with a speed-restoration problem is retained and excluded. Camera
and profiler controls limit FPS conclusions; exact native phase measurements
and ordered source analysis drive the ranking instead.

**Invariant.** Every existing gameplay invariant remains forbidden in the
checks. Staged timers do not change policy order, RNG draws or competing-unit
commands. Retain original failed verdicts; a horizon stop is never a victory,
disabled profiler readings are unavailable, and nested scopes are not summed
as independent cost. Telemetry tests enforce these reporting distinctions.

**Files.** [Report and ordered remedies](reviews/2026-10-06-metal-plate-glacial-performance.md),
[runner](../tools/playtest/run_full_match_performance.py),
[read-only observer](../tools/playtest/widgets/full_match_perf.lua),
[analysis](../tools/playtest/analyze_full_match_performance.py),
[interval summary](../tools/playtest/summarize_full_match_performance.py),
[symbol reader](../tools/playtest/symbolize_instruction_samples.py),
[telemetry tests](../tools/playtest/test_full_match_performance.py),
[scenario](../tools/playtest/cases/shared/performance/full-match-profile.json),
[checks](../tools/playtest/checks/shared/performance/full-match-profile.json),
[playtest guide](../tools/playtest/README.md), [known issues](known-issues.md),
[test guide](testing/README.md), [test catalog](testing/catalog.json),
[shared test index](testing/index/shared.md),
[benchmark catalog](benchmarks/catalog.json),
[shared benchmark index](benchmarks/index/shared.md).
The report links all four immutable evidence bundles and their original hashes.

**Verification.** Three accepted diagnostic captures loaded all 16 scripts with
310-member API parity and no script errors. They still FAIL strict gameplay
invariants; retain that verdict. Three analysis tests, Python compilation,
invariant-practice and scoped whitespace checks pass. Eight missing hover doc
links remain pre-existing KI-404 debt. No old/new speedup, network improvement,
full victory or behavior-equivalence result is claimed. KI-527--531 record the
remaining work and precise validation requirements.


## D-221 - Preserve ranged decisions while reducing query and snapshot work

**Decision.** Replace pure boolean traversals with true early-exit queries;
index static hazards separately; retain dense touched-cell storage with sparse
overflow and stable ascending friendly IDs. Continue observing fresh legal
positions/definitions in each requesting AI's snapshot. Keep numeric danger
accumulation for exceptional inputs and unchanged magnitude consumers. Add
opt-in runtime old-predicate checks and nested attribution scopes.

**Reasoning and alternatives.** D-220 identifies ranged queries/snapshots as
extra-high native costs. Skipping response ticks, suppressing orders, changing
safety margins, caching positions across frames or sharing observations without
mutation versions would change behavior. Do not apply those alternatives.
Map-sized storage trades bounded memory for fewer hashes/allocations. Only pure
existence queries may stop early; ordered scoring and floating sums must not.

**Scope decision.** The rank-one animation/movement finding belongs to Recoil.
AGENTS.md prohibits modifications to that reference even when a request appears
to belong there. Retain KI-530 and identify upstream targets, without pretending
that CircuitAI query savings remediate engine animation cost. High/medium/low
findings are outside this first round.

**Invariant.** INV-161 compares safety and danger-sign results with original
predicates on the same live snapshot; INV-148 checks friendly observations.
Exact ordered-index tests include mutations, empty generations, overflow, ID
reuse and fallback sorting. No cadence, policy, command or RNG change is allowed.

**Files and evidence.** The [implementation report](reviews/2026-10-06-extra-high-performance-remediation.md)
links each native mechanism, test, benchmark and maintenance contract.
[Invariant register](invariants.md), [actor matrix](actor-matrix.md),
[known issues](known-issues.md), [C++ skill](../skills/convention-cpp/SKILL.md),
[AngelScript skill](../skills/convention-angelscript/SKILL.md),
[performance guidance](../skills/convention-angelscript/references/performance-and-safety.md),
[playtest skill](../skills/playtest/SKILL.md),
[ranged runner](../tools/playtest/ranged_arena.py),
[focused test runner](../tools/run_ranged_performance_tests.sh),
[test catalog](testing/README.md) and [benchmark catalog](benchmarks/README.md).

**Verification.** Native integration and full standalone native/AngelScript
regressions pass; 310-member DLL/API parity passes. Ordered geometry oracles
pass. Component timings are recorded separately from game/FPS results. Five
live combat fixtures pass both old-predicate/snapshot oracles. Full 8v8
horizons complete (Metal 30 minutes, Glacial 60); their strict gameplay verdicts
remain FAIL with 49/412 invariant events. The report records mixed whole-AI
results and population/call-count confounds. Published DLL, matching symbols
and data pass output parity. All three performance skills validate. Rank one
and residual KI-527 remain open; no engine or multiplayer improvement is claimed.

**Evidence publication correction.** The first component archive omitted the
`*-results.json` measurement file under its input exclusion rule. Preserve the
original immutable record and publish a labelled supplement with byte-identical
measurements and hashed validation output. The implementation report links
both; this is not a rerun or a revised measurement. See the
[evidence changelog](../changelog/2026/10/06/2026-10-06T173131-0300-ranged-evidence-supplement.md).

## D-222 - SEA grows local production capacity and hands its commander to economy after four turrets

2026-10-06. The user's four-turret clarification is authoritative. Both compact
(default) and experimental SEA paths use the same commander/capacity policy.
The commander guard no longer expires merely because three minutes passed.
Four completed, in-range static builders at a completed T2 yard permit economic
assist; reservations and incomplete frames do not count. Emergency resource
recovery remains possible when no productive factory/workforce can restart it.

**Decision.** Preserve SEA's first mex ship and emergency naval counters. Run a
funded workforce decision before discretionary combat production in both paths.
Recognize observed surplus/high-bank pressure; reserve full new costs and live
commitments, never add received metal to income twice. For a sustained high bank
at nominal deficit, use one observation window for metal's discretionary support
purchase while retaining the normal energy funding horizon. This budgets one
existing-bank purchase and does not forecast future gifts. Reject an arbitrary
constructor count increase or enabling the entire experimental economy path.

Use native, opt-in finite rear/side support geometry with actual footprints and
reach, shared allied reservations, minimum-four rollback, and a configurable
64-pad maximum. Full support reservation is not an instruction to build 64
immediately. Reserve T2/seaplane/provisional gantry sites early, preserve wide
forward departure corridors and place capital economy behind them. The existing
surveyed enemy-shore invasion still owns actual gantry construction; discard the
untouched home placeholder when its forward site is reserved. Later factories
must clear existing/planned economy and current factory progress, face the enemy,
and have a visible forward buffer. The newly requested no-yard recovery exception
supersedes D-192's historical no-recovery exception, but does not bypass allied
ownership or terrain legality. Do not change the Recoil engine.

**Invariant.** INV-162: SEA's commander economic handoff requires a completed T2
shipyard and four completed construction turrets in reach. INV-135 continues to
require support to reach its factory; INV-138 guards later factory placement;
INV-129 checks same-frame funding. Actor state and test scope are recorded in the
[capacity plan/results](sea-production-capacity.md).

**Files and verification.** [Plan](sea-production-capacity.md),
[SEA delegate](../data/script/src/roles/sea.as), [builder](../data/script/src/roles/sea_build.as),
[factory](../data/script/src/roles/sea_factories.as), [economy](../data/script/src/manager/sea_economy.as),
[layout](../data/script/src/manager/sea_layout.as), [invasion](../data/script/src/manager/sea_invasion.as),
[settings](../data/script/src/global.as), [math](../data/script/src/helpers/sea_math.as),
[geometry](../src/circuit/terrain/NavalGeometry.h), [terrain implementation](../src/circuit/terrain/TerrainManager.cpp),
[terrain interface](../src/circuit/terrain/TerrainManager.h), [visibility](../src/circuit/map/MapManager.cpp),
[visibility interface](../src/circuit/map/MapManager.h), [bindings](../src/circuit/script/InitScript.cpp),
[native tests](../tests/naval_geometry_test.cpp), [VM tests](../tests/sea_math_tests.as),
[runner](../tools/playtest/run_sea_transition.py), [observer](../tools/playtest/widgets/sea_capacity_watch.lua),
[case](../tools/playtest/cases/sea/economy/production-capacity.json),
[checks](../tools/playtest/checks/sea/economy/production-capacity.json),
[role](roles/sea.md), [actors](actor-matrix.md), [invariants](invariants.md).
Built native DLL and focused VM/geometry tests pass. Actual runtime verification
is in progress; no completed gameplay or performance claim yet.

D-222 natural-game correction: supplied capital hid an opening deadlock. The
commander no longer incidentally builds energy; the secondary ship followed the
expander, and native ENERGY priority became passive with full energy/empty metal
while commander factory assistance remained active. Keep a home energy worker,
permit six-site dense tidal fallback rows, and expose an opt-in unit resource
priority override retaining/restoring native requests. SEA alone enables it;
ordinary assisted combat uses surplus, constructors and urgent counters remain
active. Rejected changing shared task priorities or the game priority gadget.
Native effective-value caching prevents re-evaluation command oscillation.
Additional files: [unit mechanism](../src/circuit/unit/CircuitUnit.cpp),
[unit interface](../src/circuit/unit/CircuitUnit.h),
[natural runner](../tools/playtest/run_sea.py),
[read-only task probe](../tools/playtest/sea_capacity_probe.as),
[natural growth checks](../tools/playtest/checks/sea/economy/capacity-natural.json).
Final resource-priority gameplay verification remains pending.

D-222 verification update (2026-10-06 local / 2026-10-07 UTC): the full native
and VM suite passes, including 21 SEA policy tests. Supplied Armada, Legion
and Cortex games exercise the four-turret handoff; the latter two run the final
native DLL. Normal-fog compact Glacial passes growth checks through 20 minutes
with five construction ships, three nanos, ten mexes and twenty tidals. The
baseline has stronger mex income; this is not a measured overall opening win.

The first mixed normal-fog Supreme game passes SEA growth assertions but keeps
TECH invariant failures under KI-427. It also exposed experimental support
buying ahead of needed home energy. Both builder paths now ask HomeEnergy before
discretionary support, preserving expansion workers and existing frames. The
final repeat and all failed trials are indexed in the [results](sea-production-capacity.md).

The existing allied-base and transition observers used synced GlobalLOS even
for natural games. Restrict that command to supplied fixtures and reject its
log marker in natural checks. Original observations remain immutable and are
labelled with their visibility state; do not use them to claim normal scouting
or fog safety. The first Cortex watcher falsely inferred an engine exit due to
sandboxed process inspection (KI-524); the same game subsequently completed.
Further files: [guard identity](../src/circuit/task/builder/GuardTask.h),
[base observer](../tools/playtest/widgets/sea_allied_base_watch.lua),
[transition observer](../tools/playtest/widgets/sea_transition_watch.lua),
[analysis](../tools/playtest/analyze_sea_capacity.py),
[natural transition checks](../tools/playtest/checks/sea/economy/seaplane-natural.json),
[benchmark categorization](../tools/playtest/storage.py).

D-222 final experimental repeat: all four SEA growth checks pass, ten nanos
complete, but energy remains at twelve tidals/+310 E with repeated inland-geo
approaches (KI-235/KI-532). Preserve the overall FAIL and the existing default
ExperimentalBuild=false; do not claim the optional economy migration complete.
No changes to TECH policy or Recoil are included.

## D-223 - Preserve a valid native builder GUARD instead of resending it

2026-10-06. KI-533's native command path still resends guards after SEA's task
reuse changes. This correction belongs in CircuitAI; no Recoil change or role
build-order change is needed. Both Execute and OnUnitIdle inspect the live queue
before sending. Task ownership and target validity are checked first; Execute
still applies resource priority before considering command suppression.

**Decision.** Accept an equivalent GUARD at the head or behind valid single-unit
REPAIR, engine-internal MOVE, or the finite right-mouse clearance MOVE. The
engine can put REPAIR ahead of GUARD without INTERNAL_ORDER, so checking just
the head or that flag would still interrupt factory assistance. Reject expired,
malformed, option-changing or conflicting intent; a different GUARD, WAIT,
ATTACK or ordinary external MOVE is a barrier. SHIFT only records enqueueing
and does not change an already queued guard target. Use Recoil's strict-less-than
expiry boundary. No last-target cache, delay or command rate limit is introduced.
The callback adapter makes bounded stack copies, takes O(Q) time in the examined
queue prefix and O(1) storage; it does not allocate wrapper lists in normal play.

**Invariant.** INV-163: suppressing a builder GUARD requires a matching live
engine guard target, valid queue prefix/options/expiry and current task ownership.
The optional CIRCUIT_VERIFY_GUARD observer independently reads wrapper commands
for each suppression and logs a violation if the target has disappeared; native
unit tests exercise stricter prefix/options rejection and same-frame mutation.
No new script policy or profile default is introduced. Other guard task families
and unrelated order paths are deliberately unchanged.

**Files and verification.** [Report](performance/guard-orders.md),
[task](../src/circuit/task/builder/GuardTask.cpp), [task interface](../src/circuit/task/builder/GuardTask.h),
[queue predicate](../src/circuit/spring/GuardCommand.h),
[callback adapter](../src/circuit/spring/SpringUnit.cpp), [adapter interface](../src/circuit/spring/SpringUnit.h),
[predicate tests](../tests/guard_command_test.cpp), [callback tests](../tests/guard_callback_test.cpp),
[test targets](../tests/CMakeLists.txt), [native runner](../tools/run_native_tests.sh),
[callback runner](../tools/run_guard_tests.sh), [game runner](../tools/playtest/run_guard_regression.py),
[test-only script](../tools/playtest/guard_probe.as), [observer](../tools/playtest/widgets/guard_watch.lua),
[fixture checks](../tools/playtest/checks/shared/performance/guard-fixture.json),
[natural checks](../tools/playtest/checks/shared/performance/guard-natural.json),
[case](../tools/playtest/cases/shared/performance/guard-orders.json),
[invariants](invariants.md), [actors](actor-matrix.md), [maintenance guide](performance/engineering-guide.md).
Unit/adapter checks pass; rendered baseline and candidate verification is ongoing.

D-223 verification update: full native/VM and real C-callback tests pass.
Natural Glacial baseline `20261007T022319Z-fcc3debd` and candidate
`20261007T023003Z-453bb819` pass. The final supplied Supreme candidate
`20261007T024442Z-0b83606f` passes all recovery/production assertions; native
STOP response occurs in the same frame, observed three frames later. Earlier
fixture failures were traced to active SEA guard cleanup and rejected spectator
STOP/MOVE calls; isolate only test-owned guards and require synchronized command
acknowledgement plus physical displacement. Preserve the original verdicts.
The [analyzer](../tools/playtest/analyze_guard_orders.py) retains counts, source
log hashes and limitations; the [test index](testing/README.md) is regenerated.
No FPS or internet-network claim follows from the measured command reduction.

D-223 final matched recovery baseline `20261007T024642Z-c2f4c053` also passes.
Both final supplied runs finish 18 mobile units; GUARD counts are 102 before
and 5 after. [Trial measurements](benchmarks/guard-orders.json),
[test output](benchmarks/guard-orders-tests.txt) and immutable records linked
from the implementation report preserve successful and failed evidence.
The stripped DLL, matching symbols and all 336 production data files are
verified in the required development output; the live install is untouched.

## D-224 - Use AGENTS.md as the sole repository instruction entry point

2026-10-07. The owner requested removal of proprietary coding-harness
configuration. This supersedes the former AGENTS.md rule that kept a separate
router for each vendor. Even empty settings and instruction-only redirects
still require vendor-specific maintenance; keeping them was rejected.

**Decision.** Remove the eleven vendor instruction routers, the empty
`.claude/settings.json`, and the vendor-specific log-skill discovery link.
Move the playtest and startup-diagnosis runbooks from `.claude/skills/` into
`skills/` and expose them through the existing vendor-neutral `.agents/skills/`
links. Preserve their operational guidance, repair relative links, and replace
proprietary tool names in the screenshot instructions with capability wording.
AGENTS.md owns repository instructions; the open Agent Skills runbooks remain
reusable supporting material. No vendor metadata is introduced.

The removed routers are `CLAUDE.md`, `CONVENTIONS.md`, `GEMINI.md`, `GROK.md`,
`QWEN.md`, `.rules`, `.github/copilot-instructions.md`,
`.cursor/rules/circuitai.mdc`, `.windsurf/rules/circuitai.md`,
`.clinerules/circuitai.md`, and `.junie/guidelines.md`. GitHub CI, ordinary
editor/build configuration, and global user configuration are outside this
cleanup. The ignored `.claude/scheduled_tasks.lock` belongs to a still-running
process: retain that runtime lock and do not terminate its owner. It is not
repository configuration.

**Invariant.** No tracked proprietary coding-harness configuration remains in
the working tree. All six portable skills retain valid discovery links;
playtest/startup guidance and historical decision links remain accessible.
No production C++, AngelScript, profiles, CI behavior, or benchmark evidence
is changed, so no game simulation or DLL build is required for this migration.

**Files.** [Instructions](../AGENTS.md), [README](../README.md),
[playtest skill](../skills/playtest/SKILL.md),
[widget guide](../skills/playtest/references/widgets.md),
[startup skill](../skills/ai-not-moving/SKILL.md),
[playtest discovery](../.agents/skills/playtest),
[startup discovery](../.agents/skills/ai-not-moving),
[log skill](../skills/troubleshoot-bar-logs/SKILL.md),
[known-issue locations](known-issues.md),
[link checker](../tools/knowledge/check_doc_links.py),
[API-checker documentation](../tools/knowledge/check_script_api.py),
[playtest documentation](../tools/playtest/README.md),
[runner documentation](../tools/playtest/playtest.py),
[deployment-tool documentation](../tools/widgets/deploy_widgets.py).
Earlier entries here keep their content with links redirected to the moved
runbooks. Deleted files are listed above rather than linked to missing paths.

**Verification: Checked.** Repository inventory finds no remaining tracked
vendor configuration files. Startup and widget runbooks compare equal to their
originals after newline normalization; playtest changes are limited to paths
and tool-neutral wording. All six skill links resolve, and the modified Python
files parse. The generic skill validator cannot start in the bundled Python
because PyYAML is absent; the unchanged frontmatter is checked directly instead.
Documentation links introduce no new failures: the same eight pre-existing
links to the missing hover-role document remain (KI-404).
