# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 8.2 min (frame 14731); wall 74 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:08:28
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: dense-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T140827Z-eddf94f3\runs\20261004T140944Z-72df1e1f\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `armsy` | **missing** (by 8 min) | |
| expect `armamsub` | **missing** (by 8 min) | |
| forbid `runtime` | clean |  |

## Failures

- 'armsy' not seen by 8.0 min
- 'armamsub' not seen by 8.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T140827Z-eddf94f3\runs\20261004T140944Z-72df1e1f\screen_2026-10-04_14-09-16-565.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T140827Z-eddf94f3\runs\20261004T140944Z-72df1e1f\screen_2026-10-04_14-09-29-550.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T140827Z-eddf94f3\runs\20261004T140944Z-72df1e1f\screen_2026-10-04_14-09-33-603.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-support\glacial\20261004T140827Z-eddf94f3\runs\20261004T140944Z-72df1e1f\screen_2026-10-04_14-09-38-536.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 8.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2300, 4400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7000, 6500) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2300, 4400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7000, 6500) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=2304,4400 facing=1
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=2304,4000 facing=1
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=2304,3600 facing=1
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  0.18  [SEA][Layout] replan unused berth sea.berth.0
  0.32  [SEA][Layout] berth sea.berth.0 armsy at=2496,4400 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 100100/100100, energy +58.0 bank 1000450/1000450, units 7
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 100100/100100, energy +58.0 bank 1000450/1000450, units 7
  2.00  [Playtest] target team 0 at (2300, 4400) from its start position
  2.00  [Playtest] camera requested (2300,4400) height=2200
  2.00  [Playtest] camera captured name=ta position=(2300,4400) height=2200
  2.00  [Playtest] screenshot at 2.0 min of team 0 at (2300, 4400)
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 100100/100100, energy +58.0 bank 1000450/1000450, units 7
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 100100/100100, energy +58.0 bank 1000450/1000450, units 7
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 100100/100100, energy +58.0 bank 1000450/1000450, units 7
  5.00  [Playtest] camera requested (2300,4400) height=2200
  5.00  [Playtest] camera captured name=ta position=(2300,4400) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2300, 4400)
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 100100/100100, energy +58.0 bank 1000450/1000450, units 7
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 100100/100100, energy +58.0 bank 1000450/1000450, units 7
  7.00  [Playtest] camera requested (2300,4400) height=2200
  7.00  [Playtest] camera captured name=ta position=(2300,4400) height=2200
  7.00  [Playtest] screenshot at 7.0 min of team 0 at (2300, 4400)
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 100100/100100, energy +58.0 bank 1000450/1000450, units 7
```

## Native lines (all AIs, first 120)

```
  0.10  RESERVE: zone 1 at (2304, 4400) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (2304, 4400) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (2592, 4400) facing 1, 30x12 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (2008, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2008, 4504) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (2008, 4456) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2008, 4456) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (2008, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2008, 4408) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (2008, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2008, 4360) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (2008, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2008, 4312) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (2056, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2056, 4504) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (2056, 4456) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2056, 4456) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (2056, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2056, 4408) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (2056, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2056, 4360) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (2056, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2056, 4312) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (2104, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2104, 4504) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (2104, 4456) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2104, 4456) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (2104, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2104, 4408) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (2104, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2104, 4360) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (2104, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2104, 4312) facing 1 (id 16)
  0.10  RESERVE: zone 18 at (2152, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2152, 4504) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (2152, 4456) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2152, 4456) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (2152, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2152, 4408) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (2152, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2152, 4360) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (2152, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2152, 4312) facing 1 (id 21)
  0.12  RESERVE: zone 23 at (2304, 4000) facing 1, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (2304, 4000) facing 1 (id 22)
  0.12  RESERVE: corridor 24 at (2640, 4000) facing 1, 30x18 cells: 540 of 540 held
  0.12  RESERVE: zone 25 at (2104, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 4104) facing 1 (id 23)
  0.12  RESERVE: zone 26 at (2104, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 4056) facing 1 (id 24)
  0.12  RESERVE: zone 27 at (2104, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 4008) facing 1 (id 25)
  0.12  RESERVE: zone 28 at (2104, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 3960) facing 1 (id 26)
  0.12  RESERVE: zone 29 at (2104, 3912) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 3912) facing 1 (id 27)
  0.12  RESERVE: zone 30 at (2152, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 4104) facing 1 (id 28)
  0.12  RESERVE: zone 31 at (2152, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 4056) facing 1 (id 29)
  0.12  RESERVE: zone 32 at (2152, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 4008) facing 1 (id 30)
  0.12  RESERVE: zone 33 at (2152, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 3960) facing 1 (id 31)
  0.12  RESERVE: zone 34 at (2152, 3912) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 3912) facing 1 (id 32)
  0.12  RESERVE: zone 25 released
  0.12  RESERVE: zone 26 released
  0.12  RESERVE: zone 27 released
  0.12  RESERVE: zone 28 released
  0.12  RESERVE: zone 29 released
  0.12  RESERVE: zone 30 released
  0.12  RESERVE: zone 31 released
  0.12  RESERVE: zone 32 released
  0.12  RESERVE: zone 33 released
  0.12  RESERVE: zone 34 released
  0.12  RESERVE: zone 35 at (2104, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 4136) facing 1 (id 33)
  0.12  RESERVE: zone 36 at (2104, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 4088) facing 1 (id 34)
  0.12  RESERVE: zone 37 at (2104, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 4040) facing 1 (id 35)
  0.12  RESERVE: zone 38 at (2104, 3992) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 3992) facing 1 (id 36)
  0.12  RESERVE: zone 39 at (2104, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2104, 3944) facing 1 (id 37)
  0.12  RESERVE: zone 40 at (2152, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 4136) facing 1 (id 38)
  0.12  RESERVE: zone 41 at (2152, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 4088) facing 1 (id 39)
  0.12  RESERVE: zone 42 at (2152, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 4040) facing 1 (id 40)
  0.12  RESERVE: zone 43 at (2152, 3992) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 3992) facing 1 (id 41)
  0.12  RESERVE: zone 44 at (2152, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 3944) facing 1 (id 42)
  0.12  RESERVE: zone 45 at (2200, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2200, 4136) facing 1 (id 43)
  0.12  RESERVE: zone 35 released
  0.12  RESERVE: zone 36 released
  0.12  RESERVE: zone 37 released
  0.12  RESERVE: zone 38 released
  0.12  RESERVE: zone 39 released
  0.12  RESERVE: zone 40 released
  0.12  RESERVE: zone 41 released
  0.12  RESERVE: zone 42 released
  0.12  RESERVE: zone 43 released
  0.12  RESERVE: zone 44 released
  0.12  RESERVE: zone 45 released
  0.12  RESERVE: zone 46 at (2072, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2072, 4168) facing 1 (id 44)
  0.12  RESERVE: zone 47 at (2072, 4120) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2072, 4120) facing 1 (id 45)
  0.12  RESERVE: zone 48 at (2072, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2072, 4072) facing 1 (id 46)
  0.12  RESERVE: zone 49 at (2072, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2072, 4024) facing 1 (id 47)
  0.12  RESERVE: zone 50 at (2072, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2072, 3976) facing 1 (id 48)
  0.12  RESERVE: zone 51 at (2120, 4168) facing 1, 3x3 cells: 9 of 9 held
```
