# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 45.0 min (frame 81015); wall 826 s
- DLL: build-theatres\d199\build-6\SkirmishAI.dll (1eb777348e1d5f78); AI BARbTest/test; staged 2026-10-04T23:19:52
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=TACTICAL/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=TECH/cortex/test, 9=AIR/legion/test, 10=TACTICAL/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: skirmish_cpu_clean.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-soak\shore-to-shore\20261005T021952Z-fe77c971\runs\20261005T023341Z-a75d9adb\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:47.492400][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `ed=8.000 speed_actual=8.000 ai_n=1800 ai_mean_ms=1.288358 ai_p50_ms=1.001953 ai_p95_ms=3.154297 ai_p99_ms=5.921875 ai_max_ms=10.279297 fps_n=8 fps_p10=41.000 fps_p50=58.000 fps_p90=219.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:00:53.754570][f=0001800] [AirOrders] frame=1800 team=0 all_apm=108 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `game-ended` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 5.3 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 990 (3 by power), bank 2 + 16/s (0 by metal))
- forbid 'invariant' hit at 6.3 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1470 (5 by power), bank 4 + 16/s (0 by metal))
- forbid 'invariant' hit at 11.7 min: [INVARIANT] INV-019 4 turret frames under construction, 1 allowed (build power 2850 (10 by power), bank 41 + 50/s (0 by metal))
- forbid 'invariant' hit at 12.1 min: [INVARIANT] INV-008 4 turret(s) in range of the reclaim of armalab 9744 are not on it
- forbid 'invariant' hit at 23.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-014 armmmkr packed at (320, 1696) with no turret slot within 450
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-039 T1 land constructors released 678 s, 0 spam labs of 3 wanted, no forward order for 180 s
- forbid 'invariant' hit at 30.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.1 min: [INVARIANT] INV-014 armmmkr packed at (352, 1824) with no turret slot within 450
- forbid 'invariant' hit at 31.3 min: [INVARIANT] INV-014 armmmkr packed at (352, 720) with no turret slot within 450
- forbid 'invariant' hit at 32.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 18 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.4 min: [INVARIANT] INV-014 armmmkr packed at (304, 1600) with no turret slot within 450
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-039 T1 land constructors released 858 s, 0 spam labs of 5 wanted, no forward order for 180 s
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-014 armafus packed at (272, 800) with no turret slot within 450
- forbid 'invariant' hit at 34.8 min: [INVARIANT] INV-004 metal floating at 9692 of 9700 for 60 s while armmmkr is under construction and static build power 8400 is under 11976
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 6349 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 24832 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-039 T1 land constructors released 1038 s, 0 spam labs of 6 wanted, no forward order for 180 s
- forbid 'invariant' hit at 35.8 min: [INVARIANT] INV-004 metal floating at 9691 of 9700 for 60 s while armmmkr is under construction and static build power 8400 is under 12027
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 2104 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 7737 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 22681 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 17230 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 1648 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 36.6 min: [INVARIANT] INV-039 T2 land constructors released 1032 s, 1 mex cluster(s) without long-range AA, no defence order for 180 s
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-039 T2 land constructors released 1213 s, 1 mex cluster(s) without long-range AA, no defence order for 180 s
- forbid 'invariant' hit at 42.6 min: [INVARIANT] INV-039 T2 land constructors released 1393 s, 1 mex cluster(s) without long-range AA, no defence order for 180 s

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-soak\shore-to-shore\20261005T021952Z-fe77c971\runs\20261005T023341Z-a75d9adb\screen_2026-10-05_02-21-12-047.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-soak\shore-to-shore\20261005T021952Z-fe77c971\runs\20261005T023341Z-a75d9adb\screen_2026-10-05_02-23-32-857.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-soak\shore-to-shore\20261005T021952Z-fe77c971\runs\20261005T023341Z-a75d9adb\screen_2026-10-05_02-25-37-950.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\reservation-soak\shore-to-shore\20261005T021952Z-fe77c971\runs\20261005T023341Z-a75d9adb\screen_2026-10-05_02-28-28-407.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 8, 4 shots, end at 45.5 min
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
  0.00  [Playtest] speed 8
  0.00  [Playtest] speed 8 at 0.00 min
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
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=961 E=18 bank=718 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.28  [Team][Roster] first mex 31623 at 784,1792
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|601|1753|0|1|1|784|1792
  0.28  [AIR][Rule] opening.mex builder=26675
  0.32  [Team][Roster] team 6 first mex at 1568,1952
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=987 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=1029 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
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
  1.03  [AIR][Starter] nearby distance=160
  1.03  [AIR][Rule] opening.plant builder=26675
  1.03  [AIR][EcoLayout] reserved air.eco.0 reactor=336,2144 converters=8 support=12 zone=22
  1.05  [AIR][EcoLayout] reserved air.eco.1 reactor=336,352 converters=8 support=12 zone=52
  1.07  [AIR][EcoLayout] reserved air.eco.2 reactor=1104,2656 converters=8 support=0 zone=88
  1.08  [AIR][EcoLayout] reserved air.eco.3 reactor=1360,1632 converters=8 support=12 zone=119
  1.10  [AIR][Capacity] own=4/30 usage=35/63 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=4 bank=954 E=30 bank=854 pull=63 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=517/875
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.10  [AIR][Bay] 0 plant=15495 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Capacity] own=4/30 usage=35/63 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=4 bank=637 E=30 bank=520 pull=63 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=159/270
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=15495 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.34  [Playtest] finished armap team 0 at 1.34 min
  1.35  [AIR][Claim] cancel unowned native order armnanotc
  1.35  [AIR][Claim] cancel unowned native order armnanotc
  1.35  [AIR][State] T1_CONTEST
  1.35  [AIR][Produce] opening.scout armpeep plant=15495 projected=1/1
  1.35  [AIR][Rule] opening.commander.guard builder=26675
  1.43  [AIR][Capacity] own=3/30 usage=0/29 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=471 E=30 bank=2 pull=177 plants=1/0 aircraftDemand=3/121
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Capacity] own=4/30 usage=1/36 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=512 E=30 bank=0 pull=169 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=4/30 usage=0/30 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=549 E=30 bank=3 pull=102 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Capacity] own=4/30 usage=0/30 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=583 E=30 bank=4 pull=169 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.0 bank 603/1150, energy +30.0 bank 2/1100, units 4
  2.05  [AIR][Produce] constructor.recovery armca plant=15495 projected=1/3
  2.05  [AIR][Scout] opening drone=28549 enemy starts=8
  2.10  [AIR][Capacity] own=4/30 usage=0/0 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=622 E=30 bank=3 pull=128 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=4/30 usage=0/2 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=653 E=30 bank=1 pull=70 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Capacity] own=4/30 usage=0/7 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=678 E=30 bank=0 pull=128 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=4/30 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=701 E=30 bank=0 pull=128 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.76  [AIR][Produce] constructor.recovery armca plant=15495 projected=2/3
  2.76  [AIR][Rule] recovery.energy builder=24328
  2.77  [AIR][Capacity] own=4/30 usage=5/105 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=707 E=30 bank=180 pull=105 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=1 committed=155/0
  2.77  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Capacity] own=4/35 usage=2/3 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=63 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=643 E=31 bank=276 pull=187 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=130/0
  2.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=163 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.97  [AIR][Produce] constructor.recovery armca plant=15495 projected=3/3
  2.97  [AIR][Rule] recovery.energy builder=12847
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.0 bank 616/1150, energy +40.0 bank 847/1150, units 7
  3.10  [AIR][Capacity] own=4/35 usage=5/3 gifts=1 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=0 reason=available or arriving power
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=573 E=35 bank=1142 pull=191 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=245/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.19  [AIR][Produce] opening.screen armfig plant=15495 projected=1/6
  3.19  [AIR][Rule] mex.expand builder=22883
  3.21  [AIR][Rule] commander.factory.guard builder=26675
  3.27  [AIR][Capacity] own=4/40 usage=15/375 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST M=5 bank=488 E=40 bank=960 pull=375 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=185/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.35  [AIR][Produce] opening.screen armfig plant=15495 projected=2/6
  3.35  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.37  [AIR][Layout] cluster=0 labs=1 at=865,2593
  3.38  [AIR][Layout] cluster=1 labs=1 at=1825,2305
  3.40  [AIR][Layout] cluster=2 labs=1 at=1921,2113
  3.43  [AIR][Capacity] own=4/45 usage=14/350 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST M=4 bank=397 E=45 bank=399 pull=350 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=126/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.50  [AIR][Produce] opening.screen armfig plant=15495 projected=3/6
  3.53  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=4/45 usage=15/375 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST M=4 bank=310 E=45 bank=1034 pull=375 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=66/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.65  [AIR][Produce] opening.screen armfig plant=15495 projected=4/6
  3.66  [Playtest] finished armsolar team 0 at 3.66 min
  3.67  [AIR][Claim] cancel unowned native order armmakr
  3.68  [AIR][Rule] mex.expand builder=24328
  3.70  [AIR][Screen] fighters=3 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=4/45 usage=12/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST M=5 bank=248 E=45 bank=1071 pull=375 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=25/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.80  [AIR][Rule] commander.idle.assist builder=26675
  3.80  [Playtest] camera requested (680,2016) height=2200
  3.80  [Playtest] camera captured name=ta position=(680,2016) height=2200
  3.80  [Playtest] screenshot at 3.8 min of team 0 at (680, 2016)
  3.81  [AIR][Produce] opening.screen armfig plant=15495 projected=5/6
  3.88  [AIR][Screen] fighters=4 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.91  [Playtest] finished armsolar team 0 at 3.91 min
  3.92  [AIR][Claim] cancel unowned native order armmakr
  3.92  [AIR][Layout] cluster=3 labs=1 at=961,1633
  3.92  [AIR][Rule] commander.factory.guard builder=26675
  3.92  [AIR][Rule] mex.expand builder=12847
  3.93  [AIR][Layout] cluster=4 labs=1 at=1537,865
  3.93  [AIR][Capacity] own=4/65 usage=4/127 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST M=5 bank=229 E=65 bank=1231 pull=127 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.0 bank 237/1150, energy +85.0 bank 1209/1275, units 13
  4.05  [AIR][Screen] fighters=4 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.09  [AIR][Produce] opening.screen armfig plant=15495 projected=6/6
  4.10  [AIR][Capacity] own=4/85 usage=4/189 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST M=4 bank=236 E=83 bank=1191 pull=189 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.23  [AIR][Screen] fighters=5 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.27  [AIR][Capacity] own=4/85 usage=1/81 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST M=6 bank=227 E=85 bank=1039 pull=81 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.29  [AIR][Layout] repaired support air.bay.0 viable=2/5 slot=232 at=888,1912
  4.29  [AIR][Rule] opening.support builder=24328
  4.32  [AIR][Wind] cluster=0 slots=6 at=800,2424 local=false builder=26675
  4.32  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.32  [AIR][Rule] commander.idle.energy builder=26675
  4.33  [AIR][Rule] opening.support.assist builder=12847
  4.37  [AIR][Rule] opening.support.assist builder=22883
  4.42  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.43  [AIR][Capacity] own=4/85 usage=0/0 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=6 bank=271 E=85 bank=1254 pull=84 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=1 committed=244/3026
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [AIR][Layout] cluster=5 labs=1 at=1249,2977
  4.47  [AIR][Layout] cluster=6 labs=1 at=193,2593
  4.58  [Playtest] finished armwin team 0 at 4.58 min
  4.58  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.60  [AIR][Rule] commander.energy.local builder=26675
  4.60  [AIR][Capacity] own=4/85 usage=5/28 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=6 bank=229 E=85 bank=1262 pull=119 plants=1/0 aircraftDemand=3/127
  4.60  [AIR][Projects] energyQueued=1 committed=179/2121
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.69  [Playtest] finished armwin team 0 at 4.69 min
  4.75  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.77  [AIR][Capacity] own=4/102 usage=7/35 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=6 bank=168 E=96 bank=1249 pull=126 plants=1/0 aircraftDemand=3/127
  4.77  [AIR][Projects] energyQueued=0 committed=88/1101
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.80  [Playtest] finished armwin team 0 at 4.80 min
  4.89  [Playtest] finished armwin team 0 at 4.89 min
  4.91  [AIR][Rule] commander.idle.energy builder=26675
  4.92  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.93  [AIR][Capacity] own=4/120 usage=0/2 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST M=6 bank=110 E=120 bank=1269 pull=93 plants=1/0 aircraftDemand=3/127
  4.93  [AIR][Projects] energyQueued=0 committed=9/134
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=15495 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.96  [Playtest] finished armnanotc team 0 at 4.96 min
  4.97  [AIR][Rule] mex.expand builder=24328
  4.97  [AIR][Rule] mex.expand builder=22883
  4.98  [AIR][Rule] mex.expand builder=12847
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.0 bank 104/1150, energy +157.0 bank 1274/1277, units 20
  5.04  [Playtest] finished armwin team 0 at 5.04 min
  5.06  [AIR][Rule] commander.energy.local builder=26675
  5.08  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  5.09  [AIR][Layout] repaired support air.bay.0 viable=3/5 slot=274 at=888,1960
  5.09  [AIR][Rule] opening.support builder=22883
  5.09  [AIR][Rule] opening.support.assist builder=24328
  5.10  [AIR][Rule] opening.support.assist builder=12847
  5.10  [AIR][Capacity] own=4/156 usage=7/35 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=6 bank=111 E=151 bank=1264 pull=35 plants=1/0 aircraftDemand=9/290
  5.10  [AIR][Projects] energyQueued=0 committed=254/3300
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=15495 BP=350 nanos=1+1/2 available=yes firstSlot=3
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.15  [Playtest] finished armwin team 0 at 5.15 min
  5.17  [AIR][Rule] commander.idle.assist builder=26675
  5.25  [AIR][Produce] recon.replace armpeep plant=15495 projected=1/1
  5.25  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
... 4446 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(26675) at (601, 1754) walks to (651, 1764), 136 from the armmex site (784, 1792)
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
  0.09  EXP: approach: legcom(24161) at (14750, 1700) walks to (14593, 1486), 137 from the legmex site (14512, 1376)
  0.17  RESERVE: armlab at (1968, 688) facing 1 (id 72)
  0.17  RESERVE: zone 14 at (1896, 688) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 816) facing 1 (id 73)
  0.17  RESERVE: zone 14 at (1896, 816) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 560) facing 1 (id 74)
  0.17  RESERVE: zone 14 at (1896, 560) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (3968, 1456) facing 1 (id 75)
  0.17  RESERVE: zone 14 at (3896, 1456) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 1456) facing 1: 2 of 2 slots (group 10, zone)
  0.17  EXP: approach: corcom(21797) at (14799, 731) walks to (14663, 456), 139 from the cormex site (14544, 384)
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
  0.28  EXP: approach: armcom(26675) at (730, 1781) walks to (420, 1591), 136 from the armmex site (304, 1520)
  0.30  EXP: approach: armcom(26675) at (730, 1781) walks to (420, 1591), 136 from the armmex site (304, 1520)
  0.31  EXP: approach: armcom(26675) at (730, 1781) walks to (420, 1591), 136 from the armmex site (304, 1520)
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
  0.37  EXP: approach: legcom(24161) at (14551, 1429) walks to (15079, 1412), 137 from the legmex site (15216, 1408)
  0.41  EXP: approach: armcom(26675) at (730, 1782) walks to (420, 1591), 136 from the armmex site (304, 1520)
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
  0.43  EXP: approach: corcom(21797) at (14637, 509) walks to (15107, 284), 139 from the cormex site (15232, 224)
  0.44  EXP: approach: armcom(19789) at (707, 1034) walks to (892, 355), 136 from the armmex site (928, 224)
  0.47  EXP: approach: legcom(24161) at (14551, 1429) walks to (14807, 1836), 137 from the legmex site (14880, 1952)
  0.50  RESERVE: armlab at (1968, 688) facing 1 (id 82)
```
