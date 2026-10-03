# AI gameplay benchmarks and evidence

Start with a gameplay area, then follow its evidence links. The
[machine-readable catalog](catalog.json) indexes files, not game counts:
rendered scorecards, revisions and rating ledgers are explicitly distinguished
from observations. Rebuild it with `python tools/playtest/storage.py index`.

| Domain | Evidence index |
| --- | --- |
| AIR | [Economy, combat, layout and regressions](index/air.md) |
| TECH | [Rush economy and strategy](index/tech.md) |
| FRONT | [Frontline evidence](index/front.md) |
| SEA | [Naval evidence](index/sea.md) |
| TACTICAL | [Tactical evidence](index/tactical.md) |
| SUPPORT | [Support evidence](index/support.md) |
| Shared | [Metal maps, cooperation, terrain, performance and scorecards](index/shared.md) |

Existing records retain their exact paths and contents. New compact run bundles
live in `records/<domain>/<area>/<scenario>/<YYYY-MM-DD>/<UTC-id>/`.
Each has a result, original report/checks, setup metadata and optional selected
screenshots. Raw logs, replays, staged binaries and engine caches stay in the
ignored game directories. The raw log and staged build hashes, plus the archive
location, remain in the published metadata; replays are retained in the original
engine write directory. Do not delete those directories without verified backups.

## Choose the right comparison

- [TECH rush history](tech-rush.md) retains milestone timings and the existing
  best-so-far table. New records refuse conflicting run IDs.
- [Match scorecards](scorecards/README.md) and their
  [comparison contract](scorecard-design.md) provide strict map/settings cohorts
  and the private rating ledger. Use `scorecard.py compare` for strength claims.
- [Lane worker evidence](lane-workers/README.md) records calculation cost.
- Supplied combat fixtures measure targeting, routing, damage and response.
  Their production times are not natural economy milestones.
- Ordinary economy games compare fixed game-minute windows under matching
  map/version, game/engine, starts, faction, profile, handicap and resource rules.
  Repeat seeds and swap sides while retaining a fixed opponent for strength tests.

Keep failures, missing milestones and censored games visible. A time-limit
cutoff is not a draw. A category or shared filename does not make two runs
comparable. Historical bundles without full conditions remain evidence, not
retroactively certified leaderboard entries.

See [storage conventions, commands and migration verification](../test-storage.md).
