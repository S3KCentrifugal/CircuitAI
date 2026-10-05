# Playtest report: FAIL

- Verdict: **FAIL** (expected lines never seen: fusion-support, rear-fusion)
- Game time reached: 12.0 min (frame 21600); wall 99 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:36:17
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163617Z-748b6d38\runs\20261004T163800Z-912ccc56\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | seen at 5.5 min | `[t=00:01:09.131659][f=0009990] [SeaBlock] PASS packed armfmkr count=12 edges=12` |
| expect `t2` | seen at 4.9 min | `[t=00:01:06.468586][f=0008790] [SeaBlock] PASS packed armuwmmm count=8 edges=8` |
| expect `shipyard` | seen at 1.9 min | `[t=00:00:53.342648][f=0003330] [SeaBlock] PASS factory assist armsy` |
| expect `amphibious` | seen at 1.6 min | `[t=00:00:52.546582][f=0002970] [SeaBlock] PASS factory assist armamsub` |
| expect `fusion-support` | **missing** (by 12 min) | |
| expect `rear-fusion` | **missing** (by 12 min) | |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163617Z-748b6d38\runs\20261004T163800Z-912ccc56\screen_2026-10-04_16-37-20-718.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163617Z-748b6d38\runs\20261004T163800Z-912ccc56\screen_2026-10-04_16-37-33-706.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163617Z-748b6d38\runs\20261004T163800Z-912ccc56\screen_2026-10-04_16-37-34-102.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163617Z-748b6d38\runs\20261004T163800Z-912ccc56\screen_2026-10-04_16-37-54-985.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +3.4 bank 99085/100100, energy +178.0 bank 979718/1001050, units 20
  1.64  [Playtest] finished armnanotcplat team 0 at 1.64 min
  1.83  [Playtest] finished armnanotcplat team 0 at 1.83 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.7 bank 96373/100100, energy +178.0 bank 920355/1001050, units 23
  2.04  [Playtest] finished armuwmmm team 0 at 2.04 min
  2.21  [Playtest] finished armuwmmm team 0 at 2.21 min
  2.46  [Playtest] finished armnanotcplat team 0 at 2.46 min
  2.55  [Playtest] finished armnanotcplat team 0 at 2.55 min
  2.72  [Playtest] finished armnanotcplat team 0 at 2.72 min
  2.94  [Playtest] finished armnanotcplat team 0 at 2.94 min
  3.00  [Playtest] finished armuwmmm team 0 at 2.99 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +22.7 bank 93181/100100, energy +178.0 bank 780086/1001050, units 32
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.01  [Playtest] finished armnanotcplat team 0 at 3.01 min
  3.09  [Playtest] finished armnanotcplat team 0 at 3.09 min
  3.60  [Playtest] finished armuwmmm team 0 at 3.60 min
  3.70  [Playtest] finished armuwmmm team 0 at 3.70 min
  3.81  [Playtest] finished armuwmmm team 0 at 3.81 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 92816/100100, energy +178.0 bank 722586/1001050, units 36
  4.19  [Playtest] finished armfmkr team 0 at 4.19 min
  4.30  [Playtest] finished armfmkr team 0 at 4.30 min
  4.39  [Playtest] finished armuwmmm team 0 at 4.39 min
  4.40  [Playtest] finished armfmkr team 0 at 4.40 min
  4.87  [Playtest] finished armuwmmm team 0 at 4.87 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 92307/100100, energy +178.0 bank 691579/1001050, units 40
  5.04  [Playtest] finished armfmkr team 0 at 5.04 min
  5.05  [Playtest] finished armfmkr team 0 at 5.05 min
  5.12  [Playtest] finished armfmkr team 0 at 5.12 min
  5.13  [Playtest] finished armfmkr team 0 at 5.13 min
  5.17  [Playtest] finished armfmkr team 0 at 5.17 min
  5.24  [Playtest] finished armfmkr team 0 at 5.24 min
  5.30  [Playtest] finished armfmkr team 0 at 5.30 min
  5.39  [Playtest] finished armfmkr team 0 at 5.39 min
  5.40  [Playtest] finished armfmkr team 0 at 5.40 min
  5.47  [Playtest] finished armfmkr team 0 at 5.47 min
  5.53  [Playtest] finished armfmkr team 0 at 5.53 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 92415/100100, energy +178.0 bank 691313/1001050, units 45
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  6.94  [Playtest] finished armnanotcplat team 0 at 6.94 min
  6.99  [Playtest] finished armnanotcplat team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 91240/100100, energy +178.0 bank 679376/1001050, units 48
  7.03  [Playtest] finished armnanotcplat team 0 at 7.03 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 91224/100100, energy +178.0 bank 688170/1001050, units 48
  9.00  [Playtest] eco team 0 at 9.0 min: metal +2.0 bank 91344/100100, energy +178.0 bank 698850/1001050, units 48
 10.00  [Playtest] eco team 0 at 10.0 min: metal +2.0 bank 91464/100100, energy +178.0 bank 709530/1001050, units 48
 11.00  [Playtest] eco team 0 at 11.0 min: metal +2.0 bank 90843/100100, energy +178.0 bank 705248/1001050, units 48
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +2.0 bank 90963/100100, energy +178.0 bank 715928/1001050, units 48
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: corridor 1 at (6600, 11028) facing 0, 13x31 cells: 273 of 403 held
  0.18  RESERVE: corridor 2 at (5824, 11024) facing 0, 12x30 cells: 240 of 360 held
  0.18  RESERVE: zone 3 at (6600, 11188) facing 2, 41x41 cells: 1300 of 1681 held
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 at (6472, 11188) facing 2, 41x41 cells: 1304 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6472, 11092) facing 2: 8 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 at (6728, 11188) facing 2, 41x41 cells: 1308 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6728, 11092) facing 2: 6 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 at (6344, 11188) facing 2, 41x41 cells: 1357 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6344, 11092) facing 2: 16 of 16 slots (group 4, held, zone)
  0.18  RESERVE: armuwfus at (6336, 11312) facing 2 (id 31)
  0.18  RESERVE: packed armuwfus at (6336, 11312) facing 2 in zone 6, 313 from a turret (id 31, group 0, 824 candidates)
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
  0.20  RESERVE: served armfmkr at (6232, 11208) facing 2 (id 47, 3 of this def still held)
  0.21  RESERVE: served armfmkr at (6184, 11208) facing 2 (id 48, 2 of this def still held)
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
  0.23  RESERVE: served armuwmmm at (6328, 11056) facing 2 (id 59, 1 of this def still held)
  0.23  RESERVE: served armuwmmm at (6328, 10992) facing 2 (id 60, 0 of this def still held)
  0.30  RESERVE: set of 2 armuwmmm from (6408, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 7, id 61)
  0.31  RESERVE: served armuwmmm at (6408, 11056) facing 2 (id 61, 1 of this def still held)
  0.31  RESERVE: served armuwmmm at (6408, 10992) facing 2 (id 62, 0 of this def still held)
  0.54  RESERVE: set of 2 armuwmmm from (6248, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 8, id 63)
  0.54  RESERVE: served armuwmmm at (6248, 11056) facing 2 (id 63, 1 of this def still held)
  0.55  RESERVE: served armuwmmm at (6248, 10992) facing 2 (id 64, 0 of this def still held)
  0.65  RESERVE: served armnanotcplat at (6872, 10616) facing 2 (id 39, 31 of this def still held)
  0.74  RESERVE: set of 2 armuwmmm from (6216, 11120), 0 cell(s) from a turret, growing (-5, 0) cells a step (group 9, id 65)
  0.74  RESERVE: served armuwmmm at (6216, 11120) facing 2 (id 65, 1 of this def still held)
  0.84  RESERVE: armfmkr at (6184, 11208) lost; slot restored (id 48)
  0.92  RESERVE: armfmkr at (6232, 11208) lost; slot restored (id 47)
  0.95  RESERVE: served armuwmmm at (6136, 11120) facing 2 (id 66, 0 of this def still held)
  1.02  RESERVE: armuwmmm at (6408, 11056) lost; slot restored (id 61)
  1.03  RESERVE: served armnanotcplat at (5832, 10568) facing 2 (id 51, 30 of this def still held)
  1.18  RESERVE: served armuwmmm at (6408, 11056) facing 2 (id 61, 0 of this def still held)
  1.54  RESERVE: armuwmmm at (6248, 10992) lost; slot restored (id 64)
  1.67  RESERVE: armuwmmm at (6136, 11120) lost; slot restored (id 66)
  1.81  RESERVE: served armnanotcplat at (6824, 10616) facing 2 (id 40, 29 of this def still held)
  1.84  RESERVE: served armnanotcplat at (6776, 10616) facing 2 (id 41, 28 of this def still held)
  1.86  RESERVE: armuwmmm at (6248, 11056) lost; slot restored (id 63)
  1.95  RESERVE: served armuwmmm at (6248, 11056) facing 2 (id 63, 2 of this def still held)
  2.06  RESERVE: served armuwmmm at (6248, 10992) facing 2 (id 64, 1 of this def still held)
  2.20  RESERVE: armuwmmm at (6408, 11056) lost; slot restored (id 61)
  2.25  RESERVE: served armuwmmm at (6408, 11056) facing 2 (id 61, 1 of this def still held)
  2.27  RESERVE: served armnanotcplat at (5784, 10568) facing 2 (id 52, 27 of this def still held)
  2.53  RESERVE: served armnanotcplat at (6728, 10616) facing 2 (id 42, 26 of this def still held)
  2.58  RESERVE: served armnanotcplat at (5736, 10568) facing 2 (id 53, 25 of this def still held)
  2.78  RESERVE: served armnanotcplat at (6680, 10616) facing 2 (id 43, 24 of this def still held)
  2.82  RESERVE: served armuwmmm at (6136, 11120) facing 2 (id 66, 0 of this def still held)
  2.86  RESERVE: armuwmmm at (6248, 11056) lost; slot restored (id 63)
  3.01  RESERVE: served armfmkr at (6232, 11208) facing 2 (id 47, 3 of this def still held)
  3.03  RESERVE: served armfmkr at (6184, 11208) facing 2 (id 48, 2 of this def still held)
  3.18  RESERVE: served armuwmmm at (6248, 11056) facing 2 (id 63, 0 of this def still held)
  3.52  RESERVE: served armfmkr at (6136, 11208) facing 2 (id 49, 1 of this def still held)
  3.60  RESERVE: armfmkr at (6136, 11208) is being reclaimed: its slot will be freed (id 49)
  3.60  RESERVE: armfmkr at (6232, 11208) is being reclaimed: its slot will be freed (id 47)
  3.65  RESERVE: armfmkr at (6232, 11208) reclaimed; its ground is free again (id 47)
  3.70  RESERVE: armfmkr at (6184, 11208) is being reclaimed: its slot will be freed (id 48)
  3.73  RESERVE: armuwmmm at (6136, 11120) lost; slot restored (id 66)
  3.74  RESERVE: served armfmkr at (6088, 11208) facing 2 (id 50, 0 of this def still held)
  3.75  RESERVE: set of 1 armfmkr from (6232, 11208), 0 cell(s) from a turret, growing (-3, 0) cells a step (group 10, id 67)
  3.75  RESERVE: served armuwmmm at (6136, 11120) facing 2 (id 66, 0 of this def still held)
  3.77  RESERVE: armfmkr at (6184, 11208) reclaimed; its ground is free again (id 48)
  3.83  RESERVE: served armfmkr at (6232, 11208) facing 2 (id 67, 0 of this def still held)
  3.83  RESERVE: set of 4 armfmkr from (6232, 11256), 0 cell(s) from a turret, growing (-3, 0) cells a step (group 11, id 68)
  3.95  RESERVE: served armfmkr at (6232, 11256) facing 2 (id 68, 3 of this def still held)
  4.08  RESERVE: armfmkr at (6136, 11208) reclaimed; its ground is free again (id 49)
```
