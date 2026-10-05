# Playtest report: PASS

- Verdict: **PASS** (reached 12 min)
- Game time reached: 12.1 min (frame 21780); wall 97 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:54:58
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T165458Z-8aef9e89\runs\20261004T165639Z-e6cfcb0f\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | seen at 4.6 min | `[t=00:01:02.664935][f=0008250] [SeaBlock] PASS packed armfmkr count=12 edges=13` |
| expect `t2` | seen at 3.5 min | `[t=00:00:58.262842][f=0006270] [SeaBlock] PASS packed armuwmmm count=8 edges=6` |
| expect `shipyard` | seen at 2.1 min | `[t=00:00:51.610441][f=0003720] [SeaBlock] PASS factory assist armsy` |
| expect `amphibious` | seen at 1.7 min | `[t=00:00:50.011781][f=0003000] [SeaBlock] PASS factory assist armamsub` |
| expect `fusion-support` | seen at 3.1 min | `[t=00:00:56.662502][f=0005550] [SeaBlock] PASS fusion assist` |
| expect `rear-fusion` | seen at 4.1 min | `[t=00:01:00.798552][f=0007410] [SeaBlock] PASS rear fusion completed` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T165458Z-8aef9e89\runs\20261004T165639Z-e6cfcb0f\screen_2026-10-04_16-55-58-740.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T165458Z-8aef9e89\runs\20261004T165639Z-e6cfcb0f\screen_2026-10-04_16-56-03-195.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T165458Z-8aef9e89\runs\20261004T165639Z-e6cfcb0f\screen_2026-10-04_16-56-11-733.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T165458Z-8aef9e89\runs\20261004T165639Z-e6cfcb0f\screen_2026-10-04_16-56-12-121.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T165458Z-8aef9e89\runs\20261004T165639Z-e6cfcb0f\screen_2026-10-04_16-56-33-072.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 29
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 29
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  0.73  [Playtest] finished armfmkr team 0 at 0.73 min
  0.74  [Playtest] finished armfmkr team 0 at 0.74 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 98475/100100, energy +178.0 bank 952433/1001050, units 22
  1.13  [Playtest] finished armnanotcplat team 0 at 1.13 min
  1.27  [Playtest] finished armnanotcplat team 0 at 1.27 min
  1.40  [Playtest] finished armuwmmm team 0 at 1.40 min
  1.65  [Playtest] finished armuwmmm team 0 at 1.65 min
  1.65  [Playtest] finished armnanotcplat team 0 at 1.65 min
  1.81  [Playtest] finished armuwmmm team 0 at 1.81 min
  1.88  [Playtest] finished armnanotcplat team 0 at 1.88 min
  1.90  [Playtest] finished armuwmmm team 0 at 1.90 min
  1.99  [Playtest] finished armnanotcplat team 0 at 1.99 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +45.4 bank 95850/100100, energy +178.0 bank 817067/1001050, units 32
  2.04  [Playtest] finished armnanotcplat team 0 at 2.04 min
  2.06  [Playtest] finished armnanotcplat team 0 at 2.06 min
  2.36  [Playtest] finished armnanotcplat team 0 at 2.36 min
  2.43  [Playtest] finished armnanotcplat team 0 at 2.43 min
  2.49  [Playtest] finished armuwmmm team 0 at 2.49 min
  2.56  [Playtest] finished armnanotcplat team 0 at 2.56 min
  2.66  [Playtest] finished armnanotcplat team 0 at 2.66 min
  2.70  [Playtest] finished armnanotcplat team 0 at 2.70 min
  2.83  [Playtest] finished armnanotcplat team 0 at 2.83 min
  2.92  [Playtest] finished armuwmmm team 0 at 2.92 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 90795/100100, energy +178.0 bank 670733/1001050, units 43
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.08  [Playtest] finished armnanotcplat team 0 at 3.08 min
  3.19  [Playtest] finished armnanotcplat team 0 at 3.19 min
  3.36  [Playtest] finished armuwmmm team 0 at 3.36 min
  3.37  [Playtest] finished armnanotcplat team 0 at 3.37 min
  3.44  [Playtest] finished armnanotcplat team 0 at 3.44 min
  3.47  [Playtest] finished armuwmmm team 0 at 3.47 min
  3.53  [Playtest] finished armnanotcplat team 0 at 3.53 min
  3.55  [Playtest] finished armnanotcplat team 0 at 3.55 min
  3.60  [Playtest] finished armnanotcplat team 0 at 3.60 min
  3.66  [Playtest] finished armnanotcplat team 0 at 3.66 min
  3.69  [Playtest] finished armnanotcplat team 0 at 3.69 min
  3.75  [Playtest] finished armnanotcplat team 0 at 3.75 min
  3.79  [Playtest] finished armnanotcplat team 0 at 3.79 min
  3.84  [Playtest] finished armnanotcplat team 0 at 3.84 min
  3.87  [Playtest] finished armnanotcplat team 0 at 3.87 min
  3.90  [Playtest] finished armnanotcplat team 0 at 3.90 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 84419/100100, energy +178.0 bank 603566/1001050, units 56
  4.11  [Playtest] finished armuwfus team 0 at 4.11 min
  4.12  [Playtest] finished armfmkr team 0 at 4.12 min
  4.13  [Playtest] finished armfmkr team 0 at 4.13 min
  4.28  [Playtest] finished armfmkr team 0 at 4.28 min
  4.29  [Playtest] finished armfmkr team 0 at 4.29 min
  4.31  [Playtest] finished armfmkr team 0 at 4.31 min
  4.32  [Playtest] finished armfmkr team 0 at 4.32 min
  4.40  [Playtest] finished armfmkr team 0 at 4.40 min
  4.42  [Playtest] finished armfmkr team 0 at 4.42 min
  4.49  [Playtest] finished armfmkr team 0 at 4.49 min
  4.58  [Playtest] finished armfmkr team 0 at 4.58 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 83015/100100, energy +1378.0 bank 657009/1003550, units 65
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 83135/100100, energy +1378.0 bank 739689/1003550, units 65
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  6.33  [Playtest] finished armnanotcplat team 0 at 6.33 min
  6.34  [Playtest] finished armnanotcplat team 0 at 6.34 min
  6.44  [Playtest] finished armnanotcplat team 0 at 6.44 min
  6.49  [Playtest] finished armnanotcplat team 0 at 6.49 min
  6.52  [Playtest] finished armnanotcplat team 0 at 6.52 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 77259/100100, energy +1378.0 bank 741868/1003550, units 76
  8.00  [Playtest] eco team 0 at 8.0 min: metal +25.8 bank 78606/100100, energy +1378.0 bank 753351/1003550, units 76
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.8 bank 80151/100100, energy +1378.0 bank 753351/1003550, units 76
 10.00  [Playtest] eco team 0 at 10.0 min: metal +2.4 bank 81140/100100, energy +1378.0 bank 752668/1003550, units 75
 11.00  [Playtest] eco team 0 at 11.0 min: metal +25.8 bank 80244/100100, energy +1378.0 bank 753351/1003550, units 76
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +25.8 bank 81789/100100, energy +1378.0 bank 753351/1003550, units 76
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (5832, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10568) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (5784, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10568) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (5736, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10568) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (5688, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10568) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (5640, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10568) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (5832, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10520) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (5784, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10520) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (5736, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10520) facing 2 (id 8)
  0.18  RESERVE: corridor 9 at (5824, 11024) facing 0, 12x30 cells: 240 of 360 held
  0.18  RESERVE: corridor 10 at (6600, 11028) facing 0, 13x31 cells: 273 of 403 held
  0.18  RESERVE: zone 11 at (5824, 11184) facing 2, 40x40 cells: 1268 of 1600 held
  0.18  RESERVE: zone 11 released
  0.18  RESERVE: zone 12 at (5696, 11184) facing 2, 40x40 cells: 1276 of 1600 held
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: zone 13 at (5952, 11184) facing 2, 40x40 cells: 1260 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (5952, 11088) facing 2: 8 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 13 released
  0.18  RESERVE: zone 14 at (6080, 11184) facing 2, 40x40 cells: 1312 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6080, 11088) facing 2: 16 of 16 slots (group 4, held, zone)
  0.18  RESERVE: armuwfus at (6144, 11312) facing 2 (id 33)
  0.18  RESERVE: packed armuwfus at (6144, 11312) facing 2 in zone 14, 313 from a turret (id 33, group 0, 771 candidates)
  0.20  RESERVE: set of 4 armfmkr from (6200, 11208), 0 cell(s) from a turret, growing (3, 0) cells a step (group 5, id 34)
  0.20  RESERVE: served armfmkr at (6200, 11208) facing 2 (id 34, 3 of this def still held)
  0.21  RESERVE: set of 2 armuwmmm from (6104, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 6, id 38)
  0.21  RESERVE: served armuwmmm at (6104, 11056) facing 2 (id 38, 1 of this def still held)
  0.21  EXP: approach: armcs(12343) at (6076, 10476) walks to (6427, 11166), 184 from the armfmkr site (6248, 11208)
  0.22  RESERVE: zone 15 at (6888, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6888, 10536) facing 2 (id 40)
  0.22  RESERVE: zone 16 at (6840, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6840, 10536) facing 2 (id 41)
  0.22  RESERVE: zone 17 at (6792, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6792, 10536) facing 2 (id 42)
  0.22  RESERVE: zone 18 at (6744, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6744, 10536) facing 2 (id 43)
  0.22  RESERVE: zone 19 at (6696, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6696, 10536) facing 2 (id 44)
  0.22  RESERVE: zone 20 at (6888, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6888, 10488) facing 2 (id 45)
  0.22  RESERVE: zone 21 at (6840, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6840, 10488) facing 2 (id 46)
  0.22  RESERVE: zone 15 released
  0.22  RESERVE: zone 16 released
  0.22  RESERVE: zone 17 released
  0.22  RESERVE: zone 18 released
  0.22  RESERVE: zone 19 released
  0.22  RESERVE: zone 20 released
  0.22  RESERVE: zone 21 released
  0.22  RESERVE: zone 22 at (6872, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6872, 10616) facing 2 (id 47)
  0.22  RESERVE: zone 23 at (6824, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6824, 10616) facing 2 (id 48)
  0.22  RESERVE: zone 24 at (6776, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6776, 10616) facing 2 (id 49)
  0.22  RESERVE: zone 25 at (6728, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6728, 10616) facing 2 (id 50)
  0.22  RESERVE: zone 26 at (6680, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6680, 10616) facing 2 (id 51)
  0.22  RESERVE: zone 27 at (6872, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6872, 10568) facing 2 (id 52)
  0.22  RESERVE: zone 28 at (6824, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6824, 10568) facing 2 (id 53)
  0.22  RESERVE: zone 29 at (6776, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6776, 10568) facing 2 (id 54)
  0.22  RESERVE: zone 1 at (6432, 1664) facing 0, 6x6 cells: 36 of 36 held
  0.22  RESERVE: armsy at (6432, 1664) facing 0 (id 1)
  0.22  RESERVE: corridor 2 at (6432, 1952) facing 0, 12x30 cells: 360 of 360 held
  0.22  RESERVE: zone 3 at (6408, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6408, 1544) facing 0 (id 2)
  0.22  RESERVE: zone 4 at (6456, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6456, 1544) facing 0 (id 3)
  0.22  RESERVE: zone 5 at (6504, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1544) facing 0 (id 4)
  0.22  RESERVE: zone 6 at (6552, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6552, 1544) facing 0 (id 5)
  0.22  RESERVE: zone 7 at (6600, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6600, 1544) facing 0 (id 6)
  0.22  RESERVE: zone 8 at (6408, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6408, 1592) facing 0 (id 7)
  0.22  RESERVE: zone 9 at (6456, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6456, 1592) facing 0 (id 8)
  0.22  RESERVE: zone 10 at (6504, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1592) facing 0 (id 9)
  0.22  RESERVE: zone 11 at (6552, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6552, 1592) facing 0 (id 10)
  0.22  RESERVE: zone 12 at (6600, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6600, 1592) facing 0 (id 11)
  0.22  RESERVE: zone 3 released
  0.22  RESERVE: zone 4 released
  0.22  RESERVE: zone 5 released
  0.22  RESERVE: zone 6 released
  0.22  RESERVE: zone 7 released
  0.22  RESERVE: zone 8 released
  0.22  RESERVE: zone 9 released
  0.22  RESERVE: zone 10 released
  0.22  RESERVE: zone 11 released
  0.22  RESERVE: zone 12 released
  0.22  RESERVE: zone 13 at (6344, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6344, 1560) facing 0 (id 12)
  0.22  RESERVE: zone 14 at (6392, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6392, 1560) facing 0 (id 13)
  0.22  RESERVE: zone 15 at (6440, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1560) facing 0 (id 14)
  0.22  RESERVE: zone 16 at (6488, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1560) facing 0 (id 15)
  0.22  RESERVE: zone 17 at (6536, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6536, 1560) facing 0 (id 16)
  0.22  RESERVE: zone 18 at (6344, 1608) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6344, 1608) facing 0 (id 17)
  0.22  RESERVE: zone 13 released
  0.22  RESERVE: zone 14 released
  0.22  RESERVE: zone 15 released
  0.22  RESERVE: zone 16 released
```
