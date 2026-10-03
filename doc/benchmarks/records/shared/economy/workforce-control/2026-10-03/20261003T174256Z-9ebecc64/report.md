# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54042); wall 387 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:36:26
- Map: SpeedMetal BAR V2; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=AIR/armada/test, 2=TECH/cortex/test, 3=AIR/legion/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: metal_field.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\speed-metal\20261003T173625Z-25324730\runs\20261003T174256Z-9ebecc64\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `0` | seen at -0.0 min | `[t=00:00:33.791733][f=-000001] Skirmish AI <BARb playtest-test>: METAL_FIELD: team=0 mode=1 schema=1 candidates=96 cells=16384 map=SpeedMetal BAR V2` |
| expect `1` | seen at 0.5 min | `] [MetalWatch] sample frame=900 team=0 mex=1 mexYield=30.60 converters=0 converterStarts=0 wind=1 labs=0 workers=1 frames=1 M=32.6 bankM=1007.1/1050.0 spendM=30.0 E=55.0 bankE=973.7/1000.5 spendE=60.0` |
| expect `2` | seen at 0.2 min | `[METAL][Economy] M=2 E=50 goal=120 fundedM=0 mex=0 wind=1 dense=false` |
| expect `3` | seen at 0.1 min | `Setup complete role=1 landLocked=false` |
| expect `4` | seen at 0.1 min | `Setup complete role=2 landLocked=false` |
| forbid `0` | **hit** | `[INVARIANT] INV-004 metal floating at 1250 of 1250 for 60 s while armwin is under construction and static build power 0 is under 1814` |
| forbid `1` | clean |  |
| forbid `2` | clean |  |
| forbid `3` | clean |  |
| forbid `native crash` | clean |  |

## Failures

- forbid '0' hit at 2.2 min: [INVARIANT] INV-004 metal floating at 1250 of 1250 for 60 s while armwin is under construction and static build power 0 is under 1814
- forbid '0' hit at 2.2 min: [INVARIANT] INV-004 metal floating at 1249 of 1250 for 60 s while corwin is under construction and static build power 0 is under 1814
- forbid '0' hit at 3.2 min: [INVARIANT] INV-004 metal floating at 1350 of 1350 for 60 s while armwin is under construction and static build power 0 is under 3100
- forbid '0' hit at 3.2 min: [INVARIANT] INV-004 metal floating at 1349 of 1350 for 60 s while coralab is under construction and static build power 0 is under 3100
- forbid '0' hit at 4.2 min: [INVARIANT] INV-004 metal floating at 1500 of 1500 for 60 s while armwin is under construction and static build power 0 is under 4385
- forbid '0' hit at 4.2 min: [INVARIANT] INV-004 metal floating at 1499 of 1500 for 60 s while corwin is under construction and static build power 0 is under 4385
- forbid '0' hit at 5.2 min: [INVARIANT] INV-004 metal floating at 1550 of 1550 for 60 s while armwin is under construction and static build power 0 is under 5548
- forbid '0' hit at 5.2 min: [INVARIANT] INV-004 metal floating at 1599 of 1600 for 60 s while corwin is under construction and static build power 0 is under 5548
- forbid '0' hit at 6.2 min: [INVARIANT] INV-004 metal floating at 1550 of 1550 for 60 s while armwin is under construction and static build power 0 is under 5548
- forbid '0' hit at 6.2 min: [INVARIANT] INV-004 metal floating at 1699 of 1700 for 60 s while coralab is under construction and static build power 0 is under 7383
- forbid '0' hit at 6.6 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 3 has 2410 free
- forbid '0' hit at 7.2 min: [INVARIANT] INV-004 metal floating at 1550 of 1550 for 60 s while armwin is under construction and static build power 0 is under 5548
- forbid '0' hit at 7.6 min: [INVARIANT] INV-001 a retiring factory produced corak 1440
- forbid '0' hit at 7.6 min: [INVARIANT] INV-010 combat unit corak 1440 produced at +460 metal under the gate 500
- forbid '0' hit at 7.7 min: [INVARIANT] INV-004 metal floating at 2098 of 2100 for 60 s while corwin is under construction and static build power 0 is under 9648
- forbid '0' hit at 7.7 min: [INVARIANT] INV-001 a retiring factory produced corak 5261
- forbid '0' hit at 7.9 min: [INVARIANT] INV-001 a retiring factory produced corak 31399
- forbid '0' hit at 8.1 min: [INVARIANT] INV-001 a retiring factory produced corak 19881
- forbid '0' hit at 8.2 min: [INVARIANT] INV-001 a retiring factory produced corak 5997
- forbid '0' hit at 8.3 min: [INVARIANT] INV-001 a retiring factory produced armpw 1086
- forbid '0' hit at 8.4 min: [INVARIANT] INV-001 a retiring factory produced corak 18874
- forbid '0' hit at 8.5 min: [INVARIANT] INV-001 a retiring factory produced armpw 29076
- forbid '0' hit at 8.6 min: [INVARIANT] INV-001 a retiring factory produced corak 20560
- forbid '0' hit at 8.6 min: [INVARIANT] INV-004 metal floating at 1750 of 1750 for 60 s while armwin is under construction and static build power 0 is under 5548
- forbid '0' hit at 8.7 min: [INVARIANT] INV-001 a retiring factory produced armpw 27631
- forbid '0' hit at 8.7 min: [INVARIANT] INV-001 a retiring factory produced corak 15385
- forbid '0' hit at 8.9 min: [INVARIANT] INV-001 a retiring factory produced corak 12618
- forbid '0' hit at 8.9 min: [INVARIANT] INV-001 a retiring factory produced armpw 28647
- forbid '0' hit at 9.0 min: [INVARIANT] INV-001 a retiring factory produced corak 17290
- forbid '0' hit at 9.1 min: [INVARIANT] INV-001 a retiring factory produced armpw 9237
- forbid '0' hit at 9.2 min: [INVARIANT] INV-001 a retiring factory produced corak 10397
- forbid '0' hit at 9.3 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 2256 elmos away, not flush (160)
- forbid '0' hit at 9.3 min: [INVARIANT] INV-001 a retiring factory produced armpw 15292
- forbid '0' hit at 9.4 min: [INVARIANT] INV-001 a retiring factory produced corak 13986
- forbid '0' hit at 9.5 min: [INVARIANT] INV-001 a retiring factory produced armpw 5550
- forbid '0' hit at 9.5 min: [INVARIANT] INV-001 a retiring factory produced corak 13423
- forbid '0' hit at 9.7 min: [INVARIANT] INV-004 metal floating at 5347 of 5350 for 60 s while corfus is under construction and static build power 240 is under 12524
- forbid '0' hit at 9.7 min: [INVARIANT] INV-001 a retiring factory produced corak 1052
- forbid '0' hit at 9.7 min: [INVARIANT] INV-001 a retiring factory produced armpw 8104
- forbid '0' hit at 9.9 min: [INVARIANT] INV-001 a retiring factory produced corak 31310
- forbid '0' hit at 9.9 min: [INVARIANT] INV-001 a retiring factory produced armpw 16702
- forbid '0' hit at 10.0 min: [INVARIANT] INV-001 a retiring factory produced corak 7431
- forbid '0' hit at 10.1 min: [INVARIANT] INV-001 a retiring factory produced armpw 20571
- forbid '0' hit at 10.2 min: [INVARIANT] INV-001 a retiring factory produced corak 15673
- forbid '0' hit at 10.3 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 2256 elmos away, not flush (160)
- forbid '0' hit at 10.3 min: [INVARIANT] INV-001 a retiring factory produced armpw 31960
- forbid '0' hit at 10.4 min: [INVARIANT] INV-001 a retiring factory produced corak 24242
- forbid '0' hit at 10.5 min: [INVARIANT] INV-001 a retiring factory produced corak 20400
- forbid '0' hit at 10.7 min: [INVARIANT] INV-004 metal floating at 4650 of 4650 for 60 s while armfus is under construction and static build power 0 is under 5548
- forbid '0' hit at 10.7 min: [INVARIANT] INV-004 metal floating at 5494 of 5500 for 60 s while corfus is under construction and static build power 720 is under 14115
- forbid '0' hit at 10.7 min: [INVARIANT] INV-001 a retiring factory produced corak 2637
- forbid '0' hit at 10.9 min: [INVARIANT] INV-001 a retiring factory produced corak 9114
- forbid '0' hit at 11.0 min: [INVARIANT] INV-001 a retiring factory produced corak 19473
- forbid '0' hit at 11.2 min: [INVARIANT] INV-001 a retiring factory produced corak 25739
- forbid '0' hit at 11.3 min: [INVARIANT] INV-001 a retiring factory produced corak 30330
- forbid '0' hit at 11.5 min: [INVARIANT] INV-001 a retiring factory produced corak 11448
- forbid '0' hit at 11.7 min: [INVARIANT] INV-001 a retiring factory produced corak 17621
- forbid '0' hit at 11.7 min: [INVARIANT] INV-004 metal floating at 4650 of 4650 for 60 s while armfus is under construction and static build power 0 is under 5548
- forbid '0' hit at 11.7 min: [INVARIANT] INV-004 metal floating at 5545 of 5550 for 60 s while corsilo is under construction and static build power 720 is under 15339
- forbid '0' hit at 11.8 min: [INVARIANT] INV-001 a retiring factory produced corak 23181
- forbid '0' hit at 12.0 min: [INVARIANT] INV-001 a retiring factory produced corak 20542
- forbid '0' hit at 12.1 min: [INVARIANT] INV-001 a retiring factory produced corak 30167
- forbid '0' hit at 12.3 min: [INVARIANT] INV-001 a retiring factory produced corak 18035
- forbid '0' hit at 12.5 min: [INVARIANT] INV-001 a retiring factory produced corak 7485
- forbid '0' hit at 12.6 min: [INVARIANT] INV-001 a retiring factory produced corak 23359
- forbid '0' hit at 12.7 min: [INVARIANT] INV-004 metal floating at 5695 of 5700 for 60 s while corafus is under construction and static build power 720 is under 16563
- forbid '0' hit at 12.8 min: [INVARIANT] INV-001 a retiring factory produced corak 17340
- forbid '0' hit at 12.9 min: [INVARIANT] INV-001 a retiring factory produced corak 17422
- forbid '0' hit at 13.1 min: [INVARIANT] INV-001 a retiring factory produced corak 17579
- forbid '0' hit at 13.3 min: [INVARIANT] INV-001 a retiring factory produced corak 20892
- forbid '0' hit at 13.4 min: [INVARIANT] INV-001 a retiring factory produced corak 23737
- forbid '0' hit at 13.6 min: [INVARIANT] INV-001 a retiring factory produced corak 29537
- forbid '0' hit at 13.7 min: [INVARIANT] INV-004 metal floating at 5795 of 5800 for 60 s while corafus is under construction and static build power 720 is under 18399
- forbid '0' hit at 13.8 min: [INVARIANT] INV-001 a retiring factory produced corak 2762
- forbid '0' hit at 13.9 min: [INVARIANT] INV-001 a retiring factory produced corak 25098
- forbid '0' hit at 14.7 min: [INVARIANT] INV-004 metal floating at 1698 of 1700 for 60 s while cormstor is under construction and static build power 0 is under 5640
- forbid '0' hit at 15.8 min: [INVARIANT] INV-004 metal floating at 4699 of 4700 for 60 s while corafus is under construction and static build power 0 is under 5437
- forbid '0' hit at 16.0 min: [INVARIANT] INV-004 metal floating at 1450 of 1450 for 60 s while armwin is under construction and static build power 0 is under 5486
- forbid '0' hit at 16.8 min: [INVARIANT] INV-004 metal floating at 4748 of 4750 for 60 s while corafus is under construction and static build power 0 is under 6193
- forbid '0' hit at 17.4 min: [INVARIANT] INV-022 a new set of armafus starts 4 cell(s) from the turrets, not flush
- forbid '0' hit at 17.7 min: [INVARIANT] INV-004 metal floating at 4450 of 4450 for 60 s while armfus is under construction and static build power 0 is under 5548
- forbid '0' hit at 17.8 min: [INVARIANT] INV-004 metal floating at 4748 of 4750 for 60 s while corafus is under construction and static build power 0 is under 6160
- forbid '0' hit at 18.7 min: [INVARIANT] INV-004 metal floating at 4400 of 4400 for 60 s while armafus is under construction and static build power 0 is under 4936
- forbid '0' hit at 18.8 min: [INVARIANT] INV-004 metal floating at 4748 of 4750 for 60 s while corafus is under construction and static build power 0 is under 6160
- forbid '0' hit at 19.7 min: [INVARIANT] INV-004 metal floating at 4400 of 4400 for 60 s while armafus is under construction and static build power 0 is under 4936
- forbid '0' hit at 19.8 min: [INVARIANT] INV-004 metal floating at 4747 of 4750 for 60 s while corafus is under construction and static build power 0 is under 8852
- forbid '0' hit at 20.8 min: [INVARIANT] INV-004 metal floating at 4747 of 4750 for 60 s while corafus is under construction and static build power 0 is under 9219
- forbid '0' hit at 21.8 min: [INVARIANT] INV-004 metal floating at 4748 of 4750 for 60 s while corafus is under construction and static build power 0 is under 7322
- forbid '0' hit at 22.8 min: [INVARIANT] INV-004 metal floating at 4747 of 4750 for 60 s while corafus is under construction and static build power 0 is under 9219
- forbid '0' hit at 23.8 min: [INVARIANT] INV-004 metal floating at 4747 of 4750 for 60 s while corafus is under construction and static build power 0 is under 9219
- forbid '0' hit at 24.8 min: [INVARIANT] INV-004 metal floating at 4747 of 4750 for 60 s while corafus is under construction and static build power 0 is under 7995
- forbid '0' hit at 25.8 min: [INVARIANT] INV-004 metal floating at 4747 of 4750 for 60 s while corwin is under construction and static build power 0 is under 9219
- forbid '0' hit at 26.8 min: [INVARIANT] INV-004 metal floating at 4748 of 4750 for 60 s while corwin is under construction and static build power 0 is under 9219
- forbid '0' hit at 27.8 min: [INVARIANT] INV-004 metal floating at 4748 of 4750 for 60 s while corwin is under construction and static build power 0 is under 9219
- forbid '0' hit at 28.8 min: [INVARIANT] INV-004 metal floating at 4748 of 4750 for 60 s while corwin is under construction and static build power 0 is under 9219
- forbid '0' hit at 29.8 min: [INVARIANT] INV-004 metal floating at 4749 of 4750 for 60 s while corwin is under construction and static build power 0 is under 9219

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\speed-metal\20261003T173625Z-25324730\runs\20261003T174256Z-9ebecc64\screen_2026-10-03_17-37-24-769.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\speed-metal\20261003T173625Z-25324730\runs\20261003T174256Z-9ebecc64\screen_2026-10-03_17-38-37-263.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\speed-metal\20261003T173625Z-25324730\runs\20261003T174256Z-9ebecc64\screen_2026-10-03_17-40-55-749.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 30, 3 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1000, 250) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1000, 900) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (12300, 250) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12300, 900) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1000, 250) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1000, 900) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (12300, 250) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12300, 900) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 1); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 1, side offset -16 cells, forward offset 0 cells
  0.08  [Layout] home centre (1053, 482), 241 from the start
  0.08  [Layout] turret box 40x44 cells at (1053, 1058), from the start rear 0, side -36, ground 99%, halo 91%: zone 7, 4 rows, 52 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (1477, 818) facing 1, 0 cells ahead of turret row 0
  0.08  [Layout] the front is (8874, 682): the labs face 1 (lane (8874, 682), the pair faces 1)
  0.08  [Layout] advanced lab faces 1 (the pair faces 1)
  0.08  [Layout] advanced lab's footprint reserved at (1480, 824), 546 from the home centre, 22 turret slots within reach, 7 flush (D-095)
  0.08  [Layout] forward cluster 40x44 cells at (1885, 1058), 8 cells ahead of the main cluster, ground 79%: zone 8, 4 rows, 32 turret slots
  0.10  [Team][Roster] Announced: roster|1|0|0|TECH|armada|armlab|1000|247|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=AIR side=armada start=(1000,897) factory=armap landLocked=no spot=1 known=1/1
  0.15  [Playtest] finished armwin team 0 at 0.15 min
  0.16  [Rule] table of 50 rules loaded
  0.16  [TECH][Opening] home mex order 1/1 at (1072, 240), 72 from start
  0.16  [Rule] opening.mex for armcom 4003 | M +0 E 0/61 T1 E-float M-float
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.28  [Team][Roster] first mex 6664 at 1072,240
  0.28  [Team][Roster] Re-announced: roster|1|0|0|TECH|armada|armlab|1000|247|0|0|1|1072|240
  0.29  [TECH][Opening] complete after 1 mexes, 12 s: the 1 nearest spots are ordered and none is pending; the lab is next
  0.29  [TECH][Build] first lab at the commander: (1056, 160), 103 from it, facing 1; the pair's slot stays planned
  0.29  [Rule] lab.t1.opening for armcom 4003 | M +2 E 30/76 T1 E-float M-float
  0.50  [Ferry] requested a transport (TECH at +20 metal, no transport)
  0.57  [Playtest] finished armlab team 0 at 0.57 min
  0.58  [TECH][Build] first lab's exit held (zone 38) until it is reclaimed
  0.58  [Team][Roster] team 1 first mex at 1520,576
  0.86  [Playtest] finished armwin team 0 at 0.86 min
  0.98  [Playtest] finished armwin team 0 at 0.98 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +32.6 bank 1148/1150, energy +83.5 bank 975/1151, units 8
  1.11  [Playtest] finished armwin team 0 at 1.11 min
  1.16  [Ferry] transport 5330 received and reserved; hold pending task
  1.18  [Ferry] reserved: transport 5330 flying to (1000,247)
  1.25  [Playtest] finished armwin team 0 at 1.25 min
  1.36  [Playtest] finished armwin team 0 at 1.36 min
  1.46  [Playtest] finished armwin team 0 at 1.46 min
  1.54  [Playtest] finished armmex team 0 at 1.54 min
  1.57  [Playtest] finished armwin team 0 at 1.57 min
  1.71  [Playtest] finished armwin team 0 at 1.71 min
  1.79  [Layout] advanced lab on its planned slot (1480, 824): 22 turret slots within 260
  1.86  [Playtest] finished armwin team 0 at 1.86 min
  1.90  [Playtest] finished armwin team 0 at 1.89 min
  1.95  [Playtest] finished armmex team 0 at 1.95 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +93.8 bank 1248/1250, energy +326.0 bank 1242/1255, units 24
  2.10  [Playtest] finished armwin team 0 at 2.11 min
  2.32  [Playtest] finished armwin team 0 at 2.32 min
  2.33  [TECH][Build] T1 lab reclaim deferred: metal 1250 of 1250 leaves no room for its 500
  2.35  [Playtest] finished armmex team 0 at 2.35 min
  2.36  [Playtest] finished armwin team 0 at 2.36 min
  2.56  [Playtest] finished armwin team 0 at 2.56 min
  2.67  [Playtest] finished armwin team 0 at 2.67 min
  2.67  [Playtest] finished armwin team 0 at 2.67 min
  2.78  [Playtest] finished armmex team 0 at 2.78 min
  2.84  [Playtest] finished armwin team 0 at 2.84 min
  2.85  [TECH][Build] T1 lab reclaim deferred: metal 1350 of 1350 leaves no room for its 500
  2.96  [Playtest] finished armwin team 0 at 2.96 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +155.0 bank 1346/1350, energy +526.0 bank 1252/1259, units 34
  3.08  [Playtest] finished armwin team 0 at 3.08 min
  3.17  [Playtest] finished armwin team 0 at 3.17 min
  3.18  [Playtest] finished armmex team 0 at 3.18 min
  3.23  [Playtest] finished armwin team 0 at 3.23 min
  3.53  [TECH][Build] T1 lab reclaim deferred: metal 1400 of 1400 leaves no room for its 500
  3.53  [Playtest] finished armwin team 0 at 3.53 min
  3.61  [Playtest] finished armmex team 0 at 3.61 min
  3.67  [Playtest] finished armwin team 0 at 3.67 min
  3.79  [Playtest] finished armwin team 0 at 3.79 min
  3.80  [TECH][Build] the economy is online (+203 metal): no lab is reclaimed for metal from now on (D-102, D-105)
  3.80  [TECH][Factory] combat production unlocked at +203.96 metal (gate 200)
  3.95  [Playtest] finished armwin team 0 at 3.95 min
  3.95  [Playtest] finished armwin team 0 at 3.95 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +216.2 bank 1447/1450, energy +726.0 bank 1256/1263, units 44
  4.01  [Playtest] finished armmex team 0 at 4.01 min
  4.07  [Playtest] finished armwin team 0 at 4.07 min
  4.08  [TECH][Build] T1 lab reclaim deferred: metal 1500 of 1500 leaves no room for its 500
  4.20  [Playtest] finished armwin team 0 at 4.20 min
  4.32  [Playtest] finished armwin team 0 at 4.32 min
  4.39  [Playtest] finished armwin team 0 at 4.39 min
  4.41  [Playtest] finished armmex team 0 at 4.41 min
  4.51  [Playtest] finished armwin team 0 at 4.51 min
  4.59  [TECH][Build] T1 lab reclaim deferred: metal 1550 of 1550 leaves no room for its 500
  4.68  [Playtest] finished armwin team 0 at 4.68 min
  4.72  [Playtest] finished armwin team 0 at 4.72 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +277.4 bank 1548/1550, energy +901.0 bank 1263/1267, units 51
  5.00  [Playtest] target team 0 at (1000, 250) from its start position
  5.00  [Playtest] camera requested (1000,250) height=2200
  5.02  [Playtest] camera captured name=ta position=(1000,250) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (1000, 250)
  5.12  [TECH][Build] T1 lab reclaim deferred: metal 1550 of 1550 leaves no room for its 500
  5.12  [Playtest] finished armwin team 0 at 5.12 min
  5.20  [Playtest] finished armwin team 0 at 5.20 min
  5.25  [Playtest] finished armwin team 0 at 5.25 min
  5.40  [Playtest] finished armwin team 0 at 5.40 min
  5.41  [Rule] storage.energy for armcom 4003 | M +277 E 968/5608 T2 E-float M-float
  5.58  [Playtest] finished armwin team 0 at 5.58 min
  5.64  [TECH][Build] T1 lab reclaim deferred: metal 1550 of 1550 leaves no room for its 500
  5.66  [Playtest] finished armestor team 0 at 5.66 min
  5.79  [Playtest] finished armwin team 0 at 5.79 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +277.4 bank 1546/1550, energy +1051.0 bank 7264/7270, units 59
  6.03  [Playtest] finished armwin team 0 at 6.03 min
  6.15  [TECH][Build] T1 lab reclaim deferred: metal 1550 of 1550 leaves no room for its 500
  6.16  [Playtest] finished armwin team 0 at 6.16 min
  6.21  [Playtest] finished armwin team 0 at 6.21 min
  6.31  [Playtest] finished armwin team 0 at 6.31 min
  6.50  [Playtest] finished armwin team 0 at 6.50 min
  6.59  [Playtest] finished armwin team 0 at 6.59 min
  6.62  [Playtest] finished armwin team 0 at 6.62 min
  6.65  [TECH][Build] T1 lab reclaim deferred: metal 1550 of 1550 leaves no room for its 500
  6.78  [Playtest] finished armwin team 0 at 6.78 min
  6.94  [Playtest] finished armwin team 0 at 6.94 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +277.4 bank 1545/1550, energy +1276.0 bank 7271/7274, units 68
  7.02  [Playtest] finished armwin team 0 at 7.02 min
  7.06  [Playtest] finished armwin team 0 at 7.06 min
  7.18  [TECH][Build] T1 lab reclaim deferred: metal 1550 of 1550 leaves no room for its 500
  7.19  [Playtest] finished armwin team 0 at 7.19 min
  7.33  [Playtest] finished armalab team 0 at 7.33 min
  7.33  [TECH][Build] advanced lab's exit held (zone 47)
  7.33  [Layout] advanced lab 1210: nearest construction turret none (not flush)
  7.33  [Layout] advanced lab 1210: faces 1, the front 1, 0 structures in its exit lane
  7.34  [TECH][Factory] armalab: T2 constructor 1 of 10 (bank 1750 of 1750) (D-103)
  7.34  [Rule] weapons.cluster for armck 7371 | M +277 E 1326/5608 T2 E-float M-float
  7.35  [Playtest] finished armwin team 0 at 7.35 min
  7.45  [Playtest] finished armwin team 0 at 7.45 min
  7.55  [Playtest] finished armwin team 0 at 7.55 min
  7.67  [Playtest] finished armwin team 0 at 7.67 min
  7.68  [TECH][Build] T1 lab reclaim deferred: metal 1750 of 1750 leaves no room for its 500
  7.72  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 1750 of 1750) (D-103)
  7.72  [Rule] legacy.strategic for armack 20813 | M +277 E 1423/5608 T2 E-float M-float
  7.80  [Playtest] finished armwin team 0 at 7.80 min
  7.89  [Playtest] finished armdrag team 0 at 7.89 min
  7.89  [Playtest] finished armwin team 0 at 7.89 min
  7.90  [Rule] weapons.cluster for armck 7371 | M +277 E 1455/5608 T2 E-float M-float
  7.96  [Playtest] finished armwin team 0 at 7.96 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +277.4 bank 1740/1750, energy +1540.0 bank 7562/7579, units 82
  8.03  [Playtest] finished armdrag team 0 at 8.03 min
  8.04  [Rule] weapons.cluster for armck 7371 | M +277 E 1490/5608 T2 E-float M-float
  8.06  [Rule] assist.any for armack 27768 | M +277 E 1512/5608 T2 E-float M-float
  8.11  [Playtest] finished armdrag team 0 at 8.11 min
  8.12  [Rule] weapons.cluster for armck 7371 | M +277 E 1540/5608 T2 E-float M-float
  8.13  [Rule] weapons.cluster for armck 7371 | M +277 E 1540/5608 T2 E-float M-float
  8.15  [Rule] weapons.cluster for armck 7371 | M +277 E 1540/5608 T2 E-float M-float
  8.16  [Playtest] finished armwin team 0 at 8.16 min
  8.19  [TECH][Build] T1 lab reclaim deferred: metal 1750 of 1750 leaves no room for its 500
  8.39  [Playtest] finished armwin team 0 at 8.39 min
  8.40  [Playtest] finished armwin team 0 at 8.40 min
  8.42  [Ferry] TECH: carrying 3220 to team 1 at (1584,576) anchor=first-mex distance=64
  8.44  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 1750 of 1750) (D-103)
  8.50  [Playtest] finished armwin team 0 at 8.50 min
  8.62  [Ferry] TECH: delivered constructor 3220 to team 1
  8.62  [Playtest] finished armwin team 0 at 8.62 min
  8.71  [TECH][Build] T1 lab reclaim deferred: metal 1732 of 1750 leaves no room for its 500
  8.74  [Playtest] finished armwin team 0 at 8.74 min
  8.81  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 1750 of 1750) (D-103)
  8.81  [Rule] assist.any for armack 11113 | M +277 E 1679/5608 T2 E-float M-float
  8.83  [Playtest] finished armwin team 0 at 8.83 min
  8.86  [Playtest] finished armwin team 0 at 8.86 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +277.4 bank 1732/1750, energy +1768.0 bank 7743/7783, units 98
  9.16  [Playtest] finished armwin team 0 at 9.16 min
  9.19  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 1750 of 1750) (D-103)
  9.19  [Rule] assist.any for armack 5994 | M +277 E 1768/5608 T2 E-float M-float
  9.24  [TECH][Build] T1 lab reclaim deferred: metal 1750 of 1750 leaves no room for its 500
  9.27  [Playtest] finished armwin team 0 at 9.27 min
  9.29  [Playtest] finished armnanotc team 0 at 9.29 min
  9.30  [Layout] advanced lab 1210: nearest construction turret 2256 elmos (not flush)
  9.30  [Rule] weapons.cluster for armck 7371 | M +277 E 1768/5608 T2 E-float M-float
  9.34  [Rule] storage.metal for armcom 4003 | M +277 E 1795/5608 T2 E-float M-float
  9.51  [Playtest] finished armllt team 0 at 9.51 min
  9.56  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 1750 of 1750) (D-103)
  9.62  [Playtest] finished armmstor team 0 at 9.62 min
  9.64  [Rule] assist.any for armcom 4003 | M +277 E 1832/5608 T2 E-float
  9.66  [Playtest] finished armwin team 0 at 9.66 min
  9.66  [TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab 2891; idle build power in range joins
  9.66  [Rule] lab.t1.reclaim for armck 17495 | M +277 E 1832/5608 T2 E-float
  9.68  [Rule] lab.t1.reclaim for armck 14230 | M +277 E 1832/5608 T2 E-float M-float
  9.79  [Playtest] finished armwin team 0 at 9.79 min
  9.80  [TECH][Build] T1 lab reclaim deferred: metal 4750 of 4750 leaves no room for its 500
  9.84  [Playtest] finished armrad team 0 at 9.84 min
  9.85  [Rule] weapons.cluster for armck 7371 | M +277 E 1868/5608 T2 E-float M-float
  9.93  [TECH][Factory] armalab: T2 constructor 7 of 10 (bank 4702 of 4750) (D-103)
  9.93  [Rule] assist.any for armack 23586 | M +277 E 1873/5608 T2 E-float M-float
  9.95  [Playtest] finished armwin team 0 at 9.95 min
  9.96  [Rule] assist.any for armcom 4003 | M +277 E 1896/5608 T2 E-float M-float
 10.00  [Playtest] eco team 0 at 10.0 min: metal +277.4 bank 4718/4750, energy +1935.0 bank 8031/8086, units 113
 10.30  [TECH][Factory] armalab: T2 constructor 8 of 10 (bank 4750 of 4750) (D-103)
 10.36  [Layout] armlab placed by the layout at (1248, 1424) facing 3: a turret stands, so not anywhere (D-101)
 10.37  [TECH][Build] first lab gone: its exit (zone 38) released
 10.55  [Playtest] finished armdrag team 0 at 10.55 min
 10.56  [Rule] weapons.cluster for armck 7371 | M +277 E 1949/5608 T2 E-float M-float
 10.63  [Playtest] finished armdrag team 0 at 10.63 min
 10.68  [TECH][Factory] armalab: T2 constructor 9 of 10 (bank 4650 of 4650) (D-103)
 10.68  [Rule] assist.any for armack 29057 | M +277 E 1949/5608 T2 E-float M-float
 10.76  [Playtest] finished armdrag team 0 at 10.76 min
 10.77  [Rule] weapons.cluster for armck 7371 | M +277 E 1949/5608 T2 E-float M-float
 10.87  [Playtest] finished armdrag team 0 at 10.87 min
 10.88  [Rule] weapons.cluster for armck 7371 | M +277 E 1960/5608 T2 E-float M-float
 11.00  [Playtest] eco team 0 at 11.0 min: metal +277.4 bank 4604/4650, energy +1963.0 bank 8068/8186, units 120
 11.05  [TECH][Factory] armalab: T2 constructor 10 of 10 (bank 4650 of 4650) (D-103)
 11.05  [Rule] assist.any for armack 1934 | M +277 E 1963/5608 T2 E-float M-float
 11.30  [Playtest] finished armfus team 0 at 11.30 min
 11.30  [Layout] advanced lab 1210: nearest construction turret none (not flush)
 11.32  [Rule] assist.any for armack 29916 | M +277 E 1970/5608 T2 E-float M-float
 11.41  [Rule] assist.any for armack 13213 | M +277 E 1970/5608 T2 E-float M-float
 11.42  [Playtest] finished armwin team 0 at 11.42 min
 11.47  [Playtest] finished armsilo team 0 at 11.47 min
 11.52  [Rule] assist.any for armack 20813 | M +277 E 2570/5608 T2 E-float M-float
 11.61  [Rule] assist.any for armfark 16878 | M +277 E 2753/5608 T2 E-float M-float
 11.79  [Rule] order.repair for armfark 31192 | M +277 E 2767/5608 T2 E-float M-float
 11.96  [Rule] order.repair for armfark 27939 | M +277 E 2774/5608 T2 E-float M-float
 12.00  [Playtest] eco team 0 at 12.0 min: metal +277.4 bank 4580/4650, energy +2795.0 bank 10616/10911, units 122
 12.02  [Playtest] finished armfus team 0 at 12.02 min
 12.05  [Playtest] finished armwin team 0 at 12.05 min
 12.13  [Rule] assist.any for armack 27768 | M +277 E 2786/5608 T2 E-float M-float
 12.14  [Rule] assist.any for armfark 31192 | M +277 E 2789/5608 T2 E-float M-float
 12.14  [Rule] assist.any for armfark 16418 | M +277 E 2789/5608 T2 E-float M-float
 12.15  [Rule] assist.any for armack 11113 | M +277 E 2789/5608 T2 E-float M-float
 12.15  [Rule] assist.any for armack 5994 | M +277 E 2791/5608 T2 E-float M-float
 12.16  [Rule] assist.any for armack 26559 | M +277 E 2791/5608 T2 E-float M-float
 12.16  [Rule] assist.any for armack 23586 | M +277 E 2791/5608 T2 E-float M-float
 12.16  [Rule] assist.any for armack 29057 | M +277 E 2791/5608 T2 E-float M-float
 12.18  [Rule] assist.any for armack 1934 | M +277 E 2793/5608 T2 E-float M-float
 12.18  [Rule] assist.any for armack 13213 | M +277 E 2793/5608 T2 E-float M-float
 12.19  [Rule] order.repair for armfark 31192 | M +277 E 3545/5608 T2 E-float M-float
 12.19  [Rule] legacy.strategic for armack 29916 | M +277 E 3545/5608 T2 E-float M-float
 12.20  [Rule] assist.any for armack 20813 | M +277 E 3545/5608 T2 E-float M-float
 12.22  [Rule] assist.any for armcom 4003 | M +277 E 3567/5608 T2 E-float M-float
 12.26  [Playtest] finished armwin team 0 at 12.26 min
 12.29  [Rule] order.repair for armfark 16878 | M +277 E 3572/5608 T2 E-float M-float
 12.33  [Rule] order.repair for armfark 29098 | M +277 E 3577/5608 T2 E-float M-float
 12.33  [Rule] assist.any for armack 29916 | M +277 E 3579/5608 T2 E-float M-float
 12.34  [Playtest] finished armwin team 0 at 12.34 min
 12.43  [Rule] assist.any for armcom 4003 | M +277 E 3607/5608 T2 E-float M-float
 12.44  [Playtest] finished armwin team 0 at 12.44 min
 12.52  [Rule] assist.any for armack 11113 | M +277 E 3640/5608 T2 E-float M-float
 12.53  [Rule] assist.any for armcom 4003 | M +277 E 3642/5608 T2 E-float M-float
 12.54  [Rule] assist.any for armack 5994 | M +277 E 3642/5608 T2 E-float M-float
 12.54  [Rule] assist.any for armack 27768 | M +277 E 3642/5608 T2 E-float M-float
 12.55  [Rule] assist.any for armack 26559 | M +277 E 3642/5608 T2 E-float M-float
 12.57  [Rule] assist.any for armack 29916 | M +277 E 3642/5608 T2 E-float M-float
 12.57  [Rule] assist.any for armack 29057 | M +277 E 3642/5608 T2 E-float M-float
 12.64  [Rule] order.repair for armfark 28067 | M +277 E 3665/5608 T2 E-float M-float
 12.81  [TECH][Factory] armalab: T2 constructor 10 of 10 (bank 4650 of 4650) (D-103)
 12.82  [Rule] order.repair for armfark 17957 | M +277 E 3675/5608 T2 E-float M-float
 12.99  [Playtest] finished armwin team 0 at 12.99 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +277.4 bank 4597/4650, energy +3679.0 bank 13255/13414, units 125
 13.01  [Rule] order.repair for armfark 31831 | M +277 E 3676/5608 T2 E-float M-float
 13.09  [Rule] assist.any for armfark 27939 | M +277 E 3679/5608 T2 E-float M-float
 13.13  [Rule] assist.any for armfark 16878 | M +277 E 3679/5608 T2 E-float M-float
 13.14  [Rule] assist.any for armack 4880 | M +277 E 3679/5608 T2 E-float M-float
 13.14  [Rule] assist.any for armfark 31192 | M +277 E 3679/5608 T2 E-float M-float
 13.17  [Playtest] finished armfus team 0 at 13.17 min
 13.18  [Rule] assist.any for armack 1934 | M +277 E 3704/5608 T2 E-float M-float
 13.22  [Playtest] finished armwin team 0 at 13.22 min
 13.32  [Rule] assist.any for armack 1934 | M +277 E 4312/5608 T2 E-float M-float
 13.32  [Rule] order.repair for armfark 16878 | M +277 E 4312/5608 T2 E-float M-float
 13.33  [Rule] assist.any for armfark 31192 | M +277 E 4312/5608 T2 E-float M-float
 13.33  [Rule] assist.any for armfark 27939 | M +277 E 4315/5608 T2 E-float M-float
 13.34  [Rule] assist.any for armack 4880 | M +277 E 4315/5608 T2 E-float M-float
 13.34  [Rule] assist.any for armack 11113 | M +277 E 4315/5608 T2 E-float M-float
 13.36  [Rule] assist.any for armack 5994 | M +277 E 4318/5608 T2 E-float M-float
 13.36  [Rule] assist.any for armack 27768 | M +277 E 4318/5608 T2 E-float M-float
 13.37  [Rule] assist.any for armack 26559 | M +277 E 4318/5608 T2 E-float M-float
 13.37  [Rule] assist.any for armack 23586 | M +277 E 4318/5608 T2 E-float M-float
 13.37  [Rule] assist.any for armack 29916 | M +277 E 4318/5608 T2 E-float M-float
 13.38  [Rule] assist.any for armcom 4003 | M +277 E 4318/5608 T2 E-float M-float
 13.39  [Rule] assist.any for armfark 17957 | M +277 E 4343/5608 T2 E-float M-float
 13.40  [Rule] assist.any for armfark 18306 | M +277 E 4343/5608 T2 E-float M-float
 13.40  [Rule] assist.any for armfark 29098 | M +277 E 4493/5608 T2 E-float M-float
 13.40  [Rule] assist.any for armack 29057 | M +277 E 4493/5608 T2 E-float M-float
 13.41  [Rule] assist.any for armack 20813 | M +277 E 4493/5608 T2 E-float M-float
 13.48  [Playtest] finished armwin team 0 at 13.48 min
 13.49  [Rule] order.repair for armfark 9589 | M +277 E 4499/5608 T2 E-float M-float
 13.51  [Rule] order.repair for armfark 31192 | M +277 E 4501/5608 T2 E-float M-float
 13.51  [Rule] order.repair for armfark 27939 | M +277 E 4501/5608 T2 E-float M-float
 13.52  [Rule] order.repair for armfark 17957 | M +277 E 4501/5608 T2 E-float M-float
 13.53  [Rule] assist.any for armfark 31831 | M +277 E 4505/5608 T2 E-float M-float
 13.53  [Playtest] finished armwin team 0 at 13.53 min
 13.58  [Rule] order.repair for armfark 18306 | M +277 E 4505/5608 T2 E-float M-float
 13.67  [Rule] order.repair for armfark 31192 | M +277 E 4534/5608 T2 E-float M-float
 13.69  [Rule] assist.any for armack 5994 | M +277 E 4557/5608 T2 E-float M-float
 13.70  [Rule] assist.any for armack 27768 | M +277 E 4559/5608 T2 E-float M-float
 13.71  [Rule] assist.any for armack 26559 | M +277 E 4559/5608 T2 E-float M-float
 13.71  [Rule] assist.any for armack 29057 | M +277 E 4559/5608 T2 E-float M-float
 13.72  [Rule] assist.any for armack 20813 | M +277 E 4559/5608 T2 E-float M-float
 13.72  [Rule] assist.any for armcom 4003 | M +277 E 4562/5608 T2 E-float M-float
 13.73  [Rule] assist.any for armfark 27939 | M +277 E 4562/5608 T2 E-float M-float
 13.74  [Rule] assist.any for armfark 17957 | M +277 E 4562/5608 T2 E-float M-float
 13.74  [Rule] assist.any for armack 4880 | M +277 E 4562/5608 T2 E-float M-float
 13.75  [Rule] assist.any for armfark 28067 | M +277 E 4562/5608 T2 E-float M-float
 13.76  [Rule] order.repair for armfark 31831 | M +277 E 4562/5608 T2 E-float M-float
 13.90  [Rule] order.repair for armfark 17957 | M +277 E 4567/5608 T2 E-float M-float
 13.90  [Rule] assist.any for armfark 16878 | M +277 E 4567/5608 T2 E-float M-float
 13.91  [Rule] assist.any for armfark 18306 | M +277 E 4567/5608 T2 E-float M-float
 13.92  [Rule] assist.any for armfark 8358 | M +277 E 4567/5608 T2 E-float M-float
 13.93  [Rule] assist.any for armfark 31192 | M +277 E 4567/5608 T2 E-float M-float
 13.93  [Rule] assist.any for armfark 31831 | M +277 E 4567/5608 T2 E-float M-float
 14.00  [Playtest] eco team 0 at 14.0 min: metal +277.4 bank 4573/4650, energy +4555.0 bank 15802/16040, units 130
 14.00  [Rule] assist.any for armfark 17957 | M +277 E 4565/5608 T2 E-float M-float
 14.01  [Rule] assist.any for armfark 9589 | M +277 E 4565/5608 T2 E-float M-float
 14.04  [Rule] order.repair for armfark 9589 | M +277 E 4557/5608 T2 E-float M-float
 14.14  [Rule] order.repair for armfark 18306 | M +277 E 4555/5608 T2 E-float M-float
 14.20  [Playtest] finished armfus team 0 at 14.20 min
 14.22  [Rule] assist.any for armack 1934 | M +277 E 4555/5608 T2 E-float M-float
 14.23  [Rule] order.repair for armfark 31192 | M +277 E 4555/5608 T2 E-float M-float
 14.29  [Rule] assist.any for armfark 1233 | M +277 E 4555/5608 T2 E-float M-float
 14.29  [Rule] assist.any for armfark 9589 | M +277 E 4555/5608 T2 E-float M-float
 14.30  [Rule] assist.any for armfark 18306 | M +277 E 4555/5608 T2 E-float M-float
 14.55  [Playtest] finished armfus team 0 at 14.55 min
 14.57  [Rule] order.repair for armfark 16878 | M +277 E 5316/5608 T2 E-float M-float
 14.79  [Rule] order.repair for armfark 9589 | M +277 E 6064/5608 T2 E-float M-float
 14.80  [Rule] legacy.strategic for armack 4880 | M +277 E 6064/5608 T2 E-float M-float
 14.80  [Rule] order.repair for armfark 18306 | M +277 E 6067/5608 T2 E-float M-float
 14.81  [Rule] order.repair for armfark 31831 | M +277 E 6067/5608 T1 E-float M-float
 14.81  [Rule] legacy.strategic for armack 11113 | M +277 E 6067/5608 T1 E-float M-float
 14.82  [Rule] legacy.strategic for armack 5994 | M +277 E 6063/5608 T1 E-float M-float
 14.82  [Rule] legacy.strategic for armack 27768 | M +277 E 6063/5608 T1 E-float M-float
 14.83  [Rule] legacy.strategic for armack 23586 | M +277 E 6063/5608 T1 E-float M-float
 14.85  [Rule] order.repair for armfark 27939 | M +277 E 6047/5608 T1 E-float M-float
 14.85  [Rule] order.repair for armfark 1233 | M +277 E 6034/5608 T1 E-float M-float
 14.96  [Rule] assist.any for armack 26559 | M +277 E 5944/5608 T1 E-float M-float
 14.96  [Rule] assist.any for armack 23586 | M +277 E 5944/5608 T1 E-float M-float
 14.97  [Rule] assist.any for armack 29916 | M +277 E 5943/5608 T1 E-float M-float
 14.98  [Rule] assist.any for armack 29057 | M +277 E 5943/5608 T1 E-float M-float
 14.98  [Rule] assist.any for armack 20813 | M +277 E 5943/5608 T1 E-float M-float
 14.99  [Rule] order.repair for armfark 17957 | M +277 E 5943/5608 T1 E-float M-float
 15.00  [Rule] assist.any for armfark 28067 | M +277 E 5943/5608 T1 E-float M-float
 15.00  [Playtest] eco team 0 at 15.0 min: metal +277.4 bank 4445/4450, energy +5943.0 bank 20806/20813, units 123
 15.00  [Playtest] camera requested (1000,250) height=2200
 15.00  [Rule] assist.any for armfark 31831 | M +277 E 5943/5608 T1 E-float M-float
 15.01  [Rule] assist.any for armack 11113 | M +277 E 5943/5608 T1 E-float M-float
 15.01  [Playtest] camera captured name=ta position=(1000,250) height=2200
 15.01  [Playtest] screenshot at 15.0 min of team 0 at (1000, 250)
 15.01  [Rule] assist.any for armcom 4003 | M +277 E 5943/5608 T1 E-float M-float
 15.01  [Rule] assist.any for armack 1934 | M +277 E 5943/5608 T1 E-float M-float
 15.03  [Rule] assist.any for armfark 9589 | M +277 E 5943/5608 T1 E-float M-float
 15.03  [Rule] assist.any for armack 4880 | M +277 E 5943/5608 T1 E-float M-float
 15.04  [Rule] assist.any for armfark 18306 | M +277 E 5940/5608 T1 E-float M-float
 15.04  [Rule] assist.any for armack 5994 | M +277 E 5940/5608 T1 E-float M-float
 15.04  [Rule] assist.any for armfark 27939 | M +277 E 5940/5608 T1 E-float M-float
 15.05  [Rule] assist.any for armfark 1233 | M +277 E 5940/5608 T1 E-float M-float
 16.00  [Playtest] eco team 0 at 16.0 min: metal +277.4 bank 1381/1450, energy +3324.0 bank 17983/18201, units 43
 16.04  [Playtest] finished armsilo team 0 at 16.04 min
 16.05  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 16.05  [TECH][Build] start factory ordered on the reserved slot
 16.05  [Rule] lab.t1.opening for armcom 4003 | M +277 E 3291/5608 T1 E-float M-float
 16.06  [Rule] weapons.cluster for armack 1934 | M +277 E 3291/5608 T1 E-float M-float
 16.07  [Rule] order.repair for armfark 9589 | M +277 E 3281/5608 T1 E-float M-float
 16.08  [Rule] weapons.cluster for armack 4880 | M +277 E 3281/5608 T1 E-float M-float
 16.08  [Rule] order.repair for armfark 28067 | M +277 E 3281/5608 T1 E-float M-float
 16.09  [Rule] order.repair for armfark 18306 | M +277 E 3274/5608 T1 E-float M-float
 16.09  [Rule] order.repair for armfark 31831 | M +277 E 3274/5608 T1 E-float M-float
 16.09  [Rule] legacy.strategic for armack 11113 | M +277 E 3274/5608 T1 E-float M-float
 16.13  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 16.13  [Rule] storage.metal for armcom 4003 | M +277 E 3274/5608 T1 E-float M-float
 16.23  [Rule] assist.any for armack 5994 | M +277 E 3274/5608 T1 E-float M-float
 16.24  [Rule] assist.any for armack 27768 | M +277 E 3274/5608 T1 E-float M-float
 16.25  [Rule] assist.any for armack 26559 | M +277 E 3274/5608 T1 E-float M-float
 16.25  [Rule] assist.any for armack 23586 | M +277 E 3274/5608 T1 E-float M-float
 16.26  [Rule] assist.any for armack 29916 | M +277 E 3274/5608 T1 E-float M-float
 16.26  [Rule] assist.any for armack 29057 | M +277 E 3274/5608 T1 E-float M-float
 16.27  [Rule] assist.any for armack 20813 | M +277 E 3273/5608 T1 E-float M-float
 16.28  [Rule] assist.any for armack 11113 | M +277 E 3273/5608 T1 E-float M-float
 16.30  [Rule] assist.any for armack 1934 | M +277 E 3270/5608 T1 E-float M-float
 16.31  [Rule] assist.any for armack 4880 | M +277 E 3270/5608 T1 E-float M-float
 16.38  [Playtest] finished armmstor team 0 at 16.38 min
 16.39  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 16.45  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 16.54  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 16.58  [Playtest] finished armwin team 0 at 16.58 min
 16.63  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 16.68  [Rule] assist.any for armack 23586 | M +277 E 3243/5608 T1 E-float M-float
 16.69  [Rule] assist.any for armack 29916 | M +277 E 3243/5608 T1 E-float M-float
 16.69  [Rule] assist.any for armack 29057 | M +277 E 3243/5608 T1 E-float M-float
 16.70  [Rule] assist.any for armack 20813 | M +277 E 3243/5608 T1 E-float M-float
 16.70  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
 16.70  [Rule] assist.any for armcom 4003 | M +277 E 3243/5608 T1 E-float M-float
 16.73  [Rule] assist.any for armack 27768 | M +277 E 3256/5608 T1 E-float M-float
 16.74  [Rule] assist.any for armack 4880 | M +277 E 3256/5608 T1 E-float M-float
 17.00  [Playtest] eco team 0 at 17.0 min: metal +277.4 bank 4394/4450, energy +3242.0 bank 17662/17976, units 41
 17.06  [Rule] weapons.cluster for armack 5994 | M +277 E 3242/5608 T1 E-float M-float
 17.09  [Rule] assist.any for armack 5994 | M +277 E 3242/5608 T1 E-float M-float
 17.30  [Rule] assist.any for armfark 31831 | M +277 E 3242/5608 T1 E-float M-float
 17.42  [Rule] assist.any for armfark 28067 | M +277 E 3242/5608 T1 E-float M-float
 17.42  [Playtest] finished armfus team 0 at 17.42 min
... 204 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (909, 1059) facing 1, 63x77 cells: 4482 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1405, 1059) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1357, 1059) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1309, 1059) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1261, 1059) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1480, 824) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (1885, 1059) facing 1, 45x41 cells: 1827 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2237, 1059) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2189, 1059) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2141, 1059) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2093, 1059) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (2608, 1040) facing 1 (id 96)
  0.08  RESERVE: zone 9 at (2536, 1040) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2560, 1040) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (6048, 992) facing 1 (id 99)
  0.08  RESERVE: zone 10 at (5976, 992) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (6000, 992) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: corridor 11 at (6024, 1088) facing 1, 21x6 cells: 126 of 126 held
  0.08  RESERVE: zone 12 at (6024, 992) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 12 at (6272, 992) facing 1, 20x10 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.09  RESERVE: zone 7 at (12360, 1091) facing 3, 63x77 cells: 4469 of 4851 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (11864, 1091) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (11912, 1091) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (11960, 1091) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (12008, 1091) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: coralab at (11784, 856) facing 3 (id 63)
  0.09  RESERVE: zone 8 at (11384, 1091) facing 3, 45x41 cells: 1827 of 1845 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (11032, 1091) facing 3: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (11080, 1091) facing 3: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (11128, 1091) facing 3: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (11176, 1091) facing 3: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: corlab at (10688, 1040) facing 3 (id 96)
  0.09  RESERVE: zone 9 at (10760, 1040) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of cornanotc 2x1 gap 0 behind (10736, 1040) facing 3: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (10712, 944) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: zone 11 at (10712, 1040) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (10464, 1040) facing 3, 20x10 cells: 190 of 200 held
  0.16  RESERVE: zone 1 at (1464, 952) facing 1, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armwin at (1464, 952) facing 1 (id 1)
  0.16  RESERVE: zone 1 released
  0.16  RESERVE: zone 2 at (1432, 1064) facing 1, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armwin at (1432, 1064) facing 1 (id 2)
  0.16  RESERVE: zone 3 at (1432, 1016) facing 1, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armwin at (1432, 1016) facing 1 (id 3)
  0.16  RESERVE: zone 4 at (1432, 968) facing 1, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armwin at (1432, 968) facing 1 (id 4)
  0.16  RESERVE: zone 5 at (1480, 1064) facing 1, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armwin at (1480, 1064) facing 1 (id 5)
  0.16  RESERVE: zone 6 at (1480, 1016) facing 1, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armwin at (1480, 1016) facing 1 (id 6)
  0.16  RESERVE: zone 7 at (1480, 968) facing 1, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armwin at (1480, 968) facing 1 (id 7)
  0.16  RESERVE: served armwin at (1432, 1064) facing 1 (id 2, 5 of this def still held)
  0.17  RESERVE: armlab at (2608, 1040) facing 1 (id 102)
  0.17  RESERVE: zone 13 at (2536, 1040) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (6368, 624) facing 1 (id 103)
  0.17  RESERVE: zone 13 at (6296, 624) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (6320, 624) facing 1: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 14 at (6344, 720) facing 1, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (6344, 624) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (6592, 624) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: corlab at (8192, 1024) facing 3 (id 99)
  0.17  RESERVE: zone 12 at (8264, 1024) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of cornanotc 2x1 gap 0 behind (8240, 1024) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (8216, 928) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: corridor 14 at (8216, 1120) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (8216, 1024) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (7968, 1024) facing 3, 20x10 cells: 180 of 200 held
  0.18  RESERVE: zone 1 at (12456, 392) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (12456, 392) facing 3 (id 1)
  0.18  RESERVE: zone 2 at (12456, 440) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (12456, 440) facing 3 (id 2)
  0.18  RESERVE: zone 1 released
  0.18  RESERVE: zone 2 released
  0.18  RESERVE: zone 3 at (12568, 440) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (12568, 440) facing 3 (id 3)
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 at (12904, 856) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (12904, 856) facing 3 (id 4)
  0.18  RESERVE: zone 5 at (12904, 904) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (12904, 904) facing 3 (id 5)
  0.18  RESERVE: zone 6 at (12904, 952) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (12904, 952) facing 3 (id 6)
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 at (12888, 1000) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (12888, 1000) facing 3 (id 7)
  0.18  RESERVE: zone 8 at (12888, 1048) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (12888, 1048) facing 3 (id 8)
  0.18  RESERVE: zone 9 at (12888, 1096) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (12888, 1096) facing 3 (id 9)
  0.18  RESERVE: zone 7 released
  0.18  RESERVE: zone 8 released
  0.18  RESERVE: zone 9 released
  0.18  RESERVE: zone 10 at (11832, 1144) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (11832, 1144) facing 3 (id 10)
  0.18  RESERVE: zone 11 at (11832, 1192) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (11832, 1192) facing 3 (id 11)
  0.18  RESERVE: zone 12 at (11832, 1240) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (11832, 1240) facing 3 (id 12)
  0.18  RESERVE: zone 13 at (11784, 1144) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (11784, 1144) facing 3 (id 13)
  0.18  RESERVE: zone 14 at (11784, 1192) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (11784, 1192) facing 3 (id 14)
  0.18  RESERVE: zone 15 at (11784, 1240) facing 3, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legwin at (11784, 1240) facing 3 (id 15)
  0.18  RESERVE: served legwin at (11832, 1144) facing 3 (id 10, 5 of this def still held)
  0.25  RESERVE: armalab at (6360, 1320) facing 1 (id 106)
  0.25  RESERVE: zone 16 at (6240, 1320) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (6288, 1320) facing 1: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 17 at (6312, 1320) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (6608, 1320) facing 1, 20x13 cells: 260 of 260 held
  0.25  RESERVE: coralab at (6936, 744) facing 3 (id 102)
  0.25  RESERVE: zone 16 at (7056, 744) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of cornanotc 2x2 gap 0 behind (7008, 744) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 17 at (6984, 744) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (6688, 744) facing 3, 20x13 cells: 260 of 260 held
```
