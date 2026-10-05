# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.0 min (frame 45000); wall 208 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:36:11
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-release\supreme\20261004T183611Z-75bb96b3\runs\20261004T183942Z-d2a97b86\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:41.093901][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:55.492524][f=0002585] [SeaWatch] finished frame=2585 id=26482 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 2.4 min | `[t=00:00:59.486958][f=0004380] [SeaWatch] egress id=6328 yard=26482 seconds=21.5 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-release\supreme\20261004T183611Z-75bb96b3\runs\20261004T183942Z-d2a97b86\screen_2026-10-04_18-37-25-743.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-release\supreme\20261004T183611Z-75bb96b3\runs\20261004T183942Z-d2a97b86\screen_2026-10-04_18-37-49-606.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-release\supreme\20261004T183611Z-75bb96b3\runs\20261004T183942Z-d2a97b86\screen_2026-10-04_18-38-51-889.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 6887 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [Playtest] finished armwin team 0 at 0.60 min
  0.71  [Playtest] finished armwin team 0 at 0.71 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +86.2 bank 1001/1001, units 6
  1.44  [Playtest] finished armsy team 0 at 1.44 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 609/1200, energy +93.7 bank 32/1151, units 9
  2.98  [Playtest] finished armtide team 0 at 2.98 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 181/1200, energy +91.8 bank 18/1251, units 12
  3.47  [Playtest] finished armmex team 0 at 3.47 min
  3.65  [Playtest] finished armtide team 0 at 3.65 min
  3.92  [Playtest] finished armmex team 0 at 3.92 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 1/1300, energy +111.1 bank 772/1301, units 18
  4.24  [Playtest] finished armmex team 0 at 4.24 min
  4.58  [Playtest] finished armmex team 0 at 4.58 min
  4.84  [Playtest] finished armtide team 0 at 4.84 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.0 bank 0/1400, energy +134.1 bank 960/1351, units 22
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.02  [Playtest] finished armmex team 0 at 5.02 min
  5.36  [Playtest] finished armtide team 0 at 5.36 min
  5.42  [Playtest] finished armmex team 0 at 5.42 min
  5.72  [Playtest] finished armmex team 0 at 5.72 min
  5.83  [Playtest] finished armrad team 0 at 5.83 min
  5.90  [Playtest] finished armtide team 0 at 5.90 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +21.9 bank 282/1550, energy +212.9 bank 1486/1501, units 30
  6.12  [Playtest] finished armmex team 0 at 6.13 min
  6.23  [Playtest] finished armtide team 0 at 6.23 min
  6.23  [Playtest] finished armtide team 0 at 6.23 min
  6.30  [Playtest] finished armllt team 0 at 6.30 min
  6.75  [Playtest] finished armmex team 0 at 6.75 min
  6.75  [Playtest] finished armfmkr team 0 at 6.75 min
  6.92  [Playtest] finished armllt team 0 at 6.92 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +27.5 bank 868/1650, energy +250.3 bank 1457/1651, units 40
  7.05  [Playtest] finished armfmkr team 0 at 7.05 min
  7.53  [Playtest] finished armllt team 0 at 7.53 min
  7.62  [Playtest] finished armtide team 0 at 7.62 min
  7.94  [Playtest] finished armtide team 0 at 7.94 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +27.8 bank 1642/1650, energy +285.0 bank 1377/1801, units 49
  8.12  [Playtest] finished armtide team 0 at 8.12 min
  8.30  [Playtest] finished armtide team 0 at 8.30 min
  8.37  [Playtest] finished armnanotcplat team 0 at 8.37 min
  8.40  [Playtest] finished armtide team 0 at 8.40 min
  8.42  [Playtest] finished armmex team 0 at 8.42 min
  8.54  [Playtest] finished armtide team 0 at 8.53 min
  8.67  [Playtest] finished armtide team 0 at 8.67 min
  8.84  [Playtest] finished armtide team 0 at 8.84 min
  8.95  [Playtest] finished armmex team 0 at 8.95 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +33.1 bank 1316/1750, energy +402.5 bank 1750/2101, units 57
  9.05  [Playtest] finished armtide team 0 at 9.06 min
  9.27  [Playtest] finished armtide team 0 at 9.27 min
  9.41  [Playtest] finished armtide team 0 at 9.41 min
  9.56  [Playtest] finished armtide team 0 at 9.56 min
  9.67  [Playtest] finished armmex team 0 at 9.67 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +35.4 bank 1202/1800, energy +519.2 bank 2234/2301, units 66
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.15  [Playtest] finished armnanotcplat team 0 at 10.15 min
 10.47  [Playtest] finished armmex team 0 at 10.48 min
 10.83  [Playtest] finished armfmkr team 0 at 10.83 min
 10.97  [Playtest] finished armtl team 0 at 10.97 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +36.8 bank 1506/1850, energy +510.2 bank 1814/2351, units 76
 11.33  [Playtest] finished armtide team 0 at 11.33 min
 11.64  [Playtest] finished armfmkr team 0 at 11.64 min
 11.70  [Playtest] finished armtl team 0 at 11.70 min
 11.79  [Playtest] finished armfmkr team 0 at 11.79 min
 11.86  [Playtest] finished armmex team 0 at 11.86 min
 11.99  [Playtest] finished armtide team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +42.3 bank 1625/1900, energy +517.8 bank 2092/2451, units 88
 12.28  [Playtest] finished armfmkr team 0 at 12.28 min
 12.29  [Playtest] finished armfrad team 0 at 12.29 min
 12.43  [Playtest] finished armtl team 0 at 12.43 min
 12.60  [Playtest] finished armmstor team 0 at 12.60 min
 12.63  [Playtest] finished armmex team 0 at 12.64 min
 12.73  [Playtest] finished armtide team 0 at 12.73 min
 12.85  [Playtest] finished armestor team 0 at 12.85 min
 12.98  [Playtest] finished armtl team 0 at 12.98 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +40.3 bank 2037/4950, energy +581.8 bank 5313/8501, units 97
 13.17  [Playtest] finished armtl team 0 at 13.17 min
 13.27  [Playtest] finished armllt team 0 at 13.27 min
 13.40  [Playtest] finished armrad team 0 at 13.40 min
 13.98  [Playtest] finished armtide team 0 at 13.98 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +46.3 bank 4086/4950, energy +570.3 bank 6642/8551, units 103
 14.22  [Playtest] finished armfrad team 0 at 14.22 min
 14.32  [Playtest] finished armmex team 0 at 14.32 min
 14.53  [Playtest] finished armmex team 0 at 14.52 min
 14.64  [Playtest] finished armtide team 0 at 14.64 min
 14.73  [Playtest] finished armllt team 0 at 14.73 min
 14.78  [Playtest] finished armnanotcplat team 0 at 14.78 min
 14.88  [Playtest] finished armtl team 0 at 14.88 min
 14.91  [Playtest] finished armrad team 0 at 14.91 min
 14.97  [Playtest] finished armtide team 0 at 14.97 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +44.9 bank 3873/5050, energy +642.9 bank 6450/8651, units 115
 15.57  [Playtest] finished armfmkr team 0 at 15.57 min
 15.63  [Playtest] finished armnanotcplat team 0 at 15.63 min
 15.78  [Playtest] finished armfrad team 0 at 15.77 min
 15.97  [Playtest] finished armrad team 0 at 15.97 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +50.4 bank 3916/5050, energy +652.2 bank 6324/8651, units 125
 16.27  [Playtest] finished armllt team 0 at 16.27 min
 16.43  [Playtest] finished armtide team 0 at 16.43 min
 16.62  [Playtest] finished armtide team 0 at 16.62 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +46.8 bank 3853/5050, energy +663.2 bank 6983/8751, units 130
 17.36  [Playtest] finished armllt team 0 at 17.36 min
 17.59  [Playtest] finished armtide team 0 at 17.59 min
 17.87  [Playtest] finished armtide team 0 at 17.87 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +47.1 bank 4119/5050, energy +728.8 bank 6720/8851, units 138
 18.43  [Playtest] finished armtide team 0 at 18.43 min
 18.59  [Playtest] finished armtide team 0 at 18.59 min
 18.73  [Playtest] finished armtide team 0 at 18.73 min
 18.81  [Playtest] finished armtide team 0 at 18.81 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +44.9 bank 4219/5050, energy +796.3 bank 6662/9051, units 152
 19.00  [Playtest] finished armnanotcplat team 0 at 19.00 min
 19.08  [Playtest] finished armtide team 0 at 19.08 min
 19.13  [Playtest] finished armnanotcplat team 0 at 19.13 min
 19.24  [Playtest] finished armnanotcplat team 0 at 19.24 min
 19.41  [Playtest] finished armtide team 0 at 19.41 min
 19.66  [Playtest] finished armfmkr team 0 at 19.66 min
 19.74  [Playtest] finished armtide team 0 at 19.74 min
 19.92  [Playtest] finished armnanotcplat team 0 at 19.92 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +44.9 bank 3737/5050, energy +861.6 bank 5257/9201, units 169
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.10  [Playtest] finished armtide team 0 at 20.10 min
 20.46  [Playtest] finished armtide team 0 at 20.46 min
 20.75  [Playtest] finished armfmkr team 0 at 20.75 min
 20.79  [Playtest] finished armfmkr team 0 at 20.79 min
 20.80  [Playtest] finished armtide team 0 at 20.80 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +51.5 bank 4391/5050, energy +935.6 bank 7593/9351, units 185
 21.12  [Playtest] finished armtide team 0 at 21.13 min
 21.47  [Playtest] finished armtide team 0 at 21.47 min
 21.80  [Playtest] finished armtide team 0 at 21.80 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +54.9 bank 4271/5050, energy +970.5 bank 7246/9501, units 201
 22.14  [Playtest] finished armtide team 0 at 22.14 min
 22.18  [Playtest] finished armfmkr team 0 at 22.18 min
 22.27  [Playtest] finished armfmkr team 0 at 22.27 min
 22.46  [Playtest] finished armtide team 0 at 22.46 min
 22.81  [Playtest] finished armtide team 0 at 22.81 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +44.9 bank 4186/5050, energy +1020.0 bank 6437/9651, units 218
 23.01  [Playtest] finished armnanotcplat team 0 at 23.01 min
 23.13  [Playtest] finished armtide team 0 at 23.13 min
 23.45  [Playtest] finished armtide team 0 at 23.45 min
 23.79  [Playtest] finished armtide team 0 at 23.79 min
 23.83  [Playtest] finished armnanotcplat team 0 at 23.83 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +56.7 bank 4252/5050, energy +1108.4 bank 7715/9801, units 236
 24.96  [Playtest] finished armfmkr team 0 at 24.96 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +44.9 bank 4410/5050, energy +1127.1 bank 7873/9801, units 249
```

## Native lines (all AIs, first 120)

```
  1.45  RESERVE: zone 1 at (5800, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5800, 10904) facing 2 (id 1)
  1.45  RESERVE: zone 1 released
  1.45  RESERVE: corridor 2 at (5840, 10448) facing 2, 12x30 cells: 210 of 360 held
  1.45  RESERVE: zone 3 at (5968, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: zone 3 released
  1.45  RESERVE: zone 4 at (6096, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6096, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  1.45  RESERVE: zone 4 released
  1.45  RESERVE: zone 5 at (6224, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6224, 11424) facing 2: 10 of 16 slots (group 3, held, zone)
  1.45  RESERVE: zone 5 released
  1.45  RESERVE: zone 1 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 1)
  1.45  RESERVE: zone 2 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 2)
  1.45  RESERVE: zone 1 released
  1.45  RESERVE: zone 2 released
  1.45  RESERVE: zone 3 at (6408, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1512) facing 0 (id 3)
  1.45  RESERVE: zone 4 at (6456, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6456, 1512) facing 0 (id 4)
  1.45  RESERVE: zone 5 at (6504, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6504, 1512) facing 0 (id 5)
  1.45  RESERVE: zone 3 released
  1.45  RESERVE: zone 4 released
  1.45  RESERVE: zone 5 released
  1.45  RESERVE: zone 6 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 6)
  1.45  RESERVE: zone 7 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 7)
  1.45  RESERVE: zone 8 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 8)
  1.45  RESERVE: zone 9 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 9)
  1.45  RESERVE: zone 10 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 10)
  1.45  RESERVE: zone 11 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 11)
  1.45  RESERVE: zone 6 released
  1.45  RESERVE: zone 7 released
  1.45  RESERVE: zone 8 released
  1.45  RESERVE: zone 9 released
  1.45  RESERVE: zone 10 released
  1.45  RESERVE: zone 11 released
  1.45  RESERVE: zone 12 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 12)
  1.45  RESERVE: zone 13 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 13)
  1.45  RESERVE: zone 14 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 14)
  1.45  RESERVE: zone 15 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 15)
  1.45  RESERVE: zone 16 at (6456, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6456, 1448) facing 0 (id 16)
  1.45  RESERVE: zone 17 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 17)
  1.45  RESERVE: zone 18 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 18)
  1.45  RESERVE: zone 19 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 19)
  1.45  RESERVE: zone 20 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 20)
  1.45  RESERVE: zone 21 at (6456, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6456, 1496) facing 0 (id 21)
  1.45  RESERVE: zone 22 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 22)
  1.45  RESERVE: zone 23 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 23)
  1.45  RESERVE: zone 12 released
  1.45  RESERVE: zone 13 released
  1.45  RESERVE: zone 14 released
  1.45  RESERVE: zone 15 released
  1.45  RESERVE: zone 16 released
  1.45  RESERVE: zone 17 released
  1.45  RESERVE: zone 18 released
  1.45  RESERVE: zone 19 released
  1.45  RESERVE: zone 20 released
  1.45  RESERVE: zone 21 released
  1.45  RESERVE: zone 22 released
  1.45  RESERVE: zone 23 released
  1.45  RESERVE: zone 24 at (6216, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1400) facing 0 (id 24)
  1.45  RESERVE: zone 25 at (6264, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1400) facing 0 (id 25)
  1.45  RESERVE: zone 26 at (6312, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1400) facing 0 (id 26)
  1.45  RESERVE: zone 27 at (6360, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1400) facing 0 (id 27)
  1.45  RESERVE: zone 28 at (6408, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1400) facing 0 (id 28)
  1.45  RESERVE: zone 29 at (6216, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1448) facing 0 (id 29)
  1.45  RESERVE: zone 30 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 30)
  1.45  RESERVE: zone 31 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 31)
  1.45  RESERVE: zone 32 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 32)
  1.45  RESERVE: zone 33 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 33)
  1.45  RESERVE: zone 34 at (6216, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1496) facing 0 (id 34)
  1.45  RESERVE: zone 35 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 35)
  1.45  RESERVE: zone 36 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 36)
  1.45  RESERVE: zone 37 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 37)
  1.45  RESERVE: zone 38 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 38)
  1.45  RESERVE: zone 39 at (6216, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1544) facing 0 (id 39)
  1.45  RESERVE: zone 40 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 40)
  1.45  RESERVE: zone 41 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 41)
  1.45  RESERVE: zone 24 released
  1.45  RESERVE: zone 25 released
  1.45  RESERVE: zone 26 released
```
