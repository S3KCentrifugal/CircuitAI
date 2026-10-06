# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 5.2 min (frame 9315); wall 77 s
- DLL: build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T04:50:58
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: spam-build.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T075058Z-b2b8b33a\runs\20261006T075218Z-04b360a7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `spawn` | **missing** (by 5 min) | |
| expect `repeat` | **missing** (by 5 min) | |
| expect `offspring` | **missing** (by 5 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Failures

- 'spawn' not seen by 5.0 min
- 'repeat' not seen by 5.0 min
- 'offspring' not seen by 5.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T075058Z-b2b8b33a\runs\20261006T075218Z-04b360a7\screen_2026-10-06_07-51-43-536.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T075058Z-b2b8b33a\runs\20261006T075218Z-04b360a7\screen_2026-10-06_07-51-49-799.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T075058Z-b2b8b33a\runs\20261006T075218Z-04b360a7\screen_2026-10-06_07-51-57-790.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 8, 0 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 3000/3000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 0, side offset -16 cells, forward offset 0 cells
  0.08  [Layout] home centre (3898, 2442), 98 from the start
  0.08  [Layout] turret box 40x44 cells at (4282, 2442), from the start rear 0, side 24, ground 98%, halo 87%: zone 7, 4 rows, 51 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (4042, 2866) facing 0, 0 cells ahead of turret row 0
  0.08  [Layout] the front is (3072, 5120): the labs face 0 (lane (3072, 5120), the pair faces 0)
  0.08  [Layout] advanced lab faces 0 (the pair faces 0)
  0.08  [Layout] advanced lab's footprint reserved at (4040, 2872), 451 from the home centre, 21 turret slots within reach, 7 flush (D-095)
  0.08  [Layout] forward cluster 40x44 cells at (4602, 3274), 8 cells ahead of the main cluster, ground 99%: zone 8, 4 rows, 52 turret slots
  0.08  [Rule] table of 50 rules loaded
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmex team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Rule] chain.next for armcom 28429 | M +0 E 0/61 T1 E-float M-float
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Team][Roster] first mex 14262 at 3984,2608
  0.20  [Team][Roster] Re-announced: roster|1|0|0|TECH|armada|armlab|3997|2443|0|6|1|3984|2608
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.22  [Playtest] finished armalab team 0 at 0.22 min
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  0.23  [Rule] chain.next for armck 30293 | M +0 E 6/63 T2 E-float M-float
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  0.23  [TECH][Factory] armalab: T2 constructor 1 of 10 (bank 3050 of 3050) (D-103)
  0.23  [Rule] chain.next for armck 4097 | M +0 E 6/63 T2 E-float M-float
  0.24  [Rule] chain.next for armck 25829 | M +0 E 12/66 T2 E-float M-float
  0.24  [TECH][Build] armck 4089 expands to a mex at (3936, 1232) at +0 metal
  0.24  [Rule] mex.expand for armck 4089 | M +0 E 12/66 T2 E-float M-float
  0.38  [Ferry] requested a transport (TECH at +20 metal, no transport)
  0.42  [Playtest] finished armmex team 0 at 0.43 min
  0.44  [Rule] power.turret for armcom 28429 | M +199 E 24056/4050 T2 E-float M-float
  0.45  [TECH][Factory] combat production unlocked at +210.719 metal (gate 200)
  0.48  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 3300 of 3300) (D-103)
  0.48  [TECH][Build] the economy is online (+210 metal): no lab is reclaimed for metal from now on (D-102, D-105)
  0.48  [Rule] power.turret for armack 19861 | M +210 E 24058/4274 T2 E-float M-float
  0.63  [Playtest] finished armmex team 0 at 0.63 min
  0.65  [Rule] defence.fortify for armck 30293 | M +212 E 24059/4307 T2 E-float M-float
  0.65  [Rule] defence.fortify for armack 19861 | M +212 E 24059/4307 T2 E-float M-float
  0.72  [TECH][Factory] armalab: T2 constructor 3 of 10 (bank 3350 of 3350) (D-103)
  0.72  [Rule] power.turret for armack 20327 | M +212 E 24072/4311 T2 E-float M-float
  0.76  [Playtest] finished armmex team 0 at 0.76 min
  0.79  [Rule] weapons.cluster for armck 4097 | M +214 E 24072/4344 T2 E-float M-float
  0.85  [Playtest] finished armmex team 0 at 0.85 min
  0.86  [Rule] chain.next for armack 20327 | M +214 E 24072/4344 T2 E-float M-float
  0.87  [Rule] weapons.cluster for armck 4089 | M +214 E 24073/4347 T2 E-float M-float
  0.93  [Rule] power.turret for armcom 28429 | M +216 E 24081/4380 T2 E-float M-float
  0.94  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 3450 of 3450) (D-103)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +218.1 bank 3443/3450, energy +24100.0 bank 1066470/1072700, units 46
  1.17  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 3450 of 3450) (D-103)
  1.38  [Playtest] finished armnanotc team 0 at 1.38 min
  1.39  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 3450 of 3450) (D-103)
  1.39  [Rule] chain.next for armack 9898 | M +218 E 24112/4421 T2 E-float M-float
  1.40  [Rule] chain.next for armack 8806 | M +218 E 24114/4421 T2 E-float M-float
  1.41  [Rule] weapons.cluster for armck 30293 | M +218 E 24114/4421 T2 E-float M-float
  1.42  [Rule] weapons.cluster for armck 4097 | M +218 E 24114/4421 T2 E-float M-float
  1.42  [Rule] weapons.cluster for armck 4089 | M +218 E 24114/4421 T2 E-float M-float
  1.43  [Rule] weapons.cluster for armck 25829 | M +218 E 24114/4421 T2 E-float M-float
  1.52  [Rule] power.turret for armcom 28429 | M +218 E 24114/4421 T2 E-float M-float
  1.54  [Rule] power.turret for armack 20327 | M +218 E 24115/4421 T2 E-float M-float
  1.55  [Rule] power.turret for armack 7961 | M +218 E 24115/4421 T2 E-float M-float
  1.56  [Rule] power.turret for armack 19861 | M +218 E 24118/4421 T2 E-float M-float
  1.62  [TECH][Factory] armalab: T2 constructor 7 of 10 (bank 3450 of 3450) (D-103)
  1.62  [Rule] power.turret for armack 27301 | M +218 E 24128/4421 T2 E-float M-float
  1.68  [Playtest] finished armnanotc team 0 at 1.68 min
  1.71  [Rule] weapons.cluster for armck 4097 | M +218 E 24128/4421 T2 E-float M-float
  1.76  [Playtest] finished armnanotc team 0 at 1.76 min
  1.76  [Playtest] finished armrl team 0 at 1.76 min
  1.79  [Rule] weapons.cluster for armck 30293 | M +218 E 24132/4421 T2 E-float M-float
  1.79  [Rule] weapons.cluster for armck 4089 | M +218 E 24132/4421 T2 E-float M-float
  1.84  [TECH][Factory] armalab: T2 constructor 8 of 10 (bank 3450 of 3450) (D-103)
  1.84  [Rule] power.turret for armack 27839 | M +218 E 24140/4421 T2 E-float M-float
  2.00  [Playtest] eco team 0 at 2.0 min: metal +218.1 bank 3413/3450, energy +24156.0 bank 1066635/1073100, units 57
  2.07  [TECH][Factory] armalab: T2 constructor 9 of 10 (bank 3450 of 3450) (D-103)
  2.07  [Rule] power.turret for armack 11358 | M +218 E 24156/4421 T2 E-float M-float
  2.24  [Playtest] finished armrl team 0 at 2.24 min
  2.25  [Rule] weapons.cluster for armck 25829 | M +218 E 24160/4421 T2 E-float M-float
  2.29  [TECH][Factory] armalab: T2 constructor 10 of 10 (bank 3450 of 3450) (D-103)
  2.29  [Rule] power.turret for armack 5644 | M +218 E 24168/4421 T2 E-float M-float
  2.49  [Playtest] finished armfus team 0 at 2.49 min
  2.50  [Playtest] finished armrl team 0 at 2.50 min
  2.52  [Rule] power.turret for armack 8806 | M +218 E 24182/4421 T2 E-float M-float
  2.54  [Rule] weapons.cluster for armck 30293 | M +218 E 24184/4421 T2 E-float M-float
  2.54  [Rule] power.turret for armack 25277 | M +218 E 24184/4421 T2 E-float M-float
  2.63  [Rule] power.turret for armfark 28741 | M +218 E 24184/4421 T2 E-float M-float
  2.69  [Playtest] finished armmoho team 0 at 2.69 min
  2.70  [Rule] power.turret for armack 9898 | M +218 E 24867/4421 T2 E-float M-float
  2.75  [Rule] power.turret for armfark 18926 | M +218 E 24948/4421 T2 E-float M-float
  2.77  [Playtest] finished armnanotc team 0 at 2.77 min
  2.77  [Playtest] finished armnanotc team 0 at 2.77 min
  2.78  [Rule] weapons.cluster for armck 4097 | M +218 E 24948/4421 T2 E-float M-float
  2.82  [Rule] weapons.cluster for armck 4089 | M +218 E 24955/4421 T2 E-float M-float
  2.90  [Playtest] finished armnanotc team 0 at 2.90 min
  2.95  [Rule] weapons.cluster for armck 25829 | M +223 E 24967/4531 T2 E-float M-float
  2.96  [Playtest] finished armnanotc team 0 at 2.96 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +223.6 bank 3986/4000, energy +24972.0 bank 1069876/1075950, units 69
  3.04  [Playtest] finished armnanotc team 0 at 3.04 min
  3.08  [Rule] weapons.cluster for armck 30293 | M +223 E 24972/4531 T2 E-float M-float
  3.14  [Playtest] finished armnanotc team 0 at 3.14 min
  3.16  [Rule] chain.next for armack 27301 | M +223 E 24972/4531 T2 E-float M-float
  3.22  [Rule] power.turret for armcom 28429 | M +223 E 24972/4531 T2 E-float M-float
  3.22  [Rule] power.turret for armfark 18926 | M +223 E 24972/4531 T2 E-float M-float
  3.23  [Rule] power.turret for armfark 28741 | M +223 E 24972/4531 T2 E-float M-float
  3.23  [Rule] power.turret for armack 8806 | M +223 E 24972/4531 T2 E-float M-float
  3.24  [Rule] power.turret for armack 20327 | M +223 E 24972/4531 T2 E-float M-float
  3.24  [Rule] power.turret for armack 7961 | M +223 E 24972/4531 T2 E-float M-float
  3.38  [Ferry] requested a transport (TECH at +20 metal, no transport)
  3.38  [Playtest] finished armrl team 0 at 3.38 min
  3.43  [Playtest] finished armnanotc team 0 at 3.43 min
  3.43  [Rule] weapons.cluster for armck 25829 | M +223 E 24972/4531 T2 E-float M-float
  3.48  [Rule] weapons.cluster for armck 4097 | M +223 E 24972/4531 T2 E-float M-float
  3.50  [Playtest] finished armnanotc team 0 at 3.51 min
  3.55  [Rule] weapons.cluster for armck 30293 | M +223 E 24972/4531 T2 E-float M-float
  3.58  [Playtest] finished armnanotc team 0 at 3.58 min
  3.67  [Playtest] finished armmoho team 0 at 3.67 min
  3.69  [Playtest] finished armrl team 0 at 3.69 min
  3.70  [Rule] chain.next for armack 27301 | M +223 E 24972/4531 T2 E-float M-float
  3.76  [Rule] power.turret for armck 4089 | M +223 E 24972/4531 T2 E-float M-float
  3.77  [Rule] power.turret for armack 8806 | M +223 E 24972/4531 T2 E-float M-float
  3.83  [Playtest] finished armnanotc team 0 at 3.83 min
  3.87  [Rule] weapons.cluster for armck 4089 | M +229 E 24972/4641 T2 E-float M-float
  3.88  [Layout] turrets: order 4 of 8 allowed (build power 3810 (14 by power), bank 4550 + 229/s (8 by metal), 0 dear frames take a slot)
  3.88  [Rule] power.turret for armck 25829 | M +229 E 24972/4641 T2 E-float M-float
  3.91  [Rule] power.turret for armcom 28429 | M +229 E 24972/4641 T2 E-float M-float
  4.00  [Playtest] eco team 0 at 4.0 min: metal +229.1 bank 4546/4550, energy +24972.0 bank 1070263/1075950, units 87
  4.08  [Playtest] finished armrl team 0 at 4.07 min
  4.09  [Playtest] finished armnanotc team 0 at 4.09 min
  4.10  [Rule] defence.fortify for armack 8806 | M +229 E 24972/4641 T2 E-float M-float
  4.10  [Rule] defence.fortify for armack 20327 | M +229 E 24972/4641 T2 E-float M-float
  4.12  [Rule] power.turret for armck 30293 | M +229 E 24972/4641 T2 E-float M-float
  4.14  [Rule] power.turret for armck 4089 | M +229 E 24972/4641 T2 E-float M-float
  4.32  [Playtest] finished armnanotc team 0 at 4.32 min
  4.35  [Layout] turrets: order 3 of 8 allowed (build power 4440 (16 by power), bank 4550 + 229/s (8 by metal), 0 dear frames take a slot)
  4.35  [Layout] turrets: order 4 of 8 allowed (build power 4440 (16 by power), bank 4550 + 229/s (8 by metal), 0 dear frames take a slot)
  4.36  [Layout] turrets: order 5 of 8 allowed (build power 4440 (16 by power), bank 4550 + 229/s (8 by metal), 0 dear frames take a slot)
  4.36  [Rule] power.turret for armck 25829 | M +229 E 24972/4641 T2 E-float M-float
  4.47  [Playtest] finished armmoho team 0 at 4.47 min
  4.48  [Playtest] finished armnanotc team 0 at 4.48 min
  4.49  [Rule] power.turret for armack 27301 | M +229 E 24972/4641 T2 E-float M-float
  4.55  [Playtest] finished armnanotc team 0 at 4.55 min
  4.58  [Playtest] finished armcir team 0 at 4.58 min
  4.59  [Rule] weapons.cluster for armck 4089 | M +229 E 24972/4641 T2 E-float M-float
  4.60  [Rule] weapons.cluster for armck 25829 | M +229 E 24972/4641 T2 E-float M-float
  4.61  [Playtest] finished armfort team 0 at 4.61 min
  4.61  [Rule] defence.fortify for armack 11358 | M +229 E 24972/4641 T2 E-float M-float
  4.64  [Rule] power.turret for armack 20327 | M +234 E 24972/4751 T2 E-float M-float
  4.65  [Rule] weapons.cluster for armck 4097 | M +234 E 24972/4751 T2 E-float M-float
  4.67  [Playtest] finished armfort team 0 at 4.67 min
  4.69  [Rule] defence.fortify for armack 27301 | M +234 E 24972/4751 T2 E-float M-float
  4.70  [Rule] power.turret for armack 8806 | M +234 E 24972/4751 T2 E-float M-float
  4.75  [Rule] power.turret for armcom 28429 | M +234 E 24972/4751 T2 E-float M-float
  4.75  [Rule] power.turret for armfark 18926 | M +234 E 24972/4751 T2 E-float M-float
  4.76  [Rule] power.turret for armfark 28741 | M +234 E 24972/4751 T2 E-float M-float
  4.77  [Playtest] finished armnanotc team 0 at 4.77 min
  4.80  [Rule] chain.next for armack 8806 | M +234 E 24972/4751 T2 E-float M-float
  4.82  [Rule] weapons.cluster for armck 30293 | M +234 E 24972/4751 T2 E-float M-float
  5.00  [Playtest] eco team 0 at 5.0 min: metal +234.6 bank 5095/5100, energy +24972.0 bank 1070031/1075950, units 103
  5.04  [Rule] power.turret for armack 25277 | M +234 E 24972/4751 T2 E-float M-float
  5.05  [Rule] power.turret for armcom 28429 | M +234 E 24972/4751 T2 E-float M-float
  5.06  [Rule] power.turret for armfark 18926 | M +234 E 24972/4751 T2 E-float M-float
  5.07  [Rule] power.turret for armfark 28741 | M +234 E 24972/4751 T2 E-float M-float
  5.08  [Rule] power.turret for armack 20327 | M +234 E 24972/4751 T2 E-float M-float
  5.09  [Rule] power.turret for armack 7961 | M +234 E 24972/4751 T2 E-float M-float
  5.10  [Rule] power.turret for armack 9898 | M +234 E 24972/4751 T2 E-float M-float
  5.10  [Rule] power.turret for armack 19861 | M +234 E 24972/4751 T2 E-float M-float
  5.11  [Rule] power.turret for armack 27839 | M +234 E 24972/4751 T2 E-float M-float
  5.11  [Rule] power.turret for armack 5644 | M +234 E 24972/4751 T2 E-float M-float
  5.15  [Playtest] finished armfort team 0 at 5.15 min
  5.17  [Rule] defence.fortify for armack 11358 | M +234 E 24972/4751 T2 E-float M-float
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (4283, 2299) facing 0, 77x63 cells: 4373 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4283, 2795) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4283, 2747) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4283, 2699) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4283, 2651) facing 0: 12 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (4040, 2872) facing 0 (id 62)
  0.08  RESERVE: zone 8 at (4603, 3275) facing 0, 41x45 cells: 1837 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4603, 3627) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4603, 3579) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4603, 3531) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4603, 3483) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (3360, 2864) facing 0 (id 115)
  0.08  RESERVE: zone 9 at (3360, 2792) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (3360, 2816) facing 0: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (3456, 2840) facing 0, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (3360, 2840) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (3360, 3088) facing 0, 10x20 cells: 190 of 200 held
  0.08  RESERVE: armlab at (3088, 8880) facing 2 (id 1)
  0.08  RESERVE: zone 1 at (3088, 8952) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (3088, 8928) facing 2: 2 of 2 slots (group 1, zone)
  0.08  RESERVE: corridor 2 at (3184, 8904) facing 2, 6x21 cells: 114 of 126 held
  0.08  RESERVE: corridor 3 at (2992, 8904) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 4 at (3088, 8904) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 4 at (3088, 8656) facing 2, 10x20 cells: 180 of 200 held
  0.17  RESERVE: armlab at (3120, 2784) facing 0 (id 118)
  0.17  RESERVE: zone 12 at (3120, 2712) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3120, 2736) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (3216, 2760) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (3120, 2760) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (3120, 3008) facing 0, 10x20 cells: 182 of 200 held
  0.17  RESERVE: armlab at (3968, 8784) facing 2 (id 4)
  0.17  RESERVE: zone 5 at (3968, 8856) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3968, 8832) facing 2: 2 of 2 slots (group 2, zone)
  0.17  RESERVE: corridor 6 at (4064, 8808) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 7 at (3968, 8808) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 7 at (3968, 8560) facing 2, 10x20 cells: 190 of 200 held
  0.23  EXP: approach: armck(30293) at (3500, 1800) walks to (3594, 1896), 123 from the armmex site (3680, 1984)
  0.23  EXP: approach: armck(4097) at (3620, 1800) walks to (3303, 1876), 123 from the armmex site (3184, 1904)
  0.23  RESERVE: corridor 15 at (4400, 2032) facing 0, 14x20 cells: 0 of 280 held
  0.24  EXP: approach: armck(25829) at (3740, 1800) walks to (4117, 1759), 123 from the armmex site (4192, 1856)
  0.24  EXP: approach: armck(4089) at (3860, 1800) walks to (3920, 1354), 123 from the armmex site (3936, 1232)
  0.25  RESERVE: corridor 15 at (4400, 2032) facing 0, 14x20 cells: 0 of 280 held
  0.25  RESERVE: armalab at (3864, 3144) facing 0 (id 121)
  0.25  RESERVE: zone 15 at (3864, 3024) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3864, 3072) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (3864, 3096) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (3864, 3392) facing 0, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 18 at (4480, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4480, 3744) facing 0 (id 126)
  0.25  RESERVE: zone 19 at (4448, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4448, 3744) facing 0 (id 127)
  0.25  RESERVE: zone 20 at (4416, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4416, 3744) facing 0 (id 128)
  0.25  RESERVE: zone 21 at (4384, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4384, 3744) facing 0 (id 129)
  0.25  RESERVE: zone 22 at (4352, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4352, 3744) facing 0 (id 130)
  0.25  RESERVE: zone 23 at (4320, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4320, 3744) facing 0 (id 131)
  0.25  RESERVE: zone 24 at (4288, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4288, 3744) facing 0 (id 132)
  0.25  RESERVE: zone 25 at (4256, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4256, 3744) facing 0 (id 133)
  0.25  RESERVE: zone 26 at (4224, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4224, 3744) facing 0 (id 134)
  0.25  RESERVE: zone 27 at (4192, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4192, 3744) facing 0 (id 135)
  0.25  RESERVE: zone 28 at (4160, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4160, 3744) facing 0 (id 136)
  0.25  RESERVE: zone 29 at (3840, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3840, 3744) facing 0 (id 137)
  0.25  RESERVE: zone 30 at (3808, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3808, 3744) facing 0 (id 138)
  0.25  RESERVE: zone 31 at (3776, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3776, 3744) facing 0 (id 139)
  0.25  RESERVE: zone 32 at (3744, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3744, 3744) facing 0 (id 140)
  0.25  RESERVE: zone 33 at (3648, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3648, 3744) facing 0 (id 141)
  0.25  RESERVE: zone 34 at (3616, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3616, 3744) facing 0 (id 142)
  0.25  RESERVE: zone 35 at (3584, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3584, 3744) facing 0 (id 143)
  0.25  RESERVE: zone 36 at (3552, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3552, 3744) facing 0 (id 144)
  0.25  RESERVE: zone 37 at (3520, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3520, 3744) facing 0 (id 145)
  0.25  RESERVE: zone 38 at (4256, 3632) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (4256, 3632) facing 0 (id 146)
  0.25  RESERVE: zone 39 at (3736, 3624) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (3736, 3624) facing 0 (id 147)
  0.25  RESERVE: armalab at (2760, 8904) facing 2 (id 7)
  0.25  RESERVE: zone 8 at (2760, 9024) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (2760, 8976) facing 2: 4 of 4 slots (group 3, zone)
  0.25  RESERVE: zone 9 at (2760, 8952) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 10 at (2760, 8656) facing 2, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 11 at (3520, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3520, 8496) facing 0 (id 12)
  0.25  RESERVE: zone 12 at (3552, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3552, 8496) facing 0 (id 13)
  0.25  RESERVE: zone 13 at (3584, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3584, 8496) facing 0 (id 14)
  0.25  RESERVE: zone 14 at (3616, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3616, 8496) facing 0 (id 15)
  0.25  RESERVE: zone 15 at (3648, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3648, 8496) facing 0 (id 16)
  0.25  RESERVE: zone 16 at (3680, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3680, 8496) facing 0 (id 17)
  0.25  RESERVE: zone 17 at (3712, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3712, 8496) facing 0 (id 18)
  0.25  RESERVE: zone 18 at (3744, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3744, 8496) facing 0 (id 19)
  0.25  RESERVE: zone 19 at (3776, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3776, 8496) facing 0 (id 20)
  0.25  RESERVE: zone 20 at (3808, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3808, 8496) facing 0 (id 21)
  0.25  RESERVE: zone 21 at (3840, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3840, 8496) facing 0 (id 22)
  0.25  RESERVE: zone 22 at (4160, 8496) facing 0, 2x2 cells: 4 of 4 held
```
