# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36031); wall 171 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:08:14
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\glacial\20261004T170814Z-a1b43f28\runs\20261004T171109Z-59f8c98c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.823931][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.2 min | `[t=00:00:52.054452][f=0002077] [SeaWatch] finished frame=2077 id=6887 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 4.2 min | `[t=00:01:04.787977][f=0007530] [SeaWatch] egress id=4199 yard=6887 seconds=30.3 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\glacial\20261004T170814Z-a1b43f28\runs\20261004T171109Z-59f8c98c\screen_2026-10-04_17-09-27-813.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\glacial\20261004T170814Z-a1b43f28\runs\20261004T171109Z-59f8c98c\screen_2026-10-04_17-09-56-784.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\glacial\20261004T170814Z-a1b43f28\runs\20261004T171109Z-59f8c98c\screen_2026-10-04_17-11-08-743.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 20.5 min
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 816/1100, energy +76.0 bank 1088/1100, units 6
  1.15  [Playtest] finished armsy team 0 at 1.15 min
  1.28  [Playtest] finished armmex team 0 at 1.28 min
  1.93  [Playtest] finished armtide team 0 at 1.93 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 452/1250, energy +106.0 bank 156/1350, units 11
  2.18  [Playtest] finished armtide team 0 at 2.18 min
  2.30  [Playtest] finished armtide team 0 at 2.30 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 3/1250, energy +159.0 bank 1450/1450, units 15
  3.28  [Playtest] finished armmex team 0 at 3.28 min
  3.35  [Playtest] finished armtide team 0 at 3.35 min
  3.58  [Playtest] finished armtide team 0 at 3.58 min
  3.85  [Playtest] finished armtide team 0 at 3.86 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 13/1300, energy +228.0 bank 1599/1600, units 19
  4.12  [Playtest] finished armmex team 0 at 4.13 min
  4.18  [Playtest] finished armtide team 0 at 4.18 min
  4.35  [Playtest] finished armmex team 0 at 4.35 min
  4.47  [Playtest] finished armtide team 0 at 4.47 min
  4.72  [Playtest] finished armmex team 0 at 4.72 min
  4.94  [Playtest] finished armmex team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +18.0 bank 35/1500, energy +274.0 bank 1674/1700, units 26
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.18  [Playtest] finished armfmkr team 0 at 5.18 min
  5.48  [Playtest] finished armmex team 0 at 5.48 min
  5.49  [Playtest] finished armfmkr team 0 at 5.49 min
  5.72  [Playtest] finished armmex team 0 at 5.72 min
  5.79  [Playtest] finished armfmkr team 0 at 5.79 min
  5.94  [Playtest] finished armmex team 0 at 5.94 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.6 bank 546/1650, energy +281.0 bank 1409/1750, units 33
  6.09  [Playtest] finished armfmkr team 0 at 6.09 min
  6.13  [Playtest] finished armmex team 0 at 6.13 min
  6.31  [Playtest] finished armllt team 0 at 6.31 min
  6.44  [Playtest] finished armtide team 0 at 6.44 min
  6.57  [Playtest] finished armtide team 0 at 6.57 min
  6.86  [Playtest] finished armtide team 0 at 6.86 min
  6.89  [Playtest] finished armmex team 0 at 6.89 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +32.0 bank 1199/1750, energy +364.0 bank 1649/2000, units 42
  7.01  [Playtest] finished armtide team 0 at 7.01 min
  7.11  [Playtest] finished armtide team 0 at 7.11 min
  7.14  [Playtest] finished armmex team 0 at 7.14 min
  7.38  [Playtest] finished armmex team 0 at 7.38 min
  7.38  [Playtest] finished armfmkr team 0 at 7.38 min
  7.54  [Playtest] finished armfmkr team 0 at 7.54 min
  7.54  [Playtest] finished armmex team 0 at 7.54 min
  7.75  [Playtest] finished armtide team 0 at 7.75 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +38.2 bank 1761/1900, energy +433.0 bank 1709/2150, units 52
  8.03  [Playtest] finished armmex team 0 at 8.03 min
  8.12  [Playtest] finished armtide team 0 at 8.12 min
  8.28  [Playtest] finished armmex team 0 at 8.27 min
  8.47  [Playtest] finished armllt team 0 at 8.47 min
  8.49  [Playtest] finished armtide team 0 at 8.49 min
  8.72  [Playtest] finished armmex team 0 at 8.73 min
  8.91  [Playtest] finished armtide team 0 at 8.91 min
  8.93  [Playtest] finished armmex team 0 at 8.93 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +48.0 bank 1890/2100, energy +502.0 bank 1985/2300, units 59
  9.62  [Playtest] finished armtl team 0 at 9.62 min
  9.63  [Playtest] finished armfmkr team 0 at 9.63 min
  9.66  [Playtest] finished armmstor team 0 at 9.66 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +45.2 bank 2376/5100, energy +502.0 bank 1807/2300, units 69
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.02  [Playtest] finished armestor team 0 at 10.02 min
 10.02  [Playtest] finished armfmkr team 0 at 10.02 min
 10.20  [Playtest] finished armtide team 0 at 10.20 min
 10.37  [Playtest] finished armtide team 0 at 10.37 min
 10.50  [Playtest] finished armtl team 0 at 10.50 min
 10.70  [Playtest] finished armtide team 0 at 10.70 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +64.3 bank 4122/5100, energy +578.0 bank 6920/8500, units 72
 11.04  [Playtest] finished armtide team 0 at 11.04 min
 11.13  [Playtest] finished armtide team 0 at 11.13 min
 11.69  [Playtest] finished armmex team 0 at 11.69 min
 11.72  [Playtest] finished armmex team 0 at 11.73 min
 11.77  [Playtest] finished armllt team 0 at 11.77 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +53.4 bank 4913/5200, energy +624.0 bank 6687/8600, units 81
 12.01  [Playtest] finished armfrad team 0 at 12.01 min
 12.01  [Playtest] finished armfrad team 0 at 12.01 min
 12.19  [Playtest] finished armtide team 0 at 12.19 min
 12.21  [Playtest] finished armtl team 0 at 12.22 min
 12.38  [Playtest] finished armmex team 0 at 12.38 min
 12.41  [Playtest] finished armmex team 0 at 12.41 min
 12.54  [Playtest] finished armtide team 0 at 12.54 min
 12.72  [Playtest] finished armmex team 0 at 12.72 min
 12.79  [Playtest] finished armmex team 0 at 12.79 min
 12.87  [Playtest] finished armmex team 0 at 12.87 min
 12.88  [Playtest] finished armtide team 0 at 12.88 min
 12.95  [Playtest] finished armmex team 0 at 12.95 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +63.3 bank 4782/5500, energy +693.0 bank 6768/8750, units 93
 13.06  [Playtest] finished armmex team 0 at 13.06 min
 13.08  [Playtest] finished armtl team 0 at 13.08 min
 13.21  [Playtest] finished armtide team 0 at 13.21 min
 13.35  [Playtest] finished armfrad team 0 at 13.35 min
 13.44  [Playtest] finished armmex team 0 at 13.44 min
 13.55  [Playtest] finished armtide team 0 at 13.55 min
 13.60  [Playtest] finished armmex team 0 at 13.60 min
 13.69  [Playtest] finished armmex team 0 at 13.69 min
 13.73  [Playtest] finished armmex team 0 at 13.73 min
 13.77  [Playtest] finished armfrad team 0 at 13.77 min
 13.78  [Playtest] finished armmex team 0 at 13.78 min
 13.83  [Playtest] finished armmex team 0 at 13.83 min
 13.85  [Playtest] finished armtide team 0 at 13.85 min
 13.98  [Playtest] finished armmex team 0 at 13.98 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +80.0 bank 5258/5900, energy +762.0 bank 7275/8900, units 111
 14.14  [Playtest] finished armtl team 0 at 14.14 min
 14.16  [Playtest] finished armtl team 0 at 14.16 min
 14.40  [Playtest] finished armtide team 0 at 14.40 min
 14.74  [Playtest] finished armtide team 0 at 14.74 min
 14.74  [Playtest] finished armmex team 0 at 14.74 min
 14.83  [Playtest] finished armtide team 0 at 14.83 min
 14.96  [Playtest] finished armtide team 0 at 14.96 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +84.0 bank 5061/5950, energy +854.0 bank 7425/9100, units 114
 15.09  [Playtest] finished armmex team 0 at 15.09 min
 15.09  [Playtest] finished armtide team 0 at 15.09 min
 15.22  [Playtest] finished armtide team 0 at 15.22 min
 15.28  [Playtest] finished armtl team 0 at 15.28 min
 15.38  [Playtest] finished armtide team 0 at 15.38 min
 15.53  [Playtest] finished armtide team 0 at 15.53 min
 15.57  [Playtest] finished armasy team 0 at 15.57 min
 15.61  [Playtest] finished armfrad team 0 at 15.61 min
 15.62  [Playtest] finished armmex team 0 at 15.62 min
 15.88  [Playtest] finished armtide team 0 at 15.88 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +83.1 bank 5279/6250, energy +969.0 bank 7338/9550, units 123
 16.25  [Playtest] finished armtide team 0 at 16.25 min
 16.44  [Playtest] finished armnanotcplat team 0 at 16.44 min
 16.55  [Playtest] finished armnanotcplat team 0 at 16.55 min
 16.62  [Playtest] finished armtide team 0 at 16.62 min
 16.64  [Playtest] finished armnanotcplat team 0 at 16.64 min
 16.71  [Playtest] finished armfmkr team 0 at 16.71 min
 16.82  [Playtest] finished armfmkr team 0 at 16.82 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +80.0 bank 5098/6250, energy +1075.0 bank 6821/9950, units 133
 17.13  [Playtest] finished armtide team 0 at 17.13 min
 17.30  [Playtest] finished armfmkr team 0 at 17.30 min
 17.40  [Playtest] finished armmex team 0 at 17.40 min
 17.59  [Playtest] finished armmex team 0 at 17.59 min
 17.62  [Playtest] finished armmex team 0 at 17.63 min
 17.66  [Playtest] finished armnanotcplat team 0 at 17.66 min
 17.75  [Playtest] finished armtl team 0 at 17.75 min
 17.90  [Playtest] finished armtide team 0 at 17.90 min
 17.91  [Playtest] finished armfrad team 0 at 17.91 min
 17.93  [Playtest] finished armmex team 0 at 17.93 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +88.0 bank 5154/6450, energy +1121.0 bank 6460/10050, units 147
 18.05  [Playtest] finished armtide team 0 at 18.05 min
 18.17  [Playtest] finished armtide team 0 at 18.17 min
 18.33  [Playtest] finished armtide team 0 at 18.33 min
 18.46  [Playtest] finished armmex team 0 at 18.46 min
 18.47  [Playtest] finished armtide team 0 at 18.47 min
 18.50  [Playtest] finished armmex team 0 at 18.50 min
 18.76  [Playtest] finished armmex team 0 at 18.76 min
 18.76  [Playtest] finished armmship team 0 at 18.76 min
 18.81  [Playtest] finished coruwmme team 0 at 18.81 min
 18.86  [Playtest] finished armnanotcplat team 0 at 18.86 min
 18.86  [Playtest] finished armmex team 0 at 18.86 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +102.1 bank 3317/7200, energy +1213.0 bank 7559/10250, units 161
 19.01  [Playtest] finished armmship team 0 at 19.01 min
 19.20  [Playtest] finished armtl team 0 at 19.20 min
 19.22  [Playtest] finished armmex team 0 at 19.22 min
 19.23  [Playtest] finished armmship team 0 at 19.23 min
 19.33  [Playtest] finished armnanotcplat team 0 at 19.33 min
 19.47  [Playtest] finished armmship team 0 at 19.47 min
 19.54  [Playtest] finished armmex team 0 at 19.54 min
 19.65  [Playtest] finished armnanotcplat team 0 at 19.65 min
 19.68  [Playtest] finished armmship team 0 at 19.68 min
 19.89  [Playtest] finished armnanotcplat team 0 at 19.89 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +161.4 bank 2344/7300, energy +1513.0 bank 9494/11750, units 169
 20.00  [Playtest] camera requested (1700,4550) height=3800
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
  0.47  RESERVE: zone 1 at (13256, 4040) facing 3, 3x3 cells: 9 of 9 held
  0.47  RESERVE: legtide at (13256, 4040) facing 3 (id 1)
  0.47  RESERVE: zone 2 at (13256, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.47  RESERVE: legtide at (13256, 4088) facing 3 (id 2)
  0.47  RESERVE: zone 3 at (13256, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.47  RESERVE: legtide at (13256, 4136) facing 3 (id 3)
  0.47  RESERVE: zone 4 at (13208, 4040) facing 3, 3x3 cells: 9 of 9 held
  0.47  RESERVE: legtide at (13208, 4040) facing 3 (id 4)
  0.47  RESERVE: zone 5 at (13208, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.47  RESERVE: legtide at (13208, 4088) facing 3 (id 5)
  0.47  RESERVE: zone 6 at (13208, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.47  RESERVE: legtide at (13208, 4136) facing 3 (id 6)
  0.47  RESERVE: served legtide at (13256, 4040) facing 3 (id 1, 5 of this def still held)
  0.61  RESERVE: served armtide at (296, 4680) facing 1 (id 2, 4 of this def still held)
  0.61  RESERVE: served armtide at (1016, 4088) facing 1 (id 2, 4 of this def still held)
  0.70  RESERVE: served armtide at (14040, 4680) facing 3 (id 2, 4 of this def still held)
  0.76  RESERVE: served legtide at (13256, 4088) facing 3 (id 2, 4 of this def still held)
  1.12  RESERVE: zone 7 at (248, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (248, 5048) facing 1 (id 7)
  1.12  RESERVE: zone 8 at (248, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (248, 5000) facing 1 (id 8)
  1.12  RESERVE: zone 9 at (248, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (248, 4952) facing 1 (id 9)
  1.12  RESERVE: zone 10 at (248, 4904) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (248, 4904) facing 1 (id 10)
  1.12  RESERVE: zone 11 at (248, 4856) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (248, 4856) facing 1 (id 11)
  1.12  RESERVE: zone 12 at (296, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (296, 5048) facing 1 (id 12)
  1.12  RESERVE: zone 13 at (296, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (296, 5000) facing 1 (id 13)
  1.12  RESERVE: zone 14 at (296, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (296, 4952) facing 1 (id 14)
  1.12  RESERVE: zone 15 at (296, 4904) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (296, 4904) facing 1 (id 15)
  1.12  RESERVE: zone 16 at (296, 4856) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (296, 4856) facing 1 (id 16)
  1.12  RESERVE: zone 17 at (344, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (344, 5048) facing 1 (id 17)
  1.12  RESERVE: zone 18 at (344, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (344, 5000) facing 1 (id 18)
  1.12  RESERVE: zone 19 at (344, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (344, 4952) facing 1 (id 19)
  1.12  RESERVE: zone 20 at (344, 4904) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (344, 4904) facing 1 (id 20)
  1.12  RESERVE: zone 21 at (344, 4856) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (344, 4856) facing 1 (id 21)
  1.12  RESERVE: zone 22 at (392, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (392, 5048) facing 1 (id 22)
  1.12  RESERVE: zone 23 at (392, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (392, 5000) facing 1 (id 23)
  1.12  RESERVE: zone 24 at (392, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.12  RESERVE: armnanotcplat at (392, 4952) facing 1 (id 24)
  1.12  RESERVE: zone 7 released
  1.12  RESERVE: zone 8 released
  1.12  RESERVE: zone 9 released
  1.12  RESERVE: zone 10 released
  1.12  RESERVE: zone 11 released
  1.12  RESERVE: zone 12 released
  1.12  RESERVE: zone 13 released
  1.12  RESERVE: zone 14 released
  1.12  RESERVE: zone 15 released
  1.12  RESERVE: zone 16 released
  1.12  RESERVE: zone 17 released
  1.12  RESERVE: zone 18 released
  1.12  RESERVE: zone 19 released
  1.12  RESERVE: zone 20 released
  1.12  RESERVE: zone 21 released
  1.12  RESERVE: zone 22 released
  1.12  RESERVE: zone 23 released
  1.12  RESERVE: zone 24 released
  1.12  RESERVE: corridor 25 at (752, 4768) facing 1, 30x12 cells: 88 of 360 held
  1.12  RESERVE: zone 26 at (16, 4768) facing 1, 21x40 cells: 596 of 840 held
  1.12  RESERVE: refused armnanotcplat at (8, 4840): off map
  1.12  RESERVE: refused armnanotcplat at (8, 4792): off map
  1.12  RESERVE: refused armnanotcplat at (8, 4744): off map
  1.12  RESERVE: refused armnanotcplat at (8, 4696): off map
  1.12  RESERVE: refused armnanotcplat at (8, 4840): off map
  1.12  RESERVE: refused armnanotcplat at (8, 4792): off map
  1.12  RESERVE: refused armnanotcplat at (8, 4744): off map
  1.12  RESERVE: refused armnanotcplat at (8, 4696): off map
```
