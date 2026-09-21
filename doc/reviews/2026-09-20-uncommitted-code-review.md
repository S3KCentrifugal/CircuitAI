# Uncommitted Code Review - 2026-09-20

**Review timestamp:** 2026-09-20 16:08:15 -03:00  
**Repository:** `S3KCentrifugal/CircuitAI`  
**Branch:** `smrt`  
**Reviewed base:** `1841f5cdee0adb8af900d06f74abd8c05b7f0734`  
**Verdict:** **Fail - not ready to commit**

## Executive summary

The review covered every uncommitted file in the working tree: 75 tracked
modifications and 12 untracked source/documentation files, for 87 files total.
The primary implementation delta is approximately 5,496 inserted and 428
deleted tracked lines, plus the untracked files.

The change set contains **8 P1**, **15 P2**, and **2 P3** findings. The highest
risk areas are:

- reservation ownership and save/load behavior in the new layout mechanism;
- use-after-free during extractor-upgrade reclaim cleanup;
- ferry failure paths that can transfer cargo while it is still attached;
- tactical-launcher friendly fire;
- runtime role switching that leaves native state from the previous role;
- the TECH eco planner assigning structures the requesting constructor cannot
  build;
- the host widget exposing enemy BARb layout plans and accepting cross-team
  route commands.

The repository's static gates also do not pass: `git diff --check` reports
introduced trailing whitespace, and the TECH role source marker is stale.
The JSONC files parse and the unit-helper validator passes.

## Scope and review basis

### Files reviewed

| Area | Files | Review focus |
| --- | ---: | --- |
| Native C++ | 34 | Task lifecycle, ownership, scheduler behavior, save/load, geometry, placement, combat targeting, engine commands, and script registration |
| AngelScript | 26 | 2.39.0 WIP compatibility, host API contracts, borrowed handles, role policy, task state, limits, layout, economy, and hot paths |
| JSON, Lua, and documentation | 27 | Configuration parity, UnitDef validity, widget protocol, implementation accuracy, traceability, and repository gates |
| **Total** | **87** | All tracked and untracked working-tree files |

Native review used CircuitAI's current callers and registrations, the
read-only Recoil engine checkout where engine behavior mattered, and the BAR
game definitions/shared game knowledge where weapon or build-option facts
mattered. AngelScript review used the vendored AngelScript 2.39.0 WIP
compatibility boundary, `data/script/README.md`,
`doc/angelscript-references.md`, and the repository's AngelScript convention
skill.

### Untracked implementation and design files included

```text
data/script/src/helpers/layout_helpers.as
data/script/src/helpers/sea_constructor_helpers.as
data/script/src/manager/eco_planner.as
data/script/src/manager/layout.as
doc/air-wave-attacks.md
doc/base-layout.md
doc/eco-planner.md
doc/launcher-targets.md
doc/layout-design.md
doc/start-position-control.md
src/circuit/task/fighter/AirWaveTask.cpp
src/circuit/task/fighter/AirWaveTask.h
```

## Findings summary

| ID | Priority | Location | Finding |
| --- | --- | --- | --- |
| CR-001 | P1 | `src/circuit/module/BuilderManager.cpp:849-853` | Mex-up reclaim cleanup can dereference a destroyed unit |
| CR-002 | P1 | `src/circuit/terrain/TerrainManager.cpp:677-684` | General build-site searches can consume reservations without transferring ownership |
| CR-003 | P1 | `src/circuit/terrain/TerrainManager.h:257-269`, `src/circuit/task/builder/BuilderTask.cpp:909-959` | Layout and task reservation state is lost across save/load |
| CR-004 | P1 | `src/circuit/task/fighter/FerryTask.cpp:378-384` | A failed dump can expose terminal failure while cargo is still attached |
| CR-005 | P1 | `src/circuit/task/static/SuperTask.cpp:146-157, 326-329, 465-478` | Tactical launchers can fire damaging AoE into friendly squads |
| CR-006 | P1 | `data/script/src/manager/eco_planner.as:171-198` | The eco planner can assign the commander an unbuildable structure |
| CR-007 | P1 | `data/script/src/manager/commands.as:157-198` | Runtime role switching does not reset or apply role-owned native state |
| CR-008 | P1 | `tools/widgets/gui_barb_team_link.lua:125-150, 757-779` | Layout overlay exposes enemy plans and permits cross-team commands |
| CR-009 | P2 | `src/circuit/module/EconomyManager.cpp:2175-2202` | Energy-condition overrides do not update active energy definitions |
| CR-010 | P2 | `src/circuit/task/builder/FactoryTask.cpp:91-129` | A blocked retry can lose or misattribute its original reservation |
| CR-011 | P2 | `src/circuit/task/fighter/AirWaveTask.cpp:77-81, 339-348` | Fully destroyed waves leave permanent live tasks |
| CR-012 | P2 | `src/circuit/task/fighter/DefendTask.cpp:121-128, 210-235` | Squad merging can bypass the configured attack-wait bound |
| CR-013 | P2 | `data/script/src/manager/air_waves.as:400-415` | Bomber hold timeout bypasses the income-derived wave floor |
| CR-014 | P2 | `data/script/src/manager/donation.as:263-289` | Failed constructor-donation orders can never time out |
| CR-015 | P2 | `data/script/src/manager/layout.as:356-373, 683-690` | Unbuilt advanced-solar tenants permanently block converter slots |
| CR-016 | P2 | `data/config/experimental_*/behaviour.json:116` | Stockpile comments incorrectly include configured EMP and Juno policy |
| CR-017 | P2 | `doc/layout-design.md:13` and synchronized summaries | Layout documentation describes safeguards and phases that are not built |
| CR-018 | P2 | `doc/base-layout.md:293-315` | Base-layout documentation publishes non-existent AngelScript signatures |
| CR-019 | P2 | `doc/roles/tech.md:492` | Constructor-request retry behavior is documented backwards |
| CR-020 | P2 | `doc/eco-planner.md:75, 137-141` | Eco-planner inputs and worked opening do not match the implementation |
| CR-021 | P2 | `doc/start-position-control.md:145` | Start-position proposal incorrectly says no DLL rebuild is needed |
| CR-022 | P2 | `doc/roles/tech.md:786` | TECH role source marker is stale |
| CR-023 | P2 | `doc/decisions.md:1401, 1594` | New D-023 references target a non-existent anchor |
| CR-024 | P3 | `src/circuit/task/fighter/FerryTask.cpp:58-60, 144-153` | Cargo parking can expire before the bounded ferry failure path |
| CR-025 | P3 | Multiple changed files | Introduced trailing whitespace fails `git diff --check` |

## Detailed findings

### CR-001 - Mex-up reclaim cleanup can dereference a destroyed unit

**Priority:** P1  
**Location:** `src/circuit/module/BuilderManager.cpp:849-853`

`RegisterReclaim` stores a raw `CAllyUnit*` as a key with a null task value.
An extractor-upgrade task can reclaim and destroy that extractor before its
later idle/cancel cleanup calls `UnregisterReclaim`. The null-valued entry is
not necessarily removed by the destruction path, while the action-unit
garbage pass can delete the unit object.

`UnregisterReclaim` erases the stale pointer key and then calls
`unit->GetId()` to update ally-team bookkeeping. That is a use-after-free in a
normal mex-upgrade lifecycle and can crash the AI.

**Required correction:** Key delayed reclaim bookkeeping by stable unit ID, or
remove the null-valued entry during destruction while the object is still
valid. Delayed cleanup must not derive an ID from the target pointer.

### CR-002 - General build-site searches can consume reservations without transferring ownership

**Priority:** P1  
**Locations:** `src/circuit/terrain/TerrainManager.cpp:677-684`,
`src/circuit/task/builder/BuilderTask.cpp:689-699`

`CTerrainManager::FindBuildSite` now consumes a matching reservation and
stores the reservation ID/facing in manager-global handoff fields. Only the
modified builder-task paths call `TakeReservedId`/`TakeReservedFacing`.
Existing non-task callers such as bus placement, energy-grid placement, hub
recruitment, and movement-placement searches can therefore consume a slot
without taking ownership of it.

The handoff fields are also not cleared at the beginning of every search. A
later unrelated builder task can claim stale reservation metadata, use the
wrong facing, and finish or restore the wrong slot.

**Required correction:** Make reservation selection and ownership transfer an
explicit task-aware API, preferably returning position and reservation
metadata together. At minimum, clear handoff state at each search entry and
prevent non-task callers from consuming slots.

### CR-003 - Layout and task reservation state is lost across save/load

**Priority:** P1  
**Locations:** `src/circuit/terrain/TerrainManager.h:257-269`,
`src/circuit/task/builder/BuilderTask.cpp:909-959`

The new reservations, zones, zone map, groups, ID counters, and layout flags
are not serialized. `IBuilderTask` also omits `reservationId` and
`pinnedReservation` from its save/load macro.

After loading a game, the AI loses planned ground, corridors, future slots,
group progression, and built-slot associations. Loaded builder tasks cannot
finish or restore the slots they owned before the save. Script-side IDs then
refer to absent native state, allowing fallback placement or inconsistent
phase progression.

**Required correction:** Serialize the complete native layout state using
definition IDs rather than pointers, serialize task reservation ownership,
restore blocking marks and counters before tasks resume, and version the save
format. A deterministic rebuild is acceptable only if it also relinks every
loaded task and built structure correctly.

### CR-004 - A failed dump can expose terminal failure while cargo is still attached

**Priority:** P1  
**Location:** `src/circuit/task/fighter/FerryTask.cpp:378-384`

The `DUMPING` branch enters `FAILED` when its timer expires even if
`IsLifted(cargo, frame)` remains true. It clears the native cargo ID and logs
the explicit `"timed out, still lifted"` condition.

The AngelScript failure path retains its own cargo ID and treats `FAILED` as
permission to call `GiveUnits`. The constructor can therefore be transferred
while still attached to the old owner's transport, recreating the exact
cross-owner cargo condition the dump state is intended to prevent.

**Required correction:** Never expose a terminal transferable state while
live cargo remains lifted. Keep retrying, or retain a nonterminal failed-dump
state until the cargo is confirmed on the ground or gone.

### CR-005 - Tactical launchers can fire damaging AoE into friendly squads

**Priority:** P1  
**Locations:** `src/circuit/task/static/SuperTask.cpp:146-157, 326-329, 465-478`

The new regional-launcher branch returns before the generic superweapon
scanner's friendly-squad exclusion. `SelectLauncherTarget` uses the shared
area selector, whose no-friendly-check assumption is valid for Juno and EMP
effects but not for Catalyst and Perdition.

Those launchers perform damaging AoE. Their BAR weapon definitions permit the
attack-ground behavior used here and do not make friendly overlap safe. A
valuable hostile cluster near friendly units can therefore cause a tactical
nuke or napalm strike on the AI's own army.

**Required correction:** Add a damaging-area mode that rejects or strongly
penalizes aim points whose blast overlaps friendly units. At minimum, preserve
the generic scan's own-squad exclusion.

### CR-006 - The eco planner can assign the commander an unbuildable structure

**Priority:** P1  
**Locations:** `data/script/src/manager/eco_planner.as:171-198`,
`data/script/src/roles/tech.as:1589-1601`

`EnergyOptions` claims to return structures the requesting constructor can
build, but `Make` checks only `CCircuitDef::IsAvailable`. Availability is not
the requesting builder's build-option list.

On a low-wind map at the advanced-solar income gate, an Armada or Cortex
commander can select `armadvsol` or `coradvsol`, neither of which is in that
commander's build options. The direct task return bypasses the native
selection path that would normally reject the incompatible build definition.
The commander can repeatedly receive a task it cannot execute and stall early
economy construction.

**Required correction:** Filter candidates against the requesting unit's
actual build options. If that query is not script-visible, expose a native
`CanBuild` mechanism or use constructor-class-specific candidate sets.

### CR-007 - Runtime role switching does not reset or apply role-owned native state

**Priority:** P1  
**Locations:** `data/script/src/manager/commands.as:157-198`,
`data/script/src/setup.as:369-374`

`SwitchRole` restores per-definition state and invokes the incoming
`InitHandler`, but it has no transition contract for native manager state or
role-owned layout state.

Consequences include:

- switching into TECH enables layout handling but never invokes the layout
  plan handler, so no complex is composed;
- switching out of TECH leaves layout enabled and reservations active, so
  shared builder paths can keep using TECH placement;
- AIR's porcupine globals and `porcAllyAA`, SEA's `attackWait`/`attackScale`,
  and TECH's economy overrides can leak into the next role;
- incoming porcupine and layout handlers are not reapplied.

**Required correction:** Add an explicit role-transition reset/apply
lifecycle. Restore baseline manager settings, release or disable obsolete
layout state, run the incoming role's initialization, recompute limits, then
apply its porcupine and layout delegates.

### CR-008 - Layout overlay exposes enemy plans and permits cross-team commands

**Priority:** P1  
**Locations:** `tools/widgets/gui_barb_team_link.lua:125-150, 757-779`

`refreshTeams` records every live AI team and does not filter by the local
ally team. `/barblayout` sends a query to every team in that list, so a host
running opposing BARb instances can receive and draw enemy reserved, held,
planned, and built layout data regardless of LOS.

The route command uses the selected unit's team without checking alliance or
ownership. A full-view spectator can therefore route an enemy BARb builder.
The engine's local AI message dispatch does not supply the missing alliance
authorization, and the script command validates only that the embedded team
ID matches the receiving AI.

**Required correction:** Filter discovery, incoming layout messages, and route
targets to an explicitly permitted ally team. Define a separate spectator
policy instead of treating every locally hosted AI as authorized.

### CR-009 - Energy-condition overrides do not update active energy definitions

**Priority:** P2  
**Location:** `src/circuit/module/EconomyManager.cpp:2175-2202`

`SetEnergyCondition` mutates the canonical entry returned by
`GetAvailInfo`. Active energy definitions used by `UpdateEnergyTasks` are
copies created when definitions are added to the available list. Those active
copies are not updated.

TECH can log and read back the new limit through `GetEnergyLimit` while native
selection continues applying the old limit and income gates.

**Required correction:** Add a mutable available-list update that changes both
the canonical entry and any active copy.

### CR-010 - A blocked retry can lose or misattribute its original reservation

**Priority:** P2  
**Locations:** `src/circuit/task/builder/FactoryTask.cpp:91-129`,
`src/circuit/task/builder/BuilderTask.cpp:689-699`

When a task's previously served site becomes temporarily unbuildable, the
retry searches again without releasing or clearing the existing reservation.
If another reservation is served, the first remains consumed and its ID is
overwritten. If the retry falls back to an ordinary position, the old ID is
retained and later associated with an off-slot structure.

This can advance group counts without the planned building, strand the
original slot, and restore the wrong location after destruction.

**Required correction:** Release/restore the old slot before abandoning its
position, clear task and pin state, and assign a reservation ID only when the
new position came from that reservation.

### CR-011 - Fully destroyed waves leave permanent live tasks

**Priority:** P2  
**Locations:** `src/circuit/task/fighter/AirWaveTask.cpp:77-81, 339-348`

`RemoveAssignee` erases wave membership but does not abort when the last unit
is removed. `Update` then returns forever on an empty unit set. The script does
not abort an empty native task.

Every wiped wave can remain permanently in the military manager's task sets
and scheduler, with no task-removed callback. Repeated losses accumulate dead
tasks for the rest of the match.

**Required correction:** Abort from `RemoveAssignee` when the final assignee
is removed, matching other native task types.

### CR-012 - Squad merging can bypass the configured attack-wait bound

**Priority:** P2  
**Locations:** `src/circuit/task/fighter/DefendTask.cpp:121-128, 210-235`

Forced promotion uses only the receiving task's `createdFrame`. When an older
squad merges into a newer equal-or-stronger squad, its units inherit the
newer's later timer. Repeated merges can defer attack indefinitely and
recreate the army-massing behavior the wait cap was added to prevent.

**Required correction:** Preserve the minimum creation frame across a merge.

### CR-013 - Bomber hold timeout bypasses the income-derived wave floor

**Priority:** P2  
**Location:** `data/script/src/manager/air_waves.as:400-415`

The normal launch condition requires `bombers >= Required()`. The timeout
condition requires only the fixed first-wave size. At high income, a five-unit
group can therefore launch when the income floor requires a much larger wave.

The comment says timeout waives only the escort requirement, but the code also
waives the bomber requirement.

**Required correction:** Require `bombers >= required` in the timeout path and
use timeout only to waive fighter escort.

### CR-014 - Failed constructor-donation orders can never time out

**Priority:** P2  
**Location:** `data/script/src/manager/donation.as:263-289`

The function returns when pending requests are not greater than `ordered`
before evaluating the order timeout. With one pending request and one failed
order, the timeout block is permanently unreachable.

`ordered` is also incremented before confirming that `Enqueue` returned a
task. A dead lab, cap change, aborted task, or null enqueue can therefore leave
the request permanently pending with no replacement order.

**Required correction:** Process expiration before the count-based return and
increment `ordered` only after a non-null task is returned.

### CR-015 - Unbuilt advanced-solar tenants permanently block converter slots

**Priority:** P2  
**Locations:** `data/script/src/manager/layout.as:356-373, 683-690`

Advanced-solar reservations occupy the same converter-zone cells as the later
advanced-converter band. The converter phase releases unconsumed solar and T1
converter tenants but omits unconsumed advanced-solar slots.

Native band creation rejects overlapping reservations, while
`ReclaimTenantFor` can reclaim only built tenants. Unbuilt advanced-solar
holds therefore permanently reduce planned converter capacity and eventually
push converters outside the complex.

**Required correction:** Release the unconsumed advanced-solar tenant group
when the advanced-converter phase starts.

### CR-016 - Stockpile comments incorrectly include configured EMP and Juno policy

**Priority:** P2  
**Locations:** `data/config/experimental_balanced/behaviour.json:116`,
`data/config/experimental_hard/behaviour.json:116`,
`data/config/experimental_terrible/behaviour.json:116`,
`doc/launcher-targets.md:75-76`

The comments say the stockpile floor governs nukes, EMP, and Juno. Configured
pulse and EMP weapons return from their specialized branches before
`StockedShotFloor` is reached. The settings affect tactical launchers and
generic stockpiled group-scan weapons, including nukes, but not configured
EMP/Juno policy.

**Required correction:** Narrow the documentation to the actual consumers and
explicitly exclude configured EMP and pulse targeting.

### CR-017 - Layout documentation describes safeguards and phases that are not built

**Priority:** P2  
**Locations:** `doc/layout-design.md:13`,
`AGENTS.md:115`, `data/script/README.md:95`,
`doc/roles/tech.md:635-636`

The current-state text says the recommended 176-elmo converter firebreak,
rear fusion gap, and ring road were adopted. Current settings make both flank
gaps zero, and the composer creates no ring-road reservation.

The phase description is also stale: advanced-solar tenants are armed during
initial band definition, and the fusion phase begins when any T2 constructor
exists. It does not wait for the triggers described in the document.

**Required correction:** Describe the actual D-057 tight-flank layout and
actual phase gates. Keep superseded firebreak/ring-road material explicitly
under proposal/history sections and synchronize the repository summaries.

### CR-018 - Base-layout documentation publishes non-existent AngelScript signatures

**Priority:** P2  
**Location:** `doc/base-layout.md:293-315`

The "registered" API omits the nano definition, uses a `count` parameter, and
shows default arguments that the actual bindings do not provide. The example
call will not compile against `InitScript.cpp`.

**Required correction:** Replace the signatures and examples with the actual
registered API. Keep hypothetical APIs such as `ReserveClass` clearly
separated from built interfaces.

### CR-019 - Constructor-request retry behavior is documented backwards

**Priority:** P2  
**Location:** `doc/roles/tech.md:492`

The document says a requester re-asks after cooldown only while no TECH is on
the roster. The implementation sends no automatic request until a TECH ally
is known, and the default `MaxRequests = 1` prevents an automatic retry after
the first request.

**Required correction:** Document that the automatic request is sent once,
only after a TECH ally is present, and that cooldown does not create a retry
under the default limit.

### CR-020 - Eco-planner inputs and worked opening do not match the implementation

**Priority:** P2  
**Locations:** `doc/eco-planner.md:75, 137-141`,
`doc/roles/tech.md:733-735`, `doc/decisions.md:2223-2224`

The documents say current wind and tidal strength influence the decision.
`WindEffective` uses only minimum and maximum wind; current wind is captured
but not read, and no tidal option is added to the decision candidates.

The windy worked opening is also arithmetically wrong: with 30 starting
energy and 12.5 output per turbine, four turbines produce 80 E/s, still below
the documented 90 E/s target. The branch order asks for a fifth turbine before
storage.

**Required correction:** Separate telemetry-only values from decision inputs
and recalculate examples from the implemented branch order.

### CR-021 - Start-position proposal incorrectly says no DLL rebuild is needed

**Priority:** P2  
**Location:** `doc/start-position-control.md:145`

The proposal requires registering `CTerrainManager::CanBeBuiltAt` for script,
then says no DLL rebuild is required. The method is not currently registered;
adding a native binding necessarily rebuilds the AI DLL.

**Required correction:** State the native rebuild requirement or redesign the
proposal around an already registered API and document the semantic
difference.

### CR-022 - TECH role source marker is stale

**Priority:** P2  
**Location:** `doc/roles/tech.md:786`

The marker records `70d553b63d92/2315`, while the changed role script is
`33995e0e3541/2336`. This defeats the repository's source-to-role-document
traceability gate.

**Required correction:** Review the final role source against the document,
then refresh the marker with `check_role_docs.py --update`.

### CR-023 - New D-023 references target a non-existent anchor

**Priority:** P2  
**Locations:** `doc/decisions.md:1401, 1594`

The links target
`#d-023--transports-get-their-native-task-before-any-role-policy`, but the
heading generates
`#d-023--a-ferry-transport-gets-its-native-task-before-any-role-policy`.

**Required correction:** Use the actual heading anchor at both call sites.

### CR-024 - Cargo parking can expire before the bounded ferry failure path

**Priority:** P3  
**Locations:** `src/circuit/task/fighter/FerryTask.cpp:58-60, 144-153`

Cargo receives a fixed five-minute builder wait. The declared state deadlines
can total approximately 340 seconds before retry travel is included: travel
to cargo, load retries, travel to drop, unload retries, and dump timeout.

The builder wait can expire while the ferry still owns the run, allowing
builder scheduling to issue commands before pickup, during transport, or
during recovery.

**Required correction:** Keep cargo parked for the ferry task's lifetime, or
renew the wait from actual remaining state deadlines.

### CR-025 - Introduced trailing whitespace fails `git diff --check`

**Priority:** P3  
**Locations:** Three Legion JSON files and multiple added ranges in
`src/circuit/module/MilitaryManager.cpp`

`git diff --check` reports trailing whitespace in:

- `data/config/experimental_balanced/behaviour_leg.json`;
- `data/config/experimental_hard/behaviour_leg.json`;
- `data/config/experimental_terrible/behaviour_leg.json`;
- multiple newly added ranges in `src/circuit/module/MilitaryManager.cpp`.

This is not a runtime defect, but it fails the repository's required
working-tree check and obscures meaningful whitespace review.

## Validation results

| Check | Result | Notes |
| --- | --- | --- |
| `git diff --check` | **Fail** | CR-025: introduced trailing whitespace |
| JSONC parse for all six changed behavior files | Pass | Parsed with comments enabled and trailing commas disabled |
| `python tools/knowledge/check_unit_helpers.py` | Pass | No invalid unit IDs; informational `armdfly` coverage gap only |
| `python tools/knowledge/check_role_docs.py` | **Fail** | CR-022: stale TECH source marker |
| `python tools/knowledge/check_doc_links.py` | Known baseline failure | Eight `hover.md` links fail because `doc/roles/hover.md` is absent; this is already registered as KI-404 and was not counted as a new finding |
| IDE C++ diagnostics | Inconclusive | VS Code lacks Recoil-generated include paths, so syntax diagnostics stop at missing engine headers |
| Native integration build | Not rerun | This repository requires Recoil's generated C++ AI wrapper; the trusted Recoil checkout is read-only |
| AngelScript host compile | Not available | KI-402 records the absence of a standalone profile compiler |
| In-game behavior | Not run | The changed layout, ferry, air-wave, launcher, donation, and role-switch behavior remains runtime-unverified |

## Existing registered issues not counted as new findings

- KI-402: no standalone AngelScript compilation target.
- KI-404: missing `doc/roles/hover.md` and its existing broken links.
- KI-405: layout corridors and zones are not shared with allies.
- Other unchanged entries in `doc/known-issues.md` remain open but were not
  duplicated here unless the current change introduced a new regression.

## Recommended disposition

Do not commit the change set in its current state. Resolve the P1 findings
before further gameplay validation. Then address P2 lifecycle and policy
issues, synchronize the documentation with the final implementation, clear
the static-gate failures, build in a writable Recoil integration environment,
and load all affected experimental profiles in BAR.
