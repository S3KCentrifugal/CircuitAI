# `roles/tech_harbour.as` — an island TECH moves its economy to the water (D-121)

## Intent

The owner's plan for a TECH that starts on an island (Tundra Continents):

1. TECH's usual land phase: a bot lab, the advanced lab, mex upgrades, a
   fusion, advanced fusions.
2. From the second advanced fusion, the sea: expanding the sea economy and
   pumping out sea units, with T2 sea units the priority.
3. Land constructors keep working on the island; land labs make no combat
   units, which could not leave.

Only a start the map file flags land-locked (`Global::Map::LandLocked`) enters
any of this. Land maps never do.

## The sequence

| Phase | Who | What |
| --- | --- | --- |
| before | the commander | Floating T1 converters while energy floats and income is over `HarbourCommanderMinEnergy`, up to `HarbourCommanderConverters`. The island's flat ground stays for labs and fusions. |
| start | `Active()` | At `HarbourAfterAdvancedFusions` (2) advanced fusions, or `HarbourLatestSeconds` (900) in once an advanced lab has stood. The island's ground can run out first: on Tundra's north island no fusion site was left within reach of the advanced lab. Latched. |
| 1 | a land constructor | The hover plant on the island, on a footprint it can reach (`Layout::CrampedLabSite`). A T1 shipyard needs water 30 deep, further out than a land constructor's reach. |
| 2 | the hover plant | `HarbourHoverConstructors` (3) hover constructors, then waits. |
| 3 | hover constructors, construction ships | The advanced shipyard first, on a site the script picks by ring search from the harbour (native's search started from the island's middle). Then help any yard going up, `HarbourTurrets` (10) floating turrets at the yards, floating converters while energy floats, and tidals while energy is short or under `HarbourTidalUntilEnergy`. |
| 4 | construction subs | Floating advanced converters while energy is over `HarbourConverterEnergyShare` (60%) of storage, else a naval fusion (one at a time). |
| 5 | the advanced shipyard | `HarbourT2SeaConstructors` (4) construction subs, then cruisers, a missile ship and an AA ship in a cycle. A T1 shipyard, if one exists, makes its ships and then destroyers once the advanced yard stands. |
| land labs | `HoldsLandCombat` | Constructors as usual, never combat. |

Every sea builder keeps a construction it already holds (`TechBuild::KeepCurrent`). Harbour combat ships run the advanced yard's route (`FleetTask`: Spam's route task, lane 0, through the front to past the focus). Once the harbour runs, the harbour's caps are re-opened after every economy update (`ReapplyCaps`). Harbour sea units are built whatever the income; INV-010 exempts them (owner:
"pumping out sea units").

## Functions

| Function | Called by | What |
| --- | --- | --- |
| `Enabled`, `Active`, `UnlockCaps` | everything below | The switch, the latched start, and the harbour's unit caps opened. |
| `CommanderFloat` | rule `harbour.float` | The commander's floating converters before the harbour. |
| `LandTask` | rule `harbour.yard` | The hover plant, once. |
| `SeaTask` | rule `harbour.sea` | Construction ships, subs and hover constructors (who `SEA_CON`). |
| `YardTask` | `Tech_FactoryAiMakeTask` | The hover plant and the shipyards. |
| `HoldsLandCombat` | `Tech_FactoryAiMakeTask` | Land labs make no combat units once the harbour runs. |
| `FleetTask` | `Tech_MilitaryAiMakeTask` | a harbour combat ship joins the advanced yard's route |
| `ReapplyCaps` | the economy update | re-opens the harbour's caps after TECH's limits are re-applied |
| `IsHarbourUnit`, `IsHoverConstructor` | INV-010, `TechRules::Build` | The harbour's combat units; the hover constructor counts as a sea constructor. |
| `Anchor` | `SeaTask` | Where the harbour gathers: the advanced yard, else the T1 yard, else the hover plant, else the labs. |

## Invariants

INV-051: the advanced shipyard stands or is framed `HarbourYardSeconds` (480)
after the harbour begins. See [`../invariants.md`](../invariants.md).

## Settings (`Global::RoleSettings::Tech`)

| Setting | Default | Meaning |
| --- | ---: | --- |
| `HarbourEnabled` | true | the harbour on a land-locked start |
| `HarbourAfterAdvancedFusions` | 2 | the owner's trigger |
| `HarbourLatestSeconds` | 900 | the safeguard when the island's ground runs out first |
| `HarbourHoverConstructors` | 3 | the hover plant's constructors |
| `HarbourMaxT2Shipyards` | 1 | advanced shipyards |
| `HarbourYardSearch` | 1200 | the advanced shipyard's site search radius |
| `HarbourYardSeconds` | 480 | INV-051 |
| `HarbourT1SeaConstructors` / `HarbourT2SeaConstructors` | 3 / 4 | construction ships and subs |
| `HarbourTurrets` / `HarbourTurretRadius` | 10 / 320 | floating turrets at the yards |
| `HarbourRadius` | 900 | the sea economy's radius round the harbour |
| `HarbourEnergyLowShare` | 0.3 | energy under this share of storage: energy first |
| `HarbourConverterEnergyShare` | 0.6 | construction subs: converters over this share, else a naval fusion |
| `HarbourTidalUntilEnergy` | 1500 | tidals while energy income is under this |
| `HarbourCommanderConverters` / `HarbourCommanderReach` / `HarbourCommanderMinEnergy` | 30 / 1200 / 150 | the commander's floating converters before the harbour |

<!-- source: data/script/src/roles/tech_harbour.as; blob: 8730c3b181288806b3d7ff7c72fecffe358a421b; lines: 368 -->
