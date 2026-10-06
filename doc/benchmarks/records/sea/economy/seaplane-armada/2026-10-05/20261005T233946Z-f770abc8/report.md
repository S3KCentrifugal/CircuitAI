# Playtest report: FAIL

- Verdict: **FAIL** (expected lines never seen: aircraft, support)
- Game time reached: 10.0 min (frame 18000); wall 105 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (15958e3e8775d55b); AI BARbTest/test; staged 2026-10-05T20:37:52
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: seaplane-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T233752Z-29a90cf3\runs\20261005T233946Z-f770abc8\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `mex` | seen at 1.1 min | `[t=00:00:48.487289][f=0002050] [SeaTransition] PASS mex completed by first construction ship` |
| expect `platform` | seen at 3.3 min | `[t=00:01:02.379932][f=0005924] [SeaTransition] PASS platform completed armplat` |
| expect `aircraft` | **missing** (by 10 min) | |
| expect `footprint` | seen at 2.5 min | `[SeaTransition] footprint slots=31 platform=armplat` |
| expect `support` | **missing** (by 10 min) | |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T233752Z-29a90cf3\runs\20261005T233946Z-f770abc8\screen_2026-10-05_23-38-49-546.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T233752Z-29a90cf3\runs\20261005T233946Z-f770abc8\screen_2026-10-05_23-39-02-836.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261005T233752Z-29a90cf3\runs\20261005T233946Z-f770abc8\screen_2026-10-05_23-39-33-818.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 10.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 30
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 30
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 25906 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4764|11076|0|7|1|4608|11072
  0.25  [SEA][Layout] berth sea.berth.0 armasy at=6096,10080 facing=2
  0.32  [SEA][Layout] berth sea.berth.1 armplat at=5904,9968 facing=2
  0.41  [Playtest] finished armmex team 0 at 0.41 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 99618/100200, energy +1244.0 bank 1002668/1002700, units 10
  1.00  [Playtest] camera requested (6200,11000) height=3200
  1.01  [Playtest] camera captured name=ta position=(6200,11000) height=3200
  1.01  [Playtest] screenshot at 1.0 min of team 0 at (6200, 11000)
  1.14  [Playtest] finished armmex team 0 at 1.14 min
  1.66  [Playtest] finished armnanotcplat team 0 at 1.66 min
  1.72  [Playtest] finished armmex team 0 at 1.72 min
  1.75  [SEA][Layout] berth sea.berth.2 armsy at=6288,10080 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +11.2 bank 98134/100300, energy +1244.0 bank 1002629/1002700, units 17
  2.00  [Playtest] finished armasy team 0 at 2.00 min
  2.09  [Playtest] finished armnanotcplat team 0 at 2.09 min
  2.23  [Playtest] finished armmex team 0 at 2.23 min
  2.38  [Playtest] finished armnanotcplat team 0 at 2.38 min
  2.42  [SEA][Layout] berth sea.berth.1 armplat at=5952,10192 facing=2
  3.00  [Playtest] eco team 0 at 3.0 min: metal +13.5 bank 94375/100550, energy +1274.0 bank 1002845/1003050, units 27
  3.00  [Playtest] camera requested (6200,11000) height=3800
  3.00  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.02  [Playtest] finished armmex team 0 at 3.02 min
  3.29  [Playtest] finished armplat team 0 at 3.29 min
  3.52  [Playtest] finished armmex team 0 at 3.52 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +18.1 bank 89412/100650, energy +1304.0 bank 1003132/1003400, units 39
  4.08  [Playtest] finished armmex team 0 at 4.07 min
  4.12  [Playtest] finished armnanotcplat team 0 at 4.12 min
  4.13  [Playtest] finished armuwmme team 0 at 4.13 min
  4.58  [Playtest] finished armnanotcplat team 0 at 4.58 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +30.2 bank 85839/101250, energy +1604.0 bank 1004569/1004900, units 50
  5.03  [Playtest] finished armmex team 0 at 5.03 min
  5.10  [Playtest] finished armuwmme team 0 at 5.10 min
  5.32  [Playtest] finished armmex team 0 at 5.32 min
  5.45  [Playtest] finished armnanotcplat team 0 at 5.45 min
  5.62  [Playtest] finished armmex team 0 at 5.63 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +43.8 bank 82227/101950, energy +1604.0 bank 1004668/1004900, units 60
  6.11  [Playtest] finished armmex team 0 at 6.11 min
  6.42  [Playtest] finished armuwmmm team 0 at 6.42 min
  6.47  [Playtest] finished armmex team 0 at 6.47 min
  6.68  [Playtest] finished armnanotcplat team 0 at 6.68 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +58.1 bank 78497/102050, energy +1604.0 bank 986963/1004900, units 73
  7.00  [Playtest] finished armmex team 0 at 7.00 min
  7.27  [Playtest] finished armmex team 0 at 7.27 min
  7.43  [Playtest] finished armllt team 0 at 7.43 min
  7.57  [Playtest] finished armrad team 0 at 7.57 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +65.6 bank 75083/102150, energy +1604.0 bank 958329/1004900, units 86
  8.00  [Playtest] camera requested (6200,11000) height=4000
  8.01  [Playtest] camera captured name=ta position=(6200,11000) height=4000
  8.01  [Playtest] screenshot at 8.0 min of team 0 at (6200, 11000)
  8.03  [Playtest] finished armmex team 0 at 8.03 min
  8.20  [Playtest] finished armllt team 0 at 8.20 min
  8.82  [Playtest] finished armllt team 0 at 8.82 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +65.1 bank 71694/102200, energy +1604.0 bank 930283/1004900, units 96
  9.04  [Playtest] finished armrad team 0 at 9.04 min
  9.83  [Playtest] finished armuwmme team 0 at 9.83 min
  9.97  [Playtest] finished armmakr team 0 at 9.97 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +75.3 bank 68188/102750, energy +1604.0 bank 897367/1004900, units 105
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
