# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.1 min (frame 10980); wall 72 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:27:39
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-sub-production.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-sub-legion-cand\glacial\20261005T042739Z-4ac8d7ad\runs\20261005T042854Z-59b770be\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.735824][f=-000001] [SeaArena] frame=0 loaded case=response-sub-legion control=false` |
| expect `response` | seen at 0.4 min | `[SEA][Response] layer=1 deficit=600 observedSub=500 subCover=0 recruit=legnavyfrigate` |
| expect `counter-started` | seen at 0.4 min | `[t=00:00:37.828469][f=0000670] [SeaArena] frame=670 produced id=4690 team=0 unit=legnavyfrigate` |
| expect `new-counter-fired` | seen at 1.3 min | `[t=00:00:44.567445][f=0002292] [SeaArena] frame=2292 damage victim=21302 attacker=4690 team=0 amount=140.2 attackerUnit=legnavyfrigate victimUnit=corsub produced=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-sub-legion-cand\glacial\20261005T042739Z-4ac8d7ad\runs\20261005T042854Z-59b770be\screen_2026-10-05_04-28-21-865.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-sub-legion-cand\glacial\20261005T042739Z-4ac8d7ad\runs\20261005T042854Z-59b770be\screen_2026-10-05_04-28-24-348.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-sub-legion-cand\glacial\20261005T042739Z-4ac8d7ad\runs\20261005T042854Z-59b770be\screen_2026-10-05_04-28-37-103.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 4 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (2300, 4400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2300, 4400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished legsy team 0 at 0.17 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [SEA][Layout] berth sea.berth.0 legadvshipyard at=3312,4400 facing=1
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.19  [Playtest] finished leganavaleconv team 0 at 0.19 min
  0.19  [Playtest] finished leganavaleconv team 0 at 0.19 min
  0.19  [Playtest] finished leganavaleconv team 0 at 0.19 min
  0.19  [Playtest] finished leganavaleconv team 0 at 0.19 min
  0.19  [Playtest] finished leganavaleconv team 0 at 0.19 min
  0.20  [Playtest] finished leganavaleconv team 0 at 0.19 min
  0.20  [Playtest] finished leguwmstore team 0 at 0.20 min
  0.20  [Playtest] finished leguwmstore team 0 at 0.20 min
  0.20  [SEA][Layout] berth sea.berth.1 legadvshipyard at=3216,4000 facing=1
  0.20  [Playtest] finished leguwmstore team 0 at 0.20 min
  0.20  [Playtest] finished leguwmstore team 0 at 0.20 min
  0.20  [Playtest] finished legfrad team 0 at 0.20 min
  0.21  [Playtest] finished leganavalsonarstation team 0 at 0.21 min
  0.40  [Playtest] camera requested (3400,4450) height=2400
  0.40  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.40  [Playtest] screenshot at 0.4 min of team 0 at (3400, 4450)
  0.70  [Playtest] camera requested (3400,4450) height=2400
  0.70  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.70  [Playtest] screenshot at 0.7 min of team 0 at (3400, 4450)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +84.8 bank 4664/13100, energy +4920.0 bank 1006372/1010200, units 30
  2.00  [Playtest] eco team 0 at 2.0 min: metal +84.8 bank 9102/13100, energy +4915.0 bank 1007644/1010150, units 27
  3.00  [Playtest] eco team 0 at 3.0 min: metal +84.8 bank 13096/13100, energy +4915.0 bank 1007699/1010150, units 21
  3.00  [Playtest] camera requested (3400,4450) height=3200
  3.01  [Playtest] camera captured name=ta position=(3400,4450) height=3200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (3400, 4450)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +84.8 bank 13097/13100, energy +4915.0 bank 1007712/1010150, units 23
  5.00  [Playtest] eco team 0 at 5.0 min: metal +84.8 bank 13000/13000, energy +4920.0 bank 1007702/1010100, units 20
  6.00  [Playtest] eco team 0 at 6.0 min: metal +84.8 bank 13000/13000, energy +4920.0 bank 1007702/1010100, units 20
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (3312, 4400) facing 1, 12x12 cells: 144 of 144 held
  0.18  RESERVE: legadvshipyard at (3312, 4400) facing 1 (id 1)
  0.18  RESERVE: corridor 2 at (3648, 4400) facing 1, 30x18 cells: 540 of 540 held
  0.18  RESERVE: zone 3 at (3096, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (3096, 4680) facing 1 (id 2)
  0.18  RESERVE: zone 4 at (3096, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (3096, 4632) facing 1 (id 3)
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 at (2312, 4456) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (2312, 4456) facing 1 (id 4)
  0.18  RESERVE: zone 6 at (2312, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (2312, 4408) facing 1 (id 5)
  0.18  RESERVE: zone 7 at (2312, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (2312, 4360) facing 1 (id 6)
  0.18  RESERVE: zone 8 at (2312, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (2312, 4312) facing 1 (id 7)
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 released
  0.18  RESERVE: zone 8 released
  0.18  RESERVE: zone 9 at (2248, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (2248, 4408) facing 1 (id 8)
  0.18  RESERVE: zone 10 at (2248, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (2248, 4360) facing 1 (id 9)
  0.18  RESERVE: zone 11 at (2248, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (2248, 4312) facing 1 (id 10)
  0.18  RESERVE: zone 9 released
  0.18  RESERVE: zone 10 released
  0.18  RESERVE: zone 11 released
  0.18  RESERVE: zone 12 at (2200, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (2200, 4344) facing 1 (id 11)
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: corridor 13 at (2450, 4688) facing 0, 13x30 cells: 297 of 390 held
  0.18  RESERVE: zone 14 at (2528, 4400) facing 1, 40x40 cells: 1028 of 1600 held
  0.18  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (2624, 4400) facing 1: 3 of 16 slots (group 1, held, zone)
  0.18  RESERVE: zone 14 released
  0.18  RESERVE: zone 15 at (2528, 4272) facing 1, 40x40 cells: 1150 of 1600 held
  0.18  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (2624, 4272) facing 1: 10 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 15 released
  0.18  RESERVE: zone 16 at (2528, 4528) facing 1, 40x40 cells: 978 of 1600 held
  0.18  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (2624, 4528) facing 1: 1 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 16 released
  0.18  RESERVE: zone 17 at (2528, 4144) facing 1, 40x40 cells: 1380 of 1600 held
  0.18  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (2624, 4144) facing 1: 16 of 16 slots (group 4, held, zone)
  0.18  RESERVE: leganavalfusion at (2392, 4128) facing 1 (id 42)
  0.18  RESERVE: packed leganavalfusion at (2392, 4128) facing 1 in zone 17, 320 from a turret (id 42, group 0, 710 candidates)
  0.20  RESERVE: zone 18 at (3216, 4000) facing 1, 12x12 cells: 144 of 144 held
  0.20  RESERVE: legadvshipyard at (3216, 4000) facing 1 (id 43)
  0.20  RESERVE: corridor 19 at (3552, 4000) facing 1, 30x18 cells: 450 of 540 held
  0.20  RESERVE: zone 20 at (2936, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (2936, 4312) facing 1 (id 44)
  0.20  RESERVE: zone 21 at (2936, 4264) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (2936, 4264) facing 1 (id 45)
  0.20  RESERVE: zone 20 released
  0.20  RESERVE: zone 21 released
  0.20  RESERVE: zone 22 at (3016, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3016, 4312) facing 1 (id 46)
  0.20  RESERVE: zone 23 at (3016, 4264) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3016, 4264) facing 1 (id 47)
  0.20  RESERVE: zone 24 at (3016, 4216) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3016, 4216) facing 1 (id 48)
  0.20  RESERVE: zone 25 at (3016, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3016, 4168) facing 1 (id 49)
  0.20  RESERVE: zone 22 released
  0.20  RESERVE: zone 23 released
  0.20  RESERVE: zone 24 released
  0.20  RESERVE: zone 25 released
  0.20  RESERVE: zone 26 at (3288, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3288, 4600) facing 1 (id 50)
  0.20  RESERVE: zone 27 at (3288, 4552) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3288, 4552) facing 1 (id 51)
  0.20  RESERVE: zone 26 released
  0.20  RESERVE: zone 27 released
  0.20  RESERVE: zone 28 at (3224, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3224, 4696) facing 1 (id 52)
  0.20  RESERVE: zone 29 at (3224, 4648) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3224, 4648) facing 1 (id 53)
  0.20  RESERVE: zone 30 at (3224, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3224, 4600) facing 1 (id 54)
  0.20  RESERVE: zone 31 at (3224, 4552) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (3224, 4552) facing 1 (id 55)
  0.20  RESERVE: zone 28 released
  0.20  RESERVE: zone 29 released
  0.20  RESERVE: zone 30 released
  0.20  RESERVE: zone 31 released
  0.22  RESERVE: zone 32 at (2264, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2264, 4536) facing 1 (id 56)
  0.22  RESERVE: zone 33 at (2264, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2264, 4488) facing 1 (id 57)
  0.22  RESERVE: zone 32 released
  0.22  RESERVE: zone 33 released
  0.22  RESERVE: zone 34 at (2168, 4472) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2168, 4472) facing 1 (id 58)
  0.22  RESERVE: zone 35 at (2168, 4424) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2168, 4424) facing 1 (id 59)
  0.22  RESERVE: zone 36 at (2168, 4376) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2168, 4376) facing 1 (id 60)
  0.22  RESERVE: zone 37 at (2168, 4328) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2168, 4328) facing 1 (id 61)
  0.22  RESERVE: zone 34 released
  0.22  RESERVE: zone 35 released
  0.22  RESERVE: zone 36 released
  0.22  RESERVE: zone 37 released
  0.22  RESERVE: zone 38 at (2104, 4376) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2104, 4376) facing 1 (id 62)
  0.22  RESERVE: zone 39 at (2104, 4328) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2104, 4328) facing 1 (id 63)
  0.22  RESERVE: zone 38 released
  0.22  RESERVE: zone 39 released
  0.23  RESERVE: zone 40 at (3016, 4216) facing 1, 3x3 cells: 9 of 9 held
  0.23  RESERVE: legnanotcplat at (3016, 4216) facing 1 (id 64)
  0.23  RESERVE: zone 41 at (3016, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.23  RESERVE: legnanotcplat at (3016, 4168) facing 1 (id 65)
  0.23  RESERVE: zone 40 released
  0.23  RESERVE: zone 41 released
  0.27  RESERVE: zone 42 at (2920, 4456) facing 1, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legnanotcplat at (2920, 4456) facing 1 (id 66)
  0.27  RESERVE: zone 43 at (2920, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legnanotcplat at (2920, 4408) facing 1 (id 67)
```
