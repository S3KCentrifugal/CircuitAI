# TECH / ECO meta and deterministic progression

This document records the current economy-player model implemented by the
TECH role. It treats the economy as three resources:

1. **Metal** - map-wide purchasing power.
2. **Energy** - map-wide operating and construction power.
3. **Build power** - local throughput. A constructor or construction turret
   can spend resources only on targets within its reach, so build power must
   be planned per base cluster rather than counted globally.

Decision: [D-062](decisions.md#d-062--tech-opens-on-home-metal-and-scales-by-regional-build-power).

## Evidence

The shared knowledge base establishes the economic ordering:

- [income sources](../../rjm.bar.docs/knowledge/50-economy/50-income-sources.md);
- [build power](../../rjm.bar.docs/knowledge/50-economy/51-build-power.md);
- [scaling curves](../../rjm.bar.docs/knowledge/50-economy/52-scaling-curves.md);
- [construction rules](../../rjm.bar.docs/knowledge/10-engine/15-construction-economy-rules.md).

A T1 mex on a 2.0 spot pays back in roughly 25 seconds. No energy structure
comes close, so safe home metal is claimed before the opening energy/factory
spend. Construction turrets provide 200 BP in a 3x3 footprint with 400-elmo
reach; their value is regional and depends on what is built against them.

Current Supreme Isthmus ECO replay evidence strongly favors three initial mex
commands, a bot lab as the first factory, and roughly three to five winds
before it. The deterministic TECH policy intentionally chooses six winds for
a larger wind buffer. Supreme's map wind is 1-19 (average 10), where wind
remains much cheaper per average E/s than solar.

## Supreme home cluster

The configured TECH starts are P2 `(837, 10407)` and P10 `(11456, 1901)`.
The current map data has three home spots within about 336 elmos and a fourth
spot roughly 1,109-1,129 elmos away.

Therefore these two requirements are not equivalent:

- every mex within 1,200 elmos: four spots;
- the established three-mex home cluster: three spots.

CircuitAI uses a 1,200-elmo search with a nearest-three cap. The cap is
explicit in `SupremeIsthmus::config`; it prevents the distant fourth spot from
delaying the wind and factory phases.

## Deterministic opening

**Superseded by D-063.** The opening is now every reachable mex within
2,000 elmos of the start, nearest the commander first, then the start
factory; the wind count and the post-lab storage are the planner's calls.
The Supreme record below is kept as the D-062 basis.

For Supreme TECH:

```text
3 nearest reachable home mexes
-> 6 wind turbines
-> release the native T1 bot-lab scheduler
-> wait until the lab frame exists
-> 1 energy storage
-> normal TECH economy policy
```

Native code supplies facts and actions:

- reachable home-spot count;
- claimed/queued home-spot count;
- enqueueing the nearest open eligible mex;
- holding the native start-factory job;
- pending build counts.

AngelScript owns the ordering and map-specific cap. Claimed mexes and queued
structures count immediately, preventing multiple callbacks from requesting
the same phase.

The native periodic storage builder is disabled only for TECH. Otherwise it
races the deterministic planner and can enqueue storage based on completed
counts before script-side queued work appears.

## Storage

One T1 energy storage provides a 6,000-E buffer. On Supreme, six winds swing
from 6 E/s at minimum wind to 114 E/s at maximum, plus commander income, so
one opening storage is useful.

TECH's ordinary cap is one. Storage is not income and should not displace
mexes, the six opening winds, or the first lab. Queued and under-construction
storage counts toward the cap. A future weapon-specific policy may request
another store explicitly; the general eco planner does not.

## Converters

The planner reads converter facts from native `CEconomyManager` rather than
assuming fixed values:

| Converter | Energy use | Metal output |
| --- | ---: | ---: |
| T1 | 70 E/s | 1.0 M/s |
| Advanced | 600 E/s | about 10.34 M/s |

A converter is built only when:

- the energy bank is at least 90% full;
- ten-second energy income minus current pull covers its actual draw;
- the AI is not energy-stalling;
- no energy generator is currently under construction;
- no same-definition converter task is pending.

The compact module starts with four advanced converters per completed AFUS,
leaving about 600 E/s per Armada/Cortex AFUS for production. A fifth is
allowed only from measured surplus. Four AFUS and 18 converters therefore
leave approximately 1,200 E/s before other pull.

## Regional build power

`CBuilderManager::GetBuildPowerNear` sums completed, assist-capable builders
and construction turrets within the configured cluster radius. It does not
treat all team build power as interchangeable.

The module reserves its maximum geometry at setup but builds rows
progressively:

| Row | Default metal-income gate |
| --- | ---: |
| 1 | module activation |
| 2 | 100 M/s |
| 3 | 150 M/s |
| 4 | 190 M/s |

If regional build power is below `EcoBuildPowerPerMetal x metal income`,
one additional preplanned row is requested, up to the map profile's limit.
This lets persistent metal float accelerate local build power without making
every TECH base build the full late-game cluster immediately.

Supreme requests four rows:

- full module: 32 nanos, four AFUS, 18 advanced converters (`24 x 30` cells);
- half module: 16 nanos, two AFUS, nine converters (`12 x 30` cells).

The nano band touches both AFUS and converter bands. Temporary T1 energy is
placed around the held module/factory cluster rather than at arbitrary points
across the base.

## Recycling

TECH switches to its aggressive economy settings once the configured income
gate is met:

- `ReclaimOldEnergy` marks inefficient wind/solar/advanced-solar structures
  for reclaim when a sufficiently better source completes;
- `reclaimOldConvertersAlways` lets an advanced converter recycle obsolete T1
  converters even while the energy bank is full;
- reclaim returns the metal to the economy, allowing the same footprint and
  capital to move from opening energy through fusion and into AFUS-era
  scaling.

The gantry remains a production factory. Native factory layout places it on
the enemy-facing factory line, reserves a clear exit, and gives it a rear
construction-turret block. Floating and underwater factories remain outside
the land-layout path.

## Verification

The pure C++ geometry suite covers the default three-row and Supreme
four-row modules. Static checks cannot confirm runtime build order,
constructor reachability, reclaim timing, or converter operation. Those
scenarios remain tracked in
[KI-408](known-issues.md#ki-408--tech-eco-progression-is-not-yet-played).
