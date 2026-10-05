# Playtest report: PASS

- Verdict: **PASS** (reached 12 min)
- Game time reached: 12.0 min (frame 21601); wall 118 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:57:58
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165757Z-f9fc6f76\runs\20261004T165959Z-9e3b4d88\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | seen at 5.2 min | `[t=00:01:25.745485][f=0009420] [SeaBlock] PASS packed armfmkr count=12 edges=17` |
| expect `t2` | seen at 4.8 min | `[t=00:01:23.802663][f=0008610] [SeaBlock] PASS packed armuwmmm count=8 edges=8` |
| expect `shipyard` | seen at 6.5 min | `[t=00:01:32.240348][f=0011700] [SeaBlock] PASS factory assist armsy` |
| expect `amphibious` | seen at 7.0 min | `[t=00:01:34.190082][f=0012570] [SeaBlock] PASS factory assist armamsub` |
| expect `fusion-support` | seen at 1.8 min | `[t=00:01:10.958562][f=0003300] [SeaBlock] PASS fusion assist` |
| expect `rear-fusion` | seen at 4.3 min | `[t=00:01:21.937628][f=0007770] [SeaBlock] PASS rear fusion completed` |
| expect `square` | seen at 4.7 min | `[t=00:01:23.539617][f=0008490] [SeaBlock] PASS square turret grid count=4 columns=3 rows=2` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165757Z-f9fc6f76\runs\20261004T165959Z-9e3b4d88\screen_2026-10-04_16-59-18-954.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165757Z-f9fc6f76\runs\20261004T165959Z-9e3b4d88\screen_2026-10-04_16-59-24-208.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165757Z-f9fc6f76\runs\20261004T165959Z-9e3b4d88\screen_2026-10-04_16-59-32-167.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165757Z-f9fc6f76\runs\20261004T165959Z-9e3b4d88\screen_2026-10-04_16-59-32-585.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165757Z-f9fc6f76\runs\20261004T165959Z-9e3b4d88\screen_2026-10-04_16-59-53-776.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  0.99  [Playtest] finished armfmkr team 0 at 0.99 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.7 bank 98772/100100, energy +178.0 bank 967393/1001050, units 21
  1.08  [Playtest] finished armuwmmm team 0 at 1.08 min
  1.25  [Playtest] finished armfmkr team 0 at 1.25 min
  1.65  [Playtest] finished armnanotcplat team 0 at 1.65 min
  1.82  [Playtest] finished armnanotcplat team 0 at 1.82 min
  1.96  [Playtest] finished armuwmmm team 0 at 1.96 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +26.1 bank 97049/100100, energy +178.0 bank 880075/1001050, units 28
  2.31  [Playtest] finished armuwmmm team 0 at 2.31 min
  2.93  [Playtest] finished armuwmmm team 0 at 2.93 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.7 bank 94542/100100, energy +178.0 bank 735953/1001050, units 30
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.28  [Playtest] finished armuwmmm team 0 at 3.28 min
  3.80  [Playtest] finished armuwmmm team 0 at 3.80 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 90487/100100, energy +178.0 bank 674996/1001050, units 31
  4.07  [Playtest] finished armnanotcplat team 0 at 4.07 min
  4.31  [Playtest] finished armuwfus team 0 at 4.31 min
  4.50  [Playtest] finished armuwmmm team 0 at 4.50 min
  4.56  [Playtest] finished armfmkr team 0 at 4.56 min
  4.61  [Playtest] finished armfmkr team 0 at 4.61 min
  4.66  [Playtest] finished armfmkr team 0 at 4.66 min
  4.70  [Playtest] finished armnanotcplat team 0 at 4.70 min
  4.74  [Playtest] finished armfmkr team 0 at 4.74 min
  4.77  [Playtest] finished armuwmmm team 0 at 4.77 min
  4.81  [Playtest] finished armfmkr team 0 at 4.81 min
  4.87  [Playtest] finished armfmkr team 0 at 4.87 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.1 bank 88647/100100, energy +1378.3 bank 686332/1003550, units 38
  5.06  [Playtest] finished armfmkr team 0 at 5.06 min
  5.09  [Playtest] finished armfmkr team 0 at 5.09 min
  5.16  [Playtest] finished armfmkr team 0 at 5.16 min
  5.22  [Playtest] finished armfmkr team 0 at 5.22 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +25.8 bank 88956/100100, energy +1378.0 bank 753351/1003550, units 42
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  6.48  [Playtest] finished armnanotcplat team 0 at 6.48 min
  6.53  [Playtest] finished armnanotcplat team 0 at 6.53 min
  6.63  [Playtest] finished armnanotcplat team 0 at 6.63 min
  6.64  [Playtest] finished armnanotcplat team 0 at 6.64 min
  6.74  [Playtest] finished armnanotcplat team 0 at 6.74 min
  6.79  [Playtest] finished armnanotcplat team 0 at 6.79 min
  6.87  [Playtest] finished armnanotcplat team 0 at 6.87 min
  6.95  [Playtest] finished armnanotcplat team 0 at 6.95 min
  6.97  [Playtest] finished armnanotcplat team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 85442/100100, energy +1378.0 bank 751070/1003550, units 56
  7.06  [Playtest] finished armnanotcplat team 0 at 7.06 min
  7.19  [Playtest] finished armnanotcplat team 0 at 7.19 min
  7.37  [Playtest] finished armnanotcplat team 0 at 7.37 min
  7.44  [Playtest] finished armnanotcplat team 0 at 7.44 min
  7.49  [Playtest] finished armnanotcplat team 0 at 7.49 min
  7.54  [Playtest] finished armnanotcplat team 0 at 7.54 min
  7.60  [Playtest] finished armnanotcplat team 0 at 7.60 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +25.8 bank 80579/100100, energy +1378.0 bank 753351/1003550, units 64
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.8 bank 82124/100100, energy +1378.0 bank 753351/1003550, units 64
 10.00  [Playtest] eco team 0 at 10.0 min: metal +25.8 bank 83669/100100, energy +1378.0 bank 753351/1003550, units 64
 11.00  [Playtest] eco team 0 at 11.0 min: metal +25.8 bank 84215/100100, energy +1378.0 bank 753351/1003550, units 64
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +25.8 bank 85760/100100, energy +1378.0 bank 753351/1003550, units 64
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
  0.21  RESERVE: served armfmkr at (6200, 11208) facing 2 (id 34, 3 of this def still held)
  0.21  RESERVE: set of 2 armuwmmm from (6104, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 6, id 38)
  0.22  RESERVE: served armuwmmm at (6104, 11056) facing 2 (id 38, 1 of this def still held)
  0.22  RESERVE: served armuwmmm at (6104, 10992) facing 2 (id 39, 0 of this def still held)
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
  0.23  RESERVE: served armfmkr at (6248, 11208) facing 2 (id 35, 2 of this def still held)
  0.23  RESERVE: set of 2 armuwmmm from (6024, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 7, id 55)
  0.24  RESERVE: served armuwmmm at (6024, 11056) facing 2 (id 55, 1 of this def still held)
  0.27  RESERVE: served armnanotcplat at (6104, 11256) facing 2 (id 30, 31 of this def still held)
  0.27  RESERVE: served armnanotcplat at (6152, 11256) facing 2 (id 29, 30 of this def still held)
  0.63  RESERVE: served armuwmmm at (6024, 10992) facing 2 (id 56, 0 of this def still held)
  1.08  RESERVE: set of 2 armuwmmm from (6056, 11312), 0 cell(s) from a turret, growing (0, 4) cells a step (group 8, id 57)
  1.09  RESERVE: served armuwmmm at (6056, 11312) facing 2 (id 57, 1 of this def still held)
  1.10  RESERVE: served armuwmmm at (6056, 11376) facing 2 (id 58, 0 of this def still held)
  1.11  RESERVE: served armuwfus at (6144, 11312) facing 2 (id 33, 0 of this def still held)
  1.48  RESERVE: set of 2 armuwmmm from (6184, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 9, id 59)
  1.48  RESERVE: served armuwmmm at (6184, 11056) facing 2 (id 59, 1 of this def still held)
  1.58  RESERVE: served armuwmmm at (6184, 10992) facing 2 (id 60, 0 of this def still held)
  2.11  RESERVE: armuwmmm at (6056, 11376) lost; slot restored (id 58)
  2.33  RESERVE: served armuwmmm at (6056, 11376) facing 2 (id 58, 0 of this def still held)
  3.14  RESERVE: armuwmmm at (6056, 11376) lost; slot restored (id 58)
  3.30  RESERVE: served armuwmmm at (6056, 11376) facing 2 (id 58, 0 of this def still held)
  3.32  RESERVE: served armnanotcplat at (6152, 11208) facing 2 (id 25, 29 of this def still held)
  4.09  RESERVE: served armnanotcplat at (6056, 11256) facing 2 (id 31, 28 of this def still held)
  4.35  RESERVE: served armfmkr at (6296, 11208) facing 2 (id 36, 1 of this def still held)
  4.52  RESERVE: served armfmkr at (6344, 11208) facing 2 (id 37, 0 of this def still held)
  4.57  RESERVE: set of 4 armfmkr from (6200, 11256), 0 cell(s) from a turret, growing (3, 0) cells a step (group 10, id 61)
  4.58  RESERVE: served armfmkr at (6200, 11256) facing 2 (id 61, 3 of this def still held)
  4.64  RESERVE: served armfmkr at (6248, 11256) facing 2 (id 62, 2 of this def still held)
  4.69  RESERVE: served armfmkr at (6296, 11256) facing 2 (id 63, 1 of this def still held)
  4.72  RESERVE: served armfmkr at (6344, 11256) facing 2 (id 64, 0 of this def still held)
  4.75  RESERVE: set of 4 armfmkr from (6200, 11160), 0 cell(s) from a turret, growing (3, 0) cells a step (group 11, id 65)
  4.76  RESERVE: served armfmkr at (6200, 11160) facing 2 (id 65, 3 of this def still held)
  4.79  RESERVE: served armfmkr at (6248, 11160) facing 2 (id 66, 2 of this def still held)
  5.03  RESERVE: served armfmkr at (6296, 11160) facing 2 (id 67, 1 of this def still held)
  5.09  RESERVE: served armfmkr at (6344, 11160) facing 2 (id 68, 0 of this def still held)
  6.07  RESERVE: served armnanotcplat at (6872, 10616) facing 2 (id 47, 27 of this def still held)
  6.08  RESERVE: served armnanotcplat at (5832, 10568) facing 2 (id 1, 26 of this def still held)
  6.08  RESERVE: served armnanotcplat at (6824, 10616) facing 2 (id 48, 25 of this def still held)
  6.09  RESERVE: served armnanotcplat at (6776, 10616) facing 2 (id 49, 24 of this def still held)
  6.52  RESERVE: served armnanotcplat at (5784, 10568) facing 2 (id 2, 23 of this def still held)
  6.55  RESERVE: served armnanotcplat at (6728, 10616) facing 2 (id 50, 22 of this def still held)
  6.66  RESERVE: served armnanotcplat at (6680, 10616) facing 2 (id 51, 21 of this def still held)
  6.67  RESERVE: served armnanotcplat at (5736, 10568) facing 2 (id 3, 20 of this def still held)
  6.76  RESERVE: served armnanotcplat at (6872, 10568) facing 2 (id 52, 19 of this def still held)
  6.82  RESERVE: served armnanotcplat at (6824, 10568) facing 2 (id 53, 18 of this def still held)
  6.89  RESERVE: served armnanotcplat at (5688, 10568) facing 2 (id 4, 17 of this def still held)
  6.98  RESERVE: served armnanotcplat at (6776, 10568) facing 2 (id 54, 16 of this def still held)
  7.01  RESERVE: served armnanotcplat at (5640, 10568) facing 2 (id 5, 15 of this def still held)
  7.09  RESERVE: served armnanotcplat at (5832, 10520) facing 2 (id 6, 14 of this def still held)
  7.26  RESERVE: served armnanotcplat at (5784, 10520) facing 2 (id 7, 13 of this def still held)
  7.39  RESERVE: served armnanotcplat at (5736, 10520) facing 2 (id 8, 12 of this def still held)
```
