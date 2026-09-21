# Uncommitted changes - the 100 highlights (2026-09-20)

Base: the last commit on `smrt`. Working tree: 81 tracked files changed
(8 046 insertions, 714 deletions) and 19 untracked paths. Decisions D-030 to
D-062 in [`../decisions.md`](../decisions.md); the code review and its fixes
in this folder. Two sessions contributed: this one (D-035 to D-059, D-061)
and a parallel one (D-060, D-062). Nothing is committed and nothing has been
Played since D-053.

## Targeting and stockpiles (D-030 to D-036)

1. A squad attacks when it outweighs what it can reach, or after a configurable wait (D-030).
2. Siege artillery holds fire for anything but its ordered target (D-031).
3. EMP ranks large statics first, then everything by metal cost (D-032).
4. AIR porcs for air denial earlier and on allied clusters (D-034).
5. A stockpiled shot's value floor decays while it waits, so a silo no longer holds three missiles against a discovered base (D-035, `StockedShotFloor`).
6. Perdition and Catalyst aim by unit scan and value the aim point by the metal inside the blast; the old group centroid never came within range (D-036, `SelectLauncherTarget`).
7. Super statics bypass role policy in `Military::AiMakeTask` so the native super task keeps them (D-036).
8. Damaging launchers reject an aim point whose blast holds a friendly unit (CR-005); EMP and Juno keep the old selector.
9. The stockpile settings block in all three `behaviour.json` files, with launcher keys; comments now name the real consumers (CR-016).
10. `doc/launcher-targets.md` documents the launcher scan, the floor and who gives the launcher its task.

## Builders and economy policy (D-037 to D-042, D-051 to D-054)

11. Builders finish what they start: a unit on a construction task whose structure exists is not re-tasked (D-037/D-050).
12. Unused fresh default tasks are discarded instead of orphaned in the queue (`DiscardUnusedTask`, D-037).
13. Energy focus: one energy structure at a time with capped assists (`EnergyFocusAssist`, D-037).
14. Hover plants are never spam; the three hover units lost the spam attribute (D-038).
15. Legion builds its own T2 shipyard (`GetT2ShipyardForSide`, D-039).
16. A unit marked for reclaim is never repaired by anyone on the ally team (`CAllyTeam::MarkReclaim`, three repair tasks, D-040).
17. TECH donates T2 combat bots by a plan drawn once between min 2 and max 7 with decay (D-041).
18. T2 constructors are given only on request, built ahead of everything, and flown by the ferry when one exists (D-041).
19. SUPPORT and TECH never auto-request a constructor; a request is still always served (D-046).
20. The sea-constructor ladder is shared and a donated construction ship runs it for TACTICAL (D-042, `sea_constructor_helpers.as`).
21. TECH holds turrets while the first T2 constructor is paid for and owns the nano count (`NanoHoldForFirstT2Constructors`, D-051).
22. Native assist nanos got per-instance levers on the script API (`assistNanoEnabled`, `assistNanoIncomeMod`, D-051).
23. A land-locked start never spams (D-052).
24. TECH's own economy overrides wait for +20 metal and +1000 energy, then switch once (D-054).
25. Energy-condition overrides now reach the selection list's copy, not only the canonical entry (CR-009, `CAvailList::UpdateInfo`).
26. Per-role reclaim efficiency (`reclEnergyEff`) and energy limits on the script API (D-047).
27. A mex upgrade outranks the energy ladder (`MexUpgradeFirst`).

## Ferry and donation (D-044, D-056, CR-004, CR-014, CR-024)

28. The ferry lands on clear ground found with the engine's site search (`FindLandingSpot`, D-044).
29. Cargo is parked in a builder wait so it stops taking orders; the park now outlasts the whole run and is renewed on retries (D-044, CR-024).
30. A cargo queue: constructors wait behind the one in flight instead of walking (D-044).
31. The flight to the drop is queued behind the load order, so an Atlas that hovers low with its load still leaves (D-056).
32. Any lift counts as loaded; landed means exactly on the ground for two updates (D-056).
33. A timed-out dump retries at a wider spot and never turns terminal while the cargo hangs, so a constructor is never given away in the air (CR-004).
34. A failed constructor order times out and is re-ordered; a null enqueue no longer counts as an order (CR-014).
35. The ferry protocol (`barbdon|conreq/ack/sent`) and the transport request from AIR are in `transport-ferry.md` with its eight traps.

## Air waves (D-045, CR-011, CR-013)

36. Bomber waves scale with income: +50 bombers per +100 metal (D-045).
37. Waves form lines parallel to the front and attack-move as a carpet along a computed vector (D-045, `CAirWaveTask`).
38. Six attack methods: carpet, flank, pincer, strike, deep, feint, with smart bearing sampling (D-045).
39. Direct strikes pick T3, statics and AFUS by cost (`PickStrikeTarget`).
40. A wave wiped out aborts itself instead of living in the task sets for ever (CR-011).
41. The hold time-out waives the escort only, never the bomber floor (CR-013).
42. `doc/air-wave-attacks.md` documents the size rule, formation, vector and methods.

## The layout, this session's line (D-043 to D-058)

43. Native reservations: a `RESERVED` blocking-map bit, a registry served by `FindBuildSite` with facing, restore on cancel, finish on start (D-043).
44. Reservation matching is explicit: only a builder task's search may take a slot, and the hand-off is cleared on every search (CR-002).
45. A retry hands its previously served slot back before searching again (CR-010).
46. A served factory slot is kept across retries and accepted without the front-ground test (D-055).
47. Every later land factory gets a line slot, block and exit cone before it is enqueued (`PrepareFactory`, D-055).
48. Nano blocks are served only within reach of their factory; every factory gets a block (D-048).
49. Zone-backed nano blocks tolerate a factory's own yard, so Cortex and Legion labs get theirs (V-001).
50. `BuildableFraction` and `FlatFraction` score candidate sites on buildable and flat ground (D-050).
51. Zones and corridors: cells held for the life of the plan, corridors never laid (D-053).
52. Bands: grids of one def inside a zone, armed or held, idempotent laying, tenants forgotten and final slots restored when their structure goes (D-053).
53. Exit cones, ring road, breaks and firebreak as corridors; `ReserveExitCone` for factories off the line (D-053).
54. The layout is off by JSON default (`layout.enabled`) and on only through TECH's init (D-053).
55. Builder routes: a band, a dedicated builder, a pinned slot, `repeat` grows a bay (D-053, `AiPinReservation`).
56. The per-AI overlay: `DescribeLayout` to the widget, `/barblayout` draws zones, corridors and slot states (D-053).
57. D-057 re-oriented the complex: a full-width head strip of nanos behind the labs, a spine growing away from the enemy, flanks tight on both sides, a storage strip, winds as the fusion zone's first tenant.
58. Siting tries forward and back offsets and scores the best candidates in full (D-057).
59. Unbuilt advanced-solar slots are released with the other tenants when converters arrive (CR-015).
60. The eco planner: one deterministic function of wind range, incomes, banks and what stands names the next energy, converter or storage structure (D-058).
61. It offers only what the asking constructor can build (`CanBuild` on the script API, CR-006) and one energy structure at a time (V-002).
62. Wind, energy-storage and metal-storage enqueue helpers; wind, storage and geo names by side.
63. The map's wind range, current wind, tidal and metal-spot count on the script API.
64. `doc/eco-planner.md`: the meta's numbers, the function, worked openings, settings.
65. `doc/layout-design.md`: kill-distance and reach tables, verdicts on every layout idea, the design, its implementation table.
66. The knowledge base's explosion table corrected: a nano's death deals 530 to other nanos, and the falloff formula and kill distances are recorded.
67. Layout state and task reservation ids are saved and loaded; save version 6 (CR-003).

## The layout, the parallel session's line (D-060, D-062)

68. D-060 replaces the script-composed bays, tenants and unbounded spine with native canonical clusters in `BaseLayoutGeometry.h`, centres in half-cell units.
69. Fixed T1/T2 factory clusters from actual footprints: two rear nanos for a T1 lab, a 3 x 2 block for a T2 lab, a 20-cell exit rectangle.
70. One compact rear economy module: 4 AFUS, 24 nanos, 18 advanced converters, or a half tier, with an exterior access corridor.
71. Full-tier candidates before half-tier, over increasing rear setbacks and alternating side offsets; each cluster preflights and commits atomically.
72. Module slots stay unarmed and are claimed only through `EnqueueLayout`, far-to-near; a failed pin aborts the task rather than falling back.
73. Named groups, zones, ordering, claims and factory-line metadata are serialized; script adopts restored state by name (KI-406 closed).
74. Runtime role leave aborts every layout-owned task before clearing the registry.
75. A standalone geometry test target (`tests/`, `base_layout_geometry_test.cpp`) built and checked on MSVC.
76. D-062: TECH opens on the nearest three reachable home mexes, six winds, the T1 lab, one energy storage, with native factory scheduling held until those phases finish.
77. Converter count follows measured energy surplus and each def's real conversion numbers, four per AFUS, the fifth from remaining surplus.
78. `GetBuildPowerNear` measures regional assist power; nano rows are built to a 2.5 BP per metal-income target.
79. Native automatic storage is off for TECH and pending storage tasks count toward its one-storage cap.
80. `doc/tech-eco-meta.md` records the three-resource model (metal and energy map-wide, build power regional).

## The code review (D-059)

81. An external review of the whole change set: 25 findings, all verified accurate (`2026-09-20-uncommitted-code-review.md`).
82. A use-after-free in reclaim bookkeeping introduced by D-040 is fixed by storing ids beside pointers (CR-001).
83. A squad merge keeps the older squad's attack-wait clock (CR-012).
84. Runtime role switching resets the old role's layout and native manager settings and applies the new role's porc chain and plan (CR-007, `NativeState`).
85. The widget lists, draws and commands only allied AIs; a spectator can view but not route (CR-008).
86. Eight documentation findings corrected, the D-023 anchors fixed, the role-doc marker refreshed (CR-016 to CR-023).
87. `git diff --check` flags carriage returns because the files are committed with CRLF; with `core.whitespace=cr-at-eol` it passes (CR-025).
88. The fixes are written up one by one with before/after code, diagrams and screenshot placeholders (`2026-09-20-code-review-fixes.md`).

## Widget and tooling (D-049, D-061)

89. The team-link widget is a "Player / AI" tab strip stacked on the bottom-right player list; the AI tab opens a panel above it, covering nothing (D-061).
90. Team and AI dropdown menus, status chips, a segmented role selector, Query / Overlay / Query all, and a dense event log, Material 3 at compact density.
91. The layer finding: this game's handler puts the lowest layer on top for both drawing and clicks; the widget sits at -6.
92. `deploy_widgets.py` and a Claude Code PostToolUse hook copy a changed widget into the game automatically.
93. `doc/start-position-control.md`: how an AI could choose its start position without engine or game changes, brokered through the host widget (proposal, D-049).
94. The commands channel gained `layout` and `route` verbs; the widget link mirrors ferry, donation, layout and route events.

## Process and state

95. Every change has a decision entry with an honest Built / Checked / Played status; none of D-053 onward is Played (KI-401, KI-407, KI-408).
96. KI-405: the layout's corridors and zones are not shared with allies.
97. Two script-only deploys broke game start (a reserved word, a const handle) because there is no offline AngelScript compiler (KI-402); both were fixed from the log's `ERR` lines.
98. The deployed DLL (`be6012ad...`) predates the parallel session's D-060 and D-062 native changes; the current tree has not been built since.
99. `build-layout-tests/` (a CMake build directory with Visual Studio files) is untracked output that should be ignored, not committed.
100. Line endings: the repository's files are CRLF in git; one patch script left `InitScript.cpp` mixed and it was normalised; patch scripts must keep the file's own line ending.
