# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 12.1 min (frame 21780); wall 102 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:52:12
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165212Z-1e581f2c\runs\20261004T165358Z-47772981\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | seen at 5.7 min | `[t=00:01:09.907587][f=0010260] [SeaBlock] PASS packed armfmkr count=12 edges=17` |
| expect `t2` | seen at 4.0 min | `[t=00:01:02.407222][f=0007230] [SeaBlock] PASS packed armuwmmm count=8 edges=8` |
| expect `shipyard` | **missing** (by 12 min) | |
| expect `amphibious` | **missing** (by 12 min) | |
| expect `fusion-support` | seen at 3.7 min | `[t=00:01:00.832303][f=0006690] [SeaBlock] PASS fusion assist` |
| expect `rear-fusion` | seen at 4.7 min | `[t=00:01:05.425296][f=0008400] [SeaBlock] PASS rear fusion completed` |
| forbid `errors` | clean |  |

## Failures

- 'shipyard' not seen by 12.0 min
- 'amphibious' not seen by 12.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165212Z-1e581f2c\runs\20261004T165358Z-47772981\screen_2026-10-04_16-53-13-824.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165212Z-1e581f2c\runs\20261004T165358Z-47772981\screen_2026-10-04_16-53-22-209.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165212Z-1e581f2c\runs\20261004T165358Z-47772981\screen_2026-10-04_16-53-28-931.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165212Z-1e581f2c\runs\20261004T165358Z-47772981\screen_2026-10-04_16-53-29-385.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T165212Z-1e581f2c\runs\20261004T165358Z-47772981\screen_2026-10-04_16-53-53-082.png

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
  0.18  [Playtest] finished armsy team 0 at 0.18 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  0.74  [Playtest] finished armfmkr team 0 at 0.74 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.4 bank 98983/100100, energy +178.0 bank 977982/1001050, units 24
  1.02  [Playtest] finished armnanotcplat team 0 at 1.02 min
  1.06  [Playtest] finished armfmkr team 0 at 1.06 min
  1.72  [Playtest] finished armuwmmm team 0 at 1.72 min
  1.93  [Playtest] finished armuwmmm team 0 at 1.93 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +24.7 bank 96997/100100, energy +178.0 bank 888465/1001050, units 26
  2.26  [Playtest] finished armuwmmm team 0 at 2.26 min
  2.62  [Playtest] finished armuwmmm team 0 at 2.62 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 96245/100100, energy +178.0 bank 736199/1001050, units 26
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.00  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.23  [Playtest] finished armuwmmm team 0 at 3.23 min
  3.23  [Playtest] finished armuwmmm team 0 at 3.23 min
  3.48  [Playtest] finished armuwmmm team 0 at 3.48 min
  3.58  [Playtest] finished armnanotcplat team 0 at 3.58 min
  3.70  [Playtest] finished armnanotcplat team 0 at 3.70 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 92484/100100, energy +178.0 bank 671882/1001050, units 31
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.11  [Playtest] finished armnanotcplat team 0 at 4.11 min
  4.13  [Playtest] finished armnanotcplat team 0 at 4.13 min
  4.66  [Playtest] finished armuwfus team 0 at 4.66 min
  4.71  [Playtest] finished armnanotcplat team 0 at 4.71 min
  4.74  [Playtest] finished armnanotcplat team 0 at 4.74 min
  4.84  [Playtest] finished armfmkr team 0 at 4.84 min
  4.95  [Playtest] finished armfmkr team 0 at 4.95 min
  4.98  [Playtest] finished armfmkr team 0 at 4.98 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 87705/100100, energy +1378.0 bank 666392/1003550, units 37
  5.02  [Playtest] finished armfmkr team 0 at 5.02 min
  5.05  [Playtest] finished armfmkr team 0 at 5.05 min
  5.09  [Playtest] finished armfmkr team 0 at 5.09 min
  5.45  [Playtest] finished armfmkr team 0 at 5.45 min
  5.49  [Playtest] finished armfmkr team 0 at 5.49 min
  5.55  [Playtest] finished armfmkr team 0 at 5.55 min
  5.59  [Playtest] finished armfmkr team 0 at 5.59 min
  5.63  [Playtest] finished armfmkr team 0 at 5.63 min
  5.69  [Playtest] finished armfmkr team 0 at 5.69 min
  5.75  [Playtest] finished armnanotcplat team 0 at 5.75 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 87594/100100, energy +1378.0 bank 735900/1003550, units 46
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  7.00  [Playtest] eco team 0 at 7.0 min: metal +25.8 bank 88838/100100, energy +1378.0 bank 753351/1003550, units 46
  8.00  [Playtest] eco team 0 at 8.0 min: metal +25.8 bank 90383/100100, energy +1378.0 bank 753351/1003550, units 46
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.8 bank 91928/100100, energy +1378.0 bank 753351/1003550, units 46
 10.00  [Playtest] eco team 0 at 10.0 min: metal +25.8 bank 93473/100100, energy +1378.0 bank 753351/1003550, units 46
 11.00  [Playtest] eco team 0 at 11.0 min: metal +25.8 bank 95018/100100, energy +1378.0 bank 753351/1003550, units 46
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +25.8 bank 96563/100100, energy +1378.0 bank 753351/1003550, units 46
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (6600, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6600, 10584) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (6552, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6552, 10584) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (6504, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6504, 10584) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (6456, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6456, 10584) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (6408, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6408, 10584) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (6600, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6600, 10536) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (6552, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6552, 10536) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (6504, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6504, 10536) facing 2 (id 8)
  0.18  RESERVE: corridor 9 at (6600, 11028) facing 0, 13x31 cells: 273 of 403 held
  0.18  RESERVE: corridor 10 at (5824, 11024) facing 0, 12x30 cells: 240 of 360 held
  0.18  RESERVE: zone 11 at (6600, 11188) facing 2, 41x41 cells: 1312 of 1681 held
  0.18  RESERVE: zone 11 released
  0.18  RESERVE: zone 12 at (6472, 11188) facing 2, 41x41 cells: 1324 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6472, 11092) facing 2: 8 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: zone 13 at (6728, 11188) facing 2, 41x41 cells: 1312 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6728, 11092) facing 2: 6 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 13 released
  0.18  RESERVE: zone 14 at (6344, 11188) facing 2, 41x41 cells: 1385 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6344, 11092) facing 2: 16 of 16 slots (group 4, held, zone)
  0.18  RESERVE: armuwfus at (6336, 11312) facing 2 (id 39)
  0.18  RESERVE: packed armuwfus at (6336, 11312) facing 2 in zone 14, 313 from a turret (id 39, group 0, 847 candidates)
  0.20  RESERVE: zone 15 at (5832, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5832, 10568) facing 2 (id 40)
  0.20  RESERVE: zone 16 at (5784, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5784, 10568) facing 2 (id 41)
  0.20  RESERVE: zone 17 at (5736, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5736, 10568) facing 2 (id 42)
  0.20  RESERVE: zone 18 at (5688, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5688, 10568) facing 2 (id 43)
  0.20  RESERVE: zone 19 at (5640, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5640, 10568) facing 2 (id 44)
  0.20  RESERVE: zone 20 at (5832, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5832, 10520) facing 2 (id 45)
  0.20  RESERVE: zone 21 at (5784, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5784, 10520) facing 2 (id 46)
  0.20  RESERVE: zone 22 at (5736, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5736, 10520) facing 2 (id 47)
  0.20  RESERVE: set of 4 armfmkr from (6232, 11208), 0 cell(s) from a turret, growing (-3, 0) cells a step (group 5, id 48)
  0.21  RESERVE: served armfmkr at (6232, 11208) facing 2 (id 48, 3 of this def still held)
  0.21  RESERVE: served armfmkr at (6184, 11208) facing 2 (id 49, 2 of this def still held)
  0.21  RESERVE: set of 2 armuwmmm from (6328, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 6, id 52)
  0.22  RESERVE: served armuwmmm at (6328, 11056) facing 2 (id 52, 1 of this def still held)
  0.23  RESERVE: served armuwmmm at (6328, 10992) facing 2 (id 53, 0 of this def still held)
  0.23  RESERVE: served armnanotcplat at (6328, 11256) facing 2 (id 37, 31 of this def still held)
  0.31  RESERVE: set of 2 armuwmmm from (6408, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 7, id 54)
  0.31  RESERVE: served armuwmmm at (6408, 11056) facing 2 (id 54, 1 of this def still held)
  0.33  RESERVE: served armuwmmm at (6408, 10992) facing 2 (id 55, 0 of this def still held)
  0.56  RESERVE: set of 2 armuwmmm from (6248, 11056), 0 cell(s) from a turret, growing (0, -4) cells a step (group 8, id 56)
  0.57  RESERVE: served armuwmmm at (6248, 11056) facing 2 (id 56, 1 of this def still held)
  0.59  RESERVE: served armuwmmm at (6248, 10992) facing 2 (id 57, 0 of this def still held)
  0.67  RESERVE: set of 2 armuwmmm from (6216, 11120), 0 cell(s) from a turret, growing (-5, 0) cells a step (group 9, id 58)
  0.68  RESERVE: served armuwmmm at (6216, 11120) facing 2 (id 58, 1 of this def still held)
  0.77  RESERVE: served armuwmmm at (6136, 11120) facing 2 (id 59, 0 of this def still held)
  1.39  RESERVE: armuwmmm at (6408, 10992) lost; slot restored (id 55)
  1.41  RESERVE: armuwmmm at (6248, 11056) lost; slot restored (id 56)
  1.72  RESERVE: armuwmmm at (6216, 11120) lost; slot restored (id 58)
  1.74  RESERVE: served armuwmmm at (6408, 10992) facing 2 (id 55, 2 of this def still held)
  1.75  RESERVE: served armuwmmm at (6248, 11056) facing 2 (id 56, 1 of this def still held)
  1.96  RESERVE: served armuwmmm at (6216, 11120) facing 2 (id 58, 0 of this def still held)
  2.26  RESERVE: armfmkr at (6184, 11208) is being reclaimed: its slot will be freed (id 49)
  2.26  RESERVE: armfmkr at (6232, 11208) is being reclaimed: its slot will be freed (id 48)
  2.36  RESERVE: armfmkr at (6232, 11208) reclaimed; its ground is free again (id 48)
  2.50  RESERVE: armfmkr at (6184, 11208) reclaimed; its ground is free again (id 49)
  3.25  RESERVE: served armnanotcplat at (6376, 11256) facing 2 (id 36, 30 of this def still held)
  3.26  RESERVE: served armnanotcplat at (5832, 10568) facing 2 (id 40, 29 of this def still held)
  3.27  RESERVE: served armuwfus at (6336, 11312) facing 2 (id 39, 0 of this def still held)
  3.50  RESERVE: served armnanotcplat at (6280, 11256) facing 2 (id 38, 28 of this def still held)
  3.61  RESERVE: served armnanotcplat at (6328, 11208) facing 2 (id 33, 27 of this def still held)
  4.02  RESERVE: served armnanotcplat at (6424, 11256) facing 2 (id 35, 26 of this def still held)
  4.12  RESERVE: served armnanotcplat at (6376, 11208) facing 2 (id 32, 25 of this def still held)
  4.15  RESERVE: served armnanotcplat at (6280, 11208) facing 2 (id 34, 24 of this def still held)
  4.69  RESERVE: served armfmkr at (6136, 11208) facing 2 (id 50, 1 of this def still held)
  4.74  RESERVE: served armfmkr at (6088, 11208) facing 2 (id 51, 0 of this def still held)
  4.80  RESERVE: set of 2 armfmkr from (6232, 11208), 0 cell(s) from a turret, growing (-3, 0) cells a step (group 10, id 60)
  4.80  RESERVE: served armfmkr at (6232, 11208) facing 2 (id 60, 1 of this def still held)
  4.94  RESERVE: served armfmkr at (6184, 11208) facing 2 (id 61, 0 of this def still held)
  4.98  RESERVE: set of 4 armfmkr from (6232, 11256), 0 cell(s) from a turret, growing (-3, 0) cells a step (group 11, id 62)
  4.99  RESERVE: served armfmkr at (6232, 11256) facing 2 (id 62, 3 of this def still held)
  5.02  RESERVE: served armfmkr at (6184, 11256) facing 2 (id 63, 2 of this def still held)
  5.05  RESERVE: served armfmkr at (6136, 11256) facing 2 (id 64, 1 of this def still held)
  5.08  RESERVE: served armfmkr at (6088, 11256) facing 2 (id 65, 0 of this def still held)
  5.41  RESERVE: set of 4 armfmkr from (6232, 11304), 0 cell(s) from a turret, growing (-3, 0) cells a step (group 12, id 66)
  5.42  RESERVE: served armfmkr at (6232, 11304) facing 2 (id 66, 3 of this def still held)
  5.46  RESERVE: served armfmkr at (6184, 11304) facing 2 (id 67, 2 of this def still held)
  5.55  RESERVE: served armfmkr at (6136, 11304) facing 2 (id 68, 1 of this def still held)
  5.59  RESERVE: served armfmkr at (6088, 11304) facing 2 (id 69, 0 of this def still held)
```
