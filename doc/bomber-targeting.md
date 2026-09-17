# Bomber targeting

**Status: diagnosed, not fixed. Phased plan below, P0 and P1 are safe to land first.**

Line references are as of branch `smrt`, 2026-09-16.

## Symptom

Bombers attack low-value targets and ignore strategic ones. A group of bombers
does not concentrate on anything: each picks independently, and group strength
is never used to decide what the group can kill.

Concrete case, Legion, both targets valid and reachable:

| Target | Health | Metal | Chosen? |
| --- | ---: | ---: | --- |
| `legwin` Wind Turbine | 230 | 43 | **yes** |
| `legafus` Advanced Fusion | 9 800 | 10 500 | no |

A 43-metal target is preferred over a 10 500-metal one - a 244x value error, and
the reactor is the most valuable structure on the map. The reactor would have to
be damaged below 230 HP, under 2.4% health, before it outranks an intact
windmill.

## How target selection actually works

A unit becomes a bomber when its **first** role is `bomber`
(`CMilitaryManager::DefaultMakeTask`, `MilitaryManager.cpp:1647`, keyed on
`GetMainRole()`). It is then assigned to `CBombTask`, which is
`final : public ISquadTask` (`BombTask.h:15`), so bombers already group, merge
and elect a leader.

`CBombTask::FindTarget` (`BombTask.cpp:224`) filters every known enemy:

| # | Filter | Source |
| --- | --- | --- |
| 1 | `enemy->IsHidden()` | engine |
| 2 | `maxPower <= threatMap->GetThreatAt(ePos)` (`:270`) | threat map |
| 3 | underwater and no surf-to-water | unit def |
| 4 | `edef->GetSpeed() > speed` (bomber speed / 1.75) | unit def |
| 5 | `isAntiStatic && edef->IsMobile()` | `anti_stat` **attribute** |
| 6 | `IsIgnore()` | `cdef.SetIgnore` from script |
| 7 | `(targetCat & canTargetCat) == 0` | BAR `onlytargetcategory` |
| 8 | `edef == nullptr` | unidentified radar blips never bombed |
| 9 | `(targetCat & noChaseCat) != 0` | BAR `nochasecategory` |
| 10 | `noAllies(ePos)` | friendly-fire guard within blast |

**Ranking among survivors is a single line** (`BombTask.cpp:318`):

```cpp
if (minHealth > health) { minHealth = health; ... }
```

Lowest **current** health wins. There is no value term. The cost-based scoring
is present but commented out, with `FIXME: Finish` at `BombTask.cpp:310`.

## What AngelScript controls, and what it does not

| Script lever | Effect |
| --- | --- |
| `"role": ["bomber", ...]` | which units are bombers (first entry only) |
| `"attribute": ["anti_stat"]` | flips filter 5 - ignores all mobile targets |
| `"threat"` on enemy defs | feeds the threat map, filter 2. Higher threat means **avoided**, never preferred |
| `cdef.SetIgnore(true)` | filter 6, removes whole unit classes |
| `Military::AiMakeTask` role handler | can return a different task, so the unit never enters `CBombTask` |
| `response.json` `bomber.vs` / `ratio` / `importance` | **how many bombers are produced**, not what they attack |

Script has **no hook into the ranking**. `CBombTask` has no registered script
cast or method - only `CSuperTask` got `SetTargetPos`. So no config change can
make bombers prefer reactors. This is a code gap, not a tuning problem.

Note also that `response.json` `vs` entries resolve against the **role** name
map only (`CMilitaryManager::ReadConfig`); an unknown name such as `"energy"`
logs `response %s vs unknown role '%s'` and is skipped, and because `ratio` and
`importance` are read by index, inserting one shifts every later entry onto the
wrong role.

## Defects

### D1 - no value term in ranking

Lowest health wins. See the table above. Root cause of the windmill case.

### D2 - out-of-range target clears an accepted in-range target

`BombTask.cpp:318-326`:

```cpp
if (minHealth > health) {
    minHealth = health;
    const float sqDist = pos.SqDistance2D(ePos);
    if (sqDist < sqRange) {
        bestTarget = enemy;
    } else {
        position = ePos;
        bestTarget = nullptr;     // discards an in-range target already chosen
    }
}
```

A lower-health candidate outside range wins the comparison, nulls `bestTarget`,
and leaves the bomber flying toward a position with no target. This is a plain
defect, independent of whatever ranking is used.

### D3 - group strength is never used offensively

`attackPower` accumulates `cdef->GetPower()` per assignee
(`FighterTask.cpp:52`) and is already consumed in `FindTarget` as
`maxPower = attackPower * scale * powerMod` - but **only as a danger threshold**
in filter 2. It is never used as a damage budget, so a lone bomber and a squad
of eight make identical target choices.

### D4 - no weapon damage accessor

`CWeaponDef` stores `range`, `aoe`, `costM`, `costE`, `fireTime`, `isStockpile`,
`isHigh` - but **no damage**. Any kill-feasibility or splash-value calculation
needs it. `CCircuitDef::GetPwrDamage()` is not a substitute: it is overwritten
by the config `threat` block at `CircuitDef.cpp:796`, so it reflects tuning, not
ordnance.

## Fix plan

One phase per build. Each is independently observable; bundling makes a
regression untraceable.

### P0 - instrumentation (no behavioural risk)

`BombTask.cpp` has no logging at all. Add, before the final
`if (bestTarget != nullptr)`:

```cpp
circuit->LOG("BOMB: leader=%i groupPower=%.1f maxPower=%.1f -> target=%s cost=%.0f health=%.0f",
        leader->GetId(), attackPower, maxPower,
        (bestTarget != nullptr) ? bestTarget->GetCircuitDef()->GetDef()->GetName() : "<none>",
        (bestTarget != nullptr) ? bestTarget->GetCost() : 0.f,
        (bestTarget != nullptr) ? bestTarget->GetHealth() : 0.f);
```

### P1 - fix D2 (low risk, pure defect)

```cpp
const float sqDist = pos.SqDistance2D(ePos);
if (sqDist < sqRange) {
    if (minHealth > health) {
        minHealth = health;
        bestTarget = enemy;
    }
} else if (bestTarget == nullptr) {
    // fallback heading only; never displaces an in-range target
    if (minOutHealth > health) {
        minOutHealth = health;
        position = ePos;
    }
}
```

with `float minOutHealth = std::numeric_limits<float>::max();` beside `minHealth`.

### P2 - fix D1, value ranking

Replace `minHealth` with `bestValue`:

```cpp
// Value per HP: gain versus how much must be chewed through. GetHealth() is
// current health, so damaged high-value targets become more attractive.
const float value = enemy->GetCost() / std::max(health, 1.f);
if (bestValue < value) {
    bestValue = value;
    ...
```

Check against the case above: `legwin` 43/230 = **0.19**, `legafus`
10 500/9 800 = **1.07**. Reactor wins by 5.6x.

### P3 - fix D3 and D4, group kill-feasibility

This is the "focus strategic targets with bombing power" feature. Add a filter
before ranking:

```cpp
const float groupDamage = <sum of member bomb damage>;
...
if ((health > groupDamage * KILL_MARGIN) && (enemy->GetCost() > soloCostCap)) {
    continue;   // too fat for this group; leave it for a larger one
}
```

Requires D4 first. Add to `CWeaponDef`, whose ctor already holds the
`WeaponDef*`:

```cpp
// CircuitWDef.h
float GetDamage() const { return damage; }

// CircuitWDef.cpp ctor, alongside the existing aoe/cost reads
Damage* dmg = def->GetDamage();
const std::vector<float>& types = dmg->GetTypes();
damage = types.empty() ? 0.f : types[0];
delete dmg;
```

Do **not** use `attackPower` directly as the damage budget: it is a threat
metric, not HP, and is dimensionally wrong for this comparison.

### P4 - finish the AoE splash estimate

Completes the `FIXME` at `BombTask.cpp:310`, making bombers prefer clusters:

```cpp
float metalKilled = 0.f;
for (int enemyId : circuit->GetCallback()->GetEnemyUnitIdsIn(ePos, trueAoe)) {
    CEnemyInfo* ei = circuit->GetEnemyInfo(enemyId);
    if (ei == nullptr) {
        continue;
    }
    const float dist = ePos.distance2D(ei->GetPos());
    const float dealt = bombDamage * std::max(0.f, 1.f - dist / trueAoe);
    metalKilled += (ei->GetHealth() > dealt)
            ? (SPLASH_PARTIAL * ei->GetCost() * dealt / ei->GetHealth())
            : ei->GetCost();
}
const float value = metalKilled / std::max(health, 1.f);
```

Perf caution: this runs an engine query (`GetEnemyUnitIdsIn`) per candidate,
inside a loop over all known enemies. Profile it, and consider restricting it to
candidates that already clear a cost threshold.

## Priority summary

| | Change | Risk | Depends on |
| --- | --- | --- | --- |
| P0 | Logging | none | - |
| P1 | D2 range defect | low | - |
| P2 | D1 value ranking | medium, behavioural | P0 to observe |
| P3 | D3/D4 group feasibility | medium, needs calibration | D4 accessor |
| P4 | AoE splash | higher, perf-sensitive | D4 accessor |

## Validation

All of this is C++, so none of it hot-reloads. Every iteration is a rebuild plus
a redeploy of `SkirmishAI.dll` - which is the main argument for landing P0 first.
There is no test harness, so verification is in-game only; raise `LOG_LEVEL` in
`data/script/src/define.as` to at least 3 and read the run with
[`skills/troubleshoot-bar-logs/SKILL.md`](../skills/troubleshoot-bar-logs/SKILL.md).

Keep filters 1-10 intact in all phases. They encode real constraints - threat,
target categories, `IsIgnore`, friendly-fire AoE. The defect is confined to the
tiebreak.

## Related

- [`doc/t2-constructor-stall.md`](t2-constructor-stall.md) - another native
  gating issue with an undecided fix.
- [`doc/roles/tech.md`](roles/tech.md) - role/attribute system and the
  unit-cap mechanics.
- [`doc/angelscript-references.md`](angelscript-references.md) - registered API
  surface, and what is deliberately not exposed to script.
