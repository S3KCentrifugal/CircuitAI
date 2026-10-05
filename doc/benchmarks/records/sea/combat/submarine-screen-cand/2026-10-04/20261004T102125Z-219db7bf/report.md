# Playtest report: PASS

- Verdict: **PASS** (reached 8 min)
- Game time reached: 8.1 min (frame 14580); wall 104 s
- DLL: build-theatres\d189-build-5\SkirmishAI.dll (1b875078bc2aa763); AI BARbTest/test; staged 2026-10-04T07:19:37
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\submarine-screen-cand\glacial\20261004T101937Z-e3515fff\runs\20261004T102125Z-219db7bf\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:38.159609][f=-000001] [SeaArena] frame=0 loaded case=submarine-screen control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:48.918671][f=0000304] [SeaArena] frame=304 spawn id=24620 team=0 unit=armroy` |
| expect `combat` | seen at 0.3 min | `[t=00:00:49.982011][f=0000623] [SeaArena] frame=623 damage victim=29006 attacker=30373 team=1 amount=342.5` |
| expect `orders` | seen at 1.0 min | `[t=00:00:57.269098][f=0001800] [SeaArena] frame=1800 orders team=1 apm=307 repeated=5` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\submarine-screen-cand\glacial\20261004T101937Z-e3515fff\runs\20261004T102125Z-219db7bf\screen_2026-10-04_10-20-32-927.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\submarine-screen-cand\glacial\20261004T101937Z-e3515fff\runs\20261004T102125Z-219db7bf\screen_2026-10-04_10-20-36-165.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\submarine-screen-cand\glacial\20261004T101937Z-e3515fff\runs\20261004T102125Z-219db7bf\screen_2026-10-04_10-20-52-480.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\submarine-screen-cand\glacial\20261004T101937Z-e3515fff\runs\20261004T102125Z-219db7bf\screen_2026-10-04_10-21-17-459.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 4 shots, end at 8.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2300, 4400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2300, 4400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=2304,4400 facing=1
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=2304,4000 facing=1
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=2304,3600 facing=1
  0.19  [Playtest] finished armfrad team 0 at 0.19 min
  0.20  [Playtest] finished armason team 0 at 0.20 min
  0.40  [Playtest] camera requested (3400,4450) height=2400
  0.40  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.40  [Playtest] screenshot at 0.4 min of team 0 at (3400, 4450)
  0.70  [Playtest] camera requested (3400,4450) height=2400
  0.71  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.71  [Playtest] screenshot at 0.7 min of team 0 at (3400, 4450)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  3.00  [Playtest] camera requested (3400,4450) height=3200
  3.00  [Playtest] camera captured name=ta position=(3400,4450) height=3200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (3400, 4450)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  7.00  [Playtest] camera requested (3400,4450) height=4000
  7.00  [Playtest] camera captured name=ta position=(3400,4450) height=4000
  7.00  [Playtest] screenshot at 7.0 min of team 0 at (3400, 4450)
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
```

## Native lines (all AIs, first 120)

```
  0.10  RESERVE: zone 1 at (2304, 4400) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (2304, 4400) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (2592, 4400) facing 1, 30x12 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (2088, 4472) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2088, 4472) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (2088, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2088, 4408) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (2088, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2088, 4344) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (2152, 4472) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2152, 4472) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (2152, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2152, 4408) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (2152, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (2152, 4344) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (2112, 4400) facing 1, 8x12 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (4704, 4400) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (4704, 4400) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (4992, 4400) facing 1, 30x12 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (4488, 4472) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4488, 4472) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (4488, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4488, 4408) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (4488, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4488, 4344) facing 1 (id 4)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 at (4568, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4568, 4504) facing 1 (id 5)
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (4552, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4552, 4536) facing 1 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (4520, 4552) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4520, 4552) facing 1 (id 7)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 at (4488, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4488, 4568) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (4488, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4488, 4504) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (4488, 4440) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4488, 4440) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (4552, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4552, 4568) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (4552, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4552, 4504) facing 1 (id 12)
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 at (4440, 4552) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4440, 4552) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (4440, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4440, 4488) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (4440, 4424) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4440, 4424) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (4504, 4552) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4504, 4552) facing 1 (id 16)
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 at (4408, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4408, 4536) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (4408, 4472) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4408, 4472) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (4408, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4408, 4408) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (4472, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4472, 4536) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (4472, 4472) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4472, 4472) facing 1 (id 21)
  0.10  RESERVE: zone 23 at (4472, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4472, 4408) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (4444, 4468) facing 1, 9x13 cells: 63 of 117 held
  0.12  RESERVE: zone 10 at (2304, 4000) facing 1, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (2304, 4000) facing 1 (id 8)
  0.12  RESERVE: corridor 11 at (2640, 4000) facing 1, 30x18 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (2184, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2184, 4072) facing 1 (id 9)
  0.12  RESERVE: zone 13 at (2184, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2184, 4008) facing 1 (id 10)
  0.12  RESERVE: zone 14 at (2184, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2184, 3944) facing 1 (id 11)
  0.12  RESERVE: zone 12 released
  0.12  RESERVE: zone 13 released
  0.12  RESERVE: zone 14 released
  0.12  RESERVE: zone 15 at (2168, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2168, 4104) facing 1 (id 12)
  0.12  RESERVE: zone 16 at (2168, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2168, 4040) facing 1 (id 13)
  0.12  RESERVE: zone 17 at (2168, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2168, 3976) facing 1 (id 14)
  0.12  RESERVE: zone 15 released
  0.12  RESERVE: zone 16 released
  0.12  RESERVE: zone 17 released
  0.12  RESERVE: zone 18 at (2152, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 4136) facing 1 (id 15)
  0.12  RESERVE: zone 19 at (2152, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 4072) facing 1 (id 16)
  0.12  RESERVE: zone 20 at (2152, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2152, 4008) facing 1 (id 17)
  0.12  RESERVE: zone 21 at (2216, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2216, 4136) facing 1 (id 18)
  0.12  RESERVE: zone 18 released
  0.12  RESERVE: zone 19 released
  0.12  RESERVE: zone 20 released
  0.12  RESERVE: zone 21 released
  0.12  RESERVE: zone 22 at (2120, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2120, 4152) facing 1 (id 19)
  0.12  RESERVE: zone 23 at (2120, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2120, 4088) facing 1 (id 20)
  0.12  RESERVE: zone 24 at (2120, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2120, 4024) facing 1 (id 21)
  0.12  RESERVE: zone 25 at (2184, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2184, 4152) facing 1 (id 22)
  0.12  RESERVE: zone 26 at (2184, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (2184, 4088) facing 1 (id 23)
```
