# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54017); wall 219 s
- DLL: build-theatres\d189-baseline\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T06:26:35
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-control\glacial\20261004T092635Z-09534d46\runs\20261004T093017Z-1c796807\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.645294][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:47.385940][f=0001465] [SeaWatch] finished frame=1465 id=24072 def=armsy builder=6714` |
| expect `first-ship-exit` | seen at 2.6 min | `[t=00:00:54.464024][f=0004650] [SeaWatch] egress id=20594 yard=24072 seconds=5.0 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-control\glacial\20261004T092635Z-09534d46\runs\20261004T093017Z-1c796807\screen_2026-10-04_09-27-44-892.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-control\glacial\20261004T092635Z-09534d46\runs\20261004T093017Z-1c796807\screen_2026-10-04_09-28-05-902.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-control\glacial\20261004T092635Z-09534d46\runs\20261004T093017Z-1c796807\screen_2026-10-04_09-28-57-689.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-control\glacial\20261004T092635Z-09534d46\runs\20261004T093017Z-1c796807\screen_2026-10-04_09-30-06-357.png

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
  0.17  [Team][Roster] first mex 28868 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.81  [Playtest] finished armsy team 0 at 0.81 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 716/1200, energy +30.0 bank 102/1100, units 5
  1.26  [Playtest] finished armtide team 0 at 1.26 min
  1.64  [Playtest] finished armtide team 0 at 1.64 min
  1.80  [Playtest] finished armtide team 0 at 1.80 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 490/1200, energy +106.0 bank 120/1300, units 10
  2.04  [Playtest] finished armtide team 0 at 2.04 min
  2.28  [Playtest] finished armtide team 0 at 2.28 min
  2.56  [Playtest] finished armmex team 0 at 2.56 min
  2.58  [Playtest] finished armtide team 0 at 2.58 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 58/1250, energy +182.0 bank 1487/1500, units 17
  3.03  [Playtest] finished armtide team 0 at 3.03 min
  3.29  [Playtest] finished armmex team 0 at 3.29 min
  3.33  [Playtest] finished armtide team 0 at 3.33 min
  3.58  [Playtest] finished armmex team 0 at 3.58 min
  3.79  [Playtest] finished armmex team 0 at 3.79 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.0 bank 0/1400, energy +228.0 bank 1566/1600, units 25
  4.00  [Playtest] finished armmex team 0 at 4.00 min
  4.18  [Playtest] finished armmex team 0 at 4.18 min
  4.33  [Playtest] finished armtide team 0 at 4.33 min
  4.68  [Playtest] finished armmex team 0 at 4.68 min
  4.76  [Playtest] finished armtide team 0 at 4.76 min
  4.89  [Playtest] finished armmex team 0 at 4.89 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +22.0 bank 144/1600, energy +281.0 bank 1711/1750, units 32
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.07  [Playtest] finished armtide team 0 at 5.07 min
  5.09  [Playtest] finished armmex team 0 at 5.09 min
  5.26  [Playtest] finished armmex team 0 at 5.26 min
  5.37  [Playtest] finished armtide team 0 at 5.37 min
  5.38  [Playtest] finished armmex team 0 at 5.38 min
  5.66  [Playtest] finished armfrad team 0 at 5.66 min
  5.83  [Playtest] finished armmex team 0 at 5.82 min
  5.92  [Playtest] finished armmex team 0 at 5.92 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +32.0 bank 602/1850, energy +334.0 bank 1870/1900, units 40
  6.05  [Playtest] finished armmex team 0 at 6.05 min
  6.24  [Playtest] finished armmex team 0 at 6.24 min
  6.24  [Playtest] finished armmex team 0 at 6.24 min
  6.42  [Playtest] finished armmex team 0 at 6.42 min
  6.46  [Playtest] finished armtl team 0 at 6.46 min
  6.58  [Playtest] finished armllt team 0 at 6.58 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +40.0 bank 1663/2050, energy +334.0 bank 1851/1900, units 46
  7.07  [Playtest] finished armmex team 0 at 7.07 min
  7.29  [Playtest] finished armmex team 0 at 7.29 min
  7.33  [Playtest] finished armmex team 0 at 7.33 min
  7.49  [Playtest] finished armmex team 0 at 7.49 min
  7.63  [Playtest] finished armmex team 0 at 7.63 min
  7.66  [Playtest] finished armmex team 0 at 7.66 min
  7.67  [Playtest] finished armtide team 0 at 7.67 min
  7.80  [Playtest] finished armtide team 0 at 7.80 min
  7.82  [Playtest] finished armllt team 0 at 7.82 min
  7.90  [Playtest] finished armrad team 0 at 7.90 min
  7.98  [Playtest] finished armtide team 0 at 7.98 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +52.0 bank 2236/2350, energy +405.5 bank 2125/2150, units 60
  8.09  [Playtest] finished armtide team 0 at 8.09 min
  8.13  [Playtest] finished armfrad team 0 at 8.13 min
  8.16  [Playtest] finished armtide team 0 at 8.16 min
  8.26  [Playtest] finished armtide team 0 at 8.26 min
  8.26  [Playtest] finished armmex team 0 at 8.26 min
  8.40  [Playtest] finished armtide team 0 at 8.40 min
  8.58  [Playtest] finished armmex team 0 at 8.58 min
  8.63  [Playtest] finished armllt team 0 at 8.63 min
  8.63  [Playtest] finished armtide team 0 at 8.63 min
  8.71  [Playtest] finished armtide team 0 at 8.71 min
  8.73  [Playtest] finished armtide team 0 at 8.73 min
  8.88  [Playtest] finished armfrad team 0 at 8.88 min
  8.94  [Playtest] finished armtide team 0 at 8.94 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +56.0 bank 2447/2450, energy +601.0 bank 2544/2550, units 73
  9.02  [Playtest] finished armtide team 0 at 9.02 min
  9.08  [Playtest] finished armtide team 0 at 9.08 min
  9.25  [Playtest] finished armtide team 0 at 9.25 min
  9.33  [Playtest] finished armtide team 0 at 9.33 min
  9.43  [Playtest] finished armtide team 0 at 9.43 min
  9.45  [Playtest] finished armtide team 0 at 9.45 min
  9.51  [Playtest] finished armmex team 0 at 9.51 min
  9.56  [Playtest] finished armfmkr team 0 at 9.56 min
  9.66  [Playtest] finished armtide team 0 at 9.66 min
  9.73  [Playtest] finished armfmkr team 0 at 9.73 min
  9.84  [Playtest] finished armtide team 0 at 9.84 min
  9.88  [Playtest] finished armtide team 0 at 9.88 min
  9.89  [Playtest] finished armfmkr team 0 at 9.89 min
  9.96  [Playtest] finished armtide team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +57.0 bank 2396/2400, energy +831.0 bank 2911/3000, units 85
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.06  [Playtest] finished armfmkr team 0 at 10.06 min
 10.12  [Playtest] finished armtide team 0 at 10.12 min
 10.21  [Playtest] finished armtide team 0 at 10.21 min
 10.23  [Playtest] finished armfmkr team 0 at 10.23 min
 10.24  [Playtest] finished armtide team 0 at 10.24 min
 10.53  [Playtest] finished armfmkr team 0 at 10.53 min
 10.65  [Playtest] finished armtide team 0 at 10.65 min
 10.81  [Playtest] finished armtide team 0 at 10.81 min
 10.97  [Playtest] finished armtide team 0 at 10.97 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +58.0 bank 2348/2350, energy +969.0 bank 3215/3350, units 92
 11.11  [Playtest] finished armfmkr team 0 at 11.11 min
 11.16  [Playtest] finished armtide team 0 at 11.16 min
 11.27  [Playtest] finished armfmkr team 0 at 11.27 min
 11.40  [Playtest] finished armfmkr team 0 at 11.40 min
 11.53  [Playtest] finished armfmkr team 0 at 11.53 min
 11.55  [Playtest] finished armtide team 0 at 11.55 min
 11.57  [Playtest] finished armtide team 0 at 11.57 min
 11.58  [Playtest] finished armfmkr team 0 at 11.58 min
 11.74  [Playtest] finished armfmkr team 0 at 11.74 min
 11.90  [Playtest] finished armtide team 0 at 11.90 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +64.0 bank 2330/2350, energy +1061.0 bank 3205/3550, units 105
 12.04  [Playtest] finished armtide team 0 at 12.04 min
 12.11  [Playtest] finished armtide team 0 at 12.11 min
 12.21  [Playtest] finished armtide team 0 at 12.21 min
 12.35  [Playtest] finished armtide team 0 at 12.35 min
 12.42  [Playtest] finished armtide team 0 at 12.42 min
 12.62  [Playtest] finished armasy team 0 at 12.62 min
 12.70  [Playtest] finished armtide team 0 at 12.70 min
 12.87  [Playtest] finished armtide team 0 at 12.87 min
 12.89  [Playtest] finished armtide team 0 at 12.89 min
 12.97  [Playtest] finished armtide team 0 at 12.97 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +63.0 bank 1942/2550, energy +1268.0 bank 3517/4200, units 114
 13.07  [Playtest] finished armtide team 0 at 13.07 min
 13.34  [Playtest] finished armfmkr team 0 at 13.34 min
 13.70  [Playtest] finished armfmkr team 0 at 13.70 min
 13.84  [Playtest] finished armnanotcplat team 0 at 13.84 min
 13.97  [Playtest] finished armuwmme team 0 at 13.97 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +112.9 bank 2340/3100, energy +1351.0 bank 3661/4550, units 120
 14.13  [Playtest] finished armnanotcplat team 0 at 14.13 min
 14.40  [Playtest] finished armnanotcplat team 0 at 14.40 min
 14.48  [Playtest] finished armuwmme team 0 at 14.48 min
 14.54  [Playtest] finished armuwmme team 0 at 14.54 min
 14.79  [Playtest] finished armtide team 0 at 14.79 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +72.9 bank 711/4150, energy +1374.0 bank 3583/4600, units 124
 16.00  [Playtest] eco team 0 at 16.0 min: metal +77.2 bank 0/4150, energy +1374.0 bank 3754/4600, units 125
 16.19  [Playtest] finished armmex team 0 at 16.19 min
 16.67  [Playtest] finished armuwfus team 0 at 16.67 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +82.0 bank 186/4150, energy +2553.0 bank 6841/6950, units 121
 17.33  [Playtest] finished armfmkr team 0 at 17.33 min
 17.35  [Playtest] finished armmex team 0 at 17.35 min
 17.66  [Playtest] finished armnanotcplat team 0 at 17.66 min
 17.82  [Playtest] finished armfmkr team 0 at 17.82 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +84.0 bank 0/4150, energy +2567.0 bank 6874/7050, units 122
 18.14  [Playtest] finished armfmkr team 0 at 18.14 min
 18.30  [Playtest] finished armfmkr team 0 at 18.30 min
 18.62  [Playtest] finished armfmkr team 0 at 18.62 min
 18.70  [Playtest] finished armuwfus team 0 at 18.70 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +81.0 bank 201/4000, energy +3774.0 bank 9333/9600, units 123
 19.04  [Playtest] finished armfmkr team 0 at 19.04 min
 19.04  [Playtest] finished armfmkr team 0 at 19.04 min
 19.30  [Playtest] finished armfmkr team 0 at 19.30 min
 19.38  [Playtest] finished armfmkr team 0 at 19.38 min
 19.43  [Playtest] finished armfmkr team 0 at 19.43 min
 19.48  [Playtest] finished armnanotcplat team 0 at 19.48 min
 19.73  [Playtest] finished armnanotcplat team 0 at 19.73 min
 19.86  [Playtest] finished armmex team 0 at 19.86 min
 19.89  [Playtest] finished armfmkr team 0 at 19.89 min
 19.91  [Playtest] finished armfmkr team 0 at 19.91 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +86.0 bank 77/3950, energy +3744.0 bank 8911/9450, units 130
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.33  [Playtest] finished armfmkr team 0 at 20.33 min
 20.39  [Playtest] finished armfmkr team 0 at 20.39 min
 20.59  [Playtest] finished armfmkr team 0 at 20.59 min
 20.63  [Playtest] finished armfmkr team 0 at 20.63 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +88.0 bank 40/3900, energy +3774.0 bank 8785/9600, units 136
 21.29  [Playtest] finished armfmkr team 0 at 21.29 min
 21.34  [Playtest] finished armuwmmm team 0 at 21.33 min
 21.68  [Playtest] finished armuwmmm team 0 at 21.68 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +97.4 bank 70/3900, energy +3774.0 bank 8455/9600, units 135
 22.33  [Playtest] finished armfmkr team 0 at 22.33 min
 22.35  [Playtest] finished armfmkr team 0 at 22.35 min
 22.55  [Playtest] finished armfmkr team 0 at 22.55 min
 22.55  [Playtest] finished armfmkr team 0 at 22.55 min
 22.66  [Playtest] finished armrl team 0 at 22.66 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +96.9 bank 265/3900, energy +3677.0 bank 8173/9250, units 119
 23.62  [Playtest] finished armnanotcplat team 0 at 23.62 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +91.3 bank 1420/3900, energy +3273.5 bank 7442/8450, units 104
 24.55  [Playtest] finished armnanotcplat team 0 at 24.56 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +106.9 bank 3302/3900, energy +3268.0 bank 7106/8500, units 112
 25.23  [Playtest] finished armnanotcplat team 0 at 25.23 min
 25.29  [Playtest] finished armfmkr team 0 at 25.29 min
 25.46  [Playtest] finished armnanotcplat team 0 at 25.46 min
 25.79  [Playtest] finished armnanotcplat team 0 at 25.79 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +154.1 bank 1575/3900, energy +3268.0 bank 7137/8500, units 119
 26.20  [Playtest] finished armuwmmm team 0 at 26.20 min
 26.36  [Playtest] finished armuwmmm team 0 at 26.36 min
 26.57  [Playtest] finished armnanotcplat team 0 at 26.57 min
 26.97  [Playtest] finished armfmkr team 0 at 26.97 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +90.5 bank 44/3900, energy +3268.0 bank 7037/8500, units 125
 27.04  [Playtest] finished armmship team 0 at 27.04 min
 27.08  [Playtest] finished armuwmmm team 0 at 27.08 min
 27.34  [Playtest] finished armfmkr team 0 at 27.34 min
 27.57  [Playtest] finished armfmkr team 0 at 27.57 min
 27.77  [Playtest] finished armuwmmm team 0 at 27.77 min
 27.89  [Playtest] finished armtide team 0 at 27.89 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +91.5 bank 46/3900, energy +3307.0 bank 7124/8600, units 124
 28.19  [Playtest] finished armtide team 0 at 28.19 min
 28.23  [SEA][Layout] berth sea.berth.3 corsy at=1680,4624 facing=1
 28.26  [Playtest] finished armfmkr team 0 at 28.26 min
 28.37  [Playtest] finished armfmkr team 0 at 28.37 min
 28.59  [Playtest] finished armfmkr team 0 at 28.59 min
 28.76  [Playtest] finished armfmkr team 0 at 28.76 min
 28.82  [Playtest] finished armfmkr team 0 at 28.82 min
 28.89  [Playtest] finished armfmkr team 0 at 28.89 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +100.9 bank 393/3900, energy +3307.0 bank 7010/8550, units 132
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.20  [Playtest] finished armnanotcplat team 0 at 29.20 min
 29.25  [Playtest] finished armfmkr team 0 at 29.25 min
 29.35  [Playtest] finished armnanotcplat team 0 at 29.35 min
 29.53  [Playtest] finished armfmkr team 0 at 29.53 min
 29.75  [Playtest] finished armmship team 0 at 29.75 min
 29.82  [Playtest] finished armfmkr team 0 at 29.82 min
 29.86  [Playtest] finished armtide team 0 at 29.86 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +91.9 bank 49/3900, energy +3330.0 bank 6497/8600, units 145
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(15194) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
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
