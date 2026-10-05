# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 40.0 min (frame 72000); wall 920 s
- DLL: build-theatres\d199\build-4\SkirmishAI.dll (424cf06b95681fd7); AI BARbTest/test; staged 2026-10-04T22:15:39
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=TACTICAL/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=TECH/cortex/test, 9=AIR/legion/test, 10=TACTICAL/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: skirmish_cpu_clean.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T011539Z-0c89a5b6\runs\20261005T013102Z-2ac71542\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:47.546792][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `=1.000 speed_actual=1.000 ai_n=1800 ai_mean_ms=1.319847 ai_p50_ms=1.037109 ai_p95_ms=3.384766 ai_p99_ms=6.025391 ai_max_ms=9.414063 fps_n=61 fps_p10=255.000 fps_p50=276.000 fps_p90=295.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:01:00.515952][f=0001800] [AirOrders] frame=1800 team=0 all_apm=76 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `game-ended` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 14.1 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of armalab 22759 are not on it
- forbid 'invariant' hit at 15.3 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 3300 (12 by power), bank 4 + 40/s (0 by metal))
- forbid 'invariant' hit at 15.8 min: [INVARIANT] INV-008 7 turret(s) in range of the reclaim of coralab 13439 are not on it
- forbid 'invariant' hit at 16.8 min: [INVARIANT] INV-008 8 turret(s) in range of the reclaim of coralab 13439 are not on it
- forbid 'invariant' hit at 17.8 min: [INVARIANT] INV-008 8 turret(s) in range of the reclaim of coralab 13439 are not on it
- forbid 'invariant' hit at 22.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-039 T1 land constructors released 674 s, 0 spam labs of 2 wanted, no forward order for 180 s
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.0 min: [INVARIANT] INV-022 a new set of corafus starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.4 min: [INVARIANT] INV-029 corap 30642 stands 4 cells from the turrets, not tight
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.8 min: [INVARIANT] INV-014 armmmkr packed at (288, 1200) with no turret slot within 450
- forbid 'invariant' hit at 31.3 min: [INVARIANT] INV-022 a new set of cormmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-039 T1 land constructors released 854 s, 0 spam labs of 4 wanted, no forward order for 180 s
- forbid 'invariant' hit at 32.2 min: [INVARIANT] INV-029 coraap 29039 stands 6 cells from the turrets, not tight
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-014 armmmkr packed at (400, 1856) with no turret slot within 450
- forbid 'invariant' hit at 32.8 min: [INVARIANT] INV-014 armafus packed at (336, 1776) with no turret slot within 450
- forbid 'invariant' hit at 32.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 17 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 194 elmos away, not flush (160)
- forbid 'invariant' hit at 32.9 min: [INVARIANT] INV-004 metal floating at 6688 of 6700 for 60 s while armmmkr is under construction and static build power 5760 is under 8641
- forbid 'invariant' hit at 32.9 min: [INVARIANT] INV-011 metal floating at 6688 of 6700 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 33.1 min: [INVARIANT] INV-022 a new set of cormmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 33.6 min: [INVARIANT] INV-014 cormmkr packed at (15008, 1184) with no turret slot within 450
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-019 11 turret frames under construction, 8 allowed (build power 30210 (114 by power), bank 6628 + 691/s (60 by metal))
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-014 armmmkr packed at (256, 1632) with no turret slot within 450
- forbid 'invariant' hit at 33.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 194 elmos away, not flush (160)
- forbid 'invariant' hit at 33.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.2 min: [INVARIANT] INV-022 a new set of cormmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.7 min: [INVARIANT] INV-039 T2 land constructors released 995 s, 1 mex cluster(s) without long-range AA, no defence order for 180 s
- forbid 'invariant' hit at 34.9 min: [INVARIANT] INV-004 metal floating at 6094 of 6100 for 60 s while armmmkr is under construction and static build power 0 is under 11071
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-039 T1 land constructors released 1034 s, 0 spam labs of 5 wanted, no forward order for 180 s
- forbid 'invariant' hit at 35.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 17 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 35.3 min: [INVARIANT] INV-014 cormmkr packed at (15008, 1120) with no turret slot within 450
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 10375 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 36.1 min: [INVARIANT] INV-022 a new set of cormmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 9684 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 3101 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 36.9 min: [INVARIANT] INV-014 cormmkr packed at (15008, 1056) with no turret slot within 450
- forbid 'invariant' hit at 36.9 min: [INVARIANT] INV-004 metal floating at 6042 of 6100 for 60 s while armafus is under construction and static build power 0 is under 10062
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 20595 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 100 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 13163 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 17575 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 22685 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 15567 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 21681 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 2082 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.2 min: [INVARIANT] INV-022 a new set of cormmkr starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 37.2 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (13 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 12985 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 14803 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 15453 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 11496 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 2209 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-039 T1 land constructors released 1214 s, 0 spam labs of 5 wanted, no forward order for 180 s
- forbid 'invariant' hit at 38.3 min: [INVARIANT] INV-014 cormmkr packed at (15040, 928) with no turret slot within 450
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-014 corafus packed at (14928, 1824) with no turret slot within 450
- forbid 'invariant' hit at 38.6 min: [INVARIANT] INV-020 no layout room for armmmkr for 129 s
- forbid 'invariant' hit at 38.9 min: [INVARIANT] INV-022 a new set of cormmkr starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 39.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 39.4 min: [INVARIANT] INV-014 cormmkr packed at (15056, 1520) with no turret slot within 450
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 31433 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 13991 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 7182 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 15453 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 7405 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 29179 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 8747 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 7589 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 7391 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 25303 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 13697 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 24868 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 25001 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-020 no layout room for armmmkr for 189 s
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-022 a new set of cormmkr starts 20 cell(s) from the turrets, not flush

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T011539Z-0c89a5b6\runs\20261005T013102Z-2ac71542\screen_2026-10-05_01-18-03-032.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T011539Z-0c89a5b6\runs\20261005T013102Z-2ac71542\screen_2026-10-05_01-23-33-774.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T011539Z-0c89a5b6\runs\20261005T013102Z-2ac71542\screen_2026-10-05_01-26-49-506.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T011539Z-0c89a5b6\runs\20261005T013102Z-2ac71542\screen_2026-10-05_01-30-49-877.png

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
  0.28  [Team][Roster] first mex 15242 at 784,1792
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|601|1753|0|1|1|784|1792
  0.28  [AIR][Rule] opening.mex builder=19928
  0.32  [Team][Roster] team 6 first mex at 1568,1952
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=987 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 1043/1050, energy +30.0 bank 982/1000, units 2
  1.04  [AIR][Starter] nearby distance=160
  1.04  [AIR][Rule] opening.plant builder=19928
  1.05  [AIR][EcoLayout] reserved air.eco.0 reactor=336,2144 converters=8 support=12 zone=22
  1.07  [AIR][EcoLayout] reserved air.eco.1 reactor=336,352 converters=8 support=12 zone=53
  1.08  [AIR][EcoLayout] reserved air.eco.2 reactor=1104,2656 converters=8 support=0 zone=88
  1.10  [AIR][EcoLayout] reserved air.eco.3 reactor=1360,1632 converters=8 support=12 zone=119
  1.10  [AIR][Capacity] own=4/30 usage=35/63 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=4 bank=970 E=30 bank=855 pull=63 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=534/904
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.10  [AIR][Bay] 0 plant=25028 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Capacity] own=4/30 usage=35/63 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=4 bank=653 E=30 bank=522 pull=63 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=176/298
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=25028 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.35  [Playtest] finished armap team 0 at 1.35 min
  1.35  [AIR][Claim] cancel unowned native order armnanotc
  1.35  [AIR][Claim] cancel unowned native order armnanotc
  1.35  [AIR][State] T1_CONTEST
  1.36  [AIR][Produce] opening.scout armpeep plant=25028 projected=1/1
  1.36  [AIR][Rule] opening.commander.guard builder=19928
  1.43  [AIR][Capacity] own=4/30 usage=3/99 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=473 E=30 bank=4 pull=177 plants=1/0 aircraftDemand=3/121
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Capacity] own=4/30 usage=0/30 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=515 E=30 bank=4 pull=169 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=4/30 usage=0/30 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=553 E=30 bank=1 pull=169 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Capacity] own=4/30 usage=0/30 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=587 E=30 bank=0 pull=169 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.0 bank 607/1150, energy +30.0 bank 3/1100, units 4
  2.07  [AIR][Produce] constructor.recovery armca plant=25028 projected=1/3
  2.07  [AIR][Scout] opening drone=16312 enemy starts=8
  2.10  [AIR][Capacity] own=4/30 usage=0/0 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=630 E=30 bank=1 pull=7 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=4/30 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=658 E=30 bank=3 pull=120 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Capacity] own=4/30 usage=0/2 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=680 E=30 bank=18 pull=128 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=4/30 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=698 E=30 bank=2 pull=128 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=4/30 usage=0/11 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=714 E=30 bank=17 pull=128 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Produce] constructor.recovery armca plant=25028 projected=2/3
  2.77  [AIR][Rule] recovery.energy builder=27357
  2.93  [AIR][Capacity] own=4/32 usage=2/2 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=64 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=697 E=30 bank=2 pull=128 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=132/0
  2.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=164 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.0 bank 689/1150, energy +35.0 bank 1/1125, units 6
  3.00  [Playtest] speed 1 at 3.00 min
  3.10  [AIR][Capacity] own=4/35 usage=3/7 gifts=1 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=49 shortage=66 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=683 E=35 bank=0 pull=128 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=102/0
  3.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=166 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Produce] constructor.recovery armca plant=25028 projected=3/3
  3.27  [AIR][Capacity] own=4/35 usage=5/49 gifts=1 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=50 ecoStatic=0 working=50 shortage=0 reason=available or arriving power
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=667 E=35 bank=38 pull=128 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=72/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Rule] recovery.energy builder=22820
  3.38  [AIR][Layout] cluster=0 labs=1 at=1825,2305
  3.40  [AIR][Layout] cluster=1 labs=1 at=1921,2113
  3.42  [AIR][Layout] cluster=2 labs=1 at=2017,961
  3.43  [AIR][Capacity] own=4/40 usage=5/0 gifts=1 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=100 shortage=3 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=628 E=36 bank=81 pull=112 plants=1/0 aircraftDemand=3/121
  3.43  [AIR][Projects] energyQueued=0 committed=179/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=153 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.58  [AIR][Produce] opening.screen armfig plant=25028 projected=1/6
  3.58  [AIR][Rule] recovery.energy builder=8220
  3.60  [AIR][Capacity] own=4/40 usage=8/53 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=5 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=546 E=40 bank=467 pull=53 plants=1/0 aircraftDemand=3/121
  3.60  [AIR][Projects] energyQueued=1 committed=275/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=155 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.61  [AIR][Rule] commander.factory.guard builder=19928
  3.67  [Playtest] finished armsolar team 0 at 3.67 min
  3.73  [AIR][Produce] opening.screen armfig plant=25028 projected=2/6
  3.73  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=4/45 usage=9/131 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=457 E=42 bank=1101 pull=131 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=1 committed=362/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [Playtest] camera requested (680,2016) height=2200
  3.80  [Playtest] camera captured name=ta position=(680,2016) height=2200
  3.80  [Playtest] screenshot at 3.8 min of team 0 at (680, 2016)
  3.89  [AIR][Produce] opening.screen armfig plant=25028 projected=3/6
  3.93  [AIR][Layout] cluster=3 labs=1 at=1537,481
  3.93  [AIR][Capacity] own=4/65 usage=16/301 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST M=5 bank=348 E=65 bank=1212 pull=301 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=274/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.0 bank 280/1150, energy +65.0 bank 899/1225, units 13
  4.00  [Playtest] speed 4 at 4.00 min
  4.04  [AIR][Produce] opening.screen armfig plant=25028 projected=4/6
  4.10  [AIR][Capacity] own=4/65 usage=18/375 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST M=4 bank=228 E=65 bank=1212 pull=375 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=185/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.12  [AIR][Screen] fighters=3 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.20  [AIR][Produce] opening.screen armfig plant=25028 projected=5/6
  4.20  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.20  [AIR][Rule] commander.idle.assist builder=19928
  4.20  [Playtest] finished armsolar team 0 at 4.20 min
  4.20  [AIR][Claim] cancel unowned native order armmakr
  4.21  [AIR][Rule] mex.expand builder=22820
  4.27  [AIR][Capacity] own=4/65 usage=9/127 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST M=4 bank=144 E=65 bank=1262 pull=127 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=108/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.30  [AIR][Screen] fighters=4 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.33  [Playtest] finished armsolar team 0 at 4.33 min
  4.33  [AIR][Claim] cancel unowned native order armmakr
  4.34  [AIR][Rule] commander.factory.guard builder=19928
  4.34  [AIR][Rule] mex.expand builder=27357
  4.43  [AIR][Capacity] own=4/85 usage=12/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=6 bank=52 E=81 bank=1311 pull=375 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=0 committed=11/0
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.44  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.44  [AIR][Rule] commander.idle.wait builder=19928
  4.44  [AIR][Produce] opening.screen armfig plant=25028 projected=6/6
  4.45  [AIR][Layout] cluster=4 labs=1 at=1249,2977
  4.47  [AIR][Rule] commander.factory.guard builder=19928
  4.48  [AIR][Screen] fighters=5 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.50  [Playtest] finished armsolar team 0 at 4.49 min
  4.50  [AIR][Claim] cancel unowned native order armmakr
  4.51  [AIR][Rule] mex.expand builder=8220
  4.60  [AIR][Capacity] own=4/105 usage=9/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=6 bank=30 E=105 bank=1361 pull=375 plants=1/0 aircraftDemand=3/127
  4.60  [AIR][Projects] energyQueued=0 committed=0/0
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.65  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.66  [AIR][Wind] cluster=0 slots=6 at=1024,2007 local=false builder=19928
  4.66  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.66  [AIR][Rule] commander.idle.energy builder=19928
  4.77  [AIR][Capacity] own=4/125 usage=7/35 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=6 bank=84 E=125 bank=1361 pull=35 plants=1/0 aircraftDemand=3/127
  4.77  [AIR][Projects] energyQueued=0 committed=17/77
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.81  [Playtest] finished armwin team 0 at 4.81 min
  4.82  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.82  [AIR][Rule] commander.energy.local builder=19928
  4.91  [Playtest] finished armwin team 0 at 4.91 min
  4.93  [AIR][Capacity] own=4/125 usage=6/30 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST M=6 bank=83 E=125 bank=1374 pull=30 plants=1/0 aircraftDemand=3/127
  4.93  [AIR][Projects] energyQueued=1 committed=40/175
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.98  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.0 bank 81/1150, energy +153.0 bank 1374/1376, units 19
  5.02  [Playtest] finished armwin team 0 at 5.02 min
  5.04  [AIR][Rule] commander.idle.energy builder=19928
  5.10  [AIR][Capacity] own=4/150 usage=7/35 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=6 bank=95 E=146 bank=1370 pull=35 plants=1/0 aircraftDemand=3/127
  5.10  [AIR][Projects] energyQueued=0 committed=21/94
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.15  [Playtest] finished armwin team 0 at 5.15 min
  5.15  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  5.16  [AIR][Rule] commander.energy.local builder=19928
  5.26  [Playtest] finished armwin team 0 at 5.26 min
  5.27  [AIR][Capacity] own=4/143 usage=7/35 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.27  [AIR][Economy] T1_CONTEST M=6 bank=92 E=147 bank=1363 pull=35 plants=1/0 aircraftDemand=3/127
  5.27  [AIR][Projects] energyQueued=0 committed=0/0
  5.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Rule] commander.idle.energy builder=19928
  5.32  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  5.36  [Playtest] finished armwin team 0 at 5.36 min
  5.38  [AIR][Wind] cluster=1 slots=6 at=928,2328 local=false builder=19928
  5.41  [AIR][Layout] repaired support air.bay.0 viable=2/5 slot=295 at=872,1912
  5.41  [AIR][Rule] opening.support builder=8220
  5.43  [AIR][Capacity] own=4/136 usage=0/3 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.43  [AIR][Economy] T1_CONTEST M=6 bank=113 E=138 bank=1376 pull=3 plants=1/0 aircraftDemand=3/127
  5.43  [AIR][Projects] energyQueued=1 committed=270/3375
  5.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=25028 BP=150 nanos=0+0/2 available=yes firstSlot=2
... 3570 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(19928) at (601, 1754) walks to (651, 1764), 136 from the armmex site (784, 1792)
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
  0.09  EXP: approach: legcom(23037) at (14750, 1700) walks to (14593, 1486), 137 from the legmex site (14512, 1376)
  0.17  RESERVE: armlab at (1968, 688) facing 1 (id 72)
  0.17  RESERVE: zone 14 at (1896, 688) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 816) facing 1 (id 73)
  0.17  RESERVE: zone 14 at (1896, 816) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 560) facing 1 (id 74)
  0.17  RESERVE: zone 14 at (1896, 560) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (3968, 1456) facing 1 (id 75)
  0.17  RESERVE: zone 14 at (3896, 1456) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 1456) facing 1: 2 of 2 slots (group 10, zone)
  0.17  EXP: approach: corcom(26067) at (14799, 731) walks to (14663, 456), 139 from the cormex site (14544, 384)
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
  0.28  EXP: approach: armcom(19928) at (719, 1778) walks to (420, 1592), 136 from the armmex site (304, 1520)
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
  0.37  EXP: approach: legcom(23037) at (14551, 1429) walks to (15079, 1412), 137 from the legmex site (15216, 1408)
  0.38  EXP: approach: armcom(19928) at (719, 1778) walks to (420, 1592), 136 from the armmex site (304, 1520)
  0.40  EXP: approach: armcom(19928) at (720, 1779) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.41  EXP: approach: armcom(19928) at (720, 1779) walks to (419, 1592), 136 from the armmex site (304, 1520)
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
  0.42  EXP: approach: armcom(19928) at (720, 1780) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.43  EXP: approach: corcom(26067) at (14637, 509) walks to (15107, 284), 139 from the cormex site (15232, 224)
  0.44  EXP: approach: armcom(8046) at (707, 1034) walks to (892, 355), 136 from the armmex site (928, 224)
  0.47  EXP: approach: legcom(23037) at (14551, 1429) walks to (14807, 1836), 137 from the legmex site (14880, 1952)
```
