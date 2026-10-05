# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54101); wall 196 s
- DLL: build-theatres\d189-build-4\SkirmishAI.dll (a4b0a14236636cba); AI BARbTest/test; staged 2026-10-04T07:03:22
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-3\glacial\20261004T100321Z-c0c297b1\runs\20261004T100640Z-57f13084\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:30.002684][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:43.493968][f=0001389] [SeaWatch] finished frame=1389 id=11890 def=armsy builder=27370` |
| expect `first-ship-exit` | seen at 3.0 min | `[t=00:00:52.205960][f=0005310] [SeaWatch] egress id=30384 yard=11890 seconds=5.1 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-3\glacial\20261004T100321Z-c0c297b1\runs\20261004T100640Z-57f13084\screen_2026-10-04_10-04-26-703.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-3\glacial\20261004T100321Z-c0c297b1\runs\20261004T100640Z-57f13084\screen_2026-10-04_10-04-47-693.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-3\glacial\20261004T100321Z-c0c297b1\runs\20261004T100640Z-57f13084\screen_2026-10-04_10-05-35-589.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-3\glacial\20261004T100321Z-c0c297b1\runs\20261004T100640Z-57f13084\screen_2026-10-04_10-06-31-624.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1424,3600 facing=1
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 23145 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.77  [Playtest] finished armsy team 0 at 0.77 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 707/1200, energy +30.0 bank 0/1100, units 6
  1.14  [Playtest] finished armmex team 0 at 1.14 min
  1.56  [Playtest] finished armtide team 0 at 1.56 min
  1.84  [Playtest] finished armtide team 0 at 1.84 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 828/1250, energy +76.0 bank 118/1200, units 8
  2.20  [Playtest] finished armtide team 0 at 2.20 min
  2.43  [Playtest] finished armtide team 0 at 2.43 min
  2.57  [Playtest] finished armtide team 0 at 2.57 min
  2.82  [Playtest] finished armtide team 0 at 2.82 min
  2.88  [Playtest] finished armmex team 0 at 2.88 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 404/1300, energy +182.0 bank 1462/1500, units 16
  3.80  [Playtest] finished armmex team 0 at 3.80 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 76/1350, energy +182.0 bank 1261/1500, units 20
  4.03  [Playtest] finished armllt team 0 at 4.03 min
  4.15  [Playtest] finished armtide team 0 at 4.15 min
  4.25  [Playtest] finished armrad team 0 at 4.25 min
  4.63  [Playtest] finished armtide team 0 at 4.63 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 13/1350, energy +228.0 bank 1586/1600, units 24
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.15  [Playtest] finished armtide team 0 at 5.15 min
  5.62  [Playtest] finished armfmkr team 0 at 5.62 min
  5.84  [Playtest] finished armtide team 0 at 5.84 min
  5.95  [Playtest] finished armmex team 0 at 5.95 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +15.0 bank 159/1400, energy +274.0 bank 1650/1700, units 30
  6.01  [Playtest] finished armfmkr team 0 at 6.01 min
  6.12  [Playtest] finished armmex team 0 at 6.12 min
  6.14  [Playtest] finished armtide team 0 at 6.14 min
  6.45  [Playtest] finished armtide team 0 at 6.45 min
  6.69  [Playtest] finished armmex team 0 at 6.69 min
  6.97  [Playtest] finished armfmkr team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +20.5 bank 333/1500, energy +320.0 bank 1696/1800, units 34
  7.19  [Playtest] finished armmex team 0 at 7.19 min
  7.43  [Playtest] finished armllt team 0 at 7.43 min
  7.64  [Playtest] finished armtide team 0 at 7.64 min
  7.95  [Playtest] finished armtide team 0 at 7.95 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +23.0 bank 716/1550, energy +366.0 bank 1817/1900, units 40
  8.26  [Playtest] finished armtide team 0 at 8.26 min
  8.58  [Playtest] finished armtide team 0 at 8.58 min
  8.66  [Playtest] finished armfmkr team 0 at 8.66 min
  8.90  [Playtest] finished armtide team 0 at 8.90 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +24.0 bank 1161/1550, energy +435.0 bank 1786/2050, units 43
  9.32  [Playtest] finished armtide team 0 at 9.32 min
  9.73  [Playtest] finished armtide team 0 at 9.73 min
  9.82  [Playtest] finished armnanotcplat team 0 at 9.82 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +24.0 bank 1170/1550, energy +488.0 bank 1903/2200, units 50
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.03  [Playtest] finished armtide team 0 at 10.03 min
 10.30  [Playtest] finished armtide team 0 at 10.30 min
 10.34  [Playtest] finished armfmkr team 0 at 10.34 min
 10.34  [Playtest] finished armtide team 0 at 10.34 min
 10.64  [Playtest] finished armtide team 0 at 10.64 min
 10.72  [Playtest] finished armfmkr team 0 at 10.72 min
 10.76  [Playtest] finished armtide team 0 at 10.76 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +26.0 bank 477/1550, energy +603.0 bank 2129/2450, units 54
 11.06  [Playtest] finished armtide team 0 at 11.06 min
 11.07  [Playtest] finished armtide team 0 at 11.07 min
 11.28  [Playtest] finished armtide team 0 at 11.28 min
 11.42  [Playtest] finished armtide team 0 at 11.42 min
 11.72  [Playtest] finished armtide team 0 at 11.73 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +26.0 bank 615/1550, energy +725.0 bank 2645/2750, units 60
 12.11  [Playtest] finished armtide team 0 at 12.11 min
 12.48  [Playtest] finished armfmkr team 0 at 12.48 min
 12.85  [Playtest] finished armtl team 0 at 12.85 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +27.0 bank 637/1550, energy +741.0 bank 2463/2750, units 60
 13.81  [Playtest] finished armfmkr team 0 at 13.81 min
 13.82  [Playtest] finished armtl team 0 at 13.82 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +28.0 bank 1546/1550, energy +737.5 bank 2606/2700, units 58
 14.50  [Playtest] finished armtide team 0 at 14.50 min
 14.67  [Playtest] finished armfmkr team 0 at 14.67 min
 14.82  [Playtest] finished armtide team 0 at 14.82 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +29.0 bank 1546/1550, energy +773.0 bank 2424/2750, units 60
 16.00  [Playtest] eco team 0 at 16.0 min: metal +21.5 bank 1229/1550, energy +734.0 bank 2357/2700, units 56
 16.13  [Playtest] finished armnanotcplat team 0 at 16.13 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +25.3 bank 1251/1550, energy +748.0 bank 2275/2800, units 61
 17.19  [Playtest] finished armtide team 0 at 17.19 min
 17.36  [Playtest] finished armfmkr team 0 at 17.36 min
 17.64  [Playtest] finished armfmkr team 0 at 17.64 min
 17.73  [Playtest] finished armfmkr team 0 at 17.73 min
 17.98  [Playtest] finished coruwmme team 0 at 17.98 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +78.5 bank 1016/2100, energy +775.5 bank 2350/2800, units 61
 19.00  [Playtest] eco team 0 at 19.0 min: metal +26.0 bank 970/2100, energy +596.0 bank 521/2400, units 50
 19.02  [Playtest] finished armtide team 0 at 19.02 min
 19.34  [Playtest] finished armtide team 0 at 19.34 min
 19.46  [Playtest] finished armtide team 0 at 19.46 min
 19.68  [Playtest] finished armtide team 0 at 19.68 min
 19.97  [Playtest] finished armtide team 0 at 19.97 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +26.0 bank 1729/2100, energy +711.0 bank 413/2650, units 57
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.00  [Playtest] finished armtide team 0 at 20.00 min
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.31  [Playtest] finished armtide team 0 at 20.31 min
 20.63  [Playtest] finished armtide team 0 at 20.63 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +30.5 bank 1599/2100, energy +741.0 bank 2334/2750, units 59
 21.16  [Playtest] finished armtide team 0 at 21.17 min
 21.17  [Playtest] finished armtide team 0 at 21.17 min
 21.23  [Playtest] finished armtide team 0 at 21.23 min
 21.38  [Playtest] finished armtide team 0 at 21.38 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +30.2 bank 1771/2100, energy +493.5 bank 1811/2100, units 44
 22.67  [SEA][Layout] berth sea.berth.3 corsy at=2224,3664 facing=1
 23.00  [Playtest] eco team 0 at 23.0 min: metal +22.0 bank 1192/1550, energy +481.0 bank 1741/1750, units 37
 23.22  [SEA][Layout] berth sea.berth.4 corsy at=2048,4256 facing=2
 23.38  [Playtest] finished armnanotcplat team 0 at 23.38 min
 23.73  [SEA][Layout] replan unused berth sea.berth.0
 23.93  [Playtest] finished armuwmme team 0 at 23.93 min
 23.98  [SEA][Layout] berth sea.berth.0 armsy at=1568,3856 facing=1
 24.00  [Playtest] eco team 0 at 24.0 min: metal +29.8 bank 1354/2000, energy +467.0 bank 1540/1550, units 33
 24.42  [SEA][Layout] berth sea.berth.5 armsy at=1680,4624 facing=1
 25.00  [Playtest] eco team 0 at 25.0 min: metal +28.0 bank 1612/2000, energy +467.0 bank 1537/1550, units 33
 25.33  [Playtest] finished armsy team 0 at 25.33 min
 25.96  [Playtest] finished armtl team 0 at 25.96 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +28.0 bank 2086/2100, energy +474.0 bank 1659/1700, units 38
 26.67  [Playtest] finished armnanotcplat team 0 at 26.67 min
 26.72  [Playtest] finished armnanotcplat team 0 at 26.72 min
 26.82  [Playtest] finished armmex team 0 at 26.82 min
 26.99  [Playtest] finished armtide team 0 at 26.99 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +30.0 bank 2148/2150, energy +477.5 bank 1794/1800, units 43
 27.10  [Playtest] finished armtl team 0 at 27.10 min
 27.17  [Playtest] finished armtide team 0 at 27.17 min
 27.35  [Playtest] finished armtide team 0 at 27.35 min
 27.48  [Playtest] finished armtide team 0 at 27.48 min
 27.56  [Playtest] finished armtide team 0 at 27.56 min
 27.64  [Playtest] finished armtide team 0 at 27.64 min
 27.68  [Playtest] finished armuwmme team 0 at 27.68 min
 27.74  [Playtest] finished armfrad team 0 at 27.74 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +36.0 bank 1982/2700, energy +626.0 bank 2074/2100, units 53
 28.07  [Playtest] finished armtide team 0 at 28.07 min
 28.10  [Playtest] finished armtide team 0 at 28.10 min
 28.29  [Playtest] finished armfmkr team 0 at 28.29 min
 28.37  [Playtest] finished armtide team 0 at 28.37 min
 28.39  [Playtest] finished armtide team 0 at 28.39 min
 28.42  [Playtest] finished armtide team 0 at 28.42 min
 28.58  [Playtest] finished armtide team 0 at 28.58 min
 28.70  [Playtest] finished armtide team 0 at 28.70 min
 28.74  [Playtest] finished armtide team 0 at 28.74 min
 28.76  [Playtest] finished armfmkr team 0 at 28.76 min
 28.93  [Playtest] finished armtide team 0 at 28.93 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +38.0 bank 1568/2700, energy +840.0 bank 2591/2600, units 65
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.13  [Playtest] finished armfmkr team 0 at 29.13 min
 29.30  [Playtest] finished armtide team 0 at 29.30 min
 29.36  [Playtest] finished armfmkr team 0 at 29.36 min
 29.42  [Playtest] finished armtide team 0 at 29.42 min
 29.64  [Playtest] finished armtide team 0 at 29.64 min
 29.74  [Playtest] finished armtide team 0 at 29.74 min
 29.85  [Playtest] finished armtide team 0 at 29.85 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +40.0 bank 676/2700, energy +817.0 bank 2385/2550, units 65
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(12973) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4072) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4008) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 3944) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1272, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4072) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1272, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4008) facing 1 (id 6)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (1304, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4072) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1304, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4008) facing 1 (id 8)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 at (1288, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4104) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1288, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4040) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 3976) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1352, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1352, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4040) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1352, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3976) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1321, 4037) facing 1, 9x13 cells: 54 of 117 held
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4664) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4600) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4536) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 5)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (584, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4664) facing 1 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (568, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (568, 4696) facing 1 (id 7)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 at (552, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4728) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 9)
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (520, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4744) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (520, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4680) facing 1 (id 11)
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4760) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (488, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4696) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (488, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4632) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (552, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4760) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (552, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4696) facing 1 (id 16)
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 at (440, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4744) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (440, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4680) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4616) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (504, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4744) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (504, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4680) facing 1 (id 21)
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 at (408, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4728) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (408, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4664) facing 1 (id 23)
  0.10  RESERVE: zone 25 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4600) facing 1 (id 24)
  0.10  RESERVE: zone 26 at (472, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4728) facing 1 (id 25)
  0.10  RESERVE: zone 27 at (472, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4664) facing 1 (id 26)
  0.10  RESERVE: zone 28 at (472, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4600) facing 1 (id 27)
  0.10  RESERVE: zone 29 at (444, 4660) facing 1, 9x13 cells: 63 of 117 held
  0.10  RESERVE: zone 1 at (12928, 4000) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (12928, 4000) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (12640, 4000) facing 3, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (13160, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13160, 3944) facing 3 (id 2)
  0.10  RESERVE: zone 4 at (13160, 4008) facing 3, 3x3 cells: 9 of 9 held
```
