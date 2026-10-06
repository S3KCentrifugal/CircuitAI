# Playtest report: PASS

- Verdict: **PASS** (reached 10 min)
- Game time reached: 10.1 min (frame 18229); wall 106 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (aff90f713fc9746a); AI BARbTest/test; staged 2026-10-05T20:50:35
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: seaplane-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-legion\supreme\20261005T235034Z-2c733f66\runs\20261005T235230Z-e9622520\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `mex` | seen at 1.1 min | `[t=00:00:48.145473][f=0001972] [SeaTransition] PASS mex completed by first construction ship` |
| expect `platform` | seen at 2.7 min | `[t=00:00:57.656880][f=0004825] [SeaTransition] PASS platform completed legsplab` |
| expect `aircraft` | seen at 3.1 min | `[t=00:01:01.232764][f=0005603] [SeaTransition] PASS aircraft produced legspbomber` |
| expect `footprint` | seen at 0.5 min | `[SeaTransition] footprint slots=27 platform=legsplab` |
| expect `support` | seen at 3.1 min | `[t=00:01:01.058586][f=0005550] [SeaTransition] PASS platform assistance turrets=3 assisting=3` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-legion\supreme\20261005T235034Z-2c733f66\runs\20261005T235230Z-e9622520\screen_2026-10-05_23-51-31-619.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-legion\supreme\20261005T235034Z-2c733f66\runs\20261005T235230Z-e9622520\screen_2026-10-05_23-51-44-904.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-legion\supreme\20261005T235034Z-2c733f66\runs\20261005T235230Z-e9622520\screen_2026-10-05_23-52-15-892.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 10.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 29
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 29
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished legsy team 0 at 0.17 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.20  [Playtest] finished legmex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 6297 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|4764|11076|0|7|1|4608|11072
  0.27  [SEA][Layout] berth sea.berth.0 legadvshipyard at=6208,9968 facing=2
  0.35  [SEA][Layout] berth sea.berth.1 legsplab at=5824,10368 facing=2
  0.48  [Playtest] finished legmex team 0 at 0.48 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 99663/100200, energy +1260.0 bank 1002678/1002700, units 11
  1.00  [Playtest] camera requested (6200,11000) height=3200
  1.01  [Playtest] camera captured name=ta position=(6200,11000) height=3200
  1.01  [Playtest] screenshot at 1.0 min of team 0 at (6200, 11000)
  1.10  [Playtest] finished legmex team 0 at 1.10 min
  1.56  [Playtest] finished legmex team 0 at 1.56 min
  1.78  [Playtest] finished legnanotcplat team 0 at 1.78 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +11.2 bank 98184/100300, energy +1260.0 bank 1002579/1002700, units 18
  2.00  [Playtest] finished legadvshipyard team 0 at 2.00 min
  2.09  [Playtest] finished legnanotcplat team 0 at 2.09 min
  2.18  [Playtest] finished legmex team 0 at 2.18 min
  2.68  [Playtest] finished legsplab team 0 at 2.68 min
  2.72  [Playtest] finished legmex team 0 at 2.72 min
  2.98  [Playtest] finished legnanotcplat team 0 at 2.98 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +15.8 bank 94306/100600, energy +1290.0 bank 1003023/1003250, units 33
  3.00  [Playtest] camera requested (6200,11000) height=3800
  3.00  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.22  [Playtest] finished legnanotcplat team 0 at 3.22 min
  3.36  [Playtest] finished legnanotcplat team 0 at 3.36 min
  3.50  [Playtest] finished legmex team 0 at 3.50 min
  3.58  [Playtest] finished legnanotcplat team 0 at 3.58 min
  3.69  [Playtest] finished legnanotcplat team 0 at 3.69 min
  3.80  [Playtest] finished legnanotcplat team 0 at 3.80 min
  3.89  [Playtest] finished legnanotcplat team 0 at 3.89 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +18.1 bank 88807/100650, energy +1320.0 bank 985794/1003400, units 57
  4.01  [Playtest] finished legnanotcplat team 0 at 4.01 min
  4.06  [Playtest] finished legmex team 0 at 4.06 min
  4.13  [Playtest] finished legnanotcplat team 0 at 4.13 min
  4.17  [Playtest] finished leganavalmex team 0 at 4.17 min
  4.26  [Playtest] finished legnanotcplat team 0 at 4.26 min
  4.39  [Playtest] finished legnanotcplat team 0 at 4.39 min
  4.46  [Playtest] finished legnanotcplat team 0 at 4.46 min
  4.58  [Playtest] finished legnanotcplat team 0 at 4.58 min
  4.78  [Playtest] finished legnanotcplat team 0 at 4.78 min
  4.86  [Playtest] finished legnanotcplat team 0 at 4.86 min
  4.94  [Playtest] finished leganavalmex team 0 at 4.94 min
  4.94  [Playtest] finished legnanotcplat team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +34.2 bank 79632/101800, energy +1620.0 bank 923225/1004900, units 95
  5.00  [Playtest] finished legmex team 0 at 5.00 min
  5.05  [Playtest] finished legnanotcplat team 0 at 5.05 min
  5.13  [Playtest] finished legnanotcplat team 0 at 5.13 min
  5.28  [Playtest] finished legmex team 0 at 5.28 min
  5.58  [Playtest] finished legmex team 0 at 5.58 min
  5.69  [Playtest] finished leganavalmex team 0 at 5.69 min
  5.96  [Playtest] finished legmex team 0 at 5.96 min
  5.99  [Playtest] finished legtl team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +49.5 bank 70613/102550, energy +1620.0 bank 836569/1004900, units 133
  6.05  [Playtest] finished leganavalsonarstation team 0 at 6.05 min
  6.30  [Playtest] finished legfrad team 0 at 6.30 min
  6.35  [Playtest] finished legmex team 0 at 6.35 min
  6.52  [Playtest] finished legfeconv team 0 at 6.52 min
  6.65  [Playtest] finished legmex team 0 at 6.65 min
  6.73  [Playtest] finished leganavalmex team 0 at 6.73 min
  6.92  [Playtest] finished legmex team 0 at 6.92 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +63.3 bank 60750/103250, energy +1620.0 bank 728795/1004900, units 183
  7.09  [Playtest] finished leglht team 0 at 7.09 min
  7.10  [Playtest] finished legfrad team 0 at 7.10 min
  7.18  [Playtest] finished legrad team 0 at 7.18 min
  7.29  [Playtest] finished legtl team 0 at 7.29 min
  7.63  [Playtest] finished legmex team 0 at 7.63 min
  7.67  [Playtest] finished legtl team 0 at 7.67 min
  7.79  [Playtest] finished leglht team 0 at 7.79 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +65.6 bank 51879/103300, energy +1620.0 bank 613966/1004900, units 233
  8.00  [Playtest] camera requested (6200,11000) height=4000
  8.01  [Playtest] camera captured name=ta position=(6200,11000) height=4000
  8.01  [Playtest] screenshot at 8.0 min of team 0 at (6200, 11000)
  8.03  [Playtest] finished legtl team 0 at 8.03 min
  8.38  [Playtest] finished leglht team 0 at 8.38 min
  8.59  [Playtest] finished legrad team 0 at 8.59 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +65.6 bank 41583/103300, energy +1620.0 bank 492201/1004900, units 288
  9.06  [Playtest] finished leglht team 0 at 9.06 min
  9.36  [Playtest] finished leglht team 0 at 9.36 min
  9.56  [Playtest] finished legrad team 0 at 9.56 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +65.6 bank 32652/103300, energy +1620.0 bank 378615/1004900, units 336
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (5736, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10584) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (5688, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5688, 10584) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (5640, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10584) facing 2 (id 3)
  0.18  RESERVE: zone 1 released
  0.18  RESERVE: zone 2 released
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 at (5736, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10504) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (5688, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5688, 10504) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (5640, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10504) facing 2 (id 6)
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 at (5784, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5784, 10456) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (5736, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10456) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (5688, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5688, 10456) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (5640, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10456) facing 2 (id 10)
  0.18  RESERVE: zone 7 released
  0.18  RESERVE: zone 8 released
  0.18  RESERVE: zone 9 released
  0.18  RESERVE: zone 10 released
  0.18  RESERVE: corridor 11 at (5824, 11024) facing 0, 12x30 cells: 228 of 360 held
  0.18  RESERVE: zone 12 at (5952, 11520) facing 2, 40x40 cells: 1552 of 1600 held
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: zone 13 at (6080, 11520) facing 2, 40x40 cells: 1560 of 1600 held
  0.18  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (6080, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 13 released
  0.18  RESERVE: zone 14 at (6208, 11520) facing 2, 40x40 cells: 1592 of 1600 held
  0.18  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (6208, 11424) facing 2: 8 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 14 released
  0.20  RESERVE: zone 15 at (5848, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (5848, 10408) facing 2 (id 21)
  0.20  RESERVE: zone 16 at (5800, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (5800, 10408) facing 2 (id 22)
  0.20  RESERVE: zone 17 at (5752, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (5752, 10408) facing 2 (id 23)
  0.20  RESERVE: zone 18 at (5704, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (5704, 10408) facing 2 (id 24)
  0.20  RESERVE: zone 19 at (5656, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (5656, 10408) facing 2 (id 25)
  0.20  RESERVE: zone 20 at (5848, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (5848, 10360) facing 2 (id 26)
  0.20  RESERVE: zone 21 at (5800, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (5800, 10360) facing 2 (id 27)
  0.20  RESERVE: zone 22 at (5752, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (5752, 10360) facing 2 (id 28)
  0.20  RESERVE: zone 23 at (5704, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (5704, 10360) facing 2 (id 29)
  0.20  RESERVE: zone 15 released
  0.20  RESERVE: zone 16 released
  0.20  RESERVE: zone 17 released
  0.20  RESERVE: zone 18 released
  0.20  RESERVE: zone 19 released
  0.20  RESERVE: zone 20 released
  0.20  RESERVE: zone 21 released
  0.20  RESERVE: zone 22 released
  0.20  RESERVE: zone 23 released
  0.20  RESERVE: zone 24 at (6056, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (6056, 10456) facing 2 (id 30)
  0.20  RESERVE: zone 24 released
  0.20  RESERVE: zone 25 at (6104, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (6104, 10504) facing 2 (id 31)
  0.20  RESERVE: zone 26 at (6056, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (6056, 10504) facing 2 (id 32)
  0.20  RESERVE: zone 25 released
  0.20  RESERVE: zone 26 released
  0.20  RESERVE: zone 27 at (6184, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (6184, 10696) facing 2 (id 33)
  0.20  RESERVE: zone 28 at (6136, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (6136, 10696) facing 2 (id 34)
  0.20  RESERVE: zone 29 at (6088, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (6088, 10696) facing 2 (id 35)
  0.20  RESERVE: zone 30 at (6040, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (6040, 10696) facing 2 (id 36)
  0.20  RESERVE: zone 27 released
  0.20  RESERVE: zone 28 released
  0.20  RESERVE: zone 29 released
  0.20  RESERVE: zone 30 released
  0.20  RESERVE: zone 31 at (6120, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (6120, 10792) facing 2 (id 37)
  0.20  RESERVE: zone 32 at (6072, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: legnanotcplat at (6072, 10792) facing 2 (id 38)
  0.20  RESERVE: zone 31 released
  0.20  RESERVE: zone 32 released
  0.20  RESERVE: zone 33 at (6336, 11520) facing 2, 40x40 cells: 1468 of 1600 held
  0.20  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (6336, 11424) facing 2: 8 of 16 slots (group 4, held, zone)
  0.20  RESERVE: zone 33 released
  0.20  RESERVE: zone 34 at (6464, 11520) facing 2, 40x40 cells: 1468 of 1600 held
  0.20  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (6464, 11424) facing 2: 10 of 16 slots (group 5, held, zone)
  0.20  RESERVE: zone 34 released
  0.20  RESERVE: zone 35 at (6592, 11520) facing 2, 40x40 cells: 1468 of 1600 held
  0.20  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (6592, 11424) facing 2: 16 of 16 slots (group 6, held, zone)
  0.20  RESERVE: leganavalfusion at (6656, 11656) facing 2 (id 73)
  0.20  RESERVE: packed leganavalfusion at (6656, 11656) facing 2 in zone 35, 320 from a turret (id 73, group 0, 818 candidates)
  0.22  RESERVE: zone 36 at (5656, 10696) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (5656, 10696) facing 2 (id 74)
  0.22  RESERVE: zone 36 released
  0.22  RESERVE: zone 37 at (5640, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (5640, 10584) facing 2 (id 75)
  0.22  RESERVE: zone 37 released
  0.22  RESERVE: zone 38 at (5656, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (5656, 10472) facing 2 (id 76)
  0.22  RESERVE: zone 38 released
  0.22  RESERVE: zone 39 at (5720, 10376) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (5720, 10376) facing 2 (id 77)
  0.22  RESERVE: zone 40 at (5672, 10376) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (5672, 10376) facing 2 (id 78)
  0.22  RESERVE: zone 39 released
  0.22  RESERVE: zone 40 released
  0.25  RESERVE: zone 41 at (5848, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.25  RESERVE: legnanotcplat at (5848, 10648) facing 2 (id 79)
```
