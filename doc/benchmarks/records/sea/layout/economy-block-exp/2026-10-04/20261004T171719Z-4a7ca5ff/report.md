# Playtest report: PASS

- Verdict: **PASS** (reached 12 min)
- Game time reached: 12.0 min (frame 21600); wall 125 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:15:10
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T171510Z-646b82b1\runs\20261004T171719Z-4a7ca5ff\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | seen at 5.0 min | `[t=00:01:21.584802][f=0008940] [SeaBlock] PASS packed armfmkr count=12 edges=17` |
| expect `t2` | seen at 3.7 min | `[t=00:01:15.472365][f=0006720] [SeaBlock] PASS packed armuwmmm count=8 edges=4` |
| expect `shipyard` | seen at 1.9 min | `[t=00:01:01.112710][f=0003360] [SeaBlock] PASS factory assist armsy` |
| expect `amphibious` | seen at 2.2 min | `[t=00:01:02.555606][f=0003960] [SeaBlock] PASS factory assist armamsub` |
| expect `fusion-support` | seen at 4.0 min | `[t=00:01:17.132108][f=0007260] [SeaBlock] PASS fusion assist` |
| expect `rear-fusion` | seen at 4.6 min | `[t=00:01:19.947083][f=0008310] [SeaBlock] PASS rear fusion completed` |
| expect `square` | seen at 3.9 min | `[t=00:01:16.668065][f=0007080] [SeaBlock] PASS square turret grid count=4 columns=3 rows=2` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T171510Z-646b82b1\runs\20261004T171719Z-4a7ca5ff\screen_2026-10-04_17-16-26-030.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T171510Z-646b82b1\runs\20261004T171719Z-4a7ca5ff\screen_2026-10-04_17-16-34-967.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T171510Z-646b82b1\runs\20261004T171719Z-4a7ca5ff\screen_2026-10-04_17-16-42-959.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T171510Z-646b82b1\runs\20261004T171719Z-4a7ca5ff\screen_2026-10-04_17-16-43-449.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T171510Z-646b82b1\runs\20261004T171719Z-4a7ca5ff\screen_2026-10-04_17-17-13-255.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 39
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 39
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  0.80  [Playtest] finished armfmkr team 0 at 0.80 min
  0.86  [Playtest] finished armfmkr team 0 at 0.86 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 98718/100100, energy +178.0 bank 965858/1001050, units 21
  1.17  [Playtest] finished armnanotcplat team 0 at 1.17 min
  1.26  [Playtest] finished armnanotcplat team 0 at 1.26 min
  1.64  [Playtest] finished armuwmmm team 0 at 1.64 min
  1.74  [Playtest] finished armnanotcplat team 0 at 1.74 min
  1.84  [Playtest] finished armnanotcplat team 0 at 1.84 min
  1.85  [Playtest] finished armuwmmm team 0 at 1.85 min
  1.88  [Playtest] finished armnanotcplat team 0 at 1.88 min
  1.96  [Playtest] finished armnanotcplat team 0 at 1.96 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +24.7 bank 95508/100100, energy +178.0 bank 855531/1001050, units 30
  2.04  [Playtest] finished armuwmmm team 0 at 2.04 min
  2.08  [Playtest] finished armnanotcplat team 0 at 2.08 min
  2.16  [Playtest] finished armuwmmm team 0 at 2.16 min
  2.18  [Playtest] finished armnanotcplat team 0 at 2.18 min
  2.27  [Playtest] finished armnanotcplat team 0 at 2.27 min
  2.45  [Playtest] finished armnanotcplat team 0 at 2.45 min
  2.48  [Playtest] finished armnanotcplat team 0 at 2.48 min
  2.58  [Playtest] finished armnanotcplat team 0 at 2.58 min
  2.69  [Playtest] finished armnanotcplat team 0 at 2.69 min
  2.73  [Playtest] finished armuwmmm team 0 at 2.73 min
  2.79  [Playtest] finished armnanotcplat team 0 at 2.79 min
  2.81  [Playtest] finished armnanotcplat team 0 at 2.81 min
  2.88  [Playtest] finished armnanotcplat team 0 at 2.88 min
  2.97  [Playtest] finished armnanotcplat team 0 at 2.97 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 90626/100100, energy +178.0 bank 681284/1001050, units 45
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.02  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.02  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.03  [Playtest] finished armnanotcplat team 0 at 3.03 min
  3.12  [Playtest] finished armuwmmm team 0 at 3.12 min
  3.19  [Playtest] finished armfmkr team 0 at 3.19 min
  3.40  [Playtest] finished armuwmmm team 0 at 3.40 min
  3.47  [Playtest] finished armfmkr team 0 at 3.47 min
  3.72  [Playtest] finished armuwmmm team 0 at 3.72 min
  3.78  [Playtest] finished armfmkr team 0 at 3.78 min
  3.84  [Playtest] finished armnanotcplat team 0 at 3.84 min
  3.92  [Playtest] finished armnanotcplat team 0 at 3.92 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 87449/100100, energy +178.0 bank 639351/1001050, units 54
  4.01  [Playtest] finished armnanotcplat team 0 at 4.01 min
  4.10  [Playtest] finished armnanotcplat team 0 at 4.10 min
  4.17  [Playtest] finished armnanotcplat team 0 at 4.17 min
  4.24  [Playtest] finished armnanotcplat team 0 at 4.24 min
  4.30  [Playtest] finished armnanotcplat team 0 at 4.30 min
  4.37  [Playtest] finished armnanotcplat team 0 at 4.37 min
  4.41  [Playtest] finished armnanotcplat team 0 at 4.41 min
  4.46  [Playtest] finished armnanotcplat team 0 at 4.46 min
  4.55  [Playtest] finished armnanotcplat team 0 at 4.55 min
  4.61  [Playtest] finished armuwfus team 0 at 4.61 min
  4.62  [Playtest] finished armnanotcplat team 0 at 4.62 min
  4.69  [Playtest] finished armnanotcplat team 0 at 4.69 min
  4.74  [Playtest] finished armfmkr team 0 at 4.74 min
  4.78  [Playtest] finished armfmkr team 0 at 4.78 min
  4.80  [Playtest] finished armfmkr team 0 at 4.80 min
  4.84  [Playtest] finished armfmkr team 0 at 4.84 min
  4.85  [Playtest] finished armfmkr team 0 at 4.85 min
  4.90  [Playtest] finished armnanotcplat team 0 at 4.90 min
  4.93  [Playtest] finished armfmkr team 0 at 4.93 min
  4.96  [Playtest] finished armfmkr team 0 at 4.96 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 81634/100100, energy +1378.0 bank 613261/1003550, units 70
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 81754/100100, energy +1378.0 bank 695941/1003550, units 70
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.02  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.02  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 77000/100100, energy +1378.0 bank 713930/1003550, units 76
  8.00  [Playtest] eco team 0 at 8.0 min: metal +25.8 bank 77866/100100, energy +1378.0 bank 753351/1003550, units 76
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.8 bank 79411/100100, energy +1378.0 bank 753351/1003550, units 76
 10.00  [Playtest] eco team 0 at 10.0 min: metal +2.4 bank 79424/100100, energy +1378.0 bank 752674/1003550, units 75
 11.00  [Playtest] eco team 0 at 11.0 min: metal +25.8 bank 79504/100100, energy +1378.0 bank 753351/1003550, units 76
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +25.8 bank 81049/100100, energy +1378.0 bank 753351/1003550, units 76
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
  0.18  RESERVE: zone 11 at (5952, 11520) facing 2, 40x40 cells: 1552 of 1600 held
  0.18  RESERVE: zone 11 released
  0.18  RESERVE: zone 12 at (6080, 11520) facing 2, 40x40 cells: 1560 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6080, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: zone 13 at (6208, 11520) facing 2, 40x40 cells: 1582 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6208, 11424) facing 2: 8 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 13 released
  0.20  RESERVE: zone 14 at (6336, 11520) facing 2, 40x40 cells: 1550 of 1600 held
  0.20  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6336, 11424) facing 2: 14 of 16 slots (group 4, held, zone)
  0.20  RESERVE: zone 14 released
  0.20  RESERVE: zone 15 at (6464, 11520) facing 2, 40x40 cells: 1535 of 1600 held
  0.20  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6464, 11424) facing 2: 16 of 16 slots (group 5, held, zone)
  0.20  RESERVE: armuwfus at (6480, 11392) facing 2 (id 49)
  0.20  RESERVE: packed armuwfus at (6480, 11392) facing 2 in zone 15, 313 from a turret (id 49, group 0, 950 candidates)
  0.20  RESERVE: set of 4 armfmkr from (6584, 11544), 0 cell(s) from a turret, growing (3, 0) cells a step (group 6, id 50)
  0.20  RESERVE: served armfmkr at (6584, 11544) facing 2 (id 50, 3 of this def still held)
  0.22  RESERVE: zone 16 at (6888, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6888, 10536) facing 2 (id 54)
  0.22  RESERVE: zone 17 at (6840, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6840, 10536) facing 2 (id 55)
  0.22  RESERVE: zone 18 at (6792, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6792, 10536) facing 2 (id 56)
  0.22  RESERVE: zone 19 at (6744, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6744, 10536) facing 2 (id 57)
  0.22  RESERVE: zone 20 at (6696, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6696, 10536) facing 2 (id 58)
  0.22  RESERVE: zone 21 at (6888, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6888, 10488) facing 2 (id 59)
  0.22  RESERVE: zone 22 at (6840, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6840, 10488) facing 2 (id 60)
  0.22  RESERVE: zone 16 released
  0.22  RESERVE: zone 17 released
  0.22  RESERVE: zone 18 released
  0.22  RESERVE: zone 19 released
  0.22  RESERVE: zone 20 released
  0.22  RESERVE: zone 21 released
  0.22  RESERVE: zone 22 released
  0.22  RESERVE: zone 23 at (6872, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6872, 10616) facing 2 (id 61)
  0.22  RESERVE: zone 24 at (6824, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6824, 10616) facing 2 (id 62)
  0.22  RESERVE: zone 25 at (6776, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6776, 10616) facing 2 (id 63)
  0.22  RESERVE: zone 26 at (6728, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6728, 10616) facing 2 (id 64)
  0.22  RESERVE: zone 27 at (6680, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6680, 10616) facing 2 (id 65)
  0.22  RESERVE: zone 28 at (6872, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6872, 10568) facing 2 (id 66)
  0.22  RESERVE: zone 29 at (6824, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6824, 10568) facing 2 (id 67)
  0.22  RESERVE: zone 30 at (6776, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6776, 10568) facing 2 (id 68)
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
```
