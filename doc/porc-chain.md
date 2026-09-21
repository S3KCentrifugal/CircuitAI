# Porcupine chain

How static defence ordering works, how a role overrides it, and how content
mod options extend it.

## Contents

- [What the chain is](#what-the-chain-is)
- [The default, and where it comes from](#the-default-and-where-it-comes-from)
- [Role control](#role-control)
- [Mod options](#mod-options)
- [The script API](#the-script-api)
- [Known limits](#known-limits)

## What the chain is

A metal cluster's defences are built from an **ordered list**: native
`CMilitaryManager::DefaultMakeDefence` walks it and builds as far down as the
income budget for that point allows, so position in the list *is* priority.
`Military::Porc::MakeDefence` (`manager/porc_policy.as`) decides how much of it
a given visit may take by setting `porcMode` and `porcBudgetMod`; the chain
decides *what*.

There are two chains per side, land and water.

## The default, and where it comes from

`build_chain.json`'s `porcupine` block, and `build_chain_leg.json` for Legion:

```json
"porcupine": {
    "unit": {
        "armada": ["armllt", "armtl", "armrl", "armbeamer", "armhlt", ...],
        "cortex": ["corllt", "cortl", "corrl", "corhllt", "corhlt", ...]
    },
    "land":  [0, 2, 3, 3, 4, 3, 7, 5, 12, ...],
    "water": [1, 1, 19, 1, 4, 9, 10, 9, 10]
}
```

`unit` is an ordered per-side list; `land` and `water` are arrays of **indices
into it**, and they are shared across sides — index 12 is `armamb` for Armada,
`cortoast` for Cortex and `legbastion` for Legion, so the side lists are
positionally aligned by intent. `CMilitaryManager::ReadConfig` resolves them
once into `SSideInfo::landDefenders` / `waterDefenders` and marks every def
with the `FENCE` attribute so it counts toward cluster defence cost.

Two consequences of that format: the ordering is **one list shared by every
role**, and it is **frozen at config load**.

## Role control

`RoleConfig` has a `PorcChainHandler` slot. `PorcHelpers::ApplyForRole()` runs
once from `Setup::setupMap`, after the role's `InitHandler` — so a delegate
sees its own start caps already applied — and either calls the delegate or
applies the default.

A role's delegate reads the default, edits it and writes it back:

```angelscript
void Tech_PorcChain(const string &in side)
{
    array<string>@ land = PorcHelpers::DefaultChain(side, false);
    PorcHelpers::Prioritise(land, UnitHelpers::GetAntiNukeNameForSide(side), 3);
    PorcHelpers::Remove(land, array<string> = {"armjuno"});
    aiMilitaryMgr.SetPorcChain(side, false, land);

    aiMilitaryMgr.SetPorcChain(side, true, PorcHelpers::DefaultChain(side, true));
}
```

registered as `@cfg.PorcChainHandler = cast<PorcChainDelegate@>(@Tech_PorcChain);`.

A role that registers nothing keeps the config order plus the content tiers
below.

Helpers for the common edits: `DefaultChain`, `Prioritise(chain, name, index)`,
`Replace(chain, from, to)`, `Remove(chain, names)`, `Contains`, `AppendTier`,
and `ForSide(table, side)` for the per-side name tables.

### Who registers one

| Role | Handler | Edit |
| --- | --- | --- |
| SUPPORT | `Support_PorcChain` | Swaps the side's Juno for its ranged tactical launcher — `armemp`, `cortron`, `legperdition`. See [`roles/support.md`](roles/support.md#porcupine-chain-the-launcher-swap). |
| AIR | `Air_PorcChain` | A full replacement order that leads with flak and long-range AA and repeats them; fewer ground pieces; Juno, gates, LRPCs, EMP kept. See [`roles/air.md`](roles/air.md#porc-air-denial-first). |

The other four roles keep the default. Their orderings are a tuning exercise
that wants game evidence first.

### Position is a budget threshold

This is the thing to understand before editing a chain.
`DefaultMakeDefence` accumulates `totalCost` as it walks and breaks once it
passes `maxCost = amountFactor × metal income`, with `amountFactor` between 32
and 48 by map size. An entry is therefore reachable only by a cluster whose
income clears the *cumulative* cost of everything before it:

| Land position | Cumulative (Armada) | Income needed |
| --- | --- | --- |
| 7 (`armjuno`) | 2 565 | ~64 |
| 10 (`armamd`) | 9 065 | ~225 |
| 16 (`armemp`) | 24 865 | ~620 |
| 28 (`armvulc`) | 123 025 | ~3 000 |

Everything past the low teens is decoration. Moving a unit *later* does not
deprioritise it, it deletes it; `Replace` exists because swapping in place is
the only edit that preserves how often an entry is actually reached.

An unavailable def is skipped *before* its cost is added, so a T2 entry costs
a T1-era cluster nothing.

## Mod options

Content options gate whole unit tiers, and the policy that names units has to
branch on them. `Setup::CheckModOptions` now sets:

| Flag | Mod option |
| --- | --- |
| `Global::ModOptions::ExperimentalLegionFaction` | `experimentallegionfaction` |
| `Global::ModOptions::ExperimentalExtraUnits` | `experimentalextraunits` |
| `Global::ModOptions::ScavUnitsForPlayers` | `scavunitsforplayers` |

`ExperimentalLegionFaction` was declared in `global.as` and **never assigned**
before this change; the other two were read only in each profile's `init.as`
for fragment selection and never reached the shared graph.

**Legion** needs no chain handling: the fragment system already supplies a
`legion` side list from `build_chain_leg.json`, so the default chain is
correct for a Legion game.

**Extra Units** is handled **additively**, because the pack adds a tier of
statics rather than replacing any: when `experimentalextraunits` is on,
`PorcHelpers::ExtraUnitsLand` / `ExtraUnitsWater` are appended after the
vanilla order, skipping anything already present.

| Side | Land | Water |
| --- | --- | --- |
| Armada | `armlwall` Dragon's Fury, `armgatet3` Asylum | `armgplat`, `armfrock` |
| Cortex | `cormwall` Dragon's Rage, `corgatet3` Sanctuary | `corgplat`, `corfrock` |
| Legion | `legrwall` Dragon's Constitution, `leggatet3` Elysium | — |

**Scavenger** has the same hook (`ScavUnitsLand`) with empty lists: the hook is
visible, the content choice is not yet made.

Appending puts the new tier *last*, which is right for a tier that is later and
more expensive. A role that wants one of them earlier uses `Prioritise`.

## The script API

Two native methods on `aiMilitaryMgr`:

```angelscript
array<string>@ GetPorcChain(const string &in side, bool isWater) const;
bool SetPorcChain(const string &in side, bool isWater, const array<string>@ names);
```

`Get` returns the current chain as unit names. `Set` resolves them back to
defs, **logs and skips anything not loaded**, applies the `FENCE` attribute
like the JSON path, and refuses an edit that resolves to nothing — so a chain
naming units from an inactive mod option degrades to the units that do exist
rather than emptying the chain.

Because it is names in and names out, a chain change needs no rebuild: refresh
the deployed `script/` tree and restart the match.

## Known limits

1. **Only SUPPORT registers a handler.** The other five roles get the default
   plus content tiers. Per-role orderings need game evidence to tune.
2. **The mini plasma pieces are missing from the Extra Units tier.**
   `armminivulc`, `corminibuzz` and `legministarfall` exist in BAR
   (`units/Scavengers/Buildings/DefenseOffense/`) and belong in the tier, but
   are absent from the shared unit cache, so
   `tools/knowledge/check_unit_helpers.py` rejects the ids. The cache has
   partial Extra Units coverage — `armlwall` and the shields are in it, these
   are not. Add them once the cache covers the pack.
3. **`land` and `water` indices are shared across sides**, so the JSON format
   requires the side lists to stay positionally aligned. The script API works
   in names and does not have this constraint, but editing the JSON still does.
4. **Not verified in a game.** The native accessors, the setup call and
   SUPPORT's swap all build; no match has exercised them. The swap's visible
   evidence will be a `[Porc] SUPPORT: <side> swapped 1 x <juno> -> <launcher>`
   line at setup, and the launcher appearing in defence build orders once T2 is
   up.

## Related

- [`intent.md`](intent.md) — why policy like this belongs in script.
- [`extra_units.md`](extra_units.md) — the full Extra Units Pack catalogue.
- `data/script/src/manager/porc_policy.as` — how *much* of the chain a visit
  may build.
