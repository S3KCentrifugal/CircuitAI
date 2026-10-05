# Playtest report: PASS

- Verdict: **PASS** (reached 8 min)
- Game time reached: 8.1 min (frame 14580); wall 72 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:22:59
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: dense-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-sea\glacial\20261004T142258Z-3e301613\runs\20261004T142414Z-7e46ba2c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `armtide` | seen at 4.3 min | `[t=00:00:53.836580][f=0007800] [DenseFixture] PASS touching armtide count=12 edges=16` |
| expect `armfmkr` | seen at 6.8 min | `[t=00:01:04.821401][f=0012300] [DenseFixture] PASS touching armfmkr count=6 edges=7` |
| expect `armuwmmm` | seen at 3.8 min | `[t=00:00:51.839069][f=0006900] [DenseFixture] PASS touching armuwmmm count=6 edges=7` |
| forbid `runtime` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-sea\glacial\20261004T142258Z-3e301613\runs\20261004T142414Z-7e46ba2c\screen_2026-10-04_14-23-47-261.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-sea\glacial\20261004T142258Z-3e301613\runs\20261004T142414Z-7e46ba2c\screen_2026-10-04_14-24-00-250.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-sea\glacial\20261004T142258Z-3e301613\runs\20261004T142414Z-7e46ba2c\screen_2026-10-04_14-24-04-301.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\dense-sea\glacial\20261004T142258Z-3e301613\runs\20261004T142414Z-7e46ba2c\screen_2026-10-04_14-24-09-237.png

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
  0.43  [SEA][Layout] berth sea.berth.2 armasy at=736,3184 facing=3
  0.51  [Playtest] finished armtide team 0 at 0.51 min
  0.82  [Playtest] finished armtide team 0 at 0.82 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99196/100000, energy +203.0 bank 970935/1000750, units 13
  1.12  [Playtest] finished armtide team 0 at 1.12 min
  1.43  [Playtest] finished armtide team 0 at 1.43 min
  1.74  [Playtest] finished armtide team 0 at 1.74 min
  1.92  [Playtest] finished armuwmmm team 0 at 1.92 min
  1.92  [Playtest] finished armuwmmm team 0 at 1.92 min
  1.94  [Playtest] finished armuwmmm team 0 at 1.94 min
  1.94  [Playtest] finished armuwmmm team 0 at 1.94 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +43.4 bank 98349/100000, energy +272.0 bank 928253/1000900, units 17
  2.00  [Playtest] target team 0 at (1450, 3700) from its start position
  2.00  [Playtest] camera requested (1450,3700) height=2200
  2.00  [Playtest] camera captured name=ta position=(1450,3700) height=2200
  2.00  [Playtest] screenshot at 2.0 min of team 0 at (1450, 3700)
  2.05  [Playtest] finished armtide team 0 at 2.05 min
  2.38  [Playtest] finished armtide team 0 at 2.38 min
  2.86  [Playtest] finished armtide team 0 at 2.86 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +43.4 bank 99996/100000, energy +341.0 bank 777509/1001050, units 21
  3.26  [Playtest] finished armtide team 0 at 3.26 min
  3.56  [Playtest] finished armtide team 0 at 3.57 min
  3.65  [Playtest] finished armuwmmm team 0 at 3.65 min
  3.68  [Playtest] finished armuwmmm team 0 at 3.68 min
  3.88  [Playtest] finished armtide team 0 at 3.88 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.1 bank 99766/100000, energy +410.0 bank 751099/1001200, units 24
  4.28  [Playtest] finished armtide team 0 at 4.28 min
  4.84  [Playtest] finished armfmkr team 0 at 4.84 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +8.5 bank 100000/100000, energy +433.0 bank 751126/1001250, units 26
  5.00  [Playtest] camera requested (1450,3700) height=2200
  5.01  [Playtest] camera captured name=ta position=(1450,3700) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 3700)
  5.20  [Playtest] finished armfmkr team 0 at 5.20 min
  5.64  [Playtest] finished armfmkr team 0 at 5.64 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +8.5 bank 100000/100000, energy +433.0 bank 751126/1001250, units 28
  6.02  [Playtest] finished armfmkr team 0 at 6.02 min
  6.39  [Playtest] finished armfmkr team 0 at 6.39 min
  6.79  [Playtest] finished armfmkr team 0 at 6.79 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +9.5 bank 100000/100000, energy +433.0 bank 751154/1001250, units 30
  7.00  [Playtest] camera requested (1450,3700) height=2200
  7.01  [Playtest] camera captured name=ta position=(1450,3700) height=2200
  7.01  [Playtest] screenshot at 7.0 min of team 0 at (1450, 3700)
  8.00  [Playtest] eco team 0 at 8.0 min: metal +9.5 bank 100000/100000, energy +433.0 bank 751154/1001250, units 30
```

## Native lines (all AIs, first 120)

```
  0.10  RESERVE: zone 1 at (1552, 3696) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1552, 3696) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1840, 3696) facing 1, 30x12 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (1336, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 3976) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1336, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 3928) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1336, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 3880) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1336, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 3832) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1336, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 3784) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (1384, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1384, 3976) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1384, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1384, 3928) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (1384, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1384, 3880) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1384, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1384, 3832) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1384, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1384, 3784) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1432, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1432, 3976) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1432, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1432, 3928) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1432, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1432, 3880) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1432, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1432, 3832) facing 1 (id 15)
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
  0.12  RESERVE: zone 17 at (1456, 3296) facing 3, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (1456, 3296) facing 3 (id 16)
  0.12  RESERVE: corridor 18 at (1120, 3296) facing 3, 30x18 cells: 540 of 540 held
  0.12  RESERVE: zone 19 at (1176, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1176, 3608) facing 1 (id 17)
  0.12  RESERVE: zone 20 at (1176, 3560) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1176, 3560) facing 1 (id 18)
  0.12  RESERVE: zone 19 released
  0.12  RESERVE: zone 20 released
  0.12  RESERVE: zone 21 at (1256, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1256, 3608) facing 1 (id 19)
  0.12  RESERVE: zone 22 at (1256, 3560) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1256, 3560) facing 1 (id 20)
  0.12  RESERVE: zone 23 at (1256, 3512) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1256, 3512) facing 1 (id 21)
  0.12  RESERVE: zone 24 at (1256, 3464) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1256, 3464) facing 1 (id 22)
  0.12  RESERVE: zone 21 released
  0.12  RESERVE: zone 22 released
  0.12  RESERVE: zone 23 released
  0.12  RESERVE: zone 24 released
  0.12  RESERVE: zone 25 at (1336, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1336, 3608) facing 1 (id 23)
  0.12  RESERVE: zone 26 at (1336, 3560) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1336, 3560) facing 1 (id 24)
  0.12  RESERVE: zone 27 at (1336, 3512) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1336, 3512) facing 1 (id 25)
  0.12  RESERVE: zone 28 at (1336, 3464) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1336, 3464) facing 1 (id 26)
  0.12  RESERVE: zone 25 released
  0.12  RESERVE: zone 26 released
  0.12  RESERVE: zone 27 released
  0.12  RESERVE: zone 28 released
  0.12  RESERVE: zone 29 at (1384, 3656) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1384, 3656) facing 1 (id 27)
  0.12  RESERVE: zone 30 at (1384, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1384, 3608) facing 1 (id 28)
  0.12  RESERVE: zone 31 at (1384, 3560) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1384, 3560) facing 1 (id 29)
  0.12  RESERVE: zone 32 at (1384, 3512) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1384, 3512) facing 1 (id 30)
  0.12  RESERVE: zone 33 at (1384, 3464) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1384, 3464) facing 1 (id 31)
  0.12  RESERVE: zone 34 at (1432, 3656) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1432, 3656) facing 1 (id 32)
  0.12  RESERVE: zone 35 at (1432, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1432, 3608) facing 1 (id 33)
  0.12  RESERVE: zone 36 at (1432, 3560) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1432, 3560) facing 1 (id 34)
  0.12  RESERVE: zone 37 at (1432, 3512) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1432, 3512) facing 1 (id 35)
  0.12  RESERVE: zone 38 at (1432, 3464) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1432, 3464) facing 1 (id 36)
  0.12  RESERVE: zone 39 at (1480, 3656) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1480, 3656) facing 1 (id 37)
  0.12  RESERVE: zone 40 at (1480, 3608) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1480, 3608) facing 1 (id 38)
  0.12  RESERVE: zone 41 at (1480, 3560) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1480, 3560) facing 1 (id 39)
  0.12  RESERVE: zone 42 at (1480, 3512) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1480, 3512) facing 1 (id 40)
  0.12  RESERVE: zone 43 at (1480, 3464) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (1480, 3464) facing 1 (id 41)
  0.12  RESERVE: zone 29 released
  0.12  RESERVE: zone 30 released
  0.12  RESERVE: zone 31 released
  0.12  RESERVE: zone 32 released
  0.12  RESERVE: zone 33 released
  0.12  RESERVE: zone 34 released
  0.12  RESERVE: zone 35 released
  0.12  RESERVE: zone 36 released
  0.12  RESERVE: zone 37 released
  0.12  RESERVE: zone 38 released
  0.12  RESERVE: zone 39 released
  0.12  RESERVE: zone 40 released
```
