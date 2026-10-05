# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 13.4 min (frame 24095); wall 135 s
- DLL: build-theatres\d189-baseline\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T07:22:31
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T102231Z-d6bbcffe\runs\20261004T102450Z-071d15fd\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:39.099000][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.5 min | `[t=00:01:01.061420][f=0002632] [SeaWatch] finished frame=2632 id=6328 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 4.3 min | `[t=00:01:12.481674][f=0007680] [SeaWatch] egress id=5202 yard=6328 seconds=5.2 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-033 metal over 95% for 60 s while team 6 has 361 free` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 13.3 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 6 has 361 free

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T102231Z-d6bbcffe\runs\20261004T102450Z-071d15fd\screen_2026-10-04_10-23-52-351.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T102231Z-d6bbcffe\runs\20261004T102450Z-071d15fd\screen_2026-10-04_10-24-25-477.png

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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4100|2098|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5344,796) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7824,1501) factory=legsy landLocked=no spot=6 known=3/3
  0.17  [SEA][Layout] berth sea.berth.0 armsy at=4000,2096 facing=0
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.18  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.20  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.22  [Team][Roster] team 3 first mex at 7984,1504
  0.23  [Playtest] finished armmex team 0 at 0.23 min
  0.23  [Team][Roster] first mex 9080 at 4016,2016
  0.23  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2098|0|3|1|4016|2016
  0.28  [Team][Roster] team 1 first mex at 5136,752
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 1043/1050, energy +30.0 bank 976/1000, units 2
  1.15  [Playtest] finished armmex team 0 at 1.15 min
  1.46  [Playtest] finished armsy team 0 at 1.46 min
  1.95  [Playtest] finished armtide team 0 at 1.95 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 718/1200, energy +45.0 bank 128/1150, units 6
  2.30  [Playtest] finished armmex team 0 at 2.30 min
  2.60  [Playtest] finished armtide team 0 at 2.60 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 1028/1250, energy +60.0 bank 0/1200, units 9
  3.15  [Playtest] finished armtl team 0 at 3.15 min
  3.36  [Playtest] finished armtide team 0 at 3.36 min
  3.90  [Playtest] finished armtide team 0 at 3.90 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 935/1250, energy +104.0 bank 424/1400, units 14
  4.21  [Playtest] finished armtide team 0 at 4.21 min
  4.30  [Playtest] finished armtide team 0 at 4.30 min
  4.33  [Playtest] finished armmex team 0 at 4.33 min
  4.79  [Playtest] finished armfrad team 0 at 4.79 min
  4.90  [Playtest] finished armtl team 0 at 4.90 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 537/1300, energy +134.0 bank 843/1500, units 22
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.18  [Playtest] finished armtide team 0 at 5.18 min
  5.45  [Playtest] finished armmex team 0 at 5.45 min
  5.50  [Playtest] finished armtide team 0 at 5.50 min
  5.82  [Playtest] finished armtide team 0 at 5.82 min
  5.97  [Playtest] finished armtl team 0 at 5.97 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.0 bank 29/1350, energy +179.0 bank 1639/1650, units 27
  6.72  [Playtest] finished armmex team 0 at 6.72 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +14.0 bank 0/1400, energy +179.0 bank 1638/1650, units 30
  7.36  [Playtest] finished armtl team 0 at 7.36 min
  7.72  [Playtest] finished armmex team 0 at 7.72 min
  7.83  [Playtest] finished armmex team 0 at 7.83 min
  7.93  [Playtest] finished armtide team 0 at 7.93 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +18.0 bank 21/1500, energy +194.0 bank 1675/1700, units 32
  8.16  [Playtest] finished armfrad team 0 at 8.16 min
  8.40  [Playtest] finished armmex team 0 at 8.40 min
  8.43  [Playtest] finished armtide team 0 at 8.43 min
  8.73  [Playtest] finished armmex team 0 at 8.73 min
  8.84  [Playtest] finished armtide team 0 at 8.84 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +22.0 bank 174/1600, energy +231.0 bank 1831/1850, units 38
  9.04  [Playtest] finished armmex team 0 at 9.04 min
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.31  [Playtest] finished armfrad team 0 at 9.31 min
  9.48  [Playtest] finished armtide team 0 at 9.48 min
  9.80  [Playtest] finished armtide team 0 at 9.80 min
  9.85  [Playtest] finished armtl team 0 at 9.85 min
  9.88  [Playtest] finished armmex team 0 at 9.88 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.0 bank 268/1700, energy +283.0 bank 2036/2050, units 49
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.01  [Playtest] finished armtide team 0 at 10.01 min
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.10  [Playtest] finished armtide team 0 at 10.10 min
 10.19  [Playtest] finished armmex team 0 at 10.19 min
 10.23  [Playtest] finished armtide team 0 at 10.23 min
 10.40  [Playtest] finished armtide team 0 at 10.40 min
 10.70  [Playtest] finished armtl team 0 at 10.70 min
 10.72  [Playtest] finished armtide team 0 at 10.72 min
 10.76  [Playtest] finished armmex team 0 at 10.76 min
 10.77  [Playtest] finished armtide team 0 at 10.77 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +30.0 bank 348/1800, energy +373.0 bank 2332/2350, units 58
 11.04  [Playtest] finished armtide team 0 at 11.04 min
 11.08  [Playtest] finished armmex team 0 at 11.08 min
 11.09  [Playtest] finished armtide team 0 at 11.09 min
 11.13  [Playtest] finished armmex team 0 at 11.13 min
 11.36  [Playtest] finished armtide team 0 at 11.36 min
 11.45  [Playtest] finished armmex team 0 at 11.45 min
 11.60  [Playtest] finished armtide team 0 at 11.60 min
 11.77  [Playtest] finished armtide team 0 at 11.77 min
 11.80  [Playtest] finished armfrad team 0 at 11.80 min
 11.96  [Playtest] finished armtide team 0 at 11.96 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +35.9 bank 1022/1950, energy +463.0 bank 2646/2650, units 66
 12.09  [Playtest] finished armtide team 0 at 12.09 min
 12.38  [Playtest] finished armtide team 0 at 12.38 min
 12.41  [Playtest] finished armtide team 0 at 12.41 min
 12.49  [Playtest] finished armmex team 0 at 12.49 min
 12.70  [Playtest] finished armtide team 0 at 12.70 min
 12.72  [Playtest] finished armtide team 0 at 12.72 min
 12.83  [Playtest] finished armmex team 0 at 12.83 min
 12.84  [Playtest] finished armtide team 0 at 12.84 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +39.9 bank 1925/2050, energy +560.0 bank 2983/3000, units 75
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(891) at (5345, 797) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(28578) at (7824, 1502) walks to (7847, 1502), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(22737) at (9041, 11417) walks to (9370, 11502), 139 from the cormex site (9504, 11536)
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
  0.10  RESERVE: zone 1 at (9040, 11424) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: corsy at (9040, 11424) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (9040, 11136) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (9112, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9112, 11656) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (9048, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9048, 11656) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (8984, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (8984, 11656) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (9112, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9112, 11592) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (9048, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9048, 11592) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (8984, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (8984, 11592) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (9040, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.11  EXP: idle: legcom(28578) on legmex at (7839, 1502), site (7984, 1504), target yes, fails 2 (arrived at the approach point)
  0.12  RESERVE: zone 10 at (8224, 1504) facing 0, 12x12 cells: 144 of 144 held
  0.12  RESERVE: legadvshipyard at (8224, 1504) facing 0 (id 8)
  0.12  RESERVE: corridor 11 at (8224, 1840) facing 0, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (8264, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8264, 1288) facing 0 (id 9)
  0.12  RESERVE: zone 13 at (8328, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8328, 1288) facing 0 (id 10)
  0.12  RESERVE: zone 14 at (8392, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8392, 1288) facing 0 (id 11)
  0.12  RESERVE: zone 15 at (8264, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8264, 1352) facing 0 (id 12)
  0.12  RESERVE: zone 16 at (8328, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8328, 1352) facing 0 (id 13)
  0.12  RESERVE: zone 17 at (8392, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8392, 1352) facing 0 (id 14)
  0.12  RESERVE: zone 18 at (8320, 1312) facing 0, 12x8 cells: 42 of 96 held
  0.12  RESERVE: zone 10 at (8640, 11424) facing 2, 12x12 cells: 144 of 144 held
  0.12  RESERVE: corasy at (8640, 11424) facing 2 (id 8)
  0.12  RESERVE: corridor 11 at (8640, 11088) facing 2, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (8808, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8808, 11656) facing 2 (id 9)
  0.12  RESERVE: zone 13 at (8744, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8744, 11656) facing 2 (id 10)
  0.12  RESERVE: zone 14 at (8680, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8680, 11656) facing 2 (id 11)
  0.12  RESERVE: zone 15 at (8808, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8808, 11592) facing 2 (id 12)
  0.12  RESERVE: zone 16 at (8744, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8744, 11592) facing 2 (id 13)
  0.12  RESERVE: zone 17 at (8680, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8680, 11592) facing 2 (id 14)
  0.12  RESERVE: zone 18 at (8736, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.14  RESERVE: zone 19 at (8240, 11424) facing 2, 12x12 cells: 144 of 144 held
  0.14  RESERVE: corasy at (8240, 11424) facing 2 (id 15)
  0.14  RESERVE: corridor 20 at (8240, 11088) facing 2, 18x30 cells: 516 of 540 held
  0.14  RESERVE: zone 21 at (8392, 11688) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8392, 11688) facing 2 (id 16)
  0.14  RESERVE: zone 22 at (8328, 11688) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8328, 11688) facing 2 (id 17)
  0.14  RESERVE: zone 23 at (8264, 11688) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8264, 11688) facing 2 (id 18)
  0.14  RESERVE: zone 24 at (8392, 11624) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8392, 11624) facing 2 (id 19)
  0.14  RESERVE: zone 25 at (8328, 11624) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8328, 11624) facing 2 (id 20)
  0.14  RESERVE: zone 26 at (8264, 11624) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8264, 11624) facing 2 (id 21)
  0.14  RESERVE: zone 27 at (8329, 11653) facing 2, 13x9 cells: 63 of 117 held
  0.17  RESERVE: zone 1 at (4000, 2096) facing 0, 6x6 cells: 36 of 36 held
  0.17  RESERVE: armsy at (4000, 2096) facing 0 (id 1)
  0.17  RESERVE: corridor 2 at (4000, 2384) facing 0, 12x30 cells: 338 of 360 held
  0.17  RESERVE: zone 3 at (3944, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (3944, 1880) facing 0 (id 2)
  0.17  RESERVE: zone 4 at (4008, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4008, 1880) facing 0 (id 3)
  0.17  RESERVE: zone 5 at (4072, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4072, 1880) facing 0 (id 4)
  0.17  RESERVE: zone 6 at (3944, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (3944, 1944) facing 0 (id 5)
  0.17  RESERVE: zone 7 at (4008, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4008, 1944) facing 0 (id 6)
  0.17  RESERVE: zone 8 at (4072, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4072, 1944) facing 0 (id 7)
  0.17  RESERVE: zone 9 at (4000, 1904) facing 0, 12x8 cells: 42 of 96 held
  0.17  RESERVE: zone 1 at (6608, 10640) facing 3, 6x6 cells: 36 of 36 held
  0.17  RESERVE: legsy at (6608, 10640) facing 3 (id 1)
  0.17  RESERVE: corridor 2 at (6320, 10640) facing 3, 30x12 cells: 360 of 360 held
  0.17  RESERVE: zone 3 at (7000, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (7000, 10648) facing 2 (id 2)
  0.17  RESERVE: zone 4 at (6936, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6936, 10648) facing 2 (id 3)
  0.17  RESERVE: zone 3 released
  0.17  RESERVE: zone 4 released
  0.17  RESERVE: zone 5 at (6984, 10680) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6984, 10680) facing 2 (id 4)
  0.17  RESERVE: zone 5 released
  0.17  RESERVE: zone 6 at (6968, 10712) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6968, 10712) facing 2 (id 5)
  0.17  RESERVE: zone 6 released
  0.17  RESERVE: zone 7 at (6936, 10728) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6936, 10728) facing 2 (id 6)
  0.17  RESERVE: zone 8 at (6872, 10728) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6872, 10728) facing 2 (id 7)
  0.17  RESERVE: zone 9 at (6808, 10728) facing 2, 3x3 cells: 9 of 9 held
```
