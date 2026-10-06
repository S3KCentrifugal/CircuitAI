# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.0 min (frame 5430); wall 63 s
- DLL: build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T04:39:56
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: spam-repeat.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-air\glitters\20261006T073955Z-055fb6a3\runs\20261006T074102Z-54e9e2c3\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `spawn` | seen at 0.2 min | `[t=00:00:37.809288][f=0000408] [RangedArena] frame=408 spawn id=13180 team=0 unit=armlab x=3400 z=3600` |
| expect `repeat` | seen at 0.7 min | `[t=00:00:41.557252][f=0001170] [RangedArena] frame=1170 factory id=8355 unit=armlab repeat=true builds=1 building=8806` |
| expect `offspring` | seen at 0.8 min | `[t=00:00:43.554403][f=0001484] [RangedArena] frame=1484 finished id=7961 team=0 unit=armpw cost=54` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-air\glitters\20261006T073955Z-055fb6a3\runs\20261006T074102Z-54e9e2c3\screen_2026-10-06_07-40-43-157.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-air\glitters\20261006T073955Z-055fb6a3\runs\20261006T074102Z-54e9e2c3\screen_2026-10-06_07-40-49-409.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-air\glitters\20261006T073955Z-055fb6a3\runs\20261006T074102Z-54e9e2c3\screen_2026-10-06_07-40-57-398.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 8, 0 shots, end at 3.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 3000/3000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=3000 E=0 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (3973, 2250), 148 from the start
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [AIR][Growth] growth objective reached; completed AFUS=8
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.22  [AIR][Layout] cluster=0 labs=6 at=3736,2661
  0.22  [AIR][EcoLayout] reserved air.eco.0 reactor=4000,1504 converters=8 support=12 zone=134
  0.22  [AIR][Layout] cluster=1 labs=6 at=4408,2565
  0.23  [Playtest] finished armalab team 0 at 0.23 min
  0.23  [Playtest] finished armlab team 0 at 0.23 min
  0.23  [Playtest] finished armlab team 0 at 0.23 min
  0.23  [Playtest] finished armlab team 0 at 0.23 min
  0.23  [AIR][EcoLayout] reserved air.eco.1 reactor=3616,1120 converters=8 support=12 zone=283
  0.24  [Playtest] finished armnanotc team 0 at 0.24 min
  0.24  [Playtest] finished armnanotc team 0 at 0.24 min
  0.25  [AIR][EcoLayout] reserved air.eco.2 reactor=3872,2016 converters=8 support=12 zone=309
  0.25  [AIR][Share] metal 3413 of 3500 (97%): no teammate with room (0 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.27  [AIR][EcoLayout] reserved air.eco.3 reactor=4640,2144 converters=8 support=12 zone=349
  0.27  [AIR][Capacity] own=2/30 usage=4/12106 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=3413 E=18 bank=1072700 pull=12106 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.40  [AIR][Growth] shared TECH economy enabled at M10=82.8832
  0.43  [AIR][Capacity] own=208/24058 usage=42/13042 gifts=0 sent=0 excess=166 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=165 bank=3500 E=24058 bank=1072700 pull=13042 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  0.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Capacity] own=208/24058 usage=42/13042 gifts=0 sent=0 excess=166 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24058 bank=1072700 pull=13042 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  0.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=208/24058 usage=42/13204 gifts=0 sent=0 excess=165 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24058 bank=1068808 pull=13204 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  0.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Capacity] own=208/24079 usage=42/13141 gifts=0 sent=0 excess=165 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24079 bank=1068808 pull=13141 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  0.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.00  [Playtest] eco team 0 at 1.0 min: metal +208.9 bank 3488/3500, energy +24079.0 bank 1066375/1072850, units 49
  1.10  [AIR][Capacity] own=208/24079 usage=42/13141 gifts=0 sent=0 excess=165 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24079 bank=1068858 pull=13141 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Capacity] own=208/24086 usage=49/12997 gifts=0 sent=0 excess=159 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24085 bank=1066681 pull=12997 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.33  [AIR][Share] metal 3500 of 3500 (100%): no teammate with room (0 teammates); the engine counts 0 metal sent in the last update (D-106)
  1.43  [AIR][Capacity] own=208/24086 usage=45/12820 gifts=0 sent=0 excess=163 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24086 bank=1066729 pull=12820 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Capacity] own=208/24103 usage=22/12622 gifts=0 sent=0 excess=186 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24100 bank=1066738 pull=12622 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=208/24131 usage=42/13216 gifts=0 sent=0 excess=165 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24125 bank=1066649 pull=13216 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Capacity] own=208/24131 usage=42/13216 gifts=0 sent=0 excess=165 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24131 bank=1066703 pull=13216 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +208.9 bank 3491/3500, energy +24138.0 bank 1066860/1073150, units 69
  2.10  [AIR][Capacity] own=208/24138 usage=49/13197 gifts=0 sent=0 excess=159 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24138 bank=1066716 pull=13197 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=208/24138 usage=49/13330 gifts=0 sent=0 excess=159 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24138 bank=1066719 pull=13330 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.42  [AIR][Share] metal 3500 of 3500 (100%): no teammate with room (0 teammates); the engine counts 0 metal sent in the last update (D-106)
  2.43  [AIR][Capacity] own=208/24159 usage=58/13802 gifts=0 sent=0 excess=150 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24151 bank=1066612 pull=13802 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=208/24171 usage=58/13802 gifts=0 sent=0 excess=150 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24171 bank=1066676 pull=13802 plants=0/0 aircraftDemand=0/0
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=208/24171 usage=13/12806 gifts=0 sent=0 excess=195 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24171 bank=1066845 pull=12806 plants=0/0 aircraftDemand=0/0
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Capacity] own=208/24178 usage=49/13385 gifts=0 sent=0 excess=159 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] BOOTSTRAP M=208 bank=3500 E=24178 bank=1066994 pull=13385 plants=0/0 aircraftDemand=0/0
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +208.9 bank 3478/3500, energy +24192.0 bank 1066692/1073475, units 87
```

## Native lines (all AIs, first 120)

```
  0.22  RESERVE: zone 1 at (3800, 3040) facing 0, 9x6 cells: 54 of 54 held
  0.22  RESERVE: armap at (3800, 3040) facing 0 (id 1)
  0.22  RESERVE: zone 2 at (3752, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3752, 2968) facing 0 (id 2)
  0.22  RESERVE: zone 3 at (3800, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3800, 2968) facing 0 (id 3)
  0.22  RESERVE: zone 4 at (3848, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3848, 2968) facing 0 (id 4)
  0.22  RESERVE: zone 5 at (3752, 2920) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3752, 2920) facing 0 (id 5)
  0.22  RESERVE: zone 6 at (3800, 2920) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3800, 2920) facing 0 (id 6)
  0.22  RESERVE: zone 7 at (3944, 3064) facing 0, 9x9 cells: 81 of 81 held
  0.22  RESERVE: armaap at (3944, 3064) facing 0 (id 7)
  0.22  RESERVE: zone 8 at (3896, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3896, 2968) facing 0 (id 8)
  0.22  RESERVE: zone 9 at (3944, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3944, 2968) facing 0 (id 9)
  0.22  RESERVE: zone 10 at (3992, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3992, 2968) facing 0 (id 10)
  0.22  RESERVE: zone 11 at (3896, 2920) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3896, 2920) facing 0 (id 11)
  0.22  RESERVE: zone 12 at (3944, 2920) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3944, 2920) facing 0 (id 12)
  0.22  RESERVE: zone 13 at (3992, 2920) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3992, 2920) facing 0 (id 13)
  0.22  RESERVE: zone 14 at (3896, 2872) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3896, 2872) facing 0 (id 14)
  0.22  RESERVE: zone 15 at (3944, 2872) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3944, 2872) facing 0 (id 15)
  0.22  RESERVE: zone 16 at (3992, 2872) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3992, 2872) facing 0 (id 16)
  0.22  RESERVE: zone 17 at (3896, 2824) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3896, 2824) facing 0 (id 17)
  0.22  RESERVE: zone 18 at (3944, 2824) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3944, 2824) facing 0 (id 18)
  0.22  RESERVE: zone 19 at (3992, 2824) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3992, 2824) facing 0 (id 19)
  0.22  RESERVE: zone 20 at (3896, 2776) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3896, 2776) facing 0 (id 20)
  0.22  RESERVE: zone 21 at (3944, 2776) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3944, 2776) facing 0 (id 21)
  0.22  RESERVE: zone 22 at (3992, 2776) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3992, 2776) facing 0 (id 22)
  0.22  RESERVE: zone 23 at (3896, 2728) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3896, 2728) facing 0 (id 23)
  0.22  RESERVE: zone 24 at (3944, 2728) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3944, 2728) facing 0 (id 24)
  0.22  RESERVE: zone 25 at (3992, 2728) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3992, 2728) facing 0 (id 25)
  0.22  RESERVE: zone 26 at (3896, 2680) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3896, 2680) facing 0 (id 26)
  0.22  RESERVE: zone 27 at (3944, 2680) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3944, 2680) facing 0 (id 27)
  0.22  RESERVE: zone 28 at (4088, 3064) facing 0, 9x9 cells: 81 of 81 held
  0.22  RESERVE: armaap at (4088, 3064) facing 0 (id 28)
  0.22  RESERVE: zone 29 at (4040, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4040, 2968) facing 0 (id 29)
  0.22  RESERVE: zone 30 at (4088, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4088, 2968) facing 0 (id 30)
  0.22  RESERVE: zone 31 at (4136, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4136, 2968) facing 0 (id 31)
  0.22  RESERVE: zone 32 at (4040, 2920) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4040, 2920) facing 0 (id 32)
  0.22  RESERVE: zone 33 at (4088, 2920) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4088, 2920) facing 0 (id 33)
  0.22  RESERVE: zone 34 at (4136, 2920) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4136, 2920) facing 0 (id 34)
  0.22  RESERVE: zone 35 at (4040, 2872) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4040, 2872) facing 0 (id 35)
  0.22  RESERVE: zone 36 at (4088, 2872) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4088, 2872) facing 0 (id 36)
  0.22  RESERVE: zone 37 at (4136, 2872) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4136, 2872) facing 0 (id 37)
  0.22  RESERVE: zone 38 at (4040, 2824) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4040, 2824) facing 0 (id 38)
  0.22  RESERVE: zone 39 at (4088, 2824) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4088, 2824) facing 0 (id 39)
  0.22  RESERVE: zone 40 at (4136, 2824) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4136, 2824) facing 0 (id 40)
  0.22  RESERVE: zone 41 at (4040, 2776) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4040, 2776) facing 0 (id 41)
  0.22  RESERVE: zone 42 at (4088, 2776) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4088, 2776) facing 0 (id 42)
  0.22  RESERVE: zone 43 at (4136, 2776) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4136, 2776) facing 0 (id 43)
  0.22  RESERVE: zone 44 at (4040, 2728) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4040, 2728) facing 0 (id 44)
  0.22  RESERVE: zone 45 at (4088, 2728) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4088, 2728) facing 0 (id 45)
  0.22  RESERVE: zone 46 at (4136, 2728) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4136, 2728) facing 0 (id 46)
  0.22  RESERVE: zone 47 at (4040, 2680) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4040, 2680) facing 0 (id 47)
  0.22  RESERVE: zone 48 at (4088, 2680) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (4088, 2680) facing 0 (id 48)
  0.22  RESERVE: zone 49 at (3800, 3544) facing 0, 9x9 cells: 81 of 81 held
  0.22  RESERVE: armaap at (3800, 3544) facing 0 (id 49)
  0.22  RESERVE: zone 50 at (3752, 3448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3752, 3448) facing 0 (id 50)
  0.22  RESERVE: zone 51 at (3800, 3448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3800, 3448) facing 0 (id 51)
  0.22  RESERVE: zone 52 at (3848, 3448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3848, 3448) facing 0 (id 52)
  0.22  RESERVE: zone 53 at (3752, 3400) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3752, 3400) facing 0 (id 53)
  0.22  RESERVE: zone 54 at (3800, 3400) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3800, 3400) facing 0 (id 54)
  0.22  RESERVE: zone 55 at (3848, 3400) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3848, 3400) facing 0 (id 55)
  0.22  RESERVE: zone 56 at (3752, 3352) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3752, 3352) facing 0 (id 56)
  0.22  RESERVE: zone 57 at (3800, 3352) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3800, 3352) facing 0 (id 57)
  0.22  RESERVE: zone 58 at (3848, 3352) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3848, 3352) facing 0 (id 58)
  0.22  RESERVE: zone 59 at (3752, 3304) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3752, 3304) facing 0 (id 59)
  0.22  RESERVE: zone 60 at (3800, 3304) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotc at (3800, 3304) facing 0 (id 60)
```
