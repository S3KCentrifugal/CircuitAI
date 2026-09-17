---
layer: 90
confidence: synthesis (from the derived matrix and community composition rules)
sources:
  - 40-roles-and-counters/41-counter-matrix.md
  - 70-strategy/73-army-composition.md
  - data/config/experimental_hard/response.json (current BARb form)
  - src/circuit/module/MilitaryManager.cpp (ReadConfig: vs/ratio/importance by index)
---

# Response tables

Enemy composition -> production response, in the shape BARb's
`response.json` already uses so a row can become config directly.

## How `response.json` works

```json
"response": {
  "<own role>": {
    "vs": ["<enemy role>", ...],
    "ratio": [r1, r2, ...],
    "importance": [i1, i2, ...]
  }
}
```

- `vs` names resolve against the **role** name map only. An unknown name
  (e.g. `"energy"`) logs `response %s vs unknown role` and is skipped, and
  because `ratio`/`importance` are read **by index**, every later entry
  shifts onto the wrong role. Keep the three arrays the same length and use
  only role names.
- The AI raises production weight of `<own role>` in proportion to enemy
  metal seen in each `vs` role x `ratio`, weighted by `importance`.
- It is memoryless: it reacts to what is currently known, not to what was
  seen a minute ago.

## Land response table

Rows: what the enemy fields (by metal share). Columns: own role weights to
add. Values are relative weights derived from the counter matrix direction
and the composition rules in [73](../../../../rjm.bar.docs/knowledge/70-strategy/73-army-composition.md);
tune magnitudes in play.

| Enemy role (main) | raider | riot | skirmish | assault | artillery | anti_air | anti_heavy | air | static |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| raider | 0 | **3** | 0.5 | 1 | 0 | 0 | 0 | 0 | 1 (LLT at clusters) |
| riot | 0 | 0 | **3** | 1.5 | 1 | 0 | 0 | 0.5 | 0 |
| skirmish | **2** | 0 | 0.5 | **2** | 0.5 | 0 | 0 | 1 | 0 |
| assault | 0.5 | 0 | **3** | 1 | **2** | 0 | 1 | 1 | 0 |
| artillery | **3** | 0 | 0 | 1 | 0 | 0 | 0 | **2** | 0 |
| anti_air | 1 | 1 | 1 | 1 | 0 | 0 | 0 | -1 | 0 |
| anti_heavy | **2** (swarm) | 1 | 1 | 0 | 1 | 0 | 0 | 1 | 0 |
| heavy (T2/T3) | 0 | 0 | **2** | 0 | 1 | 0 | **3** | 1 (bombers) | 1 (Pulsar-class) |
| air | 0 | 0 | 0 | 0 | 0 | **3** | 0 | **2** (fighters) | 1 (static AA) |
| bomber | 0 | 0 | 0 | 0 | 0 | **3** | 0 | **3** (fighters) | 1 |
| static | 0 | 0 | 1 | 0 | **3** | 0 | 0 | 1 | 0 |
| super (nuke/LRPC) | 1 (snipe) | 0 | 0 | 0 | 0 | 0 | 1 | **2** (bombers) | **3** (anti-nuke) |
| sub | - | - | - | - | - | - | - | anti_sub air | sonar |
| ship | - | - | - | - | shore artillery | - | - | bombers | shore statics |
| hover | shore raiders | riot at shores | skirmish | - | artillery at landings | - | - | - | LLT at shores |
| commander forward | **2** (its energy) | 0 | 1 | 0 | 0 | 0 | **2** | 0 | 0 |

Negative means reduce. **Bold** is the primary answer.

## Phase modifiers

| Phase | Modifier |
| --- | --- |
| 0-5 min | ignore `heavy`, `super`, `anti_heavy` rows; cap `anti_air` at 2 units until air is seen |
| enemy T2 seen | double `anti_heavy` weights; add `artillery` +1 baseline |
| enemy T3 seen | `anti_heavy` x3, EMP structure if available, nuke consideration |
| own income > 100 M/s | all responses scale with production; add `super` defence baseline (anti-nuke) regardless of what is seen |
| `deathmode` on | `anti_heavy` +1 whenever the enemy commander is forward |

## Baseline (no information)

Composition target from [73](../../../../rjm.bar.docs/knowledge/70-strategy/73-army-composition.md):
raider 25 / riot 20 / skirmish 30 / assault 15 / artillery 5 / anti_air 5 (%
of metal), plus one scout per 3 minutes. The response table adds to this
baseline; it does not replace it.

## Translating to `response.json`

Example for the `riot` row (own role riot responds to enemy raider and scout):

```json
"riot": { "vs": ["raider", "scout"], "ratio": [3.0, 1.0], "importance": [1.0, 0.5] }
```

Example for `anti_air`:

```json
"anti_air": { "vs": ["air", "bomber"], "ratio": [3.0, 3.0], "importance": [1.0, 1.0] }
```

Do **not** encode structure targets (energy, factories) in `vs`; they are not
roles. Structure priorities belong to bomber targeting
([bomber-targeting.md](../../bomber-targeting.md)) and raid targeting.

## What the table cannot express

- Phase and memory (a rush seen at minute 3 should shape minute 6) - needs
  script state in `Economy::AiUpdateEconomy` or a new module.
- Absolute counts (2 AA regardless of ratio) - needs `factory.json` minimums
  or script.
- Domain (shore statics vs hovers) - needs terrain-aware placement, not
  production weights.

## Related

- [41-counter-matrix.md](../../../../rjm.bar.docs/knowledge/40-roles-and-counters/41-counter-matrix.md), [73-army-composition.md](../../../../rjm.bar.docs/knowledge/70-strategy/73-army-composition.md), [40-role-taxonomy.md](../../../../rjm.bar.docs/knowledge/40-roles-and-counters/40-role-taxonomy.md).
