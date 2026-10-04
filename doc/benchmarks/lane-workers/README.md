# Lane-worker benchmarks

Recorded September 29, 2026 (Halifax); dated JSON records use September 30 UTC.
All samples used Recoil `recoil_2026.07.04`, game `Beyond All Reason test-31450-6562fb1`, Legion enabled, extra units and player Scavenger units disabled, headless at requested speed 8, natural income, and approximately six game minutes. These are short performance samples, not match-win or all-terrain attack-effectiveness evidence.

## Supreme Isthmus v1.7: 8 versus 8

Mixed Armada/Cortex/Legion roster, all map roles, experimental_hard profile. Both modes used DLL SHA256 `36ae8cf0ee2b0f510aff94a3c2b750253267683ba54f3f436c29a2fcc026f1b7`. The background setting selects the same native solver; the observer requests every team's survey and a refresh.

| Per-survey measurement | Synchronous | Worker |
| --- | ---: | ---: |
| Completed calculations | 37 | 36 |
| AIs with completed results | 16/16 | 16/16 |
| Main-thread work, median | 101.837 ms | 25.291 ms |
| Main-thread work, p95 | 154.458 ms | 73.822 ms |
| Main-thread work, maximum | 169.046 ms | 78.435 ms |
| Solver time, median | 74.258 ms | 79.226 ms |
| Snapshot time, median | 0.369 ms | 0.371 ms |
| Worker queue delay, maximum | — | 0.015 ms |
| Main-thread postprocessing, median | 25.971 ms | 24.930 ms |
| AI/worker errors | 0 | 0 |
| Invariant lines | 0 | 4 |
| Overall game check | PASS | FAIL |

Observed median main-thread survey work fell **75.2%** and p95 fell **52.2%**. Main work sums snapshot, publication and postprocessing, plus solver time in synchronous mode. It is not a whole-game frame-time or FPS benchmark. Initial surveys cost more than refreshes, and the sample counts differ; these aggregate percentiles are descriptive, not a statistical confidence interval.

The records retain exact settings rather than merging them into a rated cohort. Map/game/roster/AI options/DLL match; the auto-generated `date_hour` modoption differs (21 versus 22), as do timestamps, background configuration and runtime states. Fifteen of sixteen initial geometry fingerprints match; team 1 differs. This is not a same-input determinism test: observation/capture timing and game evolution differ. The unit suite checks identical immutable requests concurrently. Scorecard start verification is false, so these runs are not eligible for a strong gameplay comparison or an OpenSkill update.

At the worker game's last six-minute sample, all teams together had completed **152 combat units / 16,763 metal**, with **9,986 metal** of combat army remaining and **220.1 metal/s** combined income. No all-terrain combat completion was recorded in this short opening. There was no match winner.

The worker game's four invariant lines were INV-001 (retiring factory produced a constructor), INV-008 (reclaim assistance), and two INV-019 (turret construction budget). They are in the existing TECH failure family tracked by KI-427, but this experiment does not establish their cause or rule out timing effects. Lane publication and refresh checks passed; the global failure remains visible.

- [Synchronous timings and exact manifest](2026-09-30/20260930T005854.907848Z-40118188.json)
- [Worker timings and exact manifest](2026-09-30/20260930T010133.331433Z-0d662a64.json)
- [Worker gameplay scorecard](../scorecards/2026-09-30/20260930T010133.331433Z-0d662a64.json)
- [Preliminary worker run, earlier DLL; excluded from comparison](2026-09-30/20260930T005435.764754Z-d16d0dd6.json)

## Additional worker samples

Both samples used two TECH players, Legion versus Armada, with the same final DLL. They are separate map/profile cohorts, not direct comparisons to Supreme.

| Map / profile | Jobs | Main median / max | Worker solve median / max | Overall |
| --- | ---: | ---: | ---: | --- |
| Glacial Gap v1.1 / experimental_balanced | 6 | 11.505 / 42.391 ms | 41.464 / 67.023 ms | FAIL: 8 invariant lines |
| Ascendancy v2.2 / experimental_terrible | 5 | 11.714 / 74.059 ms | 152.669 / 167.987 ms | FAIL: 8 invariant lines |

Both AIs on each map published results and refreshed them; no AI/worker errors or INV-070 publication failures occurred. Glacial reported INV-013/019/029; Ascendancy reported INV-004/008/013/015. Ascendancy uses the documented staged-only fallback TECH role override (KI-428); it is not the unmodified map-role experience.

- [Glacial timings/settings/errors](2026-09-30/20260930T010133.625557Z-1eca8cbe.json)
- [Ascendancy timings/settings/errors](2026-09-30/20260930T010133.999566Z-69d04942.json)

## Verification and limits

Six native lane suites pass, including eight concurrent identical-request solvers, cancellation/admission generations, threat ownership, connectivity and specialist high ground. Existing native layout suites, the 231-member DLL/API parity check, role-document check and invariant-practice check pass. Cancellation and teardown have unit coverage; these sample games are not a forced native teardown race test.

Worker code owns immutable input and private scratch data, invokes no engine or script API, and hands complete results back through the scheduler. Old results remain readable until main-thread publication. Comments and D-144 explain this boundary and background queue priority.

Script-side validation, water/strategic-site analysis, overlay publication and route-connector searches still run on the main thread. Postprocessing reached 77.776 ms in the final Supreme worker sample; see KI-433. CPU time is relocated, not eliminated. Performance under larger rosters, prolonged combat, CPU saturation or terrain deformation still needs measurement.

Build output contains the matching stripped DLL, symbols and current data. No files were copied to the owner's live game install.
