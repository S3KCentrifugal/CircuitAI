# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 45.1 min (frame 81182); wall 632 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:27:03
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\supreme\runs\20261003T183738Z-c161d1a4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-009 a armfus frame appeared while energy floats (bank 8359 of 8364 full for 167 s, +263 over the pull): converters first` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 16.6 min: [INVARIANT] INV-009 a armfus frame appeared while energy floats (bank 8359 of 8364 full for 167 s, +263 over the pull): converters first
- forbid 'invariant' hit at 17.8 min: [INVARIANT] INV-008 4 turret(s) in range of the reclaim of legalab 17944 are not on it
- forbid 'invariant' hit at 22.6 min: [INVARIANT] INV-042 the run for cargo 29894 has lasted 600 s
- forbid 'invariant' hit at 22.6 min: [INVARIANT] INV-010 combat unit armfast 25785 produced at +168 metal under the gate 200
- forbid 'invariant' hit at 22.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.3 min: [t=00:03:07.404690][f=0041965] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 23.3 min: [INVARIANT] INV-004 metal floating at 12849 of 12850 for 60 s while armmmkr is under construction and static build power 0 is under 2954
- forbid 'invariant' hit at 23.6 min: [INVARIANT] INV-042 the run for cargo 29894 has lasted 660 s
- forbid 'invariant' hit at 24.3 min: [INVARIANT] INV-004 metal floating at 12833 of 12850 for 60 s while armmmkr is under construction and static build power 0 is under 2776
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 7 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.7 min: [INVARIANT] INV-011 metal floating at 12723 of 12850 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 26.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-010 combat unit armfast 9404 produced at +196 metal under the gate 200
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-014 legadveconv packed at (10496, 1584) with no turret slot within 450
- forbid 'invariant' hit at 28.6 min: [INVARIANT] INV-039 T1 land constructors released 393 s, 0 spam labs of 2 wanted, no forward order for 180 s
- forbid 'invariant' hit at 28.7 min: [INVARIANT] INV-022 a new set of legadveconv starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.8 min: [INVARIANT] INV-004 metal floating at 12733 of 12850 for 60 s while armmmkr is under construction and static build power 0 is under 3954
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-014 legadveconv packed at (11232, 1552) with no turret slot within 450
- forbid 'invariant' hit at 29.1 min: [t=00:04:00.045867][f=0052412] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 29.6 min: [INVARIANT] INV-010 combat unit armfast 14409 produced at +197 metal under the gate 200
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 17 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-004 metal floating at 12847 of 12850 for 60 s while armmmkr is under construction and static build power 0 is under 4790
- forbid 'invariant' hit at 30.1 min: [INVARIANT] INV-014 legadveconv packed at (11120, 1472) with no turret slot within 450
- forbid 'invariant' hit at 30.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 20 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.1 min: [INVARIANT] INV-014 legadveconv packed at (10928, 1424) with no turret slot within 450
- forbid 'invariant' hit at 31.5 min: [INVARIANT] INV-004 metal floating at 12833 of 12950 for 60 s while armmmkr is under construction and static build power 0 is under 5070
- forbid 'invariant' hit at 31.6 min: [t=00:04:34.307925][f=0056834] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 32.1 min: [INVARIANT] INV-016 the advanced lab 28157 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 32.1 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 291 elmos away, not flush (160)
- forbid 'invariant' hit at 32.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-031 the advanced lab 28157 retired while the advanced fusion was funded: bank 5198 + 485/s x 8 s (42% built, build power 22680) = 9289 against 8925 (85% of 10500)
- forbid 'invariant' hit at 32.9 min: [INVARIANT] INV-008 4 turret(s) in range of the reclaim of legalab 28157 are not on it
- forbid 'invariant' hit at 32.9 min: [INVARIANT] INV-001 a retiring factory produced legamph 29851
- forbid 'invariant' hit at 33.0 min: [t=00:05:02.809677][f=0059408] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 33.1 min: [INVARIANT] INV-016 the advanced lab 28157 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 33.1 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 291 elmos away, not flush (160)
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-032 a legadveconv ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 34.0 min: [INVARIANT] INV-039 T2 land constructors released 798 s, 1 mex cluster(s) without long-range AA, no defence order for 180 s
- forbid 'invariant' hit at 34.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.7 min: [t=00:05:46.212947][f=0062508] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 35.1 min: [INVARIANT] INV-019 35 turret frames under construction, 8 allowed (build power 13860 (52 by power), bank 9975 + 670/s (8 by metal))
- forbid 'invariant' hit at 35.3 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 403 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-052 ferry run for cargo 25482 unloading for 16 s
- forbid 'invariant' hit at 35.9 min: [INVARIANT] INV-032 a legadveconv ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-004 metal floating at 12947 of 12950 for 60 s while armmmkr is under construction and static build power 240 is under 5705
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 23395 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 22165 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 15130 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 26937 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 24211 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 27230 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 13437 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.1 min: [INVARIANT] INV-019 32 turret frames under construction, 8 allowed (build power 13020 (49 by power), bank 11078 + 797/s (8 by metal))
- forbid 'invariant' hit at 36.3 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.5 min: [t=00:06:36.999345][f=0065629] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-029 armaap 24204 stands 5 cells from the turrets, not tight
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 517 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 24678 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 25241 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 14361 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 16649 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 6884 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 20756 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 21277 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-022 a new set of armafus starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-004 metal floating at 13147 of 13150 for 60 s while armmmkr is under construction and static build power 240 is under 6735
- forbid 'invariant' hit at 37.1 min: [INVARIANT] INV-060 kill zone cluster #4 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.3 min: [INVARIANT] INV-020 no layout room for legadveconv for 120 s
- forbid 'invariant' hit at 37.3 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-011 metal floating at 13048 of 13150 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 9910 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-040 armck 3869 still on a forward job 100 s after its tier was recalled
- forbid 'invariant' hit at 37.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-004 metal floating at 13146 of 13150 for 60 s while armafus is under construction and static build power 240 is under 7139
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 17515 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.1 min: [INVARIANT] INV-060 kill zone cluster #4 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 38.3 min: [INVARIANT] INV-020 no layout room for legadveconv for 180 s
- forbid 'invariant' hit at 38.3 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-011 metal floating at 13147 of 13150 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 517 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 24678 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 11282 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 15084 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-004 metal floating at 13146 of 13150 for 60 s while armafus is under construction and static build power 240 is under 7434
- forbid 'invariant' hit at 39.1 min: [INVARIANT] INV-060 kill zone cluster #4 has 6 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.3 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-011 metal floating at 13146 of 13150 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 9910 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-004 metal floating at 13096 of 13100 for 60 s while armafus is under construction and static build power 240 is under 7113
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 22165 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 4829 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 13437 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 40.0 min: [t=00:08:28.711505][f=0072085] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 40.1 min: [INVARIANT] INV-060 kill zone cluster #4 has 6 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.1 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (6 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 40.3 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-011 metal floating at 13096 of 13100 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 40.7 min: [INVARIANT] INV-019 29 turret frames under construction, 8 allowed (build power 12630 (47 by power), bank 121 + 729/s (8 by metal))
- forbid 'invariant' hit at 40.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-004 metal floating at 13096 of 13100 for 60 s while armafus is under construction and static build power 240 is under 7507
- forbid 'invariant' hit at 41.1 min: [INVARIANT] INV-060 kill zone cluster #4 has 6 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.3 min: [INVARIANT] INV-010 combat unit leggob 15855 produced at +78 metal under the gate 200
- forbid 'invariant' hit at 41.4 min: [INVARIANT] INV-038 front cluster 5 (leggant) has stood 306 s with 47 of its 50 turrets
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-011 metal floating at 12447 of 12450 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 41.7 min: [INVARIANT] INV-010 combat unit legstr 19027 produced at +67 metal under the gate 200
- forbid 'invariant' hit at 41.7 min: [INVARIANT] INV-019 7 turret frames under construction, 1 allowed (build power 300 (1 by power), bank 10 + 67/s (8 by metal))
- forbid 'invariant' hit at 41.9 min: [INVARIANT] INV-039 T1 land constructors released 180 s, 1 spam labs of 3 wanted, no forward order for 180 s
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-004 metal floating at 12396 of 12400 for 60 s while armafus is under construction and static build power 240 is under 7230
- forbid 'invariant' hit at 42.3 min: [INVARIANT] INV-010 combat unit leggob 5407 produced at +67 metal under the gate 200
- forbid 'invariant' hit at 42.4 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 6 T2 constructors, none added
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-011 metal floating at 12346 of 12350 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 42.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 7 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 42.7 min: [INVARIANT] INV-019 4 turret frames under construction, 1 allowed (build power 450 (1 by power), bank 53 + 64/s (8 by metal))
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-004 metal floating at 11746 of 11750 for 60 s while armafus is under construction and static build power 240 is under 7260
- forbid 'invariant' hit at 43.1 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (6 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 43.3 min: [INVARIANT] INV-010 combat unit leggob 4754 produced at +67 metal under the gate 200
- forbid 'invariant' hit at 43.7 min: [INVARIANT] INV-019 9 turret frames under construction, 3 allowed (build power 810 (3 by power), bank 18 + 65/s (8 by metal))
- forbid 'invariant' hit at 44.2 min: [INVARIANT] INV-046 front cluster 5 (leggant) planned 600 s ago has no factory; 15 of its 50 turrets stand
- forbid 'invariant' hit at 44.4 min: [INVARIANT] INV-010 combat unit leggob 5954 produced at +64 metal under the gate 200
- forbid 'invariant' hit at 44.7 min: [INVARIANT] INV-019 8 turret frames under construction, 4 allowed (build power 1080 (4 by power), bank 17 + 64/s (8 by metal))

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\supreme\runs\20261003T183738Z-c161d1a4\screen_2026-10-03_18-28-25-894.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\supreme\runs\20261003T183738Z-c161d1a4\screen_2026-10-03_18-29-22-355.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\supreme\runs\20261003T183738Z-c161d1a4\screen_2026-10-03_18-29-54-325.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\supreme\runs\20261003T183738Z-c161d1a4\screen_2026-10-03_18-31-19-212.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\supreme\runs\20261003T183738Z-c161d1a4\screen_2026-10-03_18-35-34-606.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 45.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 26
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 26
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.08  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 55 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(813,10380) factory=armlab landLocked=no spot=1 known=1/1
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=976 E=18 bank=780 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.30  [AIR][Rule] opening.mex builder=2274
  0.30  [Team][Roster] first mex 14169 at 2288,11968
  0.30  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|2288|11968
  0.30  [Team][Roster] team 1 first mex at 752,10160
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=997 E=30 bank=961 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.60  [AIR][Capacity] own=4/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=997 E=30 bank=711 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=6/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1022 E=30 bank=463 pull=89 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/5
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.77  [Playtest] finished armmex team 0 at 0.77 min
  0.78  [AIR][Wind] cluster=0 slots=6 at=2104,11696 local=true builder=2274
  0.78  [AIR][Rule] opening.energy builder=2274
  0.88  [Playtest] finished armwin team 0 at 0.88 min
  0.93  [AIR][Capacity] own=6/30 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=1060 E=30 bank=517 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1083/1150, energy +39.0 bank 543/1000, units 6
  1.04  [Playtest] finished armwin team 0 at 1.04 min
  1.10  [AIR][Capacity] own=8/38 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=1098 E=38 bank=594 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=21/95
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.15  [Playtest] finished armwin team 0 at 1.15 min
  1.26  [Playtest] finished armwin team 0 at 1.26 min
  1.27  [AIR][Capacity] own=8/48 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1121 E=46 bank=787 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.36  [Playtest] finished armwin team 0 at 1.36 min
  1.43  [AIR][Capacity] own=8/72 usage=7/41 gifts=0 sent=6 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=74 bank=969 pull=41 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=21/95
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.48  [Playtest] finished armwin team 0 at 1.48 min
  1.49  [AIR][Wind] cluster=1 slots=6 at=2456,11792 local=false builder=2274
  1.60  [AIR][Capacity] own=8/71 usage=0/9 gifts=0 sent=8 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=77 bank=952 pull=9 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=1 committed=40/175
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=8/92 usage=7/41 gifts=0 sent=5 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=85 bank=1003 pull=41 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=1 committed=40/175
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.81  [Playtest] finished armwin team 0 at 1.81 min
  1.83  [AIR][Starter] nearby distance=128
  1.83  [AIR][Rule] opening.plant builder=2274
  1.83  [AIR][Layout] cluster=0 labs=6 at=2727,11425
  1.83  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 support=12 zone=146
  1.85  [AIR][EcoLayout] reserved air.eco.1 reactor=1664,11920 converters=8 support=12 zone=168
  1.87  [AIR][EcoLayout] reserved air.eco.2 reactor=2048,11536 converters=8 support=12 zone=190
  1.88  [AIR][EcoLayout] reserved air.eco.3 reactor=3200,11408 converters=8 support=12 zone=216
  1.93  [AIR][Capacity] own=8/118 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=8 bank=1032 E=122 bank=1003 pull=69 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=473/801
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=16396 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 898/1150, energy +110.4 bank 999/1003, units 12
  2.10  [AIR][Capacity] own=8/109 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=8 bank=763 E=109 bank=1003 pull=69 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=115/195
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=16396 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.15  [Playtest] finished armap team 0 at 2.15 min
  2.17  [AIR][Produce] opening.scout armpeep plant=16396 projected=1/1
  2.17  [AIR][Rule] opening.commander.guard builder=2274
  2.17  [AIR][Claim] cancel unowned native order armnanotc
  2.17  [AIR][Claim] cancel unowned native order armnanotc
  2.17  [AIR][State] T1_CONTEST
  2.27  [AIR][Capacity] own=8/115 usage=8/258 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=8 bank=667 E=111 bank=825 pull=258 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.30  [AIR][Produce] constructor.recovery armca plant=16396 projected=1/3
  2.43  [AIR][Capacity] own=8/100 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=8 bank=684 E=112 bank=561 pull=198 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.52  [AIR][Produce] constructor.recovery armca plant=16396 projected=2/3
  2.52  [AIR][Rule] mex.expand builder=9316
  2.60  [AIR][Capacity] own=8/84 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=697 E=87 bank=40 pull=160 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=50/500
  2.60  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=2/95 usage=0/4 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=193 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=683 E=92 bank=1 pull=135 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=48/489
  2.77  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=293 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.85  [AIR][Produce] constructor.recovery armca plant=16396 projected=3/3
  2.85  [AIR][Rule] recovery.energy builder=10631
  2.93  [AIR][Capacity] own=4/114 usage=1/5 gifts=0 sent=0 excess=0 pressure=true mobile=100 arriving=50 idle=0 ecoStatic=0 working=50 shortage=169 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=943 E=113 bank=0 pull=160 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=195/448
  2.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=319 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 917/1250, energy +124.2 bank 74/1153, units 18
  3.10  [AIR][Capacity] own=2/122 usage=3/17 gifts=0 sent=0 excess=0 pressure=true mobile=100 arriving=50 idle=0 ecoStatic=0 working=100 shortage=90 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=903 E=120 bank=121 pull=162 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=156/358
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=240 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.12  [AIR][Produce] opening.screen armfig plant=16396 projected=1/6
  3.12  [AIR][Rule] recovery.energy builder=15093
  3.14  [AIR][Rule] commander.factory.guard builder=2274
  3.27  [AIR][Capacity] own=5/133 usage=14/312 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=143 shortage=17 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=864 E=128 bank=156 pull=370 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=256/268
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=167 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.30  [AIR][Produce] opening.screen armfig plant=16396 projected=2/6
  3.30  [AIR][Screen] fighters=1 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.33  [AIR][Layout] cluster=1 labs=1 at=2727,11041
  3.43  [AIR][Capacity] own=7/172 usage=14/328 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=118 shortage=36 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=814 E=169 bank=149 pull=386 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=189/194
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=186 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.47  [AIR][Produce] opening.screen armfig plant=16396 projected=3/6
  3.47  [AIR][Screen] fighters=2 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=5/176 usage=10/170 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=59 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=773 E=174 bank=0 pull=257 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=126/160
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=209 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.65  [AIR][Screen] fighters=2 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.75  [AIR][Produce] opening.screen armfig plant=16396 projected=4/6
  3.77  [AIR][Capacity] own=5/176 usage=7/80 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=37 reason=funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=741 E=177 bank=107 pull=109 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=65/145
  3.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=187 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [Playtest] finished armsolar team 0 at 3.77 min
  3.83  [AIR][Screen] fighters=3 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=2/177 usage=10/198 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=103 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=698 E=177 bank=11 pull=257 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=162/134
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.00  [AIR][Screen] fighters=3 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +7.8 bank 676/1250, energy +198.0 bank 18/1228, units 23
  4.01  [AIR][Produce] opening.screen armfig plant=16396 projected=5/6
  4.04  [Playtest] finished armsolar team 0 at 4.04 min
  4.10  [AIR][Capacity] own=3/197 usage=13/389 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=118 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=661 E=197 bank=165 pull=389 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=260/82
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.17  [AIR][Produce] opening.screen armfig plant=16396 projected=6/6
  4.17  [AIR][Screen] fighters=5 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.23  [Playtest] finished armmex team 0 at 4.23 min
  4.25  [AIR][Rule] recovery.assist builder=9316
  4.27  [AIR][Capacity] own=8/215 usage=15/384 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=606 E=214 bank=599 pull=384 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=192/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.32  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.32  [AIR][Rule] commander.idle.assist builder=2274
  4.33  [AIR][Produce] intercept armfig plant=16396 projected=7/7
  4.33  [AIR][Rule] commander.factory.guard builder=2274
  4.37  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.43  [AIR][Capacity] own=11/181 usage=18/384 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=571 E=192 bank=535 pull=384 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=0 committed=125/0
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.53  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.53  [AIR][Rule] commander.idle.assist builder=2274
  4.53  [Playtest] finished armsolar team 0 at 4.53 min
  4.54  [AIR][Rule] intel.radar builder=10631
  4.54  [AIR][Rule] wait builder=9316
  4.55  [AIR][Screen] fighters=7 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=11/163 usage=3/12 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=350 shortage=88 reason=funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=589 E=167 bank=1328 pull=12 plants=1/0 aircraftDemand=3/127
  4.60  [AIR][Projects] energyQueued=0 committed=103/624
  4.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=238 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.60  [AIR][Produce] constructor.expand armca plant=16396 projected=4/4
  4.61  [AIR][Rule] project.assist builder=9316
  4.63  [Playtest] finished armsolar team 0 at 4.64 min
  4.65  [AIR][Rule] commander.factory.guard builder=2274
  4.65  [AIR][Claim] cancel unowned native order armmakr
  4.65  [AIR][Rule] energy.grow builder=15093
  4.72  [AIR][Screen] fighters=7 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.77  [AIR][Capacity] own=11/176 usage=8/118 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=50 idle=0 ecoStatic=0 working=149 shortage=107 reason=funded workload
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=541 E=179 bank=1364 pull=244 plants=1/0 aircraftDemand=3/127
  4.77  [AIR][Projects] energyQueued=0 committed=50/289
  4.77  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=307 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=16396 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.80  [Playtest] finished armrad team 0 at 4.80 min
  4.81  [AIR][Layout] repaired support air.bay.6 viable=1/5 slot=239 at=2344,11912
  4.81  [AIR][Rule] opening.support builder=10631
  4.82  [AIR][Rule] energy.grow builder=9316
  4.88  [AIR][Produce] recon.replace armpeep plant=16396 projected=1/1
  4.88  [AIR][Screen] fighters=7 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.88  [AIR][Rule] energy.grow builder=21396
  4.93  [AIR][Capacity] own=11/159 usage=6/111 gifts=0 sent=0 excess=0 pressure=false mobile=200 arriving=0 idle=0 ecoStatic=0 working=200 shortage=147 reason=funded workload
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=551 E=169 bank=1403 pull=141 plants=1/0 aircraftDemand=3/127
  4.93  [AIR][Projects] energyQueued=0 committed=321/3543
  4.93  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=347 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
... 9140 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(2274) at (2175, 11785) walks to (2216, 11852), 136 from the armmex site (2288, 11968)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.08  RESERVE: zone 7 at (1619, 10568) facing 2, 77x63 cells: 4619 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10072) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10120) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10168) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10216) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1384, 9992) facing 2 (id 63)
  0.08  RESERVE: zone 8 at (1299, 9720) facing 2, 41x29 cells: 1163 of 1189 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9496) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9544) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9592) facing 2: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9640) facing 2: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (1648, 8592) facing 2 (id 106)
  0.08  RESERVE: zone 9 at (1648, 8664) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1648, 8640) facing 2: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (1536, 8528) facing 2 (id 109)
  0.08  RESERVE: zone 10 at (1536, 8600) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1536, 8576) facing 2: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: corridor 11 at (1632, 8552) facing 2, 6x21 cells: 111 of 126 held
  0.08  RESERVE: corridor 12 at (1440, 8552) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 13 at (1536, 8552) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (1536, 8304) facing 2, 10x20 cells: 180 of 200 held
  0.08  EXP: approach: armcom(1901) at (814, 10380) walks to (789, 10291), 136 from the armmex site (752, 10160)
  0.09  EXP: approach: corcom(24492) at (10102, 513) walks to (10077, 461), 139 from the cormex site (10016, 336)
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.09  RESERVE: zone 7 at (10765, 1720) facing 0, 77x63 cells: 4540 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2216) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2168) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2120) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2072) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (11000, 2296) facing 0 (id 63)
  0.09  RESERVE: zone 8 at (11085, 2568) facing 0, 41x29 cells: 1106 of 1189 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2792) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2744) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2696) facing 0: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2648) facing 0: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (10640, 3696) facing 0 (id 106)
  0.09  RESERVE: zone 9 at (10640, 3624) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10640, 3648) facing 0: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (10736, 3672) facing 0, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 11 at (10640, 3672) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (10640, 3920) facing 0, 10x20 cells: 190 of 200 held
  0.09  EXP: approach: legcom(17070) at (11479, 1952) walks to (11503, 2016), 137 from the legmex site (11552, 2144)
  0.17  RESERVE: armlab at (1296, 8416) facing 2 (id 112)
  0.17  RESERVE: zone 14 at (1296, 8488) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1296, 8464) facing 2: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 15 at (1200, 8440) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (1296, 8440) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (1296, 8192) facing 2, 10x20 cells: 190 of 200 held
  0.17  RESERVE: leglab at (10864, 3808) facing 0 (id 109)
  0.17  RESERVE: zone 12 at (10864, 3736) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (10864, 3760) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (10960, 3784) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (10864, 3784) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (10864, 4032) facing 0, 10x20 cells: 190 of 200 held
  0.25  RESERVE: armalab at (1112, 7992) facing 2 (id 115)
  0.25  RESERVE: zone 17 at (1112, 8112) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (1112, 8064) facing 2: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 18 at (1112, 8040) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 19 at (1112, 7744) facing 2, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 20 at (336, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (336, 9088) facing 0 (id 120)
  0.25  RESERVE: zone 21 at (368, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (368, 9088) facing 0 (id 121)
  0.25  RESERVE: zone 22 at (400, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (400, 9088) facing 0 (id 122)
  0.25  RESERVE: zone 23 at (432, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (432, 9088) facing 0 (id 123)
  0.25  RESERVE: zone 24 at (464, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (464, 9088) facing 0 (id 124)
  0.25  RESERVE: zone 25 at (496, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (496, 9088) facing 0 (id 125)
  0.25  RESERVE: zone 26 at (528, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (528, 9088) facing 0 (id 126)
  0.25  RESERVE: zone 27 at (560, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (560, 9088) facing 0 (id 127)
  0.25  RESERVE: zone 28 at (592, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (592, 9088) facing 0 (id 128)
  0.25  RESERVE: zone 29 at (624, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (624, 9088) facing 0 (id 129)
  0.25  RESERVE: zone 30 at (656, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (656, 9088) facing 0 (id 130)
  0.25  RESERVE: zone 31 at (976, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (976, 9088) facing 0 (id 131)
  0.25  RESERVE: zone 32 at (1008, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1008, 9088) facing 0 (id 132)
  0.25  RESERVE: zone 33 at (1040, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1040, 9088) facing 0 (id 133)
  0.25  RESERVE: zone 34 at (1072, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1072, 9088) facing 0 (id 134)
  0.25  RESERVE: zone 35 at (1104, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1104, 9088) facing 0 (id 135)
  0.25  RESERVE: zone 36 at (1136, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1136, 9088) facing 0 (id 136)
  0.25  RESERVE: zone 37 at (1168, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1168, 9088) facing 0 (id 137)
  0.25  RESERVE: zone 38 at (1200, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1200, 9088) facing 0 (id 138)
  0.25  RESERVE: zone 39 at (1232, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1232, 9088) facing 0 (id 139)
  0.25  RESERVE: zone 40 at (1264, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1264, 9088) facing 0 (id 140)
  0.25  RESERVE: zone 41 at (1296, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1296, 9088) facing 0 (id 141)
  0.25  RESERVE: zone 42 at (560, 9200) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (560, 9200) facing 0 (id 142)
  0.25  RESERVE: zone 43 at (1064, 9192) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (1064, 9192) facing 0 (id 143)
  0.25  RESERVE: legalab at (11160, 3960) facing 0 (id 112)
  0.25  RESERVE: zone 15 at (11160, 3840) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (11160, 3888) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (11160, 3912) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (11160, 4208) facing 0, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 18 at (11952, 3248) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11952, 3248) facing 0 (id 117)
  0.25  RESERVE: zone 19 at (11920, 3248) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11920, 3248) facing 0 (id 118)
  0.25  RESERVE: zone 20 at (11888, 3248) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11888, 3248) facing 0 (id 119)
```
