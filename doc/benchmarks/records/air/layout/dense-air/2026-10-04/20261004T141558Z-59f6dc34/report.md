# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 8.1 min (frame 14521); wall 75 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:14:40
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: dense-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141440Z-f1b087fa\runs\20261004T141558Z-59f6dc34\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `armmmkr` | **missing** (by 8 min) | |
| forbid `runtime` | clean |  |

## Failures

- 'armmmkr' not seen by 8.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141440Z-f1b087fa\runs\20261004T141558Z-59f6dc34\screen_2026-10-04_14-15-30-827.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141440Z-f1b087fa\runs\20261004T141558Z-59f6dc34\screen_2026-10-04_14-15-43-815.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141440Z-f1b087fa\runs\20261004T141558Z-59f6dc34\screen_2026-10-04_14-15-47-872.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\layout\dense-air\glacial\20261004T141440Z-f1b087fa\runs\20261004T141558Z-59f6dc34\screen_2026-10-04_14-15-52-803.png

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
  0.18  [AIR][Claim] cancel unowned native order armmmkr
  0.18  [AIR][Layout] cluster=0 labs=6 at=1392,2103
  0.18  [AIR][EcoLayout] reserved air.eco.1 reactor=384,1776 converters=8 support=12 zone=156
  0.18  [AIR][Layout] cluster=1 labs=6 at=1008,1143
  0.20  [AIR][Claim] cancel unowned native order armmmkr
  0.20  [AIR][Claim] cancel unowned native order armmmkr
  0.20  [AIR][Claim] cancel unowned native order armmmkr
  0.20  [AIR][EcoLayout] reserved air.eco.2 reactor=768,2160 converters=8 support=12 zone=305
  0.22  [AIR][Claim] cancel unowned native order armmmkr
  0.22  [AIR][Claim] cancel unowned native order armmmkr
  0.22  [AIR][Claim] cancel unowned native order armmmkr
  0.22  [AIR][Claim] cancel unowned native order armmmkr
  0.22  [AIR][EcoLayout] reserved air.eco.3 reactor=1280,2288 converters=8 support=12 zone=327
  0.23  [AIR][Claim] cancel unowned native order armmmkr
  0.23  [AIR][Claim] cancel unowned native order armmmkr
  0.25  [AIR][Claim] cancel unowned native order armmmkr
  0.25  [AIR][Claim] cancel unowned native order armmmkr
  0.25  [AIR][Claim] cancel unowned native order armmmkr
  0.25  [AIR][Claim] cancel unowned native order armmmkr
  0.27  [AIR][Claim] cancel unowned native order armmmkr
  0.27  [AIR][Capacity] own=2/30 usage=1/72 gifts=0 sent=0 excess=0 pressure=false mobile=960 arriving=0 idle=720 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=100000 E=18 bank=1000390 pull=72 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=8/8 targetBP=960 floating=true savingLab=false
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
  0.28  [AIR][Claim] cancel unowned native order armmmkr
  0.28  [AIR][Claim] cancel unowned native order armmmkr
  0.28  [AIR][Claim] cancel unowned native order armmmkr
  0.28  [AIR][Claim] cancel unowned native order armmmkr
  0.30  [AIR][Claim] cancel unowned native order armmmkr
  0.30  [AIR][Claim] cancel unowned native order armmmkr
  0.30  [AIR][Claim] cancel unowned native order armmmkr
  0.32  [AIR][Claim] cancel unowned native order armmmkr
  0.32  [AIR][Claim] cancel unowned native order armmmkr
  0.32  [AIR][Claim] cancel unowned native order armmmkr
  0.33  [AIR][Claim] cancel unowned native order armmmkr
  0.33  [AIR][Claim] cancel unowned native order armmmkr
  0.35  [AIR][Claim] cancel unowned native order armmmkr
  0.35  [AIR][Claim] cancel unowned native order armmmkr
  0.35  [AIR][Claim] cancel unowned native order armmmkr
  0.37  [AIR][Claim] cancel unowned native order armmmkr
  0.37  [AIR][Claim] cancel unowned native order armmmkr
  0.38  [AIR][Claim] cancel unowned native order armmmkr
  0.38  [AIR][Claim] cancel unowned native order armmmkr
  0.38  [AIR][Claim] cancel unowned native order armmmkr
  0.38  [AIR][Claim] cancel unowned native order armmmkr
  0.40  [AIR][Claim] cancel unowned native order armmmkr
  0.42  [AIR][Claim] cancel unowned native order armmmkr
  0.42  [AIR][Claim] cancel unowned native order armmmkr
  0.42  [AIR][Claim] cancel unowned native order armmmkr
  0.42  [AIR][Claim] cancel unowned native order armmmkr
  0.43  [AIR][Claim] cancel unowned native order armmmkr
  0.43  [AIR][Capacity] own=2/110 usage=5/287 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=480 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=99977 E=110 bank=999222 pull=287 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=8/8 targetBP=960 floating=true savingLab=false
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
  0.45  [AIR][Claim] cancel unowned native order armmmkr
  0.45  [AIR][Claim] cancel unowned native order armmmkr
  0.45  [AIR][Claim] cancel unowned native order armmmkr
  0.47  [AIR][Claim] cancel unowned native order armmmkr
  0.47  [AIR][Claim] cancel unowned native order armmmkr
  0.48  [AIR][Claim] cancel unowned native order armmmkr
  0.48  [AIR][Claim] cancel unowned native order armmmkr
  0.50  [AIR][Claim] cancel unowned native order armmmkr
  0.50  [AIR][Claim] cancel unowned native order armmmkr
  0.50  [AIR][Claim] cancel unowned native order armmmkr
  0.52  [AIR][Claim] cancel unowned native order armmmkr
  0.52  [AIR][Claim] cancel unowned native order armmmkr
  0.53  [AIR][Claim] cancel unowned native order armmmkr
  0.53  [AIR][Claim] cancel unowned native order armmmkr
  0.53  [AIR][Claim] cancel unowned native order armmmkr
  0.55  [AIR][Claim] cancel unowned native order armmmkr
  0.55  [AIR][Claim] cancel unowned native order armmmkr
  0.57  [AIR][Claim] cancel unowned native order armmmkr
  0.57  [AIR][Claim] cancel unowned native order armmmkr
  0.57  [AIR][Claim] cancel unowned native order armmmkr
  0.58  [AIR][Claim] cancel unowned native order armmmkr
  0.58  [AIR][Claim] cancel unowned native order armmmkr
  0.58  [AIR][Claim] cancel unowned native order armmmkr
  0.60  [AIR][Claim] cancel unowned native order armmmkr
  0.60  [AIR][Claim] cancel unowned native order armmmkr
  0.60  [AIR][Capacity] own=2/110 usage=5/287 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=480 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=2 bank=99941 E=110 bank=997443 pull=287 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=8/8 targetBP=960 floating=true savingLab=false
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
  0.62  [AIR][Claim] cancel unowned native order armmmkr
  0.62  [AIR][Claim] cancel unowned native order armmmkr
  0.63  [AIR][Claim] cancel unowned native order armmmkr
  0.63  [AIR][Claim] cancel unowned native order armmmkr
  0.65  [AIR][Claim] cancel unowned native order armmmkr
  0.65  [AIR][Claim] cancel unowned native order armmmkr
  0.67  [AIR][Claim] cancel unowned native order armmmkr
  0.67  [AIR][Claim] cancel unowned native order armmmkr
  0.68  [AIR][Claim] cancel unowned native order armmmkr
  0.68  [AIR][Claim] cancel unowned native order armmmkr
  0.68  [AIR][Claim] cancel unowned native order armmmkr
  0.70  [AIR][Claim] cancel unowned native order armmmkr
  0.70  [AIR][Claim] cancel unowned native order armmmkr
  0.72  [AIR][Claim] cancel unowned native order armmmkr
  0.72  [AIR][Claim] cancel unowned native order armmmkr
  0.72  [AIR][Claim] cancel unowned native order armmmkr
  0.73  [AIR][Claim] cancel unowned native order armmmkr
  0.73  [AIR][Claim] cancel unowned native order armmmkr
  0.75  [AIR][Claim] cancel unowned native order armmmkr
  0.75  [AIR][Claim] cancel unowned native order armmmkr
  0.75  [AIR][Claim] cancel unowned native order armmmkr
  0.77  [AIR][Claim] cancel unowned native order armmmkr
  0.77  [AIR][Claim] cancel unowned native order armmmkr
  0.77  [AIR][Capacity] own=2/110 usage=5/287 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=480 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=2 bank=99905 E=110 bank=995693 pull=287 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=8/8 targetBP=960 floating=true savingLab=false
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
  0.78  [AIR][Claim] cancel unowned native order armmmkr
  0.78  [AIR][Claim] cancel unowned native order armmmkr
  0.78  [AIR][Claim] cancel unowned native order armmmkr
  0.80  [AIR][Claim] cancel unowned native order armmmkr
  0.80  [AIR][Claim] cancel unowned native order armmmkr
  0.82  [AIR][Claim] cancel unowned native order armmmkr
  0.82  [AIR][Claim] cancel unowned native order armmmkr
  0.82  [AIR][Claim] cancel unowned native order armmmkr
  0.83  [AIR][Claim] cancel unowned native order armmmkr
  0.83  [AIR][Claim] cancel unowned native order armmmkr
  0.85  [AIR][Claim] cancel unowned native order armmmkr
  0.85  [AIR][Claim] cancel unowned native order armmmkr
  0.85  [AIR][Claim] cancel unowned native order armmmkr
  0.87  [AIR][Claim] cancel unowned native order armmmkr
  0.87  [AIR][Claim] cancel unowned native order armmmkr
  0.88  [AIR][Claim] cancel unowned native order armmmkr
  0.88  [AIR][Claim] cancel unowned native order armmmkr
  0.88  [AIR][Claim] cancel unowned native order armmmkr
  0.90  [AIR][Claim] cancel unowned native order armmmkr
  0.90  [AIR][Claim] cancel unowned native order armmmkr
  0.92  [AIR][Claim] cancel unowned native order armmmkr
  0.92  [AIR][Claim] cancel unowned native order armmmkr
  0.92  [AIR][Claim] cancel unowned native order armmmkr
  0.93  [AIR][Claim] cancel unowned native order armmmkr
  0.93  [AIR][Claim] cancel unowned native order armmmkr
  0.93  [AIR][Capacity] own=2/110 usage=5/287 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=480 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=2 bank=99869 E=110 bank=993972 pull=287 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=8/8 targetBP=960 floating=true savingLab=false
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
  0.95  [AIR][Claim] cancel unowned native order armmmkr
  0.95  [AIR][Claim] cancel unowned native order armmmkr
  0.95  [AIR][Claim] cancel unowned native order armmmkr
  0.97  [AIR][Claim] cancel unowned native order armmmkr
  0.97  [AIR][Claim] cancel unowned native order armmmkr
  0.98  [AIR][Claim] cancel unowned native order armmmkr
  0.98  [AIR][Claim] cancel unowned native order armmmkr
  0.98  [AIR][Claim] cancel unowned native order armmmkr
  1.00  [AIR][Claim] cancel unowned native order armmmkr
  1.00  [AIR][Claim] cancel unowned native order armmmkr
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99851/100000, energy +110.0 bank 993243/1000400, units 13
  1.02  [AIR][Claim] cancel unowned native order armmmkr
  1.02  [AIR][Claim] cancel unowned native order armmmkr
  1.02  [AIR][Claim] cancel unowned native order armmmkr
  1.03  [AIR][Claim] cancel unowned native order armmmkr
  1.03  [AIR][Claim] cancel unowned native order armmmkr
  1.05  [AIR][Claim] cancel unowned native order armmmkr
  1.05  [AIR][Claim] cancel unowned native order armmmkr
  1.05  [AIR][Claim] cancel unowned native order armmmkr
  1.07  [AIR][Claim] cancel unowned native order armmmkr
  1.07  [AIR][Claim] cancel unowned native order armmmkr
  1.08  [AIR][Claim] cancel unowned native order armmmkr
  1.08  [AIR][Claim] cancel unowned native order armmmkr
  1.08  [AIR][Claim] cancel unowned native order armmmkr
  1.10  [AIR][Claim] cancel unowned native order armmmkr
  1.10  [AIR][Claim] cancel unowned native order armmmkr
  1.10  [AIR][Capacity] own=2/110 usage=5/287 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=480 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=2 bank=99832 E=110 bank=992193 pull=287 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/3 t2=8/8 targetBP=960 floating=true savingLab=false
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
  1.12  [AIR][Claim] cancel unowned native order armmmkr
  1.12  [AIR][Claim] cancel unowned native order armmmkr
  1.12  [AIR][Claim] cancel unowned native order armmmkr
  1.13  [AIR][Claim] cancel unowned native order armmmkr
  1.13  [AIR][Claim] cancel unowned native order armmmkr
  1.15  [AIR][Claim] cancel unowned native order armmmkr
  1.15  [AIR][Claim] cancel unowned native order armmmkr
  1.15  [AIR][Claim] cancel unowned native order armmmkr
  1.17  [AIR][Claim] cancel unowned native order armmmkr
  1.17  [AIR][Claim] cancel unowned native order armmmkr
  1.18  [AIR][Claim] cancel unowned native order armmmkr
  1.18  [AIR][Claim] cancel unowned native order armmmkr
  1.18  [AIR][Claim] cancel unowned native order armmmkr
  1.20  [AIR][Claim] cancel unowned native order armmmkr
  1.20  [AIR][Claim] cancel unowned native order armmmkr
  1.22  [AIR][Claim] cancel unowned native order armmmkr
  1.22  [AIR][Claim] cancel unowned native order armmmkr
  1.22  [AIR][Claim] cancel unowned native order armmmkr
  1.23  [AIR][Claim] cancel unowned native order armmmkr
  1.23  [AIR][Claim] cancel unowned native order armmmkr
  1.25  [AIR][Claim] cancel unowned native order armmmkr
  1.25  [AIR][Claim] cancel unowned native order armmmkr
  1.25  [AIR][Claim] cancel unowned native order armmmkr
  1.27  [AIR][Claim] cancel unowned native order armmmkr
  1.27  [AIR][Claim] cancel unowned native order armmmkr
  1.27  [AIR][Capacity] own=2/110 usage=5/287 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=480 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=2 bank=99796 E=110 bank=990472 pull=287 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/3 t2=8/8 targetBP=960 floating=true savingLab=false
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
  1.28  [AIR][Claim] cancel unowned native order armmmkr
  1.28  [AIR][Claim] cancel unowned native order armmmkr
  1.28  [AIR][Claim] cancel unowned native order armmmkr
  1.30  [AIR][Claim] cancel unowned native order armmmkr
  1.30  [AIR][Claim] cancel unowned native order armmmkr
  1.32  [AIR][Claim] cancel unowned native order armmmkr
  1.32  [AIR][Claim] cancel unowned native order armmmkr
  1.32  [AIR][Claim] cancel unowned native order armmmkr
  1.33  [AIR][Claim] cancel unowned native order armmmkr
  1.33  [AIR][Claim] cancel unowned native order armmmkr
  1.35  [AIR][Claim] cancel unowned native order armmmkr
  1.35  [AIR][Claim] cancel unowned native order armmmkr
  1.35  [AIR][Claim] cancel unowned native order armmmkr
  1.37  [AIR][Claim] cancel unowned native order armmmkr
  1.37  [AIR][Claim] cancel unowned native order armmmkr
  1.38  [AIR][Claim] cancel unowned native order armmmkr
  1.38  [AIR][Claim] cancel unowned native order armmmkr
  1.38  [AIR][Claim] cancel unowned native order armmmkr
  1.40  [AIR][Claim] cancel unowned native order armmmkr
  1.40  [AIR][Claim] cancel unowned native order armmmkr
  1.42  [AIR][Claim] cancel unowned native order armmmkr
  1.42  [AIR][Claim] cancel unowned native order armmmkr
  1.42  [AIR][Claim] cancel unowned native order armmmkr
  1.43  [AIR][Claim] cancel unowned native order armmmkr
  1.43  [AIR][Claim] cancel unowned native order armmmkr
  1.43  [AIR][Capacity] own=2/110 usage=5/287 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=480 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=2 bank=99760 E=110 bank=988693 pull=287 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=8/8 targetBP=960 floating=true savingLab=false
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
  1.45  [AIR][Claim] cancel unowned native order armmmkr
  1.45  [AIR][Claim] cancel unowned native order armmmkr
  1.45  [AIR][Claim] cancel unowned native order armmmkr
  1.47  [AIR][Claim] cancel unowned native order armmmkr
  1.47  [AIR][Claim] cancel unowned native order armmmkr
  1.48  [AIR][Claim] cancel unowned native order armmmkr
  1.48  [AIR][Claim] cancel unowned native order armmmkr
  1.48  [AIR][Claim] cancel unowned native order armmmkr
  1.50  [AIR][Claim] cancel unowned native order armmmkr
  1.50  [AIR][Claim] cancel unowned native order armmmkr
  1.52  [AIR][Claim] cancel unowned native order armmmkr
  1.52  [AIR][Claim] cancel unowned native order armmmkr
  1.52  [AIR][Claim] cancel unowned native order armmmkr
  1.53  [AIR][Claim] cancel unowned native order armmmkr
  1.53  [AIR][Claim] cancel unowned native order armmmkr
  1.55  [AIR][Claim] cancel unowned native order armmmkr
  1.55  [AIR][Claim] cancel unowned native order armmmkr
  1.55  [AIR][Claim] cancel unowned native order armmmkr
  1.57  [AIR][Claim] cancel unowned native order armmmkr
  1.57  [AIR][Claim] cancel unowned native order armmmkr
  1.58  [AIR][Claim] cancel unowned native order armmmkr
  1.58  [AIR][Claim] cancel unowned native order armmmkr
  1.58  [AIR][Claim] cancel unowned native order armmmkr
  1.60  [AIR][Claim] cancel unowned native order armmmkr
  1.60  [AIR][Claim] cancel unowned native order armmmkr
  1.60  [AIR][Capacity] own=2/110 usage=5/287 gifts=0 sent=0 excess=0 pressure=true mobile=960 arriving=0 idle=480 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=2 bank=99724 E=110 bank=986972 pull=287 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=8/8 targetBP=960 floating=true savingLab=false
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
... 1563 more
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
  0.18  RESERVE: restored armmmkr at (1104, 1744) (id 2)
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
```
