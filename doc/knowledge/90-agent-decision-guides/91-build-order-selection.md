---
layer: 90
confidence: synthesis (rules) / community (build orders)
sources:
  - 70-strategy/70-openings.md
  - 50-economy/52-scaling-curves.md
  - 20-game-mechanics/24-game-modes-and-options.md
  - data/config/*/commander.json, factory.json (BARb's current opening)
  - doc/roles/tech.md
---

# Build order selection

Inputs: map, faction, team role, game options. Output: the first five
minutes of commander and factory orders, and the conditions that switch to
the next phase.

## Inputs to read at frame 0

| Input | Source | Effect |
| --- | --- | --- |
| Average wind | map info (`CEconomyManager::GetWind` equivalent) | wind >= ~10: winds; else solar ([21](../../../../rjm.bar.docs/knowledge/20-game-mechanics/21-resources.md)) |
| Water fraction and sea spots | terrain analysis | shipyard / hover platform as first or second factory |
| Slope distribution near start | terrain analysis per move class | bots (steep) vs vehicles (flat) |
| Map size and start distance | map | large: vehicles/air/eco; small: bots/rush defence |
| Spot count and value within 1500 elmo | `CMetalManager` | many spots: expansion-heavy opening, early T2 pays; few: army-heavy |
| Geo vents | map features | plan a geo at 5-8 min |
| Faction | own unitdefs | unit ids for each role |
| Team role | config / `main.as` | front / tech / air / sea / support opening |
| Options | `Spring.GetModOptions` equivalents in the AI callback | resource multipliers scale every threshold; `unit_restrictions_*` remove branches; `deathmode` |

## Decision table: first factory

| Terrain | Wind | Water | Result |
| --- | --- | --- | --- |
| steep or mixed | any | none | bot lab |
| flat, open | any | none | vehicle plant |
| any land | any | > 40% water with sea spots | shipyard first (sea role) or bot/vehicle + hover platform second |
| any | any | mixed lakes/rivers | bot lab + hover platform at ~4 min |
| any land, large map, low enemy raid risk | high | none | vehicle plant; air plant second at 3-4 min |

BARb: `factory.json` `tier0` weights per factory with terrain `land`/`water`
vectors do this natively; the table is the explicit version.

## The opening template (land, 1v1 or front role)

```text
Commander:  mex -> energy x2-3 -> mex -> factory (assist to completion)
            -> energy to 60 E/s -> walk to nearest cluster: mex, mex, LLT
            -> radar tower at the front edge -> assist factory / mex duty
Factory:    con, con, raider, raider, con, raider x2, riot (when enemy raiders seen), con, ...
Cons:       each to a different cluster; 1 energy per 2 mexes; LLT at exposed clusters
Switches:   enemy raiders seen        -> factory: riot every 3rd unit
            enemy air seen            -> factory: 2 AA, then 1 per 6 units
            8+ mexes and 15 M/s       -> tech decision (71)
            enemy T2 seen             -> match tech now, or all-in now
            metal floating > 50%      -> add a nano / second factory
            energy < 20% and falling  -> energy build before anything else
```

## Team-role variants

| Role | Opening delta |
| --- | --- |
| Front | fewer cons (2-3), riots earlier, LLT at the lane choke, no T2 before 10 min without shares |
| Tech / eco | 5-6 cons, wind/solar heavy, T2 lab at 15 M/s banked, first fusion immediately after; minimal army, radar + LLT only |
| Air | energy first (winds/solars to 150 E/s), aircraft plant as first factory, Blink scout at 1:30, Banshee raids at 3 min, con air for expansion |
| Sea | shipyard, con ship x2 (125 BP each), sonar at 1:00, Skater scout, subs when enemy ships appear |
| Support | radar network, anti-nuke by the time enemy T2 is 5 min old, artillery |
| Hover / tactical | hover platform (T1.5) as first factory only on mixed maps; else second factory at 4-5 min |

BARb's Tech role opening and its known issues are in
[roles/tech.md](../../roles/tech.md); the hover variant in
[roles/hover.md](../../roles/hover.md).

## Scaling for options

Every metal/energy threshold above is at multiplier 1.0. With
`multiplier_resourceincome = 2`, the 15 M/s T2 gate becomes 30 M/s of
*display* income but the same number of spots; the right scaling is by
**spots claimed and BP**, not by raw income. Encode thresholds as fractions of
map total spot value where possible.

## Anti-patterns the data flags

- T2 lab at 18 M/s with one constructor (5-minute build, stall) -
  [roles/tech.md](../../roles/tech.md).
- Solar-only on a 20-wind map (0.13 vs 0.63 E per M).
- Second factory before 8 mexes (production without income).
- No radar by minute 3 (blind to raids that a 60-M tower would show 40 s
  early).
- Commander idle: 300 BP is 2x the factory.

## Related

- [70-openings.md](../../../../rjm.bar.docs/knowledge/70-strategy/70-openings.md), [94-economy-policies.md](94-economy-policies.md).
