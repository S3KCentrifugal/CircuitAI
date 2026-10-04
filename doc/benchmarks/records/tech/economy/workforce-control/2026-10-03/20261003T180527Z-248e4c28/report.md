# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 16.1 min (frame 29041); wall 129 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:03:14
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: rush_t2.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-rush\20261003T180314Z-455145b2\runs\20261003T180527Z-248e4c28\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `chain` | seen at 0.1 min | `[TECH][Chain] objective t2 (wind: wind 1 to 19, expected 10, now 8: 4 metal per E/s a turbine, 7.7 a solar; income bonus x1; 2 T1 cons, 1 T2 cons): mex 3, lab 1, wind 4, mex 6, wind 12, alab 1` |
| expect `milestone` | seen at 6.0 min | `[t=00:01:14.771603][f=0010796] [Playtest] finished armalab team 0 at 6.00 min` |
| forbid `script error` | clean |  |
| forbid `combat early` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-015 a dear chain order has had no frame for 45 s` |

## Failures

- forbid 'invariant' hit at 4.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 7.2 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 8.6 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added
- forbid 'invariant' hit at 9.6 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added
- forbid 'invariant' hit at 10.6 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added
- forbid 'invariant' hit at 13.1 min: [INVARIANT] INV-004 metal floating at 9100 of 9100 for 60 s while armnanotc is under construction and static build power 1200 is under 2365
- forbid 'invariant' hit at 13.1 min: [INVARIANT] INV-011 metal floating at 9100 of 9100 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 14.1 min: [INVARIANT] INV-011 metal floating at 9100 of 9100 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 14.6 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 9 T2 constructors, none added
- forbid 'invariant' hit at 15.1 min: [INVARIANT] INV-011 metal floating at 9650 of 9650 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 15.6 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 9 T2 constructors, none added
- forbid 'invariant' hit at 16.1 min: [INVARIANT] INV-011 metal floating at 9852 of 10200 for 60 s with an income step of the plan unmet

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-rush\20261003T180314Z-455145b2\runs\20261003T180527Z-248e4c28\screen_2026-10-03_18-04-29-667.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-rush\20261003T180314Z-455145b2\runs\20261003T180527Z-248e4c28\screen_2026-10-03_18-05-19-871.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 30, 3 shots, end at 16.5 min
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
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
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
  0.32  [Rule] chain.next for armcom 8988 | M +2 E 30/76 T1 M-float
  0.57  [Playtest] finished armmex team 0 at 0.57 min
  0.58  [Rule] chain.next for armcom 8988 | M +4 E 30/94 T1 M-float
  0.84  [Playtest] finished armmex team 0 at 0.84 min
  0.85  [TECH][Build] first lab at the commander: (960, 10400), 93 from it, facing 1; the pair's slot stays planned
  0.85  [Rule] chain.next for armcom 8988 | M +6 E 30/116 T1 M-float
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 884/1150, energy +30.0 bank 241/1000, units 5
  1.18  [Playtest] finished armlab team 0 at 1.18 min
  1.18  [TECH][Build] first lab's exit held (zone 54) until it is reclaimed
  1.55  [Playtest] finished armwin team 0 at 1.55 min
  1.56  [Rule] chain.next for armcom 8988 | M +8 E 30/137 T1 draining
  1.69  [Playtest] finished armwin team 0 at 1.69 min
  1.70  [Rule] chain.next for armcom 8988 | M +8 E 30/137 T1
  1.81  [Playtest] finished armwin team 0 at 1.81 min
  1.83  [Rule] chain.next for armcom 8988 | M +8 E 47/143 T1 draining
  1.95  [Playtest] finished armwin team 0 at 1.95 min
  1.96  [Rule] chain.next for armcom 8988 | M +8 E 66/143 T1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 881/1250, energy +81.2 bank 150/1102, units 11
  2.10  [Playtest] finished armwin team 0 at 2.10 min
  2.15  [Rule] chain.next for armck 15553 | M +8 E 79/143 T1
  2.23  [Playtest] finished armwin team 0 at 2.23 min
  2.25  [Rule] chain.next for armcom 8988 | M +8 E 79/143 T1 draining
  2.39  [Playtest] finished armwin team 0 at 2.39 min
  2.40  [Rule] chain.next for armcom 8988 | M +8 E 101/143 T1
  2.51  [Playtest] finished armwin team 0 at 2.51 min
  2.56  [Rule] chain.next for armck 25438 | M +8 E 114/143 T1
  2.64  [Playtest] finished armwin team 0 at 2.64 min
  2.76  [Playtest] finished armwin team 0 at 2.76 min
  2.97  [Rule] energy.convert.float for armck 26041 | M +8 E 231/143 T1 E-float
  2.98  [Playtest] finished armwin team 0 at 2.98 min
  2.99  [Rule] energy.convert.float for armcom 8988 | M +8 E 231/143 T1 E-float
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 848/1250, energy +245.8 bank 1246/1255, units 21
  3.09  [Playtest] finished armmex team 0 at 3.09 min
  3.10  [Rule] energy.convert.float for armck 15553 | M +8 E 231/143 T1 E-float
  3.20  [Playtest] finished armmakr team 0 at 3.20 min
  3.21  [Rule] energy.convert.float for armcom 8988 | M +8 E 221/143 T1 E-float
  3.37  [Rule] chain.next for armck 14057 | M +11 E 192/174 T1
  3.44  [Playtest] finished armmakr team 0 at 3.44 min
  3.45  [Rule] chain.next for armcom 8988 | M +11 E 183/174 T1
  3.78  [Rule] chain.next for armck 740 | M +11 E 101/173 T1 draining M-float
  3.79  [Playtest] finished armmakr team 0 at 3.79 min
  3.80  [Rule] chain.next for armck 26041 | M +11 E 99/173 T1 draining M-float
  3.81  [Playtest] finished armmex team 0 at 3.81 min
  3.83  [Layout] advanced lab on its planned slot (1288, 9832): 18 turret slots within 260
  3.83  [Rule] chain.next for armck 25438 | M +11 E 99/173 T1 draining M-float
  3.84  [TECH][Build] armck 26041 expands to a mex at (2848, 11008) at +11 metal
  3.84  [Rule] mex.expand for armck 26041 | M +11 E 99/173 T2 draining M-float
  3.84  [TECH][Build] armck 740 expands to a mex at (2288, 11968) at +11 metal
  3.84  [Rule] mex.expand for armck 740 | M +11 E 99/173 T2 draining M-float
  3.87  [Playtest] finished armmakr team 0 at 3.87 min
  3.88  [TECH][Build] armck 15553 expands to a mex at (2368, 8128) at +11 metal
  3.88  [Rule] mex.expand for armck 15553 | M +11 E 99/173 T2 M-float
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.5 bank 1209/1350, energy +183.3 bank 1087/1355, units 28
  4.20  [Playtest] finished armwin team 0 at 4.20 min
  4.34  [Rule] chain.next for armcom 8988 | M +15 E 234/241 T2 M-float
  4.41  [Rule] chain.next for armrectr 6389 | M +16 E 269/251 T2 M-float
  4.51  [Playtest] finished armmex team 0 at 4.51 min
  4.53  [Rule] energy.short for armcom 8988 | M +16 E 232/254 T2 M-float
  4.53  [TECH][Build] no open mex spot within 2500 of armrectr 6389 at +16 metal
  4.54  [TECH][Build] armck 14057 expands to a mex at (4608, 11072) at +16 metal
  4.54  [Rule] mex.expand for armck 14057 | M +16 E 229/254 T2 M-float
  4.66  [Rule] power.turret for armrectr 6389 | M +16 E 229/254 T2 M-float
  4.80  [TECH][Build] T1 lab reclaim deferred: metal 1400 of 1400 leaves no room for its 500
  4.86  [Playtest] finished armwin team 0 at 4.86 min
  4.87  [Rule] power.turret for armcom 8988 | M +18 E 274/289 T2 M-float
  5.00  [Playtest] eco team 0 at 5.0 min: metal +17.7 bank 1349/1400, energy +307.9 bank 1026/1356, units 34
  5.00  [Playtest] target team 0 at (837, 10407) from its start position
  5.00  [Playtest] camera requested (837,10407) height=2200
  5.01  [Playtest] camera captured name=ta position=(837,10407) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (837, 10407)
  5.12  [Playtest] finished armmex team 0 at 5.12 min
  5.13  [Rule] chain.next for armck 740 | M +16 E 305/249 T2
  5.36  [Playtest] finished armmex team 0 at 5.36 min
  5.37  [Rule] chain.next for armck 15553 | M +18 E 305/295 T2
  5.53  [Ferry] requested a transport (TECH at +20 metal, no transport)
  5.99  [Playtest] finished armmex team 0 at 5.99 min
  6.00  [Playtest] finished armalab team 0 at 6.00 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.9 bank 56/1750, energy +309.7 bank 1070/1556, units 35
  6.00  [Layout] advanced lab 11034: nearest construction turret none (not flush)
  6.00  [Layout] advanced lab 11034: faces 1, the front 1, 0 structures in its exit lane
  6.00  [TECH][Build] armck 14057 expands to a mex at (4896, 11328) at +20 metal
  6.00  [Rule] mex.expand for armck 14057 | M +20 E 279/332 T2
  6.01  [TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab 29161; idle build power in range joins
  6.01  [Rule] lab.t1.reclaim for armcom 8988 | M +20 E 279/332 T2
  6.01  [TECH][Build] armck 15553 expands to a mex at (2784, 8048) at +20 metal
  6.01  [Rule] mex.expand for armck 15553 | M +20 E 279/332 T2
  6.02  [Rule] lab.t1.reclaim for armck 25438 | M +20 E 281/333 T2
  6.02  [TECH][Build] armck 740 expands to a mex at (4896, 10800) at +20 metal
  6.02  [Rule] mex.expand for armck 740 | M +20 E 281/333 T2
  6.03  [Rule] lab.t1.reclaim for armrectr 6389 | M +20 E 281/333 T2
  6.33  [Rule] energy.short for armcom 8988 | M +22 E 284/379 T2
  6.33  [TECH][Build] first lab gone: its exit (zone 54) released
  6.33  [TECH][Build] no open mex spot within 2500 of armck 25438 at +22 metal
  6.33  [Rule] storage.energy for armck 25438 | M +22 E 284/379 T2 draining
  6.48  [Rule] chain.next for armack 8694 | M +22 E 288/379 T2
  6.53  [Rule] energy.short for armcom 8988 | M +22 E 290/379 T2
  6.57  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 866 of 1650) (D-103)
  6.58  [TECH][Build] armack 8694 expands to a mex at (2496, 7776) at +22 metal
  6.58  [Rule] mex.expand for armack 8694 | M +22 E 294/379 T2
  6.58  [Playtest] finished armmex team 0 at 6.58 min
  6.60  [TECH][Build] armck 14057 expands to a mex at (5040, 10048) at +22 metal
  6.60  [Rule] mex.expand for armck 14057 | M +22 E 296/379 T2
  6.60  [Rule] energy.assist2 for armrectr 6389 | M +22 E 299/379 T2
  6.64  [Playtest] finished armwin team 0 at 6.64 min
  6.72  [Rule] assist.any for armcom 8988 | M +25 E 323/435 T2
  6.72  [Rule] assist.any for armrectr 6389 | M +25 E 323/435 T2
  7.00  [Playtest] eco team 0 at 7.0 min: metal +25.0 bank 841/1700, energy +343.8 bank 206/1557, units 42
  7.01  [Playtest] finished armestor team 0 at 7.01 min
  7.02  [TECH][Build] armck 25438 expands to a mex at (816, 7424) at +23 metal
  7.02  [Rule] mex.expand for armck 25438 | M +23 E 340/400 T2
  7.07  [Playtest] finished armmex team 0 at 7.07 min
  7.08  [TECH][Build] armck 740 expands to a mex at (4784, 9856) at +23 metal
  7.08  [Rule] mex.expand for armck 740 | M +23 E 340/400 T2 draining
  7.08  [Playtest] finished armmex team 0 at 7.08 min
  7.09  [TECH][Build] armck 15553 expands to a mex at (3424, 8128) at +23 metal
  7.09  [Rule] mex.expand for armck 15553 | M +23 E 340/400 T2
  7.11  [Rule] mex.upgrade for armack 22328 | M +23 E 340/400 T2
  7.18  [Playtest] finished armmex team 0 at 7.18 min
  7.20  [Rule] defence.fortify for armck 26041 | M +25 E 343/431 T2
  7.20  [TECH][Factory] armalab: T2 constructor 3 of 10 (bank 1061 of 1850) (D-103)
  7.36  [TECH][Build] no open mex spot within 2500 of armrectr 6389 at +31 metal
  7.48  [Rule] energy.draining for armcom 8988 | M +31 E 314/609 T2 draining
  7.49  [Rule] assist.any for armrectr 6389 | M +31 E 308/609 T2 draining
  7.53  [Playtest] finished armmex team 0 at 7.53 min
  7.54  [TECH][Build] armck 14057 expands to a mex at (4720, 9504) at +31 metal
  7.54  [Rule] mex.expand for armck 14057 | M +31 E 296/609 T2 draining
  7.58  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 1183 of 1900) (D-103)
  7.58  [Rule] energy.assist for armack 14743 | M +31 E 293/609 T2 draining
  7.59  [Rule] energy.assist2 for armrectr 6389 | M +31 E 293/609 T2
  7.60  [Rule] mex.upgrade for armack 14743 | M +31 E 293/609 T2
  7.62  [Playtest] finished armwin team 0 at 7.62 min
  7.64  [Rule] energy.draining for armcom 8988 | M +31 E 293/609 T2 draining
  7.64  [Rule] assist.any for armrectr 6389 | M +31 E 293/609 T2 draining
  7.78  [Playtest] finished armmex team 0 at 7.78 min
  7.79  [Playtest] finished armwin team 0 at 7.79 min
  7.80  [TECH][Build] armck 15553 expands to a mex at (4512, 7600) at +29 metal
  7.80  [Rule] mex.expand for armck 15553 | M +29 E 310/541 T2
  7.80  [Rule] assist.any for armcom 8988 | M +29 E 310/541 T2
  7.85  [Playtest] finished armdrag team 0 at 7.85 min
  7.86  [Rule] assist.any for armck 26041 | M +29 E 310/541 T2
  7.88  [Playtest] finished armmex team 0 at 7.88 min
  7.89  [TECH][Build] armck 740 expands to a mex at (5440, 9424) at +29 metal
  7.89  [Rule] mex.expand for armck 740 | M +29 E 310/541 T2
  8.00  [Playtest] eco team 0 at 8.0 min: metal +38.3 bank 1424/2000, energy +395.7 bank 69/7758, units 54
  8.26  [Playtest] finished armmex team 0 at 8.26 min
  8.27  [TECH][Build] armck 14057 expands to a mex at (5024, 8784) at +31 metal
  8.27  [Rule] mex.expand for armck 14057 | M +31 E 407/594 T2 draining
  8.32  [Playtest] finished armmoho team 0 at 8.32 min
  8.33  [Rule] energy.draining for armcom 8988 | M +31 E 408/594 T2 draining
  8.33  [Layout] turrets: order 2 of 2 allowed (build power 600 (2 by power), bank 1531 + 51/s (8 by metal), 0 dear frames take a slot)
  8.33  [Rule] turret.build for armck 26041 | M +31 E 407/594 T2
  8.34  [Rule] chain.next for armack 22328 | M +31 E 407/594 T2
  8.45  [TECH][Build] no open mex spot within 2500 of armrectr 6389 at +33 metal
  8.45  [Rule] energy.assist for armrectr 6389 | M +33 E 364/666 T2 draining
  8.49  [Playtest] finished armwin team 0 at 8.49 min
  8.50  [Rule] energy.draining for armcom 8988 | M +46 E 350/985 T2 draining
  8.51  [Rule] turret.build for armrectr 6389 | M +46 E 350/985 T2 draining
  8.53  [Ferry] requested a transport (TECH at +20 metal, no transport)
  8.65  [Playtest] finished armwin team 0 at 8.65 min
  8.68  [Playtest] finished armmex team 0 at 8.68 min
  8.69  [TECH][Build] armck 25438 expands to a mex at (832, 7072) at +29 metal
  8.69  [Rule] mex.expand for armck 25438 | M +29 E 275/540 T2 draining
  8.70  [Playtest] finished armmex team 0 at 8.70 min
  8.72  [TECH][Build] armck 740 expands to a mex at (5216, 8400) at +29 metal
  8.72  [Rule] mex.expand for armck 740 | M +29 E 259/540 T2 draining
  8.81  [Playtest] finished armmex team 0 at 8.81 min
  8.83  [TECH][Build] armck 15553 expands to a mex at (4528, 7216) at +27 metal
  8.83  [Rule] mex.expand for armck 15553 | M +27 E 190/481 T2 draining
  9.00  [Playtest] eco team 0 at 9.0 min: metal +34.2 bank 2115/2750, energy +274.2 bank 0/7759, units 63
  9.04  [Rule] energy.assist for armrectr 6389 | M +32 E 204/612 T2 draining
  9.15  [Playtest] finished armmex team 0 at 9.15 min
  9.16  [TECH][Build] armck 14057 expands to a mex at (4752, 8512) at +29 metal
  9.16  [Rule] mex.expand for armck 14057 | M +29 E 238/539 T2 draining M-float
  9.21  [Rule] energy.assist for armcom 8988 | M +29 E 199/539 T2 draining M-float
  9.24  [Playtest] finished armwin team 0 at 9.24 min
  9.25  [Rule] energy.draining for armcom 8988 | M +29 E 180/539 T2 draining M-float
  9.25  [Rule] turret.build for armrectr 6389 | M +29 E 180/538 T2 draining M-float
  9.39  [Playtest] finished armwin team 0 at 9.39 min
  9.40  [Rule] energy.draining for armcom 8988 | M +25 E 152/434 T2 draining M-float
  9.41  [Playtest] finished armmex team 0 at 9.41 min
  9.43  [TECH][Build] armck 25438 expands to a mex at (544, 7168) at +25 metal
  9.43  [Rule] mex.expand for armck 25438 | M +25 E 147/434 T2 draining M-float
  9.51  [Playtest] finished armmex team 0 at 9.51 min
  9.52  [TECH][Build] armck 15553 expands to a mex at (4880, 7408) at +24 metal
  9.52  [Rule] mex.expand for armck 15553 | M +24 E 134/429 T2 draining M-float
  9.62  [Playtest] finished armwin team 0 at 9.61 min
  9.77  [Playtest] finished armwin team 0 at 9.77 min
  9.92  [Playtest] finished armmoho team 0 at 9.92 min
  9.93  [Rule] chain.next for armack 8694 | M +30 E 167/568 T2 draining M-float
  9.98  [Playtest] finished armwin team 0 at 9.98 min
  9.98  [Playtest] finished armmex team 0 at 9.98 min
  9.99  [Playtest] finished armmex team 0 at 9.99 min
  9.99  [Rule] energy.draining for armcom 8988 | M +30 E 163/568 T2 draining M-float
 10.00  [TECH][Build] armck 14057 expands to a mex at (5856, 8176) at +30 metal
 10.00  [Rule] mex.expand for armck 14057 | M +30 E 163/568 T2 draining M-float
 10.00  [Playtest] eco team 0 at 10.0 min: metal +35.9 bank 2990/3600, energy +189.7 bank 0/7761, units 72
 10.00  [TECH][Build] armck 740 expands to a mex at (5824, 7440) at +30 metal
 10.00  [Rule] mex.expand for armck 740 | M +30 E 163/568 T2 draining M-float
 10.01  [Playtest] finished armmex team 0 at 10.01 min
 10.03  [TECH][Build] armck 25438 expands to a mex at (1168, 6400) at +30 metal
 10.03  [Rule] mex.expand for armck 25438 | M +30 E 163/568 T2 draining M-float
 10.04  [TECH][Build] no open mex spot within 2500 of armrectr 6389 at +30 metal
 10.04  [Rule] energy.assist for armrectr 6389 | M +30 E 163/568 T2 draining M-float
 10.10  [Playtest] finished armwin team 0 at 10.10 min
 10.11  [Rule] turret.build for armrectr 6389 | M +32 E 163/634 T2 draining M-float
 10.13  [Playtest] finished armmex team 0 at 10.13 min
 10.13  [Playtest] finished armnanotc team 0 at 10.13 min
 10.14  [TECH][Build] armck 15553 expands to a mex at (5216, 6704) at +34 metal
 10.14  [Rule] mex.expand for armck 15553 | M +34 E 177/687 T2 draining M-float
 10.15  [Layout] turrets: order 2 of 2 allowed (build power 540 (2 by power), bank 3207 + 47/s (8 by metal), 0 dear frames take a slot)
 10.15  [Rule] turret.build for armck 26041 | M +34 E 177/687 T2 draining M-float
 10.15  [Layout] advanced lab 11034: nearest construction turret 112 elmos (flush)
 10.15  [Rule] assist.any for armrectr 6389 | M +36 E 184/758 T2 draining M-float
 10.40  [Rule] energy.assist for armcom 8988 | M +67 E 304/1419 T2 draining M-float
 10.42  [Playtest] finished armwin team 0 at 10.42 min
 10.44  [Rule] energy.draining for armcom 8988 | M +71 E 318/1488 T2 draining M-float
 10.60  [Playtest] finished armmoho team 0 at 10.60 min
 10.61  [Rule] chain.next for armack 14743 | M +76 E 364/1589 T2 draining M-float
 10.61  [Rule] energy.assist for armrectr 6389 | M +76 E 364/1589 T2 draining M-float
 10.62  [Playtest] finished armwin team 0 at 10.62 min
 10.64  [Rule] turret.build for armrectr 6389 | M +76 E 380/1598 T2 M-float
 10.82  [Playtest] finished armmex team 0 at 10.82 min
 10.83  [Rule] turret.build for armck 25438 | M +86 E 362/1787 T2 M-float
 10.87  [Playtest] finished armmex team 0 at 10.87 min
 10.88  [Rule] turret.build for armck 15553 | M +86 E 362/1787 T2 draining M-float
 10.95  [Playtest] finished armwin team 0 at 10.95 min
 10.95  [Playtest] finished armmex team 0 at 10.95 min
 10.95  [Playtest] finished armmoho team 0 at 10.95 min
 10.96  [Rule] energy.draining for armcom 8988 | M +86 E 362/1787 T2 draining M-float
 10.96  [Rule] turret.build for armck 740 | M +86 E 362/1787 T2 draining M-float
 10.97  [Rule] defence.fortify for armack 22328 | M +88 E 363/1823 T2 M-float
 11.00  [Playtest] eco team 0 at 11.0 min: metal +102.2 bank 4672/4950, energy +533.6 bank 1355/7763, units 79
 11.04  [Rule] power.turret for armrectr 6389 | M +92 E 394/1909 T2 draining M-float
 11.11  [Playtest] finished armwin team 0 at 11.11 min
 11.22  [Playtest] finished armmex team 0 at 11.22 min
 11.22  [Playtest] finished armwin team 0 at 11.22 min
 11.23  [Rule] energy.draining for armck 14057 | M +102 E 550/2103 T2 draining M-float
 11.24  [Rule] storage.metal for armcom 8988 | M +102 E 553/2103 T2 draining M-float
 11.26  [Rule] chain.next for armack 272 | M +102 E 556/2103 T2 draining M-float
 11.27  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 5000 of 5000) (D-103)
 11.31  [Playtest] finished armnanotc team 0 at 11.31 min
 11.32  [Rule] defence.fortify for armck 15553 | M +102 E 590/2103 T2 M-float
 11.32  [Layout] turrets: order 2 of 4 allowed (build power 1080 (4 by power), bank 5000 + 104/s (8 by metal), 0 dear frames take a slot)
 11.33  [Layout] turrets: order 3 of 4 allowed (build power 1080 (4 by power), bank 5000 + 104/s (8 by metal), 0 dear frames take a slot)
 11.33  [Layout] turrets: order 4 of 4 allowed (build power 1080 (4 by power), bank 5000 + 104/s (8 by metal), 0 dear frames take a slot)
 11.40  [Rule] assist.any for armrectr 6389 | M +103 E 639/2139 T2 draining M-float
 11.50  [Playtest] finished armmstor team 0 at 11.50 min
 11.52  [Rule] assist.any for armcom 8988 | M +104 E 660/2149 T2 draining M-float
 11.53  [Ferry] requested a transport (TECH at +20 metal, no transport)
 11.63  [Rule] chain.next for armack 30305 | M +104 E 656/2149 T2 draining
 11.64  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 5583 of 8000) (D-103)
 11.76  [Playtest] finished armfort team 0 at 11.76 min
 11.77  [Rule] chain.next for armack 22328 | M +103 E 656/2122 T2 draining
 11.81  [Playtest] finished armnanotc team 0 at 11.81 min
 11.83  [Layout] turrets: order 4 of 5 allowed (build power 1620 (6 by power), bank 6272 + 104/s (8 by metal), 1 dear frames take a slot)
 11.83  [Rule] power.t1 for armck 26041 | M +103 E 665/2122 T2
 12.00  [Playtest] eco team 0 at 12.0 min: metal +104.5 bank 7057/8000, energy +685.8 bank 954/7964, units 88
 12.04  [Rule] power.turret for armrectr 6389 | M +104 E 685/2149 T2 M-float
 12.22  [Layout] new set of armafus at (1168, 9376), 0 cell(s) from a turret
 12.22  [Rule] chain.next for armack 18662 | M +104 E 685/2149 T2 M-float
 12.22  [TECH][Factory] armalab: T2 constructor 7 of 10 (bank 7881 of 8000) (D-103)
 12.34  [Playtest] finished armmoho team 0 at 12.34 min
 12.36  [Rule] assist.any for armrectr 6389 | M +104 E 685/2149 T2 M-float
 12.36  [Rule] assist.any for armack 8694 | M +104 E 685/2149 T2 M-float
 12.36  [Playtest] finished armdrag team 0 at 12.36 min
 12.37  [Layout] turrets: order 5 of 6 allowed (build power 1770 (6 by power), bank 8208 + 122/s (8 by metal), 0 dear frames take a slot)
 12.37  [Rule] turret.build for armck 15553 | M +104 E 687/2149 T2 M-float
 12.42  [TECH][Build] the advanced lab is kept: the advanced fusion is funded without it: bank 8475 + 120/s x 224 s (0% built, build power 1470) = 35563 against 8245 (85% of 9700) (D-105)
 12.48  [Playtest] finished armnanotc team 0 at 12.48 min
 12.50  [Rule] power.turret for armcom 8988 | M +104 E 695/2149 T2 M-float
 12.50  [Rule] defence.fortify for armck 26041 | M +111 E 695/2287 T2 M-float
 12.51  [Rule] power.turret for armrectr 6389 | M +111 E 695/2287 T2 M-float
 12.51  [Rule] defence.fortify for armack 8694 | M +111 E 695/2287 T2 M-float
 12.54  [Playtest] finished armmoho team 0 at 12.54 min
 12.55  [Layout] new set of armafus at (1072, 9376), 0 cell(s) from a turret
 12.55  [Rule] chain.next for armack 14743 | M +111 E 695/2287 T2 draining M-float
 12.64  [Playtest] finished armnanotc team 0 at 12.64 min
 12.65  [Rule] chain.next for armcom 8988 | M +111 E 691/2287 T2 M-float
 12.66  [Layout] turrets: order 4 of 7 allowed (build power 2250 (8 by power), bank 9100 + 118/s (8 by metal), 1 dear frames take a slot)
 12.66  [Rule] power.t1 for armck 25438 | M +111 E 691/2287 T2 M-float
 12.66  [Rule] chain.next for armrectr 6389 | M +111 E 691/2287 T2 M-float
 12.90  [Rule] assist.any for armack 27802 | M +118 E 690/2425 T2 draining M-float
 12.90  [TECH][Factory] armalab: T2 constructor 8 of 10 (bank 9100 of 9100) (D-103)
 13.00  [Playtest] eco team 0 at 13.0 min: metal +118.3 bank 9096/9100, energy +674.8 bank 329/8164, units 94
 13.11  [Playtest] finished armnanotc team 0 at 13.11 min
 13.12  [Layout] turrets: order 4 of 7 allowed (build power 2340 (8 by power), bank 9100 + 118/s (8 by metal), 1 dear frames take a slot)
 13.12  [Rule] power.t1 for armck 25438 | M +118 E 671/2425 T2 M-float
 13.42  [Playtest] finished armfort team 0 at 13.42 min
 13.44  [Rule] assist.any for armack 8694 | M +118 E 706/2425 T2 M-float
 13.47  [Layout] turrets: order 5 of 7 allowed (build power 2640 (9 by power), bank 9100 + 118/s (8 by metal), 1 dear frames take a slot)
 13.55  [Rule] assist.any for armack 15638 | M +118 E 706/2425 T2 draining M-float
 13.55  [TECH][Factory] armalab: T2 constructor 9 of 10 (bank 9100 of 9100) (D-103)
 13.59  [Playtest] finished armdrag team 0 at 13.59 min
 13.60  [Layout] turrets: order 6 of 7 allowed (build power 3390 (12 by power), bank 9100 + 118/s (201 by metal), 1 dear frames take a slot)
 13.60  [Rule] power.t1 for armck 26041 | M +118 E 706/2425 T2 draining M-float
 14.00  [Playtest] eco team 0 at 14.0 min: metal +62.1 bank 9095/9100, energy +451.6 bank 0/8264, units 103
 14.03  [Rule] chain.next for armack 27802 | M +64 E 454/1341 T2 draining M-float
 14.06  [Playtest] finished armmoho team 0 at 14.06 min
 14.08  [Rule] chain.next for armack 22328 | M +59 E 438/1241 T2 draining M-float
 14.10  [Playtest] finished armnanotc team 0 at 14.10 min
 14.11  [Layout] turrets: order 6 of 6 allowed (build power 3930 (14 by power), bank 9245 + 75/s (72 by metal), 2 dear frames take a slot)
 14.11  [Rule] power.t1 for armck 25438 | M +59 E 438/1241 T2 draining M-float
 14.12  [Rule] chain.next for armack 15638 | M +59 E 438/1241 T2 draining M-float
 14.41  [Rule] chain.next for armck 25438 | M +106 E 545/2186 T2 draining M-float
 14.46  [Playtest] finished armnanotc team 0 at 14.46 min
 14.47  [Rule] chain.next for armack 8694 | M +106 E 583/2186 T2 draining M-float
 14.53  [Ferry] requested a transport (TECH at +20 metal, no transport)
 15.00  [Playtest] eco team 0 at 15.0 min: metal +86.1 bank 9646/9650, energy +542.3 bank 0/8264, units 105
 15.00  [Playtest] camera requested (837,10407) height=2200
 15.01  [Playtest] camera captured name=ta position=(837,10407) height=2200
 15.01  [Playtest] screenshot at 15.0 min of team 0 at (837, 10407)
 15.06  [Playtest] finished armnanotc team 0 at 15.06 min
 15.08  [Layout] turrets: order 4 of 6 allowed (build power 4560 (17 by power), bank 9650 + 86/s (74 by metal), 2 dear frames take a slot)
 15.08  [Rule] power.t1 for armck 740 | M +86 E 536/1781 T2 draining M-float
 15.15  [Playtest] finished armnanotc team 0 at 15.15 min
 15.17  [Layout] turrets: order 4 of 6 allowed (build power 4800 (18 by power), bank 9650 + 86/s (71 by metal), 2 dear frames take a slot)
 15.17  [Rule] power.t1 for armck 15553 | M +86 E 496/1781 T2 draining M-float
 16.00  [Playtest] eco team 0 at 16.0 min: metal +125.2 bank 9645/9650, energy +727.1 bank 0/8264, units 107
 16.03  [Playtest] finished armmoho team 0 at 16.03 min
 16.04  [Rule] chain.next for armack 272 | M +125 E 726/2563 T2 draining M-float
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
