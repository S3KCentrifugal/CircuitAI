# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54000); wall 192 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:45:12
- Map: Erebos Lakes v1.0; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T044511Z-705dbceb\runs\20261004T044827Z-59db53a9\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:45.929647][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.3 min | `[t=00:01:06.270633][f=0002421] [SeaWatch] finished frame=2421 id=17506 def=armsy builder=14021` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:01:11.473740][f=0004500] [SeaWatch] egress id=11927 yard=17506 seconds=4.8 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T044511Z-705dbceb\runs\20261004T044827Z-59db53a9\screen_2026-10-04_04-46-39-454.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T044511Z-705dbceb\runs\20261004T044827Z-59db53a9\screen_2026-10-04_04-47-01-211.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T044511Z-705dbceb\runs\20261004T044827Z-59db53a9\screen_2026-10-04_04-47-44-982.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T044511Z-705dbceb\runs\20261004T044827Z-59db53a9\screen_2026-10-04_04-48-22-604.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2076, 6352) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (8128, 3879) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2076, 6352) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (8128, 3879) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armmex team 0 at 0.17 min
  0.18  [Team][Roster] first mex 18833 at 2032,6192
  0.18  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2076|6349|0|3|1|2032|6192
  0.32  [Playtest] finished armmex team 0 at 0.32 min
  0.49  [Playtest] finished armmex team 0 at 0.49 min
  0.61  [Playtest] finished armwin team 0 at 0.61 min
  0.71  [Playtest] finished armwin team 0 at 0.71 min
  0.87  [Playtest] finished armwin team 0 at 0.87 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1085/1150, energy +69.9 bank 938/1001, units 7
  1.34  [Playtest] finished armsy team 0 at 1.35 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 774/1250, energy +78.7 bank 74/1151, units 10
  2.56  [Playtest] finished armtide team 0 at 2.56 min
  2.72  [Playtest] finished armtide team 0 at 2.72 min
  2.88  [Playtest] finished armtide team 0 at 2.88 min
  3.00  [Playtest] finished armtide team 0 at 3.00 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 291/1250, energy +151.5 bank 507/1401, units 18
  3.17  [Playtest] finished armtide team 0 at 3.17 min
  3.35  [Playtest] finished armtide team 0 at 3.35 min
  3.63  [Playtest] finished armtide team 0 at 3.63 min
  3.64  [Playtest] finished armmex team 0 at 3.64 min
  3.81  [Playtest] finished armtide team 0 at 3.81 min
  3.98  [Playtest] finished armtide team 0 at 3.98 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 1/1300, energy +243.0 bank 1643/1651, units 26
  4.06  [Playtest] finished armmex team 0 at 4.06 min
  4.20  [Playtest] finished armfmkr team 0 at 4.20 min
  4.52  [Playtest] finished armfmkr team 0 at 4.52 min
  4.56  [Playtest] finished armmex team 0 at 4.56 min
  4.83  [Playtest] finished armmex team 0 at 4.83 min
  4.84  [Playtest] finished armtide team 0 at 4.84 min
  4.96  [Playtest] finished armrad team 0 at 4.96 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +17.9 bank 0/1450, energy +270.6 bank 1396/1701, units 34
  5.00  [Playtest] target team 0 at (2076, 6352) from its start position
  5.00  [Playtest] camera requested (2076,6352) height=2200
  5.00  [Playtest] camera captured name=ta position=(2076,6352) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2076, 6352)
  5.09  [Playtest] finished armtide team 0 at 5.09 min
  5.30  [Playtest] finished armtide team 0 at 5.30 min
  5.47  [Playtest] finished armmex team 0 at 5.47 min
  5.50  [Playtest] finished armfmkr team 0 at 5.50 min
  5.70  [Playtest] finished armtide team 0 at 5.70 min
  5.78  [Playtest] finished armtl team 0 at 5.78 min
  5.88  [Playtest] finished armtide team 0 at 5.88 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +21.0 bank 0/1500, energy +363.5 bank 1795/1951, units 42
  6.04  [Playtest] finished armtide team 0 at 6.04 min
  6.22  [Playtest] finished armfmkr team 0 at 6.22 min
  6.33  [Playtest] finished armtide team 0 at 6.33 min
  6.45  [Playtest] finished armllt team 0 at 6.45 min
  6.53  [Playtest] finished armtide team 0 at 6.53 min
  6.69  [Playtest] finished armtide team 0 at 6.69 min
  6.84  [Playtest] finished armfmkr team 0 at 6.84 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.1 bank 103/1500, energy +443.8 bank 1757/2151, units 49
  7.03  [Playtest] finished armtide team 0 at 7.03 min
  7.17  [Playtest] finished armtide team 0 at 7.17 min
  7.18  [Playtest] finished armmex team 0 at 7.18 min
  7.32  [Playtest] finished armtide team 0 at 7.32 min
  7.47  [Playtest] finished armllt team 0 at 7.47 min
  7.56  [Playtest] finished armtide team 0 at 7.56 min
  7.64  [Playtest] finished armrad team 0 at 7.64 min
  7.80  [Playtest] finished armmex team 0 at 7.80 min
  7.94  [Playtest] finished armtide team 0 at 7.94 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +29.0 bank 195/1600, energy +528.1 bank 1960/2401, units 60
  8.28  [Playtest] finished armtide team 0 at 8.28 min
  8.39  [Playtest] finished armnanotcplat team 0 at 8.39 min
  8.67  [Playtest] finished armtide team 0 at 8.67 min
  8.81  [Playtest] finished armnanotcplat team 0 at 8.81 min
  8.99  [Playtest] finished armtide team 0 at 8.99 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +24.9 bank 123/1600, energy +565.9 bank 2021/2651, units 67
  9.53  [Playtest] finished armtide team 0 at 9.53 min
  9.57  [Playtest] finished armnanotcplat team 0 at 9.57 min
  9.62  [Playtest] finished armtl team 0 at 9.62 min
  9.88  [Playtest] finished armtide team 0 at 9.88 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +68.6 bank 125/1600, energy +645.3 bank 2114/2751, units 73
 10.00  [Playtest] camera requested (2076,6352) height=2200
 10.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (2076, 6352)
 10.05  [Playtest] finished armnanotcplat team 0 at 10.05 min
 10.21  [Playtest] finished armtide team 0 at 10.21 min
 10.42  [Playtest] finished armnanotcplat team 0 at 10.42 min
 10.47  [Playtest] finished armtide team 0 at 10.47 min
 10.49  [Playtest] finished armnanotcplat team 0 at 10.49 min
 10.58  [Playtest] finished armtide team 0 at 10.58 min
 10.65  [Playtest] finished armtide team 0 at 10.65 min
 10.91  [Playtest] finished armfmkr team 0 at 10.91 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +30.2 bank 13/1600, energy +739.8 bank 2704/2951, units 82
 11.11  [Playtest] finished armtide team 0 at 11.10 min
 11.34  [Playtest] finished armtide team 0 at 11.34 min
 11.53  [Playtest] finished armmex team 0 at 11.53 min
 11.84  [Playtest] finished armfmkr team 0 at 11.84 min
 11.87  [Playtest] finished armfmkr team 0 at 11.87 min
 11.92  [Playtest] finished armtl team 0 at 11.92 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +32.4 bank 16/1650, energy +740.5 bank 2519/3051, units 88
 12.08  [Playtest] finished armnanotcplat team 0 at 12.08 min
 12.19  [Playtest] finished armtide team 0 at 12.19 min
 12.29  [Playtest] finished armfrad team 0 at 12.29 min
 12.50  [Playtest] finished armtide team 0 at 12.50 min
 12.83  [Playtest] finished armtide team 0 at 12.83 min
 12.87  [Playtest] finished armnanotcplat team 0 at 12.87 min
 12.94  [Playtest] finished armtide team 0 at 12.94 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +89.3 bank 22/1650, energy +826.1 bank 2402/3251, units 99
 13.22  [Playtest] finished armtide team 0 at 13.22 min
 13.43  [Playtest] finished armtide team 0 at 13.43 min
 13.56  [Playtest] finished armtide team 0 at 13.56 min
 13.96  [Playtest] finished armtide team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +34.2 bank 13/1650, energy +898.5 bank 3386/3451, units 106
 14.37  [Playtest] finished armfmkr team 0 at 14.36 min
 14.74  [Playtest] finished armfmkr team 0 at 14.74 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +36.2 bank 0/1650, energy +932.2 bank 3350/3451, units 109
 15.12  [Playtest] finished armfmkr team 0 at 15.12 min
 15.30  [Playtest] finished armasy team 0 at 15.30 min
 15.51  [Playtest] finished armfmkr team 0 at 15.51 min
 15.71  [Playtest] finished armtide team 0 at 15.71 min
 15.84  [Playtest] finished armtide team 0 at 15.84 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +38.2 bank 258/1850, energy +1009.7 bank 3353/3901, units 115
 16.17  [Playtest] finished armtide team 0 at 16.17 min
 16.49  [Playtest] finished armtide team 0 at 16.49 min
 16.56  [Playtest] finished armuwmme team 0 at 16.56 min
 16.81  [Playtest] finished armtide team 0 at 16.81 min
 16.91  [Playtest] finished armmex team 0 at 16.91 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +40.1 bank 0/2450, energy +1073.0 bank 3438/4201, units 121
 17.20  [Playtest] finished armtl team 0 at 17.20 min
 17.51  [Playtest] finished armmex team 0 at 17.51 min
 17.61  [Playtest] finished armfrad team 0 at 17.61 min
 17.83  [Playtest] finished armnanotcplat team 0 at 17.83 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +45.3 bank 0/2500, energy +1086.0 bank 3468/4201, units 126
 19.00  [Playtest] eco team 0 at 19.0 min: metal +45.1 bank 0/2500, energy +1080.5 bank 3457/4201, units 127
 19.07  [Playtest] finished armuwadves team 0 at 19.07 min
 19.31  [Playtest] finished armmex team 0 at 19.31 min
 19.39  [Playtest] finished armmex team 0 at 19.39 min
 19.89  [Playtest] finished armuwfus team 0 at 19.89 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +52.2 bank 9/2600, energy +2280.6 bank 39972/46701, units 132
 20.00  [Playtest] camera requested (2076,6352) height=2200
 20.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (2076, 6352)
 20.11  [Playtest] finished armuwmme team 0 at 20.11 min
 20.44  [Playtest] finished armtl team 0 at 20.44 min
 20.72  [Playtest] finished armfrad team 0 at 20.72 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +58.2 bank 1692/3150, energy +2110.9 bank 46107/46251, units 127
 21.40  [Playtest] finished armuwmmm team 0 at 21.40 min
 21.52  [Playtest] finished armmex team 0 at 21.52 min
 21.70  [Playtest] finished armuwmmm team 0 at 21.70 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +156.9 bank 3199/3200, energy +1939.7 bank 35026/45801, units 122
 22.02  [Playtest] finished armmex team 0 at 22.02 min
 22.20  [Playtest] finished armuwadvms team 0 at 22.20 min
 22.29  [Playtest] finished armmex team 0 at 22.29 min
 22.48  [Playtest] finished armuwadvms team 0 at 22.49 min
 22.51  [Playtest] finished armmex team 0 at 22.51 min
 22.63  [Playtest] finished armuwmmm team 0 at 22.63 min
 22.89  [Playtest] finished armnanotcplat team 0 at 22.90 min
 22.99  [Playtest] finished armmex team 0 at 22.99 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +62.1 bank 3430/23400, energy +1712.2 bank 34211/45301, units 122
 23.09  [Playtest] finished armmship team 0 at 23.09 min
 23.26  [Playtest] finished armnanotcplat team 0 at 23.26 min
 23.46  [Playtest] finished armmex team 0 at 23.46 min
 23.48  [Playtest] finished armmship team 0 at 23.48 min
 23.81  [Playtest] finished armmex team 0 at 23.81 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +77.3 bank 6/23500, energy +1687.9 bank 34396/45201, units 126
 24.01  [Playtest] finished armnanotcplat team 0 at 24.01 min
 24.03  [Playtest] finished armmship team 0 at 24.03 min
 24.05  [Playtest] finished armmex team 0 at 24.05 min
 24.30  [Playtest] finished armmex team 0 at 24.30 min
 24.32  [Playtest] finished armnanotcplat team 0 at 24.32 min
 24.56  [Playtest] finished armmship team 0 at 24.56 min
 24.70  [Playtest] finished armmex team 0 at 24.70 min
 24.70  [Playtest] finished armmex team 0 at 24.70 min
 24.73  [Playtest] finished armnanotcplat team 0 at 24.73 min
 24.99  [Playtest] finished armmex team 0 at 24.99 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +84.2 bank 11/23750, energy +1697.9 bank 34373/45201, units 135
 25.06  [Playtest] finished armnanotcplat team 0 at 25.06 min
 25.13  [Playtest] finished armmship team 0 at 25.13 min
 25.27  [Playtest] finished armmex team 0 at 25.27 min
 25.32  [Playtest] finished armnanotcplat team 0 at 25.32 min
 25.35  [Playtest] finished armtl team 0 at 25.35 min
 25.55  [Playtest] finished armmex team 0 at 25.55 min
 25.60  [Playtest] finished armnanotcplat team 0 at 25.60 min
 25.69  [Playtest] finished armtl team 0 at 25.69 min
 25.77  [Playtest] finished armmex team 0 at 25.77 min
 25.96  [Playtest] finished armfrad team 0 at 25.96 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +92.8 bank 191/23900, energy +1997.8 bank 35544/46701, units 145
 26.13  [Playtest] finished armmex team 0 at 26.13 min
 26.52  [Playtest] finished armmex team 0 at 26.52 min
 26.77  [Playtest] finished armmex team 0 at 26.77 min
 26.89  [Playtest] finished armuwfus team 0 at 26.89 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +115.2 bank 246/24050, energy +3192.2 bank 37824/49201, units 150
 27.00  [Playtest] finished armfrad team 0 at 27.00 min
 27.02  [Playtest] finished armmex team 0 at 27.02 min
 27.15  [Playtest] finished armtl team 0 at 27.15 min
 27.33  [Playtest] finished armatl team 0 at 27.33 min
 27.38  [Playtest] finished armmex team 0 at 27.38 min
 27.63  [Playtest] finished armtl team 0 at 27.63 min
 27.67  [Playtest] finished armfrad team 0 at 27.67 min
 27.77  [Playtest] finished armatl team 0 at 27.77 min
 27.79  [Playtest] finished armmex team 0 at 27.79 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +106.6 bank 247/24200, energy +3064.4 bank 37598/48901, units 152
 28.06  [Playtest] finished armuwmme team 0 at 28.06 min
 28.46  [Playtest] finished armmex team 0 at 28.46 min
 28.60  [Playtest] finished armtl team 0 at 28.60 min
 28.63  [Playtest] finished armtl team 0 at 28.63 min
 28.76  [Playtest] finished armmex team 0 at 28.76 min
 28.98  [Playtest] finished armllt team 0 at 28.98 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +122.9 bank 256/24850, energy +2879.9 bank 36955/48401, units 146
 29.00  [Playtest] camera requested (2076,6352) height=2200
 29.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (2076, 6352)
 29.08  [Playtest] finished armrad team 0 at 29.08 min
 29.38  [Playtest] finished armepoch team 0 at 29.38 min
 29.82  [Playtest] finished armmex team 0 at 29.82 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +111.4 bank 802/24900, energy +2859.6 bank 36611/48401, units 153
```

## Native lines (all AIs, first 120)

```
  1.69  BUILDER: discarded 1 unused default task(s) in the last minute
  1.77  BUILDER: discarded 1 unused default task(s) in the last minute
  2.69  BUILDER: discarded 1 unused default task(s) in the last minute
  2.77  BUILDER: discarded 6 unused default task(s) in the last minute
  3.69  BUILDER: discarded 20 unused default task(s) in the last minute
  3.77  BUILDER: discarded 16 unused default task(s) in the last minute
  4.70  BUILDER: discarded 2 unused default task(s) in the last minute
  5.21  CBFactoryTask: no site for armtide in a usable armtide area near (7635, 4234); retrying without the area check
  5.21  CBFactoryTask: no site for armtide at all | origin (7635, 4234) elev -57 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
  5.22  BUILDER: discarded 1 unused default task(s) in the last minute
  5.70  BUILDER: discarded 5 unused default task(s) in the last minute
  6.23  BUILDER: discarded 2 unused default task(s) in the last minute
  6.70  BUILDER: discarded 22 unused default task(s) in the last minute
  7.23  BUILDER: discarded 6 unused default task(s) in the last minute
  7.71  BUILDER: discarded 92 unused default task(s) in the last minute
  8.24  BUILDER: discarded 2 unused default task(s) in the last minute
 10.10  BUILDER: discarded 1 unused default task(s) in the last minute
 10.48  BUILDER: discarded 1 unused default task(s) in the last minute
 11.11  BUILDER: discarded 45 unused default task(s) in the last minute
 11.49  BUILDER: discarded 2 unused default task(s) in the last minute
 12.14  BUILDER: discarded 1 unused default task(s) in the last minute
 12.84  BUILDER: discarded 1 unused default task(s) in the last minute
 13.27  BUILDER: discarded 1 unused default task(s) in the last minute
 13.86  BUILDER: discarded 2 unused default task(s) in the last minute
 14.05  CBFactoryTask: no site for armsy in a usable armrecl area near (9340, 2821); retrying without the area check
 14.05  CBFactoryTask: no site for armsy at all | origin (9340, 2821) elev 50 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 14.39  BUILDER: discarded 13 unused default task(s) in the last minute
 15.52  BUILDER: discarded 1 unused default task(s) in the last minute
 16.52  BUILDER: discarded 3 unused default task(s) in the last minute
 19.29  CBFactoryTask: no site for armsy in a usable armrecl area near (7612, 1954); retrying without the area check
 19.29  CBFactoryTask: no site for armsy at all | origin (7612, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.30  CBFactoryTask: no site for armsy in a usable armrecl area near (7608, 1956); retrying without the area check
 19.30  CBFactoryTask: no site for armsy at all | origin (7608, 1956) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.32  CBFactoryTask: no site for armsy in a usable armrecl area near (7612, 1952); retrying without the area check
 19.32  CBFactoryTask: no site for armsy at all | origin (7612, 1952) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.34  CBFactoryTask: no site for armsy in a usable armrecl area near (7615, 1955); retrying without the area check
 19.34  CBFactoryTask: no site for armsy at all | origin (7615, 1955) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.35  CBFactoryTask: no site for armsy in a usable armrecl area near (7610, 1955); retrying without the area check
 19.35  CBFactoryTask: no site for armsy at all | origin (7610, 1955) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.46  CBFactoryTask: no site for armsy in a usable armrecl area near (7611, 1954); retrying without the area check
 19.46  CBFactoryTask: no site for armsy at all | origin (7611, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.48  CBFactoryTask: no site for armsy in a usable armrecl area near (7611, 1955); retrying without the area check
 19.48  CBFactoryTask: no site for armsy at all | origin (7611, 1955) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.49  CBFactoryTask: no site for armsy in a usable armrecl area near (7611, 1954); retrying without the area check
 19.49  CBFactoryTask: no site for armsy at all | origin (7611, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.51  CBFactoryTask: no site for armsy in a usable armrecl area near (7610, 1959); retrying without the area check
 19.51  CBFactoryTask: no site for armsy at all | origin (7610, 1959) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.53  CBFactoryTask: no site for armsy in a usable armrecl area near (7609, 1954); retrying without the area check
 19.53  CBFactoryTask: no site for armsy at all | origin (7609, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.63  CBFactoryTask: no site for armsy in a usable armrecl area near (7612, 1955); retrying without the area check
 19.63  CBFactoryTask: no site for armsy at all | origin (7612, 1955) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.65  CBFactoryTask: no site for armsy in a usable armrecl area near (7614, 1956); retrying without the area check
 19.65  CBFactoryTask: no site for armsy at all | origin (7614, 1956) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.66  CBFactoryTask: no site for armsy in a usable armrecl area near (7613, 1957); retrying without the area check
 19.66  CBFactoryTask: no site for armsy at all | origin (7613, 1957) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.69  CBFactoryTask: no site for armsy in a usable armrecl area near (7612, 1959); retrying without the area check
 19.69  CBFactoryTask: no site for armsy at all | origin (7612, 1959) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.71  CBFactoryTask: no site for armsy in a usable armrecl area near (7614, 1954); retrying without the area check
 19.71  CBFactoryTask: no site for armsy at all | origin (7614, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.81  CBFactoryTask: no site for armsy in a usable armrecl area near (7607, 1953); retrying without the area check
 19.81  CBFactoryTask: no site for armsy at all | origin (7607, 1953) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.83  CBFactoryTask: no site for armsy in a usable armrecl area near (7612, 1959); retrying without the area check
 19.83  CBFactoryTask: no site for armsy at all | origin (7612, 1959) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.85  CBFactoryTask: no site for armsy in a usable armrecl area near (7609, 1954); retrying without the area check
 19.85  CBFactoryTask: no site for armsy at all | origin (7609, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.87  CBFactoryTask: no site for armsy in a usable armrecl area near (7613, 1953); retrying without the area check
 19.87  CBFactoryTask: no site for armsy at all | origin (7613, 1953) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.90  CBFactoryTask: no site for armsy in a usable armrecl area near (7614, 1959); retrying without the area check
 19.90  CBFactoryTask: no site for armsy at all | origin (7614, 1959) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.94  CBFactoryTask: no site for armsy in a usable armrecl area near (7611, 1955); retrying without the area check
 19.94  CBFactoryTask: no site for armsy at all | origin (7611, 1955) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.96  CBFactoryTask: no site for armsy in a usable armrecl area near (7610, 1957); retrying without the area check
 19.96  CBFactoryTask: no site for armsy at all | origin (7610, 1957) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.97  CBFactoryTask: no site for armsy in a usable armrecl area near (7610, 1957); retrying without the area check
 19.97  CBFactoryTask: no site for armsy at all | origin (7610, 1957) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 19.99  CBFactoryTask: no site for armsy in a usable armrecl area near (7609, 1955); retrying without the area check
 19.99  CBFactoryTask: no site for armsy at all | origin (7609, 1955) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.01  CBFactoryTask: no site for armsy in a usable armrecl area near (7612, 1953); retrying without the area check
 20.01  CBFactoryTask: no site for armsy at all | origin (7612, 1953) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.03  CBFactoryTask: no site for armsy in a usable armrecl area near (7608, 1958); retrying without the area check
 20.03  CBFactoryTask: no site for armsy at all | origin (7608, 1958) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.08  CBFactoryTask: no site for armsy in a usable armrecl area near (7614, 1952); retrying without the area check
 20.08  CBFactoryTask: no site for armsy at all | origin (7614, 1952) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.09  CBFactoryTask: no site for armsy in a usable armrecl area near (7615, 1954); retrying without the area check
 20.09  CBFactoryTask: no site for armsy at all | origin (7615, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.11  CBFactoryTask: no site for armsy in a usable armrecl area near (7611, 1956); retrying without the area check
 20.11  CBFactoryTask: no site for armsy at all | origin (7611, 1956) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.13  CBFactoryTask: no site for armsy in a usable armrecl area near (7614, 1958); retrying without the area check
 20.13  CBFactoryTask: no site for armsy at all | origin (7614, 1958) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.15  CBFactoryTask: no site for armsy in a usable armrecl area near (7612, 1959); retrying without the area check
 20.15  CBFactoryTask: no site for armsy at all | origin (7612, 1959) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.25  CBFactoryTask: no site for armsy in a usable armrecl area near (7609, 1956); retrying without the area check
 20.25  CBFactoryTask: no site for armsy at all | origin (7609, 1956) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.27  CBFactoryTask: no site for armsy in a usable armrecl area near (7612, 1954); retrying without the area check
 20.27  CBFactoryTask: no site for armsy at all | origin (7612, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.29  CBFactoryTask: no site for armsy in a usable armrecl area near (7610, 1958); retrying without the area check
 20.29  CBFactoryTask: no site for armsy at all | origin (7610, 1958) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.32  CBFactoryTask: no site for armsy in a usable armrecl area near (7610, 1954); retrying without the area check
 20.32  CBFactoryTask: no site for armsy at all | origin (7610, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.43  CBFactoryTask: no site for armsy in a usable armrecl area near (7613, 1956); retrying without the area check
 20.43  CBFactoryTask: no site for armsy at all | origin (7613, 1956) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.45  CBFactoryTask: no site for armsy in a usable armrecl area near (7611, 1954); retrying without the area check
 20.45  CBFactoryTask: no site for armsy at all | origin (7611, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.46  CBFactoryTask: no site for armsy in a usable armrecl area near (7608, 1956); retrying without the area check
 20.46  CBFactoryTask: no site for armsy at all | origin (7608, 1956) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.48  CBFactoryTask: no site for armsy in a usable armrecl area near (7615, 1952); retrying without the area check
 20.48  CBFactoryTask: no site for armsy at all | origin (7615, 1952) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.49  CBFactoryTask: no site for armsy in a usable armrecl area near (7607, 1956); retrying without the area check
 20.49  CBFactoryTask: no site for armsy at all | origin (7607, 1956) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.60  CBFactoryTask: no site for armsy in a usable armrecl area near (7612, 1954); retrying without the area check
 20.60  CBFactoryTask: no site for armsy at all | origin (7612, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.62  CBFactoryTask: no site for armsy in a usable armrecl area near (7613, 1952); retrying without the area check
 20.62  CBFactoryTask: no site for armsy at all | origin (7613, 1952) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.65  CBFactoryTask: no site for armsy in a usable armrecl area near (7607, 1958); retrying without the area check
 20.65  CBFactoryTask: no site for armsy at all | origin (7607, 1958) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.67  CBFactoryTask: no site for armsy in a usable armrecl area near (7608, 1954); retrying without the area check
 20.67  CBFactoryTask: no site for armsy at all | origin (7608, 1954) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.69  CBFactoryTask: no site for armsy in a usable armrecl area near (7609, 1953); retrying without the area check
 20.69  CBFactoryTask: no site for armsy at all | origin (7609, 1953) elev 51 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=1 immobileId=7 builder=armcom radius=1600
 20.71  CBFactoryTask: no site for armsy in a usable armrecl area near (7614, 1953); retrying without the area check
```
