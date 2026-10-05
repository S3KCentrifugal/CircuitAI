# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36010); wall 110 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:44:54
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\supreme\20261005T044454Z-cc5d010a\runs\20261005T044647Z-e71d1268\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.285142][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:43.425090][f=0002570] [SeaWatch] finished frame=2570 id=10240 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 2.0 min | `[t=00:00:45.094873][f=0003570] [SeaWatch] egress id=23873 yard=10240 seconds=17.1 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\supreme\20261005T044454Z-cc5d010a\runs\20261005T044647Z-e71d1268\screen_2026-10-05_04-45-52-854.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\supreme\20261005T044454Z-cc5d010a\runs\20261005T044647Z-e71d1268\screen_2026-10-05_04-46-09-189.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 20.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 20
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +86.4 bank 1001/1001, units 6
  1.43  [Playtest] finished armsy team 0 at 1.43 min
  1.50  [SEA][Layout] berth sea.berth.0 armasy at=6112,10080 facing=2
  1.65  [SEA][Layout] berth sea.berth.1 armasy at=6400,9968 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +3.2 bank 588/1200, energy +94.0 bank 30/1151, units 10
  2.51  [Playtest] finished armtide team 0 at 2.51 min
  2.83  [Playtest] finished armtide team 0 at 2.83 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 0/1200, energy +133.6 bank 454/1301, units 15
  3.54  [Playtest] finished armmex team 0 at 3.54 min
  3.99  [Playtest] finished armmex team 0 at 3.99 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.9 bank 1/1300, energy +143.0 bank 1292/1301, units 17
  4.32  [Playtest] finished armmex team 0 at 4.32 min
  4.67  [Playtest] finished armmex team 0 at 4.67 min
  4.78  [Playtest] finished armtide team 0 at 4.78 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.0 bank 11/1400, energy +140.9 bank 1305/1351, units 22
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.07  [Playtest] finished armmex team 0 at 5.07 min
  5.09  [Playtest] finished armtide team 0 at 5.09 min
  5.27  [Playtest] finished armtide team 0 at 5.27 min
  5.47  [Playtest] finished armmex team 0 at 5.47 min
  5.49  [Playtest] finished armtide team 0 at 5.49 min
  5.70  [Playtest] finished armtide team 0 at 5.70 min
  5.78  [Playtest] finished armmex team 0 at 5.78 min
  5.86  [Playtest] finished armtide team 0 at 5.86 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +21.9 bank 231/1550, energy +249.8 bank 1581/1601, units 32
  6.05  [Playtest] finished armmex team 0 at 6.05 min
  6.22  [Playtest] finished armllt team 0 at 6.22 min
  6.35  [Playtest] finished armwin team 0 at 6.35 min
  6.40  [Playtest] finished armnanotcplat team 0 at 6.40 min
  6.50  [Playtest] finished armrad team 0 at 6.50 min
  6.85  [Playtest] finished armtide team 0 at 6.85 min
  6.85  [Playtest] finished armtide team 0 at 6.85 min
  6.99  [Playtest] finished armmex team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +24.2 bank 22/1650, energy +290.7 bank 1685/1702, units 40
  7.16  [Playtest] finished armllt team 0 at 7.16 min
  7.40  [Playtest] finished armfmkr team 0 at 7.40 min
  7.62  [Playtest] finished armfmkr team 0 at 7.62 min
  7.90  [Playtest] finished armfmkr team 0 at 7.90 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +26.5 bank 22/1650, energy +294.6 bank 594/1702, units 45
  8.21  [Playtest] finished armtide team 0 at 8.21 min
  8.22  [Playtest] finished armmex team 0 at 8.23 min
  8.33  [Playtest] finished armtide team 0 at 8.33 min
  8.60  [Playtest] finished armtide team 0 at 8.60 min
  8.90  [Playtest] finished armtide team 0 at 8.90 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +31.8 bank 69/1700, energy +385.8 bank 1819/1902, units 55
  9.02  [Playtest] finished armtide team 0 at 9.02 min
  9.45  [Playtest] finished armtl team 0 at 9.45 min
  9.59  [Playtest] finished armmex team 0 at 9.59 min
  9.88  [Playtest] finished armtide team 0 at 9.88 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +34.1 bank 277/1750, energy +411.5 bank 1575/2002, units 61
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.26  [Playtest] finished armmex team 0 at 10.26 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +33.4 bank 535/1800, energy +454.5 bank 1384/2002, units 65
 11.06  [Playtest] finished armmex team 0 at 11.06 min
 11.10  [Playtest] finished armnanotcplat team 0 at 11.10 min
 11.37  [Playtest] finished armtide team 0 at 11.37 min
 11.49  [Playtest] finished armtide team 0 at 11.49 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +38.5 bank 367/1850, energy +496.3 bank 1659/2102, units 73
 12.00  [Playtest] finished armmex team 0 at 12.00 min
 12.51  [Playtest] finished armtide team 0 at 12.51 min
 12.82  [Playtest] finished armestor team 0 at 12.82 min
 12.84  [Playtest] finished armtide team 0 at 12.84 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +38.0 bank 21/1900, energy +539.0 bank 3147/8202, units 81
 13.21  [Playtest] finished armtide team 0 at 13.21 min
 13.25  [Playtest] finished armllt team 0 at 13.25 min
 13.37  [Playtest] finished armtide team 0 at 13.37 min
 13.53  [Playtest] finished armtide team 0 at 13.53 min
 13.85  [Playtest] finished armtide team 0 at 13.85 min
 13.86  [Playtest] finished armfmkr team 0 at 13.86 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +42.0 bank 300/1900, energy +598.4 bank 8278/8402, units 89
 14.30  [Playtest] finished armfrad team 0 at 14.30 min
 14.33  [Playtest] finished armtide team 0 at 14.33 min
 14.38  [Playtest] finished armmex team 0 at 14.38 min
 14.60  [Playtest] finished armllt team 0 at 14.60 min
 14.69  [Playtest] finished armtide team 0 at 14.69 min
 14.76  [Playtest] finished armrad team 0 at 14.76 min
 14.84  [Playtest] finished armtl team 0 at 14.84 min
 14.97  [Playtest] finished armtide team 0 at 14.97 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +44.3 bank 145/1950, energy +685.9 bank 7988/8552, units 101
 15.11  [Playtest] finished armtide team 0 at 15.11 min
 15.51  [Playtest] finished armtide team 0 at 15.51 min
 15.64  [Playtest] finished armrad team 0 at 15.64 min
 15.88  [Playtest] finished armtide team 0 at 15.88 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +44.3 bank 480/1950, energy +745.4 bank 8667/8702, units 110
 16.28  [Playtest] finished armrad team 0 at 16.28 min
 16.53  [Playtest] finished armllt team 0 at 16.53 min
 16.69  [Playtest] finished armtide team 0 at 16.69 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +44.3 bank 516/1950, energy +757.4 bank 8683/8752, units 118
 17.34  [Playtest] finished armtl team 0 at 17.34 min
 17.55  [Playtest] finished armtide team 0 at 17.55 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +44.3 bank 377/1950, energy +788.8 bank 8665/8802, units 123
 18.00  [Playtest] finished armllt team 0 at 18.00 min
 18.16  [Playtest] finished armtide team 0 at 18.16 min
 18.49  [Playtest] finished armtide team 0 at 18.49 min
 18.72  [Playtest] finished armtide team 0 at 18.72 min
 18.77  [Playtest] finished armfmkr team 0 at 18.77 min
 18.98  [Playtest] finished armtide team 0 at 18.98 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +45.3 bank 630/1950, energy +795.6 bank 8975/9002, units 133
 19.17  [Playtest] finished armfmkr team 0 at 19.17 min
 19.18  [Playtest] finished armfmkr team 0 at 19.18 min
 19.33  [Playtest] finished armtide team 0 at 19.33 min
 19.64  [Playtest] finished armfmkr team 0 at 19.64 min
 19.67  [Playtest] finished armtide team 0 at 19.67 min
 19.92  [Playtest] finished armfmkr team 0 at 19.92 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +49.3 bank 984/1950, energy +861.8 bank 7382/9102, units 143
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.01  [Playtest] finished armtide team 0 at 20.01 min
```

## Native lines (all AIs, first 120)

```
  1.43  RESERVE: zone 1 at (5800, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (5800, 10904) facing 2 (id 1)
  1.43  RESERVE: zone 1 released
  1.43  RESERVE: corridor 2 at (5840, 10448) facing 2, 12x30 cells: 210 of 360 held
  1.43  RESERVE: zone 3 at (5968, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.43  RESERVE: zone 3 released
  1.43  RESERVE: zone 4 at (6096, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.43  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6096, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  1.43  RESERVE: zone 4 released
  1.43  RESERVE: zone 5 at (6224, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.43  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6224, 11424) facing 2: 10 of 16 slots (group 3, held, zone)
  1.43  RESERVE: zone 5 released
  1.43  RESERVE: zone 1 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 1)
  1.43  RESERVE: zone 2 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 2)
  1.43  RESERVE: zone 1 released
  1.43  RESERVE: zone 2 released
  1.43  RESERVE: zone 3 at (6408, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1512) facing 0 (id 3)
  1.43  RESERVE: zone 4 at (6456, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6456, 1512) facing 0 (id 4)
  1.43  RESERVE: zone 5 at (6504, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6504, 1512) facing 0 (id 5)
  1.43  RESERVE: zone 3 released
  1.43  RESERVE: zone 4 released
  1.43  RESERVE: zone 5 released
  1.43  RESERVE: zone 6 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 6)
  1.43  RESERVE: zone 7 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 7)
  1.43  RESERVE: zone 8 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 8)
  1.43  RESERVE: zone 9 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 9)
  1.43  RESERVE: zone 10 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 10)
  1.43  RESERVE: zone 11 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 11)
  1.43  RESERVE: zone 6 released
  1.43  RESERVE: zone 7 released
  1.43  RESERVE: zone 8 released
  1.43  RESERVE: zone 9 released
  1.43  RESERVE: zone 10 released
  1.43  RESERVE: zone 11 released
  1.43  RESERVE: zone 12 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 12)
  1.43  RESERVE: zone 13 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 13)
  1.43  RESERVE: zone 14 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 14)
  1.43  RESERVE: zone 15 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 15)
  1.43  RESERVE: zone 16 at (6456, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6456, 1448) facing 0 (id 16)
  1.43  RESERVE: zone 17 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 17)
  1.43  RESERVE: zone 18 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 18)
  1.43  RESERVE: zone 19 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 19)
  1.43  RESERVE: zone 20 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 20)
  1.43  RESERVE: zone 21 at (6456, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6456, 1496) facing 0 (id 21)
  1.43  RESERVE: zone 22 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 22)
  1.43  RESERVE: zone 23 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 23)
  1.43  RESERVE: zone 12 released
  1.43  RESERVE: zone 13 released
  1.43  RESERVE: zone 14 released
  1.43  RESERVE: zone 15 released
  1.43  RESERVE: zone 16 released
  1.43  RESERVE: zone 17 released
  1.43  RESERVE: zone 18 released
  1.43  RESERVE: zone 19 released
  1.43  RESERVE: zone 20 released
  1.43  RESERVE: zone 21 released
  1.43  RESERVE: zone 22 released
  1.43  RESERVE: zone 23 released
  1.43  RESERVE: zone 24 at (6216, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6216, 1400) facing 0 (id 24)
  1.43  RESERVE: zone 25 at (6264, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1400) facing 0 (id 25)
  1.43  RESERVE: zone 26 at (6312, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1400) facing 0 (id 26)
  1.43  RESERVE: zone 27 at (6360, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1400) facing 0 (id 27)
  1.43  RESERVE: zone 28 at (6408, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1400) facing 0 (id 28)
  1.43  RESERVE: zone 29 at (6216, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6216, 1448) facing 0 (id 29)
  1.43  RESERVE: zone 30 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 30)
  1.43  RESERVE: zone 31 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 31)
  1.43  RESERVE: zone 32 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 32)
  1.43  RESERVE: zone 33 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 33)
  1.43  RESERVE: zone 34 at (6216, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6216, 1496) facing 0 (id 34)
  1.43  RESERVE: zone 35 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 35)
  1.43  RESERVE: zone 36 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 36)
  1.43  RESERVE: zone 37 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 37)
  1.43  RESERVE: zone 38 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 38)
  1.43  RESERVE: zone 39 at (6216, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6216, 1544) facing 0 (id 39)
  1.43  RESERVE: zone 40 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 40)
  1.43  RESERVE: zone 41 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 41)
  1.43  RESERVE: zone 24 released
  1.43  RESERVE: zone 25 released
  1.43  RESERVE: zone 26 released
```
