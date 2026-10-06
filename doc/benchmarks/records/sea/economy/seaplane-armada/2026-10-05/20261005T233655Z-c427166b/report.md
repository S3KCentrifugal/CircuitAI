# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 10.1 min (frame 18210); wall 107 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (15958e3e8775d55b); AI BARbTest/test; staged 2026-10-05T20:35:00
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: seaplane-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T233459Z-a43d4bd7\runs\20261005T233655Z-c427166b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `mex` | seen at 1.2 min | `[t=00:00:49.296563][f=0002094] [SeaTransition] PASS mex completed after first construction ship` |
| expect `platform` | **missing** (by 10 min) | |
| expect `aircraft` | **missing** (by 10 min) | |
| expect `footprint` | **missing** (by 10 min) | |
| expect `support` | **missing** (by 10 min) | |
| forbid `errors` | clean |  |

## Failures

- 'platform' not seen by 10.0 min
- 'aircraft' not seen by 10.0 min
- 'footprint' not seen by 10.0 min
- 'support' not seen by 10.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T233459Z-a43d4bd7\runs\20261005T233655Z-c427166b\screen_2026-10-05_23-35-57-522.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T233459Z-a43d4bd7\runs\20261005T233655Z-c427166b\screen_2026-10-05_23-36-10-793.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T233459Z-a43d4bd7\runs\20261005T233655Z-c427166b\screen_2026-10-05_23-36-41-784.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 10.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 40
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 40
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 18099 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4765|11076|0|7|1|4608|11072
  0.25  [SEA][Layout] berth sea.berth.0 armasy at=6096,10080 facing=2
  0.32  [SEA][Layout] berth sea.berth.1 armplat at=5904,9968 facing=2
  0.48  [Playtest] finished armmex team 0 at 0.48 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 99653/100200, energy +1244.0 bank 1002675/1002700, units 9
  1.00  [Playtest] camera requested (6200,11000) height=3200
  1.01  [Playtest] camera captured name=ta position=(6200,11000) height=3200
  1.01  [Playtest] screenshot at 1.0 min of team 0 at (6200, 11000)
  1.16  [Playtest] finished armmex team 0 at 1.16 min
  1.61  [Playtest] finished armmex team 0 at 1.61 min
  1.72  [Playtest] finished armnanotcplat team 0 at 1.72 min
  1.78  [SEA][Layout] berth sea.berth.2 armsy at=6288,10080 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +11.2 bank 98159/100300, energy +1244.0 bank 1002657/1002700, units 17
  2.00  [Playtest] finished armasy team 0 at 2.00 min
  2.10  [Playtest] finished armnanotcplat team 0 at 2.10 min
  2.21  [Playtest] finished armmex team 0 at 2.20 min
  2.71  [Playtest] finished armmex team 0 at 2.71 min
  2.94  [Playtest] finished armfrad team 0 at 2.94 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +15.8 bank 95439/100600, energy +1274.0 bank 1003012/1003050, units 26
  3.00  [Playtest] camera requested (6200,11000) height=3800
  3.00  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.51  [Playtest] finished armmex team 0 at 3.51 min
  3.63  [Playtest] finished armnanotcplat team 0 at 3.63 min
  3.80  [Playtest] finished armnanotcplat team 0 at 3.80 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +18.1 bank 91805/100650, energy +1304.0 bank 1002993/1003200, units 39
  4.06  [Playtest] finished armuwmme team 0 at 4.06 min
  4.07  [Playtest] finished armmex team 0 at 4.07 min
  4.81  [Playtest] finished armuwmmm team 0 at 4.81 min
  4.97  [Playtest] finished armuwmme team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +91.1 bank 88107/101800, energy +1604.0 bank 1002454/1004700, units 46
  5.02  [Playtest] finished armmex team 0 at 5.02 min
  5.28  [Playtest] finished armmex team 0 at 5.28 min
  5.58  [Playtest] finished armnanotcplat team 0 at 5.58 min
  5.59  [Playtest] finished armmex team 0 at 5.59 min
  5.89  [Playtest] finished armnanotcplat team 0 at 5.89 min
  5.92  [Playtest] finished armuwmme team 0 at 5.92 min
  5.99  [Playtest] finished armmex team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +57.5 bank 85148/102550, energy +1604.0 bank 978040/1004700, units 59
  6.07  [Playtest] finished armnanotcplat team 0 at 6.07 min
  6.12  [Playtest] finished armuwmmm team 0 at 6.12 min
  6.24  [Playtest] finished armnanotcplat team 0 at 6.24 min
  6.38  [Playtest] finished armnanotcplat team 0 at 6.39 min
  6.40  [Playtest] finished armmex team 0 at 6.40 min
  6.53  [Playtest] finished armnanotcplat team 0 at 6.53 min
  6.71  [Playtest] finished armmex team 0 at 6.71 min
  6.83  [Playtest] finished armuwmme team 0 at 6.83 min
  6.97  [Playtest] finished armmex team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +83.6 bank 82191/103250, energy +1604.0 bank 905189/1004700, units 77
  7.15  [Playtest] finished armllt team 0 at 7.15 min
  7.25  [Playtest] finished armrad team 0 at 7.25 min
  7.69  [Playtest] finished armason team 0 at 7.69 min
  7.70  [Playtest] finished armmex team 0 at 7.70 min
  7.88  [Playtest] finished armllt team 0 at 7.88 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +87.0 bank 79597/103300, energy +1604.0 bank 822707/1004700, units 91
  8.00  [Playtest] camera requested (6200,11000) height=4000
  8.01  [Playtest] camera captured name=ta position=(6200,11000) height=4000
  8.01  [Playtest] screenshot at 8.0 min of team 0 at (6200, 11000)
  8.50  [Playtest] finished armllt team 0 at 8.50 min
  8.67  [Playtest] finished armrad team 0 at 8.67 min
  8.92  [Playtest] finished armnanotcplat team 0 at 8.92 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +67.1 bank 76893/103300, energy +1604.0 bank 749174/1004700, units 106
  9.03  [Playtest] finished armuwmmm team 0 at 9.03 min
  9.04  [Playtest] finished armnanotcplat team 0 at 9.04 min
  9.13  [Playtest] finished armllt team 0 at 9.13 min
  9.43  [Playtest] finished armllt team 0 at 9.43 min
  9.64  [Playtest] finished armrad team 0 at 9.64 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +66.3 bank 71837/103300, energy +1604.0 bank 731826/1004700, units 121
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (5736, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10584) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (5688, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10584) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (5640, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10584) facing 2 (id 3)
  0.18  RESERVE: zone 1 released
  0.18  RESERVE: zone 2 released
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 at (5736, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10504) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (5688, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10504) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (5640, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10504) facing 2 (id 6)
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 at (5784, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10456) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (5736, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10456) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (5688, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10456) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (5640, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10456) facing 2 (id 10)
  0.18  RESERVE: zone 7 released
  0.18  RESERVE: zone 8 released
  0.18  RESERVE: zone 9 released
  0.18  RESERVE: zone 10 released
  0.18  RESERVE: corridor 11 at (5824, 11024) facing 0, 12x30 cells: 228 of 360 held
  0.18  RESERVE: zone 12 at (5952, 11520) facing 2, 40x40 cells: 1552 of 1600 held
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: zone 13 at (6080, 11520) facing 2, 40x40 cells: 1560 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6080, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 13 released
  0.18  RESERVE: zone 14 at (6208, 11520) facing 2, 40x40 cells: 1592 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6208, 11424) facing 2: 8 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 14 released
  0.20  RESERVE: zone 15 at (5848, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5848, 10408) facing 2 (id 21)
  0.20  RESERVE: zone 16 at (5800, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5800, 10408) facing 2 (id 22)
  0.20  RESERVE: zone 17 at (5752, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5752, 10408) facing 2 (id 23)
  0.20  RESERVE: zone 18 at (5704, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5704, 10408) facing 2 (id 24)
  0.20  RESERVE: zone 19 at (5656, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5656, 10408) facing 2 (id 25)
  0.20  RESERVE: zone 20 at (5848, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5848, 10360) facing 2 (id 26)
  0.20  RESERVE: zone 21 at (5800, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5800, 10360) facing 2 (id 27)
  0.20  RESERVE: zone 22 at (5752, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5752, 10360) facing 2 (id 28)
  0.20  RESERVE: zone 23 at (5704, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5704, 10360) facing 2 (id 29)
  0.20  RESERVE: zone 15 released
  0.20  RESERVE: zone 16 released
  0.20  RESERVE: zone 17 released
  0.20  RESERVE: zone 18 released
  0.20  RESERVE: zone 19 released
  0.20  RESERVE: zone 20 released
  0.20  RESERVE: zone 21 released
  0.20  RESERVE: zone 22 released
  0.20  RESERVE: zone 23 released
  0.20  RESERVE: zone 24 at (5928, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5928, 10392) facing 2 (id 30)
  0.20  RESERVE: zone 25 at (5880, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5880, 10392) facing 2 (id 31)
  0.20  RESERVE: zone 26 at (5832, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5832, 10392) facing 2 (id 32)
  0.20  RESERVE: zone 27 at (5784, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5784, 10392) facing 2 (id 33)
  0.20  RESERVE: zone 28 at (5736, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5736, 10392) facing 2 (id 34)
  0.20  RESERVE: zone 24 released
  0.20  RESERVE: zone 25 released
  0.20  RESERVE: zone 26 released
  0.20  RESERVE: zone 27 released
  0.20  RESERVE: zone 28 released
  0.20  RESERVE: zone 29 at (5992, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5992, 10408) facing 2 (id 35)
  0.20  RESERVE: zone 30 at (5944, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5944, 10408) facing 2 (id 36)
  0.20  RESERVE: zone 31 at (5896, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5896, 10408) facing 2 (id 37)
  0.20  RESERVE: zone 32 at (5848, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5848, 10408) facing 2 (id 38)
  0.20  RESERVE: zone 33 at (5800, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5800, 10408) facing 2 (id 39)
  0.20  RESERVE: zone 29 released
  0.20  RESERVE: zone 30 released
  0.20  RESERVE: zone 31 released
  0.20  RESERVE: zone 32 released
  0.20  RESERVE: zone 33 released
  0.20  RESERVE: zone 34 at (6056, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6056, 10456) facing 2 (id 40)
  0.20  RESERVE: zone 35 at (6008, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6008, 10456) facing 2 (id 41)
  0.20  RESERVE: zone 36 at (5960, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5960, 10456) facing 2 (id 42)
  0.20  RESERVE: zone 37 at (5912, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5912, 10456) facing 2 (id 43)
  0.20  RESERVE: zone 38 at (5864, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5864, 10456) facing 2 (id 44)
  0.20  RESERVE: zone 34 released
  0.20  RESERVE: zone 35 released
  0.20  RESERVE: zone 36 released
  0.20  RESERVE: zone 37 released
  0.20  RESERVE: zone 38 released
  0.20  RESERVE: zone 39 at (6104, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6104, 10504) facing 2 (id 45)
  0.20  RESERVE: zone 40 at (6056, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6056, 10504) facing 2 (id 46)
  0.20  RESERVE: zone 41 at (6008, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6008, 10504) facing 2 (id 47)
  0.20  RESERVE: zone 42 at (5960, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5960, 10504) facing 2 (id 48)
  0.20  RESERVE: zone 43 at (5912, 10504) facing 2, 3x3 cells: 9 of 9 held
```
