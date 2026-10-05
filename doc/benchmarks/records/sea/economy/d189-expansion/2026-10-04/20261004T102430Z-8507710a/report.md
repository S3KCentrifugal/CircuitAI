# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.2 min (frame 54273); wall 280 s
- DLL: build-theatres\d189-build-5\SkirmishAI.dll (1b875078bc2aa763); AI BARbTest/test; staged 2026-10-04T07:19:46
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-expansion\glacial\20261004T101946Z-93cc4195\runs\20261004T102430Z-8507710a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.795782][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.0 min | `[t=00:00:52.375315][f=0001798] [SeaWatch] finished frame=1798 id=3076 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:00:58.314630][f=0004470] [SeaWatch] egress id=4850 yard=3076 seconds=34.6 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-expansion\glacial\20261004T101946Z-93cc4195\runs\20261004T102430Z-8507710a\screen_2026-10-04_10-21-00-818.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-expansion\glacial\20261004T101946Z-93cc4195\runs\20261004T102430Z-8507710a\screen_2026-10-04_10-21-24-335.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-expansion\glacial\20261004T101946Z-93cc4195\runs\20261004T102430Z-8507710a\screen_2026-10-04_10-22-47-755.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-expansion\glacial\20261004T101946Z-93cc4195\runs\20261004T102430Z-8507710a\screen_2026-10-04_10-24-16-585.png

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
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  1.00  [Playtest] finished armsy team 0 at 1.00 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 749/1200, energy +30.0 bank 422/1100, units 4
  1.49  [Playtest] finished armtide team 0 at 1.49 min
  1.74  [Playtest] finished armtide team 0 at 1.74 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 620/1200, energy +83.0 bank 113/1250, units 9
  2.01  [Playtest] finished armtide team 0 at 2.01 min
  2.44  [Playtest] finished armtide team 0 at 2.44 min
  2.46  [Playtest] finished armmex team 0 at 2.46 min
  2.73  [Playtest] finished armmex team 0 at 2.73 min
  2.77  [Playtest] finished armtide team 0 at 2.77 min
  2.87  [Playtest] finished armfrad team 0 at 2.87 min
  2.95  [Playtest] finished armtide team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 306/1300, energy +182.0 bank 654/1500, units 17
  3.36  [Playtest] finished armtide team 0 at 3.36 min
  3.43  [Playtest] finished armtide team 0 at 3.43 min
  3.98  [Playtest] finished armmex team 0 at 3.98 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.0 bank 0/1350, energy +228.0 bank 1591/1600, units 23
  4.19  [Playtest] finished armtl team 0 at 4.19 min
  4.24  [Playtest] finished armmex team 0 at 4.24 min
  4.45  [Playtest] finished armmex team 0 at 4.45 min
  4.63  [Playtest] finished armmex team 0 at 4.63 min
  4.87  [Playtest] finished armtide team 0 at 4.87 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +18.0 bank 21/1500, energy +251.0 bank 1641/1650, units 27
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.14  [Playtest] finished armmex team 0 at 5.14 min
  5.19  [Playtest] finished armtide team 0 at 5.19 min
  5.36  [Playtest] finished armmex team 0 at 5.36 min
  5.37  [Playtest] finished armtide team 0 at 5.37 min
  5.46  [Playtest] finished armtide team 0 at 5.46 min
  5.56  [Playtest] finished armmex team 0 at 5.56 min
  5.72  [Playtest] finished armmex team 0 at 5.72 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 508/1700, energy +320.0 bank 1775/1800, units 37
  6.09  [Playtest] finished armtide team 0 at 6.09 min
  6.13  [Playtest] finished armfmkr team 0 at 6.13 min
  6.29  [Playtest] finished armmex team 0 at 6.29 min
  6.50  [Playtest] finished armtide team 0 at 6.50 min
  6.52  [Playtest] finished armmex team 0 at 6.52 min
  6.72  [Playtest] finished armmex team 0 at 6.72 min
  6.81  [Playtest] finished armtide team 0 at 6.81 min
  6.86  [Playtest] finished armnanotcplat team 0 at 6.86 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +33.0 bank 886/1850, energy +396.0 bank 1766/2000, units 46
  7.13  [Playtest] finished armtide team 0 at 7.13 min
  7.21  [Playtest] finished armtide team 0 at 7.21 min
  7.22  [Playtest] finished armfmkr team 0 at 7.22 min
  7.54  [Playtest] finished armtide team 0 at 7.53 min
  7.79  [Playtest] finished armfmkr team 0 at 7.79 min
  7.80  [Playtest] finished armtide team 0 at 7.80 min
  7.83  [Playtest] finished armtide team 0 at 7.83 min
  7.97  [Playtest] finished armtide team 0 at 7.97 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +35.0 bank 847/1850, energy +541.0 bank 2252/2350, units 57
  8.11  [Playtest] finished armtide team 0 at 8.11 min
  8.15  [Playtest] finished armtide team 0 at 8.15 min
  8.17  [Playtest] finished armtide team 0 at 8.17 min
  8.52  [Playtest] finished armfmkr team 0 at 8.52 min
  8.54  [Playtest] finished armfmkr team 0 at 8.54 min
  8.59  [Playtest] finished armtide team 0 at 8.59 min
  8.61  [Playtest] finished armtide team 0 at 8.61 min
  8.66  [Playtest] finished armfmkr team 0 at 8.66 min
  8.92  [Playtest] finished armtide team 0 at 8.92 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +38.0 bank 990/1850, energy +693.0 bank 2678/2750, units 68
  9.01  [Playtest] finished armtide team 0 at 9.01 min
  9.04  [Playtest] finished armtide team 0 at 9.04 min
  9.09  [Playtest] finished armtide team 0 at 9.09 min
  9.48  [Playtest] finished armtide team 0 at 9.48 min
  9.49  [Playtest] finished armtide team 0 at 9.49 min
  9.71  [Playtest] finished armfmkr team 0 at 9.71 min
  9.81  [Playtest] finished armfmkr team 0 at 9.81 min
  9.93  [Playtest] finished armtide team 0 at 9.93 min
  9.93  [Playtest] finished armtide team 0 at 9.93 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +39.2 bank 1093/1850, energy +854.0 bank 2577/3100, units 78
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.03  [Playtest] finished armfmkr team 0 at 10.02 min
 10.16  [Playtest] finished armtide team 0 at 10.16 min
 10.21  [Playtest] finished armtide team 0 at 10.21 min
 10.40  [Playtest] finished armfmkr team 0 at 10.40 min
 10.54  [Playtest] finished armtide team 0 at 10.54 min
 10.57  [Playtest] finished armtide team 0 at 10.57 min
 10.77  [Playtest] finished armtide team 0 at 10.77 min
 10.86  [Playtest] finished armtide team 0 at 10.86 min
 10.91  [Playtest] finished armtide team 0 at 10.91 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +41.8 bank 14/1850, energy +1015.0 bank 3074/3450, units 88
 11.39  [Playtest] finished armtide team 0 at 11.39 min
 11.43  [Playtest] finished armtide team 0 at 11.43 min
 11.77  [Playtest] finished armtide team 0 at 11.77 min
 11.80  [Playtest] finished armfmkr team 0 at 11.80 min
 11.97  [Playtest] finished armfrad team 0 at 11.97 min
 11.99  [Playtest] finished armasy team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +43.0 bank 20/2050, energy +1084.0 bank 3546/3800, units 91
 12.12  [Playtest] finished armtide team 0 at 12.12 min
 12.48  [Playtest] finished armtide team 0 at 12.48 min
 12.53  [Playtest] finished armfmkr team 0 at 12.53 min
 12.58  [Playtest] finished armmex team 0 at 12.58 min
 12.86  [Playtest] finished armfrad team 0 at 12.86 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +46.0 bank 192/2100, energy +1160.0 bank 3402/4050, units 98
 13.31  [Playtest] finished armuwmme team 0 at 13.31 min
 13.44  [Playtest] finished armmex team 0 at 13.44 min
 13.50  [Playtest] finished armmex team 0 at 13.50 min
 13.58  [Playtest] finished armmex team 0 at 13.58 min
 13.89  [Playtest] finished armmex team 0 at 13.89 min
 13.96  [Playtest] finished armuwmme team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +63.8 bank 863/3400, energy +1160.0 bank 3392/4200, units 102
 14.24  [Playtest] finished armtl team 0 at 14.24 min
 14.79  [Playtest] finished armmex team 0 at 14.79 min
 14.80  [Playtest] finished armuwmme team 0 at 14.80 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +61.6 bank 660/3800, energy +1183.0 bank 3380/4150, units 98
 15.41  [Playtest] finished armbats team 0 at 15.41 min
 15.45  [Playtest] finished armtide team 0 at 15.45 min
 15.78  [Playtest] finished armtide team 0 at 15.78 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +61.6 bank 271/3800, energy +1215.0 bank 3316/4150, units 96
 17.00  [Playtest] eco team 0 at 17.0 min: metal +62.3 bank 390/3750, energy +1478.0 bank 4423/5450, units 91
 17.96  [Playtest] finished armuwfus team 0 at 17.96 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +49.4 bank 18/3650, energy +2385.0 bank 6460/6500, units 88
 18.95  [Playtest] finished armmex team 0 at 18.95 min
 18.98  [Playtest] finished armbats team 0 at 18.98 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +62.0 bank 119/3700, energy +2371.0 bank 6398/6400, units 86
 19.59  [Playtest] finished armnanotcplat team 0 at 19.59 min
 19.90  [Playtest] finished armnanotcplat team 0 at 19.90 min
 19.94  [Playtest] finished armllt team 0 at 19.94 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +54.0 bank 1170/3650, energy +2263.0 bank 6112/6250, units 78
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.24  [Playtest] finished armmex team 0 at 20.24 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +45.9 bank 2449/2750, energy +2072.0 bank 5469/5500, units 61
 21.17  [SEA][Layout] berth sea.berth.3 armsy at=608,3184 facing=3
 21.23  [Playtest] finished armsy team 0 at 21.23 min
 21.61  [Playtest] finished armuwmmm team 0 at 21.61 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +54.3 bank 2111/2350, energy +2049.0 bank 4822/5150, units 63
 22.53  [Playtest] finished armasy team 0 at 22.53 min
 22.87  [Playtest] finished armnanotcplat team 0 at 22.87 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +54.3 bank 2347/2350, energy +1996.0 bank 4551/4900, units 63
 23.13  [SEA][Layout] replan unused berth sea.berth.0
 23.43  [SEA][Layout] berth sea.berth.0 armsy at=2144,3696 facing=1
 24.00  [Playtest] eco team 0 at 24.0 min: metal +32.3 bank 1050/1050, energy +1522.0 bank 3350/3650, units 28
 25.00  [Playtest] eco team 0 at 25.0 min: metal +22.0 bank 1050/1050, energy +46.0 bank 583/600, units 14
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 1039/1050, energy +0.0 bank 1/500, units 12
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 1039/1050, energy +0.0 bank 1/500, units 12
 27.67  [SEA][Layout] berth sea.berth.4 corsy at=2192,4000 facing=1
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 1039/1050, energy +0.0 bank 1/500, units 12
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 500/500, energy +0.0 bank 1/500, units 0
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 500/500, energy +0.0 bank 1/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
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
