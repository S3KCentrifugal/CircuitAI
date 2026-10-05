# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54058); wall 240 s
- DLL: build-theatres\d189-build-6\SkirmishAI.dll (fa67b4da76d8a753); AI BARbTest/test; staged 2026-10-04T07:52:31
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T105231Z-f60b8c3d\runs\20261004T105634Z-7f283f6c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:30.483564][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:43.560731][f=0001352] [SeaWatch] finished frame=1352 id=9800 def=legsy builder=27123` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:00:50.353676][f=0004410] [SeaWatch] egress id=11953 yard=9800 seconds=3.8 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T105231Z-f60b8c3d\runs\20261004T105634Z-7f283f6c\screen_2026-10-04_10-53-36-891.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T105231Z-f60b8c3d\runs\20261004T105634Z-7f283f6c\screen_2026-10-04_10-53-59-858.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T105231Z-f60b8c3d\runs\20261004T105634Z-7f283f6c\screen_2026-10-04_10-55-12-945.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T105231Z-f60b8c3d\runs\20261004T105634Z-7f283f6c\screen_2026-10-04_10-56-26-929.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 legsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|legion|legsy|1430|4000|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.12  [SEA][Layout] berth sea.berth.1 legadvshipyard at=1424,3600 facing=1
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.16  [Playtest] finished legmex team 0 at 0.16 min
  0.17  [SEA][Layout] berth sea.berth.2 legadvshipyard at=1472,3296 facing=3
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|1430|4000|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished legmex team 0 at 0.28 min
  0.75  [Playtest] finished legsy team 0 at 0.75 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 717/1200, energy +30.0 bank 103/1100, units 5
  1.17  [Playtest] finished legtide team 0 at 1.17 min
  1.43  [Playtest] finished legtide team 0 at 1.43 min
  1.57  [Playtest] finished legtide team 0 at 1.57 min
  1.80  [Playtest] finished legtide team 0 at 1.80 min
  1.93  [Playtest] finished legtide team 0 at 1.93 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 395/1200, energy +150.0 bank 417/1400, units 12
  2.16  [Playtest] finished legmex team 0 at 2.16 min
  2.40  [Playtest] finished legtide team 0 at 2.40 min
  2.78  [Playtest] finished legtide team 0 at 2.78 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 318/1250, energy +201.0 bank 1540/1550, units 18
  3.09  [Playtest] finished legtide team 0 at 3.09 min
  3.45  [Playtest] finished legtide team 0 at 3.45 min
  3.52  [Playtest] finished legtide team 0 at 3.52 min
  3.59  [Playtest] finished legmex team 0 at 3.59 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 0/1300, energy +270.0 bank 1689/1700, units 24
  4.42  [Playtest] finished legfrad team 0 at 4.42 min
  4.54  [Playtest] finished legmex team 0 at 4.54 min
  4.80  [Playtest] finished legmex team 0 at 4.80 min
  4.98  [Playtest] finished legtide team 0 at 4.98 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +14.0 bank 0/1400, energy +281.5 bank 1728/1750, units 27
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.04  [Playtest] finished legmex team 0 at 5.04 min
  5.22  [Playtest] finished legmex team 0 at 5.22 min
  5.43  [Playtest] finished legfeconv team 0 at 5.43 min
  5.54  [Playtest] finished legtide team 0 at 5.54 min
  5.72  [Playtest] finished legmex team 0 at 5.72 min
  5.94  [Playtest] finished legmex team 0 at 5.94 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +23.0 bank 327/1600, energy +316.0 bank 1730/1800, units 36
  6.07  [Playtest] finished legfeconv team 0 at 6.07 min
  6.13  [Playtest] finished legmex team 0 at 6.13 min
  6.29  [Playtest] finished legmex team 0 at 6.29 min
  6.41  [Playtest] finished legtide team 0 at 6.41 min
  6.52  [Playtest] finished legtide team 0 at 6.52 min
  6.71  [Playtest] finished legmex team 0 at 6.72 min
  6.73  [Playtest] finished legtide team 0 at 6.73 min
  6.85  [Playtest] finished legmex team 0 at 6.85 min
  6.87  [Playtest] finished legtide team 0 at 6.87 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +32.0 bank 910/1800, energy +413.0 bank 1937/2050, units 49
  7.04  [Playtest] finished legmex team 0 at 7.04 min
  7.05  [Playtest] finished legtide team 0 at 7.05 min
  7.08  [Playtest] finished legmex team 0 at 7.08 min
  7.19  [Playtest] finished legtide team 0 at 7.19 min
  7.27  [Playtest] finished legmex team 0 at 7.27 min
  7.37  [Playtest] finished legmex team 0 at 7.37 min
  7.74  [Playtest] finished legmex team 0 at 7.74 min
  7.90  [Playtest] finished legnanotcplat team 0 at 7.90 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +40.0 bank 1617/2000, energy +459.0 bank 2051/2150, units 54
  8.22  [Playtest] finished legmex team 0 at 8.22 min
  8.30  [Playtest] finished legmex team 0 at 8.30 min
  8.44  [Playtest] finished legtide team 0 at 8.44 min
  8.48  [Playtest] finished legtl team 0 at 8.48 min
  8.62  [Playtest] finished legtide team 0 at 8.62 min
  8.63  [Playtest] finished legmex team 0 at 8.63 min
  8.71  [Playtest] finished legmex team 0 at 8.71 min
  8.80  [Playtest] finished legtide team 0 at 8.80 min
  8.95  [Playtest] finished legmex team 0 at 8.95 min
  8.96  [Playtest] finished legtide team 0 at 8.96 min
  8.98  [Playtest] finished legmex team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +51.0 bank 2164/2300, energy +561.0 bank 2402/2450, units 70
  9.14  [Playtest] finished legtide team 0 at 9.14 min
  9.16  [Playtest] finished legmex team 0 at 9.16 min
  9.30  [Playtest] finished legmex team 0 at 9.30 min
  9.34  [Playtest] finished legmex team 0 at 9.34 min
  9.42  [Playtest] finished legtide team 0 at 9.42 min
  9.43  [Playtest] finished legtide team 0 at 9.43 min
  9.50  [Playtest] finished leglht team 0 at 9.50 min
  9.56  [Playtest] finished legtide team 0 at 9.56 min
  9.61  [Playtest] finished legrad team 0 at 9.60 min
  9.64  [Playtest] finished legtide team 0 at 9.64 min
  9.87  [Playtest] finished legtl team 0 at 9.87 min
  9.89  [Playtest] finished legtide team 0 at 9.89 min
  9.92  [Playtest] finished legtide team 0 at 9.92 min
  9.96  [Playtest] finished legmex team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +60.0 bank 2301/2500, energy +727.0 bank 2812/2850, units 86
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.18  [Playtest] finished legtide team 0 at 10.18 min
 10.30  [Playtest] finished legmex team 0 at 10.30 min
 10.31  [Playtest] finished legnanotcplat team 0 at 10.31 min
 10.51  [Playtest] finished legnanotcplat team 0 at 10.51 min
 10.54  [Playtest] finished legfrad team 0 at 10.54 min
 10.69  [Playtest] finished legtide team 0 at 10.69 min
 10.69  [Playtest] finished legmex team 0 at 10.69 min
 10.84  [Playtest] finished legtide team 0 at 10.84 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +64.0 bank 2382/2600, energy +796.0 bank 2200/3000, units 105
 11.04  [Playtest] finished legfeconv team 0 at 11.04 min
 11.06  [Playtest] finished legtide team 0 at 11.06 min
 11.09  [Playtest] finished legtide team 0 at 11.09 min
 11.12  [Playtest] finished legtide team 0 at 11.12 min
 11.18  [Playtest] finished legfeconv team 0 at 11.18 min
 11.31  [Playtest] finished legtl team 0 at 11.31 min
 11.32  [Playtest] finished legfeconv team 0 at 11.32 min
 11.40  [Playtest] finished legtide team 0 at 11.40 min
 11.58  [Playtest] finished legtide team 0 at 11.58 min
 11.64  [Playtest] finished legtide team 0 at 11.64 min
 11.66  [Playtest] finished legtide team 0 at 11.66 min
 11.91  [Playtest] finished legtide team 0 at 11.91 min
 11.98  [Playtest] finished legtide team 0 at 11.98 min
 11.99  [Playtest] finished legtide team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +67.0 bank 2599/2600, energy +991.5 bank 3470/3500, units 116
 12.66  [Playtest] finished legtide team 0 at 12.66 min
 12.68  [Playtest] finished legfrad team 0 at 12.68 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +67.0 bank 2180/2600, energy +1049.0 bank 3515/3550, units 125
 13.03  [Playtest] finished legtide team 0 at 13.03 min
 13.08  [Playtest] finished legtide team 0 at 13.08 min
 13.13  [Playtest] finished leglht team 0 at 13.13 min
 13.36  [Playtest] finished legtide team 0 at 13.36 min
 13.38  [Playtest] finished legadvshipyard team 0 at 13.38 min
 13.42  [Playtest] finished legtide team 0 at 13.42 min
 13.81  [Playtest] finished legtide team 0 at 13.81 min
 13.86  [Playtest] finished legfeconv team 0 at 13.86 min
 13.95  [Playtest] finished legtide team 0 at 13.95 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +68.0 bank 2799/2800, energy +1187.0 bank 4010/4050, units 126
 14.19  [Playtest] finished legtide team 0 at 14.19 min
 14.27  [Playtest] finished legtide team 0 at 14.27 min
 14.36  [Playtest] finished legtide team 0 at 14.36 min
 14.69  [Playtest] finished legnanotcplat team 0 at 14.69 min
 14.82  [Playtest] finished legtl team 0 at 14.82 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +68.0 bank 2790/2800, energy +1256.0 bank 4109/4200, units 141
 15.13  [Playtest] finished legmex team 0 at 15.13 min
 15.26  [Playtest] finished legtide team 0 at 15.26 min
 15.47  [Playtest] finished legfrad team 0 at 15.47 min
 15.58  [Playtest] finished legtide team 0 at 15.58 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +73.1 bank 2822/2850, energy +1302.0 bank 3963/4300, units 149
 16.72  [Playtest] finished legmex team 0 at 16.72 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +70.0 bank 2808/2850, energy +1302.0 bank 3359/4300, units 155
 17.10  [SEA][Layout] berth sea.berth.3 legsy at=3200,4336 facing=1
 17.82  [Playtest] finished coruwmme team 0 at 17.82 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +72.1 bank 2858/3350, energy +1302.0 bank 3368/4300, units 164
 18.04  [Playtest] finished legmex team 0 at 18.03 min
 18.20  [Playtest] finished legmex team 0 at 18.20 min
 18.34  [Playtest] finished coruwmme team 0 at 18.34 min
 18.49  [Playtest] finished legfrad team 0 at 18.49 min
 18.64  [Playtest] finished legmex team 0 at 18.64 min
 18.97  [Playtest] finished legfrad team 0 at 18.97 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +86.0 bank 3140/4050, energy +1302.0 bank 4260/4300, units 173
 19.02  [Playtest] finished legmex team 0 at 19.02 min
 19.03  [Playtest] finished legmex team 0 at 19.03 min
 19.56  [Playtest] finished legtl team 0 at 19.56 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +87.3 bank 3215/4150, energy +1302.0 bank 3285/4300, units 183
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.01  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.20  [Playtest] finished legfrad team 0 at 20.20 min
 20.35  [SEA][Layout] berth sea.berth.4 legsy at=3216,4176 facing=1
 20.63  [Playtest] finished legtl team 0 at 20.63 min
 20.89  [Playtest] finished legmex team 0 at 20.89 min
 20.91  [Playtest] finished legtl team 0 at 20.91 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +92.0 bank 3597/4200, energy +1302.0 bank 4156/4300, units 185
 21.11  [Playtest] finished legfeconv team 0 at 21.11 min
 21.29  [Playtest] finished legmex team 0 at 21.29 min
 21.40  [Playtest] finished legtl team 0 at 21.40 min
 21.95  [Playtest] finished legmex team 0 at 21.95 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +97.0 bank 3343/4300, energy +1302.0 bank 4125/4300, units 196
 22.18  [Playtest] finished legmex team 0 at 22.18 min
 22.35  [SEA][Layout] berth sea.berth.5 legsy at=3216,4176 facing=1
 22.40  [Playtest] finished legmex team 0 at 22.40 min
 22.46  [Playtest] finished legfrad team 0 at 22.46 min
 22.47  [Playtest] finished legfrad team 0 at 22.47 min
 22.78  [Playtest] finished legtl team 0 at 22.78 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +97.6 bank 4193/4400, energy +1302.0 bank 3369/4300, units 189
 24.00  [Playtest] eco team 0 at 24.0 min: metal +101.0 bank 3558/4400, energy +1302.0 bank 4042/4300, units 195
 24.09  [Playtest] finished leglht team 0 at 24.09 min
 24.61  [Playtest] finished legtl team 0 at 24.61 min
 24.83  [Playtest] finished legmex team 0 at 24.83 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +103.0 bank 4191/4450, energy +1332.0 bank 3985/4450, units 214
 25.05  [Playtest] finished coruwmme team 0 at 25.05 min
 25.08  [Playtest] finished legmex team 0 at 25.08 min
 25.15  [Playtest] finished legfrad team 0 at 25.15 min
 25.19  [Playtest] finished legfeconv team 0 at 25.19 min
 25.35  [SEA][Layout] berth sea.berth.6 corsy at=2048,4256 facing=2
 25.38  [Playtest] finished legtl team 0 at 25.38 min
 25.51  [Playtest] finished legtl team 0 at 25.51 min
 25.59  [Playtest] finished legmex team 0 at 25.59 min
 25.86  [Playtest] finished corsy team 0 at 25.86 min
 25.88  [Playtest] finished legmex team 0 at 25.88 min
 25.94  [Playtest] finished legmex team 0 at 25.94 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +116.0 bank 4584/5250, energy +1332.0 bank 4394/4550, units 230
 26.22  [SEA][Layout] berth sea.berth.7 corsy at=1680,4624 facing=1
 26.22  [Playtest] finished legfrad team 0 at 26.22 min
 26.43  [Playtest] finished legtl team 0 at 26.43 min
 26.86  [Playtest] finished legtl team 0 at 26.86 min
 26.99  [Playtest] finished legtl team 0 at 26.99 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +116.0 bank 4020/5250, energy +1346.0 bank 4329/4650, units 247
 27.20  [Playtest] finished cornanotcplat team 0 at 27.20 min
 27.31  [Playtest] finished legmex team 0 at 27.31 min
 27.36  [Playtest] finished legtl team 0 at 27.36 min
 27.63  [Playtest] finished cortl team 0 at 27.63 min
 27.70  [Playtest] finished legfrad team 0 at 27.70 min
 27.73  [Playtest] finished legtl team 0 at 27.73 min
 27.83  [Playtest] finished legtl team 0 at 27.83 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +118.0 bank 4591/5300, energy +1346.0 bank 4326/4650, units 257
 28.07  [SEA][Layout] berth sea.berth.8 corasy at=2320,3632 facing=1
 28.11  [Playtest] finished armtl team 0 at 28.11 min
 28.17  [Playtest] finished coruwmme team 0 at 28.17 min
 28.34  [Playtest] finished legmex team 0 at 28.34 min
 28.40  [Playtest] finished coruwfus team 0 at 28.40 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +122.0 bank 5405/5800, energy +2566.0 bank 7086/7150, units 267
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.00  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.00  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.71  [Playtest] finished corasy team 0 at 29.71 min
 29.93  [Playtest] finished coruwfus team 0 at 29.93 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +122.0 bank 4075/6000, energy +3793.0 bank 9802/9900, units 278
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1208, 4072) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1208, 4008) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1208, 3944) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1272, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1272, 4072) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1272, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1272, 4008) facing 1 (id 6)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (1304, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1304, 4072) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1304, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1304, 4008) facing 1 (id 8)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 at (1288, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1288, 4104) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1288, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1288, 4040) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1288, 3976) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1352, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1352, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1352, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1352, 4040) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1352, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1352, 3976) facing 1 (id 14)
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
