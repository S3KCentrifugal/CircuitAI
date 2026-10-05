# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54043); wall 499 s
- DLL: build-theatres\d189-baseline\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T07:24:50
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T102450Z-1e1dbef4\runs\20261004T103313Z-809f43b2\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:46.215679][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.1 min | `[t=00:01:17.388154][f=0001941] [SeaWatch] finished frame=1941 id=5580 def=armsy builder=30071` |
| expect `first-ship-exit` | seen at 3.0 min | `[t=00:01:30.042415][f=0005460] [SeaWatch] egress id=7925 yard=5580 seconds=11.0 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T102450Z-1e1dbef4\runs\20261004T103313Z-809f43b2\screen_2026-10-04_10-26-41-012.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T102450Z-1e1dbef4\runs\20261004T103313Z-809f43b2\screen_2026-10-04_10-27-35-407.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T102450Z-1e1dbef4\runs\20261004T103313Z-809f43b2\screen_2026-10-04_10-30-07-798.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T102450Z-1e1dbef4\runs\20261004T103313Z-809f43b2\screen_2026-10-04_10-32-50-996.png

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
  0.30  [Team][Roster] first mex 26509 at 3008,2912
  0.30  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|3008|2912
  0.45  [SEA][Layout] berth sea.berth.1 armasy at=2688,2144 facing=1
  0.58  [Playtest] finished armmex team 0 at 0.58 min
  0.82  [SEA][Layout] berth sea.berth.2 armasy at=2640,1904 facing=1
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.9 bank 827/1100, energy +30.0 bank 553/1000, units 4
  1.08  [Playtest] finished armsy team 0 at 1.08 min
  1.50  [Playtest] finished armmex team 0 at 1.50 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 973/1250, energy +30.0 bank 126/1100, units 6
  2.71  [Playtest] finished armmex team 0 at 2.71 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +9.1 bank 1211/1300, energy +37.0 bank 13/1150, units 8
  3.33  [Playtest] finished armtide team 0 at 3.33 min
  3.93  [Playtest] finished armmex team 0 at 3.93 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.4 bank 1336/1350, energy +67.0 bank 31/1250, units 11
  4.39  [Playtest] finished armmex team 0 at 4.39 min
  4.40  [Playtest] finished armtide team 0 at 4.40 min
  4.76  [Playtest] finished armtide team 0 at 4.76 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.8 bank 1288/1400, energy +113.0 bank 1343/1350, units 16
  5.00  [Playtest] target team 0 at (2800, 2900) from its start position
  5.00  [Playtest] camera requested (2800,2900) height=2200
  5.01  [Playtest] camera captured name=ta position=(2800,2900) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2800, 2900)
  5.08  [Playtest] finished armtide team 0 at 5.08 min
  5.20  [Playtest] finished armmex team 0 at 5.20 min
  5.40  [Playtest] finished armtide team 0 at 5.40 min
  5.56  [Playtest] finished armtl team 0 at 5.56 min
  5.72  [Playtest] finished armtide team 0 at 5.72 min
  5.81  [Playtest] finished armtl team 0 at 5.81 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +17.9 bank 1211/1450, energy +189.0 bank 1541/1550, units 23
  6.21  [Playtest] finished armmex team 0 at 6.21 min
  6.35  [Playtest] finished armfrad team 0 at 6.35 min
  6.58  [Playtest] finished armmex team 0 at 6.58 min
  6.64  [Playtest] finished armtl team 0 at 6.64 min
  6.75  [Playtest] finished armllt team 0 at 6.75 min
  6.82  [Playtest] finished armtide team 0 at 6.82 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.8 bank 1194/1550, energy +219.0 bank 1639/1650, units 33
  7.14  [Playtest] finished armtide team 0 at 7.14 min
  7.19  [Playtest] finished armmex team 0 at 7.19 min
  7.46  [Playtest] finished armtide team 0 at 7.46 min
  7.56  [Playtest] finished armtide team 0 at 7.56 min
  7.71  [Playtest] finished armtl team 0 at 7.71 min
  7.75  [Playtest] finished armtl team 0 at 7.75 min
  7.96  [Playtest] finished armtide team 0 at 7.96 min
  7.99  [Playtest] finished armtide team 0 at 7.99 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +24.8 bank 999/1550, energy +311.0 bank 1894/1900, units 42
  8.02  [Playtest] finished armfrad team 0 at 8.02 min
  8.28  [Playtest] finished armtide team 0 at 8.28 min
  8.44  [Playtest] finished armtide team 0 at 8.44 min
  8.48  [Playtest] finished armmex team 0 at 8.48 min
  8.60  [Playtest] finished armllt team 0 at 8.60 min
  8.60  [Playtest] finished armtide team 0 at 8.60 min
  8.74  [Playtest] finished armmex team 0 at 8.74 min
  8.76  [Playtest] finished armtide team 0 at 8.76 min
  8.93  [Playtest] finished armtide team 0 at 8.93 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +27.3 bank 1054/1650, energy +449.0 bank 2136/2150, units 52
  9.08  [Playtest] finished armtide team 0 at 9.08 min
  9.08  [Playtest] finished armmex team 0 at 9.08 min
  9.22  [Playtest] finished armmex team 0 at 9.22 min
  9.36  [Playtest] finished armtide team 0 at 9.36 min
  9.40  [Playtest] finished armtide team 0 at 9.40 min
  9.69  [Playtest] finished armmex team 0 at 9.69 min
  9.74  [Playtest] finished armtide team 0 at 9.74 min
  9.74  [Playtest] finished armtl team 0 at 9.74 min
  9.76  [Playtest] finished armtide team 0 at 9.76 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +34.2 bank 1426/1800, energy +571.0 bank 2436/2450, units 63
 10.00  [Playtest] camera requested (2800,2900) height=2200
 10.01  [Playtest] finished armtl team 0 at 10.01 min
 10.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (2800, 2900)
 10.04  [Playtest] finished armtide team 0 at 10.04 min
 10.05  [Playtest] finished armtide team 0 at 10.05 min
 10.16  [Playtest] finished armtide team 0 at 10.16 min
 10.23  [Playtest] finished armllt team 0 at 10.23 min
 10.27  [Playtest] finished armmex team 0 at 10.27 min
 10.39  [Playtest] finished armtide team 0 at 10.39 min
 10.47  [Playtest] finished armtide team 0 at 10.47 min
 10.48  [Playtest] finished armtide team 0 at 10.48 min
 10.76  [Playtest] finished armtide team 0 at 10.76 min
 10.81  [Playtest] finished armtl team 0 at 10.81 min
 10.82  [Playtest] finished armtide team 0 at 10.82 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +36.2 bank 1630/1850, energy +755.0 bank 2846/2850, units 73
 11.03  [Playtest] finished armtide team 0 at 11.03 min
 11.26  [Playtest] finished armtide team 0 at 11.26 min
 11.30  [Playtest] finished armtide team 0 at 11.30 min
 11.35  [Playtest] finished armtide team 0 at 11.35 min
 11.41  [Playtest] finished armmex team 0 at 11.41 min
 11.55  [Playtest] finished armtide team 0 at 11.55 min
 11.58  [Playtest] finished armtide team 0 at 11.58 min
 11.68  [Playtest] finished armllt team 0 at 11.68 min
 11.71  [Playtest] finished armtide team 0 at 11.71 min
 11.79  [Playtest] finished armtide team 0 at 11.80 min
 11.89  [Playtest] finished armtide team 0 at 11.89 min
 11.94  [Playtest] finished armtide team 0 at 11.94 min
 11.95  [Playtest] finished armtl team 0 at 11.94 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +38.3 bank 1848/1900, energy +992.0 bank 3393/3400, units 84
 12.11  [Playtest] finished armtide team 0 at 12.11 min
 12.32  [Playtest] finished armtide team 0 at 12.32 min
 12.46  [Playtest] finished armnanotcplat team 0 at 12.46 min
 12.51  [Playtest] finished armtide team 0 at 12.51 min
 12.58  [Playtest] finished armtide team 0 at 12.58 min
 12.72  [Playtest] finished armtide team 0 at 12.72 min
 12.81  [Playtest] finished armtide team 0 at 12.81 min
 12.88  [Playtest] finished armrl team 0 at 12.88 min
 12.91  [Playtest] finished armtide team 0 at 12.91 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +38.3 bank 1878/1900, energy +1153.0 bank 3740/3750, units 94
 13.04  [Playtest] finished armtide team 0 at 13.04 min
 13.05  [Playtest] finished armrad team 0 at 13.05 min
 13.28  [Playtest] finished armtide team 0 at 13.28 min
 13.50  [Playtest] finished armtide team 0 at 13.50 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +38.3 bank 468/1900, energy +1222.0 bank 3867/3900, units 102
 14.12  [Playtest] finished armtl team 0 at 14.12 min
 14.16  [Playtest] finished armasy team 0 at 14.16 min
 14.27  [Playtest] finished armfmkr team 0 at 14.27 min
 14.43  [Playtest] finished armtl team 0 at 14.43 min
 14.44  [Playtest] finished armfmkr team 0 at 14.44 min
 14.75  [Playtest] finished armfmkr team 0 at 14.75 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +41.3 bank 68/2100, energy +1252.0 bank 4131/4250, units 110
 15.20  [Playtest] finished armfmkr team 0 at 15.19 min
 15.57  [Playtest] finished armfmkr team 0 at 15.57 min
 15.68  [Playtest] finished armfrad team 0 at 15.68 min
 15.89  [Playtest] finished armuwmme team 0 at 15.89 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +49.5 bank 29/2650, energy +1275.0 bank 4129/4350, units 114
 16.21  [Playtest] finished armfmkr team 0 at 16.21 min
 16.37  [Playtest] finished armnanotcplat team 0 at 16.37 min
 16.38  [Playtest] finished armfrad team 0 at 16.38 min
 16.76  [Playtest] finished armnanotcplat team 0 at 16.76 min
 16.88  [Playtest] finished armuwmme team 0 at 16.88 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +56.7 bank 132/3200, energy +1268.0 bank 4016/4300, units 113
 17.31  [Playtest] finished armfmkr team 0 at 17.31 min
 17.62  [Playtest] finished armfrad team 0 at 17.62 min
 17.67  [Playtest] finished armfmkr team 0 at 17.67 min
 17.77  [Playtest] finished armrl team 0 at 17.77 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +55.8 bank 83/3150, energy +1282.0 bank 3388/4400, units 119
 18.18  [Playtest] finished armnanotcplat team 0 at 18.17 min
 18.18  [Playtest] finished armuwmme team 0 at 18.18 min
 18.56  [Playtest] finished armfmkr team 0 at 18.56 min
 18.68  [Playtest] finished armmex team 0 at 18.68 min
 18.90  [Playtest] finished armnanotcplat team 0 at 18.90 min
 18.94  [Playtest] finished armfmkr team 0 at 18.94 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +65.9 bank 6/3750, energy +1282.0 bank 3632/4400, units 124
 19.20  [Playtest] finished armmex team 0 at 19.20 min
 19.29  [Playtest] finished armuwmme team 0 at 19.29 min
 19.99  [Playtest] finished armmex team 0 at 19.99 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +67.6 bank 10/4300, energy +1268.0 bank 3431/4300, units 121
 20.00  [Playtest] camera requested (2800,2900) height=2200
 20.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (2800, 2900)
 20.07  [Playtest] finished armuwfus team 0 at 20.07 min
 20.45  [Playtest] finished armuwmme team 0 at 20.45 min
 20.68  [Playtest] finished armatl team 0 at 20.68 min
 20.90  [Playtest] finished armfmkr team 0 at 20.90 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +80.6 bank 576/4850, energy +2482.0 bank 6553/6900, units 126
 21.56  [Playtest] finished armmship team 0 at 21.56 min
 21.85  [Playtest] finished armfmkr team 0 at 21.85 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +81.6 bank 56/4850, energy +2475.0 bank 6470/6850, units 129
 22.17  [Playtest] finished armllt team 0 at 22.17 min
 22.39  [Playtest] finished armfmkr team 0 at 22.39 min
 22.60  [Playtest] finished armfmkr team 0 at 22.60 min
 22.84  [Playtest] finished armmex team 0 at 22.84 min
 22.98  [Playtest] finished armuwmmm team 0 at 22.98 min
 22.98  [Playtest] finished armtl team 0 at 22.98 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +83.2 bank 58/4850, energy +2482.0 bank 6192/6900, units 138
 23.11  [Playtest] finished armfmkr team 0 at 23.11 min
 23.13  [Playtest] finished armmship team 0 at 23.13 min
 23.13  [Playtest] finished armfmkr team 0 at 23.13 min
 23.14  [Playtest] finished armtl team 0 at 23.14 min
 23.27  [Playtest] finished armfmkr team 0 at 23.27 min
 23.37  [Playtest] finished armfmkr team 0 at 23.37 min
 23.61  [Playtest] finished armmex team 0 at 23.61 min
 23.83  [Playtest] finished armfmkr team 0 at 23.83 min
 23.85  [Playtest] finished armtl team 0 at 23.85 min
 23.96  [Playtest] finished armfmkr team 0 at 23.96 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +91.9 bank 61/4900, energy +2468.0 bank 5729/6800, units 147
 24.34  [Playtest] finished armfmkr team 0 at 24.34 min
 24.71  [Playtest] finished armfmkr team 0 at 24.71 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +98.1 bank 55/4900, energy +2482.0 bank 5834/6900, units 152
 25.08  [Playtest] finished armfmkr team 0 at 25.08 min
 25.39  [Playtest] finished armtl team 0 at 25.39 min
 25.96  [Playtest] finished armuwfus team 0 at 25.96 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +83.8 bank 67/4800, energy +3682.0 bank 8958/9400, units 146
 26.54  [Playtest] finished armfmkr team 0 at 26.54 min
 26.64  [Playtest] finished armfmkr team 0 at 26.64 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +97.5 bank 407/4750, energy +3682.0 bank 8115/9400, units 152
 27.01  [Playtest] finished armfmkr team 0 at 27.01 min
 27.04  [Playtest] finished armfmkr team 0 at 27.04 min
 27.23  [Playtest] finished armmship team 0 at 27.23 min
 27.23  [Playtest] finished armtl team 0 at 27.23 min
 27.42  [Playtest] finished armfmkr team 0 at 27.42 min
 27.43  [Playtest] finished armnanotcplat team 0 at 27.43 min
 27.45  [Playtest] finished armmex team 0 at 27.45 min
 27.95  [Playtest] finished armuwmmm team 0 at 27.95 min
 27.97  [Playtest] finished armtl team 0 at 27.97 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +97.2 bank 53/4800, energy +3682.0 bank 7704/9400, units 156
 28.15  [Playtest] finished armfrad team 0 at 28.15 min
 28.40  [Playtest] finished armtl team 0 at 28.40 min
 28.51  [Playtest] finished armuwmme team 0 at 28.51 min
 28.94  [Playtest] finished armmship team 0 at 28.94 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +113.3 bank 113/5350, energy +3668.0 bank 8260/9350, units 159
 29.00  [Playtest] camera requested (2800,2900) height=2200
 29.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (2800, 2900)
 29.02  [Playtest] finished armtl team 0 at 29.02 min
 29.43  [Playtest] finished armmship team 0 at 29.43 min
 29.62  [Playtest] finished armfrad team 0 at 29.62 min
 29.96  [Playtest] finished armmship team 0 at 29.96 min
 29.98  [Playtest] finished armfmkr team 0 at 29.98 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +128.8 bank 229/4750, energy +3652.0 bank 8023/9250, units 153
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
