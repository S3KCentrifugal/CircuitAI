# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 60.0 min (frame 108005); wall 1871 s
- DLL: build-theatres\d221\candidate1\SkirmishAI.dll (eca9d0229482cc8e); AI BARbTest/test; staged 2026-10-06T16:30:31
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=FRONT/cortex/test, 3=FRONT/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=TACTICAL/armada/test, 8=FRONT/cortex/test, 9=TECH/legion/test, 10=FRONT/armada/test, 11=AIR/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=TACTICAL/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: full-match-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T193031Z-f36750fa\runs\20261006T200145Z-d1685f1c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:48.571170][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `d=12.000 speed_actual=11.225 ai_n=1800 ai_mean_ms=1.120188 ai_p50_ms=0.744141 ai_p95_ms=3.000000 ai_p99_ms=6.728516 ai_max_ms=11.486328 fps_n=6 fps_p10=23.000 fps_p50=26.000 fps_p90=27.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:00:52.786982][f=0001800] [AirOrders] frame=1800 team=0 all_apm=50 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 5.8 min: [INVARIANT] INV-029 legalab 25925 stands 3 cells from the turrets, not tight
- forbid 'invariant' hit at 12.2 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1987 (7 by power), bank 2 + 35/s (0 by metal))
- forbid 'invariant' hit at 14.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 15.1 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of legalab 25925 are not on it
- forbid 'invariant' hit at 15.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 16.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 17.3 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 4687 (17 by power), bank 73 + 51/s (0 by metal))
- forbid 'invariant' hit at 22.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.2 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.6 min: [INVARIANT] INV-014 legadveconv packed at (13424, 1408) with no turret slot within 450
- forbid 'invariant' hit at 26.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.6 min: [INVARIANT] INV-039 T1 land constructors released 529 s, 0 spam labs of 2 wanted, no forward order for 180 s
- forbid 'invariant' hit at 28.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.8 min: [INVARIANT] INV-029 legalab 29558 stands 11 cells from the turrets, not tight
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-041 queued gift 12529 holds a build order (legnanotc)
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-019 5 turret frames under construction, 1 allowed (build power 22207 (83 by power), bank 82 + 347/s (0 by metal))
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-014 legadveconv packed at (13696, 1456) with no turret slot within 450
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 13 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.3 min: [INVARIANT] INV-016 the advanced lab 29558 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 30.3 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 419 elmos away, not flush (160)
- forbid 'invariant' hit at 30.3 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 0 structures in its exit lane
- forbid 'invariant' hit at 30.5 min: [INVARIANT] INV-031 the advanced lab 29558 retired while the advanced fusion was funded: bank 5473 + 445/s x 24 s (9% built, build power 12307) = 16275 against 8925 (85% of 10500)
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-031 the advanced lab 26312 retired while the advanced fusion was funded: bank 6201 + 484/s x 17 s (37% built, build power 12030) = 14445 against 8245 (85% of 9700)
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-008 2 turret(s) in range of the reclaim of legalab 29558 are not on it
- forbid 'invariant' hit at 31.0 min: [INVARIANT] INV-014 legadveconv packed at (13760, 1456) with no turret slot within 450
- forbid 'invariant' hit at 31.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 20 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.4 min: [INVARIANT] INV-014 armmmkr packed at (320, 2016) with no turret slot within 450
- forbid 'invariant' hit at 33.1 min: [INVARIANT] INV-014 legafus packed at (13088, 1392) with no turret slot within 450
- forbid 'invariant' hit at 33.2 min: [INVARIANT] INV-014 armmmkr packed at (288, 1424) with no turret slot within 450
- forbid 'invariant' hit at 33.2 min: [INVARIANT] INV-035 dedicated 17204 (legadveconv) holds legacluster
- forbid 'invariant' hit at 33.3 min: [INVARIANT] INV-052 ferry run for cargo 21880 unloading for 16 s
- forbid 'invariant' hit at 33.9 min: [INVARIANT] INV-014 armafus packed at (336, 1056) with no turret slot within 450
- forbid 'invariant' hit at 33.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 18 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.3 min: [INVARIANT] INV-019 51 turret frames under construction, 8 allowed (build power 16035 (60 by power), bank 6507 + 534/s (121 by metal))
- forbid 'invariant' hit at 34.3 min: [INVARIANT] INV-014 armmmkr packed at (256, 1776) with no turret slot within 450
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 34.8 min: [INVARIANT] INV-052 ferry run for cargo 21880 unloading for 16 s
- forbid 'invariant' hit at 34.9 min: [INVARIANT] INV-019 51 turret frames under construction, 8 allowed (build power 18330 (69 by power), bank 7070 + 496/s (81 by metal))
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-053 air constructor 9441 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 35.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 35.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 21 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 35.2 min: [INVARIANT] INV-020 no layout room for legadveconv for 122 s
- forbid 'invariant' hit at 35.3 min: [INVARIANT] INV-019 11 turret frames under construction, 8 allowed (build power 10552 (39 by power), bank 4013 + 604/s (8 by metal))
- forbid 'invariant' hit at 35.3 min: [INVARIANT] INV-014 armmmkr packed at (176, 1840) with no turret slot within 450
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 2176 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 6 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 36.2 min: [INVARIANT] INV-020 no layout room for legadveconv for 186 s
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 973 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.8 min: [INVARIANT] INV-014 legafus packed at (13088, 1488) with no turret slot within 450
- forbid 'invariant' hit at 37.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 7 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.4 min: [INVARIANT] INV-014 armafus packed at (272, 1504) with no turret slot within 450
- forbid 'invariant' hit at 37.8 min: [INVARIANT] INV-019 48 turret frames under construction, 5 allowed (build power 15592 (58 by power), bank 127 + 605/s (5 by metal))
- forbid 'invariant' hit at 38.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 38.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 19080 (72 by power), bank 52 + 531/s (0 by metal))
- forbid 'invariant' hit at 38.8 min: [INVARIANT] INV-019 13 turret frames under construction, 8 allowed (build power 9532 (35 by power), bank 214 + 654/s (8 by metal))
- forbid 'invariant' hit at 38.9 min: [INVARIANT] INV-020 no layout room for legafus for 124 s
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 3147 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 28294 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 30220 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 3483 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 22888 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 31877 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 28047 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 8939 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 15932 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 17204 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 2176 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 14068 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 28481 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 7611 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 15783 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 1662 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 180 s with 49 of its 50 turrets
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-020 no layout room for legadveconv for 184 s
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 14061 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 7747 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 16933 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 3942 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 11109 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 6978 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 26523 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 13180 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 19199 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 865 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 2478 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 16311 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 21436 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 15426 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 25719 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 10415 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 24590 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 23269 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 23379 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 12040 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 29984 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 7123 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 2411 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 25294 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 973 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 28685 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 19416 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 2380 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 40.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 240 s with 49 of its 50 turrets
- forbid 'invariant' hit at 40.9 min: [INVARIANT] INV-020 no layout room for legadveconv for 246 s
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-014 armafus packed at (176, 1504) with no turret slot within 450
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 15277 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 23487 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 12092 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 41.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 9582 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 3483 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 16353 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 24445 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 25660 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 41.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 300 s with 49 of its 50 turrets
- forbid 'invariant' hit at 41.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-020 no layout room for legafus for 309 s
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-048 spam cluster 7's turret 9862 is not working for its lab 7311 (task type -1, target -1, unit task type 2, last focus on lab -1)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-048 spam cluster 7's turret 23365 is not working for its lab 7311 (task type -1, target -1, unit task type 2, last focus on lab -1)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 28047 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 42.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 42.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 15783 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 12695 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 19342 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 6978 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 23934 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 8642 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 360 s with 49 of its 50 turrets
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 2478 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 22888 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 10415 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-020 no layout room for legafus for 373 s
- forbid 'invariant' hit at 43.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 7 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 43.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 43.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 13 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 43.1 min: [INVARIANT] INV-019 39 turret frames under construction, 8 allowed (build power 12780 (48 by power), bank 258 + 538/s (38 by metal))
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 14061 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 19199 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 865 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 13425 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 16311 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 9574 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 21436 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 21538 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 23269 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 23379 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 2411 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 1662 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 420 s with 49 of its 50 turrets
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 16933 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 44.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 44.1 min: [INVARIANT] INV-020 no layout room for legafus for 437 s
- forbid 'invariant' hit at 44.1 min: [INVARIANT] INV-019 20 turret frames under construction, 8 allowed (build power 12630 (47 by power), bank 90 + 662/s (8 by metal))
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 15277 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 23487 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 12092 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 28685 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 19416 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 2380 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 480 s with 49 of its 50 turrets
- forbid 'invariant' hit at 44.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 31877 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 45.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 45.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 45.1 min: [INVARIANT] INV-020 no layout room for legadveconv for 497 s
- forbid 'invariant' hit at 45.5 min: [INVARIANT] INV-053 air constructor 20072 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 45.5 min: [INVARIANT] INV-053 air constructor 3942 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 45.5 min: [INVARIANT] INV-053 air constructor 15783 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 45.5 min: [INVARIANT] INV-053 air constructor 12695 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 45.5 min: [INVARIANT] INV-053 air constructor 15426 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 45.5 min: [INVARIANT] INV-053 air constructor 25719 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 45.5 min: [INVARIANT] INV-053 air constructor 29984 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 45.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 540 s with 49 of its 50 turrets
- forbid 'invariant' hit at 45.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 14 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 3147 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 973 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 16353 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 14068 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 28481 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 7611 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 25294 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 46.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 46.2 min: [INVARIANT] INV-020 no layout room for legafus for 565 s
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 3483 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 600 s with 49 of its 50 turrets
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 6978 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 47.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 47.3 min: [INVARIANT] INV-020 no layout room for legafus for 627 s
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 22109 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 7123 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 660 s with 49 of its 50 turrets
- forbid 'invariant' hit at 48.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 8 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 48.1 min: [INVARIANT] INV-060 coast cluster #16 has 5 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 48.3 min: [INVARIANT] INV-020 no layout room for legafus for 688 s
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 14061 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 7747 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 19199 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 865 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 16311 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 23269 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 2411 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 1662 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 720 s with 49 of its 50 turrets
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 11109 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 973 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 15277 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 15426 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 23379 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 15932 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 25294 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 2380 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-035 dedicated 16386 (armmmkr) holds armamb
- forbid 'invariant' hit at 49.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 6 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 49.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 49.3 min: [INVARIANT] INV-020 no layout room for legafus for 751 s
- forbid 'invariant' hit at 49.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 780 s with 49 of its 50 turrets
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 23487 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 12092 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 12040 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 7123 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 50.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 50.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 50.3 min: [INVARIANT] INV-020 no layout room for armmmkr for 120 s
- forbid 'invariant' hit at 50.4 min: [INVARIANT] INV-020 no layout room for legafus for 813 s
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 27125 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 28879 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 11335 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 14008 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 25020 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 28797 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 26632 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 17007 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 21365 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 28685 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 50.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 840 s with 49 of its 50 turrets
- forbid 'invariant' hit at 51.0 min: [INVARIANT] INV-053 air constructor 30220 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 51.0 min: [INVARIANT] INV-053 air constructor 23379 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 51.0 min: [INVARIANT] INV-053 air constructor 17204 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 51.0 min: [INVARIANT] INV-053 air constructor 25660 has done nothing for 60 s (task type 2, last rule legacy.strategic)
- forbid 'invariant' hit at 51.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 51.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 51.3 min: [INVARIANT] INV-020 no layout room for armmmkr for 180 s
- forbid 'invariant' hit at 51.4 min: [INVARIANT] INV-020 no layout room for legafus for 874 s
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 14033 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 20866 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 30542 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 1719 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 3942 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 13180 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 19416 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 51.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 900 s with 49 of its 50 turrets
- forbid 'invariant' hit at 51.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (18 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 51.9 min: [INVARIANT] INV-038 front cluster 19 (legvp) has stood 706 s with 0 of its 2 turrets
- forbid 'invariant' hit at 51.9 min: [INVARIANT] INV-043 15 spam unit(s) left their lane (leggob 26392 now on task type 2)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 283 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 21991 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 3147 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 9582 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 3483 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 31877 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 16353 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 24445 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 2176 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 14068 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 28481 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 7611 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 52.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 52.4 min: [INVARIANT] INV-020 no layout room for legafus for 937 s
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 7747 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 19199 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 865 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 16311 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 21436 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 23269 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 2411 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 1662 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-035 dedicated 8249 (armafus) holds armflak
- forbid 'invariant' hit at 52.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 960 s with 49 of its 50 turrets
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 26831 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 26523 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 28294 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 2478 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 22888 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 10415 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 24590 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 28047 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 8939 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 5 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 53.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 15783 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 23487 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 12092 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 23379 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-020 no layout room for legafus for 1004 s
- forbid 'invariant' hit at 53.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 1020 s with 49 of its 50 turrets
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 14061 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 16933 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 3942 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 19342 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 6978 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 23934 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 8642 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 13425 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 9574 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 22109 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 21538 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 15426 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 25719 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 29984 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 5 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 54.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 54.5 min: [INVARIANT] INV-020 no layout room for legadveconv for 1064 s
- forbid 'invariant' hit at 54.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 1080 s with 49 of its 50 turrets
- forbid 'invariant' hit at 54.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (18 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 28294 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 8939 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 55.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 21044 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 3147 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 3483 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 31877 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 7123 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 14068 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 28481 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 7611 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 1140 s with 49 of its 50 turrets
- forbid 'invariant' hit at 55.7 min: [INVARIANT] INV-020 no layout room for legafus for 1132 s
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 11109 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 973 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 15277 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 16353 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 12092 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 12040 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 2176 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-020 no layout room for armmmkr for 121 s
- forbid 'invariant' hit at 56.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 6 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 56.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 56.5 min: [INVARIANT] INV-053 air constructor 9582 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.5 min: [INVARIANT] INV-053 air constructor 24445 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 1200 s with 49 of its 50 turrets
- forbid 'invariant' hit at 56.7 min: [INVARIANT] INV-020 no layout room for legafus for 1196 s
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 26523 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 28294 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 57.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 6 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 57.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 57.1 min: [INVARIANT] INV-020 no layout room for armmmkr for 182 s
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 7747 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 1260 s with 49 of its 50 turrets
- forbid 'invariant' hit at 57.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (18 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 57.8 min: [INVARIANT] INV-020 no layout room for legafus for 1258 s
- forbid 'invariant' hit at 57.9 min: [INVARIANT] INV-038 front cluster 19 (legvp) has stood 1066 s with 0 of its 2 turrets
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 11992 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 526 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 19199 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 22109 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 15932 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 58.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 7 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 58.1 min: [INVARIANT] INV-060 coast cluster #16 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 58.1 min: [INVARIANT] INV-020 no layout room for armmmkr for 242 s
- forbid 'invariant' hit at 58.5 min: [INVARIANT] INV-046 front cluster 12 (armshltx) planned 600 s ago has no factory; 0 of its 18 turrets stand
- forbid 'invariant' hit at 58.5 min: [INVARIANT] INV-053 air constructor 13926 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.5 min: [INVARIANT] INV-053 air constructor 4578 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.5 min: [INVARIANT] INV-053 air constructor 21044 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 58.5 min: [INVARIANT] INV-053 air constructor 7611 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 58.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 1320 s with 49 of its 50 turrets
- forbid 'invariant' hit at 58.8 min: [INVARIANT] INV-020 no layout room for legafus for 1320 s
- forbid 'invariant' hit at 59.0 min: [INVARIANT] INV-053 air constructor 31246 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 59.1 min: [INVARIANT] INV-060 kill zone cluster #2 has 5 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 59.1 min: [INVARIANT] INV-020 no layout room for armmmkr for 302 s
- forbid 'invariant' hit at 59.4 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 59.5 min: [INVARIANT] INV-053 air constructor 15997 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 59.5 min: [INVARIANT] INV-053 air constructor 2176 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 59.6 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 1380 s with 49 of its 50 turrets
- forbid 'invariant' hit at 59.8 min: [INVARIANT] INV-020 no layout room for legadveconv for 1381 s
- forbid 'invariant' hit at 60.0 min: [INVARIANT] INV-053 air constructor 4398 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 60.0 min: [INVARIANT] INV-053 air constructor 25195 has done nothing for 60 s (task type 2, last rule wait)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T193031Z-f36750fa\runs\20261006T200145Z-d1685f1c\screen_2026-10-06_19-32-45-079.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T193031Z-f36750fa\runs\20261006T200145Z-d1685f1c\screen_2026-10-06_19-33-37-469.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T193031Z-f36750fa\runs\20261006T200145Z-d1685f1c\screen_2026-10-06_19-34-36-003.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T193031Z-f36750fa\runs\20261006T200145Z-d1685f1c\screen_2026-10-06_19-36-22-274.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T193031Z-f36750fa\runs\20261006T200145Z-d1685f1c\screen_2026-10-06_19-39-49-142.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T193031Z-f36750fa\runs\20261006T200145Z-d1685f1c\screen_2026-10-06_19-47-29-457.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T193031Z-f36750fa\runs\20261006T200145Z-d1685f1c\screen_2026-10-06_19-53-56-454.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T193031Z-f36750fa\runs\20261006T200145Z-d1685f1c\screen_2026-10-06_20-01-44-239.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 12, 11 shots, end at 60.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (430, 2300) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1800, 1400) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (1800, 2550) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (880, 6850) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (12640, 2500) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (13890, 2246) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (13454, 6850) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.00  [Playtest] speed 12 at 0.00 min
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (430, 2300) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1800, 1400) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (1800, 2550) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (880, 6850) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (12640, 2500) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (13890, 2246) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (13454, 6850) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=989 E=0 bank=866 pull=83 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=27/274
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (450, 2298), 20 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|430|2297|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(490,1137) factory=armlab landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=FRONT side=cortex start=(1799,1401) factory=corvp landLocked=no spot=1 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=FRONT side=legion start=(1800,2550) factory=legvp landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(1430,3997) factory=armsy landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(699,4601) factory=corsy landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(1900,5800) factory=legsy landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=TACTICAL side=armada start=(880,6847) factory=armhp landLocked=no spot=7 known=7/7
  0.15  [Team][Roster] team 1 first mex at 496,1296
  0.15  [Team][Roster] team 4 first mex at 1424,4096
  0.15  [Team][Roster] team 7 first mex at 880,6720
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 21317 at 448,2416
  0.17  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|430|2297|0|2|1|448|2416
  0.17  [Team][Roster] team 2 first mex at 1952,1407
  0.17  [Team][Roster] team 3 first mex at 1952,2576
  0.17  [AIR][Rule] opening.mex builder=2244
  0.17  [Team][Roster] team 5 first mex at 704,4447
  0.17  [Team][Roster] team 6 first mex at 1904,5968
  0.27  [AIR][Capacity] own=2/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=953 E=18 bank=483 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=9/99
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.43  [AIR][Capacity] own=4/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=4 bank=954 E=30 bank=202 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=5/52
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.44  [Playtest] finished armmex team 0 at 0.44 min
  0.46  [AIR][Rule] recovery.energy builder=2244
  0.60  [AIR][Capacity] own=6/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=6 bank=899 E=30 bank=374 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=14/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.61  [Playtest] finished armsolar team 0 at 0.61 min
  0.77  [AIR][Capacity] own=8/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=8 bank=824 E=30 bank=862 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=14/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [Playtest] finished armsolar team 0 at 0.78 min
  0.79  [AIR][Wind] cluster=0 slots=6 at=672,2712 local=false builder=2244
  0.79  [AIR][Rule] opening.energy builder=2244
  0.93  [AIR][Capacity] own=8/50 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=8 bank=872 E=50 bank=1100 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 900/1150, energy +70.0 bank 1094/1100, units 7
  1.06  [Playtest] finished armwin team 0 at 1.06 min
  1.10  [AIR][Capacity] own=8/70 usage=3/23 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=912 E=70 bank=1099 pull=23 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=29/129
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.17  [Playtest] finished armwin team 0 at 1.16 min
  1.27  [AIR][Capacity] own=8/88 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=928 E=83 bank=1089 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=2/13
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [Playtest] finished armwin team 0 at 1.27 min
  1.28  [AIR][Starter] nearby distance=127
  1.28  [AIR][Rule] opening.plant builder=2244
  1.30  [AIR][EcoLayout] reserved air.eco.0 reactor=816,2432 converters=8 support=12 zone=28
  1.32  [AIR][EcoLayout] reserved air.eco.1 reactor=1200,2816 converters=8 support=12 zone=51
  1.33  [AIR][EcoLayout] reserved air.eco.2 reactor=1200,1280 converters=8 support=12 zone=73
  1.35  [AIR][EcoLayout] reserved air.eco.3 reactor=1200,768 converters=8 support=12 zone=95
  1.43  [AIR][Capacity] own=8/107 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=749 E=107 bank=1087 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=363/615
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=27332 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Capacity] own=8/125 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=471 E=125 bank=1099 pull=69 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=5/10
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=27332 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [Playtest] finished armap team 0 at 1.60 min
  1.61  [AIR][Produce] opening.scout armpeep plant=27332 projected=1/1
  1.61  [AIR][Rule] opening.commander.guard builder=2244
  1.62  [AIR][Claim] cancel unowned native order armnanotc
  1.62  [AIR][Claim] cancel unowned native order armnanotc
  1.62  [AIR][State] T1_CONTEST
  1.75  [AIR][Produce] constructor.recovery armca plant=27332 projected=1/3
  1.75  [AIR][Scout] opening drone=250 enemy starts=8
  1.77  [AIR][Capacity] own=8/126 usage=0/25 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=8 bank=459 E=126 bank=596 pull=25 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Capacity] own=8/116 usage=2/51 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=457 E=119 bank=55 pull=197 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.99  [AIR][Produce] constructor.recovery armca plant=27332 projected=2/3
  1.99  [AIR][Rule] recovery.energy builder=18083
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 472/1250, energy +115.6 bank 157/1226, units 13
  2.10  [AIR][Capacity] own=6/113 usage=3/17 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=28 reason=funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=473 E=115 bank=81 pull=153 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=148/0
  2.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=128 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=8/104 usage=2/9 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=83 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=463 E=105 bank=4 pull=143 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=118/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=183 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.31  [AIR][Produce] constructor.recovery armca plant=27332 projected=3/3
  2.31  [AIR][Rule] recovery.energy builder=27004
  2.43  [AIR][Capacity] own=6/103 usage=5/3 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=0 reason=available or arriving power
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=453 E=104 bank=17 pull=176 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=236/0
  2.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=5/100 usage=6/6 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=100 shortage=0 reason=available or arriving power
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=405 E=100 bank=7 pull=172 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=176/0
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.66  [AIR][Produce] opening.screen armfig plant=27332 projected=1/6
  2.66  [AIR][Rule] recovery.assist builder=26391
  2.69  [AIR][Rule] commander.factory.guard builder=2244
  2.77  [AIR][Capacity] own=5/107 usage=11/128 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=374 E=103 bank=1 pull=303 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=112/0
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.83  [Playtest] finished armsolar team 0 at 2.84 min
  2.85  [AIR][Rule] recovery.assist builder=18083
  2.93  [AIR][Capacity] own=6/133 usage=13/192 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=339 E=131 bank=39 pull=344 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=43/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.98  [AIR][Produce] opening.screen armfig plant=27332 projected=2/6
  2.98  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  2.98  [AIR][Commander] cleared factory guard for commander.idle.energy
  2.98  [AIR][Rule] commander.idle.energy builder=2244
  3.00  [AIR][Rule] commander.factory.guard builder=2244
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 315/1250, energy +161.5 bank 335/1326, units 17
  3.01  [Playtest] finished armsolar team 0 at 3.01 min
  3.03  [AIR][Rule] mex.expand builder=27004
  3.03  [AIR][Rule] mex.expand builder=18083
  3.04  [AIR][Rule] mex.expand builder=26391
  3.10  [AIR][Capacity] own=6/159 usage=6/279 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=308 E=157 bank=27 pull=352 plants=1/0 aircraftDemand=3/127
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.15  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.17  [AIR][Produce] opening.screen armfig plant=27332 projected=3/6
  3.22  [AIR][BaseResponse] contact=true
  3.22  [AIR][BaseResponse] group=0 target=3097
  3.22  [AIR][BaseResponse] group=2 target=3097
  3.22  [AIR][BaseResponse] group=3 target=3097
  3.22  [AIR][BaseResponse] dispatched=2 total=2
  3.25  [AIR][BaseResponse] contact=false
  3.25  [AIR][BaseResponse] group=0 target=-1
  3.25  [AIR][BaseResponse] group=2 target=-1
  3.25  [AIR][BaseResponse] group=3 target=-1
  3.27  [AIR][Capacity] own=8/181 usage=9/381 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=324 E=181 bank=672 pull=381 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.34  [AIR][Produce] opening.screen armfig plant=27332 projected=4/6
  3.34  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.40  [AIR][BaseResponse] contact=true
  3.40  [AIR][BaseResponse] group=0 target=12105
  3.40  [AIR][BaseResponse] group=2 target=12105
  3.40  [AIR][BaseResponse] group=3 target=12105
  3.40  [AIR][BaseResponse] dispatched=1 total=3
  3.43  [AIR][Capacity] own=8/174 usage=7/290 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=333 E=176 bank=648 pull=290 plants=1/0 aircraftDemand=3/121
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.47  [AIR][Layout] cluster=0 labs=1 at=1654,2177
  3.47  [AIR][BaseResponse] contact=false
  3.47  [AIR][BaseResponse] group=0 target=-1
  3.47  [AIR][BaseResponse] group=2 target=-1
  3.47  [AIR][BaseResponse] group=3 target=-1
  3.48  [AIR][Layout] cluster=1 labs=1 at=2134,2177
  3.52  [AIR][Produce] opening.screen armfig plant=27332 projected=5/6
  3.52  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=7/170 usage=9/381 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=346 E=170 bank=344 pull=381 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=0/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.65  [AIR][BaseResponse] contact=true
  3.65  [AIR][BaseResponse] group=0 target=31620
  3.65  [AIR][BaseResponse] group=2 target=31620
  3.65  [AIR][BaseResponse] group=3 target=31620
  3.65  [AIR][BaseResponse] dispatched=1 total=4
  3.67  [AIR][BaseResponse] contact=false
  3.67  [AIR][BaseResponse] group=0 target=-1
  3.67  [AIR][BaseResponse] group=2 target=-1
  3.67  [AIR][BaseResponse] group=3 target=-1
  3.72  [AIR][Produce] opening.screen armfig plant=27332 projected=6/6
  3.72  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=8/168 usage=6/265 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=368 E=168 bank=480 pull=265 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=0/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.83  [AIR][Layout] cluster=2 labs=1 at=118,2177
  3.88  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=6/168 usage=3/158 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=378 E=168 bank=260 pull=158 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.97  [AIR][Rule] commander.idle.energy builder=2244
  3.98  [AIR][Produce] intercept armfig plant=27332 projected=7/10
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 417/1250, energy +175.8 bank 1011/1376, units 22
  4.00  [Playtest] speed 1 at 4.00 min
  4.00  [AIR][Rule] commander.factory.guard builder=2244
  4.05  [AIR][Screen] fighters=6 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.10  [AIR][Capacity] own=8/173 usage=9/381 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=420 E=171 bank=472 pull=381 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.20  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.20  [AIR][Rule] commander.idle.energy builder=2244
  4.22  [AIR][Screen] fighters=7 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.27  [AIR][Capacity] own=8/165 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=466 E=166 bank=1297 pull=9 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.35  [AIR][Layout] cluster=3 labs=1 at=2038,3041
  4.37  [AIR][Layout] cluster=4 labs=1 at=2134,1313
  4.37  [AIR][Rule] commander.energy.local builder=2244
  4.38  [AIR][Layout] cluster=5 labs=1 at=2134,1505
  4.38  [AIR][Screen] fighters=7 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.40  [AIR][Layout] cluster=6 labs=1 at=1078,2561
  4.42  [AIR][Produce] recon.replace armpeep plant=27332 projected=1/1
  4.42  [AIR][Layout] repaired support air.bay.0 viable=2/5 slot=416 at=520,2632
  4.42  [AIR][Rule] opening.support builder=18083
  4.43  [AIR][Capacity] own=8/165 usage=7/44 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=50 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=8 bank=528 E=165 bank=1372 pull=44 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=0 committed=243/3261
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+0/2 available=yes firstSlot=2
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.46  [Playtest] finished armwin team 0 at 4.46 min
  4.48  [AIR][Rule] commander.factory.guard builder=2244
  4.53  [AIR][Rule] opening.support.assist builder=26391
  4.53  [AIR][Rule] opening.support.assist builder=27004
  4.55  [AIR][Screen] fighters=7 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.57  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.57  [AIR][Rule] commander.idle.assist builder=2244
  4.58  [AIR][Produce] air.control armfig plant=27332 projected=8/8
  4.58  [AIR][Scout] opening drone=11276 enemy starts=8
  4.60  [AIR][Capacity] own=8/167 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=253 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=8 bank=519 E=167 bank=1363 pull=93 plants=1/0 aircraftDemand=3/127
  4.60  [AIR][Projects] energyQueued=0 committed=204/2842
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.72  [AIR][Screen] fighters=7 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.77  [AIR][Capacity] own=8/143 usage=6/141 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=320 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=8 bank=382 E=147 bank=52 pull=334 plants=1/0 aircraftDemand=3/127
  4.77  [AIR][Projects] energyQueued=0 committed=14/204
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=27332 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.79  [Playtest] finished armnanotc team 0 at 4.78 min
  4.80  [AIR][Rule] commander.factory.guard builder=2244
  4.80  [AIR][Rule] mex.expand builder=27004
  4.80  [AIR][Rule] mex.expand builder=18083
  4.81  [AIR][Rule] mex.expand builder=26391
  4.88  [AIR][Screen] fighters=7 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.93  [AIR][Capacity] own=8/142 usage=6/249 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=399 E=143 bank=42 pull=257 plants=1/0 aircraftDemand=9/290
  4.93  [AIR][Projects] energyQueued=0 committed=0/0
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=27332 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 7053 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (427, 1512) facing 1, 58x77 cells: 3799 of 4466 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (923, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (875, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (827, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (779, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1000, 1272) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (1403, 1832) facing 1, 45x41 cells: 1841 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1755, 1832) facing 1: 11 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1707, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1659, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1611, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (1792, 1088) facing 1 (id 114)
  0.08  RESERVE: zone 9 at (1720, 1088) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1744, 1088) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (1768, 1184) facing 1, 21x6 cells: 122 of 126 held
  0.08  RESERVE: zone 11 at (1768, 1088) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (2016, 1088) facing 1, 20x10 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (13509, 1272) facing 2, 77x63 cells: 4538 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 776) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 824) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 872) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 920) facing 2: 12 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (13496, 1096) facing 3 (id 62)
  0.09  RESERVE: packed legalab at (13496, 1096) facing 3 in zone 7 where 8 slots of group 5 reach (id 62)
  0.09  RESERVE: leglab at (12544, 1088) facing 3 (id 63)
  0.09  RESERVE: zone 8 at (12616, 1088) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (12592, 1088) facing 3: 2 of 2 slots (group 6, zone)
  0.09  RESERVE: corridor 9 at (12568, 992) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 10 at (12568, 1184) facing 3, 21x6 cells: 122 of 126 held
  0.09  RESERVE: zone 11 at (12568, 1088) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (12320, 1088) facing 3, 20x10 cells: 180 of 200 held
  0.09  EXP: approach: corcom(22427) at (13889, 2247) walks to (13909, 2246), 139 from the cormex site (14048, 2240)
  0.12  EXP: idle: corcom(22427) on cormex at (13906, 2252), site (14048, 2240), target yes, fails 1 (arrived at the approach point)
  0.17  RESERVE: armlab at (1776, 960) facing 1 (id 117)
  0.17  RESERVE: zone 12 at (1704, 960) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 960) facing 1: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: armlab at (1776, 832) facing 1 (id 120)
  0.17  RESERVE: zone 13 at (1704, 832) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 832) facing 1: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: armlab at (1776, 704) facing 1 (id 123)
  0.17  RESERVE: zone 14 at (1704, 704) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 704) facing 1: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: armlab at (2048, 816) facing 1 (id 126)
  0.17  RESERVE: zone 15 at (1976, 816) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (2000, 816) facing 1: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: corridor 16 at (2024, 912) facing 1, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 17 at (2024, 816) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 17 at (2272, 816) facing 1, 20x10 cells: 190 of 200 held
  0.17  EXP: approach: armcom(2244) at (430, 2297) walks to (414, 2291), 136 from the armmex site (288, 2240)
  0.17  RESERVE: leglab at (12560, 832) facing 3 (id 66)
  0.17  RESERVE: zone 12 at (12632, 832) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (12608, 832) facing 3: 2 of 2 slots (group 7, zone)
  0.17  RESERVE: corridor 13 at (12584, 736) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (12584, 832) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (12336, 832) facing 3, 20x10 cells: 190 of 200 held
  0.21  EXP: approach: corcom(22427) at (13906, 2252) walks to (13903, 2278), 139 from the cormex site (13888, 2416)
  0.25  RESERVE: armalab at (2072, 1608) facing 1 (id 129)
  0.25  RESERVE: zone 18 at (1952, 1608) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (2000, 1608) facing 1: 4 of 4 slots (group 12, zone)
  0.25  RESERVE: zone 19 at (2024, 1608) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 20 at (2320, 1608) facing 1, 20x13 cells: 260 of 260 held
  0.26  RESERVE: legalab at (12520, 1784) facing 3 (id 69)
  0.26  RESERVE: zone 15 at (12640, 1784) facing 3, 6x7 cells: 42 of 42 held
  0.26  RESERVE: grid of legnanotc 2x2 gap 0 behind (12592, 1784) facing 3: 4 of 4 slots (group 8, zone)
  0.26  RESERVE: zone 16 at (12568, 1784) facing 0, 15x9 cells: 12 of 135 held
  0.26  RESERVE: corridor 17 at (12272, 1784) facing 3, 20x13 cells: 260 of 260 held
  0.28  RESERVE: zone 1 at (872, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4200) facing 1 (id 1)
  0.28  RESERVE: zone 2 at (872, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4152) facing 1 (id 2)
  0.28  RESERVE: zone 3 at (872, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4104) facing 1 (id 3)
  0.28  RESERVE: zone 4 at (872, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4056) facing 1 (id 4)
  0.28  RESERVE: zone 5 at (872, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4008) facing 1 (id 5)
  0.28  RESERVE: zone 6 at (872, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 3960) facing 1 (id 6)
  0.28  RESERVE: zone 7 at (920, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4200) facing 1 (id 7)
  0.28  RESERVE: zone 8 at (920, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4152) facing 1 (id 8)
  0.28  RESERVE: zone 9 at (920, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4104) facing 1 (id 9)
  0.28  RESERVE: zone 10 at (920, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4056) facing 1 (id 10)
  0.28  RESERVE: zone 11 at (920, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4008) facing 1 (id 11)
  0.28  RESERVE: zone 12 at (920, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 3960) facing 1 (id 12)
  0.28  RESERVE: zone 13 at (968, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4200) facing 1 (id 13)
  0.28  RESERVE: zone 14 at (968, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4152) facing 1 (id 14)
  0.28  RESERVE: zone 15 at (968, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4104) facing 1 (id 15)
  0.28  RESERVE: zone 16 at (968, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4056) facing 1 (id 16)
  0.28  RESERVE: zone 17 at (968, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4008) facing 1 (id 17)
  0.28  RESERVE: zone 18 at (968, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 3960) facing 1 (id 18)
  0.28  RESERVE: zone 19 at (1016, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4200) facing 1 (id 19)
  0.28  RESERVE: zone 20 at (1016, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4152) facing 1 (id 20)
  0.28  RESERVE: zone 21 at (1016, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4104) facing 1 (id 21)
  0.28  RESERVE: zone 22 at (1016, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4056) facing 1 (id 22)
  0.28  RESERVE: zone 23 at (1016, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4008) facing 1 (id 23)
  0.28  RESERVE: zone 24 at (1016, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 3960) facing 1 (id 24)
  0.28  RESERVE: zone 25 at (1064, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4200) facing 1 (id 25)
  0.28  RESERVE: zone 26 at (1064, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4152) facing 1 (id 26)
```
