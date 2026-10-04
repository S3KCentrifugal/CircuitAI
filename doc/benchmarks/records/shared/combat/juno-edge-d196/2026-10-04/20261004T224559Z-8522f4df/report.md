# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7201); wall 103 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (d28b4dcb6a319109); AI BARbTest/test; staged 2026-10-04T19:40:49
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: juno_edge_probe.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\juno-edge-d196\shore-to-shore\20261004T224048Z-24375389\runs\20261004T224559Z-8522f4df\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `map` | seen at 0.2 min | `[t=00:00:36.611305][f=0000300] [JunoEdge] map width=15360 height=3072` |
| expect `launch` | seen at 0.5 min | `[t=00:00:43.299625][f=0000902] [JunoEdge] launch id=5896 case=north-edge` |
| expect `projectile` | seen at 0.5 min | `[t=00:00:43.312058][f=0000903] [JunoEdge] projectile id=7791 owner=20933 targetType=103 target=1857,1104.89258,1` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\juno-edge-d196\shore-to-shore\20261004T224048Z-24375389\runs\20261004T224559Z-8522f4df\screen_2026-10-04_22-44-49-338.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\juno-edge-d196\shore-to-shore\20261004T224048Z-24375389\runs\20261004T224559Z-8522f4df\screen_2026-10-04_22-45-02-255.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 3, 2 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (550, 1740) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (14800, 1450) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 3
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (550, 1740) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (14800, 1450) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.08  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (618, 1485), 269 from the start
  0.18  [AIR][BaseResponse] contact=true
  0.18  [AIR][BaseResponse] group=0 target=22045
  0.18  [AIR][BaseResponse] group=2 target=22045
  0.25  [Playtest] finished armmex team 0 at 0.25 min
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=963 E=18 bank=696 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.27  [Team][Roster] first mex 14171 at 784,1792
  0.27  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|620|1755|0|1|1|784|1792
  0.27  [AIR][Rule] opening.mex builder=14132
  0.35  [AIR][BaseResponse] group=1 target=12125
  0.43  [AIR][Capacity] own=3/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=1001 E=30 bank=978 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=1041 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.60  [Playtest] camera requested (1857,120) height=1800
  0.60  [Playtest] camera captured name=ta position=(1857,120) height=1800
  0.60  [Playtest] screenshot at 0.6 min of team 0 at (1857, 120)
  0.77  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=50/500
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.93  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=50/500
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 1050/1050, energy +30.0 bank 998/1000, units 2
  1.10  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=50/500
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.20  [Playtest] camera requested (2088,2950) height=1800
  1.20  [Playtest] camera captured name=ta position=(2088,2950) height=1800
  1.20  [Playtest] screenshot at 1.2 min of team 0 at (2088, 2950)
  1.27  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=50/500
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.43  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=50/500
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.60  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=50/500
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.60  [AIR][BaseResponse] group=1 target=15346
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=50/500
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.93  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=50/500
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.0 bank 1050/1050, energy +30.0 bank 998/1000, units 2
  2.10  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=50/500
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=50/500
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.43  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=50/500
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.60  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  2.60  [AIR][Projects] energyQueued=0 committed=50/500
  2.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  2.77  [AIR][Projects] energyQueued=0 committed=50/500
  2.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.85  [AIR][BaseResponse] group=1 target=20933
  2.93  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  2.93  [AIR][Projects] energyQueued=0 committed=50/500
  2.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.0 bank 1050/1050, energy +30.0 bank 998/1000, units 2
  3.10  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  3.10  [AIR][Projects] energyQueued=0 committed=50/500
  3.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  3.27  [AIR][Projects] energyQueued=0 committed=50/500
  3.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.43  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  3.43  [AIR][Projects] energyQueued=0 committed=50/500
  3.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.60  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  3.60  [AIR][Projects] energyQueued=0 committed=50/500
  3.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=73
  3.77  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  3.77  [AIR][Projects] energyQueued=0 committed=50/500
  3.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.93  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=4 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] BOOTSTRAP M=4 bank=1050 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  3.93  [AIR][Projects] energyQueued=0 committed=50/500
  3.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.00  [Playtest] eco team 0 at 4.0 min: metal +5.0 bank 1050/1050, energy +45.0 bank 998/1000, units 2
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(14132) at (621, 1755) walks to (651, 1762), 136 from the armmex site (784, 1792)
  0.09  EXP: approach: armcom(3451) at (14718, 1437) walks to (14642, 1415), 136 from the armmex site (14512, 1376)
  0.27  EXP: approach: armcom(14132) at (724, 1778) walks to (420, 1591), 136 from the armmex site (304, 1520)
  0.29  EXP: approach: armcom(3451) at (14567, 1392) walks to (14814, 1833), 136 from the armmex site (14880, 1952)
  0.63  EXP: approach: armcom(3451) at (14798, 1809) walks to (15118, 1502), 136 from the armmex site (15216, 1408)
  0.72  EXP: idle: armcom(14132) on armmex at (547, 1335), site (304, 1520), target no, fails 1 (arrived at the approach point)
  0.96  RESERVE: zone 1 at (15160, 1480) facing 3, 3x3 cells: 9 of 9 held
  0.96  RESERVE: armwin at (15160, 1480) facing 3 (id 1)
  0.96  RESERVE: zone 2 at (15160, 1528) facing 3, 3x3 cells: 9 of 9 held
  0.96  RESERVE: armwin at (15160, 1528) facing 3 (id 2)
  0.96  RESERVE: zone 3 at (15160, 1576) facing 3, 3x3 cells: 9 of 9 held
  0.96  RESERVE: armwin at (15160, 1576) facing 3 (id 3)
  0.96  RESERVE: zone 4 at (15112, 1480) facing 3, 3x3 cells: 9 of 9 held
  0.96  RESERVE: armwin at (15112, 1480) facing 3 (id 4)
  0.96  RESERVE: zone 5 at (15112, 1528) facing 3, 3x3 cells: 9 of 9 held
  0.96  RESERVE: armwin at (15112, 1528) facing 3 (id 5)
  0.96  RESERVE: zone 6 at (15112, 1576) facing 3, 3x3 cells: 9 of 9 held
  0.96  RESERVE: armwin at (15112, 1576) facing 3 (id 6)
  0.96  RESERVE: served armwin at (15160, 1480) facing 3 (id 1, 5 of this def still held)
  0.99  EXP: idle: armcom(14132) on armmex at (460, 1270), site (304, 1520), target no, fails 1
  0.99  EXP: approach: armcom(14132) at (460, 1270) walks to (376, 1404), 136 from the armmex site (304, 1520)
  1.06  RESERVE: served armwin at (15160, 1528) facing 3 (id 2, 4 of this def still held)
  1.17  RESERVE: served armwin at (15160, 1576) facing 3 (id 3, 3 of this def still held)
  1.28  RESERVE: served armwin at (15112, 1480) facing 3 (id 4, 2 of this def still held)
  1.29  EXP: idle: armcom(14132) on armmex at (632, 1215), site (304, 1520), target no, fails 1 (arrived at the approach point)
  1.38  RESERVE: served armwin at (15112, 1528) facing 3 (id 5, 1 of this def still held)
  1.56  RESERVE: served armwin at (15112, 1576) facing 3 (id 6, 0 of this def still held)
  1.59  EXP: idle: armcom(14132) on armmex at (873, 1216), site (304, 1520), target no, fails 1
  1.59  EXP: approach: armcom(14132) at (873, 1216) walks to (424, 1456), 136 from the armmex site (304, 1520)
  1.67  RESERVE: zone 7 at (14840, 1384) facing 3, 3x3 cells: 9 of 9 held
  1.67  RESERVE: armwin at (14840, 1384) facing 3 (id 7)
  1.67  RESERVE: zone 8 at (14840, 1432) facing 3, 3x3 cells: 9 of 9 held
  1.67  RESERVE: armwin at (14840, 1432) facing 3 (id 8)
  1.67  RESERVE: zone 9 at (14840, 1480) facing 3, 3x3 cells: 9 of 9 held
  1.67  RESERVE: armwin at (14840, 1480) facing 3 (id 9)
  1.67  RESERVE: zone 10 at (14792, 1384) facing 3, 3x3 cells: 9 of 9 held
  1.67  RESERVE: armwin at (14792, 1384) facing 3 (id 10)
  1.67  RESERVE: zone 11 at (14792, 1432) facing 3, 3x3 cells: 9 of 9 held
  1.67  RESERVE: armwin at (14792, 1432) facing 3 (id 11)
  1.67  RESERVE: zone 12 at (14792, 1480) facing 3, 3x3 cells: 9 of 9 held
  1.67  RESERVE: armwin at (14792, 1480) facing 3 (id 12)
  1.67  EXP: approach: armcom(3451) at (15037, 1463) walks to (14966, 1435), 136 from the armwin site (14840, 1384)
  1.67  RESERVE: served armwin at (14840, 1384) facing 3 (id 7, 5 of this def still held)
  1.81  EXP: approach: armcom(3451) at (14992, 1447) walks to (14975, 1445), 136 from the armwin site (14840, 1432)
  1.81  RESERVE: served armwin at (14840, 1432) facing 3 (id 8, 4 of this def still held)
  1.93  RESERVE: served armwin at (14840, 1480) facing 3 (id 9, 3 of this def still held)
  1.93  EXP: idle: armcom(14132) on armmex at (832, 946), site (304, 1520), target no, fails 1 (arrived at the approach point)
  2.01  EXP: watchdog: armcom(14132) lost on armmex at (897, 882), site (304, 1520), dist 871, reach 169, commands yes, waiting no
  2.01  EXP: move failed: armcom(14132) at (897, 882); a radial move of 256 follows and the command queue is replaced
  2.04  RESERVE: armap at (15040, 1560) facing 1 (id 13)
  2.04  RESERVE: served armap at (15040, 1560) facing 1 (id 13, 0 of this def still held)
  2.05  RESERVE: zone 13 at (14832, 952) facing 3, 6x9 cells: 54 of 54 held
  2.05  RESERVE: armap at (14832, 952) facing 3 (id 14)
  2.05  RESERVE: zone 14 at (14904, 904) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14904, 904) facing 3 (id 15)
  2.05  RESERVE: zone 15 at (14904, 952) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14904, 952) facing 3 (id 16)
  2.05  RESERVE: zone 16 at (14904, 1000) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14904, 1000) facing 3 (id 17)
  2.05  RESERVE: zone 17 at (14952, 904) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14952, 904) facing 3 (id 18)
  2.05  RESERVE: zone 18 at (14952, 952) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14952, 952) facing 3 (id 19)
  2.05  RESERVE: zone 19 at (14808, 1096) facing 3, 9x9 cells: 81 of 81 held
  2.05  RESERVE: armaap at (14808, 1096) facing 3 (id 20)
  2.05  RESERVE: zone 20 at (14904, 1048) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14904, 1048) facing 3 (id 21)
  2.05  RESERVE: zone 21 at (14904, 1096) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14904, 1096) facing 3 (id 22)
  2.05  RESERVE: zone 22 at (14904, 1144) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14904, 1144) facing 3 (id 23)
  2.05  RESERVE: zone 23 at (14952, 1048) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14952, 1048) facing 3 (id 24)
  2.05  RESERVE: zone 24 at (14952, 1096) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14952, 1096) facing 3 (id 25)
  2.05  RESERVE: zone 25 at (14952, 1144) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14952, 1144) facing 3 (id 26)
  2.05  RESERVE: zone 26 at (15000, 1048) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15000, 1048) facing 3 (id 27)
  2.05  RESERVE: zone 27 at (15000, 1096) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15000, 1096) facing 3 (id 28)
  2.05  RESERVE: zone 28 at (15000, 1144) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15000, 1144) facing 3 (id 29)
  2.05  RESERVE: zone 29 at (15048, 1048) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15048, 1048) facing 3 (id 30)
  2.05  RESERVE: zone 30 at (15048, 1096) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15048, 1096) facing 3 (id 31)
  2.05  RESERVE: zone 31 at (15048, 1144) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15048, 1144) facing 3 (id 32)
  2.05  RESERVE: zone 32 at (15096, 1048) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15096, 1048) facing 3 (id 33)
  2.05  RESERVE: zone 33 at (15096, 1096) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15096, 1096) facing 3 (id 34)
  2.05  RESERVE: zone 34 at (15096, 1144) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15096, 1144) facing 3 (id 35)
  2.05  RESERVE: zone 35 at (15144, 1048) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15144, 1048) facing 3 (id 36)
  2.05  RESERVE: zone 36 at (15144, 1096) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15144, 1096) facing 3 (id 37)
  2.05  RESERVE: zone 37 at (15144, 1144) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15144, 1144) facing 3 (id 38)
  2.05  RESERVE: zone 38 at (15192, 1048) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15192, 1048) facing 3 (id 39)
  2.05  RESERVE: zone 39 at (15192, 1096) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (15192, 1096) facing 3 (id 40)
  2.05  RESERVE: zone 40 at (14808, 1240) facing 3, 9x9 cells: 81 of 81 held
  2.05  RESERVE: armaap at (14808, 1240) facing 3 (id 41)
  2.05  RESERVE: zone 41 at (14904, 1192) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14904, 1192) facing 3 (id 42)
  2.05  RESERVE: zone 42 at (14904, 1240) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14904, 1240) facing 3 (id 43)
  2.05  RESERVE: zone 43 at (14904, 1288) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14904, 1288) facing 3 (id 44)
  2.05  RESERVE: zone 44 at (14952, 1192) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14952, 1192) facing 3 (id 45)
  2.05  RESERVE: zone 45 at (14952, 1240) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14952, 1240) facing 3 (id 46)
  2.05  RESERVE: zone 46 at (14952, 1288) facing 3, 3x3 cells: 9 of 9 held
  2.05  RESERVE: armnanotc at (14952, 1288) facing 3 (id 47)
  2.05  RESERVE: zone 47 at (15000, 1192) facing 3, 3x3 cells: 9 of 9 held
```
