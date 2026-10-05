# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54000); wall 181 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:45:17
- Map: Erebos Lakes v1.0; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T044516Z-d9d8d664\runs\20261004T044821Z-cc434d12\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:41.481928][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.9 min | `[t=00:00:55.198268][f=0001582] [SeaWatch] finished frame=1582 id=28651 def=armsy builder=17180` |
| expect `first-ship-exit` | seen at 5.6 min | `[t=00:01:15.525536][f=0010080] [SeaWatch] egress id=20598 yard=28651 seconds=21.5 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T044516Z-d9d8d664\runs\20261004T044821Z-cc434d12\screen_2026-10-04_04-46-34-109.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T044516Z-d9d8d664\runs\20261004T044821Z-cc434d12\screen_2026-10-04_04-46-56-317.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T044516Z-d9d8d664\runs\20261004T044821Z-cc434d12\screen_2026-10-04_04-47-38-143.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T044516Z-d9d8d664\runs\20261004T044821Z-cc434d12\screen_2026-10-04_04-48-15-401.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2076, 6352) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (8128, 3879) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2076, 6352) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (8128, 3879) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [SEA][Layout] berth sea.berth.0 armsy at=2608,6128 facing=1
  0.22  [Playtest] finished armmex team 0 at 0.22 min
  0.22  [Team][Roster] first mex 6927 at 2032,6192
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2076|6349|0|3|1|2032|6192
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.40  [SEA][Layout] berth sea.berth.1 armasy at=2688,5344 facing=0
  0.62  [SEA][Layout] berth sea.berth.2 armasy at=2944,5552 facing=0
  0.88  [Playtest] finished armsy team 0 at 0.88 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 686/1200, energy +30.0 bank 0/1100, units 6
  1.30  [Playtest] finished armmex team 0 at 1.30 min
  1.82  [Playtest] finished armmex team 0 at 1.82 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1020/1300, energy +30.0 bank 117/1100, units 7
  2.49  [Playtest] finished armmex team 0 at 2.49 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +12.0 bank 1350/1350, energy +30.0 bank 68/1100, units 8
  3.44  [Playtest] finished armmex team 0 at 3.44 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +7.0 bank 1400/1400, energy +30.0 bank 0/1100, units 10
  4.13  [Playtest] finished armmex team 0 at 4.13 min
  4.44  [Playtest] finished armtide team 0 at 4.44 min
  4.60  [Playtest] finished armtide team 0 at 4.60 min
  4.75  [Playtest] finished armtide team 0 at 4.75 min
  4.89  [Playtest] finished armtide team 0 at 4.89 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +16.0 bank 1438/1450, energy +117.0 bank 112/1350, units 16
  5.00  [Playtest] target team 0 at (2076, 6352) from its start position
  5.00  [Playtest] camera requested (2076,6352) height=2200
  5.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2076, 6352)
  5.07  [Playtest] finished armtide team 0 at 5.07 min
  5.26  [Playtest] finished armtide team 0 at 5.26 min
  5.88  [Playtest] finished armmex team 0 at 5.88 min
  5.92  [Playtest] finished armtide team 0 at 5.92 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +18.0 bank 1262/1500, energy +198.0 bank 253/1650, units 25
  6.17  [Playtest] finished armtide team 0 at 6.17 min
  6.21  [Playtest] finished armtl team 0 at 6.21 min
  6.29  [Playtest] finished armtide team 0 at 6.29 min
  6.47  [Playtest] finished armtide team 0 at 6.47 min
  6.49  [Playtest] finished armmex team 0 at 6.49 min
  6.56  [Playtest] finished armtide team 0 at 6.56 min
  6.60  [Playtest] finished armtide team 0 at 6.60 min
  6.91  [Playtest] finished armtide team 0 at 6.91 min
  6.95  [Playtest] finished armllt team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +20.0 bank 707/1550, energy +332.0 bank 1113/2050, units 38
  7.04  [Playtest] finished armtide team 0 at 7.05 min
  7.06  [Playtest] finished armtide team 0 at 7.06 min
  7.08  [Playtest] finished armmex team 0 at 7.07 min
  7.10  [Playtest] finished armnanotcplat team 0 at 7.10 min
  7.24  [Playtest] finished armtide team 0 at 7.24 min
  7.29  [Playtest] finished armtide team 0 at 7.29 min
  7.34  [Playtest] finished armrad team 0 at 7.34 min
  7.34  [Playtest] finished armtl team 0 at 7.34 min
  7.51  [Playtest] finished armtide team 0 at 7.51 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +22.0 bank 302/1600, energy +432.0 bank 2275/2300, units 45
  8.14  [Playtest] finished armmex team 0 at 8.14 min
  8.30  [Playtest] finished armllt team 0 at 8.30 min
  8.41  [Playtest] finished armrad team 0 at 8.41 min
  8.60  [Playtest] finished armmex team 0 at 8.60 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +28.2 bank 227/1700, energy +432.0 bank 2272/2300, units 52
  9.97  [Playtest] finished armmex team 0 at 9.97 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.2 bank 303/1650, energy +432.0 bank 2247/2300, units 54
 10.00  [Playtest] camera requested (2076,6352) height=2200
 10.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (2076, 6352)
 10.18  [Playtest] finished armmex team 0 at 10.18 min
 10.39  [Playtest] finished armmex team 0 at 10.39 min
 10.55  [Playtest] finished armllt team 0 at 10.55 min
 10.65  [Playtest] finished armrad team 0 at 10.65 min
 10.79  [Playtest] finished armmex team 0 at 10.79 min
 10.79  [Playtest] finished armmex team 0 at 10.79 min
 10.87  [SEA][Layout] replan unused berth sea.berth.0
 10.90  [SEA][Layout] berth sea.berth.0 armsy at=2704,6096 facing=2
 11.00  [Playtest] eco team 0 at 11.0 min: metal +32.2 bank 823/1700, energy +264.0 bank 1625/1650, units 47
 11.05  [SEA][Layout] berth sea.berth.3 armsy at=2848,6352 facing=2
 11.30  [SEA][Layout] berth sea.berth.4 armsy at=3136,6352 facing=1
 11.30  [Playtest] finished armmex team 0 at 11.30 min
 11.33  [Playtest] finished armtl team 0 at 11.33 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +34.2 bank 1750/1750, energy +164.0 bank 1388/1400, units 41
 12.88  [Playtest] finished armtl team 0 at 12.88 min
 12.95  [Playtest] finished armmex team 0 at 12.95 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +36.2 bank 1799/1800, energy +164.0 bank 1361/1400, units 44
 13.07  [Playtest] finished armmex team 0 at 13.07 min
 13.33  [Playtest] finished armmex team 0 at 13.33 min
 13.66  [Playtest] finished armmex team 0 at 13.66 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +40.2 bank 1900/1900, energy +164.0 bank 1383/1400, units 41
 14.35  [Playtest] finished armmex team 0 at 14.35 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +42.2 bank 1949/1950, energy +164.0 bank 1378/1400, units 43
 15.08  [Playtest] finished armtide team 0 at 15.08 min
 15.29  [Playtest] finished armmex team 0 at 15.29 min
 15.38  [Playtest] finished armtide team 0 at 15.38 min
 15.52  [Playtest] finished armmex team 0 at 15.52 min
 15.69  [Playtest] finished armtide team 0 at 15.69 min
 15.70  [Playtest] finished armmex team 0 at 15.70 min
 16.00  [Playtest] finished armtide team 0 at 16.00 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +48.2 bank 2100/2100, energy +224.0 bank 1566/1600, units 49
 16.19  [Playtest] finished armmex team 0 at 16.19 min
 16.30  [Playtest] finished armtide team 0 at 16.30 min
 16.48  [Playtest] finished armmex team 0 at 16.48 min
 16.61  [Playtest] finished armtide team 0 at 16.61 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +52.2 bank 2199/2200, energy +284.0 bank 1695/1700, units 55
 17.07  [Playtest] finished armmex team 0 at 17.07 min
 17.10  [Playtest] finished armtide team 0 at 17.10 min
 17.41  [Playtest] finished armtide team 0 at 17.41 min
 17.41  [Playtest] finished armmex team 0 at 17.41 min
 17.72  [Playtest] finished armtide team 0 at 17.72 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +56.2 bank 2299/2300, energy +344.0 bank 1848/1850, units 59
 18.04  [Playtest] finished armtide team 0 at 18.04 min
 18.35  [Playtest] finished armtide team 0 at 18.35 min
 18.65  [Playtest] finished armtide team 0 at 18.65 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +56.2 bank 2300/2300, energy +404.0 bank 2000/2000, units 61
 20.00  [Playtest] eco team 0 at 20.0 min: metal +56.2 bank 2299/2300, energy +404.0 bank 1994/2000, units 62
 20.00  [Playtest] camera requested (2076,6352) height=2200
 20.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (2076, 6352)
 20.25  [Playtest] finished armfmkr team 0 at 20.25 min
 20.62  [Playtest] finished armfmkr team 0 at 20.62 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +58.2 bank 2299/2300, energy +404.0 bank 1924/2000, units 64
 21.02  [Playtest] finished armfmkr team 0 at 21.02 min
 21.49  [Playtest] finished armfmkr team 0 at 21.49 min
 21.82  [Playtest] finished armmex team 0 at 21.83 min
 21.86  [Playtest] finished armfmkr team 0 at 21.86 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +61.7 bank 2349/2350, energy +404.0 bank 1619/2000, units 68
 22.05  [Playtest] finished armmex team 0 at 22.05 min
 22.47  [Playtest] finished armmex team 0 at 22.47 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +65.6 bank 2449/2450, energy +404.0 bank 1616/2000, units 70
 23.02  [Playtest] finished armmex team 0 at 23.02 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +68.7 bank 2500/2500, energy +404.0 bank 1657/2000, units 70
 24.67  [Playtest] finished armwin team 0 at 24.67 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +67.8 bank 2499/2500, energy +419.5 bank 1623/2000, units 72
 25.05  [Playtest] finished armmex team 0 at 25.05 min
 25.42  [Playtest] finished armwin team 0 at 25.42 min
 25.72  [Playtest] finished armwin team 0 at 25.72 min
 25.96  [Playtest] finished armwin team 0 at 25.96 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +70.8 bank 2549/2550, energy +465.7 bank 1644/2002, units 77
 26.06  [Playtest] finished armwin team 0 at 26.06 min
 26.18  [Playtest] finished armfmkr team 0 at 26.18 min
 26.63  [Playtest] finished armwin team 0 at 26.63 min
 26.83  [Playtest] finished armwin team 0 at 26.83 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +71.8 bank 2550/2550, energy +477.9 bank 1692/2003, units 79
 27.09  [Playtest] finished armwin team 0 at 27.09 min
 27.22  [Playtest] finished armwin team 0 at 27.22 min
 27.38  [Playtest] finished armwin team 0 at 27.38 min
 27.49  [Playtest] finished armwin team 0 at 27.49 min
 27.60  [Playtest] finished armwin team 0 at 27.60 min
 27.95  [Playtest] finished armwin team 0 at 27.95 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +72.2 bank 2549/2550, energy +574.9 bank 1869/2006, units 86
 28.06  [Playtest] finished armwin team 0 at 28.06 min
 28.16  [Playtest] finished armwin team 0 at 28.16 min
 28.27  [Playtest] finished armwin team 0 at 28.27 min
 28.38  [Playtest] finished armwin team 0 at 28.38 min
 28.49  [Playtest] finished armwin team 0 at 28.49 min
 28.65  [Playtest] finished armwin team 0 at 28.65 min
 28.78  [Playtest] finished armwin team 0 at 28.78 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +72.2 bank 2550/2550, energy +706.4 bank 1946/2010, units 92
 29.00  [Playtest] camera requested (2076,6352) height=2200
 29.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (2076, 6352)
 29.21  [Playtest] finished armwin team 0 at 29.21 min
 29.38  [Playtest] finished armwin team 0 at 29.38 min
 29.63  [Playtest] finished armwin team 0 at 29.63 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +72.2 bank 2550/2550, energy +678.0 bank 1939/2011, units 95
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(17180) at (2076, 6349) walks to (2069, 6323), 136 from the armmex site (2032, 6192)
  0.08  EXP: approach: armcom(23234) at (8105, 3875) walks to (8077, 3863), 136 from the armmex site (7952, 3808)
  0.12  EXP: idle: armcom(17180) on armmex at (2063, 6332), site (2032, 6192), target yes, fails 2 (arrived at the approach point)
  0.17  RESERVE: zone 1 at (2608, 6128) facing 1, 6x6 cells: 36 of 36 held
  0.17  RESERVE: armsy at (2608, 6128) facing 1 (id 1)
  0.17  RESERVE: corridor 2 at (2896, 6128) facing 1, 30x12 cells: 360 of 360 held
  0.18  RESERVE: zone 1 at (7632, 4352) facing 3, 6x6 cells: 36 of 36 held
  0.18  RESERVE: armsy at (7632, 4352) facing 3 (id 1)
  0.18  RESERVE: corridor 2 at (7344, 4352) facing 3, 30x12 cells: 348 of 360 held
  0.18  RESERVE: zone 3 at (7784, 4360) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (7784, 4360) facing 3 (id 2)
  0.18  RESERVE: zone 4 at (7784, 4424) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (7784, 4424) facing 3 (id 3)
  0.18  RESERVE: zone 5 at (7784, 4488) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (7784, 4488) facing 3 (id 4)
  0.18  RESERVE: zone 6 at (7720, 4360) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (7720, 4360) facing 3 (id 5)
  0.18  RESERVE: zone 7 at (7720, 4424) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (7720, 4424) facing 3 (id 6)
  0.18  RESERVE: zone 8 at (7720, 4488) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (7720, 4488) facing 3 (id 7)
  0.18  RESERVE: zone 9 at (7756, 4420) facing 3, 9x13 cells: 63 of 117 held
  0.20  RESERVE: zone 3 at (2584, 6200) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (2584, 6200) facing 1 (id 2)
  0.20  RESERVE: zone 3 released
  0.21  EXP: approach: armcom(23234) at (8104, 3872) walks to (8139, 3931), 136 from the armmex site (8208, 4048)
  0.22  RESERVE: zone 4 at (2456, 6008) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (2456, 6008) facing 1 (id 3)
  0.22  RESERVE: zone 5 at (2456, 5944) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (2456, 5944) facing 1 (id 4)
  0.22  RESERVE: zone 6 at (2456, 5880) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (2456, 5880) facing 1 (id 5)
  0.22  RESERVE: zone 7 at (2520, 6008) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (2520, 6008) facing 1 (id 6)
  0.22  RESERVE: zone 8 at (2520, 5944) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (2520, 5944) facing 1 (id 7)
  0.22  RESERVE: zone 9 at (2520, 5880) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (2520, 5880) facing 1 (id 8)
  0.22  RESERVE: zone 10 at (2489, 5951) facing 1, 9x13 cells: 63 of 117 held
  0.23  EXP: approach: armcom(17180) at (2063, 6332) walks to (2028, 6383), 136 from the armmex site (1952, 6496)
  0.37  RESERVE: zone 10 at (7392, 4576) facing 0, 12x12 cells: 144 of 144 held
  0.37  RESERVE: armasy at (7392, 4576) facing 0 (id 8)
  0.37  RESERVE: corridor 11 at (7392, 4912) facing 0, 18x30 cells: 524 of 540 held
  0.37  RESERVE: zone 12 at (7320, 4216) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7320, 4216) facing 3 (id 9)
  0.37  RESERVE: zone 12 released
  0.37  RESERVE: zone 13 at (7352, 4200) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7352, 4200) facing 3 (id 10)
  0.37  RESERVE: zone 13 released
  0.37  RESERVE: zone 14 at (7400, 4200) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7400, 4200) facing 3 (id 11)
  0.37  RESERVE: zone 14 released
  0.37  RESERVE: zone 15 at (7432, 4200) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7432, 4200) facing 3 (id 12)
  0.37  RESERVE: zone 15 released
  0.37  RESERVE: zone 16 at (7464, 4216) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7464, 4216) facing 3 (id 13)
  0.37  RESERVE: zone 16 released
  0.37  EXP: approach: armcom(23234) at (8115, 3908) walks to (7756, 4238), 169 from the armsy site (7632, 4352)
  0.37  RESERVE: served armsy at (7632, 4352) facing 3 (id 1, 0 of this def still held)
  0.39  EXP: approach: armcom(17180) at (2044, 6359) walks to (2452, 6192), 169 from the armsy site (2608, 6128)
  0.39  RESERVE: served armsy at (2608, 6128) facing 1 (id 1, 0 of this def still held)
  0.40  RESERVE: zone 11 at (2688, 5344) facing 0, 12x12 cells: 144 of 144 held
  0.40  RESERVE: armasy at (2688, 5344) facing 0 (id 9)
  0.40  RESERVE: corridor 12 at (2688, 5680) facing 0, 18x30 cells: 503 of 540 held
  0.40  RESERVE: zone 13 at (2824, 5048) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (2824, 5048) facing 1 (id 10)
  0.40  RESERVE: zone 13 released
  0.40  RESERVE: zone 14 at (2872, 5112) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (2872, 5112) facing 1 (id 11)
  0.40  RESERVE: zone 15 at (2872, 5048) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (2872, 5048) facing 1 (id 12)
  0.40  RESERVE: zone 14 released
  0.40  RESERVE: zone 15 released
  0.40  RESERVE: zone 16 at (2984, 5192) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (2984, 5192) facing 1 (id 13)
  0.40  RESERVE: zone 17 at (2984, 5128) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (2984, 5128) facing 1 (id 14)
  0.40  RESERVE: zone 16 released
  0.40  RESERVE: zone 17 released
  0.40  RESERVE: zone 18 at (2952, 5288) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (2952, 5288) facing 1 (id 15)
  0.40  RESERVE: zone 19 at (2952, 5224) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (2952, 5224) facing 1 (id 16)
  0.40  RESERVE: zone 20 at (2952, 5160) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (2952, 5160) facing 1 (id 17)
  0.40  RESERVE: zone 21 at (3016, 5288) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (3016, 5288) facing 1 (id 18)
  0.40  RESERVE: zone 22 at (3016, 5224) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (3016, 5224) facing 1 (id 19)
  0.40  RESERVE: zone 23 at (3016, 5160) facing 1, 3x3 cells: 9 of 9 held
  0.40  RESERVE: armnanotcplat at (3016, 5160) facing 1 (id 20)
  0.40  RESERVE: zone 24 at (2986, 5230) facing 1, 9x13 cells: 63 of 117 held
  0.42  RESERVE: zone 17 at (7192, 4488) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7192, 4488) facing 3 (id 14)
  0.42  RESERVE: zone 18 at (7192, 4552) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7192, 4552) facing 3 (id 15)
  0.42  RESERVE: zone 19 at (7192, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7192, 4616) facing 3 (id 16)
  0.42  RESERVE: zone 20 at (7128, 4488) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7128, 4488) facing 3 (id 17)
  0.42  RESERVE: zone 21 at (7128, 4552) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7128, 4552) facing 3 (id 18)
  0.42  RESERVE: zone 22 at (7128, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7128, 4616) facing 3 (id 19)
  0.42  RESERVE: zone 23 at (7156, 4556) facing 3, 9x13 cells: 63 of 117 held
  0.62  RESERVE: zone 25 at (2944, 5552) facing 0, 12x12 cells: 144 of 144 held
  0.62  RESERVE: armasy at (2944, 5552) facing 0 (id 21)
  0.62  RESERVE: corridor 26 at (2944, 5888) facing 0, 18x30 cells: 396 of 540 held
  0.89  EXP: approach: armcom(17180) at (2422, 6210) walks to (2358, 6315), 136 from the armmex site (2288, 6432)
  0.90  EXP: approach: armcom(23234) at (7774, 4226) walks to (7550, 4512), 136 from the armmex site (7440, 4432)
  1.32  EXP: approach: armcom(17180) at (2372, 6300) walks to (2550, 6677), 136 from the armmex site (2608, 6800)
  1.41  EXP: approach: armcom(23234) at (7598, 4479) walks to (8195, 3843), 136 from the armmex site (8288, 3744)
  1.83  EXP: approach: armcom(17180) at (2535, 6649) walks to (1873, 6869), 136 from the armmex site (1744, 6912)
  2.25  EXP: approach: armcom(23234) at (8185, 3864) walks to (8428, 3446), 136 from the armmex site (8496, 3328)
  2.50  EXP: approach: armcom(17180) at (1902, 6857) walks to (2758, 5937), 136 from the armmex site (2800, 5808)
  2.84  EXP: approach: armcom(23234) at (8429, 3480) walks to (7768, 3447), 136 from the armmex site (7632, 3440)
  3.47  RESERVE: zone 24 at (7976, 4296) facing 3, 3x3 cells: 9 of 9 held
  3.47  RESERVE: armwin at (7976, 4296) facing 3 (id 20)
  3.47  RESERVE: zone 25 at (7976, 4360) facing 3, 3x3 cells: 9 of 9 held
```
