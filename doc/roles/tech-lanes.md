# Lanes between the teams (D-127)

Script: [`manager/lanes.as`](../../data/script/src/manager/lanes.as) (namespace
`Lanes`). Native analysis: [`BattleLanes.cpp`](../../src/circuit/terrain/BattleLanes.cpp)
(`aiBattle.AnalyseLanes`). Settings: `Global::RoleSettings::Tech` "LANES",
overridden by [`data/config/lanes.json`](../../data/config/lanes.json).

## Background execution (D-144)

`lanes/background=true` uses the shared native worker pool; `false` runs the
same extracted solver synchronously for controlled comparisons. `stagger_seconds`
(default 2, clamped 0–10) offsets initial and panel-request admission by team
ID modulo 16. Routine TECH refreshes retain their existing 60/180-second policy.
Duplicate requests coalesce while waiting. Unit path jobs enter ahead of queued
background jobs; already-running work is not preempted.

The main thread snapshots this AI's threats, endpoints and policy. Jobs share
its immutable cached terrain and own all scratch data. The engine-free
[`LaneSolver`](../../src/circuit/terrain/LaneSolver.h) never calls engine wrappers,
AngelScript or the logger. Completion crosses the scheduler's synchronized queue
and weakly reacquires the owner on main. A generation gate rejects cancellation
and stale/duplicate completion. Old lanes remain usable until a complete result
is swapped in; no global mutex blocks lane readers during a search.

All experimental profiles poll completion, including non-TECH panel surveys.
Only after completion does script validate geometry, advance the flank revision,
run water/site advisories and publish widget metadata. These remaining steps
still run on main and are timed separately. Lanes are suitable for this split
because many searches consume stable terrain and relatively infrequent strategic
snapshots; a previous route remains useful during the short refresh delay.

`LANE_PERF` records snapshot, queue, solver and publication milliseconds plus
search/expansion counts and a geometry fingerprint. `LANE_POST` measures script
validation, teaching, water/sites and optional overlay serialization together.
The main-thread total is snapshot + publication + postprocess, plus solver time
in synchronous mode. It is not a whole-frame profiler or a CPU-time counter.
The pure solver is unit tested with concurrent jobs and synthetic terrain;
[benchmark evidence](../benchmarks/lane-workers/README.md) records actual games.

## The owner's request

> As part of the weapon placement and location identification system that
> reliably factors in terrain data, I need maps to be first calculated at game
> start based on both team start positions. Lanes should be drawn and marked
> with high-quality drawn symbols to identify if they are navy lanes, air lanes
> (for edging/circumventing AA), all-terrain lanes (often edge lanes), land
> lanes, etc. Research the game meta for how to identify lanes. Initially lane
> calculations should be drawn and shown for 30 seconds after the first intro
> drawing. These initial calculations should be cached and recalculated as the
> battle front is shifting. These lane calculations will get used by tech for
> planning attacks. The new weapon placement system should only be under the
> experimental settings and enabled for tech role, but may later be used by
> other roles.

## What a lane is (research)

D-135 distinguishes surface slope from height change along the path. The
`mountain_surface_weight` setting penalizes a long sideways cliff traverse even
when it stays at constant elevation. `mountain_height_weight` prefers the upper
shelf between the endpoint legs. When steep paired descents are unavailable,
the native search tries a two-ended elevated crossing before the ordinary
approach fallback. A constructor's mobility does not certify buildability:
the Glacial Gap fixture independently probes actual Legion radar and defense
placement within Proteus's construction reach. Short steep saddle crossings
are distinguished from sustained sideways cliff travel in that fixture.
These are advisory routes; no constructor orders or fortification chain is
created by this change.

- **Players' view** (knowledge base 70-strategy/72-map-control.md):
  - every passable route between the sides is a front, and each must be held;
  - chokes and ramps shape the routes;
  - air and hover ignore lanes, and are the answer to a deadlocked one.
- **Supreme Isthmus as an example:**
  - a narrow land straight between the starts;
  - two separate seas, used as naval and amphibious flanks;
  - the isthmus sides.
- **What a class can pass** (BAR `gamedata/movedefs.lua`): a movedef's
  `maxslope` in degrees against the engine's slope map (`1 - cos`, one value per
  16 elmos), and its depth limits (below).
- **The method**: diverse paths by the penalty method, each pass penalising
  the cells the last used, then paths merged into lanes when they run close
  together. This follows research on k-shortest paths with limited overlap,
  and the corridor analysis of RTS terrain (Perkins 2010; Uriarte and
  Ontañón).

## Classes, least capable first

| Class | Passes (per 64-elmo cell: half its slope pixels, and depth) | Movedefs | Symbol | Line |
| --- | --- | --- | --- | --- |
| LAND | slope ≤ 0.109 (27°), ≤ 20 deep | TANK2..HTANK4 | a tank: hull, turret, barrel | solid |
| BOT | slope ≤ 0.412 (54°), ≤ 20 deep | BOT2..HBOT7 | ground badge, BOT label | solid |
| AMPHIBIOUS | any water; land as bots | ABOT3, ATANK3, HABOT5, VBOT6, commanders | ground badge, AMPHIBIOUS label | solid |
| HOVER | any water; land ≤ 0.161 (33°) | HOVER2..HHOVER4 | ground badge, HOVER label | solid |
| ALL-TERRAIN | any slope, ≤ 20 deep | TBOT3, HTBOT6 | ground badge, ALL-TERRAIN label | solid |
| NAVAL | 8 deep or more | BOAT3..5 | an anchor | solid |
| AIR | everywhere; cost rises with enemy AA | - | a plane | dashed |

A path merges into a lane found before it when 60% of it runs within
`LaneMergeRadius` (450), and only within a domain: ground classes with ground
classes, naval with naval, air with air. D-131 also requires identical
whole-route capability masks, preserving nearby cliff/water alternatives.
A lane is classified under the least
capable class that can use it. An **all-terrain lane** is therefore one only
spiders and all-terrain bots can take (a cliff route, often at a map edge). An
**air lane** is kept apart from ground lanes. On recalculations it bends round
enemy AA.

## The calculation

- **Ends.**
  - Our end: this AI player's start (D-129). Territory affiliation still uses all allied starts.
  - Their end: the enemy's, from the start script's playing teams (a team
    counts when an AI or a non-spectator player is on it; the spectating host's
    team does not). Without start positions in the script, the map start spots
    in an enemy start box are used; without boxes, every spot not ours
    (`Spam::EnemyStartSpots`).
  - Naval ends are a point in every body of ship water within 6400 of a start,
    so each sea gets its own lane.
- **Paths.** Per class, a Dijkstra from the enemy starts. From each of our
  AI start, the path to the nearest enemy start, repeated `LaneAlternatives` (3)
  times with the used cells penalised (x4, neighbours x1.5).
- **Measures.**
  - Length.
  - The narrowest point in the middle 60% of the route, using the representative
    class's traversable cross-section (including naval), and its centre. Rays
    perpendicular to the smoothed path measure both sides: hugging one shoreline
    must not make a wide approach appear narrow. It is a coarse
    corridor estimate, not an engine footprint or formation-width guarantee.
  - Mean threat along it: enemy AA for air lanes, surface threat for the rest.
    These are visibility- and profile-weighted estimates. Experimental AA weights
    are restored in D-131; other explicit zero surface/water weights remain
    [KI-424](../known-issues.md#ki-424--experimental-surfacewater-threat-multipliers-can-hide-armed-enemies).
    "No reported threat" is not a safety assessment. Naval lanes currently use
    surface threat, not a separate submarine-threat model.
  - The share of the way where enemy threat begins (the lane's front).
- **Cached, recalculated.**
  - The first calculation, at game start, is terrain only.
  - It is repeated when the front (the active combat zone nearest our start)
    moves `LaneRecalcShift` (1000), at most every `LaneRecalcMinSeconds` (60),
    or every `LaneRecalcSeconds` (180), with
    the threat seen weighted by `LaneThreatWeight`.

## Integrated strategic map (D-129)

### Battlefield guide (D-131)

The movable guide teaches one selected route. Military-map-inspired open
advance arrows mark approaches; enemy-facing brackets mark containment
opportunities. These adapt the ideas in [FM 1-02.2, Military Symbols](https://rdl.train.army.mil/catalog-ws/view/100.ATSC/CD4DFE54-1C0B-43D9-B8BA-B869F10E6561-1739243205786/FM1_02x2.pdf)
to BAR and are not a claim of standards compliance. Native calculation and
AngelScript interpretation remain the source of every tactical position.

- Select a map badge or use the route arrows. The chosen route draws last,
  brightly; other routes are faint context. **Context** switches to focus only.
- Filter Land, Bot, Amph, Hover, Cliff, Sea and Air independently. The inspector
  shows a complete-route capability mask, length, approximate width, observed
  threat, calculation age and revision. Air is always terrain-capable; this
  does not mean safe from AA. Lack of observed threat is explicitly not safety.
- Toggle Routes, Sites, Shores, Cues, Labels and Teaching; cycle ink opacity.
  Sites start off to avoid clutter. Move the header, collapse, reset, or hide.
  Preferences persist; visibility starts off on a new game.
- **Live updates** requests a survey every 30 game seconds, with native
  recalculation bounded by `recalc_min_seconds` (60). **Freeze** holds the
  displayed snapshot while autonomous AI analysis may continue. **Refresh now**
  accepts one new snapshot while frozen; the AI still respects its cooldown.
  Hidden updates never turn the display back on.

`Lanes::lessons` is an AI-owned array of kind and anchor: scout/advance,
contain a choke, specialist flank, naval access, air approach. A separate
`laneinfo` protocol record carries metrics, mask, lesson, anchor, calculation
frame and revision. The widget only maps these to teaching text and symbols.

The native search prevents diagonal corner cutting and applies uphill cost
in the direction the army travels, even in the reverse search. Specialist
alternatives have configurable bias toward terrain ordinary bots cannot cross.
An additional terrain-driven search identifies connected elevated regions,
then joins our start to an enemy via the cheapest reachable upper-half crest.
It rejects out-and-back visits and duplicate crossings. This makes distant
mountain routes discoverable without naming Ascendancy or Glacial Gap in the AI.

JSON controls: `specialist_bias` (3), `high_ground_rise` (128 elmos above the
player start), `high_ground_detour` (3 times the weighted shortest all-terrain
route), `high_ground_routes` (3), and `teaching_choke_width` (900 elmos).
These are exploration limits, not claims to enumerate every possible route.
The terrain survey is still cached; terrain deformation is not resampled.

D-132 corrects the Ascendancy interpretation: prefer an accessible northern
passage followed by a crawler descent over the enemy-facing cliffs, rather than
assuming a centre-ridge crossing teaches the same tactic. Production code has
no Ascendancy coordinates. Within each major high-ground component it searches
for an ordinary-class-accessible high approach and a downhill crawler-only
section reaching lower bot-passable terrain. D-133 inserts a smooth high-ground
traverse between them. The highest reachable elevation band is selected using
`mountain_peak_tolerance` (256 elmos below the reachable maximum; 0 forces it).
`mountain_grade_weight` (8) adds grade-squared cost for both climbs and dips in
the approach and traverse, leaving the final cliff descent unpenalized.
The traverse stays in the high-ground component and cannot revisit its approach.
`cliff_approach_class` selects tank
(0), bot (1, default), or disabled (-1); `cliff_descent_drop` (256 elmos),
`cliff_descent_run` (1600 elmos) and `cliff_descent_progress` (0.9 of the start-to-
destination vector) bound the candidate. The complete route must fit the 4x
travel/threat-cost detour limit; smoothness cost ranks eligible paths separately.
The generic crest crossing remains a fallback, with ordinary alternatives kept.
The new lesson is **Passage / cliff descent**, anchored at the staging point.
It is a suggested tactic; an actual crawler attack has not been validated.

D-134 prefers paired steep cliff crossings when both are available. It keeps
the reachable high passage but replaces the ordinary-bot approach and earliest
cheap descent with walker-only endpoint legs. Reverse all-terrain searches
discount steep downhill edges impassable to ordinary bots; all costs stay
positive. Each gate must begin above `cliff_height_fraction` (0.5) of the
reachable passage height above its base and satisfy existing drop/run/progress
bounds. Descent quality is total drop weighted by capped grade on bot-impassable
edges, divided by all descending height; gentle drops contribute no reward.
Within `cliff_quality_tolerance` (0.1) of each end's best quality, cost chooses
the route. At most 16 candidates per end enter the bounded pair check, which
rejects loops and checks the full travel/threat budget. `cliff_preference` (8)
controls the edge discount; zero disables paired selection. D-133 remains a
fallback. The widget receives both gates and scores via optional `cliffinfo`,
draws cues at both ends, and performs no cliff selection. INV-066 checks paired
gate metadata and positive native quality at both ends.

See the [screenshot UX review](../reviews/2026-09-28-tactical-guide-ux.md) for
iterations, tests and limitations. INV-062 checks class/mask/path consistency
after each survey. No units are ordered, and attack planners do not yet consume
the recommendations.

The existing [BARb control widget](../../tools/widgets/gui_barb_team_link.lua)
contains the renderer. There is no second widget to install. Select an AI row,
then **Lanes: player** to toggle its map; **All players** toggles every permitted
locally hosted AI, and **Hide lanes** turns everything off immediately. Selecting
another AI while viewing one player follows that selection. `/barbtheatres`
also toggles the selected player. Visibility starts off and persists until changed.
The widget receives AI results over `barbtheatre|1|...`; `barb|theatres|<team>`
requests a cached or recalculated survey, including from non-TECH experimental
roles. Human teams and legacy profiles do not publish surveys. A playing host
sees allied AIs; spectators can see both sides. All mode labels lanes by player.

All geometry, sites, classifications and scores are calculated in AngelScript
or native CircuitAI. The widget projects, styles and labels the result only.
No factory choice, build priority, reservation or task queue is changed.

Stage `--extra-widget tools/widgets/gui_barb_team_link.lua` for a playtest.
Deployment to the live installation remains the owner's action.

### Geothermal, islands and beach frontage

[strategic_sites.as](../../data/script/src/manager/strategic_sites.as) reads the
energy manager's existing geothermal feature list through `ai.GetGeoSpotCount`
and `ai.GetGeoSpot`. Invalid indices return a negative position. For each geo,
it samples a forward fan towards the nearest enemy start at three fractions of
Cerberus's actual effective range. `aiBattle.LineOfFire` screens terrain. Near a
land lane and away from rear starts, sufficient clear forward coverage marks a
**battery opportunity**; otherwise the advisory preference is **power**.
This is a conservative straight-line terrain screen, not a ballistic simulation
or an availability/buildability guarantee. It evaluates the position from each
player's enemy-facing direction, so occupying the opposite geo does not inherit
its defender's favourable angle. Hover geo diamonds for scores and affiliation.
Cerberus remains a Cortex reference weapon; markers do not grant it to other factions.

A four-connected 64-elmo dry-land flood fill identifies small components with
no player start and bordering a shared sea. Violet diamonds mark **air-first
island opportunities**: no continuous dry-land route from a start. These are
terrain opportunities, not claims about current ownership, metal yield, a
constructor's landing footprint or guaranteed arrival times. Air can approach
directly; naval/amphibious access needs its own production and landing route.

Beach spans are joined shoreline edges on spawn-connected mainland beside a
shared sea, screened for inland height/grade. Friendly shores use mint defensive
bars; enemy shores use coral inland-pointing assault teeth. The continuous ribbon
follows the calculated extent of each beach instead of a fixed-size badge.
Neutral stretches, cliffs and pond edges receive neither assignment. Affiliation
still estimates territory from starts rather than observed military control.

Settings under `lanes`: `geo_battery_coverage` (0.6), `beach_max_grade` (0.3),
`beach_min_length` (384 elmos), and `island_min_cells` (3). These are advisory
policy settings, not placement controls. Terrain topology is cached for the match;
deformation can make it stale. Per-player scores refresh with the lane survey.

### Water bodies and advisory sites

[`water_theatres.as`](../../data/script/src/manager/water_theatres.as) reuses
`CBattleAnalysis::WaterBody`, already calculated from `CTerrainManager`'s
elevation data. This is a conservative **ship-navigable water** survey: 64-elmo
cells whose sampled shallowest point is at least 8 deep, joined across edges,
not diagonals. It is not a new map-specific flood fill. Water shallower than
that and channels narrower than the grid are not represented. Geometry is
cached; terrain deformation after the initial native survey is not resampled.

- Components smaller than `water_min_cells` (16) are ignored as fragments.
- A **pond** is a separate component no larger than `pond_max_map_share`
  (2.5% of the map). Larger components are labelled SEA (including lakes).
- Territorial affiliation is an **estimate from the actual playing teams'
  start positions**, not proof of military control. A shore is friendly when
  its distance to our nearest start is less than `water_territory_ratio` (0.8)
  times its distance to the nearest enemy start; the converse is enemy shore.
  The middle band is neutral. No starts means no territorial recommendation.
- A shared naval theatre must have at least four shore cells, and at least
  5% of its shore cells, on **each** side. A friendly isolated body must have
  that friendly share and no enemy shore. Large friendly-only lakes never
  receive shipyard markers merely because they are large.
- **Shipyard candidate:** only a large shared component, in its friendly
  territory, within `water_site_radius` (6400) of our starts. Candidates rank
  by access distance plus observed surface threat. A 320-elmo outward corridor
  must remain in the same ship-water component, with a cell on either side.
- **Tidal / seaplane candidate:** only a friendly pond. Tidal strength must
  be positive and at least `pond_min_tidal` (10 E/s); the map's actual output
  appears in the label. This configurable threshold is an opportunity filter,
  not a cost/payback optimiser. Seaplanes do not require a sea exit.
- All suggested sites must pass the existing terrain manager's
  `BuildableFraction(def, position, 0, 0, facing)` single-site query, including
  its blocking, movement-area and engine footprint checks. No reservation is
  created. The survey tries at most 32 ranked positions per structure kind.
  No valid site means no symbol; a missing symbol is not proof none can exist.

Sites use the current faction's effective shipyard, tidal and seaplane defs.
The symbols are **advisory candidates**, not construction orders or guarantees
that every ship class can traverse the theatre. Neither existing factory
selection nor naval placement reads this new survey.

Reused native facilities also include `body15` (submarine-depth components),
`TerrainManager::GetCurrentMapArea`, `CanMoveToPos` and `CanBeBuiltAt`. Existing
movement-area size heuristics are deliberately retained, including when a
candidate query rejects a small area; this change does not relax placement.

Validation uses [`theatres_supreme.json`](../../tools/playtest/checks/theatres_supreme.json):
two ponds, two seas, two naval candidates, no pond shipyard, successful overlay
delivery, screenshots, no script error or invariant violation. Current run
evidence is recorded in [D-128](../decisions.md#d-128--water-theatres-and-a-read-only-lane-overlay).

For the integration check, stage the control widget and
[theatres_watch.lua](../../tools/playtest/widgets/theatres_watch.lua). The watcher
uses the panel's own action paths to select a player, switch players, show all,
hide all, and verify persistent visibility. It also checks geo/island/beach data.
The final run `20260928-160012` passed, including an AIR-role request and a
refresh that leaves the view hidden. For multiple origins, use `--roles TECH,AIR`
with [theatres_multi.json](../../tools/playtest/checks/theatres_multi.json) and
[theatres_multi_watch.lua](../../tools/playtest/widgets/theatres_multi_watch.lua).
Run `20260928-164931` verified all four players' air-lane origins against their
own starts. Ship the new native DLL, active data tree and control widget together;
the geothermal getters require the D-129 binary (`31153b61d5698386`).

## Attack planning

- `Lanes::BestLane(class)`: minimises `(1 + threat) * length / (1 + width * 0.001)`
  within the representative class: shorter and wider routes with less observed threat score better.
- `Lanes::Waypoints(lane, fromShare, step)`: points down it.
- Each calculation logs `[Lanes] attack plan: LAND down lane 1; NAVAL down
  lane 3; AIR down lane 5`.

TECH's attack code does not follow lanes yet: the harbour fleets and the T2
rush keep Spam's routes. They are the next consumers.

## Historical D-127 playtest (Supreme Isthmus, TECH vs TECH, build113)

- Five lanes from each side: two LAND (14,674 and 14,712 long, narrowest 128),
  two NAVAL (one per sea, 6620 each) and one AIR.
- Both teams computed the same lanes.
- Drawn right after the intro (frames 3031 and 3122), shown 30 s, erased.
- An earlier run, with both AIs drawing at once at the intro's pace, lost half
  its strokes to the server's rate limit; hence the stagger and the slower pace.

## Connected mountain qualification (D-145)

All all-terrain candidate families now pass one native terrain filter before
publication. At least `specialist_min_span` (default 1024 elmos) and
`specialist_span_fraction` (default 0.45) of endpoint separation must be crossed
in one uninterrupted route segment on a connected area above both endpoints by `high_ground_rise`. Progress is
projected toward the enemy, so disconnected mesas or sideways detours cannot
be added together. The requirement is map-independent and JSON-controlled.

TECH uses `IsLaneSpecialist` before building or feeding its dedicated flank
factory. A failed refresh invalidates production qualification until a later
survey succeeds. Existing attackers are not teleported or reassigned by this
change. Isolated elevated artillery positions remain a separate future policy.
