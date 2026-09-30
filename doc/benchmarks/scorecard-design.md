# Map/settings scorecards

## What the score means

This is a private experimental ladder, not an estimate of a public BAR account's
rating. OpenSkill receives confirmed match results and participant ratings;
economy, damage and unit production are diagnostic evidence, never skill points.
BAR describes skill as mu, uncertainty as sigma, match rating as mu minus sigma,
and conservative leaderboard rating as mu minus three sigma. It also separates
match formats and explains why in-game score does not determine skill.
[BAR rating guide](https://www.beyondallreason.info/guide/rating-and-lobby-balance).

The implementation uses the pinned `openskill==6.1.2` Plackett–Luce model:
mu=25, sigma=25/3, beta=25/6, tau=25/300, kappa=0.0001. It records pre-match win
probabilities, before/after mu and sigma, mu−sigma, mu−3sigma, rated game count
and an approximate mu±1.96sigma interval. Rank inputs are explicitly one-based;
ties use equal rank 1. No probability is described as calibrated after one game.
Fewer than ten rated games is labeled provisional as a local reporting policy,
not an OpenSkill confidence guarantee.
[Pinned library API](https://openskill.me/en/v6.1.2/api/openskill.models.weng_lin.plackett_luce.html).

Only the engine's `GameOver` winner list creates a rating event. An empty list
from that callback is a confirmed draw. A time limit, a manual stop, an early
engine exit or an absent callback is **censored**, never an assumed draw or win.
Crashes, script errors, missing telemetry, mismatched actual roles/factions or
unverified content invalidate the measurement for ratings. Ordinary invariant
violations remain visible; a gameplay bug that loses a valid match must not be
hidden by selectively excluding that loss. Identical entrant self-play is not
rated twice as if two copies were independent players.

## Comparison contract

An exact comparison cohort contains:

| Dimension | Recorded and matched |
| --- | --- |
| Map | Archive/internal name and engine-reported map checksum |
| Game | Archive/version and engine-reported game checksum |
| Engine | Version directory and executed headless/display executable SHA-256 |
| Gameplay | Every actual staged modoption, including Legion availability, extra units, damage/economy multipliers, unit restrictions, starting resources and calendar inputs |
| Participants | Team/ally topology, faction, role, requested start coordinates, AI options/profile and handicap |
| Test conditions | Supplied-economy fixtures, role overrides, simulation ceiling, headless/speed settings and hashes of staged observer/fixture widgets |

Legion disabled is a different cohort even if no Legion player appeared in the
enabled game. Different maps, game releases, rosters, starts or gameplay options
are excluded from strong comparisons rather than receiving a hidden similarity
weight. Requested and observed starts are both retained. Each observed start
must be within 64 elmos of its request; comparing two cards additionally rejects
an observed start difference over 32 elmos. This permits small engine placement
rounding but flags meaningful displacement. These are explicit local tolerances.

Wall-clock date/time identifies an observation; it is not a gameplay condition.
The in-game `date_*` modoptions can affect seasonal content, so they **are** part
of the conditions. The benchmark runner pins its default in-game calendar to
2026-09-29 at 17:00; `--calendar YYYY-MM-DDTHH` changes it explicitly. Actual run
timestamps remain UTC and local ISO-8601 values with offsets. BAR's calendar
handling was checked in `common/holidays.lua` and
`common/springUtilities/teamFunctions.lua` in the local game source.

DLL and script/config hashes identify the tested AI, not the cohort: excluding
them from the conditions allows testing a new build under matching settings.
An entrant is the build/data/options/faction/role combination. Ratings are scoped
to that entrant **within** a cohort. Changing both opposing builds at once is a
whole-system comparison, not a controlled claim that one build is stronger.
For strength experiments, keep a frozen opponent, repeat seeds and swap sides;
the initial three-map run is only a dated baseline, not that completed study.

## Diagnostic scorecard

No arbitrary 0–100 weighted total is used. A high economy can coexist with no
combat; adding those together would hide exactly the failure under investigation.

| Measure | Definition / interpretation |
| --- | --- |
| Result, duration, survival | Confirmed engine outcome when present; otherwise censored observation and per-team death state |
| Economy | Raw engine cumulative metal/energy produced, spent, excess, received/sent; live income/storage; snapshots at 5/10/15/20/30/40 game minutes |
| Waste | Metal excess divided by cumulative produced plus received; exact denominator stated, undefined denominator remains null |
| Combat production | Completed mobile armed non-builder units and nominal metal value; first combat, T2 and T3 completion; completed combat metal per game minute |
| Factory activity | Idle completed factories / all completed factories summed over half-minute samples; sampled activity, not continuous utilization |
| High-income starvation | Number of half-minute observations at +200 metal with no combat ever completed; this is not the AI's ten-second minimum gate and not inferred continuous stall duration |
| Combat exchange | Engine damage dealt/received and hostile-attributed mobile combat metal killed/lost; zero denominator is null, never infinity or a perfect score |
| Specialist stream | Completed Recluse/Termite/Arquebus counts; native dedicated-flank orders and unique routed IDs; first route assignment time |
| Reliability | Actual role/faction/start verification, script/native/observer errors, per-invariant counts, checksum and sample coverage |

The observer records actual completions, not factory orders. Specialist completion
counts include those three UnitDefs from any factory; dedicated-flank assignment
is a separate native trace metric. Routed ID counts are a lower bound when the
engine reuses IDs. A route assignment does not prove traversal; this scorecard
does not claim a mountain crossing from an order. Combat exchange excludes
friendly-attributed destruction and reclaim; it is nominal UnitDef value, not
reclaimed material or assisted damage credit. No damage callback interception
is used. Engine statistic fields were verified in Recoil's `LuaSyncedRead.cpp`.

Compare fixed-minute snapshots for economy/army changes. Final cumulative totals
from different match lengths must not be treated as equal-duration performance.
Missing milestones remain null. Script/AI exceptions are visible rather than
being converted to a zero-valued skill result.

## Storage and use

The [scorecard index](scorecards/README.md) links timestamped human-readable cards
and neighboring JSON records under `scorecards/YYYY-MM-DD/`. `ratings.json` is a
derived ledger, rebuilt chronologically. Scorecard IDs contain UTC microseconds
and a random suffix; recording identical evidence twice is idempotent. Changed
evidence for an existing ID is refused. New schema interpretations preserve the
old card under `scorecards/revisions/<id>/schema-N.json`; revisions are never
counted as additional matches. Raw reports keep their original FAIL verdicts.

The archived run contains `infolog.txt`, the exact start script, team roster,
launch information and scorecard manifest. The manifest hashes all staged policy
files, the DLL and observers; source-tree state is not substituted for the files
actually loaded. Maps/game content are measured by the engine's runtime checksums.

Install the pinned dependency with your Python runtime:

```powershell
python -m pip install -r tools/playtest/requirements-scorecard.txt
python tools/playtest/scorecard_run.py glacial --dir C:/bardev/s3k-CircuitAI/build-theatres/scorecards/glacial-next --dll C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable/SkirmishAI.dll --game "Beyond All Reason test-31450-6562fb1"
python tools/playtest/scorecard.py rebuild
python tools/playtest/scorecard.py compare <older-card.json> <newer-card.json>
```

Map aliases are `supreme`, `glacial`, and `ascendancy`; `--swap` exchanges the
factions. `--legion off` explicitly uses Cortex/Armada instead of Cortex/Legion
and records the disabled setting. The runner restricts writes to this repository's
`build-theatres/` subtree and never deploys into the main game installation.
Ascendancy's harness starts alone do not assign runtime TECH roles (KI-428);
the runner records its staged fallback-role override and verifies actual roles.
Only runs through this scorecard runner are automatically scored; historical
logs without the required settings/observer evidence are not silently imported.
