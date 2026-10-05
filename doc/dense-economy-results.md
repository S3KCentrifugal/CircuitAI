# Compact economy and naval support verification

2026-10-04. [Plan](dense-economy-plan.md). D190 adds script policy only on top
of the preserved D189 working tree. DLL SHA256:
`a293daae515d9f77945a095c2e84950177429b6b0da2b32366372bf347c1e28b`.
Baseline data and matching symbols are pinned under `build-theatres/d190-baseline`.

## Physical acceptance

| Fixture | Observed result |
| --- | --- |
| AIR advanced converters | Eight completed converters, all 10 shared edges at zero gap; frame 9300 (5:10). |
| SEA advanced converters | Six completed rectangular converters, all 7 shared edges at zero gap, accounting for facing; frame 6900 (3:50). |
| SEA T1 converters | Six completed converters, 7 shared edges; frame 12300 (6:50), after the tidal sequence. |
| SEA tidal strip | Twelve completed tidals across two adjoining patches, all 16 shared edges; frame 7800 (4:20). |
| Naval factory support | Amphibious complex: five completed turrets actively assisting at 1:40. Shipyard: fifteen completed turrets actively assisting at 2:50. |

Immutable records, original checks and screenshots:
[AIR converters](benchmarks/records/air/layout/dense-air/2026-10-04/20261004T142025Z-d633f435/README.md),
[SEA economy](benchmarks/records/sea/layout/dense-sea/2026-10-04/20261004T142414Z-7e46ba2c/README.md),
[shipyard/amphibious support](benchmarks/records/sea/layout/dense-support/2026-10-04/20261004T142300Z-2319eff6/README.md).

Fixtures supply constructors, capital and (for support) factories and fixed
products. Real layout reservations, constructor movement, workforce admission
and native turret assistance perform the work. These are placement/control
tests, not natural economy benchmarks. The large support bank intentionally
exercises bank-funded scaling. Physical footprint edges define spacing; model
meshes may occupy less than their build footprints.

## Natural economy comparisons

Paired runs use the same seed, game, engine, DLL and 20-minute horizon, with
pre-D190 working data as control. Both variants enable the existing SEA
migration option. Each game changes both SEA participants together; these are
self-play comparisons, not controlled strength matches against a fixed opponent.
Income, build power and survival below refer to the observed team 0.

| Map / seed | Variant | First turret | First T2 yard | Economy at 20 minutes |
| --- | --- | --- | --- | --- |
| Glacial Gap / 1881001 | Control | None | None | No yard; 125 build power; +12 metal, +421 energy. |
| Glacial Gap / 1881001 | D190 | 3:18 | None | No yard; 300 build power; +8 metal, +168 energy. |
| Tundra Continents / 1881001 | Control | 6:51 | None | One yard; 1,750 build power; +51.8 metal, +702 energy. |
| Tundra Continents / 1881001 | D190 | 3:55 | None | Lost all factories and build power; no income. |
| Tundra Continents / 1902 | Control | 8:36 | None | One yard; 1,825 build power; +40.5 metal, +590 energy. |
| Tundra Continents / 1902 | D190 | 7:12 | 13:47 | Two yards; 4,725 build power; +113.8 metal, +1,595 energy. |

The second Tundra candidate completed its T2 constructor at 14:28 and had six
construction turrets, 78 tidals and nine advanced mexes at 20 minutes. It
demonstrates sustained scaling on that seed. The first seed's loss demonstrates
why earlier support alone cannot establish stronger gameplay or a safe general
rollout. None of these runs completed a naval fusion by the horizon.

The final six comparisons passed runtime, invariant, opening-yard and product
egress checks. **Overall gameplay non-regression is not established.** The first
Tundra candidate's survival outcome was worse than its control. These small,
changing-pressure cohorts cannot identify whether the loss was caused by D190;
KI-231 stays open. Concurrent runs cannot measure CPU performance. Preliminary
20-minute smoke games are retained separately and do not count as final-code
comparisons.

Original paired evidence:

- Glacial seed 1881001: [control](benchmarks/records/sea/economy/cohort-baseline/2026-10-04/20261004T142605Z-6ddb1ba4/README.md), [D190](benchmarks/records/sea/economy/cohort-candidate/2026-10-04/20261004T142623Z-f9b63e2e/README.md).
- Tundra seed 1881001: [control](benchmarks/records/sea/economy/cohort-baseline/2026-10-04/20261004T142857Z-3efb4dd1/README.md), [D190](benchmarks/records/sea/economy/cohort-candidate/2026-10-04/20261004T142926Z-328aee2f/README.md).
- Tundra seed 1902: [control](benchmarks/records/sea/economy/cohort-baseline/2026-10-04/20261004T143418Z-d9955086/README.md), [D190](benchmarks/records/sea/economy/cohort-candidate/2026-10-04/20261004T143429Z-7353dd69/README.md).

## Static verification and provenance

- Five SEA math tests and 19 shared build-power tests pass. They cover proportional
  budget allocation, pending support, resource demand and cap boundaries.
- The deployed DLL exposes all 284 script API members used by the active scripts.
  Role-document and invariant checks pass; the scripts also compile and execute
  in the supplied and natural simulations.
- A byte comparison against the pre-D190 working data finds exactly seven
  changed files: global settings, layout helpers, SEA math, AIR economy layout,
  SEA layout, SEA economy and SEA build. TECH and all other data files are
  identical to that baseline. No D190 native or profile JSON changes.
- All 320 active data files match the required engine build output. The DLL
  hash matches the pinned baseline; the live BAR installation was not modified.
- Twenty-one D190 observations, including original failed fixture iterations,
  are published in the categorized benchmark store with hashes and discovery
  indices. Raw logs/replays remain in their recorded game directories.
- Existing repository-wide checks still report 167 unit-helper findings and
  eight missing links to the unwritten hover-role guide (KI-404). D190 introduces
  no additional findings in those checks; they are not represented as passes.

## Scope and limitations

- AIR T1 spacing and TECH/other role policies are unchanged. No global building
  masks or native movement behavior changed.
- SEA's existing `ExperimentalBuild=false` default remains. These improvements
  apply when its new layout system is enabled. Broader migration acceptance
  (KI-231) and general terrain/approach recovery (KI-235) remain open.
- Existing activated modules remain fixed. New plans use the new geometry.
  Fixed geo/mex sites and shipyard exits retain their constraints.
- Supplied acceptance uses Armada. Natural games include Armada, Cortex and
  Legion, but this is not a complete faction/factory matrix. Floating hover
  plants and underwater gantries share eligibility; their individual supplied
  production fixtures remain unplayed.

## Preserved failed iterations

The one-minute compile probe compiled cleanly but used a six-minute egress
check, so its original verdict remains FAIL. Early supplied tests failed from
dry naval spawn sites, non-square footprints measured without rotation, a frozen
AIR opener that never planned its module, or missing fixture AIR task ownership.
Those fixture errors were corrected without weakening production behavior.
Support testing also revealed real cross-site search starvation, corrected in
production. All original failed records are retained.
