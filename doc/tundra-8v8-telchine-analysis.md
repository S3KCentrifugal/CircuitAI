# Tundra 8v8 Telchine gameplay analysis

## Run and evidence plan

Requested: a full 8v8 on Tundra, with screenshots of Telchines landing, holding
important beaches and staying on dry ground when engaging naval targets.

The natural match is staged at `build-theatres/d159-tundra-full`, with all 16
map start spots, the existing map-assigned roles, mixed factions and Legion on
both TECH positions (teams 0 and 12). The existing map roster is asymmetric:
north has TECH, three TACTICAL and four SEA; south has TECH, AIR, TACTICAL and
five SEA. This is an existing-roster gameplay test, not a balanced win-rate
comparison. Profile: `experimental_balanced`; game:
`Beyond All Reason test-31450-6562fb1`; engine: `recoil_2026.07.04`.

Pinned DLL: `build-theatres/d158-build-05/SkirmishAI.dll`, SHA256
`d70acd89478aa3179b0e97e7a50b7941b7a2d6d5375db5b99a766e91bb005fb1`.
Native and script production/economy behavior is unmodified. Income multiplier
is one, all handicaps zero, extra units off, Legion on, `nowasting=disabled`,
`dynamiccheats=0`, commander-death mode `com`. Spectator vision is not AI vision;
no global-LOS cheat, gifted units, frozen builders or supplied resources.
The initial observation limit is 60 game minutes; completion versus a time limit
must be stated explicitly. The opening-only run `d159-tundra-8v8` was stopped
after diagnosing the camera's early speed-restoration race, and is not counted
as the full match.

Read-only observers record production, damage, attributed kills and metal value,
losses (including submerged losses), actual water-to-land transitions, stationary
coastal positions, active attack targets, movement state and naval engagements.
Camera captures temporarily slow to 0.25 and restore an explicit requested speed,
so the startup screenshot cannot overwrite 8x with a stale initial 1x reading.
The camera control file changes framing only; it issues no unit orders.

## Interpretation rules

- Natural effectiveness includes first production time and whether units arrive
  before the contested beach is lost. TECH recruitment currently requires at
  least +200 metal/sec, a compatible factory and enough metal banked.
- A screenshot of a shoreline is not proof of a landing: correlate tracked unit
  IDs with a prior submerged position and subsequent dry position.
- A stationary coastal group is not automatically a strategic garrison. Correlate
  nearby mex/geothermal assets, observed enemies and controller phase; distinguish
  assembly, safe-route blockage and a deliberate coastal hold.
- An attack order naming a ship while submerged is a pursuit candidate requiring
  review. Planned underwater travel to another dry objective is not naval pursuit.
- No pursuit violations without an actual naval engagement is inconclusive. A
  supplemental controlled shore/navy test may establish this behavior separately,
  but must never be represented as natural 8v8 combat.
- Damage totals include engine-reported damage and may include overkill. Attributed
  kills and metal value describe contribution, not isolated unit cost efficiency
  or causal effect on the match winner.
- Keep all runtime errors and invariant failures in the report. Prior KI-448
  registration failures remain relevant even if a later match succeeds.

## Completed natural 8v8

Southern ally team 1 won at **38:37**, frame 69,523. All eight opposing AIs
were eliminated. The engine continued after GameOver until the observer was
stopped at 47:12; those later frames are excluded from match results. In
particular, the first `hold coastal guard` at 40:05 is post-victory evidence,
not a successful contested garrison. Post-game awards also obscure its images.

Archive: `build-theatres/d159-tundra-full/runs/20261001-121509/` contains
`report.md`, `infolog.txt`, screenshots and `telchine-summary.json`. Reproduce
the cutoff audit with [audit_telchine_match.py](../tools/playtest/audit_telchine_match.py).

| Observation before GameOver | Result |
| --- | --- |
| First completed Telchine | 32:58, southern TECH team 12 |
| First wave | Three units depart at 34:29; six desired, minimum three after assembly timeout |
| First dry landfall | 35:06; island near (8096, 9824), five nearby mex structures |
| First regroup / secured | 35:11 / 35:29 |
| Next dry landfall | 36:18; island near (5920, 8288), six nearby mex structures |
| Next regroup / secured | 36:21 / 36:39 |
| Total completed Telchines | Seven, all southern TECH; northern TECH produced none |
| Distinct units landing / total unit landfalls | Six / twelve (includes repeated island transitions) |
| Secured wave stops | Two before GameOver |
| Telchine losses / attributed kills / damage | Zero / zero / zero |
| Naval engagements / pursuit candidates | Zero / zero; no-pursuit behavior unexercised |
| Deliberate coastal-guard phases before victory | Zero |

The first three units crossed several channels and regrouped on usable dry
ground. Their stop near five or six mexes is strategically relevant terrain,
but it was already friendly and unopposed. They waited eighteen seconds after
regrouping and continued. No defenders were left behind. Seven units represent
4,200 metal and 92,400 energy of unit production with no direct combat return
in this match; that is an observed timing failure, not a general verdict on
Telchine cost efficiency.

Natural screenshots (taken before victory):

- `build-theatres/d159-tundra-full/screenshots/screen_2026-10-01_15-10-10-194.png`:
  first wave on the first dry shore, approximately 35:07.
- `build-theatres/d159-tundra-full/screenshots/screen_2026-10-01_15-10-28-537.png`:
  next island landing, approximately 36:20.

The current +200 metal/sec gate is too late in this particular match. Northern
TECH's T2 bot lab completed at 6:48, but its income was only about +46 at 28
minutes, then collapsed to zero around 32 minutes. Southern TECH was about
+138 at 28 minutes, +182 at 30 and +231 at 32. Both sides had already invested
in and fought with navies. Southern TECH's first Telchine was completed only
after northern TECH had effectively lost its economy and army. This is a
single asymmetric-roster match: it cannot establish a win-rate advantage or
attribute the southern victory to any one role or unit.

The overall regression verdict is **FAIL**, despite successful landfalls.
Before GameOver there were 65 invariant reports: INV-013 (1), INV-029 (8),
INV-018 (23), INV-008 (1), INV-041 (19), INV-015 (5), INV-022 (1), INV-017 (6),
INV-039 (1). These concern layout, reclaim, pending work and ferry ownership.
The complete archive, including post-victory frames, contains 121 reports.
There were no script errors, crashes or amphibious INV-096 reports. Existing
KI-423/KI-427 cover broader TECH invariant work; this result does not waive it.

## Shoreline-retreat supplement

Because the natural match contained no Telchine combat, use a separate
controlled test prepared by
[prepare_telchine_shore_check.py](../tools/playtest/prepare_telchine_shore_check.py).
It reuses the existing frozen-economy amphibious harness, injects six TECH
Telchines and provides global LOS. The AI selects all Telchine movement and
holds. After they autonomously cross, land and stop at the final island, spawn
an enemy ship in coastal range and move it offshore after a verified hit.
The spectator host has Recoil godmode order permission; the fixture orders only
enemy team 2 and never a Telchine. This flag grants control, not invulnerability.

Record actual firing, ship movement beyond range, every Telchine's ground
height, movement state and command during the following minute. A passing
no-pursuit result requires a live ship beyond range and no wet/chase samples;
an unengaged or destroyed target does not pass. This isolates the hold mechanism,
not natural economics, role balance or persistent strategic garrison selection.

Three preliminary probes are retained as failures/incomplete evidence:

- `d159-tundra-shore/runs/20261001-122154`: coastal firing worked, but the
  unsynced team-control command ran before synced cheat enablement. No retreat.
- `d159-tundra-shore-repeat/runs/20261001-122404`: joining the enemy team
  removed spectator read access and broke the fixture. It also reported
  INV-050 because the failed fixture never supplied its initial factory.
- `d159-tundra-shore-final/runs/20261001-122742`: six Telchines landed,
  held dry ground and sank the cruiser before it could escape. No wet samples,
  but this cannot pass the live-target retreat check. Onshore engine-generated
  ATTACK orders are normal automatic firing while holding position; the final
  audit distinguishes them from submerged naval pursuit.

The revised probe uses a tougher battleship at least 520 elmos from every
Telchine, so it can survive initial volleys and move beyond the 600-range weapon.

**Final supplement: PASS.** Archive:
`build-theatres/d159-tundra-retreat/runs/20261001-123039/`. All six TECH Telchines
crossed and reached the final island near (5984, 11296). The controller logged
`hold coastal guard` at 6:39. At 7:25 a Telchine hit the supplied battleship;
the enemy retreat command followed one frame later. Four hits dealt 1,401.1
damage in total. At 8:26 the ship was still alive, 1,481 elmos from the firing
anchor. Across the sixty-second observation window all 360 unit samples were
dry and in movement state 0 (hold position), with zero submerged ship-attack
orders. There were no losses, script errors, invariant reports or crashes.

Actual screenshots:

- `build-theatres/d159-tundra-retreat/screenshots/screen_2026-10-01_15-29-38-041.png`:
  Telchines firing from land toward the battleship at the coastline.
- `build-theatres/d159-tundra-retreat/screenshots/screen_2026-10-01_15-29-54-716.png`:
  the same six Telchines still on land with the surviving battleship offshore.

This proves the existing hold-position mechanism refused underwater pursuit
in this encounter. It does not prove a strategic garrison policy: the fixture
has empty metal spots and a fallback hold at the final enemy-start objective,
not a naturally selected beach protecting an established friendly economy.
It also does not test AIR natural recruitment, save/load, every ship/sub type
or repeated enemy approaches. Those limits remain explicit.

## Recommended policy work

BAR's [official Telchine reference](https://www.beyondallreason.info/unit/legamph)
describes a coastal assault/guard unit with a 450-range heat ray and 600-range
depth charge, and explicitly states that it cannot fire submerged. This agrees
with the unit script and the requested shoreline behavior. The recommendations
below are inferences from that role and the observed match, not a proven build
order from one test.

1. Give amphibious recruitment its own affordable early T2 budget and coastal
   demand signal instead of inheriting TECH's +200 general combat gate. Compare
   candidate gates around +80 to +120, with energy/build-power checks, funded
   constructor obligations and a bank reserve. Keep the existing ordinary TECH
   rush/build sequencing unchanged and measure first meaningful contact, not
   just first unit completion. Both `tech.as` and `air_production.as` pass a
   combat gate into `Produce`; lowering only the JSON minimum cannot bypass
   that caller gate. Separate those amphibious call sites as well. Do not treat
   these candidate numbers as tuned.
2. Distinguish an assault wave from a retained beachhead guard. Score useful
   shore positions by protected mex/geothermal assets, channel access and
   observed enemy naval approaches; reserve a bounded defending group while
   the next wave advances. Avoid leaving every completed wave at a defeated
   enemy start. The current eighteen-second SECURE dwell alone is not a garrison.
3. Preserve dry firing positions and hold-position movement. Reposition along
   the same dry land component to cover a naval approach; never route toward
   a ship or submarine as a strategic destination. A separate explicit island
   assault may cross water only after regroup/security checks.
4. Repeat with mirrored factions/roles and several seeds after a policy change.
   Require pre-victory shore combat, target retreat, protected economic assets,
   first-wave timing and the existing invariants. Keep controlled and natural
   evidence separate, and retain failed runs.

No production policy was changed by this analysis.

## Validation and retained work

Added reusable opt-in match telemetry/camera, a GameOver-aware result audit,
the isolated shore preparer/fixture and strict check files. Natural match
checks FAIL on 65 pre-victory invariant reports (121 including post-game),
while the final controlled naval-retreat check PASSes. All preliminary failures
remain archived. Script/DLL API parity checked 259 used members without findings
before every launch; Python compilation and the invariant-practice checker pass.
Documentation links retain eight pre-existing references to missing `roles/hover.md`
(KI-404); no new broken links were introduced. All test engines were stopped.
