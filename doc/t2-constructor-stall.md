# T2 constructor stall after mex upgrades

**Status: diagnosed, not fixed. Awaiting a decision between the three options below.**

Observed 2026-09-15 across several games. Line references are as of branch
`smrt`, 2026-09-15.

## Symptom

TECH-role Tier 2 construction bots stop working for minutes at a time, then
resume on their own.

- Typically begins right after the second mex upgrade completes.
- Observed gaps of roughly 3 to 5 minutes.
- **Tier 1 constructors keep building normally throughout.**
- Intermittent between games: some matches never show it.

## Cause

The stall is in native builder task assignment, not in role script.

`Tech_T2BotConstructor_AiMakeTask` never returns null - its ladder ends with
`return defaultTask` (`data/script/src/roles/tech.as:1740`). So the empty result
comes from native `CBuilderManager::MakeBuilderTask`
(`src/circuit/module/BuilderManager.cpp:1275`), which ends:

```cpp
if (task == nullptr) {
    if ((unit->GetTask() != idleTask) || isNotReady) {
        return nullptr;          // builder receives NO task and goes idle
    }
    task = CreateBuilderTask(pos, unit);
}
```

with, at `BuilderManager.cpp:1299`:

```cpp
const bool isNotReady = !economyMgr->IsExcessed() || isStalling;
```

`IsExcessed()` is `metalProduced > metalUsed` (`EconomyManager.h:107`).

While `isNotReady` holds, the candidate loop above also skips every queued task
unless it is `Priority::NOW` **or** passes `IsIgnoreStallingPull`
(`EconomyManager.cpp:967`):

```cpp
BuildType == MEX || BuildType == PYLON || (BuildType == ENERGY && IsEnergyStalling())
```

## Why T1 keeps working and T2 does not

| | Task type it pursues | Survives the stall filter? |
| --- | --- | --- |
| T1 constructors | `MEX` | Yes - `MEX` is whitelisted by `IsIgnoreStallingPull` |
| T2 constructors | `MEXUP` at `Priority::NOW` | Only while a MEXUP target still exists |

TECH enqueues mex upgrades at `Priority::NOW`
(`tech.as:1076`, `:1098`, `:1167`), and `NOW` bypasses the stall gate. That is
why T2 constructors work at first.

But **`MEXUP` is not in `IsIgnoreStallingPull`**. The moment no valid MEXUP
target remains - which is exactly when the second upgrade finishes - the T2
constructors have:

- no `NOW`-priority task left to claim,
- every other queued task filtered out by `isNotReady`,
- and `CreateBuilderTask` unreachable, because `isNotReady` short-circuits it.

The result is `nullptr`, and the unit idles. T1 constructors are unaffected
because their `MEX` tasks bypass the same filter.

Note that `Builder::AiMakeTask` calls `aiBuilderMgr.DefaultMakeTask(u)` a second
time when the role handler returns null, so the failing path runs twice per
attempt, including a second cost-map path query.

## Why it resolves itself

`metalProduced` and `metalUsed` are running accumulators
(`EconomyManager.cpp:2058`). While the upgrades are being paid for, usage
outruns production and `IsExcessed()` stays false. Once the upgraded extractors
come online and income exceeds spend for long enough for the accumulator to
cross over, `isNotReady` goes false and the T2 constructors immediately pick up
tasks again.

That crossover time is what varies between games, which is why the stall is
intermittent and why its duration is not fixed.

This is a **real** economic stall, not a phantom one - the AI is genuinely
overspending at that moment. Any fix should be judged against that.

## Fix options

Not applied. They trade differently and the choice is a design decision.

### Option 1 - add `MEXUP` to `IsIgnoreStallingPull`

C++, one line in `CEconomyManager::IsIgnoreStallingPull`.

- For: mex upgrades are income-positive, the same justification `MEX` already
  has. Directly removes the cause.
- Against: it is upstream's function and applies to every role, and it pushes
  more spending into a period when the economy is already stalling.

### Option 2 - stop using `Priority::NOW` for MEXUP

AngelScript, in the three `tech.as` enqueue sites.

- For: `NOW` is what masks the problem early and then removes the mask all at
  once. `HIGH` plus a stall-aware branch degrades gracefully instead. Also
  consistent with the priority-discipline point in
  [`doc/roles/tech.md`](roles/tech.md) - native scores candidates by
  `distCost / (priority+1)^2`, so `NOW` flattens distance by 2500x and bypasses
  the stall gate as a side effect rather than by intent.
- Against: mex upgrades lose their guaranteed-first status, so they may be
  picked up later than today.

### Option 3 - give the T2 path a fallback when `defaultTask` is null

AngelScript, in `Tech_T2BotConstructor_AiMakeTask`.

- For: expensive constructors do something useful during a genuine stall, for
  example assisting the nearest reactor or factory. `Builder::EnqueueAssistReactor`
  already exists for this shape of work.
- Against: treats the symptom rather than the cause; the underlying overspend
  is unchanged.

## Recommendation for review

Option 2 or 3 correct the behaviour without increasing spend during a stall.
Option 1 is the smallest change but works against the stall protection that is
doing its job.

Whichever is chosen, verifying it needs `LOG_LEVEL` raised to at least 3 - see
[`skills/troubleshoot-bar-logs/SKILL.md`](../skills/troubleshoot-bar-logs/SKILL.md) -
and a match where two mex upgrades complete under a metal deficit.

## Related

- [`doc/roles/tech.md`](roles/tech.md) - TECH role reference, unit-cap system,
  and the priority-weighting arithmetic.
- [`doc/angelscript-references.md`](angelscript-references.md) - callback
  contracts and registered API.
