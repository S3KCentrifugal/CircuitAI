# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.5 min (frame 27901); wall 1 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T05:49:38
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\mex-expansion-supreme\supreme\20261006T084938Z-58fe869c\runs\20261006T085706Z-79453cbf\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.353267][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.5 min | `[t=00:00:47.261859][f=0002630] [SeaWatch] finished frame=2630 id=10240 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 1.8 min | `[t=00:00:48.992576][f=0003240] [SeaWatch] egress id=23873 yard=10240 seconds=6.7 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\sea\economy\mex-expansion-supreme\supreme\20261006T084938Z-58fe869c\runs\20261006T085706Z-79453cbf\screen_2026-10-06_08-52-00-734.png
- build-theatres\games\sea\economy\mex-expansion-supreme\supreme\20261006T084938Z-58fe869c\runs\20261006T085706Z-79453cbf\screen_2026-10-06_08-52-26-720.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 4 shots, end at 15.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 6887 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4767|11076|0|7|1|4608|11072
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [Playtest] finished armwin team 0 at 0.60 min
  0.76  [Playtest] finished armwin team 0 at 0.76 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +86.3 bank 1001/1001, units 6
  1.46  [Playtest] finished armsy team 0 at 1.46 min
  1.50  [SEA][Layout] berth sea.berth.0 armasy at=6080,10080 facing=2
  1.57  [SEA][Layout] berth sea.berth.1 armplat at=5936,10256 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 606/1200, energy +83.2 bank 27/1151, units 9
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 220/1200, energy +100.9 bank 45/1201, units 14
  3.28  [Playtest] finished armwin team 0 at 3.28 min
  3.35  [Playtest] finished armmex team 0 at 3.35 min
  3.40  [Playtest] finished armwin team 0 at 3.40 min
  3.52  [Playtest] finished armwin team 0 at 3.52 min
  3.89  [Playtest] finished armmex team 0 at 3.89 min
  3.93  [Playtest] finished armmex team 0 at 3.93 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.5 bank 4/1350, energy +157.1 bank 1193/1203, units 19
  4.36  [Playtest] finished armmex team 0 at 4.36 min
  4.52  [Playtest] finished armmex team 0 at 4.52 min
  4.63  [Playtest] finished armmex team 0 at 4.63 min
  4.68  [Playtest] finished armtide team 0 at 4.68 min
  4.94  [Playtest] finished armmex team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +21.9 bank 222/1550, energy +179.0 bank 1244/1253, units 24
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.29  [Playtest] finished armmex team 0 at 5.29 min
  5.34  [Playtest] finished armmex team 0 at 5.34 min
  5.74  [Playtest] finished armmex team 0 at 5.74 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +28.8 bank 916/1700, energy +114.1 bank 2/1253, units 31
  6.07  [Playtest] finished armmex team 0 at 6.07 min
  6.29  [Playtest] finished armllt team 0 at 6.29 min
  6.43  [Playtest] finished armrad team 0 at 6.43 min
  6.65  [Playtest] finished armmex team 0 at 6.65 min
  6.72  [Playtest] finished armnanotcplat team 0 at 6.72 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +33.4 bank 1797/1800, energy +175.7 bank 157/1253, units 35
  7.19  [Playtest] finished armmex team 0 at 7.19 min
  7.29  [Playtest] finished armtide team 0 at 7.29 min
  7.41  [Playtest] finished armllt team 0 at 7.41 min
  7.59  [Playtest] finished armtide team 0 at 7.59 min
  7.91  [Playtest] finished armtide team 0 at 7.91 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +35.7 bank 1847/1850, energy +241.8 bank 106/1403, units 42
  8.22  [Playtest] finished armtide team 0 at 8.22 min
  8.30  [Playtest] finished armmex team 0 at 8.30 min
  8.56  [Playtest] finished armtide team 0 at 8.56 min
  8.67  [Playtest] finished armwin team 0 at 8.67 min
  8.91  [Playtest] finished armtide team 0 at 8.91 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +38.0 bank 1898/1900, energy +306.4 bank 1540/1553, units 48
  9.26  [Playtest] finished armllt team 0 at 9.26 min
  9.46  [Playtest] finished armrad team 0 at 9.46 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +38.0 bank 1896/1900, energy +229.2 bank 1207/1553, units 53
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.27  [Playtest] finished armmstor team 0 at 10.27 min
 10.48  [Playtest] finished armmex team 0 at 10.48 min
 10.94  [Playtest] finished armnanotcplat team 0 at 10.94 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +40.3 bank 2366/4950, energy +324.0 bank 1057/1553, units 59
 11.02  [Playtest] finished armmex team 0 at 11.02 min
 11.90  [Playtest] finished armtide team 0 at 11.90 min
 11.98  [Playtest] finished armtide team 0 at 11.98 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +42.6 bank 2541/5000, energy +308.4 bank 285/1653, units 64
 12.10  [Playtest] finished armtide team 0 at 12.10 min
 12.84  [Playtest] finished armtide team 0 at 12.84 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +42.6 bank 2883/5000, energy +378.4 bank 303/1753, units 72
 13.06  [Playtest] finished armestor team 0 at 13.06 min
 13.47  [Playtest] finished armtide team 0 at 13.47 min
 13.58  [Playtest] finished armllt team 0 at 13.58 min
 13.86  [Playtest] finished armwin team 0 at 13.86 min
 13.98  [Playtest] finished armwin team 0 at 13.98 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +42.6 bank 2836/5000, energy +364.9 bank 964/7804, units 79
 14.02  [Playtest] finished armtide team 0 at 14.02 min
 14.16  [Playtest] finished armwin team 0 at 14.16 min
 14.33  [Playtest] finished armsolar team 0 at 14.33 min
 14.48  [Playtest] finished armtide team 0 at 14.48 min
 14.51  [Playtest] finished armsolar team 0 at 14.51 min
 14.61  [Playtest] finished armnanotcplat team 0 at 14.61 min
 14.84  [Playtest] finished armwin team 0 at 14.84 min
 14.97  [Playtest] finished armwin team 0 at 14.97 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +45.4 bank 2402/5000, energy +604.4 bank 4855/8006, units 93
 15.34  [Playtest] finished armtide team 0 at 15.34 min
 15.38  [Playtest] finished armllt team 0 at 15.38 min
 15.45  [Playtest] finished armtide team 0 at 15.45 min
 15.50  [Playtest] end at 15.5 min: quitting
```

## Native lines (all AIs, first 120)

```
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
  1.43  RESERVE: zone 27 released
  1.43  RESERVE: zone 28 released
  1.43  RESERVE: zone 29 released
  1.43  RESERVE: zone 30 released
  1.43  RESERVE: zone 31 released
  1.43  RESERVE: zone 32 released
  1.43  RESERVE: zone 33 released
  1.43  RESERVE: zone 34 released
  1.43  RESERVE: zone 35 released
  1.43  RESERVE: zone 36 released
  1.43  RESERVE: zone 37 released
  1.43  RESERVE: zone 38 released
```
