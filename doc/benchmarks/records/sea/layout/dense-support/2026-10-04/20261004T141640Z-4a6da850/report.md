# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 8.1 min (frame 14491); wall 78 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:15:19
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: dense-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T141518Z-a67daaed\runs\20261004T141640Z-4a6da850\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `armsy` | **missing** (by 8 min) | |
| expect `armamsub` | seen at 1.7 min | `[t=00:00:47.660499][f=0003000] [DenseFixture] PASS support armamsub turrets=6 assisting=6 product=5616` |
| forbid `runtime` | clean |  |

## Failures

- 'armsy' not seen by 8.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T141518Z-a67daaed\runs\20261004T141640Z-4a6da850\screen_2026-10-04_14-16-13-308.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T141518Z-a67daaed\runs\20261004T141640Z-4a6da850\screen_2026-10-04_14-16-26-298.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T141518Z-a67daaed\runs\20261004T141640Z-4a6da850\screen_2026-10-04_14-16-30-410.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T141518Z-a67daaed\runs\20261004T141640Z-4a6da850\screen_2026-10-04_14-16-35-357.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 8.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1450, 3700) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7000, 6500) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1450, 3700) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7000, 6500) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1552,3696 facing=1
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1456,3296 facing=3
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  0.43  [SEA][Layout] berth sea.berth.2 armasy at=736,3184 facing=3
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 98683/100100, energy +58.0 bank 987060/1000450, units 15
  1.33  [Playtest] finished armnanotcplat team 0 at 1.33 min
  1.35  [Playtest] finished armnanotcplat team 0 at 1.35 min
  1.36  [Playtest] finished armnanotcplat team 0 at 1.36 min
  1.36  [Playtest] finished armnanotcplat team 0 at 1.36 min
  1.54  [Playtest] finished armnanotcplat team 0 at 1.54 min
  1.64  [Playtest] finished armnanotcplat team 0 at 1.64 min
  1.71  [Playtest] finished armnanotcplat team 0 at 1.71 min
  1.74  [Playtest] finished armnanotcplat team 0 at 1.74 min
  1.80  [Playtest] finished armnanotcplat team 0 at 1.80 min
  1.85  [Playtest] finished armnanotcplat team 0 at 1.85 min
  1.92  [Playtest] finished armnanotcplat team 0 at 1.92 min
  1.99  [Playtest] finished armnanotcplat team 0 at 1.99 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 93779/100100, energy +58.0 bank 931625/1000450, units 36
  2.00  [Playtest] target team 0 at (1450, 3700) from its start position
  2.00  [Playtest] camera requested (1450,3700) height=2200
  2.01  [Playtest] camera captured name=ta position=(1450,3700) height=2200
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (1450, 3700)
  2.01  [Playtest] finished armnanotcplat team 0 at 2.01 min
  2.02  [Playtest] finished armnanotcplat team 0 at 2.02 min
  2.08  [Playtest] finished armnanotcplat team 0 at 2.08 min
  2.13  [Playtest] finished armnanotcplat team 0 at 2.13 min
  2.16  [Playtest] finished armnanotcplat team 0 at 2.16 min
  2.18  [Playtest] finished armnanotcplat team 0 at 2.18 min
  2.19  [Playtest] finished armnanotcplat team 0 at 2.19 min
  2.24  [Playtest] finished armnanotcplat team 0 at 2.24 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 87519/100100, energy +58.0 bank 867213/1000450, units 62
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 82096/100100, energy +58.0 bank 816713/1000450, units 87
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 75891/100100, energy +58.0 bank 758300/1000450, units 115
  5.00  [Playtest] camera requested (1450,3700) height=2200
  5.01  [Playtest] camera captured name=ta position=(1450,3700) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 3700)
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 69706/100100, energy +58.0 bank 700039/1000450, units 144
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 63549/100100, energy +58.0 bank 642073/1000450, units 174
  7.00  [Playtest] camera requested (1450,3700) height=2200
  7.01  [Playtest] camera captured name=ta position=(1450,3700) height=2200
  7.01  [Playtest] screenshot at 7.0 min of team 0 at (1450, 3700)
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 57708/100100, energy +58.0 bank 587693/1000450, units 200
```

## Native lines (all AIs, first 120)

```
  0.10  RESERVE: zone 1 at (1552, 3696) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1552, 3696) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1840, 3696) facing 1, 30x12 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (1256, 3800) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 3800) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1256, 3752) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 3752) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1256, 3704) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 3704) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1256, 3656) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 3656) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1256, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 3608) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (1304, 3800) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 3800) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1304, 3752) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 3752) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (1304, 3704) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 3704) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1304, 3656) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 3656) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1304, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 3608) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1352, 3800) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3800) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1352, 3752) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3752) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1352, 3704) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3704) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1352, 3656) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3656) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (1352, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3608) facing 1 (id 16)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 at (1352, 3800) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3800) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (1352, 3752) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3752) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (1352, 3704) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3704) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (1352, 3656) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3656) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (1352, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3608) facing 1 (id 21)
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 at (1352, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3832) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (1352, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3784) facing 1 (id 23)
  0.10  RESERVE: zone 25 at (1352, 3736) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3736) facing 1 (id 24)
  0.10  RESERVE: zone 26 at (1352, 3688) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3688) facing 1 (id 25)
  0.10  RESERVE: zone 27 at (1352, 3640) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3640) facing 1 (id 26)
  0.10  RESERVE: zone 28 at (1400, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1400, 3832) facing 1 (id 27)
  0.10  RESERVE: zone 23 released
  0.10  RESERVE: zone 24 released
  0.10  RESERVE: zone 25 released
  0.10  RESERVE: zone 26 released
  0.10  RESERVE: zone 27 released
  0.10  RESERVE: zone 28 released
  0.10  RESERVE: zone 29 at (1320, 3864) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1320, 3864) facing 1 (id 28)
  0.10  RESERVE: zone 30 at (1320, 3816) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1320, 3816) facing 1 (id 29)
  0.10  RESERVE: zone 31 at (1320, 3768) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1320, 3768) facing 1 (id 30)
  0.10  RESERVE: zone 32 at (1320, 3720) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1320, 3720) facing 1 (id 31)
  0.10  RESERVE: zone 33 at (1320, 3672) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1320, 3672) facing 1 (id 32)
  0.10  RESERVE: zone 34 at (1368, 3864) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1368, 3864) facing 1 (id 33)
  0.10  RESERVE: zone 35 at (1368, 3816) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1368, 3816) facing 1 (id 34)
  0.10  RESERVE: zone 36 at (1368, 3768) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1368, 3768) facing 1 (id 35)
  0.10  RESERVE: zone 37 at (1368, 3720) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1368, 3720) facing 1 (id 36)
  0.10  RESERVE: zone 38 at (1368, 3672) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1368, 3672) facing 1 (id 37)
  0.10  RESERVE: zone 39 at (1416, 3864) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1416, 3864) facing 1 (id 38)
  0.10  RESERVE: zone 40 at (1416, 3816) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1416, 3816) facing 1 (id 39)
  0.10  RESERVE: zone 29 released
  0.10  RESERVE: zone 30 released
  0.10  RESERVE: zone 31 released
  0.10  RESERVE: zone 32 released
  0.10  RESERVE: zone 33 released
  0.10  RESERVE: zone 34 released
  0.10  RESERVE: zone 35 released
  0.10  RESERVE: zone 36 released
  0.10  RESERVE: zone 37 released
  0.10  RESERVE: zone 38 released
  0.10  RESERVE: zone 39 released
  0.10  RESERVE: zone 40 released
  0.10  RESERVE: zone 41 at (1192, 3864) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 3864) facing 1 (id 40)
  0.10  RESERVE: zone 42 at (1192, 3816) facing 1, 3x3 cells: 9 of 9 held
```
