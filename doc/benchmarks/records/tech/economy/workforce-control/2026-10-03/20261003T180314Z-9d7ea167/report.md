# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 14.2 min (frame 25516); wall 124 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:01:06
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: tech_opening.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-opening\20261003T180106Z-e51a0260\runs\20261003T180314Z-9d7ea167\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `exp on` | seen at 0.1 min | `[TECH][Build] experimental build system on: direct range 1600, search radius 512` |
| expect `opening mex` | seen at 0.3 min | `[Rule] opening.mex for armcom 8988 / M +2 E 30/76 T1 M-float` |
| expect `first lab` | seen at 0.9 min | `[Rule] lab.t1.opening for armcom 8988 / M +6 E 30/116 T1 M-float` |
| expect `energy` | seen at 1.2 min | `[Rule] energy.draining for armcom 8988 / M +4 E 30/94 T1 draining` |
| expect `turret` | seen at 3.9 min | `[Rule] turret.build for armck 21764 / M +12 E 239/195 T1 M-float` |
| expect `advanced lab` | seen at 6.9 min | `[Rule] lab.t2 for armck 21764 / M +37 E 473/769 T1 E-float M-float` |
| forbid `script error` | clean |  |
| forbid `mobile packed` | clean |  |
| forbid `combat early` | clean |  |
| forbid `lab.t1 after t2` | clean |  |
| forbid `default task` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added` |

## Failures

- forbid 'invariant' hit at 12.9 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-opening\20261003T180106Z-e51a0260\runs\20261003T180314Z-9d7ea167\screen_2026-10-03_18-02-21-905.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 30, 3 shots, end at 14.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 34
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 34
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 1, side offset 16 cells, forward offset 0 cells
  0.08  [Layout] home centre (850, 10424), 48 from the start
  0.08  [Layout] turret box 32x44 cells at (850, 9656), from the start rear 0, side 48, ground 99%, halo 84%: zone 7, 4 rows, 40 of 40 turret slots
  0.08  [Layout] advanced lab on the front line at (1290, 9832) facing 1, 1 cells ahead of turret row 0
  0.08  [Layout] the front is (6144, 6144): the labs face 1 (lane (6144, 6144), the pair faces 1)
  0.08  [Layout] advanced lab faces 1 (the pair faces 1)
  0.08  [Layout] advanced lab's footprint reserved at (1288, 9832), 736 from the home centre, 18 turret slots within reach, 5 flush (D-095)
  0.08  [Layout] forward cluster 32x28 cells at (1554, 9912), 8 cells ahead of the main cluster, ground 82%: zone 8, 4 rows, 30 turret slots
  0.08  [Rule] table of 50 rules loaded
  0.31  [Playtest] finished armmex team 0 at 0.31 min
  0.32  [Team][Roster] first mex 1403 at 752,10160
  0.32  [Team][Roster] Re-announced: roster|1|0|0|TECH|armada|armlab|815|10390|0|1|1|752|10160
  0.32  [TECH][Opening] home mex order 1/3 at (672, 10624), 274 from start
  0.32  [Rule] opening.mex for armcom 8988 | M +2 E 30/76 T1 M-float
  0.57  [Playtest] finished armmex team 0 at 0.57 min
  0.58  [TECH][Opening] home mex order 2/3 at (1152, 10512), 358 from start
  0.58  [Rule] opening.mex for armcom 8988 | M +4 E 30/94 T1 M-float
  0.84  [Playtest] finished armmex team 0 at 0.84 min
  0.85  [TECH][Opening] complete after 2 mexes, 46 s: every reachable spot inside the radius is taken and no mex order is pending; the lab is next
  0.85  [TECH][Build] first lab at the commander: (960, 10400), 93 from it, facing 1; the pair's slot stays planned
  0.85  [Rule] lab.t1.opening for armcom 8988 | M +6 E 30/116 T1 M-float
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 869/1150, energy +30.0 bank 216/1000, units 5
  1.17  [Playtest] finished armlab team 0 at 1.17 min
  1.18  [Rule] energy.draining for armcom 8988 | M +4 E 30/94 T1 draining
  1.18  [TECH][Build] first lab's exit held (zone 54) until it is reclaimed
  1.51  [Playtest] finished armwin team 0 at 1.51 min
  1.52  [Rule] energy.draining for armcom 8988 | M +8 E 30/143 T1 draining
  1.66  [Playtest] finished armwin team 0 at 1.66 min
  1.67  [Rule] energy.short for armcom 8988 | M +8 E 39/143 T1
  1.80  [Playtest] finished armwin team 0 at 1.80 min
  1.81  [Rule] energy.short for armcom 8988 | M +8 E 39/143 T1
  1.94  [Playtest] finished armwin team 0 at 1.94 min
  1.95  [Rule] energy.short for armcom 8988 | M +8 E 48/143 T1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 903/1250, energy +77.8 bank 80/1102, units 11
  2.10  [Playtest] finished armwin team 0 at 2.10 min
  2.11  [Rule] energy.draining for armcom 8988 | M +8 E 68/143 T1 draining
  2.24  [Playtest] finished armwin team 0 at 2.24 min
  2.24  [TECH][Build] armck 15553 expands to a mex at (368, 9392) at +8 metal
  2.24  [Rule] mex.expand for armck 15553 | M +8 E 79/143 T1 draining
  2.25  [Rule] energy.short for armcom 8988 | M +8 E 88/143 T1
  2.39  [Playtest] finished armwin team 0 at 2.39 min
  2.40  [Rule] energy.short for armcom 8988 | M +8 E 118/143 T1
  2.51  [Playtest] finished armwin team 0 at 2.51 min
  2.62  [Playtest] finished armwin team 0 at 2.62 min
  2.65  [TECH][Build] armck 15573 expands to a mex at (1904, 11712) at +8 metal
  2.65  [Rule] mex.expand for armck 15573 | M +8 E 132/143 T1 E-float
  2.76  [Rule] energy.convert for armcom 8988 | M +8 E 149/143 T1 E-float
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 958/1250, energy +214.0 bank 1011/1204, units 19
  3.00  [Playtest] finished armmakr team 0 at 3.00 min
  3.01  [Rule] energy.convert for armcom 8988 | M +8 E 204/143 T1
  3.05  [TECH][Build] armck 1581 expands to a mex at (2320, 11536) at +8 metal
  3.05  [Rule] mex.expand for armck 1581 | M +8 E 204/143 T1 E-float
  3.18  [Playtest] finished armmex team 0 at 3.18 min
  3.20  [TECH][Build] armck 15553 expands to a mex at (816, 7424) at +9 metal
  3.20  [Rule] mex.expand for armck 15553 | M +9 E 214/146 T1
  3.21  [Playtest] finished armmakr team 0 at 3.21 min
  3.22  [Rule] energy.convert for armcom 8988 | M +9 E 216/149 T1
  3.39  [Playtest] finished armmakr team 0 at 3.39 min
  3.40  [Rule] energy.float for armcom 8988 | M +11 E 209/173 T1 M-float
  3.45  [TECH][Build] armck 26507 expands to a mex at (2848, 11008) at +11 metal
  3.45  [Rule] mex.expand for armck 26507 | M +11 E 202/173 T1 M-float
  3.51  [Playtest] finished armwin team 0 at 3.51 min
  3.66  [Playtest] finished armwin team 0 at 3.66 min
  3.76  [Playtest] finished armmex team 0 at 3.76 min
  3.77  [TECH][Build] armck 15573 expands to a mex at (2288, 11968) at +12 metal
  3.77  [Rule] mex.expand for armck 15573 | M +12 E 222/191 T1 M-float
  3.84  [Playtest] finished armwin team 0 at 3.84 min
  3.86  [TECH][Build] no open mex spot within 2500 of armck 21764 at +12 metal
  3.86  [Layout] turrets: order 1 of 1 allowed (build power 150 (0 by power), bank 1142 + 15/s (8 by metal), 0 dear frames take a slot)
  3.86  [Rule] turret.build for armck 21764 | M +12 E 239/195 T1 M-float
  3.96  [Playtest] finished armwin team 0 at 3.96 min
  3.98  [Rule] energy.short for armcom 8988 | M +14 E 203/220 T1 M-float
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.3 bank 1162/1350, energy +179.6 bank 1048/1356, units 30
  4.09  [Playtest] finished armwin team 0 at 4.09 min
  4.20  [Playtest] finished armmex team 0 at 4.20 min
  4.20  [Rule] turret.build for armrectr 23225 | M +13 E 170/208 T1 M-float
  4.21  [TECH][Build] armck 1581 expands to a mex at (4608, 11072) at +13 metal
  4.21  [Rule] mex.expand for armck 1581 | M +13 E 170/208 T1 M-float
  4.26  [Playtest] finished armwin team 0 at 4.26 min
  4.40  [Playtest] finished armmex team 0 at 4.40 min
  4.41  [Rule] turret.build for armck 15573 | M +15 E 210/246 T1 M-float
  4.42  [Playtest] finished armwin team 0 at 4.42 min
  4.44  [Rule] energy.short for armcom 8988 | M +16 E 228/263 T1 M-float
  4.53  [Playtest] finished armwin team 0 at 4.53 min
  4.55  [Playtest] finished armmex team 0 at 4.55 min
  4.57  [TECH][Build] armck 15553 expands to a mex at (544, 7168) at +19 metal
  4.57  [Rule] mex.expand for armck 15553 | M +19 E 249/305 T1 M-float
  4.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
  4.68  [Playtest] finished armmex team 0 at 4.68 min
  4.69  [Playtest] finished armwin team 0 at 4.69 min
  4.69  [TECH][Build] armck 26507 expands to a mex at (4896, 10800) at +20 metal
  4.69  [Rule] mex.expand for armck 26507 | M +20 E 304/327 T1 M-float
  4.70  [Rule] energy.short for armcom 8988 | M +20 E 306/329 T1 M-float
  4.87  [Playtest] finished armwin team 0 at 4.87 min
  4.88  [Rule] energy.float for armcom 8988 | M +25 E 333/438 T1 E-float M-float
  5.00  [Playtest] finished armwin team 0 at 5.00 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +25.7 bank 1549/1550, energy +314.8 bank 1240/1360, units 42
  5.00  [Playtest] target team 0 at (837, 10407) from its start position
  5.00  [Playtest] camera requested (837,10407) height=2200
  5.01  [Rule] power.turret for armcom 8988 | M +25 E 318/448 T1 E-float M-float
  5.02  [Playtest] camera captured name=ta position=(837,10407) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (837, 10407)
  5.04  [Rule] power.turret for armrectr 23225 | M +25 E 318/448 T1 E-float M-float
  5.11  [Playtest] finished armmex team 0 at 5.11 min
  5.12  [Rule] power.turret for armck 15553 | M +25 E 293/448 T1 M-float
  5.13  [Playtest] finished armnanotc team 0 at 5.13 min
  5.15  [Rule] defence.fortify for armck 21764 | M +25 E 278/448 T1 M-float
  5.15  [Rule] defence.fortify for armck 15573 | M +25 E 262/448 T1 M-float
  5.16  [TECH][Build] no open mex spot within 2500 of armrectr 23225 at +25 metal
  5.16  [Rule] energy.short for armcom 8988 | M +25 E 262/448 T1 M-float
  5.17  [TECH][Build] armck 15553 expands to a mex at (832, 7072) at +25 metal
  5.17  [Rule] mex.expand for armck 15553 | M +25 E 262/448 T1 M-float
  5.28  [Rule] power.turret for armrectr 23225 | M +27 E 167/480 T1 M-float
  5.39  [Playtest] finished armwin team 0 at 5.39 min
  5.40  [Rule] power.turret for armcom 8988 | M +26 E 162/462 T1 M-float
  5.60  [Playtest] finished armdrag team 0 at 5.60 min
  5.61  [Rule] defence.fortify for armck 21764 | M +27 E 284/493 T1 E-float M-float
  5.63  [Playtest] finished armmex team 0 at 5.63 min
  5.65  [Layout] turrets: order 1 of 1 allowed (build power 390 (1 by power), bank 1623 + 30/s (8 by metal), 0 dear frames take a slot)
  5.65  [Rule] power.turret for armck 15553 | M +27 E 319/504 T1 E-float M-float
  5.66  [Playtest] finished armmex team 0 at 5.66 min
  5.68  [Playtest] finished armdrag team 0 at 5.68 min
  5.68  [TECH][Build] armck 1581 expands to a mex at (4896, 11328) at +28 metal
  5.68  [Rule] mex.expand for armck 1581 | M +28 E 344/505 T1 E-float M-float
  5.69  [Rule] defence.fortify for armck 21764 | M +28 E 352/505 T1 E-float M-float
  5.70  [Rule] storage.energy for armcom 8988 | M +28 E 352/505 T1 E-float M-float
  5.76  [Rule] power.turret for armrectr 23225 | M +28 E 356/505 T1 E-float M-float
  5.76  [Playtest] finished armdrag team 0 at 5.76 min
  5.77  [Rule] defence.fortify for armck 21764 | M +28 E 356/505 T1 E-float M-float
  5.84  [Rule] power.turret for armrectr 23225 | M +32 E 364/616 T1 E-float M-float
  5.85  [Playtest] finished armdrag team 0 at 5.85 min
  5.86  [Rule] defence.fortify for armck 21764 | M +32 E 370/616 T1 E-float M-float
  5.94  [Playtest] finished armdrag team 0 at 5.94 min
  5.96  [Rule] defence.fortify for armck 21764 | M +32 E 403/629 T1 M-float
  5.98  [Playtest] finished armdrag team 0 at 5.98 min
  5.99  [Playtest] finished armestor team 0 at 5.99 min
  6.00  [Rule] defence.fortify for armck 15573 | M +32 E 408/629 T1 M-float
  6.00  [Playtest] eco team 0 at 6.0 min: metal +32.6 bank 1698/1700, energy +460.1 bank 1321/7360, units 56
  6.01  [Rule] power.turret for armcom 8988 | M +32 E 411/620 T1 M-float
  6.02  [Playtest] finished armdrag team 0 at 6.02 min
  6.04  [Rule] defence.fortify for armck 21764 | M +31 E 419/587 T1 M-float
  6.05  [Playtest] finished armdrag team 0 at 6.05 min
  6.07  [Playtest] finished armmex team 0 at 6.07 min
  6.08  [Rule] power.turret for armck 26507 | M +29 E 435/554 T1 M-float
  6.12  [Playtest] finished armdrag team 0 at 6.12 min
  6.12  [Playtest] finished armdrag team 0 at 6.13 min
  6.13  [TECH][Build] armck 26507 expands to a mex at (5040, 10048) at +29 metal
  6.13  [Rule] mex.expand for armck 26507 | M +29 E 446/554 T1 M-float
  6.13  [Rule] defence.fortify for armck 21764 | M +29 E 451/554 T1 M-float
  6.15  [Rule] defence.fortify for armck 15573 | M +29 E 451/554 T1 M-float
  6.20  [TECH][Build] no open mex spot within 2500 of armrectr 23225 at +29 metal
  6.21  [Rule] energy.short for armcom 8988 | M +29 E 461/554 T1 M-float
  6.23  [Playtest] finished armmex team 0 at 6.23 min
  6.25  [TECH][Build] armck 1581 expands to a mex at (5840, 11984) at +31 metal
  6.25  [Rule] mex.expand for armck 1581 | M +31 E 461/603 T1 M-float
  6.33  [Rule] power.turret for armrectr 23225 | M +31 E 461/610 T1 E-float M-float
  6.37  [Playtest] finished armdrag team 0 at 6.37 min
  6.38  [Rule] defence.fortify for armck 21764 | M +33 E 462/653 T1 E-float M-float
  6.39  [Playtest] finished armdrag team 0 at 6.39 min
  6.40  [Rule] defence.fortify for armck 15573 | M +36 E 462/752 T1 E-float M-float
  6.47  [Playtest] finished armdrag team 0 at 6.47 min
  6.47  [Rule] power.turret for armrectr 23225 | M +37 E 463/769 T1 E-float M-float
  6.48  [Rule] defence.fortify for armck 21764 | M +37 E 463/769 T1 E-float M-float
  6.48  [Playtest] finished armdrag team 0 at 6.48 min
  6.49  [Rule] defence.fortify for armck 15573 | M +37 E 463/769 T1 E-float M-float
  6.51  [Playtest] finished armwin team 0 at 6.51 min
  6.53  [Rule] power.turret for armcom 8988 | M +37 E 463/769 T1 E-float M-float
  6.57  [Rule] power.turret for armrectr 23225 | M +37 E 463/769 T1 E-float M-float
  6.57  [Playtest] finished armdrag team 0 at 6.57 min
  6.59  [Rule] defence.fortify for armck 21764 | M +37 E 463/769 T1 E-float M-float
  6.61  [Playtest] finished armdrag team 0 at 6.61 min
  6.62  [Rule] defence.fortify for armck 15573 | M +37 E 463/769 T1 E-float M-float
  6.68  [Rule] power.turret for armrectr 23225 | M +37 E 475/769 T1 E-float M-float
  6.69  [Rule] power.turret for armcom 8988 | M +37 E 475/769 T1 E-float M-float
  6.69  [Playtest] finished armdrag team 0 at 6.69 min
  6.70  [Rule] defence.fortify for armck 21764 | M +37 E 477/769 T1 E-float M-float
  6.71  [Playtest] finished armdrag team 0 at 6.71 min
  6.72  [Rule] defence.fortify for armck 15573 | M +37 E 479/769 T1 E-float M-float
  6.79  [Playtest] finished armdrag team 0 at 6.79 min
  6.80  [Rule] power.turret for armrectr 23225 | M +37 E 482/769 T1 E-float M-float
  6.80  [Rule] power.turret for armcom 8988 | M +37 E 482/769 T1 E-float M-float
  6.80  [Rule] defence.fortify for armck 21764 | M +37 E 482/769 T1 E-float M-float
  6.81  [Playtest] finished armdrag team 0 at 6.81 min
  6.82  [Rule] defence.fortify for armck 15573 | M +37 E 482/769 T1 E-float M-float
  6.86  [Playtest] finished armmex team 0 at 6.86 min
  6.87  [Layout] turrets: order 2 of 2 allowed (build power 540 (2 by power), bank 1833 + 39/s (8 by metal), 0 dear frames take a slot)
  6.87  [Rule] power.turret for armck 26507 | M +37 E 477/769 T1 E-float M-float
  6.89  [Rule] power.turret for armrectr 23225 | M +37 E 475/769 T1 E-float M-float
  6.89  [Rule] power.turret for armcom 8988 | M +37 E 475/769 T1 E-float M-float
  6.90  [Playtest] finished armdrag team 0 at 6.90 min
  6.91  [Layout] advanced lab on its planned slot (1288, 9832): 18 turret slots within 260
  6.91  [Rule] lab.t2 for armck 21764 | M +37 E 473/769 T1 E-float M-float
  6.98  [Rule] power.turret for armrectr 23225 | M +37 E 467/769 T2 E-float M-float
  6.99  [Rule] power.turret for armcom 8988 | M +37 E 466/769 T2 E-float M-float
  7.00  [Playtest] eco team 0 at 7.0 min: metal +39.3 bank 1849/1850, energy +466.2 bank 7306/7361, units 73
  7.19  [Playtest] finished armmex team 0 at 7.19 min
  7.20  [Rule] power.turret for armck 1581 | M +39 E 464/835 T2 E-float M-float
  7.23  [Playtest] finished armnanotc team 0 at 7.23 min
  7.25  [Layout] turrets: order 2 of 2 allowed (build power 780 (2 by power), bank 1900 + 41/s (8 by metal), 0 dear frames take a slot)
  7.26  [Rule] defence.fortify for armck 15553 | M +39 E 463/835 T2 E-float M-float
  7.54  [Playtest] finished armllt team 0 at 7.54 min
  7.55  [TECH][Build] T1 lab reclaim deferred: metal 1879 of 1900 leaves no room for its 500
  7.55  [Rule] power.turret for armck 15573 | M +41 E 433/891 T2 E-float M-float
  7.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
  7.75  [TECH][Build] no open mex spot within 2500 of armrectr 23225 at +38 metal
  7.75  [Rule] assist.any for armrectr 23225 | M +38 E 277/811 T2 M-float
  7.93  [TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab 29161; idle build power in range joins
  7.93  [Rule] lab.t1.reclaim for armck 15573 | M +38 E 220/811 T2 draining
  7.93  [Rule] lab.t1.reclaim for armrectr 23225 | M +38 E 220/811 T2 draining
  7.94  [Rule] lab.t1.reclaim for armcom 8988 | M +38 E 220/811 T2 draining
  8.00  [Playtest] eco team 0 at 8.0 min: metal +38.6 bank 963/1900, energy +256.0 bank 198/7361, units 76
  8.18  [Playtest] finished armrl team 0 at 8.18 min
  8.19  [Rule] lab.t1.reclaim for armck 15553 | M +38 E 228/811 T2 draining
  8.28  [Playtest] finished armalab team 0 at 8.28 min
  8.28  [Layout] advanced lab 11798: nearest construction turret 112 elmos (flush)
  8.28  [Layout] advanced lab 11798: faces 1, the front 1, 0 structures in its exit lane
  8.28  [Layout] factory armalab 11798 stands 1 cell(s) from a turret
  8.29  [Rule] lab.t1.reclaim for armck 21764 | M +38 E 204/811 T2 draining
  8.29  [TECH][Factory] armalab: T2 constructor 1 of 10 (bank 1199 of 2100) (D-103)
  8.32  [TECH][Build] armck 21764 expands to a mex at (2368, 8128) at +38 metal
  8.32  [Rule] mex.expand for armck 21764 | M +38 E 203/811 T2
  8.32  [TECH][Build] first lab gone: its exit (zone 54) released
  8.32  [Rule] energy.draining for armck 15573 | M +38 E 203/811 T2 draining M-float
  8.33  [Rule] storage.metal for armcom 8988 | M +38 E 203/811 T2 draining M-float
  8.33  [Rule] storage.metal for armck 15553 | M +38 E 203/811 T2 draining M-float
  8.66  [Rule] assist.any for armrectr 23225 | M +38 E 286/811 T2 M-float
  8.82  [Playtest] finished armmstor team 0 at 8.82 min
  8.83  [TECH][Build] armack 13417 expands to a mex at (2784, 8048) at +35 metal
  8.83  [Rule] mex.expand for armack 13417 | M +35 E 258/724 T2 draining M-float
  8.83  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 1938 of 2000) (D-103)
  8.84  [TECH][Build] no open mex spot within 2500 of armrectr 23225 at +35 metal
  8.84  [Rule] energy.assist2 for armrectr 23225 | M +35 E 258/724 T2
  8.84  [Rule] energy.assist2 for armcom 8988 | M +35 E 258/724 T2
  9.00  [Playtest] eco team 0 at 9.0 min: metal +36.3 bank 2084/5000, energy +389.2 bank 0/7561, units 80
  9.19  [Playtest] finished armadvsol team 0 at 9.19 min
  9.21  [Rule] power.turret for armck 15573 | M +36 E 397/731 T2
  9.21  [Rule] power.turret for armrectr 23225 | M +36 E 397/731 T2
  9.21  [Rule] power.turret for armcom 8988 | M +36 E 397/731 T2
  9.24  [Playtest] finished armmstor team 0 at 9.24 min
  9.25  [Rule] energy.draining for armck 15573 | M +37 E 404/789 T2 draining
  9.27  [TECH][Build] armck 15553 expands to a mex at (2496, 7776) at +38 metal
  9.27  [Rule] mex.expand for armck 15553 | M +38 E 406/811 T2 draining
  9.32  [Rule] energy.assist for armrectr 23225 | M +38 E 416/811 T2 draining
  9.33  [Rule] energy.assist for armcom 8988 | M +38 E 416/811 T2 draining
  9.44  [Rule] defence.fortify for armack 5373 | M +38 E 519/811 T2
  9.57  [Playtest] finished armadvsol team 0 at 9.57 min
  9.58  [Rule] power.turret for armck 15573 | M +38 E 534/811 T2 draining
  9.59  [Rule] power.turret for armrectr 23225 | M +38 E 540/811 T2
  9.59  [Rule] power.turret for armcom 8988 | M +38 E 540/811 T2
  9.75  [Playtest] finished armnanotc team 0 at 9.75 min
  9.83  [Layout] turrets: order 4 of 4 allowed (build power 1170 (4 by power), bank 2540 + 39/s (50 by metal), 0 dear frames take a slot)
  9.83  [Rule] power.turret for armck 26507 | M +38 E 637/811 T2
  9.83  [Rule] power.turret for armck 15573 | M +38 E 637/811 T2
  9.84  [Rule] power.turret for armrectr 23225 | M +38 E 636/811 T2
  9.84  [Rule] power.turret for armcom 8988 | M +38 E 636/811 T2
  9.86  [Playtest] finished armfort team 0 at 9.86 min
  9.89  [Rule] defence.fortify for armack 5373 | M +38 E 623/811 T2
  9.98  [Playtest] finished armnanotc team 0 at 9.98 min
  9.99  [Playtest] finished armfort team 0 at 9.99 min
  9.99  [TECH][Build] no open mex spot within 2500 of armck 26507 at +40 metal
  9.99  [Rule] legacy.strategic for armck 26507 | M +40 E 594/865 T2
 10.00  [Rule] legacy.strategic for armck 15573 | M +40 E 594/865 T2
 10.00  [Playtest] eco team 0 at 10.0 min: metal +41.6 bank 2700/8000, energy +590.4 bank 6358/7861, units 86
 10.01  [Rule] defence.fortify for armack 5373 | M +40 E 592/877 T2
 10.14  [Rule] assist.any for armrectr 23225 | M +41 E 591/891 T2 E-float
 10.14  [Playtest] finished armfort team 0 at 10.14 min
 10.16  [Rule] defence.fortify for armack 5373 | M +41 E 591/891 T2 E-float
 10.23  [Rule] assist.any for armrectr 23225 | M +41 E 599/891 T2 E-float
 10.24  [TECH][Build] armck 26507 expands to a mex at (3424, 8128) at +41 metal
 10.24  [Rule] mex.expand for armck 26507 | M +41 E 603/891 T2 E-float
 10.25  [Playtest] finished armfort team 0 at 10.25 min
 10.32  [Rule] assist.any for armrectr 23225 | M +41 E 618/891 T2 E-float
 10.35  [Playtest] finished armfort team 0 at 10.35 min
 10.44  [Rule] assist.any for armrectr 23225 | M +41 E 658/891 T2 E-float
 10.46  [Playtest] finished armfort team 0 at 10.46 min
 10.48  [Rule] defence.fortify for armack 5373 | M +41 E 658/891 T2 E-float
 10.54  [Rule] assist.any for armrectr 23225 | M +41 E 658/891 T2 E-float
 10.55  [Playtest] finished armfort team 0 at 10.55 min
 10.56  [Rule] defence.fortify for armack 5373 | M +41 E 658/891 T2 E-float
 10.63  [Rule] assist.any for armrectr 23225 | M +41 E 659/891 T2 E-float
 10.65  [Rule] assist.any for armcom 8988 | M +41 E 661/891 T2 E-float
 10.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
 10.66  [Playtest] finished armfort team 0 at 10.66 min
 10.68  [Rule] defence.fortify for armack 5373 | M +41 E 665/891 T2 E-float
 10.72  [Playtest] finished armnanotc team 0 at 10.72 min
 10.73  [Rule] legacy.strategic for armck 1581 | M +41 E 670/886 T2
 10.76  [Playtest] finished armmex team 0 at 10.76 min
 10.77  [Playtest] finished armfort team 0 at 10.77 min
 10.77  [TECH][Build] armck 15553 expands to a mex at (1168, 6400) at +41 metal
 10.77  [Rule] mex.expand for armck 15553 | M +41 E 670/886 T2
 10.79  [Rule] defence.fortify for armack 5373 | M +41 E 670/886 T2
 10.86  [Rule] assist.any for armrectr 23225 | M +41 E 669/886 T2 E-float
 10.87  [Playtest] finished armfort team 0 at 10.87 min
 10.89  [Rule] defence.fortify for armack 5373 | M +41 E 666/886 T2 E-float
 10.95  [Playtest] finished armmex team 0 at 10.95 min
 10.96  [TECH][Build] armck 21764 expands to a mex at (4512, 7600) at +43 metal
 10.96  [Rule] mex.expand for armck 21764 | M +43 E 663/927 T2 E-float
 10.99  [TECH][Build] no open mex spot within 2500 of armck 1581 at +43 metal
 11.00  [Playtest] eco team 0 at 11.0 min: metal +46.2 bank 4059/8100, energy +667.7 bank 7847/7861, units 97
 11.02  [TECH][Factory] armalab: T2 constructor 3 of 10 (bank 4059 of 8100) (D-103)
 11.10  [Rule] assist.any for armrectr 23225 | M +43 E 663/937 T2
 11.14  [Playtest] finished armfort team 0 at 11.14 min
 11.16  [Rule] defence.fortify for armack 5373 | M +44 E 666/947 T2
 11.18  [Playtest] finished armmoho team 0 at 11.18 min
 11.19  [Rule] mex.upgrade for armack 4591 | M +43 E 668/935 T2
 11.19  [TECH][Build] armack 13417 expands to a mex at (4528, 7216) at +43 metal
 11.19  [Rule] mex.expand for armack 13417 | M +43 E 668/935 T2
 11.23  [Rule] assist.any for armrectr 23225 | M +43 E 670/935 T2
 11.25  [Rule] defence.fortify for armck 1581 | M +43 E 670/935 T2
 11.26  [Playtest] finished armfort team 0 at 11.26 min
 11.28  [Rule] legacy.strategic for armack 5373 | M +43 E 670/935 T2
 11.38  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 4606 of 8700) (D-103)
 11.51  [Rule] defence.fortify for armck 15573 | M +54 E 660/1149 T2
 11.53  [Rule] assist.any for armcom 8988 | M +53 E 657/1125 T2
 11.55  [Rule] mex.upgrade for armack 6357 | M +53 E 657/1125 T2
 11.55  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 4655 of 8700) (D-103)
 11.55  [Rule] assist.any for armrectr 23225 | M +52 E 657/1113 T2
 11.70  [Rule] assist.any for armack 28095 | M +52 E 659/1107 T2
 11.71  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 4652 of 8700) (D-103)
 11.88  [Rule] mex.upgrade for armack 1409 | M +52 E 689/1107 T2
 11.88  [TECH][Factory] armalab: T2 constructor 7 of 10 (bank 4605 of 8700) (D-103)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +52.4 bank 4688/8700, energy +524.3 bank 174/8261, units 110
 12.01  [Playtest] finished armmex team 0 at 12.01 min
 12.02  [Layout] turrets: order 3 of 6 allowed (build power 2550 (9 by power), bank 4692 + 54/s (40 by metal), 2 dear frames take a slot)
 12.02  [Rule] power.t1 for armck 15553 | M +52 E 527/1107 T2 draining
 12.04  [TECH][Build] no open mex spot within 2500 of armrectr 23225 at +52 metal
 12.08  [Playtest] finished armmex team 0 at 12.08 min
 12.09  [Layout] turrets: order 4 of 6 allowed (build power 2550 (9 by power), bank 4744 + 51/s (38 by metal), 2 dear frames take a slot)
 12.09  [Rule] power.t1 for armck 26507 | M +50 E 497/1079 T2 draining
 12.23  [Playtest] finished armmoho team 0 at 12.23 min
 12.25  [Rule] energy.draining for armcom 8988 | M +49 E 491/1047 T2 draining
 12.26  [Rule] assist.any for armack 4591 | M +49 E 491/1047 T2
 12.36  [Playtest] finished armwin team 0 at 12.36 min
 12.37  [Rule] assist.any for armcom 8988 | M +51 E 496/1089 T2
 12.72  [Playtest] finished armmoho team 0 at 12.72 min
 12.74  [Rule] energy.draining for armcom 8988 | M +48 E 507/1033 T2 draining
 12.74  [Rule] mex.upgrade for armack 28095 | M +48 E 507/1033 T2 draining
 12.75  [Rule] assist.any for armack 6357 | M +48 E 507/1033 T2 draining
 12.92  [Playtest] finished armmex team 0 at 12.92 min
 12.93  [Layout] turrets: order 5 of 6 allowed (build power 1950 (7 by power), bank 6013 + 73/s (191 by metal), 1 dear frames take a slot)
 12.93  [Rule] power.t1 for armck 21764 | M +70 E 624/1475 T2
 13.00  [Playtest] eco team 0 at 13.0 min: metal +73.1 bank 6149/9950, energy +642.2 bank 742/8261, units 111
 13.08  [Rule] energy.draining for armcom 8988 | M +70 E 637/1475 T2 draining
 13.11  [Playtest] finished armdrag team 0 at 13.11 min
 13.12  [Layout] turrets: order 6 of 6 allowed (build power 1950 (7 by power), bank 6331 + 73/s (201 by metal), 1 dear frames take a slot)
 13.12  [Rule] power.t1 for armck 1581 | M +73 E 639/1521 T2 draining
 13.20  [Playtest] finished armmoho team 0 at 13.20 min
 13.22  [Rule] power.turret for armrectr 23225 | M +73 E 643/1521 T2
 13.22  [Rule] defence.fortify for armack 1409 | M +73 E 643/1521 T2
 13.23  [Rule] power.turret for armack 6357 | M +73 E 643/1521 T2
 13.23  [Rule] power.turret for armack 4591 | M +73 E 643/1521 T2
 13.24  [Playtest] finished armwin team 0 at 13.24 min
 13.25  [Rule] power.turret for armcom 8988 | M +73 E 645/1521 T2 draining
 13.43  [Playtest] finished armdrag team 0 at 13.43 min
 13.43  [Rule] mex.upgrade for armack 15323 | M +79 E 714/1659 T2 draining
 13.44  [TECH][Factory] armalab: T2 constructor 8 of 10 (bank 7032 of 10500) (D-103)
 13.44  [Rule] defence.fortify for armck 15573 | M +79 E 707/1659 T2
 13.49  [Playtest] finished armmoho team 0 at 13.49 min
 13.57  [Rule] turret.build for armack 13417 | M +79 E 656/1659 T2
 13.60  [Playtest] finished armdrag team 0 at 13.60 min
 13.62  [Rule] energy.draining for armck 15573 | M +79 E 656/1659 T2 draining
 13.62  [Rule] turret.build for armrectr 23225 | M +79 E 656/1659 T2 draining
 13.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
 13.98  [Playtest] finished armfort team 0 at 13.98 min
 13.99  [Rule] turret.build for armack 1409 | M +89 E 735/1843 T2 draining
 14.00  [Playtest] eco team 0 at 14.0 min: metal +89.2 bank 8378/11100, energy +732.8 bank 1/8362, units 119
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (707, 9656) facing 1, 63x69 cells: 3906 of 4347 held
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1203, 9656) facing 1: 10 of 10 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1155, 9656) facing 1: 10 of 10 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1107, 9656) facing 1: 10 of 10 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1059, 9656) facing 1: 10 of 10 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1288, 9832) facing 1 (id 51)
  0.08  RESERVE: zone 8 at (1555, 9912) facing 1, 29x33 cells: 939 of 957 held
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1779, 9912) facing 1: 10 of 10 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1731, 9912) facing 1: 10 of 10 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1683, 9912) facing 1: 5 of 10 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1635, 9912) facing 1: 5 of 10 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (2064, 8464) facing 1 (id 82)
  0.08  RESERVE: zone 9 at (1992, 8464) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2016, 8464) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (2352, 8384) facing 1 (id 85)
  0.08  RESERVE: zone 10 at (2280, 8384) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2304, 8384) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: armlab at (2272, 8288) facing 1 (id 88)
  0.08  RESERVE: zone 11 at (2200, 8288) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2224, 8288) facing 1: 2 of 2 slots (group 9, zone)
  0.08  RESERVE: corridor 12 at (2248, 8384) facing 1, 21x6 cells: 108 of 126 held
  0.08  RESERVE: zone 13 at (2248, 8288) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (2496, 8288) facing 1, 20x10 cells: 190 of 200 held
  0.08  EXP: approach: armcom(8988) at (815, 10390) walks to (788, 10291), 136 from the armmex site (752, 10160)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.08  RESERVE: zone 7 at (11581, 2536) facing 3, 63x77 cells: 4408 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11085, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11133, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11181, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11229, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (11000, 2296) facing 3 (id 63)
  0.08  RESERVE: zone 8 at (10605, 2216) facing 3, 45x41 cells: 1827 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (10253, 2216) facing 3: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (10301, 2216) facing 3: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (10349, 2216) facing 3: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (10397, 2216) facing 3: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (10224, 3824) facing 3 (id 116)
  0.08  RESERVE: zone 9 at (10296, 3824) facing 3, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (10272, 3824) facing 3: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (10248, 3920) facing 3, 21x6 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (10248, 3824) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (10000, 3824) facing 3, 20x10 cells: 190 of 200 held
  0.17  RESERVE: armlab at (3184, 8544) facing 1 (id 91)
  0.17  RESERVE: zone 14 at (3112, 8544) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3136, 8544) facing 1: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: armlab at (3104, 8448) facing 1 (id 94)
  0.17  RESERVE: zone 15 at (3032, 8448) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3056, 8448) facing 1: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: corridor 16 at (3080, 8544) facing 1, 21x6 cells: 108 of 126 held
  0.17  RESERVE: zone 17 at (3080, 8448) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 17 at (3328, 8448) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: armlab at (9648, 3968) facing 3 (id 119)
  0.17  RESERVE: zone 12 at (9720, 3968) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (9696, 3968) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (9672, 4064) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (9672, 3968) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (9424, 3968) facing 3, 20x10 cells: 190 of 200 held
  0.23  EXP: approach: armcom(21467) at (11494, 1983) walks to (11576, 1804), 136 from the armmex site (11632, 1680)
  0.25  RESERVE: armalab at (1672, 8408) facing 1 (id 97)
  0.25  RESERVE: zone 18 at (1552, 8408) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (1600, 8408) facing 1: 4 of 4 slots (group 12, zone)
  0.25  RESERVE: zone 19 at (1624, 8408) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 20 at (1920, 8408) facing 1, 20x13 cells: 242 of 260 held
  0.25  RESERVE: zone 21 at (2112, 9904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 9904) facing 0 (id 102)
  0.25  RESERVE: zone 22 at (2112, 9936) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 9936) facing 0 (id 103)
  0.25  RESERVE: zone 23 at (2112, 9968) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 9968) facing 0 (id 104)
  0.25  RESERVE: zone 24 at (2112, 10000) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10000) facing 0 (id 105)
  0.25  RESERVE: zone 25 at (2112, 10032) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10032) facing 0 (id 106)
  0.25  RESERVE: zone 26 at (2112, 10064) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10064) facing 0 (id 107)
  0.25  RESERVE: zone 27 at (2112, 10096) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10096) facing 0 (id 108)
  0.25  RESERVE: zone 28 at (2112, 10128) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10128) facing 0 (id 109)
  0.25  RESERVE: zone 29 at (2112, 10160) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10160) facing 0 (id 110)
  0.25  RESERVE: zone 30 at (2112, 10192) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10192) facing 0 (id 111)
  0.25  RESERVE: zone 31 at (2112, 10224) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10224) facing 0 (id 112)
  0.25  RESERVE: zone 32 at (2112, 10544) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10544) facing 0 (id 113)
  0.25  RESERVE: zone 33 at (2112, 10576) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10576) facing 0 (id 114)
  0.25  RESERVE: zone 34 at (2112, 10608) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10608) facing 0 (id 115)
  0.25  RESERVE: zone 35 at (2112, 10640) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10640) facing 0 (id 116)
  0.25  RESERVE: zone 36 at (2112, 10672) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10672) facing 0 (id 117)
  0.25  RESERVE: zone 37 at (2112, 10704) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10704) facing 0 (id 118)
  0.25  RESERVE: zone 38 at (2112, 10736) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10736) facing 0 (id 119)
  0.25  RESERVE: zone 39 at (2112, 10768) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10768) facing 0 (id 120)
  0.25  RESERVE: zone 40 at (2112, 10800) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10800) facing 0 (id 121)
  0.25  RESERVE: zone 41 at (2112, 10832) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10832) facing 0 (id 122)
  0.25  RESERVE: zone 42 at (2112, 10864) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10864) facing 0 (id 123)
  0.25  RESERVE: zone 43 at (2000, 10128) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (2000, 10128) facing 0 (id 124)
  0.25  RESERVE: zone 44 at (1992, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (1992, 10648) facing 0 (id 125)
  0.25  RESERVE: armalab at (10408, 4056) facing 3 (id 122)
  0.25  RESERVE: zone 15 at (10528, 4056) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (10480, 4056) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (10456, 4056) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (10160, 4056) facing 3, 20x13 cells: 245 of 260 held
  0.25  RESERVE: zone 18 at (10176, 2432) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (10176, 2432) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (10176, 2400) facing 0, 2x2 cells: 4 of 4 held
```
