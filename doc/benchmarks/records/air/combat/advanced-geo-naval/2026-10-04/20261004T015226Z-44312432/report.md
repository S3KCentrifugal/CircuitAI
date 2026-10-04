# Playtest report: PASS

- Verdict: **PASS** (reached 10 min)
- Game time reached: 10.0 min (frame 18015); wall 147 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\d186-target-priority\SkirmishAI.dll (3ecbc2deecda41e7); AI BARbTest/test; staged 2026-10-03T22:49:36
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\advanced-geo-naval\supreme\20261004T014935Z-8ce4fd5d\runs\20261004T015226Z-44312432\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.850426][f=-000001] [AirArena] event=loaded frame=0 case=advanced-geo-naval endless=0 visibility=radar` |
| expect `launch` | seen at 1.2 min | `00:53.060761][f=0002160] [AirArena] event=launch frame=2160 count=18 ids=12916,19377,21074,21438,23078,23172,25997,28690,2983,30003,30381,31145,3658,5557,5756,6711,7346,8848 risk=1 target=12120 wave=1` |
| expect `airborne` | seen at 1.2 min | `[t=00:00:54.522688][f=0002250] [AirArena] event=flight frame=2250 alive=18 autoland=0 landed=0 wave=1` |
| expect `screenshot` | seen at 1.0 min | `[t=00:00:51.106844][f=0001808] [AirArena] event=screenshot frame=1808 key=arena-overview x=6144 z=6144` |
| expect `geo-primary` | seen at 1.2 min | `[t=00:00:52.892458][f=0002130] Skirmish AI <BARb playtest-test>: WAVE: strike target armageo(12120) cost 1600 at (9500, 1800), preference 5` |
| expect `geo-destroyed` | seen at 2.7 min | `[t=00:01:10.173909][f=0004893] [AirArena] event=death frame=4893 attacker=12916 attackerTeam=0 cost=1600 id=12120 kind=target team=1 unit=armageo wave=0` |
| expect `naval-primary` | seen at 1.0 min | `[t=00:00:51.254159][f=0001830] Skirmish AI <BARb playtest-test>: WAVE: strike target armuwmmm(29932) cost 380 at (4800, 3500), preference 5` |
| expect `naval-destroyed` | seen at 3.4 min | `[t=00:01:18.035178][f=0006119] [AirArena] event=death frame=6119 attacker=3658 attackerTeam=0 cost=370 id=5955 kind=target team=1 unit=leganavaleconv wave=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\advanced-geo-naval\supreme\20261004T014935Z-8ce4fd5d\runs\20261004T015226Z-44312432\screen_2026-10-04_01-50-50-932.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\advanced-geo-naval\supreme\20261004T014935Z-8ce4fd5d\runs\20261004T015226Z-44312432\screen_2026-10-04_01-50-53-890.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\advanced-geo-naval\supreme\20261004T014935Z-8ce4fd5d\runs\20261004T015226Z-44312432\screen_2026-10-04_01-51-09-863.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\advanced-geo-naval\supreme\20261004T014935Z-8ce4fd5d\runs\20261004T015226Z-44312432\screen_2026-10-04_01-51-12-177.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\advanced-geo-naval\supreme\20261004T014935Z-8ce4fd5d\runs\20261004T015226Z-44312432\screen_2026-10-04_01-52-08-383.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 6, 0 shots, end at 10.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000000/1000000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.00  [Playtest] speed 6
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 15 from the start
  0.18  [Playtest] finished armrad team 0 at 0.18 min
  0.18  [Playtest] finished armrad team 0 at 0.18 min
  0.18  [Playtest] finished armrad team 0 at 0.19 min
  0.18  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=1000 E=21000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 15
  1.02  [AIR][Waves] opening size drawn=18
  1.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=30 escorts=0 wave=0 enemyAir=0
  1.18  [AIR][Waves] planned strike target=12120 bombers=18 required=12 aim=9500,1800 mission=economy
  1.18  [AIR][Waves] Wave 1 launched (target and route budget): bombers=18 fighters=0 holdTasksAborted=0 provisionalNext=27
  1.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  1.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 45
  2.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  2.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  2.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 40
  3.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.10  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  3.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.60  [AIR][Projects] energyQueued=0 committed=0/0
  3.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  3.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.77  [AIR][Projects] energyQueued=0 committed=0/0
  3.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 36
  4.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.10  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  4.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.60  [AIR][Projects] energyQueued=0 committed=0/0
  4.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.60  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  4.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.77  [AIR][Projects] energyQueued=0 committed=0/0
  4.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.93  [AIR][Projects] energyQueued=0 committed=0/0
  4.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 35
  5.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.10  [AIR][Projects] energyQueued=0 committed=0/0
  5.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.10  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  5.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.27  [AIR][Projects] energyQueued=0 committed=0/0
  5.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.43  [AIR][Projects] energyQueued=0 committed=0/0
  5.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.60  [AIR][Projects] energyQueued=0 committed=0/0
  5.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.60  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  5.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.77  [AIR][Projects] energyQueued=0 committed=0/0
  5.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.93  [AIR][Projects] energyQueued=0 committed=0/0
  5.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 36
  6.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.10  [AIR][Projects] energyQueued=0 committed=0/0
  6.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.10  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  6.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.27  [AIR][Projects] energyQueued=0 committed=0/0
  6.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.43  [AIR][Projects] energyQueued=0 committed=0/0
  6.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.60  [AIR][Projects] energyQueued=0 committed=0/0
  6.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.60  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  6.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.77  [AIR][Projects] energyQueued=0 committed=0/0
  6.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.93  [AIR][Projects] energyQueued=0 committed=0/0
  6.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 36
  7.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  7.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  7.10  [AIR][Projects] energyQueued=0 committed=0/0
  7.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  7.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.10  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  7.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  7.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  7.27  [AIR][Projects] energyQueued=0 committed=0/0
  7.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  7.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  7.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  7.43  [AIR][Projects] energyQueued=0 committed=0/0
  7.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  7.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  7.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  7.60  [AIR][Projects] energyQueued=0 committed=0/0
  7.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  7.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.60  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  7.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  7.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  7.77  [AIR][Projects] energyQueued=0 committed=0/0
  7.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  7.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  7.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  7.93  [AIR][Projects] energyQueued=0 committed=0/0
  7.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  7.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 36
  8.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  8.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  8.10  [AIR][Projects] energyQueued=0 committed=0/0
  8.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  8.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.10  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  8.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  8.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  8.27  [AIR][Projects] energyQueued=0 committed=0/0
  8.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  8.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  8.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  8.43  [AIR][Projects] energyQueued=0 committed=0/0
  8.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  8.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  8.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  8.60  [AIR][Projects] energyQueued=0 committed=0/0
  8.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  8.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.60  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  8.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  8.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  8.77  [AIR][Projects] energyQueued=0 committed=0/0
  8.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  8.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  8.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  8.93  [AIR][Projects] energyQueued=0 committed=0/0
  8.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  8.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  9.00  [Playtest] eco team 0 at 9.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 36
  9.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  9.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  9.10  [AIR][Projects] energyQueued=0 committed=0/0
  9.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  9.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  9.10  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  9.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  9.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  9.27  [AIR][Projects] energyQueued=0 committed=0/0
  9.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  9.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  9.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  9.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  9.43  [AIR][Projects] energyQueued=0 committed=0/0
  9.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  9.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  9.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  9.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  9.60  [AIR][Projects] energyQueued=0 committed=0/0
  9.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  9.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  9.60  [AIR][Attack] home=0 target=6 heldBombers=12 escorts=0 wave=1 enemyAir=0
  9.77  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  9.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  9.77  [AIR][Projects] energyQueued=0 committed=0/0
  9.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  9.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  9.93  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  9.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  9.93  [AIR][Projects] energyQueued=0 committed=0/0
  9.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  9.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
 10.00  [Playtest] eco team 0 at 10.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 36
```

## Native lines (all AIs, first 120)

```
  8.34  EXP: swap: corcom(17952) from task type 3 to task type 4
```
