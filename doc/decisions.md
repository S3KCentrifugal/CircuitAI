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

**Status.** Built (follow-up 2 DLL `4ba9b805...` deployed 2026-09-21 17:00 with
the script tree; parity check clean), not Played; see
[KI-411](known-issues.md#ki-411--the-experimental-build-system-is-not-yet-played).

---

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
