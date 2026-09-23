# TECH rush benchmarks

Goal: the TECH role reaches every rush milestone at or under the low end of
the realistic range (the knowledge base's rush table,
`rjm.bar.docs/knowledge/70-strategy/77-eco-tech-player.md`), on Supreme
Isthmus v1.7, zero bonus, tech versus tech, the rush chain (D-070) set to
the objective. Floors are the simulator's; a run is recorded by
`tools/playtest/benchmark.py record <run dir>` from a playtest.

| Milestone | Target | Floor |
| --- | ---: | ---: |
| T1 lab | 2:30 | 1:30 |
| T2 lab | 6:30 | 5:24 |
| T2 mex | 9:00 | 7:36 |
| fusion | 11:30 | 9:54 |
| AFUS | 18:00 | 15:42 |
| nuke silo | 16:30 | 14:18 |
| gantry | 16:00 | 14:00 |
| first T3 | 26:00 | 22:54 |

Status per objective: the best run so far, updated by the tracker.

## Best so far

| Objective | Best time | Target | Met | Run |
| --- | ---: | ---: | --- | --- |
| t2 | 5:38 | 6:30 | yes | 20260922-113014 |
| fusion | 10:44 | 11:30 | yes | 20260922-001100 |
| afus | 13:56 | 18:00 | yes | 20260922-004600-speed1 |
| nuke | 12:38 | 16:30 | yes | 20260922-002559 |
| gantry | 13:19 | 16:00 | yes | 20260922-003129 |
| titan | 16:03 | 26:00 | yes | 20260922-003611 |

## Runs

| Run | Objective | Game min | T1 lab | T2 lab | T2 mex | fusion | AFUS | nuke silo | gantry | first T3 | Metal at 5/10/15 | DLL | Note |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- | --- | --- |
| 20260921-225300 | t2 | 7.6 | 2:11 | 5:48 | - | - | - | - | - | - | 11/-/- | 64970cd9b0ec7061 | run 2: first chain run |
| 20260921-225643 | fusion | 18.1 | 2:07 | 5:43 | 13:25 | 11:19 | - | - | - | - | 11/14/54 | 64970cd9b0ec7061 | loop 1 |
| 20260921-230007 | fusion | 24.2 | 2:07 | 5:37 | 7:30 | - | - | - | - | - | 11/34/82 | 64970cd9b0ec7061 | loop 1 |
| 20260921-230529 | afus | 24.0 | 2:07 | 5:35 | 7:31 | - | - | - | - | - | 11/29/80 | 64970cd9b0ec7061 | loop 2: no waiting |
| 20260921-231047 | afus | 24.2 | 1:54 | 6:22 | 8:54 | 13:01 | - | - | - | - | 18/20/77 | 64970cd9b0ec7061 | loop 3 |
| 20260921-232128 | t2 | 13.1 | 1:56 | 7:13 | 9:48 | - | - | - | - | - | 16/38/- | 64970cd9b0ec7061 | loop 5: stall guard, assist anywhere |
| 20260921-232452 | afus | 24.2 | 1:54 | 7:57 | 10:54 | 14:43 | 23:00 | - | - | - | 18/45/66 | 64970cd9b0ec7061 | loop 5 |
| 20260921-233531 | t2 | 13.2 | 1:56 | 9:11 | 12:14 | - | - | - | - | - | 15/52/- | 64970cd9b0ec7061 | loop 6: queued takeover |
| 20260921-233917 | afus | 24.2 | 1:56 | 6:19 | 9:00 | 12:17 | 22:45 | - | - | - | 8/11/74 | 64970cd9b0ec7061 | loop 6 |
| 20260921-234426 | t2 | 13.0 | 3:05 | 11:11 | - | - | - | - | - | - | 4/22/- | 64970cd9b0ec7061 | loop 7: 8 solars before alab, 2 nanos, mex radius 2500 |
| 20260921-234750 | afus | 24.1 | 3:05 | 11:35 | 12:46 | 16:03 | 20:53 | - | - | - | 3/20/36 | 64970cd9b0ec7061 | loop 7 |
| 20260921-235252 | t2 | 13.2 | 3:56 | 8:55 | 10:14 | - | - | - | - | - | 11/29/- | 4c5e7e4c4e17a04d | loop 8: home/far mex split, energy before mohos, 2 T2 cons, build18 diagnostics |
| 20260921-235615 | afus | 24.2 | 1:14 | 9:32 | 10:56 | 12:46 | 16:46 | - | - | - | 8/34/54 | 4c5e7e4c4e17a04d | loop 8 |
| 20260922-000035 | nuke | 23.2 | 2:37 | 7:38 | 12:45 | 11:59 | - | 20:35 | - | - | 15/22/123 | 4c5e7e4c4e17a04d | loop 9 (build18) |
| 20260922-000345 | gantry | 22.2 | 2:08 | 7:11 | 11:49 | 10:54 | - | - | 15:48 | 17:03 | 18/27/64 | 4c5e7e4c4e17a04d | loop 9 (build18) |
| 20260922-000821 | t2 | 13.2 | 2:08 | 7:04 | 8:38 | - | - | - | - | - | 15/63/- | 9c9c68b4554165b7 | loop 10 (build19) |
| 20260922-001100 | fusion | 18.1 | 2:08 | 7:16 | 11:07 | 10:44 | - | - | - | - | 18/27/86 | 9c9c68b4554165b7 | loop 10 (build19) |
| 20260922-001812 | nuke | 23.2 | 2:08 | 6:07 | 9:22 | 9:08 | - | 18:34 | - | - | 20/56/113 | 9c9c68b4554165b7 | loop 10b (build19, skip-ahead) |
| 20260922-001456 | afus | 24.2 | 2:08 | 6:14 | 7:19 | 12:05 | - | 16:50 | - | - | 20/70/109 | 9c9c68b4554165b7 | loop 10b (build19, skip-ahead) |
| 20260922-002242 | afus | 24.2 | 2:08 | 6:30 | 10:04 | 9:43 | 14:05 | 22:07 | - | - | 20/31/73 | 9c9c68b4554165b7 | loop 11 |
| 20260922-002559 | nuke | 23.1 | 2:08 | 6:31 | 9:32 | 9:10 | - | 12:38 | - | - | 20/41/67 | 9c9c68b4554165b7 | loop 11 |
| 20260922-003129 | gantry | 22.3 | 2:08 | 6:06 | 9:51 | 9:29 | - | - | 13:19 | - | 494/36/57 | 9c9c68b4554165b7 | loop 12 |
| 20260922-002819 | t2 | 13.2 | 2:09 | 6:14 | 8:17 | - | - | - | - | - | 20/51/- | 9c9c68b4554165b7 | loop 12 |
| 20260922-003611 | titan | 32.1 | 2:08 | 6:36 | 10:07 | 9:41 | - | 17:16 | 14:25 | 16:03 | 18/29/61 | 9c9c68b4554165b7 | loop 12 |
| 20260922-004144 | afus | 17.1 | 2:37 | 7:17 | 8:55 | 14:04 | - | - | - | - | 15/36/84 | 9c9c68b4554165b7 | graphical, speed 4, screenshots |
| 20260922-004600-speed1 | afus | 14.2 | 2:09 | 6:09 | 10:03 | 9:40 | 13:56 | - | - | - | 20/29/- | 9c9c68b4554165b7 | speed 1 verification (real speed), headless |
| 20260922-085956 | afus | 24.2 | 1:17 | 6:08 | 10:29 | 9:54 | 15:34 | - | - | - | 21/23/58 | 9c9c68b4554165b7 | loop 13 |
| 20260922-085634 | t2 | 13.2 | 1:14 | 6:52 | 7:53 | - | - | - | - | - | 22/70/- | 9c9c68b4554165b7 | loop 13 |
| 20260922-090244 | t2 | 13.2 | 1:17 | 6:43 | 7:58 | - | - | - | - | - | 18/48/- | 9c9c68b4554165b7 | loop 14: 6 energy before alab |
| 20260922-090512 | t2 | 13.2 | 1:14 | 5:59 | 7:43 | - | - | - | - | - | 11/50/- | 9c9c68b4554165b7 | loop 15: cheap in-flight continue |
| 20260922-094938 | t2 | 13.1 | 1:16 | 5:56 | 7:55 | - | - | - | - | - | 15/45/- | 3f3e881ba9e3d5e3 | loop 16: D-072 (build20) |
| 20260922-095301 | afus | 24.2 | 1:17 | 5:40 | 7:50 | 10:10 | 14:08 | 20:39 | - | - | 21/42/82 | 3f3e881ba9e3d5e3 | loop 16: D-072 (build20) |
| 20260922-095703 | afus | 24.1 | 1:13 | 5:39 | 7:58 | 11:18 | 15:29 | - | - | - | 8/33/61 | 3f3e881ba9e3d5e3 | loop 17: box grows beside |
| 20260922-111754 | afus | 24.2 | 1:14 | 7:34 | 8:19 | 10:25 | 14:00 | - | - | - | 18/56/75 | 7e2901f0e29b9421 | loop 18: D-073 lab site (build21) |
| 20260922-111428 | t2 | 13.1 | 1:15 | 7:27 | 8:48 | - | - | - | - | - | 21/71/- | 7e2901f0e29b9421 | loop 18 |
| 20260922-113014 | t2 | 13.1 | 1:17 | 5:38 | - | - | - | - | - | - | 18/37/- | e551884be9d1a298 | loop 19: D-073 lab site (build22) |
| 20260922-113354 | afus | 24.1 | 1:17 | 5:29 | 8:00 | 11:04 | - | - | - | - | 15/18/77 | e551884be9d1a298 | loop 19 |
| 20260922-114626 | t2 | 13.2 | 1:12 | 5:39 | - | - | - | - | - | - | 16/35/- | 35b2e513b2786ef3 | loop 20: D-073 (build23) |
| 20260922-114949 | afus | 24.2 | 1:15 | 5:19 | 7:46 | 10:49 | 15:35 | 21:54 | - | - | 15/34/34 | 35b2e513b2786ef3 | loop 20: D-073 (build23) |
| 20260922-122531 | afus | 24.1 | 1:11 | 9:20 | 14:55 | 18:53 | - | - | - | - | 15/15/22 | 9c202b7969b529f8 | loop 21: D-074 (build24) |
| 20260922-122211 | t2 | 13.1 | 1:13 | 9:07 | 11:19 | - | - | - | - | - | 19/18/- | 9c202b7969b529f8 | loop 21 (build24) |
| 20260922-123807 | t2 | 13.1 | 1:11 | 6:23 | 8:17 | - | - | - | - | - | 17/50/- | bcf633613e3ca0f3 | loop 22: D-074 (build25) |
| 20260922-124128 | afus | 24.1 | 1:14 | 5:31 | 7:49 | 11:19 | 14:56 | - | - | - | 15/31/61 | bcf633613e3ca0f3 | loop 22: D-074 (build25) |
| 20260922-133909 | afus | 15.6 | 1:17 | 5:46 | 8:15 | 11:25 | 15:32 | - | - | - | 13/35/66 | bcf633613e3ca0f3 | 15-minute screenshot game, build25; two turret frames abandoned and the T1 cons cycled on an unplaceable LLT 11:25-13:21 (KI-413, KI-414) |
| 20260922-140903 | afus | 24.2 | 1:11 | 6:17 | 8:37 | 12:05 | 15:31 | 20:08 | - | - | 15/29/54 | bcf633613e3ca0f3 | D-075 verify: power.turret row, chain near-frame pre-pass, stall guard counts frames |
| 20260922-142706 | afus | 20.6 | 1:28 | 5:38 | 8:01 | 11:17 | 15:37 | - | - | - | 13/29/48 | bcf633613e3ca0f3 | D-075 played: power.turret capped at 20 BP per metal; turrets 5:55/10:14/11:44 then 7 after the AFUS; metal bank 356-585 during the AFUS build; bank 8,098 at 20 min with nothing dear ordered after the objective |
| 20260922-185810 | afus | 17.2 | 1:14 | 6:13 | 8:08 | 11:29 | 14:57 | - | - | - | 15/8/57 | cb86dda8e1a5d5a9 | D-076 played: lifecycle retire, invariants tick, build26 |
| 20260922-192117 | afus | 24.1 | 1:11 | 5:46 | 7:59 | 10:38 | 14:11 | - | - | - | 15/43/71 | 6fc7e95b0d8a1726 | D-077 played: energy.reclaim, centre-out turrets, build27 |
| 20260922-193458 | afus | 24.5 | - | - | - | - | - | - | - | - | 0/0/0 | cfbbac357f63aaf4 | D-076..079 played on build28: lifecycle, invariants, energy reclaim, turret pull, no energy float |
| 20260922-193856 | afus | 24.2 | 1:13 | 6:25 | 8:01 | 11:13 | 17:23 | - | - | - | 15/31/52 | cfbbac357f63aaf4 | D-076..079 played on build28: lifecycle, invariants, energy reclaim, turret pull, no energy float |
| 20260922-195358 | afus | 24.2 | 1:11 | 6:13 | 8:13 | 11:11 | 15:07 | - | - | - | 15/38/61 | cd41084e2cf2b147 | D-076..079 played on build29: bank-based float, turret pull fixed |
| 20260922-195815 | afus | 24.1 | 1:11 | 6:06 | 7:48 | 11:52 | 16:33 | - | - | - | 7/38/82 | cd41084e2cf2b147 | D-079 played: float = bank full 15 s or full now with +300 over the pull; build29 |
| 20260922-200246 | afus | 24.1 | 1:13 | 6:16 | 7:50 | 10:25 | 16:43 | - | - | - | 15/45/78 | cd41084e2cf2b147 | D-079 played: float = full 15 s | full+300 | half+rising+300; energy.convert before the chain; build29 |
| 20260922-200658 | afus | 24.5 | - | - | - | - | - | - | - | - | 0/0/0 | cd41084e2cf2b147 | D-079 played: energy.convert.float before the chain; build29 |
| 20260922-201105 | afus | 24.2 | 1:11 | 6:06 | 7:41 | 11:16 | 17:01 | - | - | - | 13/28/59 | cd41084e2cf2b147 | D-079 played: energy.convert.float before the chain; build29 |
| 20260922-201552 | afus | 24.2 | 1:11 | 6:17 | 8:17 | 11:29 | 19:05 | - | - | - | 15/34/83 | cd41084e2cf2b147 | D-079 played: rising-bank surplus test at any level; build29 |
| 20260922-202036 | afus | 24.2 | 1:11 | 5:42 | 7:32 | 11:09 | 18:44 | - | - | - | 15/34/78 | cd41084e2cf2b147 | D-079 played: converters in parallel while floating; build29 |
| 20260922-202500 | afus | 24.1 | 1:11 | 6:06 | 7:45 | 10:22 | 16:08 | - | - | - | 14/44/57 | cd41084e2cf2b147 | D-075/D-079 played: no turret cap at a full bank; converters first; build29 |
| 20260922-211142 | afus | 24.0 | 1:14 | 7:13 | 8:52 | 11:31 | 19:53 | - | - | - | 13/38/78 | cd41084e2cf2b147 | D-080 played: endgame plan phase 1 (auto = team 0 nuke); build29 |
| 20260922-211838 | afus | 24.1 | 1:14 | 6:10 | 8:20 | 11:26 | 21:02 | 13:39 | - | - | 15/38/25 | cd41084e2cf2b147 | D-080 played: reclaimed energy steps count as met; plan nuke phase 1 |
| 20260922-212555 | afus | 24.1 | 1:13 | 6:48 | 8:23 | 11:09 | 15:58 | 19:34 | - | - | 15/45/61 | cd41084e2cf2b147 | D-080 played: retired energy steps met; parallel afus on the ladder; plan nuke |
