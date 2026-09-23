# Eco planner: the deterministic economy build order

TECH's economy is built by one function of the game's state
(`EcoPlanner::Decide`, [`manager/eco_planner.as`](../data/script/src/manager/eco_planner.as)),
re-evaluated every time a constructor asks for work. The same inputs always
give the same next structure, so the order is reproducible, and because the
inputs move as the game goes (income, banks, wind, what stands, who asks)
the sequence re-adjusts by itself. The D-060 layout intercepts advanced
fusion/converter choices while its rear module is incomplete; other choices
retain normal placement. Decision:
[D-058](decisions.md#d-058--techs-economy-is-a-deterministic-function-of-the-games-state).
The explicit bootstrap and regional build-power model are D-062; see
[`tech-eco-meta.md`](tech-eco-meta.md).
Only TECH runs it (`Tech::EcoPlannerEnabled`).

## Contents

- [The meta in numbers](#the-meta-in-numbers)
- [Inputs](#inputs)
- [The function](#the-function)
- [Worked openings](#worked-openings)
- [Where each structure goes](#where-each-structure-goes)
- [Settings](#settings)
- [What it does not do](#what-it-does-not-do)
- [Logs](#logs)
- [Related](#related)

## The meta in numbers

From the shared knowledge base
([`50-income-sources.md`](../../rjm.bar.docs/knowledge/50-economy/50-income-sources.md),
[`52-scaling-curves.md`](../../rjm.bar.docs/knowledge/50-economy/52-scaling-curves.md)),
Armada values; Cortex and Legion are within 10 % and the planner reads each
side's own defs.

| Structure | Metal | Output | Metal per E/s | Payback as metal (T2 converter rate, 1 M per 58 E) |
| --- | ---: | ---: | ---: | ---: |
| T1 mex on a 2.0 spot | 50 | 2.0 M/s | - | **25 s** |
| Moho upgrade | 570 net | +6.0 M/s | - | 95 s |
| Geothermal (needs a vent) | 560 | 300 E/s | 1.9 | 108 s |
| Advanced fusion | 9 700 | 3 000 E/s | 3.2 | 188 s |
| Wind at 10 E/s average | 40 | ~10 E/s | 4.0 | 232 s |
| Advanced solar | 350 | 80 E/s | 4.4 | 254 s |
| Fusion | 3 350 | 750 E/s | 4.5 | 259 s |
| Wind at 7 E/s average | 40 | ~7 E/s | 5.7 | 331 s |
| Tidal at 15 | 90 | 15 E/s | 6.0 | 348 s |
| Solar | 155 | 20 E/s | 7.75 | 450 s |
| T1 converter | 1 | 1 M/s from 70 E/s | - | 1 s (converts surplus only) |
| Advanced converter | 380 | 10.34 M/s from 600 E/s | - | 37 s (converts surplus only) |
| Energy storage | 170 | 6 000 E banked | - | - |

Three facts shape the order:

1. **Mexes first, enforced.** Nothing else pays back in under a minute; a moho
   upgrade is the second-best return in the game. TECH's bootstrap directly
   claims the nearest configured home spots and holds native factory
   scheduling until they and the opening winds are queued.
2. **Energy is bought by metal per E/s, gated by the lump.** Wind at a good
   average is the cheapest energy there is, advanced solars and fusions cost
   the same per E/s, solars are twice as dear - but a 350 lump at +3 metal
   is a two-minute wait and a 3 350 lump needs a T2 constructor. So the
   choice is "cheapest per E/s among what this constructor can build and
   the bank can pay for soon".
3. **Energy has a target, not a maximum.** The scaling table says a metal
   income wants about 8 E per M at +5 and 20 E per M from +40 up (T2 units
   cost 20-27 E per M; the ramp is slow because early metal is worth more
   in mexes than in turbines). Below the target, energy is the bottleneck; above
   it, surplus energy is only worth what a converter makes of it.

Reclaim returns all metal (`unitEfficiency` 1), which is why the layout's
tenancy - solars on converter ground, winds on fusion ground - costs
nothing but build time.

## Inputs

| Input | Source | Used for |
| --- | --- | --- |
| wind min, max | `ai.GetWindMin/Max()` (map) | wind's effective output and whether turbines are an option |
| wind current, tidal strength | `ai.GetWindCur()`, `ai.GetTidalStrength()` | **logged only**: the decision uses the range, not the moment's wind, and TECH builds no tidals (a sea role's option) |
| the asking constructor's build options | `CCircuitDef::CanBuild` | only what it can build is offered (a commander has no advanced solar) |
| an energy structure under construction | `Builder::GetEnergyUnderConstruction` | one at a time (`EcoOneEnergyAtATime`) unless the bank drains |
| energy income, pull, bank, storage | `aiEconomyMgr.energy` | the target, draining, floating |
| metal income, bank, storage | `aiEconomyMgr.metal`, the 10-second minimum income | the target, affordability, floating |
| metal map | `ai.GetMetalSpotCount() >= EcoMetalMapSpots` | a metal map converts only a hard float |
| counts of solars, advanced solars, winds, converters, fusions, storages | `CCircuitDef.count` | storage rules, logging |
| queued storage and converter tasks | `aiBuilderMgr.GetQueuedBuildCount` | deduplication before completed counts change |
| converter energy use and metal output | `aiEconomyMgr.GetEnergyUse/GetMetalMake` | actual surplus and rate rather than 70/600 constants |
| T1 and T2 constructors, T2 lab | def counts | phase |
| the asking constructor's tier | `UnitHelpers::GetConstructorTier` | which options it can build |

## The function

Let `M` be metal income, `E` energy income, `P` energy pull (spend), `eB`
and `eS` the energy bank and storage, `mB` and `mS` the metal bank and
storage.

```
target(M)  = R(M) x M + EcoEnergyReserve
R(M)       = clamp(Low + (M - RampStart) x (High - Low) / (RampEnd - RampStart), Low, High)   (8 at +5, 20 from +40)
deficit    = target(M) - E
draining   = eB < EcoEnergyLowPercent x eS  and  P > E
floatingE  = eB >= EcoConvertEnergyPercent x eS
surplus    = E - P
floatingM  = metal full  or  (mB >= EcoFloatMetalPercent x mS  and  M >= 5)
affordable(x) = cost(x) <= mB + EcoAffordSeconds x M
bpTarget   = M x EcoBuildPowerPerMetal x (floatingM ? EcoBuildPowerFloatFactor : 1)
bpShort    = static assist build power (turrets only) within EcoBuildPowerRadius of Layout::BaseCentre() < bpTarget
             (workertime units as the game shows them: turret 200; GetStaticBuildPowerNear. The commander's
              300 and passing constructors are not counted: played, they hid every shortage and no turret
              was built; before that, the per-frame figure hid the opposite and turrets never stopped)

windEff    = min((windMin + windMax) / 2, 25) x (windMin < EcoWindLullFloor ? EcoWindLullFactor : 1)

options(constructor) =
    (a T2 builder with E >= EcoFusionEnergyIncome: advanced fusion if its gate passes, else fusion, whatever the ratio;
     a T1 builder in that state: no energy at all)
    solar; advanced solar if M >= EcoAdvSolarMinMetalIncome or mB >= its cost;
    wind if windEff >= EcoWindMinimum;
    and for a T2 constructor: fusion if M >= MinimumMetalIncomeForFUS,
    advanced fusion if M >= MinimumMetalIncomeForAFUS;
    only what the constructor can build and the turret box can hold within a
    turret's reach (Layout::CanPlace);
    ordered: affordable first, then metal per E/s ascending, then output descending

decide:
  0. (opening, roles/tech.as) every reachable mex within OpeningMexRadius, nearest
     the commander first; then native's start factory
  1. if draining and no energy build is in progress: options[0] if affordable, else the cheapest lump;
     if draining and one is going up within EcoAssistRadius of the builder: assist it ("assistenergy",
     up to EnergyFocusMaxAssists helpers); else nothing here - never a second one in parallel
  2. the advanced lab, if none stands or is queued, the constructor can build it,
     M >= MinimumMetalIncomeForT2Lab and E >= MinimumEnergyIncomeForT2Lab
  2b. a T2 builder: the nearest owned T1 mex within MexUpgradeRadius of the start, while fewer
     than MexUpgradeMaxConcurrent upgrades are queued ("mexup", an exact spot)
  3. if (floatingE or surplus >= 2 x EcoConverterUse), not energy-stalling, and the
     actual surplus covers the converter's native energy use (energy under construction
     does not block this):
         advanced converter if a T2 constructor asks and M clears its gate
         T1 converter if M < BuildT1ConvertersUntilMetalIncome
  3b. turrets, one at a time: orders not started + turrets under construction
     >= EcoMaxConcurrentNanos (1):
         a mobile non-commander constructor assists the turret going up within
         EcoTurretAssistRadius of the base centre ("assistnano"); else nothing here
     otherwise if bpShort (or floatingM) and Layout::CanPlaceTurret(),
     M >= EcoTurretMinMetalIncome, mB >= EcoTurretBankFraction x turret cost:
         turret (nano) on the next planned slot, nearest the factories
  4. if deficit > 0, not floatingE (a full bank is not a shortage), and no energy build
     is active (EcoOneEnergyAtATime; an order counts from the moment it is placed);
     if one is active and its frame is within EcoAssistRadius: assist it
         options[0] if affordable, else the cheapest lump
  5. energy storage if winds >= EcoStorageWinds and none stands or is queued;
     energy storage if eS < E x EcoStorageSeconds and built+queued is below the cap;
     metal storage if the bank is full and fewer than EcoMaxMetalStorages (M >= 20)
  6. if floatingM and E < 2 x target(M) and no energy build is active: the first affordable option
  7. nothing (the ladder continues: factories, defence, military)
```

Every branch is a comparison of the inputs; no randomness, no memory
except the log throttle. "Range" is in every branch: an option the box
cannot hold within a turret's reach is not offered, and the chosen one is
packed on the box cells nearest a turret (D-063).

Before a structure is started, the role's "assist the reactor under
construction instead" rule (`Tech_RedirectEnergyToReactor`) still applies.

## Worked openings

**Any map (D-063).** The commander claims up to three reachable mexes within
700 elmos of the start (the home cluster), nearest to itself first, and
nothing else; the
start factory is held until the last of them (or 240 s, or the commander's
death) and honoured the moment native asks. The mexes eat the 1,000 E bank
(500 E each), so the lab builds at the commander's 25 E/s unless energy is
stalling and branch 1 or 4 names an affordable source, which then goes
first. The turrets come when build power is short of 8 per metal: at +40
metal the target is 320, above the commander's 300, so the first turret
goes on the factory's rear slot about then.

**Windy map (5-20, average 12.5, min over the lull floor).** windEff 12.5,
3.2 metal per E/s: wind beats everything. At +3 metal and the commander's
30 E the target is 8 x 3 + 60 = 84 E; four turbines make 30 + 50 = 80 E,
still short, so the fifth turbine comes before anything else (the storage
rule is branch 4, after the energy branch); at 30 + 62.5 = 92.5 E the
target is met and the first energy storage follows (four or more winds,
none standing). From there the planner follows the target as mexes come
in; converters appear only when the bank floats.

**Still map (0-5).** windEff under the floor: turbines are never an option.
Solars at 7.75 until +6 metal, then advanced solars at 4.4 whenever the
bank or the income affords 350; at +18 an advanced converter as soon as
energy floats; a fusion the moment a T2 constructor asks with +20 metal.

**Metal map.** Converters only when the surplus is twice the usual
threshold; the target ratio pulls energy up for units instead.

## Where each structure goes

| Structure | Placement |
| --- | --- |
| solar, advanced solar, wind, T1 and advanced converter, fusion, advanced fusion, storage | the free turret-box cells nearest a turret slot, within its reach (`Layout::Place`, native `PackNearGroup`), pinned |
| construction turret | a factory's rear slot, then the box row nearest the factories (`Layout::NanoTask`) |
| mex, geo | the resource spot |

Without a box (no ground behind the pair clears `LayoutBoxMinScore`), every
economy structure goes within `LayoutFallbackShakeCells` of the factory
nanos through the ordinary search, logged once. Nothing else spirals.

## Converters in parallel while energy floats (D-079)

`PickConverter` orders one converter at a time, but while the chain's
bank-based `EnergyFloats` holds it allows `ConverterParallel` (3) queued at
once and reads the surplus as at least half the income, because the
engine's pull is inflated by whatever is under construction (played: one
T2 converter in three and a half minutes at a full bank).

## The energy veto (D-077)

`Make` asks `Global::energyAllowed` (TECH's `TechBuild::EnergyAllowed`)
before offering an energy def: no wind or solar once a fusion stands, no
advanced solar once an advanced fusion is under way. The same hook guards
the shared builder helpers, so the legacy rows cannot order them either.

## Settings

`Global::RoleSettings::Tech`:

| Setting | Default | Meaning |
| --- | --- | --- |
| `EcoPlannerEnabled` | true | off: the old solar / converter / fusion rungs run |
| `EcoEnergyRatioLow` / `High` | 8 / 20 | E per M wanted at `EcoEnergyRampStart` (5) and from `EcoEnergyRampEnd` (40); the old 25 from +18 sent every metal into energy at +16 |
| `EcoEnergyReserve` | 60 | E/s wanted on top of the ratio |
| `EcoEnergyLowPercent` | 0.25 | bank below this with pull over income is draining |
| `EcoConvertEnergyPercent` | 0.90 | bank at this is floating |
| `EcoFloatMetalPercent` | 0.80 | metal bank at this is floating |
| `EcoAffordSeconds` | 90 | a lump within this many seconds of income is affordable |
| `EcoWindMinimum` | 7 | effective wind under this: no turbines |
| `EcoWindLullFloor` / `Factor` | 4 / 0.7 | min wind under the floor discounts the average |
| `EcoAdvSolarMinMetalIncome` | 6 | the 350 lump waits for this income or the bank |
| `EcoStorageWinds` | 4 | winds before the first energy storage |
| `EcoStorageSeconds` | 20 | storage under this many seconds of income: another |
| `EcoMaxEnergyStorages` / `EcoMaxMetalStorages` | 1 / 2 | queued work counts toward each cap |
| `EcoStorageMinMetalBank` | 150 | no storage order under this much banked metal (the rule looped at 0) |
| `EcoConverterUse` | 70 | a T1 converter's draw; twice this surplus converts even while energy is under construction |
| `EcoAssistRadius` | 1200 | a builder assists the energy structure going up only within this of itself |
| `EcoFusionEnergyIncome` | 300 | from this energy income a T2 builder answers "energy" with a fusion (advanced fusion once `MinimumMetalIncomeForAFUS`), and T1 builders leave energy to the reactors |
| `EcoMetalMapSpots` | 150 | metal spots at or above this: a metal map |
| `EcoBuildPowerPerMetal` | 8 | assist BP wanted around the base per metal income (about what T2 work spends) |
| `EcoBuildPowerFloatFactor` | 1.5 | ... times this when metal floats |
| `EcoBuildPowerRadius` | 700 | the radius the BP is measured in |
| `EcoTurretMinMetalIncome` | 8 | no turret under this income |
| `EcoTurretBankFraction` | 0.5 | this share of a turret's metal banked before one starts |
| `EcoMaxConcurrentNanos` | 1 | turret orders plus turrets under construction at once; the rest assist |
| `EcoTurretAssistRadius` | 1200 | a constructor assists a turret going up within this of the base centre |
| `OpeningMexRadius` / `OpeningMexCap` | 2000 / 3 | the opening's mexes: the cap's spots nearest the start inside the radius (0 = all) |
| `OpeningMaxSeconds` | 240 | the start factory is released by then whatever the count |

The gates it shares with the ladder: `MinimumMetalIncomeForFUS`,
`MinimumMetalIncomeForAFUS`, `MinimumMetalIncomeForAdvConverter`,
`BuildT1ConvertersUntilMetalIncome`, and for the advanced lab
`MinimumMetalIncomeForT2Lab` (18) / `MinimumEnergyIncomeForT2Lab` (250;
was 500, which held the lab back at +24 metal while the base floated).
`[Eco] advanced lab waits: ...` logs once a minute while the gate holds.

## What it does not do

- Mex upgrades after the opening (native's, before the general energy ladder).
- Geothermal and tidal: geo spots are served by native's GEO tasks; tidals
  are a sea decision the SEA role makes.
- Factories, defence, military: the ladder's, after the planner returns
  nothing. A FACTORY default from native is honoured before the planner.
- Turret placement: the planner says "turret"; the box says where
  (`Layout::NanoTask`). The planner touches the layout through five calls
  only: `Place`, `NanoTask`, `CanPlace`, `CanPlaceTurret`, `BaseCentre`.
  The ladder's old rungs and the float spend go through `EcoPlanner::Enqueue`.

## With the experimental system on (D-067)

`Next` answers nothing when `Tech::ExperimentalBuild` is on. The rule table
([`roles/tech_rules.md`](roles/tech_rules.md)) calls the pieces itself,
one per row: `Read` for the state, `PickEnergy`, `PickConverter`,
`PickT2Lab`, `PickMexUpgrade`, `PickTurret`, the storage checks, and
`Enqueue(key, u)` to turn a key into a task. The order of those calls is
the table's, not `Decide`'s; `Decide` remains the order for the legacy
ladder with the switch off.

The `t2lab` key hands the site to `Layout::T2LabTask` (D-069): the pair's
slot, or the footprint the most static build power reaches.

## Logs

Level 1, throttled to a change of choice or 30 s:
`[Eco] next: <key> (<why>) | E <income>/<target> pull <p> bank <b>/<s> | M +<income> bank <b> | BP <near>/<target> turret slots <n> | wind <min>-<max> eff <e> tidal <t> | by <constructor def>`.

## Related

- [`layout-design.md`](layout-design.md) - the module that intercepts mature advanced economy.
- [`roles/tech.md`](roles/tech.md) - the ladders that call it.
- [`decisions.md`](decisions.md) - D-058.
