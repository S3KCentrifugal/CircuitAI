# tech_build.as - TECH's experimental build system

Script: [`data/script/src/roles/tech_build.as`](../../data/script/src/roles/tech_build.as),
namespace `TechBuild`. Decision:
[D-066](../decisions.md#d-066--the-experimental-build-system-a-hard-split-tech-only-one-switch).
Role document: [`tech.md`](tech.md). Not Played:
[KI-411](../known-issues.md#ki-411--the-experimental-build-system-is-not-yet-played).

## Intent

When `Global::RoleSettings::Tech::ExperimentalBuild` is on, `TechBuild::MakeTask`
is the only source of work for every TECH builder. `Tech_BuilderAiMakeTask`
hands each ask to it on its first line; native's chooser returns nothing
for the instance, so there is no fallback into stock sequencing, and native's
site search never spirals for the instance, so there is no fallback into
stock placement. With the switch off the file is never called.

`MakeTask` never returns null. A builder with nothing to build assists the
nearest structure under construction, guards the primary factory, or waits
three seconds and is asked again.

## The sequence

| Rung | Function | Who | What |
| --- | --- | --- | --- |
| 1 | `Tech_TurretAssist` (tech.as), `AssistAny`, `Wait` | static builders | reclaim in reach, then the economy under construction in the D-065 order, then any structure under construction within 700 elmos, then wait 5 s |
| 2 | `KeepCurrent` | every builder | the construction it is on (build type below `REPAIR`) when native re-asks while it walks |
| 3 | `Opening::MakeTask` (tech.as) | commander | the nearest `OpeningMexCap` mexes, nearest to itself first |
| 4 | `StartFactory` | any builder that can | the T1 bot lab, ordered once the opening is complete, on the pair's reserved slot; native's start-factory job is silent and `holdStartFactory` stays on for the whole game |
| 5 | `ExpandMex` | constructors | the nearest open spot the builder can reach within `EcoMexExpandRadius` (every spot inside it considered, nearest first), allied ground excluded, while metal income is under `EcoMexExpandUntilIncome`; logs `expands to a mex at (x, z)` and, once a minute, `no open mex spot within R` |
| 6 | `Planner` | every builder | `EcoPlanner::Next` / `Execute` behind `Tech_RedirectEnergyToReactor`: energy, converters, turrets, storages, all packed into the turret box |
| 7 | `Tech_Commander_AiMakeTask` / `Strategic` | commander / constructors | the role's strategic rungs as they stand (recycle, T2 lab gate, nukes, anti-nuke, gantry, water factories, T2 constructor policy) with a null default, so they return null when they have nothing |
| 8 | `QueuedOrder` | constructors | native's queued defence, radar, sonar, repair and bunker orders, nearest first (`aiBuilderMgr.FindQueuedTask`) |
| 9 | `AssistAny` | constructors | the nearest structure of ours under construction within `ExpAssistRadius` |
| 10 | `GuardFactory` | constructors | guard the primary T1 lab (`GuardHelpers::AssignWorkerGuard`) |
| 11 | `Wait` | everyone | 3 s, then ask again |

## Placement

Nothing here computes a site. The planner places through `Layout::Place`
and `Layout::NanoTask` (the turret box); the strategic rungs and native's
queued orders name an anchor, and native packs the free footprint nearest
it within `ExperimentalSearchRadius` (`PackNearPoint`), reserved and served.
Mex and geo orders are exact spots.

## Settings

| Setting (`Global::RoleSettings::Tech`) | Default | Meaning |
| --- | --- | --- |
| `ExperimentalBuild` | true | the switch for the whole system |
| `ExperimentalSearchRadius` | 512 | how far from an anchor a site may be packed |
| `ExpAssistRadius` | 1500 | rung 9's radius |
| `EcoMexExpandRadius` / `EcoMexExpandUntilIncome` | 2500 / 60 | rung 5 |

## Logs

Level 1: `[TECH][Build] experimental build system on: ...` at init,
`[TECH][Build] start factory ordered on the reserved slot`. Level 2:
`[TECH][Build] <def> <id> expands a mex`. Native: `RESERVE: packed <def>
near (x, z) at (x, z), D away` for every packed site, `RESERVE: no site for
<def> within R of (x, z)` when none.

## Related

- [`tech.md`](tech.md) - the role, the split, the legacy ladder.
- [`../eco-planner.md`](../eco-planner.md) - rung 6.
- [`../layout-design.md`](../layout-design.md) - where the planner's structures go.

<!-- source: data/script/src/roles/tech_build.as; blob: d4f7d86917344f3895a8789b20098d2a57248db0; lines: 232 -->
