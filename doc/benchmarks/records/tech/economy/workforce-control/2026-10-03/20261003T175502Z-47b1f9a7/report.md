# Playtest report: PASS

- Verdict: **PASS** (reached 14 min)
- Game time reached: 14.0 min (frame 25231); wall 111 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:53:07
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: tech_opening.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-opening\20261003T175307Z-e09dbb32\runs\20261003T175502Z-47b1f9a7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `exp on` | seen at 0.1 min | `[TECH][Build] experimental build system on: direct range 1600, search radius 512` |
| expect `opening mex` | seen at 0.3 min | `[Rule] opening.mex for armcom 8988 / M +2 E 30/76 T1 M-float` |
| expect `first lab` | seen at 0.9 min | `[Rule] lab.t1.opening for armcom 8988 / M +6 E 30/116 T1 M-float` |
| expect `energy` | seen at 1.2 min | `[Rule] energy.draining for armcom 8988 / M +4 E 30/99 T1 draining` |
| expect `turret` | seen at 3.7 min | `[Rule] turret.build for armck 4867 / M +11 E 173/183 T1` |
| expect `advanced lab` | seen at 8.7 min | `[Rule] lab.t2 for armck 15553 / M +49 E 406/1055 T1 E-float M-float` |
| forbid `script error` | clean |  |
| forbid `mobile packed` | clean |  |
| forbid `combat early` | clean |  |
| forbid `lab.t1 after t2` | clean |  |
| forbid `default task` | clean |  |
| forbid `invariant` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-opening\20261003T175307Z-e09dbb32\runs\20261003T175502Z-47b1f9a7\screen_2026-10-03_17-54-22-296.png

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
  0.85  [TECH][Build] first lab at the commander: (976, 10400), 93 from it, facing 1; the pair's slot stays planned
  0.85  [Rule] lab.t1.opening for armcom 8988 | M +6 E 30/116 T1 M-float
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 884/1150, energy +30.0 bank 244/1000, units 5
  1.18  [Playtest] finished armlab team 0 at 1.18 min
  1.18  [TECH][Build] first lab's exit held (zone 54) until it is reclaimed
  1.19  [Rule] energy.draining for armcom 8988 | M +4 E 30/99 T1 draining
  1.59  [Playtest] finished armwin team 0 at 1.59 min
  1.60  [Rule] energy.short for armcom 8988 | M +7 E 30/121 T1
  1.71  [Playtest] finished armwin team 0 at 1.71 min
  1.73  [Rule] energy.draining for armcom 8988 | M +8 E 30/143 T1 draining
  1.85  [Playtest] finished armwin team 0 at 1.85 min
  1.86  [Rule] energy.draining for armcom 8988 | M +7 E 48/132 T1 draining
  2.00  [Playtest] finished armwin team 0 at 2.00 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 857/1250, energy +87.0 bank 128/1102, units 10
  2.01  [Rule] energy.short for armcom 8988 | M +7 E 75/132 T1
  2.11  [Playtest] finished armwin team 0 at 2.11 min
  2.11  [TECH][Build] armck 15553 expands to a mex at (368, 9392) at +8 metal
  2.11  [Rule] mex.expand for armck 15553 | M +8 E 86/143 T1 draining
  2.23  [Playtest] finished armwin team 0 at 2.23 min
  2.25  [Rule] energy.short for armcom 8988 | M +8 E 105/143 T1
  2.37  [Playtest] finished armwin team 0 at 2.37 min
  2.39  [Rule] energy.short for armcom 8988 | M +8 E 140/143 T1
  2.49  [Playtest] finished armwin team 0 at 2.49 min
  2.52  [TECH][Build] armck 25438 expands to a mex at (1904, 11712) at +8 metal
  2.52  [Rule] mex.expand for armck 25438 | M +8 E 139/143 T1 E-float
  2.69  [Rule] energy.convert.float for armcom 8988 | M +8 E 143/143 T1 E-float
  2.92  [TECH][Build] armck 1163 expands to a mex at (2320, 11536) at +8 metal
  2.92  [Rule] mex.expand for armck 1163 | M +8 E 139/143 T1
  2.95  [Playtest] finished armmakr team 0 at 2.95 min
  2.96  [Rule] energy.short for armcom 8988 | M +8 E 139/143 T1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 908/1250, energy +145.1 bank 560/1254, units 20
  3.03  [Playtest] finished armmex team 0 at 3.03 min
  3.04  [TECH][Build] armck 15553 expands to a mex at (816, 7424) at +8 metal
  3.04  [Rule] mex.expand for armck 15553 | M +8 E 139/143 T1
  3.07  [Playtest] finished armwin team 0 at 3.07 min
  3.20  [Playtest] finished armwin team 0 at 3.20 min
  3.31  [TECH][Build] armck 25053 expands to a mex at (2848, 11008) at +11 metal
  3.31  [Rule] mex.expand for armck 25053 | M +11 E 126/173 T1
  3.35  [Playtest] finished armwin team 0 at 3.35 min
  3.54  [Playtest] finished armwin team 0 at 3.54 min
  3.62  [Playtest] finished armmex team 0 at 3.62 min
  3.64  [TECH][Build] armck 25438 expands to a mex at (2288, 11968) at +11 metal
  3.64  [Rule] mex.expand for armck 25438 | M +11 E 168/181 T1
  3.67  [Playtest] finished armwin team 0 at 3.67 min
  3.72  [TECH][Build] no open mex spot within 2500 of armck 4867 at +11 metal
  3.72  [Layout] turrets: order 1 of 1 allowed (build power 150 (0 by power), bank 966 + 14/s (8 by metal), 0 dear frames take a slot)
  3.72  [Rule] turret.build for armck 4867 | M +11 E 173/183 T1
  3.80  [Playtest] finished armwin team 0 at 3.80 min
  3.81  [Rule] energy.short for armcom 8988 | M +14 E 170/215 T1
  3.98  [Playtest] finished armwin team 0 at 3.98 min
  3.99  [Rule] energy.short for armcom 8988 | M +14 E 181/218 T1
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.5 bank 960/1350, energy +292.2 bank 1252/1357, units 32
  4.06  [Playtest] finished armmex team 0 at 4.06 min
  4.06  [Rule] turret.build for armrectr 8288 | M +14 E 207/223 T1 E-float
  4.07  [TECH][Build] armck 1163 expands to a mex at (4608, 11072) at +14 metal
  4.07  [Rule] mex.expand for armck 1163 | M +14 E 217/223 T1 E-float
  4.12  [Playtest] finished armwin team 0 at 4.12 min
  4.13  [Rule] energy.convert for armcom 8988 | M +14 E 274/223 T1 E-float
  4.25  [Playtest] finished armmex team 0 at 4.25 min
  4.26  [Rule] energy.convert.float for armck 25438 | M +16 E 304/258 T1 E-float
  4.34  [Playtest] finished armmakr team 0 at 4.34 min
  4.36  [Rule] energy.convert.float for armcom 8988 | M +16 E 317/262 T1 E-float
  4.39  [Playtest] finished armmex team 0 at 4.39 min
  4.40  [TECH][Build] armck 15553 expands to a mex at (544, 7168) at +18 metal
  4.40  [Rule] mex.expand for armck 15553 | M +18 E 318/300 T1 E-float
  4.55  [Playtest] finished armmakr team 0 at 4.55 min
  4.57  [Rule] assist.any for armcom 8988 | M +22 E 333/364 T1 E-float M-float
  4.57  [Ferry] requested a transport (TECH at +20 metal, no transport)
  4.57  [Playtest] finished armmex team 0 at 4.57 min
  4.59  [TECH][Build] armck 25053 expands to a mex at (4896, 10800) at +22 metal
  4.59  [Rule] mex.expand for armck 25053 | M +22 E 342/373 T1 E-float M-float
  4.80  [Playtest] finished armnanotc team 0 at 4.80 min
  4.81  [Rule] defence.fortify for armck 4867 | M +25 E 368/432 T1 M-float
  4.81  [TECH][Build] no open mex spot within 2500 of armrectr 8288 at +25 metal
  4.82  [Rule] energy.float for armcom 8988 | M +25 E 368/432 T1 E-float M-float
  4.94  [Rule] power.turret for armrectr 8288 | M +25 E 368/432 T1 E-float M-float
  4.96  [Playtest] finished armmex team 0 at 4.95 min
  4.97  [TECH][Build] armck 15553 expands to a mex at (832, 7072) at +25 metal
  4.97  [Rule] mex.expand for armck 15553 | M +25 E 368/432 T1 E-float M-float
  5.00  [Playtest] eco team 0 at 5.0 min: metal +28.0 bank 1599/1600, energy +369.0 bank 1280/1358, units 39
  5.00  [Playtest] target team 0 at (837, 10407) from its start position
  5.00  [Playtest] camera requested (837,10407) height=2200
  5.02  [Playtest] camera captured name=ta position=(837,10407) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (837, 10407)
  5.04  [Rule] power.turret for armrectr 8288 | M +25 E 368/448 T1 E-float M-float
  5.05  [Playtest] finished armwin team 0 at 5.05 min
  5.06  [Rule] power.turret for armcom 8988 | M +25 E 368/448 T1 E-float M-float
  5.12  [Rule] power.turret for armrectr 8288 | M +28 E 368/505 T1 E-float M-float
  5.27  [Playtest] finished armdrag team 0 at 5.27 min
  5.29  [Rule] defence.fortify for armck 4867 | M +28 E 388/505 T1 E-float M-float
  5.36  [Playtest] finished armdrag team 0 at 5.36 min
  5.38  [Rule] defence.fortify for armck 4867 | M +28 E 387/505 T1 E-float M-float
  5.44  [Playtest] finished armmex team 0 at 5.44 min
  5.46  [Playtest] finished armdrag team 0 at 5.46 min
  5.46  [TECH][Build] armck 15553 expands to a mex at (1168, 6400) at +28 metal
  5.46  [Rule] mex.expand for armck 15553 | M +28 E 387/505 T1 E-float M-float
  5.47  [Rule] defence.fortify for armck 4867 | M +28 E 387/505 T1 E-float M-float
  5.48  [Rule] storage.energy for armcom 8988 | M +28 E 387/505 T1 E-float M-float
  5.51  [Playtest] finished armmex team 0 at 5.51 min
  5.53  [Layout] turrets: order 1 of 1 allowed (build power 390 (1 by power), bank 1677 + 32/s (8 by metal), 0 dear frames take a slot)
  5.53  [Rule] power.turret for armck 1163 | M +28 E 387/505 T1 E-float M-float
  5.54  [Rule] power.turret for armrectr 8288 | M +28 E 387/505 T1 E-float M-float
  5.54  [Playtest] finished armdrag team 0 at 5.54 min
  5.56  [Rule] defence.fortify for armck 4867 | M +28 E 387/505 T1 E-float M-float
  5.63  [Rule] power.turret for armrectr 8288 | M +30 E 376/565 T1 E-float M-float
  5.64  [Playtest] finished armdrag team 0 at 5.64 min
  5.65  [Rule] defence.fortify for armck 4867 | M +30 E 371/565 T1 E-float M-float
  5.72  [Rule] power.turret for armrectr 8288 | M +32 E 352/623 T1 E-float M-float
  5.73  [Playtest] finished armdrag team 0 at 5.73 min
  5.74  [Rule] defence.fortify for armck 4867 | M +32 E 347/623 T1 M-float
  5.82  [Playtest] finished armdrag team 0 at 5.82 min
  5.83  [Playtest] finished armestor team 0 at 5.83 min
  5.84  [Rule] defence.fortify for armck 4867 | M +30 E 342/576 T1 M-float
  5.84  [Rule] defence.fortify for armck 25438 | M +30 E 342/576 T1 M-float
  5.85  [Rule] power.turret for armcom 8988 | M +30 E 342/576 T1 M-float
  5.92  [Playtest] finished armdrag team 0 at 5.92 min
  5.93  [Rule] defence.fortify for armck 4867 | M +29 E 334/547 T1 M-float
  5.96  [Playtest] finished armmex team 0 at 5.96 min
  5.98  [Rule] power.turret for armck 25053 | M +29 E 331/547 T1 M-float
  6.00  [Playtest] eco team 0 at 6.0 min: metal +31.9 bank 1749/1750, energy +328.0 bank 3730/7358, units 53
  6.02  [Playtest] finished armdrag team 0 at 6.02 min
  6.04  [Rule] defence.fortify for armck 4867 | M +29 E 327/547 T1 M-float
  6.22  [Playtest] finished armmex team 0 at 6.22 min
  6.25  [Rule] power.turret for armck 15553 | M +31 E 295/610 T1 M-float
  6.27  [Playtest] finished armdrag team 0 at 6.27 min
  6.28  [Rule] defence.fortify for armck 4867 | M +31 E 292/610 T1 M-float
  6.29  [TECH][Build] no open mex spot within 2500 of armrectr 8288 at +32 metal
  6.29  [TECH][Build] armck 25053 expands to a mex at (4784, 9856) at +32 metal
  6.29  [Rule] mex.expand for armck 25053 | M +32 E 292/620 T1 M-float
  6.29  [Rule] energy.short for armcom 8988 | M +32 E 292/620 T1 M-float
  6.30  [TECH][Build] armck 15553 expands to a mex at (432, 5760) at +32 metal
  6.30  [Rule] mex.expand for armck 15553 | M +32 E 292/620 T1 M-float
  6.35  [Rule] power.turret for armrectr 8288 | M +34 E 292/672 T1 M-float
  6.37  [Playtest] finished armdrag team 0 at 6.36 min
  6.38  [Rule] defence.fortify for armck 4867 | M +34 E 292/697 T1 M-float
  6.45  [Rule] power.turret for armrectr 8288 | M +37 E 292/769 T1 M-float
  6.46  [Playtest] finished armdrag team 0 at 6.47 min
  6.48  [Rule] defence.fortify for armck 4867 | M +37 E 293/769 T1 E-float M-float
  6.55  [Rule] power.turret for armrectr 8288 | M +37 E 305/769 T1 E-float M-float
  6.56  [Playtest] finished armdrag team 0 at 6.56 min
  6.57  [Rule] defence.fortify for armck 4867 | M +37 E 315/769 T1 E-float M-float
  6.64  [Rule] power.turret for armrectr 8288 | M +37 E 338/769 T1 E-float M-float
  6.66  [Playtest] finished armdrag team 0 at 6.66 min
  6.67  [Rule] defence.fortify for armck 4867 | M +37 E 346/769 T1 E-float M-float
  6.75  [Playtest] finished armdrag team 0 at 6.75 min
  6.76  [Rule] defence.fortify for armck 4867 | M +37 E 351/769 T1 E-float M-float
  6.85  [Playtest] finished armdrag team 0 at 6.85 min
  6.86  [Rule] defence.fortify for armck 4867 | M +37 E 339/769 T1 E-float M-float
  6.89  [Playtest] finished armwin team 0 at 6.89 min
  6.90  [Rule] power.turret for armcom 8988 | M +37 E 321/769 T1 E-float M-float
  6.94  [Playtest] finished armdrag team 0 at 6.94 min
  6.96  [Playtest] finished armmex team 0 at 6.95 min
  6.96  [Rule] defence.fortify for armck 4867 | M +37 E 287/769 T1 E-float M-float
  6.97  [Rule] power.turret for armck 25053 | M +37 E 276/769 T1 E-float M-float
  7.00  [Playtest] eco team 0 at 7.0 min: metal +39.3 bank 1849/1850, energy +247.9 bank 7062/7359, units 65
  7.04  [Playtest] finished armdrag team 0 at 7.04 min
  7.05  [Rule] defence.fortify for armck 4867 | M +37 E 243/769 T1 E-float M-float
  7.07  [Playtest] finished armdrag team 0 at 7.07 min
  7.08  [Rule] defence.fortify for armck 25438 | M +37 E 243/769 T1 E-float M-float
  7.13  [Playtest] finished armdrag team 0 at 7.13 min
  7.14  [Rule] defence.fortify for armck 4867 | M +39 E 243/835 T1 E-float M-float
  7.17  [Playtest] finished armmex team 0 at 7.17 min
  7.18  [TECH][Build] armck 25053 expands to a mex at (4720, 9504) at +39 metal
  7.18  [Rule] mex.expand for armck 25053 | M +39 E 243/835 T1 E-float M-float
  7.19  [TECH][Build] armck 15553 expands to a mex at (864, 5264) at +39 metal
  7.19  [Rule] mex.expand for armck 15553 | M +39 E 243/835 T1 E-float M-float
  7.31  [TECH][Build] no open mex spot within 2500 of armrectr 8288 at +39 metal
  7.32  [Rule] power.turret for armcom 8988 | M +39 E 297/835 T1 E-float M-float
  7.37  [Rule] power.turret for armrectr 8288 | M +41 E 343/891 T1 E-float M-float
  7.38  [Playtest] finished armdrag team 0 at 7.38 min
  7.39  [Rule] defence.fortify for armck 25438 | M +41 E 357/891 T1 E-float M-float
  7.57  [Ferry] requested a transport (TECH at +20 metal, no transport)
  7.69  [Playtest] finished armmex team 0 at 7.69 min
  7.70  [Rule] power.turret for armck 25053 | M +41 E 406/891 T1 E-float M-float
  7.81  [Playtest] finished armrl team 0 at 7.81 min
  7.82  [Rule] power.turret for armck 25438 | M +41 E 404/891 T1 E-float M-float
  7.84  [Playtest] finished armmex team 0 at 7.84 min
  7.85  [Rule] power.turret for armck 15553 | M +41 E 401/891 T1 E-float M-float
  7.86  [Playtest] finished armllt team 0 at 7.86 min
  7.88  [TECH][Build] armck 25438 expands to a mex at (2368, 8128) at +43 metal
  7.88  [Rule] mex.expand for armck 25438 | M +43 E 390/931 T1 E-float M-float
  7.88  [TECH][Build] armck 4867 expands to a mex at (2784, 8048) at +43 metal
  7.88  [Rule] mex.expand for armck 4867 | M +43 E 390/931 T1 E-float M-float
  7.89  [TECH][Build] armck 25053 expands to a mex at (5040, 10048) at +43 metal
  7.89  [Rule] mex.expand for armck 25053 | M +43 E 383/931 T1 E-float M-float
  7.90  [TECH][Build] armck 15553 expands to a mex at (288, 5088) at +43 metal
  7.90  [Rule] mex.expand for armck 15553 | M +43 E 383/931 T1 E-float M-float
  8.00  [Playtest] eco team 0 at 8.0 min: metal +45.9 bank 2000/2000, energy +333.3 bank 7288/7359, units 72
  8.34  [TECH][Build] no open mex spot within 2500 of armrectr 8288 at +45 metal
  8.40  [Rule] power.turret for armrectr 8288 | M +45 E 389/977 T1 E-float M-float
  8.41  [Rule] power.turret for armcom 8988 | M +45 E 389/977 T1 E-float M-float
  8.55  [Playtest] finished armmex team 0 at 8.55 min
  8.56  [Rule] power.turret for armck 15553 | M +45 E 403/977 T1 E-float M-float
  8.58  [Playtest] finished armmex team 0 at 8.58 min
  8.59  [Rule] power.turret for armck 25053 | M +45 E 404/977 T1 M-float
  8.71  [Playtest] finished armnanotc team 0 at 8.71 min
  8.72  [TECH][Build] armck 25053 expands to a mex at (5440, 9424) at +47 metal
  8.72  [Rule] mex.expand for armck 25053 | M +47 E 406/1019 T1 M-float
  8.73  [TECH][Build] armck 1163 expands to a mex at (2496, 7776) at +47 metal
  8.73  [Rule] mex.expand for armck 1163 | M +47 E 406/1019 T1 M-float
  8.73  [Rule] energy.short for armcom 8988 | M +49 E 406/1055 T1 M-float
  8.74  [Layout] advanced lab on its planned slot (1288, 9832): 18 turret slots within 260
  8.74  [Rule] lab.t2 for armck 15553 | M +49 E 406/1055 T1 E-float M-float
  9.00  [Playtest] eco team 0 at 9.0 min: metal +50.2 bank 2100/2100, energy +255.7 bank 7268/7359, units 75
  9.16  [Playtest] finished armwin team 0 at 9.16 min
  9.37  [TECH][Build] no open mex spot within 2500 of armrectr 8288 at +50 metal
  9.45  [Playtest] finished armmex team 0 at 9.45 min
  9.47  [TECH][Build] armck 25053 expands to a mex at (5024, 8784) at +50 metal
  9.47  [Rule] mex.expand for armck 25053 | M +50 E 303/1064 T2 E-float M-float
  9.69  [Rule] power.turret for armrectr 8288 | M +52 E 252/1110 T2 E-float M-float
  9.70  [Rule] power.turret for armcom 8988 | M +52 E 252/1110 T2 E-float M-float
 10.00  [Playtest] eco team 0 at 10.0 min: metal +52.5 bank 2149/2150, energy +236.8 bank 6383/7359, units 81
 10.05  [Playtest] finished armmex team 0 at 10.05 min
 10.07  [Layout] turrets: order 2 of 2 allowed (build power 630 (2 by power), bank 2197 + 54/s (8 by metal), 0 dear frames take a slot)
 10.07  [Rule] power.turret for armck 4867 | M +52 E 232/1110 T2 M-float
 10.13  [Playtest] finished armmex team 0 at 10.13 min
 10.14  [Rule] power.turret for armck 25438 | M +52 E 232/1110 T2 M-float
 10.15  [Playtest] finished armmex team 0 at 10.15 min
 10.17  [Rule] power.turret for armck 25053 | M +52 E 232/1110 T2 M-float
 10.25  [Playtest] finished armmex team 0 at 10.25 min
 10.26  [TECH][Build] armck 25438 expands to a mex at (3424, 8128) at +54 metal
 10.26  [Rule] mex.expand for armck 25438 | M +54 E 233/1155 T2 M-float
 10.27  [TECH][Build] armck 25053 expands to a mex at (4752, 8512) at +54 metal
 10.27  [Rule] mex.expand for armck 25053 | M +54 E 234/1155 T2 M-float
 10.27  [TECH][Build] armck 1163 expands to a mex at (4512, 7600) at +54 metal
 10.27  [Rule] mex.expand for armck 1163 | M +54 E 234/1155 T2 M-float
 10.28  [Rule] energy.short for armcom 8988 | M +54 E 234/1155 T2 M-float
 10.39  [TECH][Build] no open mex spot within 2500 of armrectr 8288 at +58 metal
 10.57  [Ferry] requested a transport (TECH at +20 metal, no transport)
 10.71  [Rule] power.turret for armrectr 8288 | M +61 E 301/1293 T2 M-float
 10.75  [Playtest] finished armmex team 0 at 10.75 min
 10.76  [Rule] power.turret for armck 25053 | M +61 E 302/1293 T2 M-float
 10.84  [TECH][Build] T1 lab reclaim deferred: metal 2400 of 2400 leaves no room for its 500
 10.84  [Rule] power.turret for armcom 8988 | M +61 E 319/1294 T2 M-float
 10.86  [Playtest] finished armwin team 0 at 10.86 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +61.7 bank 2372/2400, energy +437.2 bank 5328/7360, units 85
 11.03  [Playtest] finished armmex team 0 at 11.03 min
 11.04  [Rule] power.turret for armck 25438 | M +61 E 393/1287 T2 M-float
 11.44  [Playtest] finished armalab team 0 at 11.44 min
 11.45  [Layout] advanced lab 4591: nearest construction turret 112 elmos (flush)
 11.45  [Layout] advanced lab 4591: faces 1, the front 1, 0 structures in its exit lane
 11.45  [Layout] factory armalab 4591 stands 1 cell(s) from a turret
 11.45  [TECH][Factory] armalab: T2 constructor 1 of 10 (bank 1877 of 2650) (D-103)
 11.45  [Rule] turret.build for armck 25438 | M +63 E 439/1326 T2
 11.46  [TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab 29161; idle build power in range joins
 11.46  [Rule] lab.t1.reclaim for armrectr 8288 | M +63 E 439/1326 T2
 11.46  [Rule] turret.build for armck 25053 | M +63 E 439/1326 T2
 11.47  [Rule] lab.t1.reclaim for armcom 8988 | M +63 E 439/1326 T2
 11.47  [Rule] lab.t1.reclaim for armck 15553 | M +63 E 439/1326 T2
 11.61  [Playtest] finished armnanotc team 0 at 11.61 min
 11.61  [Playtest] finished armmex team 0 at 11.61 min
 11.62  [Layout] turrets: order 3 of 4 allowed (build power 1170 (4 by power), bank 2175 + 65/s (8 by metal), 0 dear frames take a slot)
 11.63  [Rule] lab.t1.reclaim for armck 4867 | M +63 E 440/1326 T2 M-float
 11.63  [Layout] turrets: order 4 of 4 allowed (build power 1170 (4 by power), bank 2175 + 65/s (8 by metal), 0 dear frames take a slot)
 11.64  [TECH][Build] T1 lab reclaim deferred: metal 2203 of 2700 leaves no room for its 500
 11.64  [Rule] energy.draining for armck 1163 | M +63 E 440/1326 T2 draining M-float
 11.85  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 2700 of 2700) (D-103)
 11.85  [Rule] mex.upgrade for armack 6357 | M +65 E 440/1372 T2 M-float
 11.90  [TECH][Build] first lab gone: its exit (zone 54) released
 11.90  [Layout] turrets: order 5 of 5 allowed (build power 1470 (5 by power), bank 2600 + 165/s (8 by metal), 0 dear frames take a slot)
 11.90  [Rule] turret.build for armck 4867 | M +65 E 442/1372 T2 draining M-float
 11.91  [Rule] storage.metal for armcom 8988 | M +65 E 442/1372 T2 draining M-float
 11.92  [Rule] storage.metal for armck 15553 | M +65 E 442/1372 T2 draining M-float
 12.00  [Playtest] eco team 0 at 12.0 min: metal +65.6 bank 2599/2600, energy +455.0 bank 750/7560, units 88
 12.17  [Rule] power.turret for armrectr 8288 | M +65 E 454/1372 T2 M-float
 12.17  [TECH][Factory] armalab: T2 constructor 3 of 10 (bank 2600 of 2600) (D-103)
 12.17  [Rule] defence.fortify for armack 28665 | M +65 E 454/1372 T2 M-float
 12.26  [Rule] turret.build for armrectr 8288 | M +65 E 454/1372 T2 draining M-float
 12.46  [Playtest] finished armmstor team 0 at 12.46 min
 12.48  [Rule] assist.any for armcom 8988 | M +64 E 463/1359 T2
 12.54  [Playtest] finished armnanotc team 0 at 12.54 min
 12.56  [Layout] turrets: order 5 of 6 allowed (build power 1860 (7 by power), bank 2640 + 65/s (61 by metal), 1 dear frames take a slot)
 12.56  [Rule] power.t1 for armck 4867 | M +64 E 463/1359 T2 draining
 12.56  [Rule] assist.any for armrectr 8288 | M +64 E 463/1359 T2 draining
 12.60  [Playtest] finished armfort team 0 at 12.60 min
 12.60  [Playtest] finished armmstor team 0 at 12.60 min
 12.61  [Rule] mex.upgrade for armack 28665 | M +65 E 463/1372 T2
 12.62  [Layout] turrets: order 6 of 6 allowed (build power 1860 (7 by power), bank 2674 + 65/s (62 by metal), 1 dear frames take a slot)
 12.62  [Rule] power.t1 for armck 15553 | M +65 E 459/1372 T2
 12.89  [Rule] turret.build for armck 4867 | M +65 E 354/1372 T2 draining
 13.00  [Playtest] eco team 0 at 13.0 min: metal +65.6 bank 3607/8600, energy +457.7 bank 0/7660, units 98
 13.04  [TECH][Build] no open mex spot within 2500 of armrectr 8288 at +59 metal
 13.04  [Rule] turret.build for armrectr 8288 | M +59 E 371/1253 T2 draining
 13.07  [Playtest] finished armnanotc team 0 at 13.07 min
 13.09  [Playtest] finished armnanotc team 0 at 13.09 min
 13.09  [Layout] turrets: order 5 of 7 allowed (build power 2490 (9 by power), bank 3754 + 58/s (35 by metal), 1 dear frames take a slot)
 13.09  [Rule] power.t1 for armck 4867 | M +58 E 402/1225 T2 draining
 13.09  [Rule] assist.any for armrectr 8288 | M +58 E 402/1225 T2 draining
 13.10  [Layout] turrets: order 6 of 7 allowed (build power 2490 (9 by power), bank 3793 + 60/s (37 by metal), 1 dear frames take a slot)
 13.10  [Rule] power.t1 for armck 25438 | M +58 E 414/1225 T2 draining
 13.35  [Playtest] finished armnanotc team 0 at 13.35 min
 13.37  [Layout] turrets: order 6 of 7 allowed (build power 2730 (10 by power), bank 4111 + 49/s (30 by metal), 1 dear frames take a slot)
 13.37  [Rule] power.t1 for armck 25053 | M +48 E 471/1023 T2 draining
 13.40  [Layout] turrets: order 7 of 7 allowed (build power 2730 (10 by power), bank 4180 + 56/s (34 by metal), 1 dear frames take a slot)
 13.49  [Playtest] finished armmoho team 0 at 13.49 min
 13.50  [Rule] mex.upgrade for armack 6357 | M +48 E 472/1027 T2 draining
 13.57  [Ferry] requested a transport (TECH at +20 metal, no transport)
 13.58  [Playtest] finished armnanotc team 0 at 13.58 min
 13.60  [Rule] legacy.strategic for armck 25438 | M +56 E 472/1184 T2 draining
 13.71  [Rule] energy.assist for armck 25438 | M +70 E 471/1474 T2 draining
 13.94  [Playtest] finished armnanotc team 0 at 13.94 min
 13.95  [Rule] energy.assist for armck 4867 | M +53 E 468/1137 T2 draining
 13.96  [Rule] energy.assist for armcom 8988 | M +53 E 468/1137 T2 draining
 14.00  [Playtest] eco team 0 at 14.0 min: metal +54.1 bank 5526/9150, energy +470.7 bank 0/7660, units 104
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
