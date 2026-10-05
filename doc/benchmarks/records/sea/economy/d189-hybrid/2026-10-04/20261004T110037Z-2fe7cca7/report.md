# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54201); wall 207 s
- DLL: build-theatres\d189-build-6\SkirmishAI.dll (fa67b4da76d8a753); AI BARbTest/test; staged 2026-10-04T07:57:08
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-hybrid\glacial\20261004T105707Z-bde079c5\runs\20261004T110037Z-2fe7cca7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:32.275657][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:46.079418][f=0001363] [SeaWatch] finished frame=1363 id=9800 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:00:53.251577][f=0004590] [SeaWatch] egress id=7065 yard=9800 seconds=4.7 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-hybrid\glacial\20261004T105707Z-bde079c5\runs\20261004T110037Z-2fe7cca7\screen_2026-10-04_10-58-15-693.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-hybrid\glacial\20261004T105707Z-bde079c5\runs\20261004T110037Z-2fe7cca7\screen_2026-10-04_10-58-37-865.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-hybrid\glacial\20261004T105707Z-bde079c5\runs\20261004T110037Z-2fe7cca7\screen_2026-10-04_10-59-31-654.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-hybrid\glacial\20261004T105707Z-bde079c5\runs\20261004T110037Z-2fe7cca7\screen_2026-10-04_11-00-29-420.png

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
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.76  [Playtest] finished armsy team 0 at 0.76 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 712/1200, energy +30.0 bank 65/1100, units 5
  1.18  [Playtest] finished armtide team 0 at 1.18 min
  1.41  [Playtest] finished armtide team 0 at 1.41 min
  1.58  [Playtest] finished armtide team 0 at 1.58 min
  1.72  [Playtest] finished armtide team 0 at 1.72 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 428/1200, energy +129.0 bank 905/1350, units 11
  2.10  [Playtest] finished armmex team 0 at 2.10 min
  2.46  [Playtest] finished armtide team 0 at 2.46 min
  2.48  [Playtest] finished armmex team 0 at 2.48 min
  2.76  [Playtest] finished armtide team 0 at 2.76 min
  2.79  [Playtest] finished armfrad team 0 at 2.79 min
  2.86  [Playtest] finished armtl team 0 at 2.86 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 60/1300, energy +182.0 bank 824/1500, units 18
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 0/1300, energy +182.0 bank 1483/1500, units 20
  4.59  [Playtest] finished armmex team 0 at 4.59 min
  4.81  [Playtest] finished armmex team 0 at 4.81 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +14.0 bank 32/1400, energy +182.0 bank 1468/1500, units 24
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.00  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.04  [Playtest] finished armtide team 0 at 5.04 min
  5.31  [Playtest] finished armmex team 0 at 5.31 min
  5.35  [Playtest] finished armtide team 0 at 5.35 min
  5.49  [Playtest] finished armfmkr team 0 at 5.49 min
  5.54  [Playtest] finished armllt team 0 at 5.54 min
  5.81  [Playtest] finished armtide team 0 at 5.81 min
  5.86  [Playtest] finished armmex team 0 at 5.86 min
  5.98  [Playtest] finished armtide team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +19.0 bank 8/1500, energy +262.5 bank 1498/1700, units 34
  6.07  [Playtest] finished armmex team 0 at 6.07 min
  6.25  [Playtest] finished armmex team 0 at 6.25 min
  6.39  [Playtest] finished armtide team 0 at 6.39 min
  6.50  [Playtest] finished armtide team 0 at 6.50 min
  6.85  [Playtest] finished armmex team 0 at 6.85 min
  6.95  [Playtest] finished armtide team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +25.0 bank 244/1650, energy +343.0 bank 1786/1850, units 42
  7.09  [Playtest] finished armfmkr team 0 at 7.09 min
  7.09  [Playtest] finished armmex team 0 at 7.09 min
  7.25  [Playtest] finished armllt team 0 at 7.25 min
  7.26  [Playtest] finished armtide team 0 at 7.26 min
  7.45  [Playtest] finished armmex team 0 at 7.45 min
  7.45  [Playtest] finished armfmkr team 0 at 7.45 min
  7.57  [Playtest] finished armtide team 0 at 7.57 min
  7.65  [Playtest] finished armmex team 0 at 7.65 min
  7.84  [Playtest] finished armfmkr team 0 at 7.84 min
  7.91  [Playtest] finished armtide team 0 at 7.91 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +32.9 bank 772/1800, energy +412.0 bank 1603/2000, units 50
  8.15  [Playtest] finished armmex team 0 at 8.15 min
  8.21  [Playtest] finished armfmkr team 0 at 8.21 min
  8.23  [Playtest] finished armtide team 0 at 8.23 min
  8.38  [Playtest] finished armmex team 0 at 8.38 min
  8.60  [Playtest] finished armmex team 0 at 8.60 min
  8.63  [Playtest] finished armtide team 0 at 8.63 min
  8.78  [Playtest] finished armmex team 0 at 8.78 min
  8.86  [Playtest] finished armtide team 0 at 8.86 min
  8.95  [Playtest] finished armllt team 0 at 8.95 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +42.7 bank 1858/2000, energy +488.0 bank 1807/2200, units 62
  9.08  [Playtest] finished armtide team 0 at 9.08 min
  9.27  [Playtest] finished armtide team 0 at 9.27 min
  9.40  [Playtest] finished armtide team 0 at 9.40 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +41.3 bank 1885/2000, energy +557.0 bank 1877/2350, units 67
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] finished armmex team 0 at 10.01 min
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.03  [Playtest] finished armnanotcplat team 0 at 10.03 min
 10.12  [Playtest] finished armnanotcplat team 0 at 10.11 min
 10.32  [Playtest] finished armmex team 0 at 10.32 min
 10.36  [Playtest] finished armtide team 0 at 10.36 min
 10.43  [Playtest] finished armtide team 0 at 10.43 min
 10.73  [Playtest] finished armtide team 0 at 10.73 min
 10.75  [Playtest] finished armtide team 0 at 10.75 min
 10.91  [Playtest] finished armtide team 0 at 10.91 min
 10.93  [Playtest] finished armmex team 0 at 10.93 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +49.0 bank 1793/2150, energy +693.0 bank 2184/2750, units 78
 11.09  [Playtest] finished armtide team 0 at 11.09 min
 11.11  [Playtest] finished armtide team 0 at 11.11 min
 11.20  [Playtest] finished armmex team 0 at 11.20 min
 11.30  [Playtest] finished armtide team 0 at 11.30 min
 11.32  [Playtest] finished armtide team 0 at 11.32 min
 11.49  [Playtest] finished armtl team 0 at 11.49 min
 11.52  [Playtest] finished armtide team 0 at 11.52 min
 11.52  [Playtest] finished armtide team 0 at 11.52 min
 11.65  [Playtest] finished armtide team 0 at 11.65 min
 11.78  [Playtest] finished armtide team 0 at 11.78 min
 11.85  [Playtest] finished armmex team 0 at 11.85 min
 11.91  [Playtest] finished armtide team 0 at 11.91 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +53.0 bank 1147/2250, energy +900.0 bank 3178/3200, units 88
 12.05  [Playtest] finished armtl team 0 at 12.05 min
 12.16  [Playtest] finished armmex team 0 at 12.16 min
 12.22  [Playtest] finished armtide team 0 at 12.22 min
 12.35  [Playtest] finished armtide team 0 at 12.35 min
 12.45  [Playtest] finished armmex team 0 at 12.45 min
 12.55  [Playtest] finished armtide team 0 at 12.55 min
 12.67  [Playtest] finished armtide team 0 at 12.67 min
 12.89  [Playtest] finished armtide team 0 at 12.89 min
 12.99  [Playtest] finished armtide team 0 at 12.99 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +57.0 bank 82/2350, energy +1015.0 bank 3155/3500, units 98
 13.27  [Playtest] finished armtl team 0 at 13.27 min
 13.46  [Playtest] finished armtide team 0 at 13.46 min
 13.48  [Playtest] finished armasy team 0 at 13.48 min
 13.54  [Playtest] finished armtide team 0 at 13.54 min
 13.80  [Playtest] finished armtide team 0 at 13.80 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +57.0 bank 170/2550, energy +1100.0 bank 3771/3800, units 103
 14.14  [Playtest] finished armtide team 0 at 14.14 min
 14.14  [Playtest] finished armtl team 0 at 14.14 min
 14.19  [Playtest] finished armtide team 0 at 14.19 min
 14.25  [Playtest] finished armfmkr team 0 at 14.25 min
 14.68  [Playtest] finished armtide team 0 at 14.68 min
 14.73  [Playtest] finished armtl team 0 at 14.73 min
 14.76  [Playtest] finished armtide team 0 at 14.76 min
 14.92  [Playtest] finished armuwmme team 0 at 14.92 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +58.4 bank 214/3000, energy +1245.0 bank 3340/4250, units 105
 15.03  [Playtest] finished armtide team 0 at 15.03 min
 15.19  [Playtest] finished armnanotcplat team 0 at 15.19 min
 15.47  [Playtest] finished armrl team 0 at 15.47 min
 15.66  [Playtest] finished armuwmme team 0 at 15.66 min
 15.91  [Playtest] finished armuwmme team 0 at 15.91 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +66.0 bank 43/3950, energy +1261.0 bank 4048/4250, units 103
 17.00  [Playtest] eco team 0 at 17.0 min: metal +60.0 bank 2/3800, energy +1247.0 bank 4055/4150, units 93
 17.27  [Playtest] finished armbats team 0 at 17.27 min
 17.30  [Playtest] finished armmex team 0 at 17.30 min
 17.34  [Playtest] finished armason team 0 at 17.34 min
 17.56  [Playtest] finished armnanotcplat team 0 at 17.56 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +62.0 bank 23/3850, energy +1224.0 bank 3936/4050, units 97
 19.00  [Playtest] eco team 0 at 19.0 min: metal +60.0 bank 0/3800, energy +1254.0 bank 4065/4200, units 96
 19.14  [Playtest] finished armuwfus team 0 at 19.14 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +60.0 bank 41/3800, energy +2447.0 bank 6574/6650, units 97
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.39  [Playtest] finished armtide team 0 at 20.39 min
 20.85  [Playtest] finished armfmkr team 0 at 20.85 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +61.0 bank 117/3800, energy +2777.0 bank 8115/8250, units 104
 21.23  [Playtest] finished armfmkr team 0 at 21.23 min
 21.27  [Playtest] finished armuwmmm team 0 at 21.27 min
 21.47  [Playtest] finished armuwmmm team 0 at 21.47 min
 21.60  [Playtest] finished armfmkr team 0 at 21.60 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +72.6 bank 101/3800, energy +2332.0 bank 5342/6400, units 98
 22.25  [Playtest] finished armuwmmm team 0 at 22.25 min
 22.93  [Playtest] finished armmex team 0 at 22.92 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +72.5 bank 1206/3850, energy +2178.0 bank 4990/6100, units 88
 24.00  [Playtest] eco team 0 at 24.0 min: metal +78.8 bank 47/3800, energy +2171.0 bank 5212/6050, units 85
 24.89  [Playtest] finished armuwfus team 0 at 24.89 min
 24.97  [Playtest] finished armbats team 0 at 24.97 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +254.5 bank 1283/3100, energy +3302.0 bank 8011/8300, units 78
 25.82  [Playtest] finished armnanotcplat team 0 at 25.82 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +74.5 bank 2547/3100, energy +3302.0 bank 7012/8300, units 85
 26.00  [Playtest] finished armmex team 0 at 26.00 min
 26.29  [Playtest] finished armuwmmm team 0 at 26.29 min
 26.66  [Playtest] finished armuwmmm team 0 at 26.66 min
 26.82  [Playtest] finished armuwmme team 0 at 26.82 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +99.4 bank 2885/3700, energy +3362.0 bank 7532/8600, units 88
 27.26  [Playtest] finished armnanotcplat team 0 at 27.26 min
 27.47  [Playtest] finished armnanotcplat team 0 at 27.47 min
 27.77  [Playtest] finished armnanotcplat team 0 at 27.77 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +85.9 bank 3264/3700, energy +3669.0 bank 8537/10150, units 95
 28.05  [Playtest] finished armrl team 0 at 28.05 min
 28.08  [Playtest] finished armnanotcplat team 0 at 28.08 min
 28.09  [Playtest] finished armuwmmm team 0 at 28.09 min
 28.50  [Playtest] finished armuwmme team 0 at 28.50 min
 28.55  [Playtest] finished armbats team 0 at 28.56 min
 28.73  [Playtest] finished armfmkr team 0 at 28.73 min
 28.96  [Playtest] finished armtide team 0 at 28.96 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +83.2 bank 3214/4300, energy +3722.0 bank 8401/10350, units 102
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.17  [Playtest] finished armmex team 0 at 29.17 min
 29.33  [Playtest] finished armatl team 0 at 29.33 min
 29.48  [Playtest] finished armmship team 0 at 29.48 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +82.7 bank 197/4350, energy +3722.0 bank 8773/10350, units 109
 30.02  [Playtest] finished armatl team 0 at 30.02 min
 30.03  [Playtest] finished armatl team 0 at 30.03 min
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
