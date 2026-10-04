# Playtest report: PASS

- Verdict: **PASS** (pass_on 'milestone')
- Game time reached: 16.0 min (frame 28862); wall 101 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:55:02
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: rush_t2.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-rush\20261003T175502Z-39bd8661\runs\20261003T175647Z-52f2b1ba\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `chain` | seen at 0.1 min | `[TECH][Chain] objective t2 (wind: wind 1 to 19, expected 10, now 8: 4 metal per E/s a turbine, 7.7 a solar; income bonus x1; 2 T1 cons, 1 T2 cons): mex 3, lab 1, wind 4, mex 6, wind 12, alab 1` |
| expect `milestone` | seen at 5.8 min | `[t=00:01:02.498904][f=0010475] [Playtest] finished armalab team 0 at 5.82 min` |
| forbid `script error` | clean |  |
| forbid `combat early` | clean |  |
| forbid `invariant` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-rush\20261003T175502Z-39bd8661\runs\20261003T175647Z-52f2b1ba\screen_2026-10-03_17-56-02-148.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\tech\economy\workforce-control\tech-rush\20261003T175502Z-39bd8661\runs\20261003T175647Z-52f2b1ba\screen_2026-10-03_17-56-40-749.png

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
  0.82  [Playtest] finished armmex team 0 at 0.82 min
  0.84  [TECH][Build] first lab at the commander: (928, 10400), 111 from it, facing 1; the pair's slot stays planned
  0.84  [Rule] chain.next for armcom 8988 | M +6 E 30/116 T1 M-float
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 841/1150, energy +30.0 bank 153/1000, units 5
  1.17  [Playtest] finished armlab team 0 at 1.17 min
  1.18  [TECH][Build] first lab's exit held (zone 54) until it is reclaimed
  1.83  [Playtest] finished armwin team 0 at 1.83 min
  1.84  [Rule] chain.next for armcom 8988 | M +2 E 30/77 T1 draining
  1.98  [Playtest] finished armwin team 0 at 1.98 min
  2.00  [Rule] chain.next for armcom 8988 | M +5 E 38/104 T1 draining
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 928/1250, energy +44.1 bank 54/1101, units 8
  2.12  [Playtest] finished armwin team 0 at 2.12 min
  2.13  [Rule] chain.next for armcom 8988 | M +6 E 51/111 T1 draining
  2.26  [Playtest] finished armwin team 0 at 2.26 min
  2.28  [Rule] chain.next for armcom 8988 | M +8 E 57/143 T1
  2.38  [Playtest] finished armwin team 0 at 2.38 min
  2.41  [Rule] chain.next for armck 15553 | M +8 E 66/143 T1
  2.50  [Playtest] finished armwin team 0 at 2.50 min
  2.65  [Playtest] finished armwin team 0 at 2.65 min
  2.66  [Rule] chain.next for armcom 8988 | M +8 E 106/143 T1
  2.77  [Playtest] finished armwin team 0 at 2.77 min
  2.90  [Playtest] finished armwin team 0 at 2.90 min
  2.91  [Rule] chain.next for armcom 8988 | M +8 E 154/143 T1 E-float M-float
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 1010/1250, energy +207.4 bank 1146/1154, units 18
  3.02  [Playtest] finished armwin team 0 at 3.02 min
  3.04  [Rule] energy.convert.float for armcom 8988 | M +8 E 179/143 T1 E-float M-float
  3.09  [Rule] energy.convert.float for armck 6809 | M +8 E 196/143 T1 E-float M-float
  3.33  [Playtest] finished armmakr team 0 at 3.33 min
  3.34  [Playtest] finished armmex team 0 at 3.34 min
  3.34  [Rule] energy.convert.float for armcom 8988 | M +8 E 233/143 T1 E-float M-float
  3.35  [Rule] energy.convert.float for armck 15553 | M +8 E 233/143 T1 E-float M-float
  3.50  [Rule] chain.next for armck 14057 | M +11 E 233/176 T1 M-float
  3.51  [Playtest] finished armmakr team 0 at 3.51 min
  3.52  [Rule] chain.next for armcom 8988 | M +11 E 233/173 T1 M-float
  3.66  [Playtest] finished armwin team 0 at 3.66 min
  3.85  [Playtest] finished armwin team 0 at 3.85 min
  3.86  [Rule] energy.float for armcom 8988 | M +12 E 245/186 T1 M-float
  3.90  [Rule] chain.next for armck 23225 | M +12 E 253/187 T1 M-float
  3.94  [Playtest] finished armmakr team 0 at 3.94 min
  3.95  [Layout] advanced lab on its planned slot (1288, 9832): 18 turret slots within 260
  3.95  [Rule] chain.next for armck 6809 | M +12 E 255/187 T1 M-float
  3.97  [Playtest] finished armwin team 0 at 3.97 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.3 bank 1237/1300, energy +304.2 bank 1073/1306, units 28
  4.10  [Playtest] finished armwin team 0 at 4.10 min
  4.11  [Playtest] finished armmakr team 0 at 4.11 min
  4.12  [TECH][Build] armck 15553 expands to a mex at (2368, 8128) at +12 metal
  4.12  [Rule] mex.expand for armck 15553 | M +12 E 281/198 T2 M-float
  4.22  [Playtest] finished armwin team 0 at 4.22 min
  4.24  [TECH][Build] T1 lab reclaim deferred: metal 1300 of 1300 leaves no room for its 500
  4.24  [Rule] power.turret for armcom 8988 | M +13 E 304/205 T2 M-float
  4.64  [Playtest] finished armmex team 0 at 4.64 min
  4.65  [Rule] chain.next for armck 14057 | M +12 E 322/187 T2
  4.67  [Rule] chain.next for armcom 8988 | M +12 E 319/187 T2
  5.00  [Playtest] eco team 0 at 5.0 min: metal +13.6 bank 324/1350, energy +271.0 bank 982/1307, units 32
  5.00  [Playtest] target team 0 at (837, 10407) from its start position
  5.00  [Playtest] camera requested (837,10407) height=2200
  5.01  [Playtest] camera captured name=ta position=(837,10407) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (837, 10407)
  5.06  [Playtest] finished armmex team 0 at 5.06 min
  5.07  [Rule] chain.next for armck 23225 | M +13 E 270/208 T2
  5.82  [Playtest] finished armmex team 0 at 5.82 min
  5.82  [Playtest] finished armalab team 0 at 5.82 min
  5.83  [TECH][Build] armck 15553 expands to a mex at (2784, 8048) at +17 metal
  5.83  [Rule] mex.expand for armck 15553 | M +17 E 212/268 T2
  5.83  [TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab 29161; idle build power in range joins
  5.83  [Rule] lab.t1.reclaim for armck 6809 | M +17 E 212/268 T2
  5.83  [Layout] advanced lab 14126: nearest construction turret none (not flush)
  5.83  [Layout] advanced lab 14126: faces 1, the front 1, 0 structures in its exit lane
  5.84  [Rule] lab.t1.reclaim for armck 23225 | M +17 E 211/268 T2
  5.84  [Rule] lab.t1.reclaim for armcom 8988 | M +17 E 211/268 T2
  5.84  [Rule] lab.t1.reclaim for armck 14057 | M +17 E 211/268 T2
  6.00  [Playtest] eco team 0 at 6.0 min: metal +18.1 bank 22/1650, energy +194.3 bank 5/1507, units 34
  6.23  [TECH][Build] armck 6809 expands to a mex at (2848, 11008) at +17 metal
  6.23  [Rule] mex.expand for armck 6809 | M +17 E 174/281 T2
  6.23  [TECH][Build] first lab gone: its exit (zone 54) released
  6.24  [TECH][Build] armck 23225 expands to a mex at (2288, 11968) at +17 metal
  6.24  [Rule] mex.expand for armck 23225 | M +17 E 173/281 T2 draining
  6.24  [Rule] energy.draining for armcom 8988 | M +17 E 173/281 T2 draining
  6.25  [TECH][Build] no open mex spot within 2500 of armck 14057 at +17 metal
  6.25  [Layout] turrets: order 2 of 2 allowed (build power 600 (2 by power), bank 623 + 117/s (8 by metal), 0 dear frames take a slot)
  6.25  [Rule] turret.build for armck 14057 | M +17 E 173/281 T2 draining
  6.40  [Playtest] finished armmex team 0 at 6.40 min
  6.41  [TECH][Build] armck 15553 expands to a mex at (2496, 7776) at +16 metal
  6.41  [Rule] mex.expand for armck 15553 | M +16 E 125/261 T2
  6.45  [Playtest] finished armwin team 0 at 6.45 min
  6.46  [Rule] energy.draining for armcom 8988 | M +16 E 97/261 T2 draining
  6.60  [Playtest] finished armwin team 0 at 6.60 min
  6.61  [Rule] energy.draining for armcom 8988 | M +18 E 77/290 T2 draining
  6.76  [Playtest] finished armwin team 0 at 6.76 min
  6.79  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 864 of 1600) (D-103)
  6.79  [Rule] power.turret for armack 13216 | M +17 E 132/273 T2 draining
  6.90  [Playtest] finished armmex team 0 at 6.90 min
  6.92  [Rule] power.turret for armck 15553 | M +17 E 246/273 T2
  6.97  [Ferry] requested a transport (TECH at +20 metal, no transport)
  6.98  [Playtest] finished armwin team 0 at 6.98 min
  6.99  [Rule] energy.draining for armcom 8988 | M +20 E 296/331 T2 draining
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.7 bank 860/1650, energy +322.0 bank 198/1509, units 41
  7.07  [Playtest] finished armnanotc team 0 at 7.07 min
  7.08  [Layout] advanced lab 14126: nearest construction turret 112 elmos (flush)
  7.08  [Rule] defence.fortify for armack 13216 | M +22 E 311/379 T2
  7.09  [Rule] defence.fortify for armck 15553 | M +22 E 311/379 T2
  7.09  [Rule] energy.assist2 for armck 14057 | M +22 E 311/379 T2
  7.11  [Playtest] finished armwin team 0 at 7.11 min
  7.13  [Rule] storage.energy for armcom 8988 | M +22 E 311/379 T2
  7.13  [Rule] order.repair for armck 14057 | M +22 E 322/379 T2
  7.33  [Rule] chain.next for armack 3082 | M +22 E 382/369 T2
  7.33  [TECH][Build] no open mex spot within 2500 of armck 14057 at +22 metal
  7.33  [Rule] assist.any for armck 14057 | M +22 E 393/369 T2
  7.41  [Playtest] finished armestor team 0 at 7.41 min
  7.49  [Rule] assist.any for armck 14057 | M +22 E 454/369 T2
  7.53  [TECH][Factory] armalab: T2 constructor 3 of 10 (bank 875 of 1650) (D-103)
  7.54  [Playtest] finished armfort team 0 at 7.54 min
  7.55  [Playtest] finished armmex team 0 at 7.55 min
  7.55  [Playtest] finished armmex team 0 at 7.55 min
  7.56  [Rule] defence.fortify for armack 13216 | M +22 E 464/379 T2
  7.56  [TECH][Build] armck 6809 expands to a mex at (4608, 11072) at +22 metal
  7.56  [Rule] mex.expand for armck 6809 | M +22 E 464/379 T2
  7.57  [Rule] order.repair for armck 14057 | M +22 E 463/379 T2
  7.61  [Rule] power.turret for armcom 8988 | M +22 E 456/379 T2
  7.63  [Layout] turrets: order 2 of 2 allowed (build power 840 (3 by power), bank 840 + 26/s (13 by metal), 1 dear frames take a slot)
  7.63  [Rule] power.t1 for armck 23225 | M +22 E 450/379 T2
  7.65  [Playtest] finished armfort team 0 at 7.65 min
  7.66  [Rule] chain.next for armack 13216 | M +22 E 434/379 T2
  7.93  [Rule] defence.fortify for armack 9376 | M +27 E 373/487 T2
  7.93  [Layout] turrets: order 3 of 4 allowed (build power 1440 (5 by power), bank 653 + 27/s (5 by metal), 1 dear frames take a slot)
  7.93  [Rule] power.t1 for armck 14057 | M +27 E 373/487 T2
  8.00  [Playtest] eco team 0 at 8.0 min: metal +27.3 bank 669/1750, energy +472.5 bank 1699/7710, units 49
  8.34  [Playtest] finished armnanotc team 0 at 8.34 min
  8.35  [Rule] chain.next for armck 14057 | M +27 E 479/487 T2 draining
  8.39  [Playtest] finished armfort team 0 at 8.39 min
  8.40  [Rule] defence.fortify for armack 9376 | M +27 E 477/487 T2
  8.48  [Playtest] finished armfort team 0 at 8.48 min
  8.49  [Rule] chain.next for armack 9376 | M +27 E 476/487 T2 draining
  8.80  [Playtest] finished armmex team 0 at 8.80 min
  8.82  [Rule] chain.next for armck 6809 | M +27 E 479/487 T2 draining
  9.00  [Playtest] eco team 0 at 9.0 min: metal +29.6 bank 0/1800, energy +447.5 bank 1177/7710, units 54
  9.07  [Playtest] finished armdrag team 0 at 9.07 min
  9.09  [Rule] chain.next for armck 15553 | M +29 E 439/547 T2 draining
  9.47  [Playtest] finished armnanotc team 0 at 9.47 min
  9.48  [Rule] chain.next for armck 23225 | M +29 E 331/547 T2 draining
  9.97  [Ferry] requested a transport (TECH at +20 metal, no transport)
 10.00  [Playtest] eco team 0 at 10.0 min: metal +29.6 bank 0/1800, energy +379.1 bank 68/7710, units 55
 11.00  [Playtest] eco team 0 at 11.0 min: metal +30.1 bank 0/1800, energy +479.3 bank 5832/7710, units 55
 12.00  [Playtest] eco team 0 at 12.0 min: metal +29.6 bank 0/1800, energy +400.6 bank 1695/7710, units 55
 12.30  [Playtest] finished armsilo team 0 at 12.30 min
 12.32  [Rule] chain.next for armack 3082 | M +29 E 431/547 T2
 12.32  [TECH][Build] armck 6809 expands to a mex at (816, 7424) at +29 metal
 12.32  [Rule] mex.expand for armck 6809 | M +29 E 437/547 T2
 12.33  [TECH][Build] armck 15553 expands to a mex at (544, 7168) at +29 metal
 12.33  [Rule] mex.expand for armck 15553 | M +29 E 437/547 T2
 12.33  [TECH][Build] no open mex spot within 2500 of armck 23225 at +29 metal
 12.35  [TECH][Build] armck 14057 expands to a mex at (832, 7072) at +29 metal
 12.35  [Rule] mex.expand for armck 14057 | M +29 E 442/547 T2
 12.40  [Rule] energy.draining for armck 23225 | M +29 E 466/547 T2 draining
 12.47  [Rule] energy.assist for armcom 8988 | M +29 E 478/547 T2 draining
 12.97  [Ferry] requested a transport (TECH at +20 metal, no transport)
 13.00  [Playtest] eco team 0 at 13.0 min: metal +18.1 bank 328/1800, energy +462.5 bank 0/7710, units 59
 13.03  [Playtest] finished armadvsol team 0 at 13.03 min
 13.04  [Rule] energy.draining for armck 23225 | M +19 E 462/308 T2 draining
 13.04  [Rule] assist.any for armcom 8988 | M +19 E 462/308 T2 draining
 13.76  [Playtest] finished armmoho team 0 at 13.76 min
 13.77  [Rule] chain.next for armack 13216 | M +19 E 349/321 T2 draining
 13.77  [Playtest] finished armmex team 0 at 13.77 min
 13.77  [Rule] energy.assist for armcom 8988 | M +19 E 349/321 T2 draining
 13.78  [TECH][Build] armck 6809 expands to a mex at (1168, 6400) at +19 metal
 13.78  [Rule] mex.expand for armck 6809 | M +19 E 349/321 T2 draining
 14.00  [Playtest] eco team 0 at 14.0 min: metal +25.0 bank 303/2400, energy +296.3 bank 0/7810, units 62
 14.05  [Playtest] finished armmex team 0 at 14.05 min
 14.07  [TECH][Build] armck 15553 expands to a mex at (432, 5760) at +25 metal
 14.07  [Rule] mex.expand for armck 15553 | M +25 E 296/448 T2 draining
 14.08  [Playtest] finished armmex team 0 at 14.08 min
 14.09  [TECH][Build] armck 14057 expands to a mex at (864, 5264) at +25 metal
 14.09  [Rule] mex.expand for armck 14057 | M +25 E 296/448 T2 draining
 14.30  [Playtest] finished armadvsol team 0 at 14.30 min
 14.31  [Layout] turrets: order 2 of 2 allowed (build power 1320 (4 by power), bank 455 + 24/s (3 by metal), 1 dear frames take a slot)
 14.31  [Rule] power.t1 for armck 23225 | M +23 E 247/389 T2 draining
 14.31  [Rule] energy.draining for armcom 8988 | M +23 E 247/389 T2 draining
 14.54  [Playtest] finished armwin team 0 at 14.54 min
 14.56  [Rule] energy.draining for armcom 8988 | M +35 E 331/711 T2 draining
 14.71  [Playtest] finished armwin team 0 at 14.71 min
 14.72  [Playtest] finished armmex team 0 at 14.72 min
 14.72  [Rule] energy.draining for armcom 8988 | M +35 E 390/725 T2 draining
 14.73  [Layout] turrets: order 3 of 3 allowed (build power 1320 (4 by power), bank 808 + 38/s (10 by metal), 1 dear frames take a slot)
 14.73  [Rule] power.t1 for armck 6809 | M +36 E 393/739 T2 draining
 14.80  [Playtest] finished armmoho team 0 at 14.80 min
 14.81  [Rule] chain.next for armack 3082 | M +36 E 431/754 T2 draining
 14.90  [Playtest] finished armwin team 0 at 14.90 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +52.6 bank 1206/3100, energy +648.4 bank 15/7911, units 70
 15.00  [Playtest] camera requested (837,10407) height=2200
 15.02  [Playtest] camera captured name=ta position=(837,10407) height=2200
 15.02  [Playtest] screenshot at 15.0 min of team 0 at (837, 10407)
 15.04  [Playtest] finished armmoho team 0 at 15.04 min
 15.05  [Rule] chain.next for armack 9376 | M +48 E 614/1038 T2 draining
 15.07  [Playtest] finished armwin team 0 at 15.07 min
 15.16  [Playtest] finished armmex team 0 at 15.16 min
 15.17  [TECH][Build] armck 15553 expands to a mex at (288, 5088) at +42 metal
 15.17  [Rule] mex.expand for armck 15553 | M +42 E 628/914 T2 draining
 15.26  [Playtest] finished armwin team 0 at 15.26 min
 15.42  [Playtest] finished armwin team 0 at 15.42 min
 15.52  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 1957 of 3700) (D-103)
 15.60  [Playtest] finished armwin team 0 at 15.60 min
 15.61  [Rule] energy.draining for armcom 8988 | M +27 E 628/499 T2 draining
 15.64  [Playtest] finished armnanotc team 0 at 15.64 min
 15.66  [TECH][Build] no open mex spot within 2500 of armck 23225 at +42 metal
 15.66  [Rule] assist.any for armck 23225 | M +42 E 684/910 T2 draining
 15.76  [Playtest] finished armwin team 0 at 15.76 min
 15.77  [Rule] energy.draining for armcom 8988 | M +58 E 744/1237 T2 draining
 15.77  [Playtest] finished armmoho team 0 at 15.77 min
 15.79  [Rule] chain.next for armack 13216 | M +58 E 747/1237 T2 draining
 15.86  [Rule] energy.assist for armck 23225 | M +59 E 759/1241 T2 draining
 15.93  [Playtest] finished armmex team 0 at 15.93 min
 15.94  [Playtest] finished armwin team 0 at 15.94 min
 15.94  [Rule] energy.draining for armck 15553 | M +62 E 748/1301 T2 draining
 15.97  [Ferry] requested a transport (TECH at +20 metal, no transport)
 16.00  [Playtest] eco team 0 at 16.0 min: metal +61.8 bank 3042/4300, energy +713.2 bank 30/7914, units 77
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
