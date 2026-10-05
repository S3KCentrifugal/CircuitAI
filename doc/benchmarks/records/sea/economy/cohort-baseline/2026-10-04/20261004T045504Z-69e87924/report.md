# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54006); wall 321 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:49:40
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T044939Z-50d6aa07\runs\20261004T045504Z-69e87924\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:38.009391][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:58.518857][f=0002496] [SeaWatch] finished frame=2496 id=22022 def=armsy builder=17199` |
| expect `first-ship-exit` | seen at 4.8 min | `[t=00:01:12.719789][f=0008550] [SeaWatch] egress id=24886 yard=22022 seconds=7.1 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T044939Z-50d6aa07\runs\20261004T045504Z-69e87924\screen_2026-10-04_04-50-58-828.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T044939Z-50d6aa07\runs\20261004T045504Z-69e87924\screen_2026-10-04_04-51-24-223.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T044939Z-50d6aa07\runs\20261004T045504Z-69e87924\screen_2026-10-04_04-53-04-476.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T044939Z-50d6aa07\runs\20261004T045504Z-69e87924\screen_2026-10-04_04-54-47-157.png

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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5341,795) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7815,1505) factory=legsy landLocked=no spot=6 known=3/3
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 23225 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.18  [Team][Roster] team 2 first mex at 6384,720
  0.19  [Team][Roster] team 3 first mex at 7984,1504
  0.23  [Team][Roster] team 1 first mex at 5136,752
  0.37  [Playtest] finished armmex team 0 at 0.37 min
  0.65  [Playtest] finished armmex team 0 at 0.65 min
  0.84  [Playtest] finished armtide team 0 at 0.84 min
  0.99  [Playtest] finished armtide team 0 at 0.99 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1008/1150, energy +45.0 bank 803/1100, units 6
  1.39  [Playtest] finished armsy team 0 at 1.39 min
  1.86  [Playtest] finished armtide team 0 at 1.86 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 595/1250, energy +82.0 bank 120/1300, units 12
  2.01  [Playtest] finished armtide team 0 at 2.01 min
  2.26  [Playtest] finished armtide team 0 at 2.26 min
  2.37  [Playtest] finished armtide team 0 at 2.37 min
  2.46  [Playtest] finished armtide team 0 at 2.46 min
  2.58  [Playtest] finished armtide team 0 at 2.58 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 0/1250, energy +164.0 bank 1600/1600, units 17
  3.02  [Playtest] finished armtide team 0 at 3.02 min
  3.22  [Playtest] finished armtide team 0 at 3.22 min
  3.41  [Playtest] finished armtide team 0 at 3.41 min
  3.60  [Playtest] finished armtide team 0 at 3.60 min
  3.79  [Playtest] finished armmex team 0 at 3.79 min
  3.87  [Playtest] finished armtide team 0 at 3.87 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 0/1300, energy +239.0 bank 1843/1850, units 24
  4.08  [Playtest] finished armmex team 0 at 4.08 min
  4.13  [Playtest] finished armtide team 0 at 4.13 min
  4.34  [Playtest] finished armfmkr team 0 at 4.34 min
  4.59  [Playtest] finished armfmkr team 0 at 4.59 min
  4.77  [Playtest] finished armmex team 0 at 4.77 min
  4.83  [Playtest] finished armfmkr team 0 at 4.83 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +17.0 bank 73/1400, energy +254.0 bank 1617/1900, units 32
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.03  [Playtest] finished armmex team 0 at 5.03 min
  5.05  [Playtest] finished armfmkr team 0 at 5.05 min
  5.26  [Playtest] finished armfmkr team 0 at 5.26 min
  5.33  [Playtest] finished armmex team 0 at 5.33 min
  5.51  [Playtest] finished armfmkr team 0 at 5.51 min
  5.81  [Playtest] finished armfmkr team 0 at 5.81 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +19.5 bank 635/1500, energy +254.0 bank 1441/1900, units 39
  6.03  [Playtest] finished armfmkr team 0 at 6.03 min
  6.17  [Playtest] finished armmex team 0 at 6.18 min
  6.20  [Playtest] finished armtide team 0 at 6.20 min
  6.45  [Playtest] finished armmex team 0 at 6.45 min
  6.53  [Playtest] finished armnanotcplat team 0 at 6.53 min
  6.60  [Playtest] finished armfrad team 0 at 6.60 min
  6.68  [Playtest] finished armtide team 0 at 6.68 min
  6.83  [Playtest] finished armtide team 0 at 6.83 min
  6.86  [Playtest] finished armtl team 0 at 6.86 min
  6.97  [Playtest] finished armtide team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.0 bank 269/1600, energy +321.0 bank 1636/2150, units 52
  7.23  [Playtest] finished armtide team 0 at 7.23 min
  7.40  [Playtest] finished armtide team 0 at 7.40 min
  7.66  [Playtest] finished armtide team 0 at 7.66 min
  7.76  [Playtest] finished armtide team 0 at 7.76 min
  7.80  [Playtest] finished armtide team 0 at 7.80 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +25.5 bank 4/1600, energy +403.0 bank 1952/2450, units 61
  8.03  [Playtest] finished armtide team 0 at 8.03 min
  8.19  [Playtest] finished armtide team 0 at 8.19 min
  8.37  [Playtest] finished armtide team 0 at 8.37 min
  8.52  [Playtest] finished armtide team 0 at 8.52 min
  8.66  [Playtest] finished armtide team 0 at 8.66 min
  8.78  [Playtest] finished armtide team 0 at 8.78 min
  9.00  [Playtest] finished armtide team 0 at 9.00 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +26.9 bank 213/1600, energy +493.0 bank 2243/2800, units 63
  9.15  [Playtest] finished armtide team 0 at 9.15 min
  9.27  [Playtest] finished armnanotcplat team 0 at 9.27 min
  9.36  [Playtest] finished armtide team 0 at 9.36 min
  9.51  [Playtest] finished armtide team 0 at 9.51 min
  9.61  [Playtest] finished armnanotcplat team 0 at 9.61 min
  9.70  [Playtest] finished armtl team 0 at 9.70 min
  9.78  [Playtest] finished armtide team 0 at 9.78 min
  9.91  [Playtest] finished armfrad team 0 at 9.91 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +28.4 bank 50/1600, energy +568.0 bank 2257/3000, units 74
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.12  [Playtest] finished armtide team 0 at 10.12 min
 10.17  [Playtest] finished armmex team 0 at 10.17 min
 10.32  [Playtest] finished armmex team 0 at 10.32 min
 10.33  [Playtest] finished armmex team 0 at 10.33 min
 10.45  [Playtest] finished armtide team 0 at 10.45 min
 10.56  [Playtest] finished armtl team 0 at 10.56 min
 10.65  [Playtest] finished armfrad team 0 at 10.65 min
 10.66  [Playtest] finished armtl team 0 at 10.66 min
 10.80  [Playtest] finished armtide team 0 at 10.80 min
 10.86  [Playtest] finished armfrad team 0 at 10.86 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +32.3 bank 15/1750, energy +620.0 bank 2537/3200, units 86
 11.01  [Playtest] finished armtl team 0 at 11.01 min
 11.16  [Playtest] finished armtide team 0 at 11.16 min
 11.23  [Playtest] finished armtl team 0 at 11.23 min
 11.32  [Playtest] finished armnanotcplat team 0 at 11.32 min
 11.50  [Playtest] finished armtide team 0 at 11.50 min
 11.65  [Playtest] finished armmex team 0 at 11.65 min
 11.83  [Playtest] finished armtide team 0 at 11.83 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +35.2 bank 12/1800, energy +658.0 bank 2698/3300, units 94
 12.01  [Playtest] finished armmex team 0 at 12.01 min
 12.18  [Playtest] finished armtide team 0 at 12.18 min
 12.29  [Playtest] finished armmex team 0 at 12.29 min
 12.49  [Playtest] finished armtl team 0 at 12.49 min
 12.51  [Playtest] finished armtide team 0 at 12.51 min
 12.53  [Playtest] finished armtide team 0 at 12.53 min
 12.80  [Playtest] finished armestor team 0 at 12.80 min
 12.82  [Playtest] finished armtide team 0 at 12.82 min
 12.93  [Playtest] finished armnanotcplat team 0 at 12.93 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +33.9 bank 19/1900, energy +732.0 bank 7079/9600, units 106
 13.10  [Playtest] finished armmex team 0 at 13.10 min
 13.12  [Playtest] finished armmex team 0 at 13.12 min
 13.16  [Playtest] finished armtide team 0 at 13.16 min
 13.16  [Playtest] finished armmex team 0 at 13.16 min
 13.48  [Playtest] finished armtide team 0 at 13.48 min
 13.67  [Playtest] finished armtl team 0 at 13.67 min
 13.70  [Playtest] finished armnanotcplat team 0 at 13.70 min
 13.82  [Playtest] finished armtide team 0 at 13.82 min
 13.99  [Playtest] finished armmex team 0 at 13.99 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +42.3 bank 23/2000, energy +770.0 bank 7514/9700, units 105
 14.14  [Playtest] finished armtide team 0 at 14.14 min
 14.30  [Playtest] finished armmex team 0 at 14.30 min
 14.49  [Playtest] finished armtide team 0 at 14.49 min
 14.82  [Playtest] finished armtide team 0 at 14.82 min
 14.99  [Playtest] finished armmex team 0 at 14.99 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +45.2 bank 52/2100, energy +815.0 bank 7862/9900, units 115
 15.01  [Playtest] finished armtide team 0 at 15.01 min
 15.34  [Playtest] finished armtide team 0 at 15.34 min
 15.35  [Playtest] finished armmex team 0 at 15.35 min
 15.74  [Playtest] finished armtide team 0 at 15.74 min
 15.89  [Playtest] finished armtl team 0 at 15.89 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +45.3 bank 17/2000, energy +860.0 bank 7742/10000, units 115
 16.06  [Playtest] finished armtide team 0 at 16.06 min
 16.25  [Playtest] finished armmex team 0 at 16.25 min
 16.38  [Playtest] finished armtide team 0 at 16.38 min
 16.71  [Playtest] finished armtide team 0 at 16.71 min
 16.89  [Playtest] finished armtide team 0 at 16.89 min
 16.91  [Playtest] finished armmex team 0 at 16.91 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +44.6 bank 32/2100, energy +913.0 bank 7941/10200, units 116
 17.23  [Playtest] finished armtide team 0 at 17.23 min
 17.56  [Playtest] finished armtl team 0 at 17.56 min
 17.63  [Playtest] finished armtide team 0 at 17.63 min
 17.93  [Playtest] finished armmex team 0 at 17.93 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +47.9 bank 276/2050, energy +734.0 bank 8492/9350, units 94
 18.47  [Playtest] finished armtl team 0 at 18.47 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +29.9 bank 1197/1250, energy +29.5 bank 5971/6600, units 26
 19.18  [Playtest] finished armsy team 0 at 19.18 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +16.0 bank 944/1200, energy +7.0 bank 1/650, units 20
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +1.0 bank 870/1050, energy +7.0 bank 0/650, units 17
 21.15  [Playtest] finished armfrad team 0 at 21.15 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +6.0 bank 891/900, energy +14.0 bank 3/700, units 14
 23.00  [Playtest] eco team 0 at 23.0 min: metal +0.0 bank 500/500, energy +0.0 bank 0/500, units 0
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 500/500, energy +0.0 bank 0/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 500/500, energy +0.0 bank 0/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 500/500, energy +0.0 bank 0/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 500/500, energy +0.0 bank 0/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 500/500, energy +0.0 bank 0/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 500/500, energy +0.0 bank 0/500, units 0
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.00  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.00  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 500/500, energy +0.0 bank 0/500, units 0
```

## Native lines (all AIs, first 120)

```
  1.33  BUILDER: discarded 1 unused default task(s) in the last minute
  1.37  BUILDER: discarded 1 unused default task(s) in the last minute
  1.49  BUILDER: discarded 1 unused default task(s) in the last minute
  1.52  BUILDER: discarded 1 unused default task(s) in the last minute
  1.53  BUILDER: discarded 1 unused default task(s) in the last minute
  1.53  BUILDER: discarded 1 unused default task(s) in the last minute
  1.67  BUILDER: discarded 1 unused default task(s) in the last minute
  1.68  BUILDER: discarded 1 unused default task(s) in the last minute
  1.73  BUILDER: discarded 1 unused default task(s) in the last minute
  2.37  BUILDER: discarded 1 unused default task(s) in the last minute
  2.49  BUILDER: discarded 1 unused default task(s) in the last minute
  2.52  BUILDER: discarded 3 unused default task(s) in the last minute
  2.53  BUILDER: discarded 2 unused default task(s) in the last minute
  2.54  BUILDER: discarded 1 unused default task(s) in the last minute
  2.60  BUILDER: discarded 1 unused default task(s) in the last minute
  2.67  BUILDER: discarded 2 unused default task(s) in the last minute
  2.74  BUILDER: discarded 2 unused default task(s) in the last minute
  2.78  BUILDER: discarded 1 unused default task(s) in the last minute
  3.38  BUILDER: discarded 4 unused default task(s) in the last minute
  3.50  BUILDER: discarded 3 unused default task(s) in the last minute
  3.53  BUILDER: discarded 2 unused default task(s) in the last minute
  3.54  BUILDER: discarded 1 unused default task(s) in the last minute
  3.78  BUILDER: discarded 3 unused default task(s) in the last minute
  3.87  BUILDER: discarded 3 unused default task(s) in the last minute
  4.51  BUILDER: discarded 3 unused default task(s) in the last minute
  4.54  BUILDER: discarded 2 unused default task(s) in the last minute
  5.54  BUILDER: discarded 3 unused default task(s) in the last minute
  5.78  BUILDER: discarded 1 unused default task(s) in the last minute
  6.13  BUILDER: discarded 1 unused default task(s) in the last minute
  6.14  BUILDER: discarded 1 unused default task(s) in the last minute
  6.75  BUILDER: discarded 1 unused default task(s) in the last minute
  6.79  BUILDER: discarded 1 unused default task(s) in the last minute
  7.03  BUILDER: discarded 1 unused default task(s) in the last minute
  7.13  BUILDER: discarded 3 unused default task(s) in the last minute
  7.19  BUILDER: discarded 1 unused default task(s) in the last minute
  7.66  BUILDER: discarded 1 unused default task(s) in the last minute
  7.68  BUILDER: discarded 1 unused default task(s) in the last minute
  7.68  BUILDER: discarded 1 unused default task(s) in the last minute
  7.79  BUILDER: discarded 1 unused default task(s) in the last minute
  8.13  BUILDER: discarded 3 unused default task(s) in the last minute
  8.19  BUILDER: discarded 1 unused default task(s) in the last minute
  8.59  BUILDER: discarded 1 unused default task(s) in the last minute
  8.68  BUILDER: discarded 1 unused default task(s) in the last minute
  8.92  BUILDER: discarded 1 unused default task(s) in the last minute
  9.12  BUILDER: discarded 1 unused default task(s) in the last minute
  9.20  BUILDER: discarded 1 unused default task(s) in the last minute
  9.31  BUILDER: discarded 1 unused default task(s) in the last minute
  9.59  BUILDER: discarded 1 unused default task(s) in the last minute
 10.05  BUILDER: discarded 1 unused default task(s) in the last minute
 10.21  BUILDER: discarded 2 unused default task(s) in the last minute
 10.31  BUILDER: discarded 2 unused default task(s) in the last minute
 10.60  BUILDER: discarded 1 unused default task(s) in the last minute
 11.06  BUILDER: discarded 1 unused default task(s) in the last minute
 11.32  BUILDER: discarded 3 unused default task(s) in the last minute
 11.33  BUILDER: discarded 1 unused default task(s) in the last minute
 11.51  BUILDER: discarded 1 unused default task(s) in the last minute
 11.60  BUILDER: discarded 2 unused default task(s) in the last minute
 12.06  BUILDER: discarded 3 unused default task(s) in the last minute
 12.33  BUILDER: discarded 3 unused default task(s) in the last minute
 12.49  BUILDER: discarded 1 unused default task(s) in the last minute
 12.57  CBFactoryTask: no site for armtide in a usable armtide area near (7800, 10341); retrying without the area check
 12.57  CBFactoryTask: no site for armtide at all | origin (7800, 10341) elev -24 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.60  BUILDER: discarded 3 unused default task(s) in the last minute
 12.64  CBFactoryTask: no site for armtide in a usable armtide area near (7926, 10544); retrying without the area check
 12.64  CBFactoryTask: no site for armtide at all | origin (7926, 10544) elev -50 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.72  CBFactoryTask: no site for armtide in a usable armtide area near (7884, 10402); retrying without the area check
 12.72  CBFactoryTask: no site for armtide at all | origin (7884, 10402) elev -23 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.78  CBFactoryTask: no site for armtide in a usable armtide area near (7894, 10514); retrying without the area check
 12.78  CBFactoryTask: no site for armtide at all | origin (7894, 10514) elev -42 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.07  BUILDER: discarded 1 unused default task(s) in the last minute
 13.19  CBFactoryTask: no site for armtide in a usable armtide area near (7947, 10325); retrying without the area check
 13.19  CBFactoryTask: no site for armtide at all | origin (7947, 10325) elev -20 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.23  CBFactoryTask: no site for armtide in a usable armtide area near (7915, 10367); retrying without the area check
 13.23  CBFactoryTask: no site for armtide at all | origin (7915, 10367) elev -21 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.27  BUILDER: discarded 1 unused default task(s) in the last minute
 13.34  BUILDER: discarded 3 unused default task(s) in the last minute
 13.35  CBFactoryTask: no site for armtide in a usable armtide area near (7914, 10506); retrying without the area check
 13.35  CBFactoryTask: no site for armtide at all | origin (7914, 10506) elev -43 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.60  BUILDER: discarded 2 unused default task(s) in the last minute
 13.63  BUILDER: discarded 1 unused default task(s) in the last minute
 13.71  BUILDER: discarded 1 unused default task(s) in the last minute
 14.09  BUILDER: discarded 3 unused default task(s) in the last minute
 14.34  BUILDER: discarded 4 unused default task(s) in the last minute
 14.61  BUILDER: discarded 4 unused default task(s) in the last minute
 14.63  BUILDER: discarded 1 unused default task(s) in the last minute
 14.71  BUILDER: discarded 2 unused default task(s) in the last minute
 15.24  BUILDER: discarded 1 unused default task(s) in the last minute
 15.32  CBFactoryTask: no site for armtide in a usable armtide area near (7939, 10464); retrying without the area check
 15.32  CBFactoryTask: no site for armtide at all | origin (7939, 10464) elev -41 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 15.34  BUILDER: discarded 7 unused default task(s) in the last minute
 15.39  CBFactoryTask: no site for armtide in a usable armtide area near (7913, 10529); retrying without the area check
 15.39  CBFactoryTask: no site for armtide at all | origin (7913, 10529) elev -46 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 15.39  CBFactoryTask: no site for cortide in a usable cortide area near (817, 10309); retrying without the area check
 15.39  CBFactoryTask: no site for cortide at all | origin (817, 10309) elev -79 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=corcs radius=1600
 15.45  BUILDER: discarded 1 unused default task(s) in the last minute
 15.61  BUILDER: discarded 3 unused default task(s) in the last minute
 15.63  BUILDER: discarded 8 unused default task(s) in the last minute
 15.72  BUILDER: discarded 1 unused default task(s) in the last minute
 15.79  CBFactoryTask: no site for armtide in a usable armtide area near (7822, 10445); retrying without the area check
 15.79  CBFactoryTask: no site for armtide at all | origin (7822, 10445) elev -21 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 16.04  CBFactoryTask: no site for armtide in a usable armtide area near (7919, 10404); retrying without the area check
 16.04  CBFactoryTask: no site for armtide at all | origin (7919, 10404) elev -29 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 16.34  BUILDER: discarded 3 unused default task(s) in the last minute
 16.45  BUILDER: discarded 1 unused default task(s) in the last minute
 16.45  BUILDER: discarded 1 unused default task(s) in the last minute
 16.62  BUILDER: discarded 3 unused default task(s) in the last minute
 16.63  BUILDER: discarded 4 unused default task(s) in the last minute
 16.72  BUILDER: discarded 3 unused default task(s) in the last minute
 16.87  BUILDER: discarded 1 unused default task(s) in the last minute
 17.11  CBFactoryTask: no site for armtide in a usable armtide area near (7759, 10433); retrying without the area check
 17.11  CBFactoryTask: no site for armtide at all | origin (7759, 10433) elev -24 | canBuildHere=0 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 17.22  BUILDER: discarded 1 unused default task(s) in the last minute
 17.40  CBFactoryTask: no site for armtide in a usable armtide area near (7790, 10438); retrying without the area check
 17.40  CBFactoryTask: no site for armtide at all | origin (7790, 10438) elev -21 | canBuildHere=0 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 17.46  BUILDER: discarded 3 unused default task(s) in the last minute
 17.46  BUILDER: discarded 1 unused default task(s) in the last minute
 17.46  BUILDER: discarded 1 unused default task(s) in the last minute
 17.58  BUILDER: discarded 1 unused default task(s) in the last minute
 17.62  BUILDER: discarded 12 unused default task(s) in the last minute
 17.63  BUILDER: discarded 2 unused default task(s) in the last minute
```
