# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.1 min (frame 45152); wall 215 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:41:34
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-control\glacial\20261004T184134Z-fe039196\runs\20261004T184512Z-4797543a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:30.977590][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.1 min | `[t=00:00:46.503317][f=0002062] [SeaWatch] finished frame=2062 id=6887 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.1 min | `[t=00:00:50.566871][f=0003810] [SeaWatch] egress id=8887 yard=6887 seconds=5.1 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-control\glacial\20261004T184134Z-fe039196\runs\20261004T184512Z-4797543a\screen_2026-10-04_18-42-41-557.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-control\glacial\20261004T184134Z-fe039196\runs\20261004T184512Z-4797543a\screen_2026-10-04_18-43-05-475.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-control\glacial\20261004T184134Z-fe039196\runs\20261004T184512Z-4797543a\screen_2026-10-04_18-44-24-482.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.60  [Playtest] finished armtide team 0 at 0.60 min
  0.74  [Playtest] finished armtide team 0 at 0.74 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 803/1100, energy +76.0 bank 1088/1100, units 6
  1.15  [Playtest] finished armsy team 0 at 1.15 min
  1.61  [Playtest] finished armtide team 0 at 1.61 min
  1.74  [Playtest] finished armtide team 0 at 1.74 min
  1.85  [Playtest] finished armtide team 0 at 1.85 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 90/1200, energy +159.0 bank 568/1450, units 13
  2.04  [Playtest] finished armtide team 0 at 2.04 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 0/1200, energy +182.0 bank 1498/1500, units 16
  3.02  [Playtest] finished armtide team 0 at 3.02 min
  3.34  [Playtest] finished armmex team 0 at 3.34 min
  3.44  [Playtest] finished armtide team 0 at 3.44 min
  3.68  [Playtest] finished armmex team 0 at 3.68 min
  3.79  [Playtest] finished armtide team 0 at 3.79 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 41/1300, energy +251.0 bank 1648/1650, units 20
  4.28  [Playtest] finished armfmkr team 0 at 4.28 min
  4.50  [Playtest] finished armfmkr team 0 at 4.50 min
  4.53  [Playtest] finished armmex team 0 at 4.53 min
  4.75  [Playtest] finished armmex team 0 at 4.75 min
  4.79  [Playtest] finished armfmkr team 0 at 4.79 min
  4.97  [Playtest] finished armmex team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +18.0 bank 79/1450, energy +251.0 bank 1440/1650, units 28
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.09  [Playtest] finished armfmkr team 0 at 5.09 min
  5.17  [Playtest] finished armmex team 0 at 5.18 min
  5.37  [Playtest] finished armfmkr team 0 at 5.37 min
  5.69  [Playtest] finished armmex team 0 at 5.69 min
  5.77  [Playtest] finished armfmkr team 0 at 5.77 min
  5.92  [Playtest] finished armmex team 0 at 5.92 min
  5.98  [Playtest] finished armfmkr team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +23.9 bank 564/1600, energy +258.0 bank 1344/1700, units 36
  6.13  [Playtest] finished armmex team 0 at 6.13 min
  6.32  [Playtest] finished armmex team 0 at 6.32 min
  6.43  [Playtest] finished armtide team 0 at 6.43 min
  6.54  [Playtest] finished armllt team 0 at 6.54 min
  6.61  [Playtest] finished armtide team 0 at 6.61 min
  6.75  [Playtest] finished armtide team 0 at 6.75 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +30.0 bank 1149/1700, energy +334.0 bank 1525/1900, units 43
  7.12  [Playtest] finished armmex team 0 at 7.13 min
  7.24  [Playtest] finished armtide team 0 at 7.24 min
  7.37  [Playtest] finished armmex team 0 at 7.37 min
  7.48  [Playtest] finished armtide team 0 at 7.48 min
  7.61  [Playtest] finished armmex team 0 at 7.61 min
  7.69  [Playtest] finished armtide team 0 at 7.69 min
  7.76  [Playtest] finished armmex team 0 at 7.76 min
  7.84  [Playtest] finished armtide team 0 at 7.84 min
  7.97  [Playtest] finished armtide team 0 at 7.97 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +39.0 bank 1832/1900, energy +437.5 bank 1788/2150, units 53
  8.18  [Playtest] finished armtide team 0 at 8.18 min
  8.24  [Playtest] finished armmex team 0 at 8.24 min
  8.32  [Playtest] finished armtide team 0 at 8.32 min
  8.43  [Playtest] finished armtide team 0 at 8.43 min
  8.49  [Playtest] finished armmex team 0 at 8.49 min
  8.72  [Playtest] finished armmex team 0 at 8.72 min
  8.73  [Playtest] finished armtide team 0 at 8.73 min
  8.93  [Playtest] finished armmex team 0 at 8.93 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +46.8 bank 1998/2100, energy +548.0 bank 1901/2400, units 69
  9.06  [Playtest] finished armtide team 0 at 9.06 min
  9.11  [Playtest] finished armllt team 0 at 9.11 min
  9.26  [Playtest] finished armrad team 0 at 9.26 min
  9.28  [Playtest] finished armtl team 0 at 9.28 min
  9.41  [Playtest] finished armtide team 0 at 9.41 min
  9.53  [Playtest] finished armfmkr team 0 at 9.52 min
  9.69  [Playtest] finished armnanotcplat team 0 at 9.69 min
  9.73  [Playtest] finished armtide team 0 at 9.73 min
  9.73  [Playtest] finished armfmkr team 0 at 9.73 min
  9.90  [Playtest] finished armnanotcplat team 0 at 9.90 min
 10.00  [Playtest] finished armmstor team 0 at 10.00 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +46.1 bank 1538/5100, energy +624.0 bank 2163/2600, units 79
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.04  [Playtest] finished armtide team 0 at 10.04 min
 10.19  [Playtest] finished armtide team 0 at 10.19 min
 10.28  [Playtest] finished armestor team 0 at 10.28 min
 10.53  [Playtest] finished armtide team 0 at 10.52 min
 10.67  [Playtest] finished armllt team 0 at 10.67 min
 10.86  [Playtest] finished armtide team 0 at 10.86 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +48.2 bank 929/5100, energy +716.0 bank 6751/8800, units 89
 11.06  [Playtest] finished armmex team 0 at 11.06 min
 11.11  [Playtest] finished armmex team 0 at 11.11 min
 11.12  [Playtest] finished armmex team 0 at 11.12 min
 11.12  [Playtest] finished armtide team 0 at 11.12 min
 11.14  [Playtest] finished armmex team 0 at 11.14 min
 11.23  [Playtest] finished armmex team 0 at 11.23 min
 11.26  [Playtest] finished armrad team 0 at 11.26 min
 11.26  [Playtest] finished armtide team 0 at 11.26 min
 11.37  [Playtest] finished armfrad team 0 at 11.37 min
 11.44  [Playtest] finished armtl team 0 at 11.44 min
 11.58  [Playtest] finished armfrad team 0 at 11.58 min
 11.75  [Playtest] finished armmex team 0 at 11.75 min
 11.96  [Playtest] finished armllt team 0 at 11.96 min
 11.97  [Playtest] finished armtide team 0 at 11.97 min
 11.97  [Playtest] finished armtl team 0 at 11.97 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +61.1 bank 1576/5400, energy +785.0 bank 7062/8950, units 101
 12.03  [Playtest] finished armmex team 0 at 12.03 min
 12.06  [Playtest] finished armmex team 0 at 12.06 min
 12.10  [Playtest] finished armmex team 0 at 12.10 min
 12.30  [Playtest] finished armtide team 0 at 12.30 min
 12.39  [Playtest] finished armfrad team 0 at 12.39 min
 12.58  [Playtest] finished armmex team 0 at 12.58 min
 12.63  [Playtest] finished armmex team 0 at 12.63 min
 12.66  [Playtest] finished armmex team 0 at 12.66 min
 12.67  [Playtest] finished armmex team 0 at 12.67 min
 12.67  [Playtest] finished armtide team 0 at 12.67 min
 12.84  [Playtest] finished armmex team 0 at 12.84 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +74.8 bank 3488/5800, energy +831.0 bank 6850/9050, units 113
 13.02  [Playtest] finished armmex team 0 at 13.02 min
 13.03  [Playtest] finished armmex team 0 at 13.03 min
 13.16  [Playtest] finished armnanotcplat team 0 at 13.16 min
 13.17  [Playtest] finished armtl team 0 at 13.17 min
 13.31  [Playtest] finished armtl team 0 at 13.31 min
 13.58  [Playtest] finished armtide team 0 at 13.58 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +78.2 bank 5483/5900, energy +840.0 bank 6851/9000, units 114
 14.12  [Playtest] finished armnanotcplat team 0 at 14.12 min
 14.58  [Playtest] finished armtide team 0 at 14.58 min
 14.90  [Playtest] finished armtide team 0 at 14.90 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +79.2 bank 5016/5850, energy +879.0 bank 6888/9050, units 114
 15.22  [Playtest] finished armtide team 0 at 15.22 min
 15.54  [Playtest] finished armtide team 0 at 15.55 min
 15.80  [Playtest] finished armnanotcplat team 0 at 15.80 min
 15.88  [Playtest] finished armtide team 0 at 15.88 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +75.6 bank 4785/5750, energy +962.0 bank 6997/9300, units 120
 16.08  [Playtest] finished armtide team 0 at 16.08 min
 16.28  [Playtest] finished armtide team 0 at 16.28 min
 16.51  [Playtest] finished armtide team 0 at 16.51 min
 16.86  [Playtest] finished armasy team 0 at 16.86 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +68.0 bank 4145/5950, energy +1038.0 bank 6736/9700, units 125
 17.03  [Playtest] finished armtide team 0 at 17.03 min
 17.10  [Playtest] finished armnanotcplat team 0 at 17.10 min
 17.36  [Playtest] finished armtide team 0 at 17.36 min
 17.72  [Playtest] finished armtide team 0 at 17.72 min
 17.94  [Playtest] finished armnanotcplat team 0 at 17.94 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +68.0 bank 1353/5950, energy +1167.0 bank 7328/10150, units 134
 18.05  [Playtest] finished armtide team 0 at 18.05 min
 18.30  [Playtest] finished armnanotcplat team 0 at 18.30 min
 18.47  [Playtest] finished armnanotcplat team 0 at 18.47 min
 18.55  [Playtest] finished armtide team 0 at 18.55 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +77.0 bank 758/5950, energy +1213.0 bank 7896/10250, units 142
 19.07  [Playtest] finished armmex team 0 at 19.07 min
 19.11  [Playtest] finished armmex team 0 at 19.11 min
 19.22  [Playtest] finished armfrad team 0 at 19.22 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +78.5 bank 1771/6050, energy +1213.0 bank 6650/10250, units 150
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.05  [Playtest] finished armmex team 0 at 20.05 min
 20.09  [Playtest] finished armmex team 0 at 20.09 min
 20.41  [Playtest] finished armmex team 0 at 20.41 min
 20.68  [Playtest] finished armmex team 0 at 20.68 min
 20.72  [Playtest] finished armtl team 0 at 20.72 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +77.8 bank 2599/6100, energy +1213.0 bank 5593/10250, units 159
 21.01  [Playtest] finished armfrad team 0 at 21.01 min
 21.01  [Playtest] finished armmship team 0 at 21.01 min
 21.29  [Playtest] finished armnanotcplat team 0 at 21.29 min
 21.50  [Playtest] finished armmship team 0 at 21.50 min
 21.64  [Playtest] finished armmex team 0 at 21.64 min
 21.86  [Playtest] finished armatl team 0 at 21.86 min
 21.88  [Playtest] finished armnanotcplat team 0 at 21.88 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +83.0 bank 58/6100, energy +1206.0 bank 7888/10200, units 160
 22.00  [Playtest] finished armmex team 0 at 22.00 min
 22.05  [Playtest] finished coruwmme team 0 at 22.05 min
 22.10  [Playtest] finished armmship team 0 at 22.10 min
 22.54  [Playtest] finished armmship team 0 at 22.54 min
 22.95  [Playtest] finished armmship team 0 at 22.95 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +89.7 bank 63/6650, energy +1206.0 bank 8043/10200, units 162
 23.01  [Playtest] finished armnanotcplat team 0 at 23.01 min
 23.03  [Playtest] finished armnanotcplat team 0 at 23.03 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +113.7 bank 67/6650, energy +1506.0 bank 8745/11700, units 164
 24.47  [Playtest] finished armnanotcplat team 0 at 24.47 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +86.5 bank 4/6650, energy +1506.0 bank 8996/11700, units 155
```

## Native lines (all AIs, first 120)

```
  0.28  RESERVE: zone 1 at (1016, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4136) facing 1 (id 1)
  0.28  RESERVE: zone 2 at (1016, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4088) facing 1 (id 2)
  0.28  RESERVE: zone 3 at (1016, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4040) facing 1 (id 3)
  0.28  RESERVE: zone 4 at (1064, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4136) facing 1 (id 4)
  0.28  RESERVE: zone 5 at (1064, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4088) facing 1 (id 5)
  0.28  RESERVE: zone 6 at (1064, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4040) facing 1 (id 6)
  0.28  RESERVE: served armtide at (1016, 4136) facing 1 (id 1, 5 of this def still held)
  0.28  RESERVE: zone 1 at (296, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4728) facing 1 (id 1)
  0.28  RESERVE: zone 2 at (296, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4680) facing 1 (id 2)
  0.28  RESERVE: zone 3 at (296, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4632) facing 1 (id 3)
  0.28  RESERVE: zone 4 at (344, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4728) facing 1 (id 4)
  0.28  RESERVE: zone 5 at (344, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4680) facing 1 (id 5)
  0.28  RESERVE: zone 6 at (344, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4632) facing 1 (id 6)
  0.28  RESERVE: served armtide at (296, 4728) facing 1 (id 1, 5 of this def still held)
  0.41  RESERVE: zone 1 at (14040, 4632) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14040, 4632) facing 3 (id 1)
  0.41  RESERVE: zone 2 at (14040, 4680) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14040, 4680) facing 3 (id 2)
  0.41  RESERVE: zone 3 at (14040, 4728) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14040, 4728) facing 3 (id 3)
  0.41  RESERVE: zone 4 at (13992, 4632) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (13992, 4632) facing 3 (id 4)
  0.41  RESERVE: zone 5 at (13992, 4680) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (13992, 4680) facing 3 (id 5)
  0.41  RESERVE: zone 6 at (13992, 4728) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (13992, 4728) facing 3 (id 6)
  0.41  RESERVE: served armtide at (14040, 4632) facing 3 (id 1, 5 of this def still held)
  0.48  RESERVE: zone 1 at (13256, 4040) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13256, 4040) facing 3 (id 1)
  0.48  RESERVE: zone 2 at (13256, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13256, 4088) facing 3 (id 2)
  0.48  RESERVE: zone 3 at (13256, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13256, 4136) facing 3 (id 3)
  0.48  RESERVE: zone 4 at (13208, 4040) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13208, 4040) facing 3 (id 4)
  0.48  RESERVE: zone 5 at (13208, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13208, 4088) facing 3 (id 5)
  0.48  RESERVE: zone 6 at (13208, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13208, 4136) facing 3 (id 6)
  0.48  RESERVE: served legtide at (13256, 4040) facing 3 (id 1, 5 of this def still held)
  0.61  RESERVE: served armtide at (296, 4680) facing 1 (id 2, 4 of this def still held)
  0.61  RESERVE: served armtide at (1016, 4088) facing 1 (id 2, 4 of this def still held)
  0.70  RESERVE: served armtide at (14040, 4680) facing 3 (id 2, 4 of this def still held)
  0.76  RESERVE: served legtide at (13256, 4088) facing 3 (id 2, 4 of this def still held)
  1.05  RESERVE: zone 7 at (248, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (248, 5048) facing 1 (id 7)
  1.05  RESERVE: zone 8 at (248, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (248, 5000) facing 1 (id 8)
  1.05  RESERVE: zone 9 at (248, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (248, 4952) facing 1 (id 9)
  1.05  RESERVE: zone 10 at (248, 4904) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (248, 4904) facing 1 (id 10)
  1.05  RESERVE: zone 11 at (248, 4856) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (248, 4856) facing 1 (id 11)
  1.05  RESERVE: zone 12 at (296, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (296, 5048) facing 1 (id 12)
  1.05  RESERVE: zone 13 at (296, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (296, 5000) facing 1 (id 13)
  1.05  RESERVE: zone 14 at (296, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (296, 4952) facing 1 (id 14)
  1.05  RESERVE: zone 15 at (296, 4904) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (296, 4904) facing 1 (id 15)
  1.05  RESERVE: zone 16 at (296, 4856) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (296, 4856) facing 1 (id 16)
  1.05  RESERVE: zone 17 at (344, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (344, 5048) facing 1 (id 17)
  1.05  RESERVE: zone 18 at (344, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (344, 5000) facing 1 (id 18)
  1.05  RESERVE: zone 19 at (344, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (344, 4952) facing 1 (id 19)
  1.05  RESERVE: zone 20 at (344, 4904) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (344, 4904) facing 1 (id 20)
  1.05  RESERVE: zone 21 at (344, 4856) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (344, 4856) facing 1 (id 21)
  1.05  RESERVE: zone 22 at (392, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (392, 5048) facing 1 (id 22)
  1.05  RESERVE: zone 23 at (392, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (392, 5000) facing 1 (id 23)
  1.05  RESERVE: zone 24 at (392, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.05  RESERVE: armnanotcplat at (392, 4952) facing 1 (id 24)
  1.05  RESERVE: zone 7 released
  1.05  RESERVE: zone 8 released
  1.05  RESERVE: zone 9 released
  1.05  RESERVE: zone 10 released
  1.05  RESERVE: zone 11 released
  1.05  RESERVE: zone 12 released
  1.05  RESERVE: zone 13 released
  1.05  RESERVE: zone 14 released
  1.05  RESERVE: zone 15 released
  1.05  RESERVE: zone 16 released
  1.05  RESERVE: zone 17 released
  1.05  RESERVE: zone 18 released
  1.05  RESERVE: zone 19 released
  1.05  RESERVE: zone 20 released
  1.05  RESERVE: zone 21 released
  1.05  RESERVE: zone 22 released
  1.05  RESERVE: zone 23 released
  1.05  RESERVE: zone 24 released
  1.05  RESERVE: corridor 25 at (752, 4768) facing 1, 30x12 cells: 88 of 360 held
  1.05  RESERVE: zone refused at (-320, 4768): off map
  1.05  RESERVE: zone refused at (-320, 4640): off map
  1.05  RESERVE: zone refused at (-320, 4896): off map
  1.05  RESERVE: zone refused at (-320, 4512): off map
  1.05  RESERVE: zone refused at (-320, 5024): off map
  1.05  RESERVE: zone refused at (-320, 4384): off map
  1.05  RESERVE: zone refused at (-320, 5152): off map
  1.05  RESERVE: zone refused at (-320, 4256): off map
  1.07  RESERVE: zone 26 at (88, 4680) facing 1, 3x3 cells: 9 of 9 held
```
