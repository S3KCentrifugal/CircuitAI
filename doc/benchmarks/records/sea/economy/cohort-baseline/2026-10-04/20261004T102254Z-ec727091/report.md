# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54105); wall 259 s
- DLL: build-theatres\d189-baseline\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T07:18:32
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T101831Z-40877af1\runs\20261004T102254Z-ec727091\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:36.666135][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.1 min | `[t=00:00:49.881825][f=0002060] [SeaWatch] finished frame=2060 id=13026 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 4.1 min | `[t=00:01:01.773491][f=0007410] [SeaWatch] egress id=26405 yard=13026 seconds=63.4 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T101831Z-40877af1\runs\20261004T102254Z-ec727091\screen_2026-10-04_10-19-41-941.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T101831Z-40877af1\runs\20261004T102254Z-ec727091\screen_2026-10-04_10-20-06-568.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T101831Z-40877af1\runs\20261004T102254Z-ec727091\screen_2026-10-04_10-21-08-935.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T101831Z-40877af1\runs\20261004T102254Z-ec727091\screen_2026-10-04_10-22-39-668.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 6887 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=5840,10640 facing=2
  0.39  [Playtest] finished armmex team 0 at 0.39 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 936/1100, energy +30.0 bank 731/1000, units 4
  1.14  [Playtest] finished armsy team 0 at 1.14 min
  1.72  [Playtest] finished armmex team 0 at 1.72 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 946/1250, energy +30.0 bank 112/1100, units 6
  2.74  [Playtest] finished armmex team 0 at 2.74 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.2 bank 1297/1300, energy +30.0 bank 54/1100, units 7
  3.65  [Playtest] finished armtide team 0 at 3.65 min
  3.71  [Playtest] finished armllt team 0 at 3.71 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +6.6 bank 1196/1300, energy +58.0 bank 4/1200, units 12
  4.00  [Playtest] finished armrad team 0 at 4.00 min
  4.04  [Playtest] finished armtide team 0 at 4.04 min
  4.60  [Playtest] finished armmex team 0 at 4.60 min
  4.61  [Playtest] finished armmex team 0 at 4.61 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.5 bank 1397/1400, energy +86.0 bank 144/1300, units 16
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.08  [Playtest] finished armtide team 0 at 5.08 min
  5.27  [Playtest] finished armtide team 0 at 5.27 min
  5.54  [Playtest] finished armllt team 0 at 5.54 min
  5.57  [Playtest] finished armtide team 0 at 5.57 min
  5.77  [Playtest] finished armmex team 0 at 5.77 min
  5.87  [Playtest] finished armwin team 0 at 5.87 min
  5.88  [Playtest] finished armtide team 0 at 5.88 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +17.8 bank 1231/1450, energy +178.4 bank 337/1500, units 24
  6.28  [Playtest] finished armtl team 0 at 6.28 min
  6.60  [Playtest] finished armtl team 0 at 6.60 min
  6.74  [Playtest] finished armmex team 0 at 6.74 min
  6.90  [Playtest] finished armfrad team 0 at 6.90 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +20.1 bank 1213/1500, energy +195.6 bank 757/1550, units 31
  7.07  [Playtest] finished armmex team 0 at 7.07 min
  7.27  [Playtest] finished armfrad team 0 at 7.27 min
  7.29  [Playtest] finished armtl team 0 at 7.29 min
  7.40  [Playtest] finished armtide team 0 at 7.40 min
  7.89  [Playtest] finished armtide team 0 at 7.89 min
  7.97  [Playtest] finished armtide team 0 at 7.97 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +22.4 bank 1496/1550, energy +265.8 bank 1734/1750, units 39
  8.11  [Playtest] finished armtide team 0 at 8.11 min
  8.25  [Playtest] finished armtl team 0 at 8.25 min
  8.31  [Playtest] finished armtide team 0 at 8.31 min
  8.37  [Playtest] finished armtide team 0 at 8.36 min
  8.73  [Playtest] finished armtl team 0 at 8.73 min
  8.76  [Playtest] finished armtide team 0 at 8.76 min
  8.94  [Playtest] finished armtide team 0 at 8.94 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +22.4 bank 1201/1550, energy +370.3 bank 1988/2000, units 48
  9.09  [Playtest] finished armnanotcplat team 0 at 9.09 min
  9.09  [Playtest] finished armtide team 0 at 9.09 min
  9.24  [Playtest] finished armmex team 0 at 9.24 min
  9.25  [Playtest] finished armtide team 0 at 9.25 min
  9.27  [Playtest] finished armtide team 0 at 9.27 min
  9.35  [Playtest] finished armtide team 0 at 9.35 min
  9.47  [Playtest] finished armllt team 0 at 9.47 min
  9.64  [Playtest] finished armtide team 0 at 9.64 min
  9.73  [Playtest] finished armtide team 0 at 9.73 min
  9.86  [Playtest] finished armtl team 0 at 9.86 min
  9.87  [Playtest] finished armtide team 0 at 9.87 min
  9.88  [Playtest] finished armmex team 0 at 9.88 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.8 bank 324/1650, energy +517.7 bank 2332/2350, units 61
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.11  [Playtest] finished armmex team 0 at 10.11 min
 10.17  [Playtest] finished armtide team 0 at 10.17 min
 10.18  [Playtest] finished armtide team 0 at 10.18 min
 10.34  [Playtest] finished armmex team 0 at 10.34 min
 10.44  [Playtest] finished armtide team 0 at 10.44 min
 10.57  [Playtest] finished armmex team 0 at 10.57 min
 10.69  [Playtest] finished armtide team 0 at 10.69 min
 10.85  [Playtest] finished armfrad team 0 at 10.85 min
 10.86  [Playtest] finished armtl team 0 at 10.86 min
 10.89  [Playtest] finished armllt team 0 at 10.89 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +33.4 bank 269/1800, energy +616.0 bank 2649/2650, units 73
 11.09  [Playtest] finished armtide team 0 at 11.09 min
 11.17  [Playtest] finished armtide team 0 at 11.17 min
 11.30  [Playtest] finished armmex team 0 at 11.30 min
 11.40  [Playtest] finished armtide team 0 at 11.40 min
 11.45  [Playtest] finished armtide team 0 at 11.45 min
 11.55  [Playtest] finished armtide team 0 at 11.55 min
 11.60  [Playtest] finished armmex team 0 at 11.60 min
 11.60  [Playtest] finished armmex team 0 at 11.60 min
 11.78  [Playtest] finished armllt team 0 at 11.78 min
 11.89  [Playtest] finished armrad team 0 at 11.89 min
 11.92  [Playtest] finished armtide team 0 at 11.92 min
 11.99  [Playtest] finished armtl team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +40.3 bank 1389/1950, energy +741.4 bank 2940/2950, units 87
 12.03  [Playtest] finished armtide team 0 at 12.03 min
 12.08  [Playtest] finished armfrad team 0 at 12.08 min
 12.14  [Playtest] finished armfmkr team 0 at 12.14 min
 12.23  [Playtest] finished armtide team 0 at 12.23 min
 12.34  [Playtest] finished armmex team 0 at 12.34 min
 12.36  [Playtest] finished armfrad team 0 at 12.36 min
 12.51  [Playtest] finished armfmkr team 0 at 12.51 min
 12.54  [Playtest] finished armllt team 0 at 12.54 min
 12.56  [Playtest] finished armtide team 0 at 12.56 min
 12.67  [Playtest] finished armtide team 0 at 12.67 min
 12.88  [Playtest] finished armfmkr team 0 at 12.89 min
 12.90  [Playtest] finished armtide team 0 at 12.90 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +45.6 bank 1998/2000, energy +844.8 bank 3110/3200, units 100
 13.20  [Playtest] finished armtide team 0 at 13.20 min
 13.22  [Playtest] finished armrad team 0 at 13.22 min
 13.29  [Playtest] finished armfmkr team 0 at 13.29 min
 13.36  [Playtest] finished armtide team 0 at 13.36 min
 13.61  [Playtest] finished armllt team 0 at 13.61 min
 13.66  [Playtest] finished armfmkr team 0 at 13.66 min
 13.68  [Playtest] finished armtide team 0 at 13.68 min
 13.83  [Playtest] finished armrad team 0 at 13.83 min
 13.89  [Playtest] finished armfmkr team 0 at 13.89 min
 13.90  [Playtest] finished armtl team 0 at 13.90 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +48.6 bank 1997/2000, energy +906.9 bank 3178/3350, units 114
 14.05  [Playtest] finished armtide team 0 at 14.05 min
 14.28  [Playtest] finished armfmkr team 0 at 14.28 min
 14.32  [Playtest] finished armtide team 0 at 14.32 min
 14.36  [Playtest] finished armtide team 0 at 14.36 min
 14.62  [Playtest] finished armfmkr team 0 at 14.62 min
 14.98  [Playtest] finished armtide team 0 at 14.98 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +50.6 bank 1998/2000, energy +973.0 bank 3342/3550, units 123
 15.02  [Playtest] finished armtide team 0 at 15.02 min
 15.05  [Playtest] finished armfmkr team 0 at 15.05 min
 15.30  [Playtest] finished armtide team 0 at 15.30 min
 15.33  [Playtest] finished armtide team 0 at 15.33 min
 15.50  [Playtest] finished armtide team 0 at 15.50 min
 15.51  [Playtest] finished armfmkr team 0 at 15.51 min
 15.52  [Playtest] finished armfmkr team 0 at 15.52 min
 15.60  [Playtest] finished armfmkr team 0 at 15.60 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +54.6 bank 1998/2000, energy +1077.7 bank 3458/3750, units 136
 16.23  [Playtest] finished armtide team 0 at 16.23 min
 16.36  [Playtest] finished armnanotcplat team 0 at 16.36 min
 16.48  [Playtest] finished armtide team 0 at 16.48 min
 16.55  [Playtest] finished armtide team 0 at 16.55 min
 16.56  [Playtest] finished armtide team 0 at 16.56 min
 16.72  [Playtest] finished armfmkr team 0 at 16.72 min
 16.82  [Playtest] finished armnanotcplat team 0 at 16.82 min
 16.98  [Playtest] finished armtide team 0 at 16.98 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +64.1 bank 1954/2000, energy +1194.1 bank 3422/4000, units 152
 17.03  [Playtest] finished armtide team 0 at 17.03 min
 17.09  [Playtest] finished armfmkr team 0 at 17.09 min
 17.13  [Playtest] finished armtide team 0 at 17.13 min
 17.24  [Playtest] finished armfmkr team 0 at 17.24 min
 17.36  [Playtest] finished armfmkr team 0 at 17.36 min
 17.66  [Playtest] finished armfmkr team 0 at 17.66 min
 17.66  [Playtest] finished armtide team 0 at 17.66 min
 17.91  [Playtest] finished armtide team 0 at 17.91 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +59.5 bank 1980/2000, energy +1266.9 bank 3537/4200, units 164
 18.06  [Playtest] finished armtide team 0 at 18.06 min
 18.15  [Playtest] finished armtide team 0 at 18.15 min
 18.32  [Playtest] finished armfmkr team 0 at 18.32 min
 18.38  [Playtest] finished armtide team 0 at 18.38 min
 18.59  [Playtest] finished armtide team 0 at 18.59 min
 18.72  [Playtest] finished armfmkr team 0 at 18.72 min
 18.80  [Playtest] finished armfmkr team 0 at 18.80 min
 18.94  [Playtest] finished armfmkr team 0 at 18.94 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +54.6 bank 1918/2000, energy +1344.8 bank 3714/4400, units 180
 19.01  [Playtest] finished armtide team 0 at 19.01 min
 19.07  [Playtest] finished armtide team 0 at 19.07 min
 19.08  [Playtest] finished armtide team 0 at 19.08 min
 19.28  [Playtest] finished armtide team 0 at 19.28 min
 19.32  [Playtest] finished armfmkr team 0 at 19.32 min
 19.40  [Playtest] finished armfmkr team 0 at 19.40 min
 19.49  [Playtest] finished armfmkr team 0 at 19.49 min
 19.60  [Playtest] finished armtide team 0 at 19.60 min
 19.77  [Playtest] finished armtide team 0 at 19.77 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +60.9 bank 1968/2000, energy +1476.6 bank 3988/4700, units 195
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.11  [Playtest] finished armtide team 0 at 20.11 min
 20.14  [Playtest] finished armtide team 0 at 20.14 min
 20.42  [Playtest] finished armfmkr team 0 at 20.42 min
 20.46  [Playtest] finished armtide team 0 at 20.46 min
 20.59  [Playtest] finished armtide team 0 at 20.59 min
 20.66  [Playtest] finished armfmkr team 0 at 20.66 min
 20.74  [Playtest] finished armtide team 0 at 20.74 min
 20.87  [Playtest] finished armfmkr team 0 at 20.87 min
 20.90  [Playtest] finished armtide team 0 at 20.90 min
 20.93  [Playtest] finished armfmkr team 0 at 20.93 min
 20.95  [Playtest] finished armfmkr team 0 at 20.95 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +58.8 bank 1970/2000, energy +1603.0 bank 4469/5000, units 210
 21.08  [Playtest] finished armfmkr team 0 at 21.08 min
 21.44  [Playtest] finished armfmkr team 0 at 21.44 min
 21.52  [Playtest] finished armtide team 0 at 21.52 min
 21.53  [Playtest] finished armfmkr team 0 at 21.53 min
 21.73  [Playtest] finished armfmkr team 0 at 21.73 min
 21.75  [Playtest] finished armtide team 0 at 21.75 min
 21.86  [Playtest] finished armfmkr team 0 at 21.86 min
 21.96  [Playtest] finished armfmkr team 0 at 21.96 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +58.6 bank 1986/2000, energy +1640.5 bank 4384/5100, units 227
 22.07  [Playtest] finished armfmkr team 0 at 22.07 min
 22.09  [Playtest] finished armtide team 0 at 22.09 min
 22.49  [Playtest] finished armtide team 0 at 22.49 min
 22.55  [Playtest] finished armtide team 0 at 22.56 min
 22.68  [Playtest] finished armnanotcplat team 0 at 22.68 min
 22.77  [Playtest] finished armtide team 0 at 22.77 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +64.6 bank 1974/2000, energy +1715.1 bank 4551/5300, units 240
 24.00  [Playtest] eco team 0 at 24.0 min: metal +60.9 bank 1876/2000, energy +1718.4 bank 4553/5300, units 245
 25.00  [Playtest] eco team 0 at 25.0 min: metal +66.6 bank 1991/2000, energy +1729.0 bank 4636/5300, units 254
 26.00  [Playtest] eco team 0 at 26.0 min: metal +64.1 bank 1997/2000, energy +1722.8 bank 4792/5300, units 262
 26.83  [Playtest] finished armtl team 0 at 26.83 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +57.7 bank 1782/2000, energy +1721.2 bank 4501/5300, units 271
 28.00  [Playtest] eco team 0 at 28.0 min: metal +61.4 bank 1735/2000, energy +1721.3 bank 4808/5300, units 275
 28.25  [Playtest] finished armtl team 0 at 28.25 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +57.7 bank 1803/2000, energy +1726.3 bank 4504/5300, units 284
 29.00  [Playtest] camera requested (4814,11077) height=2200
 29.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4814, 11077)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +64.4 bank 1998/2000, energy +1722.8 bank 4799/5300, units 290
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(28578) at (4776, 11079) walks to (4744, 11078), 136 from the armmex site (4608, 11072)
  0.08  EXP: approach: armcom(891) at (7537, 1223) walks to (7560, 1224), 136 from the armmex site (7696, 1232)
  0.21  EXP: approach: armcom(891) at (7548, 1223) walks to (7475, 1094), 136 from the armmex site (7408, 976)
  0.21  EXP: approach: armcom(28578) at (4754, 11078) walks to (4829, 11210), 136 from the armmex site (4896, 11328)
  0.22  RESERVE: zone 1 at (6480, 1664) facing 0, 6x6 cells: 36 of 36 held
  0.22  RESERVE: armsy at (6480, 1664) facing 0 (id 1)
  0.22  RESERVE: corridor 2 at (6480, 1952) facing 0, 12x30 cells: 360 of 360 held
  0.22  RESERVE: zone 3 at (6424, 1448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 1448) facing 0 (id 2)
  0.22  RESERVE: zone 4 at (6488, 1448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1448) facing 0 (id 3)
  0.22  RESERVE: zone 3 released
  0.22  RESERVE: zone 4 released
  0.22  RESERVE: zone 5 at (6520, 1448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6520, 1448) facing 0 (id 4)
  0.22  RESERVE: zone 5 released
  0.22  RESERVE: zone 6 at (6504, 1480) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1480) facing 0 (id 5)
  0.22  RESERVE: zone 6 released
  0.22  RESERVE: zone 7 at (6488, 1512) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1512) facing 0 (id 6)
  0.22  RESERVE: zone 7 released
  0.22  RESERVE: zone 8 at (6456, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6456, 1528) facing 0 (id 7)
  0.22  RESERVE: zone 9 at (6520, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6520, 1528) facing 0 (id 8)
  0.22  RESERVE: zone 8 released
  0.22  RESERVE: zone 9 released
  0.22  RESERVE: zone 10 at (6424, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 1544) facing 0 (id 9)
  0.22  RESERVE: zone 11 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 10)
  0.22  RESERVE: zone 12 at (6552, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6552, 1544) facing 0 (id 11)
  0.22  RESERVE: zone 10 released
  0.22  RESERVE: zone 11 released
  0.22  RESERVE: zone 12 released
  0.22  RESERVE: zone 13 at (6376, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1528) facing 0 (id 12)
  0.22  RESERVE: zone 14 at (6440, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1528) facing 0 (id 13)
  0.22  RESERVE: zone 15 at (6504, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1528) facing 0 (id 14)
  0.22  RESERVE: zone 16 at (6376, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1592) facing 0 (id 15)
  0.22  RESERVE: zone 17 at (6440, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1592) facing 0 (id 16)
  0.22  RESERVE: zone 18 at (6504, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1592) facing 0 (id 17)
  0.22  RESERVE: zone 19 at (6443, 1561) facing 0, 13x9 cells: 57 of 117 held
  0.23  RESERVE: zone 1 at (5840, 10640) facing 2, 6x6 cells: 36 of 36 held
  0.23  RESERVE: armsy at (5840, 10640) facing 2 (id 1)
  0.23  RESERVE: corridor 2 at (5840, 10352) facing 2, 12x30 cells: 360 of 360 held
  0.23  RESERVE: zone 3 at (5912, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5912, 10872) facing 2 (id 2)
  0.23  RESERVE: zone 4 at (5848, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5848, 10872) facing 2 (id 3)
  0.23  RESERVE: zone 5 at (5784, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5784, 10872) facing 2 (id 4)
  0.23  RESERVE: zone 6 at (5912, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5912, 10808) facing 2 (id 5)
  0.23  RESERVE: zone 7 at (5848, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5848, 10808) facing 2 (id 6)
  0.23  RESERVE: zone 8 at (5784, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5784, 10808) facing 2 (id 7)
  0.23  RESERVE: zone 9 at (5840, 10832) facing 2, 12x8 cells: 42 of 96 held
  0.41  EXP: approach: armcom(28578) at (4804, 11184) walks to (5691, 10718), 168 from the armsy site (5840, 10640)
  0.41  RESERVE: served armsy at (5840, 10640) facing 2 (id 1, 0 of this def still held)
  0.41  EXP: approach: armcom(891) at (7494, 1111) walks to (6628, 1583), 168 from the armsy site (6480, 1664)
  0.41  RESERVE: served armsy at (6480, 1664) facing 0 (id 1, 0 of this def still held)
  1.15  EXP: approach: armcom(891) at (6661, 1563) walks to (7272, 1515), 136 from the armmex site (7408, 1504)
  1.16  RESERVE: zone 10 at (5912, 10984) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5912, 10984) facing 2 (id 8)
  1.16  RESERVE: zone 11 at (5848, 10984) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5848, 10984) facing 2 (id 9)
  1.16  RESERVE: zone 12 at (5784, 10984) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5784, 10984) facing 2 (id 10)
  1.16  RESERVE: zone 13 at (5912, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5912, 10920) facing 2 (id 11)
  1.16  RESERVE: zone 14 at (5848, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5848, 10920) facing 2 (id 12)
  1.16  RESERVE: zone 15 at (5784, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5784, 10920) facing 2 (id 13)
  1.16  RESERVE: zone 16 at (5840, 10958) facing 2, 12x9 cells: 42 of 108 held
  1.17  EXP: approach: armcom(28578) at (5662, 10739) walks to (5032, 10789), 136 from the armmex site (4896, 10800)
  1.74  RESERVE: zone 20 at (6424, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.74  RESERVE: armtide at (6424, 1416) facing 0 (id 18)
  1.74  RESERVE: zone 21 at (6488, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.74  RESERVE: armtide at (6488, 1416) facing 0 (id 19)
  1.74  RESERVE: zone 20 released
  1.74  RESERVE: zone 21 released
  1.74  RESERVE: zone 22 at (6376, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.74  RESERVE: armtide at (6376, 1400) facing 0 (id 20)
  1.74  RESERVE: zone 22 released
  1.74  RESERVE: zone 23 at (6344, 1384) facing 0, 3x3 cells: 9 of 9 held
  1.74  RESERVE: armtide at (6344, 1384) facing 0 (id 21)
  1.74  RESERVE: zone 23 released
  1.77  RESERVE: zone 24 at (6328, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6328, 1352) facing 0 (id 22)
  1.77  RESERVE: zone 25 at (6392, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6392, 1352) facing 0 (id 23)
  1.77  RESERVE: zone 24 released
  1.77  RESERVE: zone 25 released
  1.77  RESERVE: zone 26 at (6328, 1320) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6328, 1320) facing 0 (id 24)
  1.77  RESERVE: zone 27 at (6392, 1320) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6392, 1320) facing 0 (id 25)
  1.77  RESERVE: zone 26 released
  1.77  RESERVE: zone 27 released
  1.77  RESERVE: zone 28 at (6328, 1272) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6328, 1272) facing 0 (id 26)
  1.77  RESERVE: zone 29 at (6392, 1272) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6392, 1272) facing 0 (id 27)
  1.77  RESERVE: zone 28 released
  1.77  RESERVE: zone 29 released
  1.77  RESERVE: zone 30 at (6344, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6344, 1240) facing 0 (id 28)
  1.77  RESERVE: zone 30 released
  1.77  RESERVE: zone 31 at (6376, 1224) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6376, 1224) facing 0 (id 29)
```
