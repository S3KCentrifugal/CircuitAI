# SEA control before coastal support

Investigation: 2026-10-05. Baseline: `f2affdf2`. This is a diagnosis and
implementation plan, **not a deployed behavior fix**. Runtime C++, AngelScript,
profiles, economy and scouting policy are unchanged in this investigation.

## Result

SEA currently has an approach director, but no complete water-control mission
lifecycle. It selects the nearest compatible water contact, temporarily hands
combat back to native ATTACK, and searches water when contacts run out. There
is no explicit sequence of securing occupied seas, denying new shipyards, then
assigning available ships to support the land front.

The reported northwest Supreme Isthmus shipyard incident is **not yet reproduced**.
Two supplied-force checks establish that an undefended visible yard is attacked,
and that a short loss of vision can still end in its destruction. Several source
gaps can explain missed opportunities, but none is asserted as the proven cause
of that particular match without its target/contact history.

## Baseline and local match evidence

Before investigation, all existing work was committed at `f2affdf2` and pushed
to `origin/codex/ranged-combat-rework`; Git reported everything up to date.
Investigation work is on `codex/sea-control-investigation` so it does not enter
the existing ranged-combat pull request.

The installed `SMRTBARb/stable/SkirmishAI.dll` and development output both hash
to `15958e3e8775d55b0667557957fc3840be39cb1924f508de4d847f87b69b1434`.
Installed and repository `sea_operations.as` both hash to
`d44c36b1b4554b9c736177ace081a1dcd29700ccfca28a0892f5ff48d2615d5b`.
These comparisons establish parity for the binary and director inspected;
they are not a historical hash manifest for every earlier match or profile.

The current live infolog contains several games/replays. The last AI match
starts at line 41737, reaches frame 36578 (20:19.3), and lists Armada SEA team 11
and Legion SEA team 14. Team 11 logged 30 search routes and seven contact routes;
team 14 logged 58 search routes and two contact routes. These are **route-log
counts**, not idle time, attacks, kills, or time spent on each mission.
The archived `20261005190330_infolog.txt` is another Supreme match, reaching
frame 49933, with Armada SEA teams 12 and 14. Both show the D-202 patrol owner.

The logs lack candidate rejection reasons, known-yard lifecycles and the
identity/position of the reported hostile yard. They cannot establish whether
it was unfinished, subsequently hidden, in a rejected coast cell, or superseded
by another target. No private live-match log is copied into the benchmark store.

## Confirmed source gaps, in priority order

1. **No strategic shipyard/navy priority or persistent mission.**
   [SeaOperations::Tick](../data/script/src/manager/sea_operations.as) selects
   `dist < nearest`, after water-body and weapon-layer filters. Factories do not
   outrank nearby low-value naval structures. Every same-definition cohort has
   one centroid and goal for its entire connected water body. On reaching weapon
   range, it transfers to generic ATTACK without passing the chosen target ID.
   [CAttackTask::FindTarget](../src/circuit/task/fighter/AttackTask.cpp) then runs
   its own group, reachability, category, ignore and distance selection. Thus
   approaching a particular yard does not create a contract to finish destroying
   it. The handoff is deliberately retained from D-201 for formations and repair;
   do not replace it with global attack spam. Tracked as KI-513.

2. **The director cannot proactively select unfinished yards, and loses
   hidden yards from its candidate list.**
   [GetNavalForceCount](../src/circuit/terrain/BattleAnalysis.cpp) includes
   completed enemy naval factories, despite an outdated comment saying friendly
   anchors only. It excludes `IsBeingBuilt()` and requires current radar/LOS.
   `GetSeaForceCount` adds unknown submerged contacts and completed non-builder
   structures, not unfinished factories or remembered hidden yards. An existing
   route can survive contact loss until arrival or the 45-second search interval;
   after that, the director may choose a generic search. Native combat and engine
   auto-fire can still attack independently: this is not a claim that all attacks
   on unfinished/hidden buildings are impossible. Tracked as KI-512.

3. **No ordinary-fleet transition to coastal FRONT support.**
   The fleet director only scores its water snapshot. With no target it calls
   `Search`, which uses enemy-start hypotheses and water rings, not friendly
   FRONT positions, ground contacts, weapon reach or a coastal fire-support
   objective. Its route can therefore keep an available destroyer fleet searching
   water instead of assigning a useful shore firing position. Native ATTACK can
   independently choose a shore target; designated artillery hulls deliberately
   retain native artillery. This gap concerns explicit allocation and reliable
   follow-through, not an absolute inability to shoot land. Tracked as KI-514.

4. **A failed route does not actually select the next target.**
   The failure branch says “select another water objective,” advances `search`
   and waits ten seconds. But a known target is selected again by the same nearest
   distance rule; `search` only affects the no-target branch. An unchanged,
   unrouteable closest contact can repeatedly block a reachable second target.
   This is established control flow, not a reproduced cause in the reported
   match. Tracked as KI-515.

Additional geometry to verify: water affiliation uses 64-elmo cells and rejects
a cell if any sampled point is shallower than eight elmos. A target's center
cell is not equivalent to a reachable firing position near its footprint.
Likewise, the straight range-offset point can be on land even if a naval target
is reachable from another bearing. Do not loosen water/path checks globally;
test these coast cases with actual ship movement and weapon geometry.

## Played investigation cases

Both gameplay cases use Supreme Isthmus v1.7, BAR `test-31479-433a460`, Recoil
`recoil_2026.07.04`, experimental_balanced, seed 1891 and the unchanged baseline
DLL/data. They supply eight Armada destroyers, a forward radar and one Cortex
yard. Constructors and factory production are frozen by the established arena
harness. Adaptive SEA combat stays enabled with legacy layout selected.
The `-cand` storage suffix is the runner's label; it does not mean gameplay code
was changed. The two cases use different yard positions and are not a timing
performance comparison.

| Case | Observation | Evidence |
| --- | --- | --- |
| Continuous vision | Yard identified at frame 330 (11 s), damaged at 953 (31.8 s), destroyed at 1187 (39.6 s). PASS. | [Original result](benchmarks/records/sea/combat/control-yard-seen-cand/2026-10-05/20261005T225123Z-7f45ffe7/README.md) |
| Radar removed at 15 s | Yard absent from LOS/radar at 20, 25, 30 and 35 s. Director logs search at 38 s. Fleet reacquires at 40 s, damages at 41.5 s and destroys at 46.2 s. PASS. | [Complete observation](benchmarks/records/sea/combat/control-yard-lost-cand/2026-10-05/20261005T225638Z-42f7b8ed/README.md) |

The short-fog result limits the diagnosis: forgetting the target in the current
contact list does not necessarily abandon the approach or prevent a kill. A
distant/long-hidden target, assembly before first routing, alternate distractors
and a cliff-constrained approach still need dedicated fixtures.

The observer's optional `remove_units` events remove only explicitly named
supplied assets. `objective_observer` records spectator ground truth and the
tested ally team's legal visibility; none of this data is supplied to AI policy.
Friendly warship commands remain exclusively AI-owned. Existing cases that omit
these options retain their observer behavior.

Retained setup/tool failures are separate from gameplay outcomes:

- [Initial visible-yard setup FAIL](benchmarks/records/sea/combat/control-yard-seen-cand/2026-10-05/20261005T224851Z-d64204f7/README.md): several proposed fleet coordinates were dry; corrected before the passing case.
- [Engine startup FAIL](benchmarks/records/sea/combat/control-yard-lost-cand/2026-10-05/20261005T225214Z-b756e48d/README.md): insufficient disk space. Lossless NTFS compression of generated debug files recovered space.
- [Incomplete watcher FAIL](benchmarks/records/sea/combat/control-yard-lost-cand/2026-10-05/20261005T225429Z-dd34499a/README.md): restricted process inspection reported exit at frame 600 while the engine continued. An elevated watcher archived the complete same game separately; this is not a second independent gameplay run.

An earlier overlength storage label failed before allocating/launching a game;
the case's internal name was shortened. No failed verdict was rewritten.

## Proposed SEA mission policy

The requested priority is consistent with using naval control to enable coastal
pressure. BAR's [naval guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare)
describes destroyer standoff against naval defenses, battleship shore bombardment
and the anti-sub/AA protection needed by capital ships. Those mechanics support
the following design; the ranking and reserve calculation are AI design proposals,
not claims of universally optimal PvP coefficients.

1. **Defend and contest occupied water.** Handle immediate harbor/fleet attacks
   with weapons that can actually engage their target layer. Keep the existing
   scout/AA patrol owner, carrier ownership and repair retreats.
2. **Deny enemy production and secure the sea.** Explicitly track enemy shipyards,
   including unfinished frames, and enemy fleets in each occupied water body.
   Rank exposed expansion yards ahead of expendable economy distractors; clear
   a defending fleet/torpedo screen when necessary to reach a yard. Do not force
   surface-only boats through unsupported submarines just to satisfy a priority.
3. **Verify and hold cleared water.** Remember the last legally observed location
   of a static yard. Losing vision marks it unconfirmed rather than destroyed.
   Send a verifier or committed fleet; clear it on destruction or a fresh view
   of an empty site. Expire/retry unreachable missions explicitly so one stale
   contact cannot freeze all useful ships. Continue independent scouting.
4. **Assign genuinely available ships to the coastal front.** Use known ground
   contacts and friendly FRONT/shore objectives. Retain local anti-sub, AA and
   harbor reserves, with allied committed cover counted once. Select reachable
   water firing positions from actual surface weapon range/trajectory and terrain.
   Withdraw the support allocation when renewed naval pressure needs it.

Use separate surface and underwater capability budgets. Metal-cost ratios are
a deterministic first estimate, not a guarantee of equal fighting strength.
Expose reserve ratios, commitment/retry intervals and mission preferences under
`RoleSettings::Sea`; calibrate them with cases before selecting defaults. Do not
wait for omniscient proof that every enemy in an ocean is dead before using spare
ships, and do not send the whole fleet to land merely because contacts disappear.

## Required implementation, in order

1. **Read-only SEA objective data.** Extend SEA's own native view with observed
   factory frames, explicit structure/factory classification and legal last-known
   static sites. Keep AIR's `GetNavalForceCount` semantics unchanged. Native data
   reports visibility, last-seen frame, lifecycle and geometry; it does not choose
   mission priorities. Files: `BattleAnalysis.cpp/.h`, relevant enemy event/state
   access only if needed, `InitScript.cpp`, and the script API reference.
2. **Mission selection and assignment in script.** Add a small `SeaObjectives`
   policy module used by `SeaOperations`. Classify once per snapshot, index by
   water body, rank deterministically, account for already committed cohorts,
   and distinguish contest/deny/verify/support. Preserve stable unit-ID ownership.
   Put pure ranking, reserve and transition arithmetic in `sea_math.as`, tested
   by the actual embedded VM. Settings stay in `global.as`.
3. **Maintain combat intent through handoff.** Add an explicit, opt-in objective
   to native contact combat or a SEA route firing mechanism, rather than issuing
   another unrelated generic ATTACK. Audit legal visibility, weapon/category,
   range and target-destruction transitions. `CRouteTask::SetSeaTarget` currently
   accepts aircraft only for AA: do not silently broaden it and break D-202.
   Shared native defaults remain unchanged when no SEA objective is assigned.
4. **Firing-position search and alternate targets.** Test a bounded set of
   navigable positions around the target's firing envelope with the actual hull
   movement/weapon constraints. A failed target/body/MoveDef attempt gets a
   temporary failure entry; select the next candidate. Invalidate the failure
   when geometry/contact changes or the retry interval expires.
5. **Coastal support from surplus.** Use existing legal ground-contact and
   lane/strategic-site data to find useful shore fire positions. Add subcohort
   assignment where needed; current definition-plus-water grouping cannot send
   half a destroyer type to help FRONT while retaining the rest. Utility ships
   follow their assigned screen; scouts and AA retain their current separate
   owners. Verify that siege hulls still fire effectively under their retained
   native policy before opting them into a new movement owner.
6. **Observability and invariants.** Log mission transitions and bounded rejection
   reasons: hidden/unconfirmed, layer mismatch, wrong sea, unsafe screen, no firing
   position, already covered and retry pending. Proposed promises: contact loss
   is not destruction; committed objectives survive task handoff; unreachable
   targets do not starve reachable ones; only surplus is assigned to shore duty.
   Update the invariant/actor registers, SEA reference, decisions and test index
   with the eventual implementation and actually played verification.

No production, economy, shared role classification or sample-tree edit is needed
to address the objective-selection gaps. Extra production changes would require
separate evidence that composition, rather than assignment, blocked the mission.

## Acceptance matrix for the implementation

| Scenario | Required observation |
| --- | --- |
| Visible northwest yard | Existing case remains PASS; approach, damage and kill measured. |
| Brief fog loss | Existing case remains PASS; no invented hidden positions or destruction. |
| Distant yard beyond current route lifetime | Mission persists/reverifies until killed or explicitly invalidated; no indefinite search-only diversion. |
| Yard seen before fleet assembly | A later ready cohort receives the known static-site mission. |
| Unfinished yard | Eligible ships attack the frame before completion where safely reachable. |
| Yard versus nearby converters | Safe production denial wins over irrelevant low-value structures; defensive blockers may be cleared first. |
| Coastal cliff / blocked closest goal | Find a reachable firing point or move to the next valid objective; bound retries and order churn. |
| Secured sea plus active center front | A funded combat-capable surplus moves to coastal range and deals actual damage; patrol and harbor cover remain. |
| New invasion during shore support | Appropriate ships switch back promptly; surface-only hulls preserve sub screening. |
| Two disconnected seas and allied SEA | No unreachable cross-sea assignment or double credit for the same committed cover. |
| Faction/profile regression | Armada/Cortex/Legion; all three experimental profiles; Herring patrol/air interception, missile ships, flagships, carriers and repair ownership. |
| Full Supreme / Glacial / Shore games | Enemy-yard lifetime, fleet idle time, shore damage, harbor survival and economy remain visible over full games. |
| Serial performance comparison | Same content, seed, population and phase; objective CPU, path requests, allocations and non-Lua commands. No FPS claim from these small fixtures. |

## Performance constraints

Keep one shared census per policy interval, O(U + E + G*E) straightforward
selection before indexing, where U is owned units, E known contacts and G cohorts.
Bucket contacts by body and cache immutable UnitDef classifications; do not add
per-ship full-map enemy scans or repeated helper-array construction. Path searches
run on mission/geometry transitions or bounded retries, not every census.

Preserve a live unchanged command queue while continuing threat observation.
Objective ownership and version changes must invalidate any command reuse. One
fleet route still creates per-unit engine commands; it is not one multiplayer
packet. Keep callbacks on the AI owner thread. Workers, if ever justified by a
profile, receive immutable snapshots only. These are design constraints, not
measured optimization gains from this investigation.

## Reproduce the existing cases

Run `tools/playtest/sea_arena.py` with `--case sea-control-visible-yard-supreme`
or `--case sea-control-lost-yard-supreme`, the matched `--dll`,
`--profile experimental_balanced --legacy-layout --minutes 4 --speed 4`.
Each game allocates a unique categorized directory. Use the same elevated
process permissions for launch and watch on this host; retain original reports
when a watcher must be reattached. Current source tests and proposed tests are
indexed separately from executed evidence in the [SEA test index](testing/index/sea.md).

Validation: the actual engine loaded both scenarios; the API checker reports
303 members and zero findings; the invariant checker reports zero findings;
all four existing SEA combat-analyzer tests pass. The generated test/evidence
indices include the new definitions and five observations. The documentation
link checker reports only the eight pre-existing missing `roles/hover.md` links
(KI-404). No new gameplay binary was built, no performance gain is claimed,
and the user's existing live BAR process was left running.
