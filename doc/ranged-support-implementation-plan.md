# Ranged support implementation plan

2026-10-05. Historical design baseline: `f65f10db`.
**Implementation follow-up:** D-207 implements the refined opt-in design on
`codex/ranged-combat-rework`. See the [current implementation](ranged-combat.md)
and [played results, regressions and performance costs](benchmarks/ranged-combat.md).
The sketches below remain the design history; the current reference identifies
the actual API names and which verification remains outstanding.
This breaks down the [siege review](reviews/2026-10-05-siege-classification-request.md)
and [D-204](decisions.md#d-204---safe-range-outranks-heavy-target-preference-for-ranged-support)
into code changes. It addresses KI-503 and KI-504 in the
[issue register](known-issues.md). All new API names and configuration keys below
are design sketches, not existing callable interfaces. Numbers are initial test
values, not benchmarked tuning.

D-206 refines this plan after the [complete balanced-profile inventory](reviews/2026-10-05-balanced-siege-attributes.md):
use one new `ranged` attribute as the enable switch, four target presets,
capability-aware withdrawal, and explicit sensor/mission-owner integration.
That review contains the exact proposed lists and per-unit disposition. The
older independent `ranged.enabled` switch and precedence over specialist
missions are superseded, not additional controls to implement.

The required outcome is useful fire from safe positions, followed by deliberate
advancement. A preferred heavy target must never authorize pursuit into known
static coverage. This intentionally changes combat behavior for the ten opted-in
land UnitDefs wherever a role owns them. It does not change production weights,
economy, aircraft control, naval combat or existing non-opted-in artillery.

## Required changes, in implementation order

1. **JSON and C++: separate range control from unit classification.**

   Add an optional per-unit `ranged` policy in the active
   [configuration tree](../data/config/). Parse it in
   [FactoryManager::ReadConfig](../src/circuit/module/FactoryManager.cpp),
   store the validated values on [CircuitDef](../src/circuit/unit/CircuitDef.h),
   and keep absence of the new attribute equivalent to today's behavior. Suggested policy
   value type: new `src/circuit/unit/RangedPolicy.h`.

   Preserve each profile's existing roles and attribute entries, then append
   `ranged` for opted-in definitions. They also
   affect counter accounting and factory eligibility, so they are not merely
   movement labels. The intended final implementation does not need to turn
   Sharpshooter into structure-only artillery to prevent pursuit.

   Append `RANGED` to the native enum, mask and name table in
   [CircuitDef.cpp](../src/circuit/unit/CircuitDef.cpp), preserving existing
   bit values. Expose the matching `Unit::Attr::RANGED` in
   [unit.as](../data/script/src/unit.as). There is no second enable boolean.

   Example proposed Sharpshooter fields, with unrelated fields left intact:

   ```json
   "attribute": ["ranged", "ret_hold"],
   "ranged": {
     "target_mode": "precision",
     "allow_mobile": true,
     "allow_static": true,
     "prefer_heavy": true,
     "range_fraction": 0.95,
     "range_hysteresis": 32,
     "safety_margin": 64,
     "avoid_static_coverage": true,
     "cloak_on_reload": true,
     "spacing": 96,
     "screen": "prefer",
     "withdraw": "capability",
     "preserve_volley": true
   }
   ```

   `range_fraction` applies to effective range of a weapon that can actually
   damage the selected target. It is not a fraction of LOS. The hysteresis and
   margin are elmos. Validate finite values, modes and bounds; reject invalid
   enabled policies with an actionable diagnostic. Target value thresholds,
   target-switch hysteresis, observed repair-progress window, formation spacing
   and optional area bombardment also need JSON controls. Keep their defaults
   and units documented together; do not bury unit-name exceptions in C++.

2. **C++: reuse the artillery task's lifecycle with an explicit protected-range path.**

   Extend [ArtilleryTask.h](../src/circuit/task/fighter/ArtilleryTask.h) and
   [ArtilleryTask.cpp](../src/circuit/task/fighter/ArtilleryTask.cpp) to own an
   optional new `RangedEngagement` component under `src/circuit/task/fighter/`.
   Keep the existing task kind, registration and ordinary artillery path.
   `CanAssignTo` must admit enabled ranged definitions even when their main role
   remains anti-heavy/skirmish/assault. Initialize the new component before the
   legacy siege RETURN-fire/FIGHT-travel branch can run.

   ```cpp
   // Proposed branch; the component and accessor must be implemented first.
   void CArtilleryTask::Execute(CCircuitUnit* unit) {
       if (unit->GetCircuitDef()->IsAttrRanged()) {
           ranged->Update(unit); // Sole owner of protected movement and firing.
           return;
       }
       ExecuteLegacy(unit);      // Existing artillery behavior, extracted intact.
   }
   ```

   Apply the same separation to assignment, removal, idle, damage, target death
   and path callbacks. Holding a firing position with an empty MOVE queue must
   not trigger the existing `OnUnitIdle` removal/reassignment loop. Damage still
   permits the existing retreat handover. Shared threat/slot services below
   prevent one task per unit from implying one full-map scan per unit.

   This bypasses the affected units' unsafe anti-heavy approach and squad
   self-spotting paths. Do not globally change `RANGE_MOD`, AntiHeavyTask,
   SquadTask or naval siege semantics as part of this implementation.

3. **C++ binding and AngelScript: give the policy reliable task ownership.**

   Add `TryMakeRangedTask(CCircuitUnit*)` to
   [MilitaryManager.h](../src/circuit/module/MilitaryManager.h) and
   [MilitaryManager.cpp](../src/circuit/module/MilitaryManager.cpp). It returns
   null for ineligible/disabled definitions; otherwise it creates the configured
   artillery task. Native `DefaultMakeTask` calls it after transport protection,
   before scout/support/main-role routing. This covers legacy profiles too.

   Bind it in [MilitaryScript.cpp](../src/circuit/script/MilitaryScript.cpp)
   using the existing task-return ownership convention. In experimental
   [military.as](../data/script/src/manager/military.as), insert the following
   **after ferry, super-static and specialist-owner guards, before generic
   combat dispatch**, reusing the existing `t` variable in the remainder:

   ```cpp
   // AngelScript; proposed native binding.
   // Existing specialist mission admission precedes this ordinary combat path.
   IUnitTask@ t = aiMilitaryMgr.TryMakeRangedTask(u);
   if (t !is null) return t;
   // Existing generic role dispatch follows for all other definitions.
   ```

   The native method must not steal a unit from player/external control,
   transport handling or retreat. Handle fresh assignment through the existing
   manager lifecycle, rather than adding a polling loop that reassigns units.
   This ordering deliberately lets already-built/donated ranged units fight
   safely even where TECH's generic military gate would otherwise return null
   below its income threshold. Production is unaffected.

   The default amphibious and flank rosters do not include these ten units;
   spam admission is attribute-driven. Other existing siege units do overlap:
   Recluse/Arquebus are TECH flank candidates. Preserve a specialist mission's
   objective and route, and integrate the ranged component through an adapter
   before enabling such overlaps. Report unsupported combinations once and
   refuse conflicting admission; never silently steal mission ownership. Update
   [angelscript-references.md](angelscript-references.md) for the new binding.
   No per-frame targeting loop or unit list is required in `air.as`, `sea.as`,
   `tech.as`, `front.as`, `support.as` or `tactical.as`.

4. **C++: select a firing position and approach that preserve range.**

   Add reusable, testable geometry under a proposed
   `src/circuit/terrain/RangedGeometry.h`. Extend
   [BattleAnalysis](../src/circuit/terrain/BattleAnalysis.h) with opt-in shared
   observations of known ground weapon coverage. Reuse enemy/spatial snapshots
   and terrain/path infrastructure; do not derive safety solely from the
   profile-weighted threat value, which may be zero for a dangerous weapon.

   Validate target category, relevant weapon, height-adjusted reach, unit radius,
   terrain and firing arc. Prefer a stable point near maximum usable range.
   Never use `min(weaponRange, losRange)` as a firing-distance rule. A known
   target can be supported by allied vision/radar; the shooter is not the scout.

   ```cpp
   // Proposed pure decision step, with observation/command code outside it.
   const float desired = EffectiveRange(weapon, from, target) * policy.rangeFraction;
   for (const auto& site : CandidateFiringSites(target, desired)) {
       if (!CanReachAndFire(site, target, weapon)) continue;
       if (!OutsideKnownStaticCoverage(site, policy.safetyMargin)) continue;
       if (!SafeApproach(from, site, coverageSnapshot)) continue;
       ConsiderStableSlot(site);
   }
   ```

   Check the entire approach, not only the destination. Pass a forbidden-coverage
   mask to an opt-in path query, or validate the returned corridor and reject it;
   a soft path cost alone does not enforce the rule. Extend the existing
   [path-query infrastructure](../src/circuit/terrain/path/) without changing
   default queries. Revalidate before issuing/continuing movement when known
   coverage changes. If spawned inside danger, allow a validated escape that
   decreases exposure instead of trapping the unit behind a strict admission
   rule. Unknown threats cannot be guaranteed absent.

   Existing `BattleAnalysis::LineOfFire` samples a straight line over terrain;
   it is not an exact engine trajectory test for arcing artillery or blockers.
   Use weapon-aware conservative geometry and verify real shots in the engine.
   Count repeated aim/no-fire failures and try another safe site; never solve
   them by walking into the target. Do not change the existing helper's semantics
   globally to serve this new controller.

5. **C++ with JSON priorities: select useful in-range targets without pursuit.**

   Put selection in the new `RangedEngagement` component with an independently
   testable decision helper. Legal observation, compatible weapon, current
   firing reach, safe position and friendly-splash clearance are eligibility
   gates. Rank eligible candidates by configurable useful damage/progress and
   specialization. A large target-value bonus cannot cancel a safety rejection.

   ```cpp
   // Proposed selection skeleton. Heavy preference is applied after eligibility.
   for (const Contact& target : nearbyContacts) {
       if (!CanFireSafelyFromCurrentSlot(unit, target, snapshot)) continue;
       const float value = UsefulDamageScore(unit, target, observedHealthHistory);
       Consider(target, value, policy.preferHeavy && target.isHeavy);
   }
   ```

   Permit mobile targets and statics for the opted-in units; do not inherit
   ArtilleryTask's blanket mobile exclusion. Expensive precision shots need a
   configurable useful-damage threshold and a fallback, not a permanent
   HEAVY-only filter. Track visible health changes to identify negligible net
   progress against repair-supported bait; do not assume knowledge of invisible
   repairers or exact enemy repair income. Switch when an accessible defense or
   other target is more productive, with hysteresis to avoid retargeting every
   tick. Reserve planned salvos locally to reduce redundant sniper overkill;
   expire reservations on death, target loss, canceled fire and reload changes.

6. **C++: issue firing orders that do not acquire movement ownership.**

   Prefer BAR's priority-target command with HOLD_POS and a separately planned
   MOVE path. The existing opt-in implementation in
   [RouteTask.cpp](../src/circuit/task/fighter/RouteTask.cpp) demonstrates the
   command transport through [CustomCommand](../src/circuit/spring/CustomCommand.h).
   Extract/reuse that transport in the new component; leave SEA's policy intact.
   Do not globally enable `CircuitUnit::CmdSetTarget`, or send ordinary ATTACK
   followed by FIGHT at the enemy's location.

   ```cpp
   // Proposed controller code using the existing synchronous command bridge.
   if (newTargetId != ownedTargetId) {
       CancelOwnedTargetIfStillOwned(); // ID-specific; preserve player replacement.
       if (newTargetId >= 0) {
           float params[] = {float(newTargetId)};
           SendCustomCommand(aiId, unitId, CMD_UNIT_SET_TARGET, params);
       }
       ownedTargetId = newTargetId;
   }
   // The validated firing-slot MOVE queue is managed independently.
   ```

   Clear the owned target when it leaves usable range, becomes illegal/dies,
   or the task releases ownership. Preserve a stable aim/beam/volley while it
   remains valid. Confirm command support for every pinned UnitDef/game version
   and test selected-target firing under its configured fire state. Unsupported
   commands must be a reported rollout blocker for that definition, not silent
   fallback to pursuit. Save/restore only states this task owns; never overwrite
   a player's replacement order or fire-state change during handover.

7. **C++ with JSON controls: manage spacing, reload and safe advancement.**

   Use a shared local slot registry for nearby protected units, with stable
   per-unit lateral positions and their individual weapon ranges. Keep the
   screen-facing orientation, minimum separation and friendly splash clearance;
   do not collapse mixed-range units onto one target point. Avoid an all-pairs
   unit-distance pass by querying local spatial cells.

   Read mounted weapon arcs, turn/acceleration, real damage barrels, beam/burst
   timing, cloak and death-blast geometry from the loaded game. Cache capability
   metadata; expose explicit overrides for restrictions hidden in unit scripts.
   Sharpshooter can aim independently while moving away, whereas Starlight
   cannot fire at a pursuer outside its forward arc. Do not assume reverse
   driving when loaded reverse speed is zero. Predict closure versus turn plus
   acceleration plus escape time, and use hysteresis for committed withdrawal.

   Tactical withdrawal remains in this component and may fire without canceling
   MOVE. Emergency escape uses existing retreat/repair ownership. In
   [RetreatTask.cpp](../src/circuit/task/RetreatTask.cpp), honor `ret_hold` for
   opted-in cloaked units instead of overwriting HOLD with RETURN. Never add
   `ret_fight` as a substitute for moving while firing: FIGHT may stop to engage.
   The balanced Starlight's `retreat:0` also needs a meaningful health fallback;
   0.65 is a test candidate, while predictive withdrawal can act earlier.

   Extend [SupportTask](../src/circuit/task/fighter/SupportTask.cpp) and
   MilitaryManager with ranged-cohort escort anchors. Current support selection
   searches ATTACK/DEFEND and casts to `ISquadTask`; individual artillery tasks
   are not squads. Do not add ARTY to that cast path. Keep sensor task ownership,
   coverage-aware quotas, and safe offset positions; publish value anchors with
   ID/generation cleanup on membership, death, transfer and release. Repair
   support stays behind exits. Preserve commander task ownership rather than
   drawing it forward to spot for shooters.

   The controller needs distinct approach, fire, reload/hold, reposition and
   await-safe-route states. During reload it holds when safe and withdraws only
   for a concrete threat or an improved validated position. Completing a beam
   or burst outranks a cosmetic formation adjustment. Safety/retreat can still
   interrupt it. Idle/no-target is not permission to drop the task.

   After a covering defense dies, invalidate its coverage and evaluate the
   next safe firing band. If no safe attack exists, retain useful defensive
   coverage, request/reuse reconnaissance and consider another reachable
   objective. Log the blocking reason. Do not introduce an arbitrary timer
   that eventually authorizes an unsafe charge. Nor may indefinite idle
   survival count as success when a useful safe firing solution exists.

8. **JSON: enable appropriate modes for all ten units, preserving profile bytes.**

   Pilot the exact proposed lists in experimental_balanced first. The subsequent
   explicit profile migration would cover the 77 existing unit objects across the 15 active
   behavior files inventoried in the [review](reviews/2026-10-05-siege-classification-request.md#exact-current-configuration-inventory).
   These comprise root `behaviour.json` and the base/Legion files in all seven
   difficulty folders. There is no root `behaviour_leg.json`.

   | UnitDef | Proposed mode | Important difference |
   | --- | --- | --- |
   | `armfboy` | skirmish | Anti-swarm support; avoid friendly splash; preserve HEAVY counter category. |
   | `armfido` | skirmish | Proactive mobile fire, spacing and safe repositioning. |
   | `armsnipe` | precision | Useful heavy/commander shots preferred within safety; cloak, reload, energy and overkill checks. |
   | `armmanni` | precision | Useful heavy/static shots; stable beam, facing and spacing; safety before close-range damage. |
   | `cormort` | skirmish | Restore proactive mobile fire while preventing pursuit into static coverage. |
   | `corban` | skirmish | First-strike/reload safety, preserve legal opportunistic AA, shorten escape turns. |
   | `cortrem` | bombardment | Mobile concentrations or statics; safe area fire, friendly splash; retain HEAVY category. |
   | `legamcluster` | bombardment | Cluster-weapon targeting and splash safety. |
   | `legmed` | bombardment | Safe static/mobile fire without continually resetting salvos. |
   | `legvcarry` | carrier | Safe carrier position, genuine drone engagement and gadget-controlled drones. |

   These are four target-policy presets, not additional attribute bits.
   Carrier mode is a required adapter/fixture, not a renamed direct-fire mode.
   Mantis has a zero-damage targeting weapon: never reject all targets for zero
   fake-weapon DPS, or treat its target-designation range as guaranteed safety.
   Pass validated targets through the carrier's own command/weapon-target
   interface; let the BAR gadget continue launch, attack, recall, docking,
   repair and stockpile control. Verify parent fire-state propagation. Do not
   independently micro its drones.

   Patch raw byte spans to preserve comments, CRLF/LF and all unrelated fields.
   Assert byte identity outside approved insertions. Do not edit deployed
   `stable/config`, samples, build chains or response weights. The bot/vehicle
   production lists remain unchanged: combat positioning does not require a
   production rebalance. Root fallback is whole-file, so editing only root
   would leave profile overrides unaffected.

9. **C++: bound calculation and command cost without a global rate limit.**

   Build/reuse one legal-contact and known-coverage snapshot per AI observation
   revision. Cache weapon capability metadata per UnitDef. Spatially query
   candidates near firing slots; evaluate a small deterministic set of positions
   rather than every map cell per unit. Reuse buffers and deterministic ties.
   Keep expensive terrain/trajectory checks behind cheap category/range gates.

   Cost should be described honestly: snapshot construction is O(E) in observed
   contacts; coverage-index updates also depend on covered cells. A local query
   costs visited cells plus returned contacts, not universally O(1). Unit work
   then depends on local candidates and firing sites, with separate pathfinding
   cost. Avoid O(U*E) repeated full-map scans and O(U^2) formation comparisons.

   Suppress only unchanged, still-live commands for the same owner/intent.
   Invalidate on target, queue, destination, membership, danger and owner changes.
   Do not slow threat observation or impose an APM cap. Use existing path workers
   with immutable snapshots; callbacks and AngelScript remain on the owner
   thread. Reacquire IDs and validate task/generation/coverage before applying
   asynchronous results. Comment these contracts beside the caches and queues.

10. **Tests and simulations: compare physical behavior, not task labels.**

    Add dependency-free `tests/ranged_engagement_test.cpp` and geometry tests
    under [tests](../tests/), registered in [tests/CMakeLists.txt](../tests/CMakeLists.txt).
    Cover safety-before-score, target loss, hard coverage along paths, escape
    from danger, mixed range, deterministic ties, repair progress, overkill
    reservation expiry, fire-state ownership and stale path rejection. Add
    exact command-bridge/ownership tests where mocks can exercise real adapters.

    Create categorized fixtures under `tools/playtest/cases/shared/combat/`
    following the [case storage rules](../tools/playtest/cases/README.md), with
    checks under [shared combat checks](../tools/playtest/checks/shared/combat/). Existing
    `artillery_fire`/`artillery_profiles` checks concern static artillery and do
    not already prove these mobile-unit behaviors.

    | Case | Required acceptance |
    | --- | --- |
    | `ranged-static-bait` | Retreating Fatboy cannot pull shooters through known static coverage; shooters damage accessible defenses. |
    | `ranged-mobile-only` | Units proactively damage compatible mobile targets without needing an enemy building or being hit first. |
    | `ranged-target-lost` | No stale pursuit; reacquire or change useful objective, no task churn on idle. |
    | `ranged-terrain` | Slopes/cliffs/blocked line of fire produce real shots or safe relocation, never an unsafe closing fallback. |
    | `ranged-volley-reload` | Sharpshooter cloak/reload works; Starlight beam and other bursts complete; raiders provoke a timely response. |
    | `ranged-carrier` | Mantis launches and retargets drones, then recalls/docks; carrier remains safely positioned. |
    | `ranged-advance` | Clearing the defensive line leads to useful forward progress and attacks on the next objective. |
    | `ranged-owner-regression` | Player, retreat, donation, save/load and LEGACY/non-opted SEA artillery behavior remain correct. |

    Stage three variants: A unchanged baseline; B exact artillery/siege-only
    configuration; C this explicit controller. Never mutate the source profiles
    to switch benchmark variants. Pin AI/game/engine/configs and seeds, preserve
    all outcomes, and compare identical forces/economy/observation rules.
    Start with flat controlled bait tests; repeat on Supreme Istmus, Glacial Gap
    and an uneven land map, then full games with realistic mixed armies.

    Record actual shot distances, unsafe travel/exposure, metal lost, enemy
    damage/metal destroyed, defense-line progress, idle time, beam/volley
    completion, target switches, task churn, CPU and orders per game minute.
    Capture screenshots during combat. Require zero deliberate crossing of
    known forbidden coverage in the controlled approach test, successful useful
    firing in the mobile/static tests, and advancement after coverage removal.
    Measure improvement and performance; do not assert a speedup, win-rate gain
    or exact metal-trade benefit before matched results exist.

11. **Documentation, invariants and rollout: keep the change reviewable.**

    Record the new policy/schema/binding, owner state machine and cache
    invalidation. Add proposed range/command-ownership invariants to
    [invariants.md](invariants.md) and actor entries to
    [actor-matrix.md](actor-matrix.md) when the implementation exists, with runtime
    checks and corresponding forbidden log markers in the case checks. Update
    role references that describe affected units and regenerate
    [barb-unit-config.md](knowledge/barb-unit-config.md) after profile changes.
    Leave KI-503 through KI-507 open until their physical verification is attached.

    Run native tests, configuration validation, script API checks, all affected
    profile loads and the combat matrix. Build/package DLL and data together
    before simulations. Publish immutable results through the existing
    [test-storage structure](test-storage.md). Roll out precision units first,
    then skirmish/bombardment and carrier modes once their fixtures pass;
    completing the request still requires all ten definitions. Per-definition
    removal of `ranged` from its attributes is the rollback lever. The original artillery/siege-only
    variant remains a measured comparison, not an untested declared loser.

## Sharpshooter and Starlight impact

| Situation | Sharpshooter (`armsnipe`) | Starlight (`armmanni`) |
| --- | --- | --- |
| Heavy in safe firing reach | Prefer a valuable shot, avoiding redundant committed damage. | Prefer useful heavy damage while maintaining beam/facing and spacing. |
| Heavy retreats behind repaired turrets | Clear target; shoot a worthwhile reachable defense/other unit or reposition safely. No chase. | Same safety rule; no close-range damage bonus can override it. |
| Only mobile enemies remain | Continue useful proactive fire. | Continue useful proactive fire. |
| No allied vision/radar contact | Do not walk into LOS solely to self-spot a vanished target; reacquire through normal scouting/observations. | Same, with safe objective movement where a route exists. |
| Reload/firing | Preserve cloak policy, shot-energy feasibility and reload state. Move for safety, not every reload by default. | Avoid turn/move/target churn that truncates a beam; finish fire unless safety requires withdrawal. |
| Mixed formation | Use its own range and stable lateral slot behind available screening. | Spread out behind screening; avoid bunching and unnecessary blast-chain exposure. |
| Enemy defense destroyed | Advance to the next reachable safe firing band. | Same; exploit safe opportunities without charging surviving coverage. |

The [official Sharpshooter guide](https://www.beyondallreason.info/unit/armsnipe)
describes 900 range, a 2,500-damage shot, 10-second reload and cloak/vision support.
The [official Starlight guide](https://www.beyondallreason.info/unit/armmanni)
describes 950 range, beam damage falloff and protected, spread-out use. Thus
keeping Starlights farther away can reduce damage per shot; the intended payoff
is less exposure and more surviving firing time. That payoff needs measurement.
Use loaded game capabilities, not these website numbers, in calculations.

At flat nominal ranges a provisional 0.95 firing fraction is about 855/902.5
elmos respectively, compared with squad formation's current 0.8 factor where
that path is used. These are illustrative distances, not guaranteed shot
positions or a global change to RANGE_MOD. Height, firing arcs, unit radii,
target motion and line of fire affect the real solution.

The exact two-list configuration alternative would instead route both units
to today's structure-selecting artillery task and apply siege return-fire
behavior. It can reduce heavy-target pursuit but also removes proactive native
mobile target selection; explicit orders and retaliation can still fire at
mobiles. The proposed controller preserves those useful shots without allowing
them to dictate an unsafe movement route.

## Verification of this plan

Checked against source task dispatch, artillery/anti-heavy/squad paths,
configuration loading, command transport and local BAR target/carrier gadgets.
Official unit guides were revisited on 2026-10-05. This is a documentation change;
no C++, JSON or AngelScript implementation or candidate simulation is claimed.
