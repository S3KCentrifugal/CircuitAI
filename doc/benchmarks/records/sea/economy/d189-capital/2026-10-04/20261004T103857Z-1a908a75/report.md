# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54036); wall 298 s
- DLL: build-theatres\d189-build-5\SkirmishAI.dll (1b875078bc2aa763); AI BARbTest/test; staged 2026-10-04T07:33:55
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-capital\glacial\20261004T103355Z-fe58737c\runs\20261004T103857Z-1a908a75\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:42.728099][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:01:01.514584][f=0001399] [SeaWatch] finished frame=1399 id=9050 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:01:08.304249][f=0004440] [SeaWatch] egress id=19532 yard=9050 seconds=15.2 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-capital\glacial\20261004T103355Z-fe58737c\runs\20261004T103857Z-1a908a75\screen_2026-10-04_10-35-20-789.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-capital\glacial\20261004T103355Z-fe58737c\runs\20261004T103857Z-1a908a75\screen_2026-10-04_10-35-46-978.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-capital\glacial\20261004T103355Z-fe58737c\runs\20261004T103857Z-1a908a75\screen_2026-10-04_10-37-13-532.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-capital\glacial\20261004T103355Z-fe58737c\runs\20261004T103857Z-1a908a75\screen_2026-10-04_10-38-45-026.png

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
  0.78  [Playtest] finished armsy team 0 at 0.78 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 718/1200, energy +30.0 bank 85/1100, units 5
  1.25  [Playtest] finished armtide team 0 at 1.25 min
  1.56  [Playtest] finished armtide team 0 at 1.56 min
  1.83  [Playtest] finished armtide team 0 at 1.83 min
  1.98  [Playtest] finished armtide team 0 at 1.98 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 467/1200, energy +117.5 bank 236/1350, units 10
  2.26  [Playtest] finished armtide team 0 at 2.26 min
  2.35  [Playtest] finished armmex team 0 at 2.35 min
  2.38  [Playtest] finished armtide team 0 at 2.38 min
  2.68  [Playtest] finished armmex team 0 at 2.68 min
  2.81  [Playtest] finished armfrad team 0 at 2.81 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 179/1300, energy +182.0 bank 1481/1500, units 19
  3.19  [Playtest] finished armtide team 0 at 3.19 min
  3.23  [Playtest] finished armtide team 0 at 3.23 min
  3.55  [Playtest] finished armmex team 0 at 3.55 min
  3.64  [Playtest] finished armtide team 0 at 3.64 min
  3.83  [Playtest] finished armmex team 0 at 3.83 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.0 bank 0/1400, energy +251.0 bank 1633/1650, units 26
  4.01  [Playtest] finished armtide team 0 at 4.01 min
  4.09  [Playtest] finished armmex team 0 at 4.09 min
  4.28  [Playtest] finished armmex team 0 at 4.28 min
  4.48  [Playtest] finished armtide team 0 at 4.48 min
  4.68  [Playtest] finished armtide team 0 at 4.68 min
  4.79  [Playtest] finished armmex team 0 at 4.79 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.0 bank 70/1550, energy +320.0 bank 1776/1800, units 31
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.02  [Playtest] finished armmex team 0 at 5.02 min
  5.22  [Playtest] finished armmex team 0 at 5.22 min
  5.23  [Playtest] finished armtide team 0 at 5.23 min
  5.40  [Playtest] finished armmex team 0 at 5.40 min
  5.74  [Playtest] finished armtide team 0 at 5.74 min
  5.82  [Playtest] finished armfmkr team 0 at 5.82 min
  5.97  [Playtest] finished armmex team 0 at 5.97 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +29.0 bank 674/1750, energy +373.0 bank 1896/1950, units 41
  6.07  [Playtest] finished armtide team 0 at 6.07 min
  6.19  [Playtest] finished armmex team 0 at 6.19 min
  6.39  [Playtest] finished armtide team 0 at 6.39 min
  6.39  [Playtest] finished armmex team 0 at 6.39 min
  6.57  [Playtest] finished armmex team 0 at 6.57 min
  6.61  [Playtest] finished armnanotcplat team 0 at 6.61 min
  6.70  [Playtest] finished armtide team 0 at 6.70 min
  6.91  [Playtest] finished armnanotcplat team 0 at 6.91 min
  6.96  [Playtest] finished armfmkr team 0 at 6.96 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +36.0 bank 1197/1900, energy +442.0 bank 1576/2100, units 52
  7.02  [Playtest] finished armtide team 0 at 7.02 min
  7.08  [Playtest] finished armmex team 0 at 7.07 min
  7.24  [Playtest] finished armfmkr team 0 at 7.24 min
  7.32  [Playtest] finished armmex team 0 at 7.32 min
  7.40  [Playtest] finished armtide team 0 at 7.40 min
  7.53  [Playtest] finished armmex team 0 at 7.53 min
  7.60  [Playtest] finished armtide team 0 at 7.60 min
  7.70  [Playtest] finished armfmkr team 0 at 7.70 min
  7.71  [Playtest] finished armtide team 0 at 7.71 min
  7.72  [Playtest] finished armmex team 0 at 7.72 min
  7.92  [Playtest] finished armtide team 0 at 7.92 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +46.0 bank 960/2100, energy +564.0 bank 2070/2400, units 63
  8.03  [Playtest] finished armtide team 0 at 8.03 min
  8.08  [Playtest] finished armfmkr team 0 at 8.08 min
  8.32  [Playtest] finished armtide team 0 at 8.32 min
  8.37  [Playtest] finished armfmkr team 0 at 8.37 min
  8.54  [Playtest] finished armtide team 0 at 8.54 min
  8.54  [Playtest] finished armtide team 0 at 8.54 min
  8.86  [Playtest] finished armtide team 0 at 8.86 min
  8.88  [Playtest] finished armtide team 0 at 8.88 min
  8.89  [Playtest] finished armtide team 0 at 8.89 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +48.0 bank 912/2100, energy +732.0 bank 2703/2800, units 75
  9.03  [Playtest] finished armtide team 0 at 9.03 min
  9.32  [Playtest] finished armtide team 0 at 9.32 min
  9.34  [Playtest] finished armtide team 0 at 9.34 min
  9.52  [Playtest] finished armtide team 0 at 9.52 min
  9.64  [Playtest] finished armtide team 0 at 9.64 min
  9.64  [Playtest] finished armfmkr team 0 at 9.64 min
  9.66  [Playtest] finished armtide team 0 at 9.66 min
  9.93  [Playtest] finished armtide team 0 at 9.93 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +49.0 bank 1019/2100, energy +900.0 bank 3100/3200, units 86
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.12  [Playtest] finished armtide team 0 at 10.12 min
 10.28  [Playtest] finished armtide team 0 at 10.28 min
 10.34  [Playtest] finished armtide team 0 at 10.34 min
 10.56  [Playtest] finished armtide team 0 at 10.56 min
 10.60  [Playtest] finished armtide team 0 at 10.60 min
 10.66  [Playtest] finished armtide team 0 at 10.66 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +49.0 bank 0/2100, energy +1038.0 bank 3500/3500, units 92
 11.01  [Playtest] finished armmex team 0 at 11.01 min
 11.05  [Playtest] finished armtide team 0 at 11.05 min
 11.27  [Playtest] finished armtide team 0 at 11.27 min
 11.42  [Playtest] finished armtide team 0 at 11.42 min
 11.42  [Playtest] finished armfmkr team 0 at 11.42 min
 11.63  [Playtest] finished armasy team 0 at 11.63 min
 11.74  [Playtest] finished armtide team 0 at 11.74 min
 11.77  [Playtest] finished armfrad team 0 at 11.77 min
 11.87  [Playtest] finished armtide team 0 at 11.87 min
 11.87  [Playtest] finished armtide team 0 at 11.87 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +52.0 bank 20/2350, energy +1176.0 bank 3756/4000, units 102
 12.10  [Playtest] finished armtide team 0 at 12.10 min
 12.26  [Playtest] finished armfmkr team 0 at 12.26 min
 12.35  [Playtest] finished armfmkr team 0 at 12.35 min
 12.42  [Playtest] finished armtide team 0 at 12.42 min
 12.49  [Playtest] finished armmex team 0 at 12.49 min
 12.54  [Playtest] finished armfmkr team 0 at 12.54 min
 12.62  [Playtest] finished armtide team 0 at 12.61 min
 12.63  [Playtest] finished armfmkr team 0 at 12.63 min
 12.97  [Playtest] finished armuwmme team 0 at 12.97 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +111.2 bank 23/2950, energy +1275.0 bank 3497/4300, units 109
 13.07  [Playtest] finished armtl team 0 at 13.07 min
 13.37  [Playtest] finished armmex team 0 at 13.37 min
 13.45  [Playtest] finished armfmkr team 0 at 13.45 min
 13.64  [Playtest] finished armtide team 0 at 13.64 min
 13.68  [Playtest] finished armmex team 0 at 13.68 min
 13.89  [Playtest] finished armtide team 0 at 13.89 min
 13.91  [Playtest] finished armuwmme team 0 at 13.91 min
 13.92  [Playtest] finished armtide team 0 at 13.92 min
 13.96  [Playtest] finished armuwmme team 0 at 13.96 min
 13.99  [Playtest] finished armmex team 0 at 13.99 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +74.7 bank 360/4150, energy +1374.0 bank 3669/4600, units 115
 14.24  [Playtest] finished armfrad team 0 at 14.24 min
 14.24  [Playtest] finished armmex team 0 at 14.24 min
 14.32  [Playtest] finished armnanotcplat team 0 at 14.32 min
 14.87  [Playtest] finished armmex team 0 at 14.87 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +70.5 bank 0/4000, energy +1374.0 bank 3727/4600, units 112
 16.00  [Playtest] eco team 0 at 16.0 min: metal +71.6 bank 0/4000, energy +1363.5 bank 3712/4500, units 111
 16.54  [Playtest] finished armuwfus team 0 at 16.54 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +73.0 bank 38/3950, energy +2853.0 bank 8368/8450, units 110
 17.12  [Playtest] finished armfmkr team 0 at 17.12 min
 17.28  [Playtest] finished armmex team 0 at 17.28 min
 17.48  [Playtest] finished armnanotcplat team 0 at 17.48 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +72.0 bank 37/3900, energy +2546.0 bank 6733/6900, units 110
 18.22  [Playtest] finished armbats team 0 at 18.22 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +72.0 bank 37/3900, energy +2546.0 bank 6715/6900, units 112
 19.17  [Playtest] finished armfmkr team 0 at 19.17 min
 19.44  [Playtest] finished armuwmmm team 0 at 19.44 min
 19.54  [Playtest] finished armfmkr team 0 at 19.54 min
 19.60  [Playtest] finished armuwmmm team 0 at 19.60 min
 19.91  [Playtest] finished armfmkr team 0 at 19.91 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +80.6 bank 1408/3900, energy +2853.0 bank 6144/6950, units 116
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.01  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.42  [Playtest] finished armnanotcplat team 0 at 20.42 min
 20.61  [Playtest] finished armatl team 0 at 20.61 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +82.2 bank 431/3900, energy +2546.0 bank 5972/6900, units 103
 21.01  [Playtest] finished armmex team 0 at 21.01 min
 21.18  [Playtest] finished armuwmmm team 0 at 21.18 min
 21.27  [Playtest] finished armfmkr team 0 at 21.27 min
 21.29  [Playtest] finished armbats team 0 at 21.29 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +75.0 bank 1450/2700, energy +1957.0 bank 3909/4900, units 70
 22.13  [Playtest] finished armuwmme team 0 at 22.13 min
 22.73  [SEA][Layout] replan unused berth sea.berth.2
 23.00  [Playtest] eco team 0 at 23.0 min: metal +54.0 bank 1799/1750, energy +1782.0 bank 3524/4350, units 51
 23.07  [SEA][Layout] berth sea.berth.2 armasy at=2496,3632 facing=1
 23.13  [Playtest] finished armuwmmm team 0 at 23.13 min
 23.42  [SEA][Layout] berth sea.berth.3 armsy at=1424,3232 facing=3
 23.63  [SEA][Layout] berth sea.berth.4 corsy at=1872,3808 facing=3
 24.00  [Playtest] eco team 0 at 24.0 min: metal +26.0 bank 1150/1150, energy +0.0 bank 456/500, units 13
 25.00  [Playtest] eco team 0 at 25.0 min: metal +26.0 bank 1150/1150, energy +0.0 bank 456/500, units 13
 26.00  [Playtest] eco team 0 at 26.0 min: metal +26.0 bank 1150/1150, energy +0.0 bank 456/500, units 13
 27.00  [Playtest] eco team 0 at 27.0 min: metal +6.0 bank 1150/1150, energy +0.0 bank 0/500, units 13
 28.00  [Playtest] eco team 0 at 28.0 min: metal +9.0 bank 1150/1150, energy +0.0 bank 0/500, units 13
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 1035/1150, energy +0.0 bank 0/500, units 13
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 1054/1150, energy +0.0 bank 0/500, units 13
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
