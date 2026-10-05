# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54010); wall 491 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:17:54
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\caldera\20261004T111754Z-ded0c038\runs\20261004T112607Z-120592b0\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:39.842440][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.1 min | `[t=00:01:06.070658][f=0001896] [SeaWatch] finished frame=1896 id=5580 def=armsy builder=30071` |
| expect `first-ship-exit` | seen at 3.2 min | `[t=00:01:18.766172][f=0005760] [SeaWatch] egress id=7925 yard=5580 seconds=12.9 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\caldera\20261004T111754Z-ded0c038\runs\20261004T112607Z-120592b0\screen_2026-10-04_11-19-30-560.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\caldera\20261004T111754Z-ded0c038\runs\20261004T112607Z-120592b0\screen_2026-10-04_11-20-22-629.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\caldera\20261004T111754Z-ded0c038\runs\20261004T112607Z-120592b0\screen_2026-10-04_11-23-00-116.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\caldera\20261004T111754Z-ded0c038\runs\20261004T112607Z-120592b0\screen_2026-10-04_11-25-49-220.png

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
  0.00  [Playtest] frame 1 team 15 ally 3 side  ai false dead false start (0, 0) units 107
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
  0.05  [Playtest] frame 90 team 15 ally 3 side  ai false dead false start (0, 0) units 107
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
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=2352,2912 facing=2
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.28  [Team][Roster] team 2 first mex at 6688,960
  0.29  [Team][Roster] team 4 first mex at 10080,2976
  0.30  [Team][Roster] first mex 20159 at 3008,2912
  0.30  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|3008|2912
  0.45  [SEA][Layout] berth sea.berth.1 armasy at=2688,2144 facing=1
  0.57  [Playtest] finished armmex team 0 at 0.57 min
  0.82  [SEA][Layout] berth sea.berth.2 armasy at=2640,1904 facing=1
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.9 bank 790/1100, energy +30.0 bank 486/1000, units 4
  1.05  [Playtest] finished armsy team 0 at 1.05 min
  1.46  [Playtest] finished armmex team 0 at 1.46 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 994/1250, energy +30.0 bank 126/1100, units 6
  2.69  [Playtest] finished armmex team 0 at 2.69 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.4 bank 1049/1300, energy +30.0 bank 13/1150, units 7
  3.60  [Playtest] finished armwin team 0 at 3.60 min
  3.81  [Playtest] finished armwin team 0 at 3.81 min
  3.92  [Playtest] finished armmex team 0 at 3.92 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.4 bank 1337/1350, energy +77.0 bank 244/1151, units 12
  4.02  [Playtest] finished armwin team 0 at 4.02 min
  4.47  [Playtest] finished armllt team 0 at 4.47 min
  4.53  [Playtest] finished armmex team 0 at 4.53 min
  5.00  [Playtest] finished armtl team 0 at 5.00 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.5 bank 1316/1400, energy +98.5 bank 1137/1201, units 17
  5.00  [Playtest] target team 0 at (2800, 2900) from its start position
  5.00  [Playtest] camera requested (2800,2900) height=2200
  5.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2800, 2900)
  5.30  [Playtest] finished armmex team 0 at 5.30 min
  5.38  [Playtest] finished armtide team 0 at 5.38 min
  5.59  [Playtest] finished armmex team 0 at 5.59 min
  5.70  [Playtest] finished armtide team 0 at 5.70 min
  5.84  [Playtest] finished armmex team 0 at 5.84 min
  5.93  [Playtest] finished armmex team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.8 bank 1458/1600, energy +156.9 bank 1339/1351, units 26
  6.07  [Playtest] finished armtide team 0 at 6.07 min
  6.37  [Playtest] finished armtide team 0 at 6.37 min
  6.39  [Playtest] finished armtide team 0 at 6.39 min
  6.54  [Playtest] finished armmex team 0 at 6.54 min
  6.57  [Playtest] finished armmex team 0 at 6.57 min
  6.81  [Playtest] finished armtide team 0 at 6.81 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +29.3 bank 1308/1700, energy +234.0 bank 1460/1551, units 33
  7.08  [Playtest] finished armllt team 0 at 7.08 min
  7.15  [Playtest] finished armmex team 0 at 7.15 min
  7.35  [Playtest] finished armtl team 0 at 7.35 min
  7.67  [Playtest] finished armmex team 0 at 7.67 min
  7.92  [Playtest] finished armtl team 0 at 7.92 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +33.4 bank 1371/1800, energy +246.9 bank 1577/1601, units 40
  8.05  [Playtest] finished armmex team 0 at 8.05 min
  8.27  [Playtest] finished armtide team 0 at 8.27 min
  8.28  [Playtest] finished armmex team 0 at 8.28 min
  8.62  [Playtest] finished armtide team 0 at 8.62 min
  8.93  [Playtest] finished armtide team 0 at 8.93 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +35.9 bank 1534/1850, energy +306.3 bank 1785/1801, units 48
  9.00  [Playtest] finished armnanotcplat team 0 at 9.00 min
  9.11  [Playtest] finished armtide team 0 at 9.11 min
  9.21  [Playtest] finished armllt team 0 at 9.21 min
  9.24  [Playtest] finished armtide team 0 at 9.24 min
  9.32  [Playtest] finished armnanotcplat team 0 at 9.32 min
  9.36  [Playtest] finished armtide team 0 at 9.36 min
  9.74  [Playtest] finished armtide team 0 at 9.74 min
  9.77  [Playtest] finished armtide team 0 at 9.77 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +33.8 bank 1189/1800, energy +447.0 bank 2005/2051, units 54
 10.00  [Playtest] camera requested (2800,2900) height=2200
 10.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (2800, 2900)
 10.12  [Playtest] finished armtide team 0 at 10.12 min
 10.12  [Playtest] finished armtide team 0 at 10.12 min
 10.28  [Playtest] finished armtide team 0 at 10.28 min
 10.29  [Playtest] finished armtl team 0 at 10.29 min
 10.42  [Playtest] finished armtide team 0 at 10.42 min
 10.63  [Playtest] finished armllt team 0 at 10.63 min
 10.72  [Playtest] finished armtl team 0 at 10.72 min
 10.80  [Playtest] finished armtide team 0 at 10.80 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +33.8 bank 423/1800, energy +569.0 bank 2335/2351, units 63
 11.12  [Playtest] finished armtide team 0 at 11.12 min
 11.49  [Playtest] finished armtide team 0 at 11.49 min
 11.59  [Playtest] finished armfrad team 0 at 11.59 min
 11.81  [Playtest] finished armtide team 0 at 11.81 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +31.7 bank 51/1750, energy +574.4 bank 2351/2351, units 64
 12.14  [Playtest] finished armtide team 0 at 12.14 min
 12.58  [Playtest] finished armtide team 0 at 12.58 min
 12.66  [Playtest] finished armmex team 0 at 12.66 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +33.8 bank 16/1800, energy +655.8 bank 2376/2401, units 64
 14.00  [Playtest] eco team 0 at 14.0 min: metal +31.7 bank 34/1750, energy +652.0 bank 1037/2401, units 63
 14.78  [Playtest] finished armtide team 0 at 14.78 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +31.7 bank 52/1750, energy +648.6 bank 1747/2451, units 66
 15.11  [Playtest] finished armtide team 0 at 15.11 min
 15.44  [Playtest] finished armtide team 0 at 15.44 min
 15.80  [Playtest] finished armtide team 0 at 15.80 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +31.7 bank 15/1750, energy +727.2 bank 2332/2601, units 70
 16.17  [Playtest] finished armtide team 0 at 16.17 min
 16.51  [Playtest] finished armtide team 0 at 16.51 min
 16.66  [Playtest] finished armmex team 0 at 16.66 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +33.8 bank 16/1800, energy +784.0 bank 2692/2701, units 75
 17.08  [Playtest] finished armtide team 0 at 17.08 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +33.8 bank 103/1800, energy +823.3 bank 2798/2801, units 75
 18.03  [Playtest] finished armfrad team 0 at 18.03 min
 18.09  [Playtest] finished armtide team 0 at 18.09 min
 18.23  [Playtest] finished armtide team 0 at 18.24 min
 18.73  [Playtest] finished armfmkr team 0 at 18.73 min
 18.78  [Playtest] finished armtl team 0 at 18.78 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +34.8 bank 1191/1800, energy +849.9 bank 2804/2851, units 73
 20.00  [Playtest] eco team 0 at 20.0 min: metal +26.2 bank 0/1150, energy +816.1 bank 2310/2351, units 67
 20.00  [Playtest] camera requested (2800,2900) height=2200
 20.01  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (2800, 2900)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +21.4 bank 0/1050, energy +796.8 bank 2313/2351, units 59
 22.00  [Playtest] eco team 0 at 22.0 min: metal +21.4 bank 6/1050, energy +830.7 bank 2301/2351, units 61
 22.65  [Playtest] finished armasy team 0 at 22.65 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +19.3 bank 0/1200, energy +795.6 bank 2516/2551, units 63
 24.00  [Playtest] eco team 0 at 24.0 min: metal +19.3 bank 0/1200, energy +834.7 bank 2675/2701, units 61
 25.00  [Playtest] eco team 0 at 25.0 min: metal +13.5 bank 0/1100, energy +446.5 bank 1748/1751, units 38
 25.27  [Playtest] finished armtl team 0 at 25.27 min
 25.29  [Playtest] finished armuwmme team 0 at 25.29 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +15.6 bank 11/1550, energy +281.9 bank 1444/1450, units 25
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 0/700, energy +60.0 bank 1000/1000, units 4
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 0/500, energy +60.0 bank 800/800, units 3
 28.32  [SEA][Layout] berth sea.berth.3 armsy at=1856,3312 facing=2
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 0/500, energy +30.0 bank 647/650, units 2
 29.00  [Playtest] camera requested (2800,2900) height=2200
 29.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (2800, 2900)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 0/500, energy +0.0 bank 500/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(30071) at (2836, 2906) walks to (2872, 2907), 136 from the armmex site (3008, 2912)
  0.09  EXP: approach: legcom(28578) at (8000, 2900) walks to (7993, 2915), 137 from the legmex site (7936, 3040)
  0.09  EXP: approach: armcom(19480) at (10084, 3172) walks to (10083, 3112), 136 from the armmex site (10080, 2976)
  0.09  EXP: approach: legcom(3424) at (12803, 2749) walks to (12803, 2775), 137 from the legmex site (12800, 2912)
  0.09  EXP: approach: armcom(27123) at (2798, 12604) walks to (2775, 12632), 136 from the armmex site (2688, 12736)
  0.09  EXP: approach: corcom(22737) at (4457, 13822) walks to (4287, 13897), 139 from the cormex site (4160, 13952)
  0.09  EXP: approach: legcom(24526) at (7960, 13019) walks to (7761, 13090), 137 from the legmex site (7632, 13136)
  0.09  EXP: approach: corcom(5679) at (10073, 12977) walks to (9926, 12728), 139 from the cormex site (9856, 12608)
  0.09  EXP: approach: armcom(16913) at (12744, 12493) walks to (12674, 12472), 136 from the armmex site (12544, 12432)
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
  0.11  EXP: idle: legcom(28578) on legmex at (7996, 2908), site (7936, 3040), target yes, fails 2 (arrived at the approach point)
  0.12  EXP: idle: armcom(27123) on armmex at (2783, 12622), site (2688, 12736), target yes, fails 2 (arrived at the approach point)
  0.14  RESERVE: zone 1 at (3088, 12608) facing 2, 6x6 cells: 36 of 36 held
  0.14  RESERVE: armsy at (3088, 12608) facing 2 (id 1)
  0.14  RESERVE: corridor 2 at (3088, 12320) facing 2, 12x30 cells: 360 of 360 held
  0.14  RESERVE: zone 3 at (3160, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3160, 12840) facing 2 (id 2)
  0.14  RESERVE: zone 4 at (3096, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3096, 12840) facing 2 (id 3)
  0.14  RESERVE: zone 5 at (3032, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3032, 12840) facing 2 (id 4)
  0.14  RESERVE: zone 6 at (3160, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3160, 12776) facing 2 (id 5)
  0.14  RESERVE: zone 7 at (3096, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3096, 12776) facing 2 (id 6)
  0.14  RESERVE: zone 3 released
  0.14  RESERVE: zone 4 released
  0.14  RESERVE: zone 5 released
  0.14  RESERVE: zone 6 released
  0.14  RESERVE: zone 7 released
  0.14  RESERVE: zone 8 at (3256, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3256, 12840) facing 2 (id 7)
  0.14  RESERVE: zone 9 at (3192, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3192, 12840) facing 2 (id 8)
  0.14  RESERVE: zone 10 at (3128, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3128, 12840) facing 2 (id 9)
  0.14  RESERVE: zone 11 at (3256, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3256, 12776) facing 2 (id 10)
  0.14  RESERVE: zone 12 at (3192, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3192, 12776) facing 2 (id 11)
  0.14  RESERVE: zone 13 at (3128, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3128, 12776) facing 2 (id 12)
  0.14  RESERVE: zone 14 at (3184, 12800) facing 2, 12x8 cells: 42 of 96 held
  0.19  EXP: approach: armcom(891) at (4500, 1597) walks to (4584, 1870), 136 from the armmex site (4624, 2000)
  0.19  RESERVE: zone 1 at (13216, 12496) facing 0, 6x6 cells: 36 of 36 held
  0.19  RESERVE: armsy at (13216, 12496) facing 0 (id 1)
  0.19  RESERVE: corridor 2 at (13216, 12784) facing 0, 12x30 cells: 360 of 360 held
  0.19  RESERVE: zone 3 at (13224, 12216) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13224, 12216) facing 3 (id 2)
  0.19  RESERVE: zone 4 at (13224, 12280) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13224, 12280) facing 3 (id 3)
  0.19  RESERVE: zone 5 at (13224, 12344) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13224, 12344) facing 3 (id 4)
  0.19  RESERVE: zone 3 released
  0.19  RESERVE: zone 4 released
  0.19  RESERVE: zone 5 released
  0.19  RESERVE: zone 6 at (13320, 12216) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13320, 12216) facing 3 (id 5)
  0.19  RESERVE: zone 7 at (13320, 12280) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13320, 12280) facing 3 (id 6)
  0.19  RESERVE: zone 8 at (13320, 12344) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13320, 12344) facing 3 (id 7)
  0.19  RESERVE: zone 9 at (13256, 12216) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13256, 12216) facing 3 (id 8)
  0.19  RESERVE: zone 10 at (13256, 12280) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13256, 12280) facing 3 (id 9)
  0.19  RESERVE: zone 11 at (13256, 12344) facing 3, 3x3 cells: 9 of 9 held
```
