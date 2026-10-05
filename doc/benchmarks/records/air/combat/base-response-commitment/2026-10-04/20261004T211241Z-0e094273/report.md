# Playtest report: PASS

- Verdict: **PASS** (reached 8 min)
- Game time reached: 8.0 min (frame 14446); wall 98 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (6ce4e0ebfac96507); AI BARbTest/test; staged 2026-10-04T18:11:00
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: base-response-commitment.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\base-response-commitment\supreme-isthmus-v1-7\20261004T211059Z-1570f726\runs\20261004T211241Z-0e094273\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:33.647503][f=-000001] [AirArena] event=loaded frame=0 case=base-response-commitment endless=0 visibility=radar` |
| expect `committed-attack` | seen at 3.3 min | `[t=00:01:05.337633][f=0005922] Skirmish AI <BARb playtest-test>: WAVE: committed attack target=12120 bombers=18 escorts=24 offensive=1 handoff=visible-priority distance=1256` |
| expect `ground-emergency` | seen at 3.0 min | `[AIR][BaseResponse] contact=true` |
| expect `escort-retained-under-incursion` | seen at 3.0 min | `[t=00:01:01.950526][f=0005490] [AirArena] event=commitment frame=5490 escorts=24 homeIntruders=1800 owned=24 state=3 wave=1` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\base-response-commitment\supreme-isthmus-v1-7\20261004T211059Z-1570f726\runs\20261004T211241Z-0e094273\screen_2026-10-04_21-11-52-669.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\base-response-commitment\supreme-isthmus-v1-7\20261004T211059Z-1570f726\runs\20261004T211241Z-0e094273\screen_2026-10-04_21-11-55-143.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\base-response-commitment\supreme-isthmus-v1-7\20261004T211059Z-1570f726\runs\20261004T211241Z-0e094273\screen_2026-10-04_21-12-07-139.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\base-response-commitment\supreme-isthmus-v1-7\20261004T211059Z-1570f726\runs\20261004T211241Z-0e094273\screen_2026-10-04_21-12-08-723.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\base-response-commitment\supreme-isthmus-v1-7\20261004T211059Z-1570f726\runs\20261004T211241Z-0e094273\screen_2026-10-04_21-12-10-905.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\base-response-commitment\supreme-isthmus-v1-7\20261004T211059Z-1570f726\runs\20261004T211241Z-0e094273\screen_2026-10-04_21-12-12-376.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 10, 0 shots, end at 8.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000000/1000000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.00  [Playtest] speed 10
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
  0.19  [Playtest] finished armwin team 0 at 0.19 min
  0.19  [Playtest] finished armwin team 0 at 0.19 min
  0.19  [Playtest] finished armwin team 0 at 0.19 min
  0.19  [Playtest] finished armwin team 0 at 0.19 min
  0.19  [Playtest] finished armwin team 0 at 0.19 min
  0.19  [Playtest] finished armwin team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.20  [Playtest] finished armrad team 0 at 0.19 min
  0.20  [Playtest] finished armrad team 0 at 0.20 min
  0.20  [Playtest] finished armrad team 0 at 0.20 min
  0.20  [Playtest] finished armrad team 0 at 0.20 min
  0.20  [Playtest] finished armrad team 0 at 0.20 min
  0.23  [AIR][Scout] opening drone=28690 enemy starts=2
  0.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=1000 E=21000 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Capacity] own=2/42222 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=43605 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.51  [AIR][Scout] opening drone=30381 enemy starts=2
  0.60  [AIR][Capacity] own=2/72866 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=61090 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=2/91698 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=89805 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Capacity] own=2/104356 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=103157 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +139828.7 bank 1000003072/1000003072, units 15
  1.03  [AIR][Waves] opening size drawn=18
  1.08  [AIR][Screen] fighters=1 cells=8 centre=2386,11418 width=600 advance=400 responding=false
  1.10  [AIR][Capacity] own=2/131836 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=124536 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Attack] home=3 target=6 heldBombers=31 escorts=0 wave=0 enemyAir=0
  1.13  [AIR][Scout] opening drone=9049 enemy starts=2
  1.20  [AIR][Waves] planned strike target=27721 bombers=18 required=3 aim=10300,1700 mission=economy
  1.20  [AIR][Waves] Wave 1 launched (target and route budget): bombers=18 fighters=24 holdTasksAborted=0 provisionalNext=27
  1.27  [AIR][Capacity] own=2/141156 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=141218 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Capacity] own=2/143957 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=143580 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Capacity] own=2/143672 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=143862 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=14 escorts=0 wave=1 enemyAir=0
  1.77  [AIR][Capacity] own=2/143457 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=143499 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Capacity] own=2/141109 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=141332 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +143497.5 bank 1000003072/1000003072, units 71
  2.01  [AIR][Scout] opening drone=7060 enemy starts=2
  2.10  [AIR][Capacity] own=2/141805 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=141347 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=14 escorts=0 wave=1 enemyAir=0
  2.27  [AIR][Capacity] own=2/142476 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=142593 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Capacity] own=2/143707 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=143642 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Capacity] own=2/142368 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=143333 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Attack] home=0 target=6 heldBombers=14 escorts=0 wave=1 enemyAir=0
  2.77  [AIR][Capacity] own=2/141165 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=141383 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.93  [AIR][Capacity] own=2/116940 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=124835 bank=1000003072 pull=0 plants=0/0 aircraftDemand=0/0
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +106056.8 bank 1000003072/1000003072, units 71
  3.02  [AIR][BaseResponse] contact=true
  3.02  [AIR][BaseResponse] group=0 target=990
  3.02  [AIR][BaseResponse] group=1 target=990
  3.02  [AIR][BaseResponse] dispatched=14 total=14
  3.04  [AIR][Scout] opening drone=3268 enemy starts=2
  3.10  [AIR][Capacity] own=2/42581 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=67367 bank=1000000512 pull=0 plants=0/0 aircraftDemand=0/0
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.10  [AIR][Attack] home=0 target=30 heldBombers=0 escorts=0 wave=1 enemyAir=1800
  3.20  [AIR][BaseResponse] group=0 target=28022
  3.20  [AIR][BaseResponse] group=1 target=28022
  3.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.38  [AIR][BaseResponse] group=0 target=29205
  3.38  [AIR][BaseResponse] group=1 target=29205
  3.42  [AIR][BaseResponse] contact=false
  3.42  [AIR][BaseResponse] group=0 target=-1
  3.42  [AIR][BaseResponse] group=1 target=-1
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
  3.60  [AIR][Attack] home=0 target=27 heldBombers=0 escorts=0 wave=1 enemyAir=1620
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
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 35
  4.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.10  [AIR][Attack] home=0 target=24 heldBombers=12 escorts=0 wave=1 enemyAir=1458
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
  4.60  [AIR][Attack] home=0 target=22 heldBombers=12 escorts=0 wave=1 enemyAir=1312
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
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 27
  5.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.10  [AIR][Projects] energyQueued=0 committed=0/0
  5.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.10  [AIR][Attack] home=0 target=20 heldBombers=12 escorts=0 wave=1 enemyAir=1180
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
  5.60  [AIR][Attack] home=0 target=18 heldBombers=12 escorts=0 wave=1 enemyAir=1062
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
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 26
  6.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.10  [AIR][Projects] energyQueued=0 committed=0/0
  6.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.10  [AIR][Attack] home=0 target=16 heldBombers=12 escorts=0 wave=1 enemyAir=956
  6.27  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.27  [AIR][Projects] energyQueued=0 committed=0/0
  6.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.27  [AIR][Waves] Wave 1 committed operation exhausted
  6.28  [AIR][Waves] committed operation ended; next=8
  6.43  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.43  [AIR][Projects] energyQueued=0 committed=0/0
  6.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.51  [AIR][Scout] opening drone=19119 enemy starts=2
  6.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.60  [AIR][Projects] energyQueued=0 committed=0/0
  6.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.60  [AIR][Attack] home=0 target=15 heldBombers=12 escorts=0 wave=1 enemyAir=864
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
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 23
  7.10  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  7.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  7.10  [AIR][Projects] energyQueued=0 committed=0/0
  7.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  7.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.10  [AIR][Attack] home=0 target=13 heldBombers=12 escorts=0 wave=1 enemyAir=782
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
  7.51  [AIR][Scout] opening drone=10302 enemy starts=2
  7.60  [AIR][Capacity] own=2/30000 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  7.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  7.60  [AIR][Projects] energyQueued=0 committed=0/0
  7.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  7.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.60  [AIR][Attack] home=0 target=12 heldBombers=12 escorts=0 wave=1 enemyAir=707
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
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 23
```

## Native lines (all AIs, first 120)

```
```
