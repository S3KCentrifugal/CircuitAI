# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 12.1 min (frame 21825); wall 102 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:45:35
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T164534Z-27ee7e83\runs\20261004T164720Z-b5abb934\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | **missing** (by 12 min) | |
| expect `t2` | seen at 5.8 min | `[t=00:01:11.811342][f=0010410] [SeaBlock] PASS packed armuwmmm count=8 edges=8` |
| expect `shipyard` | seen at 1.6 min | `[t=00:00:53.748001][f=0002880] [SeaBlock] PASS factory assist armsy` |
| expect `amphibious` | seen at 2.1 min | `[t=00:00:55.807759][f=0003780] [SeaBlock] PASS factory assist armamsub` |
| expect `fusion-support` | seen at 5.7 min | `[t=00:01:11.505964][f=0010290] [SeaBlock] PASS fusion assist` |
| expect `rear-fusion` | seen at 6.5 min | `[t=00:01:17.061721][f=0011760] [SeaBlock] PASS rear fusion completed` |
| forbid `errors` | clean |  |

## Failures

- 't1' not seen by 12.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T164534Z-27ee7e83\runs\20261004T164720Z-b5abb934\screen_2026-10-04_16-46-39-571.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T164534Z-27ee7e83\runs\20261004T164720Z-b5abb934\screen_2026-10-04_16-46-52-841.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T164534Z-27ee7e83\runs\20261004T164720Z-b5abb934\screen_2026-10-04_16-46-53-410.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T164534Z-27ee7e83\runs\20261004T164720Z-b5abb934\screen_2026-10-04_16-46-56-222.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T164534Z-27ee7e83\runs\20261004T164720Z-b5abb934\screen_2026-10-04_16-47-15-166.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 35
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 35
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.8 bank 98939/100100, energy +178.0 bank 974831/1001050, units 23
  1.56  [Playtest] finished armuwmmm team 0 at 1.56 min
  1.58  [Playtest] finished armnanotcplat team 0 at 1.58 min
  1.65  [Playtest] finished armnanotcplat team 0 at 1.65 min
  1.97  [Playtest] finished armnanotcplat team 0 at 1.97 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +13.1 bank 96245/100100, energy +178.0 bank 897860/1001050, units 27
  2.09  [Playtest] finished armnanotcplat team 0 at 2.09 min
  2.28  [Playtest] finished armuwmmm team 0 at 2.28 min
  2.34  [Playtest] finished armuwmmm team 0 at 2.34 min
  2.49  [Playtest] finished armnanotcplat team 0 at 2.49 min
  2.86  [Playtest] finished armnanotcplat team 0 at 2.86 min
  2.87  [Playtest] finished armnanotcplat team 0 at 2.87 min
  2.95  [Playtest] finished armnanotcplat team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.7 bank 93803/100100, energy +178.0 bank 750019/1001050, units 33
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.4 bank 93174/100100, energy +178.0 bank 719220/1001050, units 40
  4.05  [Playtest] finished armuwmmm team 0 at 4.05 min
  4.19  [Playtest] finished armuwmmm team 0 at 4.19 min
  4.47  [Playtest] finished armuwmmm team 0 at 4.47 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +8.4 bank 92562/100100, energy +178.0 bank 685138/1001050, units 40
  5.06  [Playtest] finished armuwmmm team 0 at 5.06 min
  5.23  [Playtest] finished armnanotcplat team 0 at 5.23 min
  5.30  [Playtest] finished armnanotcplat team 0 at 5.30 min
  5.39  [Playtest] finished armnanotcplat team 0 at 5.39 min
  5.48  [Playtest] finished armfmkr team 0 at 5.48 min
  5.52  [Playtest] finished armnanotcplat team 0 at 5.52 min
  5.58  [Playtest] finished armnanotcplat team 0 at 5.58 min
  5.66  [Playtest] finished armnanotcplat team 0 at 5.66 min
  5.70  [Playtest] finished armnanotcplat team 0 at 5.70 min
  5.73  [Playtest] finished armnanotcplat team 0 at 5.73 min
  5.77  [Playtest] finished armuwmmm team 0 at 5.77 min
  5.82  [Playtest] finished armnanotcplat team 0 at 5.82 min
  5.87  [Playtest] finished armnanotcplat team 0 at 5.87 min
  5.93  [Playtest] finished armnanotcplat team 0 at 5.93 min
  5.98  [Playtest] finished armnanotcplat team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 88811/100100, energy +178.0 bank 636088/1001050, units 48
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  6.02  [Playtest] finished armnanotcplat team 0 at 6.02 min
  6.08  [Playtest] finished armnanotcplat team 0 at 6.07 min
  6.11  [Playtest] finished armfmkr team 0 at 6.11 min
  6.13  [Playtest] finished armnanotcplat team 0 at 6.13 min
  6.16  [Playtest] finished armfmkr team 0 at 6.16 min
  6.20  [Playtest] finished armfmkr team 0 at 6.20 min
  6.26  [Playtest] finished armnanotcplat team 0 at 6.26 min
  6.29  [Playtest] finished armfmkr team 0 at 6.29 min
  6.31  [Playtest] finished armfmkr team 0 at 6.31 min
  6.39  [Playtest] finished armfmkr team 0 at 6.39 min
  6.45  [Playtest] finished armfmkr team 0 at 6.45 min
  6.50  [Playtest] finished armfmkr team 0 at 6.50 min
  6.52  [Playtest] finished armuwfus team 0 at 6.52 min
  6.54  [Playtest] finished armfmkr team 0 at 6.54 min
  6.82  [Playtest] finished armfmkr team 0 at 6.82 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 83897/100100, energy +1378.0 bank 631785/1003550, units 60
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 84017/100100, energy +1378.0 bank 714465/1003550, units 60
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.8 bank 84892/100100, energy +1378.0 bank 753351/1003550, units 60
 10.00  [Playtest] eco team 0 at 10.0 min: metal +25.8 bank 86437/100100, energy +1378.0 bank 753351/1003550, units 60
 11.00  [Playtest] eco team 0 at 11.0 min: metal +25.8 bank 87982/100100, energy +1378.0 bank 753351/1003550, units 60
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +25.8 bank 89527/100100, energy +1378.0 bank 753351/1003550, units 60
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: corridor 1 at (6600, 11028) facing 0, 13x31 cells: 273 of 403 held
  0.18  RESERVE: corridor 2 at (5824, 11024) facing 0, 12x30 cells: 192 of 360 held
  0.18  RESERVE: zone 3 at (6600, 11188) facing 2, 41x41 cells: 1300 of 1681 held
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 at (6472, 11188) facing 2, 41x41 cells: 1304 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6472, 11092) facing 2: 8 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 at (6728, 11188) facing 2, 41x41 cells: 1308 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6728, 11092) facing 2: 6 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 at (6344, 11188) facing 2, 41x41 cells: 1293 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6344, 11092) facing 2: 16 of 16 slots (group 4, held, zone)
  0.18  RESERVE: armuwfus at (6336, 11312) facing 2 (id 31)
  0.18  RESERVE: packed armuwfus at (6336, 11312) facing 2 in zone 6, 313 from a turret (id 31, group 0, 760 candidates)
  0.20  RESERVE: zone 7 at (6888, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6888, 10536) facing 2 (id 32)
  0.20  RESERVE: zone 8 at (6840, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6840, 10536) facing 2 (id 33)
  0.20  RESERVE: zone 9 at (6792, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6792, 10536) facing 2 (id 34)
  0.20  RESERVE: zone 10 at (6744, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6744, 10536) facing 2 (id 35)
  0.20  RESERVE: zone 11 at (6696, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6696, 10536) facing 2 (id 36)
  0.20  RESERVE: zone 12 at (6888, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6888, 10488) facing 2 (id 37)
  0.20  RESERVE: zone 13 at (6840, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6840, 10488) facing 2 (id 38)
  0.20  RESERVE: zone 7 released
  0.20  RESERVE: zone 8 released
  0.20  RESERVE: zone 9 released
  0.20  RESERVE: zone 10 released
  0.20  RESERVE: zone 11 released
  0.20  RESERVE: zone 12 released
  0.20  RESERVE: zone 13 released
  0.20  RESERVE: zone 14 at (6872, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6872, 10616) facing 2 (id 39)
  0.20  RESERVE: zone 15 at (6824, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10616) facing 2 (id 40)
  0.20  RESERVE: zone 16 at (6776, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6776, 10616) facing 2 (id 41)
  0.20  RESERVE: zone 17 at (6728, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6728, 10616) facing 2 (id 42)
  0.20  RESERVE: zone 18 at (6680, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6680, 10616) facing 2 (id 43)
  0.20  RESERVE: zone 19 at (6872, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6872, 10568) facing 2 (id 44)
  0.20  RESERVE: zone 20 at (6824, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10568) facing 2 (id 45)
  0.20  RESERVE: zone 21 at (6776, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6776, 10568) facing 2 (id 46)
  0.20  RESERVE: set of 4 armfmkr from (6232, 11208), 0 cell(s) from a turret, growing (-3, 0) cells a step (group 5, id 47)
  0.21  RESERVE: served armfmkr at (6232, 11208) facing 2 (id 47, 3 of this def still held)
  0.22  RESERVE: served armfmkr at (6184, 11208) facing 2 (id 48, 2 of this def still held)
  0.22  RESERVE: zone 22 at (5832, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5832, 10568) facing 2 (id 51)
  0.22  RESERVE: zone 23 at (5784, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5784, 10568) facing 2 (id 52)
  0.22  RESERVE: zone 24 at (5736, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5736, 10568) facing 2 (id 53)
  0.22  RESERVE: zone 25 at (5688, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5688, 10568) facing 2 (id 54)
  0.22  RESERVE: zone 26 at (5640, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5640, 10568) facing 2 (id 55)
  0.22  RESERVE: zone 27 at (5832, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5832, 10520) facing 2 (id 56)
  0.22  RESERVE: zone 28 at (5784, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5784, 10520) facing 2 (id 57)
  0.22  RESERVE: zone 29 at (5736, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5736, 10520) facing 2 (id 58)
  0.22  RESERVE: set of 2 armuwmmm from (6328, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 6, id 59)
  0.22  RESERVE: served armuwmmm at (6328, 11056) facing 2 (id 59, 1 of this def still held)
  0.23  RESERVE: served armuwmmm at (6328, 10992) facing 2 (id 60, 0 of this def still held)
  0.25  RESERVE: served armnanotcplat at (6328, 11256) facing 2 (id 29, 31 of this def still held)
  0.30  RESERVE: set of 2 armuwmmm from (6408, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 7, id 61)
  0.31  RESERVE: served armuwmmm at (6408, 11056) facing 2 (id 61, 1 of this def still held)
  0.60  RESERVE: set of 2 armuwmmm from (6248, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 8, id 63)
  0.60  RESERVE: served armuwmmm at (6408, 10992) facing 2 (id 62, 2 of this def still held)
  0.67  RESERVE: served armnanotcplat at (6376, 11256) facing 2 (id 28, 30 of this def still held)
  0.73  RESERVE: served armuwmmm at (6248, 11056) facing 2 (id 63, 1 of this def still held)
  0.73  RESERVE: served armnanotcplat at (6872, 10616) facing 2 (id 39, 29 of this def still held)
  0.75  RESERVE: served armnanotcplat at (5832, 10568) facing 2 (id 51, 28 of this def still held)
  0.94  RESERVE: armnanotcplat at (6328, 11256) lost; slot restored (id 29)
  1.04  RESERVE: armfmkr at (6232, 11208) lost; slot restored (id 47)
  1.04  RESERVE: armfmkr at (6184, 11208) lost; slot restored (id 48)
  1.12  RESERVE: served armuwmmm at (6248, 10992) facing 2 (id 64, 0 of this def still held)
  1.12  RESERVE: served armnanotcplat at (6328, 11256) facing 2 (id 29, 28 of this def still held)
  1.22  RESERVE: armuwmmm at (6328, 10992) lost; slot restored (id 60)
  1.41  RESERVE: armnanotcplat at (6376, 11256) lost; slot restored (id 28)
  1.51  RESERVE: served armuwmmm at (6328, 10992) facing 2 (id 60, 0 of this def still held)
  1.57  RESERVE: served armnanotcplat at (6376, 11256) facing 2 (id 28, 28 of this def still held)
  1.57  RESERVE: set of 2 armuwmmm from (6424, 11312), 0 cell(s) from a turret, growing (0, 4) cells a step (group 9, id 65)
  1.58  RESERVE: served armnanotcplat at (6824, 10616) facing 2 (id 40, 27 of this def still held)
  1.58  RESERVE: armuwmmm at (6408, 10992) lost; slot restored (id 62)
  1.58  RESERVE: served armuwmmm at (6424, 11312) facing 2 (id 65, 2 of this def still held)
  1.68  RESERVE: served armnanotcplat at (6776, 10616) facing 2 (id 41, 26 of this def still held)
  1.69  RESERVE: served armfmkr at (6232, 11208) facing 2 (id 47, 3 of this def still held)
  1.74  RESERVE: armnanotcplat at (6328, 11256) lost; slot restored (id 29)
  1.76  RESERVE: armuwmmm at (6248, 10992) lost; slot restored (id 64)
  1.90  RESERVE: served armuwmmm at (6408, 10992) facing 2 (id 62, 2 of this def still held)
  1.93  RESERVE: served armnanotcplat at (6328, 11256) facing 2 (id 29, 26 of this def still held)
  1.94  RESERVE: served armuwmmm at (6248, 10992) facing 2 (id 64, 1 of this def still held)
  1.99  RESERVE: served armnanotcplat at (5784, 10568) facing 2 (id 52, 25 of this def still held)
  2.21  RESERVE: armnanotcplat at (6376, 11256) lost; slot restored (id 28)
  2.23  RESERVE: served armnanotcplat at (6376, 11256) facing 2 (id 28, 25 of this def still held)
  2.28  RESERVE: served armnanotcplat at (6728, 10616) facing 2 (id 42, 24 of this def still held)
  2.28  RESERVE: armfmkr at (6232, 11208) is being reclaimed: its slot will be freed (id 47)
  2.34  RESERVE: armfmkr at (6232, 11208) reclaimed; its ground is free again (id 47)
  2.35  RESERVE: served armnanotcplat at (5736, 10568) facing 2 (id 53, 23 of this def still held)
  2.40  RESERVE: served armuwmmm at (6424, 11376) facing 2 (id 66, 0 of this def still held)
  2.54  RESERVE: served armuwfus at (6336, 11312) facing 2 (id 31, 0 of this def still held)
  2.56  RESERVE: served armnanotcplat at (6680, 10616) facing 2 (id 43, 22 of this def still held)
  2.67  RESERVE: armuwmmm at (6408, 10992) lost; slot restored (id 62)
  2.72  RESERVE: armnanotcplat at (6328, 11256) lost; slot restored (id 29)
  2.75  RESERVE: served armnanotcplat at (6328, 11256) facing 2 (id 29, 22 of this def still held)
  2.87  RESERVE: served armuwmmm at (6408, 10992) facing 2 (id 62, 0 of this def still held)
  2.91  RESERVE: served armfmkr at (6184, 11208) facing 2 (id 48, 2 of this def still held)
  2.92  RESERVE: armuwmmm at (6248, 10992) lost; slot restored (id 64)
  2.96  RESERVE: armnanotcplat at (6376, 11256) lost; slot restored (id 28)
  3.01  RESERVE: served armnanotcplat at (6376, 11256) facing 2 (id 28, 22 of this def still held)
```
