# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54062); wall 342 s
- DLL: build-theatres\d189-build-5\SkirmishAI.dll (1b875078bc2aa763); AI BARbTest/test; staged 2026-10-04T07:22:54
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T102254Z-a5e8b343\runs\20261004T102840Z-ffb76a56\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:38.755536][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.5 min | `[t=00:00:58.571433][f=0000939] [SeaWatch] finished frame=939 id=7159 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 2.6 min | `[t=00:01:07.571465][f=0004620] [SeaWatch] egress id=5244 yard=7159 seconds=14.2 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T102254Z-a5e8b343\runs\20261004T102840Z-ffb76a56\screen_2026-10-04_10-24-17-981.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T102254Z-a5e8b343\runs\20261004T102840Z-ffb76a56\screen_2026-10-04_10-24-46-300.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T102254Z-a5e8b343\runs\20261004T102840Z-ffb76a56\screen_2026-10-04_10-26-28-841.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T102254Z-a5e8b343\runs\20261004T102840Z-ffb76a56\screen_2026-10-04_10-28-26-103.png

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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4093|2106|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5343,796) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7825,1501) factory=legsy landLocked=no spot=6 known=3/3
  0.17  [SEA][Layout] berth sea.berth.0 armsy at=4000,2144 facing=0
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.18  [SEA][Layout] berth sea.berth.1 armasy at=4496,2112 facing=0
  0.20  [SEA][Layout] berth sea.berth.2 armasy at=4896,2112 facing=0
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 12850 at 4016,2016
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4093|2106|0|3|1|4016|2016
  0.22  [Team][Roster] team 3 first mex at 7984,1504
  0.28  [Team][Roster] team 1 first mex at 5136,752
  0.52  [Playtest] finished armsy team 0 at 0.52 min
  0.82  [Playtest] finished armtide team 0 at 0.82 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 466/1150, energy +45.0 bank 77/1150, units 6
  1.04  [Playtest] finished armtide team 0 at 1.04 min
  1.21  [Playtest] finished armtide team 0 at 1.21 min
  1.59  [Playtest] finished armmex team 0 at 1.59 min
  1.94  [Playtest] finished armtl team 0 at 1.94 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 220/1200, energy +82.0 bank 188/1300, units 10
  2.29  [Playtest] finished armtide team 0 at 2.29 min
  2.32  [Playtest] finished armtide team 0 at 2.32 min
  2.63  [Playtest] finished armmex team 0 at 2.63 min
  2.64  [Playtest] finished armtide team 0 at 2.64 min
  2.95  [Playtest] finished armmex team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 258/1300, energy +134.0 bank 1255/1500, units 18
  3.09  [Playtest] finished armtide team 0 at 3.09 min
  3.25  [Playtest] finished armmex team 0 at 3.25 min
  3.40  [Playtest] finished armtide team 0 at 3.40 min
  3.71  [Playtest] finished armtide team 0 at 3.71 min
  3.72  [Playtest] finished armmex team 0 at 3.72 min
  3.83  [Playtest] finished armmex team 0 at 3.83 min
  3.98  [Playtest] finished armtl team 0 at 3.98 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +16.0 bank 221/1450, energy +179.0 bank 265/1650, units 27
  4.09  [Playtest] finished armtide team 0 at 4.09 min
  4.15  [Playtest] finished armmex team 0 at 4.15 min
  4.41  [Playtest] finished armtide team 0 at 4.41 min
  4.67  [Playtest] finished armtl team 0 at 4.67 min
  4.73  [Playtest] finished armtide team 0 at 4.73 min
  4.95  [Playtest] finished armfrad team 0 at 4.95 min
  4.97  [Playtest] finished armmex team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.0 bank 284/1550, energy +224.0 bank 1787/1800, units 34
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.28  [Playtest] finished armmex team 0 at 5.28 min
  5.29  [Playtest] finished armtl team 0 at 5.29 min
  5.29  [Playtest] finished armmex team 0 at 5.29 min
  5.53  [Playtest] finished armtl team 0 at 5.53 min
  5.62  [Playtest] finished armtide team 0 at 5.62 min
  5.73  [Playtest] finished armfrad team 0 at 5.73 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.0 bank 612/1650, energy +239.0 bank 1833/1850, units 42
  6.02  [Playtest] finished armtide team 0 at 6.02 min
  6.36  [Playtest] finished armtide team 0 at 6.36 min
  6.56  [Playtest] finished armmex team 0 at 6.56 min
  6.58  [Playtest] finished armtl team 0 at 6.58 min
  6.68  [Playtest] finished armtide team 0 at 6.68 min
  6.72  [Playtest] finished armtide team 0 at 6.72 min
  6.91  [Playtest] finished armtl team 0 at 6.91 min
  7.00  [Playtest] finished armtide team 0 at 7.00 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.0 bank 681/1700, energy +306.0 bank 2107/2150, units 47
  7.18  [Playtest] finished armmex team 0 at 7.18 min
  7.33  [Playtest] finished armtide team 0 at 7.33 min
  7.48  [Playtest] finished armmex team 0 at 7.48 min
  7.54  [Playtest] finished armtide team 0 at 7.54 min
  7.65  [Playtest] finished armtide team 0 at 7.65 min
  7.86  [Playtest] finished armtide team 0 at 7.86 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +30.0 bank 1162/1800, energy +381.0 bank 2334/2350, units 55
  8.54  [Playtest] finished armnanotcplat team 0 at 8.54 min
  8.62  [Playtest] finished armnanotcplat team 0 at 8.62 min
  8.69  [Playtest] finished armtide team 0 at 8.69 min
  8.77  [Playtest] finished armtide team 0 at 8.77 min
  8.85  [Playtest] finished armtide team 0 at 8.85 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +28.0 bank 1443/1750, energy +426.0 bank 2493/2500, units 59
  9.04  [Playtest] finished armtide team 0 at 9.04 min
  9.09  [Playtest] finished armfmkr team 0 at 9.09 min
  9.17  [Playtest] finished armtide team 0 at 9.17 min
  9.22  [Playtest] finished armtide team 0 at 9.22 min
  9.35  [Playtest] finished armtide team 0 at 9.35 min
  9.40  [Playtest] finished armfmkr team 0 at 9.40 min
  9.43  [Playtest] finished armtide team 0 at 9.43 min
  9.57  [Playtest] finished armfmkr team 0 at 9.57 min
  9.71  [Playtest] finished armfmkr team 0 at 9.70 min
  9.71  [Playtest] finished armmex team 0 at 9.71 min
  9.85  [Playtest] finished armtide team 0 at 9.85 min
  9.88  [Playtest] finished armfmkr team 0 at 9.88 min
  9.91  [Playtest] finished armtide team 0 at 9.91 min
  9.95  [Playtest] finished armtl team 0 at 9.95 min
  9.99  [Playtest] finished armtide team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +33.0 bank 1216/1750, energy +538.0 bank 2688/2950, units 77
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.05  [Playtest] finished armfmkr team 0 at 10.05 min
 10.17  [Playtest] finished armtide team 0 at 10.17 min
 10.23  [Playtest] finished armtide team 0 at 10.23 min
 10.31  [Playtest] finished armtide team 0 at 10.31 min
 10.37  [Playtest] finished armtide team 0 at 10.37 min
 10.57  [Playtest] finished armtide team 0 at 10.57 min
 10.63  [Playtest] finished armtide team 0 at 10.63 min
 10.70  [Playtest] finished armtide team 0 at 10.69 min
 10.89  [Playtest] finished armtide team 0 at 10.89 min
 10.92  [Playtest] finished armfmkr team 0 at 10.92 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +35.0 bank 388/1750, energy +673.0 bank 3018/3350, units 84
 11.29  [Playtest] finished armfmkr team 0 at 11.29 min
 11.30  [Playtest] finished armtide team 0 at 11.30 min
 11.43  [Playtest] finished armtide team 0 at 11.43 min
 11.46  [Playtest] finished armtl team 0 at 11.46 min
 11.62  [Playtest] finished armtide team 0 at 11.62 min
 11.66  [Playtest] finished armfmkr team 0 at 11.66 min
 11.79  [Playtest] finished armfmkr team 0 at 11.79 min
 11.96  [Playtest] finished armtide team 0 at 11.96 min
 11.96  [Playtest] finished armfmkr team 0 at 11.96 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +39.0 bank 278/1750, energy +733.0 bank 3030/3550, units 97
 12.20  [Playtest] finished armtide team 0 at 12.20 min
 12.29  [Playtest] finished armtide team 0 at 12.29 min
 12.53  [Playtest] finished armtide team 0 at 12.53 min
 12.68  [Playtest] finished armtide team 0 at 12.68 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +39.0 bank 74/1750, energy +793.0 bank 3436/3750, units 104
 13.02  [Playtest] finished armtide team 0 at 13.02 min
 13.22  [Playtest] finished armtide team 0 at 13.22 min
 13.39  [Playtest] finished armtide team 0 at 13.39 min
 13.42  [Playtest] finished armmex team 0 at 13.42 min
 13.58  [Playtest] finished armtide team 0 at 13.58 min
 13.71  [Playtest] finished armtide team 0 at 13.70 min
 13.75  [Playtest] finished armmex team 0 at 13.75 min
 13.90  [Playtest] finished armfmkr team 0 at 13.90 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +44.0 bank 1055/1850, energy +868.0 bank 3789/4000, units 107
 14.39  [Playtest] finished armtide team 0 at 14.39 min
 14.45  [Playtest] finished armmex team 0 at 14.45 min
 14.73  [Playtest] finished armtide team 0 at 14.73 min
 14.80  [Playtest] finished armmex team 0 at 14.80 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +42.6 bank 1236/1950, energy +898.0 bank 3273/4100, units 117
 15.07  [Playtest] finished armtide team 0 at 15.07 min
 15.39  [Playtest] finished armtide team 0 at 15.39 min
 15.53  [Playtest] finished armmex team 0 at 15.53 min
 15.71  [Playtest] finished armtide team 0 at 15.71 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +49.9 bank 18/2000, energy +943.0 bank 3944/4250, units 120
 16.25  [Playtest] finished armasy team 0 at 16.25 min
 16.29  [Playtest] finished armtide team 0 at 16.29 min
 16.78  [Playtest] finished armtide team 0 at 16.78 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +47.1 bank 19/2200, energy +1003.0 bank 3960/4700, units 132
 17.00  [Playtest] finished armtl team 0 at 17.00 min
 17.19  [Playtest] finished armfmkr team 0 at 17.19 min
 17.24  [Playtest] finished armfrad team 0 at 17.24 min
 17.36  [Playtest] finished armfmkr team 0 at 17.36 min
 17.51  [Playtest] finished armtide team 0 at 17.51 min
 17.63  [Playtest] finished armfmkr team 0 at 17.63 min
 17.78  [Playtest] finished armuwmme team 0 at 17.78 min
 17.84  [Playtest] finished armfmkr team 0 at 17.84 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +53.0 bank 0/2750, energy +1048.0 bank 3818/4900, units 139
 18.01  [Playtest] finished armfmkr team 0 at 18.01 min
 18.22  [Playtest] finished armfmkr team 0 at 18.22 min
 18.52  [Playtest] finished armtl team 0 at 18.52 min
 18.77  [Playtest] finished armuwmme team 0 at 18.77 min
 18.81  [Playtest] finished armtide team 0 at 18.81 min
 18.93  [Playtest] finished armuwmme team 0 at 18.93 min
 19.00  [Playtest] finished armtide team 0 at 19.00 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +73.9 bank 487/3850, energy +1363.0 bank 5673/6500, units 138
 19.08  [Playtest] finished armtide team 0 at 19.08 min
 19.55  [Playtest] finished armuwmme team 0 at 19.55 min
 19.95  [Playtest] finished armuwmme team 0 at 19.95 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +75.9 bank 38/4950, energy +1393.0 bank 5164/6550, units 141
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 20.40  [Playtest] finished armuwmme team 0 at 20.40 min
 20.40  [Playtest] finished armtide team 0 at 20.40 min
 20.59  [Playtest] finished armmship team 0 at 20.59 min
 20.86  [Playtest] finished armfmkr team 0 at 20.86 min
 20.97  [Playtest] finished armmex team 0 at 20.97 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +83.1 bank 13/5550, energy +1408.0 bank 5157/6600, units 143
 21.03  [Playtest] finished armuwmme team 0 at 21.03 min
 21.33  [Playtest] finished armmship team 0 at 21.33 min
 21.36  [Playtest] finished armmex team 0 at 21.36 min
 21.46  [Playtest] finished armtl team 0 at 21.46 min
 21.48  [Playtest] finished armuwmme team 0 at 21.48 min
 21.73  [Playtest] finished armfrad team 0 at 21.73 min
 21.86  [Playtest] finished armuwmme team 0 at 21.86 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +97.3 bank 206/7200, energy +1401.0 bank 5087/6550, units 141
 22.27  [Playtest] finished armuwmme team 0 at 22.27 min
 22.70  [Playtest] finished armnanotcplat team 0 at 22.70 min
 22.78  [Playtest] finished armuwmme team 0 at 22.78 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +104.1 bank 1466/8250, energy +1115.0 bank 3770/5150, units 141
 23.07  [Playtest] finished armuwmme team 0 at 23.07 min
 23.28  [SEA][Layout] berth sea.berth.3 corsy at=4272,2176 facing=0
 23.42  [Playtest] finished armuwmme team 0 at 23.42 min
 23.59  [Playtest] finished armtide team 0 at 23.59 min
 23.90  [Playtest] finished armtide team 0 at 23.90 min
 23.91  [Playtest] finished armtide team 0 at 23.91 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +115.8 bank 1735/9350, energy +1467.0 bank 3197/6850, units 146
 24.07  [Playtest] finished armatl team 0 at 24.07 min
 24.17  [Playtest] finished armtide team 0 at 24.17 min
 24.47  [Playtest] finished armfrad team 0 at 24.47 min
 24.63  [Playtest] finished armmex team 0 at 24.63 min
 24.82  [Playtest] finished armbats team 0 at 24.82 min
 24.98  [Playtest] finished armnanotcplat team 0 at 24.98 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +122.2 bank 3620/9400, energy +1468.0 bank 5312/6800, units 156
 25.29  [Playtest] finished armmex team 0 at 25.29 min
 25.62  [Playtest] finished armtide team 0 at 25.62 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +117.8 bank 4489/9400, energy +1183.0 bank 2486/5350, units 157
 26.59  [Playtest] finished armuwmme team 0 at 26.58 min
 26.87  [Playtest] finished armtide team 0 at 26.87 min
 26.87  [Playtest] finished armuwfus team 0 at 26.87 min
 26.97  [Playtest] finished armfrad team 0 at 26.97 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +134.8 bank 4996/9350, energy +2712.0 bank 9264/9500, units 153
 27.15  [Playtest] finished armnanotcplat team 0 at 27.15 min
 27.36  [Playtest] finished armnanotcplat team 0 at 27.36 min
 27.55  [Playtest] finished armnanotcplat team 0 at 27.56 min
 27.77  [Playtest] finished armtl team 0 at 27.77 min
 27.80  [Playtest] finished armbats team 0 at 27.80 min
 27.89  [Playtest] finished armnanotcplat team 0 at 27.89 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +124.4 bank 5266/9350, energy +2577.0 bank 7069/9050, units 153
 28.09  [Playtest] finished armtl team 0 at 28.09 min
 28.40  [Playtest] finished armtl team 0 at 28.40 min
 28.51  [Playtest] finished armfrad team 0 at 28.51 min
 28.98  [Playtest] finished armnanotcplat team 0 at 28.99 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +122.7 bank 5236/9350, energy +2172.0 bank 5926/7250, units 147
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 29.13  [Playtest] finished armnanotcplat team 0 at 29.13 min
 29.41  [Playtest] finished armfrad team 0 at 29.41 min
 29.63  [Playtest] finished armuwfus team 0 at 29.63 min
 29.67  [Playtest] finished armnanotcplat team 0 at 29.67 min
 29.75  [Playtest] finished armnanotcplat team 0 at 29.75 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +224.8 bank 4994/9350, energy +3582.0 bank 10848/10900, units 144
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(891) at (5344, 796) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(28578) at (7825, 1501) walks to (7847, 1502), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(22737) at (9042, 11418) walks to (9370, 11502), 139 from the cormex site (9504, 11536)
  0.10  RESERVE: zone 1 at (7824, 1504) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7824, 1504) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (7824, 1792) facing 0, 12x30 cells: 348 of 360 held
  0.10  RESERVE: zone 3 at (7768, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1288) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7832, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7832, 1288) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7896, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1288) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7768, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1352) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7832, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7832, 1352) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7896, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1352) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (7824, 1312) facing 0, 12x8 cells: 42 of 96 held
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
  0.11  EXP: idle: legcom(28578) on legmex at (7839, 1501), site (7984, 1504), target yes, fails 2 (arrived at the approach point)
  0.12  RESERVE: zone 10 at (8224, 1504) facing 0, 12x12 cells: 144 of 144 held
  0.12  RESERVE: legadvshipyard at (8224, 1504) facing 0 (id 8)
  0.12  RESERVE: corridor 11 at (8224, 1840) facing 0, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (8264, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8264, 1288) facing 0 (id 9)
  0.12  RESERVE: zone 13 at (8328, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8328, 1288) facing 0 (id 10)
  0.12  RESERVE: zone 14 at (8392, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8392, 1288) facing 0 (id 11)
  0.12  RESERVE: zone 15 at (8264, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8264, 1352) facing 0 (id 12)
  0.12  RESERVE: zone 16 at (8328, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8328, 1352) facing 0 (id 13)
  0.12  RESERVE: zone 17 at (8392, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8392, 1352) facing 0 (id 14)
  0.12  RESERVE: zone 18 at (8320, 1312) facing 0, 12x8 cells: 42 of 96 held
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
  0.14  RESERVE: zone 19 at (8240, 11424) facing 2, 12x12 cells: 144 of 144 held
  0.14  RESERVE: corasy at (8240, 11424) facing 2 (id 15)
  0.14  RESERVE: corridor 20 at (8240, 11088) facing 2, 18x30 cells: 516 of 540 held
  0.14  RESERVE: zone 21 at (8392, 11688) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8392, 11688) facing 2 (id 16)
  0.14  RESERVE: zone 22 at (8328, 11688) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8328, 11688) facing 2 (id 17)
  0.14  RESERVE: zone 23 at (8264, 11688) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8264, 11688) facing 2 (id 18)
  0.14  RESERVE: zone 24 at (8392, 11624) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8392, 11624) facing 2 (id 19)
  0.14  RESERVE: zone 25 at (8328, 11624) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8328, 11624) facing 2 (id 20)
  0.14  RESERVE: zone 26 at (8264, 11624) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8264, 11624) facing 2 (id 21)
  0.14  RESERVE: zone 27 at (8329, 11653) facing 2, 13x9 cells: 63 of 117 held
  0.17  RESERVE: zone 1 at (4000, 2144) facing 0, 6x6 cells: 36 of 36 held
  0.17  RESERVE: armsy at (4000, 2144) facing 0 (id 1)
  0.17  RESERVE: corridor 2 at (4000, 2432) facing 0, 12x30 cells: 344 of 360 held
  0.17  RESERVE: zone 3 at (3944, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (3944, 1928) facing 0 (id 2)
  0.17  RESERVE: zone 4 at (4008, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4008, 1928) facing 0 (id 3)
  0.17  RESERVE: zone 5 at (4072, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4072, 1928) facing 0 (id 4)
  0.17  RESERVE: zone 6 at (3944, 1992) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (3944, 1992) facing 0 (id 5)
  0.17  RESERVE: zone 3 released
  0.17  RESERVE: zone 4 released
  0.17  RESERVE: zone 5 released
  0.17  RESERVE: zone 6 released
  0.17  RESERVE: zone 7 at (4040, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4040, 1928) facing 0 (id 6)
  0.17  RESERVE: zone 8 at (4104, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4104, 1928) facing 0 (id 7)
  0.17  RESERVE: zone 9 at (4168, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4168, 1928) facing 0 (id 8)
  0.17  RESERVE: zone 7 released
  0.17  RESERVE: zone 8 released
  0.17  RESERVE: zone 9 released
  0.17  RESERVE: zone 10 at (4024, 1960) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4024, 1960) facing 0 (id 9)
  0.17  RESERVE: zone 11 at (4088, 1960) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4088, 1960) facing 0 (id 10)
  0.17  RESERVE: zone 12 at (4152, 1960) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4152, 1960) facing 0 (id 11)
  0.17  RESERVE: zone 10 released
  0.17  RESERVE: zone 11 released
  0.17  RESERVE: zone 12 released
  0.17  RESERVE: zone 13 at (3944, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (3944, 2024) facing 0 (id 12)
  0.17  RESERVE: zone 13 released
```
