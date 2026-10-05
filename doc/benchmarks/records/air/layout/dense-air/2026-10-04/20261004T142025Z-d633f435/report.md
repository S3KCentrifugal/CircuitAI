# Playtest report: PASS

- Verdict: **PASS** (reached 8 min)
- Game time reached: 8.3 min (frame 14881); wall 76 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:19:07
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: dense-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141906Z-bf8c054d\runs\20261004T142025Z-d633f435\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `armmmkr` | seen at 5.2 min | `[t=00:01:00.371795][f=0009300] [DenseFixture] PASS touching armmmkr count=8 edges=10` |
| forbid `runtime` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141906Z-bf8c054d\runs\20261004T142025Z-d633f435\screen_2026-10-04_14-19-57-102.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141906Z-bf8c054d\runs\20261004T142025Z-d633f435\screen_2026-10-04_14-20-10-089.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141906Z-bf8c054d\runs\20261004T142025Z-d633f435\screen_2026-10-04_14-20-14-141.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141906Z-bf8c054d\runs\20261004T142025Z-d633f435\screen_2026-10-04_14-20-19-080.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 15, 3 shots, end at 8.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1800, 1650) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7000, 6500) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1800, 1650) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7000, 6500) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=100000 E=0 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (1776, 1453), 195 from the start
  0.17  [AIR][EcoLayout] reserved air.eco.0 reactor=896,1648 converters=8 support=12 zone=22
  0.18  [AIR][Rule] dense.fixture builder=25026
  0.18  [AIR][Layout] cluster=0 labs=6 at=1392,2103
  0.18  [AIR][EcoLayout] reserved air.eco.1 reactor=384,1776 converters=8 support=12 zone=156
  0.18  [AIR][Layout] cluster=1 labs=6 at=1008,1143
  0.19  [AIR][Rule] dense.fixture builder=6096
  0.19  [AIR][Rule] dense.fixture builder=16527
  0.20  [AIR][Rule] dense.fixture builder=24262
  0.20  [AIR][EcoLayout] reserved air.eco.2 reactor=768,2160 converters=8 support=12 zone=305
  0.20  [AIR][Rule] dense.fixture builder=7827
  0.20  [AIR][Rule] dense.fixture builder=31581
  0.21  [AIR][Rule] dense.fixture builder=15847
  0.21  [AIR][Rule] dense.fixture builder=8769
  0.22  [AIR][EcoLayout] reserved air.eco.3 reactor=1280,2288 converters=8 support=12 zone=327
  0.27  [AIR][Capacity] own=2/30 usage=6/352 gifts=0 sent=0 excess=0 pressure=false mobile=960 arriving=0 idle=0 ecoStatic=0 working=599 shortage=5706 reason=funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=99993 E=18 bank=999752 pull=352 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=3022/167040
  0.27  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=6666 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  0.43  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=959 shortage=5396 reason=funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=99904 E=110 bank=995572 pull=575 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=2918/161301
  0.43  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=6356 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  0.60  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=959 shortage=5196 reason=funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=2 bank=99812 E=110 bank=990972 pull=575 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=2814/155541
  0.60  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=6156 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  0.77  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=959 shortage=4996 reason=funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=2 bank=99719 E=110 bank=986372 pull=575 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=2710/149781
  0.77  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=5956 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  0.93  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=4796 reason=funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=2 bank=99627 E=110 bank=981772 pull=575 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=2606/144021
  0.93  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=5756 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99581/100000, energy +110.0 bank 979491/1000400, units 17
  1.10  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=4596 reason=funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=2 bank=99534 E=110 bank=977172 pull=575 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=2501/138261
  1.10  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=5556 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.27  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=4396 reason=funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=2 bank=99442 E=110 bank=972572 pull=575 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=2397/132500
  1.27  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=5356 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.43  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=4196 reason=funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=2 bank=99349 E=110 bank=967972 pull=575 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=2293/126740
  1.43  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=5156 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.60  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=3996 reason=funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=2 bank=99257 E=110 bank=963372 pull=575 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=2189/120980
  1.60  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=4956 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.77  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=3796 reason=funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=2 bank=99164 E=110 bank=958772 pull=575 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=2084/115220
  1.77  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=4756 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.93  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=3596 reason=funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=2 bank=99072 E=110 bank=954172 pull=575 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=1980/109459
  1.93  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=4556 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99026/100000, energy +110.0 bank 951891/1000400, units 17
  2.00  [Playtest] target team 0 at (1800, 1650) from its start position
  2.00  [Playtest] camera requested (1800,1650) height=2200
  2.00  [Playtest] camera captured name=ta position=(1800,1650) height=2200
  2.00  [Playtest] screenshot at 2.0 min of team 0 at (1800, 1650)
  2.10  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=3396 reason=funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=2 bank=98979 E=110 bank=949572 pull=575 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=1876/103699
  2.10  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=4356 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  2.27  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=3196 reason=funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=2 bank=98887 E=110 bank=944972 pull=575 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=1772/97939
  2.27  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=4156 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  2.43  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=2996 reason=funded workload
  2.43  [AIR][Economy] BOOTSTRAP M=2 bank=98794 E=110 bank=940372 pull=575 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=1667/92178
  2.43  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=3956 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  2.60  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=960 shortage=2796 reason=funded workload
  2.60  [AIR][Economy] BOOTSTRAP M=2 bank=98702 E=110 bank=935772 pull=575 plants=0/0 aircraftDemand=0/0
  2.60  [AIR][Projects] energyQueued=0 committed=1563/86418
  2.60  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=3756 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  2.77  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=959 shortage=2596 reason=funded workload
  2.77  [AIR][Economy] BOOTSTRAP M=2 bank=98609 E=110 bank=931172 pull=575 plants=0/0 aircraftDemand=0/0
  2.77  [AIR][Projects] energyQueued=0 committed=1459/80659
  2.77  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=3556 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  2.93  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=959 shortage=2396 reason=funded workload
  2.93  [AIR][Economy] BOOTSTRAP M=2 bank=98517 E=110 bank=926572 pull=575 plants=0/0 aircraftDemand=0/0
  2.93  [AIR][Projects] energyQueued=0 committed=1355/74900
  2.93  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=3356 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 98471/100000, energy +110.0 bank 924291/1000400, units 17
  3.10  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=959 shortage=2196 reason=funded workload
  3.10  [AIR][Economy] BOOTSTRAP M=2 bank=98424 E=110 bank=921972 pull=575 plants=0/0 aircraftDemand=0/0
  3.10  [AIR][Projects] energyQueued=0 committed=1251/69141
  3.10  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=3156 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=959 shortage=1996 reason=funded workload
  3.27  [AIR][Economy] BOOTSTRAP M=2 bank=98332 E=110 bank=917372 pull=575 plants=0/0 aircraftDemand=0/0
  3.27  [AIR][Projects] energyQueued=0 committed=1146/63382
  3.27  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=2956 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=959 shortage=1796 reason=funded workload
  3.43  [AIR][Economy] BOOTSTRAP M=2 bank=98239 E=110 bank=912772 pull=575 plants=0/0 aircraftDemand=0/0
  3.43  [AIR][Projects] energyQueued=0 committed=1042/57623
  3.43  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=2756 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.60  [AIR][Capacity] own=2/110 usage=10/575 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=0 ecoStatic=0 working=959 shortage=1596 reason=funded workload
  3.60  [AIR][Economy] BOOTSTRAP M=2 bank=98147 E=110 bank=908172 pull=575 plants=0/0 aircraftDemand=0/0
  3.60  [AIR][Projects] energyQueued=0 committed=938/51864
  3.60  [AIR][Workforce] t1=0/3 t2=8/9 targetBP=2556 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
... 512 more
```

## Native lines (all AIs, first 120)

```
  0.17  RESERVE: zone 1 at (896, 1648) facing 1, 6x6 cells: 36 of 36 held
  0.17  RESERVE: armafus at (896, 1648) facing 1 (id 1)
  0.17  RESERVE: zone 2 at (1104, 1744) facing 1, 4x4 cells: 16 of 16 held
  0.17  RESERVE: armmmkr at (1104, 1744) facing 1 (id 2)
  0.17  RESERVE: zone 3 at (1104, 1680) facing 1, 4x4 cells: 16 of 16 held
  0.17  RESERVE: armmmkr at (1104, 1680) facing 1 (id 3)
  0.17  RESERVE: zone 4 at (1104, 1616) facing 1, 4x4 cells: 16 of 16 held
  0.17  RESERVE: armmmkr at (1104, 1616) facing 1 (id 4)
  0.17  RESERVE: zone 5 at (1104, 1552) facing 1, 4x4 cells: 16 of 16 held
  0.17  RESERVE: armmmkr at (1104, 1552) facing 1 (id 5)
  0.17  RESERVE: zone 6 at (1168, 1744) facing 1, 4x4 cells: 16 of 16 held
  0.17  RESERVE: armmmkr at (1168, 1744) facing 1 (id 6)
  0.17  RESERVE: zone 7 at (1168, 1680) facing 1, 4x4 cells: 16 of 16 held
  0.17  RESERVE: armmmkr at (1168, 1680) facing 1 (id 7)
  0.17  RESERVE: zone 8 at (1168, 1616) facing 1, 4x4 cells: 16 of 16 held
  0.17  RESERVE: armmmkr at (1168, 1616) facing 1 (id 8)
  0.17  RESERVE: zone 9 at (1168, 1552) facing 1, 4x4 cells: 16 of 16 held
  0.17  RESERVE: armmmkr at (1168, 1552) facing 1 (id 9)
  0.17  RESERVE: zone 10 at (984, 1768) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (984, 1768) facing 1 (id 10)
  0.17  RESERVE: zone 11 at (984, 1720) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (984, 1720) facing 1 (id 11)
  0.17  RESERVE: zone 12 at (984, 1672) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (984, 1672) facing 1 (id 12)
  0.17  RESERVE: zone 13 at (984, 1624) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (984, 1624) facing 1 (id 13)
  0.17  RESERVE: zone 14 at (984, 1576) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (984, 1576) facing 1 (id 14)
  0.17  RESERVE: zone 15 at (984, 1528) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (984, 1528) facing 1 (id 15)
  0.17  RESERVE: zone 16 at (1032, 1768) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (1032, 1768) facing 1 (id 16)
  0.17  RESERVE: zone 17 at (1032, 1720) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (1032, 1720) facing 1 (id 17)
  0.17  RESERVE: zone 18 at (1032, 1672) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (1032, 1672) facing 1 (id 18)
  0.17  RESERVE: zone 19 at (1032, 1624) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (1032, 1624) facing 1 (id 19)
  0.17  RESERVE: zone 20 at (1032, 1576) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (1032, 1576) facing 1 (id 20)
  0.17  RESERVE: zone 21 at (1032, 1528) facing 1, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotc at (1032, 1528) facing 1 (id 21)
  0.17  RESERVE: zone 22 at (1024, 1648) facing 1, 24x20 cells: 208 of 480 held
  0.18  RESERVE: served armmmkr at (1104, 1744) facing 1 (id 2, 7 of this def still held)
  0.18  RESERVE: zone 23 at (1776, 2024) facing 1, 6x9 cells: 54 of 54 held
  0.18  RESERVE: armap at (1776, 2024) facing 1 (id 22)
  0.18  RESERVE: zone 24 at (1704, 2072) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1704, 2072) facing 1 (id 23)
  0.18  RESERVE: zone 25 at (1704, 2024) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1704, 2024) facing 1 (id 24)
  0.18  RESERVE: zone 26 at (1704, 1976) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1704, 1976) facing 1 (id 25)
  0.18  RESERVE: zone 27 at (1656, 2072) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1656, 2072) facing 1 (id 26)
  0.18  RESERVE: zone 28 at (1656, 2024) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1656, 2024) facing 1 (id 27)
  0.18  RESERVE: zone 29 at (1800, 1880) facing 1, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (1800, 1880) facing 1 (id 28)
  0.18  RESERVE: zone 30 at (1704, 1928) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1704, 1928) facing 1 (id 29)
  0.18  RESERVE: zone 31 at (1704, 1880) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1704, 1880) facing 1 (id 30)
  0.18  RESERVE: zone 32 at (1704, 1832) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1704, 1832) facing 1 (id 31)
  0.18  RESERVE: zone 33 at (1656, 1928) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1656, 1928) facing 1 (id 32)
  0.18  RESERVE: zone 34 at (1656, 1880) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1656, 1880) facing 1 (id 33)
  0.18  RESERVE: zone 35 at (1656, 1832) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1656, 1832) facing 1 (id 34)
  0.18  RESERVE: zone 36 at (1608, 1928) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1608, 1928) facing 1 (id 35)
  0.18  RESERVE: zone 37 at (1608, 1880) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1608, 1880) facing 1 (id 36)
  0.18  RESERVE: zone 38 at (1608, 1832) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1608, 1832) facing 1 (id 37)
  0.18  RESERVE: zone 39 at (1560, 1928) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1560, 1928) facing 1 (id 38)
  0.18  RESERVE: zone 40 at (1560, 1880) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1560, 1880) facing 1 (id 39)
  0.18  RESERVE: zone 41 at (1560, 1832) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1560, 1832) facing 1 (id 40)
  0.18  RESERVE: zone 42 at (1512, 1928) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1512, 1928) facing 1 (id 41)
  0.18  RESERVE: zone 43 at (1512, 1880) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1512, 1880) facing 1 (id 42)
  0.18  RESERVE: zone 44 at (1512, 1832) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1512, 1832) facing 1 (id 43)
  0.18  RESERVE: zone 45 at (1464, 1928) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1464, 1928) facing 1 (id 44)
  0.18  RESERVE: zone 46 at (1464, 1880) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1464, 1880) facing 1 (id 45)
  0.18  RESERVE: zone 47 at (1464, 1832) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1464, 1832) facing 1 (id 46)
  0.18  RESERVE: zone 48 at (1416, 1928) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1416, 1928) facing 1 (id 47)
  0.18  RESERVE: zone 49 at (1416, 1880) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1416, 1880) facing 1 (id 48)
  0.18  RESERVE: zone 50 at (1800, 1736) facing 1, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (1800, 1736) facing 1 (id 49)
  0.18  RESERVE: zone 51 at (1704, 1784) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1704, 1784) facing 1 (id 50)
  0.18  RESERVE: zone 52 at (1704, 1736) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1704, 1736) facing 1 (id 51)
  0.18  RESERVE: zone 53 at (1704, 1688) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1704, 1688) facing 1 (id 52)
  0.18  RESERVE: zone 54 at (1656, 1784) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1656, 1784) facing 1 (id 53)
  0.18  RESERVE: zone 55 at (1656, 1736) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1656, 1736) facing 1 (id 54)
  0.18  RESERVE: zone 56 at (1656, 1688) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1656, 1688) facing 1 (id 55)
  0.18  RESERVE: zone 57 at (1608, 1784) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1608, 1784) facing 1 (id 56)
  0.18  RESERVE: zone 58 at (1608, 1736) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1608, 1736) facing 1 (id 57)
  0.18  RESERVE: zone 59 at (1608, 1688) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1608, 1688) facing 1 (id 58)
  0.18  RESERVE: zone 60 at (1560, 1784) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1560, 1784) facing 1 (id 59)
```
