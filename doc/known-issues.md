# Known issues

The register of **diagnosed but unresolved** problems in this repository: what
is wrong, why it was not fixed, and what fixing it would take. An issue belongs
here once someone has understood it well enough to describe a solution. A
suspicion that has not been traced to code does not belong here yet.

This is the single index. Two problems are large enough to have their own
documents and are indexed here rather than duplicated:
[`bomber-targeting.md`](bomber-targeting.md) and
[`t2-constructor-stall.md`](t2-constructor-stall.md). Role-layer findings that
the role-doc tooling already enforces live in
[`roles/README.md`](roles/README.md) and are indexed here the same way.

## Contents

- [How to use this register](#how-to-use-this-register)
- [Native C++ (KI-1xx)](#native-c-ki-1xx)
- [AngelScript policy (KI-2xx)](#angelscript-policy-ki-2xx)
- [Configuration and data (KI-3xx)](#configuration-and-data-ki-3xx)
- [Process, tooling and verification (KI-4xx)](#process-tooling-and-verification-ki-4xx)
- [Indexed elsewhere](#indexed-elsewhere)
- [Maintaining this register](#maintaining-this-register)

## How to use this register

| Field | Meaning |
| --- | --- |
| **ID** | `KI-<area><nn>`. Stable for the life of the issue; never reused after closure. |
| **Severity** | **High**: wrong behaviour in a normal game, or a crash risk. **Medium**: a feature is inert, degraded, or silently misconfigured. **Low**: dead code, duplication, cosmetic or diagnostic-only. |
| **Location** | The file, and line numbers where they are stable enough to be useful. Prefer symbol names. |
| **Problem** | What is actually wrong and what it costs at runtime. |
| **Proposed solution** | Enough detail to start work: the approach, the files to touch, and the traps. |
| **Verification** | How to know it is fixed. Static checks are not enough for anything behavioural. |

Severity is about impact on a played game, not on how annoying the code is.

---

## Native C++ (KI-1xx)

### KI-101 — Super-weapon angle weighting distorts target choice

**Severity**: Medium
**Location**: `src/circuit/task/static/SuperTask.cpp`, `CSuperTask::Update`, the
`else` branch of the group scan

**Problem.** Once a super weapon has fired and its state is `ENGAGE`, candidate
groups are compared with an angle weight meant to model turn delay:

```cpp
const float angleMod = M_PI / (2.f * (std::acos(targetVec.dot2D(newVec)) + 1e-2f));
if (cost >= group.cost * angleMod) { continue; }
```

A group on exactly the previous firing bearing gets `angleMod ≈ 157`; at 90° it
is ≈ 1.0 and at 180° ≈ 0.5. The weapon therefore treats a group in front of it
as up to 157× more valuable than one behind, and keeps hammering one bearing.
The comparison is also inconsistent: `cost` accumulates the *raw* `group.cost`
while candidates are compared against the *modified* value.

The code carries its own `// TODO: Use WeaponDef::GetTurnRate() for turn-delay
weight`, so the weight was always a placeholder. It matters for vertical-launch
weapons with no meaningful turn constraint — which is most of them. Junos no
longer reach this branch (they take the pulse path), but nuclear silos,
tactical missile launchers, EMP silos and LRPCs still do.

**Proposed solution.** Derive the weight from the weapon instead of assuming
one. In `CWeaponDef`, cache `def->GetTurnRate()` alongside `range`/`aoe`. In the
scan, compute the turn delay as the angle divided by the turn rate, convert it
to frames, and express the weight as a mild preference — for example
`angleMod = 1.f / (1.f + turnDelayFrames / float(TARGET_DELAY))`, bounded to
something like `[0.5, 1.0]`, so the bearing can only ever break a near-tie
rather than overwhelm a 100× cost difference. A turn rate high enough to face
any bearing within one `TARGET_DELAY` should produce `angleMod == 1` and remove
the bias entirely. Also store the modified value in `cost` so the comparison is
consistent, or keep a separate `bestScore`.

**Verification.** Not static-checkable. Run a match with a nuclear silo and an
LRPC and confirm from the `SUPER ...` log lines that consecutive targets are not
clustered on one bearing when a more expensive group exists elsewhere in range.

### KI-102 — Mobile pulse weapons never reach the pulse policy

**Severity**: Medium
**Location**: `src/circuit/module/MilitaryManager.cpp`, `CMilitaryManager::MakeTask`
role→task map; `src/circuit/task/static/SuperTask.cpp`

**Problem.** `CSuperTask::SelectPulseTarget` implements Juno target priority,
but it only runs for units that get a `CSuperTask`. The role→task map sends a
`super`-role unit to `Enqueue(TaskF::Common(cdef->IsMobile() ? ATTACK : SUPER))`,
so a **mobile** pulse weapon gets an ordinary attack task instead.

The concrete case is `legcib` (Blindfold, Legion air, 100 M / 3,500 E) which
carries `juno_pulse_mini`: the same kill lists, AoE 500, a 250/7 s denial ring
and no stockpile. It is the cheap, repeatable Juno, and it is the one variant
the priority policy cannot steer. Tagging it with the `juno` role changes
nothing, because nothing on the ATTACK path reads the pulse config.

**Proposed solution.** Two options, in preference order:

1. **A mobile pulse task.** Add a small `CPulseTask` (or a flag on the existing
   bomber/attack path) that reuses `SelectPulseTarget`'s candidate collection
   and ranking, then flies the unit to the aim point and attack-grounds it. The
   selection logic should be factored out of `CSuperTask` into a free function
   or a helper on `CMilitaryManager` so both call sites share it — that shared
   helper is the real work; the task shell is thin.
2. **Cheaper interim.** In `CMilitaryManager::MakeTask`, route a mobile def that
   carries the pulse role to `SUPER` anyway. `CSuperTask` assumes a static
   `position` captured in `Start()`, so this needs `position` refreshed from the
   unit each `Update()` and the range check done from the unit's current
   position. Less clean, but far less code.

Either way `legcib` then needs `"juno"` appended to its `role` array in
`behaviour_leg.json` (all profiles), which is currently `["super", "air"]`.

**Verification.** A Legion game with Blindfolds built and an enemy radar net;
confirm `PULSE legcib(...)` log lines and that the aircraft flies to sensors
rather than to the nearest enemy.

### KI-104 — EMP salvo size ignores which silos can reach the point

**Severity**: Low
**Location**: `CMilitaryManager::GetEmpSalvoSize`
(`src/circuit/module/MilitaryManager.cpp`), consumed by
`CSuperTask::SelectEmpTarget`

**Problem.** Paralysis accumulates, so a target too healthy for one EMP shot
can still be held by two or three landing together: the Scavenger Epic Bulwark
goes from no stun, to 1 s, to 21.5 s across one, two and three shots. The
viability test therefore multiplies the weapon's paralysis damage by a `salvo`
factor.

`GetEmpSalvoSize()` computes that factor as **every stocked EMP silo we own**,
without checking whether each one's 3 650 range covers the candidate point. On
a map where silos sit in different districts the factor is an over-estimate,
and a target can pass the viability test on the strength of shots that cannot
physically reach it.

The consequence is bounded rather than severe: the firing silo always covers
its own candidates by construction, so the first shot is never wasted on a
target it cannot stun *at all*. What can happen is that the follow-up never
arrives, leaving a target stunned for less than the policy predicted.

**Proposed solution.** Make the count positional. Pass the candidate position
into the salvo query and count only silos whose `GetMaxRange()` covers it:

```cpp
int CMilitaryManager::GetEmpSalvoSize(const springai::AIFloat3& pos) const
```

iterating `stockpilers` as now but adding
`unit->GetPos(frame).SqDistance2D(pos) < SQUARE(cdef->GetMaxRange())`.

The wrinkle is ordering: `SelectAreaTarget` needs the classifier to score a
candidate, and the classifier would now need the candidate's position to
compute the salvo. That is fine — the classifier already receives the
`SEnemyData`, so it can call the positional query itself. The cost is one
`stockpilers` walk per candidate; with a handful of silos and a few dozen
candidates that is negligible, but cache the result per position if the
candidate set ever grows.

Also consider requiring the follow-up shots to actually be *fired*: the policy
currently assumes a salvo it never orders. Aiming every stocked silo in range
at the same point is the natural companion change, and is what makes the
multi-shot arithmetic honest rather than hypothetical.

**Verification.** An Armada game with two EMP silos in different districts:
confirm from the `EMP ...` log lines that a target only reachable by one of
them is judged on one shot, not two.

### KI-105 — Bomber splash value (P4) is unimplemented

**Severity**: Low
**Location**: `CBombTask::FindTarget` (`src/circuit/task/fighter/BombTask.cpp`),
the block that still carries `FIXME: Finish`

**Problem.** Target value is `cost / max(health, 1)` for the single best
candidate. It does not account for what else the blast would catch, so a lone
4 000-metal target always beats three 1 500-metal targets standing together,
even though the second is worth more metal per pass.

The area mode added alongside it compensates by *count* — it spreads into a
line when `area_min_targets` candidates sit inside `area_radius` — but count is
a crude proxy for value. A cluster of three nanos and a cluster of three
converters are treated identically.

**Proposed solution.** Phase P4 of [`bomber-targeting.md`](bomber-targeting.md),
now unblocked because `CWeaponDef::GetAlpha()` and `GetEdgeEffectiveness()`
exist:

```cpp
float metalKilled = 0.f;
for (int enemyId : circuit->GetCallback()->GetEnemyUnitIdsIn(ePos, trueAoe)) {
    CEnemyInfo* ei = circuit->GetEnemyInfo(enemyId);
    if (ei == nullptr) { continue; }
    const float dist = ePos.distance2D(ei->GetPos());
    const float falloff = 1.f - (1.f - edgeEff) * (dist / trueAoe);
    const float dealt = alpha * std::max(0.f, falloff);
    metalKilled += (ei->GetHealth() > dealt)
            ? (SPLASH_PARTIAL * ei->GetCost() * dealt / ei->GetHealth())
            : ei->GetCost();
}
const float value = metalKilled / std::max(health, 1.f);
```

The perf caution from the original plan stands: `GetEnemyUnitIdsIn` is an
engine query per candidate inside a loop over all known enemies. Restrict it to
candidates that already clear a cost threshold, and measure before and after.

With this in place the area-mode trigger should switch from a candidate *count*
to summed splash value, which is the honest version of the same idea.

**Verification.** From the `BOMB:` log lines, a group offered one fat target
and a denser cheap cluster of higher total value picks the cluster.

---

### KI-106 — Closed: the Eight Horses crash was a role mask passed as a role index

**Severity**: High — **fixed and symbolised**
**Location**: `Military::UpdateEnemyThreatCache` / `UpdateEnemyCostCache`
(`data/script/src/manager/military.as`); guard in
`CEnemyManager::GetEnemyThreat` / `GetEnemyCost`
(`src/circuit/unit/enemy/EnemyManager.h`)

**Problem.** Two games on Eight Horses died at `f=181` and `f=180` with an
access violation. The second crash was on a deployed DLL whose md5 matched the
build on disk, so `addr2line` gave the real answer:

```
circuit::CEnemyManager::GetEnemyThreat(int) const at EnemyManager.h:84
CallSystemFunctionNative ... asCContext::Execute ...
circuit::CInitScript::Update() at InitScript.cpp:816
```

`GetEnemyThreat` and `GetEnemyCost` index `std::array<SEnemyInfo, 64>` by role
**index**. `military.as` read `FactoryProduction::roleMaskCache` — which holds
role **masks** — and passed those. A mask is `1 << index`, so `"super"`
(index 18) arrived as 262 144 and read two megabytes past the array. Roles with
small indices read heap garbage without faulting, which is why the symptom for
a long time was a threat cache full of nonsense rather than a crash.

The trigger was mine: `FactoryProduction::BuildRoleCaches()` was made
unconditional earlier in the same session, precisely because the caches were
otherwise empty and every threat read zero. Making the cache live turned a
dormant type confusion into a deterministic crash at the first cache refresh.

**The first diagnosis was wrong.** A null dereference in
`CMapManager::IsSuddenThreat` was found on a plausible path and fixed; the
crash recurred at the same frame. That fix is a genuine null-guard and stays,
but it was never the cause, and the register said so at the time because the
deployed binary did not match the symbols. The lesson is the procedure, not the
patch: **do not accept a diagnosis from a binary you cannot symbolise.**

**Fix.** Both halves:

1. `FactoryProduction::roleTypeCache` — the same roles in indexed form —
   alongside `roleMaskCache`, and both `military.as` call sites read it.
2. `CEnemyManager::IsRoleIndex` bounds-checks both accessors, logs the first
   eight offenders naming the accessor and the index, and returns 0. A script
   cannot reach out-of-bounds memory through these again.

**Verification.** Symbolised: deployed md5 `e0dbc2b4b1f2cadd905362d11523014f`
matches the build, `ImageBase 0x1e33b0000`, RVA `0x43ef63`. A game on Eight
Horses must now pass `f=180` with no access violation, and no
`GetEnemyThreat: role index ... out of range` line in the log. **Not yet run.**

---

### KI-107 — A surplus mobile sensor has no job of its own

**Severity**: Low
**Location**: `CSupportTask::Update` / `FindCandidates`
(`src/circuit/task/fighter/SupportTask.cpp`)

**Problem.** The escort cap fixes the pile-up, but it does not give the
sensors it turns away anything to do. When every squad already holds its one
escort, the rest fall through to `Start(unit)`, which parks them on a random
radial position around the base. They are not useless there — base radar
coverage is worth something — but a mobile radar bot standing at home is worth
much less than one extending vision over a contested expansion, and a jammer at
home is worth nothing at all.

This is a smaller version of the original complaint: the units still bunch, just
at base instead of behind a sharpshooter.

**Proposed solution.** Give the surplus a picket task rather than a parking
spot. Two candidates, in order of value:

1. **Radar pickets.** Rank the map's metal clusters by enemy influence and our
   own radar coverage (`CMapManager::IsInRadar` exists now), and station surplus
   radar bots on the highest-ranked uncovered ones, one per cluster. This is the
   same rationing logic as the escort cap, against a different set of slots.
2. **Jammer screens.** A jammer is worth most sitting on the approach a push
   will use, not at base. Station surplus jammers on the front-facing edge of
   the nearest defended cluster.

Both want the count capping too, or the factory keeps producing sensors that
have nowhere to go. The real fix for the excess is upstream in production
policy: the factory should stop queuing sensors once the map is covered, which
is AngelScript's call, in `FactoryProduction`.

**Verification.** With more sensors than squads, the surplus spreads across
distinct uncovered clusters rather than sharing the base ring, and no two
occupy the same cluster.

---

### KI-108 — Script sees only the low 32 bits of a role mask

**Severity**: Medium
**Location**: `CInitScript::RegisterScript` (`src/circuit/script/InitScript.cpp`),
`RegisterTypedef("Mask", "uint")` and the `TypeMask::mask` property

**Problem.** `CMaskHandler::Mask` is 64-bit. AngelScript's `Mask` is registered
as `uint`, and `TypeMask::mask` is exposed at the native field's offset, so
script reads the **low 32 bits** of a 64-bit value.

For the twenty built-in roles (indices 0-19) that is lossless. For the custom
roles added in `unit.as` — `anti_nuke`, `jammer`, `radar`, `emp`, `juno`,
`spam` and the rest, which sit above index 31 — the true mask has no bits in
the low word, so script reads **0**.

This only became true with the `MaskHandler::GetMask` 64-bit fix
([KI-1xx history](#native-c-ki-1xx)). Before it, `1 << type` for `type >= 32`
was undefined and in practice aliased down into the low word, so script read a
wrong but non-zero value. Neither is correct; zero is at least honest.

Nothing in the tree currently masks on a custom role from script — every
`.mask` use is a built-in role or an attribute — so this is latent. The first
script that writes `def.IsRoleAny(Unit::Role::JAMMER.mask)` will get a silent
constant false.

**Proposed solution.** Register `Mask` as `uint64`:

```cpp
r = engine->RegisterTypedef("Mask", "uint64"); ASSERT(r >= 0);
```

The trap is the 37 existing `.mask` uses. `IsRoleAny(Mask)` and friends widen
harmlessly, but `int(Unit::Role::X.mask)` in `factory_production.as` becomes a
narrowing cast the compiler may warn on — and warnings are errors. Audit those
sites in the same change; `roleMaskCache` should probably hold `uint64` too, or
be dropped entirely in favour of `roleTypeCache` where the consumer wants an
index.

**Verification.** A script log of `Unit::Role::JAMMER.mask` prints a non-zero
value, and `IsRoleAny` on a custom role matches the defs the config tags.

---

### KI-109 — Spam activates and then produces nothing, and the log cannot say why

**Severity**: Medium
**Location**: `Spam::FactoryMakeTask`, `Spam::Update`
(`data/script/src/manager/spam.as`)

**Problem.** In a 16-AI game on Eight Horses spam activated for two AIs and
then did nothing at all:

```
[f=19115] [Spam] Focus set to (7729,4835); 0 route(s) rebuilt
[f=19115] [Spam] Activated: mi=82.0178 ei=2414.58 focus=(7729,4835)
[f=19242] [Spam] Activated: mi=71.5658 ei=2591.47 focus=(4595,7440)
```

No `[Spam] Route created for factory ...` line follows either, and that line
logs at verbosity 2 — the level the "Focus set" line above it printed at. So no
route was built, no unit was assigned, and the feature did nothing in the 74
seconds of game that remained.

**The activation threshold is not the bug.** `MinEnergyIncome = 1500` is
deliberate: spam is a fusion-era behaviour, because below that economy the same
units — Pawn, Grunt, Goblin, Blitz — are ordinary front-line combat units and
the roles should keep spending them as such. Spam is what a mature economy does
with T1 factories it no longer needs for front-line units, which is why
`UnitByFactory` lists only the nine T1 labs, vehicle plants and hovercraft
platforms. Both are by design.

What is wrong is that **nothing between activation and a unit moving is
logged**, so the actual blocker cannot be identified. `FactoryMakeTask` has
three silent `return null` paths, and for AI 5 — role FRONT, side armada,
factory `armvp`, which *is* in `UnitByFactory` — at least one of them fired
every time it was asked:

1. the factory is not in `UnitByFactory` (expected for T2/T3/air/sea);
2. the spam unit is not a loaded def;
3. `IsAvailable(frame)` is false — a role start limit or a reached unit cap.

(3) is the strongest candidate for AI 5 and cannot be confirmed from the log.
`MilitaryMakeTask` then can never run either: it returns null while
`routeByFactory` is empty, and only `FactoryMakeTask` fills it.

**Fix applied (diagnostics only).** `FactoryMakeTask` now reports which guard
rejected a listed factory, and `Spam::Update` reports the income shortfall once
a minute while inactive. Both are memoised — a factory that asks every few
seconds logs one line per change of answer, not hundreds. The "not a spam
factory" case stays silent because it is the normal answer for most factories.

**Still open: the underlying cause.** The diagnostics do not fix anything; they
make the next game name the guard. Once it does:

- if it is `IsAvailable`, find which limit zeroes the spam unit and decide
  whether spam should raise that cap while active — a role that capped a T1
  unit for front-line reasons has no reason to cap it for spam;
- if the listed factories are simply gone by fusion era, the design needs a
  way to keep or rebuild one T1 factory as a spam pump, since spam by
  definition starts only once the economy has moved past them.

**Verification.** A game reaching fusion economy logs `[Spam] Activated`
followed either by `[Spam] Route created for factory ... lane ...` and spam
units moving down the lane, or by a
`[Spam] <factory> (<id>) not spamming: <reason>` line naming the blocker.

---

### KI-110 — A stockpiled super weapon holds its shot until it dies

**Severity**: High
**Location**: `CSuperTask::Update`, the `maxCost` floor
(`src/circuit/task/static/SuperTask.cpp`); group value in
`CEnemyManager::KMeansIteration` (`src/circuit/unit/enemy/EnemyManager.cpp`)

**Problem.** A TECH player's `corsilo` charged one missile and was destroyed
before the second. It never fired, and the reason is in the log:

```
SUPER corsilo(17768): no target | range=72000 regional=0 groups=16 inRange=16
      rejInfl=5 rejSquad=0 rejIgnore=0 bestCost=640 minCost=1500
```

Sixteen enemy groups, all sixteen inside the 72 000 range, none rejected for
sitting near our own squads or for ignore flags. Five were rejected by the
influence rule, which is deliberate for a map-range weapon. **The binding gate
was cost**: the best surviving group was worth 640 metal against a floor of
1500, which is exactly `crblmssl`'s `metalpershot`. The same line repeats every
60 seconds (f=27255, 29065, 30868) with the same numbers until the silo
dies.

**Provenance.** Three separate changes, years apart, and the one that broke it
is from this session.

| # | Fault | Introduced | Author |
| --- | --- | --- | --- |
| 1 | The cost floor became the full shot cost | **uncommitted, this session** | this session's Juno work |
| 2 | Value measured over a k-means cell, not the AoE | `bbfc1dde` "Add CaptureAction", 2021-11-04 | rlcevg (upstream) |
| 3 | Group value collapses without vision | `cbbb5efc` "Update enemy groups per allyteam...", 2020-01-22 | rlcevg (upstream) |
| - | The `isRegional` influence split and this diagnostic | `d37af50f` "Implement orphan rescue mechanism...", 2026-09-18 | ours |

**1. The cost floor is a sunk cost — and it is a regression.** `bbfc1dde`
wrote the floor as

```cpp
const float maxCost = cdef->IsAttrStock() ? cdef->GetWeaponDef()->GetCostM() : cdef->GetCostM() * 0.01f;
```

`CWeaponDef::GetCostM()` on a stockpile weapon is the **per-second stockpiling
rate**, not the cost of a shot — `metalpershot / stockpiletime`. That is a unit
mismatch: a rate compared against a group's absolute metal cost. It was a
latent type error that happened to behave well, because the resulting floor was
tiny and effectively meant "fire at any group at all":

| Weapon | metalpershot | stockpiletime | old floor (rate) | new floor (shot) |
| --- | --- | --- | --- | --- |
| `crblmssl` (corsilo) | 1500 | 180 | **8.33** | **1500** |
| `nuclear_missile` (armsilo) | 1000 | 120 | 8.33 | 1000 |
| `juno_pulse` | 200 | 75 | 2.67 | 200 |
| `armemp_weapon` | 500 | 65 | 7.69 | 500 |

This session's Juno work corrected the unit mismatch to `GetCostMShot()`. That
is dimensionally right and behaviourally wrong: it raised the nuke's floor
**180-fold**, from 8.33 to 1500, and the silo stopped firing. The Juno's floor
rose 75-fold at the same time, which is why `corjuno` in the same log sits at
`bestCost=50 minCost=200` and is equally mute.

The deeper error is that the shot cost is **already sunk** once the missile is
stockpiled. Treating it as the price of firing asks "is this target worth 1500
metal" when the real question is "is this the best target I will get before I
lose the missile". Holding for break-even and then dying with the shot in the
tube is the worst available outcome, and it is the one the rule now selects.

The same change also removed the `isRegional &&` guard on the diagnostic, which
is the only reason the nuke's failure is visible at all — under `d37af50f` a
map-range weapon never logged.

**2. The value is measured over the wrong area.** `crblmssl` has an
`areaofeffect` of 1920. The floor is compared against one k-means cell, not
against the metal standing inside the blast. `KMeansIteration` picks
`newK = min(32, 1 + sqrt(enemyCount))`, so the cell size is a function of how
many enemies are known, not of the weapon — the denominator and the weapon's
footprint are unrelated quantities. Same class of error as
[KI-105](#ki-105--bomber-splash-value-p4-is-unimplemented).

**3. Group value collapses without vision.** `cbbb5efc` accumulates

```cpp
if (enemy.cdef != nullptr) {
    if (!enemy.cdef->IsMobile() || enemy.IsInRadarOrLOS()) { eg.cost += enemy.cost; }
} // else: influence only, no cost at all
```

An unidentified contact is worth zero; a mobile is worth zero unless
*currently* in radar or LOS. Identified statics persist, so a scouted enemy
base keeps its value, but a TECH player with little forward vision reads the
map as far poorer than it is. That is how sixteen groups came to peak at 640
metal. On its own this was harmless — against a floor of 8.33 it never
mattered. It only becomes load-bearing once fault 1 raised the floor into the
range where group value decides anything.

**Proposed solution.** Take these in order; the first is the one that matters.

0. **Decide the floor's meaning first.** Reverting to `GetCostM()` restores
   the old behaviour but reinstates the unit mismatch; the honest version is a
   floor expressed in the same units as a group's cost and set deliberately,
   not one that happens to be tiny.
1. **Decay the floor for a stockpiled weapon.** Add to the super-weapon config
   a `stock_patience_seconds` and a `stock_min_fraction`. While a shot is
   stocked, scale `maxCost` from the full `GetCostMShot()` down to
   `min_fraction` of it over `patience` seconds, resetting on fire. A nuke then
   waits for a good target for a few minutes and afterwards takes the best one
   available, rather than waiting forever. Suggested start: 240 s to
   0.25 — a nuke that has sat loaded for four minutes will fire at a
   375-metal cluster.
2. **Value the target by metal inside the AoE**, not by k-means cell: sum
   `GetEnemyUnitIdsIn(group.pos, aoe)` costs, with the perf caution from
   KI-105 (restrict to groups that already clear a reduced floor).
3. **Do not let an unscouted map read as an empty one.** Either exclude
   unidentified contacts from the *denominator* as well, or fold a scouting
   confidence term into the floor. This one wants a decision about intent
   before code.

**Verification.** A silo that has held a stocked missile past the patience
window fires at the best target available, and the `SUPER ... no target` line
shows `minCost` falling over successive reports rather than sitting at 1500.

---

## AngelScript policy (KI-2xx)

### KI-201 — The dynamic factory production system is entirely inert

**Severity**: Medium
**Location**: `data/script/src/global.as:382, 648, 801, 880`;
`data/script/src/manager/factory_production.as` and the five
`manager/factory_production/factory_configs_*.as` tables

**Problem.** Four role settings blocks declare
`bool UseDynamicFactoryProduction = false` (Air, Front, Sea, Tactical) and TECH
and SUPPORT do not declare it at all. Every one is `false`, so
`FactoryProduction::Initialize()` is never called and
`FactoryProduction::MakeTask` is never reached. That leaves roughly 1,750 lines
— `factory_production.as` plus the bot, vehicle, air, hover and sea
configuration tables — as dead code that nonetheless has to be read, maintained
and kept compiling.

This was also the root of a separate, now-fixed defect: the enemy threat and
cost caches resolved their role masks through a table that only
`Initialize()` filled, so every cached value was zero. That is fixed
(`Setup::setupMap` now calls `FactoryProduction::BuildRoleCaches()`
unconditionally), but the production system itself remains switched off.

**Proposed solution.** Decide, per role, rather than leaving it ambiguous:

- To **adopt** it, enable one role at a time (FRONT first — it has the most
  complete unit tables), play several games at each difficulty against each
  faction, and compare army composition against the `factory.json` behaviour it
  replaces. The tables reference unit ids that
  `tools/knowledge/check_unit_helpers.py` validates, so start by running that.
- To **retire** it, delete `factory_production.as`, the five config tables and
  the four `UseDynamicFactoryProduction` settings, and move
  `BuildRoleCaches()` (which is genuinely needed by `Military`) into
  `military.as` where its only consumer lives.

Leaving it as-is is the worst of the three: the cost of carrying it with none of
the benefit.

**Verification.** If adopted: in-game composition comparison per role. If
retired: the two checker scripts still exit 0, and the experimental profiles
still load.

### KI-202 — Defence predicates are unimplemented stubs

**Severity**: Low
**Location**: `data/script/src/helpers/defense_helpers.as`

**Problem.** Every predicate in the file (`ShouldBuildT1LightAA`,
`ShouldBuildT1LightTurret`, `ShouldBuildT1Arty`, and the rest of the ~88-line
file) returns `false` with a `// TODO` describing what it should decide. No
caller can therefore ever get a `true`, so roles fall back to explicit defence
enqueues or to the native porcupine placement.

This is harmless at runtime but actively misleading: the file reads like a
defence policy layer and is named as one.

**Proposed solution.** The useful predicates are the ones the shared porcupine
policy cannot express, because `Military::Porc::MakeDefence`
(`manager/porc_policy.as`) already handles budget and mode well. Implement
only those, against the data the script can actually see:

- `ShouldBuildT1LightAA` / `ShouldBuildT1MediumAA`: compare
  `Military::GetCachedRoleThreat("air")` and `GetCachedRoleCost("bomber")`
  against our own AA cost, now that those caches return real values.
- `ShouldBuildT1LightTurret`: gate on `aiEnemyMgr.mobileThreat` and the raider
  role cost near a cluster.

Delete every predicate that is not implemented rather than leaving it returning
`false`, so the file's surface matches its behaviour.

**Verification.** `tools/knowledge/check_unit_helpers.py` exits 0; in-game, AA
appears in response to an enemy air opening and does not appear without one.

### KI-203 — Four `RoleConfig` contract slots have no implementation

**Severity**: Low
**Location**: `data/script/src/types/role_config.as`; coverage matrix in
`doc/roles/README.md`

**Problem.** `RoleConfig` declares 22 delegate slots plus three fields. Four
parts of that contract are never used by any of the six roles:

- `FactoryAiTaskAddedHandler` — never assigned
- `FactoryAiTaskRemovedHandler` — never assigned
- `MilitaryAiTaskAddedHandler` — never assigned
- `UnitMaxOverrides` — declared on the class, never written and never read

`MilitaryAiUnitRemoved` is assigned only by AIR, while FRONT assigns
`MilitaryAiUnitAdded` with no matching removal — an asymmetry that is a latent
leak if FRONT ever starts tracking units in that handler.

They cost a null check per call, which is trivial; the real cost is that the
contract implies capabilities the codebase does not have.

**Proposed solution.** Retire the three unused delegate slots and
`UnitMaxOverrides` from `role_config.as`, and remove the corresponding rows
from the coverage matrix in `doc/roles/README.md`. If a slot is wanted later it
costs three lines to re-add. For the asymmetry, give FRONT a
`Front_MilitaryAiUnitRemoved` that undoes whatever `Front_MilitaryAiUnitAdded`
records, even if that is currently nothing — the pairing is what stops the next
change leaking.

`tools/knowledge/check_role_docs.py` verifies the matrix against the wiring, so
run it with `--update` after the change.

**Verification.** `python tools/knowledge/check_role_docs.py` exits 0; all three
experimental profiles still load.

### KI-204 — Role selection machinery adds nothing over a direct lookup

**Severity**: Low
**Location**: `data/script/src/types/role_config.as` (`RoleConfigs::Match`);
`<Role>_RoleMatch` in all six `data/script/src/roles/*.as`

**Problem.** `RoleConfigs::Match` walks the registry and returns the first
config whose `RoleMatchHandler` returns true, which is designed to let a role
claim a start based on side, position or the default factory. All six
predicates reduce to `preferredMapRole == AiRole::<SELF>`, and all six accept
and ignore the `side`, `pos` and `defaultStartFactory` parameters. The
first-match-wins ordering is therefore irrelevant today — but it would
silently start to matter the moment one predicate stops being an identity test,
because registration order in `Setup::RegisterRoles()` is arbitrary.

**Proposed solution.** Either use the mechanism or remove it.

- **Use it**: give at least one role a real predicate — the obvious candidate is
  SEA claiming a start whose nearest spot is water-adjacent regardless of the
  map's role hint — and make the ordering explicit by sorting the registry by an
  added `matchPriority` field rather than relying on registration order.
- **Remove it**: drop `RoleMatchHandler` and `RoleConfigs::Match`, and have
  `Setup::setupMap` call `RoleConfigs::Get(derivedRole)` directly. That is what
  the code does today in effect, and it is six fewer near-identical functions.

**Verification.** Load each experimental profile on a map with explicit start
spots (Supreme Isthmus has the richest set) and confirm the resolved role in
the `[GameDetails]` startup log matches the spot's hint.

### KI-205 — Start-limit application uses two incompatible styles

**Severity**: Low
**Location**: `Air_ApplyStartLimits`, `Front_ApplyStartLimits`,
`Sea_ApplyStartLimits`, `Support_ApplyStartLimits` versus
`Tactical_ApplyStartLimits`, `Tech_ApplyStartLimits`

**Problem.** AIR, FRONT, SEA and SUPPORT build a `dictionary` of hardcoded unit
names and call `UnitHelpers::ApplyUnitLimits`. TACTICAL and TECH call
`UnitHelpers::BatchApplyUnitCaps` over accessors such as
`UnitHelpers::GetAllT1BotLabs()` with values from `Global::RoleSettings`.

The first style hardcodes faction unit names inline, which is how Legion gets
silently omitted in places, and it puts caps in the role file instead of the
settings block where every other tunable lives. The second style is
faction-complete and data-driven.

**Proposed solution.** Convert the four dictionary-style roles to
`BatchApplyUnitCaps` over the `UnitHelpers::GetAll*` accessors, moving each
hardcoded number into the matching `Global::RoleSettings::<Role>` block as a
`StartCap*` value (TECH already has a full set to copy the naming from). Do one
role per change so a regression is attributable, and update the role's document
under `doc/roles/` in the same commit — the pre-commit hook enforces that.

**Verification.** `python tools/knowledge/check_unit_helpers.py` exits 0 (it
flags unit ids that are unknown, unreachable or the wrong faction, which is
exactly what the hardcoded lists get wrong). In game, compare the startup
`Set Unit Limit:` log lines before and after.

### KI-206 — Registered handlers with empty bodies

**Severity**: Low
**Location**: `Support_MainUpdate` (`roles/support.as:67`),
`Tactical_MainUpdate` (`roles/tactical.as:103`), `Tactical_EconomyUpdate`
(`roles/tactical.as:113`), `Air_EconomyUpdate` (`roles/air.as:406`)

**Problem.** Four delegates are registered and called on every tick or economy
update, and do nothing beyond a comment. The cost is a handful of script calls
per second, which is negligible; the cost that matters is that the coverage
matrix in `doc/roles/README.md` reports these roles as implementing behaviour
they do not implement.

**Proposed solution.** Delete the four functions and the `@cfg.<Slot> = ...`
lines that register them, so the slots fall through to the shared manager
behaviour — which is what happens today anyway. Update each role's document and
the coverage matrix, then run
`python tools/knowledge/check_role_docs.py --update`.

Keep `Tactical_MainUpdate`'s comment ("no periodic objective scanning
(performance). Selection occurs at Init.") somewhere — move it to
`doc/roles/tactical.md`, because it records a deliberate decision that would
otherwise look like an omission.

**Verification.** `check_role_docs.py` exits 0; profiles load; no behaviour
change is expected, so an unchanged game is the pass condition.

### KI-207 — Copy-paste defects in role logging and comments

**Severity**: Low
**Location**: `roles/sea.as:102`, `roles/support.as:174`,
`global.as` `Global::RoleSettings::Tactical` block

**Problem.** Three cosmetic defects that cost debugging time:

- `Sea_ApplyStartLimits` logs `"Tactical start limits applied"`.
- `Support_BuilderAiMakeTask` logs with a `[FRONT]` prefix.
- The whole `Global::RoleSettings::Tactical` settings block is commented as SEA
  (`"SEA BASE SETTINGS"`, `"Scout unit cap for SEA role"`) and is indented at 4
  spaces where the other five role blocks use 8.

Anyone filtering an infolog by role prefix gets the wrong role, which is a
genuine time sink given these logs are the main diagnostic channel.

**Proposed solution.** Correct the two log strings to `[SEA]` and `[SUPPORT]`,
rewrite the TACTICAL block comments to describe TACTICAL, and re-indent it to
8 spaces to match its siblings. Then grep every role file for a log string
naming a different role than the file it sits in — these three were found by
eye and others are likely.

**Verification.** `grep -n '\[FRONT\]' data/script/src/roles/support.as` and the
equivalents return nothing; `check_role_docs.py` exits 0.

### KI-208 — Dynamic military quota adjustment is inconsistent across roles

**Severity**: Low
**Location**: `Front_UpdateDynamicMilitaryQuotas` (`roles/front.as`),
`Air_UpdateDynamicMilitaryQuotas` (`roles/air.as`),
`Sea_UpdateDynamicMilitaryQuotas` (`roles/sea.as`)

**Problem.** FRONT, AIR and SEA each run a dynamic quota adjustment from
`MainUpdate` after a delay, but FRONT and AIR read the delay from a
compile-time constant (`FRONT_DYNAMIC_QUOTA_DELAY_FRAMES`,
`AIR_DYNAMIC_QUOTA_DELAY_FRAMES`) while SEA reads
`Global::RoleSettings::Sea::DynamicQuotaDelaySeconds` directly. The constants
are *initialised from* the settings, so they cannot be retuned at runtime and,
more importantly, a runtime role switch does not re-read them. TECH, SUPPORT and
TACTICAL have no dynamic quota logic at all.

The comparison itself only became meaningful with the enemy cost cache fix, so
this logic has effectively never run against real numbers.

**Proposed solution.** Two steps:

1. Make all three read the setting at call time, as SEA does. Delete the two
   constants.
2. Re-tune. With the cost cache now returning real values, the thresholds
   (`DynamicQuotaEnemyCostThresholdMultiplier` and the `Underpowered*Quota`
   values) have never been exercised against a non-zero enemy cost and should be
   treated as unvalidated guesses. Play each role against a known enemy
   composition and log `ourArmyCost` against `enemySurfaceCostPerPlayer` before
   changing numbers.

Whether TECH, SUPPORT and TACTICAL should have the logic is a design question,
not a defect — decide it explicitly and record the decision in their role docs.

**Verification.** In game, at the `[FRONT][Quota]`/`[AIR][Quota]`/`[SEA][Quota]`
log lines, confirm the underpowered state flips in both directions over a match
rather than latching once.

### KI-209 — Dead and partial script features

**Severity**: Low
**Location**: `data/script/src/types/profile.as`,
`data/script/src/types/opener.as`, `data/script/src/misc/commander.as`,
`Economy::AiLoad`/`AiSave` and the other manager save/load hooks

**Problem.** Several files are carried but not executed:

- `types/profile.as` (77 lines) is entirely commented out — a superseded profile
  model kept as design material.
- `types/opener.as` (113 lines) has exactly one reference in the tree, inside a
  commented-out block in `manager/factory.as`.
- `misc/commander.as` is three string constants plus a large commented-out
  "commander hiding" system.
- Every manager's `AiLoad`/`AiSave` is empty, so nothing script-side survives a
  save/load. Objective assignment, queued/built counts, spam routes, the team
  roster and air-wave state all reset.

**Proposed solution.** Split by intent:

- Delete `types/profile.as` and the commented-out commander hiding. Git history
  is the archive; a commented-out file is not.
- For `types/opener.as`, either wire it back into `Factory::AiUnitAdded` (the
  commented block shows how it was meant to work) or delete it. The per-factory
  opening build order it encodes is genuinely useful and overlaps with
  `MapConfig` factory weights — decide which owns openings before writing code.
- Save/load is a larger piece of work and deserves its own issue when someone
  commits to it. The minimum viable version is `ObjectiveManager`'s assignment
  and completion dictionaries plus `Team::Roster`, serialised through the
  `IStream`/`OStream` the hooks already receive.

**Verification.** Profiles load after deletion; for save/load, save and reload a
game mid-match and confirm objectives are not re-queued from scratch.

### KI-210 — Strategic objective placement is approximate and accounting is in-memory

**Severity**: Medium
**Location**: `data/script/src/helpers/objective_executor.as`,
`data/script/src/manager/objective_manager.as`,
`data/script/src/maps/supreme_isthmus.as`

**Problem.** Two related weaknesses in the strategic objective system:

- **Placement.** `MEX` and `GEO` objective steps build at the objective's
  anchor position rather than at a real metal or geo spot. `CMetalManager`
  knows where the spots are; the script does not consult it, so a mex step
  lands wherever the anchor happens to be and relies on native placement
  nudging it. Several Supreme Isthmus coordinates and radii are still marked
  `TODO precise` / `TODO tune` in the map file.
- **Accounting.** `ObjectiveManager` keeps assignment, completion, per-type
  queued and built counts in script dictionaries, and every manager's
  `AiLoad`/`AiSave` is empty. The counts also drift when a task is removed by a
  path the manager does not observe — a builder dying mid-task, or a task
  aborted natively — because only `AiTaskRemoved` decrements them.

The result is an objective that can be re-queued forever, or reported complete
when it is not.

**Proposed solution.** Split the two:

- For placement, expose metal and geo spot lookup to script (a
  `aiMetalMgr.GetNearestSpot(pos)` style binding registered in
  `InitScript.cpp`) and have `ObjectiveExecutor::TryEnqueueStep` resolve a
  `T1_MEX` / `T1_GEO` step to the nearest free spot within the objective's
  radius, failing the step if there is none. That also lets the objective
  radius mean something concrete.
- For accounting, reconcile rather than count. Replace the incremented
  `queued`/`built` counters with a recount derived from live state — the
  objective's concrete UnitDef `count` for built, and a scan of the builder
  manager's tracked tasks for queued — computed on demand and cached for a few
  seconds. A derived number cannot drift. Save/load then becomes unnecessary
  for this subsystem, which removes most of the reason to implement it.

**Verification.** On Supreme Isthmus, confirm an objective's mex step lands on
a metal spot; kill the assigned builder mid-step and confirm the objective is
re-queued exactly once rather than never or repeatedly.

### KI-211 — Dynamic production cannot build its unit-role cache safely

**Severity**: Medium
**Location**: `data/script/src/manager/factory_production.as`,
`BuildRoleCaches` and the disabled `unitRoleCache`

**Problem.** `FactoryProduction` declares a `unitRoleCache` mapping unit name to
its role list, and does not populate it. The code says why:

```
// NOT USED - scanning units during initialization causes engine crashes
// Use GetUnitsWithRole() for on-demand role queries during gameplay instead
```

So every role query walks the def list at decision time instead of reading a
cache. The crash was never root-caused — only avoided — which means the
underlying fragility is still there for anything else that iterates
`ai.GetCircuitDef(defId)` over the full range early in a game.

The most likely cause is iterating def ids before CircuitAI has finished
constructing every `CCircuitDef`, so a handle is null or partially built; the
setup path defers map/profile resolution to the first factory selection for
much the same reason.

**Proposed solution.** Root-cause it rather than working around it. Add a
temporary level-1 log of `defId`, the handle's nullness and
`ai.GetDefCount()` inside a small scan loop, run it from `Setup::setupMap`
(after the deferred point, where everything else is safe), and see whether the
crash still reproduces. If it does not, the original crash was an
initialisation-order problem that the deferred setup already fixed, and the
cache can be built there. If it does, symbolise the stack per
`skills/troubleshoot-bar-logs/SKILL.md` and fix the native side.

Note this is the same class of problem as the now-fixed role-mask cache: a
table that was only built on a path nobody takes. Build the unit-role cache in
`Setup::setupMap` next to `BuildRoleCaches()` once it is proven safe.

**Verification.** Load all three experimental profiles on a large map with
Legion and extra units enabled — the largest def count reachable — and confirm
no crash and a populated cache in the log.

### KI-212 — Profile entry points are duplicated and the three experimental profiles are identical

**Severity**: Low
**Location**: `data/script/{easy,medium,hard,hard_aggressive,experimental_balanced,experimental_hard,experimental_terrible}/{init.as,main.as}`

**Problem.** Every profile carries its own `init.as` and `main.as`, and the
three experimental ones are near-identical copies. After the enemy-cache fix
they differ only in a log string: same strategy weights (0.85 / 0.35 / 0.25 for
T2 / T3 / nuke rush), same factory tier tagging, and `ApplyProfileSettings()`
empty in all three.

`ApplyProfileSettings()` exists precisely to hold per-difficulty tuning and is
unused, so "balanced", "hard" and "terrible" differ only through their JSON
config. The duplication is also how the profiles drift: the missing enemy cache
refresh in two of the three was an unpropagated edit, not a difficulty choice.

**Proposed solution.** Collapse the shared body and keep the differences
visible:

1. Move the whole shared `main.as` body into `src/setup.as` (or a new
   `src/profile_main.as`) as `Main::SharedAiMain()` / `SharedAiUpdate()`.
2. Reduce each experimental `main.as` to the hooks plus a call to the shared
   function plus its own `ApplyProfileSettings()` body.
3. Put the actual difficulty differences in `ApplyProfileSettings()` — strategy
   weights first, since those are the one thing already parameterised. Decide
   what "terrible" and "hard" should mean and write it there rather than
   leaving it implicit in JSON.

Leave the four legacy profiles alone: their `main.as` files are intentionally
near-empty and share nothing.

**Verification.** All three experimental profiles load; the startup
`[Strategy] ... Decided:` log line differs between them in a way that matches
the intended difficulty.

### KI-213 — Metal extractor upgrades are never ranked against anything

**Severity**: High
**Location**: `Tech_BuilderAiMakeTask` (`data/script/src/roles/tech.as`), and the
equivalent chains in `roles/air.as`, `roles/sea.as`, `roles/support.as`,
`roles/front.as`

**Problem.** A role's builder chain is a sequence of independent gates: T2 lab,
air plant, **T1 converter**, T1 solar, nano, **advanced solar**, vehicle plant,
gantry, **T2 converter**, silo, anti-nuke, AFUS, fusion. Each gate asks "do I
pass my own threshold", and the first that says yes wins.

**A metal extractor upgrade is not in that chain at all.** The only mex-upgrade
path is a passthrough at the top of `Tech_BuilderAiMakeTask`: if the *native*
`DefaultMakeTask` happens to have chosen a `MEXUP`, the role re-issues it at
`Priority::NOW`. Whenever native proposes anything else, the script ladder runs
and a converter is built while an upgradeable extractor sits there.

This is the opportunity-cost failure described in
[`intent.md`](intent.md#playing-like-a-strong-player): the AI filters where a
player ranks. It is made worse by the fact that the T1 converter gate fires on
`metalIncome < 18` — precisely the condition a mex upgrade fixes better.

The arithmetic, at BAR values:

| Option | Metal in | Energy in | Metal out | True cost incl. energy |
| --- | ---: | ---: | ---: | ---: |
| Mex upgrade (`armmex` 50 M — `armmoho` 620 M) | 570 net | 7 700 once, 20/s upkeep | 4x that spot, ~+5.4 M/s typical | ~635 M |
| T2 converter (`armmmkr`) | 380 | 21 000 once, **600/s** | 10.34 M/s | ~2 320 M (600 E/s ~ 1 940 M of AFUS) |

Per metal invested the upgrade is roughly **1.9x** the converter once the
energy is priced, and extractor spots are **finite and contested** while
converters are not. Both arguments point the same way: upgrade first.

`Economy::MexTracker` already holds everything needed — owned mexes, upgraded
state, in-progress state, `GetNearestNonUpgradedMex`,
`GetNearestNonUpgradedMexInRange`, `AnyUpgradeInProgressNear` — and **only TECH
uses it**. AIR, SEA and SUPPORT build converters with the same gate shape and
never consult it.

**Proposed solution.** No C++ needed; this is a policy decision and belongs in
script per [`intent.md`](intent.md#the-architectural-rule).

1. **Add a shared gate** in `economy_helpers.as`:

   ```angelscript
   // A mex upgrade is the best metal-per-metal available and the supply is
   // finite. Anything that merely converts energy waits behind it.
   bool ShouldUpgradeMexFirst(CCircuitUnit@ u, const AIFloat3 &in anchor, float radius)
   ```

   returning true when `UnitHelpers::GetConstructorTier(u.circuitDef) >= 2`,
   the side's T2 mex def is available, and
   `Economy::MexTracker::GetNearestNonUpgradedMexInRange(...)` yields a
   position. Gate it on a per-role setting so a role can opt out.

2. **Insert it ahead of the energy ladder** in every role's builder chain,
   immediately after the native MEX/GEO passthrough and *before* the first
   converter gate, enqueuing
   `TaskB::Spot(Task::BuildType::MEXUP, Task::Priority::NOW, upgradeDef, pos, -1)`.

3. **Only for constructors that can build the T2 mex.** A T1 constructor
   cannot, so the gate must check the tier and fall through for T1 builders
   rather than blocking them.

4. **Do not stall on an upgrade already running.** Use
   `AnyUpgradeInProgressNear` so a second builder does not queue the same spot,
   and cap concurrent upgrades with a setting.

5. **Extend `MexTracker` registration to the other roles.** Today only TECH
   calls `RegisterMex` / `MarkUpgraded` / `MarkUpgradeInProgress` from its
   task-added and task-removed handlers, so the tracker is empty for every
   other role. Move that bookkeeping into `Builder::AiTaskAdded` /
   `AiTaskRemoved` so it is role-independent.

The longer-term version of this is a real comparison rather than an ordered
chain: score each candidate build by metal-per-metal-per-second including its
energy cost, and take the best. The ordered gate above is the cheap correct
step; the scoring rewrite is the one that generalises.

**Status: implemented for TECH, AIR, SEA and SUPPORT.**
`EconomyHelpers::ShouldUpgradeMexFirst` / `EnqueueMexUpgradeIfFirst` added, the
gate inserted ahead of each role's first converter, and the `MexTracker`
bookkeeping moved from TECH's handlers into `Builder::AiTaskAdded` /
`AiTaskRemoved` so every role populates it. Settings are
`Global::RoleSettings::MexUpgradeFirst` / `MexUpgradeRadius` /
`MexUpgradeMaxConcurrent`.

**Still open:** FRONT and TACTICAL have no converter ladder so the gate was not
added to them, but they do build T2 constructors and would benefit; and the
ordered-gate approach is still a chain, not the metal-per-metal-per-second
scoring described above. Not verified in a game.

**Verification.** In game with a T2 constructor and an un-upgraded owned mex in
range, confirm from the task log that `MEXUP` is chosen before any converter,
and that converters resume once every reachable spot is upgraded.

### KI-214 — T1 energy is built after fusion is up, and can loop with reclaim

**Severity**: Medium
**Location**: `EconomyHelpers::ShouldBuildT1AdvancedSolar` and
`ShouldBuildT1EnergyConverter` (`data/script/src/helpers/economy_helpers.as`);
call sites in `roles/tech.as`, `roles/air.as`, `roles/sea.as`,
`roles/support.as`

**Problem.** Neither gate knows whether a fusion or advanced fusion exists.

`ShouldBuildT1AdvancedSolar` with the T2 progress gate enabled (as TECH passes
it) reduces, once any T2 constructor or lab exists, to its fallback:

```angelscript
fallbackOk = (energyIncome < energyIncomeMinimumThreshold)   // TECH: 600
          && (metalIncome > metalIncomeFallbackMinimum);     // TECH: 6
```

So TECH builds 350-metal advanced solars at 80 E/s whenever energy income dips
below 600 — with a fusion (750 E/s) or an AFUS (3 000 E/s) already standing.
Up to `MaxAdvancedSolars` (8) of them.

Worse, it can loop. If advanced solars are reclaimed — by cap changes or by an
economy policy — energy income falls, the fallback fires, they are rebuilt,
income rises, and they are reclaimed again. There is no hysteresis between the
build gate and whatever removes them, and no record of having decided once that
they are obsolete.

**Proposed solution.**

1. **Add a tech-floor argument** to both helpers: `bool hasReactor`, computed
   by the caller as
   `UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllFusionReactors()) +
   SumUnitDefCounts(UnitHelpers::GetAllAdvancedFusionReactors()) > 0`. Return
   false from the T1 advanced-solar and T1 solar gates when it is true. This is
   the rule as stated: **a T1 constructor should not build T1 energy once
   fusion is up.**
2. **Keep the T1 converter available** — a converter is not T1 energy
   generation, it is metal conversion, and it stays useful at any tier. Gate it
   on KI-213 instead.
3. **Add hysteresis against reclaim.** Whatever removes advanced solars should
   set a one-way "obsolete" flag per def class in `Global`, and the build gates
   should honour it. Identify the reclaim source from the log first: nothing in
   `tech.as` reclaims advanced solars — only T1 and T2 labs — so it is either
   native or a cap change, and the fix differs.
4. **Reconsider the thresholds.** `AdvancedSolarEnergyIncomeMinimum` 600 was
   presumably chosen pre-fusion. With a reactor floor in place it mostly stops
   mattering, but it should be re-read rather than left.

**Verification.** In a game that reaches fusion, confirm no advanced solar or
solar is enqueued afterwards, and that no build/reclaim oscillation appears in
the task log.

### KI-215 — A stockpiling nuclear silo outpaces energy growth and blocks conversion

**Severity**: Medium
**Location**: `EconomyHelpers::ShouldBuildT1EnergyConverter` /
`ShouldBuildT2EnergyConverter`, and the silo gate in `roles/tech.as`

**Problem.** `armsilo` has `energypershot` 125 000 over `stockpiletime` 120 s,
so a silo that is stockpiling draws about **1 042 E/s, continuously**. For
scale:

| Source | E/s | Metal |
| --- | ---: | ---: |
| Nuclear silo draw (stockpiling) | **-1 042** | 8 100 |
| Advanced fusion | +3 000 | 9 700 |
| Fusion | +750 | 3 350 |
| Advanced solar | +80 | 350 |

One silo eats more than a fusion produces. TECH builds silos before AFUS in its
chain, and `CMilitaryManager` re-issues `Stockpile` at misc priority 2 for every
stockpiler on each defence update, so the draw is permanent and prioritised.

Two consequences, both observed:

- **Energy scales ahead of conversion.** The converter gates require
  `energyCurrent / energyStorage >= 0.90`. With a silo drawing 1 042 E/s the
  store rarely reaches 90%, so converters are effectively locked out and the
  role keeps adding generation instead.
- **`isEnergyStalling` latches.** `Economy::AiUpdateEconomy` sets it from
  `energy.income < energy.pull`, and the silo's pull makes that true for long
  stretches, which suppresses other work through every stall-gated path.

**Proposed solution.**

1. **Price the silo before building it.** Extend the silo gate to require
   headroom: energy income at least the silo's draw plus the existing minimum,
   computed from the weapon rather than hardcoded —
   `CWeaponDef::GetCostEShot() / stockpileTime` is already available now that
   the per-shot costs are cached (added for the EMP work).
2. **Exclude known stockpile draw from the converter gate.** The
   `energyCurrent/storage >= 0.90` test is a proxy for "we have spare energy",
   and a silo filling its stockpile is not a reason to call energy scarce. Pass
   the expected stockpile draw into the helper and compare against
   `income - stockpileDraw`.
3. **Consider pausing the stockpile.** `unit->CmdMiscPriority` already
   distinguishes priority; a silo at full stock, or one whose stock exceeds the
   number of enemy anti-nukes in coverage, does not need to keep buying
   missiles. This is the biggest single saving and needs a native change in
   `CMilitaryManager::UpdateDefenceTasks`, where the unconditional re-issue
   lives.

**Verification.** With a silo built, confirm from the economy log that
converters still pass their gate when income exceeds the silo draw, and that
`isEnergyStalling` is not permanently true.

### KI-216 — Closed: transport support implemented (donated constructors now fly)

**Status**: implemented, unverified in a game. All four stages of the plan
below are in the tree; see [`transport-ferry.md`](transport-ferry.md) for what
was actually built, and the "Known limits" there for what is still open. The
original analysis is kept because it is the record of why the design is shaped
this way.

- Stage 1 — `{ROLE_TYPE(TRANS), FightType::FERRY}` in the role-task map, so a
  transport is never given a Defend/ATTACK task.
- Stage 2 — `CmdLoadUnits`, `CmdLoadUnitsInArea`, `CmdUnloadUnit`,
  `CmdUnloadUnitsInArea` on `CCircuitUnit`. The C++ wrapper already had all
  four; nothing had wrapped them.
- Stage 3 — `CFerryTask`, one transport per task, deadlines on every state,
  positional load verification (the wrapper exposes no `GetTransporter`).
- Stage 4 — `Team::Ferry` (`data/script/src/manager/ferry.as`), three messages
  over `AiSendMessage`. One correction to the plan: AIR **flies the transport
  to TECH's base before transferring ownership**, rather than giving it at its
  own base, so the hand-over is also the arrival.

---

### KI-216 (original analysis) — No transport support: donated T2 constructors walk, and a transport is sent to fight

**Severity**: Medium
**Location**: `src/circuit/unit/CircuitDef.h:47` ("Not implemented: mine,
transport"); `CMilitaryManager::MakeTask` role—task map
(`src/circuit/module/MilitaryManager.cpp`); `data/script/src/manager/donation.as`

**Problem.** `Team::Donation` hands a finished T2 constructor to an ally with
`ai.GiveUnits`, and the unit then **walks** to its new owner across whatever
lies between. On a large or contested map that is a long trip for a 600-metal
unit with no escort, and it is the slowest part of the whole TECH—to—ally tech
transfer.

An air transport would solve it, and the AI cannot fly one:

1. **No transport commands.** The engine ABI has `COMMAND_UNIT_LOAD_UNITS`
   (57), `LOAD_UNITS_AREA` (58), `UNLOAD_UNITS_AREA` (60) and `UNLOAD_UNIT`
   (61), but `CCircuitUnit` wraps none of them — its command surface has
   `CmdMoveTo`, `CmdFightTo`, `CmdAttackGround` and so on, and nothing for
   cargo.
2. **No transport task.** There is no `CTransportTask`; the upstream comment at
   `CircuitDef.h:47` states transport is not implemented.
3. **A transport is sent to fight.** The role—task map has entries for scout,
   raider, riot, artillery, AA, AH, bomber, support, mine and super, but
   **none for `ROLE_TYPE(TRANS)`**, so a transport falls through to the `else`
   branch and is given `TaskF::Defend(ATTACK, minAttackers)`. It joins the army.
4. **Script cannot help.** `CCircuitUnit` exposes only `GetPos`, attribute
   toggles, fire/move state, `SelfDestruct` and rules params to AngelScript —
   no movement or cargo commands at all.

**Proposed solution.** Four stages, each independently landable and observable.
Per [`intent.md`](intent.md#the-architectural-rule) the mechanism is native and
the policy stays in script.

**Stage 1 — stop transports fighting (small, useful alone).** Give
`ROLE_TYPE(TRANS)` an entry in the role—task map so a transport is not handed
a Defend/ATTACK task. The safest target is a hold equivalent to the one
`AirWaves` uses for its bomber hold —
`TaskF::Defend(check = MELEE, promote = <unreachable>, power = 1e9)` — which
parks the unit near base and never promotes. This alone satisfies "the TECH
player needs to be able to ensure this unit does not get sent to battle".

**Stage 2 — transport commands.** Wrap the four ABI commands on
`CCircuitUnit`: `CmdLoadUnits(std::vector<CCircuitUnit*>)`,
`CmdLoadUnitsArea(pos, radius)`, `CmdUnloadUnit(pos, unit)`,
`CmdUnloadUnitsArea(pos, radius)`. Mirror the existing `Cmd*` shape
(`short options`, `int timeout`, `TRY_UNIT` at the call site).

**Stage 3 — a ferry task.** A `CFerryTask` (static task family, one cargo
unit) sequencing: fly to the cargo, `CmdLoadUnits`, verify the load took
(cargo's position tracks the transport), fly to the drop position,
`CmdUnloadUnit`, verify, then report completion. It needs timeouts at every
step — transports in Spring fail to load for reasons the AI cannot see
(capacity, mass, the cargo moving) and the task must give up rather than hang.
Register a script cast plus `SetCargo` / `SetDropPos` / `IsDone`, the way
`CSuperTask::SetTargetPos` is registered, so the policy below stays in script.

**Stage 4 — the coordination protocol (script).** All of this is
`AiSendMessage` over the existing roster, which already carries every ally's
start position, so no new addressing is needed:

| Step | Who | Action |
| --- | --- | --- |
| 1 | TECH | on enqueueing its T2 lab, broadcast `ferry_request` |
| 2 | AIR | on receipt, set a one-shot flag that makes the next factory task a transport, ahead of every other build |
| 3 | AIR | when that transport finishes, `ai.GiveUnits` it to the requesting TECH team and broadcast `ferry_ready` |
| 4 | TECH | on receiving the transport, hold it (Stage 1) and mark it reserved: never an army unit, never reassigned |
| 5 | TECH | when `Donation::OnConstructorBuilt` picks a recipient, instead of giving the constructor immediately, create a `CFerryTask` with the constructor as cargo and the recipient's roster `startPos` as the drop |
| 6 | TECH | on task completion, `ai.GiveUnits` the constructor to the recipient and return the transport to its hold |

Keep the current walk as the fallback for every failure path — no transport,
transport dead, ferry timed out — so the donation still happens, just slower.
The transport should be one unit per TECH instance, rebuilt on loss only if a
donation is still planned (`Donation::planned > Donation::given`).

**Related finding: no self-donation bug.** Checked at the user's request, and
every recipient path already excludes our own team:
`Roster::AllyTeamIds()` filters `!= ai.teamId`; `PickRecipient()`'s lead-team
fallback returns -1 when the leader is us; both orphan-rescue paths guard
`== ai.teamId`. A defensive guard with a loud log was added to
`Donation::OnConstructorBuilt` anyway, since the invariant was implicit across
three call sites. The likely source of the observation is the widget line
format: `WidgetLink::Send` emits
`barb|donation|<senderTeam>|<senderAllyTeam>|<name>|<recipient>|...`, so the
sender's own team id appears two fields before the recipient and is easy to
misread as the target.

**Verification.** Stage 1: a transport is built and never appears in an attack
group. Stages 2—4: with a TECH and an AIR instance on one ally team, confirm
the transport is built on the T2 lab, arrives at TECH, and that a donated
constructor reaches the recipient's base by air rather than on foot — and that
killing the transport mid-ferry falls back to walking.

---

## Configuration and data (KI-3xx)

### KI-301 — Two Legion mobile EW units cannot be classified

**Severity**: Medium
**Location**: `data/config/*/behaviour_leg.json`

**Problem.** `legavjam` (Cicero, mobile jammer, 105 M) and `legavrad` (Pheme,
mobile radar, 125 M) have no entry in any profile's `behaviour_leg.json`. The
Juno pulse policy classifies targets by the `jammer` / `radar` config roles
appended to a def's `behaviour.json` entry, so a def with no entry can never be
tagged and is invisible to `CSuperTask::SelectPulseTarget`.

Against a Legion enemy the `jammer_mobile` and `radar_mobile` classes are
therefore incomplete: `legajamk` (Tiresias) and `legaradk` (Euclid) are covered,
their vehicle counterparts are not.

**Proposed solution.** Add entries to `behaviour_leg.json` in all three
experimental profiles, matching the shape their Armada and Cortex counterparts
use — `armseer` (mobile radar) and `armjam` (mobile jammer) are the templates:

```json
"legavjam": {
    "role": ["support", "jammer"],
    "threat": {"air": 0.0, "surf": 0.0, "water": 0.0, "default": 0.0},
    "power": 1.0
},
"legavrad": {
    "role": ["assault", "radar"],
    "attribute": ["support"],
    "threat": {"air": 0.0, "surf": 0.0, "water": 0.0, "default": 0.0},
    "power": 1.0
}
```

The first role entry is the main role and drives task assignment, so match the
counterpart's main role rather than inventing one. Confirm both ids are
reachable in the current BAR build first — an unreachable def is dead config,
which is why `armsonar`, `corsonar` and `cormine4` were deliberately left out of
the pulse tables.

**Verification.** `python tools/knowledge/check_unit_helpers.py` exits 0 (it
rejects unknown, unreachable and wrong-faction ids). In a Legion game, confirm
`PULSE` log lines rank a Cicero as `jammer_mobile`.

### KI-302 — Mines and scout spam are outside the pulse target classes

**Severity**: Medium
**Location**: `data/config/*/behaviour.json` `"pulse"` block;
`CMilitaryManager::PulseClass`; `CSuperTask::SelectPulseTarget`

**Problem.** A Juno pulse deletes three flagged groups: sensors and EW
(`juno_kill`), mines (`mine`) and scouts (`juno_deny`). The implemented policy
covers only the first, split into four jammer/radar classes. Mines and scouts
carry no `jammer` or `radar` role and so are never targeted.

That leaves the highest **aggregate** value target unreachable: a minefield of a
dozen heavy mines is 600 M of enemy investment inside one 1,400 blast, and
clearing it unblocks a stalled advance — a value the metal figure understates.
Scout spam matters less per unit but the 450/30 s denial ring is the only tool
that keeps an area closed afterwards.

**Proposed solution.** Extend the existing mechanism rather than adding a
parallel one:

1. Add two members to `CMilitaryManager::PulseClass` (`MINE`, `SCOUT`) and two
   role names to the `"pulse"` config block (`"mine": "mine_field"`,
   `"scout": "scout_spam"` — do not reuse the built-in `mine` role name, which
   already has native meaning).
2. Tag the 11 buildable mine defs and the four scout defs in `behaviour.json`
   and `behaviour_leg.json` with the new roles. The def lists are in
   `../rjm.bar.docs/knowledge/20-game-mechanics/23-special-systems.md`.
3. In `SelectPulseTarget`, classify them alongside the existing four and extend
   the default `priority` array. Mines should rank **below** static sensors but
   the `min_targets` gate should apply to them specifically: a lone 50 M mine is
   never worth 200 M + 12,000 E, while eleven are. Consider a per-class
   `min_targets` override rather than the single global one.

Note that the role masker has 64 slots and 50 are used, so two more roles fit —
but only because `CMaskHandler::GetMask` was fixed to shift a 64-bit `1`. Before
that fix any role above bit 30 aliased a low bit.

**Verification.** In game, lay a friendly minefield, observe from the enemy AI's
perspective, or use a Juno against a known enemy minefield and confirm the
`PULSE` line reports the mine class and a target count above 1.

### KI-303 — The EMP rework mod options are not detected

**Severity**: Medium
**Location**: `CMilitaryManager::ReadConfig` (`"pulse"` and `"emp"` blocks);
`CSuperTask::SelectPulseTarget`, `CSuperTask::SelectEmpTarget`

**Problem.** With the `junorework` mod option set, BAR loads
`unit_juno_rework_damage.lua` instead of `unit_juno_damage.lua`, and the effect
**inverts**: `juno_deny` units (the scouts) are destroyed, while `juno_kill`
sensors and `mine` mines are only **EMP-stunned for 30 s** (32 s with
`emprework`).

Under that option the implemented priority order is close to backwards. Hitting
a static jammer no longer removes it, it blinks it off for 30 seconds — which
can still be worth it as the opener to a timed attack, but is not worth a
first-priority shot, and is certainly not worth it when a scout swarm is in
range and would actually die.

Nothing currently reads the option, so the AI plays the same way in both modes.

**Proposed solution.** Read the option once and switch the ranking:

1. In `CSetupManager` (or wherever mod options are already parsed for native
   use), expose `junorework`. Script reads mod options through
   `aiSetupMgr.GetModOptions()`, but this decision is native, so it needs a
   native accessor — check whether one already exists before adding it.
2. Give the `"pulse"` config block a second priority list,
   `"priority_rework"`, defaulting to
   `["scout", "mine", "jammer_static", "radar_static", "jammer_mobile", "radar_mobile"]`
   once KI-302 adds those classes, and select between the two lists in
   `ReadConfig` based on the option.
3. Log which list was selected at startup, alongside the existing
   `CONFIG <profile>: pulse ...` line, so a log reader can tell which ruleset
   was in force.

The mechanics of both gadget variants are recorded in
`../rjm.bar.docs/knowledge/20-game-mechanics/23-special-systems.md`.

**The same option breaks the EMP policy's arithmetic.** `emprework` sets
`modrules.paralyze.paralyzeDeclineRate` to 20 instead of 40 and halves the
mobile paralysis cap to 10 s. `CSuperTask::SelectEmpTarget` reads the decline
rate from the `"emp"` block's `decline_rate`, which is a hand-set 40, so with
the option on every stun duration it computes is wrong by a factor of two and
`min_stun` rejects the wrong candidates. Fix both together: read the option
once, then select the rework priority list *and* set `decline_rate` to 20 from
it rather than trusting the config value.

**Verification.** Start a game with `junorework` enabled and confirm the startup
`CONFIG ... pulse` line names the rework list; confirm a Juno prefers a scout
swarm over a jammer tower.

### KI-304 — Legacy profiles keep the generic super-weapon scan

**Severity**: Low
**Location**: `data/config/{easy,medium,hard,hard_aggressive}/behaviour.json`

**Problem.** The `"pulse"` and `"emp"` config blocks were added only to the
three experimental profiles, per the repository rule against changing the
legacy and shared-framework profiles in one change. The four legacy profiles
therefore have neither block, both `pulseInfo.isEnabled` and
`empInfo.isEnabled` stay false for them, and their Junos and EMP silos fall
back to the generic group scan — aiming at the richest enemy group on enemy
ground with weapons that cannot damage or hold it.

Their Junos consequently still burn up to 4,000 M and 240,000 E per silo on a
stockpile spent on armies, and their EMP silos up to 5,000 M and 156,440 E on
targets that are often immune outright.

**Proposed solution.** Copy the `"pulse"` and `"emp"` blocks from
`data/config/experimental_balanced/behaviour.json` into the four legacy
`behaviour.json` files; append the `jammer` / `radar` roles to their sensor
defs and `anti_nuke` to their anti-nuke defs. The def-to-class table is in
[`juno-targets.md`](juno-targets.md) and the EMP ranking needs almost no
tagging — see [`emp-targets.md`](emp-targets.md). Append the role, never
prepend it, because the first entry of `role` is the main role and drives task
assignment.

Do it as its own change, not bundled with experimental-profile work, and play
one game per legacy profile afterwards since those profiles are otherwise
native-driven and less exercised.

**Verification.** All four profiles load; `CONFIG <profile>: pulse enabled`
appears in the log for each.

### KI-305 — Stale `HOVER_SEA` keys in eight map configurations

**Severity**: Low
**Location**: `data/script/src/maps/` — `eight_horses.as`,
`flats_and_forests.as`, `glacial_gap.as`, `red_river_estuary.as`,
`shore_to_shore.as`, `supreme_isthmus.as`, `tempest.as`,
`tundra_continents.as`

**Problem.** The role was renamed `HOVER_SEA` → `TACTICAL`, and
`MapConfig::RoleKey()` now emits `"TACTICAL"`. Eight map files still publish
factory-weight and unit-limit overlay entries under the `"HOVER_SEA"` key.
`GetSideFactoryWeightsByRole` and `GetRoleUnitLimitOverlayFor` look up
`"TACTICAL"`, so those entries are unreachable: on those maps a TACTICAL start
silently falls back to the generic weighted selection and the base unit limits,
losing whatever the map author intended.

**Proposed solution.** Rename the key in all eight files. It is a literal string
replacement of `"HOVER_SEA"` with `"TACTICAL"` in the `root.set(...)` calls and
the surrounding comments, but check each file individually: `glacial_gap.as`
already carries a `// TACTICAL role (formerly HOVER_SEA)` comment, suggesting a
partial migration, so some files may have both keys or a half-renamed block.

Afterwards, add a guard so this cannot recur silently — in
`MapConfig::SetRoleUnitLimitOverlays` and the factory-weights constructor, log
at level 2 when a supplied role key does not match any `RoleKey()` output.

**Verification.** Load a TACTICAL start on each of the eight maps and confirm
from the `[Factory] Role handler returned` and `[Limits] Merged unit limits`
log lines that the map's overlay is applied.

### KI-306 — `armdfly` missing from the T2 aircraft combat list

**Severity**: Low
**Location**: `UnitHelpers::GetAllT2AircraftCombatUnits`
(`data/script/src/helpers/unit_helpers.as:920`)

**Problem.** `tools/knowledge/check_unit_helpers.py` reports this as an
informational coverage gap on every run: `armdfly` (Abductor) is a T2 Armada
aircraft that is not in the list. Any policy that iterates T2 combat aircraft —
caps, production targets, wave rosters — skips it.

The Abductor is a transport-class unit whose value is capturing units, so
whether it belongs in a *combat* list is a judgement call, not obviously a bug.
That ambiguity is why it has sat as an informational gap rather than a finding.

**Proposed solution.** Decide and record the decision:

- If the Abductor should be produced, add `"armdfly"` to
  `GetAllT2AircraftCombatUnits` and check whether the AIR role's production and
  cap logic handles a unit with no direct-fire weapon sensibly — it likely needs
  its own small quota rather than joining the fighter/bomber counts.
- If it should not, add it to the checker's ignore list with a comment saying
  why, so the informational gap stops reappearing on every run.

The second option is the honest default until someone wants Abductor play.

**Verification.** `python tools/knowledge/check_unit_helpers.py` reports zero
coverage gaps.

### KI-307 — UnitDef drift in configuration identifiers

**Severity**: Medium
**Location**: `data/config/*/behaviour*.json`, `factory*.json`,
`build_chain*.json`

**Problem.** Several Legion and optional-unit identifiers in the JSON profiles
are placeholders or version-sensitive. BAR renames units
(`gamedata/unitDefRenames.lua` records legacy-to-descriptive mappings) and gates
content behind game and mod options, so an id that was valid at one BAR version
silently becomes an unknown def at another. The symptom is "unknown UnitDef" and
"invalid factory build-option" warnings in the game log, and the affected entry
simply never applies.

`tools/knowledge/check_unit_helpers.py` validates ids quoted in
`data/script/src` against the shared BAR cache, but **nothing validates the
JSON configs**, which is where most unit ids live.

**Proposed solution.** Extend the checker to cover configuration. Add a mode to
`tools/knowledge/check_unit_helpers.py` (or a sibling
`tools/knowledge/check_config_units.py`) that walks every
`data/config/**/*.json`, collects each key under the unit table plus every id
appearing in `factory.json` unit lists and `build_chain.json` chains, and
validates them against `../rjm.bar.docs/tools/knowledge/.cache/kb.json` for:
existence, reachability, faction consistency with the file
(`behaviour_leg.json` should hold Legion ids), and — for factory unit lists —
that the unit is actually in that factory's effective `buildoptions`.

The last check is the valuable one and the reason `AGENTS.md` warns not to
infer a factory edge from two defs existing.

**Verification.** The new checker exits 0 across all seven profiles, and a
deliberately renamed id in a scratch copy is reported.

### KI-308 — Legion production coverage is incomplete

**Severity**: Low
**Location**: `data/script/src/manager/factory_production/factory_configs_air.as`,
`factory_configs_sea.as`

**Problem.** The dynamic air configurations explicitly omit Legion, and T2
Legion naval production is a placeholder. A Legion game therefore has no
dynamic air or T2 naval unit tables to select from.

This is currently masked entirely by KI-201: the dynamic production system is
switched off for every role, so none of these tables execute. It becomes a real
gap the moment KI-201 is resolved in favour of adopting the system, which is why
it is recorded separately rather than folded into it.

**Proposed solution.** Fill the Legion tables in the same shape as the Armada
and Cortex ones, using `doc/units.md` and
`../rjm.bar.docs/knowledge/30-units/legion/` for the roster and each factory's
effective `buildoptions` for the edges. Do it as part of whatever change
resolves KI-201, not before — filling tables nothing reads adds maintenance
cost for no benefit.

**Verification.** With dynamic production enabled for AIR and SEA, a Legion
game produces a varied air and T2 naval mix rather than falling back.

### KI-309 — The shared unit cache has partial Extra Units Pack coverage

**Severity**: Low
**Location**: `../rjm.bar.docs/tools/knowledge/extract.py` and its cache
`tools/knowledge/.cache/kb.json`; surfaced by
`tools/knowledge/check_unit_helpers.py`

**Problem.** Extra Units Pack content is only partly present in the shared unit
cache. `armlwall`, `cormwall`, `legrwall` and the three `*gatet3` shields
resolve; `armminivulc`, `corminibuzz` and `legministarfall` do not, despite all
nine living in the same directory
(`units/Scavengers/Buildings/DefenseOffense/`) and all nine being documented in
[`extra_units.md`](extra_units.md).

The consequence is that `check_unit_helpers.py` rejects ids that are real. The
porcupine chain's Extra Units tier had to omit the three mini plasma pieces to
keep the checker at zero findings, so an AI playing with
`experimentalextraunits` will not use them even though they are the pack's most
interesting defensive additions.

**Proposed solution.** Work out why extraction is inconsistent. The likely
cause is that `extract.py` runs BAR's def pipeline with a fixed set of mod
options, and the units that do resolve reach a build menu by some route that
does not depend on `experimentalextraunits` while the mini pieces need it.

Either extract a second pass with the content options enabled and mark those
units in the cache (`reachable_with: experimentalextraunits`), or record the
pack explicitly from `doc/extra_units.md`, which already catalogues all 41 with
source paths. The first is better: it keeps the cache generated rather than
hand-maintained, which is the rule in that repository.

Then `check_unit_helpers.py` should treat an option-gated id as valid, and the
three ids can be restored to `PorcHelpers::ExtraUnitsLand`.

**Verification.** `python tools/knowledge/check_unit_helpers.py` exits 0 with
the mini pieces present in the chain, and a game with
`experimentalextraunits=1` logs them being appended by `[Porc]`.

---

## Process, tooling and verification (KI-4xx)

### KI-401 — No in-game verification of the current change set

**Severity**: High
**Location**: whole repository; see the change table in the session that
introduced the pulse policy

**Problem.** The native pulse targeting policy, the mask-handler fix, the
`IGNORE`/`NEUTRAL` bit separation, the enemy-cost cache fix and the AngelScript
corrections have been compiled and statically checked but **never run in a
game**. The compile proves the code is well-formed; it proves nothing about
behaviour.

Two carry real risk:

- **`IGNORE` / `NEUTRAL` bit separation** (`EnemyUnit.h`). These shared bit
  `0x08`, so `ClearNeutral()` cleared the ignore flag and an ignored unit read
  as neutral. Separating them changes enemy filtering everywhere — target
  selection, threat accounting, the `ignoredByAI` rules param — and the previous
  conflated behaviour may have been silently load-bearing.
- **`CMaskHandler::GetMask`** (`MaskHandler.h`). Every custom role above bit 30
  previously aliased a low bit: `juno` behaved as `assault`, `jammer` as
  `scout`, `radar` as `raider`, `anti_nuke` as `builder`. Fixing it means those
  roles now mean what they say, so any tuning that was unknowingly compensating
  for the aliasing is now wrong.

**Proposed solution.** Deploy and play, in this order, recording the infolog for
each:

1. **Armada vs Cortex, `experimental_balanced`, no Legion.** Confirm the AI
   opens, expands and fights normally. This is the regression gate for the mask
   and ignore changes — watch for units being ignored that should not be, and
   for `response` tables producing odd unit mixes.
2. **A game where an enemy builds radar and jammers.** Confirm `PULSE` log lines
   appear, that rank 1 is preferred over rank 2, and that a shot is actually
   fired (stockpile > 0 → `ai_super_fire` in the log).
3. **A game with no enemy sensors in range.** Confirm the once-a-minute
   `PULSE ... no target` line and that the Juno holds rather than firing.
4. **A Legion game** for the `behaviour_leg.json` tagging.

Deploy per the build notes: copy `build-amd64-windows/install/AI/Skirmish/BARb/stable/`
over the BAR install **including `script/` and `config/`**, since the
AngelScript and JSON changes ship in that tree and are otherwise silently stale.
Apply `skills/troubleshoot-bar-logs/SKILL.md` when reading the logs.

**Verification.** This issue closes when all four scenarios have been played and
the logs attached to a changelog entry.

### KI-402 — No standalone AngelScript compilation target

**Severity**: Medium
**Location**: repository build; `data/script/`

**Problem.** The only way to discover that an AngelScript change compiles is to
load a profile in a running BAR game. The host compiles with warnings-as-errors,
so a single bad signature takes the whole AI down at match start, and the
feedback loop is minutes long. Static greps catch obsolete API calls but not
registration mismatches, signature errors or namespace mistakes.

This is the single largest drag on script work in this repository and the reason
several of the issues above are "decide, then play a game to find out".

**Proposed solution.** Build a small host that links the vendored AngelScript
from `src/lib/angelscript/`, registers the same surface as
`src/circuit/script/InitScript.cpp` with stub implementations, and compiles a
named profile exactly as `CScriptManager` does — `init.as` as module `init`,
then `main.as` as module `main`, with the same engine properties
(warnings-as-errors, unsafe references off, implicit handle types off,
multiline strings on, `property` keyword required, UTF-8 on).

The registration surface is the work: it is large, and it must not drift from
`InitScript.cpp`. The way to keep it honest is to generate the stubs from the
same registration calls — factor `InitScript`'s registration into a function
parameterised by a "real or stub" backend, so the harness and the AI register
from one source.

Ship it as a `tools/script-check/` CMake target that CI and the pre-commit hook
can run against all seven profiles.

**Verification.** Deliberately break a signature in a shared module and confirm
the harness fails; confirm all seven profiles compile clean when unbroken.

### KI-403 — Script logging volume

**Severity**: Low
**Location**: `LOG_LEVEL` in `data/script/src/define.as`; call sites throughout
`data/script/src/`

**Problem.** Many hot paths emit level 2–4 diagnostics. In an AI-heavy match
CircuitAI's own `:::AI LOG` output has been measured at **99.7% of all log
lines** — 1,695,964 of 1,700,340 in one 252 MB archive. At high `LOG_LEVEL` this
costs both disk and time, and it makes engine-level problems hard to find.

`LOG_LEVEL` is currently 1, which keeps it manageable, but the instrumentation
that matters for a specific investigation lives at 3–4 and cannot be enabled
without enabling everything at that level.

**Proposed solution.** Add a category dimension alongside the level. Give
`GenericHelpers::LogUtil` an optional category argument (`"factory"`,
`"builder"`, `"pulse"`, `"spam"`, …) and a `Global::Log::Categories` bitmask or
dictionary in `global.as`, so a session can raise the level for one subsystem
without raising it globally. Default every existing call to a general category
so the change is mechanical and behaviour-preserving.

Separately, audit the level-4 and level-5 "Enter <function>" trace lines — those
are the bulk of the volume and are better served by the category switch than by
being on at all times.

**Verification.** With one category enabled at level 4 and the rest at 1,
confirm from a short match that the log holds that subsystem's detail and not
the rest.

---

### KI-404 — `doc/roles/hover.md` is referenced everywhere and does not exist

**Severity**: Medium
**Location**: missing file `doc/roles/hover.md`; referenced from `AGENTS.md:76`
and `AGENTS.md:131`, `doc/roles/README.md:60` and `:212`, `doc/roles/sea.md:209`,
`doc/roles/support.md:196` and `:239`, `doc/roles/tactical.md:38` and `:246`,
`doc/knowledge/README.md:23`,
`doc/knowledge/90-agent-decision-guides/90-decision-architecture.md:10`,
`doc/knowledge/90-agent-decision-guides/91-build-order-selection.md:74`,
`doc/knowledge/barb-status-by-topic.md:148`

**Problem.** Eleven places across the documentation link to
`doc/roles/hover.md`, and the file is not in the repository. `AGENTS.md`
describes it in the Repository Map as the "Deep reference for hover production:
ownership, build decisions, the native contract, and the cause of hover
production stalling once a T2 factory exists". `doc/roles/tactical.md:246` tells
the reader to "**read this**". `doc/roles/README.md` lists it in the Documents
table and points at it for the full consequence of
`UseDynamicFactoryProduction` being false everywhere.

So the single most-recommended document in the role layer is a dead link, and
the specific behaviour it is cited for — why hover production stalls once a T2
factory exists — is recorded nowhere else. `doc/roles/README.md` is checked by
`tools/knowledge/check_role_docs.py`, but that tool validates role scripts
against role documents and does not check that referenced files exist, which is
why this went unnoticed until a link check was written.

**Proposed solution.** Write the document. The content it is cited for, and
where to derive each part:

1. **Ownership** — which manager owns hover plants and hover constructors.
   `Factory::primaryT1HoverPlant` / `primaryFloatingHoverPlant` in
   `data/script/src/manager/factory.as`, and
   `Builder::primaryT1HoverConstructor` / `secondaryT1HoverConstructor` /
   `freelanceT1HoverConstructor` / `tacticalHoverConstructor` in
   `manager/builder.as`.
2. **Build decisions** — the income-scaled plant allowance in
   `Global::RoleSettings::Tactical` (`MetalIncomePerExtraHoverPlant`,
   `MaxHoverPlants`, `MinHoverConstructorCount`) and TECH's landlocked
   expansion path (`Tech_TryEnqueueLandLockedWaterFactory`).
3. **The native contract** — the `rare` attribute and the native `isActive`
   gate that `doc/roles/support.md:196` and `doc/roles/sea.md:209` already
   summarise; trace it in `CFactoryManager` / `CFactoryData` to state it
   precisely.
4. **The T2 stall** — the behaviour the document is most cited for. Reproduce
   it, then record the actual cause. `data/script/HOVER_FACTORY_IMPLEMENTATION.md`
   (10.8 KB, hover production tables and tier logic) is the starting point, and
   the `rare` attribute is the likely mechanism: a T1 factory's units stop being
   selected once a T2 factory exists unless they carry it.
5. **Which roles reach hover** — TACTICAL opens on a hover plant; SEA and TECH
   can reach one; it is not a role. `doc/roles/README.md:60` already states
   this and it is the reason the document lives in `roles/`.

End it with a source marker like the other role documents so
`check_role_docs.py` can be extended to cover it.

**Until it is written**, do not delete the eleven references: they record what
readers are expected to find. Add a line at the top of
`doc/roles/README.md`'s Documents table noting that `hover.md` is outstanding
and pointing at this issue, so nobody follows a dead link without warning.

The tooling half of this is **done**: `tools/knowledge/check_doc_links.py`
now validates every relative Markdown link under `doc/`, `data/script/`,
`skills/` and the root instruction files. It currently reports
`879 relative link(s), 9 broken` — all nine being the `hover.md` references
above — and will exit 0 once the document exists. Run it before finishing any
documentation change.

**Verification.** `python tools/knowledge/check_doc_links.py` exits 0, and the
document ends with a source marker in the same form as the other role
documents.

---

## Indexed elsewhere

These are open, documented, and owned by their own document. Do not duplicate
their detail here; add the pointer and keep the one-line summary accurate.

| Issue | Document | Summary |
| --- | --- | --- |
| Bomber targeting | [`bomber-targeting.md`](bomber-targeting.md) | Diagnosed but unfixed bomber target selection, with a phased remediation plan. |
| T2 constructor stall | [`t2-constructor-stall.md`](t2-constructor-stall.md) | T2 constructors stall after mex upgrades; three options await a decision. |
| Role-layer findings | [`roles/README.md`](roles/README.md) | Cross-role findings, enforced against the scripts by `tools/knowledge/check_role_docs.py`. KI-203 to KI-208 are the ones with a proposed solution. |
| Juno policy limits | [`juno-targets.md`](juno-targets.md) | Per-feature limits of the pulse policy; KI-102 and KI-301 to KI-304 are the register entries. |
| EMP policy limits | [`emp-targets.md`](emp-targets.md) | Per-feature limits of the EMP policy; KI-104, KI-303 and KI-304 are the register entries. |

## Maintaining this register

1. **Add an issue when a problem is diagnosed but left unfixed.** That includes
   a defect found while doing something else, a feature that turns out to be
   inert, and a fix applied but not verified in game. If it was understood well
   enough to explain, it is understood well enough to record.
2. **Never delete an entry to make the list shorter.** Remove an entry only when
   the issue is actually resolved, and say so in the commit message. IDs are not
   reused.
3. **Every entry needs a proposed solution with enough detail to start work** —
   the approach, the files, and the traps. "Needs investigation" means it is not
   ready for this register.
4. **Keep locations current.** When a fix moves code an issue points at, update
   the location in the same change.
5. **Prefer a pointer to a copy.** A problem large enough for its own document
   gets one, and appears in [Indexed elsewhere](#indexed-elsewhere) with a
   one-line summary.
6. **Verification is part of the entry.** State how the fix will be proven, and
   distinguish static checks from in-game verification. Compiling is not
   verifying.
