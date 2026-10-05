# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54069); wall 475 s
- DLL: build-theatres\d188-build-4\SkirmishAI.dll (4269e12be49092f4); AI BARbTest/test; staged 2026-10-04T01:16:48
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T041647Z-8c90fc50\runs\20261004T042446Z-bb3f8a41\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:39.147757][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.3 min | `[t=00:01:08.484528][f=0002376] [SeaWatch] finished frame=2376 id=30216 def=armsy builder=21009` |
| expect `first-ship-exit` | seen at 2.8 min | `[t=00:01:16.858030][f=0005040] [SeaWatch] egress id=17258 yard=30216 seconds=6.9 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T041647Z-8c90fc50\runs\20261004T042446Z-bb3f8a41\screen_2026-10-04_04-18-25-609.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T041647Z-8c90fc50\runs\20261004T042446Z-bb3f8a41\screen_2026-10-04_04-19-19-649.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T041647Z-8c90fc50\runs\20261004T042446Z-bb3f8a41\screen_2026-10-04_04-21-58-309.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T041647Z-8c90fc50\runs\20261004T042446Z-bb3f8a41\screen_2026-10-04_04-24-29-506.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2800, 2900) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4500, 1600) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (6600, 1000) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (8000, 2900) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (10100, 3200) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (11000, 1600) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (12800, 2700) units 1
  0.00  [Playtest] frame 1 team 7 ally 1 side armada ai true dead false start (2800, 12600) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (4500, 13800) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (8000, 13000) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (8800, 14300) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (10100, 13000) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (11000, 14200) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (12800, 12500) units 1
  0.00  [Playtest] frame 1 team 14 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 15 ally 3 side  ai false dead false start (0, 0) units 124
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2800, 2900) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4500, 1600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (6600, 1000) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (8000, 2900) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (10100, 3200) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (11000, 1600) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (12800, 2700) units 1
  0.05  [Playtest] frame 90 team 7 ally 1 side armada ai true dead false start (2800, 12600) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (4500, 13800) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (8000, 13000) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (8800, 14300) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (10100, 13000) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (11000, 14200) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (12800, 12500) units 1
  0.05  [Playtest] frame 90 team 14 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 15 ally 3 side  ai false dead false start (0, 0) units 124
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(4500,1597) factory=armhp landLocked=no spot=1 known=1/6
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6626,998) factory=corhp landLocked=no spot=2 known=2/6
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(8000,2900) factory=corhp landLocked=no spot=3 known=3/6
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(10084,3171) factory=armsy landLocked=no spot=5 known=4/6
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(11030,1625) factory=corsy landLocked=no spot=6 known=5/6
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(12803,2748) factory=legsy landLocked=no spot=7 known=6/6
  0.18  [Team][Roster] team 1 first mex at 4480,1536
  0.20  [Team][Roster] team 6 first mex at 12800,2912
  0.22  [Team][Roster] team 3 first mex at 7936,3040
  0.22  [Team][Roster] team 5 first mex at 10976,1584
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.28  [Team][Roster] team 2 first mex at 6688,960
  0.29  [Team][Roster] team 4 first mex at 10080,2976
  0.30  [Team][Roster] first mex 9024 at 3008,2912
  0.30  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|3008|2912
  0.58  [Playtest] finished armmex team 0 at 0.58 min
  0.70  [SEA][Layout] berth sea.berth.0 armsy at=2352,2912 facing=2
  0.88  [Playtest] finished armmex team 0 at 0.88 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +9.3 bank 1137/1150, energy +30.0 bank 761/1000, units 4
  1.22  [SEA][Layout] berth sea.berth.1 armasy at=2688,2144 facing=1
  1.32  [Playtest] finished armsy team 0 at 1.32 min
  1.58  [SEA][Layout] berth sea.berth.2 armasy at=2640,1904 facing=1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +5.6 bank 1041/1250, energy +30.0 bank 1/1100, units 6
  2.50  [Playtest] finished armmex team 0 at 2.50 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.4 bank 1299/1300, energy +37.0 bank 6/1150, units 8
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1282/1300, energy +37.0 bank 0/1150, units 11
  4.19  [Playtest] finished armwin team 0 at 4.19 min
  4.28  [Playtest] finished armtl team 0 at 4.28 min
  4.36  [Playtest] finished armwin team 0 at 4.36 min
  4.51  [Playtest] finished armwin team 0 at 4.51 min
  4.69  [Playtest] finished armwin team 0 at 4.69 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.4 bank 1283/1300, energy +92.4 bank 401/1202, units 16
  5.00  [Playtest] target team 0 at (2800, 2900) from its start position
  5.00  [Playtest] camera requested (2800,2900) height=2200
  5.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2800, 2900)
  5.20  [Playtest] finished armtide team 0 at 5.20 min
  5.26  [Playtest] finished armtide team 0 at 5.26 min
  5.36  [Playtest] finished armmex team 0 at 5.36 min
  5.41  [Playtest] finished armtide team 0 at 5.41 min
  5.73  [Playtest] finished armtide team 0 at 5.73 min
  5.81  [Playtest] finished armtide team 0 at 5.81 min
  5.99  [Playtest] finished armfrad team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +13.4 bank 1290/1350, energy +244.7 bank 1551/1552, units 25
  6.05  [Playtest] finished armtide team 0 at 6.05 min
  6.45  [Playtest] finished armtide team 0 at 6.45 min
  6.46  [Playtest] finished armtide team 0 at 6.46 min
  6.48  [Playtest] finished armmex team 0 at 6.48 min
  6.72  [Playtest] finished armmex team 0 at 6.72 min
  6.89  [Playtest] finished armtide team 0 at 6.89 min
  6.94  [Playtest] finished armtide team 0 at 6.94 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +18.3 bank 1249/1450, energy +367.3 bank 1787/1802, units 35
  7.08  [Playtest] finished armmex team 0 at 7.07 min
  7.22  [Playtest] finished armmex team 0 at 7.22 min
  7.27  [Playtest] finished armtide team 0 at 7.27 min
  7.29  [Playtest] finished armtide team 0 at 7.29 min
  7.58  [Playtest] finished armtl team 0 at 7.57 min
  7.69  [Playtest] finished armmex team 0 at 7.69 min
  7.71  [Playtest] finished armtide team 0 at 7.71 min
  7.95  [Playtest] finished armtide team 0 at 7.95 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +27.9 bank 1154/1600, energy +465.9 bank 2034/2052, units 46
  8.11  [Playtest] finished armtide team 0 at 8.11 min
  8.22  [Playtest] finished armllt team 0 at 8.22 min
  8.28  [Playtest] finished armtide team 0 at 8.28 min
  8.29  [Playtest] finished armtide team 0 at 8.28 min
  8.31  [Playtest] finished armtl team 0 at 8.31 min
  8.43  [Playtest] finished armtide team 0 at 8.43 min
  8.52  [Playtest] finished armnanotcplat team 0 at 8.52 min
  8.71  [Playtest] finished armtide team 0 at 8.71 min
  8.90  [Playtest] finished armtide team 0 at 8.90 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.2 bank 594/1600, energy +578.8 bank 2336/2352, units 53
  9.09  [Playtest] finished armtide team 0 at 9.09 min
  9.13  [Playtest] finished armmex team 0 at 9.13 min
  9.24  [Playtest] finished armtide team 0 at 9.24 min
  9.35  [Playtest] finished armfrad team 0 at 9.35 min
  9.44  [Playtest] finished armtide team 0 at 9.44 min
  9.59  [Playtest] finished armtide team 0 at 9.59 min
  9.82  [Playtest] finished armtide team 0 at 9.82 min
  9.97  [Playtest] finished armmex team 0 at 9.97 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +22.4 bank 389/1550, energy +719.8 bank 2585/2602, units 62
 10.00  [Playtest] camera requested (2800,2900) height=2200
 10.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (2800, 2900)
 10.04  [Playtest] finished armtide team 0 at 10.04 min
 10.04  [Playtest] finished armmex team 0 at 10.04 min
 10.54  [Playtest] finished armtl team 0 at 10.54 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +24.8 bank 276/1600, energy +696.9 bank 2542/2552, units 61
 11.03  [Playtest] finished armmex team 0 at 11.03 min
 11.42  [Playtest] finished armllt team 0 at 11.42 min
 11.49  [Playtest] finished armtide team 0 at 11.49 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +25.2 bank 629/1600, energy +715.6 bank 2648/2652, units 58
 12.44  [Playtest] finished armfrad team 0 at 12.44 min
 12.46  [Playtest] finished armfmkr team 0 at 12.46 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +26.2 bank 592/1600, energy +710.5 bank 2545/2602, units 59
 13.10  [Playtest] finished armmex team 0 at 13.10 min
 13.62  [Playtest] finished armtl team 0 at 13.62 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +28.3 bank 949/1650, energy +707.0 bank 2595/2652, units 60
 14.63  [Playtest] finished armtl team 0 at 14.63 min
 14.78  [Playtest] finished armfrad team 0 at 14.78 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +28.3 bank 1116/1650, energy +706.0 bank 2643/2702, units 67
 15.37  [Playtest] finished armtide team 0 at 15.37 min
 15.76  [Playtest] finished armtl team 0 at 15.76 min
 15.88  [Playtest] finished armtl team 0 at 15.88 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +28.3 bank 955/1650, energy +785.7 bank 2732/2752, units 67
 16.39  [Playtest] finished armtl team 0 at 16.40 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +26.2 bank 989/1600, energy +764.5 bank 2543/2602, units 64
 18.00  [Playtest] eco team 0 at 18.0 min: metal +24.1 bank 1236/1550, energy +714.8 bank 2545/2602, units 64
 18.72  [Playtest] finished armmex team 0 at 18.72 min
 18.82  [Playtest] finished armnanotcplat team 0 at 18.82 min
 18.98  [Playtest] finished armnanotcplat team 0 at 18.98 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +26.6 bank 1326/1600, energy +777.5 bank 2606/2702, units 71
 19.13  [Playtest] finished armfmkr team 0 at 19.13 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +23.1 bank 634/1050, energy +750.9 bank 2144/2202, units 64
 20.00  [Playtest] camera requested (2800,2900) height=2200
 20.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (2800, 2900)
 20.19  [Playtest] finished armfmkr team 0 at 20.19 min
 20.30  [Playtest] finished armfmkr team 0 at 20.30 min
 20.49  [Playtest] finished armfmkr team 0 at 20.49 min
 20.64  [Playtest] finished armfmkr team 0 at 20.64 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +19.8 bank 183/900, energy +720.0 bank 1886/2152, units 65
 21.02  [Playtest] finished armfmkr team 0 at 21.02 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +17.1 bank 72/850, energy +532.2 bank 1293/1502, units 42
 22.93  [SEA][Layout] berth sea.berth.3 corsy at=3376,3120 facing=1
 23.00  [Playtest] eco team 0 at 23.0 min: metal +2.1 bank 283/550, energy +0.0 bank 492/500, units 2
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 297/500, energy +0.0 bank 495/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 495/500, energy +0.0 bank 484/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 495/500, energy +0.0 bank 484/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 495/500, energy +0.0 bank 484/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 495/500, energy +0.0 bank 484/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 495/500, energy +0.0 bank 484/500, units 0
 29.00  [Playtest] camera requested (2800,2900) height=2200
 29.01  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (2800, 2900)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 495/500, energy +0.0 bank 484/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(21009) at (2836, 2906) walks to (2872, 2907), 136 from the armmex site (3008, 2912)
  0.09  EXP: approach: legcom(1080) at (8000, 2900) walks to (7993, 2915), 137 from the legmex site (7936, 3040)
  0.09  EXP: approach: armcom(31164) at (10084, 3172) walks to (10083, 3112), 136 from the armmex site (10080, 2976)
  0.09  EXP: approach: legcom(24292) at (12803, 2749) walks to (12803, 2775), 137 from the legmex site (12800, 2912)
  0.09  EXP: approach: armcom(18689) at (2798, 12604) walks to (2775, 12632), 136 from the armmex site (2688, 12736)
  0.09  EXP: approach: corcom(28911) at (4457, 13822) walks to (4287, 13897), 139 from the cormex site (4160, 13952)
  0.09  EXP: approach: legcom(30327) at (7960, 13019) walks to (7761, 13090), 137 from the legmex site (7632, 13136)
  0.09  EXP: approach: corcom(31547) at (10073, 12977) walks to (9926, 12728), 139 from the cormex site (9856, 12608)
  0.09  EXP: approach: armcom(10566) at (12744, 12493) walks to (12674, 12472), 136 from the armmex site (12544, 12432)
  0.10  RESERVE: zone 1 at (8000, 2896) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (8000, 2896) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (8288, 2896) facing 1, 30x12 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (7720, 2904) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7720, 2904) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7784, 2904) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7784, 2904) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7848, 2904) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7848, 2904) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7720, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7720, 2968) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7784, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7784, 2968) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7848, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7848, 2968) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (7776, 2928) facing 0, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (7968, 13024) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7968, 13024) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (7968, 12736) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (8040, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8040, 13256) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (7976, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7976, 13256) facing 2 (id 3)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 at (8136, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8136, 13256) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (8072, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8072, 13256) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (8008, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8008, 13256) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (8136, 13192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8136, 13192) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (8072, 13192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8072, 13192) facing 2 (id 8)
  0.10  RESERVE: zone 10 at (8008, 13192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8008, 13192) facing 2 (id 9)
  0.10  RESERVE: zone 11 at (8064, 13216) facing 2, 12x8 cells: 42 of 96 held
  0.11  RESERVE: zone 1 at (10080, 12976) facing 3, 6x6 cells: 36 of 36 held
  0.11  RESERVE: corsy at (10080, 12976) facing 3 (id 1)
  0.11  RESERVE: corridor 2 at (9792, 12976) facing 3, 30x12 cells: 360 of 360 held
  0.11  RESERVE: zone 3 at (10376, 12984) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10376, 12984) facing 2 (id 2)
  0.11  RESERVE: zone 4 at (10312, 12984) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10312, 12984) facing 2 (id 3)
  0.11  RESERVE: zone 5 at (10248, 12984) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10248, 12984) facing 2 (id 4)
  0.11  RESERVE: zone 6 at (10376, 12920) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10376, 12920) facing 2 (id 5)
  0.11  RESERVE: zone 7 at (10312, 12920) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10312, 12920) facing 2 (id 6)
  0.11  RESERVE: zone 8 at (10248, 12920) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10248, 12920) facing 2 (id 7)
  0.11  RESERVE: zone 9 at (10304, 12944) facing 2, 12x8 cells: 42 of 96 held
  0.11  EXP: idle: legcom(1080) on legmex at (7996, 2908), site (7936, 3040), target yes, fails 2 (arrived at the approach point)
  0.12  EXP: idle: armcom(18689) on armmex at (2783, 12622), site (2688, 12736), target yes, fails 2 (arrived at the approach point)
  0.19  EXP: approach: armcom(6840) at (4500, 1597) walks to (4584, 1870), 136 from the armmex site (4624, 2000)
  0.19  EXP: approach: legcom(15023) at (11000, 14200) walks to (11060, 14134), 137 from the legmex site (11152, 14032)
  0.21  EXP: approach: legcom(24292) at (12803, 2755) walks to (12904, 2767), 137 from the legmex site (13040, 2784)
  0.22  RESERVE: served legsy at (8000, 2896) facing 1 (id 1, 0 of this def still held)
  0.22  EXP: approach: armcom(18689) at (2782, 12624) walks to (2769, 12519), 136 from the armmex site (2752, 12384)
  0.23  EXP: approach: corcom(25339) at (11063, 1644) walks to (11157, 1695), 139 from the cormex site (11280, 1760)
  0.23  EXP: approach: armcom(9476) at (8763, 14249) walks to (8883, 14299), 136 from the armmex site (9008, 14352)
  0.24  RESERVE: zone 1 at (4656, 13824) facing 2, 6x6 cells: 36 of 36 held
  0.24  RESERVE: corsy at (4656, 13824) facing 2 (id 1)
  0.24  RESERVE: corridor 2 at (4656, 13536) facing 2, 12x30 cells: 360 of 360 held
  0.24  RESERVE: zone 3 at (4728, 14056) facing 2, 3x3 cells: 9 of 9 held
  0.24  RESERVE: cornanotcplat at (4728, 14056) facing 2 (id 2)
  0.24  RESERVE: zone 4 at (4664, 14056) facing 2, 3x3 cells: 9 of 9 held
  0.24  RESERVE: cornanotcplat at (4664, 14056) facing 2 (id 3)
  0.24  RESERVE: zone 5 at (4600, 14056) facing 2, 3x3 cells: 9 of 9 held
  0.24  RESERVE: cornanotcplat at (4600, 14056) facing 2 (id 4)
  0.24  RESERVE: zone 6 at (4728, 13992) facing 2, 3x3 cells: 9 of 9 held
  0.24  RESERVE: cornanotcplat at (4728, 13992) facing 2 (id 5)
  0.24  RESERVE: zone 7 at (4664, 13992) facing 2, 3x3 cells: 9 of 9 held
  0.24  RESERVE: cornanotcplat at (4664, 13992) facing 2 (id 6)
  0.24  RESERVE: zone 8 at (4600, 13992) facing 2, 3x3 cells: 9 of 9 held
  0.24  RESERVE: cornanotcplat at (4600, 13992) facing 2 (id 7)
  0.24  RESERVE: zone 9 at (4656, 14016) facing 2, 12x8 cells: 42 of 96 held
  0.28  EXP: approach: corcom(20915) at (6588, 1014) walks to (6393, 1048), 139 from the cormex site (6256, 1072)
  0.29  RESERVE: zone 10 at (9680, 13168) facing 3, 12x12 cells: 144 of 144 held
  0.29  RESERVE: corasy at (9680, 13168) facing 3 (id 8)
  0.29  RESERVE: corridor 11 at (9344, 13168) facing 3, 30x18 cells: 534 of 540 held
  0.29  RESERVE: zone 12 at (10072, 13176) facing 2, 3x3 cells: 9 of 9 held
  0.29  RESERVE: cornanotcplat at (10072, 13176) facing 2 (id 9)
  0.29  RESERVE: zone 13 at (10008, 13176) facing 2, 3x3 cells: 9 of 9 held
  0.29  RESERVE: cornanotcplat at (10008, 13176) facing 2 (id 10)
  0.29  RESERVE: zone 14 at (9944, 13176) facing 2, 3x3 cells: 9 of 9 held
  0.29  RESERVE: cornanotcplat at (9944, 13176) facing 2 (id 11)
  0.29  RESERVE: zone 15 at (10072, 13112) facing 2, 3x3 cells: 9 of 9 held
  0.29  RESERVE: cornanotcplat at (10072, 13112) facing 2 (id 12)
  0.29  RESERVE: zone 16 at (10008, 13112) facing 2, 3x3 cells: 9 of 9 held
  0.29  RESERVE: cornanotcplat at (10008, 13112) facing 2 (id 13)
  0.29  RESERVE: zone 17 at (9944, 13112) facing 2, 3x3 cells: 9 of 9 held
  0.29  RESERVE: cornanotcplat at (9944, 13112) facing 2 (id 14)
  0.29  RESERVE: zone 18 at (10000, 13136) facing 2, 12x8 cells: 42 of 96 held
  0.30  EXP: approach: armcom(31164) at (10082, 3039) walks to (10264, 3136), 136 from the armmex site (10384, 3200)
  0.30  EXP: approach: armcom(21009) at (2945, 2909) walks to (2872, 2748), 136 from the armmex site (2816, 2624)
  0.31  EXP: approach: armcom(10566) at (12597, 12448) walks to (12623, 12665), 136 from the armmex site (12640, 12800)
  0.35  RESERVE: zone 10 at (8400, 2704) facing 0, 12x12 cells: 144 of 144 held
  0.35  RESERVE: legadvshipyard at (8400, 2704) facing 0 (id 8)
  0.35  RESERVE: corridor 11 at (8400, 3040) facing 0, 18x30 cells: 336 of 540 held
  0.35  RESERVE: zone 12 at (8440, 2488) facing 0, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (8440, 2488) facing 0 (id 9)
  0.35  RESERVE: zone 13 at (8504, 2488) facing 0, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (8504, 2488) facing 0 (id 10)
  0.35  RESERVE: zone 14 at (8568, 2488) facing 0, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (8568, 2488) facing 0 (id 11)
  0.35  RESERVE: zone 15 at (8440, 2552) facing 0, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (8440, 2552) facing 0 (id 12)
  0.35  RESERVE: zone 16 at (8504, 2552) facing 0, 3x3 cells: 9 of 9 held
```
