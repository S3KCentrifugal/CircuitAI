# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 40.0 min (frame 72000); wall 878 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (d28b4dcb6a319109); AI BARbTest/test; staged 2026-10-04T19:02:38
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=TACTICAL/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=TECH/cortex/test, 9=AIR/legion/test, 10=TACTICAL/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: skirmish_cpu_clean.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-clean-control\shore-to-shore\20261004T220237Z-921ca60b\runs\20261004T222147Z-3387c795\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:46.218461][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `=1.000 speed_actual=1.000 ai_n=1800 ai_mean_ms=0.000000 ai_p50_ms=0.000000 ai_p95_ms=0.000000 ai_p99_ms=0.000000 ai_max_ms=0.000000 fps_n=61 fps_p10=268.000 fps_p50=284.000 fps_p90=296.000 profiling=0` |
| expect `commands` | seen at 1.0 min | `[t=00:00:58.721653][f=0001800] [AirOrders] frame=1800 team=0 all_apm=88 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 5.7 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1860 (7 by power), bank 1 + 17/s (0 by metal))
- forbid 'invariant' hit at 6.7 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1860 (7 by power), bank 4 + 13/s (0 by metal))
- forbid 'invariant' hit at 12.2 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of coralab 23732 are not on it
- forbid 'invariant' hit at 12.3 min: [INVARIANT] INV-001 a retiring factory produced corack 24008
- forbid 'invariant' hit at 12.5 min: [INVARIANT] INV-019 4 turret frames under construction, 1 allowed (build power 2940 (11 by power), bank 2 + 34/s (0 by metal))
- forbid 'invariant' hit at 15.4 min: [INVARIANT] INV-008 13 turret(s) in range of the reclaim of corwin 10868 are not on it
- forbid 'invariant' hit at 18.1 min: [INVARIANT] INV-019 4 turret frames under construction, 1 allowed (build power 4260 (16 by power), bank 10 + 35/s (0 by metal))
- forbid 'invariant' hit at 23.5 min: [INVARIANT] INV-009 a corafus frame appeared while energy floats (bank 18628 of 18800 full for 161 s, +508 over the pull): converters first
- forbid 'invariant' hit at 24.7 min: [INVARIANT] INV-019 4 turret frames under construction, 1 allowed (build power 5220 (19 by power), bank 81 + 62/s (0 by metal))
- forbid 'invariant' hit at 32.2 min: [INVARIANT] INV-022 a new set of cormmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.3 min: [INVARIANT] INV-029 corap 2427 stands 6 cells from the turrets, not tight
- forbid 'invariant' hit at 32.5 min: [INVARIANT] INV-029 coraap 23280 stands 10 cells from the turrets, not tight
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-022 a new set of cormmkr starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.8 min: [INVARIANT] INV-014 cormmkr packed at (14976, 1728) with no turret slot within 450
- forbid 'invariant' hit at 35.4 min: [INVARIANT] INV-039 T1 land constructors released 180 s, 0 spam labs of 2 wanted, no forward order for 180 s
- forbid 'invariant' hit at 36.2 min: [INVARIANT] INV-014 corafus packed at (14992, 1648) with no turret slot within 450
- forbid 'invariant' hit at 36.3 min: [INVARIANT] INV-014 cormmkr packed at (15056, 1280) with no turret slot within 450
- forbid 'invariant' hit at 36.3 min: [INVARIANT] INV-022 a new set of cormmkr starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-014 cormmkr packed at (15008, 1216) with no turret slot within 450
- forbid 'invariant' hit at 38.3 min: [INVARIANT] INV-022 a new set of cormmkr starts 13 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-039 T1 land constructors released 360 s, 0 spam labs of 4 wanted, no forward order for 180 s
- forbid 'invariant' hit at 39.1 min: [INVARIANT] INV-014 cormmkr packed at (14992, 848) with no turret slot within 450
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-014 corafus packed at (15024, 1008) with no turret slot within 450

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-clean-control\shore-to-shore\20261004T220237Z-921ca60b\runs\20261004T222147Z-3387c795\screen_2026-10-04_22-05-01-378.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-clean-control\shore-to-shore\20261004T220237Z-921ca60b\runs\20261004T222147Z-3387c795\screen_2026-10-04_22-12-02-061.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-clean-control\shore-to-shore\20261004T220237Z-921ca60b\runs\20261004T222147Z-3387c795\screen_2026-10-04_22-17-32-971.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-clean-control\shore-to-shore\20261004T220237Z-921ca60b\runs\20261004T222147Z-3387c795\screen_2026-10-04_22-21-34-344.png

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
  0.28  [Team][Roster] first mex 15823 at 784,1792
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|601|1753|0|1|1|784|1792
  0.28  [AIR][Rule] opening.mex builder=27232
  0.32  [Team][Roster] team 6 first mex at 1568,1952
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=987 E=30 bank=977 pull=3 plants=0/0 aircraftDemand=0/0
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
  1.07  [AIR][Wind] cluster=0 slots=6 at=496,2120 local=false builder=27232
  1.07  [AIR][Rule] opening.energy builder=27232
  1.10  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=4 bank=1039 E=30 bank=985 pull=3 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=1 committed=40/175
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Capacity] own=4/30 usage=7/33 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=4 bank=1036 E=30 bank=950 pull=33 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=1 committed=40/175
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.32  [Playtest] finished armwin team 0 at 1.32 min
  1.43  [Playtest] finished armwin team 0 at 1.43 min
  1.43  [AIR][Capacity] own=4/30 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=4 bank=1010 E=30 bank=964 pull=35 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.54  [Playtest] finished armwin team 0 at 1.54 min
  1.60  [AIR][Capacity] own=4/40 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=4 bank=994 E=40 bank=956 pull=35 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=21/95
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.65  [Playtest] finished armwin team 0 at 1.65 min
  1.77  [AIR][Capacity] own=4/36 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=4 bank=991 E=39 bank=960 pull=35 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=18/78
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.81  [Playtest] finished armwin team 0 at 1.81 min
  1.93  [AIR][Capacity] own=4/45 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=4 bank=980 E=43 bank=961 pull=35 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=6/29
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.95  [Playtest] finished armwin team 0 at 1.95 min
  1.96  [AIR][Starter] nearby distance=128
  1.96  [AIR][Rule] opening.plant builder=27232
  1.97  [AIR][EcoLayout] reserved air.eco.0 reactor=848,2144 converters=8 support=12 zone=32
  1.98  [AIR][EcoLayout] reserved air.eco.1 reactor=336,352 converters=8 support=12 zone=60
  2.00  [AIR][EcoLayout] reserved air.eco.2 reactor=1104,2656 converters=8 support=0 zone=96
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.0 bank 926/1050, energy +105.6 bank 996/1003, units 9
  2.02  [AIR][EcoLayout] reserved air.eco.3 reactor=1360,1632 converters=8 support=12 zone=122
  2.10  [AIR][Capacity] own=4/84 usage=35/63 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=4 bank=769 E=75 bank=952 pull=63 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=374/633
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=10128 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=4/112 usage=35/63 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=4 bank=459 E=109 bank=1000 pull=63 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=16/28
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=10128 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [Playtest] finished armap team 0 at 2.27 min
  2.28  [AIR][Claim] cancel unowned native order armnanotc
  2.28  [AIR][Claim] cancel unowned native order armnanotc
  2.28  [AIR][State] T1_CONTEST
  2.29  [AIR][Produce] opening.scout armpeep plant=10128 projected=1/1
  2.29  [AIR][Rule] opening.commander.guard builder=27232
  2.41  [AIR][Produce] constructor.recovery armca plant=10128 projected=1/3
  2.41  [AIR][Scout] opening drone=28389 enemy starts=8
  2.43  [AIR][Capacity] own=4/130 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=4 bank=402 E=131 bank=540 pull=21 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=4/127 usage=0/0 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=364 E=127 bank=122 pull=97 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.65  [AIR][Produce] constructor.recovery armca plant=10128 projected=2/3
  2.65  [AIR][Rule] recovery.energy builder=5261
  2.77  [AIR][Capacity] own=4/129 usage=2/3 gifts=1 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=49 shortage=0 reason=available or arriving power
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=330 E=128 bank=480 pull=191 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=139/0
  2.77  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.86  [AIR][Produce] constructor.recovery armca plant=10128 projected=3/3
  2.86  [AIR][Rule] recovery.assist builder=6542
  2.93  [AIR][Capacity] own=4/142 usage=5/3 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST M=4 bank=255 E=142 bank=1141 pull=191 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=103/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.0 bank 205/1150, energy +148.0 bank 1088/1153, units 14
  3.00  [Playtest] speed 1 at 3.00 min
  3.06  [AIR][Produce] opening.screen armfig plant=10128 projected=1/6
  3.07  [AIR][Rule] commander.factory.guard builder=27232
  3.07  [AIR][Rule] mex.expand builder=25202
  3.10  [AIR][Capacity] own=4/146 usage=12/259 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST M=4 bank=169 E=147 bank=1166 pull=259 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=44/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.21  [AIR][Produce] opening.screen armfig plant=10128 projected=2/6
  3.21  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.22  [Playtest] finished armsolar team 0 at 3.22 min
  3.23  [AIR][Claim] cancel unowned native order armmakr
  3.24  [AIR][Rule] mex.expand builder=5261
  3.24  [AIR][Rule] mex.expand builder=6542
  3.27  [AIR][Capacity] own=4/130 usage=9/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST M=5 bank=97 E=133 bank=1048 pull=375 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.36  [AIR][Wind] cluster=1 slots=6 at=912,2376 local=false builder=27232
  3.36  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.36  [AIR][Rule] commander.idle.energy builder=27232
  3.37  [AIR][Produce] opening.screen armfig plant=10128 projected=3/6
  3.40  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.43  [AIR][Capacity] own=4/136 usage=3/127 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST M=4 bank=81 E=139 bank=1215 pull=127 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=1 committed=40/175
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.47  [AIR][Layout] cluster=0 labs=1 at=1825,2305
  3.48  [AIR][Layout] cluster=1 labs=1 at=1921,2113
  3.57  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=4/130 usage=10/160 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST M=4 bank=102 E=131 bank=1203 pull=160 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=1 committed=40/175
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.63  [Playtest] finished armwin team 0 at 3.63 min
  3.65  [AIR][Rule] commander.energy.local builder=27232
  3.73  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.74  [Playtest] finished armwin team 0 at 3.74 min
  3.77  [AIR][Capacity] own=4/135 usage=5/138 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST M=6 bank=74 E=132 bank=1224 pull=138 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=36/159
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Produce] opening.screen armfig plant=10128 projected=4/6
  3.80  [Playtest] target team 0 at (550, 1740) from its start position
  3.80  [Playtest] camera requested (680,2016) height=2200
  3.80  [Playtest] camera captured name=ta position=(680,2016) height=2200
  3.80  [Playtest] screenshot at 3.8 min of team 0 at (680, 2016)
  3.83  [AIR][Layout] cluster=2 labs=1 at=1537,865
  3.85  [Playtest] finished armwin team 0 at 3.85 min
  3.85  [AIR][Layout] cluster=3 labs=1 at=1729,961
  3.86  [AIR][Rule] commander.factory.guard builder=27232
  3.92  [AIR][Screen] fighters=3 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=4/180 usage=3/127 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST M=5 bank=59 E=177 bank=1217 pull=127 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.0 bank 53/1150, energy +185.8 bank 1024/1229, units 20
  4.00  [Playtest] speed 4 at 4.00 min
  4.03  [AIR][Produce] opening.screen armfig plant=10128 projected=5/6
  4.10  [AIR][Capacity] own=4/185 usage=9/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST M=4 bank=56 E=185 bank=1200 pull=375 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Screen] fighters=4 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.19  [AIR][Produce] opening.screen armfig plant=10128 projected=6/6
  4.27  [AIR][Capacity] own=4/194 usage=9/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST M=6 bank=46 E=189 bank=999 pull=375 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Naval] theatre=0:5:0 enemy=1420 friendly=420 subs=580 antiSub=0 deficit=1000
  4.27  [AIR][Screen] fighters=5 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.34  [AIR][Produce] intercept armfig plant=10128 projected=7/7
  4.37  [AIR][Layout] cluster=4 labs=1 at=1441,2881
  4.43  [AIR][Capacity] own=4/223 usage=9/375 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=6 bank=32 E=223 bank=1132 pull=375 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.49  [AIR][Produce] recon.replace armpeep plant=10128 projected=1/1
  4.60  [AIR][Capacity] own=4/220 usage=8/252 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=6 bank=29 E=223 bank=1197 pull=252 plants=1/0 aircraftDemand=3/127
  4.60  [AIR][Projects] energyQueued=0 committed=0/0
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.62  [AIR][Produce] air.control armfig plant=10128 projected=8/8
  4.62  [AIR][Scout] opening drone=8853 enemy starts=8
  4.63  [AIR][Screen] fighters=7 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.77  [AIR][Capacity] own=4/199 usage=8/334 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=6 bank=16 E=201 bank=532 pull=334 plants=1/0 aircraftDemand=3/127
  4.77  [AIR][Projects] energyQueued=0 committed=0/0
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Produce] air.control armfig plant=10128 projected=9/9
  4.82  [AIR][Screen] fighters=8 cells=8 centre=1544,744 width=1200 advance=994 responding=false
  4.93  [AIR][Capacity] own=4/199 usage=7/288 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=3 E=199 bank=215 pull=288 plants=1/0 aircraftDemand=3/127
  4.93  [AIR][Projects] energyQueued=0 committed=0/0
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.93  [AIR][Rule] commander.idle.wait builder=27232
  5.00  [AIR][Screen] fighters=9 cells=8 centre=1544,744 width=1200 advance=994 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.0 bank 33/1150, energy +225.2 bank 1229/1229, units 26
  5.10  [AIR][Capacity] own=4/218 usage=0/3 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=69 E=213 bank=1176 pull=3 plants=1/0 aircraftDemand=3/127
  5.10  [AIR][Projects] energyQueued=0 committed=0/0
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=9 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.12  [AIR][Rule] commander.idle.energy builder=27232
  5.17  [AIR][Screen] fighters=9 cells=8 centre=1544,744 width=1200 advance=994 responding=false
  5.17  [AIR][Produce] air.control armfig plant=10128 projected=10/10
  5.20  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=238 at=744,1944
  5.20  [AIR][Rule] opening.support builder=5261
  5.21  [AIR][Rule] opening.support.assist builder=6542
  5.23  [AIR][Rule] opening.support.assist builder=25202
  5.27  [AIR][Capacity] own=4/226 usage=1/105 gifts=2 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=136 shortage=0 reason=no funded workload
  5.27  [AIR][Economy] T1_CONTEST M=6 bank=109 E=226 bank=1184 pull=187 plants=1/0 aircraftDemand=3/127
  5.27  [AIR][Projects] energyQueued=0 committed=250/3141
  5.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.33  [AIR][Screen] fighters=9 cells=8 centre=1544,744 width=1200 advance=994 responding=false
  5.35  [Playtest] finished armwin team 0 at 5.35 min
  5.36  [AIR][Rule] commander.energy.local builder=27232
  5.43  [AIR][Capacity] own=4/226 usage=10/160 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  5.43  [AIR][Economy] T1_CONTEST M=6 bank=15 E=226 bank=1221 pull=250 plants=1/0 aircraftDemand=3/127
  5.43  [AIR][Projects] energyQueued=0 committed=159/2120
  5.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=10128 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 1974 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(27232) at (601, 1754) walks to (651, 1764), 136 from the armmex site (784, 1792)
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
  0.09  EXP: approach: legcom(5300) at (14750, 1700) walks to (14593, 1486), 137 from the legmex site (14512, 1376)
  0.17  RESERVE: armlab at (1968, 688) facing 1 (id 72)
  0.17  RESERVE: zone 14 at (1896, 688) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 816) facing 1 (id 73)
  0.17  RESERVE: zone 14 at (1896, 816) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 560) facing 1 (id 74)
  0.17  RESERVE: zone 14 at (1896, 560) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (3968, 1456) facing 1 (id 75)
  0.17  RESERVE: zone 14 at (3896, 1456) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 1456) facing 1: 2 of 2 slots (group 10, zone)
  0.17  EXP: approach: corcom(17339) at (14799, 731) walks to (14663, 456), 139 from the cormex site (14544, 384)
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
  0.28  EXP: approach: armcom(27232) at (715, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
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
  0.37  EXP: approach: legcom(5300) at (14551, 1429) walks to (15079, 1412), 137 from the legmex site (15216, 1408)
  0.38  EXP: approach: armcom(27232) at (716, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.38  EXP: approach: legcom(5300) at (14550, 1428) walks to (14807, 1836), 137 from the legmex site (14880, 1952)
  0.40  EXP: approach: armcom(27232) at (716, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.41  EXP: approach: armcom(27232) at (716, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
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
  0.42  EXP: approach: armcom(27232) at (716, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.43  EXP: approach: corcom(17339) at (14637, 509) walks to (15107, 284), 139 from the cormex site (15232, 224)
  0.44  EXP: approach: armcom(27232) at (716, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
```
