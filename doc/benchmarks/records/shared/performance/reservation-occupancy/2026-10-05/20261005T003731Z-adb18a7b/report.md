# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 40.0 min (frame 72000); wall 906 s
- DLL: build-theatres\d199\baseline\SkirmishAI.dll (585949b1f419e865); AI BARbTest/test; staged 2026-10-04T21:21:40
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=TACTICAL/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=TECH/cortex/test, 9=AIR/legion/test, 10=TACTICAL/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: skirmish_cpu_clean.json; widget loaded: yes
- Log: build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T002140Z-532b954d\runs\20261005T003731Z-adb18a7b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:01:00.571189][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `=1.000 speed_actual=1.000 ai_n=1800 ai_mean_ms=1.286969 ai_p50_ms=1.039063 ai_p95_ms=3.031250 ai_p99_ms=5.998047 ai_max_ms=9.023438 fps_n=60 fps_p10=186.000 fps_p50=212.000 fps_p90=227.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:01:13.611292][f=0001800] [AirOrders] frame=1800 team=0 all_apm=94 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `game-ended` | **hit** | `[t=00:12:33.916595][f=0060037] [SkirmishPerfEnd] frame=60037 winners=1` |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 4.7 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 990 (3 by power), bank 0 + 13/s (0 by metal))
- forbid 'invariant' hit at 5.7 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 990 (3 by power), bank 0 + 9/s (0 by metal))
- forbid 'invariant' hit at 6.7 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 990 (3 by power), bank 0 + 10/s (0 by metal))
- forbid 'invariant' hit at 11.2 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 2670 (10 by power), bank 6 + 40/s (0 by metal))
- forbid 'invariant' hit at 13.2 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of coralab 12152 are not on it
- forbid 'invariant' hit at 15.0 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 15.7 min: [INVARIANT] INV-008 15 turret(s) in range of the reclaim of corwin 19170 are not on it
- forbid 'invariant' hit at 16.7 min: [INVARIANT] INV-008 15 turret(s) in range of the reclaim of corwin 19170 are not on it
- forbid 'invariant' hit at 22.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.8 min: [INVARIANT] INV-035 dedicated 8703 (armmmkr) holds armamb
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.4 min: [INVARIANT] INV-039 T1 land constructors released 512 s, 0 spam labs of 3 wanted, no forward order for 180 s
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-004 metal floating at 9034 of 9100 for 60 s while armmmkr is under construction and static build power 5040 is under 6446
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-011 metal floating at 9034 of 9100 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 28.6 min: [INVARIANT] INV-029 armalab 2865 stands 14 cells from the turrets, not tight
- forbid 'invariant' hit at 28.6 min: [INVARIANT] INV-014 armmmkr packed at (576, 1968) with no turret slot within 450
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-011 metal floating at 500 of 500 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 2 has 131 free
- forbid 'game-ended' hit at 33.4 min: [t=00:12:33.916595][f=0060037] [SkirmishPerfEnd] frame=60037 winners=1

## Screenshots

- build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T002140Z-532b954d\runs\20261005T003731Z-adb18a7b\screen_2026-10-05_00-24-58-686.png
- build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T002140Z-532b954d\runs\20261005T003731Z-adb18a7b\screen_2026-10-05_00-30-29-439.png
- build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T002140Z-532b954d\runs\20261005T003731Z-adb18a7b\screen_2026-10-05_00-33-57-477.png
- build-theatres\games\shared\performance\reservation-occupancy\shore-to-shore\20261005T002140Z-532b954d\runs\20261005T003731Z-adb18a7b\screen_2026-10-05_00-37-18-422.png

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
  0.28  [Team][Roster] first mex 14800 at 784,1792
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|601|1753|0|1|1|784|1792
  0.28  [AIR][Rule] opening.mex builder=14279
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 1043/1050, energy +30.0 bank 980/1000, units 2
  1.08  [AIR][Wind] cluster=0 slots=6 at=608,2136 local=false builder=14279
  1.08  [AIR][Rule] opening.energy builder=14279
  1.10  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=4 bank=1039 E=30 bank=980 pull=3 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=1 committed=40/175
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Capacity] own=4/30 usage=7/33 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=4 bank=1036 E=30 bank=954 pull=33 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=25/112
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.32  [Playtest] finished armwin team 0 at 1.32 min
  1.43  [Playtest] finished armwin team 0 at 1.43 min
  1.43  [AIR][Capacity] own=4/30 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=4 bank=1011 E=30 bank=971 pull=35 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.54  [Playtest] finished armwin team 0 at 1.54 min
  1.60  [AIR][Capacity] own=4/48 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=4 bank=996 E=51 bank=973 pull=35 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=21/95
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.65  [Playtest] finished armwin team 0 at 1.65 min
  1.76  [Playtest] finished armwin team 0 at 1.76 min
  1.77  [AIR][Capacity] own=4/69 usage=7/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=4 bank=971 E=67 bank=953 pull=35 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.86  [Playtest] finished armwin team 0 at 1.86 min
  1.88  [AIR][Starter] nearby distance=128
  1.88  [AIR][Rule] opening.plant builder=14279
  1.88  [AIR][EcoLayout] reserved air.eco.0 reactor=336,352 converters=8 support=12 zone=34
  1.90  [AIR][EcoLayout] reserved air.eco.1 reactor=1104,2656 converters=8 support=0 zone=67
  1.92  [AIR][EcoLayout] reserved air.eco.2 reactor=1360,1632 converters=8 support=12 zone=101
  1.93  [AIR][EcoLayout] reserved air.eco.3 reactor=1360,992 converters=8 support=12 zone=129
  1.93  [AIR][Capacity] own=4/109 usage=35/63 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=4 bank=915 E=105 bank=963 pull=63 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=560/948
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=30055 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.0 bank 759/1050, energy +124.1 bank 996/1003, units 9
  2.10  [AIR][Capacity] own=4/120 usage=35/63 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=4 bank=604 E=122 bank=1000 pull=63 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=202/343
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=30055 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.19  [Playtest] finished armap team 0 at 2.19 min
  2.20  [AIR][Claim] cancel unowned native order armnanotc
  2.20  [AIR][Claim] cancel unowned native order armnanotc
  2.20  [AIR][State] T1_CONTEST
  2.21  [AIR][Produce] opening.scout armpeep plant=30055 projected=1/1
  2.21  [AIR][Rule] opening.commander.guard builder=14279
  2.27  [AIR][Capacity] own=4/109 usage=8/252 gifts=2 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=4 bank=410 E=110 bank=777 pull=252 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.33  [AIR][Produce] constructor.recovery armca plant=30055 projected=1/3
  2.33  [AIR][Scout] opening drone=12999 enemy starts=8
  2.43  [AIR][Capacity] own=4/98 usage=0/0 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=5 bank=391 E=101 bank=466 pull=133 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.54  [AIR][Produce] constructor.recovery armca plant=30055 projected=2/3
  2.54  [AIR][Rule] mex.expand builder=15163
  2.60  [AIR][Capacity] own=4/94 usage=1/28 gifts=2 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=5 bank=366 E=95 bank=505 pull=191 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.76  [AIR][Produce] constructor.recovery armca plant=30055 projected=3/3
  2.76  [AIR][Rule] mex.expand builder=30650
  2.77  [AIR][Capacity] own=4/98 usage=6/135 gifts=2 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=6 bank=342 E=98 bank=1151 pull=135 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Capacity] own=4/106 usage=0/3 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST M=5 bank=310 E=109 bank=936 pull=191 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.97  [AIR][Produce] opening.screen armfig plant=30055 projected=1/6
  2.97  [AIR][Rule] mex.expand builder=21244
  2.99  [AIR][Rule] commander.factory.guard builder=14279
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.0 bank 309/1150, energy +105.8 bank 787/1178, units 13
  3.00  [Playtest] speed 1 at 3.00 min
  3.10  [AIR][Capacity] own=4/102 usage=3/156 gifts=3 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=308 E=104 bank=47 pull=264 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.13  [AIR][Rule] recovery.energy builder=15163
  3.15  [AIR][Rule] recovery.energy builder=30650
  3.20  [AIR][Produce] opening.screen armfig plant=30055 projected=2/6
  3.20  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.26  [AIR][Rule] recovery.assist builder=21244
  3.27  [AIR][Capacity] own=4/94 usage=9/127 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=317 E=98 bank=18 pull=251 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=278/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.37  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.38  [AIR][Layout] cluster=0 labs=1 at=1825,2305
  3.43  [AIR][Capacity] own=4/68 usage=11/94 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=265 E=75 bank=7 pull=251 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=194/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.53  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=4/62 usage=11/85 gifts=3 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=228 E=62 bank=18 pull=243 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=105/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.67  [Playtest] finished armsolar team 0 at 3.66 min
  3.68  [AIR][Rule] mex.expand builder=15163
  3.69  [AIR][Produce] opening.screen armfig plant=30055 projected=3/6
  3.73  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=4/65 usage=9/152 gifts=3 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=208 E=63 bank=34 pull=251 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=41/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.78  [AIR][Rule] recovery.assist builder=15163
  3.80  [Playtest] camera requested (680,2016) height=2200
  3.80  [Playtest] camera captured name=ta position=(680,2016) height=2200
  3.80  [Playtest] screenshot at 3.8 min of team 0 at (680, 2016)
  3.85  [Playtest] finished armsolar team 0 at 3.85 min
  3.86  [AIR][Rule] recovery.energy builder=21244
  3.86  [AIR][Rule] mex.expand builder=15163
  3.87  [AIR][Rule] mex.expand builder=30650
  3.90  [AIR][Layout] cluster=1 labs=1 at=97,1921
  3.90  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.92  [AIR][Layout] cluster=2 labs=1 at=961,1633
  3.93  [AIR][Layout] cluster=3 labs=1 at=1729,961
  3.93  [AIR][Capacity] own=4/117 usage=8/226 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=177 E=113 bank=65 pull=251 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=147/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.95  [AIR][Layout] cluster=4 labs=1 at=1729,1825
  3.96  [AIR][Rule] recovery.assist builder=15163
  3.96  [AIR][Rule] recovery.assist builder=30650
  3.97  [AIR][Produce] opening.screen armfig plant=30055 projected=4/6
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.0 bank 155/1150, energy +190.0 bank 250/1278, units 19
  4.00  [Playtest] speed 4 at 4.00 min
  4.08  [AIR][Screen] fighters=3 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.10  [AIR][Capacity] own=4/178 usage=15/268 gifts=4 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=112 E=167 bank=768 pull=268 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=72/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.12  [AIR][Produce] opening.screen armfig plant=30055 projected=5/6
  4.24  [Playtest] finished armsolar team 0 at 4.24 min
  4.25  [AIR][Rule] mex.expand builder=21244
  4.25  [AIR][Claim] cancel unowned native order armmakr
  4.25  [AIR][Rule] mex.expand builder=15163
  4.26  [AIR][Rule] mex.expand builder=30650
  4.26  [AIR][Wind] cluster=1 slots=6 at=640,2520 local=false builder=14279
  4.26  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.26  [AIR][Rule] commander.idle.energy builder=14279
  4.27  [AIR][Capacity] own=4/192 usage=10/375 gifts=4 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST M=8 bank=32 E=192 bank=1314 pull=375 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=1 committed=40/175
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Screen] fighters=4 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.27  [AIR][Produce] opening.screen armfig plant=30055 projected=6/6
  4.43  [AIR][Capacity] own=4/212 usage=3/127 gifts=3 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=7 bank=80 E=212 bank=1314 pull=127 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=1 committed=40/175
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [AIR][Screen] fighters=5 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.47  [AIR][Layout] cluster=5 labs=1 at=1249,2977
  4.48  [AIR][Layout] cluster=6 labs=1 at=865,2113
  4.60  [AIR][Capacity] own=4/205 usage=3/127 gifts=3 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=7 bank=126 E=210 bank=1314 pull=127 plants=1/0 aircraftDemand=3/127
  4.60  [AIR][Projects] energyQueued=1 committed=40/175
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.62  [AIR][Screen] fighters=5 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.67  [AIR][Produce] intercept armfig plant=30055 projected=7/7
  4.73  [Playtest] finished armwin team 0 at 4.73 min
  4.77  [AIR][Capacity] own=4/175 usage=3/127 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=6 bank=123 E=182 bank=1315 pull=127 plants=1/0 aircraftDemand=3/127
  4.77  [AIR][Projects] energyQueued=1 committed=40/175
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Naval] theatre=0:4:0 enemy=1110 friendly=150 subs=0 antiSub=0 deficit=960
  4.78  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.79  [AIR][Rule] commander.energy.local builder=14279
  4.88  [Playtest] finished armwin team 0 at 4.88 min
  4.93  [AIR][Capacity] own=4/149 usage=10/160 gifts=3 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST M=6 bank=119 E=162 bank=1264 pull=160 plants=1/0 aircraftDemand=3/127
  4.93  [AIR][Projects] energyQueued=0 committed=25/110
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.95  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.99  [Playtest] finished armwin team 0 at 4.99 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.0 bank 105/1150, energy +132.8 bank 1178/1329, units 25
  5.00  [AIR][Rule] commander.factory.guard builder=14279
  5.10  [AIR][Commander] cleared factory guard for commander.idle.energy
  5.10  [AIR][Rule] commander.idle.energy builder=14279
  5.10  [AIR][Capacity] own=4/129 usage=0/3 gifts=3 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=7 bank=137 E=132 bank=1265 pull=3 plants=1/0 aircraftDemand=3/127
  5.10  [AIR][Projects] energyQueued=0 committed=0/0
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=30055 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.12  [AIR][Screen] fighters=7 cells=8 centre=949,734 width=600 advance=400 responding=false
  5.13  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=294 at=824,1960
  5.13  [AIR][Rule] opening.support builder=21244
  5.24  [AIR][Rule] opening.support.assist builder=30650
  5.25  [AIR][Rule] opening.support.assist builder=15163
  5.27  [AIR][Capacity] own=4/127 usage=7/35 gifts=3 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=350 shortage=0 reason=no funded workload
  5.27  [AIR][Economy] T1_CONTEST M=7 bank=186 E=128 bank=1266 pull=66 plants=1/0 aircraftDemand=3/127
  5.27  [AIR][Projects] energyQueued=0 committed=233/3078
  5.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
... 3281 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(14279) at (601, 1754) walks to (651, 1764), 136 from the armmex site (784, 1792)
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
  0.09  EXP: approach: legcom(13004) at (14751, 1701) walks to (14593, 1486), 137 from the legmex site (14512, 1376)
  0.17  RESERVE: armlab at (1968, 688) facing 1 (id 72)
  0.17  RESERVE: zone 14 at (1896, 688) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 816) facing 1 (id 73)
  0.17  RESERVE: zone 14 at (1896, 816) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 560) facing 1 (id 74)
  0.17  RESERVE: zone 14 at (1896, 560) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (3968, 1456) facing 1 (id 75)
  0.17  RESERVE: zone 14 at (3896, 1456) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 1456) facing 1: 2 of 2 slots (group 10, zone)
  0.17  EXP: approach: corcom(17448) at (14799, 731) walks to (14663, 456), 139 from the cormex site (14544, 384)
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
  0.28  EXP: approach: armcom(14279) at (718, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.30  EXP: approach: armcom(14279) at (718, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
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
  0.37  EXP: approach: legcom(13004) at (14551, 1429) walks to (15079, 1412), 137 from the legmex site (15216, 1408)
  0.40  EXP: approach: armcom(14279) at (718, 1778) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.41  EXP: approach: armcom(14279) at (718, 1779) walks to (419, 1592), 136 from the armmex site (304, 1520)
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
  0.43  EXP: approach: armcom(14279) at (718, 1779) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.43  EXP: approach: corcom(17448) at (14637, 509) walks to (15107, 284), 139 from the cormex site (15232, 224)
  0.44  EXP: approach: armcom(18341) at (707, 1034) walks to (892, 355), 136 from the armmex site (928, 224)
  0.47  EXP: approach: legcom(13004) at (14550, 1429) walks to (14807, 1836), 137 from the legmex site (14880, 1952)
```
