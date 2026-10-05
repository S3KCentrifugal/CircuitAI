# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.1 min (frame 45093); wall 257 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:43:17
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-preplan\glacial\20261004T184317Z-1be6ed95\runs\20261004T184737Z-485827e5\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:33.978700][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.6 min | `[t=00:00:53.726621][f=0002902] [SeaWatch] finished frame=2902 id=28410 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.9 min | `[t=00:00:59.040822][f=0005160] [SeaWatch] egress id=6248 yard=28410 seconds=32.2 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-preplan\glacial\20261004T184317Z-1be6ed95\runs\20261004T184737Z-485827e5\screen_2026-10-04_18-44-32-035.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-preplan\glacial\20261004T184317Z-1be6ed95\runs\20261004T184737Z-485827e5\screen_2026-10-04_18-45-01-981.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-preplan\glacial\20261004T184317Z-1be6ed95\runs\20261004T184737Z-485827e5\screen_2026-10-04_18-46-36-131.png

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
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 24679 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.43  [Playtest] finished armmex team 0 at 0.43 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1130/1150, energy +30.0 bank 980/1000, units 5
  1.01  [Playtest] finished armtide team 0 at 1.01 min
  1.26  [Playtest] finished armtide team 0 at 1.26 min
  1.61  [Playtest] finished armsy team 0 at 1.61 min
  1.63  [SEA][Layout] berth sea.berth.0 armasy at=1728,4256 facing=1
  1.65  [SEA][Layout] berth sea.berth.1 armasy at=1760,3952 facing=1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 776/1250, energy +83.0 bank 219/1250, units 9
  2.45  [Playtest] finished armtide team 0 at 2.45 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +9.4 bank 329/1250, energy +113.0 bank 64/1350, units 14
  3.29  [Playtest] finished armmex team 0 at 3.29 min
  3.33  [Playtest] finished armtide team 0 at 3.33 min
  3.41  [Playtest] finished armtide team 0 at 3.41 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 0/1300, energy +159.0 bank 1442/1450, units 20
  4.03  [Playtest] finished armmex team 0 at 4.03 min
  4.93  [Playtest] finished armmex team 0 at 4.93 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +14.0 bank 4/1400, energy +159.0 bank 1419/1450, units 21
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.16  [Playtest] finished armmex team 0 at 5.16 min
  5.40  [Playtest] finished armmex team 0 at 5.40 min
  5.56  [Playtest] finished armtide team 0 at 5.56 min
  5.58  [Playtest] finished armmex team 0 at 5.58 min
  5.60  [Playtest] finished armtide team 0 at 5.60 min
  5.81  [Playtest] finished armtide team 0 at 5.81 min
  5.99  [Playtest] finished armtide team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.0 bank 79/1550, energy +235.0 bank 1697/1700, units 28
  6.12  [Playtest] finished armmex team 0 at 6.13 min
  6.38  [Playtest] finished armmex team 0 at 6.38 min
  6.46  [Playtest] finished armfmkr team 0 at 6.46 min
  6.75  [Playtest] finished armfmkr team 0 at 6.75 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +25.0 bank 633/1650, energy +265.0 bank 1333/1750, units 35
  7.01  [Playtest] finished armtide team 0 at 7.01 min
  7.17  [Playtest] finished armtide team 0 at 7.17 min
  7.31  [Playtest] finished armtide team 0 at 7.31 min
  7.39  [Playtest] finished armnanotcplat team 0 at 7.39 min
  7.46  [Playtest] finished armtide team 0 at 7.46 min
  7.90  [Playtest] finished armfmkr team 0 at 7.90 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +25.4 bank 614/1650, energy +357.0 bank 1511/1950, units 41
  8.24  [Playtest] finished armtide team 0 at 8.24 min
  8.36  [Playtest] finished armtide team 0 at 8.36 min
  8.48  [Playtest] finished armtide team 0 at 8.48 min
  8.60  [Playtest] finished armtide team 0 at 8.60 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.6 bank 343/1650, energy +449.0 bank 1671/2150, units 47
  9.04  [Playtest] finished armfmkr team 0 at 9.04 min
  9.41  [Playtest] finished armtide team 0 at 9.41 min
  9.59  [Playtest] finished armtide team 0 at 9.59 min
  9.99  [Playtest] finished armfmkr team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +25.8 bank 257/1650, energy +495.0 bank 1792/2250, units 50
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.37  [Playtest] finished armtide team 0 at 10.37 min
 10.71  [Playtest] finished armtide team 0 at 10.71 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +29.0 bank 204/1650, energy +541.0 bank 1880/2350, units 54
 11.05  [Playtest] finished armtide team 0 at 11.05 min
 11.10  [Playtest] finished armfmkr team 0 at 11.10 min
 11.26  [Playtest] finished armtl team 0 at 11.26 min
 11.40  [Playtest] finished armtide team 0 at 11.40 min
 11.75  [Playtest] finished armtide team 0 at 11.75 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +29.3 bank 268/1650, energy +617.0 bank 2079/2550, units 57
 12.11  [Playtest] finished armtl team 0 at 12.11 min
 12.18  [Playtest] finished armtide team 0 at 12.18 min
 12.47  [Playtest] finished armmex team 0 at 12.48 min
 12.52  [Playtest] finished armtide team 0 at 12.52 min
 12.69  [Playtest] finished armmex team 0 at 12.69 min
 12.88  [Playtest] finished armtide team 0 at 12.88 min
 12.91  [Playtest] finished armfrad team 0 at 12.91 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +32.7 bank 50/1750, energy +686.0 bank 2186/2700, units 66
 13.04  [Playtest] finished armmex team 0 at 13.04 min
 13.19  [Playtest] finished armtl team 0 at 13.19 min
 13.30  [Playtest] finished armtide team 0 at 13.30 min
 13.37  [Playtest] finished armmex team 0 at 13.37 min
 13.41  [Playtest] finished armmex team 0 at 13.41 min
 13.80  [Playtest] finished armmex team 0 at 13.80 min
 13.82  [Playtest] finished armmex team 0 at 13.82 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +58.9 bank 1145/2000, energy +716.0 bank 2537/2800, units 73
 14.24  [Playtest] finished armtide team 0 at 14.24 min
 14.34  [Playtest] finished armtl team 0 at 14.34 min
 14.61  [Playtest] finished armfmkr team 0 at 14.61 min
 14.64  [Playtest] finished armmex team 0 at 14.64 min
 14.75  [Playtest] finished armmex team 0 at 14.75 min
 14.93  [Playtest] finished armmex team 0 at 14.93 min
 14.97  [Playtest] finished armmex team 0 at 14.97 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +55.4 bank 2022/2200, energy +739.0 bank 2385/2850, units 82
 15.09  [Playtest] finished armnanotcplat team 0 at 15.09 min
 15.27  [Playtest] finished armfrad team 0 at 15.27 min
 15.37  [Playtest] finished armnanotcplat team 0 at 15.37 min
 15.38  [Playtest] finished armmex team 0 at 15.38 min
 15.44  [Playtest] finished armtide team 0 at 15.44 min
 15.57  [Playtest] finished armmex team 0 at 15.57 min
 15.61  [Playtest] finished armfmkr team 0 at 15.61 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +50.6 bank 1796/2200, energy +762.0 bank 2231/2900, units 91
 16.09  [Playtest] finished armtl team 0 at 16.09 min
 16.28  [Playtest] finished armtide team 0 at 16.28 min
 16.54  [Playtest] finished armmex team 0 at 16.54 min
 16.59  [Playtest] finished armtide team 0 at 16.59 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +118.0 bank 1770/2250, energy +808.0 bank 2396/3000, units 97
 17.48  [Playtest] finished armtide team 0 at 17.48 min
 17.59  [Playtest] finished armasy team 0 at 17.59 min
 17.78  [Playtest] finished armtide team 0 at 17.78 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +48.0 bank 1670/2450, energy +854.0 bank 2085/3300, units 105
 18.17  [Playtest] finished armtide team 0 at 18.17 min
 18.23  [Playtest] finished armtide team 0 at 18.23 min
 18.44  [Playtest] finished armnanotcplat team 0 at 18.44 min
 18.53  [Playtest] finished armtide team 0 at 18.53 min
 18.88  [Playtest] finished armtide team 0 at 18.88 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +92.4 bank 1493/2450, energy +1006.0 bank 2041/3800, units 114
 19.15  [Playtest] finished armuwmme team 0 at 19.15 min
 19.16  [Playtest] finished armuwmme team 0 at 19.16 min
 19.22  [Playtest] finished armtide team 0 at 19.22 min
 19.39  [Playtest] finished armuwmme team 0 at 19.39 min
 19.46  [Playtest] finished armnanotcplat team 0 at 19.46 min
 19.57  [Playtest] finished armtide team 0 at 19.57 min
 19.69  [Playtest] finished armuwmme team 0 at 19.69 min
 19.96  [Playtest] finished armtide team 0 at 19.96 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +116.4 bank 2231/4650, energy +1075.0 bank 2151/3950, units 107
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.03  [Playtest] finished armuwmme team 0 at 20.03 min
 20.03  [Playtest] finished armnanotcplat team 0 at 20.03 min
 20.20  [Playtest] finished armtide team 0 at 20.20 min
 20.33  [Playtest] finished armnanotcplat team 0 at 20.33 min
 20.57  [Playtest] finished armnanotcplat team 0 at 20.57 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +76.0 bank 1432/5150, energy +1098.0 bank 939/4000, units 106
 21.18  [Playtest] finished armatl team 0 at 21.18 min
 21.76  [Playtest] finished armuwfus team 0 at 21.76 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +82.0 bank 624/5100, energy +2298.0 bank 6458/6500, units 106
 22.22  [Playtest] finished armnanotcplat team 0 at 22.22 min
 22.55  [Playtest] finished armuwmmm team 0 at 22.55 min
 22.87  [Playtest] finished armuwmmm team 0 at 22.87 min
 22.94  [Playtest] finished armnanotcplat team 0 at 22.94 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +79.7 bank 1839/4950, energy +2298.0 bank 5185/6500, units 103
 23.30  [Playtest] finished armuwadves team 0 at 23.30 min
 23.39  [Playtest] finished armuwmmm team 0 at 23.39 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +73.6 bank 966/4600, energy +2291.0 bank 35894/46450, units 93
 24.57  [Playtest] finished armnanotcplat team 0 at 24.58 min
 24.65  [Playtest] finished armnanotcplat team 0 at 24.65 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +132.7 bank 1142/4600, energy +2277.0 bank 35071/46350, units 95
```

## Native lines (all AIs, first 120)

```
  0.29  RESERVE: zone 1 at (152, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4808) facing 1 (id 1)
  0.29  RESERVE: zone 2 at (152, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4760) facing 1 (id 2)
  0.29  RESERVE: zone 3 at (152, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4712) facing 1 (id 3)
  0.29  RESERVE: zone 4 at (152, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4664) facing 1 (id 4)
  0.29  RESERVE: zone 5 at (152, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4616) facing 1 (id 5)
  0.29  RESERVE: zone 6 at (152, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4568) facing 1 (id 6)
  0.29  RESERVE: zone 7 at (200, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4808) facing 1 (id 7)
  0.29  RESERVE: zone 8 at (200, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4760) facing 1 (id 8)
  0.29  RESERVE: zone 9 at (200, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4712) facing 1 (id 9)
  0.29  RESERVE: zone 10 at (200, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4664) facing 1 (id 10)
  0.29  RESERVE: zone 11 at (200, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4616) facing 1 (id 11)
  0.29  RESERVE: zone 12 at (200, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4568) facing 1 (id 12)
  0.29  RESERVE: zone 13 at (248, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4808) facing 1 (id 13)
  0.29  RESERVE: zone 14 at (248, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4760) facing 1 (id 14)
  0.29  RESERVE: zone 15 at (248, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4712) facing 1 (id 15)
  0.29  RESERVE: zone 16 at (248, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4664) facing 1 (id 16)
  0.29  RESERVE: zone 17 at (248, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4616) facing 1 (id 17)
  0.29  RESERVE: zone 18 at (248, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4568) facing 1 (id 18)
  0.29  RESERVE: zone 19 at (296, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4808) facing 1 (id 19)
  0.29  RESERVE: zone 20 at (296, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4760) facing 1 (id 20)
  0.29  RESERVE: zone 21 at (296, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4712) facing 1 (id 21)
  0.29  RESERVE: zone 22 at (296, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4664) facing 1 (id 22)
  0.29  RESERVE: zone 23 at (296, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4616) facing 1 (id 23)
  0.29  RESERVE: zone 24 at (296, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4568) facing 1 (id 24)
  0.29  RESERVE: zone 25 at (344, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4808) facing 1 (id 25)
  0.29  RESERVE: zone 26 at (344, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4760) facing 1 (id 26)
  0.29  RESERVE: zone 27 at (344, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4712) facing 1 (id 27)
  0.29  RESERVE: zone 28 at (344, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4664) facing 1 (id 28)
  0.29  RESERVE: zone 29 at (344, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4616) facing 1 (id 29)
  0.29  RESERVE: zone 30 at (344, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4568) facing 1 (id 30)
  0.29  RESERVE: zone 31 at (392, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4808) facing 1 (id 31)
  0.29  RESERVE: zone 32 at (392, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4760) facing 1 (id 32)
  0.29  RESERVE: zone 33 at (392, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4712) facing 1 (id 33)
  0.29  RESERVE: zone 34 at (392, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4664) facing 1 (id 34)
  0.29  RESERVE: zone 35 at (392, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4616) facing 1 (id 35)
  0.29  RESERVE: zone 36 at (392, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4568) facing 1 (id 36)
  0.29  RESERVE: zone 37 at (440, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4808) facing 1 (id 37)
  0.29  RESERVE: zone 38 at (440, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4760) facing 1 (id 38)
  0.29  RESERVE: zone 39 at (440, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4712) facing 1 (id 39)
  0.29  RESERVE: zone 40 at (440, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4664) facing 1 (id 40)
  0.29  RESERVE: zone 41 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4616) facing 1 (id 41)
  0.29  RESERVE: zone 42 at (440, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4568) facing 1 (id 42)
  0.29  RESERVE: zone 43 at (488, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4808) facing 1 (id 43)
  0.29  RESERVE: zone 44 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4760) facing 1 (id 44)
  0.29  RESERVE: zone 45 at (488, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4712) facing 1 (id 45)
  0.29  RESERVE: zone 46 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4664) facing 1 (id 46)
  0.29  RESERVE: zone 47 at (488, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4616) facing 1 (id 47)
  0.29  RESERVE: zone 48 at (488, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4568) facing 1 (id 48)
  0.29  RESERVE: served armtide at (152, 4808) facing 1 (id 1, 47 of this def still held)
  0.41  RESERVE: zone 1 at (14184, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4568) facing 3 (id 1)
  0.41  RESERVE: zone 2 at (14184, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4616) facing 3 (id 2)
  0.41  RESERVE: zone 3 at (14184, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4664) facing 3 (id 3)
  0.41  RESERVE: zone 4 at (14184, 4712) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4712) facing 3 (id 4)
  0.41  RESERVE: zone 5 at (14184, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4760) facing 3 (id 5)
  0.41  RESERVE: zone 6 at (14184, 4808) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4808) facing 3 (id 6)
  0.41  RESERVE: zone 7 at (14136, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4568) facing 3 (id 7)
  0.41  RESERVE: zone 8 at (14136, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4616) facing 3 (id 8)
  0.41  RESERVE: zone 9 at (14136, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4664) facing 3 (id 9)
  0.41  RESERVE: zone 10 at (14136, 4712) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4712) facing 3 (id 10)
  0.41  RESERVE: zone 11 at (14136, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4760) facing 3 (id 11)
  0.41  RESERVE: zone 12 at (14136, 4808) facing 3, 3x3 cells: 9 of 9 held
```
