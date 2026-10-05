# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36006); wall 179 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:26:24
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T142623Z-8d503aec\runs\20261004T142926Z-328aee2f\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:32.443686][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.6 min | `[t=00:00:47.293785][f=0001089] [SeaWatch] finished frame=1089 id=9050 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 2.4 min | `[t=00:00:54.410161][f=0004290] [SeaWatch] egress id=18500 yard=9050 seconds=11.8 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T142623Z-8d503aec\runs\20261004T142926Z-328aee2f\screen_2026-10-04_14-27-33-417.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T142623Z-8d503aec\runs\20261004T142926Z-328aee2f\screen_2026-10-04_14-28-02-195.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T142623Z-8d503aec\runs\20261004T142926Z-328aee2f\screen_2026-10-04_14-29-25-389.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 20.5 min
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
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=4096,2096 facing=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5334,793) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7819,1503) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.15  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 5679 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.22  [Team][Roster] team 3 first mex at 7984,1504
  0.28  [Team][Roster] team 1 first mex at 5136,752
  0.60  [Playtest] finished armsy team 0 at 0.61 min
  0.82  [Playtest] finished armmex team 0 at 0.82 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 649/1200, energy +30.0 bank 96/1100, units 5
  1.28  [Playtest] finished armtide team 0 at 1.28 min
  1.66  [Playtest] finished armmex team 0 at 1.66 min
  1.92  [Playtest] finished armtide team 0 at 1.92 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 682/1250, energy +60.0 bank 72/1200, units 9
  2.10  [Playtest] finished armtide team 0 at 2.10 min
  2.24  [Playtest] finished armtide team 0 at 2.24 min
  2.38  [Playtest] finished armtide team 0 at 2.38 min
  2.52  [Playtest] finished armtide team 0 at 2.52 min
  2.70  [Playtest] finished armtide team 0 at 2.70 min
  2.85  [Playtest] finished armmex team 0 at 2.85 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 822/1300, energy +149.0 bank 1457/1550, units 18
  3.17  [Playtest] finished armmex team 0 at 3.17 min
  3.74  [Playtest] finished armmex team 0 at 3.74 min
  3.76  [Playtest] finished armmex team 0 at 3.76 min
  3.92  [Playtest] finished armnanotcplat team 0 at 3.92 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +16.0 bank 833/1450, energy +149.0 bank 152/1550, units 24
  4.14  [Playtest] finished armmex team 0 at 4.14 min
  4.24  [Playtest] finished armtide team 0 at 4.24 min
  4.45  [Playtest] finished armmex team 0 at 4.45 min
  4.72  [Playtest] finished armtide team 0 at 4.72 min
  4.89  [Playtest] finished armtide team 0 at 4.89 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.0 bank 765/1550, energy +194.0 bank 1000/1700, units 27
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.00  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.26  [Playtest] finished armtide team 0 at 5.26 min
  5.48  [Playtest] finished armtide team 0 at 5.48 min
  5.82  [Playtest] finished armtide team 0 at 5.82 min
  5.83  [Playtest] finished armtl team 0 at 5.83 min
  5.99  [Playtest] finished armtide team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.0 bank 922/1550, energy +239.0 bank 1873/1900, units 36
  6.07  [Playtest] finished armmex team 0 at 6.07 min
  6.33  [Playtest] finished armtide team 0 at 6.33 min
  6.49  [Playtest] finished armtide team 0 at 6.49 min
  6.58  [Playtest] finished armtl team 0 at 6.58 min
  6.68  [Playtest] finished armmex team 0 at 6.68 min
  6.73  [Playtest] finished armtide team 0 at 6.73 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +24.0 bank 398/1650, energy +313.0 bank 2133/2150, units 42
  7.04  [Playtest] finished armtide team 0 at 7.04 min
  7.44  [Playtest] finished armtl team 0 at 7.44 min
  7.47  [Playtest] finished armmex team 0 at 7.47 min
  7.69  [Playtest] finished armmex team 0 at 7.69 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.0 bank 1063/1750, energy +335.0 bank 2185/2250, units 49
  8.23  [Playtest] finished armtl team 0 at 8.23 min
  8.40  [Playtest] finished armmex team 0 at 8.40 min
  8.47  [Playtest] finished armtl team 0 at 8.48 min
  8.50  [Playtest] finished armfrad team 0 at 8.50 min
  8.62  [Playtest] finished armtide team 0 at 8.62 min
  8.73  [Playtest] finished armmex team 0 at 8.73 min
  8.79  [Playtest] finished armmex team 0 at 8.79 min
  8.94  [Playtest] finished armtide team 0 at 8.94 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +33.9 bank 1582/1900, energy +372.0 bank 2240/2400, units 63
  9.01  [Playtest] finished armtide team 0 at 9.01 min
  9.09  [Playtest] finished armtl team 0 at 9.09 min
  9.22  [Playtest] finished armtide team 0 at 9.22 min
  9.26  [Playtest] finished armtide team 0 at 9.26 min
  9.33  [Playtest] finished armtide team 0 at 9.33 min
  9.42  [Playtest] finished armtl team 0 at 9.42 min
  9.57  [Playtest] finished armtide team 0 at 9.57 min
  9.61  [Playtest] finished armtide team 0 at 9.61 min
  9.75  [Playtest] finished armfmkr team 0 at 9.75 min
  9.93  [Playtest] finished armtide team 0 at 9.93 min
  9.95  [Playtest] finished armtide team 0 at 9.95 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +34.9 bank 1871/1900, energy +492.0 bank 2761/2800, units 69
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.21  [Playtest] finished armtide team 0 at 10.21 min
 10.25  [Playtest] finished armtide team 0 at 10.25 min
 10.25  [Playtest] finished armllt team 0 at 10.25 min
 10.27  [Playtest] finished armtide team 0 at 10.27 min
 10.50  [Playtest] finished armfrad team 0 at 10.50 min
 10.54  [Playtest] finished armtide team 0 at 10.54 min
 10.59  [Playtest] finished armtide team 0 at 10.59 min
 10.69  [Playtest] finished armtide team 0 at 10.69 min
 10.86  [Playtest] finished armtide team 0 at 10.86 min
 10.91  [Playtest] finished armtide team 0 at 10.91 min
 10.99  [Playtest] finished armfmkr team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +33.0 bank 1821/1850, energy +612.0 bank 3143/3200, units 80
 11.02  [Playtest] finished armtide team 0 at 11.02 min
 11.06  [Playtest] finished armnanotcplat team 0 at 11.06 min
 11.21  [Playtest] finished armtide team 0 at 11.21 min
 11.24  [Playtest] finished armfmkr team 0 at 11.24 min
 11.24  [Playtest] finished armtide team 0 at 11.24 min
 11.31  [Playtest] finished armfmkr team 0 at 11.31 min
 11.37  [Playtest] finished armtide team 0 at 11.37 min
 11.41  [Playtest] finished armfmkr team 0 at 11.41 min
 11.53  [Playtest] finished armtide team 0 at 11.53 min
 11.55  [Playtest] finished armfmkr team 0 at 11.55 min
 11.65  [Playtest] finished armtide team 0 at 11.65 min
 11.83  [Playtest] finished armtl team 0 at 11.83 min
 11.91  [Playtest] finished armtide team 0 at 11.91 min
 11.93  [Playtest] finished armfmkr team 0 at 11.93 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +34.3 bank 1289/1800, energy +717.0 bank 2782/3550, units 91
 12.05  [Playtest] finished armtide team 0 at 12.05 min
 12.27  [Playtest] finished armfmkr team 0 at 12.27 min
 12.32  [Playtest] finished armfmkr team 0 at 12.32 min
 12.34  [Playtest] finished armtide team 0 at 12.34 min
 12.38  [Playtest] finished armtide team 0 at 12.38 min
 12.50  [Playtest] finished armtide team 0 at 12.50 min
 12.52  [Playtest] finished armfmkr team 0 at 12.52 min
 12.52  [Playtest] finished armtide team 0 at 12.52 min
 12.84  [Playtest] finished armfmkr team 0 at 12.84 min
 12.90  [Playtest] finished armtide team 0 at 12.90 min
 12.91  [Playtest] finished armfmkr team 0 at 12.91 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +31.7 bank 967/1650, energy +807.0 bank 3075/3850, units 93
 13.01  [Playtest] finished armtide team 0 at 13.01 min
 13.18  [Playtest] finished armnanotcplat team 0 at 13.18 min
 13.37  [Playtest] finished armmex team 0 at 13.37 min
 13.61  [Playtest] finished armfmkr team 0 at 13.61 min
 13.65  [Playtest] finished armtide team 0 at 13.65 min
 13.86  [Playtest] finished armtl team 0 at 13.85 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +26.9 bank 15/1500, energy +823.5 bank 3158/3800, units 91
 14.85  [Playtest] finished armtide team 0 at 14.85 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +16.7 bank 126/1150, energy +689.5 bank 2617/2650, units 43
 15.20  [SEA][Layout] berth sea.berth.3 armsy at=4512,3072 facing=1
 15.26  [Playtest] finished armtl team 0 at 15.26 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +6.0 bank 419/650, energy +7.0 bank 526/550, units 9
 17.00  [Playtest] eco team 0 at 17.0 min: metal +6.0 bank 519/650, energy +7.0 bank 542/550, units 9
 18.00  [Playtest] eco team 0 at 18.0 min: metal +6.0 bank 650/650, energy +0.0 bank 205/500, units 8
 19.00  [Playtest] eco team 0 at 19.0 min: metal +0.0 bank 650/650, energy +0.0 bank 1/500, units 8
 20.00  [Playtest] eco team 0 at 20.0 min: metal +0.0 bank 600/600, energy +0.0 bank 1/500, units 4
 20.00  [Playtest] camera requested (4100,2100) height=2200
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(891) at (5334, 794) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(28578) at (7819, 1504) walks to (7847, 1504), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(22737) at (9049, 11419) walks to (9370, 11502), 139 from the cormex site (9504, 11536)
  0.10  RESERVE: zone 1 at (4096, 2096) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (4096, 2096) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (4096, 2384) facing 0, 12x30 cells: 356 of 360 held
  0.10  RESERVE: zone 3 at (4072, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4072, 1976) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (4120, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4120, 1976) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (4168, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1976) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (4216, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4216, 1976) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (4264, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4264, 1976) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (4072, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4072, 2024) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (4120, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4120, 2024) facing 0 (id 8)
  0.10  RESERVE: zone 10 at (4168, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 2024) facing 0 (id 9)
  0.10  RESERVE: zone 11 at (4216, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4216, 2024) facing 0 (id 10)
  0.10  RESERVE: zone 12 at (4264, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4264, 2024) facing 0 (id 11)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 at (3928, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3928, 1976) facing 0 (id 12)
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 at (3864, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1928) facing 0 (id 13)
  0.10  RESERVE: zone 15 at (3912, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1928) facing 0 (id 14)
  0.10  RESERVE: zone 16 at (3960, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1928) facing 0 (id 15)
  0.10  RESERVE: zone 17 at (4008, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1928) facing 0 (id 16)
  0.10  RESERVE: zone 18 at (4056, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4056, 1928) facing 0 (id 17)
  0.10  RESERVE: zone 19 at (3864, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1976) facing 0 (id 18)
  0.10  RESERVE: zone 20 at (3912, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1976) facing 0 (id 19)
  0.10  RESERVE: zone 21 at (3960, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1976) facing 0 (id 20)
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 at (3816, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3816, 1880) facing 0 (id 21)
  0.10  RESERVE: zone 23 at (3864, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1880) facing 0 (id 22)
  0.10  RESERVE: zone 24 at (3912, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1880) facing 0 (id 23)
  0.10  RESERVE: zone 25 at (3960, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1880) facing 0 (id 24)
  0.10  RESERVE: zone 26 at (4008, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1880) facing 0 (id 25)
  0.10  RESERVE: zone 27 at (3816, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3816, 1928) facing 0 (id 26)
  0.10  RESERVE: zone 28 at (3864, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1928) facing 0 (id 27)
  0.10  RESERVE: zone 29 at (3912, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1928) facing 0 (id 28)
  0.10  RESERVE: zone 30 at (3960, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1928) facing 0 (id 29)
  0.10  RESERVE: zone 31 at (4008, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1928) facing 0 (id 30)
  0.10  RESERVE: zone 32 at (3816, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3816, 1976) facing 0 (id 31)
  0.10  RESERVE: zone 33 at (3864, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1976) facing 0 (id 32)
  0.10  RESERVE: zone 34 at (3912, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1976) facing 0 (id 33)
  0.10  RESERVE: zone 35 at (3960, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1976) facing 0 (id 34)
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 released
  0.10  RESERVE: zone 24 released
  0.10  RESERVE: zone 25 released
  0.10  RESERVE: zone 26 released
  0.10  RESERVE: zone 27 released
  0.10  RESERVE: zone 28 released
  0.10  RESERVE: zone 29 released
  0.10  RESERVE: zone 30 released
  0.10  RESERVE: zone 31 released
  0.10  RESERVE: zone 32 released
  0.10  RESERVE: zone 33 released
  0.10  RESERVE: zone 34 released
  0.10  RESERVE: zone 35 released
  0.10  RESERVE: zone 1 at (7824, 1504) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7824, 1504) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (7824, 1792) facing 0, 12x30 cells: 348 of 360 held
  0.10  RESERVE: zone 3 at (7800, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7800, 1384) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7848, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7848, 1384) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7896, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1384) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7944, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7944, 1384) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7992, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7992, 1384) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7800, 1432) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7800, 1432) facing 0 (id 7)
```
