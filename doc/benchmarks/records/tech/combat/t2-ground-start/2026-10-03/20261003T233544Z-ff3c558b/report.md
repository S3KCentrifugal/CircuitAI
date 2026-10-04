# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 40.0 min (frame 72090); wall 470 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T20:27:52
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/legion/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: t2_ground_start.json; widget loaded: yes
- Log: build-theatres\games\tech\combat\t2-ground-start\supreme\20261003T232713Z-1fd51b78\runs\20261003T233544Z-ff3c558b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.163076][f=-000001] [TechT2Start] loaded observer_only=1` |
| expect `fast bot completed` | seen at 22.7 min | `[t=00:03:00.862931][f=0040840] [TechT2Start] finished team=0 name=legstr count=1 id=20481` |
| forbid `script error` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-017 the advanced lab's nearest construction turret is 167 elmos away, not flush (160)` |
| forbid `wrong T2 bot` | clean |  |

## Failures

- forbid 'invariant' hit at 7.2 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 167 elmos away, not flush (160)
- forbid 'invariant' hit at 14.2 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (9984, 768) not upgraded
- forbid 'invariant' hit at 14.3 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (2320, 11536) not upgraded
- forbid 'invariant' hit at 15.9 min: [INVARIANT] INV-008 19 turret(s) in range of the reclaim of armalab 3518 are not on it
- forbid 'invariant' hit at 17.5 min: [INVARIANT] INV-011 metal floating at 12898 of 12900 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 18.5 min: [INVARIANT] INV-011 metal floating at 12899 of 12900 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 19.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 19.5 min: [INVARIANT] INV-011 metal floating at 12342 of 13450 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 20.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 21.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 22.8 min: [INVARIANT] INV-022 a new set of legafus starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.6 min: [INVARIANT] INV-022 a new set of armafus starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-011 metal floating at 15592 of 15600 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 25.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.6 min: [INVARIANT] INV-011 metal floating at 14813 of 15600 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.2 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-031 the advanced lab 20546 retired while the advanced fusion was funded: bank 13583 + 414/s x 3 s (84% built, build power 15622) = 14975 against 8925 (85% of 10500)
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-001 a retiring factory produced legstr 1179
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-011 metal floating at 14200 of 14200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-011 metal floating at 15591 of 15600 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-011 metal floating at 15691 of 15700 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 29.4 min: [INVARIANT] INV-031 the advanced lab 26759 retired while the advanced fusion was funded: bank 15694 + 442/s x 1 s (93% built, build power 19350) = 16163 against 8245 (85% of 9700)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-001 a retiring factory produced armack 1071
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-014 legadveconv packed at (576, 9184) with no turret slot within 450
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-019 20 turret frames under construction, 8 allowed (build power 13312 (50 by power), bank 14400 + 538/s (912 by metal))
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 13 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-014 legadveconv packed at (448, 9312) with no turret slot within 450
- forbid 'invariant' hit at 30.8 min: [INVARIANT] INV-019 20 turret frames under construction, 8 allowed (build power 15142 (57 by power), bank 11141 + 585/s (444 by metal))
- forbid 'invariant' hit at 30.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 20 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.2 min: [INVARIANT] INV-014 armmmkr packed at (11760, 2384) with no turret slot within 450
- forbid 'invariant' hit at 31.8 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 32.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.6 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 16792 (63 by power), bank 121 + 504/s (1 by metal))
- forbid 'invariant' hit at 32.8 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 32.9 min: [INVARIANT] INV-014 legadveconv packed at (464, 9760) with no turret slot within 450
- forbid 'invariant' hit at 33.2 min: [INVARIANT] INV-014 armmmkr packed at (11632, 2000) with no turret slot within 450
- forbid 'invariant' hit at 33.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 14 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 33.4 min: [INVARIANT] INV-019 28 turret frames under construction, 8 allowed (build power 15480 (58 by power), bank 14539 + 611/s (702 by metal))
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-038 front cluster 5 (leggant) has stood 180 s with 35 of its 50 turrets
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-022 a new set of legadveconv starts 20 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 34.1 min: [INVARIANT] INV-014 legadveconv packed at (528, 10000) with no turret slot within 450
- forbid 'invariant' hit at 34.4 min: [INVARIANT] INV-019 14 turret frames under construction, 8 allowed (build power 16830 (63 by power), bank 14638 + 600/s (359 by metal))
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-014 armafus packed at (11712, 2576) with no turret slot within 450
- forbid 'invariant' hit at 34.6 min: [INVARIANT] INV-014 armmmkr packed at (11680, 2080) with no turret slot within 450
- forbid 'invariant' hit at 34.7 min: [INVARIANT] INV-038 front cluster 5 (leggant) has stood 240 s with 35 of its 50 turrets
- forbid 'invariant' hit at 34.8 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 35.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 19 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 35.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 20 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 35.3 min: [INVARIANT] INV-014 legadveconv packed at (592, 10064) with no turret slot within 450
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-014 armmmkr packed at (11808, 2192) with no turret slot within 450
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-038 front cluster 5 (leggant) has stood 300 s with 35 of its 50 turrets
- forbid 'invariant' hit at 35.8 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 889 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 36.1 min: [INVARIANT] INV-019 33 turret frames under construction, 3 allowed (build power 15292 (57 by power), bank 115 + 566/s (3 by metal))
- forbid 'invariant' hit at 36.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 36.4 min: [INVARIANT] INV-014 legadveconv packed at (1344, 8944) with no turret slot within 450
- forbid 'invariant' hit at 36.7 min: [INVARIANT] INV-038 front cluster 5 (leggant) has stood 360 s with 35 of its 50 turrets
- forbid 'invariant' hit at 36.8 min: [INVARIANT] INV-060 kill zone cluster #2 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.1 min: [INVARIANT] INV-014 armmmkr packed at (11872, 2192) with no turret slot within 450
- forbid 'invariant' hit at 37.1 min: [INVARIANT] INV-019 30 turret frames under construction, 3 allowed (build power 15802 (59 by power), bank 115 + 595/s (3 by metal))
- forbid 'invariant' hit at 37.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 20 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (13 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 37.7 min: [INVARIANT] INV-038 front cluster 5 (leggant) has stood 420 s with 35 of its 50 turrets
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-032 a armmmkr ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-038 front cluster 5 (leggant) has stood 480 s with 35 of its 50 turrets
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 18396 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 31186 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 28631 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.2 min: [INVARIANT] INV-038 front cluster 5 (armshltx) has stood 244 s with 49 of its 50 turrets
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 21808 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 39.7 min: [INVARIANT] INV-038 front cluster 5 (leggant) has stood 540 s with 35 of its 50 turrets
- forbid 'invariant' hit at 39.8 min: [INVARIANT] INV-046 front cluster 3 (armalab) planned 600 s ago has no factory; 0 of its 4 turrets stand
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 13734 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-022 a new set of legadveconv starts 2 cell(s) from the turrets, not flush

## Screenshots

- build-theatres\games\tech\combat\t2-ground-start\supreme\20261003T232713Z-1fd51b78\runs\20261003T233544Z-ff3c558b\screen_2026-10-03_23-29-14-877.png
- build-theatres\games\tech\combat\t2-ground-start\supreme\20261003T232713Z-1fd51b78\runs\20261003T233544Z-ff3c558b\screen_2026-10-03_23-30-26-691.png
- build-theatres\games\tech\combat\t2-ground-start\supreme\20261003T232713Z-1fd51b78\runs\20261003T233544Z-ff3c558b\screen_2026-10-03_23-31-49-017.png
- build-theatres\games\tech\combat\t2-ground-start\supreme\20261003T232713Z-1fd51b78\runs\20261003T233544Z-ff3c558b\screen_2026-10-03_23-34-30-519.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 20, 4 shots, end at 40.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 37
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 37
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 1, side offset 12 cells, forward offset 4 cells
  0.08  [Layout] home centre (850, 10424), 46 from the start
  0.08  [Layout] turret box 40x44 cells at (850, 9656), from the start rear 0, side 48, ground 99%, halo 85%: zone 7, 4 rows, 52 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (1290, 9896) facing 1, 1 cells ahead of turret row 0
  0.08  [Layout] the front is (6144, 6144): the labs face 1 (lane (6144, 6144), the pair faces 1)
  0.08  [Layout] advanced lab faces 1 (the pair faces 1)
  0.08  [Layout] advanced lab's footprint reserved at (1288, 9896), 685 from the home centre, 18 turret slots within reach, 5 flush (D-095)
  0.08  [Layout] forward cluster 40x36 cells at (1618, 9976), 8 cells ahead of the main cluster, ground 75%: zone 8, 4 rows, 52 turret slots
  0.08  [Rule] table of 50 rules loaded
  0.34  [Playtest] finished legmex team 0 at 0.34 min
  0.35  [Team][Roster] first mex 4808 at 672,10624
  0.35  [Team][Roster] Re-announced: roster|1|0|0|TECH|legion|leglab|809|10443|0|1|1|672|10624
  0.35  [Rule] chain.next for legcom 7321 | M +2 E 30/76 T1 M-float
  0.56  [Playtest] finished legmex team 0 at 0.56 min
  0.57  [Rule] chain.next for legcom 7321 | M +4 E 30/94 T1 M-float
  0.82  [Playtest] finished legmex team 0 at 0.82 min
  0.84  [TECH][Build] first lab at the commander: (1056, 10624), 190 from it, facing 1; the pair's slot stays planned
  0.84  [Rule] chain.next for legcom 7321 | M +6 E 30/116 T1 M-float
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 852/1150, energy +30.0 bank 36/1000, units 5
  1.24  [Playtest] finished leglab team 0 at 1.24 min
  1.25  [Rule] chain.next for legcom 7321 | M +2 E 30/79 T1 draining
  1.25  [TECH][Build] first lab's exit held (zone 54) until it is reclaimed
  1.51  [Playtest] finished legwin team 0 at 1.51 min
  1.52  [Rule] chain.next for legcom 7321 | M +6 E 30/118 T1 draining
  1.66  [Playtest] finished legwin team 0 at 1.66 min
  1.82  [Playtest] finished legwin team 0 at 1.82 min
  1.94  [Playtest] finished legwin team 0 at 1.94 min
  1.95  [Rule] chain.next for legcom 7321 | M +8 E 63/143 T1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 838/1250, energy +60.4 bank 156/1102, units 11
  2.05  [Playtest] finished legwin team 0 at 2.05 min
  2.07  [Rule] chain.next for legcom 7321 | M +8 E 59/143 T1
  2.20  [Playtest] finished legwin team 0 at 2.20 min
  2.26  [Rule] chain.next for legck 5135 | M +8 E 69/143 T1
  2.35  [Playtest] finished legwin team 0 at 2.35 min
  2.37  [Rule] chain.next for legcom 7321 | M +8 E 89/143 T1 draining
  2.49  [Playtest] finished legwin team 0 at 2.49 min
  2.50  [Rule] chain.next for legcom 7321 | M +8 E 110/143 T1
  2.60  [Playtest] finished legwin team 0 at 2.60 min
  2.63  [Rule] chain.next for legck 9897 | M +8 E 123/143 T1
  2.73  [Playtest] finished legwin team 0 at 2.73 min
  2.85  [Playtest] finished legwin team 0 at 2.85 min
  2.87  [Rule] chain.next for legcom 7321 | M +8 E 182/143 T1 E-float
  2.97  [Rule] chain.next for legrezbot 27498 | M +8 E 196/143 T1 E-float
  2.99  [Playtest] finished legwin team 0 at 2.99 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 741/1250, energy +192.1 bank 1199/1206, units 22
  3.00  [TECH][Build] no open mex spot within 2500 of legrezbot 27498 at +8 metal
  3.00  [Rule] assist.any for legrezbot 27498 | M +8 E 195/143 T1 E-float
  3.00  [Rule] energy.convert.float for legcom 7321 | M +8 E 195/143 T1 E-float
  3.19  [Playtest] finished legeconv team 0 at 3.19 min
  3.20  [Rule] chain.next for legcom 7321 | M +8 E 205/143 T1 E-float
  3.22  [Playtest] finished legmex team 0 at 3.22 min
  3.24  [Rule] chain.next for legck 5135 | M +8 E 207/143 T1 E-float
  3.30  [Rule] chain.next for legrezbot 27498 | M +8 E 214/143 T1 E-float
  3.31  [Playtest] finished legwin team 0 at 3.31 min
  3.33  [Rule] chain.next for legcom 7321 | M +8 E 221/143 T1 E-float
  3.34  [Rule] chain.next for legck 7551 | M +8 E 225/143 T1 E-float
  3.66  [Playtest] finished legmex team 0 at 3.66 min
  3.67  [Rule] chain.next for legck 9897 | M +12 E 156/187 T1
  3.72  [Rule] chain.next for legck 14266 | M +12 E 143/187 T1
  3.82  [Playtest] finished legmex team 0 at 3.82 min
  3.84  [Layout] advanced lab on its planned slot (1288, 9896): 18 turret slots within 260
  3.84  [TECH][Build] legck 7551 expands to a mex at (2848, 11008) at +13 metal
  3.84  [Rule] mex.expand for legck 7551 | M +13 E 124/211 T2
  3.85  [TECH][Build] legck 5135 expands to a mex at (2288, 11968) at +13 metal
  3.85  [Rule] mex.expand for legck 5135 | M +13 E 124/211 T2
  3.86  [Layout] turrets: order 1 of 1 allowed (build power 375 (1 by power), bank 948 + 16/s (300 by metal), 0 dear frames take a slot)
  3.86  [Rule] turret.build for legck 14266 | M +13 E 120/211 T2
  3.97  [Playtest] finished legwin team 0 at 3.97 min
  3.98  [Rule] chain.next for legcom 7321 | M +13 E 83/211 T2
  4.00  [Playtest] eco team 0 at 4.0 min: metal +15.8 bank 1002/1400, energy +84.4 bank 733/1307, units 31
  4.04  [TECH][Build] no open mex spot within 2500 of legrezbot 27498 at +15 metal
  4.04  [Rule] assist.any for legrezbot 27498 | M +15 E 83/245 T2
  4.09  [Playtest] finished legwin team 0 at 4.09 min
  4.09  [TECH][Build] T1 lab reclaim deferred: metal 1010 of 1400 leaves no room for its 470
  4.09  [Rule] chain.next for legck 8984 | M +15 E 83/245 T2
  4.10  [Rule] chain.next for legcom 7321 | M +15 E 83/245 T2
  4.13  [Rule] power.turret for legrezbot 27498 | M +15 E 85/245 T2
  4.43  [Playtest] finished legmex team 0 at 4.43 min
  4.45  [Rule] chain.next for legck 5135 | M +11 E 166/179 T2 draining
  5.00  [Playtest] eco team 0 at 5.0 min: metal +19.1 bank 0/1450, energy +295.6 bank 1267/1357, units 34
  5.04  [Rule] chain.next for legrezbot 27498 | M +13 E 294/203 T2 E-float
  5.48  [Playtest] finished legmex team 0 at 5.48 min
  5.49  [Rule] chain.next for legck 7551 | M +19 E 329/305 T2 E-float
  5.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
  5.70  [Playtest] speed 1 at 5.70 min
  5.90  [Playtest] finished legalab team 0 at 5.90 min
  5.90  [Layout] advanced lab 24378: nearest construction turret none (not flush)
  5.90  [Layout] advanced lab 24378: faces 1, the front 1, 0 structures in its exit lane
  5.91  [TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab 12899; idle build power in range joins
  5.91  [Rule] lab.t1.reclaim for legck 8984 | M +21 E 332/351 T2 E-float
  5.92  [Rule] lab.t1.reclaim for legck 9897 | M +21 E 332/351 T2 E-float
  5.92  [Rule] lab.t1.reclaim for legck 7551 | M +21 E 330/351 T2 E-float
  5.93  [Rule] lab.t1.reclaim for legck 5135 | M +21 E 330/351 T2 E-float
  5.93  [Rule] lab.t1.reclaim for legcom 7321 | M +21 E 329/351 T2
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.4 bank 1/1700, energy +323.6 bank 868/1557, units 35
  6.00  [Playtest] target team 0 at (837, 10407) from its start position
  6.00  [Playtest] camera requested (837,10407) height=2000
  6.00  [Playtest] camera captured name=ta position=(837,10407) height=2000
  6.00  [Playtest] screenshot at 6.0 min of team 0 at (837, 10407)
  6.05  [Playtest] speed 20 at 6.05 min
  6.10  [Playtest] finished legnanotc team 0 at 6.10 min
  6.10  [Layout] advanced lab 24378: nearest construction turret 112 elmos (flush)
  6.11  [TECH][Build] no open mex spot within 2500 of legrezbot 27498 at +20 metal
  6.12  [Rule] lab.t1.reclaim for legck 14266 | M +20 E 315/331 T2
  6.30  [Rule] chain.next for legack 24167 | M +20 E 280/331 T2
  6.35  [TECH][Build] first lab gone: its exit (zone 54) released
  6.36  [Rule] defence.fortify for legck 8984 | M +20 E 280/331 T2
  6.36  [Rule] defence.fortify for legck 9897 | M +20 E 280/331 T2
  6.37  [Rule] chain.next for legck 7551 | M +20 E 280/331 T2
  6.37  [Rule] chain.next for legck 5135 | M +20 E 280/331 T2
  6.37  [Rule] chain.next for legcom 7321 | M +20 E 280/331 T2
  6.38  [Rule] chain.next for legck 14266 | M +20 E 280/331 T2
  6.64  [Rule] power.turret for legrezbot 27498 | M +20 E 336/331 T2
  6.72  [Rule] chain.next for legcom 7321 | M +20 E 351/331 T2
  6.76  [Rule] chain.next for legack 10829 | M +20 E 351/331 T2
  6.79  [Playtest] finished legwin team 0 at 6.79 min
  6.80  [Rule] chain.next for legrezbot 27498 | M +20 E 351/331 T2
  6.81  [Layout] turrets: order 2 of 2 allowed (build power 1267 (4 by power), bank 537 + 20/s (3 by metal), 1 dear frames take a slot)
  6.81  [Rule] power.t1 for legck 5135 | M +20 E 351/331 T2
  6.89  [Playtest] finished legdrag team 0 at 6.89 min
  6.90  [Playtest] finished legwin team 0 at 6.90 min
  6.90  [Rule] defence.fortify for legck 8984 | M +20 E 352/331 T2 E-float
  6.91  [Rule] chain.next for legck 7551 | M +20 E 352/331 T2 E-float
  6.92  [Playtest] finished legdrag team 0 at 6.92 min
  6.93  [Rule] defence.fortify for legck 9897 | M +20 E 355/331 T2 E-float
  6.93  [Playtest] finished legwin team 0 at 6.93 min
  6.96  [Rule] chain.next for legck 14266 | M +20 E 371/335 T2 E-float
  6.96  [Playtest] finished legdrag team 0 at 6.96 min
  6.99  [Playtest] finished legdrag team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +21.4 bank 521/1600, energy +423.4 bank 1551/1659, units 46
  7.04  [Playtest] finished legdrag team 0 at 7.04 min
  7.05  [Rule] defence.fortify for legck 8984 | M +21 E 383/351 T2
  7.07  [Playtest] finished legdrag team 0 at 7.07 min
  7.07  [Playtest] finished legwin team 0 at 7.07 min
  7.08  [Rule] defence.fortify for legck 9897 | M +20 E 395/341 T2
  7.10  [Playtest] finished legnanotc team 0 at 7.10 min
  7.12  [Rule] chain.next for legck 5135 | M +20 E 413/333 T2
  7.13  [Playtest] finished legdrag team 0 at 7.13 min
  7.13  [Rule] defence.fortify for legck 14266 | M +20 E 413/333 T2
  7.14  [Rule] chain.next for legck 8984 | M +20 E 417/331 T2
  7.17  [Playtest] finished legdrag team 0 at 7.17 min
  7.18  [Rule] defence.fortify for legck 9897 | M +20 E 423/331 T2 E-float
  7.27  [Playtest] finished legdrag team 0 at 7.27 min
  7.28  [Rule] defence.fortify for legck 9897 | M +20 E 440/331 T2 E-float
  7.30  [Playtest] finished legwin team 0 at 7.30 min
  7.31  [Layout] turrets: order 2 of 2 allowed (build power 1395 (5 by power), bank 470 + 21/s (3 by metal), 1 dear frames take a slot)
  7.31  [Rule] power.t1 for legck 7551 | M +20 E 446/335 T2 E-float
  7.36  [Playtest] finished legdrag team 0 at 7.36 min
  7.37  [Playtest] finished legwin team 0 at 7.37 min
  7.37  [Rule] defence.fortify for legck 9897 | M +21 E 431/351 T2 E-float
  7.38  [Rule] chain.next for legck 5135 | M +21 E 431/351 T2 E-float
  7.42  [Playtest] finished legwin team 0 at 7.43 min
  7.44  [Rule] chain.next for legcom 7321 | M +21 E 390/349 T2
  7.59  [Playtest] finished legmoho team 0 at 7.59 min
  7.59  [Playtest] finished legdrag team 0 at 7.59 min
  7.60  [Playtest] finished legdrag team 0 at 7.60 min
  7.61  [Rule] chain.next for legack 24167 | M +20 E 288/331 T2
  7.61  [TECH][Build] no open mex spot within 2500 of legrezbot 27498 at +20 metal
  7.61  [Rule] chain.next for legck 14266 | M +20 E 288/331 T2
  7.62  [Rule] chain.next for legck 9897 | M +20 E 285/331 T2
  7.64  [Playtest] finished legwin team 0 at 7.64 min
  7.69  [Playtest] finished legnanotc team 0 at 7.69 min
  7.71  [Rule] defence.fortify for legck 7551 | M +20 E 281/331 T2
  7.72  [Playtest] finished legwin team 0 at 7.72 min
  7.73  [Rule] defence.fortify for legack 24167 | M +20 E 281/331 T2
  7.75  [Playtest] finished legwin team 0 at 7.76 min
  7.77  [Rule] chain.next for legck 8984 | M +27 E 281/487 T2
  7.77  [TECH][Build] legck 5135 expands to a mex at (2368, 8128) at +27 metal
  7.77  [Rule] mex.expand for legck 5135 | M +27 E 281/487 T2
  7.78  [Rule] storage.energy for legcom 7321 | M +27 E 281/487 T2
  7.94  [Rule] chain.next for legrezbot 27498 | M +27 E 340/494 T2 E-float
  7.95  [Playtest] finished legwin team 0 at 7.95 min
  7.96  [TECH][Build] legck 8984 expands to a mex at (816, 7424) at +27 metal
  7.96  [Rule] mex.expand for legck 8984 | M +27 E 347/499 T2 E-float
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.3 bank 788/2150, energy +559.1 bank 1659/1663, units 61
  8.04  [Rule] chain.next for legrezbot 27498 | M +28 E 391/512 T2 E-float
  8.14  [Playtest] finished legestor team 0 at 8.14 min
  8.15  [Rule] chain.next for legcom 7321 | M +28 E 536/510 T2
  8.18  [Playtest] finished legwin team 0 at 8.18 min
  8.20  [Rule] chain.next for legck 14266 | M +27 E 565/499 T2
  8.31  [Playtest] finished legwin team 0 at 8.31 min
  8.33  [Rule] chain.next for legck 9897 | M +27 E 567/487 T2
  8.38  [Playtest] finished legdrag team 0 at 8.38 min
  8.39  [Rule] defence.fortify for legck 7551 | M +27 E 584/487 T2 E-float
  8.42  [Playtest] finished legforti team 0 at 8.42 min
  8.44  [Rule] defence.fortify for legack 24167 | M +27 E 593/487 T2 E-float
  8.47  [Playtest] finished legdrag team 0 at 8.47 min
  8.48  [Rule] defence.fortify for legck 7551 | M +27 E 605/487 T2 E-float
  8.55  [Playtest] finished legdrag team 0 at 8.55 min
  8.56  [Rule] defence.fortify for legck 7551 | M +28 E 608/512 T2 E-float
  8.57  [Playtest] finished legforti team 0 at 8.57 min
  8.59  [Rule] defence.fortify for legack 24167 | M +28 E 604/512 T2 E-float
  8.63  [Playtest] finished legdrag team 0 at 8.63 min
  8.65  [Rule] defence.fortify for legck 7551 | M +28 E 602/512 T2 E-float
  8.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
  8.68  [Playtest] finished legforti team 0 at 8.68 min
  8.72  [Playtest] finished legmoho team 0 at 8.72 min
  8.72  [Playtest] finished legdrag team 0 at 8.72 min
  8.73  [Rule] defence.fortify for legck 9897 | M +28 E 602/512 T2 E-float
  8.73  [TECH][Build] no open mex spot within 2500 of legck 7551 at +28 metal
  8.73  [Rule] assist.any for legck 7551 | M +28 E 602/512 T2 E-float
  8.75  [Rule] chain.next for legack 10829 | M +28 E 602/512 T2 E-float
  8.78  [Playtest] finished legforti team 0 at 8.78 min
  8.86  [Rule] assist.any for legck 7551 | M +28 E 604/512 T2 E-float
  8.90  [Playtest] finished legforti team 0 at 8.90 min
  8.91  [Rule] defence.fortify for legack 24167 | M +35 E 609/706 T2 E-float
  8.93  [Rule] chain.next for legrezbot 27498 | M +35 E 613/706 T2 E-float
  8.94  [Rule] chain.next for legcom 7321 | M +35 E 613/706 T2 E-float
  8.95  [Rule] chain.next for legck 14266 | M +35 E 613/706 T2 E-float
  8.98  [Rule] chain.next for legck 7551 | M +35 E 613/706 T2 E-float
  9.00  [Playtest] eco team 0 at 9.0 min: metal +35.2 bank 1435/2700, energy +614.4 bank 7643/7664, units 75
  9.02  [Playtest] finished legforti team 0 at 9.02 min
  9.03  [TECH][Factory] legalab: T2 constructor 3 of 10 (bank 1454 of 2700) (D-103)
  9.04  [Rule] chain.next for legack 24167 | M +35 E 613/706 T2 E-float
  9.22  [Rule] defence.fortify for legack 26825 | M +34 E 607/676 T2
  9.38  [Playtest] finished legdrag team 0 at 9.38 min
  9.40  [Rule] defence.fortify for legck 9897 | M +34 E 611/676 T2
  9.42  [Playtest] finished legmoho team 0 at 9.42 min
  9.44  [Rule] assist.any for legck 7551 | M +34 E 591/676 T2
  9.44  [Rule] assist.any for legrezbot 27498 | M +34 E 591/676 T2
  9.45  [Rule] assist.any for legck 14266 | M +34 E 591/676 T2
  9.45  [Rule] assist.any for legack 10829 | M +34 E 586/676 T2
  9.46  [Playtest] finished legdrag team 0 at 9.46 min
  9.48  [Rule] defence.fortify for legck 9897 | M +34 E 581/676 T2
  9.54  [Rule] assist.any for legck 7551 | M +34 E 571/676 T2 E-float
  9.55  [Rule] assist.any for legrezbot 27498 | M +34 E 570/676 T2 E-float
  9.55  [Playtest] finished legdrag team 0 at 9.55 min
  9.56  [Rule] defence.fortify for legck 14266 | M +34 E 570/676 T2 E-float
  9.62  [TECH][Factory] legalab: T2 constructor 4 of 10 (bank 1806 of 3250) (D-103)
  9.63  [Rule] power.turret for legack 10829 | M +42 E 570/902 T2 E-float
  9.63  [Layout] turrets: order 2 of 3 allowed (build power 990 (3 by power), bank 1806 + 42/s (397 by metal), 0 dear frames take a slot)
  9.63  [Rule] power.turret for legck 9897 | M +42 E 570/902 T2 E-float
  9.64  [Layout] turrets: order 3 of 3 allowed (build power 990 (3 by power), bank 1830 + 42/s (402 by metal), 0 dear frames take a slot)
  9.64  [Rule] power.turret for legck 7551 | M +42 E 570/902 T2 E-float
  9.64  [Rule] power.turret for legrezbot 27498 | M +42 E 570/902 T2 E-float
  9.64  [Rule] power.turret for legcom 7321 | M +42 E 570/902 T2 E-float
  9.69  [Playtest] finished legforti team 0 at 9.69 min
  9.72  [TECH][Build] legack 26825 expands to a mex at (2784, 8048) at +42 metal
  9.72  [Rule] mex.expand for legack 26825 | M +42 E 570/902 T2
  9.77  [TECH][Build] no open mex spot within 2500 of legrezbot 27498 at +41 metal
  9.79  [Rule] defence.fortify for legack 10829 | M +41 E 598/894 T2
  9.80  [TECH][Factory] legalab: T2 constructor 5 of 10 (bank 1821 of 3250) (D-103)
  9.80  [TECH][Build] legack 22589 expands to a mex at (2496, 7776) at +41 metal
  9.80  [Rule] mex.expand for legack 22589 | M +41 E 598/890 T2
  9.96  [Rule] assist.any for legrezbot 27498 | M +41 E 628/882 T2
  9.97  [Rule] assist.any for legcom 7321 | M +41 E 632/882 T2
  9.98  [TECH][Factory] legalab: T2 constructor 6 of 10 (bank 1824 of 3250) (D-103)
  9.98  [Rule] assist.any for legack 18635 | M +41 E 632/882 T2
 10.00  [Playtest] eco team 0 at 10.0 min: metal +41.1 bank 1870/3250, energy +656.7 bank 5043/7964, units 83
 10.00  [Rule] power.turret for legack 18635 | M +41 E 638/882 T2
 10.04  [Rule] power.turret for legrezbot 27498 | M +41 E 642/882 T2
 10.07  [Playtest] finished legdrag team 0 at 10.07 min
 10.08  [Rule] defence.fortify for legck 14266 | M +41 E 642/882 T2
 10.10  [Playtest] finished legnanotc team 0 at 10.10 min
 10.12  [Layout] turrets: order 3 of 7 allowed (build power 2145 (8 by power), bank 1783 + 41/s (13 by metal), 1 dear frames take a slot)
 10.12  [Rule] power.t1 for legck 7551 | M +41 E 642/882 T2
 10.12  [Rule] chain.next for legrezbot 27498 | M +41 E 642/882 T2
 10.12  [Rule] chain.next for legcom 7321 | M +41 E 642/882 T2
 10.13  [Rule] chain.next for legack 18635 | M +41 E 642/882 T2
 10.15  [Playtest] finished legdrag team 0 at 10.15 min
 10.16  [Layout] turrets: order 4 of 6 allowed (build power 1875 (7 by power), bank 1742 + 41/s (15 by metal), 1 dear frames take a slot)
 10.16  [Rule] power.t1 for legck 14266 | M +41 E 648/882 T2
 10.21  [TECH][Factory] legalab: T2 constructor 7 of 10 (bank 1679 of 3250) (D-103)
 10.21  [Rule] chain.next for legack 1185 | M +41 E 656/882 T2 draining
 10.23  [Rule] defence.fortify for legack 1185 | M +41 E 656/882 T2
 10.31  [Playtest] finished legforti team 0 at 10.31 min
 10.32  [Rule] chain.next for legack 10829 | M +41 E 656/882 T2
 10.37  [Playtest] finished legnanotc team 0 at 10.37 min
 10.38  [Layout] turrets: order 4 of 6 allowed (build power 2115 (7 by power), bank 1601 + 41/s (12 by metal), 1 dear frames take a slot)
 10.38  [Rule] power.t1 for legck 9897 | M +41 E 659/882 T2 draining
 10.56  [Playtest] finished legnanotc team 0 at 10.56 min
 10.57  [Layout] turrets: order 4 of 7 allowed (build power 2355 (8 by power), bank 1600 + 41/s (11 by metal), 1 dear frames take a slot)
 10.57  [Rule] power.t1 for legck 7551 | M +41 E 668/882 T2
 10.64  [Playtest] finished legmex team 0 at 10.65 min
 10.66  [Layout] turrets: order 5 of 7 allowed (build power 2737 (10 by power), bank 1541 + 43/s (10 by metal), 1 dear frames take a slot)
 10.66  [Rule] power.t1 for legck 5135 | M +41 E 625/882 T2 draining
 10.70  [Playtest] finished legforti team 0 at 10.70 min
 10.72  [Rule] chain.next for legack 1185 | M +40 E 579/868 T2 draining
 10.85  [Rule] chain.next for legack 24167 | M +37 E 512/790 T2
 10.86  [Playtest] finished legmoho team 0 at 10.86 min
 10.88  [TECH][Build] no open mex spot within 2500 of legack 1185 at +37 metal
 10.88  [Rule] assist.any for legack 1185 | M +37 E 512/790 T2
 10.88  [Rule] assist.any for legrezbot 27498 | M +37 E 512/790 T2
 10.89  [Rule] assist.any for legcom 7321 | M +37 E 512/790 T2
 10.89  [TECH][Build] legack 18635 expands to a mex at (544, 7168) at +37 metal
 10.89  [Rule] mex.expand for legack 18635 | M +37 E 512/790 T2
 10.90  [Rule] assist.any for legack 10829 | M +37 E 512/790 T2
 10.95  [Playtest] finished legnanotc team 0 at 10.95 min
 10.96  [Rule] chain.next for legack 1185 | M +42 E 512/909 T2 draining
 10.97  [Rule] chain.next for legck 9897 | M +43 E 512/928 T2 draining
 10.97  [Rule] chain.next for legrezbot 27498 | M +43 E 512/928 T2 draining
 11.00  [Playtest] eco team 0 at 11.0 min: metal +50.3 bank 1830/3850, energy +653.4 bank 428/8064, units 95
 11.09  [Rule] chain.next for legack 16104 | M +50 E 580/1066 T2 draining
 11.12  [Playtest] finished legnanotc team 0 at 11.12 min
 11.13  [Rule] chain.next for legck 7551 | M +50 E 626/1066 T2
 11.14  [Rule] chain.next for legcom 7321 | M +50 E 626/1066 T2
 11.14  [Rule] chain.next for legack 10829 | M +50 E 626/1066 T2
 11.18  [Playtest] finished legnanotc team 0 at 11.18 min
 11.18  [TECH][Factory] legalab: T2 constructor 8 of 10 (bank 1937 of 3850) (D-103)
 11.19  [Rule] chain.next for legck 14266 | M +50 E 659/1066 T2
 11.45  [TECH][Factory] legalab: T2 constructor 9 of 10 (bank 2175 of 3850) (D-103)
 11.45  [Rule] defence.fortify for legack 8629 | M +50 E 683/1066 T2
 11.63  [Playtest] finished legmex team 0 at 11.63 min
 11.64  [Rule] chain.next for legck 8984 | M +50 E 693/1066 T2 draining
 11.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
 11.69  [TECH][Factory] legalab: T2 constructor 10 of 10 (bank 2282 of 3900) (D-103)
 11.69  [Rule] chain.next for legack 6298 | M +50 E 698/1066 T2 draining
 11.89  [Playtest] finished legforti team 0 at 11.89 min
 11.91  [Rule] chain.next for legack 8629 | M +52 E 710/1112 T2
 12.00  [Playtest] eco team 0 at 12.0 min: metal +52.6 bank 2470/3900, energy +712.7 bank 210/8364, units 103
 12.09  [Rule] defence.fortify for legack 13291 | M +52 E 712/1112 T2
 12.16  [Playtest] finished legmoho team 0 at 12.16 min
 12.21  [Rule] chain.next for legack 22589 | M +52 E 712/1112 T2
 12.23  [Rule] chain.next for legck 5135 | M +52 E 712/1112 T2 draining
 12.27  [Playtest] finished legnanotc team 0 at 12.27 min
 12.50  [Rule] defence.fortify for legaceb 19185 | M +61 E 715/1296 T2
 12.54  [Playtest] finished legforti team 0 at 12.54 min
 12.56  [Rule] chain.next for legack 13291 | M +61 E 715/1296 T2
 12.74  [Rule] chain.next for legaceb 24622 | M +61 E 665/1296 T2
 12.79  [Playtest] finished legmoho team 0 at 12.79 min
 12.81  [Rule] chain.next for legack 26825 | M +61 E 659/1296 T2
 12.84  [Playtest] finished legforti team 0 at 12.84 min
 12.85  [Rule] defence.fortify for legaceb 19185 | M +61 E 643/1296 T2
 13.00  [Playtest] eco team 0 at 13.0 min: metal +71.0 bank 4156/5100, energy +445.0 bank 3939/8664, units 108
 13.02  [Playtest] finished legforti team 0 at 13.02 min
 13.03  [Rule] defence.fortify for legaceb 19185 | M +70 E 448/1462 T2 M-float
 13.03  [Playtest] finished legmoho team 0 at 13.03 min
 13.04  [Rule] defence.fortify for legack 13291 | M +71 E 438/1480 T2
 13.08  [Rule] assist.any for legrezbot 27498 | M +71 E 429/1480 T2
 13.10  [Layout] new set of legafus at (960, 9712), 0 cell(s) from a turret
 13.10  [Rule] energy.float for legack 26825 | M +71 E 429/1480 T2 M-float
 13.11  [Rule] storage.metal for legck 14266 | M +71 E 429/1480 T2 M-float
 13.12  [Rule] storage.metal for legck 8984 | M +71 E 429/1480 T2 M-float
 13.19  [Playtest] finished legforti team 0 at 13.19 min
 13.20  [Rule] defence.fortify for legck 9897 | M +79 E 429/1646 T2 M-float
 13.43  [Rule] assist.any for legrezbot 27498 | M +81 E 647/1683 T2 E-float M-float
 13.47  [Rule] assist.any for legaceb 19185 | M +81 E 681/1685 T2 E-float M-float
 13.48  [Rule] power.turret for legack 10829 | M +81 E 685/1685 T2 E-float M-float
 13.49  [Rule] power.turret for legack 1185 | M +81 E 685/1685 T2 E-float M-float
 13.49  [Layout] turrets: order 2 of 8 allowed (build power 2400 (9 by power), bank 5700 + 81/s (112 by metal), 0 dear frames take a slot)
 13.49  [Rule] power.turret for legck 7551 | M +81 E 685/1685 T2 E-float M-float
 13.51  [Playtest] finished legforti team 0 at 13.51 min
 13.51  [Rule] defence.fortify for legaceb 19185 | M +81 E 687/1685 T2 E-float M-float
 13.52  [Rule] chain.next for legack 13291 | M +81 E 687/1685 T2 E-float M-float
 13.54  [Rule] power.turret for legack 8629 | M +81 E 690/1685 T2 E-float M-float
 13.55  [Layout] turrets: order 3 of 8 allowed (build power 2400 (9 by power), bank 5700 + 81/s (112 by metal), 0 dear frames take a slot)
 13.55  [Rule] power.turret for legaceb 24622 | M +81 E 693/1685 T2 E-float M-float
 13.56  [Rule] power.turret for legack 22589 | M +81 E 693/1685 T2 E-float M-float
 13.56  [Rule] power.turret for legack 18635 | M +81 E 693/1685 T2 E-float M-float
 13.57  [Layout] turrets: order 4 of 8 allowed (build power 2400 (9 by power), bank 5700 + 81/s (112 by metal), 0 dear frames take a slot)
 13.57  [Rule] power.turret for legck 5135 | M +81 E 697/1685 T2 E-float M-float
 13.59  [Rule] power.turret for legack 6298 | M +81 E 703/1685 T2 E-float M-float
 13.60  [Rule] power.turret for legack 16104 | M +81 E 703/1685 T2 E-float M-float
 13.60  [Rule] power.turret for legack 1185 | M +81 E 709/1685 T2 E-float M-float
 13.61  [Rule] power.turret for legrezbot 27498 | M +81 E 709/1685 T2 E-float M-float
 13.61  [Rule] power.turret for legcom 7321 | M +81 E 709/1685 T2 E-float M-float
 13.67  [Playtest] finished legforti team 0 at 13.67 min
 13.69  [Rule] defence.fortify for legaceb 19185 | M +81 E 747/1685 T2 E-float M-float
 13.76  [Rule] power.turret for legack 6298 | M +81 E 756/1685 T2 E-float M-float
 13.77  [Rule] power.turret for legack 16104 | M +81 E 756/1685 T2 E-float M-float
 13.77  [Rule] power.turret for legack 1185 | M +81 E 756/1685 T2 E-float M-float
 13.77  [Rule] power.turret for legrezbot 27498 | M +81 E 756/1685 T2 E-float M-float
 13.78  [Rule] power.turret for legcom 7321 | M +81 E 756/1685 T2 E-float M-float
 13.78  [Rule] power.turret for legack 8629 | M +81 E 756/1685 T2 E-float M-float
 13.85  [Playtest] finished legforti team 0 at 13.85 min
 13.86  [Rule] defence.fortify for legaceb 19185 | M +81 E 755/1685 T2 E-float M-float
 13.90  [Playtest] finished legnanotc team 0 at 13.90 min
 13.93  [Layout] turrets: order 4 of 8 allowed (build power 2850 (10 by power), bank 5700 + 81/s (72 by metal), 0 dear frames take a slot)
 13.93  [Rule] power.turret for legaceb 24622 | M +81 E 749/1685 T2 M-float
 14.00  [Playtest] eco team 0 at 14.0 min: metal +81.3 bank 5685/5700, energy +752.9 bank 7338/8664, units 115
 14.01  [Playtest] finished legnanotc team 0 at 14.01 min
 14.03  [Layout] turrets: order 4 of 8 allowed (build power 3202 (12 by power), bank 5691 + 81/s (59 by metal), 0 dear frames take a slot)
 14.03  [Rule] power.turret for legaceb 24622 | M +81 E 748/1685 T2 M-float
 14.03  [Playtest] finished legforti team 0 at 14.03 min
 14.04  [Rule] defence.fortify for legaceb 19185 | M +81 E 748/1685 T2 M-float
 14.12  [Rule] power.turret for legack 6298 | M +81 E 748/1685 T2 E-float M-float
 14.12  [Rule] power.turret for legack 16104 | M +81 E 749/1685 T2 M-float
 14.13  [Rule] power.turret for legack 1185 | M +81 E 749/1685 T2 M-float
 14.13  [Rule] power.turret for legrezbot 27498 | M +81 E 750/1685 T2 M-float
 14.14  [Playtest] finished legnanotc team 0 at 14.14 min
 14.14  [Rule] power.turret for legcom 7321 | M +81 E 750/1685 T2 M-float
 14.14  [Playtest] finished legdrag team 0 at 14.14 min
... 2679 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (707, 9656) facing 1, 63x77 cells: 4528 of 4851 held
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1203, 9656) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1155, 9656) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1107, 9656) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1059, 9656) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: legalab at (1288, 9896) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (1619, 9976) facing 1, 37x41 cells: 1486 of 1517 held
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1907, 9976) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1859, 9976) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1811, 9976) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1763, 9976) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: leglab at (2064, 8464) facing 1 (id 116)
  0.08  RESERVE: zone 9 at (1992, 8464) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of legnanotc 2x1 gap 0 behind (2016, 8464) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: leglab at (2352, 8384) facing 1 (id 119)
  0.08  RESERVE: zone 10 at (2280, 8384) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of legnanotc 2x1 gap 0 behind (2304, 8384) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: leglab at (2272, 8288) facing 1 (id 122)
  0.08  RESERVE: zone 11 at (2200, 8288) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of legnanotc 2x1 gap 0 behind (2224, 8288) facing 1: 2 of 2 slots (group 9, zone)
  0.08  RESERVE: corridor 12 at (2248, 8384) facing 1, 21x6 cells: 108 of 126 held
  0.08  RESERVE: zone 13 at (2248, 8288) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (2496, 8288) facing 1, 20x10 cells: 190 of 200 held
  0.08  EXP: approach: legcom(7321) at (809, 10444) walks to (755, 10515), 137 from the legmex site (672, 10624)
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
  0.17  RESERVE: leglab at (3184, 8544) facing 1 (id 125)
  0.17  RESERVE: zone 14 at (3112, 8544) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (3136, 8544) facing 1: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: leglab at (3104, 8448) facing 1 (id 128)
  0.17  RESERVE: zone 15 at (3032, 8448) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (3056, 8448) facing 1: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: corridor 16 at (3080, 8544) facing 1, 21x6 cells: 108 of 126 held
  0.17  RESERVE: zone 17 at (3080, 8448) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 17 at (3328, 8448) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: armlab at (9648, 3968) facing 3 (id 119)
  0.17  RESERVE: zone 12 at (9720, 3968) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (9696, 3968) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (9672, 4064) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (9672, 3968) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (9424, 3968) facing 3, 20x10 cells: 190 of 200 held
  0.23  EXP: approach: armcom(12291) at (11494, 1983) walks to (11576, 1804), 136 from the armmex site (11632, 1680)
  0.25  RESERVE: legalab at (1672, 8408) facing 1 (id 131)
  0.25  RESERVE: zone 18 at (1552, 8408) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (1600, 8408) facing 1: 4 of 4 slots (group 12, zone)
  0.25  RESERVE: zone 19 at (1624, 8408) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 20 at (1920, 8408) facing 1, 20x13 cells: 242 of 260 held
  0.25  RESERVE: zone 21 at (2112, 9968) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 9968) facing 0 (id 136)
  0.25  RESERVE: zone 22 at (2112, 10000) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10000) facing 0 (id 137)
  0.25  RESERVE: zone 23 at (2112, 10032) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10032) facing 0 (id 138)
  0.25  RESERVE: zone 24 at (2112, 10064) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10064) facing 0 (id 139)
  0.25  RESERVE: zone 25 at (2112, 10096) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10096) facing 0 (id 140)
  0.25  RESERVE: zone 26 at (2112, 10128) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10128) facing 0 (id 141)
  0.25  RESERVE: zone 27 at (2112, 10160) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10160) facing 0 (id 142)
  0.25  RESERVE: zone 28 at (2112, 10192) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10192) facing 0 (id 143)
  0.25  RESERVE: zone 29 at (2112, 10224) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10224) facing 0 (id 144)
  0.25  RESERVE: zone 30 at (2112, 10256) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10256) facing 0 (id 145)
  0.25  RESERVE: zone 31 at (2112, 10288) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10288) facing 0 (id 146)
  0.25  RESERVE: zone 32 at (2112, 10608) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10608) facing 0 (id 147)
  0.25  RESERVE: zone 33 at (2112, 10640) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10640) facing 0 (id 148)
  0.25  RESERVE: zone 34 at (2112, 10672) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10672) facing 0 (id 149)
  0.25  RESERVE: zone 35 at (2112, 10704) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10704) facing 0 (id 150)
  0.25  RESERVE: zone 36 at (2112, 10736) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10736) facing 0 (id 151)
  0.25  RESERVE: zone 37 at (2112, 10768) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10768) facing 0 (id 152)
  0.25  RESERVE: zone 38 at (2112, 10800) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10800) facing 0 (id 153)
  0.25  RESERVE: zone 39 at (2112, 10832) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10832) facing 0 (id 154)
  0.25  RESERVE: zone 40 at (2112, 10864) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10864) facing 0 (id 155)
  0.25  RESERVE: zone 41 at (2112, 10896) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10896) facing 0 (id 156)
  0.25  RESERVE: zone 42 at (2112, 10928) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10928) facing 0 (id 157)
  0.25  RESERVE: zone 43 at (2000, 10192) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: leglht at (2000, 10192) facing 0 (id 158)
  0.25  RESERVE: zone 44 at (1992, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: legrl at (1992, 10696) facing 0 (id 159)
  0.25  RESERVE: armalab at (10408, 4056) facing 3 (id 122)
  0.25  RESERVE: zone 15 at (10528, 4056) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (10480, 4056) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (10456, 4056) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (10160, 4056) facing 3, 20x13 cells: 245 of 260 held
  0.25  RESERVE: zone 18 at (10176, 2432) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (10176, 2432) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (10176, 2400) facing 0, 2x2 cells: 4 of 4 held
```
