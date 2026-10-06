# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.5 min (frame 27900); wall 1 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T06:17:13
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\mex-safe-supreme\supreme\20261006T091712Z-2835db4c\runs\20261006T092445Z-e07e151d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.378703][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.5 min | `[t=00:00:47.340629][f=0002645] [SeaWatch] finished frame=2645 id=10240 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 1.9 min | `[t=00:00:49.788757][f=0003510] [SeaWatch] egress id=23873 yard=10240 seconds=7.0 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\sea\economy\mex-safe-supreme\supreme\20261006T091712Z-2835db4c\runs\20261006T092445Z-e07e151d\screen_2026-10-06_09-22-57-014.png
- build-theatres\games\sea\economy\mex-safe-supreme\supreme\20261006T091712Z-2835db4c\runs\20261006T092445Z-e07e151d\screen_2026-10-06_09-23-23-000.png

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
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 6887 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4770|11077|0|7|1|4608|11072
  0.39  [Playtest] finished armmex team 0 at 0.39 min
  0.50  [Playtest] finished armwin team 0 at 0.50 min
  0.61  [Playtest] finished armwin team 0 at 0.61 min
  0.76  [Playtest] finished armwin team 0 at 0.76 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1081/1100, energy +63.0 bank 1001/1001, units 6
  1.47  [Playtest] finished armsy team 0 at 1.47 min
  1.52  [SEA][Layout] berth sea.berth.0 armasy at=6080,10080 facing=2
  1.58  [SEA][Layout] berth sea.berth.1 armplat at=5936,10256 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +5.5 bank 691/1200, energy +59.3 bank 15/1151, units 9
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 480/1200, energy +76.2 bank 49/1201, units 12
  3.21  [Playtest] finished armmex team 0 at 3.21 min
  3.30  [Playtest] finished armwin team 0 at 3.30 min
  3.41  [Playtest] finished armwin team 0 at 3.41 min
  3.71  [Playtest] finished armmex team 0 at 3.71 min
  3.74  [Playtest] finished armtide team 0 at 3.74 min
  3.76  [Playtest] finished armmex team 0 at 3.76 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.5 bank 215/1350, energy +139.5 bank 357/1252, units 19
  4.10  [Playtest] finished armtide team 0 at 4.10 min
  4.12  [Playtest] finished armmex team 0 at 4.13 min
  4.32  [Playtest] finished armmex team 0 at 4.32 min
  4.38  [Playtest] finished armmex team 0 at 4.38 min
  4.45  [Playtest] finished armtide team 0 at 4.45 min
  4.69  [Playtest] finished armmex team 0 at 4.69 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +21.9 bank 302/1550, energy +169.7 bank 1311/1352, units 27
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.07  [Playtest] finished armmex team 0 at 5.07 min
  5.08  [Playtest] finished armmex team 0 at 5.08 min
  5.35  [Playtest] finished armllt team 0 at 5.35 min
  5.46  [Playtest] finished armrad team 0 at 5.45 min
  5.80  [Playtest] finished armmex team 0 at 5.80 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +28.8 bank 1047/1700, energy +160.8 bank 131/1352, units 33
  6.09  [Playtest] finished armrad team 0 at 6.09 min
  6.29  [Playtest] finished armmex team 0 at 6.29 min
  6.49  [Playtest] finished armllt team 0 at 6.49 min
  6.65  [Playtest] finished armnanotcplat team 0 at 6.65 min
  6.72  [Playtest] finished armmex team 0 at 6.72 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +33.4 bank 1796/1800, energy +181.7 bank 71/1352, units 38
  7.13  [Playtest] finished armtide team 0 at 7.13 min
  7.17  [Playtest] finished armmex team 0 at 7.18 min
  7.44  [Playtest] finished armtide team 0 at 7.44 min
  7.60  [Playtest] finished armllt team 0 at 7.60 min
  7.76  [Playtest] finished armtide team 0 at 7.76 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +35.7 bank 1844/1850, energy +240.5 bank 392/1502, units 46
  8.11  [Playtest] finished armmex team 0 at 8.10 min
  8.17  [Playtest] finished armtide team 0 at 8.17 min
  8.49  [Playtest] finished armtide team 0 at 8.49 min
  8.64  [Playtest] finished armwin team 0 at 8.64 min
  8.83  [Playtest] finished armtide team 0 at 8.83 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +38.0 bank 1896/1900, energy +271.5 bank 1546/1653, units 51
  9.33  [Playtest] finished armllt team 0 at 9.33 min
  9.69  [Playtest] finished armllt team 0 at 9.69 min
  9.87  [Playtest] finished armrad team 0 at 9.87 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +38.0 bank 1897/1900, energy +343.0 bank 1639/1653, units 58
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.36  [Playtest] finished armnanotcplat team 0 at 10.36 min
 10.59  [Playtest] finished armmstor team 0 at 10.59 min
 10.81  [Playtest] finished armtide team 0 at 10.81 min
 10.84  [Playtest] finished armmex team 0 at 10.84 min
 10.88  [Playtest] finished armwin team 0 at 10.88 min
 11.00  [Playtest] finished armwin team 0 at 11.00 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +40.3 bank 1600/4950, energy +317.6 bank 1154/1704, units 67
 11.13  [Playtest] finished armtide team 0 at 11.13 min
 11.57  [Playtest] finished armmex team 0 at 11.57 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +42.6 bank 1595/5000, energy +423.1 bank 1728/1754, units 72
 12.33  [Playtest] finished armtide team 0 at 12.33 min
 12.90  [Playtest] finished armtide team 0 at 12.90 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +42.6 bank 1600/5000, energy +453.9 bank 1119/1854, units 80
 13.04  [Playtest] finished armfmkr team 0 at 13.04 min
 13.50  [Playtest] finished armtide team 0 at 13.50 min
 13.90  [Playtest] finished armestor team 0 at 13.90 min
 13.94  [Playtest] finished armtide team 0 at 13.94 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +42.6 bank 1622/5000, energy +493.3 bank 2782/7954, units 87
 14.34  [Playtest] finished armtide team 0 at 14.34 min
 14.35  [Playtest] finished armllt team 0 at 14.35 min
 14.79  [Playtest] finished armtide team 0 at 14.79 min
 14.99  [Playtest] finished armllt team 0 at 14.99 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +43.6 bank 1545/5000, energy +543.2 bank 7954/8054, units 96
 15.37  [Playtest] finished armtide team 0 at 15.37 min
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
