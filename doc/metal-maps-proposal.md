# Metal maps: change proposal

Date: 2026-10-02. **Status: proposed. No code, configuration or decision record has
been changed.**

This proposal comes from a read-only review of the engine (Recoil `92efda5e60`), the
game (BAR `1d267c20d1`), the Skirmish AI C++ and the AngelScript. The AI was reviewed
on branch `smrt-test` at `c4df7f63`, plus the owner's AIR work that was then
uncommitted and has since landed as `af974624`.
Three headless playtests on installed metal maps confirmed the findings.

Implementation needs owner decisions first; see [section 12](#12-owner-decisions).
Several of them are exceptions to recorded owner rules.

**The owner's request.** On metal maps:

- the AI must build metal extractors (mexes) anywhere profitable, ignoring spot indices;
- it must mass-produce mexes;
- it must never build energy converters or advanced energy converters;
- it must fit mexes into the AIR and TECH economy layouts;
- it must scale correctly for an economy where metal is abundant.

**Nothing may change on non-metal maps.**

**Labels used in this document:**

| Label | Meaning |
| --- | --- |
| [data] | read from code, unit definitions or map files |
| [derived] | arithmetic on data |
| [observed] | seen in the playtests below |
| [official] | written by the BAR developers |
| [community] | from player videos or posts; URL given |
| [judgement] | reasoned opinion, to be verified by playtest |

## Contents

1. [Executive summary](#1-executive-summary)
2. [Evidence](#2-evidence)
3. [What a metal map is (engine and game rules)](#3-what-a-metal-map-is)
4. [Root causes in BARb](#4-root-causes-in-barb)
5. [Economics and meta: the scaling laws change](#5-economics-and-meta)
6. [Design](#6-design)
7. [Change list](#7-change-list)
8. [Keeping non-metal maps unchanged](#8-keeping-non-metal-maps-unchanged)
9. [Invariants, checks and actor matrix (D-076)](#9-invariants-checks-and-actor-matrix)
10. [Validation plan and acceptance targets](#10-validation-plan-and-acceptance-targets)
11. [Rollout phases](#11-rollout-phases)
12. [Owner decisions](#12-owner-decisions)
13. [Risks and open questions](#13-risks-and-open-questions)
- Appendices: [A units](#appendix-a-extractors-and-converters), [B extraction tables](#appendix-b-extraction-tables), [C evidence files](#appendix-c-evidence-files), [D references](#appendix-d-references)

---

## 1. Executive summary

**The owner's recollection is correct.** Every mex decision in the AI, native and
scripted, is keyed by a **metal-spot index**.

On a metal map BAR publishes no spot list (`mex_count = -1`). The AI's fallback
(`src/circuit/resource/MetalManager.cpp:143-187`) then analyses the raw metal map and
finds 14,000–148,000 candidate sites. It keeps every `inc`-th site, which leaves
**80–380 spots for the whole map, plus or minus a random 25**.

| Map | Spots kept | Where a mex could legally go |
| --- | --- | --- |
| Full Metal Plate | about 240 | about 37,000 sites, at the 64-elmo pitch the footprints allow |
| Within 1,400 elmos of an AIR start | 8 | about 1,300 |

The AI can only ever build on the spots it kept, and BARb's role scripts cap
expansion further with radii and income gates tuned for normal maps.

**Six other faults stack on top:**

1. Energy converters are built on every code path (native FRONT and scripted AIR).
2. Reactor gates hold every fusion until every mex is upgraded, an expensive and wrong
   investment on these maps.
3. The script's metal-map flag is set but never read.
4. Roles on unregistered maps never include TECH in small games.
5. The economy policy assumes metal is scarce, while on metal maps **energy and
   spending capacity are the binding constraints**.
6. Several native spot-index defects (out-of-bounds writes with spot id -1) make
   "just place mexes by position" unsafe today. They affect normal maps too.

**Playtest evidence** [observed]. Default roles, 12 game minutes each:

| Map (T1 mex yield) | Mexes built | Converters | Metal income | Note |
| --- | --- | --- | --- | --- |
| Full Metal Plate (2.37 M/s) | AIR Armada **6**, AIR Cortex **2**, AIR Legion **0** | AIR Armada 7 | +23 M/s | metal everywhere |
| Nine Metal Islands (0.97–1.94) | FRONT **15** | **11** | +27.8 | bank near 0: metal-starved |
| SpeedMetal (30.6) | FRONT **7**, all upgraded | AIR Cortex: 4 | **+858**, bank pinned full from minute 5 | cannot spend: energy and build power bind |

**What to change** (all behind one native flag, `IsMetalMap()`):

1. **Detect** metal maps once, natively. The flag can only be true when
   `mex_count <= 0` *and* the raw metal layer is rich and widespread. That excludes
   no-metal maps and vein maps. Expose it to script.
2. **Place mexes by position.** Add an *extraction field* that mirrors the engine's
   real extraction (a disc of cells within the extractor radius), and a free-site
   search on a 64-elmo lattice that respects layouts, lanes and threat. Mex tasks no
   longer need an index. Keep a deterministic coarse *skeleton* of spots so the
   military, setup and energy-grid code that uses clusters keeps working.
3. **Veto all 12 converter types** natively (`SetBuildAllowed(false)`) and gate the
   script paths that lift caps.
4. **Energy-first economic policy.** Each decision builds whatever binds: energy, then
   mexes, then spending capacity (nanos and factories). The mex count follows from
   the energy that can spend its output: about 1.3 wind turbines per mex on plate
   maps, about 15 on SpeedMetal. Mohos come late, for density, not as a precondition
   for reactors.
5. **Layouts.** Mexes become filler in TECH halo bands and forward clusters, AIR
   wind-cluster gaps and eco modules (replacing converter pins), with walkable
   corridors.
6. **Register the installed metal maps** and add a metal-map default-role rule, so
   TECH and AIR actually run there.
7. **Fix the native index defects** as a separate change, if the owner agrees.

**Non-metal maps.**

- The legacy spot path stays byte-identical, including its `rand()` call.
- Every new rule is gated by the flag.
- A regression check compares the spot-list hash and benchmark metrics on Supreme
  Isthmus.
- The only ungated change proposed is the bounds-guard fix for out-of-range spot
  ids, which removes undefined behaviour that already occurs on normal maps.
  Decision OD-2 decides it separately.

---

## 2. Evidence

### 2.1 Playtests [observed]

**Set-up.**

- Build: the staged `SkirmishAI.dll` (02:14), pinned in the session scratchpad.
- Script: a snapshot of HEAD's `data/` (API parity checked; the working tree's
  `PlanAirFactoryCluster` call, then uncommitted and now in `af974624`, is not in that
  DLL).
- Profile `experimental_balanced`, BAR `test-31479-433a460`, headless, speed 20,
  12 game minutes.
- Roles were **the AI's defaults**, because none of these maps has an AI map config
  (`[Setup] StartSpots length=0`). The playtest widget records builds for team 0
  only; other teams come from AI log lines.

| Map | maxMetal / R | Team 0 role, side | Team 0 mexes (T1 / moho) | Team 0 converters | Energy builds | Metal income at 4 / 8 / 12 min | Metal bank at 12 min |
| --- | --- | --- | --- | --- | --- | --- | --- |
| SpeedMetal BAR V2 | 10 / 30 | FRONT, Armada | 7 / 7 | 0 | 97 wind, 2 fusion | +124 / +553 / **+859** | **8781 / 8900**, pinned full from about minute 5 |
| Full Metal Plate 1.7 | 7.5 / 24 | AIR, Armada | **6** / 0 | **7** `armmakr` | 46 wind | +11.5 / +20.2 / +23.2 | 922 / 1400 |
| Nine_Metal_Islands_V1 | 1.9 / 24 | FRONT, Armada | 15 / 0 | **11** `armmakr` | 14 wind, 6 advanced solar, 2 tidal, 2 solar | +10.6 / +15.5 / +27.8 | near 0 for most of the game |

**Other teams, from AI logs.**

- **Full Metal Plate**:
  - AIR Cortex ended with `mexes=2`.
  - AIR Legion ended with `mexes=0`. Its `opening.mex` rule fired three times and
    `mex.expand` twice.
  - 12 AIR converter reservations were served.
- **SpeedMetal**:
  - AIR Cortex held `mexes=4` from minute 1 to minute 3 and later, then upgraded
    all of them: 4 × 122.4 = 490, matching the logged `M=491`.
  - It sat in `T2_SUSTAIN RECOVERY`, energy-bound, with a full metal bank.
  - It reserved four eco modules with 8 converters each and built `cormakr`.

**Arithmetic check** [derived]. The incomes match the engine formula exactly:

- **SpeedMetal:** 7 mohos × 122.4 = 857 M/s, against +859 observed.
- **Full Metal Plate (AIR Armada):** 6 × 2.37 = 14.2, plus 7 converters × 1.0, plus
  the commander's 2, gives 23.2, against +23.2 observed.

The failure is therefore not the extraction model; it is how many mexes the AI
builds and what it builds instead.

**AI initialisation** took 4.4–5.7 s for the first AI on each map, which includes
script compilation [observed].

### 2.2 Offline reproduction of the native fallback [derived]

The native review ported `CMetalData::MakeResourcePoints` plus the `ParseMetalSpots`
subsampling line by line and ran it on the real SMF metal layers. Scripts are listed
in Appendix C.

| Map (size, R, maxMetal) | Analyser sites | Spots kept (offset 0 / -25 / +25) | Median spacing |
| --- | --- | --- | --- |
| Full Metal Plate 1.7 (24×24, 24, 7.5) | 147,712 | 240 / 215 / 265 | 410 elmos |
| Oort Cloud V2 (24×24, 24, 7.5) | 78,680 | 241 / 216 / 266 | 326 |
| Iron Isle V1 (24×12, 24, 1.9) | 79,948 | 151 / 124 / 174 | 351 |
| SpeedMetal BAR V2 (26×4, 30, 10) | 13,967 | 92 / 66 / 117 | 187 |

**Spots kept within a radius of the start, against legal 64-elmo mex sites on metal
land** [derived; terrain and other buildings not subtracted]:

| Start | r = 700 | r = 1,400 | r = 2,500 |
| --- | --- | --- | --- |
| Full Metal Plate (2400, 850) | 4 vs about 375 | 8 vs about 1,300 | 21 vs about 3,400 |
| SpeedMetal (700, 1024) | 11 vs about 375 | 24 vs about 975 | 27 vs about 1,125 |
| Oort Cloud (1500, 1500) | 2 vs about 220 | 9 vs about 525 | 15 vs about 1,025 |
| Iron Isle (1500, 3072) | 3 vs about 375 | 13 vs about 1,125 | 33 vs about 2,525 |

The native review quoted the site counts at a 32-elmo pitch. They are restated here
at the 64-elmo minimum pitch that the mex footprint and yardmap enforce
([section 3.2](#32-extraction-is-a-disc-and-mexes-need-64-elmos)).

The script radii explain the playtest counts:

- TECH opening: 700 elmos, capped at 3 mexes.
- AIR: 1,400 elmos.
- TECH expansion: 2,500 elmos, until +60 metal income.

### 2.3 Code facts confirmed for this proposal [data]

- **Fallback subsampling.** `MetalManager.cpp:143-187`: the `mex_count <= 0` branch,
  `mCount` formula at `:159`, random offset at `:156`, stride at `:160-167`. The
  constructor carries the upstream TODO "Add metal zone and no-metal-spots maps
  support" (`:108`).
- **Dead flag.** `eco_planner.as:204` sets `s.metalMap` from
  `ai.GetMetalSpotCount() >= EcoMetalMapSpots` (150, `global.as:667`). The field
  (`:84`) is never read.
- **Union.** `spotId` shares a union with `pointId` (`BuilderManager.h:48-51`), and
  `Enqueue` passes it straight into `CBMexTask` and `CBMexUpTask`
  (`BuilderManager.cpp:1052-1059`).
- **Out-of-bounds writes on every map.** Every script MEXUP passes spot id -1, for
  example `eco_planner.as:626`. `CBMexUpTask` calls `SetUpgradingMexSpot(-1, …)` in
  its constructor and `Finish` (`MexUpTask.cpp:33, 72`), which writes
  `mexSpots[-1].isUp` with no bounds check (`EconomyManager.h:154-155`).
- **Wrong spot reopened.** `MexTask.cpp:150` sets `spotId = 0` "to prevent spot
  opening on Cancel", but `Cancel` reopens any `spotId >= 0` (`:91`). Spot 0 is
  reopened instead.
- **Native converter branch.** `EconomyManager.cpp:1512-1530` contains a commented-out
  test of whether a converter beats a mex.
- **Engine extraction** sums the cells whose centre lies within `extractionRange`
  (`ExtractorBuilding.cpp:117-145`). `extractRange` is the map's `extractorRadius`
  for any extractor (`UnitDef.cpp:588`).
- **Footprint.** `footprintX × SPRING_FOOTPRINT_SCALE` (2) gives 64 elmos for a 4×4
  mex (`UnitDef.cpp:671`, `GlobalConstants.h:17`).
- **Default roles.** When a map has no config, the role comes from the default start
  factory: an air factory gives AIR; a land factory gives a random draw among FRONT,
  SUPPORT and TECH, with TECH allowed only when there are 5 or more enemy teams
  (`setup.as:296-318`, `helpers/role_helpers.as:12-26`). No metal map is registered
  (`maps.as:28-52`).

---

## 3. What a metal map is

### 3.1 BAR detection and what an AI can read [data]

**Detection.** BAR's spot finder (`common/upgets/api_resource_spot_finder.lua`)
calls a map a metal map in either case:

- its name is on a hard-coded list (`:32-40, 377-378`): `Oort_Cloud_V2`,
  `Asteroid_Mines_V2.1`, `Cloud9_V2`, `Iron_Isle_V1`, `Nine_Metal_Islands_V1`,
  `SpeedMetal BAR V2`;
- any 8-connected region of non-zero metal is wider or taller than
  **6 × extractorRadius** (`:241, 352-354`).

There is no coverage percentage. The list entry for Asteroid Mines V2.1 no longer
matches the installed V3, which the shape rule catches instead.

**What it publishes.** On a metal map it sets `mex_count = -1` and no spot
parameters (`:207-223`). **A map with no metal at all also gets -1.** No
`isMetalMap` rules parameter exists; the `GG` and `WG` flag is not readable by a
Skirmish AI. So an AI must tell "metal everywhere" from "no metal" by reading the
raw metal layer (`Map_getResourceMapRaw`, `Map_getMaxResource`,
`Map_getExtractorRadius`).

**False positive.** Sunderance V1.3 is a vein map (3% of cells have metal) that the
6R rule flags as a metal map. A coverage threshold keeps it on the normal path.

**Placement.** On a metal map the mex denier removes itself
(`luarules/gadgets/cmd_mex_denier.lua:38-44`), so a mex is legal on **any**
buildable square. The engine has no metal or yield check, so zero-yield mexes are
legal too. On normal maps the denier only allows mexes at "100% yield" positions on
BAR's spots.

### 3.2 Extraction is a disc, and mexes need 64 elmos [data, derived]

**One extractor's income**, in M/s:

```
I(p) = extractsMetal × maxMetal × Σ byte_c        over cells c with |centre(c) − p| < R
```

- Cells are 16×16 elmos. `maxMetal` scales each byte (`MetalMap.cpp:76-83`).
- Overlap is first come, first served, to the deepest extraction
  (`MetalMap.cpp:98-114`). The extraction map is **one global array**, so cells are
  shared across all teams.
- A 4×4 mex snaps to 16-elmo cell corners.

**Number of cells in the disc around a corner, N(R)**: R = 24 gives 4; 30 gives 12;
40 gives 16; 70 gives 60; 90 gives 96.

**Minimum spacing.** Footprint and yardmap blocking require **at least 64 elmos**
between two mex centres on one axis. Every offset of 48 elmos or less is blocked, both
at creation and with the yard open. This comes from a model of
`CGameHelper::TestBuildSquare` with the BAR yardmaps (`yard_spacing.py`). A T2
extractor fits exactly on a finished T1 one.

**Consequence for every BAR metal map (R ≤ 31).**

- Neighbouring discs never overlap at legal spacing.
- The best layout is the **densest 64-elmo lattice**.
- That reaches 25% of a plate's metal at R = 24 and 75% at R = 30. That is far more
  than any economy can use (section 5).

**Income timing.**

- An extractor credits metal only after paying its energy upkeep every half second
  (`Unit.cpp:1084-1092`): 3 E/s for a T1 mex, 20 E/s for a moho.
- **An energy stall stops mex income.**

### 3.3 Installed metal maps [data]

From a scan of all 261 installed archives with BAR's rule applied (`map_scan.csv`):

| Map | maxMetal / R | Metal cells | T1 / moho M/s per mex | Wind / tidal | Notes |
| --- | --- | --- | --- | --- | --- |
| SpeedMetal BAR V2 | 10 / 30 | 48% (byte 255) | **30.6 / 122.4** | 30 (capped to 25) / 0 | terrain speed ×2; one causeway lane |
| Full Metal Plate 1.4 / 1.5 / 1.7 | 7.5 / 24 | 100% (79) | 2.37 / 9.48 | 25 constant / 1 | 16 starts |
| Oort Cloud V2 | 7.5 / 24 | 46% | 2.37 / 9.48 | 25 / void | void between asteroids |
| Cloud9 V2 | 7.5 / 24 | 41% | 2.37 / 9.48 | 25 / void | |
| Asteroid Mines V3 | 7.5 / 24 | 29% | 2.37 / 9.48 | 25 / void | caught by the shape rule only |
| Iron Isle V1 | 1.9 / 24 | 100% | 1.94 land / 0.97 sea | 5–25 / 20 | |
| Nine Metal Islands V1 | 1.9 / 24 | 100% | 1.94 land / 0.97 sea | 5–25 / 20 | land is 11% of cells |
| Adamantium Factory V1 | 4.9 / 24 | 100% (bands) | 1.0–5.0 | 5–25 / 20 | |

For comparison, a mex on a normal map makes "between 1-3 metal per second" [official].

### 3.4 Converters [data]

BAR converts energy to metal through `game_energy_conversion.lua`. Converters run
only while energy is above 75% of storage.

| Converter | Cost | Converts | Yields |
| --- | --- | --- | --- |
| T1 (`armmakr`, `cormakr`, `legeconv`; naval `armfmkr`, `corfmkr`, `legfeconv`) | 1 M, 1,150–1,250 E | 70 E/s | 1.0 M/s |
| Advanced (`armmmkr`, `cormmkr`, `legadveconv`; naval `armuwmmm`, `coruwmmm`, `leganavaleconv`) | 370–380 M, 21,000 E | 600 E/s | 10.34 M/s |

On Full Metal Plate a T1 mex gives 2.37 M/s for 3 E/s, against 1.0 M/s for 70 E/s
from a T1 converter.

### 3.5 Why not use the engine's own spot list [derived]

On every installed metal map, `Map_getResourceMapSpotsPositions` runs into its
10,000-spot cap (`ResourceMapAnalyzer.cpp:37`):

- Spots sit 48 elmos apart, closer than one footprint.
- They are swept in row-major order, so on Full Metal Plate every spot lies in the
  top strip (z ≤ 1,272 of 12,288).
- Its "disc" for R = 24 or 30 is a 5-cell plus shape.

It is unusable here, as is CircuitAI's copy of the same analyser.

---

## 4. Root causes in BARb

Ranked by impact on the observed failure.

| # | Cause | Evidence (file:line) | Effect |
| --- | --- | --- | --- |
| R1 | **Sparse synthetic spot list.** The fallback keeps every `inc`-th of 14k–148k analyser sites, giving about 80 + 0.3125·(mapSize − 64) ± 25 spots for the whole map. There is no terrain filter (`/* CanBeBuiltAt */` is commented out at `:181-182`). | `MetalManager.cpp:143-187` | 4–24 spots within 1,400 elmos of a start, where hundreds to thousands of sites are legal |
| R2 | **Every mex decision is keyed by index.** Native `UpdateMetalTasks` picks indices through the cluster graph. The fork's `EnqueueMexWithin` walks indices inside a radius. `CBMexTask` requires `IsOpenSpot(spotId)`. | `EconomyManager.cpp:1033-1068, 1468-1510`; `MexTask.cpp:115-137` | The AI cannot place a mex anywhere else; there is no positional API |
| R3 | **Occupancy is nearest-index (Voronoi).** Any own or allied extractor closes `FindNearestSpot(pos)` with no distance limit. A cluster counts as "finished" when its count reaches its size. The easy and medium profiles cap mexes at 0.3 and 0.8 × spot count, counting **allied** mexes. | `MetalManager.cpp:288-365`; `MetalManager.h:74-76`; `easy/economy.json:79`, `medium/economy.json:79`; `EconomyManager.cpp:610-613` | In team games a human ally's mex spam closes the AI's few spots; easy and medium stop building mexes entirely |
| R4 | **Script caps were tuned for spot maps.** <br>TECH: opening 3 within 700 (`global.as:578-579`); chain at most 6 within 2,500 (`:517`); `mex.expand` only while income < 60 (`:565-566`, `tech_rules.as:178, 476`). <br>AIR: opening 3 within 700 (`air_rules.as:31-33`); `mex.expand` one order at a time within 1,400, while `metal < 80`, at most `PreFusionMexLimit` 6 before a reactor (`air_rules.as:79-84`; `global.as:975, 995`). | as cited | 3–10 mexes, then the roles stop asking |
| R5 | **The metal-map flag is dead.** It is set from synthetic spot count ≥ 150, so SpeedMetal (66–117) is never detected and a large normal map can be a false positive. Nothing reads it. | `eco_planner.as:84, 204`; `global.as:667`; `doc/eco-planner.md` describes behaviour that does not exist | no metal-map behaviour anywhere |
| R6 | **Reactor gates make mexes expensive.** <br>TECH holds fusion while any owned mex within the chain radius is T1 (`TechChain::MohosPending`, `tech_chain.as:322-335`; INV-021). The exemption is "metal full for long". <br>AIR starts no reactor until **every** owned mex is upgraded (`AirEconomy::MexesReady`, `air_economy.as:77-91`, used at `air_build.as:82, 156, 205, 346, 406, 440`, `air_growth.as:53, 62`; INV-077; D-148). Each moho costs 620 M, 7,700 E and 14,900 build time. | as cited | more mexes means a later fusion: the AI is punished for expanding |
| R7 | **Converters on every path.** There are 12 converter defs and about 17 code paths: TECH rows `energy.convert.float` and `energy.convert` (`tech_rules.as:471, 481`); AIR `mex.phase.convert` (`air_rules.as:60`), `surplus.convert` (`:120-126`), `commander.convert` (`air_build.as:289`); AIR eco modules with 8 converter pins (`air_eco_layout.as:107-113`, INV-107); the TECH harbour, the dedicated air-constructor role's `LiftCapForRole` (`tech_build.as:455-461`, INV-034/035/036), sea, support and tactical paths; native `UpdateMetalTasks` (`EconomyManager.cpp:1512-1530`); build chains (AFUS → 5 advanced converters). | as cited; observed 7 and 11 `armmakr`, AIR `cormakr` | energy wasted at 70 E per metal |
| R8 | **Scaling assumes metal is scarce.** <br>TECH ranks energy options by metal per E/s; "metal full for long" rows fire continuously; income gates (spam labs at 200, weapon clusters at 200–500) clear in minutes; the T1 energy target ignores the 3 E/s mex upkeep. <br>AIR's energy target is `max(160, 45·M, 1.3·demand)`. <br>FRONT adds labs per +35 metal without looking at energy. | `eco_planner.as:168-177, 323-353`; `tech_build.as:146-158`; `air_rules.as` energy target; `front.as:719-764` | on SpeedMetal, +859 M/s mined with the bank pinned full: no spending capacity, energy-bound |
| R9 | **Unregistered metal maps get default roles.** TECH needs 5 or more enemy teams. | `setup.as:296-318`; `role_helpers.as:12-26`; `maps.as` | TECH (the layout eco role) never runs on metal maps in normal games |
| R10 | **Native index defects** (all maps). <br>No bounds guards: `IsOpenMexSpot`/`SetOpenMexSpot`, `Is/SetUpgradingMexSpot`, `CMetalManager::IsOpenSpot`, `SetOpenSpot`. <br>Script MEXUP and `TaskB::Common(MEX)` pass -1. `MexTask.cpp:150` reopens spot 0. | `EconomyManager.cpp:1281-1293`; `EconomyManager.h:154-155`; `MetalManager.h:69`; `MetalManager.cpp:263-269`; `MexUpTask.cpp:33, 72`; `task.as:95` | Undefined behaviour today. Positional mexes would trigger the -1 path constantly, so this must be fixed first. |
| R11 | **The native yield model is wrong on metal maps.** It uses a whole-cell radius `int(R/16)` = 1, a 5-cell plus shape. | `MetalData.cpp:233, 493-494` | Income estimate is +25% on Full Metal Plate and −58% on SpeedMetal (12.75 against 30.6); `GetMetalMake` inherits the error |
| R12 | **Random spot count** (seeded from `random_seed` or `time()`). | `MetalManager.cpp:156`; `CircuitAI.cpp:1839-1843` | Spot ids change between runs and after save/load; spot-indexed MEX and MEXUP tasks are dropped on load |

**Upstream context.** CircuitAI issue #97 (2019) says "proper support of
metal-area maps was not finished". Issue #124 says the AI fails on Nine Metal
Islands. BAR issue #1764 reports BARb "mining 1500 metal/s while using only
50-100… STILL building metal converters". Upstream `MetalManager` and `MetalData` are
byte-identical to the fork, so there is no newer upstream fix to adopt.

---

## 5. Economics and meta

On a metal map, **metal is never the constraint; energy, build power and spending
capacity are**. Casters say it directly: "Metal is never the problem on this map…
It's always having enough energy" [community].

### 5.1 Unit economics of a T1 mex [derived]

Here *v* is a T1 mex's yield in M/s. Moho rows assume a new moho on fresh ground.

| v | 0.97 | 1.94 | 2.37 | 5.0 | 30.6 |
| --- | --- | --- | --- | --- | --- |
| Metal payback (50 / v) | 52 s | 26 s | 21 s | 10 s | 1.6 s |
| Build-power seconds per M/s (1,800 / v) | 1,856 | 928 | 759 | 360 | 59 |
| Upkeep per M/s (3 / v) | 3.1 E/s | 1.55 | 1.27 | 0.6 | 0.1 |
| Moho: payback | 160 s | 80 | 65 | 31 | 5 |
| Moho: build-power seconds per M/s | 3,840 | 1,920 | 1,572 | 745 | 122 |

### 5.2 Energy binds: wind turbines per mex [derived]

To spend one mex's output the economy needs `r·v + 3` E/s, where *r* is the
energy-to-metal (E:M) ratio of what gets built. Measured median *r*: T1 ground 12.8,
T2 ground 19.4, T1 air 27–31, T3 about 21.5. So the number of turbines needed per
mex is **k = (r·v + 3) / w**, where *w* is the energy per turbine:

| w, r | v = 0.97 | v = 2.37 | v = 5 | v = 30.6 |
| --- | --- | --- | --- | --- |
| w = 25, r = 12 (T1 ground) | 0.59 | 1.26 | 2.52 | 14.8 |
| w = 25, r = 18 (T2 ground) | 0.82 | 1.83 | 3.72 | 22.2 |
| w = 25, r = 28 (air) | 1.21 | 2.77 | 5.72 | 34.4 |
| w = 15, r = 12 | 0.98 | 2.10 | 4.20 | 24.7 |

**Wind** at w ≥ 22 is the cheapest energy by build power: 64 BP-s per E/s, against
72 for fusion and 104 for advanced fusion. Wind output is capped at 25 per turbine.
Advanced fusion wins only on unit slots and area: one equals 120 turbines.

### 5.3 Converters lose everywhere on metal maps [derived]

Cost per M/s of income, with the energy for the converters supplied by wind at
w = 25:

| Route | Metal | Energy | BP-s |
| --- | --- | --- | --- |
| T1 mex, v = 2.37 | 23 | 220 | 841 |
| T1 mex, v = 0.97 | 57 | 537 | 2,054 |
| T1 converter + wind | 113 | 1,640 | 7,080 |
| T2 converter + wind | 130 | 2,437 | 7,097 |

- **Break-even.** A converter only wins when v < 0.25 M/s, or v < 0.69 M/s if its
  energy is genuinely free. Every BAR metal map is above both.
- **What BAR does.** Its own metal-map quick-start build orders contain **no
  converters**, while its normal-map orders do
  (`luarules/configs/quick_start_build_defs.lua`) [official]. BAR's unit page calls
  converters "wildly inefficient… compared to Extractors" [official].
- **Floating energy** on a metal map means production build power is missing, not
  that a converter is needed.

### 5.4 Mohos versus more T1 mexes [derived]

| For the same 4v income | 4 T1 mexes | 1 moho |
| --- | --- | --- |
| Metal | 200 | 620 |
| Energy | 2,000 | 7,700 |
| BP-s | 7,200 | 14,900 |
| Upkeep | 12 E/s | 20 E/s |
| Unit slots | 4 | 1 |

A moho wins only in four cases:

1. the unit count is near the cap;
2. no free site is within reach;
3. the site is exposed to raids (2,800 HP against 270);
4. footprint density matters.

Note that T2 constructors cannot build T1 mexes or wind turbines, so T1 builders are
needed all game.

### 5.5 Spending capacity, the income curve and the unit cap [derived]

**Production build power** needed to spend income S with army share f is
`bp_per_metal × f × S`, where `bp_per_metal` is about 18 for T1 ground, 28 for T2
ground and 38 for air. For example, S = 100 and f = 0.5 needs 900 BP at T1.

**Income compounds.** Doubling time is about 30–170 s, depending on v, build-power
efficiency and army share.

| Simulated spendable income (one player, half to army from 4:00) | 3:00 | 5:00 | 10:00 | 15:00 |
| --- | --- | --- | --- | --- |
| v = 0.97, w = 15 | 9–11 | 13–18 | 34–37 | 55–95 |
| v = 2.37, w = 25 | 12–19 | 33–45 | 130–195 | 450–865 |
| v = 30.6 | about 30 | 50–110, energy-bound | 70–115 with army | — |

**Unit cap.** The cap is 2,000 by default. Each 100 M/s of spendable income needs
about 95 economy structures on the plates and about 52 on SpeedMetal, so a T1-only
economy hits the cap around **12–25 minutes**. After that, growth comes only from
density: mohos, fusions and advanced fusions, reclaiming the T1 structures they
replace.

### 5.6 How the maps are played [community, official]

- **Values confirmed in play.** "Pulls 31 metal per second" on SpeedMetal, and
  "9.5 as opposed to 2.4" on Full Metal Plate (BrightWorks casts; URLs in
  Appendix D).
- **Openings.** Labs come early. Wind is built "constantly", and storage is
  "basically necessary". On Cloud9: lab, 4–5 turbines, then mexes, keeping metal
  "14 in, 14 out".
- **Timings.**
  - T2 within about 6 minutes on SpeedMetal.
  - Fusion at about 7 minutes on Full Metal Plate.
  - Full T3 production at about 18 minutes.
  - Nukes as early as about 6 minutes on SpeedMetal, so build an anti-nuke early.
- **Mohos.** On SpeedMetal, "advanced metal… don't need to on here".
- **Style.** SpeedMetal is a choke map with "gigantic resources", and players are
  often defensive. Build power is the premier raid target, because mexes are cheap
  to replace.

---

## 6. Design

### 6.1 Principles

1. **One flag, computed once, natively.** `CMetalData::IsMetalMap()` can only be true
   inside the existing `mex_count <= 0` branch. Script reads it through
   `ai.IsMetalMap()`. Every new behaviour is gated by it.
2. **The legacy branch stays byte-identical**, including its `rand()` call order, so
   spot lists, clusters and decisions on every other map are unchanged.
3. **Two layers on metal maps.**
   - An *extraction field* places mexes by position, using the engine's own yield
     model.
   - A deterministic *skeleton* of at most 400 spots keeps today's cluster consumers
     working: military, setup, the energy grid and builder safety probes.
4. **Energy first.** The mex count follows from the energy available to spend its
   output. Converters are forbidden. Mohos are for density, never a precondition for
   reactors.
5. **Script owns policy; native owns mechanism**, per `doc/intent.md`. Native exposes
   levers through JSON and bindings.

### 6.2 Detection

**Native**, in `MetalManager::ParseMetalSpots` (`MetalManager.cpp:143`):

```cpp
int mexCount = game->GetRulesParamFloat("mex_count", -1);
if (calcMex || mexCount <= 0) {
    const SMetalStats st = metalData->MakeStats(map, metalRes);  // one raw read: coverage, land coverage,
                                                                  // median isolated T1 yield, R, maxMetal
    const Json::Value& mm = root["economy"]["metal_map"];
    const std::string mode = mm.get("mode", "auto").asString();  // auto | off | on
    isMetal = (mode == "on" && mexCount <= 0)
           || (mode == "auto" && mexCount <= 0
               && st.coverage >= mm.get("min_coverage", 0.10f).asFloat()
               && st.medianYieldT1 >= mm.get("min_yield", 0.5f).asFloat());
    if (isMetal) { metalData->InitMetalField(st, mm); spots = metalData->MakeSkeleton(mm); }  // no rand()
    else         { /* existing lines 145-187, verbatim */ }
}
```

**Calibration** [data]:

| Maps | Metal coverage |
| --- | --- |
| Normal maps measured | 0.3–0.4% |
| Sunderance (vein map) | 3% |
| Metal maps | 29–100% |
| No-metal maps (e.g. Greenest Fields) | 0% |

A threshold of 10% separates them with a wide margin. `min_yield` 0.5 M/s keeps
low-value fields on the legacy path, where converters can still make sense (v < 0.69).

**Logging.** Log once at init:
`[MetalMap] mode=auto coverage=… medianT1=… R=… maxMetal=… skeleton=…`

**Script.** Add `Global::Map::MetalMap` in `global.as:17-36`, set in `setup.as` from
`ai.IsMetalMap()`. Also add an optional per-map override `MetalMapMode`
(-1 auto, 0 off, 1 on) in `types/map_config.as`, passed to native through the JSON
lever, so a map config can force the mode. Replace the dead test at
`eco_planner.as:204` and delete `EcoMetalMapSpots` (`global.as:667`).

### 6.3 Extraction field (new native code)

A new `resource/MetalField.{h,cpp}`, owned per process in `CMetalData`, with claim
state per ally team in `CMetalManager`.

**Static data:**

- `raw[W·H]` from `Map_getResourceMapRaw`, at 16-elmo cells.
- `scale = Map_getMaxResource`.
- `R = Map_getExtractorRadius`.
- Disc offsets mirroring `ExtractorBuilding.cpp:128-135`: corner-centred for even
  footprints, cell-centred for odd.
- A buildable mask per 16-elmo point for the side's mex defs: in bounds,
  `CanBeBuiltAt`, not void, not harmful water.

**Per ally team:**

- `claim[W·H]`: the deepest extraction requested by known extractors (own, allied,
  and enemy when seen) plus reservations. These are the engine's `RequestExtraction`
  semantics.
- A 16-elmo footprint occupancy bitset.
- 8×8-cell tiles caching `bestFreeYield` and `freeSites`, with a dirty flag.

**Interface:**

```cpp
float Yield(const CCircuitDef* def, AIFloat3 p);   // marginal M/s = Σ raw·scale·max(0, extractsM − claim)
bool  FindMexSite(CCircuitUnit* builder, const CCircuitDef* def, AIFloat3 centre, float radius,
                  float minYield, bool allyAware, AIFloat3& out);
void  Reserve(def, pos, key);  void Release(key);
void  Claim(unitId, def, pos); void Unclaim(unitId);
```

**`FindMexSite`** scans tiles by distance from `centre` and skips:

- tiles below `minYield`;
- threatened tiles;
- allied zones, when `allyAware`.

It tries candidate points on the lattice anchored at the layout grid: pitch
`max(64, 2R)` for R > 32, otherwise 64. For each candidate it requires:

- buildable;
- no footprint overlap;
- not `IsAllyLayoutBlocked`;
- not on a lane, exit or bay reservation.

It maximises `Yield − λ·distance`, then confirms with `IsPossibleToBuildAt` and
`CanReachAtSafe`.

**Corridors.** A **corridor pattern** is enforced so mex carpets never wall units
in: blocks of at most 4×4 mexes (256×256 elmos), separated by 64–96 elmo lanes. Only
the yard corners of a finished mex are walkable. Expected packing is about 70% of a
dense lattice [derived].

### 6.4 Skeleton and clusters

- Tile the map deterministically with `S = max(cluster_range/2, sqrt(area/400))`,
  giving at most 400 skeleton spots.
- Each tile with at least about 10% buildable metal land contributes one spot, at its
  best isolated-yield buildable point. `income` is the isolated T1 yield, so
  `GetSpotAvgIncome`, `GetMetalMake` and edge costs keep their meaning.
- Run the existing `Clusterize` and `BuildClusterGraph` with geometric distances.
  Path distances at 400 spots would cost about 160,000 path estimates.
- In metal mode, `IsClusterFinished` and `IsClusterQueued` are derived from the field:
  no free site at or above `minYield`, or reservations at or above free sites.
- Skip the per-spot MEX pre-block in `TerrainManager::Init` (`:357-383`) in metal
  mode.
- Spot ids become stable across runs and save/load.

### 6.5 Positional mex tasks and upgrades

**`CBMexTask`** (`MexTask.cpp`), in metal mode:

- Constructor (`:26-35`): when `spotId < 0`, call `Reserve` instead of
  `SetOpenMexSpot`.
- `Execute` (`:115-137`): skip the `IsOpenSpot` gate. On an engine refusal, release
  the reservation, re-search within 128 elmos, then `SetBuildPos` and `Reserve`, or
  abort cleanly.
- `Cancel`: release the reservation.
- `Reevaluate`: test disc and footprint overlap through the field.
- `Load`: accept -1 and re-reserve.

**`CBMexUpTask`** already works by position; it needs only the bounds guards from
OD-2.

**Claims:**

- `MetalManager::MarkAllyMexes`: `Claim` on add and `Unclaim` on remove. No
  nearest-spot closing in metal mode.
- `mexFinishedHandler` (`EconomyManager.cpp:137-151`): income comes from `Yield`.
- `mexDestroyedHandler` (`BuilderManager.cpp:232-255`): call `Unclaim`; no spot
  reopen.

**Native chooser** (FRONT, SUPPORT, SEA and TACTICAL keep it):

- `UpdateMetalTasks` (`EconomyManager.cpp:1468-1510`) calls
  `FindMexSite(unit, def, pos, radius(income), minYield)` and enqueues
  `TaskB::Spot(MEX, HIGH, def, pos, -1)`, with up to `mex_tasks_per_builder` parallel
  orders per builder.
- The economic test of section 6.8 replaces "not metal full".
- The per-cluster throttle (`:1374-1380`) becomes per builder or per tile.
- `mexCount`, `mexMax` and the `ms_pull` interpolation use the own extractor count.

**Script mex helpers.** `EnqueueMexWithin`, `GetMexSpotCountWithin`,
`GetClaimedMexCountWithin` and `GetMexCentroidWithin` (`EconomyManager.cpp:902-1070`)
route to the field in metal mode. `maxSpots` then means "candidate sites considered",
so existing TECH and AIR calls become positional with no script change.

### 6.6 Converter veto

- **Native.** In metal mode with `metal_map.convert == false`, call
  `SetBuildAllowed(false)` on every converter def at `EconomyManager::Init`. That is
  the existing veto honoured by `BuilderManager::Enqueue` (`:993-996`) and by
  `IsAvailable` (`CircuitDef.h:225, 230`). It blocks T1, advanced, floating and naval
  converters for native, build-chain and script paths alike. Also skip the native
  branch at `EconomyManager.cpp:1512-1530` explicitly.
- **Script.** Cap all 12 defs at 0 inside
  `LimitsHelpers::ComputeAndStoreMergedUnitLimits` (`limits_helpers.as:26-52`). It is
  re-applied on role switches (`setup.as:367`, `commands.as:572-581`). Add
  `UnitHelpers::GetAllEnergyConverters()` beside `unit_helpers.as:1349-1402`.
- **Gate the cap-lifters and bypasses** so they don't fight the veto:
  - `TechBuild::LiftCapForRole` (`tech_build.as:455-461`). Never assign the
    converter air-constructor role in metal mode; INV-034/035/036 skip it.
  - Harbour `Open` (`tech_harbour.as:101-102`).
  - `Builder::EnqueueT1NavalEnergyConverter`, `EnqueueAdvEnergyConverter` and
    `EnqueueAdvNavalEnergyConverter` (`builder.as:1387-1395, 1716-1757`).
- **Remove the rows**, so traces don't cycle on vetoed work:
  - TECH: add a `NotMetalMap` predicate to `tech_rules.as:471, 481`.
  - AIR: skip `mex.phase.convert`, `surplus.convert` and `commander.convert`
    (`air_rules.as:60, 126`; `air_build.as:289`) and the converter branch in
    `air_growth.as`.
  - Sea, support and tactical converter calls.
- **AIR eco modules** reserve AFUS plus mex pins instead of AFUS plus 8 converter
  pins (`air_eco_layout.as:107-113`). INV-107's slot count changes to match.
- **Floating energy** goes to build power and production through the existing D-105
  rows.

### 6.7 Script API (new bindings)

| Binding | Purpose |
| --- | --- |
| `bool ai.IsMetalMap() const` | the flag |
| `float aiEconomyMgr.GetExtractorRadius() const` | map R |
| `float aiEconomyMgr.GetMexYieldAt(const CCircuitDef@, const AIFloat3& in) const` | marginal M/s at a position |
| `AIFloat3 aiEconomyMgr.FindMexSite(CCircuitUnit@, const AIFloat3& in, float radius, float minYield)` | best free site, or -RgtVector |
| `IUnitTask@+ aiEconomyMgr.EnqueueMexAt(CCircuitUnit@, const AIFloat3& in, bool allyAware)` | positional mex order |
| `int aiEconomyMgr.GetFreeMexSitesWithin(const AIFloat3& in, float radius, float minYield, int cap)` | free sites for field sizing |
| `int aiEconomyMgr.GetOwnMexCount() const` | own extractors, T1 and T2 |
| `bool aiEconomyMgr.convertAllowed` (read-only) | whether the converter veto is on |

Document them in `doc/angelscript-references.md` and keep `check_script_api.py` in
parity.

### 6.8 Economic policy on metal maps (shared, script)

Add a new module, `manager/metal_map.as`, with settings in
`Global::RoleSettings::MetalMap`. Its decision function is shared by all roles.

**Inputs.**

| Input | Meaning |
| --- | --- |
| v | marginal yield at the best free site near home (`FindMexSite` + `GetMexYieldAt`) |
| w_eff | `min(25, average wind)` |
| r | the role's spend ratio: FRONT 12, rising to 18 after T2; AIR 28; TECH 10 while growing, 18–21 at T2/T3 |
| M, E | income, from the 10-second minimum |
| bankM, bankE | resource banks |
| upkeep | `3·n_T1mex + 20·n_moho` |
| drains | production drains |
| units | own unit count, against the cap |

**Decision per economy builder ask** ("build what binds"):

```
need_E   = r·min(M, spendable) + upkeep + drains         // energy to run the economy at full spend
spendable= min(M, (E − upkeep) / r)
1. if E < need_E·(1 − m) or bankE < reserve:  ENERGY
       wind      if w_eff ≥ 22 (all plate maps)
       fusion    if a T2 builder exists and w_eff < 22
       adv solar if w_eff < 16 and no T2
       tidal     for naval builders where tidal ≥ 20
2. else if metal binds (bankM < 0.3·storage and pull ≥ M):  MEX at FindMexSite, up to N in parallel
3. else:  SPEND capacity, i.e. a nano beside a factory, or a new factory cluster
       when production BP < bp_per_metal·f·spendable
never: converters.   Mohos only by rule 6.9.
```

The mex count is not a cap; it emerges as roughly
`n_mex ≈ (E_available − drains) / (r·v + 3)`.

- **Plate maps:** hundreds of mexes by mid game. This is what "mass production"
  means there.
- **SpeedMetal:** tens of mexes, with energy and factories taking the build power.

**Phase guidance** (acceptance ranges in section 10):

- **Opening, 0–3 minutes.**
  - The commander builds a mex at spawn, then follows BAR's metal-map quick-start
    rhythm (mex, wind, wind, mex, wind, wind, …) adjusted by k.
  - First lab once 1–2 mexes stand and energy is at least about 100 E/s.
  - Constructors before army.
  - First nano turret by about 1:30–2:00.
  - One energy storage.
  - No metal storage beyond one, and no converters.
- **Early, 3–8 minutes.**
  - Run the decision loop.
  - Army share: FRONT 0.6–0.8, AIR 0.5–0.7 once its plant is up, TECH 0.1–0.25.
  - Static defence at the economy's edge when contact time is under 60 s.
  - T2 at spendable income of about 40 with energy of about 500, or on seeing enemy
    T2. Its first jobs are fusion (only if w < 22) or T2 production, not mohos.
  - On SpeedMetal, anti-nuke by about 8–10 minutes.
- **Mid, 8–20 minutes.**
  - Watch the unit count. From about 0.4 × cap in economy structures, switch to
    density: advanced fusion, then reclaim the turbines it replaces; mohos in place,
    exposed sites first.
  - Gantry at spendable income of about 150 with 6,000 E/s spare.
- **Late, 20 minutes and on.** Cap-bound. Grow only by density and by reclaiming T1
  economy. Spend on T3 and superweapons. When energy binds and metal floats, **switch
  surplus mexes off** (3 E/s each) instead of stalling.

**Gates in metal mode.** Metal-only gates are replaced with gates on *spendable
income*, `min(M, (E − upkeep)/r)`:

- TECH's "metal full for long" rows;
- spam-lab and weapon-cluster income gates;
- FRONT's labs per +35 metal;
- AIR's +50 milestones.

### 6.9 Moho policy on metal maps

- Turn off `MexUpgradeFirst` (`global.as:259`) and the TECH chain's moho steps
  (`tech_chain.as:287-297, 347-354`) in metal mode.
- `mex.upgrade` (TECH `tech_rules.as:480`; AIR `air_build.as:358-384`) fires only when
  one of these holds:
  - own units ≥ `MohoUnitCapFraction` (0.5) × cap;
  - no free site with `v ≥ minYield` within field reach;
  - the mex is in a raided area;
  - energy floats with spare build power.
- **Reactor gates.** In metal mode, skip `MohosPending` (`tech_chain.as:322-335`;
  `eco_planner.as:366-371`), INV-021, AIR `MexesReady` in reactor admission (the six
  call sites in R6) and INV-077. This needs OD-3.

### 6.10 Roles

**TECH**

- The chain's mex steps (`tech_chain.as:272-275`) become a field target. `wantCk`
  (`:265`) rises to about 4.
- A new `mex.field` row sits above `chain.next` (`tech_rules.as:473`), for
  constructors and for the commander inside the home radius. Its predicates are:
  metal map, decision = MEX, a free field site exists, and an energy reserve is kept
  (each mex costs 500 E).
- In metal mode, move `energy.draining` above the mex rows.
- `ExpandMex` (`tech_build.as:722-743`):
  - anchor on `Layout::BaseCentre()`;
  - drop the `< 60` gate;
  - allow N parallel orders.
- TECH keeps T1 constructors on the field until it is saturated (`fwd.t1`).
- Supply energy and T2 constructors to allies; on metal maps, share energy, not
  metal.

**AIR**

- **`mex.expand`** (`air_rules.as:79-84`):
  - drop `metal < 80` and `PreFusionMexLimit`;
  - allow N parallel orders;
  - use field sites within `HomeEconomyRadius` (2,400);
  - move the row above `fusion.first`.
- **Keep** `opening.mex` and INV-079. INV-092's radius changes to match.
- **Energy.** AIR's r is 28, so it needs about 2.8 turbines per mex on plate maps.
  Its wind clusters are its engine, and mexes fill the gaps between clusters
  (section 6.11).
- **Bombers.** The "mex upgrade first, because spots are finite" rule does not hold
  on metal maps. Bomber targeting should prefer turbine fields (196 HP each), nanos
  and dense mex fields there.

**FRONT, SUPPORT, SEA, TACTICAL** (native chooser):

- They get positional mexes and the converter veto natively (6.5, 6.6).
- FRONT can run a self-sufficient forward module behind its lane: a lab, 2–4 nanos,
  and mexes plus wind at ratio k.
- Script passthroughs need no change.

### 6.11 Layout integration

**Prerequisites:** 6.3, 6.5 and 6.7.

**Spacing.** Mexes sit on a 64-elmo lattice. On R ≤ 31 maps no extraction is lost to
neighbours. Other buildings standing on metal cells do not reduce extraction, so a
mex in any gap is pure gain.

**TECH (`manager/layout.as`)**

- **Halo band.** After `PlanBox` (`:469-505`), lay a mex band in the halo ring beyond
  the shelf and in the forward cluster:
  - use `LayBand(zone, mexDef, front, facing, cols, rows, gap, …, mexGroup)`
    (`InitScript.cpp:1154`);
  - serve it with `NextSlotAny` + `AiPinReservation`, as `NanoTask` does;
  - the pinned task is a positional MEX (`EnqueueMexAt`), not `TaskB::Common`.
- **Outer fields.** Add zones ringing outward from `HomeCentre` with `ReserveZone` +
  `LayBand`, kept clear of factory clusters, exits and lanes, and persisted in layout
  ints (pattern at `:493-501`).
- **Seed.** In metal mode, `HomeCentre` uses `StartPos` (`:1139-1149`), because
  synthetic spots no longer define home.
- **Converter ground.** The ground used by the converter sets (`:847-853`) becomes mex
  band or wind ground.

**AIR (`manager/air_layout.as`, `air_eco_layout.as`)**

- **Wind-gap rows.** When `WindPass` plans a six-turbine cluster, also reserve a row of
  mex pins along the 144-elmo gap (`WindClusterGap`). That gives alternating
  wind and mex bands.
- **Eco modules.** Replace the 8 converter pins around each AFUS with mex pins at the
  lattice pitch.
- **AFUS blast.** An AFUS's death explosion does 10,600 damage within 640 elmos with
  linear falloff, so mexes (270 HP) within about 600 elmos would die with it. Either
  accept that (they are cheap) or keep a band clear (`26-structure-explosions...`).
- **Field planner.** A new `manager/air_mex_field.as` rings outward inside
  `AirHome::EconomySite`, outside bays, envelopes and eco zones, persisted as
  `air.mex.*`.
- **Sequencing.** Build on the owner's `PlanAirFactoryCluster` and
  six-lab compound work.

**Both roles**

- Lanes, exits and bays are hard exclusions.
- D-099 already ignores extractors when testing factory lane walls
  (`TerrainManager.cpp:3291-3292`). In metal mode, verify mex bands never sit on lane
  cells instead of relying on that exemption.

### 6.12 Map registration and default roles

**Register the installed metal maps** in `maps.as` with `StartSpot` tables and a
role per spot, so TECH and AIR are assigned deliberately:

- SpeedMetal BAR V2
- Full Metal Plate (1.4, 1.5, 1.7)
- Oort Cloud V2
- Cloud9 V2
- Asteroid Mines V3
- Iron Isle V1
- Nine Metal Islands V1
- Adamantium Factory V1

Registration also gives the playtest tool its start-spot tables. Today it needs a
scratch file passed with `--map-file`.

**Default-role rule for unregistered metal maps** (needs OD-4):

- When `Global::Map::MetalMap` is set and no map config matches, allow TECH for the
  ally team's lead AI regardless of enemy count. The economy is limited by energy,
  so a dedicated eco and energy role pays.
- Keep AIR from an air start factory.

---

## 7. Change list

### 7.1 Native C++

| Area | File:line | Change | Gate |
| --- | --- | --- | --- |
| Bounds guards | `EconomyManager.h:154-155`, `EconomyManager.cpp:1276-1293`, `MetalManager.h:69, 81`, `MetalManager.cpp:263-269` | Out-of-range ids read as "no spot"; setters do nothing | **ungated (OD-2)** |
| Reevaluate fix | `MexTask.cpp:150` | `spotId = -1` (was 0) | **ungated (OD-2)** |
| Detection | `MetalManager.cpp:143-187`; `MetalData.{h,cpp}` | `MakeStats`, `IsMetalMap()`, JSON `metal_map` | new branch only |
| Field | new `resource/MetalField.{h,cpp}`; `CMetalManager` claims | Yield, `FindMexSite`, `Reserve`/`Claim`, corridors | metal mode |
| Skeleton | `MetalData` | deterministic tile skeleton; geometric clustering | metal mode |
| Terrain pre-block | `TerrainManager.cpp:357-383` | skip per-spot MEX pre-block | metal mode |
| Mex task | `MexTask.cpp:26-35, 91, 115-137, 145-165, 335-341` | positional reservation, re-search, Load with -1 | metal mode |
| Ally marking | `MetalManager.cpp:288-365` | `Claim`/`Unclaim` instead of nearest-spot closing | metal mode |
| Income | `EconomyManager.cpp:137-151`; `BuilderManager.cpp:232-255` | yield from field; `Unclaim` on death | metal mode |
| Native chooser | `EconomyManager.cpp:1374-1380, 1400-1402, 1468-1510, 599-634` | positional mexes, parallel orders, spendable-income test, own-count `mexMax` | metal mode |
| Script mex helpers | `EconomyManager.cpp:902-1070` | route `*Mex*Within` to the field | metal mode |
| Converters | `EconomyManager::Init`; `EconomyManager.cpp:1512-1530` | `SetBuildAllowed(false)` on all converter defs; skip the branch | metal mode |
| Bindings | `InitScript.cpp` (near `:1194`); `EconomyScript.cpp` (near `:93`) | section 6.7 | n/a |

### 7.2 Script

| Area | File:line | Change |
| --- | --- | --- |
| Flag | `global.as:17-36, 667`; `setup.as` (after map config); `types/map_config.as:28-30` | `Global::Map::MetalMap`, `MetalMapMode` override, log line; delete `EcoMetalMapSpots` |
| Shared policy | new `manager/metal_map.as`; `Global::RoleSettings::MetalMap` | decision loop (6.8), spendable income, moho rule (6.9) |
| Converters | `limits_helpers.as:26-52`; `unit_helpers.as:1349-1402`; rows in 6.6 | 0 caps; gate cap-lifters; remove rows |
| TECH | `tech_rules.as:178, 471, 473, 476, 480, 481`; `tech_build.as:455-461, 722-743`; `tech_chain.as:265, 272-297, 322-354`; `eco_planner.as:168-185, 204, 323-353, 366-371, 393-421`; `layout.as:469-505, 847-853, 1139-1149` | field rows, gates, moho policy, energy ranking, halo bands |
| AIR | `air_rules.as:31-33, 60, 79-84, 120-126`; `air_build.as:82, 138-156, 205, 289, 338-406, 440`; `air_economy.as:77-91`; `air_growth.as:53-62`; `air_eco_layout.as:107-113`; `air_layout.as` (`WindPass`) | field expansion, converter removal, reactor gates, mex pins |
| Others | `sea_constructor_helpers.as:131-137, 170-175`; `support.as:349-360`; `tactical.as:422-425`; `tech_harbour.as:101-102, 166-177, 235-254`; `builder.as:1387-1395, 1716-1757` | converter gates |
| Roles | `helpers/role_helpers.as:12-26`; `maps.as`; new `maps/*.as` for metal maps | registration and default-role rule |
| Invariants | `manager/invariants.as` (INV-021, 034-036, 077, 092, 107 exceptions; new INV, section 9) | metal-mode branches |

### 7.3 JSON (`data/config/experimental_*/economy.json`, plus legacy profiles if in scope)

```json
"metal_map": {
  "mode": "auto",              // auto | off | on
  "min_coverage": 0.10,        // share of metal cells for auto detection
  "min_yield": 0.5,            // median isolated T1 yield (M/s) for auto detection
  "convert": false,            // converters allowed in metal mode
  "min_yield_frac": 0.5,       // site yield floor as a fraction of the median
  "lattice": 64,               // elmos; raised to 2R when R > 32
  "block": 4,                  // mexes per block side before a corridor
  "corridor": 80,              // elmos between blocks
  "search_radius": [900, 3000],
  "mex_tasks_per_builder": 2,
  "skeleton_tile": 512,
  "porc": false                // per-cluster porc chain on finished mexes
}
```

In metal mode, also make the native `(avg < 100 || !full)` test
(`EconomyManager.cpp:1472`) a lever, and drop build-chain converter hubs
(AFUS → 5 advanced converters) through `build_chain` conditions or a `_metal`
fragment.

### 7.4 Docs and registers

- A new decision record, numbered by the next free D-number at implementation time.
- Known-issue entries for:
  - the native index defects (R10);
  - the `TaskB::Common(MEX)` objective path (KI-210 extension);
  - the `eco-planner.md` drift (`:84, 193-194, 246, 254`);
  - the legacy profiles, if they stay out of scope.
- Metal-map exceptions in `doc/roles/tech-requirements.md`. The script review cited
  S8, S16, S18, S19 and L9; verify each.
- Role docs: run `check_role_docs.py --update`.
- `angelscript-references.md` (bindings).
- `AGENTS.md` Repository Map entries for the new files.
- Shared knowledge base `rjm.bar.docs`, outside this repository:
  - correct `27-metal-maps-and-spots.md`: extraction is a disc of cells within
    `extractorRadius`, not the footprint, because the cited `MetalMap.cpp:56` area sum
    has no callers; and `Map_getResourceMapSpotsAverageIncome` returns mean bytes per
    cell, not an income;
  - add the upkeep-first rule, the N(R) table, BAR's detection rule and the metal-map
    table;
  - qualify `21-resources.md`'s converter wording for metal maps.

---

## 8. Keeping non-metal maps unchanged

| Mechanism | How it guarantees invariance |
| --- | --- |
| Flag only inside `mex_count <= 0` | On every map where BAR publishes spots, the flag is false by construction, and the legacy branch runs byte-identically, including `rand()` order |
| Coverage and yield thresholds | No-metal maps (0%) and vein maps (Sunderance, 3%) stay on the legacy path |
| Native gates | Field, skeleton, task changes and converter veto all test `IsMetalMap()` |
| Script gates | Every new rule, cap and setting reads `Global::Map::MetalMap`; caps are applied only when it is set |
| Regression check | A fixed-seed Supreme Isthmus run must log the same spot-list hash, spot count and cluster count before and after, with no `[MetalMap]` line, and benchmark metrics within run-to-run variance |
| Guard invariant | The "Non-metal guard" invariant (section 9): on a non-metal map, no metal-map rule key and no converter cap appear |

**The one exception is OD-2.** The bounds guards and the `spotId = -1` fix change
code that runs on all maps. For valid indices they are behaviour-preserving. For
invalid ones (every script MEXUP today) they replace an out-of-bounds write with a
no-op. The owner may instead keep them gated, but leaving known heap writes in place
is not recommended.

---

## 9. Invariants, checks and actor matrix

These follow D-076, using the next free INV range at implementation time.

| Proposed invariant | Promise |
| --- | --- |
| Flag consistent | The metal-map flag matches the native detection, at setup and after any role switch |
| No converters | On a metal map, none of the 12 converter defs is queued, framed or standing for us. Counted by def, because helpers enqueue some converters as FACTORY tasks |
| Mex progress | On a metal map, while the decision loop says MEX and free field sites exist, a mex order or frame appears within 60 s, and the owned mex count does not fall over 3 minutes, excluding deaths |
| No out-of-range spot index | No spot accessor receives an out-of-range index (native; `check_invariants.py` scans C++) |
| Field layout | Mex field slots never overlap exits, bays, envelopes, turret slots or lanes |
| No mex-gated reactor | On a metal map, no reactor is withheld only because mexes are not upgraded |
| Non-metal guard | On a non-metal map, no metal-map rule key and no converter cap ever appears |

**In-game checks.**

- `tools/playtest/checks/metal_map_tech.json`, `metal_map_air.json` and
  `metal_map_front.json`. Each:
  - requires `[MetalMap] mode=` and mex-count milestones;
  - forbids `[INVARIANT]` and any converter `finished` line.
- Add a "forbid `[MetalMap]`" assertion to `tech_opening.json` (normal map).

**Actor matrix.** Add rows for:

- the flag;
- the converter defs on a metal map;
- the mex field slot;
- each new TECH and AIR rule key.

**Unit tests.** Add pure helpers to `production_math.as` with tests in
`tests/production_math_tests.as`:

- `MetalMapDetected(coverage, medianYield, mexCount)`
- `MexPitch(R, footprint)`
- `TurbinesPerMex(r, v, w)`
- `MohoWorthwhile(units, cap, freeSites, raided)`
- `SpendableIncome(M, E, upkeep, r)`

---

## 10. Validation plan and acceptance targets

Run headless playtests at speed 20 on each map, 12–15 minutes:

- Speedmetal BAR V2, Full Metal Plate 1.7 and Nine Metal Islands V1, after
  registering them (6.12);
- Oort Cloud V2 or Cloud9 V2 (void between asteroids);
- the Supreme Isthmus regression (section 8).

Targets come from the scaling simulation (section 5.5) and the community timings.
They are envelopes, not exact goals.

| Map | Metric | Today [observed] | Target |
| --- | --- | --- | --- |
| Full Metal Plate (v 2.37, w 25) | own T1 mexes | 6 at 12:00 (AIR) | ≥ 15 at 5:00; ≥ 50 at 10:00 |
| | spendable metal income | +23 at 12:00 | ≥ 30 at 5:00; ≥ 120 at 10:00 |
| | converters | 7 | 0 |
| | energy stall time | n/a | < 5% after 2:00 |
| Nine Metal Islands (land 1.94 / sea 0.97, w 5–25) | own mexes | 15 at 12:00 | ≥ 12 at 5:00; ≥ 30 at 10:00 (land first, then sea floor by naval or amphibious builders) |
| | converters | 11 | 0 |
| SpeedMetal (v 30.6) | metal bank pinned at full | from 5:00 to 12:00 | never pinned for more than 120 s after 6:00, with metal spent at ≥ 70% of income |
| | turbines at 5:00 | about 30 | ≥ 30–50, with factories and nanos scaling by the spending formula |
| | mohos before 10:00 | 7 | 0, unless the moho rule fires (it should not, since metal never binds) |
| All metal maps | AIR legion mexes | 0 | ≥ 10 by 8:00 |
| Supreme Isthmus | spot hash, count, clusters | baseline | identical; no `[MetalMap]` line |

Also measure:

- init time (field build plus skeleton, against today's about 5 s);
- `FindMexSite` cost (Tracy zones);
- claims under a mex-spamming ally;
- a mid-game save and load on a metal map.

---

## 11. Rollout phases

| Phase | Content | Depends on |
| --- | --- | --- |
| 0 | OD decisions; register metal maps (6.12); OD-2 bounds fixes with the regression check | — |
| 1 | Native detection, field, skeleton, positional mex tasks, converter veto, bindings (6.2–6.7) | 0 |
| 2 | Script flag, shared decision loop, converter caps and row gates, reactor-gate exceptions, moho policy (6.6, 6.8, 6.9) | 1 |
| 3 | Role work: TECH field rows and halo bands; AIR field expansion, wind-gap rows, eco modules (6.10, 6.11) | 2; AIR after the owner's AIR compound work lands |
| 4 | Native-chooser roles' spending capacity (factory and nano scaling by spendable income); unit-cap density transition | 2 |
| 5 | Validation runs, threshold calibration, docs, knowledge-base corrections | 1–4 |

---

## 12. Owner decisions

| # | Decision | Recommendation |
| --- | --- | --- |
| OD-1 | Approve a single native metal-map flag (`mex_count ≤ 0` plus coverage ≥ 10% plus median T1 yield ≥ 0.5), the extraction field and the skeleton, with all behaviour gated | Approve |
| OD-2 | Fix the native spot-index defects (bounds guards; `MexTask.cpp:150` → -1) on **all** maps. This changes only undefined behaviour | Approve as a separate commit with the Supreme Isthmus regression check; alternative: gate it |
| OD-3 | Metal-map exceptions to D-100/S8 (moho before fusion; `MohosPending`, INV-021), D-148 (AIR mexes upgraded before reactors; INV-077), INV-107 (AIR modules hold 8 converters) and INV-034/035/036 (TECH converter air-constructor role), plus the tech-requirements items S16, S18, S19 and L9 | Approve for metal maps only |
| OD-4 | Register the eight installed metal maps; allow TECH for the lead AI on unregistered metal maps | Approve |
| OD-5 | Moho policy on metal maps: T1 first, mohos only for density, cap pressure or exposure | Approve |
| OD-6 | Legacy profiles (easy, medium, hard, hard_aggressive): include them in metal mode, or leave them as they are. Easy and medium stop at the ally-inclusive `mex_max` today | Include the native mechanism (it is profile-independent); leave their policy as is |

---

## 13. Risks and open questions

1. **Energy.** Each T1 mex costs 3 E/s, and an energy stall stops all mex income.
   The decision loop must keep the reserve; add stall telemetry.
2. **Unit cap and performance.** Huge economies hit the 2,000 cap and can lag
   (CircuitAI #97). The density transition (6.8) and the field's tile cache bound the
   work.
3. **Porc chains.** A finished mex triggers `MakeDefence` per cluster
   (`BuilderTask.cpp:1054-1056`; build chains). With hundreds of mexes, bound it per
   skeleton cluster (`metal_map.porc`).
4. **Pathing.** Mex carpets are impassable. The corridor pattern and lane exclusions
   are mandatory.
5. **Shared extraction.** Extraction is shared across all teams, first come first
   served. Claim allied and seen enemy extractors, or yields are overestimated.
6. **Partial metal maps.** On the asteroid maps (29–46% coverage, void between) and
   hybrid maps, rely on per-site yield. Field search must skip void and unreachable
   islands; per-site yield handles it.
7. **Water metal maps.** On Nine Metal Islands and Iron Isle, sea floor is worth half.
   Take land first, then naval, hover or amphibious builders on the sea floor; T1
   mexes have no depth limit.
8. **SpeedMetal's ×2 terrain speed.** Threat, contact time and raid timing estimated
   from unit speed are off by a factor of 2 there. This is out of scope here, but
   relevant to its defence timing.
9. **Threshold calibration.** Coverage of 10% and median yield of 0.5 are priors from
   one scan of 261 maps. Log the stats at init and adjust.
10. **Mex-count targets** come from a one-player simulation. Calibrate them against
    played games; the replay-coding protocol in `78-air-pvp-meta.md` §6 applies.
11. **Phoenix and other Legion specifics** are unaffected. Legion's `legmext15` is not
    reachable.
12. **Line anchors.** The owner's AIR cluster work (`af974624`, which landed during
    this review) touches `InitScript.cpp`, `air_layout.as`, `air_rules.as`,
    `air_build.as` and `tech_build.as`. The anchors here were read from the working
    tree that contained it, so they should still hold, but re-check them before
    implementing.

---

## Appendix A: extractors and converters

From the knowledge-base cache, checked against the unit files. All have 4×4
footprints (64×64 elmos) unless noted.

| id | M | E | BT | Upkeep E/s | extractsmetal | HP | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `armmex` / `cormex` / `legmex` | 50 | 500 | 1,800–1,880 | 3 | 0.001 | 270–275 | any water depth |
| `armamex` (Twilight) | 200 | 1,500 | 1,800 | 3 (+12 cloak) | 0.001 | 1,610 | stealth |
| `corexp` (Exploiter) | 240 | 1,900 | 2,900 | 3 | 0.001 | 1,440 | armed |
| `armmoho` | 620 | 7,700 | 14,900 | 20 | 0.004 | 2,800 | T2 |
| `cormoho` / `legmoho` | 640 | 8,100 | 14,100 | 20 | 0.004 | 3,900 | T2 |
| `cormexp` | 2,400 | 12,000 | 32,500 | 20 | 0.004 | 7,800 | armed T2 |
| `armuwmme` / `coruwmme` / `leganavalmex` | 620–640 | 7,700–8,100 | 14,100–14,900 | 20 | 0.004 | 2,800–3,900 | naval T2, min depth 15 |
| T1 converters (6 defs) | 1 | 1,150–1,250 | 2,600–2,680 | — | 70 E/s → 1.0 M/s | 167 | 3×3 |
| Advanced converters (6 defs) | 370–380 | 21,000 | 31,300–35,000 | — | 600 E/s → 10.34 M/s | 445–560 | 4×4 (naval 5×4, 5×5) |

## Appendix B: extraction tables

**Cells in the disc, N(R)**, with the mex centred on a cell corner:

| R | 24 | 30 | 40 | 60 | 70 | 80 | 90 | 100 | 120 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| N(R) | 4 | 12 | 16 | 44 | 60 | 80 | 96 | 120 | 172 |

- **Uniform field:** `v = extractsMetal × maxMetal × byte × N(R)`. For example,
  Full Metal Plate gives 0.001 × 7.5 × 79 × 4 = 2.37 M/s, and SpeedMetal gives
  0.001 × 10 × 255 × 12 = 30.6.
- **Lattice:** with a 64-elmo pitch and R ≤ 31, discs never overlap, so each mex gets
  N(R) cells. With larger R, a pitch near 2R maximises yield per mex, while √2·R to
  √3·R maximises yield per area.

## Appendix C: evidence files

**Playtest runs** (the engine write directories are outside the repository):

- `C:\bardev\barb-playtest-metal1\runs\20261002-103300\` (SpeedMetal)
- `C:\bardev\barb-playtest-metal2\runs\20261002-104126\` (Full Metal Plate)
- `C:\bardev\barb-playtest-metal3\runs\20261002-104125\` (Nine Metal Islands)

Each holds `report.md` and `infolog.txt`.

**Session scratchpad**
(`%TEMP%\claude\C--bardev-s3k-CircuitAI\b8cff2ff-…\scratchpad\`). These files are
temporary; copy anything worth keeping.

| Path | What it does |
| --- | --- |
| `maps/*_spots.as` | scratch start-spot tables used with `--map-file` |
| `builds/metal/` | the pinned DLL |
| `data_head/` | the HEAD data snapshot |
| `mexnative/sim_parse.py`, `density.py` | port of the native fallback |
| `rma_port.py` | port of the engine analyser |
| `yard_spacing.py` | the 64-elmo spacing model |
| `scan_maps.py`, `map_scan.csv` | the 261-map scan |
| `mm_research/` | scaling tables and simulator |

## Appendix D: references

**Engine (Recoil)**

- `rts/Sim/Units/UnitTypes/ExtractorBuilding.cpp`
- `rts/Map/MetalMap.cpp`
- `rts/Sim/Units/UnitDef.cpp`
- `rts/Sim/Misc/GlobalConstants.h`
- `rts/Sim/Misc/ResourceMapAnalyzer.cpp`
- `rts/Game/GameHelper.cpp`
- `rts/Sim/Units/Unit.cpp`
- `rts/ExternalAI/SSkirmishAICallbackImpl.cpp`

**Game (BAR)**

- `common/upgets/api_resource_spot_finder.lua`
- `luarules/gadgets/cmd_mex_denier.lua`
- `luarules/gadgets/unit_mex_upgrade_reclaimer.lua`
- `luarules/gadgets/game_energy_conversion.lua`
- `luarules/configs/quick_start_build_defs.lua`
- `units/ArmBuildings/LandEconomy/armmex.lua`, `armmoho.lua`, `armmakr.lua`, `armmmkr.lua`
- `gamedata/alldefs_post.lua`
- `modoptions.lua`

**Shared knowledge base**

- `../rjm.bar.docs/knowledge/20-game-mechanics/27-metal-maps-and-spots.md`
  (needs the corrections listed in 7.4)
- `21-resources.md`
- `26-structure-explosions-and-base-spacing.md`
- `50-economy/*`
- `70-strategy/77-eco-tech-player.md`, `78-air-pvp-meta.md`

**Official**

- [In-depth look at economy](https://www.beyondallreason.info/guide/in-depth-look-at-economy)
- [Converter unit page](https://www.beyondallreason.info/unit/cormakr)
- [BAR maps metadata](https://github.com/beyond-all-reason/maps-metadata/blob/main/map_list.yaml)
- BAR issues
  [#1764](https://github.com/beyond-all-reason/Beyond-All-Reason/issues/1764)
  (BARb converters on metal maps) and
  [#449](https://github.com/beyond-all-reason/Beyond-All-Reason/issues/449) (wind cap)
- CircuitAI issues [#97](https://github.com/rlcevg/CircuitAI/issues/97) and
  [#124](https://github.com/rlcevg/CircuitAI/issues/124)
- [Zero-K mex spot finder](https://github.com/ZeroK-RTS/Zero-K/blob/master/LuaRules/Gadgets/mex_spot_finder.lua)
  (`mex_count = -1` for indiscrete metal maps)

**Community** (casts and posts)

- SpeedMetal and Full Metal Plate casts:
  [LADiZ18XUNU](https://www.youtube.com/watch?v=LADiZ18XUNU),
  [s8_FyXJ59IQ](https://www.youtube.com/watch?v=s8_FyXJ59IQ),
  [CRHOSEEk6U8](https://www.youtube.com/watch?v=CRHOSEEk6U8),
  [RyYeU1MeOHA](https://www.youtube.com/watch?v=RyYeU1MeOHA),
  [IcJyUMOL5s8](https://www.youtube.com/watch?v=IcJyUMOL5s8),
  [QcefnI4y2P8](https://www.youtube.com/watch?v=QcefnI4y2P8),
  [00jmlbKWGpc](https://www.youtube.com/watch?v=00jmlbKWGpc)
- Cloud9: [ZyMDpbvRNNM](https://www.youtube.com/watch?v=ZyMDpbvRNNM)
- Spring-era SpeedMetal threads, search snippets only:
  [p=177873](https://springrts.com/phpbb/viewtopic.php?p=177873),
  [p=169439](https://springrts.com/phpbb/viewtopic.php?p=169439),
  [p=560695](https://springrts.com/phpbb/viewtopic.php?p=560695)
