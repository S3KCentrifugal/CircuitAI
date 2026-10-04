# TECH flank production: played verification

[D-136](../decisions.md#d-136--a-separate-factory-continuously-exploits-an-accessible-mountain-flank)
adds an extra factory at +200 metal for an accessible all-terrain lane. The
ordinary lab and spam retain their existing production policies. Connectivity
and route commands are native; selection and production are AngelScript.

## Played results

All runs use Glacial Gap v1.1 and Beyond All Reason test-31443-11f7f95. Results
are under `build-theatres/flank/`; original reports are retained unchanged.

| Run | Conditions | Evidence |
| --- | --- | --- |
| glacial-natural/runs/20260929-101844 | Cortex west, Armada east; experimental_balanced; 45 minutes; no supplied economy or units | Orders at +203/+202 metal, completed labs 25786/11440, continuous production, both streams reached the northern mountain, both sustained production beyond five minutes |
| glacial-final/runs/20260929-101653 | Legion west, Armada east; experimental_hard; 30 minutes; economy-only fixture; normal combat damage | Labs 21741/3554 built by AI constructors, both produced continuously, both reached the mountain, all ten functional expectations observed |
| glacial3/runs/20260929-100723 | Earlier policy; economy-only fixture; weapon damage disabled | Complete northern traversal both directions, west by 24.75 minutes and east by 29.17; southern-bank connectivity rejected from both sides |
| baseline/runs/20260929-100850 | Previous D-135 DLL and scripts, same map and economy fixture | Existing invariant failures reproduced without flank production: INV-001/008/010/011/014/017/019/022/029/031/035 |

The economy fixture gives only energy/conversion structures. It never supplies
a factory, constructor or combat unit. The natural run establishes the income
gate without this fixture. All runs temporarily extend the existing forward
cluster patience setting to avoid KI-423 interfering with the test.

Full traversal with damage disabled separates path feasibility from normal
combat losses. Under normal damage the opposing streams meet on the mountain;
reaching the enemy base is not required when defenders kill an attacker.

The initial watcher counted ordinary production from game start. A final
`coexistence/runs/20260929-102238` regression tightens that check to count only
after a flank factory is observed routing units. All ten functional checks
passed: both factories built, continuous and sustained production, actual
mountain travel, and subsequent ordinary fast-bot/spam completions. The latter
passed at 18.0 minutes east (70 fast bots, one spam unit) and 23.2 minutes west
(63 fast bots, one spam unit). Overall FAIL remains due to broader invariants.

## Review rounds

1. Construction and ownership: prove actual builder-created labs and exact
   producer IDs, rather than nearby units. Gate income is measured when the
   order is placed; income can dip while the constructor walks to the site.
2. Movement: observe queued mountain waypoints and actual unit positions.
   Preserve intermediate MOVE commands and use FIGHT at the destination.
   Retain ordinary spam task defaults.
3. Coexistence: exclude the extra lab from primary-lab assignment, reclaim,
   normal T2 counts and the economy turret-box proximity invariant. Otherwise
   it could suppress replacement of the ordinary factory. Check post-activation
   fast-bot and spam completions separately.

## Screenshots

The visible normal-combat run shows Legion production on the west and Armada
production on the east. At 22 minutes both streams occupy the northern shelf.
Console text is test instrumentation; screenshots are unedited game captures.

![Northern shelf, both armies](../../build-theatres/flank/glacial-final/runs/20260929-101653/screen_2026-09-29_13-15-16-612.png)

![West production and ascent](../../build-theatres/flank/glacial-final/runs/20260929-101653/screen_2026-09-29_13-13-40-513.png)

![East production](../../build-theatres/flank/glacial-final/runs/20260929-101653/screen_2026-09-29_13-14-04-750.png)

## Build and limits

The MinGW native build succeeds; repeating it reports no work to do. The
stripped DLL is 7,517,850 bytes, SHA-256
`fe1b62f48707ccfcf61b413a1e2906055230f6602edd2813b1aa666ec2bb8b57`.
The matching `SkirmishAI.dbg` is linked through `.gnu_debuglink`. All 228 data
files match the workspace in the required engine build output. The artifact
manifest is `build-theatres/flank/artifacts.json`, with input hashes alongside.

Script/DLL API parity checks 225 members with zero findings. Role documentation
and invariant-practice checks pass. Existing unit-helper findings are armsonar
and corsonar (KI-425); existing document-link failures refer to missing hover.md
(KI-404). No live game installation was modified.

Overall playtest verdicts remain FAIL because broader TECH invariants fire;
functional success is not an overall clean regression suite. The natural run
also used the original deadlines, which were too early for its natural +200
income. Their missing-expectation results are not rewritten. The zero-damage
fixture additionally invalidates normal flak-threat expectations (INV-064).
No INV-067 or script errors were observed in the final combat runs.

Save/load reconstruction remains unplayed (KI-426). Factory destruction and
replacement are implemented but not separately exercised. These tests do not
prove every map or custom replacement unit can traverse its generated route.
Air transport is deferred.
