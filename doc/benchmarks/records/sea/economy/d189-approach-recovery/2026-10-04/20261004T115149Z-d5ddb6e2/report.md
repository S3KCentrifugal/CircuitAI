# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54181); wall 270 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:47:17
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\tundra\20261004T114716Z-75a4fa43\runs\20261004T115149Z-d5ddb6e2\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:30.990113][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.6 min | `[t=00:00:46.699988][f=0001104] [SeaWatch] finished frame=1104 id=3076 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 1.9 min | `[t=00:00:51.938096][f=0003330] [SeaWatch] egress id=24884 yard=3076 seconds=9.1 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\tundra\20261004T114716Z-75a4fa43\runs\20261004T115149Z-d5ddb6e2\screen_2026-10-04_11-48-26-195.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\tundra\20261004T114716Z-75a4fa43\runs\20261004T115149Z-d5ddb6e2\screen_2026-10-04_11-48-50-181.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\tundra\20261004T114716Z-75a4fa43\runs\20261004T115149Z-d5ddb6e2\screen_2026-10-04_11-50-10-470.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\tundra\20261004T114716Z-75a4fa43\runs\20261004T115149Z-d5ddb6e2\screen_2026-10-04_11-51-38-116.png

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
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=4096,2096 facing=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5327,791) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7822,1502) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.15  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 21142 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.20  [Team][Roster] team 3 first mex at 7984,1504
  0.27  [Team][Roster] team 1 first mex at 5136,752
  0.61  [Playtest] finished armsy team 0 at 0.61 min
  0.92  [Playtest] finished armtide team 0 at 0.92 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 547/1150, energy +45.0 bank 107/1150, units 5
  1.30  [Playtest] finished armmex team 0 at 1.30 min
  1.57  [Playtest] finished armtide team 0 at 1.57 min
  1.95  [Playtest] finished armmex team 0 at 1.95 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 518/1250, energy +67.0 bank 103/1250, units 10
  2.32  [Playtest] finished armmex team 0 at 2.32 min
  2.44  [Playtest] finished armtide team 0 at 2.44 min
  2.66  [Playtest] finished armtide team 0 at 2.66 min
  2.67  [Playtest] finished armmex team 0 at 2.67 min
  2.81  [Playtest] finished armtide team 0 at 2.81 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +12.0 bank 718/1350, energy +119.0 bank 671/1450, units 16
  3.16  [Playtest] finished armtide team 0 at 3.16 min
  3.27  [Playtest] finished armmex team 0 at 3.27 min
  3.59  [Playtest] finished armmex team 0 at 3.59 min
  3.74  [Playtest] finished armmex team 0 at 3.74 min
  3.75  [Playtest] finished armtl team 0 at 3.75 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +18.0 bank 931/1500, energy +134.0 bank 3/1500, units 23
  4.01  [Playtest] finished armtl team 0 at 4.01 min
  4.19  [Playtest] finished armmex team 0 at 4.19 min
  4.71  [Playtest] finished armmex team 0 at 4.71 min
  4.95  [Playtest] finished armtl team 0 at 4.95 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +22.0 bank 1307/1600, energy +134.0 bank 264/1500, units 26
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.02  [Playtest] finished armtide team 0 at 5.02 min
  5.49  [Playtest] finished armtide team 0 at 5.49 min
  5.60  [Playtest] finished armmex team 0 at 5.60 min
  5.79  [Playtest] finished armtide team 0 at 5.79 min
  5.91  [Playtest] finished armmex team 0 at 5.91 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 1346/1700, energy +179.0 bank 1632/1650, units 32
  6.10  [Playtest] finished armtide team 0 at 6.10 min
  6.15  [Playtest] finished armmex team 0 at 6.15 min
  6.42  [Playtest] finished armtide team 0 at 6.42 min
  6.72  [Playtest] finished armtide team 0 at 6.72 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +28.0 bank 1645/1750, energy +231.0 bank 1833/1850, units 39
  7.14  [Playtest] finished armtl team 0 at 7.14 min
  7.21  [Playtest] finished armtide team 0 at 7.21 min
  7.21  [Playtest] finished armtide team 0 at 7.22 min
  7.26  [Playtest] finished armtl team 0 at 7.26 min
  7.52  [Playtest] finished armtide team 0 at 7.52 min
  7.52  [Playtest] finished armtide team 0 at 7.52 min
  7.96  [Playtest] finished armtl team 0 at 7.96 min
  8.00  [Playtest] finished armtide team 0 at 8.00 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +30.7 bank 1749/1750, energy +298.0 bank 2131/2150, units 46
  8.17  [Playtest] finished armfrad team 0 at 8.17 min
  8.73  [Playtest] finished armnanotcplat team 0 at 8.73 min
  8.77  [Playtest] finished armnanotcplat team 0 at 8.77 min
  8.82  [Playtest] finished armfmkr team 0 at 8.82 min
  8.91  [Playtest] finished armtide team 0 at 8.91 min
  9.00  [Playtest] finished armtide team 0 at 9.00 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +29.0 bank 1749/1750, energy +335.0 bank 2272/2300, units 53
  9.21  [Playtest] finished armtide team 0 at 9.21 min
  9.26  [Playtest] finished armtide team 0 at 9.26 min
  9.34  [Playtest] finished armtide team 0 at 9.34 min
  9.41  [Playtest] finished armtide team 0 at 9.41 min
  9.47  [Playtest] finished armmex team 0 at 9.47 min
  9.57  [Playtest] finished armfrad team 0 at 9.57 min
  9.68  [Playtest] finished armmex team 0 at 9.68 min
  9.84  [Playtest] finished armllt team 0 at 9.84 min
  9.85  [Playtest] finished armfrad team 0 at 9.85 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +33.0 bank 1809/1850, energy +410.0 bank 2457/2500, units 63
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.45  [Playtest] finished armmex team 0 at 10.45 min
 10.47  [Playtest] finished armmex team 0 at 10.48 min
 10.75  [Playtest] finished armmex team 0 at 10.75 min
 10.79  [Playtest] finished armmex team 0 at 10.79 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +40.5 bank 1631/2050, energy +417.0 bank 1931/2550, units 71
 11.03  [Playtest] finished armmex team 0 at 11.03 min
 11.12  [Playtest] finished armmex team 0 at 11.12 min
 11.38  [Playtest] finished armllt team 0 at 11.38 min
 11.68  [Playtest] finished armllt team 0 at 11.68 min
 11.71  [Playtest] finished armtl team 0 at 11.72 min
 11.97  [Playtest] finished armrad team 0 at 11.97 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +43.9 bank 1610/2150, energy +417.0 bank 767/2550, units 80
 12.02  [Playtest] finished armtl team 0 at 12.02 min
 12.10  [Playtest] finished armtl team 0 at 12.10 min
 12.80  [Playtest] finished armtl team 0 at 12.80 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +44.9 bank 1912/2150, energy +417.0 bank 2441/2550, units 85
 13.01  [Playtest] finished armfmkr team 0 at 13.01 min
 13.30  [Playtest] finished armtide team 0 at 13.30 min
 13.47  [Playtest] finished armtide team 0 at 13.47 min
 13.64  [Playtest] finished armtide team 0 at 13.64 min
 13.90  [Playtest] finished armtide team 0 at 13.90 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +45.9 bank 2148/2150, energy +477.0 bank 2721/2750, units 90
 14.10  [Playtest] finished armtide team 0 at 14.10 min
 14.45  [Playtest] finished armtide team 0 at 14.45 min
 14.66  [Playtest] finished armfmkr team 0 at 14.66 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +44.3 bank 1971/2150, energy +500.0 bank 2114/2800, units 96
 15.17  [Playtest] finished armfmkr team 0 at 15.17 min
 15.34  [Playtest] finished armmex team 0 at 15.34 min
 15.38  [Playtest] finished armmex team 0 at 15.38 min
 15.61  [Playtest] finished armfrad team 0 at 15.61 min
 15.79  [Playtest] finished armfmkr team 0 at 15.79 min
 15.90  [Playtest] finished armmex team 0 at 15.90 min
 15.95  [Playtest] finished armtide team 0 at 15.95 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +54.9 bank 2218/2300, energy +522.0 bank 2383/2900, units 105
 16.13  [Playtest] finished armtide team 0 at 16.13 min
 16.36  [Playtest] finished armtide team 0 at 16.36 min
 16.36  [Playtest] finished armtide team 0 at 16.36 min
 16.52  [Playtest] finished armtide team 0 at 16.52 min
 16.53  [Playtest] finished armmex team 0 at 16.53 min
 16.62  [Playtest] finished armfmkr team 0 at 16.62 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +54.7 bank 2006/2300, energy +582.0 bank 2655/3100, units 109
 18.00  [Playtest] eco team 0 at 18.0 min: metal +51.6 bank 2046/2300, energy +578.5 bank 2384/3100, units 111
 18.01  [Playtest] finished armmex team 0 at 18.01 min
 18.50  [Playtest] finished armfrad team 0 at 18.50 min
 18.90  [Playtest] finished armfrad team 0 at 18.90 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +60.2 bank 2021/2350, energy +575.0 bank 2750/3050, units 115
 19.39  [Playtest] finished armtide team 0 at 19.39 min
 19.93  [Playtest] finished armtide team 0 at 19.93 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +52.9 bank 1789/2350, energy +612.0 bank 2435/3200, units 122
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 20.04  [Playtest] finished armfmkr team 0 at 20.04 min
 20.06  [Playtest] finished armfmkr team 0 at 20.06 min
 20.48  [Playtest] finished armtide team 0 at 20.48 min
 20.80  [Playtest] finished armtide team 0 at 20.80 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +54.8 bank 1836/2350, energy +647.0 bank 2614/3350, units 119
 21.10  [SEA][Layout] berth sea.berth.3 legsy at=4288,2096 facing=0
 21.14  [Playtest] finished armtide team 0 at 21.14 min
 21.44  [Playtest] finished armfrad team 0 at 21.44 min
 21.46  [Playtest] finished armtide team 0 at 21.46 min
 21.98  [Playtest] finished armfmkr team 0 at 21.98 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +54.1 bank 1882/2350, energy +677.0 bank 2693/3450, units 119
 22.16  [Playtest] finished armmex team 0 at 22.16 min
 22.48  [Playtest] finished armtide team 0 at 22.48 min
 22.89  [Playtest] finished armtide team 0 at 22.89 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +57.7 bank 2203/2400, energy +702.0 bank 2746/3500, units 119
 23.76  [Playtest] finished armmex team 0 at 23.76 min
 23.86  [Playtest] finished armfmkr team 0 at 23.86 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +59.2 bank 1925/2450, energy +702.0 bank 2740/3500, units 126
 24.12  [Playtest] finished armmex team 0 at 24.12 min
 24.41  [Playtest] finished armtide team 0 at 24.41 min
 24.72  [Playtest] finished armtide team 0 at 24.72 min
 24.78  [Playtest] finished armtide team 0 at 24.78 min
 24.82  [Playtest] finished armmex team 0 at 24.82 min
 24.99  [Playtest] finished armmex team 0 at 24.99 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +62.7 bank 2521/2600, energy +747.0 bank 2851/3650, units 137
 25.19  [Playtest] finished armtide team 0 at 25.19 min
 25.20  [Playtest] finished armtide team 0 at 25.20 min
 25.37  [Playtest] finished armtl team 0 at 25.37 min
 25.54  [Playtest] finished armtide team 0 at 25.54 min
 25.86  [Playtest] finished armtide team 0 at 25.86 min
 25.96  [Playtest] finished armtl team 0 at 25.96 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +67.5 bank 2592/2600, energy +807.0 bank 3022/3850, units 139
 26.38  [Playtest] finished armtl team 0 at 26.38 min
 26.59  [Playtest] finished armtl team 0 at 26.59 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +64.9 bank 2561/2600, energy +807.0 bank 2992/3850, units 145
 27.28  [Playtest] finished armtl team 0 at 27.28 min
 27.40  [Playtest] finished armtl team 0 at 27.40 min
 27.99  [Playtest] finished armtl team 0 at 27.99 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +64.2 bank 2565/2600, energy +807.0 bank 2969/3850, units 151
 28.27  [Playtest] finished armasy team 0 at 28.27 min
 28.49  [Playtest] finished armtl team 0 at 28.49 min
 28.61  [Playtest] finished armtide team 0 at 28.61 min
 28.62  [Playtest] finished armnanotcplat team 0 at 28.62 min
 28.91  [Playtest] finished armtide team 0 at 28.91 min
 28.95  [Playtest] finished armtide team 0 at 28.95 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +71.9 bank 2233/2800, energy +882.0 bank 3561/4350, units 162
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 29.34  [Playtest] finished armuwmme team 0 at 29.34 min
 29.36  [Playtest] finished armtl team 0 at 29.36 min
 29.62  [Playtest] finished armtl team 0 at 29.62 min
 29.65  [Playtest] finished armtl team 0 at 29.65 min
 29.66  [Playtest] finished armtl team 0 at 29.66 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +75.4 bank 1057/3350, energy +912.0 bank 3547/4500, units 174
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(891) at (5328, 792) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(28578) at (7823, 1502) walks to (7847, 1503), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(22737) at (9054, 11420) walks to (9370, 11501), 139 from the cormex site (9504, 11536)
  0.10  RESERVE: zone 1 at (4096, 2096) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (4096, 2096) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (4096, 2384) facing 0, 12x30 cells: 356 of 360 held
  0.10  RESERVE: zone 3 at (4040, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4040, 1880) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (4104, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1880) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (4168, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1880) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (4040, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4040, 1944) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (4104, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1944) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (4168, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1944) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (4096, 1904) facing 0, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (7824, 1504) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7824, 1504) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (7824, 1792) facing 0, 12x30 cells: 348 of 360 held
  0.10  RESERVE: zone 3 at (7768, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1288) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7832, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7832, 1288) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7896, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1288) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7768, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1352) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7832, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7832, 1352) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7896, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1352) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (7824, 1312) facing 0, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (6800, 10608) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (6800, 10608) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (6800, 10320) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (6872, 10840) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6872, 10840) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (6808, 10840) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6808, 10840) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (6744, 10840) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6744, 10840) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (6872, 10776) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6872, 10776) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (6808, 10776) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6808, 10776) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (6744, 10776) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6744, 10776) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (6800, 10800) facing 2, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (8208, 10896) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (8208, 10896) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (8208, 10608) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (8376, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8376, 11128) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (8312, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8312, 11128) facing 2 (id 3)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 at (8360, 11160) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8360, 11160) facing 2 (id 4)
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 at (8344, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8344, 11192) facing 2 (id 5)
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (8312, 11208) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8312, 11208) facing 2 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (8280, 11224) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8280, 11224) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (8216, 11224) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8216, 11224) facing 2 (id 8)
  0.10  RESERVE: zone 10 at (8152, 11224) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8152, 11224) facing 2 (id 9)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (8200, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8200, 11192) facing 2 (id 10)
  0.10  RESERVE: zone 12 at (8136, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8136, 11192) facing 2 (id 11)
  0.10  RESERVE: zone 13 at (8072, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8072, 11192) facing 2 (id 12)
  0.10  RESERVE: zone 14 at (8200, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8200, 11128) facing 2 (id 13)
  0.10  RESERVE: zone 15 at (8136, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8136, 11128) facing 2 (id 14)
  0.10  RESERVE: zone 16 at (8072, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8072, 11128) facing 2 (id 15)
  0.10  RESERVE: zone 17 at (8140, 11156) facing 2, 13x9 cells: 59 of 117 held
  0.10  RESERVE: zone 1 at (9056, 11424) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: corsy at (9056, 11424) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (9056, 11136) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (9128, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9128, 11656) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (9064, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9064, 11656) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (9000, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9000, 11656) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (9128, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9128, 11592) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (9064, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9064, 11592) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (9000, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9000, 11592) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (9056, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.11  EXP: idle: legcom(28578) on legmex at (7840, 1502), site (7984, 1504), target yes, fails 1 (arrived at the approach point)
  0.12  RESERVE: zone 10 at (4496, 2096) facing 0, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (4496, 2096) facing 0 (id 8)
  0.12  RESERVE: corridor 11 at (4496, 2432) facing 0, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (4536, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4536, 1880) facing 0 (id 9)
  0.12  RESERVE: zone 13 at (4600, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4600, 1880) facing 0 (id 10)
  0.12  RESERVE: zone 14 at (4664, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4664, 1880) facing 0 (id 11)
  0.12  RESERVE: zone 15 at (4536, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4536, 1944) facing 0 (id 12)
  0.12  RESERVE: zone 16 at (4600, 1944) facing 0, 3x3 cells: 9 of 9 held
```
