# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.2 min (frame 54353); wall 167 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:21:44
- Map: Erebos Lakes v1.0; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\erebos\20261004T112143Z-e60b5e05\runs\20261004T112434Z-cf40e493\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.407594][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.9 min | `[t=00:00:42.408651][f=0001552] [SeaWatch] finished frame=1552 id=22737 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 4.4 min | `[t=00:00:56.627033][f=0007950] [SeaWatch] egress id=24679 yard=22737 seconds=7.2 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\erebos\20261004T112143Z-e60b5e05\runs\20261004T112434Z-cf40e493\screen_2026-10-04_11-22-48-229.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\erebos\20261004T112143Z-e60b5e05\runs\20261004T112434Z-cf40e493\screen_2026-10-04_11-23-09-217.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\erebos\20261004T112143Z-e60b5e05\runs\20261004T112434Z-cf40e493\screen_2026-10-04_11-23-50-388.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\erebos\20261004T112143Z-e60b5e05\runs\20261004T112434Z-cf40e493\screen_2026-10-04_11-24-27-974.png

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
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 19480 at 2032,6192
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2076|6349|0|3|1|2032|6192
  0.35  [Playtest] finished armmex team 0 at 0.35 min
  0.40  [SEA][Layout] berth sea.berth.1 armasy at=2688,5344 facing=0
  0.62  [SEA][Layout] berth sea.berth.2 armasy at=2944,5552 facing=0
  0.86  [Playtest] finished armsy team 0 at 0.86 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 689/1200, energy +30.0 bank 1/1100, units 6
  1.27  [Playtest] finished armmex team 0 at 1.27 min
  1.78  [Playtest] finished armmex team 0 at 1.78 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1025/1300, energy +30.0 bank 76/1100, units 7
  2.45  [Playtest] finished armmex team 0 at 2.45 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +12.0 bank 1347/1350, energy +30.0 bank 46/1100, units 8
  3.44  [Playtest] finished armmex team 0 at 3.44 min
  3.94  [Playtest] finished armtide team 0 at 3.94 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.0 bank 1400/1400, energy +50.0 bank 108/1150, units 10
  4.13  [Playtest] finished armtide team 0 at 4.13 min
  4.32  [Playtest] finished armtide team 0 at 4.32 min
  4.76  [Playtest] finished armmex team 0 at 4.76 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +16.0 bank 1446/1450, energy +104.0 bank 63/1350, units 17
  5.00  [Playtest] target team 0 at (2076, 6352) from its start position
  5.00  [Playtest] camera requested (2076,6352) height=2200
  5.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2076, 6352)
  5.02  [Playtest] finished armmex team 0 at 5.02 min
  5.34  [Playtest] finished armtide team 0 at 5.34 min
  5.42  [Playtest] finished armmex team 0 at 5.42 min
  5.72  [Playtest] finished armtide team 0 at 5.72 min
  5.98  [Playtest] finished armllt team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.0 bank 1546/1550, energy +144.0 bank 192/1450, units 23
  6.51  [Playtest] finished armtl team 0 at 6.51 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +14.0 bank 1493/1550, energy +144.0 bank 1/1450, units 26
  7.01  [Playtest] finished armllt team 0 at 7.01 min
  7.13  [Playtest] finished armfrad team 0 at 7.13 min
  7.40  [Playtest] finished armrad team 0 at 7.40 min
  7.50  [Playtest] finished armtl team 0 at 7.50 min
  7.99  [Playtest] finished armtide team 0 at 7.99 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +20.0 bank 1547/1550, energy +144.0 bank 1492/1500, units 29
  8.31  [Playtest] finished armllt team 0 at 8.31 min
  8.33  [Playtest] finished armtide team 0 at 8.33 min
  8.47  [Playtest] finished armtide team 0 at 8.47 min
  8.63  [Playtest] finished armtide team 0 at 8.63 min
  8.84  [Playtest] finished armmex team 0 at 8.84 min
  8.94  [Playtest] finished armtide team 0 at 8.94 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +22.0 bank 1542/1600, energy +251.0 bank 1728/1750, units 41
  9.09  [Playtest] finished armmex team 0 at 9.09 min
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.24  [Playtest] finished armtide team 0 at 9.24 min
  9.29  [Playtest] finished armmex team 0 at 9.29 min
  9.67  [Playtest] finished armmex team 0 at 9.67 min
  9.67  [Playtest] finished armtide team 0 at 9.67 min
  9.98  [Playtest] finished armllt team 0 at 9.98 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +28.0 bank 1747/1750, energy +311.0 bank 1881/1900, units 45
 10.00  [Playtest] camera requested (2076,6352) height=2200
 10.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (2076, 6352)
 10.57  [Playtest] finished armmex team 0 at 10.57 min
 10.62  [Playtest] finished armnanotcplat team 0 at 10.61 min
 10.84  [Playtest] finished armrad team 0 at 10.84 min
 10.89  [Playtest] finished armtide team 0 at 10.89 min
 10.97  [Playtest] finished armmex team 0 at 10.97 min
 10.99  [Playtest] finished armmex team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +26.0 bank 1447/1750, energy +218.0 bank 720/1700, units 45
 11.05  [Playtest] finished armtide team 0 at 11.05 min
 11.13  [Playtest] finished armtide team 0 at 11.13 min
 11.20  [Playtest] finished armllt team 0 at 11.20 min
 11.44  [Playtest] finished armtide team 0 at 11.44 min
 11.53  [Playtest] finished armllt team 0 at 11.53 min
 11.53  [Playtest] finished armtl team 0 at 11.53 min
 11.56  [Playtest] finished armtide team 0 at 11.56 min
 11.72  [Playtest] finished armtide team 0 at 11.72 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +28.0 bank 1256/1750, energy +318.0 bank 1933/1950, units 52
 12.08  [Playtest] finished armtl team 0 at 12.08 min
 12.18  [Playtest] finished armmex team 0 at 12.18 min
 12.28  [Playtest] finished armtide team 0 at 12.28 min
 12.59  [Playtest] finished armtide team 0 at 12.59 min
 12.98  [Playtest] finished armtide team 0 at 12.98 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +30.0 bank 1445/1800, energy +411.4 bank 2149/2150, units 58
 13.13  [Playtest] finished armmex team 0 at 13.13 min
 13.28  [Playtest] finished armtide team 0 at 13.28 min
 13.42  [Playtest] finished armtide team 0 at 13.42 min
 13.72  [Playtest] finished armfrad team 0 at 13.72 min
 13.80  [Playtest] finished armmex team 0 at 13.80 min
 13.93  [Playtest] finished armmex team 0 at 13.93 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +36.0 bank 1638/1950, energy +432.0 bank 2270/2300, units 67
 14.01  [Playtest] finished armllt team 0 at 14.01 min
 14.94  [Playtest] finished armmex team 0 at 14.94 min
 14.96  [Playtest] finished armmex team 0 at 14.95 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +40.0 bank 2002/2050, energy +432.0 bank 2252/2300, units 76
 15.01  [Playtest] finished armmex team 0 at 15.01 min
 15.21  [Playtest] finished armfrad team 0 at 15.21 min
 15.23  [Playtest] finished armmex team 0 at 15.23 min
 15.31  [Playtest] finished armmex team 0 at 15.31 min
 15.38  [Playtest] finished armllt team 0 at 15.38 min
 15.42  [Playtest] finished armmex team 0 at 15.42 min
 15.85  [Playtest] finished armtl team 0 at 15.85 min
 15.94  [Playtest] finished armfrad team 0 at 15.94 min
 15.96  [Playtest] finished armtl team 0 at 15.96 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +48.0 bank 2247/2250, energy +432.0 bank 2241/2300, units 86
 16.46  [Playtest] finished armtl team 0 at 16.46 min
 16.58  [Playtest] finished armtl team 0 at 16.58 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +48.0 bank 2245/2250, energy +432.0 bank 2218/2300, units 91
 17.02  [Playtest] finished armmex team 0 at 17.02 min
 17.77  [Playtest] finished armfrad team 0 at 17.77 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +50.0 bank 2296/2300, energy +432.0 bank 2233/2300, units 94
 18.44  [Playtest] finished armfrad team 0 at 18.44 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +50.0 bank 2296/2300, energy +432.0 bank 2233/2300, units 99
 20.00  [Playtest] eco team 0 at 20.0 min: metal +50.0 bank 2298/2300, energy +432.0 bank 2256/2300, units 101
 20.00  [Playtest] camera requested (2076,6352) height=2200
 20.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (2076, 6352)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +50.0 bank 2294/2300, energy +432.0 bank 2226/2300, units 104
 22.00  [Playtest] eco team 0 at 22.0 min: metal +50.0 bank 2300/2300, energy +432.0 bank 2286/2300, units 106
 23.00  [Playtest] eco team 0 at 23.0 min: metal +50.0 bank 2294/2300, energy +432.0 bank 2226/2300, units 109
 24.00  [Playtest] eco team 0 at 24.0 min: metal +50.0 bank 2297/2300, energy +432.0 bank 2251/2300, units 112
 25.00  [Playtest] eco team 0 at 25.0 min: metal +50.0 bank 2294/2300, energy +432.0 bank 2226/2300, units 115
 25.32  [Playtest] finished armrad team 0 at 25.32 min
 25.62  [Playtest] finished armtl team 0 at 25.62 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +50.0 bank 2293/2300, energy +432.0 bank 2218/2300, units 120
 26.64  [Playtest] finished armtl team 0 at 26.65 min
 26.76  [Playtest] finished armtl team 0 at 26.76 min
 26.92  [Playtest] finished armrad team 0 at 26.92 min
 26.96  [Playtest] finished armfrad team 0 at 26.96 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +50.0 bank 2292/2300, energy +432.0 bank 1946/2300, units 127
 27.09  [Playtest] finished armtl team 0 at 27.09 min
 27.98  [Playtest] finished armrad team 0 at 27.98 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +50.0 bank 2293/2300, energy +432.0 bank 2218/2300, units 132
 28.82  [Playtest] finished armmex team 0 at 28.83 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +52.0 bank 2343/2350, energy +432.0 bank 2204/2300, units 135
 29.00  [Playtest] camera requested (2076,6352) height=2200
 29.02  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (2076, 6352)
 29.14  [Playtest] finished armfrad team 0 at 29.14 min
 29.17  [Playtest] finished armmex team 0 at 29.17 min
 29.41  [Playtest] finished armmex team 0 at 29.41 min
 29.64  [Playtest] finished armtl team 0 at 29.65 min
 29.66  [Playtest] finished armmex team 0 at 29.66 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +58.0 bank 2494/2500, energy +432.0 bank 2167/2300, units 144
 30.02  [Playtest] finished armmex team 0 at 30.02 min
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(28578) at (2076, 6349) walks to (2069, 6323), 136 from the armmex site (2032, 6192)
  0.08  EXP: approach: armcom(891) at (8106, 3878) walks to (8076, 3864), 136 from the armmex site (7952, 3808)
  0.10  EXP: idle: armcom(891) on armmex at (8086, 3866), site (7952, 3808), target yes, fails 2 (arrived at the approach point)
  0.11  EXP: idle: armcom(28578) on armmex at (2063, 6332), site (2032, 6192), target yes, fails 2 (arrived at the approach point)
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
  0.20  EXP: approach: armcom(28578) at (2063, 6332) walks to (2028, 6383), 136 from the armmex site (1952, 6496)
  0.21  EXP: approach: armcom(891) at (8085, 3866) walks to (8132, 3935), 136 from the armmex site (8208, 4048)
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
  0.36  EXP: approach: armcom(28578) at (2055, 6363) walks to (2453, 6194), 168 from the armsy site (2608, 6128)
  0.37  RESERVE: served armsy at (2608, 6128) facing 1 (id 1, 0 of this def still held)
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
  0.38  EXP: approach: armcom(891) at (8107, 3916) walks to (7756, 4238), 169 from the armsy site (7632, 4352)
  0.38  RESERVE: served armsy at (7632, 4352) facing 3 (id 1, 0 of this def still held)
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
  0.88  EXP: approach: armcom(28578) at (2428, 6208) walks to (2360, 6316), 136 from the armmex site (2288, 6432)
  0.90  EXP: approach: armcom(891) at (7780, 4221) walks to (7551, 4511), 136 from the armmex site (7440, 4432)
  1.28  EXP: approach: armcom(28578) at (2373, 6299) walks to (2550, 6677), 136 from the armmex site (2608, 6800)
  1.48  EXP: approach: armcom(891) at (7595, 4478) walks to (8195, 3843), 136 from the armmex site (8288, 3744)
  1.80  EXP: approach: armcom(28578) at (2540, 6660) walks to (1874, 6871), 136 from the armmex site (1744, 6912)
  2.33  EXP: approach: armcom(891) at (8183, 3869) walks to (8428, 3446), 136 from the armmex site (8496, 3328)
  2.47  EXP: approach: armcom(28578) at (1897, 6859) walks to (2758, 5937), 136 from the armmex site (2800, 5808)
  2.88  EXP: approach: armcom(891) at (8426, 3483) walks to (7768, 3447), 136 from the armmex site (7632, 3440)
  3.50  RESERVE: zone 24 at (7976, 4296) facing 3, 3x3 cells: 9 of 9 held
  3.50  RESERVE: armwin at (7976, 4296) facing 3 (id 20)
```
