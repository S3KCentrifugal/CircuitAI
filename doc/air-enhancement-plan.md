# AIR enhancement plan: production, strike packages, targeting, navigation and ISR

Date: 2026-10-01. **Status: reviewed; core production and strike controller implemented and played.** The
[evidence audit and implementation contract](air-enhancement-review.md) corrects
and supersedes the initial proposal below, including all numerical examples.
The initial review used branch `smrt-test` at `75e1056b`. Preserve the owner's
twenty-turret expansion rule; the proposed bypass below is not authorized for
implementation. Experimental AIR wave sizing may change under this review.
Specialist packages remain proposals until measured in simulation.
See [measured results and remaining work](air-enhancement-results.md); the
natural-match and full capacity acceptance criteria are not all satisfied.

Owner observation that started this work: *fighters fly with the bombers as
intended, but bombers accumulate too slowly and the wave and formation
patterns are weak.* The review confirms both and finds the causes.

Sources. Every claim about our code cites `file:line`. Game and engine
facts cite the shared knowledge base: [17-air-mechanics.md], [38-air-roster.md],
[63-air-tactics.md] and [78-air-pvp-meta.md] in `../rjm.bar.docs/knowledge/`.
Those pages cite the BAR (`1d267c20d1`) and Recoil
(`2026.07.01-84-g92efda5e60`) sources. Meta claims cite official BAR guides.
Each claim carries a confidence label:

- **[data]**: read from code or unit definitions.
- **[derived]**: calculated from data.
- **[community]**: a guide or community source.
- **[judgement]**: reasoned opinion that must be checked by playtest.

[17-air-mechanics.md]: ../../rjm.bar.docs/knowledge/10-engine/17-air-mechanics.md
[38-air-roster.md]: ../../rjm.bar.docs/knowledge/30-units/38-air-roster.md
[63-air-tactics.md]: ../../rjm.bar.docs/knowledge/60-tactics/63-air-tactics.md
[78-air-pvp-meta.md]: ../../rjm.bar.docs/knowledge/70-strategy/78-air-pvp-meta.md

## Contents

1. [Executive summary](#1-executive-summary)
2. [Diagnosis: why bombers trickle and waves are weak](#2-diagnosis)
3. [Ground truth: the mechanics that decide air battles](#3-ground-truth)
4. [Doctrine, mapped to this game](#4-doctrine)
5. [The situation model: input variables](#5-situation-model)
6. [Best use of every combat aircraft](#6-aircraft-use-cases)
7. [Production and accumulation](#7-production)
8. [Deterministic wave growth](#8-wave-growth)
9. [The strike package](#9-strike-package)
10. [Formations](#10-formations)
11. [Targeting](#11-targeting)
12. [Navigation: ingress, deep strike, egress, abort](#12-navigation)
13. [ISR: scout waves and radar-plane waves](#13-isr)
14. [Fighters: counter-air, CAP, sweep, escort](#14-fighters)
15. [Mission catalogue and decision matrix](#15-missions)
16. [Implementation roadmap](#16-roadmap)
17. [Validation and benchmarks](#17-validation)
18. [Risks and open questions](#18-risks)
19. [Appendix A: anti-air reference](#appendix-a)
20. [Appendix B: bomber passes per target](#appendix-b)
21. [Appendix C: references](#appendix-c)

---

<a id="1-executive-summary"></a>
## 1. Executive summary

**What is wrong.**
- Bomber accumulation is throttled by production policy and energy availability.
  - KI-442 recorded 8,094 of 8,100 metal banked while the bomber hold sat unfilled.
  - The natural 60-minute Armada game built 121 T2 fighters and 24 T2 bombers, and
    no bomber damage was captured (`doc/benchmarks/air-management.md:92-94`).
  - That archived natural run did not demonstrate a wave; this is not evidence
    that no natural wave has ever launched. Later economy fixes require a fresh baseline.
- Waves are weak because the formation is a single unbounded line:
  - it is aimed at our own army;
  - it has no speed matching, no time-on-target and no route planning;
  - target choice ignores anti-air and kill feasibility.

**What to build**, in order of leverage:

1. **Unblock production** (script and JSON only, days of work):
   - Give strikes bounded production turns when home defense and construction needs permit.
   - Size the home fighter quota from the *armed* enemy air only.
   - Stop counting enemy scouts and air constructors as "intrusions" that veto strikes.
   - Fix the double counting in `EnemyAir()`.
   - Fix the survival bug that inflates every later wave.
   - Fund energy and support for additional T2 plants while preserving twenty
     completed turrets per existing T2 lab.
2. **Make wave size a deterministic schedule** that grows with game time and
   production capacity. It is floored by what the target needs (kill mass) and what
   the defence takes (saturation). A launch fires on a fixed cadence instead of
   waiting for an income floor of 50 bombers per +100 metal.
3. **Replace "a wave" with a strike package.** Its elements are:
   - reconnaissance;
   - suppression of enemy air defence (SEAD): anti-air drain, EMP stun or kill;
   - fighter sweep and escort;
   - strikers;
   - a re-strike reserve.

   Proposed elements require measured stun duration and actual release timing.
   A Stiletto does not guarantee a universal 20-second window; this specialist
   package is not part of the implemented ordinary-bomber controller.
4. **Choose targets as a system, not as a cost list.**
   - Energy (AFUS, fusion), metal (T2 mex, converters) and production (labs, nanos)
     are the critical nodes.
   - Score value per bomber-pass after expected losses. Include chain explosions.
   - Allocate exactly the bombs each target needs.
   - Assess damage and re-strike.
5. **Route by threat.**
   - Score the bearing of each sortie by the anti-air exposure it integrates along the
     route.
   - Prefer map-edge corridors for deep strikes "behind the lines".
   - Fly egress straight on.
   - Abort on predefined loss criteria.
6. **Formation by threat type.**
   - Spread at least 180 elmos against flak.
   - A box of ranks with a bounded front.
   - Slots assigned by nearest unit.
   - Arrive as a line, not parked on a stand-off point.
7. **ISR.** Early, waves of 2-4 scouts on separate routes. Late, a standing
   radar-plane orbit and radar-plane sweeps that refresh the team's picture of
   enemy anti-air and economy before every package.
8. **Fix aircraft states.**
   - Fighters to Fly.
   - Wave bombers on hold fire until the run.
   - Preserve static AA fire behavior. Return-fire alone would suppress useful
     defense without an explicit target controller.

   An AI receives none of the LuaUI defaults that human players get.

**Expected result [judgement].** On a natural game, the first wave launches about 3
minutes after the second T2 bomber batch starts (8-12 T2 bombers rather than 50).
Waves may grow toward 40-80 when funded. Each package estimates exposure and
kill feasibility; hidden threats and execution uncertainty prevent guaranteed
success. A wave is launched only against a target whose estimated kill
requirement plus predicted losses is covered with margin. Otherwise it waits, or
picks a softer target from the same system.

---

<a id="2-diagnosis"></a>
## 2. Diagnosis: why bombers trickle and waves are weak

### 2.1 Accumulation

| # | Cause | Evidence | Effect |
| --- | --- | --- | --- |
| A1 | **The fighter home quota comes first and is huge** | `HomeTarget = max(6, min(60, max(0.5 x metal income, enemyAir/fighterCost x 1.1)))` (`data/script/src/manager/air_economy.as:113-120`; `global.as` `HomeFightersPerMetal 0.5`, `HomeFighterCeiling 60`). The T2 plant fills it before any bomber (`air_production.as:97-114` before `:141-154`). Escorts committed elsewhere are added on top (`production_math.as:94-98`). | At +120 metal income the plant must hold 60 fighters at home before it builds a bomber. |
| A2 | **Any enemy aircraft on our half of the map vetoes strike production** | `StrikeReady` requires `!intrusion` (`production_math.as:3-7`). Intrusion sums every observed enemy flier in "friendly" territory (`air_screen.as:35-41`), which `AirHome::Friendly` defines as half the map (`air_home.as:32-41`). The native contact list includes scouts, constructors and transports (`BattleAnalysis.cpp:584-592`). | One passing enemy Blink stops bomber production. |
| A3 | **Enemy air is counted twice and includes non-combatants** | `EnemyAir() = cost("air") + cost("bomber")` (`air_economy.as:112`). The `air` role is on constructors and transports. Bombers carry both tags. | Inflates both A1 and the strike gate of 1.25 x enemy air (`StrikeControlRatio`). |
| A4 | **Income floor blocks every launch** | `Required() = max(nextWaveSize, floor(income/100) x 50)`, capped at 300 (`air_waves.as:217-232`). The time-out still requires `bombers >= required` (`air_waves.as:427-428`). | At +140 metal income, 24 held bombers can never launch. |
| A5 | **Survival is measured wrongly** | Bombers back from a run are deleted from `waveBombers` (`air_waves.as:199-210`) before `_EvaluateLastWave` counts survivors 120 s after launch (`:516-520`). | Survivors look like losses, growth goes to x2.0, and the next wave takes longer. |
| A6 | **Waves only ever grow** | Growth is never below x1.25, with a floor of 20 and a cap of 300 (`air_waves.as:540-563`). | The time between waves grows geometrically. |
| A7 | **Expansion needs completed support and energy** | Each new T2 lab needs 20 completed nanos on every existing T2 lab (`air_build.as:250-257`; `T2ExpansionSupport = 20`, comment "banked metal cannot bypass"). | Those 31-37 minute T2 timings are historical, superseded by later 10-20 minute results; a fresh matched baseline is required. |
| A8 | **Held bombers bleed** | Held units sit in `CDefendTask` (`air_waves.as:347-358`), which engages inside defend influence and, with no target, falls back to the **front** (`DefendTask.cpp:190-193, 351-372`). | Bombers die in ones and twos before a wave exists. |
| A9 | **One bomber type per side** | `GetT2WaveBomberForSide` builds only `armpnix`/`corhurc`/`legphoenix` (`unit_helpers.as:984-990`). | No Stiletto SEAD, no Liche decapitation, no Wildfire. |
| A10 | **T1 bombers trickle by design** | Native `CBombTask` is created per bomber with no hold (`MilitaryManager.cpp:831-834`). Merging requires being within 1000 elmos (`BombTask.cpp:46-64`). The script caps live T1 bombers at income/8 (max 12) (`air_production.as:117-135`). | T1 bombers arrive one at a time and die one at a time. |
| A11 | **Fighters are the fallback product** | The last branch builds one more fighter without a ceiling (`air_production.as:168-171`). | Surplus capacity becomes fighters, not bombers. |

### 2.2 Wave and formation

| # | Weakness | Evidence |
| --- | --- | --- |
| F1 | The line width is unbounded: slot k sits at plus or minus k/2 x 96 elmos (`AirWaveTask.cpp:259-263`). 50 bombers make a 4,800-elmo front; overflow at 300 stacks on the map edge. | the carpet is diluted over unrelated anti-air |
| F2 | Lane spacing is 96 elmos (`WaveLaneSpacing`), but a flak burst has a 172-elmo diameter with edge effectiveness 1.0. **One flak shell can hit two adjacent lanes at full damage** (Appendix A). | the formation is flak-vulnerable |
| F3 | No speed matching. `CmdWantedSpeed` is commented out (`src/circuit/unit/CircuitUnit.cpp:318-323`). BAR's wanted-speed gadget command id is itself commented out (`luarules/gadgets/unit_wanted_speed.lua:24-28`), so no engine-side path exists. Plane squads never regroup (`SquadTask.cpp:251`). | groups string out |
| F4 | Forming means "75 % within 128 elmos of a slot", for planes that cannot hover (`AirWaveTask.cpp:361-385`). The 45 s time-out usually launches the run. | ragged lines |
| F5 | Slots follow arrival order (`AirWaveTask.cpp:74`); units cross each other while forming. | slow forming |
| F6 | Ingress is a straight `CmdMoveTo` from base to slot (`AirWaveTask.cpp:317`). The "smart bearing" samples only the stand-off point and the halfway point (`:195-223`). | the wave can cross the whole enemy defence to reach a quiet stand-off |
| F7 | The CARPET aim is **our own strongest squad's leader** (`MilitaryManager.cpp:1864-1880`, via `_FrontAim`, `air_waves.as:263-292`). CARPET has the highest weight, 3 (`WaveWeightCarpet`). | bombs fall on the ground war and near our own units |
| F8 | The method is a weighted random draw (`air_waves.as:296-345`), not chosen by situation. | FEINT and PINCER fire when they make no sense |
| F9 | STRIKE puts the whole wave on one unit (`AirWaveTask.cpp:329`). `PickStrikeTarget` scores `cost/(1+dist/1000)` with no anti-air, health or bomb count (`:152-190`). | overkill on one building, nothing for the others |
| F10 | Escorts `Guard` individual bombers (`air_waves.as:381-396`) and engage the first enemy found (`GuardTask.cpp:84-95`). There is no forward sweep. | interceptors reach the bombers |
| F11 | Wave units never react to damage (`AirWaveTask.cpp:114-118`). There is no abort, no egress plan, and the mop-up `CBombTask` may turn back into the anti-air (`air_waves.as:618-633`). | avoidable attrition |
| F12 | No aircraft state management. Fighters are never set to Fly. Bombers are never set to hold fire en route. The only `SetIdleMode` call is for flying mines (`MilitaryManager.cpp:110-112`). | fighters idle landed; bombers release on targets of opportunity |
| F13 | No scouting beyond one opening scout (`air_production.as:59-71`). Radar planes are never produced. `GetScoutPosition` skips any cluster covered by anti-air (`MilitaryManager.cpp:1224-1233`). | enemy anti-air and economy go stale exactly where the bombers must go |

### 2.3 What already works and should be kept

- The `CAirWaveTask` state machine and its script hooks:
  - `SetPlan`, `PickStrikeTarget`, `GetState`, `GetFormedCount`
    (`InitScript.cpp:1486-1499`).
- The native threat-aware air A\*:
  - cost `2 x airThreat` (`PathFinder.cpp:491-496`), used by `CBombTask`.
- `CBombTask` FOCUS/AREA modes with kill feasibility (`GetAlpha`, `kill_margin`),
  documented in `doc/bomber-targeting.md`.
- Escorts flying with the bombers (the owner's observation).
- The home screen and intercept geometry (INV-080, INV-093).
- Script inputs: `aiBattle.AirThreat`, `GetGroundContact*` + `IsGroundContactEconomy`,
  `EnemyCost(kind)`, `AirHeat/AirCentre`, lanes with an `L_AIR` class, `CRouteTask`.
  These cover most of the situation model in section 5 without new natives.

---

<a id="3-ground-truth"></a>
## 3. Ground truth: the mechanics that decide air battles

Each of these is a game or engine fact with a design consequence. Sources are in
[17-air-mechanics.md] unless stated.

| # | Fact | Consequence for design |
| --- | --- | --- |
| G1 | **[data] Anti-air target priority.** BAR's `unit_aa_targeting_priority.lua` multiplies priority (lower is preferred): bombers x0.1; gunships, transports and builders x1; fighters x2; unarmed scouts x100. The engine also prefers low-health, high-power targets, and re-evaluates an auto-target only every ~65 frames (2.2 s) unless the target dies or leaves range (`Weapon.cpp:717`). | Fighters cannot soak anti-air for bombers. Decoys work only through **arrival order** (the first bomber-class aircraft into range takes the locks) and through **cheap bomber-class units** (Martyr `legkam`, 65 metal, counts as a bomber). Enemy fighters also shoot our bombers first and ignore our escorts, which gives escorts free shots. |
| G2 | **[data+derived] Long-range missile anti-air inverts at distance.** Mercury and Screamer have `proximitypriority = -1` and range 2400. The engine's range factor is `dist x proximityPriority + 0.4 x range + 100` (`GameHelper.cpp:744`), which is negative beyond about 1060 elmos. Targets are sorted ascending (`:784`). Beyond 1060 elmos the gadget multipliers therefore invert: x100 scouts and x2 fighters become *preferred* over x0.1 bombers. The stockpile is 5 missiles, 14 s and 1800 energy each. | **Drain them.** 3-5 scouts or fighters spread 1100-2400 elmos from a Mercury empty its stockpile, then the strike arrives inside the 14 s refill. The official Mercury page agrees: missiles "can be baited out by cheap air units like scouts" [community]. Verify in playtest before relying on it. |
| G3 | **[data] Flak is area fire; missile anti-air is single-target.** Flak (`armflak`/`corflak`): 250 vtol damage every 0.5 s, area-of-effect diameter 172, edge effectiveness 1.0, cylinder targeting. BAR sets `collide = false` on almost every aircraft, so blobs stack perfectly. | **Spread at least 180 elmos against flak; mass against missiles.** A stacked Stormbringer blob dies to one flak in 1.5 s. |
| G4 | **[data] Anti-air structures can only shoot `VTOL`, and every one is `EMPABLE`.** | SEAD by ground artillery, raiders, or Stiletto EMP is unopposed by the anti-air itself. One Stiletto bomb (6000 paralyse, `paralyzeOnMaxHealth`) stuns any anti-air tower for 20 s. |
| G5 | **[data] Release beats death.** Bombs already released land when the bomber dies. Kills are credited when the crash starts. Crashing aircraft are invulnerable and not shot at. | Plan against **exposure before release**. Losses on egress cost metal, not the mission. |
| G6 | **[data] Only fighters dive; bombers fly level** and release by ballistic prediction. Yaw is locked after the pass until 3 s after last fire or until past `min(1000, turnRadius x speed)`. BAR forces the bomber turn radius to 500 while idle or attacking. | A pass is a straight line. A re-strike is 10-15 s away. Egress continues along the entry heading, so the exit side of the target must also be clear. |
| G7 | **[data] Altitude barely matters to anti-air.** Missile `heightmod` is 0.2 and flak uses cylinder targeting. It matters to *our* beam weapons: Phoenix `skybeam` has `heightmod` 1. | Do not count on height for safety. Phoenix runs lose about 60 elmos of range. |
| G8 | **[data] Sensors.** Flying aircraft are seen only through air line of sight, which ignores terrain. Landed aircraft need ground line of sight. Radar is terrain-shadowed. Radar-stealth aircraft: `armhawk`, `corvamp`, `legvenator`, `armstil`, `armdfly`, `legwhisper`. Targets that are not in line of sight get a priority penalty of about x10,000. | Landing held bombers behind cover hides them. Stealth strikers stay off enemy radar until in air line of sight. Killing enemy radar before a package blinds early warning. |
| G9 | **[data] Liche (`armliche`)**: one 5625-damage bomb, radius 128, **not interceptable by anti-nukes**. BAR sets `attacksafetydistance 3000`, so it flies over its target like a bomber. | Two Liches per AFUS; one per fusion, T2 mex, anti-nuke or anti-air tower; two per commander. A Liche on an anti-nuke unlocks the team's nuke. |
| G10 | **[derived] An AFUS chain-reacts.** Its death explosion does 10,600 damage, radius 640, with linear falloff: about 7,300 at 200 elmos and 5,600 at 300. Advanced geothermal plants use the same explosion. Converter and nano fields chain on their own. | Score a target with the value of its neighbours inside the blast. A packed AFUS cluster is the most valuable bomber target in the game. |
| G11 | **[derived] Bomb-line geometry.** Five bombs in a line spaced `burstrate x speed` (Blizzard 52, Hailstorm 50, Stormbringer 62 elmos). A 4x4-6x6 building catches about 2.5-3 of the 5 bombs. | Kill counts in Appendix B are about half the "all bombs hit" figure for T1 bombers. They match the official T2 claims (3 Hailstorms or 4 Blizzards per fusion; 4-5 Hailstorms or 7-8 Blizzards per AFUS). |
| G12 | **[data] No air pads, no fuel, no repair level.** Aircraft heal only by idle auto-heal (5 hp/s after 60 s idle) or from constructors. `CMD_LAND_AT_AIRBASE` from `RetreatTask` (`RetreatTask.cpp:63-66`) has nothing to land on. | Retreat should mean "fly to a nano-covered, anti-air-covered rally point and land". Damaged survivors then heal from nanos and auto-heal. |
| G13 | **[data] An AI receives no LuaUI defaults.** Air plants stamp Land. The fighters-to-Fly and bombers-to-hold-fire defaults are LuaUI widgets. | BARb must set these states itself (F12). |
| G14 | **[community] Balance direction** (BAR patch notes, 23 July 2026): static anti-air buffed (flak range 850, reload 0.5; Chainsaw/Eradicator 1200; Ferret/SAM 950); T2 fighters nerfed "to prevent lategame fighter swarms". | SEAD and saturation matter more than raw mass. Fighter spam is less rewarded, which is one more reason to cap the home fighter quota. |

---

<a id="4-doctrine"></a>
## 4. Doctrine, mapped to this game

Military air doctrine solved this problem class decades ago. Each principle
below maps to a concrete mechanism in sections 7-15.

| Principle (source) | Idea | BARb application |
| --- | --- | --- |
| **Counterair: offensive counterair (OCA) and defensive counterair (DCA)** (USAF AFDP 3-01) | Win enough control of the air to strike. OCA = attack operations + SEAD + fighter sweep + escort. DCA = defend own airspace. | Separate fighter tasks: CAP (DCA), sweep and escort (OCA) (section 14). Gate deep strikes on local air superiority along the route, not on global "fighter value >= 1.25 x everything that flies" (A3). |
| **SEAD / DEAD** (Operation Mole Cricket 19, 1982: decoys made Syrian batteries fire, then 29 of 30 batteries were destroyed; Desert Storm opening night) | Make the defence expose and expend itself, then neutralise or destroy it, then strike. | Drain Mercury/Screamer with scouts (G2); stun with Stiletto (G4); kill low-HP anti-air (Mercury, flak, 1670-1840 HP) with 2 T2 bomber passes or a Liche; request ground artillery on anti-air from allies (G4). |
| **Strike package composition** (AFDP 3-01 / 3-03) | One mission, several elements with distinct roles and timings. | The package object in section 9. |
| **Strategic attack / target-system analysis** (Warden, *The Enemy as a System*, 1995: five rings, parallel attack) | Hit the critical nodes of the system, ideally all at once, so it cannot repair in time. | Rings for BAR: leadership = commander; organic essentials = energy and metal; infrastructure = factories, nanos, T2 constructors; population = n/a; fielded forces = army. Bombers work the inner rings; ground forces work the outer one. Strike several nodes in the same minute (parallel attack) to overload rebuilding (section 11). |
| **Concentration and the Lanchester square law** | Under aimed fire, fighting strength goes with numbers squared. | Fighter-on-fighter combat roughly obeys the square law: never feed fighters piecemeal (section 14). Against area fire (flak) it does not; dispersion wins (G3). Against point anti-air, size by saturation arithmetic (section 8.3). |
| **Saturation of defences** | Present more targets per unit time than the defence can service. | Wave size from per-anti-air kill rates times exposure time (section 8.3). Arrive simultaneously from two axes so independent anti-air picks split. |
| **Time on target (TOT)** | Elements from different origins arrive at the same instant. | Wait-gated departures computed from route length and speed, matching the official BAR advanced-mechanics advice to use Wait so several runs execute together [community]. |
| **Route planning / terrain masking** | Minimise time inside engagement envelopes. | Terrain does not mask air line of sight or anti-air (G8), so the route is masked by *distance*, not by hills. Integrate threat along the route; prefer map-edge corridors (section 12). |
| **Deception and feints** | Make the enemy commit fighters and missiles to the wrong place. | A cheap feint (T1 bombers, Martyrs, scouts) on a peripheral target 30-60 s before the main package. Draws the enemy CAP and Mercury missiles (section 9.4). |
| **Air superiority sequencing** (Big Week 1944; Schweinfurt-Regensburg 1943: unescorted deep raids took prohibitive losses) | Win the air, then go deep. | Deep strikes only with escort superiority on the route, or when no enemy fighters have been seen recently (section 12.5). |
| **ISR / persistent reconnaissance** | Know the defence before you strike it. | Scout waves early, radar-plane orbits late, a persistent anti-air map with type and last-seen time, and a recon pass before every package (section 13). |
| **OODA loop** (Boyd) | Cycle faster than the opponent can adapt. | Rotate axis and target type every package. Humans build anti-air where they were last hit; strike where they were not (section 12.6). |
| **Battle damage assessment and re-strike** (JP 3-60, combat assessment) | Verify effect; re-attack or retarget. | Read target health after each pass. Re-strike immediately if one more pass kills; otherwise retarget, because constructors and auto-heal repair (section 11.6). |
| **Attrition management and abort criteria** (Linebacker II 1972: B-52 losses on predictable repeated routes) | Predefine loss limits; never repeat a route. | Abort rules in section 12.7; route variation in section 12.6. |

---

<a id="5-situation-model"></a>
## 5. The situation model: input variables

All air decisions should read from one situation snapshot, refreshed every 10 s by
an `AirSituation` script module. It computes the indices below. Almost every input
already exists in script (`doc/roles/air.md`; `data/script/src/manager/lanes.as`;
`InitScript.cpp` registrations). New natives are marked **(N)**.

### 5.1 Raw inputs

| Input | Symbol | Source (existing unless N) |
| --- | --- | --- |
| Map width x height, diagonal | `W, H, D` | `AiTerrainWidth/Height/Diagonal()` |
| Base-to-enemy-start distance (nearest, mean) | `R_e` | `Lanes::EnemyStarts()`, `Lanes::ScriptStarts` |
| Land and water fraction | `f_land, f_water` | `aiTerrainMgr.GetLandPercent()`, `WaterTheatres` |
| Map type flags | land-locked, islands, ponds | `Global::Map::LandLocked`, `StrategicSites::islands`, `WaterTheatres` bodies |
| Game time (minutes) | `t` | `ai.frame / 1800` |
| Own metal and energy income (10 s minimum) | `M, E` | `Economy::GetMinMetalIncomeLast10s`, energy equivalent |
| Own T2 air plants, air build power | `n_T2, BP_air` | `AirEconomy::t2, power[]` |
| Enemy mobile army cost | `C_army` | `aiBattle.EnemyCost(LAND/HOVER/AMPH/SHIP)` |
| Enemy static economy value (seen) | `C_eco` | `GetGroundContact*` + `IsGroundContactEconomy` |
| Enemy static defence cost | `C_def` | `aiBattle.EnemyCost(STATIC_DEF)` |
| Enemy anti-air **by class** | `A_flak, A_msl, A_lr, A_mob` | **(N)** split of the cached `anti_air` role by def: flak (AoE >= 100), point missile, long range (range >= 2000: Mercury, Screamer, Xyston), mobile anti-air. Script fallback: classify `GetGroundContact*` defs by name list. |
| Enemy **armed** air value | `F_e` | fighters (`anti_air` role on fliers) + bombers + gunships, **excluding** `scout`, `builder` and `transport` roles (fixes A3) |
| Own fighter value, home and wave | `F_o` | `AirScreen::HomeValue` + wave ledger |
| Enemy air activity near a point | `heat_air(p)` | `aiBattle.AirHeat/AirCentre` |
| Anti-air threat at a point | `T(p)` | `aiBattle.AirThreat(pos)` (default layer) |
| Anti-air threat integrated along a route | `T_path(a,b)` | **(N)** `AirPathThreat(from, to, role)` (native report C11) |
| Allies' roles and starts | team | `Team::Roster`, `Lanes::AllyStarts` |

### 5.2 Derived indices

```
MapScale     S_map  = R_e / v_bomber                 seconds of flight to the enemy start
                      small  < 40 s   (R_e < ~10 000 elmos for T2 bombers at ~255 elmo/s)
                      medium 40-70 s
                      large  > 70 s
WaterIndex   I_w    = f_water, plus 1 if the enemy economy sits on islands or offshore
AirControl   I_ac   = F_o / max(1, F_e)                  global; and locally I_ac(route)
AADensity    I_aa   = (A_flak + A_msl + A_lr) / max(1, C_eco)   metal of anti-air per metal of economy
FlakShare    I_fl   = A_flak / max(1, A_flak + A_msl + A_lr)
LongRangeAA  I_lr   = A_lr / max(1, A_flak + A_msl + A_lr)
ArmyPressure I_ap   = C_army / max(1, own mobile cost)
EcoExposure  I_ex   = sum over eco targets of value(x) x [T(x) < T_soft] / C_eco
                      share of enemy economy that is softly defended
Phase        P      = OPENING (t < 6), T1 (no own T2 air plant), T2, LATE (t >= 30 or E >= 6000)
Production   rate_b = bombers per minute the air plants can build at current funding
                      = sum over T2 plants of BP_plant x 60 / bomberBuildTime, limited by M and E
```

**Why these variables** [judgement, grounded in G1-G14]:

- **`S_map`** sets the decision cycle. On small maps, packages arrive before the enemy
  reacts, so smaller and more frequent strikes win (OODA). On large maps transit is
  expensive, so fewer, larger packages win (mass). It also sets the scout cadence.
- **`I_w`** selects torpedo aircraft and seaplanes (section 6) and naval targets.
- **`I_ac`** gates deep strikes (air superiority sequencing) and sizes escorts.
- **`I_aa`, `I_fl`, `I_lr`** select the SEAD method and the formation spacing:
  - flak means spread;
  - missiles mean mass;
  - long-range anti-air means drain first.
- **`I_ap`** says whether bombers should support the ground war (interdiction) or go
  for the economy (strategic attack). When our ground side is losing, `I_ap > 1.3`,
  interdiction pays first.
- **`I_ex`** says whether soft economic targets exist, which is the cheapest
  strategic attack.
- **`P`** and **`rate_b`** drive the deterministic wave schedule (section 8).

---

<a id="6-aircraft-use-cases"></a>
## 6. Best use of every combat aircraft

Unit data is in [38-air-roster.md]; the arithmetic is in Appendix B. "Avoid" lists the
cases where the unit is wasted. Each "best use" is a mission from section 15.

### 6.1 Bombers

| Unit | Best use | Targets | Avoid | Notes |
| --- | --- | --- | --- | --- |
| `armthund` Stormbringer / `corshad` Whirlwind (T1, 150 metal) | **Early economic raids** (wind fields, solars, T1 mexes, nanos, converters, radar) in waves of 6-12. Also the **lead decoy** element of T2 packages (bomber-class priority, cheap). | 1 per grouped wind, 2 per solar, 5 per advanced solar, 15-20 per T2 lab [community, official Early Air Raids guide] | Fusion and AFUS (13 and 27 passes); anything under flak | Must fly as a group (A10). Assume only one effective pass per sortie [community]. |
| `armpnix` Blizzard / `corhurc` Hailstorm (T2 main bombers) | **Strategic attack** on fusion, AFUS, T2 mex, anti-nukes, factories; **SEAD** on Mercury/Screamer/flak (2 passes); **interdiction** of armour columns | fusion 4 / 3-4; AFUS 7 / 6 (Appendix B) | Unescorted into an enemy fighter CAP; Chainsaw/Eradicator clusters (4450 HP each, 4-5 passes) | The backbone of every package. Hailstorm is better per pass, Blizzard faster. |
| `legphoenix` Phoenix (Legion T2) | Like Hailstorm, plus it **can sweep a line of statics**: the beam fires every frame for 2.17 s at 145 damage, about 9,400 damage per pass in theory | fusion, defensive lines | Long anti-air exposure (the beam needs dwell time) | **[judgement]** Measure single-pass damage in playtest before sizing. Height costs about 60 elmos of range (G7). |
| `armstil` Stiletto (EMP, radar stealth, 460 metal) | **SEAD stun**: one bomb stuns any anti-air tower for 20 s. **Economy freeze**: a stunned AFUS stops producing. Also stuns a defensive line just before a ground push. | anti-air clusters ahead of the strikers; AFUS (2 bombs) | Being treated as a damage dealer (A1 native: paralyse alpha is counted as kill damage in `GetAlpha`) | Leads the package by 3-6 s. Never in the same lanes as strikers if friendly ground units are under the run. |
| `armliche` Liche (atomic, 2200 metal) | **Decapitation and high-value point kills**: commander (2 bombs), AFUS (2), fusion / anti-nuke / silo / anti-air (1). Bomb not interceptable. | the inner rings | Long-range missile anti-air zones without drain or stun first (official tip) | Fly as a pair. Pair with Mercury drain (G2) or a Stiletto stun. Do not mix into carpets. |
| `legnap` Wildfire (not in standard menus) | Area denial of massed mobiles (fire pools) | moving armies | Buildings | Only if enabled. |
| `legmineb` Harbinger | **Mine the enemy's expansion routes and mex fields** | enemy constructor paths, re-expansion spots | Defended areas | Stockpiled; one drop per 10 s. |
| `legkam` Martyr (65 metal kamikaze) | **Lead decoy** (counts as a bomber for anti-air priority, x0.1) and cheap spotter (spawns `legvision`) | first into anti-air range | Mass strikes | The cheapest anti-air lock absorber in the game. |
| `legcib` Blindfold | **Anti-mine and counter-intel**: mini Juno pulse | minefields, Juno-relevant structures | | Clears paths for ground pushes. |
| `armsb` Tsunami, `corsb` Dam Buster, `legspbomber` Pyrphoros (seaplane bombers) | Naval or island maps (`I_w` high): shipyards, naval economy, groups of ships | spread targets (shotgun bombs) | Single buildings (about 50 % hits) | Built at seaplane platforms. |

### 6.2 Torpedo aircraft

| Unit | Best use | Avoid |
| --- | --- | --- |
| `armlance`, `cortitan` (1200 damage), `legatorpbomber` | **Naval interdiction**: capital ships, submarines, naval factories, tidal fields. Exempt from BAR's area-attack limiter (`areaattack_unlimited`). | Any land target (x0.2 damage, `land_damage_mult`) |
| `armseap`, `corseap`, `legsptorpgunship` | Persistent anti-submarine patrol over our own sea lanes | Deep strikes |

Use only when `I_w` is high or enemy naval value is significant (`EnemyCost(SHIP/SUB)`).

### 6.3 Gunships

| Unit | Best use | Avoid |
| --- | --- | --- |
| `armkam` Banshee, `legmos` Mosquito (T1) | **Constructor and mex hunting**: 6 Banshees kill undefended mexes, 15 penetrate light anti-air [community]. "Destroy the anti-air first; your next priority is always their constructors." | flak (it kills gunship groups); any T2 anti-air |
| `corbw` Shuriken (EMP gunship) | Stun ground units about 1:1 ahead of a ground push; pull back before anti-air arrives [community] | anti-air (aircraft are never EMPABLE, so it cannot fight air) |
| `armbrawl` Roughneck, `corape` Wasp, `armsaber`, `corcut`, `legspsurfacegunship` | **Close air support** for the ground war (`I_ap > 1`): kill raiders and artillery; SEAD only on T1 towers | flak and Chainsaw (Roughneck's 380 range is inside flak's 850) |
| `armblade` Hornet | Anti-armour strikes on T2/T3 heavies | dense anti-air |
| `corcrwh` Dragon, `legfort` Tyrannus (T3 flying fortresses, about 5,000 metal) | **Siege anchors**: hover over a contested area with escorts; self-defending against air (Dragon missiles, Tyrannus starbursts). They keep collision on, so they can be bumped. | being sent alone into Mercury or Xyston coverage |
| `armdfly` Abductor | EMP plus transport; stealthy insertion | |
| `legspcarrier` Hecatoncheir | Drone screen over naval or island fronts | |

**[judgement]** Gunships are tactical, not strategic: they belong to the ground war
and to constructor hunting. They should be produced under the ground-support budget
(section 7.3), never at the expense of the bomber share.

### 6.4 Fighters

| Unit | Role |
| --- | --- |
| `armfig`, `corveng`, `legfig` (T1) | Opening CAP; scout killers. `legfig` also has sight 700 and radar 400, so it is Legion's air scout. |
| `armhawk`, `corvamp`, `legvenator` (T2, radar stealth), `legafigdef` | Sweep, escort, CAP. `legvenator` has a 100-AoE birdshot: excellent against enemy bomber stacks. |
| `armsfig`, `corsfig`, `legspfighter` | Seaplane-platform fighters for naval maps |

### 6.5 Scouts and radar planes

| Unit | Role |
| --- | --- |
| `armpeep`, `corfink` (sight 835-865, radar 1120-1140, `LIGHTAIRSCOUT`) | Scout waves; Mercury drain; pre-strike recon. **They never crash**, so they die instantly and leave no debris. |
| `armsehak`, `corhunt`, `legspradarsonarplane` (radar 2200-2250, sonar 900) | Naval and mid-game radar sweeps |
| `armawac`, `corawac`, `legwhisper` (sight 1250-1275, radar 2400-2500, sonar 1200; Whisper is radar-stealthy) | Late-game radar orbit and radar-plane sweeps for the team (section 13) |

---

<a id="7-production"></a>
## 7. Production and accumulation

Goal: once AIR has a T2 plant and is not losing the air war, a **guaranteed,
deterministic fraction** of T2 production goes to bombers. Surplus metal becomes
more bombers and more T2 plants, not more fighters.

### 7.1 Fix the enemy-air metric (A3)

```
EnemyArmedAir = cost(roles fighter/anti_air on fliers) + cost(bomber) + cost(gunship roles on fliers)
                - (do not count) scout, builder, transport
```

Implementation:
- Script: iterate the cached enemy contacts by def, de-duplicated by unit.
- Native, preferred: `aiBattle.EnemyCost(AIR_ARMED)` **(N)**, beside `EnemyCost(AIR)`.

Use it everywhere `EnemyAir()` is used today: `HomeTarget`, `StrikeReady`,
`FightersFor`, and the dynamic quotas.

Also fix `armthund` in `behaviour.json`. Its roles include `static` and `anti_air`,
with air threat 1. This makes enemy Stormbringers count as anti-air and as air
threat. Change it to `["bomber", "air"]` with air threat 0 and surface threat 1; do not erase its lethal surface threat.

### 7.2 Replace the intrusion veto (A2)

Use unique **armed** observed air contacts. Unarmed scouts, constructors and
transports remain intercept targets but do not suppress strikes. An armed
intrusion raises the local defense requirement in proportion to its value.
A serious home defense deficit takes precedence for as long as it persists;
a blind 30-second expiry would abandon the core during a sustained attack.
Metal value is a bounded heuristic, not a matchup or DPS prediction.

### 7.3 Production allocation instead of a fighter-first queue (A1, A11)

Use ten successful combat orders per factory as the deterministic cycle.
Constructors, scouts and requested transports do not consume strike turns.
After emergency defense and required construction crews, reserve six strike
turns against no observed armed air, three at parity, and zero while available
fighter value is below observed armed-air value. This is **order allocation**,
not metal/energy allocation: bomber and fighter costs differ considerably.
The original equations and their 70/45/30 percent examples did not agree.

Home demand uses `clamp(6, 60, ceil(1.2 * enemyArmedValue / fighterCost))`.
There is no income term and no unsupported reduction to a ceiling of 25.
Credit other-tier fighters by their value. Home fighters, held escorts and
active escorts have distinct ownership; only available defense counts for
emergencies. Strike turns with no eligible demand fall back to air control.
T1 support and bomber selection alternate within these strike turns, without
adding a second independent modulo cycle that could starve bomber orders.

### 7.4 Retain twenty completed turrets per existing T2 lab (A7)

**Decision: preserve D-155.** Neither banked metal nor a bomber shortfall
bypasses the owner's twenty-turret requirement. Add bays only when their
existing income/resource gates and support requirements pass. The proposed
float bypass is rejected for this implementation. KI-442 was energy-limited;
another unstaffed lab cannot solve missing energy. Later D-155 simulations
already demonstrated second-lab construction, invalidating the initial
claim that natural games can never acquire one.

### 7.5 Hold where it does not bleed (A8)

- Replace the `CDefendTask` hold with an **air staging task** (native report C3):
  - fly to a **staging point** on the friendly side, offset toward the planned
    bearing and inside our anti-air and nano coverage;
  - **land** there (`SetIdleMode(1)`), with no front fallback.
- Landing removes extended air-LOS visibility, but ground LOS/radar and AA
  targeting still apply. Healing and repair require their actual game conditions.
- Held fighters stay airborne on CAP instead (section 14).
- Script stopgap until the native task exists: use `CRouteTask` to a fixed staging
  point with a one-point route. Do not use `CDefendTask`.

### 7.6 T1 bombers as groups (A10)

- T1 bombers join a small T1 hold with the same staging point.
- Start **T1 raids at three reusable bombers** against feasible known soft targets; this threshold needs natural-game validation.
- Cap T1 bombers by schedule, not by `income/8` alive.
- After the first T2 plant, T1 bomber production stops. Existing T1 bombers retain their independent raid pool. Decoy coordination
  remains a proposal, not a proven use of sunk investment.
- Fix the Legion mapping: `legmos` is a gunship, not Legion's T1 bomber
  (`air_production.as:118`, `air_economy.as:127`). Legion's T1 strike unit is
  `legkam` in decoy and spotter roles, plus `legmos` gunships for constructor
  hunting.

### 7.7 Set aircraft states (F12, G13)

| Unit class | Idle mode | Fire state | Move state |
| --- | --- | --- | --- |
| Fighters (`fighter=1` customparam) | **Fly** | fire at will | maneuver on CAP; hold position for escorts |
| Wave bombers while staged | **Land** | hold fire | hold |
| Wave bombers in transit | (flying) | **hold fire** | hold |
| Wave bombers on the run | (flying) | fire at will (needed for `Fight`/area runs; explicit Attack orders fire regardless) | |
| Scouts and radar planes | Fly on orbit, land when staged | hold fire | |
| Our own Mercury/Screamer | n/a | **preserve existing fire state**; return-fire alone suppresses defense | |

This needs natives: `SetIdleMode`, and attack-ground, attack, fight and patrol orders,
registered for script (native report C12).

---

<a id="8-wave-growth"></a>
## 8. Deterministic wave growth

The owner asked for wave sizes that grow deterministically as the game
progresses. Today's sizes are deterministic but unreachable (A4-A6). The proposal
keeps them deterministic and makes them reachable: the size is a function of time
and of what the factories can build, floored by what the mission needs.

### 8.1 The three sizes

```
S_sched(t)   schedule size    what the schedule says this wave should be
S_kill(X)    kill size        bomber passes needed to kill target set X (Appendix B, with margin)
S_sat(X, R)  saturation size  bombers expected to be lost before release on route R to X (section 8.3)

Required(X, R, t) = max( S_kill(X) + S_sat(X, R),  S_sched(t) )
```

- A wave **launches** when the held bombers reach `Required`, or when the cadence
  timer fires (section 8.4).
- A cadence launch checks whether `held >= S_kill(X') + S_sat(X', R')` for **any**
  target X' in the current target list. That target is usually softer or closer.
- **A package is never launched below its own kill-plus-saturation requirement.**
  This is an estimate, never an unbeatable guarantee. Hidden AA, target motion,
  uncertain pass damage and formation errors can invalidate it.

### 8.2 The schedule (`S_sched`)

The schedule is a pure function of game state. It is reachable because it is
bounded by production rate.

```
Phase T1 raid:      S_sched = clamp(6, 12, 6 + floor((t - t_T1bomb) / 3))      grows +1 every 3 min
Phase T2:           S_sched = clamp(S0, S_max(P), S0 + g x waveIndex)
                    S0 = 8 (Blizzard/Hailstorm) or 6 (Phoenix), g = 4 per wave
Phase LATE:         S_sched = clamp(S0_late, S_max, S0_late + g_late x waveIndexLate)
                    S0_late = 24, g_late = 8
Reachability cap:   S_sched <= rate_b x H(P)
                    H = 4 min (T2), 6 min (LATE): never schedule more than
                    the plants can build inside one hold window
Hard cap:           S_max(T2) = 40, S_max(LATE) = 120   (formation and anti-air limits, section 10)
```

**Corrected funding example.** A 310-metal, 18,500-energy Hailstorm
at 60 M/s and 1,964 E/s cannot be funded from metal alone. Even allocating
65% of all energy to it yields only `1964 * .65 * 60 / 18500 = 4.14/min`,
before other aircraft. The implemented forecast uses
`min(factoryRate, metalBudget/costM, energyBudget/costE)` and includes held
bombers; its 35% strike budget is a tuning parameter, not a measured optimum.

**Implemented schedule:** first size 8, increment 4 per launch, cap 80,
240-second cadence. The cadence waives only the schedule, never minimum size,
escorts, an active cohort or target feasibility. The original phase equations
above are future alternatives, not active settings. D-045's income floor
remains in the legacy branch only. Opposing AA growth is not assumed linear.

### 8.3 Proposed saturation estimate (`S_sat`): uncalibrated, not implemented

For each anti-air unit `a` that covers route segment `R` (ingress, run, the part of
egress before release):

```
exposure_a  = path length inside a's range before release / v_bomber    (+1 s burst duration)
kills_a     = exposure_a / ttk_a(bomber)                                 (Appendix A ttk values)
              flak: x stackFactor   (1 if spacing >= 180, else bombers within 86 elmos of each other)
              Mercury/Screamer: min(stockpile_now, 5) + exposure_a / 14 s   (minus drained missiles)
              stunned by Stiletto at arrival: 0
              enemy fighters near route: F_e_local / escort-adjusted kill rate
S_sat       = ceil( (sum over a of kills_a) x 1.25 )                     25 % safety margin
```

**Worked example [derived].** A fusion with one flak and one Chainsaw beside it,
attacked by spread Blizzards:
- flak exposure 850/258 ≈ 3.3 s, at one kill per 2.5 s, gives 1.3 losses;
- Chainsaw exposure about 3.6 s after missile flight, at one kill per 2 s, gives 1.8;
- `S_sat = ceil(3.1 x 1.25) = 4`;
- `S_kill = 4 x 1.15 ≈ 5`;
- Required = 9.

Stacked aircraft face greater splash risk; the exact losses require a rendered test. Section 10 spacing
therefore matters as much as the count.

Inputs: anti-air positions and types from the ISR anti-air map (section 13.4),
`ttk` from Appendix A, and the route from section 12. Before the native
`AirPathThreat` exists, approximate exposure from `aiBattle.AirThreat` sampled every
200 elmos along the route.

### 8.4 Cadence and the hold window

- A **cadence timer** launches a package every `H_cad(P, S_map)`:
  - 3 min on small maps, 4 min on medium, 5 min on large (T2);
  - 1 minute more in LATE.
- At the timer, choose the best target the held force can beat (8.1).
- If none qualifies, hold, and send a recon pass (13.3) to refresh the anti-air map.
  New information often reveals a softer target.
- **Shrinking is allowed**: after a wave with survival above 0.8, the next `S_sat`
  estimate uses observed losses, which may be lower. The schedule index still
  advances, so the base grows monotonically.

### 8.5 Survival accounting (fix A5)

- Snapshot launched unit ids in a `launchedIds` set at `_Launch`.
- Evaluate when the run ends (`CAirWaveTask` DONE), or after 120 s.
- Count `ai.GetTeamUnit(id) != null`.
- Record per package:
  - losses before release;
  - losses after release;
  - damage dealt (target health before and after);
  - targets killed, including chain explosions.

Feed the observed per-anti-air kill rate back into `ttk` (exponential moving
average, alpha 0.3) per anti-air class. This is battle damage assessment for the
model itself.

---

<a id="9-strike-package"></a>
## 9. The strike package

A **package** replaces the single wave. It is one mission object: target set X,
route R, time on target `T0`, and elements with their own spacing, start time and
abort rules. Doctrine: AFDP 3-01 strike packages; time on target.

### 9.1 Elements

| Element | Units | Purpose | Arrives | Size rule |
| --- | --- | --- | --- | --- |
| **Recon** | 1-2 scouts or a radar plane | Refresh targets and anti-air on the route (BDA before the strike) | T0 - 60 s | 1 per 2 targets |
| **Drain** | 3-5 scouts or T1 fighters | Empty Mercury/Screamer stockpiles (G2) | T0 - 20 s, holding 1100-2400 elmos from each long-range anti-air | `min(5, stockpile)` per long-range anti-air; only if `I_lr > 0` |
| **Sweep** | T2 fighters | Clear enemy CAP on the route before the strikers arrive | T0 - 15 s, 600-900 elmos ahead on the bearing | `max(0, 1.3 x F_e_route - escort)` |
| **SEAD** | Stiletto line, or 2 T2 bomber passes per low-HP anti-air, or a request for allied artillery | Stun or kill the anti-air that covers the run | T0 - 4 s (stun lasts 20 s) | 1 Stiletto bomb per anti-air tower within 1200 elmos of the run, 2 per AFUS if freezing |
| **Lead / decoy** | T1 bombers or Martyrs | Take the first anti-air locks (G1 stickiness) | T0 - 2 s, 200 elmos ahead | 10-20 % of strikers, or as available |
| **Strikers** | T2 bombers, Liche pairs | Destroy target set X | T0 | `S_kill + S_sat` |
| **Escort** | T2 fighters | Kill interceptors that reach the strikers; enemy fighters prioritise bombers (G1), so escorts get free shots | with the strikers, 300-600 elmos behind and above | `ceil(1.0 x F_e_route / fighterCost)`; 0 if no enemy fighters seen in 5 min |
| **Re-strike reserve** | 20-30 % of strikers, trailing | BDA follow-up: finish targets one pass short | T0 + 10-15 s | `ceil(0.25 x S_kill)` |

### 9.2 Time on target

- Every element computes its departure time as `t_depart = T0 - pathLength(R_e) / v_e
  - offset_e`, using the slowest unit of the element.
- Elements wait (staged and landed) until `t_depart`.
- This replaces speed matching, which the engine and gadget do not offer (F3), with
  *departure* matching. Planes in an element fly at nearly the same speed: +/-1 %
  jitter, and within-type speeds are identical.
- Mixed types (Blizzard 258, Liche 295, Stiletto 300 elmo/s) get per-type departure
  times.

Doctrine: time on target. Official BAR advice also uses Wait to run several
bombing runs simultaneously [community].

### 9.3 Parallel attack

- When the held force exceeds the requirement for one target by at least 2x, split
  into two or three **cells**.
- Give each cell a different target in the same target system (section 11.2), with
  the same `T0`, approaching on **different axes**.
- Each anti-air unit chooses targets independently and re-evaluates every 2.2 s, so
  two simultaneous axes divide its fire (saturation).
- The enemy must repair two nodes at once (Warden's parallel attack).

### 9.4 Feints

- A feint runs when `I_ac < 1` (we do not control the air) or a strong enemy CAP
  covers the main target.
- Send a cheap element (T1 bombers, Martyrs, or a scout wave) at a peripheral target
  on the far side of the enemy base, **45-60 s before** `T0`.
- When enemy fighters commit (`AirHeat` rises near the feint), the main package's
  sweep and strikers depart.

This replaces today's FEINT mode, which holds the main wave visibly at the stand-off
for 25 s (`WaveFeintHoldSeconds`) and invites interception [judgement].

---

<a id="10-formations"></a>
## 10. Formations

### 10.1 Spacing by threat type (G3)

```
lane spacing   = 180 elmos if the route or target has flak (I_fl > 0.2 locally), else 110
rank spacing   = 220 elmos (time separation ≈ 0.85 s at 258 elmo/s)
stack          = only against missile-only defence with no flak and no Venator present
```

- **Why 180:** flak's 172-elmo diameter with edge 1.0 means two bombers less than
  172 apart can both take a full hit. At 180 every shell kills at most one.
- **Why not wider:** the bomb line from each bomber is about 200-250 elmos long
  along-track (5 bombs at 50-62 spacing). Lateral width only needs to cover the
  target set.
- **Why ranks:** depth limits the front width. Ranks arriving 0.85 s apart also
  re-trigger anti-air target evaluation. The 2.2 s stickiness keeps anti-air on the
  first rank while the later ranks release (G1).

### 10.2 The box

```
cols  = min(n, max(3, ceil(targetFrontWidth / laneSpacing)))   targetFrontWidth = target-set width + 2 x 120
ranks = ceil(n / cols)
front width <= 1500 elmos (hard cap), depth = ranks x rankSpacing
```

**Assignment.**
- Greedy nearest-slot assignment after `ComputeLines` (Hungarian matching if
  affordable).
- Re-compact when a unit dies.
- Fixes F1 and F5 (native report C4).

### 10.3 Arrive as a line, not park on a point (F4)

- Planes cannot hover. "Formed within 128 elmos of a slot" makes them orbit.
- Replace forming-at-stand-off with **in-motion forming**:
  - each unit gets a **gate point**: its slot projected 1800-2500 elmos back along
    the run line, inside our own or neutral airspace;
  - with a gate time: `T0 - (gate-to-target distance / v)`;
  - units fly to their gate with departure timing (9.2) and pass through it at the
    gate time.
- The formation is created by geometry and timing, not by waiting.
- The forming check becomes "units within 300 elmos of their *moving* expected
  position". If a unit is late by more than 5 s, it drops to the re-strike reserve.

### 10.4 Run geometry

- **Approach perpendicular to the target set's long axis.** A bomb line laid
  perpendicular across a row of buildings hits more of them [community: advanced
  mechanics guide]. For a single building, approach along its long axis.
- **For a point target**, aim each column's centre bomb at the building centre:
  - 1 column per target for up to `S_kill` bombers;
  - excess bombers retarget (section 11.5).
- **Exit**: continue straight for at least 900 elmos (yaw lock, G6), then turn
  toward the **lowest-threat** egress point (section 12.4).

### 10.5 Fighters in formation

- **Escort**: a loose box 300-600 elmos behind and 50-100 elmos above the strikers,
  with Fly state set and move state hold.
- Escorts pick targets by **threat to the package**: enemy fighters within 1200 of
  any striker, weighted by cost divided by distance to the nearest striker.
- They do not pick by "first enemy found" (F10).
- **Sweep**: line abreast 600-900 elmos ahead, timed (9.1).

---

<a id="11-targeting"></a>
## 11. Targeting

### 11.1 Target classes and weights (target-system analysis)

| Ring | Class | Examples | Weight w |
| --- | --- | --- | --- |
| Leadership | Commander | `armcom`, `corcom`, `legcom` | 3.0, Liche only, or when isolated |
| Essentials: energy | AFUS, advanced geothermal, fusion | `armafus`, `armageo`, `armfus` | 2.5 / 2.5 / 2.0 |
| Essentials: metal | T2 mex, advanced converters, converter fields | `armmoho`, `armmmkr` | 1.8 / 1.6 |
| Strategic | Anti-nuke (when our team has a nuke), nuke silo, long-range artillery | `armamd`, `armsilo` | 2.2 / 2.5 / 2.0 |
| Infrastructure | T2/T3 factories, nano fields, T2 constructors | `armaap`, `armnanotc` | 1.5 / 1.3 / 1.5 |
| Sensors | radar, Pinpointer, jammer (only as SEAD prep) | `armrad`, `armtarg` | 1.0, or 2.0 within 1500 of a planned target |
| Air defence | flak, Mercury/Screamer, SAM | | as SEAD only: value = the expected losses it would cause to the package |
| Fielded forces | armour columns, artillery groups | | 1.0 (interdiction mission only) |
| Soft economy (T1) | wind fields, solars, T1 mex | | 1.2 for T1 raids |

The weights are JSON (`bomber.class_weight{}`, native report C7) so they can be
tuned without code changes.

### 11.2 Target score

```
value(x)      = w(class(x)) x cost(x)
              + sum over neighbours n within blastRadius(x) of w(n) x cost(n) x P(n dies | x dies)   (G10 chain)
              + productionLoss(x) x horizon       (income the enemy loses until rebuilt; energy at 1/60 metal)
passes(x)     = ceil(health(x) x killMargin / passDamage(bomberType, footprint(x)))   (Appendix B model)
losses(x, R)  = S_sat(x, R)                                                          (section 8.3)
score(x)      = value(x) / (passes(x) + losses(x, R) x lossWeight)
              x freshness(x)           1.0 if seen in the last 3 min, 0.5 if older (radar only), 0 if unknown def
```

- **The target system is chosen first**, by situation (section 15): energy, metal,
  production, strategic or interdiction.
- **Then up to 3 nodes** within one route envelope are chosen by `score` for
  parallel attack (9.3).

### 11.3 AFUS focus (the owner's example)

- **When**: any AFUS seen, and `EcoExposure` of the AFUS cluster is acceptable.
- **Plan**:
  1. Recon confirms the AFUS position, anti-air ring and neighbours.
  2. Pick the AFUS with the **most neighbour value inside 640 elmos** (chain).
  3. Route via the lowest-threat corridor (12.2), usually the map edge, entering from
     the enemy's rear, where the economy sits and front-line anti-air does not.
  4. Strikers: Hailstorm 6, Blizzard 7, Phoenix to be measured, or Liche 2, plus
     `S_sat` and 25 % margin.
  5. SEAD: Stiletto stun of the covering anti-air, or a drain if there is a Mercury.
  6. Re-strike reserve for a second AFUS within 300 elmos (at about 7,300 → 1,000 HP
     after the chain, one pass finishes it).
- **Value [derived]**: 6 Hailstorms (1,860 metal) for an AFUS (9,700 metal) is 5.2:1,
  before the chain.

### 11.4 Erasing static defence ("static clean-up" campaign)

- **When**:
  - an allied ground push is planned at a defended line (`I_ap`, lane choke with
    `C_def` high); or
  - porcupine defences block our team's front.
- **Sequence**:
  1. Recon.
  2. Stiletto stun of the anti-air in the section.
  3. Bomber carpet in ranks across the line, with lanes perpendicular to the line.
  4. Re-strike on surviving high-value turrets.
  5. **Hand-off**: request the ground push to arrive inside the 20 s stun window
     (team message; `AiSendMessage` already used by the ferry protocol).
- **Order inside the section**:
  1. anti-air;
  2. long-range plasma and artillery (they outrange the ground push);
  3. high-value turrets;
  4. cheap turrets last, or skip them; ground units handle those.

### 11.5 Damage allocation (F9)

- For each chosen target, reserve `passes(x)` bombers. Assign columns to targets in
  score order until the strikers are used up.
- Leftover bombers go to the next target in the same envelope.
- Record reserved damage on the enemy (native: `CEnemyInfo` binding, already used by
  `SetTarget`/`BindTask`) so concurrent packages do not double-book (native report
  C6).

### 11.6 Battle damage assessment and re-strike

After each pass, read target health from bombers, recon or radar line of sight:

- **Health at or below one more pass of damage**: the reserve re-strikes
  immediately, about 10-15 s later (G6).
- **Otherwise**: abandon the target and add it to the next package's list with its
  measured health. Constructors repair, and buildings auto-heal after 60 s idle.
- **Target killed**: log the kill, including chain kills, and feed the observed
  damage per pass back into `passDamage` (section 8.5).

### 11.7 What the existing code should stop doing

- **CARPET at our own army** (F7). The carpet aim must come from section 11.2 or
  from interdiction scoring, never from `GetCombatFocusPos`.
- **Random method choice** (F8). The method follows from the mission (section 15).
- **Score = cost/health in `CBombTask`** (`BombTask.cpp:378`). Replace it with the
  section 11.2 score for native T1 groups and mop-ups.

---

<a id="12-navigation"></a>
## 12. Navigation: ingress, deep strike, egress, abort

### 12.1 Route cost

```
cost(route) = sum over cells of airThreat_static(cell) x dwellTime(cell)
            + lambda_f x enemyFighterHeat(cell)            (mobile threat, discounted by escort strength)
            + lambda_l x length
```

- Use the existing air A\* (`PathFinder.cpp:491-496`), but with the air threat split
  into **static anti-air** and **mobile (fighter)** layers (native report C11). Today
  enemy fighters are baked into the static layer (`ThreatMap.cpp:383-401`), so routes
  avoid a passing fighter group as if it were a battery.
- Drop the ground line-of-sight hit test for planes (`BombTask.cpp:200`).

### 12.2 Corridor search (bearing by route, not by two samples) (F6)

- For each of 12-16 bearings around the target, compute the cheapest route from
  staging → gate → target → exit.
- Choose the bearing with the minimum `cost(route) / value captured`.
- Add a **map-edge bias** when `S_map` is medium or large: cells within 1500 elmos of
  the map border cost x0.7. Defenders rarely cover edges, and planes may overshoot
  the edge. Units more than 1800 elmos off-map are destroyed by BAR, so the route
  must keep a 600-elmo margin.

### 12.3 Deep strike behind the lines (the owner's example)

- **Precondition**:
  - `I_ac(route) >= 1`, i.e. escort fighter value at least the enemy fighter value
    seen within 2000 of the route in the last 5 minutes; or no enemy fighters seen;
  - and `cost(route) <= lossBudget`.
- **Route**:
  1. Staging (landed).
  2. Edge corridor.
  3. Turn-in point **behind** the enemy economy, at the start-position side away from
     our front.
  4. Run.
  5. Exit straight over the enemy rear and back along the edge.
- **Why it works [judgement + doctrine]**:
  - enemy anti-air concentrates on the front and around factories facing our side;
  - the rear economy (AFUS rings, converter fields) is usually defended by fewer,
    older anti-air;
  - entering from the rear also makes the egress (straight on, G6) leave the base
    instead of crossing it.

### 12.4 Egress

- Egress = straight on for at least 900 elmos, then the lowest-threat path to the
  nearest safe point: the map edge, or our staging.
- **No mop-up into anti-air**: the mop-up `CBombTask` (F11) only runs when route
  threat to the next target is at most 0.3 x the package's surviving power.
  Otherwise the bombers return to staging and land.

### 12.5 Air superiority gating

Deep strikes need local air superiority on the route. When `I_ac < 0.8`:

- run fighter sweeps first (section 14);
- strike only targets within 2500 elmos of our own anti-air or CAP (close strikes);
- keep producing at the higher fighter share (7.3).

Doctrine: Schweinfurt-Regensburg and Big Week.

### 12.6 Route and axis variation (OODA; Linebacker II lesson)

- Penalise any bearing within 30° of the last two packages' bearings (x1.3 cost).
- Rotate target classes when the enemy builds anti-air at the last struck node: a
  rise of more than 50 % in anti-air within 1500 elmos since the last strike.

### 12.7 Abort criteria (attrition management)

Abort the run and egress at once if any of these is true before release:

| Trigger | Threshold |
| --- | --- |
| Losses so far | > 35 % of strikers |
| Predicted remaining losses before release | > the striker surplus over `S_kill` |
| Enemy fighters near the package | > 1.5 x escort value |
| Target gone | the target is dead (retarget within the envelope if possible) |

After release, never abort (G5).

The script reads losses through the wave ledger and the target through
`GetStrikeTargetId`. The native `CAirWaveTask::OnUnitDamaged` (empty today,
F11) should feed a damage counter so abort can be decided natively within one
frame (native report C5).

---

<a id="13-isr"></a>
## 13. ISR: scout waves and radar-plane waves

Bombers need identified targets: unknown defs are never bombed, and radar-only
targeting is inaccurate (`BombTask.cpp:368-370`; [community: advanced mechanics]).
Today the AI scouts once (F13) and skips defended areas, so the bombers fly blind
exactly where it matters.

### 13.1 Early: scout waves (T1)

| Parameter | Rule |
| --- | --- |
| Units | `armpeep` / `corfink` (fast, `LIGHTAIRSCOUT`, never crash) or `legfig` for Legion |
| Wave size | 2 (small map), 3 (medium), 4 (large) |
| Cadence | every 90 s (small), 120 s (medium), 150 s (large) until T2 air; then every 180 s |
| Routes | **different** per scout: one along each map edge, one through the centre, one over the enemy's likely expansion fields. Routes come from `Lanes` waypoints (`L_AIR`) or fixed waypoint lists via `CRouteTask.SetRoute`. |
| Priority points | enemy starts; metal fields not owned by us; last strike targets; air plants; suspected anti-air |
| Survival | scouts are x100 priority for normal anti-air (G1), so they survive passing near anti-air while other aircraft are present. Alone they still die. Accept that. |
| Budget | about 3-5 % of air metal until T2 |

### 13.2 Late: radar-plane orbit and radar-plane waves

| Parameter | Rule |
| --- | --- |
| Units | `armawac` / `corawac` / `legwhisper` (radar 2400-2500, sight 1250, sonar 1200; Whisper is stealthy); `armsehak` / `corhunt` on naval maps |
| **Standing orbit** | 1-2 radar planes orbit over our front, 1200-1600 elmos behind the forward edge of our anti-air coverage. Radar range then covers about 1000-1300 elmos into enemy territory with the planes inside our umbrella. |
| **Radar-plane wave** | every 4-6 minutes in LATE (`t >= 30` or `E >= 6000`), 2-4 radar planes on spread parallel tracks, 2500 elmos apart, sweeping across the enemy half at the anti-air-free edge of the threat map. This is the "waves of radar planes to scout the map for the team" requirement. |
| Sharing | radar coverage is shared with allies by the engine. Announce sweeps to the team (`AiSendMessage`) so allied players and AIs can plan artillery and Junos. |
| Escort | when enemy fighters are seen in the last 3 minutes, attach 2-4 fighters per sweep |
| Budget | 1 radar plane per T2 plant, cap 4, plus losses |

### 13.3 Pre-strike recon pass

- **60 s before** `T0` (9.1), 1-2 scouts fly the package route and the target area
  along a minimum-threat path.
- They refresh:
  - target positions and health;
  - anti-air positions and type;
  - enemy fighter presence.
- The package plan is recomputed at `T0 - 30 s` with fresh data, and can switch
  target inside the same envelope.
- **Mercury drain** uses the same scouts (G2), holding 1100-2400 elmos from the
  long-range anti-air.

### 13.4 The anti-air map

Keep a persistent record of every enemy anti-air structure seen. It is the main
input to `S_sat` and to route choice.

**Each record holds:**
- id;
- def class: flak, point missile, long range, or pop-up `armferret` (radar-stealth,
  cloakable);
- position, range and `ttk` (Appendix A);
- last seen time;
- last known health;
- stockpile estimate for Mercury/Screamer.

**Aging rules:**
- A record older than 5 minutes keeps its position but is marked "unconfirmed".
- An unconfirmed record counts at 1.25x threat (assume upgrades), until recon
  refreshes it.
- **New anti-air near the last strike** triggers route variation (12.6).

Native support: `aiBattle` already holds ground contacts. A class filter on static
anti-air (native report C11) avoids per-frame script iteration.

---

<a id="14-fighters"></a>
## 14. Fighters: counter-air, CAP, sweep, escort

Fighters work in three pools with separate ledgers. INV-072 is kept: one fighter,
one job.

| Pool | Mission | Size | Behaviour |
| --- | --- | --- | --- |
| **CAP** (defensive counter-air) | Defend our and allied economy against bombers | `HomeTarget` (7.3), 6-25 | Patrol a line **forward of the protected assets by at least the enemy bomb-release lead** (~300-500 elmos plus the 2.2 s reaction distance), inside our anti-air umbrella. Priority: bombers > gunships > fighters > transports > scouts (doctrine and G1). Scouts get only spare attention. |
| **Sweep** (offensive counter-air) | Destroy enemy fighters before a package, or alone when `I_ac` is 0.8-1.5 | `1.3 x F_e_route` | Fly ahead on the package bearing; engage only with local superiority >= 1.3 (Lanchester square law). Never feed piecemeal: launch as one group. |
| **Escort** | Protect strikers | section 9.1 | Section 10.5 |

**Fighter rules:**

- **Fly state on** (7.7).
- **Never chase scouts into anti-air.** `CAntiAirTask` targets the nearest hittable
  flier regardless of type (`AntiAirTask.cpp:327-331`). Replace that with the
  threat-to-assets score above.
- **Group by role, not by exact def.** `AntiAirTask.cpp:47-50` joins only identical
  defs, which fragments T1 and T2 fighter groups.
- **Lure enemy fighters over our anti-air.** When enemy fighters exceed our CAP, the
  CAP retreats inside our flak and missile umbrella and fights there. The umbrella
  multiplies effective strength (square law). It does not chase out.
- **When enemy air is absent for 5+ minutes**, cut the fighter share to the floor
  (7.3) and convert surplus fighters to escorts. Do not keep building fighters
  against no air ([78-air-pvp-meta.md]).

---

<a id="15-missions"></a>
## 15. Mission catalogue and decision matrix

### 15.1 Missions

| Mission | Purpose | Package |
| --- | --- | --- |
| **M1 T1 economic raid** | Damage wind, solar, mex and constructors early | 6-12 T1 bombers (+ Banshees vs constructors), recon, route by edge |
| **M2 Strategic strike** | Kill energy or metal nodes (AFUS, fusion, T2 mex) | full package (section 9) |
| **M3 Deep strike** | Strategic strike via the enemy rear, edge corridor | M2 + edge corridor + air-superiority gate (12.3) |
| **M4 Decapitation** | Commander or anti-nuke kill | 2-4 Liches + drain/stun + escort |
| **M5 SEAD / static clean-up** | Remove anti-air or a defensive line | Stiletto stun + bomber ranks + re-strike; coordinate with an allied ground push (11.4) |
| **M6 Interdiction** | Break an enemy armour push or artillery group | T2 bombers on a moving column, run along its axis; gunships for close air support |
| **M7 Naval strike** | Ships, shipyards, tidal fields | torpedo bombers + seaplane bombers |
| **M8 Sweep** | Win local air control | fighters (section 14) |
| **M9 Recon / radar sweep** | ISR | section 13 |
| **M10 Feint** | Draw CAP and missiles | cheap element (9.4) |
| **M11 Mine-laying** | Deny re-expansion | `legmineb` on enemy expansion fields |

### 15.2 Decision matrix

Evaluated at each cadence tick (8.4). The first row that matches selects the mission;
the package is then sized by section 8.

| # | Condition (situation model, section 5) | Mission | Why |
| --- | --- | --- | --- |
| 1 | Enemy armed air near our economy (intrusion, 7.2) | M8 CAP response; pause strikes up to 30 s | defend essentials first |
| 2 | `I_ac < 0.8` | M8 sweep over our anti-air; only close M2 strikes | air superiority sequencing |
| 3 | Allied front losing (`I_ap > 1.3`) and an enemy armour group within 3000 of an allied base | M6 interdiction | supporting the decisive ground fight beats a slow strategic payoff |
| 4 | Enemy commander isolated (no anti-air within 1200) or an anti-nuke covering an allied nuke target | M4 decapitation | inner ring, high value per sortie |
| 5 | AFUS or fusion seen, and `S_kill + S_sat <= held` | M2 or M3 (M3 if the front anti-air is dense and the edge route is at least 30 % cheaper) | highest value per pass; chain explosions |
| 6 | Allied ground push planned at a defended line, or `C_def` blocks the team's lane | M5 static clean-up | combined arms; stun window |
| 7 | `I_w > 0.5` and enemy naval value > 2000 | M7 naval strike | domain choice |
| 8 | Phase T1 and `I_ex > 0.3` | M1 T1 raid | soft targets early; forces enemy anti-air spend, which is itself a win [community: Basics of Air Warfare] |
| 9 | Nothing qualifies | M9 recon, then hold; add a feint (M10) if held > 1.5 x the next requirement | information first |

### 15.3 How the inputs shift the plan

| Input | Low | High |
| --- | --- | --- |
| Map size (`S_map`) | small: cadence 3 min, smaller packages, fewer feints, scouts every 90 s | large: cadence 5 min, larger packages, edge corridors, deep strikes, radar orbits matter more |
| Terrain and water (`I_w`) | land maps: no torpedo aircraft or seaplanes | water maps: seaplane platform; torpedo bombers for M7; `armsehak`/`corhunt` for sonar; island economies make M3 cheap (no ground escort needed by the enemy) |
| Enemy army cost (`I_ap`) | strategic attack (M2-M4) | interdiction (M6) and close air support gunships until the ground front stabilises |
| Enemy anti-air (`I_aa`, `I_fl`, `I_lr`) | low: bigger strikes, stack allowed, skip SEAD | flak-heavy: spacing 180, SEAD by Stiletto; long-range heavy: drain first, Liche pairs; anti-air everywhere: switch to M5 with allied ground or artillery, or to targets outside coverage |
| Enemy air presence (`I_ac`, `F_e`) | absent: fighter share at floor; escorts 0; deep strikes allowed | strong: sweep first, larger escort, close strikes only, more CAP; Venator birdshot vs enemy stacks |
| Game time (`P`) | early: scout waves, T1 raids | late: radar-plane waves, packages of 40-120, Liches, parallel attacks |
| Team role and size | 1v1: AIR is also the main scout | team games: AIR delivers ISR to allies; coordinate M5 with TECH or FRONT pushes; announce radar sweeps |

---

<a id="16-roadmap"></a>
## 16. Implementation roadmap

Repository rules apply:

- **D-076**: every behaviour fix ships an invariant, an in-game check and an
  actor-matrix row; `tools/knowledge/check_invariants.py` enforces this.
- Script changes go in `data/script/src/`.
- Native changes need script/JSON levers, per `doc/intent.md`.
- The owner deploys; changes are built and staged only.

### Reviewed decisions (the audit overrides the original proposals)

| # | Decision | Current rule | Proposal |
| --- | --- | --- | --- |
| OD-1 | Wave launch | D-045 income floor | Replaced for experimental AIR by funded cadence and feasible targets. |
| OD-2 | T2 expansion | Twenty completed turrets per existing lab | Preserved; proposed bypass rejected. |
| OD-3 | Home quota | Income term and ceiling 60 | Remove income term; retain ceiling 60 and count armed air once. |
| OD-4 | Intrusion | Any aircraft veto | Armed value deficit; no blind 30-second expiry. |

The roadmap below is retained as the proposal backlog. Completed portions,
modified acceptance criteria and remaining work are recorded in the review
and simulation results; it must not be read as a completion checklist.

### Phase 1: unblock accumulation (script, JSON and native contact queries)

| Step | Change | Files | Invariant / check |
| --- | --- | --- | --- |
| 1.1 | `EnemyArmedAir` metric; fix the `armthund` roles | `air_economy.as:112`, `air_waves.as:161`, `experimental_*/behaviour.json` | INV: scouts, builders and transports add 0 to enemy armed air |
| 1.2 | Intrusion = armed group near the core; 30 s pause | `air_screen.as:35-41`, `production_math.as:3-7` | INV: an enemy scout pass does not change strike readiness |
| 1.3 | Survival from `launchedIds` | `air_waves.as:199-210, 516-520` | INV: survivors that return early count as survivors |
| 1.4 | Production interleave with shares (7.3); new `HomeTarget`; fallback product | `air_production.as:93-171`, `air_economy.as:113-120`, `global.as` | check: bomber share >= 40 % of T2 decisions while `I_ac >= 1` |
| 1.5 | Deterministic schedule and cadence (8.2, 8.4); time-out launches at kill-plus-saturation | `air_waves.as:217-232, 413-432, 540-563` | check: first T2 wave within 6 min of the first T2 bomber, on a natural game |
| 1.6 | Staging with `CRouteTask` instead of `CDefendTask` (stopgap) | `air_waves.as:347-358` | INV: held bombers stay within 600 of staging |
| 1.7 | T1 bomber hold and raids; Legion mapping fix | `air_production.as:117-135`, `air_economy.as:127` | check: T1 raids launch as groups of at least 6 |
| 1.8 | Scout waves (13.1) via `CRouteTask` | new `air_intel.as` | check: at least 1 scout wave per cadence until T2 |
| 1.9 | Second T2 plant on float or shortfall (after OD-2) | `air_build.as:250-257` | check: second plant by T2 + 12 min on a natural game |

Expected effect: the first T2 wave launches, waves recur, and bombers no longer
bleed in the hold.

### Phase 2: natives for control (C++)

| Step | Change | Native report ref |
| --- | --- | --- |
| 2.1 | Register `SetIdleMode`, `CmdAttack`, `CmdAttackGround`, `CmdFight`, `CmdPatrol`, `CmdGuard`, `SetFireState` for script; apply 7.7 states | C12 |
| 2.2 | `CAirStageTask`: park and land at a point, no front fallback | C3 |
| 2.3 | Air threat split into static and mobile layers; `AirPathThreat(from,to,role)`; anti-air class filter on contacts | C11 |
| 2.4 | `CAirWaveTask` box formation: max front, ranks, nearest-slot assignment, expected count, gates and in-motion forming | C4 |
| 2.5 | `CAirWaveTask` route: bearing by integrated path cost, edge bias, explicit exit, abort counter in `OnUnitDamaged` | C5 |
| 2.6 | Damage allocation and enemy damage reservation; split a wave over N targets | C6 |
| 2.7 | Bomber value model: class weights, chain-explosion term, splash (KI-105), route-loss budget | C7 |
| 2.8 | `PickCarpetAim` for interdiction and economy carpets; remove `GetCombatFocusPos` from wave aim | C8 |
| 2.9 | Per-def bomber kinds (lethal / EMP / nuke) | C14 |
| 2.10 | Fighter target priority by threat to assets; role-based grouping | C10 |

### Phase 3: packages and missions (script, on top of Phase 2)

| Step | Change |
| --- | --- |
| 3.1 | `AirSituation` module (section 5) and the decision matrix (15.2) |
| 3.2 | Package object: elements, time-on-target departures, parallel cells, feints (section 9) |
| 3.3 | Anti-air map and `S_sat` (8.3, 13.4); BDA and re-strike (11.6) |
| 3.4 | Radar-plane orbit and waves (13.2); pre-strike recon (13.3); Mercury drain (G2) |
| 3.5 | Bomber mix: Stiletto SEAD element, Liche pairs, Phoenix (after measurement), Wildfire if enabled |
| 3.6 | Mission M5 hand-off to allied ground pushes (team messages) |

### Phase 4: measurement-driven tuning

- Measure in playtest with fixtures:
  - pass damage per bomber type against fusion and AFUS;
  - Phoenix single-pass damage;
  - flak kill rates against spacing 96, 180 and stacked;
  - the Mercury drain behaviour (G2).
- Replace the Appendix A and B priors with measured values.

---

<a id="17-validation"></a>
## 17. Validation and benchmarks

Use `tools/playtest/playtest.py` (separate write dir, fresh build) and the existing
air benchmark protocol (`doc/benchmarks/air-management.md`).

**Metrics per game:**

| Metric | Today (natural hard Armada) | Target after Phase 1 | Target after Phase 3 |
| --- | --- | --- | --- |
| T2 bombers built in 60 min | 24 | >= 80 | >= 150 |
| T2 fighters built in 60 min | 121 | <= 60 vs a no-air enemy | sized by enemy air |
| First T2 wave launch | never | <= T2 + 6 min | <= T2 + 5 min |
| Waves launched in 60 min | 0 | >= 6 | >= 10 |
| Bomber losses before release | n/a | <= 35 % | <= 20 % |
| Enemy metal destroyed per bomber metal lost | n/a | >= 2:1 | >= 4:1 |
| AFUS killed when present | 0 | >= 1 per 15 min of exposure | >= 1 per package targeted |
| Scout or radar coverage of enemy half (time-weighted) | one opening pass | >= 40 % | >= 70 % late |

**Fixtures to add:**
- An AFUS cluster behind flak plus Chainsaw.
- A Mercury-defended base.
- A defensive line with an allied ground push.
- An enemy fighter CAP.
- A water map with naval economy.

**Opponents:** BARb hard, BARb itself, and, if available, replays coded per
[78-air-pvp-meta.md] section 6 for meta timing checks.

---

<a id="18-risks"></a>
## 18. Risks and open questions

1. **Priority inversion (G2) is derived from code, not observed.** Verify with a
   fixture before relying on drains. If it does not hold, drains still work against
   a sticky target selection, at a higher scout cost.
2. **Pass-count model (Appendix B).** The model ignores collision-volume shape and
   release error (about +/-1 pass at T2). The 1.15 kill margin and the re-strike
   reserve absorb most of it. Measure (Phase 4).
3. **Phoenix damage** may be far above or below the bomb model. Do not size Legion
   packages until measured.
4. **Departure-time matching versus engine jitter.** Planes randomise acceleration
   and control surfaces by +/-1 % and cruise height by noise. Gate points 1800-2500
   elmos back give about 7-10 s of correction margin.
5. **Team etiquette.** Static clean-up (M5) and radar sweeps need ally coordination.
   Without a responding ally, M5 degrades to M2 on anti-air.
6. **Resource competition with TECH and FRONT.** The bomber share is an AIR-internal
   split; it does not take shared team resources. Resource sharing rules are
   unchanged.
7. **`air_rework` modoption** changes fighter and bomber numbers. Read the actual
   unit definitions at runtime (`CCircuitDef`) rather than the tables in this
   document.
8. **Owner rules.** OD-1 to OD-4 change recorded decisions. Phase 1 steps 1.4, 1.5 and
   1.9 should not start before they are decided.

---

<a id="appendix-a"></a>
## Appendix A: anti-air reference

Data are raw unit definitions (BAR `1d267c20d1`).

- **DPS** = vtol damage x burst / reload.
- **AoE** is a diameter.
- **ttk** = seconds to kill one bomber from the first shot, ignoring missile flight
  time **[derived]**: Stormbringer 670 HP, Blizzard 1130, Hailstorm 1520.

| Anti-air | Metal | HP | Range | vtol damage, AoE | vtol DPS | ttk Stormbringer / Blizzard / Hailstorm | Counter |
| --- | ---: | ---: | ---: | --- | ---: | --- | --- |
| Nettle / Thistle / Bramble (`armrl`/`corrl`/`legrl`) | 80 | 330 | 765 | 115, 48 | 68 | 10 / 17 / 22 s | ignore at T2 |
| Ferret (`armferret`, pop-up, radar-stealth, cloakable) | 330 | 1600 | 950 | 125, 16 | 208 | 3.2 / 5.4 / 7.3 | recon; stun |
| SAM (`cormadsam`) | 350 | 2500 | 950 | 90, 16 | 225 | 3.0 / 5.0 / 6.8 | mass |
| Rhapsis (`legrhapsis`) | 280 | 1900 | 950 | 6x15, 16 | 180 | 3.7 / 6.3 / 8.4 | mass |
| Chainsaw / Eradicator (`armcir`/`corerad`) | 750-800 | 4450 | 1200 | 4x250, 48 | 625 | 1.1 / 1.8 / 2.4 | **mass or bypass**; stun; tanky (4-5 T2 passes) |
| Flak (`armflak`/`corflak`) | 820-850 | 1750-1840 | 850 | 250, **172 edge 1.0** | 500 | 1.5 / 2.5 / 3.5 per **stack** | **spacing >= 180**; stun; 2 T2 passes |
| Pluto (`legflak`) | 820 | 1750 | 875 | 3x58, 44 | 1048 | 0.65 / 1.1 / 1.5 | stun first; spread |
| Lupara (`leglupara`, 2x2 footprint) | 900 | 4000 | 1125 | 2x255, 150 | 283 | 2.4 / 4 / 5.4 | hard to bomb; stun |
| Mercury / Screamer (`armmercury`/`corscreamer`) | 1600-1650 | 1670 | 2400 | 750, 425 (edge 0.75), stockpile 5, 14 s | burst 417 / sustained 54 | 1 missile per bomber | **drain (G2)**, then 2 T2 passes or 1 Liche |
| Xyston (`leglraa`) | 1600 | 1670 | 2000 | 2x700, 100 | 280 | 1 / 1 / 2 volleys (5 s) | out-range drain unclear; strike fast |
| Mobile flak Shredder / Fury (`armyork`/`corsent`) | 450-470 | 2600-2700 | 775 | 200, 140 | 273 | | spread |
| Mobile T1 anti-air bots and vehicles | 120-250 | 600-1100 | 700-760 | 37-160 | 48-120 | | ignore at T2 |
| Fighters `armhawk` / `corvamp` / `legvenator` | 110-150 | 210-370 | 690-740 | 480-750 | 500-576 | 2-3 s per bomber | escort; Venator splash (AoE 100) punishes stacks |

**Patch note (23 July 2026)**: anti-air ranges and DPS were buffed. Use runtime
`CCircuitWDef` values, not this table.

---

<a id="appendix-b"></a>
## Appendix B: bomber passes per target

Geometry model [derived]:

- bombs fall in a line spaced `burstrate x speed`, centred on the target;
- damage per bomb falls off as `(R - d)/(R - d x edge)`;
- all targets are standard armour;
- each figure is the number of passes, i.e. bombers in one run, needed to kill the
  target from full health; parenthesised figures assume every bomb hits;
- the model matches the official T2 claims (Hailstorm: 3 per fusion, 4-5 per AFUS;
  Blizzard: 4 per fusion, 7-8 per AFUS).

| Target | Metal | HP | Stormbringer | Whirlwind | Blizzard | Hailstorm | Tsunami | Liche |
| --- | ---: | ---: | --- | --- | --- | --- | --- | --- |
| AFUS `armafus` | 9700 | 8300 | 27 (16) | 25 (15) | 7 | 6 (5) | 10 | 2 |
| AFUS `corafus`/`legafus` | 9700-10500 | 9800 | 32 | 29 | 9 | 7 | 11 | 2 |
| Fusion | 3350-4000 | 3800-4600 | 13-16 | 13-16 | 4 | 3-4 | 5-6 | 1 |
| T2 mex | 620-640 | 2800-3900 | 11-15 | 11-14 | 3-4 | 2-3 | 4-6 | 1 |
| Nano | 230 | 560 | 3 | 3 | 1 | 1 | 1 | |
| Advanced converter | 370-380 | 445-560 | 2 | 2 | 1 | 1 | 1 | |
| Advanced solar | 350 | 1130 | 5 | 5 | 2 | 1 | 2 | |
| T2 air plant / T2 lab | 2600-2900 | 3750-4250 | 9-10 | 9-10 | 3-4 | 3 | 4-5 | 1 |
| Anti-nuke | 1500 | 3300 | 12 | 12 | 4 | 3 | 5 | 1 |
| Nuke silo | 8100 | 5900 | 18 | 16 | 5 | 4 | 7 | 1-2 |
| Commander (moving) | 2700 | 3700 | 15 | 15 | 5 | 3 | 7 | 2 |
| Flak | 820-850 | 1750-1840 | 7-8 | 7-8 | 2-3 | 2 | 4 | 1 |
| Chainsaw / Eradicator | 750-800 | 4450 | 17 | 16 | 5 | 4 | 6 | 1 |
| Mercury / Screamer | 1600-1650 | 1670 | 7 | 6 | 2 | 2 | 3 | 1 |

**Value per bomber metal [derived]:**
- Hailstorm vs AFUS: 5.2:1.
- Hailstorm vs fusion: about 3.9:1.
- Liche pair vs AFUS: 2.2:1, but immune to anti-nukes.
- Stormbringers vs AFUS: 2.4:1 **only** if none die before release.

That is why T1 bombers go for soft economy, and T2 for the energy core.

---

<a id="appendix-c"></a>
## Appendix C: references

**This repository** (cited by `file:line` above):
- `data/script/src/manager/air_production.as`, `air_waves.as`, `air_economy.as`,
  `air_screen.as`, `air_build.as`;
- `data/script/src/helpers/production_math.as`, `air_home.as`, `unit_helpers.as`;
- `data/script/src/global.as` (`Global::RoleSettings::Air`);
- `src/circuit/task/fighter/AirWaveTask.cpp`, `BombTask.cpp`, `SquadTask.cpp`,
  `AntiAirTask.cpp`, `GuardTask.cpp`, `DefendTask.cpp`;
- `src/circuit/module/MilitaryManager.cpp`, `src/circuit/map/ThreatMap.cpp`,
  `src/circuit/terrain/path/PathFinder.cpp`, `src/circuit/unit/CircuitUnit.cpp`;
- `doc/air-wave-attacks.md`, `doc/air-management.md`, `doc/bomber-targeting.md`,
  `doc/benchmarks/air-management.md`, `doc/decisions.md` (D-045, D-147 to D-156),
  `doc/known-issues.md` (KI-105, KI-401, KI-442).

**Shared knowledge base** (`../rjm.bar.docs/knowledge/`):
- [17-air-mechanics.md], [38-air-roster.md], [63-air-tactics.md], [78-air-pvp-meta.md];
- `26-structure-explosions-and-base-spacing.md`.

**BAR official guides and pages** [community]:
- [Early Air Raids](https://www.beyondallreason.info/guide/early-air-raids)
- [Important knowledge on advanced mechanics](https://www.beyondallreason.info/guide/important-knowledge-on-advanced-mechanics)
- [Basics of Air Warfare](https://www.beyondallreason.info/guide/basics-of-air-warfare)
- Unit pages:
  [Hailstorm](https://www.beyondallreason.info/unit/corhurc),
  [Blizzard](https://www.beyondallreason.info/unit/armpnix),
  [Liche](https://www.beyondallreason.info/unit/armliche),
  [Stiletto](https://www.beyondallreason.info/unit/armstil),
  [Mercury](https://www.beyondallreason.info/unit/armmercury),
  [Arbalest](https://www.beyondallreason.info/unit/armflak)
- [Patch notes, 23 July 2026](https://www.beyondallreason.info/microblogs/194)
- Low confidence: [How anti-air really works in BAR](https://www.crdhq.com/articles/how-anti-air-really-works-in-bar)

**Military doctrine and history:**
- USAF [AFDP 3-01 Counterair Operations](https://www.doctrine.af.mil/Doctrine-Publications/AFDP-3-01-Counterair-Ops/)
- USAF [AFDP 3-03 Counterland](https://www.doctrine.af.mil/Portals/61/documents/AFDP_3-03/3-03-AFDP-COUNTERLAND.pdf)
- [JP 3-60 Joint Targeting](https://www.justsecurity.org/wp-content/uploads/2015/06/Joint_Chiefs-Joint_Targeting_20130131.pdf)
- J. Warden, *The Enemy as a System* (1995); see
  [RAF Air and Space Power Review](https://www.raf.mod.uk/what-we-do/centre-for-air-and-space-power-studies/aspr/apr-vol14-iss1-3-pdf/)
- J. Boyd, [*A Discourse on Winning and Losing*](https://www.airuniversity.af.edu/Portals/10/AUPress/Books/B_0151_Boyd_Discourse_Winning_Losing.pdf) (Air University Press)
- Lanchester laws: [Horwood, MacKay and Price](https://www-users.york.ac.uk/~nm15/Horwood,%20MacKay%20and%20Price.pdf);
  [ASPI](https://www.aspistrategist.org.au/geek-of-the-week-frederick-lanchester-and-why-quantity-is-a-quality/)
- Operations:
  [Mole Cricket 19](https://en.wikipedia.org/wiki/Operation_Mole_Cricket_19),
  [Big Week](https://en.wikipedia.org/wiki/Big_Week),
  [Schweinfurt-Regensburg](https://en.wikipedia.org/wiki/Schweinfurt%E2%80%93Regensburg_mission),
  [Linebacker II](https://en.wikipedia.org/wiki/Operation_Linebacker_II)
