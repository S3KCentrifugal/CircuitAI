# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54057); wall 209 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:08:37
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\d189-legion-registration\glacial\20261004T110836Z-86a31aaf\runs\20261004T111251Z-57ab3ab4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:30.133340][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.7 min | `[t=00:00:43.104008][f=0001337] [SeaWatch] finished frame=1337 id=9800 def=legsy builder=27123` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:00:50.339041][f=0004590] [SeaWatch] egress id=27341 yard=9800 seconds=4.7 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\sea\economy\d189-legion-registration\glacial\20261004T110836Z-86a31aaf\runs\20261004T111251Z-57ab3ab4\screen_2026-10-04_11-10-11-452.png
- build-theatres\games\sea\economy\d189-legion-registration\glacial\20261004T110836Z-86a31aaf\runs\20261004T111251Z-57ab3ab4\screen_2026-10-04_11-10-33-161.png
- build-theatres\games\sea\economy\d189-legion-registration\glacial\20261004T110836Z-86a31aaf\runs\20261004T111251Z-57ab3ab4\screen_2026-10-04_11-11-30-844.png
- build-theatres\games\sea\economy\d189-legion-registration\glacial\20261004T110836Z-86a31aaf\runs\20261004T111251Z-57ab3ab4\screen_2026-10-04_11-12-42-308.png

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
  0.29  [Playtest] finished legmex team 0 at 0.29 min
  0.74  [Playtest] finished legsy team 0 at 0.74 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 713/1200, energy +30.0 bank 70/1100, units 5
  1.20  [Playtest] finished legtide team 0 at 1.20 min
  1.46  [Playtest] finished legtide team 0 at 1.46 min
  1.71  [Playtest] finished legtide team 0 at 1.71 min
  1.87  [Playtest] finished legtide team 0 at 1.87 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 411/1200, energy +127.0 bank 110/1350, units 12
  2.01  [Playtest] finished legtide team 0 at 2.01 min
  2.13  [Playtest] finished legmex team 0 at 2.13 min
  2.67  [Playtest] finished legtide team 0 at 2.67 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 474/1250, energy +178.0 bank 1487/1500, units 17
  3.15  [Playtest] finished legtide team 0 at 3.15 min
  3.30  [Playtest] finished legmex team 0 at 3.30 min
  3.39  [Playtest] finished legmex team 0 at 3.39 min
  3.47  [Playtest] finished legtide team 0 at 3.47 min
  3.59  [Playtest] finished legmex team 0 at 3.59 min
  3.79  [Playtest] finished legmex team 0 at 3.79 min
  3.88  [Playtest] finished legtide team 0 at 3.88 min
  3.95  [Playtest] finished legmex team 0 at 3.95 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +18.0 bank 41/1500, energy +247.0 bank 1632/1650, units 26
  4.20  [Playtest] finished legtide team 0 at 4.20 min
  4.44  [Playtest] finished legfeconv team 0 at 4.44 min
  4.45  [Playtest] finished legmex team 0 at 4.45 min
  4.52  [Playtest] finished legtide team 0 at 4.52 min
  4.67  [Playtest] finished legmex team 0 at 4.67 min
  4.86  [Playtest] finished legmex team 0 at 4.86 min
  4.87  [Playtest] finished legtide team 0 at 4.87 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +25.0 bank 240/1650, energy +316.0 bank 1678/1800, units 35
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.03  [Playtest] finished legmex team 0 at 5.03 min
  5.27  [Playtest] finished legfeconv team 0 at 5.27 min
  5.59  [Playtest] finished legmex team 0 at 5.59 min
  5.59  [Playtest] finished legtide team 0 at 5.59 min
  5.62  [Playtest] finished legtide team 0 at 5.62 min
  5.81  [Playtest] finished legmex team 0 at 5.81 min
  5.91  [Playtest] finished legtide team 0 at 5.91 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +32.0 bank 1032/1800, energy +390.0 bank 1912/2000, units 47
  6.00  [Playtest] finished legmex team 0 at 6.00 min
  6.06  [Playtest] finished legmex team 0 at 6.06 min
  6.17  [Playtest] finished legmex team 0 at 6.17 min
  6.25  [Playtest] finished legtide team 0 at 6.25 min
  6.25  [Playtest] finished legtide team 0 at 6.25 min
  6.41  [Playtest] finished legmex team 0 at 6.41 min
  6.58  [Playtest] finished legtide team 0 at 6.58 min
  6.66  [Playtest] finished legmex team 0 at 6.66 min
  6.88  [Playtest] finished legmex team 0 at 6.88 min
  6.95  [Playtest] finished legmex team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +46.0 bank 1934/2150, energy +464.0 bank 2129/2200, units 57
  7.08  [Playtest] finished legmex team 0 at 7.08 min
  7.25  [Playtest] finished legmex team 0 at 7.25 min
  7.37  [Playtest] finished legnanotcplat team 0 at 7.37 min
  7.38  [Playtest] finished legmex team 0 at 7.38 min
  7.39  [Playtest] finished leglht team 0 at 7.39 min
  7.63  [Playtest] finished legtl team 0 at 7.63 min
  7.88  [Playtest] finished legtide team 0 at 7.88 min
  7.96  [Playtest] finished legmex team 0 at 7.96 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +53.4 bank 2140/2350, energy +492.0 bank 1775/2300, units 67
  8.12  [Playtest] finished legtide team 0 at 8.12 min
  8.21  [Playtest] finished legtide team 0 at 8.21 min
  8.28  [Playtest] finished legmex team 0 at 8.28 min
  8.46  [Playtest] finished legfrad team 0 at 8.46 min
  8.50  [Playtest] finished legtide team 0 at 8.50 min
  8.53  [Playtest] finished legtide team 0 at 8.52 min
  8.62  [Playtest] finished legmex team 0 at 8.61 min
  8.92  [Playtest] finished legmex team 0 at 8.92 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +60.0 bank 2498/2500, energy +589.0 bank 2482/2550, units 77
  9.00  [Playtest] finished legtide team 0 at 9.00 min
  9.47  [Playtest] finished legtide team 0 at 9.47 min
  9.50  [Playtest] finished legmex team 0 at 9.50 min
  9.68  [Playtest] finished legtide team 0 at 9.68 min
  9.83  [Playtest] finished legfrad team 0 at 9.83 min
  9.83  [Playtest] finished legmex team 0 at 9.83 min
  9.93  [Playtest] finished legtide team 0 at 9.93 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +64.0 bank 2597/2600, energy +681.0 bank 2675/2750, units 88
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.17  [Playtest] finished legmex team 0 at 10.17 min
 10.26  [Playtest] finished legtl team 0 at 10.26 min
 10.31  [Playtest] finished legtide team 0 at 10.31 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +66.0 bank 2646/2650, energy +706.5 bank 2762/2800, units 93
 11.08  [Playtest] finished legtl team 0 at 11.08 min
 11.40  [Playtest] finished legfrad team 0 at 11.40 min
 11.41  [Playtest] finished legmex team 0 at 11.41 min
 11.42  [Playtest] finished legnanotcplat team 0 at 11.42 min
 11.59  [Playtest] finished legfeconv team 0 at 11.59 min
 11.98  [Playtest] finished legtide team 0 at 11.98 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +69.0 bank 2696/2700, energy +704.0 bank 2597/2850, units 102
 12.16  [Playtest] finished legtide team 0 at 12.16 min
 12.58  [Playtest] finished legtide team 0 at 12.58 min
 12.72  [Playtest] finished legtide team 0 at 12.72 min
 12.99  [Playtest] finished legmex team 0 at 12.99 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +69.0 bank 2692/2750, energy +796.0 bank 2960/3000, units 112
 13.05  [Playtest] finished legtide team 0 at 13.05 min
 13.06  [Playtest] finished legtide team 0 at 13.06 min
 13.31  [Playtest] finished legtide team 0 at 13.31 min
 13.41  [Playtest] finished legmex team 0 at 13.41 min
 13.47  [Playtest] finished legtide team 0 at 13.47 min
 13.75  [Playtest] finished legtide team 0 at 13.75 min
 13.93  [Playtest] finished legtide team 0 at 13.93 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +71.0 bank 2748/2750, energy +934.0 bank 3297/3300, units 118
 14.11  [Playtest] finished legtide team 0 at 14.11 min
 14.31  [Playtest] finished legtide team 0 at 14.31 min
 14.45  [Playtest] finished legtl team 0 at 14.44 min
 14.73  [Playtest] finished legtide team 0 at 14.73 min
 14.78  [Playtest] finished legmex team 0 at 14.77 min
 14.96  [Playtest] finished legnanotcplat team 0 at 14.96 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +73.0 bank 2459/2800, energy +1003.0 bank 3199/3450, units 119
 15.06  [Playtest] finished legtide team 0 at 15.06 min
 15.19  [Playtest] finished legmex team 0 at 15.19 min
 15.47  [Playtest] finished legtide team 0 at 15.47 min
 15.62  [Playtest] finished legtide team 0 at 15.62 min
 15.83  [Playtest] finished legtide team 0 at 15.83 min
 15.88  [Playtest] finished legadvshipyard team 0 at 15.88 min
 15.91  [Playtest] finished legtl team 0 at 15.91 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +75.0 bank 1649/3050, energy +1095.0 bank 3812/3850, units 128
 16.25  [Playtest] finished legtl team 0 at 16.25 min
 16.50  [Playtest] finished legtide team 0 at 16.50 min
 16.52  [Playtest] finished legtide team 0 at 16.52 min
 16.83  [Playtest] finished legtide team 0 at 16.83 min
 16.89  [Playtest] finished legtide team 0 at 16.89 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +75.0 bank 2805/3050, energy +1187.0 bank 4018/4050, units 134
 17.11  [Playtest] finished leglht team 0 at 17.11 min
 17.21  [Playtest] finished legtide team 0 at 17.21 min
 17.28  [Playtest] finished legtide team 0 at 17.28 min
 17.70  [Playtest] finished legfeconv team 0 at 17.70 min
 17.88  [Playtest] finished legfeconv team 0 at 17.88 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +77.0 bank 2804/3050, energy +1240.0 bank 4085/4200, units 145
 18.27  [SEA][Layout] berth sea.berth.3 armsy at=1792,3856 facing=1
 18.67  [Playtest] finished legtide team 0 at 18.67 min
 18.70  [Playtest] finished legfeconv team 0 at 18.70 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +78.0 bank 3036/3050, energy +1258.0 bank 4071/4200, units 151
 19.07  [Playtest] finished legtide team 0 at 19.07 min
 19.15  [SEA][Layout] berth sea.berth.4 armsy at=2048,4256 facing=2
 19.32  [Playtest] finished coruwmme team 0 at 19.32 min
 19.64  [Playtest] finished coruwmme team 0 at 19.64 min
 19.65  [Playtest] finished legmex team 0 at 19.65 min
 19.67  [Playtest] finished legtide team 0 at 19.67 min
 19.71  [Playtest] finished legnanotcplat team 0 at 19.71 min
 19.89  [Playtest] finished legnanotcplat team 0 at 19.89 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +92.0 bank 3728/4200, energy +1309.0 bank 4190/4350, units 156
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.14  [Playtest] finished legtl team 0 at 20.14 min
 20.53  [Playtest] finished leglht team 0 at 20.53 min
 20.75  [Playtest] finished legfeconv team 0 at 20.75 min
 20.91  [Playtest] finished armsy team 0 at 20.91 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +93.0 bank 3280/4300, energy +1304.0 bank 3857/4400, units 163
 21.20  [Playtest] finished legfeconv team 0 at 21.20 min
 21.32  [Playtest] finished armtide team 0 at 21.32 min
 21.56  [Playtest] finished armtide team 0 at 21.56 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +94.0 bank 4082/4300, energy +1357.0 bank 4265/4550, units 166
 22.00  [Playtest] finished armtide team 0 at 22.00 min
 22.01  [Playtest] finished legtide team 0 at 22.01 min
 22.25  [SEA][Layout] berth sea.berth.5 armasy at=2320,3632 facing=1
 22.34  [Playtest] finished legtide team 0 at 22.34 min
 22.34  [Playtest] finished armtide team 0 at 22.34 min
 22.64  [Playtest] finished armtide team 0 at 22.64 min
 22.77  [Playtest] finished legfeconv team 0 at 22.77 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +95.0 bank 4090/4300, energy +1472.0 bank 4681/4800, units 175
 23.02  [Playtest] finished armtide team 0 at 23.02 min
 23.19  [Playtest] finished legfeconv team 0 at 23.19 min
 23.62  [Playtest] finished legfeconv team 0 at 23.62 min
 23.74  [Playtest] finished legfeconv team 0 at 23.74 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +89.5 bank 3755/4300, energy +1500.0 bank 4392/4900, units 187
 24.13  [Playtest] finished legtide team 0 at 24.13 min
 24.23  [Playtest] finished legtide team 0 at 24.23 min
 24.82  [Playtest] finished armasy team 0 at 24.82 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +98.0 bank 2725/4500, energy +1546.0 bank 3927/5200, units 201
 25.33  [Playtest] finished armtide team 0 at 25.33 min
 25.64  [Playtest] finished legfeconv team 0 at 25.64 min
 25.87  [Playtest] finished armuwmme team 0 at 25.87 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +105.0 bank 2486/5050, energy +1629.0 bank 4564/5550, units 219
 26.52  [Playtest] finished legtl team 0 at 26.52 min
 26.66  [Playtest] finished legrl team 0 at 26.66 min
 26.67  [Playtest] finished legtl team 0 at 26.67 min
 26.96  [Playtest] finished legtl team 0 at 26.96 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +103.0 bank 2231/5000, energy +1929.0 bank 6447/7050, units 240
 27.13  [Playtest] finished armtide team 0 at 27.13 min
 27.18  [Playtest] finished legtl team 0 at 27.18 min
 27.25  [Playtest] finished legtl team 0 at 27.25 min
 27.33  [Playtest] finished legtl team 0 at 27.33 min
 27.44  [Playtest] finished legtl team 0 at 27.44 min
 27.59  [Playtest] finished armtide team 0 at 27.59 min
 27.78  [Playtest] finished legtl team 0 at 27.78 min
 27.79  [Playtest] finished armtide team 0 at 27.79 min
 27.95  [Playtest] finished armtide team 0 at 27.95 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +103.0 bank 1395/5000, energy +2021.0 bank 6470/7250, units 262
 28.86  [Playtest] finished armfmkr team 0 at 28.86 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +104.0 bank 865/5000, energy +2021.0 bank 6018/7250, units 283
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.01  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.06  [Playtest] finished legmex team 0 at 29.06 min
 29.06  [Playtest] finished armmex team 0 at 29.06 min
 29.23  [Playtest] finished armfmkr team 0 at 29.23 min
 29.38  [Playtest] finished legtide team 0 at 29.38 min
 29.48  [Playtest] finished legtl team 0 at 29.48 min
 29.81  [Playtest] finished armmex team 0 at 29.81 min
 29.86  [Playtest] finished legmex team 0 at 29.86 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +113.0 bank 709/5200, energy +2044.0 bank 6221/7300, units 306
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
