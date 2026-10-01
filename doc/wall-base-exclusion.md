# Walls outside allied bases (D-154)

AIR and TECH must leave the area around allied starts open for economy,
factories and movement. Use a shared 1,200-elmo radius, configurable as
`weapons/fortification/base_exclusion_radius`. This matches the existing TECH
front-factory base-radius default, but is an independent policy setting.

Implementation plan:

1. Share one footprint-versus-circle predicate and one allied-start cache.
   Combine this AI's real start, allied roster announcements and playing-team
   start-script positions; never use enemy starts or empty map spawn slots.
2. Reject wall footprints at planning and at the snapped reservation position.
   Apply the same admission to AIR's queued defense service. Keep existing
   defense guns and economy reservations governed by their existing rules.
3. Move TECH lane lines forward beyond the base exclusion, bounded by the
   current front and worker radius. Omit them if no safe eligible line exists.
   Skip resource wall rings for assets inside a base; retain forward perimeters.
4. Release unstarted reservations invalidated by late start announcements and
   audit wall construction with INV-089. Do not reclaim existing structures.
5. Run geometry unit tests and a controlled game with rear and forward assets.
   Independently run the current explicit TECH nuke-rush setting, recording
   whether a silo finishes and whether a missile is actually fired.

This replaces the earlier request to wall every advanced mex and geothermal
plant: rear assets are excluded. Walls address ground movement and fire;
backline anti-air remains appropriate and is unaffected. See the shared
[defensive placement research](../../rjm.bar.docs/knowledge/60-tactics/66-defensive-placement.md).

The policy is implemented in [WallHelpers](../data/script/src/helpers/wall_helpers.as),
with dependency-free [placement geometry](../data/script/src/helpers/placement_math.as).
It caches the allied-start union for one second. Existing framed structures are
preserved if a late announcement changes the exclusion. Start positions must be
known from the script or roster; unknown human-selected starts cannot be inferred
from an empty map spawn slot. Save/reload of an older build's wall reservations
has not been exercised.

## Validation, 2026-09-30

All runs used Supreme Isthmus v1.7, BAR test-31450-6562fb1, recoil_2026.07.04,
experimental_hard, zero income bonus, and DLL SHA256
`fcc2c7ea532f9ef37b3f3991023d6e6bca018b49d9d5f906234ad7f2f13b6046`.
Run manifests and logs remain under the repository's ignored `build-theatres/`.

| Run | Evidence | Strict verdict |
| --- | --- | --- |
| `d154-walls/runs/20260930-210130` | Rear assets in TECH's own base and the allied AIR base; six forward resource walls completed; zero base-area wall creations and no INV-089 through 14.5 minutes. All five wall expectations met. | FAIL: other TECH INV-004/010/015/037 |
| `d154-fortification-final/runs/20260930-210640` | Final scripts; future gantry reserved, forward geo/mex walls completed at 1.2 minutes, T2 lane line planned. All five fortification expectations met through 15.1 minutes; no script error or INV-089. | FAIL: TECH INV-010/011/015/019/022/029/047/052 |
| `d154-nuke/runs/20260930-205611` | Control before wall edits, explicit `RushObjective="nuke"`; silo completed at frame 32847 (18:15), chain completed and native super task assigned. Positive stockpile but no target at frames 41569/43369/45169; no launch by 25.1 minutes. | FAIL: missed 16:30 silo benchmark; INV-008 on tested team, other teams also INV-011/022 |

The fixture supplies assets, builders and economy to exercise placement; it is
not evidence of natural economic timing. The nuke control is a natural run.
The unrelated invariant reports remain failures and are recorded under KI-427;
this work does not assign their cause or weaken their checks.

`tools/run_native_tests.sh` passed: 76 layout-ranking checks, base geometry,
eight lane-solver suites, 93 production-policy cases and ten new placement cases.
The new cases cover boundary contact, footprint overlap with a centre outside,
diagonals, a second allied base, a long wall line and invalid extents.
API parity and role-document checks pass. Existing unit-catalog findings for
`armsonar`/`corsonar` remain KI-425; missing hover-document links remain KI-404.

## Current nuke setting

Set `Global::RoleSettings::Tech::RushObjective = "nuke"` in
[global.as](../data/script/src/global.as). It is a script setting, not a lobby
option. `Tech::ExperimentalBuild` must be enabled. `"auto"` currently chooses
`"afus"`; `NukeRush` elsewhere in TECH settings is a count used by the older
income-gated constructor path, not the active rush-chain selector.

The explicit chain still builds and stockpiles a silo, but current evidence does
not verify a successful first strike. Shared `Military::AiMakeTask` returns a
native super task before TECH's first-strike handler can run, leaving this game
waiting for ordinary target intelligence. `CSuperTask`'s `no target` diagnostic
requires a positive stockpile, and its launch event logs `NUKE: launched`.
The dispatch defect is recorded under KI-418; the timing miss is KI-441. No nuke
setting or targeting behavior was changed by the wall fix.
