# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 12.2 min (frame 21977); wall 101 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:33:47
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163347Z-b8e41e38\runs\20261004T163531Z-7d750e6b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | **missing** (by 12 min) | |
| expect `t2` | seen at 6.2 min | `[t=00:01:08.253865][f=0011160] [SeaBlock] PASS packed armuwmmm count=8 edges=8` |
| expect `shipyard` | seen at 1.8 min | `[t=00:00:47.974780][f=0003300] [SeaBlock] PASS factory assist armsy` |
| expect `amphibious` | seen at 1.9 min | `[t=00:00:48.242898][f=0003420] [SeaBlock] PASS factory assist armamsub` |
| expect `fusion-support` | **missing** (by 12 min) | |
| expect `rear-fusion` | **missing** (by 12 min) | |
| forbid `errors` | clean |  |

## Failures

- 't1' not seen by 12.0 min
- 'fusion-support' not seen by 12.0 min
- 'rear-fusion' not seen by 12.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163347Z-b8e41e38\runs\20261004T163531Z-7d750e6b\screen_2026-10-04_16-34-44-748.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163347Z-b8e41e38\runs\20261004T163531Z-7d750e6b\screen_2026-10-04_16-34-57-737.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163347Z-b8e41e38\runs\20261004T163531Z-7d750e6b\screen_2026-10-04_16-34-58-144.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163347Z-b8e41e38\runs\20261004T163531Z-7d750e6b\screen_2026-10-04_16-35-24-562.png

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
  0.97  [Playtest] finished armuwmmm team 0 at 0.97 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.6 bank 98999/100100, energy +178.0 bank 971201/1001050, units 20
  1.80  [Playtest] finished armnanotcplat team 0 at 1.80 min
  1.81  [Playtest] finished armnanotcplat team 0 at 1.81 min
  1.84  [Playtest] finished armnanotcplat team 0 at 1.84 min
  1.88  [Playtest] finished armnanotcplat team 0 at 1.88 min
  1.96  [Playtest] finished armuwmmm team 0 at 1.96 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +22.7 bank 96630/100100, energy +178.0 bank 878366/1001050, units 26
  2.29  [Playtest] finished armnanotcplat team 0 at 2.29 min
  2.33  [Playtest] finished armnanotcplat team 0 at 2.33 min
  2.39  [Playtest] finished armnanotcplat team 0 at 2.39 min
  2.52  [Playtest] finished armnanotcplat team 0 at 2.52 min
  2.64  [Playtest] finished armnanotcplat team 0 at 2.64 min
  2.73  [Playtest] finished armnanotcplat team 0 at 2.72 min
  2.82  [Playtest] finished armnanotcplat team 0 at 2.82 min
  2.83  [Playtest] finished armnanotcplat team 0 at 2.83 min
  2.95  [Playtest] finished armnanotcplat team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.7 bank 91065/100100, energy +178.0 bank 718583/1001050, units 41
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.08  [Playtest] finished armnanotcplat team 0 at 3.08 min
  3.15  [Playtest] finished armnanotcplat team 0 at 3.15 min
  3.27  [Playtest] finished armuwmmm team 0 at 3.27 min
  3.42  [Playtest] finished armnanotcplat team 0 at 3.42 min
  3.49  [Playtest] finished armnanotcplat team 0 at 3.49 min
  3.57  [Playtest] finished armnanotcplat team 0 at 3.57 min
  3.70  [Playtest] finished armnanotcplat team 0 at 3.70 min
  3.88  [Playtest] finished armnanotcplat team 0 at 3.88 min
  3.88  [Playtest] finished armnanotcplat team 0 at 3.88 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.7 bank 80573/100100, energy +178.0 bank 553066/1001050, units 60
  4.07  [Playtest] finished armnanotcplat team 0 at 4.07 min
  4.07  [Playtest] finished armuwmmm team 0 at 4.07 min
  4.22  [Playtest] finished armuwmmm team 0 at 4.22 min
  4.22  [Playtest] finished armnanotcplat team 0 at 4.22 min
  4.29  [Playtest] finished armnanotcplat team 0 at 4.29 min
  4.29  [Playtest] finished armuwmmm team 0 at 4.29 min
  4.34  [Playtest] finished armnanotcplat team 0 at 4.34 min
  4.40  [Playtest] finished armnanotcplat team 0 at 4.40 min
  4.48  [Playtest] finished armnanotcplat team 0 at 4.48 min
  4.53  [Playtest] finished armnanotcplat team 0 at 4.53 min
  4.60  [Playtest] finished armnanotcplat team 0 at 4.60 min
  4.68  [Playtest] finished armnanotcplat team 0 at 4.68 min
  4.69  [Playtest] finished armuwmmm team 0 at 4.69 min
  4.74  [Playtest] finished armnanotcplat team 0 at 4.74 min
  4.81  [Playtest] finished armnanotcplat team 0 at 4.81 min
  4.84  [Playtest] finished armnanotcplat team 0 at 4.84 min
  4.89  [Playtest] finished armnanotcplat team 0 at 4.89 min
  4.92  [Playtest] finished armnanotcplat team 0 at 4.92 min
  4.95  [Playtest] finished armnanotcplat team 0 at 4.95 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 66069/100100, energy +178.0 bank 348786/1001050, units 87
  5.03  [Playtest] finished armnanotcplat team 0 at 5.03 min
  5.27  [Playtest] finished armnanotcplat team 0 at 5.27 min
  5.40  [Playtest] finished armnanotcplat team 0 at 5.40 min
  5.42  [Playtest] finished armnanotcplat team 0 at 5.42 min
  5.46  [Playtest] finished armnanotcplat team 0 at 5.46 min
  5.64  [Playtest] finished armnanotcplat team 0 at 5.64 min
  5.64  [Playtest] finished armnanotcplat team 0 at 5.64 min
  5.71  [Playtest] finished armnanotcplat team 0 at 5.71 min
  5.89  [Playtest] finished armnanotcplat team 0 at 5.89 min
  5.98  [Playtest] finished armnanotcplat team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 51329/100100, energy +178.0 bank 153629/1001050, units 112
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  6.07  [Playtest] finished armnanotcplat team 0 at 6.07 min
  6.20  [Playtest] finished armuwmmm team 0 at 6.20 min
  6.47  [Playtest] finished armfmkr team 0 at 6.47 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 39073/100100, energy +178.0 bank 9152/1001050, units 128
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 38788/100100, energy +178.0 bank 11957/1001050, units 128
  9.00  [Playtest] eco team 0 at 9.0 min: metal +2.0 bank 38260/100100, energy +178.0 bank 9900/1001050, units 129
 10.00  [Playtest] eco team 0 at 10.0 min: metal +2.0 bank 37945/100100, energy +178.0 bank 12257/1001050, units 129
 11.00  [Playtest] eco team 0 at 11.0 min: metal +2.0 bank 37493/100100, energy +178.0 bank 11714/1001050, units 130
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +2.0 bank 37009/100100, energy +178.0 bank 10469/1001050, units 131
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (6776, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6776, 10760) facing 2 (id 1)
  0.18  RESERVE: zone 1 released
  0.18  RESERVE: corridor 2 at (6600, 11028) facing 0, 13x31 cells: 273 of 403 held
  0.18  RESERVE: corridor 3 at (5824, 11024) facing 0, 12x30 cells: 240 of 360 held
  0.18  RESERVE: zone 4 at (6600, 11188) facing 2, 41x41 cells: 1300 of 1681 held
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 at (6472, 11188) facing 2, 41x41 cells: 1304 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6472, 11092) facing 2: 8 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 at (6728, 11188) facing 2, 41x41 cells: 1308 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6728, 11092) facing 2: 6 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 at (6344, 11188) facing 2, 41x41 cells: 1357 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6344, 11092) facing 2: 16 of 16 slots (group 4, held, zone)
  0.18  RESERVE: armuwfus at (6336, 11312) facing 2 (id 32)
  0.18  RESERVE: packed armuwfus at (6336, 11312) facing 2 in zone 7, 313 from a turret (id 32, group 0, 824 candidates)
  0.20  RESERVE: set of 4 armfmkr from (6232, 11208), 0 cell(s) from a turret, growing (-3, 0) cells a step (group 5, id 33)
  0.20  RESERVE: served armfmkr at (6232, 11208) facing 2 (id 33, 3 of this def still held)
  0.20  RESERVE: zone 8 at (6824, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10456) facing 2 (id 37)
  0.20  RESERVE: zone 8 released
  0.20  RESERVE: zone 9 at (6872, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6872, 10520) facing 2 (id 38)
  0.20  RESERVE: zone 10 at (6824, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10520) facing 2 (id 39)
  0.20  RESERVE: zone 11 at (6776, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6776, 10520) facing 2 (id 40)
  0.20  RESERVE: zone 12 at (6728, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6728, 10520) facing 2 (id 41)
  0.20  RESERVE: zone 13 at (6680, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6680, 10520) facing 2 (id 42)
  0.20  RESERVE: zone 14 at (6872, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6872, 10472) facing 2 (id 43)
  0.20  RESERVE: zone 15 at (6824, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10472) facing 2 (id 44)
  0.20  RESERVE: zone 9 released
  0.20  RESERVE: zone 10 released
  0.20  RESERVE: zone 11 released
  0.20  RESERVE: zone 12 released
  0.20  RESERVE: zone 13 released
  0.20  RESERVE: zone 14 released
  0.20  RESERVE: zone 15 released
  0.20  RESERVE: zone 16 at (6968, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6968, 10696) facing 2 (id 45)
  0.20  RESERVE: zone 17 at (6920, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6920, 10696) facing 2 (id 46)
  0.20  RESERVE: zone 18 at (6872, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6872, 10696) facing 2 (id 47)
  0.20  RESERVE: zone 19 at (6824, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10696) facing 2 (id 48)
  0.20  RESERVE: zone 20 at (6776, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6776, 10696) facing 2 (id 49)
  0.20  RESERVE: zone 21 at (6968, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6968, 10648) facing 2 (id 50)
  0.20  RESERVE: zone 22 at (6920, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6920, 10648) facing 2 (id 51)
  0.20  RESERVE: zone 23 at (6872, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6872, 10648) facing 2 (id 52)
  0.20  RESERVE: zone 24 at (6824, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10648) facing 2 (id 53)
  0.20  RESERVE: zone 25 at (6776, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6776, 10648) facing 2 (id 54)
  0.20  RESERVE: zone 26 at (6968, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6968, 10600) facing 2 (id 55)
  0.20  RESERVE: zone 27 at (6920, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6920, 10600) facing 2 (id 56)
  0.20  RESERVE: zone 28 at (6872, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6872, 10600) facing 2 (id 57)
  0.20  RESERVE: zone 29 at (6824, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10600) facing 2 (id 58)
  0.20  RESERVE: zone 30 at (6776, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6776, 10600) facing 2 (id 59)
  0.20  RESERVE: zone 16 released
  0.20  RESERVE: zone 17 released
  0.20  RESERVE: zone 18 released
  0.20  RESERVE: zone 19 released
  0.20  RESERVE: zone 20 released
  0.20  RESERVE: zone 21 released
  0.20  RESERVE: zone 22 released
  0.20  RESERVE: zone 23 released
  0.20  RESERVE: zone 24 released
  0.20  RESERVE: zone 25 released
  0.20  RESERVE: zone 26 released
  0.20  RESERVE: zone 27 released
  0.20  RESERVE: zone 28 released
  0.20  RESERVE: zone 29 released
  0.20  RESERVE: zone 30 released
  0.20  RESERVE: zone 31 at (6904, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6904, 10792) facing 2 (id 60)
  0.20  RESERVE: zone 32 at (6856, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6856, 10792) facing 2 (id 61)
  0.20  RESERVE: zone 33 at (6808, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6808, 10792) facing 2 (id 62)
  0.20  RESERVE: zone 34 at (6760, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6760, 10792) facing 2 (id 63)
  0.20  RESERVE: zone 31 released
  0.20  RESERVE: zone 32 released
  0.20  RESERVE: zone 33 released
  0.20  RESERVE: zone 34 released
  0.21  RESERVE: served armfmkr at (6184, 11208) facing 2 (id 34, 2 of this def still held)
  0.22  RESERVE: zone 35 at (6808, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6808, 10856) facing 2 (id 64)
  0.22  RESERVE: zone 36 at (6760, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6760, 10856) facing 2 (id 65)
  0.22  RESERVE: zone 35 released
  0.22  RESERVE: zone 36 released
  0.22  RESERVE: zone 37 at (6424, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 10472) facing 2 (id 66)
  0.22  RESERVE: zone 38 at (6376, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 10472) facing 2 (id 67)
  0.22  RESERVE: zone 39 at (6328, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6328, 10472) facing 2 (id 68)
  0.22  RESERVE: zone 37 released
  0.22  RESERVE: zone 38 released
  0.22  RESERVE: zone 39 released
  0.22  RESERVE: zone 40 at (6488, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 10392) facing 2 (id 69)
  0.22  RESERVE: zone 41 at (6440, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 10392) facing 2 (id 70)
```
