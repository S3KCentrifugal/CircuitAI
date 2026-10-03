# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 40.1 min (frame 72097); wall 364 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T20:28:06
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/legion/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: t2_landlocked_start.json; widget loaded: yes
- Log: build-theatres\games\tech\combat\t2-landlocked-start\tundra\20261003T232713Z-3984d2ff\runs\20261003T233412Z-25a490df\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.986824][f=-000001] [TechT2Start] loaded observer_only=1` |
| expect `amphibious bot completed` | seen at 24.8 min | `[t=00:02:38.630090][f=0044683] [TechT2Start] finished team=0 name=legamph count=1 id=29369` |
| forbid `script error` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `wrong T2 bot` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 7.6 min: [INVARIANT] INV-018 the advanced lab faces 2 (the front 2) with 2 structures in its exit lane
- forbid 'invariant' hit at 7.6 min: [INVARIANT] INV-016 the advanced lab 1854 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 8.6 min: [INVARIANT] INV-018 the advanced lab faces 2 (the front 2) with 2 structures in its exit lane
- forbid 'invariant' hit at 8.6 min: [INVARIANT] INV-016 the advanced lab 1854 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 9.6 min: [INVARIANT] INV-018 the advanced lab faces 2 (the front 2) with 2 structures in its exit lane
- forbid 'invariant' hit at 9.6 min: [INVARIANT] INV-016 the advanced lab 1854 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 10.6 min: [INVARIANT] INV-018 the advanced lab faces 2 (the front 2) with 2 structures in its exit lane
- forbid 'invariant' hit at 11.6 min: [INVARIANT] INV-018 the advanced lab faces 2 (the front 2) with 2 structures in its exit lane
- forbid 'invariant' hit at 12.6 min: [INVARIANT] INV-018 the advanced lab faces 2 (the front 2) with 2 structures in its exit lane
- forbid 'invariant' hit at 13.6 min: [INVARIANT] INV-018 the advanced lab faces 2 (the front 2) with 2 structures in its exit lane
- forbid 'invariant' hit at 14.6 min: [INVARIANT] INV-018 the advanced lab faces 2 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 18.3 min: [INVARIANT] INV-008 2 turret(s) in range of the reclaim of armwin 15602 are not on it
- forbid 'invariant' hit at 19.4 min: [INVARIANT] INV-011 metal floating at 4197 of 4200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 20.3 min: [INVARIANT] INV-004 metal floating at 4197 of 4200 for 60 s while armafus is under construction and static build power 720 is under 2031
- forbid 'invariant' hit at 20.4 min: [INVARIANT] INV-011 metal floating at 4197 of 4200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 21.3 min: [INVARIANT] INV-004 metal floating at 4197 of 4200 for 60 s while armafus is under construction and static build power 720 is under 2036
- forbid 'invariant' hit at 21.4 min: [INVARIANT] INV-029 armhp 27985 stands 19 cells from the turrets, not tight
- forbid 'invariant' hit at 21.4 min: [INVARIANT] INV-011 metal floating at 4337 of 4400 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 21.6 min: [INVARIANT] INV-006 2 wind/solar/advanced-solar structure(s) still stand 240 s after the advanced fusion
- forbid 'invariant' hit at 22.4 min: [INVARIANT] INV-011 metal floating at 4496 of 4500 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 23.0 min: [INVARIANT] INV-051 no advanced shipyard 480 s after the harbour began
- forbid 'invariant' hit at 23.4 min: [INVARIANT] INV-008 20 turret(s) in range of the reclaim of armalab 6439 are not on it
- forbid 'invariant' hit at 23.9 min: [INVARIANT] INV-029 armasy 17803 stands 38 cells from the turrets, not tight
- forbid 'invariant' hit at 24.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-029 armaap 26102 stands 4 cells from the turrets, not tight
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-022 a new set of armafus starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.2 min: [INVARIANT] INV-029 armalab 3399 stands 12 cells from the turrets, not tight
- forbid 'invariant' hit at 28.6 min: [INVARIANT] INV-029 leghp 6108 stands 29 cells from the turrets, not tight
- forbid 'invariant' hit at 28.7 min: [INVARIANT] INV-019 3 turret frames under construction, 2 allowed (build power 14190 (53 by power), bank 281 + 260/s (2 by metal))
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 13 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.0 min: [INVARIANT] INV-011 metal floating at 11650 of 11650 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 30.1 min: [INVARIANT] INV-014 armmmkr packed at (6528, 12000) with no turret slot within 450
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-029 legadvshipyard 18364 stands 21 cells from the turrets, not tight
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 30.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 31.0 min: [INVARIANT] INV-011 metal floating at 11804 of 11850 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 31.5 min: [INVARIANT] INV-014 armmmkr packed at (6528, 12064) with no turret slot within 450
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 31.8 min: [INVARIANT] INV-014 armafus packed at (6448, 12016) with no turret slot within 450
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-011 metal floating at 12400 of 12400 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 33.0 min: [INVARIANT] INV-011 metal floating at 11252 of 12400 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 33.3 min: [INVARIANT] INV-014 armafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 34.0 min: [INVARIANT] INV-011 metal floating at 4887 of 4900 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 34.1 min: [INVARIANT] INV-004 metal floating at 4893 of 4900 for 60 s while armmmkr is under construction and static build power 8400 is under 9029
- forbid 'invariant' hit at 34.2 min: [INVARIANT] INV-020 no layout room for armafus for 121 s
- forbid 'invariant' hit at 34.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 34.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 34.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 34.9 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (10 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 15714 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 20970 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 17374 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 16288 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 4928 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 3108 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-020 no layout room for armmmkr for 198 s
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 36.2 min: [INVARIANT] INV-004 metal floating at 4886 of 4900 for 60 s while armuwmmm is under construction and static build power 8400 is under 10541
- forbid 'invariant' hit at 36.4 min: [INVARIANT] INV-014 armafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 36.6 min: [INVARIANT] INV-020 no layout room for armmmkr for 261 s
- forbid 'invariant' hit at 36.6 min: [INVARIANT] INV-060 coast cluster #13 has 3 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 36.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 36.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 36.9 min: [INVARIANT] INV-032 a armmmkr ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 12716 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 15890 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 16228 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 6270 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 18981 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-020 no layout room for armmstor for 321 s
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-060 coast cluster #13 has 3 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.7 min: [INVARIANT] INV-004 metal floating at 5691 of 5700 for 60 s while armnanotc is under construction and static build power 8400 is under 10520
- forbid 'invariant' hit at 37.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 37.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 37.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 37.9 min: [INVARIANT] INV-032 a armmmkr ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 7285 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 14966 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 23427 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 7085 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 24623 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 19720 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 26960 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 28130 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 20899 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 16986 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.6 min: [INVARIANT] INV-020 no layout room for armmstor for 381 s
- forbid 'invariant' hit at 38.6 min: [INVARIANT] INV-060 coast cluster #13 has 3 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-004 metal floating at 5655 of 5700 for 60 s while armfmkr is under construction and static build power 8400 is under 9468
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-032 a armmmkr ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (10 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-020 no layout room for armmstor for 441 s
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-001 a retiring factory produced armfark 15589
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-060 coast cluster #13 has 3 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.7 min: [INVARIANT] INV-016 the advanced lab 3399 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 39.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 303 elmos away, not flush (160)
- forbid 'invariant' hit at 39.7 min: [INVARIANT] INV-018 the advanced lab faces 1 (the front 2) with 1 structures in its exit lane
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-008 6 turret(s) in range of the reclaim of armalab 3399 are not on it
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 14340 has done nothing for 60 s (task type 2, last rule assist.any)

## Screenshots

- build-theatres\games\tech\combat\t2-landlocked-start\tundra\20261003T232713Z-3984d2ff\runs\20261003T233412Z-25a490df\screen_2026-10-03_23-29-34-109.png
- build-theatres\games\tech\combat\t2-landlocked-start\tundra\20261003T232713Z-3984d2ff\runs\20261003T233412Z-25a490df\screen_2026-10-03_23-30-30-711.png
- build-theatres\games\tech\combat\t2-landlocked-start\tundra\20261003T232713Z-3984d2ff\runs\20261003T233412Z-25a490df\screen_2026-10-03_23-31-30-385.png
- build-theatres\games\tech\combat\t2-landlocked-start\tundra\20261003T232713Z-3984d2ff\runs\20261003T233412Z-25a490df\screen_2026-10-03_23-33-06-886.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 20, 4 shots, end at 40.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (2800, 800) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (6000, 11400) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2800, 800) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (6000, 11400) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] no atomic factory pair fits: no planned pair or turret box; structures are packed where the ground allows (D-120)
  0.08  [Layout] home centre (2866, 888), 62 from the start
  0.20  [Playtest] finished legmex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 16506 at 2848,928
  0.20  [Team][Roster] Re-announced: roster|1|0|0|TECH|legion|leglab|2818|849|1|2|1|2848|928
  0.21  [Rule] table of 50 rules loaded
  0.21  [Rule] chain.next for legcom 21155 | M +0 E 0/61 T1 M-float
  0.36  [Playtest] finished legmex team 0 at 0.36 min
  0.38  [Rule] chain.next for legcom 21155 | M +3 E 30/88 T1 M-float
  0.62  [Playtest] finished legmex team 0 at 0.62 min
  0.64  [Layout] advanced lab's footprint held beside the first lab at (2968, 936), 122 from it (D-121)
  0.64  [TECH][Build] first lab at the commander: (3088, 960), 89 from it, facing 0 (no planned pair, D-120)
  0.64  [Rule] chain.next for legcom 21155 | M +5 E 30/109 T1 M-float
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 808/1150, energy +30.0 bank 1/1000, units 5
  1.18  [Playtest] finished leglab team 0 at 1.18 min
  1.19  [Layout] no planned pair: economy structures are packed within 640 of the nearest lab (D-121)
  1.32  [Playtest] finished legwin team 0 at 1.32 min
  1.52  [Playtest] finished legwin team 0 at 1.52 min
  1.53  [Rule] chain.next for legcom 21155 | M +7 E 38/132 T1
  1.68  [Playtest] finished legwin team 0 at 1.68 min
  1.69  [Rule] chain.next for legcom 21155 | M +7 E 49/132 T1
  1.83  [Playtest] finished legwin team 0 at 1.83 min
  1.84  [Rule] chain.next for legcom 21155 | M +7 E 62/132 T1 draining
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 926/1250, energy +78.4 bank 135/1102, units 10
  2.06  [Rule] chain.next for legck 30414 | M +7 E 78/132 T1
  2.36  [Rule] chain.next for legcom 21155 | M +7 E 80/132 T1 draining
  2.46  [Playtest] finished legwin team 0 at 2.46 min
  2.48  [Rule] chain.next for legck 5617 | M +7 E 65/132 T1 draining
  2.48  [Rule] chain.next for legck 30414 | M +7 E 65/132 T1 M-float
  2.73  [Playtest] finished legwin team 0 at 2.73 min
  2.89  [Playtest] finished legwin team 0 at 2.89 min
  2.91  [Rule] chain.next for legcom 21155 | M +7 E 99/132 T1 draining
  2.91  [Rule] chain.next for legrezbot 11430 | M +7 E 99/132 T1 draining
  2.95  [Playtest] finished legwin team 0 at 2.95 min
  2.96  [Rule] chain.next for legck 5617 | M +7 E 99/132 T1 draining
  2.99  [Playtest] finished legwin team 0 at 2.99 min
  3.00  [TECH][Build] no open mex spot within 2500 of legrezbot 11430 at +7 metal
  3.00  [Rule] assist.any for legrezbot 11430 | M +7 E 99/132 T1 draining
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 886/1250, energy +117.8 bank 137/1204, units 19
  3.00  [Rule] chain.next for legck 30414 | M +7 E 99/132 T1 draining
  3.01  [Playtest] finished legwin team 0 at 3.01 min
  3.02  [Rule] chain.next for legrezbot 11430 | M +7 E 99/132 T1 draining
  3.13  [Playtest] finished legwin team 0 at 3.13 min
  3.21  [Playtest] finished legwin team 0 at 3.21 min
  3.23  [Layout] advanced lab on its cramped slot beside the first lab (D-121) (2968, 936): 1 turret slots within 260
  3.29  [TECH][Build] T1 lab reclaim deferred: metal 837 of 1250 leaves no room for its 470
  3.29  [Rule] chain.next for legrezbot 11430 | M +7 E 142/132 T2
  3.29  [Rule] chain.next for legck 14146 | M +7 E 142/132 T2
  3.35  [Playtest] finished legwin team 0 at 3.35 min
  3.37  [Rule] chain.next for legcom 21155 | M +7 E 145/132 T2
  3.45  [Playtest] finished legwin team 0 at 3.45 min
  3.47  [TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab 20321; idle build power in range joins
  3.47  [Rule] lab.t1.reclaim for legrezbot 11430 | M +7 E 166/132 T2 E-float
  3.47  [Rule] lab.t1.reclaim for legck 5617 | M +7 E 166/132 T2 E-float
  3.48  [Rule] harbour.float for legcom 21155 | M +7 E 166/132 T2 E-float
  3.48  [Rule] lab.t1.reclaim for legck 14146 | M +7 E 166/132 T2 E-float
  3.73  [Rule] power.turret for legrezbot 11430 | M +7 E 183/132 T2 E-float M-float
  3.73  [Rule] energy.convert.float for legck 5617 | M +7 E 183/132 T2 E-float M-float
  3.73  [Rule] energy.convert.float for legck 14146 | M +7 E 185/132 T2 E-float M-float
  3.79  [Playtest] finished legfeconv team 0 at 3.79 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.0 bank 1146/1150, energy +267.5 bank 1106/1157, units 26
  4.19  [Playtest] finished legfeconv team 0 at 4.19 min
  4.21  [Rule] power.turret for legcom 21155 | M +7 E 218/132 T2 M-float
  4.37  [Playtest] finished legeconv team 0 at 4.37 min
  4.38  [Rule] power.turret for legck 5617 | M +7 E 191/132 T2 M-float
  4.49  [Playtest] finished legeconv team 0 at 4.49 min
  4.51  [Rule] power.turret for legck 14146 | M +9 E 197/144 T2 M-float
  5.00  [Playtest] eco team 0 at 5.0 min: metal +9.6 bank 751/1150, energy +268.3 bank 926/1157, units 27
  5.04  [Rule] chain.next for legrezbot 11430 | M +9 E 265/152 T2
  6.00  [Playtest] eco team 0 at 6.0 min: metal +10.7 bank 0/1150, energy +267.9 bank 964/1157, units 27
  6.07  [Playtest] finished legalab team 0 at 6.07 min
  6.07  [Layout] advanced lab 1854: nearest construction turret none (not flush)
  6.07  [Layout] advanced lab 1854: faces 2, the front 2, 2 structures in its exit lane
  6.08  [TECH][Build] no open mex spot within 2500 of legrezbot 11430 at +10 metal
  6.08  [Rule] chain.next for legck 5617 | M +10 E 261/165 T2
  6.08  [Rule] chain.next for legcom 21155 | M +10 E 262/165 T2
  6.09  [Rule] chain.next for legck 30414 | M +10 E 262/165 T2
  6.09  [Rule] chain.next for legck 14146 | M +10 E 262/165 T2
  6.14  [Rule] chain.next for legrezbot 11430 | M +9 E 265/152 T2
  6.41  [Playtest] finished legwin team 0 at 6.41 min
  6.43  [Rule] chain.next for legcom 21155 | M +9 E 268/150 T2
  6.66  [Playtest] finished legwin team 0 at 6.66 min
  6.68  [Rule] chain.next for legck 5617 | M +9 E 284/154 T2
  6.68  [Playtest] finished legwin team 0 at 6.68 min
  6.70  [Rule] chain.next for legck 30414 | M +9 E 284/155 T2
  6.75  [Rule] chain.next for legrezbot 11430 | M +10 E 284/160 T2
  6.87  [Playtest] finished legwin team 0 at 6.87 min
  6.88  [Rule] chain.next for legcom 21155 | M +10 E 311/159 T2
  7.00  [Playtest] eco team 0 at 7.0 min: metal +11.7 bank 0/1350, energy +333.0 bank 1114/1359, units 35
  7.02  [Playtest] finished legwin team 0 at 7.02 min
  7.04  [Rule] chain.next for legck 5617 | M +10 E 326/166 T2
  7.09  [Rule] chain.next for legack 20442 | M +10 E 331/164 T2
  7.23  [Playtest] finished legwin team 0 at 7.23 min
  7.26  [Rule] chain.next for legck 30414 | M +10 E 272/157 T2
  7.47  [Playtest] finished legwin team 0 at 7.47 min
  7.48  [TECH][Build] no open mex spot within 2500 of legrezbot 11430 at +9 metal
  7.50  [Rule] chain.next for legck 14146 | M +9 E 184/146 T2
  7.54  [Rule] chain.next for legrezbot 11430 | M +8 E 177/142 T2
  7.70  [Playtest] speed 1 at 7.70 min
  7.75  [Playtest] finished legwin team 0 at 7.74 min
  7.76  [Rule] chain.next for legck 5617 | M +8 E 178/143 T2
  7.78  [Playtest] finished legwin team 0 at 7.78 min
  7.80  [Rule] chain.next for legcom 21155 | M +9 E 182/145 T2
  7.86  [Rule] chain.next for legrezbot 11430 | M +9 E 188/144 T2
  8.00  [Playtest] eco team 0 at 8.0 min: metal +9.9 bank 0/1350, energy +267.0 bank 1183/1461, units 43
  8.00  [Playtest] target team 0 at (2800, 800) from its start position
  8.00  [Playtest] camera requested (2800,800) height=2400
  8.00  [Playtest] camera captured name=ta position=(2800,800) height=2400
  8.00  [Playtest] screenshot at 8.0 min of team 0 at (2800, 800)
  8.04  [Playtest] finished legwin team 0 at 8.04 min
  8.05  [Playtest] speed 20 at 8.05 min
  8.06  [Rule] chain.next for legcom 21155 | M +9 E 227/147 T2
  8.26  [Playtest] finished legwin team 0 at 8.26 min
  8.28  [Rule] chain.next for legck 14146 | M +10 E 286/159 T2
  8.61  [Playtest] finished legwin team 0 at 8.61 min
  8.63  [Rule] chain.next for legck 5617 | M +10 E 300/162 T2
  8.69  [Rule] chain.next for legack 23665 | M +10 E 300/166 T2
  8.87  [Playtest] finished legwin team 0 at 8.87 min
  8.89  [Rule] harbour.float for legcom 21155 | M +11 E 407/175 T2 E-float
  8.89  [Rule] chain.next for legck 30414 | M +11 E 407/175 T2 E-float
  9.00  [Playtest] eco team 0 at 9.0 min: metal +12.0 bank 13/1350, energy +363.0 bank 1355/1563, units 45
  9.20  [Playtest] finished legfeconv team 0 at 9.20 min
  9.21  [Rule] chain.next for legcom 21155 | M +8 E 350/144 T2
  9.42  [Playtest] finished legwin team 0 at 9.42 min
  9.43  [Playtest] finished legmoho team 0 at 9.43 min
  9.45  [Rule] chain.next for legack 20442 | M +10 E 336/168 T2
  9.52  [Playtest] finished legwin team 0 at 9.52 min
  9.53  [Playtest] finished legwin team 0 at 9.53 min
  9.55  [Rule] chain.next for legck 30414 | M +11 E 336/173 T2
  9.60  [Playtest] finished legwin team 0 at 9.60 min
  9.61  [TECH][Build] no open mex spot within 2500 of legrezbot 11430 at +17 metal
  9.62  [Rule] storage.energy for legcom 21155 | M +17 E 341/279 T2
  9.63  [Layout] cramped turret 2 of 3 near (2968, 936) (D-121)
  9.68  [Rule] chain.next for legrezbot 11430 | M +17 E 309/267 T2
 10.00  [Playtest] eco team 0 at 10.0 min: metal +15.4 bank 14/1900, energy +534.8 bank 1240/1565, units 50
 10.23  [Playtest] finished legestor team 0 at 10.23 min
 10.24  [Rule] chain.next for legcom 21155 | M +17 E 565/282 T2 draining
 10.48  [Playtest] finished legmoho team 0 at 10.48 min
 10.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
 10.72  [Rule] power.turret for legck 5617 | M +23 E 302/389 T2
 10.81  [Playtest] finished legnanotc team 0 at 10.81 min
 10.82  [Layout] advanced lab 1854: nearest construction turret 260 elmos (not flush)
 10.82  [TECH][Build] no open mex spot within 2500 of legrezbot 11430 at +20 metal
 10.83  [Rule] chain.next for legck 5617 | M +20 E 225/339 T2
 10.89  [Rule] power.turret for legrezbot 11430 | M +20 E 182/337 T2
 10.90  [Rule] power.turret for legcom 21155 | M +20 E 182/337 T2
 10.90  [Layout] cramped turret 3 of 4 near (2968, 936) (D-121)
 10.90  [Rule] power.t1 for legck 30414 | M +20 E 166/337 T2
 10.91  [Rule] power.turret for legack 20442 | M +20 E 166/337 T2
 11.00  [Playtest] eco team 0 at 11.0 min: metal +20.0 bank 586/2450, energy +169.8 bank 5687/7565, units 50
 11.10  [Layout] cramped turret 4 of 4 near (2968, 936) (D-121)
 11.10  [Rule] power.t1 for legck 5617 | M +20 E 133/323 T2
 11.30  [Rule] chain.next for legrezbot 11430 | M +19 E 186/322 T2
 11.44  [Playtest] finished legmoho team 0 at 11.44 min
 11.45  [Rule] chain.next for legcom 21155 | M +19 E 320/322 T2
 11.46  [Rule] chain.next for legack 20442 | M +19 E 330/322 T2
 11.70  [Playtest] finished legnanotc team 0 at 11.70 min
 11.72  [Rule] power.turret for legrezbot 11430 | M +25 E 438/454 T2
 11.72  [Layout] advanced lab 1854: nearest construction turret 178 elmos (not flush)
 11.72  [Rule] power.turret for legcom 21155 | M +25 E 441/454 T2
 11.72  [Rule] power.turret for legck 30414 | M +25 E 441/454 T2
 11.73  [Rule] power.turret for legack 23665 | M +25 E 441/454 T2
 11.73  [Rule] power.turret for legack 20442 | M +25 E 445/454 T2
 11.78  [Playtest] finished legnanotc team 0 at 11.78 min
 11.80  [Rule] chain.next for legck 5617 | M +25 E 460/454 T2
 11.86  [TECH][Build] no open mex spot within 2500 of legrezbot 11430 at +27 metal
 11.88  [Rule] chain.next for legack 23665 | M +27 E 506/499 T2
 12.00  [Playtest] eco team 0 at 12.0 min: metal +31.0 bank 1105/3000, energy +379.4 bank 6336/7565, units 51
 12.01  [Rule] chain.next for legack 20442 | M +30 E 390/583 T2
 12.05  [Rule] chain.next for legrezbot 11430 | M +30 E 373/583 T2
 12.07  [Rule] chain.next for legcom 21155 | M +30 E 370/580 T2
 12.07  [Layout] cramped turret 5 of 5 near (2968, 936) (D-121)
 12.07  [Rule] power.t1 for legck 30414 | M +30 E 370/580 T2
 12.91  [Rule] chain.next for legck 5617 | M +25 E 331/454 T2 draining
 13.00  [Playtest] eco team 0 at 13.0 min: metal +26.0 bank 4/3000, energy +432.3 bank 2885/7565, units 53
 13.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
 13.88  [Playtest] finished legnanotc team 0 at 13.88 min
 13.89  [Rule] chain.next for legck 30414 | M +27 E 365/493 T2
 13.96  [Playtest] finished legfus team 0 at 13.96 min
 13.97  [TECH][Build] no open mex spot within 2500 of legrezbot 11430 at +27 metal
 13.99  [Rule] energy.reclaim for legck 5617 | M +27 E 381/498 T2
 14.00  [Playtest] eco team 0 at 14.0 min: metal +26.0 bank 76/3000, energy +1439.1 bank 8775/10065, units 53
 14.04  [Rule] harbour.float for legcom 21155 | M +27 E 394/502 T2 E-float
 14.06  [Rule] turret.assist for legnanotc 23916 | M +28 E 401/505 T2 E-float
 14.09  [Rule] turret.assist for legnanotc 26208 | M +28 E 422/513 T2 E-float
 14.09  [Rule] turret.assist for legnanotc 21975 | M +28 E 422/513 T2 E-float
 14.09  [Rule] turret.assist for legnanotc 20292 | M +28 E 422/513 T2 E-float
 14.12  [Rule] energy.reclaim for legck 30414 | M +28 E 1303/513 T2 E-float
 14.13  [Rule] energy.reclaim for legck 5617 | M +28 E 1317/513 T2 E-float
 14.14  [Rule] energy.convert.float for legack 23665 | M +28 E 1317/513 T2 E-float
 14.14  [Rule] energy.convert.float for legack 20442 | M +28 E 1317/513 T2 E-float
 14.17  [Rule] energy.reclaim for legrezbot 11430 | M +29 E 1341/536 T2 E-float
 14.17  [Rule] energy.convert.float for legack 23665 | M +29 E 1341/536 T2 E-float
 14.20  [Rule] energy.convert.float for legack 23665 | M +29 E 1326/546 T2 E-float
 14.23  [Rule] energy.convert.float for legack 23665 | M +30 E 1273/583 T2 E-float
 14.25  [Rule] energy.convert.float for legack 23665 | M +30 E 1230/583 T2 E-float
 14.40  [Playtest] finished legfeconv team 0 at 14.40 min
 14.41  [Rule] assist.any for legrezbot 11430 | M +39 E 1149/845 T2 E-float
 14.41  [Rule] assist.any for legck 5617 | M +39 E 1149/845 T2 E-float
 14.43  [Rule] assist.any for legck 30414 | M +39 E 1139/845 T2 E-float
 14.57  [Layout] advanced lab 1854: faces 2, the front 2, 1 structures in its exit lane
 14.65  [Layout] advanced lab 1854: faces 2, the front 2, 0 structures in its exit lane
 14.72  [TECH][Factory] legalab: T2 constructor 3 of 10 (bank 1675 of 3000) (D-103)
 14.81  [Playtest] finished legfeconv team 0 at 14.81 min
 14.82  [Rule] assist.any for legcom 21155 | M +40 E 1105/871 T2
 14.98  [Rule] chain.next for legack 7724 | M +35 E 1105/727 T2
 14.98  [TECH][Factory] legalab: T2 constructor 4 of 10 (bank 1824 of 3000) (D-103)
 15.00  [TECH][Build] no open mex spot within 2500 of legack 7724 at +35 metal
 15.00  [Rule] assist.any for legack 7724 | M +35 E 1105/725 T2
 15.00  [Playtest] eco team 0 at 15.0 min: metal +28.8 bank 1841/3000, energy +1179.0 bank 7720/10158, units 45
 15.00  [Rule] harbour.yard for legck 14146 | M +35 E 1105/725 T2
 15.27  [Rule] assist.any for legack 7526 | M +34 E 1094/686 T2
 15.27  [TECH][Factory] legalab: T2 constructor 5 of 10 (bank 1930 of 3000) (D-103)
 15.30  [Playtest] finished legadveconv team 0 at 15.30 min
 15.32  [Rule] energy.reclaim for legrezbot 11430 | M +34 E 1093/686 T2
 15.33  [Rule] harbour.yard for legck 5617 | M +34 E 1093/686 T2
 15.33  [Rule] energy.reclaim for legcom 21155 | M +25 E 1093/454 T2
 15.34  [Rule] energy.reclaim for legck 30414 | M +25 E 1093/454 T2
 15.34  [Rule] assist.any for legack 20442 | M +25 E 1093/454 T2
 15.41  [Rule] assist.any for legrezbot 11430 | M +25 E 1093/454 T2
 15.41  [Rule] turret.any for legnanotc 26208 | M +25 E 1093/454 T2
 15.42  [Rule] turret.any for legnanotc 21975 | M +25 E 1093/454 T2
 15.43  [Rule] turret.any for legnanotc 20292 | M +25 E 1093/454 T2
 15.43  [Rule] assist.any for legcom 21155 | M +25 E 1093/454 T2
 15.44  [Rule] order.repair for legck 30414 | M +25 E 1093/454 T2
 15.53  [Rule] assist.any for legack 23966 | M +25 E 1099/454 T2
 15.53  [TECH][Factory] legalab: T2 constructor 6 of 10 (bank 1937 of 3000) (D-103)
 15.53  [Rule] assist.any for legck 30414 | M +25 E 1099/454 T2
 15.77  [Rule] assist.any for legack 26302 | M +25 E 1153/454 T2
 15.77  [TECH][Factory] legalab: T2 constructor 7 of 10 (bank 1760 of 3000) (D-103)
 15.80  [Playtest] finished legadveconv team 0 at 15.80 min
 15.84  [Rule] energy.reclaim for legrezbot 11430 | M +25 E 1153/454 T2
 15.84  [Rule] energy.reclaim for legcom 21155 | M +25 E 1153/454 T2
 15.85  [Rule] energy.reclaim for legck 30414 | M +25 E 1153/454 T2
 15.85  [Rule] energy.convert for legack 20442 | M +25 E 1153/454 T2
 15.94  [Rule] order.repair for legck 30414 | M +25 E 1164/454 T2
 15.98  [TECH][Factory] legalab: T2 constructor 8 of 10 (bank 1755 of 3000) (D-103)
 15.99  [Rule] energy.reclaim for legck 30414 | M +25 E 1164/454 T2
 15.99  [Rule] energy.reclaim for legrezbot 11430 | M +25 E 1164/454 T2
 16.00  [Playtest] eco team 0 at 16.0 min: metal +36.9 bank 1776/3000, energy +1173.6 bank 8199/10506, units 43
 16.02  [TECH][Build] no open mex spot within 2500 of legack 7724 at +25 metal
 16.02  [Rule] turret.assist for legnanotc 21975 | M +25 E 1164/454 T2
 16.09  [Rule] order.repair for legck 30414 | M +36 E 1164/761 T2
 16.22  [TECH][Factory] legalab: T2 constructor 9 of 10 (bank 1900 of 3000) (D-103)
 16.22  [Rule] energy.reclaim for legck 30414 | M +34 E 1167/673 T2
 16.22  [Rule] energy.reclaim for legcom 21155 | M +34 E 1167/673 T2
 16.25  [Rule] turret.assist for legnanotc 20292 | M +34 E 1167/673 T2
 16.32  [Rule] order.repair for legck 30414 | M +34 E 1170/673 T2
 16.43  [TECH][Factory] legalab: T2 constructor 10 of 10 (bank 2009 of 3000) (D-103)
 16.44  [Rule] energy.convert.float for legack 7724 | M +34 E 1207/691 T2
 16.44  [Rule] energy.convert.float for legack 18387 | M +34 E 1207/691 T2
 16.45  [Rule] energy.reclaim for legcom 21155 | M +34 E 1207/691 T2
 16.45  [Rule] energy.reclaim for legck 30414 | M +34 E 1207/691 T2
 16.53  [Rule] order.repair for legck 30414 | M +34 E 1207/691 T2
 16.65  [Ferry] requested a transport (TECH at +20 metal, no transport)
 16.79  [Rule] storage.metal for legck 30414 | M +37 E 1242/771 T2 M-float
 16.81  [Rule] storage.metal for legcom 21155 | M +37 E 1243/772 T2 M-float
 16.96  [Rule] assist.any for legrezbot 11430 | M +46 E 1272/996 T2 M-float
 16.97  [Rule] assist.any for legack 20442 | M +46 E 1273/996 T2 M-float
 16.98  [Rule] chain.next for legack 23966 | M +46 E 1273/996 T2 M-float
 16.98  [Rule] assist.any for legack 10963 | M +46 E 1273/996 T2 M-float
 16.99  [Rule] turret.assist for legnanotc 21975 | M +46 E 1273/989 T2 M-float
 16.99  [Rule] assist.any for legack 23665 | M +46 E 1273/989 T2 M-float
 17.00  [Rule] assist.any for legack 18387 | M +46 E 1273/989 T2 M-float
 17.00  [Playtest] eco team 0 at 17.0 min: metal +45.0 bank 2904/3000, energy +1273.9 bank 8632/10804, units 44
 17.00  [Rule] assist.any for legack 8906 | M +45 E 1273/979 T2 M-float
 17.00  [Rule] assist.any for legack 23966 | M +45 E 1273/979 T2 M-float
 17.01  [Rule] assist.any for legack 7526 | M +45 E 1273/979 T2 M-float
 17.01  [Rule] assist.any for legack 26302 | M +45 E 1273/979 T2 M-float
 17.02  [Rule] turret.assist for legnanotc 20292 | M +45 E 1273/968 T2 M-float
 17.02  [TECH][Build] no open mex spot within 2500 of legack 7724 at +45 metal
 17.02  [Rule] assist.any for legack 7724 | M +45 E 1273/968 T2 M-float
 17.03  [Rule] assist.any for legack 12319 | M +45 E 1273/968 T2 M-float
 17.03  [Playtest] finished legmstor team 0 at 17.03 min
 17.07  [Rule] turret.assist for legnanotc 26208 | M +44 E 1273/949 T2
 17.08  [Rule] turret.any for legnanotc 23916 | M +44 E 1273/949 T2
 17.08  [Playtest] finished legmstor team 0 at 17.08 min
 17.48  [Rule] order.repair for legck 30414 | M +39 E 1269/839 T2
 17.61  [Rule] defence.fortify for legaceb 7518 | M +36 E 1271/754 T2
 17.96  [Rule] order.repair for legck 30414 | M +45 E 1200/972 T2
 18.00  [Playtest] eco team 0 at 18.0 min: metal +34.7 bank 4669/9000, energy +1189.5 bank 8448/10904, units 46
 18.03  [TECH][Build] no open mex spot within 2500 of legack 23966 at +38 metal
 18.03  [Rule] assist.any for legack 23966 | M +38 E 1189/809 T2
 18.04  [Rule] assist.any for legrezbot 11430 | M +36 E 1187/738 T2
 18.04  [Rule] assist.any for legack 12319 | M +36 E 1187/738 T2
 18.05  [Rule] assist.any for legck 5617 | M +36 E 1187/738 T2
 18.05  [Rule] assist.any for legack 23665 | M +34 E 1186/680 T2
 18.06  [Rule] assist.any for legack 20442 | M +34 E 1186/680 T2
 18.07  [Rule] assist.any for legack 10963 | M +34 E 1185/675 T2
 18.07  [Rule] assist.any for legack 7724 | M +34 E 1185/675 T2
 18.08  [Rule] assist.any for legack 18387 | M +34 E 1185/675 T2
 18.08  [Rule] assist.any for legack 8906 | M +34 E 1185/675 T2
 18.09  [Rule] assist.any for legack 7526 | M +33 E 1185/668 T2
 18.09  [Rule] assist.any for legack 26302 | M +33 E 1185/668 T2
 18.12  [Rule] defence.fortify for legaceb 9052 | M +33 E 1185/659 T2
 18.12  [Rule] energy.reclaim for legck 30414 | M +33 E 1185/659 T2
 18.16  [Playtest] finished legforti team 0 at 18.16 min
 18.20  [Rule] defence.fortify for legaceb 7518 | M +33 E 1185/659 T2
 18.24  [Rule] assist.any for legack 7724 | M +33 E 1185/659 T2
 18.25  [Rule] assist.any for legack 10963 | M +33 E 1185/659 T2
 18.25  [Rule] assist.any for legack 23966 | M +33 E 1185/659 T2
 18.26  [Rule] assist.any for legack 18387 | M +33 E 1185/659 T2
 18.28  [Rule] assist.any for legack 8906 | M +33 E 1189/667 T2
 18.28  [Rule] assist.any for legack 7526 | M +33 E 1189/667 T2
 18.29  [Rule] assist.any for legack 12319 | M +36 E 1193/735 T2
 18.29  [Rule] assist.any for legack 26302 | M +36 E 1193/735 T2
 18.29  [Rule] assist.any for legrezbot 11430 | M +36 E 1193/735 T2
 18.31  [Rule] assist.any for legck 30414 | M +38 E 1199/805 T2
 18.32  [Rule] assist.any for legack 23665 | M +38 E 1199/805 T2
 18.36  [Playtest] finished legforti team 0 at 18.36 min
 18.40  [Rule] defence.fortify for legaceb 7518 | M +45 E 1234/965 T2
 18.44  [Rule] assist.any for legack 7724 | M +45 E 1241/965 T2
 18.48  [Rule] assist.any for legack 7526 | M +45 E 1242/965 T2
 18.50  [Rule] assist.any for legrezbot 11430 | M +45 E 1242/965 T2
 18.51  [Rule] assist.any for legack 23966 | M +45 E 1242/965 T2
 18.55  [Playtest] finished legforti team 0 at 18.55 min
 18.55  [Rule] assist.any for legack 8906 | M +45 E 1244/960 T2
 18.57  [TECH][Build] legaceb 7518 expands to a mex at (2800, 1568) at +44 metal
 18.57  [Rule] mex.expand for legaceb 7518 | M +44 E 1246/959 T2
 18.58  [Rule] assist.any for legack 26302 | M +44 E 1246/959 T2
 18.63  [Playtest] finished legforti team 0 at 18.63 min
 18.65  [TECH][Build] legaceb 9052 expands to a mex at (2656, 1440) at +44 metal
 18.65  [Rule] mex.expand for legaceb 9052 | M +44 E 1253/959 T2
 18.70  [Rule] assist.any for legcom 21155 | M +44 E 1261/959 T2
 18.71  [Rule] assist.any for legck 30414 | M +44 E 1261/959 T2
 18.71  [Rule] assist.any for legack 20442 | M +44 E 1261/959 T2
 18.72  [Rule] assist.any for legack 7724 | M +44 E 1261/959 T2
 18.72  [Rule] assist.any for legack 8906 | M +44 E 1262/959 T2
 18.73  [Rule] assist.any for legack 23966 | M +44 E 1262/959 T2
 18.73  [Rule] assist.any for legack 12319 | M +44 E 1262/959 T2
 18.74  [Rule] assist.any for legack 7526 | M +44 E 1263/959 T2
 18.75  [Rule] assist.any for legack 26302 | M +44 E 1263/959 T2
 18.75  [Rule] assist.any for legack 10963 | M +45 E 1263/962 T2
 18.76  [Rule] assist.any for legrezbot 11430 | M +45 E 1263/962 T2
 18.76  [Rule] assist.any for legack 23665 | M +45 E 1263/962 T2
 18.77  [Rule] assist.any for legack 18387 | M +45 E 1263/962 T2
 18.77  [Rule] assist.any for legck 5617 | M +45 E 1264/966 T2
 18.80  [Rule] turret.any for legnanotc 20292 | M +45 E 1267/975 T2
 18.83  [Rule] turret.any for legnanotc 26208 | M +46 E 1269/980 T2
 18.84  [Rule] turret.any for legnanotc 21975 | M +46 E 1271/985 T2
 18.95  [Playtest] finished legmex team 0 at 18.95 min
 18.96  [Rule] chain.next for legack 7724 | M +45 E 1277/977 T2
 18.99  [Rule] chain.next for legaceb 7518 | M +45 E 1272/977 T2
 19.00  [Playtest] eco team 0 at 19.0 min: metal +48.2 bank 6917/9050, energy +1268.3 bank 8837/11004, units 51
 19.03  [Playtest] finished legmex team 0 at 19.03 min
 19.04  [TECH][Build] no open mex spot within 2500 of legrezbot 11430 at +45 metal
 19.05  [TECH][Build] legaceb 9052 expands to a mex at (1952, 2480) at +45 metal
 19.05  [Rule] mex.expand for legaceb 9052 | M +45 E 1266/977 T2
 19.07  [TECH][Build] legack 8906 expands to a mex at (1664, 2304) at +45 metal
 19.07  [Rule] mex.expand for legack 8906 | M +45 E 1264/977 T2
 19.08  [TECH][Build] legaceb 7518 expands to a mex at (1440, 2048) at +45 metal
 19.08  [Rule] mex.expand for legaceb 7518 | M +45 E 1264/977 T2
 19.18  [Rule] energy.float for legck 30414 | M +47 E 1255/1012 T2 M-float
 19.20  [Rule] energy.float for legck 5617 | M +49 E 1252/1057 T2 M-float
 19.25  [Rule] energy.float for legck 30414 | M +50 E 1242/1061 T2 M-float
 19.31  [Rule] energy.float for legck 30414 | M +50 E 1233/1061 T2 M-float
 19.32  [Rule] power.turret for legack 26302 | M +50 E 1233/1061 T2 M-float
 19.32  [Rule] power.turret for legrezbot 11430 | M +50 E 1231/1061 T2 M-float
 19.32  [Layout] cramped turret 6 of 7 near (2968, 936) (D-121)
 19.32  [Rule] power.turret for legck 5617 | M +50 E 1231/1061 T2 M-float
 19.34  [Rule] power.turret for legack 23665 | M +49 E 1230/1059 T2 M-float
 19.35  [Rule] power.turret for legack 23966 | M +49 E 1230/1059 T2 M-float
 19.36  [Rule] power.turret for legcom 21155 | M +49 E 1230/1056 T2 M-float
 19.36  [Rule] power.turret for legack 20442 | M +49 E 1230/1056 T2 M-float
 19.36  [Rule] power.turret for legack 10963 | M +49 E 1230/1056 T2 M-float
 19.37  [Rule] power.turret for legack 18387 | M +49 E 1230/1054 T2 M-float
 19.37  [Rule] power.turret for legack 7526 | M +49 E 1230/1054 T2 M-float
 19.38  [Rule] power.turret for legack 12319 | M +49 E 1230/1054 T2 M-float
 19.38  [Rule] power.turret for legck 30414 | M +49 E 1230/1054 T2 M-float
 19.53  [Rule] turret.assist for legnanotc 26208 | M +48 E 1219/1036 T2 M-float
 19.55  [Rule] turret.assist for legnanotc 20292 | M +47 E 1218/1012 T2 M-float
 19.56  [Rule] turret.assist for legnanotc 21975 | M +47 E 1218/1012 T2 M-float
 19.57  [Rule] turret.assist for legnanotc 23916 | M +47 E 1218/1012 T2 M-float
 19.57  [Playtest] finished legmex team 0 at 19.57 min
 19.58  [Rule] assist.any for legaceb 9052 | M +47 E 1218/1012 T2 M-float
 19.58  [Rule] assist.any for legack 23966 | M +47 E 1218/1012 T2 M-float
 19.59  [Rule] assist.any for legack 10963 | M +47 E 1217/1012 T2 M-float
 19.59  [Rule] assist.any for legack 18387 | M +47 E 1217/1012 T2 M-float
 19.60  [Rule] chain.next for legack 7526 | M +47 E 1217/1012 T2 M-float
 19.60  [Rule] chain.next for legack 12319 | M +47 E 1217/1012 T2 M-float
 19.61  [Rule] chain.next for legack 26302 | M +47 E 1217/1012 T2 M-float
 19.61  [Rule] chain.next for legrezbot 11430 | M +47 E 1217/1012 T2 M-float
... 990 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: leglab at (4640, 4368) facing 0 (id 1)
  0.08  RESERVE: zone 1 at (4640, 4296) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of legnanotc 2x1 gap 0 behind (4640, 4320) facing 0: 2 of 2 slots (group 1, zone)
  0.08  RESERVE: legalab at (2344, 2360) facing 0 (id 4)
  0.08  RESERVE: zone 2 at (2344, 2240) facing 0, 7x6 cells: 42 of 42 held
  0.08  RESERVE: grid of legnanotc 2x2 gap 0 behind (2344, 2288) facing 0: 4 of 4 slots (group 2, zone)
  0.08  RESERVE: zone 3 at (2344, 2312) facing 0, 9x15 cells: 12 of 135 held
  0.08  RESERVE: corridor 4 at (2344, 2608) facing 0, 13x20 cells: 260 of 260 held
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.08  RESERVE: zone 7 at (6483, 11864) facing 2, 77x58 cells: 4038 of 4466 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (6483, 11368) facing 2: 7 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (6483, 11416) facing 2: 7 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (6483, 11464) facing 2: 7 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (6483, 11512) facing 2: 8 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (6248, 11288) facing 2 (id 40)
  0.08  RESERVE: armlab at (5232, 10704) facing 2 (id 41)
  0.08  RESERVE: zone 8 at (5232, 10776) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (5232, 10752) facing 2: 2 of 2 slots (group 6, zone)
  0.08  RESERVE: armlab at (5808, 8304) facing 2 (id 44)
  0.08  RESERVE: zone 9 at (5808, 8376) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (5808, 8352) facing 2: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (5344, 10672) facing 2 (id 47)
  0.08  RESERVE: zone 10 at (5344, 10744) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (5344, 10720) facing 2: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: armlab at (5232, 10704) facing 2 (id 50)
  0.08  RESERVE: zone 11 at (5232, 10776) facing 2, 6x3 cells: 0 of 18 held
  0.08  RESERVE: armlab at (5184, 10480) facing 2 (id 51)
  0.08  RESERVE: zone 11 at (5184, 10552) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (5184, 10528) facing 2: 2 of 2 slots (group 9, zone)
  0.08  RESERVE: armlab at (5808, 8304) facing 2 (id 54)
  0.08  RESERVE: zone 12 at (5808, 8376) facing 2, 6x3 cells: 0 of 18 held
  0.08  RESERVE: armlab at (5920, 8272) facing 2 (id 55)
  0.08  RESERVE: zone 12 at (5920, 8344) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (5920, 8320) facing 2: 2 of 2 slots (group 10, zone)
  0.08  RESERVE: armlab at (6096, 7104) facing 2 (id 58)
  0.08  RESERVE: zone 13 at (6096, 7176) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (6096, 7152) facing 2: 2 of 2 slots (group 11, zone)
  0.08  RESERVE: corridor 14 at (6192, 7128) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 15 at (6096, 7128) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 15 at (6096, 6880) facing 2, 10x20 cells: 190 of 200 held
  0.08  EXP: approach: armcom(13552) at (5991, 11426) walks to (5808, 11539), 136 from the armmex site (5936, 11584)
  0.17  RESERVE: leggant at (1312, 5040) facing 0 (id 9)
  0.17  RESERVE: zone 5 at (1312, 4824) facing 0, 30x15 cells: 450 of 450 held
  0.17  RESERVE: grid of legnanotc 10x5 gap 0 behind (1312, 4944) facing 0: 38 of 50 slots (group 3, zone)
  0.17  RESERVE: zone 5 released
  0.17  RESERVE: zone 6 at (1312, 4824) facing 0, 24x15 cells: 360 of 360 held
  0.17  RESERVE: grid of legnanotc 8x5 gap 0 behind (1312, 4944) facing 0: 31 of 40 slots (group 4, zone)
  0.17  RESERVE: zone 6 released
  0.17  RESERVE: zone 7 at (1312, 4848) facing 0, 24x12 cells: 288 of 288 held
  0.17  RESERVE: grid of legnanotc 8x4 gap 0 behind (1312, 4944) facing 0: 28 of 32 slots (group 5, zone)
  0.17  RESERVE: zone 7 released
  0.17  RESERVE: zone 8 at (1312, 4848) facing 0, 18x12 cells: 216 of 216 held
  0.17  RESERVE: grid of legnanotc 6x4 gap 0 behind (1312, 4944) facing 0: 22 of 24 slots (group 6, zone)
  0.17  RESERVE: zone 8 released
  0.17  RESERVE: zone 9 at (1312, 4872) facing 0, 18x9 cells: 162 of 162 held
  0.17  RESERVE: grid of legnanotc 6x3 gap 0 behind (1312, 4944) facing 0: 17 of 18 slots (group 7, zone)
  0.17  RESERVE: zone 9 released
  0.17  RESERVE: zone 10 at (1312, 4896) facing 0, 10x6 cells: 60 of 60 held
  0.17  RESERVE: grid of legnanotc 3x2 gap 0 behind (1312, 4944) facing 0: 6 of 6 slots (group 8, zone)
  0.17  RESERVE: zone 11 at (1312, 4992) facing 0, 12x18 cells: 12 of 216 held
  0.17  RESERVE: corridor 12 at (1312, 5312) facing 0, 16x20 cells: 304 of 320 held
  0.17  RESERVE: armlab at (5344, 10672) facing 2 (id 61)
  0.17  RESERVE: zone 16 at (5344, 10744) facing 2, 6x3 cells: 0 of 18 held
  0.17  RESERVE: armlab at (5232, 10704) facing 2 (id 62)
  0.17  RESERVE: zone 16 at (5232, 10776) facing 2, 6x3 cells: 0 of 18 held
  0.17  RESERVE: armlab at (5184, 10480) facing 2 (id 63)
  0.17  RESERVE: zone 16 at (5184, 10552) facing 2, 6x3 cells: 0 of 18 held
  0.17  RESERVE: armlab at (5808, 8304) facing 2 (id 64)
  0.17  RESERVE: zone 16 at (5808, 8376) facing 2, 6x3 cells: 0 of 18 held
  0.17  RESERVE: armlab at (5920, 8272) facing 2 (id 65)
  0.17  RESERVE: zone 16 at (5920, 8344) facing 2, 6x3 cells: 0 of 18 held
  0.17  RESERVE: armalab at (4856, 10312) facing 2 (id 66)
  0.17  RESERVE: zone 16 at (4856, 10432) facing 2, 7x6 cells: 42 of 42 held
  0.17  RESERVE: grid of armnanotc 2x2 gap 0 behind (4856, 10384) facing 2: 4 of 4 slots (group 12, zone)
  0.17  RESERVE: zone 17 at (4856, 10360) facing 0, 9x15 cells: 12 of 135 held
  0.17  RESERVE: corridor 18 at (4856, 10064) facing 2, 13x20 cells: 260 of 260 held
  0.20  EXP: idle: armcom(13552) on armmex at (5817, 11534), site (5936, 11584), target yes, fails 2 (arrived at the approach point)
  0.21  EXP: approach: legcom(21155) at (2823, 862) walks to (2737, 831), 137 from the legmex site (2608, 784)
  0.25  RESERVE: leglab at (4640, 4368) facing 0 (id 152)
  0.25  RESERVE: zone 13 at (4640, 4296) facing 0, 6x3 cells: 0 of 18 held
  0.25  RESERVE: armalab at (5112, 10728) facing 2 (id 71)
  0.25  RESERVE: zone 19 at (5112, 10848) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (5112, 10800) facing 2: 4 of 4 slots (group 13, zone)
  0.25  RESERVE: zone 20 at (5112, 10776) facing 0, 9x15 cells: 9 of 135 held
  0.25  RESERVE: corridor 21 at (5112, 10480) facing 2, 13x20 cells: 245 of 260 held
  0.33  RESERVE: armlab at (5344, 10672) facing 2 (id 76)
  0.33  RESERVE: zone 22 at (5344, 10744) facing 2, 6x3 cells: 0 of 18 held
  0.33  RESERVE: armlab at (5232, 10704) facing 2 (id 77)
  0.33  RESERVE: zone 22 at (5232, 10776) facing 2, 6x3 cells: 0 of 18 held
  0.33  RESERVE: armlab at (5808, 8304) facing 2 (id 78)
  0.33  RESERVE: zone 22 at (5808, 8376) facing 2, 6x3 cells: 0 of 18 held
  0.33  RESERVE: armlab at (5920, 8272) facing 2 (id 79)
  0.33  RESERVE: zone 22 at (5920, 8344) facing 2, 6x3 cells: 0 of 18 held
  0.33  RESERVE: armshltx at (3920, 10720) facing 2 (id 80)
  0.33  RESERVE: zone 22 at (3920, 10936) facing 2, 30x15 cells: 450 of 450 held
  0.33  RESERVE: grid of armnanotc 10x5 gap 0 behind (3920, 10816) facing 2: 37 of 50 slots (group 14, zone)
  0.33  RESERVE: zone 22 released
  0.33  RESERVE: zone 23 at (3920, 10936) facing 2, 24x15 cells: 360 of 360 held
  0.33  RESERVE: grid of armnanotc 8x5 gap 0 behind (3920, 10816) facing 2: 32 of 40 slots (group 15, zone)
  0.33  RESERVE: zone 23 released
  0.33  RESERVE: zone 24 at (3920, 10912) facing 2, 24x12 cells: 288 of 288 held
  0.33  RESERVE: grid of armnanotc 8x4 gap 0 behind (3920, 10816) facing 2: 26 of 32 slots (group 16, zone)
  0.33  RESERVE: zone 24 released
  0.33  RESERVE: zone 25 at (3920, 10912) facing 2, 18x12 cells: 216 of 216 held
  0.33  RESERVE: grid of armnanotc 6x4 gap 0 behind (3920, 10816) facing 2: 21 of 24 slots (group 17, zone)
  0.33  RESERVE: zone 25 released
  0.33  RESERVE: zone 26 at (3920, 10888) facing 2, 18x9 cells: 162 of 162 held
  0.33  RESERVE: grid of armnanotc 6x3 gap 0 behind (3920, 10816) facing 2: 16 of 18 slots (group 18, zone)
  0.33  RESERVE: zone 26 released
  0.33  RESERVE: zone 27 at (3920, 10864) facing 2, 10x6 cells: 60 of 60 held
  0.33  RESERVE: grid of armnanotc 3x2 gap 0 behind (3920, 10816) facing 2: 6 of 6 slots (group 19, zone)
  0.33  RESERVE: zone 28 at (3920, 10768) facing 0, 12x18 cells: 12 of 216 held
  0.33  RESERVE: corridor 29 at (3920, 10448) facing 2, 16x20 cells: 320 of 320 held
  0.38  EXP: approach: legcom(21155) at (2757, 837) walks to (3038, 932), 137 from the legmex site (3168, 976)
  0.42  RESERVE: leglab at (4640, 4368) facing 0 (id 153)
  0.42  RESERVE: zone 13 at (4640, 4296) facing 0, 6x3 cells: 0 of 18 held
  0.42  RESERVE: armshltx at (6336, 7056) facing 2 (id 219)
  0.42  RESERVE: zone 30 at (6336, 7272) facing 2, 30x15 cells: 387 of 450 held
  0.42  RESERVE: grid of armnanotc 10x5 gap 0 behind (6336, 7152) facing 2: 29 of 50 slots new (group 20, zone)
  0.42  RESERVE: zone 30 released
```
