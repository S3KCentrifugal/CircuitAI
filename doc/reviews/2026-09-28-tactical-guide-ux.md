# Tactical guide UX review — 2026-09-28

This is an implementation self-review with engine screenshots and automated
control interactions, not a claim of independent player usability testing.
The intended reader is learning which terrain and approaches matter, why they
matter, and what to scout before committing an army.

## Current verified result

### D-135: sustained mountain shelves on Glacial Gap — 2026-09-29

The native search now distinguishes surface slope from height change along
the route. Flat-looking lateral travel on a cliff is penalized. The upper
traverse has an elevation preference; short intentional cliff endpoint legs
retain the previous steepness policy. If the peak-waypoint search cannot join
both ends, a weighted multi-source search connects upper-band gates through
the component and neighboring land cells, allowing narrow saddle crossings.
All selection remains C++; AngelScript/JSON expose the two new weights.

Three review stages were necessary: inspect the exported terrain and failed
candidate shapes; inspect both actual engine routes and distinguish short
crossings from sideways cliff travel; verify nearby Legion building sites,
interactive controls and the Ascendancy/Supreme regressions. Early surface-only
iterations selected a valley route and were rejected despite their general UI
checks passing. A hard elevation floor disconnected Glacial's narrow cuts and
was replaced with a cost. The screenshot fixture previously selected the lane
with one extreme point; it now selects sustained high ground. This fixture
selection does not move route calculation into the production widget.

Final Glacial Gap v1.1 run:
[`glacial-shelf-verified/runs/20260929-021555/report.md`](../../build-theatres/tactical/glacial-shelf-verified/runs/20260929-021555/report.md).
Its four-player `experimental_terrible` fixture includes Legion. Results below
sample the central 60% of the map width; construction checks use the engine's
`TestBuildOrder` at the line or within Proteus's actual construction reach.

| Measure | Northern route | Southern route |
| --- | --- | --- |
| Mean ground height | 490.3 elmos | 499.4 elmos |
| Samples in outer 10% of map depth | 84 / 84 | 84 / 84 |
| Sideways cliff samples | 3 / 84 | 2 / 84 |
| Longest consecutive sideways cliff run | 1 sample | 1 sample |
| Nearby legal Legion radar sites | 80 / 84 | 80 / 84 |
| Nearby legal Legion cluster-defense sites | 61 / 84 | 74 / 84 |

The fixture requires mean height >=450, >=80% outer-edge samples, <=5%
sideways-cliff samples and no consecutive sideways-cliff samples. It also
requires nearby radar/defense feasibility at >=70%/60% of samples. Total steep
surface samples are logged separately: brief steep crossings of cuts are useful
and must not be confused with long contour travel along a cliff. These checks
and the freeze/refresh/filter/hide controls pass. `InvariantForwardSeconds` is
extended only in staged Glacial data for unrelated KI-423; production data is
unchanged by that override.

![Northern upper shelf](../../build-theatres/tactical/glacial-shelf-verified/runs/20260929-021555/screen_2026-09-29_05-15-39-086.png)

![Southern upper shelf](../../build-theatres/tactical/glacial-shelf-verified/runs/20260929-021555/screen_2026-09-29_05-15-45-353.png)

The same DLL passes the windowed
[Ascendancy experimental_hard regression](../../build-theatres/tactical/ascendancy-shelf-final/runs/20260929-020953/report.md)
and [Supreme experimental_balanced regression](../../build-theatres/tactical/supreme-shelf-final/runs/20260929-021412/report.md).
Ascendancy retains its northern passage and both steep outer cliff endpoints.
Its report does not resolve the TECH AI id, so only the explicitly `scope:any`
geometry, script-error, invariant and UI checks are claimed. Earlier headless
attempts cannot exercise drawn button rectangles and are not UI evidence.

Final DLL SHA256:
`AD7009816B1060C8B220F7DAA359E645C8B22BE704680099BC50DC8B14CAFAFA`
(7,515,802 bytes); matching debug symbols:
`558C015ABA791092728C91BF73E8B976B04AD0C87F452C7984504F061CBC4C71`.
The mandatory engine build output matches `pinned-shelf7`, all 227 active data
files match, and the manifest records 842 source/data/build inputs. CMake reports
no work, `.gnu_debuglink` names `SkirmishAI.dbg`, and all 223 used script API
members match. Invariant and role-document checks pass; documentation links
retain the eight pre-existing missing hover-guide links (KI-404).

This verifies native route geometry, UI behavior and construction-site
feasibility. It does not demonstrate actual walker travel or completed
fortification construction. The live BAR installation was not modified.

### D-134: steep outer faces on both sides — 2026-09-29

The owner's third annotated screenshot accepts the northern passage but marks
the outer western/eastern cliff faces. D-133 still preferred an ordinary-bot
approach and a cheap descent. The new native paired-cliff search ranks exclusive
steepness at both ends, retaining the smooth high passage between them. Cost
breaks ties within a configurable 10% band of each end's best steepness score.

Three self-review passes covered candidate terrain plots, the actual engine
route against the marked outer cliffs, and both cue labels plus the panel's
controls. Ascendancy run `ascendancy-release/runs/20260929-003509/report.md`
passes the strengthened assertions: entry (1312, 1952), exit (11168, 2528),
native quality 1.77119 and 1.72598, the northern passage, and all controls.
Script/widget/invariant checks are clean. The two cues indicate the route's
direction: up the home cliff and down the enemy cliff. The reverse attack can
use these same physical cliff faces in reverse; unit traversal remains untested.

![Paired outer cliff crossings](../../build-theatres/tactical/ascendancy-release/runs/20260929-003509/screen_2026-09-29_03-34-48-557.png)

Current DLL SHA256:
`18BC083415DB49BD36E6E47BCDF964C6A745E29FB4CF2A9F78BCA3E744576770`
(7,504,538 bytes). Matching debug symbols:
`ADD3F855471E0DF2923877FBF780826A2B3EAD8F4691CC1C432CA92560944AD7`.
The required engine output and `pinned-steep` pair match; all 227 active data
files match source. The manifest records 842 inputs. CMake has no work, the
debug link names `SkirmishAI.dbg`, and API parity checks 222 members. Invariant
and role-document checks pass; the eight existing missing-hover links remain
KI-404. No production map waypoints were added.

The same DLL passes balanced-profile Supreme in
`supreme-release/runs/20260929-003750/report.md` and four-player terrible-profile
Glacial Gap in `glacial-complete/runs/20260929-003944/report.md`, including both
northern/southern crossings and all guide controls. Glacial retains the existing
staged-only KI-423 forward-layout timeout override; that separate issue is not
validated by this run.

### D-133: smooth high traverse — 2026-09-29

The owner's second annotated image rejected D-132's early eastern descent and
short western approach. D-133 reaches a configurable band near the highest
ordinary-class-accessible elevation, then traverses the high-ground component
with quadratic grade cost before the final cliff descent. An absolute maximum
prototype produced a bump detour; the default 256-elmo tolerance avoids making
that the mandatory teaching route. This is an explicit height/smoothness trade-off,
not a claim of a globally optimal route or temporal smoothing across surveys.

Three self-review passes covered the native-terrain prototypes (height versus
bump detours), actual in-game geometry against both marked ends, and teaching
cue placement/readability plus automated controls. Ascendancy run
`ascendancy-release/runs/20260929-001155/report.md` passes: exit (9568, 928),
versus D-132's (7200, 992), northern traverse and western passage assertions,
all UI controls and dynamic refresh. Script and invariant checks are clean.

![Extended smooth mountain traverse](../../build-theatres/tactical/ascendancy-release/runs/20260929-001155/screen_2026-09-29_03-11-37-205.png)

The cue follows the later exit and the panel now teaches following the high
passage to the far-side cliff. Actual crawler movement/combat is still untested.
Grade cost discourages abrupt climbs and dips along the route; it is not a
heading/turn-angle optimizer. Terrain remains the native cached survey.

The same DLL passes balanced-profile Supreme in
`supreme-release/runs/20260929-001354/report.md` and terrible-profile four-player
Glacial Gap in `glacial-complete/runs/20260929-001529/report.md`, including both
mountain crossings and all guide controls. Glacial retains the documented
staged-only KI-423 layout-timeout override. CMake reports no remaining work,
and the published DLL's debug link names its matching `SkirmishAI.dbg`.

Current DLL SHA256:
`414B93571E283EF8641EE66ECC129FB091EBC7CD068A0F39DA4EFC7CA889FEF9`
(7,489,178 bytes), matching debug symbols
`6E5A40D7AAC99E23B981A878F815B7E354544D5486824A055CE756174EB4D1A1`.
All 227 data files match the required engine output and `pinned-smooth` binary
pair; 842 input hashes are recorded. Script/API parity checks 219 members.
Invariant and role-document checks pass; the eight existing missing-hover
documentation links remain KI-404.

### D-132: northern passage and cliff descent

The owner's annotated Ascendancy screenshot rejected the earlier central-ridge
route as a poor teaching example. The native search now joins an ordinary
movement-class approach to an all-terrain descent, controlled by four JSON
settings. No production map coordinates are used.

The first two native trials (`ascendancy-release/runs/20260928-233943` and
`20260928-234658`) failed the stronger northern-route check. A cheaper looping
candidate was selected and then discarded, suppressing valid alternatives on
the same mountain. Rejecting approach/descent intersections before ranking
fixed this. The exploratory Lua terrain export was not exact enough to stand
in for native-grid or engine verification.

`ascendancy-release/runs/20260928-235127/report.md` passes with DLL
`3a8ca994d32933f4`: the selected route reaches z=544, stages at (7200, 992), and
descends toward the enemy. Three review passes covered route geometry against
the owner's annotation, cue direction/placement at the actual cliff entry,
and readability/control behavior with labels on and off. These were self-reviews,
not independent user tests. The first screenshot shows the corrected route and
teaching panel; the second confirms route-label control and a refreshed snapshot:

![Northern passage and cliff descent](../../build-theatres/tactical/ascendancy-release/runs/20260928-235127/screen_2026-09-29_02-51-08-773.png)

![Route labels disabled](../../build-theatres/tactical/ascendancy-release/runs/20260928-235127/screen_2026-09-29_02-51-14-901.png)

The hard profile on Ascendancy and balanced profile on Supreme
(`supreme-release/runs/20260928-235255/report.md`) pass metadata, freeze, manual
refresh, layer/filter controls, dynamic revision, hiding, and script/invariant
checks. Actual crawler movement/combat along the route is not yet tested.

Glacial Gap's terrible-profile regression also passes in
`glacial-complete/runs/20260928-235556/report.md`, including both northern and
southern crossings and the full control sequence. The preceding run
`20260928-235407` failed because it fielded only the two northern TECH starts;
the watcher requires the four-player `--roles TECH,TACTICAL` fixture so team 1
occupies the southern allied start. No production change was needed for that
fixture error. This run retains the staged-only forward-layout timeout override
for KI-423; it does not validate that unrelated layout issue.

Published DLL SHA256:
`3A8CA994D32933F4165E33151690C2718246D429AA89DFDFBF488401FF140B55`
(7,485,082 bytes). Matching symbols:
`5B5F0EF1F65654724BA0F9D844B2B7D4ED68E3F6B3F73926E8AC35C9B51D7461`.
The required engine build output matches the immutable `pinned-descent2` pair;
all 227 deployed data files match source. The manifest records 842 inputs.
CMake reports no work; the DLL's debug link names `SkirmishAI.dbg`.
API parity checks 218 members; invariant and role-document checks pass.
The eight existing missing `hover.md` links remain KI-404.

### Earlier D-131 verification

Final DLL `a6d6761a385be53b` with the corrected AA profiles passed the four-player
Glacial Gap test in `glacial-complete/runs/20260928-223556/report.md` (paths below
are relative to `build-theatres/tactical/`). Both northern and southern mountain
crossings passed. Freeze, manual refresh, layer toggles, movement filter,
collapse, opacity, live revisions and hidden refresh passed. Twelve spawned
enemy flak guns were confirmed in ordinary allied LOS; the refreshed air route
changed from 0 to 1,089.44 elmos clearance from the battery. Script, widget and
invariant checks were clean. The isolated fixture extends the separate TECH
forward-layout timeout, as explained under KI-423 below.

The earlier final-build attempt `glacial-complete/runs/20260928-222632/report.md`
timed out during slow graphics loading/early gameplay. It is a failed timeout,
not successful evidence. The rerun allowed 14 wall minutes and finished in 490 s.
The first screenshot in the successful run caught incomplete terrain rendering;
it is rejected for presentation. The southern-crossing and AA screenshots show
fully rendered terrain and were visually reviewed.

The older sections retain the actual review iterations and rejected diagnoses;
their intermediate binary hashes are superseded by the final binary above.

Supreme's final-DLL control test also passed in
`supreme-release/runs/20260928-223740/report.md`; the naval width now reads 2,400
elmos and the land choke 800. Its first capture revealed the same terrain-render
race. The camera harness now waits at least three rendered frames and one actual
second after moving, instead of six simulation frames (only 25 ms at 8x).
Presentation recaptures use an earlier first-shot schedule to retain the checks'
one-minute deadline. The production widget is unaffected.

| Final binary test | Result | Archived report |
| --- | --- | --- |
| Glacial Gap, experimental_terrible, four players | PASS both mountain crossings, controls and observed-AA reroute | `glacial-complete/runs/20260928-223556/report.md` |
| Supreme Isthmus, experimental_balanced | PASS controls, 800-elmo ground choke and 2,400-elmo naval width; settled screenshots visually reviewed | `supreme-release/runs/20260928-224126/report.md` |
| Ascendancy, experimental_hard | PASS northern mountain crossing, controls and revisions; settled screenshots visually reviewed | `ascendancy-release/runs/20260928-224309/report.md` |
| Glacial Gap presentation recapture | PASS both crossings and controls; both settled mountain screenshots visually reviewed | `glacial-complete/runs/20260928-224540/report.md` |

The Ascendancy harness role is not identified as TECH, so its checks remain
global lane/UI checks. All final runs use the same DLL and active profiles;
test-only intro/timing overrides are listed below. Screenshot files are archived
beside each report, so subsequent runs cannot replace their evidence.

## Round 1: hierarchy and agency

On Supreme Isthmus, the initial guide supplied useful sea/land distinctions but
background routes could draw over the selected route. Dense site labels fought
with the teaching cue. The selected route now draws last with a dark outline;
secondary routes are subdued. Sites start off. The player can focus one route,
filter each movement class, hide labels/sites/shores/cues separately, reduce ink,
move/collapse the panel, freeze the displayed survey, explicitly refresh it,
select a player or all players, and hide the entire overlay.

Evidence: `build-theatres/tactical/supreme-r1/runs/20260928-210751/report.md`.
The real widget controls passed freeze, frozen refresh, resume, hide and hidden
refresh checks. This first run predates the final drawing refinements.

## Round 2: a plausible diagram is not sufficient

Ascendancy's first test produced an all-terrain route but it stayed near the
ordinary central approach. That failed the user's actual mountain example even
though the generic UI checks passed. Native analysis now searches connected high
ground and evaluates reachable cross-mountain alternatives, in addition to the
ordinary shortest paths. No map name or mountain coordinate enters production
code. JSON controls minimum rise, maximum detour and route count. The test now
requires an all-terrain route crossing the northern part of the map's middle.

Evidence: `build-theatres/tactical/ascendancy-r2/runs/20260928-211040/report.md`
(the insufficient check) and `ascendancy-r3/runs/20260928-211720/report.md`
(the stronger check passed with DLL `354e47306c2a5d10`).

## Round 3: route usefulness, legibility and perspective

The first high-ground search preferred the absolute summit, which could send the
route unnecessarily close to the map edge. It now chooses the cheapest reachable
crossing in the upper half of a high-ground component. Teaching symbols sit on the
specialist section or choke, not an arbitrary screen position. The panel states
terrain-compatible classes, length, bottleneck width, observed threat and survey
age. "No observed threat" explicitly does not mean "safe".

Glacial Gap's two-player northern-start fixture showed a northern crossing but
failed the southern-crossing check. That fixture could not establish southern
starting-area coverage. The follow-up uses both TECH (north) and TACTICAL (south)
origins on each side and selects each player's own survey. The failed evidence is
retained in `build-theatres/tactical/glacial-r4/runs/20260928-212220/report.md`.

## Symbols and teaching

The open direction arrow and enemy-facing defensive bracket borrow the ideas of
an axis of advance and a battle position from
[US Army FM 1-02.2, Military Symbols](https://rdl.train.army.mil/catalog-ws/view/100.ATSC/CD4DFE54-1C0B-43D9-B8BA-B869F10E6561-1739243205786/FM1_02x2.pdf).
They are simplified game annotations, not a claim of doctrinal symbol compliance.
The selected route's lesson explains scouting, containing a choke, specialist
flanking, naval approach or air approach. The observed-threat diamond advises
scouting before crossing. Optional existing strategic sites remain candidates.

## Ownership and practical limits

C++ calculates terrain connectivity, routes, capabilities, threat costs and
chokes. AngelScript owns refresh policy, tuning and lesson anchors. Lua renders
published results and manages local display preferences. No widget pathfinding
or combat orders were added. Future AI attacks can consume the same lane cache.

These are broad movement-class estimates on a coarse terrain grid, not promises
for every unit footprint. Exploration is bounded rather than exhaustive. Terrain
is cached, so deformation is not incorporated. Threat reflects the AI's observed
information and profile weights; remaining ground/sea zero weights are KI-424.
Naval costs currently use surface threat, not a separate submarine model.
Territory is a start-based estimate. Surveys require a local BARb
instance running the shared experimental scripts. Ordinary human-only or remote-AI
spectator games do not gain a survey merely by installing this widget.

The isolated tests disable the intro only in a copied data tree, remove chat from
screenshots, and deliberately inject enemy AA for a dynamic rerouting test. They
do not change the owner's game installation. Ascendancy uses actual map start
coordinates in a test fixture; the harness does not identify its default-map role
as TECH, so its assertions are global UI/geometry checks, not TECH behavior checks.

## Final verification

The default Glacial four-player run passed north and south geometry, then failed
on the separate TECH forward-cluster timeout (INV-013). Code inspection found that
unsuccessful terrain searches never advance the exhaustion counter; this is
recorded as KI-423. The tactical follow-up extends that one timeout to 10,000 s
in its staged copy, retaining all invariant/error checks. It is not evidence that
the default TECH layout is fixed.

The final screenshot pass also found that beach symbols were still drawn with
Shores off. Beach cues now require both Shores and Cues, and the selected player's
survey draws after every background survey. Focus-only screenshots demonstrate
that players can remove the multi-player clutter without losing the selected
route or its teaching cue.

Build verification: DLL SHA-256
`8CB1748A17A1CB17D3775CAD18F5C3D782529567AB4DE748F809FFA870F98C97`;
matching debug symbols staged beside it. CMake reports no work to do against the
current native tree. All 216 used script APIs match the binary. All 227 deployed
data files match current source; 842 input hashes are retained in
`build-theatres/tactical/inputs-final.json`. Invariant/documentation coverage
checks pass. The link checker reports only the eight existing missing-hover-guide
links (KI-404), with no new broken links.

The first AA test (`glacial-r6`, run `20260928-213415`) failed because its `/give`
command ran before synced cheat permission took effect: the engine explicitly
rejected the command, so there was no AA battery to avoid. The fixture now enables
cheats on an earlier frame and verifies that all 12 flak units actually exist
before testing the route. This failed run still verified both mountain crossings,
freeze/manual refresh, survey revisions, hiding and INV-062 without violations.

Profile coverage exposed another real defect: `ascendancy-final` with explicit
`profile=experimental_hard` returned zero enemy starts. The native start parser
accepted only leaf blocks, so an AI containing `[OPTIONS]` was dropped from the
participating-team set. It now reads direct fields while skipping nested sections.
INV-063 rejects a tactical survey with no enemy destinations. The failing run
`20260928-213553` is preserved; the next native build supersedes the hash above.

Release build: `734A4468F9C7DAA57734B9D998869D075FD2E087CDCA491CECA76295C46FD705`
(7,478,938 bytes). Its matched `.dbg` SHA-256 is
`AAC38823233C39338AFADE1D734F8253CD15B316FF51AB0BB6202830D56C5CE3`.
The mandatory engine build output contains this pair and the latest active data.

| Release test | Result | Evidence |
| --- | --- | --- |
| Ascendancy, experimental_hard | PASS: northern mountain crossing, 14 lanes, revisions, all layer controls, class filter, collapse, opacity, freeze/manual refresh/hide; no script/invariant/widget errors | `ascendancy-release/runs/20260928-214109/report.md` |

Evidence paths in this table are under `build-theatres/tactical/`. The successful
Ascendancy run includes nested AI OPTIONS in its actual engine start script,
providing an in-game regression check for the start parser fix.

The next AA attempt (`glacial-release`, `20260928-214306`) successfully created
12 flak units but still failed the reroute assertion. It used global LOS; the
native enemy-created callback explicitly documents that enemy data cannot always
be queried under global LOS. The subsequent fixture removes that shortcut, gives
ally 0 a stationary radar observer beside the battery, and asserts ordinary LOS
on all 12 enemies before evaluating the route. No production threat weights were
changed to make the test pass.

The ordinary-vision attempt (`glacial-observed`, `20260928-214744`) also failed
the route-clearance assertion despite all 12 flak units being in allied LOS.
Therefore global LOS alone does not explain the failure. A staged-script-only
probe now records the flak definition's AA threat and the sampled native threat
map value; the failure remains open until that evidence explains it.

Round 3 also exposed a misleading choke estimate in the Supreme screenshot:
twice the distance to the nearest impassable cell can describe a path hugging
one coast, not the corridor's full width. Native lane measurement now casts
perpendicular rays to both boundaries and centres the marker between them.
INV-062 also checks the resulting choke anchor is traversable by its class.
The DLL containing this final geometry refinement starts `da8bf2986ed20c00`.

The native probe settled the AA failure: `armflak.GetAirThreat()` was **0** even
before any enemy was spawned, and the sampled map stayed at 0 after confirmed
LOS. The route refresh itself was running. The initializer now resolves armor
indices from the loaded engine's fighter/submarine UnitDefs instead of assuming
the historical sorted armor-name list matches this game archive. Representative
units and fallback policy remain in AngelScript. INV-064 checks the BAR flak
threat at survey setup; the next test will establish the loaded indices and
whether the observed-AA route changes.

The armor-index hypothesis was disproved in `glacial-verified`: both Lua's
`Game.armorTypes` and a temporary native UnitDef lookup reported vtol=14/subs=13,
matching the historical script, while INV-064 still fired. The speculative lookup
API and initializer change were removed. It was not a successful fix. The next
probe reads the native weapon's category, projectile speed, armor damage and
classification to locate the zero threat without changing unrelated policies.

The final native probe confirmed correct weapon classification (flak: air armor
14, damage 250, matching air category, speed 53.33, range 850). The zero came from
experimental JSON profiles, not the engine or pathfinder. D-131 restores `air`
and `default` multipliers to 1 for 47 AA-role entries in each experimental profile
(base and Legion files), retaining their surface/water settings. Both weights
are required by the enemy damage gate. This affects ordinary AI avoidance too.
The diagnostic native log was removed before the final build. Remaining ground
and water zeros are documented as KI-424; the panel now labels the measure
"reported" and explicitly mentions AI sight plus profile weights.

Final binary: `A6D6761A385BE53BCD2CAC73B2F5A1DEC430092D3AEBAA763039FBCB485391E5`
(7,479,450 bytes), debug symbols
`805596343E2367FD8409AD81A0F1B373460BF60FF0DC8282DC3DA9BE8311D124`.
This supersedes all historical hashes above. The required engine build output
and immutable `pinned-complete` pair match. CMake reports no work; `.gnu_debuglink`
names the paired symbols. The final manifest covers 842 inputs and all 227 data
files match the active source exactly. Script API parity (216 calls) and invariant
coverage pass. The documentation checker has only eight existing missing-hover
links (KI-404); the unit-helper checker has the two sonar findings now recorded
as KI-425. None is represented as a clean check.
