# Metal-map implementation: measured results

2026-10-02. Implementation: [metal-maps-implementation.md](metal-maps-implementation.md).
Machine-readable measurements: [simulation census](benchmarks/metal-map-simulations.json).
The forty-mex opening is explicit owner policy. These tests establish behavior,
not optimal competitive timing or an unbeatable AI.

## Final behavior observed

Final native DLL: `build-theatres/d170-build-10/SkirmishAI.dll`, SHA-256 prefix
`9d1c668474924f01`, 7,742,137 bytes, with matching debug symbols. The last native
change restores cancelled field-mex reservations; it is guarded by the field
task tag. Build 9 (`b00160a53d718c84`) supplied the full normal-map controls.
Final script recovery reassigns orphaned mex orders before creating more work.

All runs use Recoil `recoil_2026.07.04` and game
`Beyond All Reason test-31479-433a460`, separate engine write directories,
natural resources and rendered screenshots. Metal start fixtures explicitly
assign AIR/TECH positions; they are registered only in staged data. Team order
is AIR/Cortex, TECH/Armada, TECH/Cortex, AIR/Legion unless stated otherwise.

| Run | Duration | Completed mexes / transition evidence | Converter starts | Full verdict |
| --- | --- | --- | --- | --- |
| `d170-nine-final` | 20 min | All four reached 40 at 15:30, 12:00, 14:30, 13:00; final counts 40, 42, 56, 46 | 0 on every team | FAIL: two INV-013 forward-cluster warnings |
| `d170-forty-nine` | 30 min | Earlier full run: all four reached 40 at 15:00, 13:00, 11:30, 12:30; peaks 96, 47, 63, 75 | 0 | FAIL: TECH invariants |
| `d170-forty-plate2` | 21+ min, stopped after diagnosis | Peaks 54, 22, 46, 44; three players reached 40; exposed TECH worker diversion later fixed | 0 | FAIL: obsolete metal-mode INV-021, subsequently narrowed to ordinary maps |
| `d170-forty-speed3` | 24.2 min, game ended | Both TECH players reached 40 at 15 and 18 min; AIR peaks 36 and 27 | 0 | FAIL: TECH invariants |
| `d170-forty-speed4` | 30 min | Cortex TECH reached 40 by 20 min; other bases were damaged/destroyed before forty | 0 | FAIL: TECH invariants; focused audit also flags missing census after team elimination |
| `d170-legacy` | 20 min | Native **hard** profile, four players: peaks 130, 111, 147, 138; forty by 8:30–9:00 | 0 | PASS |
| `d170-cancel` | 8 min | Controlled unframed mex cancellation released pin 247, which was served again; 11 subsequent team-0 mex completions | 0 | PASS |

The `hard` run has no AngelScript AIR/TECH role controller. Its start labels in
the generic harness report are metadata, not evidence that experimental roles
ran. Its successful native converter/extraction checks are reported separately.

In the 30-minute Nine Metal Islands run, AIR screens completed at 5:29 and
3:46; corresponding T2 lab frames appeared at 5:35 and 3:53. TECH's third T1
constructors appeared at 2:21 and 2:32; T2 lab frames followed at 2:51 and 3:01,
including travel to their planned sites. At twenty minutes of the final run,
AIR had four labs each and 80/104 completed non-factory builders (including
construction turrets). This is observed growth, not a pure mobile-constructor
count or a throughput guarantee.

Dense placement was checked both visually and through independently observed
mex coordinates. In `d170-forty-nine`, 96/98, 48/48, 63/63 and 74/75 observed
sites had another mex site within 64 elmos. This measures construction-site
spacing, including sites later destroyed. It does not imply every site survived
or that neighbouring upgraded extraction circles never overlap.

## Normal-map controls

Both baseline and changed games ran twenty minutes. These were unseeded natural
combat games, so numerical differences are not a deterministic equivalence test.
Source review confirms that normal mode skips field construction, dense mex
modules, dedicated worker assignments and converter suppression. The independent
spot-zero cancellation repair and actual-producer diagnostic are the explicit
normal-mode differences.

| Map / team 0 | Before | After |
| --- | --- | --- |
| Supreme Isthmus, AIR | 4 mexes, 18 converter starts, 2 labs | 4 mexes, 10 converter starts, 2 labs |
| Glacial Gap, TECH | 17 mexes, 12 converter starts, 1 lab | 16 mexes, 5 converter starts, 1 lab |

Both changed games retained positive finite spot classification, no metal-mode
team or `[METAL]` policy entry, working factories, ordinary upgrades and converter
construction. Their focused compatibility audits pass. Their full reports fail
on TECH invariants, as do both baselines: Supreme shares INV-016 with its baseline;
Glacial shares INV-013/028/021/008. Other occurrences differ and remain recorded.
Glacial's existing map configuration supplies TECH starts, so this control was
TECH versus TECH. Supreme exercised both AIR and TECH.

The final native cancellation amendment executes only for tagged field tasks;
the later script amendment adds field-worker recovery. The ordinary-map controls
predate those two metal-only amendments. No claim of replay-byte identity is made.

## Fixes driven by the tests

The retained failed iterations found configuration-fragment replacement,
startup-config lifetime, a coarse ally exclusion covering AIR's own SpeedMetal
start, constrained platform factory packing, storage over-queueing, mex snapping,
task-to-reservation blocker handoff, dedicated TECH workers diverted to defenses,
and cancelled mexes retaining their served pins. All were corrected in this
change. Forty is a minimum opening commitment; further demand adds more modules.

The cancellation fixture is reproducible with `prepare_metal_check.py
--cancel-first --dir <staged-dir> ...` and `metal_cancel.json`. At frame 5681 it
observed `taskPin=-1 state=0`; the same pin was served again at frame 6137.
The independent deferred cleanup check also passed. The fixture changes only
staged scripts and supplies no resources or units.

## Validation limits and retained evidence

The full native test runner passes: layout (76 checks), base geometry, lanes
(8 suites), strategic targeting (6 suites), terrain (18 scenarios), air geometry,
field yield/claims/overlap/upgrade/cancellation arithmetic, and 245 AngelScript
policy cases (133 + 20 + 19 + 61 + 12). All 275 used script API members match the
built DLL. Invariant-registration, role-document and whitespace checks pass.

The document-link check retains eight pre-existing missing `roles/hover.md`
links (KI-404). Unit-helper validation retains two unreachable sonar references
in unchanged `tech_weapons.as` (KI-473). Full simulation failures, banked metal,
energy stalls and outstanding save/load/profile/performance coverage are tracked
under KI-472. The bounded searches and once-per-second snapshots are not measured
8v8 FPS or APM guarantees.

Each named run retains `infolog.txt`, `report.md`, a staged data/DLL snapshot,
`staged.json`, and `screenshots/` under `build-theatres/<run>/`. Representative
captures are listed in the census JSON. Screenshots remain local artifacts;
they are not fabricated or reconstructed from logs. None of these tests wrote
to the live game installation.
