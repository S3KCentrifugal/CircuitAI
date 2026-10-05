# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54059); wall 277 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:17:03
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\tundra\20261004T111703Z-861b39b9\runs\20261004T112143Z-b10cce9f\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:32.934402][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.6 min | `[t=00:00:47.910091][f=0001104] [SeaWatch] finished frame=1104 id=9050 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 1.9 min | `[t=00:00:53.061515][f=0003420] [SeaWatch] egress id=4850 yard=9050 seconds=10.7 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\tundra\20261004T111703Z-861b39b9\runs\20261004T112143Z-b10cce9f\screen_2026-10-04_11-18-13-918.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\tundra\20261004T111703Z-861b39b9\runs\20261004T112143Z-b10cce9f\screen_2026-10-04_11-18-41-761.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\tundra\20261004T111703Z-861b39b9\runs\20261004T112143Z-b10cce9f\screen_2026-10-04_11-20-08-665.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\tundra\20261004T111703Z-861b39b9\runs\20261004T112143Z-b10cce9f\screen_2026-10-04_11-21-31-011.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4100, 2100) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (5400, 800) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (6400, 800) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (7800, 1500) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (1504, 12000) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (1610, 10300) units 1
  0.00  [Playtest] frame 1 team 6 ally 1 side legion ai true dead false start (6700, 10600) units 1
  0.00  [Playtest] frame 1 team 7 ally 1 side armada ai true dead false start (8200, 10900) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (9000, 11400) units 1
  0.00  [Playtest] frame 1 team 9 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 10 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4100, 2100) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (5400, 800) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (6400, 800) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (7800, 1500) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (1504, 12000) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (1610, 10300) units 1
  0.05  [Playtest] frame 90 team 6 ally 1 side legion ai true dead false start (6700, 10600) units 1
  0.05  [Playtest] frame 90 team 7 ally 1 side armada ai true dead false start (8200, 10900) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (9000, 11400) units 1
  0.05  [Playtest] frame 90 team 9 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 10 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=4096,2096 facing=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5342,795) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7814,1506) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 10685 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.18  [Team][Roster] team 2 first mex at 6384,720
  0.22  [Team][Roster] team 3 first mex at 7984,1504
  0.28  [Team][Roster] team 1 first mex at 5136,752
  0.61  [Playtest] finished armsy team 0 at 0.61 min
  0.95  [Playtest] finished armtide team 0 at 0.95 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 547/1150, energy +45.0 bank 87/1150, units 5
  1.31  [Playtest] finished armmex team 0 at 1.31 min
  1.60  [Playtest] finished armtide team 0 at 1.60 min
  1.97  [Playtest] finished armmex team 0 at 1.97 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 516/1250, energy +67.0 bank 93/1250, units 9
  2.46  [Playtest] finished armtide team 0 at 2.46 min
  2.64  [Playtest] finished armmex team 0 at 2.64 min
  2.65  [Playtest] finished armtide team 0 at 2.65 min
  2.89  [Playtest] finished armmex team 0 at 2.89 min
  3.00  [Playtest] finished armtide team 0 at 3.00 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +12.0 bank 636/1350, energy +104.0 bank 396/1450, units 16
  3.31  [Playtest] finished armtide team 0 at 3.31 min
  3.49  [Playtest] finished armmex team 0 at 3.49 min
  3.68  [Playtest] finished armmex team 0 at 3.68 min
  3.94  [Playtest] finished armtl team 0 at 3.94 min
  3.99  [Playtest] finished armmex team 0 at 3.99 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +16.0 bank 774/1500, energy +134.0 bank 162/1500, units 22
  4.33  [Playtest] finished armmex team 0 at 4.33 min
  4.38  [Playtest] finished armtide team 0 at 4.38 min
  4.71  [Playtest] finished armtide team 0 at 4.71 min
  4.74  [Playtest] finished armtide team 0 at 4.74 min
  4.83  [Playtest] finished armmex team 0 at 4.83 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +22.0 bank 772/1600, energy +179.0 bank 544/1650, units 29
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.01  [Playtest] finished armtide team 0 at 5.01 min
  5.16  [Playtest] finished armmex team 0 at 5.16 min
  5.33  [Playtest] finished armtide team 0 at 5.33 min
  5.65  [Playtest] finished armtide team 0 at 5.65 min
  5.83  [Playtest] finished armmex team 0 at 5.83 min
  5.94  [Playtest] finished armtide team 0 at 5.94 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 1233/1700, energy +253.0 bank 1928/1950, units 38
  6.12  [Playtest] finished armtide team 0 at 6.12 min
  6.14  [Playtest] finished armtl team 0 at 6.14 min
  6.25  [Playtest] finished armtide team 0 at 6.25 min
  6.28  [Playtest] finished armmex team 0 at 6.28 min
  6.36  [Playtest] finished armtide team 0 at 6.36 min
  6.44  [Playtest] finished armtide team 0 at 6.44 min
  6.47  [Playtest] finished armfrad team 0 at 6.47 min
  6.64  [Playtest] finished armtide team 0 at 6.64 min
  6.67  [Playtest] finished armmex team 0 at 6.67 min
  6.91  [Playtest] finished armtide team 0 at 6.91 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +30.0 bank 1355/1800, energy +343.0 bank 2289/2300, units 48
  7.20  [Playtest] finished armnanotcplat team 0 at 7.20 min
  7.30  [Playtest] finished armnanotcplat team 0 at 7.30 min
  7.44  [Playtest] finished armnanotcplat team 0 at 7.44 min
  7.49  [Playtest] finished armmex team 0 at 7.49 min
  7.50  [Playtest] finished armtide team 0 at 7.50 min
  7.55  [Playtest] finished armtide team 0 at 7.55 min
  7.62  [Playtest] finished armtide team 0 at 7.62 min
  7.68  [Playtest] finished armtide team 0 at 7.68 min
  7.73  [Playtest] finished armtide team 0 at 7.73 min
  7.79  [Playtest] finished armtide team 0 at 7.79 min
  7.88  [Playtest] finished armtide team 0 at 7.88 min
  7.93  [Playtest] finished armtide team 0 at 7.93 min
  7.98  [Playtest] finished armtide team 0 at 7.98 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +31.9 bank 783/1850, energy +470.0 bank 2704/2750, units 62
  8.04  [Playtest] finished armtide team 0 at 8.04 min
  8.07  [Playtest] finished armmex team 0 at 8.07 min
  8.11  [Playtest] finished armmex team 0 at 8.11 min
  8.14  [Playtest] finished armtl team 0 at 8.14 min
  8.27  [Playtest] finished armtide team 0 at 8.27 min
  8.37  [Playtest] finished armmex team 0 at 8.37 min
  8.38  [Playtest] finished armmex team 0 at 8.38 min
  8.41  [Playtest] finished armtide team 0 at 8.41 min
  8.50  [Playtest] finished armtide team 0 at 8.50 min
  8.53  [Playtest] finished armllt team 0 at 8.53 min
  8.54  [Playtest] finished armtide team 0 at 8.54 min
  8.62  [Playtest] finished armtide team 0 at 8.63 min
  8.86  [Playtest] finished armtide team 0 at 8.86 min
  8.93  [Playtest] finished armtide team 0 at 8.93 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +39.9 bank 818/2050, energy +612.0 bank 3187/3200, units 83
  9.01  [Playtest] finished armtide team 0 at 9.01 min
  9.05  [Playtest] finished armmex team 0 at 9.05 min
  9.07  [Playtest] finished armtl team 0 at 9.07 min
  9.19  [Playtest] finished armtide team 0 at 9.19 min
  9.26  [Playtest] finished armtl team 0 at 9.26 min
  9.29  [Playtest] finished armtide team 0 at 9.29 min
  9.35  [Playtest] finished armtide team 0 at 9.35 min
  9.38  [Playtest] finished armmex team 0 at 9.38 min
  9.45  [Playtest] finished armmex team 0 at 9.45 min
  9.48  [Playtest] finished armtide team 0 at 9.48 min
  9.67  [Playtest] finished armllt team 0 at 9.67 min
  9.67  [Playtest] finished armtide team 0 at 9.67 min
  9.72  [Playtest] finished armmex team 0 at 9.72 min
  9.86  [Playtest] finished armrad team 0 at 9.85 min
  9.98  [Playtest] finished armtl team 0 at 9.98 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +47.9 bank 518/2250, energy +702.0 bank 3463/3500, units 95
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.37  [Playtest] finished armfrad team 0 at 10.37 min
 10.73  [Playtest] finished armmex team 0 at 10.73 min
 10.87  [Playtest] finished armtl team 0 at 10.87 min
 10.93  [Playtest] finished armmex team 0 at 10.93 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +51.9 bank 572/2350, energy +702.0 bank 3483/3500, units 106
 11.14  [Playtest] finished armllt team 0 at 11.14 min
 11.28  [Playtest] finished armtl team 0 at 11.28 min
 11.46  [Playtest] finished armtl team 0 at 11.46 min
 11.55  [Playtest] finished armtl team 0 at 11.55 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +51.9 bank 520/2350, energy +709.0 bank 3453/3550, units 111
 12.02  [SEA][Layout] berth sea.berth.3 corsy at=4288,2096 facing=0
 12.15  [Playtest] finished armfmkr team 0 at 12.15 min
 12.64  [Playtest] finished armfrad team 0 at 12.64 min
 12.91  [Playtest] finished armmex team 0 at 12.91 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +54.9 bank 1167/2400, energy +702.0 bank 3347/3500, units 114
 13.25  [Playtest] finished armmex team 0 at 13.25 min
 13.51  [Playtest] finished armmex team 0 at 13.51 min
 13.72  [Playtest] finished armllt team 0 at 13.72 min
 13.81  [Playtest] finished armrad team 0 at 13.81 min
 13.93  [Playtest] finished armmex team 0 at 13.93 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +60.9 bank 1330/2550, energy +698.5 bank 3406/3450, units 120
 14.87  [Playtest] finished armfmkr team 0 at 14.87 min
 14.96  [Playtest] finished armfmkr team 0 at 14.96 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +62.9 bank 2431/2550, energy +702.0 bank 3389/3500, units 126
 15.25  [Playtest] finished armmex team 0 at 15.25 min
 15.26  [Playtest] finished armfmkr team 0 at 15.26 min
 15.50  [Playtest] finished armfmkr team 0 at 15.50 min
 15.74  [Playtest] finished armfmkr team 0 at 15.74 min
 16.00  [Playtest] finished armtide team 0 at 16.00 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +65.9 bank 2148/2550, energy +681.0 bank 3065/3400, units 127
 16.29  [Playtest] finished armfmkr team 0 at 16.29 min
 16.37  [Playtest] finished armtide team 0 at 16.37 min
 16.59  [Playtest] finished armtide team 0 at 16.59 min
 16.60  [Playtest] finished armfmkr team 0 at 16.60 min
 16.69  [Playtest] finished armtide team 0 at 16.69 min
 16.84  [Playtest] finished armtide team 0 at 16.84 min
 16.94  [Playtest] finished armfmkr team 0 at 16.94 min
 16.98  [Playtest] finished armfrad team 0 at 16.98 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +60.9 bank 2451/2500, energy +763.0 bank 2762/3650, units 138
 17.03  [Playtest] finished armtide team 0 at 17.03 min
 17.11  [Playtest] finished armfmkr team 0 at 17.11 min
 17.29  [Playtest] finished armfmkr team 0 at 17.29 min
 17.56  [Playtest] finished armtide team 0 at 17.56 min
 17.69  [Playtest] finished armtide team 0 at 17.69 min
 17.71  [Playtest] finished armmex team 0 at 17.71 min
 17.79  [Playtest] finished armtide team 0 at 17.79 min
 17.87  [Playtest] finished armtide team 0 at 17.87 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +70.9 bank 2538/2550, energy +852.0 bank 3455/4000, units 141
 18.01  [Playtest] finished armtide team 0 at 18.01 min
 18.19  [Playtest] finished armtide team 0 at 18.19 min
 18.31  [Playtest] finished armmex team 0 at 18.31 min
 18.33  [Playtest] finished armtide team 0 at 18.33 min
 18.44  [Playtest] finished armtide team 0 at 18.44 min
 18.66  [Playtest] finished armtide team 0 at 18.66 min
 18.75  [Playtest] finished armtide team 0 at 18.75 min
 18.81  [Playtest] finished armtide team 0 at 18.81 min
 19.00  [Playtest] finished armtide team 0 at 19.00 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +72.9 bank 2585/2600, energy +950.0 bank 3877/4350, units 145
 19.30  [Playtest] finished armtide team 0 at 19.30 min
 19.52  [Playtest] finished armtide team 0 at 19.52 min
 19.61  [Playtest] finished armtide team 0 at 19.61 min
 19.85  [Playtest] finished armtide team 0 at 19.85 min
 19.93  [Playtest] finished armtide team 0 at 19.93 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +72.9 bank 2169/2600, energy +1040.0 bank 3672/4600, units 153
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.01  [Playtest] finished armasy team 0 at 20.01 min
 20.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 20.16  [Playtest] finished armtide team 0 at 20.16 min
 20.44  [Playtest] finished armrad team 0 at 20.44 min
 20.55  [Playtest] finished armfmkr team 0 at 20.55 min
 20.65  [Playtest] finished armtide team 0 at 20.65 min
 20.75  [Playtest] finished armmex team 0 at 20.75 min
 20.86  [Playtest] finished armtide team 0 at 20.86 min
 20.97  [Playtest] finished armtide team 0 at 20.97 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +65.1 bank 1747/2850, energy +1130.0 bank 3913/5150, units 169
 21.04  [Playtest] finished armnanotcplat team 0 at 21.04 min
 21.11  [Playtest] finished armtide team 0 at 21.11 min
 21.12  [Playtest] finished armuwmme team 0 at 21.12 min
 21.38  [Playtest] finished armnanotcplat team 0 at 21.38 min
 21.41  [Playtest] finished armtide team 0 at 21.41 min
 21.72  [Playtest] finished armtide team 0 at 21.72 min
 21.89  [Playtest] finished armuwmme team 0 at 21.89 min
 22.00  [Playtest] finished armuwmme team 0 at 22.00 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +81.7 bank 195/4500, energy +1505.0 bank 5418/6950, units 177
 22.51  [Playtest] finished armuwmme team 0 at 22.51 min
 22.78  [Playtest] finished armuwmme team 0 at 22.78 min
 22.98  [Playtest] finished armnanotcplat team 0 at 22.98 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +96.7 bank 79/5600, energy +1505.0 bank 5195/6950, units 184
 23.28  [Playtest] finished armmex team 0 at 23.28 min
 23.48  [Playtest] finished armuwmme team 0 at 23.48 min
 23.64  [Playtest] finished armmex team 0 at 23.64 min
 23.87  [Playtest] finished armuwmme team 0 at 23.87 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +123.2 bank 490/6800, energy +1505.0 bank 1464/6950, units 196
 24.30  [Playtest] finished armuwmme team 0 at 24.30 min
 24.33  [Playtest] finished armtide team 0 at 24.33 min
 24.39  [Playtest] finished armtl team 0 at 24.39 min
 24.63  [SEA][Layout] berth sea.berth.4 corsy at=3840,1984 facing=3
 24.67  [Playtest] finished armuwmme team 0 at 24.67 min
 24.73  [Playtest] finished armnanotcplat team 0 at 24.73 min
 24.74  [Playtest] finished armmex team 0 at 24.74 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +123.8 bank 1387/7950, energy +1527.0 bank 1130/7050, units 206
 25.32  [Playtest] finished armtide team 0 at 25.32 min
 25.34  [Playtest] finished armuwmme team 0 at 25.34 min
 25.46  [Playtest] finished armuwmme team 0 at 25.46 min
 25.52  [Playtest] finished armmex team 0 at 25.52 min
 25.80  [Playtest] finished armnanotcplat team 0 at 25.80 min
 25.97  [Playtest] finished armnanotcplat team 0 at 25.97 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +137.8 bank 4467/9100, energy +1542.0 bank 1817/7100, units 217
 26.23  [Playtest] finished armuwmme team 0 at 26.23 min
 26.31  [Playtest] finished armtl team 0 at 26.31 min
 26.48  [Playtest] finished armtide team 0 at 26.48 min
 26.50  [Playtest] finished armuwmme team 0 at 26.50 min
 26.85  [Playtest] finished armnanotcplat team 0 at 26.85 min
 26.98  [Playtest] finished armtl team 0 at 26.98 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +149.8 bank 7271/10200, energy +1557.0 bank 572/7150, units 225
 27.26  [Playtest] finished armtl team 0 at 27.26 min
 27.37  [Playtest] finished armuwmme team 0 at 27.37 min
 27.50  [Playtest] finished armtl team 0 at 27.50 min
 27.70  [Playtest] finished armtl team 0 at 27.70 min
 27.91  [Playtest] finished armtl team 0 at 27.91 min
 27.95  [Playtest] finished armuwmme team 0 at 27.95 min
 27.97  [Playtest] finished armtide team 0 at 27.97 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +161.7 bank 11208/11300, energy +1572.0 bank 1018/7200, units 236
 28.08  [Playtest] finished armtl team 0 at 28.08 min
 28.14  [Playtest] finished armtl team 0 at 28.14 min
 28.42  [Playtest] finished armtl team 0 at 28.42 min
 28.59  [Playtest] finished armtl team 0 at 28.59 min
 28.72  [Playtest] finished armatl team 0 at 28.72 min
 28.89  [Playtest] finished armtl team 0 at 28.89 min
 28.96  [Playtest] finished armtl team 0 at 28.96 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +162.5 bank 11291/11300, energy +1572.0 bank 5154/7200, units 248
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 29.03  [Playtest] finished armtl team 0 at 29.03 min
 29.06  [Playtest] finished armuwmme team 0 at 29.06 min
 29.49  [Playtest] finished armtide team 0 at 29.49 min
 29.69  [Playtest] finished armtl team 0 at 29.69 min
 29.83  [Playtest] finished armtide team 0 at 29.83 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +167.7 bank 11843/11850, energy +1602.0 bank 2647/7300, units 261
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(891) at (5342, 796) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(28578) at (7814, 1506) walks to (7847, 1506), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(22737) at (9044, 11418) walks to (9370, 11502), 139 from the cormex site (9504, 11536)
  0.10  RESERVE: zone 1 at (4096, 2096) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (4096, 2096) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (4096, 2384) facing 0, 12x30 cells: 356 of 360 held
  0.10  RESERVE: zone 3 at (4040, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4040, 1880) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (4104, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1880) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (4168, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1880) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (4040, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4040, 1944) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (4104, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1944) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (4168, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1944) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (4096, 1904) facing 0, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (7808, 1504) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7808, 1504) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (7808, 1792) facing 0, 12x30 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (7752, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7752, 1288) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7816, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7816, 1288) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7880, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7880, 1288) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7752, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7752, 1352) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7816, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7816, 1352) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7880, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7880, 1352) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (7808, 1312) facing 0, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (9040, 11424) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: corsy at (9040, 11424) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (9040, 11136) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (9112, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9112, 11656) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (9048, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9048, 11656) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (8984, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (8984, 11656) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (9112, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9112, 11592) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (9048, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9048, 11592) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (8984, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (8984, 11592) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (9040, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.11  EXP: idle: legcom(28578) on legmex at (7840, 1506), site (7984, 1504), target yes, fails 2 (arrived at the approach point)
  0.12  RESERVE: zone 10 at (4496, 2096) facing 0, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (4496, 2096) facing 0 (id 8)
  0.12  RESERVE: corridor 11 at (4496, 2432) facing 0, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (4536, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4536, 1880) facing 0 (id 9)
  0.12  RESERVE: zone 13 at (4600, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4600, 1880) facing 0 (id 10)
  0.12  RESERVE: zone 14 at (4664, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4664, 1880) facing 0 (id 11)
  0.12  RESERVE: zone 15 at (4536, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4536, 1944) facing 0 (id 12)
  0.12  RESERVE: zone 16 at (4600, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4600, 1944) facing 0 (id 13)
  0.12  RESERVE: zone 17 at (4664, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4664, 1944) facing 0 (id 14)
  0.12  RESERVE: zone 18 at (4592, 1904) facing 0, 12x8 cells: 42 of 96 held
  0.12  RESERVE: zone 10 at (8208, 1504) facing 0, 12x12 cells: 144 of 144 held
  0.12  RESERVE: legadvshipyard at (8208, 1504) facing 0 (id 8)
  0.12  RESERVE: corridor 11 at (8208, 1840) facing 0, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (8248, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8248, 1288) facing 0 (id 9)
  0.12  RESERVE: zone 13 at (8312, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8312, 1288) facing 0 (id 10)
  0.12  RESERVE: zone 14 at (8376, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8376, 1288) facing 0 (id 11)
  0.12  RESERVE: zone 15 at (8248, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8248, 1352) facing 0 (id 12)
  0.12  RESERVE: zone 16 at (8312, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8312, 1352) facing 0 (id 13)
  0.12  RESERVE: zone 17 at (8376, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8376, 1352) facing 0 (id 14)
  0.12  RESERVE: zone 18 at (8304, 1312) facing 0, 12x8 cells: 42 of 96 held
  0.12  RESERVE: zone 10 at (8640, 11424) facing 2, 12x12 cells: 144 of 144 held
  0.12  RESERVE: corasy at (8640, 11424) facing 2 (id 8)
  0.12  RESERVE: corridor 11 at (8640, 11088) facing 2, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (8808, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8808, 11656) facing 2 (id 9)
  0.12  RESERVE: zone 13 at (8744, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8744, 11656) facing 2 (id 10)
  0.12  RESERVE: zone 14 at (8680, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8680, 11656) facing 2 (id 11)
  0.12  RESERVE: zone 15 at (8808, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8808, 11592) facing 2 (id 12)
  0.12  RESERVE: zone 16 at (8744, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8744, 11592) facing 2 (id 13)
  0.12  RESERVE: zone 17 at (8680, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8680, 11592) facing 2 (id 14)
  0.12  RESERVE: zone 18 at (8736, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.13  RESERVE: zone 19 at (4896, 2096) facing 0, 12x12 cells: 144 of 144 held
  0.13  RESERVE: armasy at (4896, 2096) facing 0 (id 15)
  0.13  RESERVE: corridor 20 at (4896, 2432) facing 0, 18x30 cells: 540 of 540 held
  0.13  RESERVE: zone 21 at (4920, 1912) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (4920, 1912) facing 0 (id 16)
  0.13  RESERVE: zone 22 at (4984, 1912) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (4984, 1912) facing 0 (id 17)
  0.13  RESERVE: zone 23 at (5048, 1912) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (5048, 1912) facing 0 (id 18)
  0.13  RESERVE: zone 24 at (4920, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (4920, 1976) facing 0 (id 19)
  0.13  RESERVE: zone 25 at (4984, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (4984, 1976) facing 0 (id 20)
  0.13  RESERVE: zone 26 at (5048, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (5048, 1976) facing 0 (id 21)
  0.13  RESERVE: zone 27 at (4985, 1941) facing 0, 13x9 cells: 56 of 117 held
  0.14  RESERVE: zone 19 at (8240, 11424) facing 2, 12x12 cells: 144 of 144 held
  0.14  RESERVE: corasy at (8240, 11424) facing 2 (id 15)
  0.14  RESERVE: corridor 20 at (8240, 11088) facing 2, 18x30 cells: 516 of 540 held
  0.14  RESERVE: zone 21 at (8392, 11688) facing 2, 3x3 cells: 9 of 9 held
```
