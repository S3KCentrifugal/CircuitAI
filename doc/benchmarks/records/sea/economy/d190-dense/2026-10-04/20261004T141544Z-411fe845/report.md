# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36023); wall 172 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:12:49
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d190-dense\tundra\20261004T141249Z-f2fe9570\runs\20261004T141544Z-411fe845\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.831217][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.6 min | `[t=00:00:46.677121][f=0001089] [SeaWatch] finished frame=1089 id=9050 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 2.4 min | `[t=00:00:53.855368][f=0004320] [SeaWatch] egress id=4850 yard=9050 seconds=11.4 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d190-dense\tundra\20261004T141249Z-f2fe9570\runs\20261004T141544Z-411fe845\screen_2026-10-04_14-13-58-132.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d190-dense\tundra\20261004T141249Z-f2fe9570\runs\20261004T141544Z-411fe845\screen_2026-10-04_14-14-20-708.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d190-dense\tundra\20261004T141249Z-f2fe9570\runs\20261004T141544Z-411fe845\screen_2026-10-04_14-15-43-787.png

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
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5323,790) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7815,1505) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 30071 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.20  [Team][Roster] team 3 first mex at 7984,1504
  0.28  [Team][Roster] team 1 first mex at 5136,752
  0.60  [Playtest] finished armsy team 0 at 0.61 min
  0.86  [Playtest] finished armmex team 0 at 0.86 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 640/1200, energy +30.0 bank 113/1100, units 5
  1.36  [Playtest] finished armmex team 0 at 1.36 min
  1.70  [Playtest] finished armtide team 0 at 1.70 min
  1.86  [Playtest] finished armtide team 0 at 1.86 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 744/1250, energy +60.0 bank 123/1200, units 8
  2.81  [Playtest] finished armmex team 0 at 2.81 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 1168/1300, energy +67.0 bank 101/1250, units 11
  3.00  [Playtest] finished armmex team 0 at 3.01 min
  3.26  [Playtest] finished armmex team 0 at 3.26 min
  3.86  [Playtest] finished armtide team 0 at 3.86 min
  3.89  [Playtest] finished armmex team 0 at 3.89 min
  3.90  [Playtest] finished armtide team 0 at 3.90 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +16.0 bank 1124/1450, energy +104.0 bank 55/1400, units 19
  4.00  [Playtest] finished armtide team 0 at 4.00 min
  4.10  [Playtest] finished armtide team 0 at 4.10 min
  4.21  [Playtest] finished armmex team 0 at 4.21 min
  4.30  [Playtest] finished armtide team 0 at 4.30 min
  4.41  [Playtest] finished armtide team 0 at 4.41 min
  4.53  [Playtest] finished armmex team 0 at 4.53 min
  4.71  [Playtest] finished armtide team 0 at 4.71 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.0 bank 1377/1550, energy +179.0 bank 1282/1650, units 27
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.02  [Playtest] finished armtide team 0 at 5.02 min
  5.02  [Playtest] finished armmex team 0 at 5.02 min
  5.33  [Playtest] finished armtide team 0 at 5.33 min
  5.35  [Playtest] finished armmex team 0 at 5.35 min
  5.49  [Playtest] finished armmex team 0 at 5.49 min
  5.64  [Playtest] finished armtide team 0 at 5.64 min
  5.67  [Playtest] finished armmex team 0 at 5.67 min
  5.78  [Playtest] finished armtl team 0 at 5.78 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 1536/1700, energy +224.0 bank 1760/1800, units 34
  6.26  [Playtest] finished armtl team 0 at 6.26 min
  6.58  [Playtest] finished armmex team 0 at 6.58 min
  6.64  [Playtest] finished armtide team 0 at 6.64 min
  6.94  [Playtest] finished armmex team 0 at 6.94 min
  6.95  [Playtest] finished armtide team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.0 bank 1695/1700, energy +261.0 bank 1943/1950, units 36
  7.32  [Playtest] finished armtide team 0 at 7.32 min
  7.65  [Playtest] finished armtide team 0 at 7.65 min
  7.72  [Playtest] finished armtl team 0 at 7.72 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +26.0 bank 1695/1700, energy +291.0 bank 2039/2050, units 40
  8.40  [Playtest] finished armnanotcplat team 0 at 8.40 min
  8.59  [Playtest] finished armtide team 0 at 8.59 min
  8.81  [Playtest] finished armtide team 0 at 8.81 min
  9.00  [Playtest] finished armtl team 0 at 9.00 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +20.0 bank 1520/1550, energy +321.0 bank 2146/2150, units 42
  9.08  [Playtest] finished armtide team 0 at 9.08 min
  9.15  [Playtest] finished armtide team 0 at 9.15 min
  9.21  [Playtest] finished armfrad team 0 at 9.21 min
  9.33  [Playtest] finished armtide team 0 at 9.33 min
  9.40  [Playtest] finished armtide team 0 at 9.40 min
  9.51  [Playtest] finished armtide team 0 at 9.51 min
  9.65  [Playtest] finished armtide team 0 at 9.65 min
  9.70  [Playtest] finished armnanotcplat team 0 at 9.70 min
  9.75  [Playtest] finished armtide team 0 at 9.75 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +20.0 bank 1420/1550, energy +433.0 bank 2524/2550, units 50
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.06  [Playtest] finished armtide team 0 at 10.06 min
 10.08  [Playtest] finished armtide team 0 at 10.08 min
 10.17  [Playtest] finished armtide team 0 at 10.17 min
 10.24  [Playtest] finished armtide team 0 at 10.24 min
 10.36  [Playtest] finished armtide team 0 at 10.36 min
 10.43  [Playtest] finished armtide team 0 at 10.43 min
 10.48  [Playtest] finished armfrad team 0 at 10.48 min
 10.62  [Playtest] finished armtide team 0 at 10.62 min
 10.71  [Playtest] finished armnanotcplat team 0 at 10.71 min
 10.74  [Playtest] finished armfrad team 0 at 10.74 min
 10.78  [Playtest] finished armtl team 0 at 10.78 min
 10.83  [Playtest] finished armnanotcplat team 0 at 10.83 min
 10.87  [Playtest] finished armtide team 0 at 10.87 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +18.0 bank 1277/1500, energy +560.0 bank 2999/3000, units 62
 11.03  [Playtest] finished armtide team 0 at 11.03 min
 11.18  [Playtest] finished armfmkr team 0 at 11.18 min
 11.26  [Playtest] finished armtide team 0 at 11.26 min
 11.37  [Playtest] finished armfmkr team 0 at 11.36 min
 11.43  [Playtest] finished armfmkr team 0 at 11.43 min
 11.53  [Playtest] finished armfmkr team 0 at 11.53 min
 11.66  [Playtest] finished armfmkr team 0 at 11.66 min
 11.82  [Playtest] finished armfmkr team 0 at 11.82 min
 11.87  [Playtest] finished armmex team 0 at 11.87 min
 11.87  [Playtest] finished armtl team 0 at 11.87 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +14.0 bank 23/1400, energy +597.0 bank 2041/3150, units 72
 12.05  [Playtest] finished armfrad team 0 at 12.05 min
 12.31  [Playtest] finished armtide team 0 at 12.31 min
 12.49  [Playtest] finished armmex team 0 at 12.49 min
 12.80  [Playtest] finished armmex team 0 at 12.80 min
 12.92  [Playtest] finished armtide team 0 at 12.92 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +24.0 bank 248/1500, energy +613.0 bank 2612/3150, units 78
 13.00  [Playtest] finished armtide team 0 at 13.00 min
 13.10  [Playtest] finished armmex team 0 at 13.10 min
 13.13  [Playtest] finished armtide team 0 at 13.13 min
 13.36  [Playtest] finished armtide team 0 at 13.36 min
 13.41  [Playtest] finished armtide team 0 at 13.41 min
 13.46  [Playtest] finished armtide team 0 at 13.47 min
 13.78  [Playtest] finished armtide team 0 at 13.78 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +18.2 bank 16/1400, energy +696.0 bank 2701/3400, units 76
 14.03  [Playtest] finished armfmkr team 0 at 14.03 min
 14.07  [Playtest] finished armfmkr team 0 at 14.07 min
 14.13  [Playtest] finished armfmkr team 0 at 14.13 min
 14.17  [Playtest] finished armtide team 0 at 14.17 min
 14.95  [Playtest] finished armmex team 0 at 14.95 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +18.6 bank 6/1300, energy +704.0 bank 2833/3350, units 71
 15.53  [SEA][Layout] berth sea.berth.3 legsy at=4352,1472 facing=1
 16.00  [Playtest] eco team 0 at 16.0 min: metal +2.0 bank 501/550, energy +7.0 bank 548/550, units 7
 16.08  [SEA][Layout] berth sea.berth.4 corsy at=3760,2432 facing=0
 17.00  [Playtest] eco team 0 at 17.0 min: metal +2.0 bank 327/550, energy +7.0 bank 470/550, units 8
 18.00  [Playtest] eco team 0 at 18.0 min: metal +7.8 bank 550/550, energy +0.0 bank 462/500, units 7
 19.00  [Playtest] eco team 0 at 19.0 min: metal +2.0 bank 550/550, energy +0.0 bank 492/500, units 6
 20.00  [Playtest] eco team 0 at 20.0 min: metal +0.0 bank 500/500, energy +0.0 bank 480/500, units 0
 20.00  [Playtest] camera requested (4100,2100) height=2200
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(891) at (5323, 791) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(28578) at (7815, 1506) walks to (7847, 1505), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(22737) at (9056, 11421) walks to (9370, 11501), 139 from the cormex site (9504, 11536)
  0.10  RESERVE: zone 1 at (4096, 2096) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (4096, 2096) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (4096, 2384) facing 0, 12x30 cells: 356 of 360 held
  0.10  RESERVE: zone 3 at (4008, 1800) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1800) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (4056, 1800) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4056, 1800) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (4104, 1800) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1800) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (4152, 1800) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4152, 1800) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (4200, 1800) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4200, 1800) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (4008, 1848) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1848) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (4056, 1848) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4056, 1848) facing 0 (id 8)
  0.10  RESERVE: zone 10 at (4104, 1848) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1848) facing 0 (id 9)
  0.10  RESERVE: zone 11 at (4152, 1848) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4152, 1848) facing 0 (id 10)
  0.10  RESERVE: zone 12 at (4200, 1848) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4200, 1848) facing 0 (id 11)
  0.10  RESERVE: zone 13 at (4008, 1896) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1896) facing 0 (id 12)
  0.10  RESERVE: zone 14 at (4056, 1896) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4056, 1896) facing 0 (id 13)
  0.10  RESERVE: zone 15 at (4104, 1896) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1896) facing 0 (id 14)
  0.10  RESERVE: zone 16 at (4152, 1896) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4152, 1896) facing 0 (id 15)
  0.10  RESERVE: zone 17 at (4200, 1896) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4200, 1896) facing 0 (id 16)
  0.10  RESERVE: zone 18 at (4008, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1944) facing 0 (id 17)
  0.10  RESERVE: zone 19 at (4056, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4056, 1944) facing 0 (id 18)
  0.10  RESERVE: zone 20 at (4104, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1944) facing 0 (id 19)
  0.10  RESERVE: zone 21 at (4152, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4152, 1944) facing 0 (id 20)
  0.10  RESERVE: zone 22 at (4200, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4200, 1944) facing 0 (id 21)
  0.10  RESERVE: zone 1 at (7808, 1504) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7808, 1504) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (7808, 1792) facing 0, 12x30 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (7720, 1208) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7720, 1208) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7768, 1208) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1208) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7816, 1208) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7816, 1208) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7864, 1208) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7864, 1208) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7912, 1208) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7912, 1208) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7720, 1256) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7720, 1256) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (7768, 1256) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1256) facing 0 (id 8)
  0.10  RESERVE: zone 10 at (7816, 1256) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7816, 1256) facing 0 (id 9)
  0.10  RESERVE: zone 11 at (7864, 1256) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7864, 1256) facing 0 (id 10)
  0.10  RESERVE: zone 12 at (7912, 1256) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7912, 1256) facing 0 (id 11)
  0.10  RESERVE: zone 13 at (7720, 1304) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7720, 1304) facing 0 (id 12)
  0.10  RESERVE: zone 14 at (7768, 1304) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1304) facing 0 (id 13)
  0.10  RESERVE: zone 15 at (7816, 1304) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7816, 1304) facing 0 (id 14)
  0.10  RESERVE: zone 16 at (7864, 1304) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7864, 1304) facing 0 (id 15)
  0.10  RESERVE: zone 17 at (7912, 1304) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7912, 1304) facing 0 (id 16)
  0.10  RESERVE: zone 18 at (7720, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7720, 1352) facing 0 (id 17)
  0.10  RESERVE: zone 19 at (7768, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1352) facing 0 (id 18)
  0.10  RESERVE: zone 20 at (7816, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7816, 1352) facing 0 (id 19)
  0.10  RESERVE: zone 21 at (7864, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7864, 1352) facing 0 (id 20)
  0.10  RESERVE: zone 22 at (7912, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7912, 1352) facing 0 (id 21)
  0.10  RESERVE: zone 1 at (6800, 10608) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (6800, 10608) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (6800, 10320) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (6904, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6904, 10904) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (6856, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6856, 10904) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (6808, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6808, 10904) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (6760, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6760, 10904) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (6712, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6712, 10904) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (6904, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6904, 10856) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (6856, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6856, 10856) facing 2 (id 8)
  0.10  RESERVE: zone 10 at (6808, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6808, 10856) facing 2 (id 9)
  0.10  RESERVE: zone 11 at (6760, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6760, 10856) facing 2 (id 10)
  0.10  RESERVE: zone 12 at (6712, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6712, 10856) facing 2 (id 11)
  0.10  RESERVE: zone 13 at (6904, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6904, 10808) facing 2 (id 12)
  0.10  RESERVE: zone 14 at (6856, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6856, 10808) facing 2 (id 13)
  0.10  RESERVE: zone 15 at (6808, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6808, 10808) facing 2 (id 14)
  0.10  RESERVE: zone 16 at (6760, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6760, 10808) facing 2 (id 15)
```
