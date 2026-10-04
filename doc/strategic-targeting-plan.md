# Shared Juno and nuclear targeting (D-157)

Design written before implementation, 2026-09-30.

## Diagnosis

Juno's area scan reads only hostile combat snapshots. Non-combat radar and
jammer buildings also live in the separate peaceful-enemy snapshot, so priority
ranking cannot help when those targets never enter the candidate list. The
existing ranking also merges advanced and basic towers. Its radar-hole fallback
requires known enemy contacts and radar coverage; it cannot scatter along an
otherwise empty fog boundary. No allied launch reservation exists.

Strategic nukes use mixed enemy groups, allowing expensive mobile units to win.
The persistent attack command and stale position memory can repeat the same
strike. There is no history of launch locations per physical silo.

## Changes

- Scan both enemy snapshot classes for Junos and strategic nukes, without
  revealing unobserved enemies. Keep other super-weapon selection unchanged.
- Juno order: advanced static jammer, static jammer, advanced static radar,
  static radar, mobile jammer, mobile radar. Classify loaded Juno-vulnerable
  sensors by their properties and technology level, retaining role tags as
  compatible extensions. Configure priority and all thresholds in JSON.
- If no available known sensor or inferred jammer hole exists, sample hidden
  ground adjacent to current allied LOS, slightly inside the fog. Prefer
  contested/enemy-facing boundaries, rotate equal candidates across launches,
  and never use hidden enemy units to generate points.
- Share Juno pending and recent-shot areas through the native ally-team object.
  Pending claims have a timeout; actual launches extend the exclusion through
  flight/impact time. All allied AI roles consume the same ledger. Also observe
  allied queued ground-attack commands, including human Junos; humans can still
  override their own orders and are never controlled by this protocol.
- Strategic silos rank only known immobile structures and count only those
  structures toward the shot's value. Preserve friendly-blast avoidance and
  the existing stockpile value floor. Tactical launchers and EMP are separate.
- Record actual launch locations per silo, excluding a blast-sized area for
  300 seconds. Another silo is unrestricted by that history. Recheck at command
  execution, including script overrides. Stop the completed launch command so
  the engine cannot repeat it before the next selection pass.
- Keep histories with the allied unit identity, across task recreation and
  allied transfers; prune destroyed units/expired entries. Do not claim save/load
  persistence without testing it.

## Verification

Use dependency-free tests for class ordering, mobile exclusion, expiry bounds,
same/different silo identity, overlap, allied pending claims and cancellation.
Build the native DLL and run focused engine fixtures with separate sensor
classes, allied Junos, fog scatter, a T3-only nuke target, two silos sharing a
building target, and a surviving/rebuilt target inside the five-minute window.
Observe actual projectiles/launch events, not just attack orders. Keep global
invariant checks active and report unrelated failures explicitly.

BAR's [Juno unit page](https://www.beyondallreason.info/unit/legjuno) and
[advanced mechanics guide](https://www.beyondallreason.info/guide/important-knowledge-on-advanced-mechanics)
support its sensor-denial use. Exact loaded effects and the optional Juno rework
are described in the shared knowledge base's `23-special-systems.md`. The
owner's explicit tower order remains authoritative even under that rework;
this change does not silently replace it with scout priority.

## Measured results

Built and played with stripped DLL SHA-256
`bd4070a901d2ff1eb8cd83609b17d2d15ca5359e40b361277b9ec1649c143a23`,
Recoil `recoil_2026.07.04`, BAR `test-31450-6562fb1`, Supreme Isthmus v1.7.
All runs are under ignored `build-theatres/`; retained logs, reports and
`strategic-audit.json` preserve the evidence. Stock is injected once, so this
tests targeting capability rather than economic timing.

| Run | Observations | Result |
| --- | --- | --- |
| `d157-juno03/runs/20260930-234327` | Experimental AIR and SUPPORT allies; Armada and Cortex Junos select ranks 0, 1, 2, 3 in order. 42 confirmed launches and 42 independently observed stock drops; fog scattering continues after the explicit local-vision phase. No impact point enters another active 90-second exclusion. | Harness and independent audit pass; 9.4 game minutes, zero invariants/errors. |
| `d157-nuclear03/runs/20260930-234337` | No shots during the mobile/Titan-only phase. Both silos fire at the AFUS site at frame 5757 (3:11.9). Cortex fires again at 15032 (8:21.1), Armada at 15336 (8:31.2): intervals 309.2 and 319.3 seconds. All four shots hit the same permitted site; the fixture replaces destroyed AFUSes. | Harness and independent audit pass; 11.4 game minutes, zero invariants/errors. |
| `d157-juno-hard01/runs/20260930-234637` | Legacy hard profile also loads the six-class controller and selects all four tower classes in order; both allied Junos fire and scatter. | Harness and launch audit pass. Autonomous legacy combat remains enabled: the allied teams are removed around 5:01, so the 9.5-minute report is not nine minutes of surviving launchers. |

The initial fixture destroyed commanders next to the injected launchers, which
destroyed the test subjects; those runs are invalid. A second fixture repeatedly
reset ammunition downward, creating artificial stock-drop launch signals. The
final fixture preserves commanders and supplies stock only once. The native
stock-drop fallback now also requires an active, valid engagement; an idle ammo
edit cannot register a launch. Earlier failed reports remain retained.

The audit reads Juno's loaded radius from the game: 700 elmos. Recoil halves the
source `areaofeffect=1400` diameter when loading it. Corrected this distinction
in the shared game knowledge; targeting and claims use the loaded radius.

The native suite passes: layout ranking (76 checks), geometry, lane solver
(eight checks), strategic targeting (six suites), production math (128 checks)
and placement math (20 checks). Invariant and role-document checks pass;
script/DLL parity verifies all 253 used API members. Documentation link checking
reports only the eight existing missing-hover links (KI-404). Shared knowledge
validation checks 753 files with zero broken links, missing images or unknown
unit IDs. Unit-helper checking retains the two existing TECH sonar findings
(KI-425). No sample-profile files changed.

Published the stripped DLL, matching debug symbols and current `data/` together
to the required Recoil build output `build-amd64-windows/install/AI/Skirmish/BARb/stable`,
with API parity checked there. The owner can deploy that output to the game.

Limits: this is controlled targeting evidence, not a full competitive balance
benchmark or every role/faction/map combination. Human command observation is
best effort; pending task cancellation and per-owner history are unit-tested,
but allied transfers are not separately exercised in-game. Save/load does not
serialize these histories (KI-444); uninterrupted match behavior is verified.
