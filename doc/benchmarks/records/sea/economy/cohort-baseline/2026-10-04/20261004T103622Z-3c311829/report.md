# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54114); wall 185 s
- DLL: build-theatres\d189-baseline\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T07:33:13
- Map: Erebos Lakes v1.0; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T103313Z-3aee47da\runs\20261004T103622Z-3c311829\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:36.642087][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.9 min | `[t=00:00:49.850521][f=0001582] [SeaWatch] finished frame=1582 id=22737 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 5.5 min | `[t=00:01:11.323451][f=0009930] [SeaWatch] egress id=1973 yard=22737 seconds=10.5 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T103313Z-3aee47da\runs\20261004T103622Z-3c311829\screen_2026-10-04_10-34-26-273.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T103313Z-3aee47da\runs\20261004T103622Z-3c311829\screen_2026-10-04_10-34-49-361.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T103313Z-3aee47da\runs\20261004T103622Z-3c311829\screen_2026-10-04_10-35-37-605.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T103313Z-3aee47da\runs\20261004T103622Z-3c311829\screen_2026-10-04_10-36-15-335.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 684/1200, energy +30.0 bank 0/1100, units 6
  1.32  [Playtest] finished armmex team 0 at 1.32 min
  1.83  [Playtest] finished armmex team 0 at 1.83 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1009/1300, energy +30.0 bank 108/1100, units 7
  2.46  [Playtest] finished armmex team 0 at 2.46 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +12.0 bank 1347/1350, energy +30.0 bank 58/1100, units 8
  3.45  [Playtest] finished armmex team 0 at 3.45 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 1400/1400, energy +30.0 bank 0/1100, units 10
  4.13  [Playtest] finished armmex team 0 at 4.13 min
  4.46  [Playtest] finished armtide team 0 at 4.46 min
  4.61  [Playtest] finished armtide team 0 at 4.61 min
  4.77  [Playtest] finished armtide team 0 at 4.77 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +16.0 bank 1448/1450, energy +97.0 bank 63/1300, units 14
  5.00  [Playtest] target team 0 at (2076, 6352) from its start position
  5.00  [Playtest] camera requested (2076,6352) height=2200
  5.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2076, 6352)
  5.36  [Playtest] finished armllt team 0 at 5.36 min
  5.78  [Playtest] finished armllt team 0 at 5.78 min
  5.88  [Playtest] finished armtide team 0 at 5.88 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +16.0 bank 1437/1450, energy +124.0 bank 304/1400, units 21
  6.05  [Playtest] finished armwin team 0 at 6.05 min
  6.29  [Playtest] finished armtl team 0 at 6.29 min
  6.31  [Playtest] finished armtide team 0 at 6.31 min
  6.63  [Playtest] finished armtide team 0 at 6.63 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +16.0 bank 1445/1450, energy +184.9 bank 1541/1550, units 27
  7.22  [Playtest] finished armtide team 0 at 7.22 min
  7.32  [Playtest] finished armtide team 0 at 7.32 min
  7.35  [Playtest] finished armtide team 0 at 7.35 min
  7.40  [Playtest] finished armmex team 0 at 7.40 min
  7.52  [Playtest] finished armfrad team 0 at 7.52 min
  7.53  [Playtest] finished armtide team 0 at 7.53 min
  7.64  [Playtest] finished armtide team 0 at 7.64 min
  7.94  [Playtest] finished armtide team 0 at 7.94 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +18.0 bank 1146/1500, energy +313.8 bank 1885/1900, units 39
  8.19  [Playtest] finished armtide team 0 at 8.19 min
  8.27  [Playtest] finished armmex team 0 at 8.27 min
  8.34  [Playtest] finished armtide team 0 at 8.34 min
  8.42  [Playtest] finished armllt team 0 at 8.42 min
  8.45  [Playtest] finished armtl team 0 at 8.45 min
  8.50  [Playtest] finished armtide team 0 at 8.50 min
  8.55  [Playtest] finished armrad team 0 at 8.55 min
  8.55  [Playtest] finished armnanotcplat team 0 at 8.55 min
  8.66  [Playtest] finished armtide team 0 at 8.66 min
  8.74  [Playtest] finished armmex team 0 at 8.74 min
  8.80  [Playtest] finished armtide team 0 at 8.80 min
  8.97  [Playtest] finished armtide team 0 at 8.97 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +24.2 bank 251/1600, energy +422.2 bank 2169/2200, units 49
  9.15  [Playtest] finished armfrad team 0 at 9.15 min
  9.42  [Playtest] finished armmex team 0 at 9.42 min
  9.64  [Playtest] finished armmex team 0 at 9.64 min
  9.85  [Playtest] finished armllt team 0 at 9.85 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +28.2 bank 411/1700, energy +433.6 bank 2170/2200, units 53
 10.00  [Playtest] camera requested (2076,6352) height=2200
 10.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (2076, 6352)
 10.78  [Playtest] finished armmex team 0 at 10.78 min
 10.78  [Playtest] finished armmex team 0 at 10.78 min
 10.94  [Playtest] finished armllt team 0 at 10.94 min
 10.96  [Playtest] finished armmex team 0 at 10.96 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +34.2 bank 816/1850, energy +433.9 bank 2189/2200, units 60
 11.29  [Playtest] finished armmex team 0 at 11.29 min
 11.33  [Playtest] finished armtl team 0 at 11.33 min
 11.55  [Playtest] finished armmex team 0 at 11.55 min
 11.78  [Playtest] finished armmex team 0 at 11.77 min
 11.94  [Playtest] finished armllt team 0 at 11.94 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +38.2 bank 1668/1950, energy +443.3 bank 2242/2300, units 66
 12.22  [Playtest] finished armmex team 0 at 12.22 min
 12.40  [Playtest] finished armmex team 0 at 12.40 min
 12.78  [Playtest] finished armmex team 0 at 12.78 min
 12.87  [Playtest] finished armmex team 0 at 12.87 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +42.2 bank 1949/1950, energy +278.8 bank 1717/1750, units 53
 13.02  [SEA][Layout] berth sea.berth.3 armsy at=2848,6352 facing=1
 13.19  [Playtest] finished armtl team 0 at 13.19 min
 13.29  [Playtest] finished armtl team 0 at 13.29 min
 13.30  [Playtest] finished armfrad team 0 at 13.30 min
 13.86  [Playtest] finished armmex team 0 at 13.86 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +42.2 bank 1950/1950, energy +74.0 bank 929/1200, units 40
 15.00  [Playtest] eco team 0 at 15.0 min: metal +42.2 bank 1950/1950, energy +66.8 bank 1133/1150, units 38
 15.16  [Playtest] finished armmex team 0 at 15.16 min
 15.48  [Playtest] finished armmex team 0 at 15.48 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +22.2 bank 2050/2050, energy +58.9 bank 0/1100, units 39
 16.05  [Playtest] finished armmex team 0 at 16.05 min
 16.88  [Playtest] finished armmex team 0 at 16.88 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +39.2 bank 2150/2150, energy +52.3 bank 0/1050, units 38
 18.00  [Playtest] eco team 0 at 18.0 min: metal +34.2 bank 2050/2050, energy +44.2 bank 1/1050, units 34
 19.00  [Playtest] eco team 0 at 19.0 min: metal +31.2 bank 2050/2050, energy +41.0 bank 0/1000, units 33
 20.00  [Playtest] eco team 0 at 20.0 min: metal +34.2 bank 1950/1950, energy +45.4 bank 0/1000, units 30
 20.00  [Playtest] camera requested (2076,6352) height=2200
 20.02  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (2076, 6352)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +32.2 bank 1950/1950, energy +42.3 bank 1/1000, units 28
 22.00  [Playtest] eco team 0 at 22.0 min: metal +31.2 bank 1950/1950, energy +39.7 bank 0/1000, units 27
 23.00  [Playtest] eco team 0 at 23.0 min: metal +24.2 bank 1900/1900, energy +30.0 bank 0/1000, units 25
 24.00  [Playtest] eco team 0 at 24.0 min: metal +24.2 bank 1900/1900, energy +30.0 bank 0/1000, units 25
 25.00  [Playtest] eco team 0 at 25.0 min: metal +24.2 bank 1850/1850, energy +30.0 bank 0/1000, units 24
 26.00  [Playtest] eco team 0 at 26.0 min: metal +24.2 bank 1850/1850, energy +30.0 bank 0/1000, units 24
 27.00  [Playtest] eco team 0 at 27.0 min: metal +24.2 bank 1850/1850, energy +30.0 bank 0/1000, units 24
 28.00  [Playtest] eco team 0 at 28.0 min: metal +24.2 bank 1850/1850, energy +30.0 bank 0/1000, units 24
 29.00  [Playtest] eco team 0 at 29.0 min: metal +24.2 bank 1850/1850, energy +30.0 bank 0/1000, units 24
 29.00  [Playtest] camera requested (2076,6352) height=2200
 29.02  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (2076, 6352)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +24.2 bank 1850/1850, energy +30.0 bank 0/1000, units 24
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(28578) at (2076, 6349) walks to (2069, 6323), 136 from the armmex site (2032, 6192)
  0.08  EXP: approach: armcom(891) at (8104, 3871) walks to (8078, 3860), 136 from the armmex site (7952, 3808)
  0.12  EXP: idle: armcom(28578) on armmex at (2063, 6332), site (2032, 6192), target yes, fails 2 (arrived at the approach point)
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
  0.21  EXP: approach: armcom(891) at (8099, 3863) walks to (8139, 3931), 136 from the armmex site (8208, 4048)
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
  0.38  EXP: approach: armcom(891) at (8130, 3915) walks to (7759, 4241), 168 from the armsy site (7632, 4352)
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
  0.89  EXP: approach: armcom(28578) at (2430, 6207) walks to (2361, 6317), 136 from the armmex site (2288, 6432)
  0.91  EXP: approach: armcom(891) at (7784, 4218) walks to (7551, 4511), 136 from the armmex site (7440, 4432)
  1.33  EXP: approach: armcom(28578) at (2374, 6297) walks to (2551, 6677), 136 from the armmex site (2608, 6800)
  1.44  EXP: approach: armcom(891) at (7597, 4479) walks to (8195, 3843), 136 from the armmex site (8288, 3744)
  1.84  EXP: approach: armcom(28578) at (2540, 6660) walks to (1874, 6871), 136 from the armmex site (1744, 6912)
  2.29  EXP: approach: armcom(891) at (8185, 3862) walks to (8428, 3446), 136 from the armmex site (8496, 3328)
  2.47  EXP: approach: armcom(28578) at (1906, 6856) walks to (2758, 5937), 136 from the armmex site (2800, 5808)
  2.84  EXP: approach: armcom(891) at (8433, 3475) walks to (7768, 3446), 136 from the armmex site (7632, 3440)
```
