# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36000); wall 164 s
- DLL: build-theatres\d202\build-4\SkirmishAI.dll (9af405acf9a6180b); AI BARbTest/test; staged 2026-10-05T11:25:52
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\patrol-aa-screen\supreme\20261005T142552Z-0946384f\runs\20261005T142839Z-b06f2c20\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.066906][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.5 min | `[t=00:00:49.078844][f=0002744] [SeaWatch] finished frame=2744 id=26482 def=corsy builder=28578` |
| expect `first-ship-exit` | seen at 2.2 min | `[t=00:00:53.266059][f=0003990] [SeaWatch] egress id=19532 yard=26482 seconds=21.9 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\patrol-aa-screen\supreme\20261005T142552Z-0946384f\runs\20261005T142839Z-b06f2c20\screen_2026-10-05_14-27-06-947.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\patrol-aa-screen\supreme\20261005T142552Z-0946384f\runs\20261005T142839Z-b06f2c20\screen_2026-10-05_14-27-37-974.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\patrol-aa-screen\supreme\20261005T142552Z-0946384f\runs\20261005T142839Z-b06f2c20\screen_2026-10-05_14-28-38-958.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 4 shots, end at 20.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.19  [Playtest] finished cormex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 19026 at 4607,11071
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|cortex|corsy|4777|11078|0|7|1|4607|11071
  0.37  [Playtest] finished cormex team 0 at 0.37 min
  0.60  [Playtest] finished cormex team 0 at 0.60 min
  0.72  [Playtest] finished corwin team 0 at 0.72 min
  0.84  [Playtest] finished corwin team 0 at 0.84 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1128/1150, energy +50.4 bank 823/1001, units 6
  1.52  [Playtest] finished corsy team 0 at 1.52 min
  1.57  [SEA][Layout] berth sea.berth.0 corasy at=6048,10048 facing=2
  1.70  [SEA][Layout] berth sea.berth.1 corasy at=6336,9968 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.8 bank 819/1250, energy +59.6 bank 19/1151, units 9
  2.80  [Playtest] finished cortide team 0 at 2.80 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 673/1250, energy +85.6 bank 93/1251, units 13
  3.12  [Playtest] finished cortide team 0 at 3.12 min
  3.46  [Playtest] finished cortide team 0 at 3.46 min
  3.52  [Playtest] finished cormex team 0 at 3.52 min
  3.63  [Playtest] finished cortide team 0 at 3.63 min
  3.80  [Playtest] finished cormex team 0 at 3.80 min
  3.85  [Playtest] finished cortide team 0 at 3.85 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.0 bank 259/1350, energy +173.2 bank 767/1451, units 20
  4.02  [Playtest] finished cortide team 0 at 4.02 min
  4.10  [Playtest] finished cormex team 0 at 4.10 min
  4.50  [Playtest] finished cormex team 0 at 4.50 min
  4.82  [Playtest] finished cortide team 0 at 4.82 min
  4.88  [Playtest] finished cormex team 0 at 4.88 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +19.6 bank 151/1500, energy +220.9 bank 1536/1551, units 25
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.19  [Playtest] finished cormex team 0 at 5.19 min
  5.35  [Playtest] finished cortide team 0 at 5.35 min
  5.41  [Playtest] finished corllt team 0 at 5.41 min
  5.64  [Playtest] finished cormex team 0 at 5.64 min
  5.74  [Playtest] finished corrad team 0 at 5.74 min
  5.74  [Playtest] finished cortide team 0 at 5.74 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.2 bank 592/1600, energy +251.3 bank 1641/1651, units 33
  6.19  [Playtest] finished cormex team 0 at 6.19 min
  6.36  [Playtest] finished corllt team 0 at 6.36 min
  6.57  [Playtest] finished cornanotcplat team 0 at 6.57 min
  6.97  [Playtest] finished corfmkr team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.5 bank 656/1650, energy +259.8 bank 145/1651, units 39
  7.42  [Playtest] finished cortide team 0 at 7.42 min
  7.45  [Playtest] finished cormex team 0 at 7.45 min
  7.49  [Playtest] finished cortide team 0 at 7.49 min
  7.66  [Playtest] finished cortide team 0 at 7.66 min
  7.82  [Playtest] finished cortide team 0 at 7.82 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +29.8 bank 424/1700, energy +354.8 bank 1410/1851, units 47
  8.00  [Playtest] finished cormex team 0 at 8.00 min
  8.33  [Playtest] finished corfmkr team 0 at 8.33 min
  8.63  [Playtest] finished cortide team 0 at 8.63 min
  8.70  [Playtest] finished cormex team 0 at 8.70 min
  8.79  [Playtest] finished cortide team 0 at 8.79 min
  8.90  [Playtest] finished cortide team 0 at 8.90 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +35.4 bank 344/1800, energy +397.6 bank 1892/2001, units 53
  9.48  [Playtest] finished corfmkr team 0 at 9.48 min
  9.49  [Playtest] finished cormex team 0 at 9.49 min
  9.63  [Playtest] finished cortide team 0 at 9.63 min
  9.80  [Playtest] finished cortide team 0 at 9.80 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +37.7 bank 518/1850, energy +453.7 bank 1646/2101, units 59
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.02  [Playtest] finished cortide team 0 at 10.02 min
 10.13  [Playtest] finished cortide team 0 at 10.13 min
 10.40  [Playtest] finished cormex team 0 at 10.40 min
 10.85  [Playtest] finished cortide team 0 at 10.85 min
 10.96  [Playtest] finished corfmkr team 0 at 10.97 min
 10.98  [Playtest] finished corestor team 0 at 10.98 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +39.8 bank 1110/1900, energy +522.2 bank 1961/8251, units 68
 11.07  [Playtest] finished cortide team 0 at 11.07 min
 11.43  [Playtest] finished corllt team 0 at 11.43 min
 11.55  [Playtest] finished cortide team 0 at 11.55 min
 11.71  [Playtest] finished cortl team 0 at 11.71 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +40.6 bank 1402/1900, energy +544.2 bank 6324/8351, units 74
 12.20  [Playtest] finished cornanotcplat team 0 at 12.20 min
 12.34  [Playtest] finished cortide team 0 at 12.34 min
 12.95  [Playtest] finished cormex team 0 at 12.95 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +43.0 bank 1113/1950, energy +569.5 bank 6674/8401, units 81
 13.11  [Playtest] finished corllt team 0 at 13.11 min
 13.18  [Playtest] finished cortl team 0 at 13.18 min
 13.26  [Playtest] finished corrad team 0 at 13.26 min
 13.30  [Playtest] finished cortide team 0 at 13.30 min
 13.82  [Playtest] finished cortide team 0 at 13.82 min
 14.00  [Playtest] finished cortide team 0 at 14.00 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +44.3 bank 902/1950, energy +623.3 bank 7633/8551, units 90
 14.19  [Playtest] finished cormex team 0 at 14.19 min
 14.33  [Playtest] finished cortide team 0 at 14.33 min
 14.44  [Playtest] finished cortide team 0 at 14.44 min
 14.56  [Playtest] finished cormstor team 0 at 14.56 min
 14.72  [Playtest] finished cortl team 0 at 14.72 min
 14.83  [Playtest] finished cortide team 0 at 14.83 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +46.6 bank 380/5000, energy +710.3 bank 7713/8701, units 100
 15.02  [Playtest] finished corfrad team 0 at 15.02 min
 15.42  [Playtest] finished cortide team 0 at 15.42 min
 15.68  [Playtest] finished corfmkr team 0 at 15.68 min
 15.73  [Playtest] finished cormex team 0 at 15.73 min
 15.73  [Playtest] finished cortide team 0 at 15.73 min
 15.87  [Playtest] finished corfmkr team 0 at 15.86 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +47.5 bank 251/5050, energy +745.6 bank 6721/8801, units 109
 16.03  [Playtest] finished cortide team 0 at 16.03 min
 16.18  [Playtest] finished cortide team 0 at 16.18 min
 16.26  [Playtest] finished cortl team 0 at 16.26 min
 16.29  [Playtest] finished corfmkr team 0 at 16.29 min
 16.55  [Playtest] finished corfrad team 0 at 16.55 min
 16.55  [Playtest] finished cortide team 0 at 16.55 min
 16.69  [Playtest] finished cortide team 0 at 16.69 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +51.9 bank 431/5050, energy +830.1 bank 7398/9001, units 118
 17.25  [Playtest] finished corllt team 0 at 17.25 min
 17.29  [Playtest] finished cortide team 0 at 17.29 min
 17.40  [Playtest] finished corrad team 0 at 17.40 min
 17.59  [Playtest] finished cortide team 0 at 17.59 min
 17.82  [Playtest] finished corfrad team 0 at 17.82 min
 17.90  [Playtest] finished corrad team 0 at 17.90 min
 17.90  [Playtest] finished cortide team 0 at 17.90 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +51.9 bank 488/5050, energy +901.0 bank 7359/9151, units 129
 18.15  [Playtest] finished corllt team 0 at 18.15 min
 18.21  [Playtest] finished cortide team 0 at 18.21 min
 18.62  [Playtest] finished cortide team 0 at 18.62 min
 18.96  [Playtest] finished cortide team 0 at 18.96 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +51.9 bank 577/5050, energy +957.6 bank 8802/9301, units 137
 19.26  [Playtest] finished cortide team 0 at 19.26 min
 19.37  [Playtest] finished cortl team 0 at 19.37 min
 19.57  [Playtest] finished cortide team 0 at 19.57 min
 19.64  [Playtest] finished corfrad team 0 at 19.64 min
 19.87  [Playtest] finished cortide team 0 at 19.87 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +51.9 bank 774/5050, energy +1025.2 bank 9390/9451, units 146
 20.00  [Playtest] camera requested (4814,11077) height=2200
```

## Native lines (all AIs, first 120)

```
  1.38  RESERVE: zone 1 at (6472, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6472, 1464) facing 0 (id 1)
  1.38  RESERVE: zone 2 at (6520, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6520, 1464) facing 0 (id 2)
  1.38  RESERVE: zone 1 released
  1.38  RESERVE: zone 2 released
  1.38  RESERVE: zone 3 at (6408, 1480) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6408, 1480) facing 0 (id 3)
  1.38  RESERVE: zone 4 at (6456, 1480) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6456, 1480) facing 0 (id 4)
  1.38  RESERVE: zone 5 at (6504, 1480) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6504, 1480) facing 0 (id 5)
  1.38  RESERVE: zone 3 released
  1.38  RESERVE: zone 4 released
  1.38  RESERVE: zone 5 released
  1.38  RESERVE: zone 6 at (6328, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6328, 1464) facing 0 (id 6)
  1.38  RESERVE: zone 7 at (6376, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6376, 1464) facing 0 (id 7)
  1.38  RESERVE: zone 8 at (6424, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6424, 1464) facing 0 (id 8)
  1.38  RESERVE: zone 9 at (6472, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6472, 1464) facing 0 (id 9)
  1.38  RESERVE: zone 10 at (6520, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6520, 1464) facing 0 (id 10)
  1.38  RESERVE: zone 11 at (6328, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6328, 1512) facing 0 (id 11)
  1.38  RESERVE: zone 6 released
  1.38  RESERVE: zone 7 released
  1.38  RESERVE: zone 8 released
  1.38  RESERVE: zone 9 released
  1.38  RESERVE: zone 10 released
  1.38  RESERVE: zone 11 released
  1.38  RESERVE: zone 12 at (6264, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6264, 1416) facing 0 (id 12)
  1.38  RESERVE: zone 13 at (6312, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6312, 1416) facing 0 (id 13)
  1.38  RESERVE: zone 14 at (6360, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6360, 1416) facing 0 (id 14)
  1.38  RESERVE: zone 15 at (6408, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6408, 1416) facing 0 (id 15)
  1.38  RESERVE: zone 16 at (6456, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6456, 1416) facing 0 (id 16)
  1.38  RESERVE: zone 17 at (6264, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6264, 1464) facing 0 (id 17)
  1.38  RESERVE: zone 18 at (6312, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6312, 1464) facing 0 (id 18)
  1.38  RESERVE: zone 19 at (6360, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6360, 1464) facing 0 (id 19)
  1.38  RESERVE: zone 20 at (6408, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6408, 1464) facing 0 (id 20)
  1.38  RESERVE: zone 21 at (6456, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6456, 1464) facing 0 (id 21)
  1.38  RESERVE: zone 22 at (6264, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6264, 1512) facing 0 (id 22)
  1.38  RESERVE: zone 23 at (6312, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6312, 1512) facing 0 (id 23)
  1.38  RESERVE: zone 12 released
  1.38  RESERVE: zone 13 released
  1.38  RESERVE: zone 14 released
  1.38  RESERVE: zone 15 released
  1.38  RESERVE: zone 16 released
  1.38  RESERVE: zone 17 released
  1.38  RESERVE: zone 18 released
  1.38  RESERVE: zone 19 released
  1.38  RESERVE: zone 20 released
  1.38  RESERVE: zone 21 released
  1.38  RESERVE: zone 22 released
  1.38  RESERVE: zone 23 released
  1.38  RESERVE: zone 24 at (6216, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6216, 1368) facing 0 (id 24)
  1.38  RESERVE: zone 25 at (6264, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6264, 1368) facing 0 (id 25)
  1.38  RESERVE: zone 26 at (6312, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6312, 1368) facing 0 (id 26)
  1.38  RESERVE: zone 27 at (6360, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6360, 1368) facing 0 (id 27)
  1.38  RESERVE: zone 28 at (6408, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6408, 1368) facing 0 (id 28)
  1.38  RESERVE: zone 29 at (6216, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6216, 1416) facing 0 (id 29)
  1.38  RESERVE: zone 30 at (6264, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6264, 1416) facing 0 (id 30)
  1.38  RESERVE: zone 31 at (6312, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6312, 1416) facing 0 (id 31)
  1.38  RESERVE: zone 32 at (6360, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6360, 1416) facing 0 (id 32)
  1.38  RESERVE: zone 33 at (6408, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6408, 1416) facing 0 (id 33)
  1.38  RESERVE: zone 34 at (6216, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6216, 1464) facing 0 (id 34)
  1.38  RESERVE: zone 35 at (6264, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6264, 1464) facing 0 (id 35)
  1.38  RESERVE: zone 36 at (6312, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6312, 1464) facing 0 (id 36)
  1.38  RESERVE: zone 37 at (6360, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6360, 1464) facing 0 (id 37)
  1.38  RESERVE: zone 38 at (6408, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6408, 1464) facing 0 (id 38)
  1.38  RESERVE: zone 39 at (6216, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6216, 1512) facing 0 (id 39)
  1.38  RESERVE: zone 40 at (6264, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6264, 1512) facing 0 (id 40)
  1.38  RESERVE: zone 41 at (6312, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.38  RESERVE: armnanotcplat at (6312, 1512) facing 0 (id 41)
  1.38  RESERVE: zone 24 released
  1.38  RESERVE: zone 25 released
  1.38  RESERVE: zone 26 released
  1.38  RESERVE: zone 27 released
  1.38  RESERVE: zone 28 released
  1.38  RESERVE: zone 29 released
  1.38  RESERVE: zone 30 released
  1.38  RESERVE: zone 31 released
  1.38  RESERVE: zone 32 released
  1.38  RESERVE: zone 33 released
  1.38  RESERVE: zone 34 released
  1.38  RESERVE: zone 35 released
  1.38  RESERVE: zone 36 released
  1.38  RESERVE: zone 37 released
  1.38  RESERVE: zone 38 released
```
