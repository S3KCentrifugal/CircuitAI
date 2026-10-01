# Juno target priority

All profiles use the shared `CSuperTask` pulse controller by default. Roles
decide whether to build a Juno; they do not change its targeting. D-157 fixes
the missing peaceful-enemy candidate pool, adds explicit tower tiers and
coordinates allied shots. See [design and verification](strategic-targeting-plan.md).

## Priority

| Rank | JSON class | Targets |
| ---: | --- | --- |
| 0 | `jammer_advanced` | Advanced static jamming towers |
| 1 | `jammer_static` | Other static jamming towers |
| 2 | `radar_advanced` | Advanced static radars |
| 3 | `radar_static` | Other static radars |
| 4 | `jammer_mobile` | Fresh known mobile jammers |
| 5 | `radar_mobile` | Fresh known mobile radars |

Loaded `juno_kill`, radar/jammer ranges and `techlevel` classify sensors once
at configuration load. Existing jammer/radar role tags remain extensions.
Configured Juno unit names cover legacy profiles without requiring new role
tags. No unseen enemy is revealed by classification.

The scan reads **both** known-enemy snapshots: combat and non-combat. Previously
it read only the former, excluding peaceful radar and jammer towers before
ranking. It rejects fake/dead/dying/ignored enemies, stale mobiles, unreachable
positions and areas already claimed by allied Junos. Candidate impact points
are ranked by the best class inside the loaded blast radius, then total sensor
value. Known available targets beat all speculative fire. A claimed jammer is
already being handled, so another Juno can progress to the next target.

## Fallback and coordination

If no known target qualifies, the existing suspected-jammer radar-hole scan
runs first. If that also fails, sample the current allied LOS boundary and
aim slightly beyond it on the enemy-facing side. Enemy-contact/influence
information ranks the boundary, while a rotating tie-break spreads shots.
Scatter does not read hidden units and never falls back to the richest army.
There is no fallback shot if no valid boundary exists, including full-map LOS.

The shared ally-team ledger reserves an area when a loaded Juno receives its
order. Actual weapon-fired events replace that pending claim with a recent-shot
area; stockpile drops provide a deduplicated fallback. The launch command is
stopped after firing. Pending claims cancel with their task or time out; a
launched missile's claim survives destruction of its Juno until expiry.

Allied Juno ground-attack commands are also observed, including human orders.
This reserves their current ground aim without controlling their units. A human
can still change an order between observation ticks, and unit-target commands
are not inferred as ground claims. AI-to-AI launch coordination is authoritative;
human-command observation is best effort.

## Configuration

Every active `data/config/**/behaviour.json` supplies the six-class order and
enables scatter. `CMilitaryManager::ReadConfig` also has matching defaults.

| Key under `pulse` | Default / meaning |
| --- | --- |
| `enabled` | true; false explicitly disables the pulse controller |
| `units` | armjuno, corjuno, legjuno; optional explicit launcher list |
| `role`, `jammer`, `radar` | Existing role-based extensions |
| `priority` | The table order; omitted classes are excluded |
| `mobile_max_age` | 60 seconds |
| `min_targets` | 1 |
| `pending_seconds` | 45 seconds for a queued shot |
| `coverage_seconds` | 90 seconds from launch, allowing flight and impact |
| `scatter` | true |
| `scatter_step`, `scatter_depth` | 384 / 192 elmos; large-map grid is bounded to about 4,096 seed cells |
| `suspect_jammer` | true; enable radar-hole inference |
| `hole_probe_radius`, `hole_radius` | 760 / 500 elmos |
| `hole_min_enemy_infl`, `hole_probes` | 0.05 / 8 |

Log tags distinguish `PULSE ... rank=`, `suspected jammer`, `fog scatter`, and
`PULSE: launched from`. A launch inside an active exclusion emits INV-095.

## Limits

The controller does not target mines/scouts as explicit known classes (KI-302),
nor control Legion's mobile mini-Juno bomber (KI-102). The owner's tower order
also applies under the optional Juno rework, although the game effect changes
from destruction to temporary sensor paralysis (KI-303). Fog geometry and
claims are based on current observations, not omniscience. Strategic shot history
is not serialized across save/load (KI-444).

Game mechanics and the pinned unit lists remain in the shared knowledge base,
`../rjm.bar.docs/knowledge/20-game-mechanics/23-special-systems.md`.
