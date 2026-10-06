# Playtest report: PASS

- Verdict: **PASS** (reached 10 min)
- Game time reached: 10.1 min (frame 18210); wall 106 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (aff90f713fc9746a); AI BARbTest/test; staged 2026-10-05T20:45:59
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: seaplane-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T234559Z-9405ce28\runs\20261005T234754Z-d6159754\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `mex` | seen at 1.1 min | `[t=00:00:48.952577][f=0002033] [SeaTransition] PASS mex completed by first construction ship` |
| expect `platform` | seen at 3.2 min | `[t=00:01:02.207175][f=0005715] [SeaTransition] PASS platform completed armplat` |
| expect `aircraft` | seen at 3.5 min | `[t=00:01:04.085779][f=0006278] [SeaTransition] PASS aircraft produced armsehak` |
| expect `footprint` | seen at 2.5 min | `[SeaTransition] footprint slots=31 platform=armplat` |
| expect `support` | seen at 3.2 min | `[t=00:01:02.659246][f=0005850] [SeaTransition] PASS platform assistance turrets=2 assisting=2` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T234559Z-9405ce28\runs\20261005T234754Z-d6159754\screen_2026-10-05_23-46-56-483.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T234559Z-9405ce28\runs\20261005T234754Z-d6159754\screen_2026-10-05_23-47-09-756.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T234559Z-9405ce28\runs\20261005T234754Z-d6159754\screen_2026-10-05_23-47-40-740.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 10.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 26793 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4776|11079|0|7|1|4608|11072
  0.25  [SEA][Layout] berth sea.berth.0 armasy at=6096,10080 facing=2
  0.32  [SEA][Layout] berth sea.berth.1 armplat at=5904,9968 facing=2
  0.47  [Playtest] finished armmex team 0 at 0.47 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 99637/100200, energy +1244.0 bank 1002668/1002700, units 9
  1.00  [Playtest] camera requested (6200,11000) height=3200
  1.01  [Playtest] camera captured name=ta position=(6200,11000) height=3200
  1.01  [Playtest] screenshot at 1.0 min of team 0 at (6200, 11000)
  1.13  [Playtest] finished armmex team 0 at 1.13 min
  1.70  [Playtest] finished armmex team 0 at 1.70 min
  1.72  [Playtest] finished armnanotcplat team 0 at 1.72 min
  1.78  [SEA][Layout] berth sea.berth.2 armsy at=6288,10080 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +11.2 bank 98134/100300, energy +1244.0 bank 1002618/1002700, units 17
  2.00  [Playtest] finished armasy team 0 at 2.00 min
  2.09  [Playtest] finished armnanotcplat team 0 at 2.09 min
  2.19  [Playtest] finished armmex team 0 at 2.19 min
  2.40  [Playtest] finished armnanotcplat team 0 at 2.40 min
  2.43  [SEA][Layout] berth sea.berth.1 armplat at=5952,10192 facing=2
  2.95  [Playtest] finished armmex team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +15.8 bank 94330/100600, energy +1274.0 bank 1002900/1003050, units 28
  3.00  [Playtest] camera requested (6200,11000) height=3800
  3.00  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.17  [Playtest] finished armplat team 0 at 3.17 min
  3.52  [Playtest] finished armmex team 0 at 3.52 min
  3.80  [Playtest] finished armmex team 0 at 3.80 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +19.9 bank 90726/100700, energy +1304.0 bank 1003176/1003400, units 40
  4.00  [Playtest] finished armnanotcplat team 0 at 4.00 min
  4.11  [Playtest] finished armmex team 0 at 4.11 min
  4.50  [Playtest] finished armmex team 0 at 4.50 min
  4.90  [Playtest] finished armmex team 0 at 4.90 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +34.3 bank 87123/100850, energy +1604.0 bank 1004617/1004900, units 57
  5.21  [Playtest] finished armmex team 0 at 5.21 min
  5.28  [Playtest] finished armuwmmm team 0 at 5.28 min
  5.47  [Playtest] finished armmex team 0 at 5.47 min
  5.58  [Playtest] finished armuwmme team 0 at 5.58 min
  5.87  [Playtest] finished armnanotcplat team 0 at 5.87 min
  5.94  [Playtest] finished armmex team 0 at 5.94 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +50.7 bank 83777/101550, energy +1604.0 bank 984465/1004900, units 68
  6.02  [Playtest] finished armnanotcplat team 0 at 6.02 min
  6.13  [Playtest] finished armllt team 0 at 6.13 min
  6.33  [Playtest] finished armuwmme team 0 at 6.33 min
  6.45  [Playtest] finished armnanotcplat team 0 at 6.45 min
  6.51  [Playtest] finished armrad team 0 at 6.51 min
  6.72  [Playtest] finished armllt team 0 at 6.72 min
  6.76  [Playtest] finished armnanotcplat team 0 at 6.76 min
  6.90  [Playtest] finished armnanotcplat team 0 at 6.90 min
  7.00  [Playtest] finished armnanotcplat team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +58.3 bank 79783/102100, energy +1604.0 bank 939775/1004900, units 86
  7.07  [Playtest] finished armuwmme team 0 at 7.07 min
  7.08  [Playtest] finished armnanotcplat team 0 at 7.08 min
  7.16  [Playtest] finished armnanotcplat team 0 at 7.16 min
  7.20  [Playtest] finished armllt team 0 at 7.20 min
  7.22  [Playtest] finished armnanotcplat team 0 at 7.22 min
  7.58  [Playtest] finished armuwmmm team 0 at 7.58 min
  7.63  [Playtest] finished armnanotcplat team 0 at 7.63 min
  7.69  [Playtest] finished armnanotcplat team 0 at 7.69 min
  7.74  [Playtest] finished armnanotcplat team 0 at 7.74 min
  7.79  [Playtest] finished armnanotcplat team 0 at 7.79 min
  7.83  [Playtest] finished armnanotcplat team 0 at 7.84 min
  7.98  [Playtest] finished armuwmme team 0 at 7.98 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +130.1 bank 74743/103200, energy +1604.0 bank 824463/1004900, units 104
  8.00  [Playtest] camera requested (6200,11000) height=4000
  8.01  [Playtest] camera captured name=ta position=(6200,11000) height=4000
  8.01  [Playtest] screenshot at 8.0 min of team 0 at (6200, 11000)
  8.02  [Playtest] finished armnanotcplat team 0 at 8.02 min
  8.09  [Playtest] finished armnanotcplat team 0 at 8.09 min
  8.13  [Playtest] finished armuwmmm team 0 at 8.13 min
  8.18  [Playtest] finished armnanotcplat team 0 at 8.18 min
  8.28  [Playtest] finished armmex team 0 at 8.28 min
  8.37  [Playtest] finished armason team 0 at 8.37 min
  8.39  [Playtest] finished armuwmmm team 0 at 8.39 min
  8.57  [Playtest] finished armnanotcplat team 0 at 8.57 min
  8.59  [Playtest] finished armason team 0 at 8.59 min
  8.84  [Playtest] finished armuwfus team 0 at 8.84 min
  8.93  [Playtest] finished armmex team 0 at 8.93 min
  8.98  [Playtest] finished armnanotcplat team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +65.6 bank 66455/103300, energy +2804.0 bank 719414/1007400, units 122
  9.22  [Playtest] finished armnanotcplat team 0 at 9.22 min
  9.33  [Playtest] finished armnanotcplat team 0 at 9.33 min
  9.35  [Playtest] finished armfrad team 0 at 9.35 min
  9.39  [Playtest] finished armmakr team 0 at 9.40 min
  9.52  [Playtest] finished armnanotcplat team 0 at 9.52 min
  9.62  [Playtest] finished armnanotcplat team 0 at 9.62 min
  9.73  [Playtest] finished armnanotcplat team 0 at 9.73 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +65.6 bank 52721/103300, energy +2804.0 bank 686209/1007400, units 146
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
