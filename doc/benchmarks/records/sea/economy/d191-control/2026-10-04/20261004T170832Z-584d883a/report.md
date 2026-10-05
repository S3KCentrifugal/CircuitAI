# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36008); wall 165 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:05:43
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-control\glacial\20261004T170543Z-69b5e61b\runs\20261004T170832Z-584d883a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:33.028889][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.9 min | `[t=00:00:48.930577][f=0001552] [SeaWatch] finished frame=1552 id=18500 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 3.1 min | `[t=00:00:58.090010][f=0005550] [SeaWatch] egress id=26663 yard=18500 seconds=17.3 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-control\glacial\20261004T170543Z-69b5e61b\runs\20261004T170832Z-584d883a\screen_2026-10-04_17-06-54-178.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-control\glacial\20261004T170543Z-69b5e61b\runs\20261004T170832Z-584d883a\screen_2026-10-04_17-07-15-253.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-control\glacial\20261004T170543Z-69b5e61b\runs\20261004T170832Z-584d883a\screen_2026-10-04_17-08-31-058.png

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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.41  [Playtest] finished armtide team 0 at 0.41 min
  0.56  [Playtest] finished armtide team 0 at 0.56 min
  0.86  [Playtest] finished armsy team 0 at 0.86 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 498/1200, energy +76.0 bank 770/1200, units 8
  1.06  [Playtest] finished armmex team 0 at 1.06 min
  1.18  [Playtest] finished armmex team 0 at 1.18 min
  1.33  [Playtest] finished armtide team 0 at 1.33 min
  1.48  [Playtest] finished armtide team 0 at 1.48 min
  1.65  [Playtest] finished armtide team 0 at 1.65 min
  1.81  [Playtest] finished armtide team 0 at 1.81 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 79/1300, energy +182.0 bank 1157/1500, units 16
  2.12  [Playtest] finished armtide team 0 at 2.12 min
  2.50  [Playtest] finished armtide team 0 at 2.50 min
  2.91  [Playtest] finished armtide team 0 at 2.91 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 0/1300, energy +251.0 bank 1650/1650, units 22
  3.26  [Playtest] finished armtide team 0 at 3.26 min
  3.78  [Playtest] finished armfmkr team 0 at 3.78 min
  3.97  [Playtest] finished armmex team 0 at 3.97 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.0 bank 0/1350, energy +274.0 bank 1642/1700, units 27
  4.20  [Playtest] finished armmex team 0 at 4.20 min
  4.28  [Playtest] finished armfmkr team 0 at 4.28 min
  4.30  [Playtest] finished armtide team 0 at 4.30 min
  4.42  [Playtest] finished armmex team 0 at 4.42 min
  4.54  [Playtest] finished armfmkr team 0 at 4.54 min
  4.60  [Playtest] finished armmex team 0 at 4.60 min
  4.74  [Playtest] finished armtide team 0 at 4.74 min
  4.92  [Playtest] finished armtide team 0 at 4.92 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +21.0 bank 116/1500, energy +350.0 bank 1555/1900, units 35
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.08  [Playtest] finished armtide team 0 at 5.08 min
  5.24  [Playtest] finished armtide team 0 at 5.24 min
  5.37  [Playtest] finished armfmkr team 0 at 5.37 min
  5.51  [Playtest] finished armtide team 0 at 5.51 min
  5.86  [Playtest] finished armnanotcplat team 0 at 5.86 min
  5.99  [Playtest] finished armfmkr team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +21.2 bank 19/1500, energy +419.0 bank 1658/2050, units 42
  6.01  [Playtest] finished armtide team 0 at 6.01 min
  6.17  [Playtest] finished armtide team 0 at 6.17 min
  6.34  [Playtest] finished armtide team 0 at 6.34 min
  6.39  [Playtest] finished armtl team 0 at 6.39 min
  6.53  [Playtest] finished armtide team 0 at 6.53 min
  6.86  [Playtest] finished armtide team 0 at 6.86 min
  6.96  [Playtest] finished armnanotcplat team 0 at 6.96 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.9 bank 15/1500, energy +534.0 bank 1933/2300, units 50
  7.14  [Playtest] finished armtide team 0 at 7.14 min
  7.29  [Playtest] finished armnanotcplat team 0 at 7.29 min
  7.43  [Playtest] finished armtide team 0 at 7.43 min
  7.50  [Playtest] finished armtl team 0 at 7.50 min
  7.81  [Playtest] finished armfmkr team 0 at 7.81 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +24.0 bank 13/1500, energy +587.0 bank 2102/2450, units 55
  8.03  [Playtest] finished armtide team 0 at 8.03 min
  8.37  [Playtest] finished armtide team 0 at 8.37 min
  8.40  [Playtest] finished armmex team 0 at 8.40 min
  8.76  [Playtest] finished armfmkr team 0 at 8.76 min
  8.83  [Playtest] finished armfrad team 0 at 8.83 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +26.1 bank 0/1550, energy +633.0 bank 2120/2550, units 64
  9.16  [Playtest] finished armmex team 0 at 9.16 min
  9.30  [Playtest] finished armtide team 0 at 9.30 min
  9.55  [Playtest] finished armmex team 0 at 9.55 min
  9.62  [Playtest] finished armtide team 0 at 9.62 min
  9.76  [Playtest] finished armmex team 0 at 9.76 min
  9.99  [Playtest] finished armmex team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +32.0 bank 0/1750, energy +686.0 bank 2229/2700, units 71
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.04  [Playtest] finished armtide team 0 at 10.04 min
 10.08  [Playtest] finished armmex team 0 at 10.08 min
 10.39  [Playtest] finished armmex team 0 at 10.39 min
 10.42  [Playtest] finished armtide team 0 at 10.42 min
 10.49  [Playtest] finished armmex team 0 at 10.49 min
 10.72  [Playtest] finished armtide team 0 at 10.72 min
 10.78  [Playtest] finished armtl team 0 at 10.78 min
 10.89  [Playtest] finished armmex team 0 at 10.89 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +42.4 bank 50/1950, energy +762.0 bank 2655/2900, units 80
 11.08  [Playtest] finished armtide team 0 at 11.08 min
 11.11  [Playtest] finished armtl team 0 at 11.11 min
 11.26  [Playtest] finished armfmkr team 0 at 11.26 min
 11.39  [Playtest] finished armmex team 0 at 11.39 min
 11.40  [Playtest] finished armtide team 0 at 11.40 min
 11.69  [Playtest] finished armmex team 0 at 11.69 min
 11.73  [Playtest] finished armtide team 0 at 11.73 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +46.1 bank 0/2050, energy +817.0 bank 2427/2950, units 89
 12.07  [Playtest] finished armtide team 0 at 12.07 min
 12.13  [Playtest] finished armtl team 0 at 12.13 min
 12.41  [Playtest] finished armtide team 0 at 12.41 min
 12.45  [Playtest] finished armmex team 0 at 12.45 min
 12.46  [Playtest] finished armmex team 0 at 12.46 min
 12.71  [Playtest] finished armfrad team 0 at 12.72 min
 12.72  [Playtest] finished armtide team 0 at 12.72 min
 12.94  [Playtest] finished armfmkr team 0 at 12.94 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +50.0 bank 349/2150, energy +886.0 bank 2450/3100, units 95
 13.07  [Playtest] finished armnanotcplat team 0 at 13.07 min
 13.14  [Playtest] finished armtide team 0 at 13.14 min
 13.22  [Playtest] finished armfmkr team 0 at 13.22 min
 13.25  [Playtest] finished armnanotcplat team 0 at 13.25 min
 13.29  [Playtest] finished armtide team 0 at 13.29 min
 13.37  [Playtest] finished armnanotcplat team 0 at 13.37 min
 13.53  [Playtest] finished armnanotcplat team 0 at 13.53 min
 13.60  [Playtest] finished armtide team 0 at 13.60 min
 13.74  [Playtest] finished armnanotcplat team 0 at 13.74 min
 13.85  [Playtest] finished armtide team 0 at 13.85 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +48.1 bank 68/2050, energy +992.0 bank 2665/3400, units 102
 14.01  [Playtest] finished armfmkr team 0 at 14.01 min
 14.10  [Playtest] finished armtide team 0 at 14.10 min
 14.17  [Playtest] finished armfmkr team 0 at 14.17 min
 14.42  [Playtest] finished armtide team 0 at 14.42 min
 14.73  [Playtest] finished armfmkr team 0 at 14.73 min
 14.75  [Playtest] finished armtide team 0 at 14.75 min
 14.85  [Playtest] finished armfmkr team 0 at 14.85 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +49.4 bank 21/2050, energy +1061.0 bank 3019/3550, units 109
 15.07  [Playtest] finished armtide team 0 at 15.07 min
 15.41  [Playtest] finished armtide team 0 at 15.41 min
 15.60  [Playtest] finished armnanotcplat team 0 at 15.60 min
 15.75  [Playtest] finished armtide team 0 at 15.75 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +50.0 bank 23/1900, energy +1116.0 bank 2604/3600, units 109
 16.17  [Playtest] finished armtide team 0 at 16.17 min
 16.50  [Playtest] finished armtide team 0 at 16.50 min
 16.73  [Playtest] finished armfmkr team 0 at 16.73 min
 16.84  [Playtest] finished armtide team 0 at 16.84 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +38.9 bank 10/1850, energy +1178.0 bank 3221/3700, units 104
 17.17  [Playtest] finished armtide team 0 at 17.17 min
 17.55  [Playtest] finished armnanotcplat team 0 at 17.55 min
 17.67  [Playtest] finished armfmkr team 0 at 17.67 min
 17.88  [Playtest] finished armfmkr team 0 at 17.88 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +36.0 bank 0/1600, energy +1215.0 bank 3361/3850, units 100
 18.17  [Playtest] finished armfmkr team 0 at 18.17 min
 18.76  [Playtest] finished armfmkr team 0 at 18.76 min
 18.85  [Playtest] finished armfmkr team 0 at 18.85 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +33.0 bank 252/1500, energy +1208.0 bank 3022/3800, units 99
 19.50  [Playtest] finished armfmkr team 0 at 19.50 min
 19.59  [Playtest] finished armnanotcplat team 0 at 19.59 min
 19.81  [Playtest] finished armtide team 0 at 19.81 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +24.9 bank 7/1000, energy +842.0 bank 2097/2350, units 80
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.00  [Playtest] finished armnanotcplat team 0 at 20.00 min
```

## Native lines (all AIs, first 120)

```
  1.37  BUILDER: discarded 1 unused default task(s) in the last minute
  1.40  BUILDER: discarded 1 unused default task(s) in the last minute
  1.43  BUILDER: discarded 1 unused default task(s) in the last minute
  1.55  BUILDER: discarded 1 unused default task(s) in the last minute
  1.73  BUILDER: discarded 1 unused default task(s) in the last minute
  1.81  BUILDER: discarded 1 unused default task(s) in the last minute
  2.38  BUILDER: discarded 1 unused default task(s) in the last minute
  2.40  BUILDER: discarded 1 unused default task(s) in the last minute
  2.43  BUILDER: discarded 1 unused default task(s) in the last minute
  2.56  BUILDER: discarded 1 unused default task(s) in the last minute
  2.73  BUILDER: discarded 4 unused default task(s) in the last minute
  2.81  BUILDER: discarded 2 unused default task(s) in the last minute
  3.74  BUILDER: discarded 1 unused default task(s) in the last minute
  4.84  BUILDER: discarded 1 unused default task(s) in the last minute
  5.03  BUILDER: discarded 1 unused default task(s) in the last minute
  5.51  BUILDER: discarded 1 unused default task(s) in the last minute
  6.03  BUILDER: discarded 2 unused default task(s) in the last minute
  6.20  BUILDER: discarded 1 unused default task(s) in the last minute
  7.04  BUILDER: discarded 1 unused default task(s) in the last minute
  7.16  BUILDER: discarded 1 unused default task(s) in the last minute
  8.02  BUILDER: discarded 1 unused default task(s) in the last minute
  8.04  BUILDER: discarded 2 unused default task(s) in the last minute
  8.09  BUILDER: discarded 1 unused default task(s) in the last minute
  8.16  BUILDER: discarded 3 unused default task(s) in the last minute
  8.72  BUILDER: discarded 1 unused default task(s) in the last minute
  9.02  BUILDER: discarded 3 unused default task(s) in the last minute
  9.05  BUILDER: discarded 3 unused default task(s) in the last minute
  9.09  BUILDER: discarded 3 unused default task(s) in the last minute
  9.16  BUILDER: discarded 2 unused default task(s) in the last minute
  9.72  BUILDER: discarded 2 unused default task(s) in the last minute
 10.03  BUILDER: discarded 2 unused default task(s) in the last minute
 10.09  BUILDER: discarded 4 unused default task(s) in the last minute
 10.10  BUILDER: discarded 2 unused default task(s) in the last minute
 10.17  BUILDER: discarded 2 unused default task(s) in the last minute
 10.73  BUILDER: discarded 1 unused default task(s) in the last minute
 11.09  BUILDER: discarded 2 unused default task(s) in the last minute
 11.10  BUILDER: discarded 4 unused default task(s) in the last minute
 11.62  BUILDER: discarded 1 unused default task(s) in the last minute
 11.75  BUILDER: discarded 4 unused default task(s) in the last minute
 12.61  BUILDER: discarded 1 unused default task(s) in the last minute
 12.62  BUILDER: discarded 3 unused default task(s) in the last minute
 12.67  BUILDER: discarded 1 unused default task(s) in the last minute
 12.76  BUILDER: discarded 2 unused default task(s) in the last minute
 13.03  BUILDER: discarded 1 unused default task(s) in the last minute
 13.07  BUILDER: discarded 1 unused default task(s) in the last minute
 13.62  BUILDER: discarded 5 unused default task(s) in the last minute
 13.76  BUILDER: discarded 10 unused default task(s) in the last minute
 14.07  BUILDER: discarded 2 unused default task(s) in the last minute
 14.08  BUILDER: discarded 2 unused default task(s) in the last minute
 14.37  BUILDER: discarded 1 unused default task(s) in the last minute
 14.62  BUILDER: discarded 20 unused default task(s) in the last minute
 14.77  BUILDER: discarded 3 unused default task(s) in the last minute
 14.93  BUILDER: discarded 1 unused default task(s) in the last minute
 15.07  BUILDER: discarded 7 unused default task(s) in the last minute
 15.08  BUILDER: discarded 1 unused default task(s) in the last minute
 15.37  BUILDER: discarded 10 unused default task(s) in the last minute
 15.43  CBFactoryTask: no site for armtide in a usable armtide area near (2082, 4053); retrying without the area check
 15.43  CBFactoryTask: no site for armtide at all | origin (2082, 4053) elev -94 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 15.62  BUILDER: discarded 2 unused default task(s) in the last minute
 15.78  BUILDER: discarded 1 unused default task(s) in the last minute
 15.94  BUILDER: discarded 1 unused default task(s) in the last minute
 16.07  BUILDER: discarded 6 unused default task(s) in the last minute
 16.09  BUILDER: discarded 1 unused default task(s) in the last minute
 16.37  BUILDER: discarded 3 unused default task(s) in the last minute
 16.62  BUILDER: discarded 9 unused default task(s) in the last minute
 16.78  BUILDER: discarded 3 unused default task(s) in the last minute
 16.94  BUILDER: discarded 3 unused default task(s) in the last minute
 17.08  BUILDER: discarded 5 unused default task(s) in the last minute
 17.37  BUILDER: discarded 6 unused default task(s) in the last minute
 17.63  BUILDER: discarded 1 unused default task(s) in the last minute
 17.79  BUILDER: discarded 1 unused default task(s) in the last minute
 17.94  BUILDER: discarded 2 unused default task(s) in the last minute
 18.37  BUILDER: discarded 3 unused default task(s) in the last minute
 18.63  BUILDER: discarded 2 unused default task(s) in the last minute
 18.95  BUILDER: discarded 3 unused default task(s) in the last minute
 19.37  BUILDER: discarded 8 unused default task(s) in the last minute
 19.82  BUILDER: discarded 1 unused default task(s) in the last minute
 19.95  BUILDER: discarded 1 unused default task(s) in the last minute
```
