# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 40.0 min (frame 72002); wall 1033 s
- DLL: build-theatres\d197-build\SkirmishAI.dll (585949b1f419e865); AI BARbTest/test; staged 2026-10-04T20:24:48
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=TACTICAL/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=TECH/cortex/test, 9=AIR/legion/test, 10=TACTICAL/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: skirmish_cpu_clean.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261004T232447Z-ed07c75f\runs\20261004T234203Z-870e40cb\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:46.411563][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `=1.000 speed_actual=1.000 ai_n=1800 ai_mean_ms=1.436042 ai_p50_ms=1.064453 ai_p95_ms=3.851563 ai_p99_ms=6.906250 ai_max_ms=9.666016 fps_n=61 fps_p10=192.000 fps_p50=230.000 fps_p90=277.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:00:59.517333][f=0001800] [AirOrders] frame=1800 team=0 all_apm=62 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `game-ended` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 5.2 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 990 (3 by power), bank 0 + 14/s (0 by metal))
- forbid 'invariant' hit at 5.3 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 840 (3 by power), bank 2 + 17/s (0 by metal))
- forbid 'invariant' hit at 13.2 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of armalab 8713 are not on it
- forbid 'invariant' hit at 13.2 min: [INVARIANT] INV-008 6 turret(s) in range of the reclaim of coralab 27966 are not on it
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.9 min: [INVARIANT] INV-039 T1 land constructors released 423 s, 0 spam labs of 2 wanted, no forward order for 180 s
- forbid 'invariant' hit at 27.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-029 armalab 8296 stands 10 cells from the turrets, not tight
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (7 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 28.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-022 a new set of corafus starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-029 coralab 12449 stands 7 cells from the turrets, not tight
- forbid 'invariant' hit at 29.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 29.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-029 coraap 24352 stands 3 cells from the turrets, not tight
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-022 a new set of cormmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.1 min: [INVARIANT] INV-014 armmmkr packed at (336, 880) with no turret slot within 450
- forbid 'invariant' hit at 30.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 30.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 30.8 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 208 elmos away, not flush (160)
- forbid 'invariant' hit at 31.0 min: [INVARIANT] INV-022 a new set of cormmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.1 min: [INVARIANT] INV-031 the advanced lab 12449 retired while the advanced fusion was funded: bank 4019 + 312/s x 23 s (0% built, build power 13920) = 11417 against 8245 (85% of 9700)
- forbid 'invariant' hit at 31.2 min: [INVARIANT] INV-014 armmmkr packed at (288, 816) with no turret slot within 450
- forbid 'invariant' hit at 31.2 min: [INVARIANT] INV-022 a new set of armmmkr starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 31.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-022 a new set of cormmkr starts 7 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.4 min: [INVARIANT] INV-014 armmmkr packed at (288, 752) with no turret slot within 450
- forbid 'invariant' hit at 32.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 32.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 32.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 33.0 min: [INVARIANT] INV-014 cormmkr packed at (15008, 1648) with no turret slot within 450
- forbid 'invariant' hit at 33.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 33.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-022 a new set of cormmkr starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.0 min: [INVARIANT] INV-060 coast cluster #5 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 34.1 min: [INVARIANT] INV-014 armmmkr packed at (304, 1408) with no turret slot within 450
- forbid 'invariant' hit at 34.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 34.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 34.9 min: [INVARIANT] INV-022 a new set of cormmkr starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-060 coast cluster #5 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-052 ferry run for cargo 30393 unloading for 16 s
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-014 cormmkr packed at (14960, 1776) with no turret slot within 450
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-022 a new set of armmmkr starts 13 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 35.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 35.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-060 coast cluster #5 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.2 min: [INVARIANT] INV-014 cormmkr packed at (15088, 1776) with no turret slot within 450
- forbid 'invariant' hit at 36.2 min: [INVARIANT] INV-022 a new set of cormmkr starts 16 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 36.4 min: [INVARIANT] INV-014 corafus packed at (15040, 1504) with no turret slot within 450
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 31662 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 36.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-060 coast cluster #5 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 2491 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 24251 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 993 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 18280 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 37.8 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 8 has 543 free
- forbid 'invariant' hit at 37.9 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 10 has 183 free
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-060 coast cluster #5 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 889 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-014 corafus packed at (15040, 1504) with no turret slot within 450
- forbid 'invariant' hit at 38.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 38.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-060 coast cluster #5 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-016 the advanced lab 8296 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 524 elmos away, not flush (160)
- forbid 'invariant' hit at 39.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (13 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-060 coast cluster #5 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 25056 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 2048 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 30770 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 18280 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 2179 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 993 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 24251 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 31662 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 20354 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 19726 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 12204 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 4494 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 2491 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 30011 has done nothing for 60 s (task type 2, last rule wait)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261004T232447Z-ed07c75f\runs\20261004T234203Z-870e40cb\screen_2026-10-04_23-27-09-860.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261004T232447Z-ed07c75f\runs\20261004T234203Z-870e40cb\screen_2026-10-04_23-32-41-619.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261004T232447Z-ed07c75f\runs\20261004T234203Z-870e40cb\screen_2026-10-04_23-36-01-094.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261004T232447Z-ed07c75f\runs\20261004T234203Z-870e40cb\screen_2026-10-04_23-41-50-731.png

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
  0.28  [Team][Roster] first mex 27188 at 784,1792
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|601|1753|0|1|1|784|1792
  0.28  [AIR][Rule] opening.mex builder=31863
  0.32  [Team][Roster] team 6 first mex at 1568,1952
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=987 E=30 bank=993 pull=3 plants=0/0 aircraftDemand=0/0
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
  1.09  [AIR][Wind] cluster=0 slots=6 at=496,2120 local=false builder=31863
  1.09  [AIR][Rule] opening.energy builder=31863
  1.10  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=4 bank=1039 E=30 bank=988 pull=3 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=1 committed=40/175
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=4 bank=1039 E=30 bank=968 pull=3 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=1 committed=40/175
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.35  [Playtest] finished armwin team 0 at 1.35 min
  1.43  [AIR][Capacity] own=4/30 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=4 bank=1017 E=30 bank=964 pull=35 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=10/47
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.46  [Playtest] finished armwin team 0 at 1.46 min
  1.56  [Playtest] finished armwin team 0 at 1.56 min
  1.60  [AIR][Capacity] own=4/44 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=4 bank=1000 E=45 bank=983 pull=3 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=33/144
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.67  [Playtest] finished armwin team 0 at 1.67 min
  1.77  [AIR][Capacity] own=4/67 usage=3/18 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=4 bank=997 E=68 bank=956 pull=18 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=29/127
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.83  [Playtest] finished armwin team 0 at 1.83 min
  1.93  [AIR][Capacity] own=4/78 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=4 bank=990 E=78 bank=1001 pull=35 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=21/95
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.98  [Playtest] finished armwin team 0 at 1.98 min
  2.00  [AIR][Starter] nearby distance=128
  2.00  [AIR][Rule] opening.plant builder=31863
  2.00  [AIR][EcoLayout] reserved air.eco.0 reactor=848,2144 converters=8 support=12 zone=30
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.0 bank 982/1050, energy +127.8 bank 1003/1003, units 8
  2.02  [AIR][EcoLayout] reserved air.eco.1 reactor=336,352 converters=8 support=12 zone=56
  2.03  [AIR][EcoLayout] reserved air.eco.2 reactor=1104,2656 converters=8 support=0 zone=90
  2.05  [AIR][EcoLayout] reserved air.eco.3 reactor=1360,1632 converters=8 support=12 zone=116
  2.10  [AIR][Capacity] own=4/112 usage=35/63 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=4 bank=834 E=106 bank=1000 pull=63 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=446/754
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=8856 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=4/136 usage=35/63 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=4 bank=524 E=136 bank=994 pull=63 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=88/149
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=8856 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.31  [Playtest] finished armap team 0 at 2.31 min
  2.32  [AIR][Claim] cancel unowned native order armnanotc
  2.32  [AIR][Claim] cancel unowned native order armnanotc
  2.32  [AIR][State] T1_CONTEST
  2.32  [AIR][Produce] opening.scout armpeep plant=8856 projected=1/1
  2.32  [AIR][Rule] opening.commander.guard builder=31863
  2.43  [AIR][Capacity] own=4/123 usage=8/252 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=4 bank=401 E=127 bank=514 pull=252 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=8856 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.44  [AIR][Produce] constructor.recovery armca plant=8856 projected=1/3
  2.44  [AIR][Scout] opening drone=24784 enemy starts=8
  2.60  [AIR][Capacity] own=4/117 usage=0/3 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=4 bank=366 E=117 bank=982 pull=191 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=8856 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.65  [AIR][Produce] constructor.recovery armca plant=8856 projected=2/3
  2.65  [AIR][Rule] mex.expand builder=28045
  2.77  [AIR][Capacity] own=4/115 usage=0/3 gifts=1 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=5 bank=338 E=116 bank=1116 pull=191 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=8856 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.87  [AIR][Produce] constructor.recovery armca plant=8856 projected=3/3
  2.87  [AIR][Rule] mex.expand builder=13108
  2.93  [AIR][Capacity] own=4/118 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST M=4 bank=300 E=118 bank=1141 pull=187 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=8856 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.0 bank 277/1150, energy +146.6 bank 1088/1153, units 12
  3.00  [Playtest] speed 1 at 3.00 min
  3.08  [AIR][Produce] opening.screen armfig plant=8856 projected=1/6
  3.08  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=114 at=744,1944
  3.08  [AIR][Rule] opening.support builder=28538
  3.10  [AIR][Capacity] own=4/140 usage=0/40 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST M=4 bank=270 E=138 bank=1178 pull=40 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=230/3200
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=8856 BP=150 nanos=0+0/2 available=yes firstSlot=2
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.10  [AIR][Rule] commander.factory.guard builder=31863
  3.14  [AIR][Rule] opening.support.assist builder=28045
  3.16  [AIR][Rule] opening.support.assist builder=13108
  3.20  [AIR][Commander] cleared factory guard for opening.support.assist
  3.20  [AIR][Rule] opening.support.assist builder=31863
  3.27  [AIR][Capacity] own=4/151 usage=3/127 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST M=5 bank=180 E=149 bank=1166 pull=398 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=128/1785
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=8856 BP=150 nanos=0+1/2 available=yes firstSlot=2
  3.29  [AIR][Produce] opening.screen armfig plant=8856 projected=2/6
  3.29  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.33  [AIR][Layout] cluster=0 labs=1 at=1825,2305
  3.35  [AIR][Layout] cluster=1 labs=1 at=1921,2113
  3.37  [AIR][Layout] cluster=2 labs=1 at=1921,2689
  3.38  [Playtest] finished armnanotc team 0 at 3.38 min
  3.38  [AIR][Layout] cluster=3 labs=1 at=2017,961
  3.39  [AIR][Rule] mex.expand builder=13108
  3.39  [AIR][Rule] mex.expand builder=28538
  3.40  [AIR][Rule] mex.expand builder=28045
  3.40  [AIR][Rule] commander.factory.guard builder=31863
  3.43  [AIR][Capacity] own=4/144 usage=7/292 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST M=4 bank=47 E=146 bank=1166 pull=292 plants=1/0 aircraftDemand=9/290
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+0/2 available=yes firstSlot=3
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.47  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.49  [AIR][Produce] opening.screen armfig plant=8856 projected=3/6
  3.60  [AIR][Capacity] own=4/144 usage=9/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST M=4 bank=7 E=144 bank=961 pull=375 plants=1/0 aircraftDemand=9/290
  3.60  [AIR][Projects] energyQueued=0 committed=0/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+0/2 available=yes firstSlot=3
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.63  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.64  [AIR][Produce] opening.screen armfig plant=8856 projected=4/6
  3.77  [AIR][Capacity] own=4/145 usage=10/403 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST M=6 bank=11 E=144 bank=1166 pull=403 plants=1/0 aircraftDemand=9/290
  3.77  [AIR][Projects] energyQueued=0 committed=0/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+0/2 available=yes firstSlot=3
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [Playtest] camera requested (680,2016) height=2200
  3.80  [Playtest] camera captured name=ta position=(680,2016) height=2200
  3.80  [Playtest] screenshot at 3.8 min of team 0 at (680, 2016)
  3.81  [AIR][Produce] opening.screen armfig plant=8856 projected=5/6
  3.81  [AIR][Screen] fighters=4 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.90  [AIR][Layout] cluster=4 labs=1 at=193,1921
  3.92  [AIR][Layout] cluster=5 labs=1 at=1537,481
  3.93  [AIR][Layout] cluster=6 labs=1 at=1729,865
  3.93  [AIR][Capacity] own=4/148 usage=3/135 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST M=5 bank=3 E=148 bank=1166 pull=135 plants=1/0 aircraftDemand=9/290
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+0/2 available=yes firstSlot=3
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.98  [AIR][Screen] fighters=4 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.0 bank 3/1150, energy +152.0 bank 1143/1178, units 18
  4.00  [Playtest] speed 4 at 4.00 min
  4.04  [AIR][Produce] opening.screen armfig plant=8856 projected=6/6
  4.10  [AIR][Capacity] own=4/149 usage=10/403 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST M=4 bank=11 E=148 bank=1021 pull=403 plants=1/0 aircraftDemand=9/290
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.15  [AIR][Screen] fighters=5 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.27  [AIR][Capacity] own=4/140 usage=0/3 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST M=6 bank=28 E=142 bank=1166 pull=3 plants=1/0 aircraftDemand=9/290
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.29  [AIR][Wind] cluster=1 slots=6 at=1024,1832 local=false builder=31863
  4.29  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.29  [AIR][Rule] commander.idle.energy builder=31863
  4.32  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.43  [AIR][Capacity] own=4/157 usage=0/3 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=6 bank=96 E=175 bank=1178 pull=3 plants=1/0 aircraftDemand=9/290
  4.43  [AIR][Projects] energyQueued=1 committed=40/175
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.45  [AIR][Produce] recon.replace armpeep plant=8856 projected=1/1
  4.48  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.52  [Playtest] finished armwin team 0 at 4.52 min
  4.54  [AIR][Rule] commander.factory.guard builder=31863
  4.59  [AIR][Scout] opening drone=31521 enemy starts=8
  4.60  [AIR][Capacity] own=4/131 usage=6/199 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=6 bank=71 E=142 bank=1117 pull=199 plants=1/0 aircraftDemand=9/290
  4.60  [AIR][Projects] energyQueued=0 committed=0/0
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.64  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.64  [AIR][Rule] commander.idle.energy builder=31863
  4.65  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.68  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=284 at=616,1944
  4.68  [AIR][Rule] opening.support builder=28538
  4.68  [AIR][Rule] commander.idle.assist builder=31863
  4.68  [AIR][Rule] opening.support.assist builder=13108
  4.69  [AIR][Rule] opening.support.assist builder=28045
  4.77  [AIR][Capacity] own=4/105 usage=0/0 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=6 bank=110 E=108 bank=1133 pull=93 plants=1/0 aircraftDemand=9/290
  4.77  [AIR][Projects] energyQueued=0 committed=191/2669
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+1/2 available=yes firstSlot=3
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Naval] theatre=0:3:1 enemy=1090 friendly=750 subs=0 antiSub=0 deficit=340
  4.82  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.93  [AIR][Capacity] own=4/92 usage=0/4 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST M=6 bank=2 E=95 bank=882 pull=274 plants=1/0 aircraftDemand=9/290
  4.93  [AIR][Projects] energyQueued=0 committed=26/367
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=8856 BP=350 nanos=1+1/2 available=yes firstSlot=3
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.98  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.0 bank 0/1150, energy +88.7 bank 1082/1178, units 22
  5.00  [Playtest] finished armnanotc team 0 at 5.00 min
  5.01  [AIR][Rule] mex.expand builder=13108
  5.02  [AIR][Rule] mex.expand builder=28538
  5.02  [AIR][Rule] mex.expand builder=28045
  5.03  [AIR][Rule] commander.idle.wait builder=31863
  5.06  [AIR][Rule] commander.idle.energy builder=31863
  5.10  [AIR][Capacity] own=4/88 usage=0/3 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=6 bank=35 E=89 bank=1142 pull=3 plants=1/0 aircraftDemand=14/447
  5.10  [AIR][Projects] energyQueued=1 committed=40/175
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
... 3702 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(31863) at (601, 1754) walks to (651, 1764), 136 from the armmex site (784, 1792)
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
  0.09  EXP: approach: legcom(15365) at (14751, 1701) walks to (14593, 1486), 137 from the legmex site (14512, 1376)
  0.17  RESERVE: armlab at (1968, 688) facing 1 (id 72)
  0.17  RESERVE: zone 14 at (1896, 688) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 816) facing 1 (id 73)
  0.17  RESERVE: zone 14 at (1896, 816) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 560) facing 1 (id 74)
  0.17  RESERVE: zone 14 at (1896, 560) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (3968, 1456) facing 1 (id 75)
  0.17  RESERVE: zone 14 at (3896, 1456) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 1456) facing 1: 2 of 2 slots (group 10, zone)
  0.17  EXP: approach: corcom(22513) at (14799, 731) walks to (14663, 456), 139 from the cormex site (14544, 384)
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
  0.28  EXP: approach: armcom(31863) at (716, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
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
  0.37  EXP: approach: legcom(15365) at (14551, 1429) walks to (15079, 1412), 137 from the legmex site (15216, 1408)
  0.38  EXP: approach: armcom(31863) at (716, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.38  EXP: approach: legcom(15365) at (14550, 1428) walks to (14807, 1836), 137 from the legmex site (14880, 1952)
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
  0.43  EXP: approach: corcom(22513) at (14637, 509) walks to (15107, 284), 139 from the cormex site (15232, 224)
  0.44  EXP: approach: armcom(4222) at (707, 1034) walks to (892, 355), 136 from the armmex site (928, 224)
  0.48  EXP: approach: armcom(31863) at (716, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.49  EXP: approach: armcom(31863) at (716, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.50  RESERVE: armlab at (1968, 688) facing 1 (id 82)
```
