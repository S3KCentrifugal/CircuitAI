# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 40.0 min (frame 72015); wall 1086 s
- DLL: build-theatres\d199\build-4\SkirmishAI.dll (424cf06b95681fd7); AI BARbTest/test; staged 2026-10-04T22:32:49
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=TACTICAL/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=TECH/cortex/test, 9=AIR/legion/test, 10=TACTICAL/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: skirmish_cpu_clean.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T013249Z-4525f639\runs\20261005T015059Z-a65805e7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:47.421074][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `1.000 speed_actual=1.000 ai_n=1800 ai_mean_ms=1.430222 ai_p50_ms=1.082031 ai_p95_ms=3.746094 ai_p99_ms=7.210938 ai_max_ms=10.537109 fps_n=61 fps_p10=217.000 fps_p50=245.000 fps_p90=260.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:01:00.464737][f=0001800] [AirOrders] frame=1800 team=0 all_apm=88 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `game-ended` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 4.7 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 840 (3 by power), bank 1 + 14/s (0 by metal))
- forbid 'invariant' hit at 5.7 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 840 (3 by power), bank 2 + 14/s (0 by metal))
- forbid 'invariant' hit at 14.0 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of armalab 24851 are not on it
- forbid 'invariant' hit at 15.2 min: [INVARIANT] INV-008 7 turret(s) in range of the reclaim of coralab 1660 are not on it
- forbid 'invariant' hit at 21.2 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 5370 (20 by power), bank 20 + 72/s (0 by metal))
- forbid 'invariant' hit at 23.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.2 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-029 armalab 30295 stands 10 cells from the turrets, not tight
- forbid 'invariant' hit at 28.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 30.0 min: [INVARIANT] INV-014 armmmkr packed at (320, 1696) with no turret slot within 450
- forbid 'invariant' hit at 30.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 30.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 32.2 min: [INVARIANT] INV-014 armmmkr packed at (272, 1216) with no turret slot within 450
- forbid 'invariant' hit at 32.3 min: [INVARIANT] INV-029 coralab 1159 stands 13 cells from the turrets, not tight
- forbid 'invariant' hit at 32.3 min: [INVARIANT] INV-022 a new set of cormmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 18 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-029 coraap 11780 stands 5 cells from the turrets, not tight
- forbid 'invariant' hit at 32.8 min: [INVARIANT] INV-014 armafus packed at (272, 800) with no turret slot within 450
- forbid 'invariant' hit at 33.6 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added
- forbid 'invariant' hit at 33.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-016 the advanced lab 1159 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 318 elmos away, not flush (160)
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.4 min: [INVARIANT] INV-022 a new set of cormmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 34.8 min: [INVARIANT] INV-016 the advanced lab 1159 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 34.8 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 318 elmos away, not flush (160)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 25359 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 31863 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 6135 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 35.8 min: [INVARIANT] INV-016 the advanced lab 1159 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 35.8 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 318 elmos away, not flush (160)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 16424 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 8593 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 1247 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 25348 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.4 min: [INVARIANT] INV-060 coast cluster #7 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 9041 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 2903 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 25268 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 11661 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 3837 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 36.7 min: [INVARIANT] INV-052 ferry run for cargo 25201 unloading for 16 s
- forbid 'invariant' hit at 36.8 min: [INVARIANT] INV-031 the advanced lab 1159 retired while the advanced fusion was funded: bank 5381 + 293/s x 20 s (59% built, build power 6660) = 11307 against 8245 (85% of 9700)
- forbid 'invariant' hit at 36.8 min: [INVARIANT] INV-016 the advanced lab 1159 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 36.8 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 318 elmos away, not flush (160)
- forbid 'invariant' hit at 36.9 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (7 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 36.9 min: [INVARIANT] INV-008 7 turret(s) in range of the reclaim of coralab 1159 are not on it
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 9488 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 2088 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 19557 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.4 min: [INVARIANT] INV-060 coast cluster #7 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 6962 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 15888 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 983 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 16069 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 14571 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 25794 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 27571 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 24828 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 29622 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 6159 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-022 a new set of cormmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 2228 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 27081 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 5003 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 6135 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 11338 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 7515 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 11236 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-060 coast cluster #7 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 38.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 38.8 min: [INVARIANT] INV-022 a new set of cormmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 38.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (14 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 38.9 min: [INVARIANT] INV-020 no layout room for armmmkr for 124 s
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 24512 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 25841 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 14362 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 8094 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 2344 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 30885 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 7504 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 8662 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 21511 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 29876 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 1333 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 702 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 26050 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 19038 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 2771 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.4 min: [INVARIANT] INV-060 coast cluster #7 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 25954 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 6959 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 809 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 6554 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 5031 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 20876 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 16069 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 6 has 6534 free
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-014 cormmkr packed at (15008, 1712) with no turret slot within 450
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 256 elmos away, not flush (160)
- forbid 'invariant' hit at 39.7 min: [INVARIANT] INV-060 coast cluster #9 has 5 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-020 no layout room for armmmkr for 184 s
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 31863 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 25359 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 9041 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 9968 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 29810 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 7515 has done nothing for 60 s (task type 2, last rule wait)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T013249Z-4525f639\runs\20261005T015059Z-a65805e7\screen_2026-10-05_01-35-13-058.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T013249Z-4525f639\runs\20261005T015059Z-a65805e7\screen_2026-10-05_01-40-43-750.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T013249Z-4525f639\runs\20261005T015059Z-a65805e7\screen_2026-10-05_01-44-04-538.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T013249Z-4525f639\runs\20261005T015059Z-a65805e7\screen_2026-10-05_01-50-44-109.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 4, 4 shots, end at 40.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (550, 1740) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (550, 730) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (550, 2700) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (2000, 400) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (2000, 950) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (2000, 1500) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (2000, 2050) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (2000, 2600) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (14800, 730) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (14800, 1740) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (14800, 2700) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (13250, 400) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (13250, 950) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (13250, 1500) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (13250, 2050) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (13250, 2600) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 4
  0.00  [Playtest] speed 4 at 0.00 min
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (550, 1740) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (550, 730) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (550, 2700) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (2000, 400) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (2000, 950) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (2000, 1500) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (2000, 2050) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (2000, 2600) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (14800, 730) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (14800, 1740) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (14800, 2700) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (13250, 400) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (13250, 950) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (13250, 1500) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (13250, 2050) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (13250, 2600) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.08  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=997 E=0 bank=990 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (618, 1485), 269 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|601|1753|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(550,727) factory=armlab landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=TACTICAL side=cortex start=(547,2771) factory=corhp landLocked=no spot=2 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(1991,407) factory=legsy landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(1934,916) factory=armsy landLocked=no spot=3 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(1999,1501) factory=corsy landLocked=no spot=4 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(1936,2043) factory=legsy landLocked=no spot=4 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=SEA side=armada start=(1957,2671) factory=armsy landLocked=no spot=5 known=7/7
  0.15  [Team][Roster] team 1 first mex at 624,688
  0.17  [Team][Roster] team 3 first mex at 1840,336
  0.17  [Team][Roster] team 5 first mex at 1888,1487
  0.20  [Team][Roster] team 2 first mex at 544,2927
  0.20  [Team][Roster] team 4 first mex at 1792,832
  0.25  [Team][Roster] team 7 first mex at 1808,2912
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=961 E=18 bank=716 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.28  [Team][Roster] first mex 9658 at 784,1792
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|601|1753|0|1|1|784|1792
  0.28  [AIR][Rule] opening.mex builder=594
  0.32  [Team][Roster] team 6 first mex at 1568,1952
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=987 E=30 bank=990 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=1030 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=4 bank=1039 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.93  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=4 bank=1039 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 1043/1050, energy +30.0 bank 998/1000, units 2
  1.07  [AIR][Wind] cluster=0 slots=6 at=496,2120 local=false builder=594
  1.07  [AIR][Rule] opening.energy builder=594
  1.10  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=4 bank=1039 E=30 bank=982 pull=3 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=1 committed=40/175
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Capacity] own=4/30 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=4 bank=1036 E=30 bank=950 pull=35 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=1 committed=40/175
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.31  [Playtest] finished armwin team 0 at 1.32 min
  1.42  [Playtest] finished armwin team 0 at 1.42 min
  1.43  [AIR][Capacity] own=4/30 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=4 bank=1010 E=30 bank=950 pull=35 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.53  [Playtest] finished armwin team 0 at 1.53 min
  1.60  [AIR][Capacity] own=4/40 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=4 bank=993 E=43 bank=969 pull=35 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=18/78
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.64  [Playtest] finished armwin team 0 at 1.64 min
  1.76  [Playtest] finished armwin team 0 at 1.76 min
  1.77  [AIR][Capacity] own=4/61 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=4 bank=976 E=56 bank=951 pull=35 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.89  [Playtest] finished armwin team 0 at 1.89 min
  1.90  [AIR][Starter] nearby distance=128
  1.90  [AIR][Rule] opening.plant builder=594
  1.92  [AIR][EcoLayout] reserved air.eco.0 reactor=848,2144 converters=8 support=12 zone=30
  1.93  [AIR][EcoLayout] reserved air.eco.1 reactor=336,352 converters=8 support=12 zone=59
  1.93  [AIR][Capacity] own=4/110 usage=8/17 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=4 bank=962 E=109 bank=988 pull=17 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=607/1027
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=30574 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.95  [AIR][EcoLayout] reserved air.eco.2 reactor=1104,2656 converters=8 support=0 zone=90
  1.97  [AIR][EcoLayout] reserved air.eco.3 reactor=1360,1632 converters=8 support=12 zone=116
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.0 bank 805/1050, energy +137.6 bank 996/1003, units 9
  2.10  [AIR][Capacity] own=4/132 usage=35/63 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=4 bank=649 E=132 bank=952 pull=63 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=249/421
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=30574 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.22  [Playtest] finished armap team 0 at 2.22 min
  2.22  [AIR][Claim] cancel unowned native order armnanotc
  2.22  [AIR][Claim] cancel unowned native order armnanotc
  2.22  [AIR][State] T1_CONTEST
  2.23  [AIR][Produce] opening.scout armpeep plant=30574 projected=1/1
  2.23  [AIR][Rule] opening.commander.guard builder=594
  2.27  [AIR][Capacity] own=4/122 usage=8/252 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=4 bank=407 E=122 bank=929 pull=252 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.35  [AIR][Produce] constructor.recovery armca plant=30574 projected=1/3
  2.35  [AIR][Scout] opening drone=25856 enemy starts=8
  2.43  [AIR][Capacity] own=4/122 usage=0/19 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=4 bank=380 E=122 bank=377 pull=191 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.56  [AIR][Produce] constructor.recovery armca plant=30574 projected=2/3
  2.56  [AIR][Rule] recovery.energy builder=2564
  2.60  [AIR][Capacity] own=4/133 usage=0/0 gifts=1 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=344 E=130 bank=513 pull=128 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=1 committed=155/0
  2.60  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=4/124 usage=6/61 gifts=1 sent=0 excess=0 pressure=false mobile=100 arriving=0 idle=50 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=5 bank=278 E=125 bank=1116 pull=191 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=126/0
  2.77  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Produce] constructor.recovery armca plant=30574 projected=3/3
  2.77  [AIR][Rule] mex.expand builder=14789
  2.93  [AIR][Capacity] own=4/127 usage=1/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=49 shortage=0 reason=available or arriving power
  2.93  [AIR][Economy] T1_CONTEST M=4 bank=208 E=125 bank=1141 pull=154 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=96/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.98  [AIR][Produce] opening.screen armfig plant=30574 projected=1/6
  2.98  [AIR][Rule] mex.expand builder=17106
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.0 bank 186/1150, energy +146.5 bank 1156/1178, units 14
  3.00  [Playtest] speed 1 at 3.00 min
  3.01  [AIR][Rule] commander.factory.guard builder=594
  3.10  [AIR][Capacity] own=4/138 usage=12/375 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST M=4 bank=159 E=135 bank=1166 pull=375 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=66/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.14  [AIR][Produce] opening.screen armfig plant=30574 projected=2/6
  3.14  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.27  [AIR][Capacity] own=4/101 usage=12/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST M=5 bank=121 E=106 bank=689 pull=375 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=37/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.29  [AIR][Produce] opening.screen armfig plant=30574 projected=3/6
  3.33  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.42  [AIR][Layout] cluster=0 labs=1 at=1825,2305
  3.43  [AIR][Layout] cluster=1 labs=1 at=1921,2113
  3.43  [AIR][Capacity] own=4/82 usage=9/268 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=63 E=86 bank=347 pull=268 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=7/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Produce] opening.screen armfig plant=30574 projected=4/6
  3.45  [AIR][Layout] cluster=2 labs=1 at=1921,2689
  3.47  [AIR][Layout] cluster=3 labs=1 at=2017,961
  3.47  [Playtest] finished armsolar team 0 at 3.47 min
  3.48  [AIR][Rule] mex.expand builder=2564
  3.52  [AIR][Screen] fighters=3 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=4/81 usage=6/243 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=46 E=82 bank=135 pull=375 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=0/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.63  [AIR][Produce] opening.screen armfig plant=30574 projected=5/6
  3.70  [AIR][Screen] fighters=4 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=4/115 usage=9/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=36 E=108 bank=895 pull=375 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=0/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.78  [AIR][Produce] opening.screen armfig plant=30574 projected=6/6
  3.80  [Playtest] camera requested (680,2016) height=2200
  3.80  [Playtest] camera captured name=ta position=(680,2016) height=2200
  3.80  [Playtest] screenshot at 3.8 min of team 0 at (680, 2016)
  3.88  [AIR][Screen] fighters=5 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=4/149 usage=9/375 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST M=5 bank=12 E=146 bank=863 pull=375 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.98  [AIR][Layout] cluster=4 labs=1 at=97,2017
  3.99  [AIR][Commander] cleared factory guard for commander.idle.wait
  3.99  [AIR][Rule] commander.idle.wait builder=594
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.0 bank 33/1150, energy +166.0 bank 1228/1228, units 19
  4.00  [Playtest] speed 4 at 4.00 min
  4.02  [AIR][Wind] cluster=1 slots=6 at=912,2392 local=false builder=594
  4.02  [AIR][Rule] commander.idle.energy builder=594
  4.05  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.10  [AIR][Capacity] own=4/160 usage=0/3 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST M=4 bank=70 E=157 bank=1215 pull=3 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=1 committed=40/175
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.18  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=231 at=760,1960
  4.18  [AIR][Rule] opening.support builder=2564
  4.22  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.24  [AIR][Rule] opening.support.assist builder=14789
  4.25  [AIR][Rule] opening.support.assist builder=17106
  4.27  [AIR][Capacity] own=4/139 usage=4/0 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=136 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST M=6 bank=100 E=143 bank=1183 pull=83 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=1 committed=256/3180
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.28  [Playtest] finished armwin team 0 at 4.28 min
  4.30  [AIR][Rule] commander.energy.local builder=594
  4.33  [AIR][Layout] cluster=5 labs=1 at=1345,577
  4.35  [AIR][Layout] cluster=6 labs=1 at=1,2305
  4.38  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.41  [Playtest] finished armwin team 0 at 4.41 min
  4.43  [AIR][Capacity] own=4/136 usage=2/13 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=6 bank=56 E=141 bank=1185 pull=104 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=0 committed=187/2259
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.51  [Playtest] finished armwin team 0 at 4.51 min
  4.53  [AIR][Rule] commander.idle.assist builder=594
  4.55  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=4/135 usage=0/2 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=6 bank=16 E=137 bank=1178 pull=93 plants=1/0 aircraftDemand=3/126
  4.60  [AIR][Projects] energyQueued=0 committed=85/1194
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=30
  4.72  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.77  [AIR][Capacity] own=4/105 usage=0/2 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=151 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=6 bank=2 E=110 bank=1177 pull=274 plants=1/0 aircraftDemand=3/126
  4.77  [AIR][Projects] energyQueued=0 committed=7/98
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=30574 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.78  [Playtest] finished armnanotc team 0 at 4.78 min
  4.80  [AIR][Rule] mex.expand builder=14789
  4.80  [AIR][Rule] mex.expand builder=17106
  4.80  [AIR][Rule] commander.idle.wait builder=594
  4.81  [AIR][Rule] mex.expand builder=2564
  4.84  [AIR][Rule] commander.idle.energy builder=594
  4.88  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.93  [AIR][Capacity] own=4/105 usage=0/3 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST M=6 bank=54 E=106 bank=1215 pull=3 plants=1/0 aircraftDemand=8/288
  4.93  [AIR][Projects] energyQueued=1 committed=40/175
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=30574 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.0 bank 76/1150, energy +170.2 bank 1228/1229, units 24
  5.05  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  5.07  [Playtest] finished armwin team 0 at 5.07 min
  5.08  [AIR][Rule] commander.energy.local builder=594
  5.10  [AIR][Capacity] own=4/155 usage=2/15 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=6 bank=79 E=141 bank=1230 pull=15 plants=1/0 aircraftDemand=8/288
  5.10  [AIR][Projects] energyQueued=0 committed=36/159
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=30574 BP=350 nanos=1+0/2 available=yes firstSlot=3
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=28
  5.18  [AIR][Produce] recon.replace armpeep plant=30574 projected=1/1
  5.18  [Playtest] finished armwin team 0 at 5.18 min
  5.22  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  5.27  [AIR][Capacity] own=4/181 usage=14/229 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  5.27  [AIR][Economy] T1_CONTEST M=6 bank=58 E=182 bank=1126 pull=229 plants=1/0 aircraftDemand=8/288
... 3806 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(594) at (601, 1754) walks to (651, 1764), 136 from the armmex site (784, 1792)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (453, 1269) facing 1, 60x77 cells: 3972 of 4620 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (949, 1269) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (901, 1269) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (853, 1269) facing 1: 11 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (805, 1269) facing 1: 11 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1032, 1032) facing 1 (id 59)
  0.08  RESERVE: armlab at (1968, 688) facing 1 (id 60)
  0.08  RESERVE: zone 8 at (1896, 688) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1920, 688) facing 1: 2 of 2 slots (group 6, zone)
  0.08  RESERVE: armlab at (1968, 816) facing 1 (id 63)
  0.08  RESERVE: zone 9 at (1896, 816) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1920, 816) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (1968, 560) facing 1 (id 66)
  0.08  RESERVE: zone 10 at (1896, 560) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1920, 560) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: armlab at (3968, 816) facing 1 (id 69)
  0.08  RESERVE: zone 11 at (3896, 816) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 816) facing 1: 2 of 2 slots (group 9, zone)
  0.08  RESERVE: corridor 12 at (3944, 912) facing 1, 21x6 cells: 126 of 126 held
  0.08  RESERVE: zone 13 at (3944, 816) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (4192, 816) facing 1, 20x10 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.09  RESERVE: zone 7 at (14872, 1253) facing 3, 62x77 cells: 4049 of 4774 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14376, 1253) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14424, 1253) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14472, 1253) facing 3: 11 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14520, 1253) facing 3: 11 of 13 slots (group 5, held, zone)
  0.09  RESERVE: coralab at (14296, 1016) facing 3 (id 59)
  0.09  RESERVE: corlab at (13424, 528) facing 3 (id 60)
  0.09  RESERVE: zone 8 at (13496, 528) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of cornanotc 2x1 gap 0 behind (13472, 528) facing 3: 2 of 2 slots (group 6, zone)
  0.09  RESERVE: corridor 9 at (13448, 432) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 10 at (13448, 624) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: zone 11 at (13448, 528) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (13200, 528) facing 3, 20x10 cells: 180 of 200 held
  0.09  EXP: approach: legcom(11315) at (14750, 1700) walks to (14593, 1486), 137 from the legmex site (14512, 1376)
  0.17  RESERVE: armlab at (1968, 688) facing 1 (id 72)
  0.17  RESERVE: zone 14 at (1896, 688) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 816) facing 1 (id 73)
  0.17  RESERVE: zone 14 at (1896, 816) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 560) facing 1 (id 74)
  0.17  RESERVE: zone 14 at (1896, 560) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (3968, 1456) facing 1 (id 75)
  0.17  RESERVE: zone 14 at (3896, 1456) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 1456) facing 1: 2 of 2 slots (group 10, zone)
  0.17  EXP: approach: corcom(12844) at (14799, 731) walks to (14663, 456), 139 from the cormex site (14544, 384)
  0.17  RESERVE: corlab at (13424, 912) facing 3 (id 63)
  0.17  RESERVE: zone 12 at (13496, 912) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of cornanotc 2x1 gap 0 behind (13472, 912) facing 3: 2 of 2 slots (group 7, zone)
  0.17  RESERVE: corridor 13 at (13448, 816) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: corridor 14 at (13448, 1008) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (13448, 912) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (13200, 912) facing 3, 20x10 cells: 180 of 200 held
  0.26  RESERVE: coralab at (13448, 1224) facing 3 (id 66)
  0.26  RESERVE: zone 16 at (13568, 1224) facing 3, 6x7 cells: 42 of 42 held
  0.26  RESERVE: grid of cornanotc 2x2 gap 0 behind (13520, 1224) facing 3: 4 of 4 slots (group 8, zone)
  0.26  RESERVE: zone 17 at (13496, 1224) facing 0, 15x9 cells: 12 of 135 held
  0.26  RESERVE: corridor 18 at (13200, 1224) facing 3, 20x13 cells: 260 of 260 held
  0.28  EXP: approach: armcom(594) at (719, 1778) walks to (420, 1592), 136 from the armmex site (304, 1520)
  0.30  EXP: approach: armcom(594) at (719, 1778) walks to (420, 1592), 136 from the armmex site (304, 1520)
  0.33  RESERVE: armlab at (1968, 688) facing 1 (id 78)
  0.33  RESERVE: zone 15 at (1896, 688) facing 1, 3x6 cells: 0 of 18 held
  0.33  RESERVE: armlab at (1968, 816) facing 1 (id 79)
  0.33  RESERVE: zone 15 at (1896, 816) facing 1, 3x6 cells: 0 of 18 held
  0.33  RESERVE: armlab at (1968, 560) facing 1 (id 80)
  0.33  RESERVE: zone 15 at (1896, 560) facing 1, 3x6 cells: 0 of 18 held
  0.33  RESERVE: armlab at (3968, 1456) facing 1 (id 81)
  0.33  RESERVE: zone 15 at (3896, 1456) facing 1, 3x6 cells: 0 of 18 held
  0.34  RESERVE: coralab at (13448, 1400) facing 3 (id 71)
  0.34  RESERVE: zone 19 at (13568, 1400) facing 3, 6x7 cells: 42 of 42 held
  0.34  RESERVE: grid of cornanotc 2x2 gap 0 behind (13520, 1400) facing 3: 4 of 4 slots (group 9, zone)
  0.34  RESERVE: zone 20 at (13496, 1400) facing 0, 15x9 cells: 12 of 135 held
  0.34  RESERVE: corridor 21 at (13200, 1400) facing 3, 20x13 cells: 220 of 260 held
  0.37  EXP: approach: legcom(11315) at (14551, 1429) walks to (15079, 1412), 137 from the legmex site (15216, 1408)
  0.38  EXP: approach: legcom(11315) at (14550, 1428) walks to (14807, 1836), 137 from the legmex site (14880, 1952)
  0.40  EXP: approach: armcom(594) at (719, 1779) walks to (420, 1592), 136 from the armmex site (304, 1520)
  0.41  EXP: approach: armcom(594) at (719, 1779) walks to (420, 1592), 136 from the armmex site (304, 1520)
  0.42  RESERVE: corgant at (13472, 2576) facing 3 (id 76)
  0.42  RESERVE: zone 22 at (13688, 2576) facing 3, 15x30 cells: 434 of 450 held
  0.42  RESERVE: grid of cornanotc 10x5 gap 0 behind (13568, 2576) facing 3: 46 of 50 slots (group 10, zone)
  0.42  RESERVE: zone 22 released
  0.42  RESERVE: zone 23 at (13688, 2576) facing 3, 15x24 cells: 344 of 360 held
  0.42  RESERVE: grid of cornanotc 8x5 gap 0 behind (13568, 2576) facing 3: 36 of 40 slots (group 11, zone)
  0.42  RESERVE: zone 23 released
  0.42  RESERVE: zone 24 at (13664, 2576) facing 3, 12x24 cells: 272 of 288 held
  0.42  RESERVE: grid of cornanotc 8x4 gap 0 behind (13568, 2576) facing 3: 28 of 32 slots (group 12, zone)
  0.42  RESERVE: zone 24 released
  0.42  RESERVE: zone 25 at (13664, 2576) facing 3, 12x18 cells: 200 of 216 held
  0.42  RESERVE: grid of cornanotc 6x4 gap 0 behind (13568, 2576) facing 3: 20 of 24 slots (group 13, zone)
  0.42  RESERVE: zone 25 released
  0.42  RESERVE: zone 26 at (13640, 2576) facing 3, 9x18 cells: 146 of 162 held
  0.42  RESERVE: grid of cornanotc 6x3 gap 0 behind (13568, 2576) facing 3: 14 of 18 slots (group 14, zone)
  0.42  RESERVE: zone 26 released
  0.42  RESERVE: zone 27 at (13616, 2576) facing 3, 6x10 cells: 58 of 60 held
  0.42  RESERVE: grid of cornanotc 3x2 gap 0 behind (13568, 2576) facing 3: 5 of 6 slots (group 15, zone)
  0.42  RESERVE: zone 27 released
  0.42  RESERVE: corgant at (13472, 2576) facing 3 (id 226)
  0.42  RESERVE: zone 28 at (13688, 2576) facing 3, 15x30 cells: 434 of 450 held
  0.42  RESERVE: grid of cornanotc 10x5 gap 0 behind (13568, 2576) facing 3: 46 of 50 slots (group 16, zone)
  0.42  RESERVE: zone 28 released
  0.42  RESERVE: zone 29 at (13688, 2576) facing 3, 15x24 cells: 344 of 360 held
  0.42  RESERVE: grid of cornanotc 8x5 gap 0 behind (13568, 2576) facing 3: 36 of 40 slots (group 17, zone)
  0.42  RESERVE: zone 29 released
  0.42  RESERVE: zone 30 at (13664, 2576) facing 3, 12x24 cells: 272 of 288 held
  0.42  RESERVE: grid of cornanotc 8x4 gap 0 behind (13568, 2576) facing 3: 28 of 32 slots (group 18, zone)
  0.42  RESERVE: zone 30 released
  0.42  RESERVE: zone 31 at (13664, 2576) facing 3, 12x18 cells: 200 of 216 held
  0.42  RESERVE: grid of cornanotc 6x4 gap 0 behind (13568, 2576) facing 3: 20 of 24 slots (group 19, zone)
  0.42  RESERVE: zone 31 released
  0.42  RESERVE: zone 32 at (13640, 2576) facing 3, 9x18 cells: 146 of 162 held
  0.42  RESERVE: grid of cornanotc 6x3 gap 0 behind (13568, 2576) facing 3: 14 of 18 slots (group 20, zone)
  0.42  RESERVE: zone 32 released
  0.42  RESERVE: zone 33 at (13616, 2576) facing 3, 6x10 cells: 58 of 60 held
  0.42  RESERVE: grid of cornanotc 3x2 gap 0 behind (13568, 2576) facing 3: 5 of 6 slots (group 21, zone)
  0.42  RESERVE: zone 33 released
  0.43  EXP: approach: corcom(12844) at (14637, 509) walks to (15107, 284), 139 from the cormex site (15232, 224)
  0.44  EXP: approach: armcom(5813) at (707, 1034) walks to (892, 355), 136 from the armmex site (928, 224)
  0.50  RESERVE: armlab at (1968, 688) facing 1 (id 82)
```
