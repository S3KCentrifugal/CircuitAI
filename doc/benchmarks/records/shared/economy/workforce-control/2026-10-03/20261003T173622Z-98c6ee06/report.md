# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 26.0 min (frame 46748); wall 207 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:32:52
- Map: Full Metal Plate 1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=AIR/armada/test, 2=TECH/cortex/test, 3=AIR/legion/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: metal_field.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\full-metal\20261003T173252Z-bdc00049\runs\20261003T173622Z-98c6ee06\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `0` | seen at -0.0 min | `[t=00:00:37.496380][f=-000001] Skirmish AI <BARb playtest-test>: METAL_FIELD: team=0 mode=1 schema=1 candidates=96 cells=16384 map=Full Metal Plate 1.7` |
| expect `1` | seen at 0.5 min | `0900] [MetalWatch] sample frame=900 team=0 mex=2 mexYield=2.37 converters=0 converterStarts=0 wind=1 labs=0 workers=1 frames=0 M=4.4 bankM=934.1/1100.0 spendM=8.3 E=55.0 bankE=797.1/1000.5 spendE=86.3` |
| expect `2` | seen at 0.2 min | `[METAL][Economy] M=2 E=50 goal=120 fundedM=0 mex=0 wind=1 dense=false` |
| expect `3` | seen at 0.1 min | `Setup complete role=1 landLocked=false` |
| expect `4` | seen at 0.1 min | `Setup complete role=2 landLocked=false` |
| forbid `0` | **hit** | `[INVARIANT] INV-025 a T1 lab frame started with 3 T1 constructors at +99 metal, advanced lab down` |
| forbid `1` | clean |  |
| forbid `2` | clean |  |
| forbid `3` | clean |  |
| forbid `native crash` | clean |  |

## Failures

- forbid '0' hit at 13.2 min: [INVARIANT] INV-025 a T1 lab frame started with 3 T1 constructors at +99 metal, advanced lab down
- forbid '0' hit at 13.7 min: [INVARIANT] INV-010 combat unit armpw 29600 produced at +103 metal under the gate 200
- forbid '0' hit at 15.9 min: [INVARIANT] INV-004 metal floating at 6950 of 6950 for 60 s while armamd is under construction and static build power 0 is under 2187
- forbid '0' hit at 16.9 min: [INVARIANT] INV-004 metal floating at 6200 of 6200 for 60 s while armamd is under construction and static build power 0 is under 537
- forbid '0' hit at 17.9 min: [INVARIANT] INV-004 metal floating at 5800 of 5800 for 60 s while armfus is under construction and static build power 0 is under 681
- forbid '0' hit at 18.9 min: [INVARIANT] INV-004 metal floating at 5550 of 5550 for 60 s while armfus is under construction and static build power 0 is under 496

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\full-metal\20261003T173252Z-bdc00049\runs\20261003T173622Z-98c6ee06\screen_2026-10-03_17-33-54-856.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\full-metal\20261003T173252Z-bdc00049\runs\20261003T173622Z-98c6ee06\screen_2026-10-03_17-34-40-954.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\workforce-control\full-metal\20261003T173252Z-bdc00049\runs\20261003T173622Z-98c6ee06\screen_2026-10-03_17-36-02-104.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 30, 3 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2400, 850) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4700, 2500) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (9650, 11400) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (7350, 9750) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2400, 850) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4700, 2500) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (9650, 11400) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (7350, 9750) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 2); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 0, side offset 12 cells, forward offset 0 cells
  0.08  [Layout] home centre (2290, 1101), 276 from the start
  0.08  [Layout] turret box 40x44 cells at (2002, 1101), from the start rear 0, side -18, ground 98%, halo 91%: zone 7, 4 rows, 52 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (2242, 1525) facing 0, 0 cells ahead of turret row 0
  0.08  [Layout] the front is (4096, 8192): the labs face 0 (lane (4096, 8192), the pair faces 0)
  0.08  [Layout] advanced lab faces 0 (the pair faces 0)
  0.08  [Layout] advanced lab's footprint reserved at (2248, 1528), 428 from the home centre, 22 turret slots within reach, 7 flush (D-095)
  0.08  [Layout] forward cluster 40x44 cells at (1682, 1933), 8 cells ahead of the main cluster, ground 100%: zone 8, 4 rows, 52 turret slots
  0.10  [Team][Roster] Announced: roster|1|0|0|TECH|armada|armlab|2400|847|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=AIR side=armada start=(4700,2497) factory=armap landLocked=no spot=1 known=1/1
  0.15  [Playtest] finished armwin team 0 at 0.15 min
  0.16  [Rule] table of 50 rules loaded
  0.16  [TECH][Opening] home mex order 1/2 at (2656, 656), 319 from start
  0.16  [Rule] opening.mex for armcom 4003 | M +0 E 0/61 T1 E-float M-float
  0.28  [Team][Roster] team 1 first mex at 4768,2560
  0.37  [Playtest] finished armmex team 0 at 0.37 min
  0.38  [TECH][Opening] home mex order 2/2 at (2656, 720), 285 from start
  0.38  [Rule] opening.mex for armcom 4003 | M +2 E 50/76 T1 M-float
  0.38  [Team][Roster] first mex 27992 at 2656,656
  0.38  [Team][Roster] Re-announced: roster|1|0|0|TECH|armada|armlab|2400|847|0|0|1|2656|656
  0.49  [Playtest] finished armmex team 0 at 0.49 min
  0.51  [TECH][Opening] complete after 2 mexes, 25 s: the 2 nearest spots are ordered and none is pending; the lab is next
  0.51  [TECH][Build] no footprint for the first lab within 224 of the commander; the pair's slot is used
  0.51  [TECH][Build] start factory ordered on the reserved slot
  0.51  [Rule] lab.t1.opening for armcom 4003 | M +2 E 55/76 T1 M-float
  0.80  [Playtest] finished armlab team 0 at 0.80 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.7 bank 583/1200, energy +55.0 bank 1061/1100, units 6
  1.15  [Playtest] finished armwin team 0 at 1.15 min
  1.26  [Playtest] finished armwin team 0 at 1.26 min
  1.38  [Playtest] finished armwin team 0 at 1.38 min
  1.50  [Playtest] finished armwin team 0 at 1.50 min
  1.51  [Rule] assist.any for armcom 4003 | M +6 E 112/117 T1 E-float
  1.81  [Playtest] finished armmex team 0 at 1.81 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.1 bank 498/1250, energy +169.0 bank 1184/1202, units 15
  2.02  [Layout] advanced lab on its planned slot (2248, 1528): 22 turret slots within 260
  2.19  [Rule] assist.any for armcom 4003 | M +9 E 171/145 T2 E-float
  2.21  [Playtest] finished armwin team 0 at 2.21 min
  2.22  [Playtest] finished armmex team 0 at 2.22 min
  2.29  [TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab 30067; idle build power in range joins
  2.29  [Rule] lab.t1.reclaim for armcom 4003 | M +9 E 176/145 T2 E-float
  2.29  [Rule] lab.t1.reclaim for armck 13693 | M +9 E 176/145 T2 E-float
  2.63  [Playtest] finished armmex team 0 at 2.63 min
  2.75  [Playtest] finished armwin team 0 at 2.75 min
  2.91  [Playtest] finished armwin team 0 at 2.91 min
  2.99  [Playtest] finished armwin team 0 at 2.99 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +13.9 bank 1056/1250, energy +251.0 bank 1144/1154, units 21
  3.05  [Playtest] finished armmex team 0 at 3.05 min
  3.07  [Playtest] finished armwin team 0 at 3.07 min
  3.08  [Rule] assist.any for armcom 4003 | M +13 E 251/212 T2 E-float M-float
  3.47  [Playtest] finished armmex team 0 at 3.47 min
  3.48  [Playtest] finished armwin team 0 at 3.48 min
  3.87  [Playtest] finished armwin team 0 at 3.87 min
  3.87  [Playtest] finished armmex team 0 at 3.87 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +21.0 bank 0/1400, energy +351.0 bank 1148/1156, units 27
  4.08  [Ferry] requested a transport (TECH at +20 metal, no transport)
  4.32  [Playtest] finished armalab team 0 at 4.32 min
  4.33  [TECH][Build] advanced lab's exit held (zone 87)
  4.33  [Layout] advanced lab 22387: nearest construction turret none (not flush)
  4.33  [Layout] advanced lab 22387: faces 0, the front 0, 0 structures in its exit lane
  4.33  [Rule] assist.any for armck 15933 | M +20 E 351/342 T2 E-float
  4.40  [Playtest] finished armwin team 0 at 4.40 min
  4.41  [Playtest] finished armmex team 0 at 4.41 min
  4.51  [Playtest] finished armwin team 0 at 4.51 min
  4.69  [Playtest] finished armwin team 0 at 4.69 min
  4.77  [Rule] assist.any for armack 24544 | M +23 E 401/393 T2 E-float
  4.81  [Playtest] finished armwin team 0 at 4.81 min
  4.84  [Playtest] finished armmex team 0 at 4.84 min
  4.87  [Playtest] finished armwin team 0 at 4.87 min
  4.88  [Rule] assist.any for armcom 4003 | M +23 E 423/393 T2 E-float
  4.89  [Ferry] transport 20645 received and reserved; hold pending task
  4.92  [Ferry] reserved: transport 20645 flying to (2400,847)
  5.00  [Playtest] eco team 0 at 5.0 min: metal +25.7 bank 266/1700, energy +490.0 bank 1455/1458, units 36
  5.00  [Playtest] target team 0 at (2400, 850) from its start position
  5.00  [Playtest] camera requested (2400,850) height=2200
  5.01  [Playtest] camera captured name=ta position=(2400,850) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2400, 850)
  5.08  [Playtest] finished armmex team 0 at 5.09 min
  5.10  [Rule] storage.energy for armcom 4003 | M +25 E 490/447 T2 E-float
  5.10  [Rule] defence.fortify for armck 15933 | M +25 E 490/447 T2 E-float
  5.11  [Rule] defence.fortify for armack 24544 | M +25 E 490/447 T2 E-float
  5.28  [Playtest] finished armmex team 0 at 5.28 min
  5.49  [Playtest] finished armwin team 0 at 5.49 min
  5.53  [Playtest] finished armestor team 0 at 5.53 min
  5.63  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 970 of 1800) (D-103)
  5.64  [Playtest] finished armfort team 0 at 5.64 min
  5.66  [Playtest] finished armwin team 0 at 5.66 min
  5.66  [Rule] defence.fortify for armack 24544 | M +30 E 512/569 T2
  5.68  [Playtest] finished armmex team 0 at 5.68 min
  5.71  [Playtest] finished armdrag team 0 at 5.71 min
  5.72  [Rule] defence.fortify for armck 15933 | M +30 E 512/569 T2
  5.74  [Playtest] finished armfort team 0 at 5.74 min
  5.79  [Playtest] finished armwin team 0 at 5.79 min
  5.79  [Playtest] finished armdrag team 0 at 5.79 min
  5.84  [Playtest] finished armfort team 0 at 5.84 min
  5.86  [Playtest] finished armwin team 0 at 5.86 min
  5.88  [Playtest] finished armdrag team 0 at 5.88 min
  5.90  [Rule] defence.fortify for armck 15933 | M +32 E 540/615 T2 E-float
  5.91  [Playtest] finished armwin team 0 at 5.91 min
  5.94  [Playtest] finished armfort team 0 at 5.94 min
  5.97  [Playtest] finished armdrag team 0 at 5.97 min
  5.98  [Rule] defence.fortify for armck 15933 | M +32 E 565/635 T2 E-float
  6.00  [Playtest] eco team 0 at 6.0 min: metal +32.8 bank 931/1850, energy +615.0 bank 7551/7561, units 54
  6.00  [Rule] assist.any for armack 15022 | M +32 E 565/635 T2 E-float
  6.04  [Playtest] finished armfort team 0 at 6.04 min
  6.05  [Rule] assist.any for armack 24544 | M +32 E 587/635 T2 E-float
  6.05  [Playtest] finished armdrag team 0 at 6.05 min
  6.07  [Rule] defence.fortify for armck 15933 | M +32 E 610/635 T2 E-float
  6.12  [Playtest] finished armmex team 0 at 6.12 min
  6.13  [Playtest] finished armdrag team 0 at 6.13 min
  6.14  [Rule] defence.fortify for armck 15933 | M +32 E 612/635 T2 E-float
  6.16  [Playtest] finished armwin team 0 at 6.16 min
  6.18  [Rule] assist.any for armcom 4003 | M +32 E 619/635 T2 E-float
  6.21  [Playtest] finished armdrag team 0 at 6.21 min
  6.22  [Rule] defence.fortify for armck 15933 | M +32 E 627/635 T2 E-float
  6.24  [Playtest] finished armwin team 0 at 6.24 min
  6.30  [Playtest] finished armdrag team 0 at 6.30 min
  6.31  [Rule] defence.fortify for armck 15933 | M +33 E 629/662 T2 E-float
  6.37  [Ferry] TECH: carrying 25254 to team 1 at (4886,2608) anchor=first-mex distance=127
  6.38  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 1083 of 1900) (D-103)
  6.39  [Playtest] finished armdrag team 0 at 6.39 min
  6.40  [Rule] defence.fortify for armck 15933 | M +35 E 679/705 T2 E-float
  6.43  [Playtest] finished armmex team 0 at 6.43 min
  6.48  [Playtest] finished armdrag team 0 at 6.48 min
  6.50  [Rule] defence.fortify for armck 15933 | M +35 E 679/705 T2 E-float
  6.51  [Rule] assist.any for armcom 4003 | M +35 E 679/705 T2 E-float
  6.57  [Playtest] finished armdrag team 0 at 6.57 min
  6.58  [Rule] defence.fortify for armck 15933 | M +36 E 680/734 T2 E-float
  6.61  [Playtest] finished armmex team 0 at 6.61 min
  6.75  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 1405 of 2000) (D-103)
  6.75  [Rule] defence.fortify for armack 7858 | M +37 E 679/787 T2 E-float
  6.80  [Ferry] TECH: delivered constructor 25254 to team 1
  6.80  [Playtest] finished armdrag team 0 at 6.80 min
  6.81  [Playtest] finished armwin team 0 at 6.81 min
  6.82  [Rule] defence.fortify for armck 15933 | M +39 E 679/833 T2 E-float
  6.90  [Playtest] finished armdrag team 0 at 6.90 min
  6.92  [Rule] defence.fortify for armck 15933 | M +39 E 684/857 T2 E-float
  6.98  [Playtest] finished armwin team 0 at 6.98 min
  6.99  [Rule] assist.any for armcom 4003 | M +39 E 718/857 T2 E-float
  7.00  [Playtest] eco team 0 at 7.0 min: metal +40.3 bank 1594/2000, energy +730.5 bank 7637/7663, units 74
  7.00  [Playtest] finished armdrag team 0 at 7.01 min
  7.01  [Playtest] finished armmex team 0 at 7.01 min
  7.02  [Rule] defence.fortify for armck 15933 | M +39 E 718/857 T2 E-float
  7.10  [Playtest] finished armdrag team 0 at 7.10 min
  7.10  [Playtest] finished armwin team 0 at 7.10 min
  7.11  [Rule] defence.fortify for armck 15933 | M +39 E 718/857 T2 E-float M-float
  7.12  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 1660 of 2050) (D-103)
  7.12  [Rule] legacy.strategic for armack 24544 | M +40 E 718/865 T2 E-float M-float
  7.13  [Rule] legacy.strategic for armack 6671 | M +40 E 718/865 T2 E-float M-float
  7.13  [Rule] legacy.strategic for armack 15022 | M +40 E 740/866 T2 E-float M-float
  7.14  [Playtest] finished armfort team 0 at 7.14 min
  7.16  [Rule] legacy.strategic for armack 7858 | M +40 E 740/866 T2 E-float M-float
  7.20  [Playtest] finished armdrag team 0 at 7.20 min
  7.21  [Rule] defence.fortify for armck 15933 | M +41 E 740/883 T2 E-float M-float
  7.22  [Playtest] finished armwin team 0 at 7.22 min
  7.24  [Rule] storage.metal for armcom 4003 | M +42 E 743/901 T2 E-float M-float
  7.30  [Playtest] finished armdrag team 0 at 7.30 min
  7.31  [Rule] defence.fortify for armck 15933 | M +42 E 775/905 T2 E-float M-float
  7.39  [Playtest] finished armdrag team 0 at 7.39 min
  7.40  [Layout] turrets: order 2 of 3 allowed (build power 1200 (4 by power), bank 1891 + 42/s (43 by metal), 1 dear frames take a slot)
  7.40  [Rule] turret.build for armck 15933 | M +42 E 807/905 T2 E-float M-float
  7.42  [Playtest] finished armmex team 0 at 7.42 min
  7.50  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 1846 of 2100) (D-103)
  7.50  [Rule] defence.fortify for armack 5261 | M +42 E 807/905 T2 E-float M-float
  7.60  [Playtest] finished armmstor team 0 at 7.60 min
  7.62  [Rule] assist.any for armcom 4003 | M +43 E 807/934 T2 E-float
  7.68  [Playtest] finished armwin team 0 at 7.68 min
  7.87  [Rule] defence.fortify for armack 20297 | M +44 E 843/953 T2 E-float
  7.89  [Playtest] finished armfort team 0 at 7.89 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +44.7 bank 684/5100, energy +860.0 bank 7923/7964, units 92
  8.13  [Playtest] finished armmex team 0 at 8.13 min
  8.24  [Playtest] finished armfort team 0 at 8.24 min
  8.26  [Rule] defence.fortify for armack 20297 | M +44 E 860/953 T2 E-float
  8.43  [Playtest] finished armfort team 0 at 8.43 min
  8.57  [Playtest] finished armmex team 0 at 8.57 min
  8.90  [Playtest] finished armnanotc team 0 at 8.90 min
  8.90  [Layout] advanced lab 22387: nearest construction turret 96 elmos (flush)
  9.00  [Playtest] eco team 0 at 9.0 min: metal +49.4 bank 0/5200, energy +860.0 bank 7936/7964, units 98
  9.02  [Playtest] finished armmex team 0 at 9.02 min
  9.49  [Playtest] finished armmex team 0 at 9.49 min
  9.66  [Playtest] finished armmex team 0 at 9.66 min
  9.78  [Playtest] finished armfus team 0 at 9.78 min
  9.80  [Rule] assist.any for armack 24544 | M +54 E 860/1142 T2 E-float
  9.88  [Playtest] finished armmex team 0 at 9.88 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +58.9 bank 0/5400, energy +1610.0 bank 10406/10464, units 103
 10.09  [Playtest] finished armmex team 0 at 10.09 min
 10.29  [Playtest] finished armmex team 0 at 10.29 min
 10.89  [Playtest] finished armmoho team 0 at 10.89 min
 10.90  [Rule] assist.any for armack 5261 | M +63 E 1610/1332 T2 E-float
 11.00  [Playtest] eco team 0 at 11.0 min: metal +70.7 bank 0/6050, energy +1610.0 bank 10353/10464, units 104
 11.06  [Playtest] finished armmex team 0 at 11.06 min
 11.10  [Playtest] finished armmex team 0 at 11.10 min
 11.19  [Playtest] finished armfus team 0 at 11.19 min
 11.21  [Rule] assist.any for armack 15022 | M +70 E 1610/1474 T2 E-float
 11.47  [Playtest] finished armmex team 0 at 11.47 min
 11.54  [Playtest] finished armmoho team 0 at 11.54 min
 11.54  [Playtest] finished armmex team 0 at 11.55 min
 11.56  [Rule] defence.fortify for armack 5261 | M +75 E 2360/1569 T2 E-float
 11.56  [Rule] defence.fortify for armack 20297 | M +75 E 2360/1569 T2 E-float
 11.58  [Playtest] finished armfus team 0 at 11.58 min
 11.60  [Rule] legacy.strategic for armack 24544 | M +75 E 2360/1569 T2 E-float
 11.60  [Rule] assist.any for armack 6671 | M +75 E 2360/1569 T2 E-float
 11.70  [Playtest] finished armfus team 0 at 11.70 min
 11.72  [Rule] legacy.strategic for armcom 4003 | M +87 E 2360/1806 T2 E-float
 11.73  [Rule] assist.any for armack 7858 | M +87 E 2360/1806 T2 E-float
 11.73  [Rule] legacy.strategic for armack 15022 | M +87 E 3035/1806 T2 E-float
 11.94  [Playtest] finished armmex team 0 at 11.94 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +89.7 bank 1706/6850, energy +3860.0 bank 17809/17964, units 111
 12.05  [Playtest] finished armmex team 0 at 12.05 min
 12.07  [Playtest] finished armfort team 0 at 12.07 min
 12.07  [Rule] defence.fortify for armack 7858 | M +87 E 3860/1806 T2 E-float
 12.08  [Rule] assist.any for armack 20297 | M +87 E 3860/1806 T2 E-float
 12.11  [Playtest] finished armfort team 0 at 12.11 min
 12.12  [Rule] defence.fortify for armack 5261 | M +88 E 3860/1825 T2 E-float
 12.34  [Playtest] finished armmex team 0 at 12.34 min
 12.38  [Playtest] finished armfort team 0 at 12.38 min
 12.39  [Rule] defence.fortify for armack 5261 | M +92 E 3860/1901 T2 E-float
 12.49  [Playtest] finished armfort team 0 at 12.49 min
 12.50  [Playtest] finished armmex team 0 at 12.50 min
 12.50  [Rule] defence.fortify for armack 5261 | M +92 E 3860/1910 T2 E-float
 12.61  [Playtest] finished armfort team 0 at 12.61 min
 12.62  [Rule] defence.fortify for armack 5261 | M +94 E 3860/1948 T2 E-float
 12.62  [Playtest] finished armfort team 0 at 12.62 min
 12.63  [TECH][Factory] armalab: T2 constructor 7 of 10 (bank 3733 of 7000) (D-103)
 12.64  [Rule] defence.fortify for armack 7858 | M +94 E 3860/1948 T2 E-float
 12.73  [Playtest] finished armfort team 0 at 12.73 min
 12.75  [Rule] assist.any for armack 5261 | M +96 E 3860/1995 T2 E-float
 12.77  [Playtest] finished armfort team 0 at 12.77 min
 12.79  [Rule] assist.any for armack 7858 | M +96 E 3860/1995 T2 E-float
 13.00  [Playtest] eco team 0 at 13.0 min: metal +96.8 bank 4461/7000, energy +3860.0 bank 17863/18064, units 122
 13.00  [Playtest] finished armmex team 0 at 13.00 min
 13.01  [TECH][Factory] armalab: T2 constructor 8 of 10 (bank 4463 of 7000) (D-103)
 13.01  [Rule] assist.any for armack 28067 | M +96 E 3860/1995 T2 E-float
 13.01  [Rule] defence.fortify for armck 15933 | M +96 E 3860/1995 T2 E-float
 13.08  [Playtest] finished armmex team 0 at 13.08 min
 13.19  [TECH][Build] last factory gone: no lab rebuilt (3 T1 constructors, +97 metal under 200) (D-102)
 13.20  [Layout] armlab flush against the turrets at (2256, 1504) facing 0 (D-104)
 13.20  [Rule] lab.t1.opening for armcom 4003 | M +98 E 3869/2024 T1 E-float M-float
 13.48  [Playtest] finished armmex team 0 at 13.48 min
 13.51  [Playtest] finished armlab team 0 at 13.51 min
 13.52  [TECH][Build] first lab's exit held (zone 105) until it is reclaimed
 13.52  [Layout] factory armlab 13106 stands 0 cell(s) from a turret
 13.53  [Rule] assist.any for armcom 4003 | M +101 E 3874/2090 T1 E-float
 13.57  [Playtest] finished armwin team 0 at 13.57 min
 13.90  [Playtest] finished armmex team 0 at 13.90 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +106.3 bank 5964/7100, energy +3899.0 bank 17584/17965, units 130
 14.03  [Playtest] finished armllt team 0 at 14.03 min
 14.04  [Rule] defence.fortify for armck 15933 | M +103 E 3899/2138 T1 E-float M-float
 14.06  [Ferry] transport lost; donations walk until the next request lands
 14.07  [Ferry] requested a transport (TECH at +20 metal, no transport)
 14.19  [Layout] turret box full and no ground behind or beside it scores 75%; retried in a minute
 14.19  [Layout] advanced lab nearest a turret slot, facing 1, at (1512, 1160): 1 turret slots within 260
 14.19  [Rule] lab.t2 for armack 6671 | M +106 E 2026/2185 T1 E-float M-float
 14.30  [Playtest] finished armmex team 0 at 14.30 min
 14.33  [TECH][Build] first lab gone: its exit (zone 105) released
 14.38  [Rule] legacy.strategic for armack 28067 | M +106 E 139/2185 T2 E-float
 14.50  [Layout] new set of armafus at (1648, 1392), 0 cell(s) from a turret
 14.50  [Rule] legacy.strategic for armack 5261 | M +107 E 139/2209 T2 E-float M-float
 14.50  [Rule] legacy.strategic for armack 20297 | M +107 E 137/2218 T2 E-float M-float
 14.51  [Rule] legacy.strategic for armack 7858 | M +107 E 137/2218 T2 E-float M-float
 14.63  [Playtest] finished armrl team 0 at 14.63 min
 14.64  [Rule] legacy.strategic for armck 15933 | M +108 E 125/2236 T2 E-float M-float
 14.72  [Playtest] finished armmex team 0 at 14.72 min
 14.73  [Rule] legacy.strategic for armck 13060 | M +110 E 125/2266 T2 E-float M-float
 14.79  [Rule] energy.assist2 for armck 15933 | M +110 E 125/2266 T2 M-float
 15.00  [Playtest] eco team 0 at 15.0 min: metal +112.7 bank 7097/7100, energy +125.0 bank 6608/7500, units 94
 15.00  [Playtest] camera requested (2400,850) height=2200
 15.02  [Playtest] camera captured name=ta position=(2400,850) height=2200
 15.02  [Playtest] screenshot at 15.0 min of team 0 at (2400, 850)
 16.00  [Playtest] eco team 0 at 16.0 min: metal +105.6 bank 6944/6950, energy +118.0 bank 6549/7450, units 89
 16.20  [Rule] energy.assist for armck 15933 | M +50 E 118/1067 T2 draining M-float
 16.85  [Rule] energy.assist for armack 6671 | M +26 E 118/476 T2 draining M-float
 17.00  [Playtest] eco team 0 at 17.0 min: metal +40.3 bank 6200/6200, energy +118.0 bank 0/7450, units 85
 17.01  [Rule] legacy.strategic for armack 6671 | M +30 E 118/582 T2 draining M-float
 17.07  [Ferry] requested a transport (TECH at +20 metal, no transport)
 17.09  [Rule] legacy.strategic for armack 6671 | M +40 E 118/872 T2 draining M-float
 17.12  [Rule] legacy.strategic for armack 6671 | M +40 E 118/872 T2 draining M-float
 17.16  [Rule] legacy.strategic for armack 6671 | M +41 E 118/881 T2 draining M-float
 17.21  [Rule] energy.assist for armack 6671 | M +46 E 118/992 T2 draining M-float
 17.80  [Rule] energy.assist for armcom 4003 | M +34 E 118/678 T2 draining M-float
 18.00  [Playtest] eco team 0 at 18.0 min: metal +35.5 bank 5736/5750, energy +118.0 bank 0/7450, units 77
 18.12  [Rule] legacy.strategic for armack 6671 | M +26 E 118/455 T2 draining M-float
 19.00  [Playtest] eco team 0 at 19.0 min: metal +24.8 bank 5550/5550, energy +118.0 bank 0/7450, units 74
 19.60  [Playtest] finished armwin team 0 at 19.60 min
 19.92  [Playtest] finished armwin team 0 at 19.92 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +42.3 bank 2250/2250, energy +80.0 bank 120/1001, units 52
 20.07  [Ferry] requested a transport (TECH at +20 metal, no transport)
 20.09  [Playtest] finished armwin team 0 at 20.09 min
 20.21  [Playtest] finished armwin team 0 at 20.21 min
 20.34  [Playtest] finished armwin team 0 at 20.34 min
 20.49  [Playtest] finished armwin team 0 at 20.49 min
 20.61  [Playtest] finished armwin team 0 at 20.61 min
 20.74  [Playtest] finished armwin team 0 at 20.74 min
 20.86  [Playtest] finished armwin team 0 at 20.86 min
 20.99  [Playtest] finished armwin team 0 at 20.99 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +25.7 bank 1500/1500, energy +255.0 bank 1005/1005, units 56
 21.14  [Playtest] finished armwin team 0 at 21.14 min
 21.26  [Playtest] finished armwin team 0 at 21.26 min
 21.41  [Playtest] finished armwin team 0 at 21.41 min
 21.42  [Rule] storage.energy for armcom 4003 | M +14 E 327/216 T1 E-float M-float
 21.75  [Playtest] finished armestor team 0 at 21.75 min
 21.91  [Playtest] finished armwin team 0 at 21.91 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +6.7 bank 1094/1100, energy +380.0 bank 6058/7007, units 53
 22.25  [Playtest] finished armwin team 0 at 22.25 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +6.7 bank 971/1100, energy +405.0 bank 7007/7007, units 54
 23.31  [Playtest] finished armwin team 0 at 23.31 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 500/500, energy +0.0 bank 160/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 500/500, energy +0.0 bank 160/500, units 0
 25.00  [Playtest] camera requested (2400,850) height=2200
 25.02  [Playtest] camera captured name=ta position=(2400,850) height=2200
 25.02  [Playtest] screenshot at 25.0 min of team 0 at (2400, 850)
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (2003, 957) facing 0, 77x63 cells: 4441 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2003, 1453) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2003, 1405) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2003, 1357) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2003, 1309) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (2248, 1528) facing 0 (id 63)
  0.08  RESERVE: zone 8 at (1683, 1933) facing 0, 41x45 cells: 1845 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1683, 2285) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1683, 2237) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1683, 2189) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1683, 2141) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (2656, 2512) facing 0 (id 116)
  0.08  RESERVE: zone 9 at (2656, 2440) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2656, 2464) facing 0: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (2752, 2488) facing 0, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (2656, 2488) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (2656, 2736) facing 0, 10x20 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.09  RESERVE: zone 7 at (9219, 11485) facing 3, 63x77 cells: 4148 of 4851 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (8723, 11485) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (8771, 11485) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (8819, 11485) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (8867, 11485) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: coralab at (8648, 11480) facing 3 (id 63)
  0.09  RESERVE: zone 8 at (8243, 11805) facing 3, 45x41 cells: 1835 of 1845 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (7891, 11805) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (7939, 11805) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (7987, 11805) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (8035, 11805) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: corlab at (8288, 10832) facing 3 (id 116)
  0.09  RESERVE: zone 9 at (8360, 10832) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of cornanotc 2x1 gap 0 behind (8336, 10832) facing 3: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (8312, 10736) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (8312, 10928) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: zone 12 at (8312, 10832) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (8064, 10832) facing 3, 20x10 cells: 180 of 200 held
  0.16  EXP: approach: armcom(4003) at (2400, 847) walks to (2773, 726), 136 from the armmex site (2656, 656)
  0.17  RESERVE: zone 1 at (7248, 9712) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (7248, 9712) facing 0 (id 1)
  0.17  RESERVE: zone 2 at (7312, 9712) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (7312, 9712) facing 0 (id 2)
  0.17  RESERVE: zone 3 at (7376, 9712) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (7376, 9712) facing 0 (id 3)
  0.17  RESERVE: zone 4 at (7440, 9712) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (7440, 9712) facing 0 (id 4)
  0.17  RESERVE: zone 5 at (7248, 9648) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (7248, 9648) facing 0 (id 5)
  0.17  RESERVE: zone 6 at (7312, 9648) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (7312, 9648) facing 0 (id 6)
  0.17  RESERVE: zone 7 at (7376, 9648) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (7376, 9648) facing 0 (id 7)
  0.17  RESERVE: zone 8 at (7440, 9648) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (7440, 9648) facing 0 (id 8)
  0.17  RESERVE: zone 9 at (7344, 9680) facing 0, 16x8 cells: 0 of 128 held
  0.17  RESERVE: armlab at (2400, 2576) facing 0 (id 119)
  0.17  RESERVE: zone 12 at (2400, 2504) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (2400, 2528) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (2496, 2552) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (2400, 2552) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (2400, 2800) facing 0, 10x20 cells: 190 of 200 held
  0.17  RESERVE: corlab at (8496, 10496) facing 3 (id 119)
  0.17  RESERVE: zone 13 at (8568, 10496) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of cornanotc 2x1 gap 0 behind (8544, 10496) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 14 at (8520, 10400) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: corridor 15 at (8520, 10592) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (8520, 10496) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (8272, 10496) facing 3, 20x10 cells: 180 of 200 held
  0.25  RESERVE: armalab at (3000, 2440) facing 0 (id 122)
  0.25  RESERVE: zone 15 at (3000, 2320) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3000, 2368) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (3000, 2392) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (3000, 2688) facing 0, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 18 at (2880, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2880, 2144) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (2848, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2848, 2144) facing 0 (id 128)
  0.25  RESERVE: zone 20 at (2816, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2816, 2144) facing 0 (id 129)
  0.25  RESERVE: zone 21 at (2784, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2784, 2144) facing 0 (id 130)
  0.25  RESERVE: zone 22 at (2752, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2752, 2144) facing 0 (id 131)
  0.25  RESERVE: zone 23 at (2720, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2720, 2144) facing 0 (id 132)
  0.25  RESERVE: zone 24 at (2688, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2688, 2144) facing 0 (id 133)
  0.25  RESERVE: zone 25 at (2656, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2656, 2144) facing 0 (id 134)
  0.25  RESERVE: zone 26 at (2624, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2624, 2144) facing 0 (id 135)
  0.25  RESERVE: zone 27 at (2592, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2592, 2144) facing 0 (id 136)
  0.25  RESERVE: zone 28 at (2560, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2560, 2144) facing 0 (id 137)
  0.25  RESERVE: zone 29 at (2240, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2240, 2144) facing 0 (id 138)
  0.25  RESERVE: zone 30 at (2208, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2208, 2144) facing 0 (id 139)
  0.25  RESERVE: zone 31 at (2176, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2176, 2144) facing 0 (id 140)
  0.25  RESERVE: zone 32 at (2144, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2144, 2144) facing 0 (id 141)
  0.25  RESERVE: zone 33 at (2112, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 2144) facing 0 (id 142)
  0.25  RESERVE: zone 34 at (2080, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2080, 2144) facing 0 (id 143)
  0.25  RESERVE: zone 35 at (2048, 2144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2048, 2144) facing 0 (id 144)
  0.25  RESERVE: zone 36 at (2656, 2032) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (2656, 2032) facing 0 (id 145)
  0.25  RESERVE: zone 37 at (2152, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (2152, 2024) facing 0 (id 146)
  0.25  RESERVE: coralab at (8104, 11128) facing 3 (id 122)
  0.25  RESERVE: zone 17 at (8224, 11128) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of cornanotc 2x2 gap 0 behind (8176, 11128) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 18 at (8152, 11128) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 19 at (7856, 11128) facing 3, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 20 at (8352, 11248) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (8352, 11248) facing 0 (id 127)
```
