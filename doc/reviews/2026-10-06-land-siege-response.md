# Incinerator advance and land siege production

## Outcome and scope

FRONT now admits a funded anti-static siege unit before normal combat selection.
The final runtime change is AngelScript only. TECH, AIR, SEA, SUPPORT, TACTICAL,
legacy profiles and existing unit combat controllers retain their behavior.
The Incinerator stall has **not** been reproduced or declared fixed; see KI-521.

The initial plan below considered TECH too. Supplied testing exposed its
intentional T2 combat and vehicle-factory caps. The proposed TECH hook was
removed; lifting those restrictions needs a separate policy decision. Failed
fixtures and their exact staged sources remain in the evidence catalog.

## Design and evidence before implementation

The current Incinerator (`leginc`) has main role `heavy`, enemy classification
`assault`, no `ranged` attribute and no standoff override. Its ordinary owner is
the native DEFEND-to-ATTACK squad. The D-207 ranged rework did not directly
change its controller. Four supplied Incinerators on Glitters cleared two
successive lines (three light and three heavy lasers) by frame 2132, without
loss. This does not reproduce the reported crowded-front stall. Investigate a
mixed force before changing assault movement; do not remove the protections
of Sharpshooters and Starlights on speculation.

FRONT production has a separate, verified imbalance. TECH's fixed ten-unit combat batches
bypass native response selection. FRONT normally uses native production
(`UseDynamicFactoryProduction=false`); its optional dynamic chooser reacts to
same-role enemy threat, not specifically static defenses. Native artillery
response targets 0.7 times observed static metal, versus 5 times for assault
and heavy units. Simply increasing factory probabilities is weak: response
selection adds 30 to each nonzero probability.

## Initial change plan (TECH extension rejected after testing)

1. Keep native movement and ranged policy unchanged until a reproduction
   warrants a specific fix. Add repeatable Incinerator and mixed-force cases.
2. Add one shared AngelScript land-siege producer for FRONT and TECH. Call it
   after constructor/utility obligations and before ordinary combat batches.
   Only supported T2 land factories can use it; water-isolated starts retain
   amphibious choices. Never alter unit caps, factory layouts or tech gates.
3. Read the native observed static-metal aggregate (constant-time callback),
   require sustainable income, and cap siege investment against army value.
   Count existing and pending recruits across the fixed counter roster. Enqueue
   one unit per decision, with no polling loop or extra movement commands.
4. Prefer Tremors and long-range rockets from vehicles, and Sheldon/Thanatos
   where bot factories provide the available bombardment alternative. Keep
   assault screens and sensors through the ordinary production path. Do not
   treat Belchers (625 range) or fragile precision units as equivalent siege.
5. Test arithmetic with the actual AngelScript VM, exercise production with
   supplied economy and controlled static/no-static opponents, and rerun
   ranged combat plus crowded Incinerator advance. Record original failures,
   command counts, screenshots and exact build/data pins.

## PvP mechanics informing the design

The [official Incinerator guide](https://www.beyondallreason.info/unit/leginc)
describes a slow, durable sustained-fire frontline platform requiring escorts
and clear direct-fire lanes. This supports checking congestion and target
approach rather than treating it as a fragile sniper. The
[Tremor guide](https://www.beyondallreason.info/unit/cortrem) describes long-range
high-trajectory area bombardment, vulnerability to close attackers and a major
friendly-fire hazard. More production must retain its ranged/splash controller
and leave resources for a screen. These are tactical justifications, not proof
of an optimal numerical army ratio; ratios below require simulation evidence.

## Final implementation

- `Front_FactoryAiMakeTask` calls `LandSiege::Produce` after constructor
  guarantees and before either dynamic or native combat selection.
- A ten-second minimum of **40 metal/s and 800 energy/s** permits consideration.
  Income ramps the dedicated siege share from **20% at 40 metal/s to 35% at
  120 metal/s**, rather than using the match clock.
- Budget is the smaller of `1.25 * knownStaticMetal / nativeTeamFactor` and
  `armyCost * siegeShare`. `armyCost` includes static defenses: the share leaves
  investment room but does not establish that a nearby mobile screen exists.
- The six-unit roster counts live frames plus unframed pending recruits across
  every factory. One admission occurs at a time and INV-155 audits visibility.
  Caps, build options and landlocked-start policy remain authoritative.
- Vehicle counters are Tremor/Negotiator, Ambassador and Boreas. Bot factories
  can offer Sheldon or Thanatos. A modest Tremor preference is balanced by
  invested metal. Pick the desired mix before affordability, so repeatedly
  buying cheaper rockets cannot starve the second Tremor.
- This bounds the dedicated override, not every ordinary native artillery
  choice. It does not cancel existing queues or replace construction priorities.
- No native C++, behavior JSON, layout, weapon range, retreat rule or attack
  formation is changed. Settings are `Global::Military::LandSiege*` in
  [global.as](../../data/script/src/global.as).

## Observed results

All rendered cases use All That Glitters v2.2.3, BAR
`test-31479-433a460`, Recoil `recoil_2026.07.04`, seed 2071, and the unchanged
D-212 DLL SHA-256
`f224e17dc3c6f79801ee31fc755d49165c96cd0b022a5c5cffa70488363111ed`.
Production fixtures supply economy, two factories and build power, freeze mobile
builders and hold combat units so the known static demand remains constant.
Income comes from real AFUS/converter operation. Combat fixtures leave friendly
combat commands to the AI and hold enemy static targets. These are supplied
scenarios, not natural economy timing or match-win evidence.

| Scenario | Observed result |
| --- | --- |
| Cortex FRONT baseline, 5 minutes | 0 Tremors, 5 Negotiators: 4,400 metal in these counters |
| Cortex FRONT candidate, 5 minutes | 2 Tremors, 2 Negotiators: 5,460 metal, **24.1% more siege investment**; total siege-unit count is four versus five, not an increase in count |
| Armada FRONT, 5 minutes | 6 Ambassadors; ordinary tank/constructor production continues |
| Legion FRONT, 5 minutes | 6 Boreas; ordinary skirmisher, AA and utility production continues |
| Cortex bot factories, 5 minutes | 15 Sheldons; ordinary combat/constructor production continued |
| Legion bot factories, 5 minutes | 15 Thanatos; ordinary combat/constructor production continued |
| No-static FRONT control | No dedicated siege decisions; native production remains active |
| Four Incinerators | Six lasers destroyed by 71.1 seconds, no losses, three verified beam damage sources |
| Mixed Incinerator force | Eight HLTs destroyed by 68 seconds, no friendly losses; Incinerators advanced about 1,200 elmos but longer-range allies killed the targets first |
| Tremor combat regression | Four targets destroyed, four shooters, no losses or observed friendly damage |
| Sharpshooter regression | Four targets destroyed, four shooters and four cloaked units observed; no losses |
| Starlight regression | Four targets destroyed, four shooters, no losses; minimum sampled separation after 60 seconds approximately 263 elmos |

The early Cortex candidate made only one Tremor. Its cheaper-first affordability
selection consumed successive budget increases on Negotiators; the final mix
selection produced the second Tremor. Both original runs remain recorded.
Continuous-beam firing cannot be measured reliably by polling reloadFrame once
per second, so Incinerator proof uses actual UnitDamaged attribution.

## Failed fixtures and scope correction

The first production fixture treated BAR factories' `canMove` flag as physical
mobility and rejected both factory sites. The observer now distinguishes
immobile factories and uses TestBuildOrder for their footprints. This is a test
harness correction, not an AI terrain change.

TECH trials separately encountered unbuildable supplied AFUS coordinates,
combat gifts preceding the income sample window, and supplied buildings
violating naturally planned layout invariants. A layout-isolated trial still
produced no siege units because TECH deliberately keeps the general T2 combat
caps closed and only releases named rush/amphibious units. It also failed its
natural first-factory invariant. Those trials do not prove a TECH gameplay
regression or successful TECH siege production. No invariant was removed from
the implementation; the TECH hook and experimental fixture option were removed.
Every failed observation is retained below with its original verdict.

## Performance and limits

The producer runs only when an eligible factory requests work, after cheap role,
tier and income rejections. Known static metal and army cost use native
aggregates. Roster work is bounded by six definitions; pending-recruit callbacks
scan the native recruit queue, so the honest complexity is **O(K * Q), K=6**,
not constant time in queue length. No new timer, map scan, per-unit update or
movement command is added. Reported engine command counts are not network packet
counts. Changed unit populations prevent attributing render-FPS differences to
this small producer; no measured FPS gain or blanket no-regression claim is made.

Incinerator behavior in the reported match remains unverified. Reproduction
needs the affected map/profile and force/target context; see
[KI-521](../known-issues.md#ki-521---reported-incinerator-front-line-stall-not-reproduced-in-supplied-forces).
Natural 8v8 late-game siege composition has not received a dedicated full-match
benchmark in this change. Sheldon/Thanatos production passed supplied scenarios;
their performance against mixed player armies is a separate measurement.


## Validation and reproduction

The full `tools/run_native_tests.sh` suite passed, including three actual-VM
land-siege policy tests. Script/DLL API, invariant practice, role-document
freshness, Python compilation and whitespace checks passed. The existing
whole-repository unit checker reports 170 findings (map hover IDs and unreachable
sonars, KI-481/KI-473); none reference the new helper/controller. The documentation
checker reports eight pre-existing links to missing hover documentation (KI-404).
No unrelated map files were changed by this work.

The current data and matching stripped DLL/debug symbols were published to the
required development output at
`C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`;
API parity there passes. The live BAR installation was not modified.

Example (from the repository root, with a matching DLL/data pair):

```powershell
python tools/playtest/ranged_benchmark.py --cases land-siege-production-cortex land-siege-production-armada land-siege-production-legion land-siege-production-cortex-bots land-siege-production-legion-bots land-siege-no-static --dll build-theatres/d212-final/SkirmishAI.dll --minutes 5 --speed 8
python tools/playtest/ranged_benchmark.py --cases incinerator-front-push incinerator-mixed-front ranged-cortrem ranged-armsnipe ranged-armmanni --dll build-theatres/d212-final/SkirmishAI.dll --minutes 4 --speed 8
```

The runner now also invokes `land_siege_report.py` for production assertions;
finishing the observation window alone cannot count as a production pass.
Baseline production uses the same source with `LandSiegeEnabled=false` in a
separate staged data tree. Every run's source hashes and fixture overrides are
recorded; `--variant baseline` alone is a label, not an implementation switch.

## Immutable evidence

Original watcher verdicts below are retained. Production acceptance lives in
`land-siege-measurements-v3.json`; combat acceptance is in
`ranged-measurements-v5.json` when present. Incinerator beam evidence uses damage
attribution, and the first Incinerator case's original reload-polling shooter
threshold is not retroactively rewritten. Raw logs, replays, all screenshots and
staged source trees remain at the locations recorded in each result manifest.

| Scenario / raw run ID | Original watch | Compact evidence |
| --- | --- | --- |
| incinerator-front-push / `20261006T050221Z-5035783b` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/incinerator-front-push/2026-10-06/20261006T050352Z-b262dd77/README.md) |
| incinerator-mixed-front / `20261006T051217Z-9324362c` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/incinerator-mixed-front/2026-10-06/20261006T051332Z-17f57361/README.md) |
| land-siege-cortex / `20261006T051429Z-3cde09a2` | FAIL | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-cortex/2026-10-06/20261006T051512Z-7a344f31/README.md) |
| land-siege-cortex / `20261006T051648Z-283140fa` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-cortex/2026-10-06/20261006T051809Z-b1d6c75a/README.md) |
| land-siege-cortex / `20261006T051836Z-5e893307` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-cortex/2026-10-06/20261006T051956Z-8d789d70/README.md) |
| land-siege-cortex / `20261006T052138Z-730aff64` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-cortex/2026-10-06/20261006T052259Z-040e7cdf/README.md) |
| land-siege-tech / `20261006T052400Z-790757a5` | FAIL | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-tech/2026-10-06/20261006T052444Z-79cbd348/README.md) |
| land-siege-tech / `20261006T053027Z-d90f8cec` | FAIL | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-tech/2026-10-06/20261006T053111Z-eb0cb566/README.md) |
| land-siege-no-static / `20261006T052444Z-44c46d8d` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-no-static/2026-10-06/20261006T052605Z-13d857bf/README.md) |
| land-siege-armada / `20261006T053111Z-115504bb` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-armada/2026-10-06/20261006T053233Z-a103be14/README.md) |
| land-siege-legion / `20261006T053233Z-41c30df9` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-legion/2026-10-06/20261006T053354Z-2d20daf6/README.md) |
| ranged-cortrem / `20261006T052605Z-9b10cfb2` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/ranged-cortrem/2026-10-06/20261006T052727Z-0acc55fc/README.md) |
| ranged-armsnipe / `20261006T052727Z-4fe66265` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/ranged-armsnipe/2026-10-06/20261006T052849Z-1e3a851a/README.md) |
| ranged-armmanni / `20261006T052849Z-4fa930f2` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/ranged-armmanni/2026-10-06/20261006T053010Z-ef40d5dd/README.md) |
| land-siege-tech / `20261006T053432Z-b007ff41` | FAIL | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-tech/2026-10-06/20261006T053521Z-fd1a5911/README.md) |
| land-siege-tech / `20261006T053654Z-6ebd090e` | FAIL | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-tech/2026-10-06/20261006T053815Z-21ff0f03/README.md) |
| land-siege-cortex / `20261006T054710Z-6e11787f` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-cortex/2026-10-06/20261006T054830Z-efccd19a/README.md) |
| land-siege-cortex-bots / `20261006T054831Z-82bf5b89` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-cortex-bots/2026-10-06/20261006T054951Z-1d935a0e/README.md) |
| land-siege-legion-bots / `20261006T054952Z-5e729ffc` | PASS | [Record](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/combat/land-siege-legion-bots/2026-10-06/20261006T055113Z-2b9bba6f/README.md) |
