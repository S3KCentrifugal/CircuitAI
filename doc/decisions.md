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

**Status.** Diagnosed, **open**. Both the nuke and the Juno are currently mute.

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
