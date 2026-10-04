# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54002); wall 294 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:43:00
- Map: Nine_Metal_Islands_V1; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=AIR/armada/test, 2=TECH/cortex/test, 3=AIR/legion/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: metal_field.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\nine-metal\20261003T174300Z-e4ecc3d7\runs\20261003T174757Z-5867a381\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `0` | seen at -0.0 min | `[t=00:00:41.116436][f=-000001] Skirmish AI <BARb playtest-test>: METAL_FIELD: team=0 mode=1 schema=1 candidates=96 cells=16384 map=Nine_Metal_Islands_V1` |
| expect `1` | seen at 0.5 min | `0900] [MetalWatch] sample frame=900 team=0 mex=2 mexYield=3.88 converters=0 converterStarts=0 wind=1 labs=0 workers=1 frames=0 M=5.9 bankM=941.1/1100.0 spendM=0.6 E=54.9 bankE=888.7/1000.5 spendE=11.6` |
| expect `2` | seen at 0.1 min | `[METAL][Economy] M=0 E=12 goal=120 fundedM=0 mex=0 wind=0 dense=false` |
| expect `3` | seen at 0.1 min | `Setup complete role=1 landLocked=false` |
| expect `4` | seen at 0.1 min | `Setup complete role=2 landLocked=false` |
| forbid `0` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `1` | clean |  |
| forbid `2` | clean |  |
| forbid `3` | clean |  |
| forbid `native crash` | clean |  |

## Failures

- forbid '0' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid '0' hit at 7.8 min: [INVARIANT] INV-052 ferry run for cargo 2417 unloading for 16 s
- forbid '0' hit at 17.0 min: [INVARIANT] INV-042 the run for cargo 2417 has lasted 600 s

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\nine-metal\20261003T174300Z-e4ecc3d7\runs\20261003T174757Z-5867a381\screen_2026-10-03_17-44-09-835.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\nine-metal\20261003T174300Z-e4ecc3d7\runs\20261003T174757Z-5867a381\screen_2026-10-03_17-44-56-952.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\nine-metal\20261003T174300Z-e4ecc3d7\runs\20261003T174757Z-5867a381\screen_2026-10-03_17-46-51-802.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 30, 3 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1900, 5400) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (2037, 10300) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (15100, 9200) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (14440, 5084) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1900, 5400) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (2037, 10300) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (15100, 9200) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (14440, 5084) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 2); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 1, side offset 4 cells, forward offset 0 cells
  0.08  [Layout] home centre (2168, 5453), 273 from the start
  0.08  [Layout] turret box 40x44 cells at (2168, 5933), from the start rear 0, side -30, ground 75%, halo 64%: zone 7, 4 rows, 20 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (2592, 6029) facing 1, 0 cells ahead of turret row 0
  0.08  [Layout] the front is (8192, 5461): the labs face 1 (lane (8192, 5461), the pair faces 1)
  0.08  [Layout] advanced lab faces 1 (the pair faces 1)
  0.08  [Layout] advanced lab's footprint reserved at (2600, 6024), 715 from the home centre, 17 turret slots within reach, 5 flush (D-095)
  0.08  [Layout] forward cluster 40x20 cells at (2808, 6253), 8 cells ahead of the main cluster, ground 77%: zone 8, 4 rows, 35 turret slots
  0.10  [Team][Roster] Announced: roster|1|0|0|TECH|armada|armlab|1900|5397|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=AIR side=armada start=(2037,10297) factory=armap landLocked=no spot=1 known=1/1
  0.15  [Playtest] finished armwin team 0 at 0.15 min
  0.16  [Rule] table of 50 rules loaded
  0.16  [TECH][Opening] home mex order 1/2 at (1776, 5264), 181 from start
  0.16  [Rule] opening.mex for armcom 4003 | M +0 E 0/61 T1 E-float M-float
  0.28  [Team][Roster] team 1 first mex at 2096,10368
  0.30  [Playtest] finished armmex team 0 at 0.30 min
  0.32  [TECH][Opening] home mex order 2/2 at (1712, 5264), 230 from start
  0.32  [Rule] opening.mex for armcom 4003 | M +2 E 42/76 T1 M-float
  0.32  [Team][Roster] first mex 789 at 1776,5264
  0.32  [Team][Roster] Re-announced: roster|1|0|0|TECH|armada|armlab|1900|5397|0|0|1|1776|5264
  0.47  [Playtest] finished armmex team 0 at 0.47 min
  0.48  [TECH][Opening] complete after 2 mexes, 23 s: the 2 nearest spots are ordered and none is pending; the lab is next
  0.48  [TECH][Build] first lab at the commander: (1824, 5104), 224 from it, facing 1; the pair's slot stays planned
  0.48  [Rule] lab.t1.opening for armcom 4003 | M +2 E 54/79 T1 M-float
  0.79  [Playtest] finished armlab team 0 at 0.79 min
  0.80  [TECH][Build] first lab's exit held (zone 43) until it is reclaimed
  1.00  [Playtest] eco team 0 at 1.0 min: metal +5.9 bank 562/1200, energy +54.8 bank 1059/1100, units 6
  1.31  [Playtest] finished armwin team 0 at 1.31 min
  1.46  [Playtest] finished armwin team 0 at 1.46 min
  1.57  [Playtest] finished armwin team 0 at 1.57 min
  1.70  [Playtest] finished armwin team 0 at 1.70 min
  1.75  [Playtest] finished armmex team 0 at 1.75 min
  1.82  [Playtest] finished armwin team 0 at 1.82 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.8 bank 356/1250, energy +131.7 bank 1127/1203, units 16
  2.01  [Playtest] finished armwin team 0 at 2.01 min
  2.03  [Layout] advanced lab on its planned slot (2600, 6024): 17 turret slots within 260
  2.13  [Playtest] finished armwin team 0 at 2.13 min
  2.14  [Rule] assist.any for armcom 4003 | M +7 E 133/130 T2 E-float
  2.16  [Playtest] finished armmex team 0 at 2.16 min
  2.25  [Playtest] finished armwin team 0 at 2.26 min
  2.44  [Layout] turrets: order 1 of 1 allowed (build power 450 (1 by power), bank 347 + 9/s (3 by metal), 0 dear frames take a slot)
  2.44  [Rule] turret.build for armck 1581 | M +9 E 267/153 T2 E-float
  2.55  [TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab 495; idle build power in range joins
  2.55  [Rule] lab.t1.reclaim for armck 4491 | M +9 E 275/153 T2 E-float
  2.60  [Playtest] finished armmex team 0 at 2.61 min
  2.62  [Rule] lab.t1.reclaim for armck 8801 | M +9 E 278/153 T2 E-float
  2.80  [Playtest] finished armmex team 0 at 2.80 min
  2.81  [Rule] lab.t1.reclaim for armcom 4003 | M +10 E 282/169 T2 E-float
  3.00  [Playtest] eco team 0 at 3.0 min: metal +13.6 bank 454/1400, energy +268.4 bank 1282/1304, units 23
  3.03  [TECH][Build] first lab gone: its exit (zone 43) released
  3.48  [Playtest] finished armmex team 0 at 3.48 min
  3.52  [Playtest] finished armwin team 0 at 3.52 min
  3.64  [Playtest] finished armwin team 0 at 3.64 min
  3.65  [Rule] assist.any for armcom 4003 | M +14 E 269/218 T2 E-float
  3.73  [Playtest] finished armwin team 0 at 3.73 min
  3.87  [Playtest] finished armmex team 0 at 3.87 min
  3.93  [Playtest] finished armnanotc team 0 at 3.93 min
  3.94  [Rule] assist.any for armck 1581 | M +15 E 351/240 T2 E-float
  4.00  [Playtest] eco team 0 at 4.0 min: metal +17.5 bank 838/1400, energy +357.9 bank 1166/1206, units 28
  4.27  [Playtest] finished armmex team 0 at 4.27 min
  4.43  [Playtest] finished armwin team 0 at 4.43 min
  4.82  [Playtest] finished armmex team 0 at 4.82 min
  4.95  [Playtest] finished armwin team 0 at 4.95 min
  5.00  [Ferry] requested a transport (TECH at +20 metal, no transport)
  5.00  [Playtest] eco team 0 at 5.0 min: metal +21.4 bank 0/1500, energy +129.3 bank 1030/1207, units 31
  5.00  [Playtest] target team 0 at (1900, 5400) from its start position
  5.00  [Playtest] camera requested (1900,5400) height=2200
  5.00  [Playtest] finished armalab team 0 at 5.00 min
  5.01  [Playtest] camera captured name=ta position=(1900,5400) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1900, 5400)
  5.02  [TECH][Build] advanced lab's exit held (zone 68)
  5.02  [Layout] advanced lab 8288: nearest construction turret 96 elmos (flush)
  5.02  [Layout] advanced lab 8288: faces 1, the front 1, 0 structures in its exit lane
  5.02  [Layout] factory armalab 8288 stands 0 cell(s) from a turret
  5.02  [Rule] storage.energy for armcom 4003 | M +20 E 129/339 T2
  5.41  [Playtest] finished armestor team 0 at 5.41 min
  5.47  [Playtest] finished armwin team 0 at 5.47 min
  5.49  [Playtest] finished armwin team 0 at 5.49 min
  5.61  [Rule] assist.any for armck 24319 | M +17 E 128/282 T2 draining
  5.67  [Playtest] finished armmex team 0 at 5.67 min
  5.77  [Playtest] finished armwin team 0 at 5.77 min
  5.79  [Rule] assist.any for armck 1581 | M +20 E 138/327 T2
  5.92  [Playtest] finished armwin team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +23.3 bank 745/1750, energy +154.6 bank 0/7409, units 43
  6.03  [Playtest] finished armmex team 0 at 6.03 min
  6.03  [Ferry] transport 11185 received and reserved; hold pending task
  6.04  [Rule] assist.any for armcom 4003 | M +21 E 143/355 T2 draining
  6.05  [Ferry] reserved: transport 11185 flying to (1900,5397)
  6.12  [Playtest] finished armwin team 0 at 6.12 min
  6.15  [Rule] assist.any for armack 15655 | M +21 E 151/355 T2
  6.24  [Playtest] finished armwin team 0 at 6.24 min
  6.25  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 1256 of 1800) (D-103)
  6.26  [Playtest] finished armwin team 0 at 6.26 min
  6.39  [Playtest] finished armmex team 0 at 6.39 min
  6.42  [Playtest] finished armwin team 0 at 6.42 min
  6.54  [Rule] assist.any for armack 674 | M +24 E 453/414 T2
  6.55  [Playtest] finished armwin team 0 at 6.55 min
  6.60  [Playtest] finished armwin team 0 at 6.60 min
  6.61  [Rule] order.repair for armck 1581 | M +26 E 541/455 T2 E-float
  6.63  [Playtest] finished armwin team 0 at 6.63 min
  6.64  [Rule] assist.any for armck 24319 | M +26 E 578/460 T2 E-float
  6.79  [Playtest] finished armmex team 0 at 6.79 min
  6.84  [Ferry] TECH: carrying 7858 to team 1 at (2005,10458) anchor=first-mex distance=128
  6.85  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 1079 of 1900) (D-103)
  6.85  [Rule] assist.any for armck 1581 | M +26 E 708/460 T2 E-float
  6.87  [Rule] order.repair for armck 24319 | M +26 E 708/460 T2 E-float
  6.88  [Rule] assist.any for armack 674 | M +26 E 708/460 T2 E-float
  6.92  [Playtest] finished armmex team 0 at 6.92 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +29.1 bank 1073/1950, energy +721.5 bank 7680/7712, units 54
  7.15  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 1069 of 1950) (D-103)
  7.15  [Rule] assist.any for armck 24319 | M +28 E 652/528 T2 E-float
  7.15  [Rule] assist.any for armack 7196 | M +29 E 628/533 T2 E-float
  7.20  [Playtest] finished armmex team 0 at 7.20 min
  7.28  [Rule] assist.any for armack 674 | M +29 E 450/533 T2 E-float
  7.29  [Rule] assist.any for armack 7196 | M +29 E 434/533 T2 E-float
  7.30  [Rule] assist.any for armcom 4003 | M +29 E 434/533 T2 E-float
  7.38  [Playtest] finished armmex team 0 at 7.38 min
  7.44  [Rule] assist.any for armack 19929 | M +31 E 412/586 T2
  7.44  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 1097 of 2050) (D-103)
  7.50  [Playtest] finished armwin team 0 at 7.50 min
  7.50  [Playtest] finished armwin team 0 at 7.50 min
  7.67  [Playtest] finished armmex team 0 at 7.67 min
  7.68  [Playtest] finished armwin team 0 at 7.68 min
  7.68  [Ferry] TECH: delivered constructor 7858 to team 1
  7.74  [Rule] assist.any for armack 4608 | M +33 E 484/640 T2
  7.74  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 1070 of 2100) (D-103)
  7.75  [Playtest] finished armmex team 0 at 7.75 min
  7.76  [Layout] turrets: order 2 of 6 allowed (build power 1590 (6 by power), bank 1091 + 35/s (9 by metal), 0 dear frames take a slot)
  7.76  [Rule] turret.build for armck 1581 | M +33 E 484/640 T2 E-float
  7.80  [Playtest] finished armwin team 0 at 7.80 min
  7.83  [Playtest] finished armmex team 0 at 7.83 min
  7.84  [Playtest] finished armwin team 0 at 7.84 min
  7.86  [Playtest] finished armwin team 0 at 7.86 min
  7.93  [Rule] assist.any for armack 7196 | M +35 E 514/727 T2 E-float
  7.94  [Rule] assist.any for armack 19929 | M +35 E 514/727 T2 E-float
  7.94  [Rule] assist.any for armack 4608 | M +35 E 514/727 T2 E-float
  7.95  [Rule] assist.any for armack 674 | M +35 E 514/727 T2 E-float
  7.96  [Rule] assist.any for armack 15655 | M +36 E 531/739 T2 E-float
  8.00  [Playtest] finished armwin team 0 at 8.00 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +38.8 bank 1100/2200, energy +649.9 bank 7640/7916, units 68
  8.04  [Rule] assist.any for armack 18987 | M +38 E 576/795 T2 E-float
  8.05  [TECH][Factory] armalab: T2 constructor 7 of 10 (bank 1117 of 2200) (D-103)
  8.12  [Playtest] finished armwin team 0 at 8.12 min
  8.31  [Playtest] finished armwin team 0 at 8.31 min
  8.32  [Playtest] finished armwin team 0 at 8.32 min
  8.34  [TECH][Factory] armalab: T2 constructor 8 of 10 (bank 1646 of 2200) (D-103)
  8.36  [Rule] assist.any for armack 742 | M +38 E 675/820 T2 E-float
  8.37  [Rule] assist.any for armcom 4003 | M +38 E 675/820 T2 E-float
  8.38  [Playtest] finished armwin team 0 at 8.39 min
  8.49  [Playtest] finished armnanotc team 0 at 8.49 min
  8.54  [Playtest] finished armwin team 0 at 8.55 min
  8.58  [Rule] assist.any for armcom 4003 | M +38 E 829/820 T2 E-float
  8.62  [Playtest] finished armwin team 0 at 8.62 min
  8.64  [Rule] assist.any for armck 24319 | M +38 E 925/820 T2 E-float
  8.64  [TECH][Factory] armalab: T2 constructor 9 of 10 (bank 1560 of 2200) (D-103)
  8.68  [Playtest] finished armmex team 0 at 8.68 min
  8.68  [Rule] assist.any for armack 1086 | M +38 E 961/820 T2 E-float
  8.90  [Rule] assist.any for armack 2699 | M +40 E 1091/871 T2 E-float
  9.00  [Playtest] eco team 0 at 9.0 min: metal +40.8 bank 360/2250, energy +1112.0 bank 8257/8319, units 81
  9.12  [Playtest] finished armmex team 0 at 9.12 min
  9.27  [Playtest] finished armwin team 0 at 9.27 min
  9.44  [Playtest] finished armmex team 0 at 9.44 min
  9.55  [Playtest] finished armmex team 0 at 9.55 min
  9.61  [Playtest] finished armfus team 0 at 9.60 min
  9.62  [Playtest] finished armwin team 0 at 9.62 min
  9.63  [Rule] assist.any for armack 19929 | M +43 E 541/929 T2
  9.77  [Rule] assist.any for armcom 4003 | M +46 E 1329/987 T2 E-float
  9.94  [Playtest] finished armmex team 0 at 9.94 min
  9.98  [TECH][Factory] armalab: T2 constructor 10 of 10 (bank 1406 of 2450) (D-103)
  9.99  [Playtest] finished armwin team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +48.5 bank 1480/2450, energy +1258.7 bank 10778/10820, units 88
 10.00  [Rule] order.repair for armck 1581 | M +46 E 1304/991 T2 E-float
 10.10  [Playtest] finished armwin team 0 at 10.10 min
 10.20  [Rule] assist.any for armcom 4003 | M +48 E 1231/1030 T2 E-float
 10.22  [Rule] assist.any for armck 1581 | M +48 E 1231/1030 T2 E-float
 10.22  [Rule] assist.any for armack 26473 | M +48 E 1231/1030 T2 E-float
 10.44  [Playtest] finished armmex team 0 at 10.44 min
 10.50  [Playtest] finished armmex team 0 at 10.50 min
 10.65  [Playtest] finished armmex team 0 at 10.65 min
 10.70  [Playtest] finished armmex team 0 at 10.70 min
 10.75  [Playtest] finished armmex team 0 at 10.75 min
 10.86  [Playtest] finished armmex team 0 at 10.86 min
 10.92  [Playtest] finished armmex team 0 at 10.92 min
 10.96  [Playtest] finished armmex team 0 at 10.96 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +64.0 bank 608/2850, energy +1316.5 bank 10868/10921, units 97
 11.04  [Playtest] finished armfus team 0 at 11.04 min
 11.05  [Rule] assist.any for armack 742 | M +58 E 1313/1235 T2 E-float
 11.11  [Playtest] finished armmex team 0 at 11.11 min
 11.13  [Layout] turrets: order 4 of 5 allowed (build power 1530 (5 by power), bank 908 + 64/s (145 by metal), 0 dear frames take a slot)
 11.13  [Rule] turret.build for armck 1581 | M +62 E 1313/1309 T2 E-float
 11.20  [Rule] assist.any for armack 742 | M +64 E 1319/1340 T2 E-float
 11.21  [Rule] legacy.strategic for armack 26473 | M +64 E 2051/1340 T2 E-float
 11.21  [Rule] assist.any for armack 19929 | M +64 E 2051/1340 T2 E-float
 11.22  [Rule] assist.any for armack 674 | M +64 E 2051/1340 T2 E-float
 11.22  [Rule] assist.any for armack 7196 | M +64 E 2051/1340 T2 E-float
 11.23  [Rule] assist.any for armack 18987 | M +64 E 2051/1340 T2 E-float
 11.30  [Playtest] finished armnanotc team 0 at 11.30 min
 11.32  [Rule] assist.any for armck 1581 | M +65 E 2053/1367 T2 E-float
 11.50  [Playtest] finished armmex team 0 at 11.50 min
 11.52  [Rule] assist.any for armck 24319 | M +65 E 2229/1378 T2 E-float
 11.57  [Playtest] finished armmex team 0 at 11.57 min
 11.66  [Layout] turrets: order 4 of 4 allowed (build power 1320 (4 by power), bank 2413 + 69/s (8 by metal), 0 dear frames take a slot)
 11.66  [Rule] turret.build for armck 24319 | M +66 E 2467/1382 T2 E-float M-float
 11.67  [Playtest] finished armmex team 0 at 11.67 min
 11.72  [Rule] assist.any for armfark 14835 | M +67 E 2459/1413 T2 E-float M-float
 11.76  [Rule] assist.any for armack 19929 | M +68 E 2443/1429 T2 E-float M-float
 11.76  [Rule] assist.any for armack 674 | M +68 E 2443/1429 T2 E-float M-float
 11.77  [Rule] assist.any for armack 7196 | M +68 E 2443/1429 T2 E-float M-float
 11.81  [Playtest] finished armmex team 0 at 11.81 min
 11.86  [Rule] order.repair for armfark 5700 | M +70 E 2426/1471 T2 E-float M-float
 11.89  [Rule] assist.any for armack 19929 | M +71 E 2426/1487 T2 E-float M-float
 11.89  [Rule] assist.any for armack 674 | M +71 E 2426/1487 T2 E-float M-float
 11.90  [Rule] assist.any for armack 7196 | M +71 E 2426/1495 T2 E-float M-float
 11.91  [Rule] assist.any for armack 18987 | M +71 E 2426/1495 T2 E-float M-float
 11.91  [Rule] assist.any for armack 4608 | M +71 E 2426/1495 T2 E-float M-float
 11.92  [Rule] assist.any for armack 2699 | M +71 E 2426/1495 T2 E-float M-float
 11.93  [Rule] assist.any for armack 1086 | M +71 E 2426/1495 T2 E-float M-float
 11.93  [Rule] assist.any for armack 15655 | M +71 E 2426/1495 T2 E-float M-float
 11.93  [Playtest] finished armmex team 0 at 11.93 min
 11.93  [Rule] assist.any for armfark 5700 | M +71 E 2426/1495 T2 E-float M-float
 11.94  [Rule] assist.any for armfark 24977 | M +71 E 2426/1495 T2 E-float M-float
 11.94  [Layout] turrets: order 5 of 7 allowed (build power 2070 (7 by power), bank 2780 + 73/s (68 by metal), 0 dear frames take a slot)
 11.94  [Rule] turret.build for armck 8801 | M +71 E 2426/1495 T2 E-float M-float
 12.00  [Playtest] eco team 0 at 12.0 min: metal +75.6 bank 2900/3150, energy +2591.9 bank 13387/13496, units 109
 12.03  [Rule] assist.any for armack 7196 | M +73 E 2439/1526 T2 E-float M-float
 12.03  [Rule] assist.any for armack 18987 | M +73 E 2439/1526 T2 E-float M-float
 12.04  [Rule] assist.any for armack 4608 | M +73 E 2448/1533 T2 E-float M-float
 12.04  [Rule] assist.any for armack 2699 | M +73 E 2448/1533 T2 E-float M-float
 12.05  [Rule] assist.any for armfark 24119 | M +73 E 2448/1533 T2 E-float M-float
 12.05  [Rule] assist.any for armack 1086 | M +73 E 2458/1533 T2 E-float M-float
 12.06  [Rule] assist.any for armack 15655 | M +73 E 2458/1533 T2 E-float M-float
 12.09  [Rule] assist.any for armack 19929 | M +73 E 2487/1537 T2 E-float M-float
 12.09  [Rule] assist.any for armack 674 | M +73 E 2487/1537 T2 E-float M-float
 12.12  [Playtest] finished armmex team 0 at 12.13 min
 12.16  [Rule] storage.metal for armcom 4003 | M +75 E 2556/1568 T2 E-float M-float
 12.18  [Rule] assist.any for armfark 25739 | M +75 E 2531/1572 T2 E-float M-float
 12.35  [Rule] turret.build for armack 19929 | M +76 E 2344/1586 T2 E-float
 12.35  [Rule] turret.build for armack 674 | M +76 E 2340/1590 T2 E-float
 12.36  [Rule] turret.build for armack 7196 | M +76 E 2340/1590 T2 E-float
 12.36  [Rule] turret.build for armack 18987 | M +76 E 2340/1590 T2 E-float
 12.37  [Rule] turret.build for armack 4608 | M +76 E 2335/1592 T2 E-float
 12.38  [Rule] turret.build for armack 2699 | M +76 E 2335/1592 T2 E-float
 12.38  [Rule] turret.build for armack 1086 | M +76 E 2335/1592 T2 E-float
 12.39  [Rule] turret.build for armack 15655 | M +76 E 2329/1592 T2 E-float
 12.47  [Playtest] finished armnanotc team 0 at 12.47 min
 12.48  [Rule] assist.any for armack 19929 | M +76 E 2286/1592 T2 E-float
 12.49  [Rule] assist.any for armack 674 | M +76 E 2286/1592 T2 E-float
 12.49  [Rule] assist.any for armack 7196 | M +76 E 2286/1592 T2 E-float
 12.50  [Rule] assist.any for armack 18987 | M +76 E 2286/1592 T2 E-float
 12.50  [Rule] assist.any for armack 4608 | M +76 E 2281/1592 T2 E-float
 12.51  [Rule] assist.any for armack 2699 | M +76 E 2281/1592 T2 E-float
 12.51  [Rule] assist.any for armack 1086 | M +76 E 2281/1592 T2 E-float
 12.52  [Playtest] finished armmstor team 0 at 12.52 min
 12.81  [Rule] assist.any for armack 674 | M +76 E 2368/1592 T2 E-float
 12.82  [Rule] assist.any for armack 7196 | M +76 E 2403/1592 T2 E-float
 12.82  [Rule] assist.any for armack 18987 | M +76 E 2403/1592 T2 E-float
 12.83  [Rule] assist.any for armack 4608 | M +76 E 2403/1592 T2 E-float
 12.84  [Rule] assist.any for armack 2699 | M +76 E 2439/1592 T2 E-float
 12.85  [Rule] assist.any for armack 1086 | M +76 E 2439/1592 T2 E-float
 12.85  [Rule] assist.any for armack 15655 | M +76 E 2439/1592 T2 E-float
 12.87  [Rule] assist.any for armack 19929 | M +76 E 2515/1592 T2 E-float
 12.93  [Playtest] finished armmex team 0 at 12.93 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +77.6 bank 2690/6250, energy +2790.3 bank 13403/13546, units 115
 13.00  [Rule] assist.any for armack 19929 | M +76 E 2674/1592 T2 E-float
 13.01  [Rule] assist.any for armack 674 | M +76 E 2674/1592 T2 E-float
 13.01  [Rule] assist.any for armack 7196 | M +76 E 2674/1592 T2 E-float
 13.05  [Playtest] finished armnanotc team 0 at 13.05 min
 13.07  [Rule] legacy.strategic for armck 8801 | M +76 E 2713/1592 T2 E-float
 13.15  [Rule] assist.any for armack 7196 | M +77 E 2778/1609 T2 E-float
 13.16  [Rule] assist.any for armack 4608 | M +77 E 2778/1609 T2 E-float
 13.16  [Rule] assist.any for armack 18987 | M +77 E 2778/1609 T2 E-float
 13.16  [Rule] assist.any for armack 2699 | M +77 E 2778/1609 T2 E-float
 13.17  [Rule] assist.any for armack 15655 | M +77 E 2788/1611 T2 E-float
 13.19  [Rule] assist.any for armack 1086 | M +77 E 2796/1611 T2 E-float
 13.21  [Rule] assist.any for armack 19929 | M +77 E 2801/1611 T2 E-float
 13.22  [Rule] assist.any for armack 674 | M +77 E 2805/1611 T2 E-float
 13.29  [Playtest] finished armmex team 0 at 13.29 min
 13.31  [Rule] legacy.strategic for armck 24319 | M +77 E 2805/1611 T2 E-float
 13.85  [Rule] assist.any for armack 2699 | M +79 E 2801/1650 T2 E-float
 13.85  [Rule] assist.any for armack 1086 | M +79 E 2801/1650 T2 E-float
 13.86  [Rule] assist.any for armack 19929 | M +79 E 2801/1650 T2 E-float
 13.87  [Rule] assist.any for armack 15655 | M +79 E 2803/1650 T2 E-float
 13.88  [Rule] assist.any for armack 674 | M +79 E 2803/1650 T2 E-float
 13.88  [Rule] assist.any for armack 7196 | M +79 E 2804/1650 T2 E-float
 13.89  [Rule] assist.any for armack 18987 | M +79 E 2804/1650 T2 E-float
 13.91  [Rule] assist.any for armack 4608 | M +79 E 2804/1650 T2 E-float
 13.96  [Playtest] finished armmex team 0 at 13.96 min
 13.98  [Rule] legacy.strategic for armck 8801 | M +79 E 2802/1650 T2 E-float
 14.00  [Playtest] eco team 0 at 14.0 min: metal +81.4 bank 3940/6350, energy +2805.3 bank 13451/13546, units 117
 14.26  [Rule] assist.any for armack 19929 | M +81 E 2798/1688 T2 E-float
 14.27  [Rule] assist.any for armack 674 | M +81 E 2798/1688 T2 E-float
 14.27  [Rule] assist.any for armack 7196 | M +81 E 2798/1688 T2 E-float
 14.28  [Rule] assist.any for armack 18987 | M +81 E 2798/1688 T2 E-float
 14.29  [Rule] assist.any for armack 2699 | M +81 E 2798/1688 T2 E-float
 14.29  [Rule] assist.any for armack 4608 | M +81 E 2798/1688 T2 E-float
 14.30  [Rule] assist.any for armack 1086 | M +81 E 2798/1688 T2 E-float
 14.30  [Rule] assist.any for armack 15655 | M +81 E 2798/1688 T2 E-float
 14.41  [Playtest] finished armsilo team 0 at 14.41 min
 14.41  [Playtest] finished armmex team 0 at 14.41 min
 14.43  [Playtest] finished armmex team 0 at 14.43 min
 14.45  [Rule] legacy.strategic for armck 1581 | M +81 E 2804/1688 T2 E-float
 14.46  [Rule] legacy.strategic for armck 24319 | M +81 E 2805/1688 T2 E-float
 14.55  [Rule] assist.any for armack 19929 | M +81 E 2805/1688 T2 E-float
 14.55  [Rule] assist.any for armack 674 | M +81 E 2805/1688 T2 E-float
 14.56  [Rule] assist.any for armack 7196 | M +81 E 2805/1688 T2 E-float
 14.56  [Rule] assist.any for armack 18987 | M +81 E 2805/1688 T2 E-float
 14.56  [Rule] assist.any for armack 4608 | M +81 E 2805/1688 T2 E-float
 14.57  [Rule] assist.any for armack 2699 | M +81 E 2805/1692 T2 E-float M-float
 14.58  [Rule] assist.any for armack 1086 | M +81 E 2805/1692 T2 E-float M-float
 14.61  [Rule] assist.any for armack 15655 | M +82 E 2795/1712 T2 E-float M-float
 14.63  [Playtest] finished armmex team 0 at 14.63 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +85.3 bank 5858/6500, energy +2422.6 bank 13339/13546, units 120
 15.00  [Playtest] camera requested (1900,5400) height=2200
 15.02  [Playtest] camera captured name=ta position=(1900,5400) height=2200
 15.02  [Playtest] screenshot at 15.0 min of team 0 at (1900, 5400)
 15.34  [TECH][Build] last factory gone: no lab rebuilt (4 T1 constructors, +85 metal under 200) (D-102)
 15.35  [TECH][Build] start factory ordered on the reserved slot
 15.35  [Rule] lab.t1.opening for armack 2699 | M +85 E 2473/1766 T1 E-float M-float
 15.35  [Ferry] transport lost; donations walk until the next request lands
 15.35  [Ferry] requested a transport (TECH at +20 metal, no transport)
 15.35  [Layout] advanced lab in the turret layout (most slots reach it, nearest the seed) at (2376, 6440): 4 turret slots within 260
 15.35  [Rule] lab.t2 for armack 1086 | M +84 E 2346/1754 T1 E-float M-float
 15.36  [Rule] storage.energy for armck 24319 | M +84 E 2346/1754 T2 E-float M-float
 15.40  [Rule] energy.float for armack 19929 | M +77 E 1386/1615 T2 M-float
 15.42  [Rule] legacy.strategic for armack 15655 | M +77 E 429/1615 T2 E-float M-float
 15.43  [Rule] legacy.strategic for armack 2699 | M +77 E 429/1615 T2 E-float M-float
 15.43  [Rule] legacy.strategic for armack 674 | M +77 E 429/1615 T2 E-float M-float
 15.44  [Rule] storage.metal for armcom 4003 | M +77 E 163/1615 T2 E-float M-float
 15.45  [Rule] legacy.strategic for armack 7196 | M +77 E 163/1615 T2 E-float M-float
 15.45  [Rule] legacy.strategic for armack 18987 | M +77 E 163/1615 T2 E-float M-float
 15.46  [Rule] legacy.strategic for armack 4608 | M +77 E 163/1615 T2 E-float M-float
 15.98  [Ferry] transport 13657 received and reserved; hold pending task
 16.00  [Ferry] reserved: transport 13657 flying to (1900,5397)
 16.00  [Playtest] eco team 0 at 16.0 min: metal +67.9 bank 2334/2700, energy +163.0 bank 798/1950, units 52
 16.22  [Playtest] finished armwin team 0 at 16.22 min
 16.28  [Playtest] finished armmex team 0 at 16.28 min
 16.87  [Playtest] finished armmex team 0 at 16.87 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +71.8 bank 282/2800, energy +187.0 bank 251/1950, units 62
 17.02  [Playtest] finished armestor team 0 at 17.02 min
 17.12  [Playtest] finished armmstor team 0 at 17.12 min
 17.13  [Rule] energy.assist2 for armcom 4003 | M +64 E 185/1344 T2
 17.29  [Playtest] finished armmex team 0 at 17.29 min
 17.73  [Playtest] finished armmex team 0 at 17.73 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +75.6 bank 0/5900, energy +178.7 bank 7025/7950, units 63
 18.54  [Playtest] finished armmex team 0 at 18.54 min
 18.66  [Playtest] finished armmex team 0 at 18.66 min
 18.67  [Playtest] finished armfus team 0 at 18.67 min
 18.69  [Rule] assist.any for armack 4608 | M +75 E 168/1572 T2 E-float
 18.69  [Rule] assist.any for armcom 4003 | M +75 E 168/1572 T2 E-float
 18.95  [Playtest] finished armmex team 0 at 18.95 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +81.5 bank 0/6050, energy +923.0 bank 10319/10450, units 68
 19.16  [Playtest] finished armmex team 0 at 19.16 min
 19.38  [Playtest] finished armmex team 0 at 19.38 min
 19.39  [Rule] order.repair for armck 8801 | M +83 E 927/1724 T2 E-float
 19.64  [Playtest] finished armmex team 0 at 19.64 min
 19.66  [Rule] assist.any for armck 24319 | M +85 E 935/1766 T2 E-float
 19.92  [Playtest] finished armfus team 0 at 19.92 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +87.3 bank 0/6200, energy +1687.7 bank 12809/12950, units 69
 20.78  [Playtest] finished armmex team 0 at 20.78 min
 20.87  [Playtest] finished armfus team 0 at 20.87 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +88.2 bank 0/6250, energy +2437.4 bank 15182/15450, units 71
 21.21  [Playtest] finished armfus team 0 at 21.21 min
 21.23  [Rule] assist.any for armack 674 | M +88 E 2436/1824 T2 E-float
 21.28  [Playtest] finished armfus team 0 at 21.28 min
 21.29  [Playtest] finished armalab team 0 at 21.29 min
 21.29  [Rule] assist.any for armack 15655 | M +88 E 2436/1824 T2 E-float
 21.30  [Rule] assist.any for armack 1086 | M +88 E 2436/1824 T2 E-float
 21.30  [TECH][Build] advanced lab's exit held (zone 173)
 21.30  [Layout] advanced lab 3622: nearest construction turret none (not flush)
 21.34  [TECH][Build] last factory gone: no lab rebuilt (3 T1 constructors, +88 metal under 200) (D-102)
 21.35  [Ferry] transport lost; donations walk until the next request lands
 21.35  [Ferry] requested a transport (TECH at +20 metal, no transport)
 21.86  [Playtest] finished armmex team 0 at 21.86 min
 21.87  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 21.87  [TECH][Build] start factory ordered on the reserved slot
 21.87  [Rule] lab.t1.opening for armcom 4003 | M +70 E 58/1473 T1 E-float
 21.89  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 21.90  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 21.92  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
... 92 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (2024, 5933) facing 1, 63x77 cells: 4513 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2520, 5933) facing 1: 5 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2472, 5933) facing 1: 5 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2424, 5933) facing 1: 5 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2376, 5933) facing 1: 5 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (2600, 6024) facing 1 (id 31)
  0.08  RESERVE: zone 8 at (2808, 6253) facing 1, 21x41 cells: 843 of 861 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2968, 6253) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2920, 6253) facing 1: 9 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2872, 6253) facing 1: 9 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2824, 6253) facing 1: 9 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armshltx at (6512, 2384) facing 1 (id 67)
  0.08  RESERVE: zone 9 at (6296, 2384) facing 1, 15x30 cells: 450 of 450 held
  0.08  RESERVE: grid of armnanotc 10x5 gap 0 behind (6416, 2384) facing 1: 48 of 50 slots (group 7, zone)
  0.08  RESERVE: zone 9 released
  0.08  RESERVE: zone 10 at (6296, 2384) facing 1, 15x24 cells: 360 of 360 held
  0.08  RESERVE: grid of armnanotc 8x5 gap 0 behind (6416, 2384) facing 1: 40 of 40 slots (group 8, zone)
  0.08  RESERVE: zone 11 at (6392, 2384) facing 0, 27x24 cells: 144 of 648 held
  0.08  RESERVE: corridor 12 at (6784, 2384) facing 1, 20x16 cells: 320 of 320 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.09  RESERVE: zone 7 at (15155, 9843) facing 3, 63x77 cells: 4449 of 4851 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14659, 9843) facing 3: 5 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14707, 9843) facing 3: 5 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14755, 9843) facing 3: 5 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14803, 9843) facing 3: 5 of 13 slots (group 5, held, zone)
  0.09  RESERVE: coralab at (14584, 10056) facing 3 (id 31)
  0.09  RESERVE: corlab at (13744, 9440) facing 3 (id 32)
  0.09  RESERVE: zone 8 at (13816, 9440) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of cornanotc 2x1 gap 0 behind (13792, 9440) facing 3: 2 of 2 slots (group 6, zone)
  0.09  RESERVE: corridor 9 at (13768, 9344) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: zone 10 at (13768, 9440) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 10 at (13520, 9440) facing 3, 20x10 cells: 190 of 200 held
  0.09  RESERVE: zone 1 at (14336, 5056) facing 0, 4x4 cells: 16 of 16 held
  0.09  RESERVE: legmex at (14336, 5056) facing 0 (id 1)
  0.09  RESERVE: zone 2 at (14400, 5056) facing 0, 4x4 cells: 16 of 16 held
  0.09  RESERVE: legmex at (14400, 5056) facing 0 (id 2)
  0.09  RESERVE: zone 3 at (14464, 5056) facing 0, 4x4 cells: 16 of 16 held
  0.09  RESERVE: legmex at (14464, 5056) facing 0 (id 3)
  0.09  RESERVE: zone 4 at (14528, 5056) facing 0, 4x4 cells: 16 of 16 held
  0.09  RESERVE: legmex at (14528, 5056) facing 0 (id 4)
  0.09  RESERVE: zone 5 at (14336, 4992) facing 0, 4x4 cells: 16 of 16 held
  0.09  RESERVE: legmex at (14336, 4992) facing 0 (id 5)
  0.09  RESERVE: zone 6 at (14400, 4992) facing 0, 4x4 cells: 16 of 16 held
  0.09  RESERVE: legmex at (14400, 4992) facing 0 (id 6)
  0.09  RESERVE: zone 7 at (14464, 4992) facing 0, 4x4 cells: 16 of 16 held
  0.09  RESERVE: legmex at (14464, 4992) facing 0 (id 7)
  0.09  RESERVE: zone 8 at (14528, 4992) facing 0, 4x4 cells: 16 of 16 held
  0.09  RESERVE: legmex at (14528, 4992) facing 0 (id 8)
  0.09  RESERVE: zone 9 at (14432, 5024) facing 0, 16x8 cells: 0 of 128 held
  0.09  EXP: swap: legcom(8988) from task type 5 to task type 5
  0.16  EXP: approach: armcom(4003) at (1900, 5397) walks to (1876, 5171), 136 from the armmex site (1776, 5264)
  0.16  RESERVE: zone 1 at (1936, 10256) facing 0, 4x4 cells: 16 of 16 held
  0.16  RESERVE: armmex at (1936, 10256) facing 0 (id 1)
  0.16  RESERVE: zone 2 at (2000, 10256) facing 0, 4x4 cells: 16 of 16 held
  0.16  RESERVE: armmex at (2000, 10256) facing 0 (id 2)
  0.16  RESERVE: zone 3 at (2064, 10256) facing 0, 4x4 cells: 16 of 16 held
  0.16  RESERVE: armmex at (2064, 10256) facing 0 (id 3)
  0.16  RESERVE: zone 4 at (2128, 10256) facing 0, 4x4 cells: 16 of 16 held
  0.16  RESERVE: armmex at (2128, 10256) facing 0 (id 4)
  0.16  RESERVE: zone 5 at (1936, 10192) facing 0, 4x4 cells: 16 of 16 held
  0.16  RESERVE: armmex at (1936, 10192) facing 0 (id 5)
  0.16  RESERVE: zone 6 at (2000, 10192) facing 0, 4x4 cells: 16 of 16 held
  0.16  RESERVE: armmex at (2000, 10192) facing 0 (id 6)
  0.16  RESERVE: zone 7 at (2064, 10192) facing 0, 4x4 cells: 16 of 16 held
  0.16  RESERVE: armmex at (2064, 10192) facing 0 (id 7)
  0.16  RESERVE: zone 8 at (2128, 10192) facing 0, 4x4 cells: 16 of 16 held
  0.16  RESERVE: armmex at (2128, 10192) facing 0 (id 8)
  0.16  RESERVE: zone 9 at (2032, 10224) facing 0, 16x8 cells: 0 of 128 held
  0.17  RESERVE: armshltx at (5312, 2384) facing 1 (id 156)
  0.17  RESERVE: zone 13 at (5096, 2384) facing 1, 15x30 cells: 450 of 450 held
  0.17  RESERVE: grid of armnanotc 10x5 gap 0 behind (5216, 2384) facing 1: 14 of 50 slots (group 9, zone)
  0.17  RESERVE: zone 13 released
  0.17  RESERVE: zone 14 at (5096, 2384) facing 1, 15x24 cells: 360 of 360 held
  0.17  RESERVE: grid of armnanotc 8x5 gap 0 behind (5216, 2384) facing 1: 12 of 40 slots (group 10, zone)
  0.17  RESERVE: zone 14 released
  0.17  RESERVE: zone 15 at (5120, 2384) facing 1, 12x24 cells: 288 of 288 held
  0.17  RESERVE: grid of armnanotc 8x4 gap 0 behind (5216, 2384) facing 1: 12 of 32 slots (group 11, zone)
  0.17  RESERVE: zone 15 released
  0.17  RESERVE: zone 16 at (5120, 2384) facing 1, 12x18 cells: 216 of 216 held
  0.17  RESERVE: grid of armnanotc 6x4 gap 0 behind (5216, 2384) facing 1: 10 of 24 slots (group 12, zone)
  0.17  RESERVE: zone 16 released
  0.17  RESERVE: zone 17 at (5144, 2384) facing 1, 9x18 cells: 162 of 162 held
  0.17  RESERVE: grid of armnanotc 6x3 gap 0 behind (5216, 2384) facing 1: 10 of 18 slots (group 13, zone)
  0.17  RESERVE: zone 17 released
  0.17  RESERVE: zone 18 at (5168, 2384) facing 1, 6x10 cells: 60 of 60 held
  0.17  RESERVE: grid of armnanotc 3x2 gap 0 behind (5216, 2384) facing 1: 6 of 6 slots (group 14, zone)
  0.17  RESERVE: zone 18 released
  0.17  RESERVE: armshltx at (5552, 2384) facing 1 (id 221)
  0.17  RESERVE: zone 19 at (5336, 2384) facing 1, 15x30 cells: 450 of 450 held
  0.17  RESERVE: grid of armnanotc 10x5 gap 0 behind (5456, 2384) facing 1: 35 of 50 slots (group 15, zone)
  0.17  RESERVE: zone 19 released
  0.17  RESERVE: zone 20 at (5336, 2384) facing 1, 15x24 cells: 360 of 360 held
  0.17  RESERVE: grid of armnanotc 8x5 gap 0 behind (5456, 2384) facing 1: 30 of 40 slots (group 16, zone)
  0.17  RESERVE: zone 20 released
  0.17  RESERVE: zone 21 at (5360, 2384) facing 1, 12x24 cells: 288 of 288 held
  0.17  RESERVE: grid of armnanotc 8x4 gap 0 behind (5456, 2384) facing 1: 24 of 32 slots (group 17, zone)
  0.17  RESERVE: zone 21 released
  0.17  RESERVE: zone 22 at (5360, 2384) facing 1, 12x18 cells: 216 of 216 held
  0.17  RESERVE: grid of armnanotc 6x4 gap 0 behind (5456, 2384) facing 1: 20 of 24 slots (group 18, zone)
  0.17  RESERVE: zone 22 released
  0.17  RESERVE: zone 23 at (5384, 2384) facing 1, 9x18 cells: 162 of 162 held
  0.17  RESERVE: grid of armnanotc 6x3 gap 0 behind (5456, 2384) facing 1: 15 of 18 slots (group 19, zone)
  0.17  RESERVE: zone 23 released
  0.17  RESERVE: zone 24 at (5408, 2384) facing 1, 6x10 cells: 60 of 60 held
  0.17  RESERVE: grid of armnanotc 3x2 gap 0 behind (5456, 2384) facing 1: 6 of 6 slots (group 20, zone)
  0.17  RESERVE: zone 25 at (5504, 2384) facing 0, 18x12 cells: 12 of 216 held
  0.17  RESERVE: corridor 26 at (5824, 2384) facing 1, 20x16 cells: 320 of 320 held
  0.17  RESERVE: corlab at (13952, 10192) facing 3 (id 35)
  0.17  RESERVE: zone 11 at (14024, 10192) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of cornanotc 2x1 gap 0 behind (14000, 10192) facing 3: 2 of 2 slots (group 7, zone)
  0.17  RESERVE: corridor 12 at (13976, 10096) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: corridor 13 at (13976, 10288) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (13976, 10192) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (13728, 10192) facing 3, 20x10 cells: 180 of 200 held
  0.25  RESERVE: coralab at (14024, 10472) facing 3 (id 38)
  0.25  RESERVE: zone 15 at (14144, 10472) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of cornanotc 2x2 gap 0 behind (14096, 10472) facing 3: 4 of 4 slots (group 8, zone)
  0.25  RESERVE: zone 16 at (14072, 10472) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (13776, 10472) facing 3, 20x13 cells: 260 of 260 held
```
