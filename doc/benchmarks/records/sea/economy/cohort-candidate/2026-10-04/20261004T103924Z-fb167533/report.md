# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.2 min (frame 54297); wall 177 s
- DLL: build-theatres\d189-build-5\SkirmishAI.dll (1b875078bc2aa763); AI BARbTest/test; staged 2026-10-04T07:36:23
- Map: Erebos Lakes v1.0; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T103622Z-6cba3cd7\runs\20261004T103924Z-fb167533\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:38.009570][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.9 min | `[t=00:00:53.249527][f=0001582] [SeaWatch] finished frame=1582 id=22737 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 5.2 min | `[t=00:01:12.454568][f=0009360] [SeaWatch] egress id=18500 yard=22737 seconds=4.7 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T103622Z-6cba3cd7\runs\20261004T103924Z-fb167533\screen_2026-10-04_10-37-40-003.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T103622Z-6cba3cd7\runs\20261004T103924Z-fb167533\screen_2026-10-04_10-38-01-146.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T103622Z-6cba3cd7\runs\20261004T103924Z-fb167533\screen_2026-10-04_10-38-42-153.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T103622Z-6cba3cd7\runs\20261004T103924Z-fb167533\screen_2026-10-04_10-39-19-138.png

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
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 19480 at 2032,6192
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2076|6349|0|3|1|2032|6192
  0.37  [Playtest] finished armmex team 0 at 0.37 min
  0.40  [SEA][Layout] berth sea.berth.1 armasy at=2688,5344 facing=0
  0.62  [SEA][Layout] berth sea.berth.2 armasy at=2944,5552 facing=0
  0.88  [Playtest] finished armsy team 0 at 0.88 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 684/1200, energy +30.0 bank 1/1100, units 6
  1.29  [Playtest] finished armmex team 0 at 1.29 min
  1.81  [Playtest] finished armmex team 0 at 1.81 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1019/1300, energy +30.0 bank 106/1100, units 7
  2.45  [Playtest] finished armmex team 0 at 2.45 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +12.0 bank 1350/1350, energy +30.0 bank 121/1100, units 8
  3.44  [Playtest] finished armmex team 0 at 3.44 min
  3.94  [Playtest] finished armtide team 0 at 3.94 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.0 bank 1400/1400, energy +50.0 bank 122/1150, units 10
  4.12  [Playtest] finished armtide team 0 at 4.12 min
  4.31  [Playtest] finished armtide team 0 at 4.31 min
  4.64  [Playtest] finished armmex team 0 at 4.64 min
  4.95  [Playtest] finished armtide team 0 at 4.95 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +16.0 bank 1430/1450, energy +124.0 bank 262/1400, units 17
  5.00  [Playtest] target team 0 at (2076, 6352) from its start position
  5.00  [Playtest] camera requested (2076,6352) height=2200
  5.00  [Playtest] camera captured name=ta position=(2076,6352) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2076, 6352)
  5.28  [Playtest] finished armtide team 0 at 5.28 min
  5.58  [Playtest] finished armmex team 0 at 5.57 min
  5.74  [Playtest] finished armtide team 0 at 5.74 min
  5.80  [Playtest] finished armmex team 0 at 5.80 min
  5.93  [Playtest] finished armtl team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.0 bank 1511/1550, energy +171.0 bank 778/1550, units 23
  6.28  [Playtest] finished armllt team 0 at 6.28 min
  6.36  [Playtest] finished armrad team 0 at 6.36 min
  6.38  [Playtest] finished armtide team 0 at 6.38 min
  6.50  [Playtest] finished armmex team 0 at 6.50 min
  6.56  [Playtest] finished armtide team 0 at 6.56 min
  6.69  [Playtest] finished armtide team 0 at 6.69 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.0 bank 1218/1600, energy +231.0 bank 1354/1700, units 33
  7.00  [Playtest] finished armtide team 0 at 7.00 min
  7.01  [Playtest] finished armtide team 0 at 7.01 min
  7.01  [Playtest] finished armtl team 0 at 7.01 min
  7.19  [Playtest] finished armtide team 0 at 7.19 min
  7.48  [Playtest] finished armmex team 0 at 7.48 min
  7.61  [Playtest] finished armtide team 0 at 7.61 min
  7.63  [Playtest] finished armllt team 0 at 7.63 min
  7.77  [Playtest] finished armrad team 0 at 7.77 min
  7.85  [Playtest] finished armtide team 0 at 7.85 min
  7.93  [Playtest] finished armmex team 0 at 7.93 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.2 bank 1339/1700, energy +331.0 bank 1925/1950, units 44
  8.02  [Playtest] finished armtide team 0 at 8.02 min
  8.43  [Playtest] finished armnanotcplat team 0 at 8.43 min
  8.52  [Playtest] finished armtide team 0 at 8.52 min
  8.56  [Playtest] finished armnanotcplat team 0 at 8.56 min
  8.67  [Playtest] finished armtide team 0 at 8.67 min
  8.78  [Playtest] finished armtide team 0 at 8.78 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +28.2 bank 1160/1700, energy +418.0 bank 2200/2200, units 49
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.2 bank 755/1650, energy +358.0 bank 2050/2050, units 48
 10.00  [Playtest] camera requested (2076,6352) height=2200
 10.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (2076, 6352)
 10.25  [Playtest] finished armtide team 0 at 10.25 min
 10.45  [Playtest] finished armtide team 0 at 10.45 min
 10.73  [Playtest] finished armmex team 0 at 10.73 min
 10.78  [Playtest] finished armmex team 0 at 10.78 min
 10.82  [Playtest] finished armtide team 0 at 10.82 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +29.0 bank 18/1650, energy +345.0 bank 1530/2000, units 52
 11.07  [Playtest] finished armmex team 0 at 11.07 min
 11.10  [Playtest] finished armmex team 0 at 11.10 min
 11.30  [Playtest] finished armtl team 0 at 11.30 min
 11.48  [Playtest] finished armtl team 0 at 11.48 min
 11.51  [Playtest] finished armtide team 0 at 11.51 min
 11.60  [Playtest] finished armmex team 0 at 11.60 min
 11.74  [Playtest] finished armtide team 0 at 11.74 min
 11.81  [Playtest] finished armtl team 0 at 11.81 min
 11.91  [Playtest] finished armtide team 0 at 11.91 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +30.2 bank 16/1750, energy +365.0 bank 2062/2100, units 61
 12.06  [Playtest] finished armmex team 0 at 12.06 min
 12.25  [Playtest] finished armmex team 0 at 12.25 min
 12.36  [Playtest] finished armfrad team 0 at 12.36 min
 12.41  [Playtest] finished armllt team 0 at 12.41 min
 12.66  [Playtest] finished armtide team 0 at 12.66 min
 12.68  [Playtest] finished armfrad team 0 at 12.68 min
 12.72  [Playtest] finished armmex team 0 at 12.73 min
 12.84  [Playtest] finished armtl team 0 at 12.84 min
 12.85  [Playtest] finished armtide team 0 at 12.85 min
 12.97  [Playtest] finished armmex team 0 at 12.98 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +37.2 bank 19/1950, energy +412.0 bank 1137/2300, units 76
 13.09  [Playtest] finished armmex team 0 at 13.09 min
 13.10  [Playtest] finished armmex team 0 at 13.10 min
 13.18  [Playtest] finished armmex team 0 at 13.18 min
 13.20  [Playtest] finished armtide team 0 at 13.20 min
 13.33  [Playtest] finished armllt team 0 at 13.33 min
 13.38  [Playtest] finished armmex team 0 at 13.38 min
 13.67  [Playtest] finished armtl team 0 at 13.67 min
 13.79  [Playtest] finished armmex team 0 at 13.79 min
 13.94  [Playtest] finished armfrad team 0 at 13.94 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +48.2 bank 283/2200, energy +439.0 bank 2139/2350, units 86
 14.26  [Playtest] finished armmex team 0 at 14.26 min
 14.69  [Playtest] finished armmex team 0 at 14.69 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +52.2 bank 1288/2300, energy +439.0 bank 2302/2350, units 93
 15.13  [Playtest] finished armmex team 0 at 15.13 min
 15.19  [Playtest] finished armmex team 0 at 15.19 min
 15.46  [Playtest] finished armfrad team 0 at 15.46 min
 15.72  [Playtest] finished armmex team 0 at 15.73 min
 15.97  [Playtest] finished armtl team 0 at 15.97 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +58.2 bank 2000/2450, energy +439.0 bank 1650/2350, units 103
 16.05  [Playtest] finished armmex team 0 at 16.05 min
 16.16  [Playtest] finished armmex team 0 at 16.16 min
 16.24  [Playtest] finished armtl team 0 at 16.24 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +62.2 bank 2545/2550, energy +439.0 bank 1928/2350, units 109
 17.17  [Playtest] finished armwin team 0 at 17.17 min
 17.31  [Playtest] finished armtl team 0 at 17.31 min
 17.87  [Playtest] finished armmex team 0 at 17.87 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +64.2 bank 2597/2600, energy +455.0 bank 1734/2350, units 115
 18.53  [Playtest] finished armllt team 0 at 18.53 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +64.2 bank 2596/2600, energy +447.9 bank 2284/2350, units 120
 19.16  [Playtest] finished armmex team 0 at 19.16 min
 19.33  [Playtest] finished armllt team 0 at 19.33 min
 19.96  [Playtest] finished armwin team 0 at 19.96 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +66.2 bank 2645/2650, energy +470.9 bank 2251/2351, units 128
 20.00  [Playtest] camera requested (2076,6352) height=2200
 20.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (2076, 6352)
 20.87  [Playtest] finished armmex team 0 at 20.87 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +68.2 bank 2696/2700, energy +471.0 bank 1773/2351, units 132
 21.58  [Playtest] finished armmex team 0 at 21.58 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +70.2 bank 2747/2750, energy +469.7 bank 2284/2351, units 138
 22.40  [Playtest] finished armmex team 0 at 22.40 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +72.2 bank 2797/2800, energy +460.9 bank 2226/2351, units 144
 23.10  [Playtest] finished armmex team 0 at 23.10 min
 23.73  [Playtest] finished armmex team 0 at 23.73 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +76.2 bank 2896/2900, energy +470.7 bank 2113/2351, units 149
 24.16  [Playtest] finished armcom team 0 at 24.16 min
 24.45  [Playtest] finished armmex team 0 at 24.45 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +80.2 bank 3450/3450, energy +475.9 bank 369/2851, units 153
 25.26  [Playtest] finished armwin team 0 at 25.26 min
 25.36  [Playtest] finished armwin team 0 at 25.36 min
 25.80  [Playtest] finished armsolar team 0 at 25.80 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +80.2 bank 3449/3450, energy +522.1 bank 236/2902, units 158
 26.77  [Playtest] finished armmex team 0 at 26.77 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +82.3 bank 3500/3500, energy +529.4 bank 131/2902, units 160
 27.52  [Playtest] finished armwin team 0 at 27.52 min
 27.70  [Playtest] finished armwin team 0 at 27.70 min
 27.98  [Playtest] finished armwin team 0 at 27.98 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +82.3 bank 3496/3500, energy +562.8 bank 882/2903, units 165
 28.71  [Playtest] finished armmex team 0 at 28.72 min
 28.75  [Playtest] finished armtl team 0 at 28.75 min
 28.80  [Playtest] finished armrad team 0 at 28.80 min
 28.97  [Playtest] finished armmex team 0 at 28.97 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +86.3 bank 3598/3600, energy +597.2 bank 2864/2903, units 175
 29.00  [Playtest] camera requested (2076,6352) height=2200
 29.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (2076, 6352)
 29.01  [Playtest] finished armllt team 0 at 29.01 min
 29.57  [Playtest] finished armtl team 0 at 29.57 min
 29.61  [Playtest] finished armmex team 0 at 29.61 min
 29.72  [Playtest] finished armfrad team 0 at 29.72 min
 29.82  [Playtest] finished armrad team 0 at 29.82 min
 29.86  [Playtest] finished armmex team 0 at 29.86 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +90.3 bank 3696/3700, energy +600.7 bank 2761/2903, units 186
 30.02  [Playtest] finished armllt team 0 at 30.01 min
 30.12  [Playtest] finished armrad team 0 at 30.12 min
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(28578) at (2076, 6349) walks to (2069, 6323), 136 from the armmex site (2032, 6192)
  0.08  EXP: approach: armcom(891) at (8103, 3869) walks to (8078, 3859), 136 from the armmex site (7952, 3808)
  0.12  EXP: idle: armcom(28578) on armmex at (2063, 6333), site (2032, 6192), target yes, fails 2 (arrived at the approach point)
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
  0.21  EXP: approach: armcom(891) at (8100, 3863) walks to (8139, 3930), 136 from the armmex site (8208, 4048)
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
  0.22  EXP: approach: armcom(28578) at (2063, 6332) walks to (2028, 6383), 136 from the armmex site (1952, 6496)
  0.37  RESERVE: zone 10 at (7392, 4560) facing 0, 12x12 cells: 144 of 144 held
  0.37  RESERVE: armasy at (7392, 4560) facing 0 (id 8)
  0.37  RESERVE: corridor 11 at (7392, 4896) facing 0, 18x30 cells: 524 of 540 held
  0.37  RESERVE: zone 12 at (7304, 4232) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7304, 4232) facing 3 (id 9)
  0.37  RESERVE: zone 12 released
  0.37  RESERVE: zone 13 at (7320, 4200) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7320, 4200) facing 3 (id 10)
  0.37  RESERVE: zone 13 released
  0.37  RESERVE: zone 14 at (7352, 4184) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7352, 4184) facing 3 (id 11)
  0.37  RESERVE: zone 14 released
  0.37  RESERVE: zone 15 at (7400, 4184) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7400, 4184) facing 3 (id 12)
  0.37  RESERVE: zone 15 released
  0.37  RESERVE: zone 16 at (7432, 4184) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7432, 4184) facing 3 (id 13)
  0.37  RESERVE: zone 16 released
  0.37  RESERVE: zone 17 at (7464, 4200) facing 3, 3x3 cells: 9 of 9 held
  0.37  RESERVE: armnanotcplat at (7464, 4200) facing 3 (id 14)
  0.37  RESERVE: zone 17 released
  0.38  EXP: approach: armcom(891) at (8130, 3915) walks to (7759, 4241), 169 from the armsy site (7632, 4352)
  0.38  RESERVE: served armsy at (7632, 4352) facing 3 (id 1, 0 of this def still held)
  0.38  EXP: approach: armcom(28578) at (2044, 6359) walks to (2452, 6192), 169 from the armsy site (2608, 6128)
  0.38  RESERVE: served armsy at (2608, 6128) facing 1 (id 1, 0 of this def still held)
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
  0.42  RESERVE: zone 18 at (7192, 4472) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7192, 4472) facing 3 (id 15)
  0.42  RESERVE: zone 19 at (7192, 4536) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7192, 4536) facing 3 (id 16)
  0.42  RESERVE: zone 20 at (7192, 4600) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7192, 4600) facing 3 (id 17)
  0.42  RESERVE: zone 21 at (7128, 4472) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7128, 4472) facing 3 (id 18)
  0.42  RESERVE: zone 22 at (7128, 4536) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7128, 4536) facing 3 (id 19)
  0.42  RESERVE: zone 23 at (7128, 4600) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armnanotcplat at (7128, 4600) facing 3 (id 20)
  0.42  RESERVE: zone 24 at (7156, 4540) facing 3, 9x13 cells: 55 of 117 held
  0.62  RESERVE: zone 25 at (2944, 5552) facing 0, 12x12 cells: 144 of 144 held
  0.62  RESERVE: armasy at (2944, 5552) facing 0 (id 21)
  0.62  RESERVE: corridor 26 at (2944, 5888) facing 0, 18x30 cells: 396 of 540 held
  0.89  EXP: approach: armcom(28578) at (2431, 6206) walks to (2361, 6317), 136 from the armmex site (2288, 6432)
  0.90  EXP: approach: armcom(891) at (7781, 4221) walks to (7550, 4511), 136 from the armmex site (7440, 4432)
  1.31  EXP: approach: armcom(28578) at (2378, 6293) walks to (2552, 6676), 136 from the armmex site (2608, 6800)
  1.47  EXP: approach: armcom(891) at (7598, 4478) walks to (8195, 3843), 136 from the armmex site (8288, 3744)
  1.82  EXP: approach: armcom(28578) at (2540, 6659) walks to (1874, 6871), 136 from the armmex site (1744, 6912)
  2.33  EXP: approach: armcom(891) at (8185, 3865) walks to (8428, 3446), 136 from the armmex site (8496, 3328)
  2.47  EXP: approach: armcom(28578) at (1902, 6857) walks to (2758, 5937), 136 from the armmex site (2800, 5808)
  2.89  EXP: approach: armcom(891) at (8428, 3481) walks to (7768, 3447), 136 from the armmex site (7632, 3440)
```
