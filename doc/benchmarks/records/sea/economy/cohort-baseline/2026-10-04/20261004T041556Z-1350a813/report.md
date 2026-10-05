# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54000); wall 340 s
- DLL: build-theatres\d188-build-4\SkirmishAI.dll (4269e12be49092f4); AI BARbTest/test; staged 2026-10-04T01:10:12
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T041011Z-be596736\runs\20261004T041556Z-1350a813\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:47.182507][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.1 min | `[t=00:01:18.602409][f=0001987] [SeaWatch] finished frame=1987 id=15145 def=armsy builder=30660` |
| expect `first-ship-exit` | seen at 4.0 min | `[t=00:01:35.083527][f=0007290] [SeaWatch] egress id=6401 yard=15145 seconds=4.9 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T041011Z-be596736\runs\20261004T041556Z-1350a813\screen_2026-10-04_04-11-58-475.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T041011Z-be596736\runs\20261004T041556Z-1350a813\screen_2026-10-04_04-12-30-858.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T041011Z-be596736\runs\20261004T041556Z-1350a813\screen_2026-10-04_04-14-10-116.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T041011Z-be596736\runs\20261004T041556Z-1350a813\screen_2026-10-04_04-15-43-901.png

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
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5347,797) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7822,1502) factory=legsy landLocked=no spot=6 known=3/3
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.20  [Team][Roster] team 3 first mex at 7984,1504
  0.23  [Team][Roster] team 1 first mex at 5136,752
  0.24  [Playtest] finished armmex team 0 at 0.24 min
  0.25  [Team][Roster] first mex 16475 at 4016,2016
  0.25  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.45  [Playtest] finished armmex team 0 at 0.45 min
  0.64  [Playtest] finished armtide team 0 at 0.64 min
  0.79  [Playtest] finished armtide team 0 at 0.79 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 685/1100, energy +60.0 bank 1087/1100, units 6
  1.10  [Playtest] finished armsy team 0 at 1.10 min
  1.48  [Playtest] finished armtide team 0 at 1.48 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 267/1200, energy +89.0 bank 0/1350, units 12
  2.27  [Playtest] finished armtide team 0 at 2.27 min
  2.39  [Playtest] finished armtide team 0 at 2.39 min
  2.69  [Playtest] finished armtide team 0 at 2.69 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 0/1200, energy +134.0 bank 1489/1500, units 16
  3.51  [Playtest] finished armtl team 0 at 3.51 min
  3.81  [Playtest] finished armmex team 0 at 3.81 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 13/1250, energy +134.0 bank 1497/1500, units 19
  4.01  [Playtest] finished armtide team 0 at 4.01 min
  4.30  [Playtest] finished armtide team 0 at 4.30 min
  4.63  [Playtest] finished armmex team 0 at 4.63 min
  4.64  [Playtest] finished armtide team 0 at 4.64 min
  4.89  [Playtest] finished armmex team 0 at 4.89 min
  4.96  [Playtest] finished armtide team 0 at 4.96 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 15/1350, energy +194.0 bank 1690/1700, units 25
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.21  [Playtest] finished armtide team 0 at 5.20 min
  5.47  [Playtest] finished armtide team 0 at 5.47 min
  5.88  [Playtest] finished armtide team 0 at 5.88 min
  5.90  [Playtest] finished armmex team 0 at 5.90 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +14.0 bank 0/1400, energy +239.0 bank 1845/1850, units 31
  6.29  [Playtest] finished armtide team 0 at 6.29 min
  6.62  [Playtest] finished armfmkr team 0 at 6.62 min
  6.84  [Playtest] finished armfmkr team 0 at 6.84 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +17.0 bank 111/1400, energy +254.0 bank 1771/1900, units 33
  7.05  [Playtest] finished armtide team 0 at 7.05 min
  7.28  [Playtest] finished armfmkr team 0 at 7.28 min
  7.44  [Playtest] finished armfmkr team 0 at 7.44 min
  7.51  [Playtest] finished armtide team 0 at 7.51 min
  7.75  [Playtest] finished armtide team 0 at 7.75 min
  7.79  [Playtest] finished armtl team 0 at 7.79 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +16.5 bank 0/1400, energy +299.0 bank 1628/2050, units 41
  8.05  [Playtest] finished armfrad team 0 at 8.05 min
  8.11  [Playtest] finished armtide team 0 at 8.11 min
  8.34  [Playtest] finished armtide team 0 at 8.34 min
  8.55  [Playtest] finished armtide team 0 at 8.55 min
  8.84  [Playtest] finished armtide team 0 at 8.84 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +18.0 bank 173/1400, energy +359.0 bank 1941/2250, units 46
  9.11  [Playtest] finished armtide team 0 at 9.11 min
  9.39  [Playtest] finished armtide team 0 at 9.39 min
  9.61  [Playtest] finished armtide team 0 at 9.61 min
  9.66  [Playtest] finished armtide team 0 at 9.66 min
  9.82  [Playtest] finished armtide team 0 at 9.82 min
  9.86  [Playtest] finished armtide team 0 at 9.86 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +18.0 bank 0/1400, energy +456.0 bank 2541/2600, units 54
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.04  [Playtest] finished armtide team 0 at 10.04 min
 10.16  [Playtest] finished armtide team 0 at 10.16 min
 10.45  [Playtest] finished armfmkr team 0 at 10.45 min
 10.89  [Playtest] finished armtide team 0 at 10.89 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +19.0 bank 13/1400, energy +501.0 bank 2341/2750, units 58
 11.28  [Playtest] finished armnanotcplat team 0 at 11.28 min
 11.44  [Playtest] finished armfmkr team 0 at 11.44 min
 11.96  [Playtest] finished armtide team 0 at 11.96 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +18.8 bank 0/1400, energy +516.0 bank 2260/2800, units 59
 12.06  [Playtest] finished armnanotcplat team 0 at 12.06 min
 12.34  [Playtest] finished armtide team 0 at 12.34 min
 12.63  [Playtest] finished armfmkr team 0 at 12.63 min
 12.82  [Playtest] finished armfmkr team 0 at 12.82 min
 12.88  [Playtest] finished armmex team 0 at 12.88 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +21.4 bank 14/1450, energy +531.0 bank 2335/2850, units 67
 13.10  [Playtest] finished armtide team 0 at 13.10 min
 13.21  [Playtest] finished armmex team 0 at 13.20 min
 13.40  [Playtest] finished armtide team 0 at 13.40 min
 13.61  [Playtest] finished armmex team 0 at 13.61 min
 13.87  [Playtest] finished armtide team 0 at 13.87 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +23.2 bank 39/1500, energy +572.5 bank 2517/3000, units 69
 14.13  [Playtest] finished armtide team 0 at 14.13 min
 14.73  [Playtest] finished armtide team 0 at 14.73 min
 14.76  [Playtest] finished armnanotcplat team 0 at 14.76 min
 14.80  [Playtest] finished armtide team 0 at 14.80 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +24.4 bank 0/1500, energy +621.0 bank 2588/3150, units 69
 15.15  [Playtest] finished armtide team 0 at 15.15 min
 15.70  [Playtest] finished armtide team 0 at 15.70 min
 15.76  [Playtest] finished armtide team 0 at 15.76 min
 15.84  [Playtest] finished armtide team 0 at 15.84 min
 15.94  [Playtest] finished armtide team 0 at 15.94 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +20.0 bank 15/1350, energy +696.0 bank 3181/3400, units 70
 16.34  [Playtest] finished armfmkr team 0 at 16.34 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +15.1 bank 187/1350, energy +592.0 bank 2360/3000, units 57
 18.00  [Playtest] eco team 0 at 18.0 min: metal +4.0 bank 470/600, energy +7.0 bank 445/550, units 4
 19.00  [Playtest] eco team 0 at 19.0 min: metal +4.0 bank 492/600, energy +0.0 bank 253/500, units 2
 20.00  [Playtest] eco team 0 at 20.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.00  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.00  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 22.00  [Playtest] eco team 0 at 22.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 23.00  [Playtest] eco team 0 at 23.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.00  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.00  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 500/500, energy +0.0 bank 440/500, units 0
```

## Native lines (all AIs, first 120)

```
  1.35  BUILDER: discarded 1 unused default task(s) in the last minute
  1.39  BUILDER: discarded 1 unused default task(s) in the last minute
  1.39  BUILDER: discarded 1 unused default task(s) in the last minute
  1.43  BUILDER: discarded 1 unused default task(s) in the last minute
  1.49  BUILDER: discarded 1 unused default task(s) in the last minute
  1.52  BUILDER: discarded 1 unused default task(s) in the last minute
  1.55  BUILDER: discarded 1 unused default task(s) in the last minute
  1.58  BUILDER: discarded 1 unused default task(s) in the last minute
  1.65  BUILDER: discarded 1 unused default task(s) in the last minute
  2.40  BUILDER: discarded 2 unused default task(s) in the last minute
  2.40  BUILDER: discarded 1 unused default task(s) in the last minute
  2.41  BUILDER: discarded 1 unused default task(s) in the last minute
  2.43  BUILDER: discarded 3 unused default task(s) in the last minute
  2.49  BUILDER: discarded 2 unused default task(s) in the last minute
  2.52  BUILDER: discarded 1 unused default task(s) in the last minute
  2.56  BUILDER: discarded 3 unused default task(s) in the last minute
  2.58  BUILDER: discarded 1 unused default task(s) in the last minute
  2.65  BUILDER: discarded 3 unused default task(s) in the last minute
  3.42  BUILDER: discarded 4 unused default task(s) in the last minute
  3.42  BUILDER: discarded 1 unused default task(s) in the last minute
  3.49  BUILDER: discarded 4 unused default task(s) in the last minute
  3.53  BUILDER: discarded 1 unused default task(s) in the last minute
  3.56  BUILDER: discarded 1 unused default task(s) in the last minute
  3.58  BUILDER: discarded 2 unused default task(s) in the last minute
  3.66  BUILDER: discarded 3 unused default task(s) in the last minute
  4.14  BUILDER: discarded 1 unused default task(s) in the last minute
  4.43  BUILDER: discarded 3 unused default task(s) in the last minute
  4.43  BUILDER: discarded 4 unused default task(s) in the last minute
  4.49  BUILDER: discarded 3 unused default task(s) in the last minute
  4.60  BUILDER: discarded 4 unused default task(s) in the last minute
  4.65  BUILDER: discarded 1 unused default task(s) in the last minute
  4.67  BUILDER: discarded 1 unused default task(s) in the last minute
  4.95  CBFactoryTask: no site for armtide in a usable armtide area near (5762, 577); retrying without the area check
  4.95  CBFactoryTask: no site for armtide at all | origin (5762, 577) elev -62 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
  5.15  BUILDER: discarded 1 unused default task(s) in the last minute
  5.39  BUILDER: discarded 1 unused default task(s) in the last minute
  5.43  BUILDER: discarded 1 unused default task(s) in the last minute
  5.50  BUILDER: discarded 1 unused default task(s) in the last minute
  5.65  BUILDER: discarded 1 unused default task(s) in the last minute
  5.91  BUILDER: discarded 1 unused default task(s) in the last minute
  5.98  CBFactoryTask: no site for armtide in a usable armtide area near (5811, 690); retrying without the area check
  5.98  CBFactoryTask: no site for armtide at all | origin (5811, 690) elev -74 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
  6.16  BUILDER: discarded 1 unused default task(s) in the last minute
  6.38  BUILDER: discarded 1 unused default task(s) in the last minute
  6.41  BUILDER: discarded 1 unused default task(s) in the last minute
  6.43  BUILDER: discarded 2 unused default task(s) in the last minute
  6.51  BUILDER: discarded 1 unused default task(s) in the last minute
  6.66  BUILDER: discarded 8 unused default task(s) in the last minute
  7.35  BUILDER: discarded 1 unused default task(s) in the last minute
  7.51  BUILDER: discarded 1 unused default task(s) in the last minute
  7.67  BUILDER: discarded 47 unused default task(s) in the last minute
  8.36  BUILDER: discarded 62 unused default task(s) in the last minute
  8.53  BUILDER: discarded 1 unused default task(s) in the last minute
  8.67  BUILDER: discarded 10 unused default task(s) in the last minute
  9.05  BUILDER: discarded 1 unused default task(s) in the last minute
  9.36  BUILDER: discarded 55 unused default task(s) in the last minute
  9.53  BUILDER: discarded 2 unused default task(s) in the last minute
  9.68  BUILDER: discarded 59 unused default task(s) in the last minute
 10.04  BUILDER: discarded 1 unused default task(s) in the last minute
 10.11  BUILDER: discarded 1 unused default task(s) in the last minute
 10.18  BUILDER: discarded 1 unused default task(s) in the last minute
 10.36  BUILDER: discarded 2 unused default task(s) in the last minute
 10.53  BUILDER: discarded 3 unused default task(s) in the last minute
 10.68  BUILDER: discarded 6 unused default task(s) in the last minute
 10.72  BUILDER: discarded 1 unused default task(s) in the last minute
 11.04  BUILDER: discarded 2 unused default task(s) in the last minute
 11.11  BUILDER: discarded 1 unused default task(s) in the last minute
 11.19  BUILDER: discarded 1 unused default task(s) in the last minute
 11.36  BUILDER: discarded 1 unused default task(s) in the last minute
 11.48  BUILDER: discarded 1 unused default task(s) in the last minute
 11.54  BUILDER: discarded 2 unused default task(s) in the last minute
 11.72  BUILDER: discarded 4 unused default task(s) in the last minute
 12.04  BUILDER: discarded 2 unused default task(s) in the last minute
 12.19  BUILDER: discarded 1 unused default task(s) in the last minute
 12.37  BUILDER: discarded 3 unused default task(s) in the last minute
 12.50  BUILDER: discarded 3 unused default task(s) in the last minute
 12.72  BUILDER: discarded 4 unused default task(s) in the last minute
 13.01  BUILDER: discarded 1 unused default task(s) in the last minute
 13.19  BUILDER: discarded 2 unused default task(s) in the last minute
 13.28  BUILDER: discarded 1 unused default task(s) in the last minute
 13.39  BUILDER: discarded 1 unused default task(s) in the last minute
 13.51  BUILDER: discarded 1 unused default task(s) in the last minute
 14.02  BUILDER: discarded 2 unused default task(s) in the last minute
 14.14  BUILDER: discarded 1 unused default task(s) in the last minute
 14.20  BUILDER: discarded 3 unused default task(s) in the last minute
 14.29  BUILDER: discarded 3 unused default task(s) in the last minute
 14.39  BUILDER: discarded 2 unused default task(s) in the last minute
 14.51  BUILDER: discarded 1 unused default task(s) in the last minute
 14.67  BUILDER: discarded 1 unused default task(s) in the last minute
 15.03  BUILDER: discarded 3 unused default task(s) in the last minute
 15.30  BUILDER: discarded 2 unused default task(s) in the last minute
 15.35  BUILDER: discarded 1 unused default task(s) in the last minute
 15.51  BUILDER: discarded 1 unused default task(s) in the last minute
 15.71  BUILDER: discarded 4 unused default task(s) in the last minute
 16.22  BUILDER: discarded 1 unused default task(s) in the last minute
 16.30  BUILDER: discarded 3 unused default task(s) in the last minute
 16.36  BUILDER: discarded 1 unused default task(s) in the last minute
 16.44  BUILDER: discarded 1 unused default task(s) in the last minute
 16.59  BUILDER: discarded 1 unused default task(s) in the last minute
 17.07  BUILDER: discarded 1 unused default task(s) in the last minute
 17.30  BUILDER: discarded 1 unused default task(s) in the last minute
 17.36  BUILDER: discarded 1 unused default task(s) in the last minute
 17.51  BUILDER: discarded 1 unused default task(s) in the last minute
 17.71  BUILDER: discarded 1 unused default task(s) in the last minute
 17.72  BUILDER: discarded 6 unused default task(s) in the last minute
 18.11  BUILDER: discarded 7 unused default task(s) in the last minute
 18.26  BUILDER: discarded 1 unused default task(s) in the last minute
 18.51  BUILDER: discarded 4 unused default task(s) in the last minute
 18.66  CBFactoryTask: no site for armtide in a usable armtide area near (8527, 11288); retrying without the area check
 18.66  CBFactoryTask: no site for armtide at all | origin (8527, 11288) elev -77 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 19.27  BUILDER: discarded 2 unused default task(s) in the last minute
 19.41  CBFactoryTask: no site for armtide in a usable armtide area near (8638, 11252); retrying without the area check
 19.41  CBFactoryTask: no site for armtide at all | origin (8638, 11252) elev -78 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 19.51  BUILDER: discarded 1 unused default task(s) in the last minute
 19.58  BUILDER: discarded 1 unused default task(s) in the last minute
 19.76  CBFactoryTask: no site for armtide in a usable armtide area near (8545, 11294); retrying without the area check
 19.76  CBFactoryTask: no site for armtide at all | origin (8545, 11294) elev -77 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 20.53  BUILDER: discarded 2 unused default task(s) in the last minute
 21.09  BUILDER: discarded 1 unused default task(s) in the last minute
 22.10  BUILDER: discarded 3 unused default task(s) in the last minute
```
