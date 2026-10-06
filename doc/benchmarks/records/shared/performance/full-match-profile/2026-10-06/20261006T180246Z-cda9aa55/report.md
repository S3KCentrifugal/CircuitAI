# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 60.0 min (frame 108002); wall 2070 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T14:28:12
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=FRONT/cortex/test, 3=FRONT/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=TACTICAL/armada/test, 8=FRONT/cortex/test, 9=TECH/legion/test, 10=FRONT/armada/test, 11=AIR/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=TACTICAL/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: full-match-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T172811Z-7d8d246d\runs\20261006T180246Z-cda9aa55\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:55.989701][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `d=12.000 speed_actual=11.960 ai_n=1800 ai_mean_ms=0.998879 ai_p50_ms=0.578125 ai_p95_ms=2.837891 ai_p99_ms=5.923828 ai_max_ms=10.863281 fps_n=6 fps_p10=17.000 fps_p50=25.000 fps_p90=26.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:01:00.221267][f=0001800] [AirOrders] frame=1800 team=0 all_apm=53 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 4.5 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 840 (3 by power), bank 2 + 12/s (0 by metal))
- forbid 'invariant' hit at 5.5 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 840 (3 by power), bank 10 + 12/s (0 by metal))
- forbid 'invariant' hit at 10.1 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 192 elmos away, not flush (160)
- forbid 'invariant' hit at 11.4 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1920 (7 by power), bank 0 + 39/s (0 by metal))
- forbid 'invariant' hit at 12.9 min: [INVARIANT] INV-052 ferry run for cargo 14054 unloading for 16 s
- forbid 'invariant' hit at 14.4 min: [INVARIANT] INV-052 ferry run for cargo 14054 unloading for 16 s
- forbid 'invariant' hit at 14.9 min: [INVARIANT] INV-008 4 turret(s) in range of the reclaim of armalab 27869 are not on it
- forbid 'invariant' hit at 16.4 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of legalab 30211 are not on it
- forbid 'invariant' hit at 17.3 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 18.3 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 21.5 min: [INVARIANT] INV-022 a new set of legafus starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 21.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.2 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.7 min: [INVARIANT] INV-022 a new set of legadveconv starts 7 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-053 air constructor 19220 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 27.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.4 min: [INVARIANT] INV-014 legadveconv packed at (13248, 1440) with no turret slot within 450
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.2 min: [INVARIANT] INV-029 legalab 26591 stands 12 cells from the turrets, not tight
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-016 the advanced lab 23323 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 486 elmos away, not flush (160)
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-018 the advanced lab faces 2 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-031 the advanced lab 23323 retired while the advanced fusion was funded: bank 8379 + 383/s x 9 s (43% built, build power 18900) = 12188 against 8245 (85% of 9700)
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-014 legadveconv packed at (13648, 1456) with no turret slot within 450
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 13 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-016 the advanced lab 26591 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 385 elmos away, not flush (160)
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 0 structures in its exit lane
- forbid 'invariant' hit at 30.8 min: [INVARIANT] INV-014 armmmkr packed at (288, 1408) with no turret slot within 450
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-016 the advanced lab 26591 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 385 elmos away, not flush (160)
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 0 structures in its exit lane
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-031 the advanced lab 26591 retired while the advanced fusion was funded: bank 6846 + 440/s x 7 s (59% built, build power 18532) = 9982 against 8925 (85% of 10500)
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-022 a new set of legadveconv starts 19 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.9 min: [INVARIANT] INV-014 armmmkr packed at (288, 1040) with no turret slot within 450
- forbid 'invariant' hit at 31.9 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of legalab 26591 are not on it
- forbid 'invariant' hit at 31.9 min: [INVARIANT] INV-052 ferry run for cargo 21867 unloading for 16 s
- forbid 'invariant' hit at 32.1 min: [INVARIANT] INV-014 legadveconv packed at (13408, 1440) with no turret slot within 450
- forbid 'invariant' hit at 33.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 17 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 33.3 min: [INVARIANT] INV-014 armmmkr packed at (304, 1280) with no turret slot within 450
- forbid 'invariant' hit at 33.3 min: [INVARIANT] INV-014 legafus packed at (13504, 1424) with no turret slot within 450
- forbid 'invariant' hit at 33.4 min: [INVARIANT] INV-014 legadveconv packed at (13408, 1568) with no turret slot within 450
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-053 air constructor 13425 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 34.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 16 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.7 min: [INVARIANT] INV-014 legadveconv packed at (13920, 1392) with no turret slot within 450
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-014 armmmkr packed at (192, 1888) with no turret slot within 450
- forbid 'invariant' hit at 35.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-019 50 turret frames under construction, 8 allowed (build power 24000 (90 by power), bank 8368 + 519/s (72 by metal))
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 3658 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 36.8 min: [INVARIANT] INV-014 armmmkr packed at (128, 1888) with no turret slot within 450
- forbid 'invariant' hit at 36.8 min: [INVARIANT] INV-014 armafus packed at (304, 1744) with no turret slot within 450
- forbid 'invariant' hit at 36.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-019 9 turret frames under construction, 8 allowed (build power 25500 (96 by power), bank 3536 + 553/s (30 by metal))
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 10515 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 26511 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 4081 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 18689 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 26503 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 21385 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 1618 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.4 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (11 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 18045 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 18197 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 5656 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 10105 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 13980 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 1652 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 7285 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 16552 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 27440 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 8877 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 3248 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 4710 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 18263 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 17370 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 22258 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 2071 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 30567 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 15088 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 28500 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-019 42 turret frames under construction, 8 allowed (build power 15330 (57 by power), bank 9017 + 732/s (8 by metal))
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-035 dedicated 18263 (legadveconv) holds legflak
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 18 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 27082 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 565 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 20599 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 25983 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 30285 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 30257 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 13353 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 19416 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 18854 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 6342 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 28126 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 16537 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 5572 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 22237 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 31384 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 17292 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 24242 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 20925 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 2814 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 12296 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 38.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 13063 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 13776 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 9915 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 667 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-035 dedicated 18263 (legadveconv) holds legflak
- forbid 'invariant' hit at 39.4 min: [INVARIANT] INV-020 no layout room for legadveconv for 120 s
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 1375 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 28200 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 29344 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 18689 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 2877 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 13308 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 2650 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 25228 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 27315 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 5273 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 17 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 40.4 min: [INVARIANT] INV-014 armmmkr packed at (2192, 2112) with no turret slot within 450
- forbid 'invariant' hit at 40.4 min: [INVARIANT] INV-020 no layout room for legafus for 181 s
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 18197 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 7285 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 5572 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 12218 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 1652 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 19416 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 865 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 445 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 8877 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-019 28 turret frames under construction, 8 allowed (build power 10500 (39 by power), bank 4762 + 574/s (8 by metal))
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-042 the run for cargo 21867 has lasted 600 s
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 6388 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 29362 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 31928 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 3553 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 21209 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 13063 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 30011 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 27082 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 565 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 13980 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 18045 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 5656 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 26511 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 30257 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 6651 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 283 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 18854 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 4081 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 3165 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 9798 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 13425 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 28126 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 16552 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 18689 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 2877 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 22487 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 26503 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 31384 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 10105 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 13308 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 4710 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 17370 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 20925 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 22258 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 2071 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 2650 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 25228 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 21385 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 2814 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 30567 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 1618 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 27315 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 12296 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 15088 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 28500 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-020 no layout room for legafus for 247 s
- forbid 'invariant' hit at 41.7 min: [INVARIANT] INV-019 45 turret frames under construction, 8 allowed (build power 11910 (44 by power), bank 3181 + 520/s (8 by metal))
- forbid 'invariant' hit at 41.9 min: [INVARIANT] INV-046 front cluster 3 (legalab) planned 600 s ago has no factory; 3 of its 4 turrets stand
- forbid 'invariant' hit at 41.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 22978 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 25162 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 22805 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 2427 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 28962 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 11743 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 24373 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 3658 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 10894 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 28200 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 13776 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 9915 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 13353 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 3053 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 667 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 27440 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 22237 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 18263 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-019 17 turret frames under construction, 8 allowed (build power 9450 (35 by power), bank 104 + 672/s (8 by metal))
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 8017 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 26633 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 26477 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 26916 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 16362 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 3248 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 12218 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 23672 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 42.7 min: [INVARIANT] INV-020 no layout room for legafus for 316 s
- forbid 'invariant' hit at 42.8 min: [INVARIANT] INV-045 front cluster 3 (legalab) started its factory with 3 of its 4 turrets finished (4 wanted first)
- forbid 'invariant' hit at 42.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 42.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 31452 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 10515 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 43.1 min: [INVARIANT] INV-020 no layout room for armmmkr for 121 s
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 19220 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 29408 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 28299 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 2380 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 43.7 min: [INVARIANT] INV-020 no layout room for legadveconv for 377 s
- forbid 'invariant' hit at 43.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 16400 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 8017 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 5273 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 10894 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 7600 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 6388 has done nothing for 60 s (task type 2, last rule legacy.strategic)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 7285 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 21385 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.8 min: [INVARIANT] INV-020 no layout room for legafus for 443 s
- forbid 'invariant' hit at 44.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 17 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 44.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 13201 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 25162 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 11796 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 18421 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 26633 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 28962 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 11743 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 24373 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 7878 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 27743 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 3553 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 21209 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 1375 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 26916 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 30011 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 27082 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 565 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 13980 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 18045 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 1652 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 20599 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 18197 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 25983 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 30257 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 283 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 29344 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 29910 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 18854 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 3165 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 28126 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 16552 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 2877 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 865 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 445 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 5572 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 31384 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 3248 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 10105 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 12218 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 23672 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 13308 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 4710 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 23296 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 20925 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-053 air constructor 22258 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-019 50 turret frames under construction, 8 allowed (build power 12360 (46 by power), bank 192 + 583/s (8 by metal))
- forbid 'invariant' hit at 45.2 min: [INVARIANT] INV-052 ferry run for cargo 28407 unloading for 16 s
- forbid 'invariant' hit at 45.4 min: [INVARIANT] INV-038 front cluster 6 (leggant) has stood 180 s with 49 of its 50 turrets
- forbid 'invariant' hit at 45.5 min: [INVARIANT] INV-053 air constructor 25610 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 45.9 min: [INVARIANT] INV-020 no layout room for legafus for 510 s
- forbid 'invariant' hit at 45.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 22978 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 14942 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 6023 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 22805 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 2427 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 18738 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 22986 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 22698 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 20869 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 31452 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 8599 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 833 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 9600 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 7211 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 6774 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 955 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 24377 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 29408 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 11876 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 29292 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 8498 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 30738 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 26477 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 25285 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 9173 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 6785 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 22835 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 21371 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 27923 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 31720 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 2949 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 2380 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 28796 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 25495 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 10515 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-053 air constructor 23831 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.0 min: [INVARIANT] INV-019 38 turret frames under construction, 8 allowed (build power 11910 (44 by power), bank 303 + 552/s (8 by metal))
- forbid 'invariant' hit at 46.3 min: [INVARIANT] INV-035 dedicated 18263 (legadveconv) holds legflak
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 3658 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 30943 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 13776 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 9915 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 30285 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 5656 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 26511 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 13353 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 4081 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 18689 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 27440 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 26503 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 22237 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 18263 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 25228 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 21385 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 30567 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 1618 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 27315 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 15088 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.5 min: [INVARIANT] INV-053 air constructor 28500 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 46.9 min: [INVARIANT] INV-020 no layout room for legafus for 570 s
- forbid 'invariant' hit at 46.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 27671 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 16400 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 11796 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 14431 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 18421 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 16775 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 28299 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 7600 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 18197 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 6651 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 7285 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 5572 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 31384 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 13308 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 4710 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 17370 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 22258 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 2071 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.0 min: [INVARIANT] INV-053 air constructor 2650 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 25162 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 25610 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 28962 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 11743 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 24373 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 18124 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 3053 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.5 min: [INVARIANT] INV-053 air constructor 667 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 47.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-020 no layout room for legafus for 632 s
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 14942 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 22805 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 31452 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 833 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 9600 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 7211 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 21793 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 29408 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 11876 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 6785 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 21371 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 27923 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 31720 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 2380 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 10515 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 48.0 min: [INVARIANT] INV-053 air constructor 1375 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 13776 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 13980 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 5656 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 26511 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 29344 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 4081 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 2877 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 26503 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 25228 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 21385 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 30567 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 27315 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.5 min: [INVARIANT] INV-053 air constructor 15088 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 48.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-020 no layout room for legadveconv for 692 s
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 27743 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 18045 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 18197 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 29910 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 7285 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 13425 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 28126 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 445 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 5572 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 3248 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 13308 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.0 min: [INVARIANT] INV-053 air constructor 17370 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.5 min: [INVARIANT] INV-053 air constructor 28500 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 49.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 49.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-020 no layout room for legafus for 752 s
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 8017 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 14942 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 6023 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 2427 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 11796 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 23956 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 14431 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 26633 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 25610 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 22986 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 22698 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 28962 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 31452 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 8599 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 19220 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 833 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 11743 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 24373 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 7211 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 21793 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 29408 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 11876 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 29292 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 8498 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 30738 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 26477 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 9173 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 6785 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 27923 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 2949 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 30943 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 28796 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 18124 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.0 min: [INVARIANT] INV-053 air constructor 10515 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 9600 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 6774 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 25285 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 21371 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 2380 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 23831 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.5 min: [INVARIANT] INV-053 air constructor 6651 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 50.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 51.0 min: [INVARIANT] INV-020 no layout room for legafus for 813 s
- forbid 'invariant' hit at 51.0 min: [INVARIANT] INV-053 air constructor 16400 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 51.0 min: [INVARIANT] INV-053 air constructor 16775 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 51.0 min: [INVARIANT] INV-053 air constructor 31720 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 51.0 min: [INVARIANT] INV-053 air constructor 28299 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 25495 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 51.5 min: [INVARIANT] INV-053 air constructor 9915 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 51.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 27671 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 11796 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 25610 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 24373 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 955 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 29408 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 5273 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 3658 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 10894 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 7600 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 29344 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 3165 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 16552 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 2877 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 5572 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 31384 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 23672 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 13308 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 4710 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 17370 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 22258 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 2071 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 21385 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.0 min: [INVARIANT] INV-053 air constructor 1618 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 52.1 min: [INVARIANT] INV-020 no layout room for legafus for 880 s
- forbid 'invariant' hit at 52.4 min: [INVARIANT] INV-020 no layout room for armafus for 124 s
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 22805 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 23831 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 13425 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 52.5 min: [INVARIANT] INV-053 air constructor 18263 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 52.9 min: [INVARIANT] INV-060 air defence cluster #23 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-038 front cluster 19 (armvp) has stood 553 s with 1 of its 2 turrets
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-022 a new set of legadveconv starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 20869 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 6388 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 7878 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 3553 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 26916 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 30011 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 27082 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 29910 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 23296 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.0 min: [INVARIANT] INV-053 air constructor 20925 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-020 no layout room for armafus for 188 s
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 18421 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 22835 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 21209 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 1375 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 28200 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 13776 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 9915 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 30285 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 13353 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 27440 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 53.5 min: [INVARIANT] INV-053 air constructor 22237 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 6651 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 283 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 3053 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 667 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 7285 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 16552 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 5572 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 23672 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 13308 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 4710 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-053 air constructor 22258 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 54.0 min: [INVARIANT] INV-035 dedicated 20869 (armafus) holds armflak
- forbid 'invariant' hit at 54.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 54.5 min: [INVARIANT] INV-053 air constructor 18197 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 54.5 min: [INVARIANT] INV-053 air constructor 25983 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 28299 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 7878 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 27743 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 3553 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 26916 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 30011 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 27082 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 565 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 13980 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 18045 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 5656 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 30257 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 29344 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 29910 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 18854 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 3165 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 28126 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 18689 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 445 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 26503 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 31384 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 3248 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 23296 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 17370 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 20925 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 2071 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 2650 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 25228 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 21385 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 2814 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 1618 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.0 min: [INVARIANT] INV-053 air constructor 15088 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 17831 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 27671 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 26633 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 28680 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 31720 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 23831 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 26511 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 4081 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 30567 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 27315 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 55.5 min: [INVARIANT] INV-053 air constructor 28500 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 13776 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 56.0 min: [INVARIANT] INV-053 air constructor 13425 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 56.4 min: [INVARIANT] INV-035 dedicated 30550 (armafus) holds armmercury
- forbid 'invariant' hit at 56.5 min: [INVARIANT] INV-053 air constructor 1999 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.5 min: [INVARIANT] INV-053 air constructor 28200 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.5 min: [INVARIANT] INV-053 air constructor 9915 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.5 min: [INVARIANT] INV-053 air constructor 30285 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.5 min: [INVARIANT] INV-053 air constructor 667 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.5 min: [INVARIANT] INV-053 air constructor 27440 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 56.5 min: [INVARIANT] INV-053 air constructor 22237 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 5063 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 18421 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 17364 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 21209 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 18197 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 25983 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 13353 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 283 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 29344 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 3053 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 7285 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 16552 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 5572 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 31384 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 23672 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 13308 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 4710 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.0 min: [INVARIANT] INV-053 air constructor 22258 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.1 min: [INVARIANT] INV-020 no layout room for armmmkr for 120 s
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 18856 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 7878 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 3553 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 27082 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 29910 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 28126 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 445 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 3248 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.5 min: [INVARIANT] INV-053 air constructor 23296 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 57.8 min: [INVARIANT] INV-045 front cluster 7 (armlab) started its factory with 0 of its 2 turrets finished (2 wanted first)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 6388 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 27743 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 26916 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 30011 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 565 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 13980 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 18045 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 5656 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 26511 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 30257 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 18854 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 3165 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 26503 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 20925 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 25228 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 30567 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 27315 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 15088 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.0 min: [INVARIANT] INV-053 air constructor 28500 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 58.1 min: [INVARIANT] INV-038 front cluster 8 (leglab) has stood 765 s with 1 of its 2 turrets
- forbid 'invariant' hit at 58.2 min: [INVARIANT] INV-020 no layout room for armmmkr for 181 s
- forbid 'invariant' hit at 58.5 min: [INVARIANT] INV-053 air constructor 18678 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 59.0 min: [INVARIANT] INV-035 dedicated 18678 (armmmkr) holds armflak
- forbid 'invariant' hit at 59.0 min: [INVARIANT] INV-053 air constructor 21209 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 59.0 min: [INVARIANT] INV-053 air constructor 13425 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 59.0 min: [INVARIANT] INV-053 air constructor 1618 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 59.2 min: [INVARIANT] INV-020 no layout room for legafus for 126 s
- forbid 'invariant' hit at 59.3 min: [INVARIANT] INV-020 no layout room for armmmkr for 248 s
- forbid 'invariant' hit at 59.5 min: [INVARIANT] INV-053 air constructor 29616 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 59.5 min: [INVARIANT] INV-053 air constructor 15012 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 59.5 min: [INVARIANT] INV-053 air constructor 17364 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 59.5 min: [INVARIANT] INV-053 air constructor 13776 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 59.5 min: [INVARIANT] INV-053 air constructor 18263 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 59.5 min: [INVARIANT] INV-053 air constructor 2814 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 60.0 min: [INVARIANT] INV-053 air constructor 22267 has done nothing for 60 s (task type 2, last rule wait)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T172811Z-7d8d246d\runs\20261006T180246Z-cda9aa55\screen_2026-10-06_17-30-33-799.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T172811Z-7d8d246d\runs\20261006T180246Z-cda9aa55\screen_2026-10-06_17-31-25-978.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T172811Z-7d8d246d\runs\20261006T180246Z-cda9aa55\screen_2026-10-06_17-32-23-142.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T172811Z-7d8d246d\runs\20261006T180246Z-cda9aa55\screen_2026-10-06_17-34-15-130.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T172811Z-7d8d246d\runs\20261006T180246Z-cda9aa55\screen_2026-10-06_17-37-40-980.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T172811Z-7d8d246d\runs\20261006T180246Z-cda9aa55\screen_2026-10-06_17-45-34-023.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T172811Z-7d8d246d\runs\20261006T180246Z-cda9aa55\screen_2026-10-06_17-53-06-324.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T172811Z-7d8d246d\runs\20261006T180246Z-cda9aa55\screen_2026-10-06_18-02-45-354.png

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
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=990 E=0 bank=871 pull=83 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=31/316
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
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 28241 at 448,2416
  0.17  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|430|2297|0|2|1|448|2416
  0.17  [Team][Roster] team 2 first mex at 1952,1407
  0.17  [Team][Roster] team 3 first mex at 1952,2576
  0.17  [Team][Roster] team 5 first mex at 704,4447
  0.17  [Team][Roster] team 6 first mex at 1904,5968
  0.17  [AIR][Rule] opening.mex builder=2244
  0.27  [AIR][Capacity] own=2/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=945 E=18 bank=391 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=5/58
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.42  [Playtest] finished armmex team 0 at 0.42 min
  0.43  [AIR][Rule] recovery.energy builder=2244
  0.43  [AIR][Capacity] own=4/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP RECOVERY M=4 bank=939 E=30 bank=95 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=1 committed=155/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [Playtest] finished armsolar team 0 at 0.60 min
  0.60  [AIR][Capacity] own=8/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=8 bank=877 E=30 bank=352 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.61  [AIR][Wind] cluster=0 slots=6 at=672,2712 local=false builder=2244
  0.61  [AIR][Rule] opening.energy builder=2244
  0.77  [AIR][Capacity] own=8/40 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=8 bank=946 E=48 bank=884 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=1 committed=40/175
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.87  [Playtest] finished armwin team 0 at 0.87 min
  0.93  [AIR][Capacity] own=8/50 usage=7/41 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=8 bank=984 E=50 bank=1031 pull=41 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=22/97
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.98  [Playtest] finished armwin team 0 at 0.98 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 999/1150, energy +57.5 bank 1051/1051, units 7
  1.09  [Playtest] finished armwin team 0 at 1.09 min
  1.10  [AIR][Capacity] own=8/57 usage=7/41 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=9 bank=1010 E=57 bank=1047 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.20  [Playtest] finished armwin team 0 at 1.20 min
  1.27  [AIR][Capacity] own=8/62 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1052 E=64 bank=1052 pull=9 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=36/160
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.35  [Playtest] finished armwin team 0 at 1.35 min
  1.43  [AIR][Capacity] own=8/63 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1072 E=63 bank=1000 pull=41 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=10/47
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.46  [Playtest] finished armwin team 0 at 1.46 min
  1.47  [AIR][Wind] cluster=1 slots=6 at=304,2760 local=false builder=2244
  1.60  [AIR][Capacity] own=8/74 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=1125 E=72 bank=1000 pull=41 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=22/96
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.65  [Playtest] finished armwin team 0 at 1.65 min
  1.76  [Playtest] finished armwin team 0 at 1.76 min
  1.77  [AIR][Capacity] own=8/61 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=62 bank=1000 pull=41 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.86  [Playtest] finished armwin team 0 at 1.87 min
  1.93  [AIR][Capacity] own=8/62 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=64 bank=1001 pull=41 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=18/78
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.97  [Playtest] finished armwin team 0 at 1.97 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 1143/1150, energy +137.5 bank 1051/1055, units 16
  2.08  [Playtest] finished armwin team 0 at 2.08 min
  2.09  [AIR][Starter] nearby distance=128
  2.09  [AIR][Rule] opening.plant builder=2244
  2.10  [AIR][EcoLayout] reserved air.eco.0 reactor=816,2432 converters=8 support=12 zone=34
  2.10  [AIR][Capacity] own=8/112 usage=6/38 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=97 bank=1055 pull=38 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=650/1100
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.12  [AIR][EcoLayout] reserved air.eco.1 reactor=1200,2816 converters=8 support=12 zone=56
  2.13  [AIR][EcoLayout] reserved air.eco.2 reactor=1200,1280 converters=8 support=12 zone=78
  2.15  [AIR][EcoLayout] reserved air.eco.3 reactor=1200,768 converters=8 support=12 zone=100
  2.27  [AIR][Capacity] own=8/123 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=8 bank=919 E=124 bank=1006 pull=69 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=325/551
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=729 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  2.42  [Playtest] finished armap team 0 at 2.42 min
  2.43  [AIR][Produce] opening.scout armpeep plant=729 projected=1/1
  2.43  [AIR][Rule] opening.commander.guard builder=2244
  2.43  [AIR][Claim] cancel unowned native order armnanotc
  2.43  [AIR][Claim] cancel unowned native order armnanotc
  2.43  [AIR][Capacity] own=8/81 usage=35/69 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][State] T1_CONTEST
  2.43  [AIR][Economy] T1_CONTEST M=8 bank=651 E=87 bank=1003 pull=69 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.56  [AIR][Produce] constructor.recovery armca plant=729 projected=1/3
  2.56  [AIR][Scout] opening drone=9014 enemy starts=8
  2.60  [AIR][Capacity] own=8/89 usage=0/0 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=9 bank=687 E=85 bank=463 pull=74 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.72  [AIR][BaseResponse] contact=true
  2.72  [AIR][BaseResponse] group=0 target=12105
  2.72  [AIR][BaseResponse] group=2 target=12105
  2.72  [AIR][BaseResponse] group=3 target=12105
  2.77  [AIR][Capacity] own=8/115 usage=0/13 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=690 E=114 bank=32 pull=155 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.80  [AIR][Produce] constructor.recovery armca plant=729 projected=2/3
  2.80  [AIR][BaseResponse] contact=false
  2.80  [AIR][BaseResponse] group=0 target=-1
  2.80  [AIR][BaseResponse] group=2 target=-1
  2.80  [AIR][BaseResponse] group=3 target=-1
  2.80  [AIR][Rule] recovery.energy builder=13500
  2.93  [AIR][Capacity] own=8/127 usage=4/42 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=108 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=707 E=126 bank=215 pull=166 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=142/0
  2.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=208 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 692/1250, energy +145.8 bank 221/1180, units 21
  3.05  [AIR][Produce] constructor.recovery armca plant=729 projected=3/3
  3.05  [AIR][Rule] recovery.energy builder=31958
  3.10  [AIR][Capacity] own=8/138 usage=0/0 gifts=1 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=49 shortage=166 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=693 E=133 bank=482 pull=139 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=1 committed=268/0
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=316 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Capacity] own=8/99 usage=6/19 gifts=1 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=100 shortage=76 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=652 E=104 bank=37 pull=147 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=215/0
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=226 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.30  [AIR][Produce] opening.screen armfig plant=729 projected=1/6
  3.30  [AIR][Rule] recovery.energy builder=16185
  3.31  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.31  [AIR][Rule] commander.idle.assist builder=2244
  3.34  [AIR][Rule] commander.factory.guard builder=2244
  3.43  [AIR][Layout] cluster=0 labs=1 at=1654,2177
  3.43  [AIR][Capacity] own=8/94 usage=11/116 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=41 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=650 E=96 bank=35 pull=257 plants=1/0 aircraftDemand=3/121
  3.43  [AIR][Projects] energyQueued=0 committed=303/0
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=191 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Layout] cluster=1 labs=1 at=2134,2177
  3.60  [AIR][Capacity] own=7/93 usage=11/123 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=14 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=625 E=93 bank=4 pull=319 plants=1/0 aircraftDemand=3/121
  3.60  [AIR][Projects] energyQueued=0 committed=214/0
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=164 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=71
  3.73  [Playtest] finished armsolar team 0 at 3.73 min
  3.75  [AIR][Produce] opening.screen armfig plant=729 projected=2/6
  3.75  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.75  [AIR][Rule] recovery.assist builder=13500
  3.77  [AIR][Capacity] own=7/95 usage=6/13 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=118 shortage=56 reason=funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=603 E=94 bank=185 pull=13 plants=1/0 aircraftDemand=3/124
  3.77  [AIR][Projects] energyQueued=0 committed=129/0
  3.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=206 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.92  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=7/151 usage=15/257 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=556 E=143 bank=86 pull=274 plants=1/0 aircraftDemand=3/124
  3.93  [AIR][Projects] energyQueued=0 committed=40/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [AIR][Layout] cluster=2 labs=1 at=118,2177
  3.98  [AIR][Produce] opening.screen armfig plant=729 projected=3/6
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 535/1250, energy +206.2 bank 531/1280, units 26
  4.00  [Playtest] speed 1 at 4.00 min
  4.01  [Playtest] finished armsolar team 0 at 4.01 min
  4.01  [Playtest] finished armsolar team 0 at 4.01 min
  4.02  [AIR][Rule] mex.expand builder=31958
  4.02  [AIR][Rule] mex.expand builder=13500
  4.03  [AIR][Rule] mex.expand builder=16185
  4.08  [AIR][Screen] fighters=2 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.10  [AIR][Capacity] own=7/193 usage=9/381 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=539 E=181 bank=467 pull=381 plants=1/0 aircraftDemand=3/125
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=64
  4.16  [AIR][Produce] opening.screen armfig plant=729 projected=4/6
  4.27  [AIR][Capacity] own=8/269 usage=9/381 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=551 E=258 bank=1366 pull=381 plants=1/0 aircraftDemand=3/126
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=729 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Screen] fighters=3 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.30  [AIR][Produce] opening.screen armfig plant=729 projected=5/6
  4.33  [AIR][Layout] repaired support air.bay.0 viable=1/5 slot=270 at=536,2712
  4.33  [AIR][Rule] opening.support builder=16185
  4.41  [AIR][Rule] opening.support.assist builder=31958
  4.41  [AIR][Rule] opening.support.assist builder=13500
  4.42  [AIR][Commander] cleared factory guard for opening.support.assist
  4.42  [AIR][Rule] opening.support.assist builder=2244
  4.43  [AIR][Capacity] own=8/333 usage=0/216 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=310 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=9 bank=560 E=327 bank=1326 pull=403 plants=1/0 aircraftDemand=3/126
  4.43  [AIR][Projects] energyQueued=0 committed=215/2991
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=729 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][BaseResponse] contact=true
  4.43  [AIR][BaseResponse] group=0 target=20578
  4.43  [AIR][BaseResponse] group=2 target=20578
  4.43  [AIR][BaseResponse] group=3 target=20578
  4.43  [AIR][BaseResponse] dispatched=4 total=4
  4.48  [AIR][Layout] cluster=3 labs=1 at=2038,3041
  4.48  [AIR][BaseResponse] contact=false
  4.48  [AIR][BaseResponse] group=0 target=-1
  4.48  [AIR][BaseResponse] group=2 target=-1
  4.48  [AIR][BaseResponse] group=3 target=-1
  4.51  [AIR][Produce] opening.screen armfig plant=729 projected=6/6
  4.51  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=8/330 usage=3/133 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=9 bank=441 E=332 bank=1366 pull=404 plants=1/0 aircraftDemand=3/124
  4.60  [AIR][Projects] energyQueued=0 committed=27/382
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=729 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=58
  4.62  [Playtest] finished armnanotc team 0 at 4.62 min
  4.64  [AIR][Rule] mex.expand builder=13500
  4.64  [AIR][Rule] mex.expand builder=31958
  4.64  [AIR][Rule] commander.factory.guard builder=2244
  4.65  [AIR][Rule] mex.expand builder=16185
  4.68  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.72  [AIR][Produce] intercept armfig plant=729 projected=7/10
  4.73  [AIR][Layout] repaired support air.bay.0 viable=2/5 slot=292 at=456,2744
  4.73  [AIR][Rule] opening.support builder=13500
  4.77  [AIR][Capacity] own=8/322 usage=11/448 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=9 bank=412 E=323 bank=1292 pull=448 plants=1/0 aircraftDemand=8/286
  4.77  [AIR][Projects] energyQueued=0 committed=230/3200
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=729 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.84  [AIR][Rule] opening.support.assist builder=31958
  4.84  [AIR][Commander] cleared factory guard for opening.support.assist
  4.84  [AIR][Rule] opening.support.assist builder=2244
  4.84  [AIR][Rule] opening.support.assist builder=16185
  4.86  [AIR][Produce] recon.replace armpeep plant=729 projected=1/1
  4.86  [AIR][Screen] fighters=7 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.87  [AIR][Support] return to production bay=0
  4.93  [AIR][Capacity] own=8/323 usage=6/202 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST M=9 bank=325 E=323 bank=1366 pull=474 plants=1/0 aircraftDemand=8/288
  4.93  [AIR][Projects] energyQueued=0 committed=104/1450
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=729 BP=350 nanos=1+1/2 available=yes firstSlot=3
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.00  [Playtest] eco team 0 at 5.0 min: metal +8.0 bank 239/1250, energy +332.6 bank 1207/1380, units 33
  5.00  [Playtest] camera requested (2000,3200) height=6500
  5.00  [Playtest] camera captured name=ta position=(2000,3200) height=6500
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2000, 3200)
  5.02  [AIR][Produce] air.control armfig plant=729 projected=8/8
  5.02  [AIR][Scout] opening drone=9810 enemy starts=8
  5.02  [Playtest] finished armnanotc team 0 at 5.02 min
  5.03  [AIR][Screen] fighters=7 cells=8 centre=889,1145 width=600 advance=400 responding=false
  5.04  [AIR][Rule] mex.expand builder=13500
  5.04  [AIR][Rule] mex.expand builder=31958
  5.04  [AIR][Rule] commander.factory.guard builder=2244
  5.05  [AIR][Rule] mex.expand builder=16185
  5.10  [AIR][Capacity] own=8/324 usage=17/713 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=8 bank=211 E=325 bank=1271 pull=713 plants=1/0 aircraftDemand=13/443
  5.10  [AIR][Projects] energyQueued=0 committed=0/0
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=729 BP=550 nanos=2+0/2 available=yes firstSlot=3
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=53
  5.12  [AIR][Raid] opening size drawn=4
  5.12  [AIR][Produce] opening.raid armthund plant=729 projected=1/4
... 7291 more
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
  0.17  RESERVE: leglab at (12560, 832) facing 3 (id 66)
  0.17  RESERVE: zone 12 at (12632, 832) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (12608, 832) facing 3: 2 of 2 slots (group 7, zone)
  0.17  RESERVE: corridor 13 at (12584, 736) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (12584, 832) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (12336, 832) facing 3, 20x10 cells: 190 of 200 held
  0.17  EXP: approach: armcom(2244) at (430, 2297) walks to (414, 2291), 136 from the armmex site (288, 2240)
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
