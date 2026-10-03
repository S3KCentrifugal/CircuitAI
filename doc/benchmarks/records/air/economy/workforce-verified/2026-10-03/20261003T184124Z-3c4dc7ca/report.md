# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 45.1 min (frame 81124); wall 392 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:34:49
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glitters\runs\20261003T184124Z-3c4dc7ca\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=995 E=0 bank=934 pull=61 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 16094 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 5.0 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 16094 are not on it
- forbid 'invariant' hit at 7.0 min: [INVARIANT] INV-019 3 turret frames under construction, 2 allowed (build power 1192 (4 by power), bank 404 + 17/s (2 by metal))
- forbid 'invariant' hit at 11.9 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 6 T2 constructors, none added
- forbid 'invariant' hit at 12.2 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 3 T2 constructors, none added
- forbid 'invariant' hit at 12.9 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 6 T2 constructors, none added
- forbid 'invariant' hit at 13.2 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 2 T2 constructors, none added
- forbid 'invariant' hit at 13.9 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 6 T2 constructors, none added
- forbid 'invariant' hit at 14.2 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 2 T2 constructors, none added
- forbid 'invariant' hit at 14.9 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 6 T2 constructors, none added
- forbid 'invariant' hit at 19.4 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (5200, 272) not upgraded
- forbid 'invariant' hit at 20.8 min: [INVARIANT] INV-022 a new set of armafus starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.5 min: [INVARIANT] INV-010 combat unit armfast 24553 produced at +137 metal under the gate 200
- forbid 'invariant' hit at 23.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.8 min: [INVARIANT] INV-010 combat unit legstr 28190 produced at +105 metal under the gate 200
- forbid 'invariant' hit at 25.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.3 min: [INVARIANT] INV-011 metal floating at 19599 of 19600 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 32.3 min: [INVARIANT] INV-011 metal floating at 20146 of 20150 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 32.4 min: [INVARIANT] INV-010 combat unit legstr 24531 produced at +197 metal under the gate 200
- forbid 'invariant' hit at 32.6 min: [INVARIANT] INV-011 metal floating at 15871 of 16350 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 32.8 min: [INVARIANT] INV-060 air defence cluster #18 has 4 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 33.4 min: [INVARIANT] INV-009 a armafus frame appeared while energy floats (bank 20956 of 21050 full for 495 s, +925 over the pull): converters first
- forbid 'invariant' hit at 33.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 33.9 min: [INVARIANT] INV-010 combat unit armpw 11829 produced at +189 metal under the gate 200
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-060 air defence cluster #18 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 34.6 min: [INVARIANT] INV-010 combat unit leggob 29213 produced at +179 metal under the gate 200
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 35.1 min: [INVARIANT] INV-010 combat unit legstr 28648 produced at +194 metal under the gate 200
- forbid 'invariant' hit at 35.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 35.4 min: [INVARIANT] INV-031 the advanced lab 18339 retired while the advanced fusion was funded: bank 10877 + 239/s x 17 s (37% built, build power 11910) = 15007 against 8245 (85% of 9700)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-001 a retiring factory produced armfast 8737
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-060 air defence cluster #18 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 8868 has done nothing for 60 s (task type 2, last rule lab.base.reclaim)
- forbid 'invariant' hit at 35.6 min: [INVARIANT] INV-010 combat unit leggob 10432 produced at +171 metal under the gate 200
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 36.3 min: [INVARIANT] INV-060 kill zone cluster #1 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-060 air defence cluster #18 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 23915 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 18767 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-022 a new set of armmmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 36.6 min: [INVARIANT] INV-014 armmmkr packed at (3712, 320) with no turret slot within 450
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 17642 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 3309 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 31500 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 26370 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 19775 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 37.1 min: [INVARIANT] INV-014 legadveconv packed at (976, 9872) with no turret slot within 450
- forbid 'invariant' hit at 37.3 min: [INVARIANT] INV-060 kill zone cluster #1 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-060 air defence cluster #18 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 38.2 min: [INVARIANT] INV-014 legadveconv packed at (1984, 9840) with no turret slot within 450
- forbid 'invariant' hit at 38.3 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-014 armmmkr packed at (4512, 528) with no turret slot within 450
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 14 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-060 air defence cluster #18 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 8854 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 39.4 min: [INVARIANT] INV-014 legadveconv packed at (912, 9872) with no turret slot within 450
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-060 air defence cluster #18 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.8 min: [INVARIANT] INV-014 armmmkr packed at (4320, 336) with no turret slot within 450
- forbid 'invariant' hit at 39.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 18 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 40.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 16 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-060 air defence cluster #18 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 27587 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 12104 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 26708 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 40.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 20 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 40.8 min: [INVARIANT] INV-014 armmmkr packed at (4224, 352) with no turret slot within 450
- forbid 'invariant' hit at 40.8 min: [INVARIANT] INV-014 legadveconv packed at (1536, 10080) with no turret slot within 450
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 30331 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 16023 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 41.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 21 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-060 air defence cluster #18 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.8 min: [INVARIANT] INV-060 kill zone cluster #1 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.8 min: [INVARIANT] INV-014 legadveconv packed at (1344, 10032) with no turret slot within 450
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-048 spam cluster 1's turret 24074 is not working for its lab 16911 (task type 15, target 20149, unit task type 6, last focus on lab 16911)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-048 spam cluster 1's turret 28157 is not working for its lab 16911 (task type 15, target 20149, unit task type 6, last focus on lab 16911)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-048 spam cluster 2's turret 22885 is not working for its lab 7386 (task type 15, target 1237, unit task type 6, last focus on lab 7386)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-048 spam cluster 2's turret 11784 is not working for its lab 7386 (task type 15, target 1237, unit task type 6, last focus on lab 7386)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 24937 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 42.1 min: [INVARIANT] INV-035 dedicated 24937 (armmmkr) holds armflak
- forbid 'invariant' hit at 42.3 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added
- forbid 'invariant' hit at 42.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 3309 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 13566 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 9112 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.8 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 26326 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 12267 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 43.8 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 1 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 17883 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.8 min: [INVARIANT] INV-060 kill zone cluster #1 has 6 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-022 a new set of legadveconv starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 45.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 1

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glitters\runs\20261003T184124Z-3c4dc7ca\screen_2026-10-03_18-35-45-964.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glitters\runs\20261003T184124Z-3c4dc7ca\screen_2026-10-03_18-36-17-895.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glitters\runs\20261003T184124Z-3c4dc7ca\screen_2026-10-03_18-36-38-375.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glitters\runs\20261003T184124Z-3c4dc7ca\screen_2026-10-03_18-37-40-113.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glitters\runs\20261003T184124Z-3c4dc7ca\screen_2026-10-03_18-39-56-189.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 45.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2801, 775) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2801, 775) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=6/61 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=995 E=0 bank=934 pull=61 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=35/352
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2832, 746), 55 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2790|783|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(4211,611) factory=armlab landLocked=no spot=2 known=1/1
  0.17  [Team][Roster] team 1 first mex at 4256,480
  0.17  [Playtest] finished armmex team 0 at 0.17 min
  0.18  [AIR][Rule] opening.mex builder=2274
  0.18  [Team][Roster] first mex 19579 at 2688,704
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2790|783|0|1|1|2688|704
  0.27  [AIR][Capacity] own=2/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=953 E=18 bank=497 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=13/138
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.43  [Playtest] finished armmex team 0 at 0.43 min
  0.43  [AIR][Capacity] own=3/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP RECOVERY M=3 bank=939 E=30 bank=90 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.44  [AIR][Rule] recovery.energy builder=2274
  0.60  [Playtest] finished armsolar team 0 at 0.60 min
  0.60  [AIR][Capacity] own=6/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=866 E=30 bank=301 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.76  [Playtest] finished armsolar team 0 at 0.76 min
  0.77  [AIR][Capacity] own=7/40 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=786 E=48 bank=696 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.92  [Playtest] finished armsolar team 0 at 0.92 min
  0.93  [AIR][Claim] cancel unowned native order armmakr
  0.93  [AIR][Capacity] own=7/60 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=698 E=68 bank=1126 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.93  [AIR][Wind] cluster=0 slots=6 at=2584,576 local=false builder=2274
  0.93  [AIR][Rule] opening.energy builder=2274
  1.00  [Playtest] eco team 0 at 1.0 min: metal +7.5 bank 730/1150, energy +90.0 bank 1150/1150, units 7
  1.10  [AIR][Capacity] own=7/90 usage=7/41 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=750 E=90 bank=1145 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=14/63
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.13  [Playtest] finished armwin team 0 at 1.13 min
  1.14  [AIR][Starter] nearby distance=128
  1.14  [AIR][Rule] opening.plant builder=2274
  1.15  [AIR][EcoLayout] reserved air.eco.0 reactor=1888,400 converters=8 support=12 zone=1166
  1.17  [AIR][EcoLayout] reserved air.eco.1 reactor=1632,912 converters=8 support=12 zone=1189
  1.18  [AIR][EcoLayout] reserved air.eco.2 reactor=1248,400 converters=8 support=12 zone=1214
  1.20  [AIR][EcoLayout] reserved air.eco.3 reactor=4064,1424 converters=8 support=12 zone=1254
  1.27  [AIR][Capacity] own=7/90 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=592 E=90 bank=1119 pull=69 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=404/684
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=14169 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.43  [AIR][Capacity] own=7/105 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=309 E=105 bank=1123 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=46/78
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=14169 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.45  [Playtest] finished armap team 0 at 1.45 min
  1.47  [AIR][Claim] cancel unowned native order armnanotc
  1.47  [AIR][Claim] cancel unowned native order armnanotc
  1.47  [AIR][State] T1_CONTEST
  1.47  [AIR][Produce] opening.scout armpeep plant=14169 projected=1/1
  1.47  [AIR][Rule] opening.commander.guard builder=2274
  1.59  [AIR][Produce] constructor.recovery armca plant=14169 projected=1/3
  1.60  [AIR][Capacity] own=7/105 usage=8/249 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_CONTEST M=7 bank=251 E=105 bank=343 pull=249 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=7/105 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=260 E=105 bank=2 pull=134 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  1.91  [AIR][Produce] constructor.recovery armca plant=14169 projected=2/3
  1.91  [AIR][Rule] recovery.energy builder=9205
  1.93  [AIR][Capacity] own=7/102 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=291 E=103 bank=123 pull=9 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=1 committed=155/0
  1.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.5 bank 287/1250, energy +105.0 bank 2/1275, units 13
  2.10  [AIR][Capacity] own=6/104 usage=3/13 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=0 reason=available or arriving power
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=284 E=104 bank=11 pull=120 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=128/0
  2.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=7/98 usage=3/13 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=49 shortage=22 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=281 E=99 bank=20 pull=134 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=98/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=122 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.28  [AIR][Produce] constructor.recovery armca plant=14169 projected=3/3
  2.28  [AIR][Rule] recovery.assist builder=15132
  2.43  [AIR][Capacity] own=5/98 usage=6/8 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=254 E=99 bank=9 pull=155 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=48/0
  2.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.57  [Playtest] finished armsolar team 0 at 2.57 min
  2.58  [AIR][Rule] mex.expand builder=15132
  2.59  [AIR][Rule] intel.radar builder=9205
  2.60  [AIR][Capacity] own=5/105 usage=0/5 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=215 E=105 bank=9 pull=174 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=110/1130
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.62  [AIR][Produce] opening.screen armfig plant=14169 projected=1/6
  2.63  [AIR][Rule] wait builder=19803
  2.64  [AIR][Rule] commander.factory.guard builder=2274
  2.69  [AIR][Rule] project.assist builder=19803
  2.77  [AIR][Capacity] own=5/128 usage=8/206 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=220 E=127 bank=87 pull=318 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=81/835
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.92  [Playtest] finished armrad team 0 at 2.92 min
  2.93  [AIR][Capacity] own=6/137 usage=9/212 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=46 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=191 E=137 bank=19 pull=359 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=28/281
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.93  [AIR][Rule] wait builder=9205
  2.94  [AIR][Produce] opening.screen armfig plant=14169 projected=2/6
  2.94  [AIR][Commander] cleared factory guard for commander.idle.wait
  2.94  [AIR][Rule] commander.idle.wait builder=2274
  2.94  [AIR][Screen] fighters=1 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  2.97  [AIR][Rule] commander.factory.guard builder=2274
  3.00  [Playtest] eco team 0 at 3.0 min: metal +7.5 bank 198/1250, energy +140.8 bank 2/1375, units 18
  3.10  [AIR][Capacity] own=4/140 usage=5/140 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=88 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=205 E=139 bank=6 pull=202 plants=1/0 aircraftDemand=3/127
  3.10  [AIR][Projects] energyQueued=0 committed=8/86
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.12  [AIR][Screen] fighters=1 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  3.16  [Playtest] finished armmex team 0 at 3.16 min
  3.17  [AIR][Rule] mex.expand builder=19803
  3.18  [AIR][Rule] wait builder=15132
  3.27  [AIR][Capacity] own=7/140 usage=3/136 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=243 E=140 bank=12 pull=260 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=49/498
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.28  [AIR][Screen] fighters=1 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  3.30  [AIR][Produce] opening.screen armfig plant=14169 projected=3/6
  3.30  [AIR][Rule] project.assist builder=15132
  3.31  [AIR][Rule] project.assist builder=9205
  3.32  [AIR][Layout] cluster=0 labs=3 at=3390,2967
  3.33  [AIR][Layout] cluster=1 labs=1 at=3198,951
  3.35  [AIR][Layout] cluster=2 labs=1 at=3102,1431
  3.37  [AIR][Layout] cluster=3 labs=1 at=1662,567
  3.38  [AIR][Layout] cluster=4 labs=1 at=2910,1527
  3.43  [AIR][Capacity] own=6/140 usage=4/159 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=45 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=282 E=140 bank=21 pull=349 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=39/399
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Screen] fighters=2 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=7/140 usage=4/141 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=318 E=140 bank=6 pull=288 plants=1/0 aircraftDemand=3/125
  3.60  [AIR][Projects] energyQueued=0 committed=15/154
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=72
  3.63  [AIR][Screen] fighters=2 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  3.65  [AIR][Commander] cleared factory guard for commander.idle.wait
  3.65  [AIR][Rule] commander.idle.wait builder=2274
  3.67  [AIR][Produce] opening.screen armfig plant=14169 projected=4/6
  3.69  [AIR][Rule] commander.factory.guard builder=2274
  3.69  [Playtest] finished armmex team 0 at 3.69 min
  3.71  [AIR][Rule] wait builder=15132
  3.71  [AIR][Rule] wait builder=9205
  3.77  [AIR][Capacity] own=9/140 usage=3/140 gifts=270 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=643 E=140 bank=7 pull=264 plants=1/0 aircraftDemand=3/126
  3.77  [AIR][Projects] energyQueued=0 committed=49/498
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Rule] project.assist builder=15132
  3.77  [AIR][Rule] project.assist builder=9205
  3.80  [AIR][Screen] fighters=3 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=7/140 usage=4/140 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=55 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=687 E=140 bank=5 pull=291 plants=1/0 aircraftDemand=3/126
  3.93  [AIR][Projects] energyQueued=0 committed=36/361
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [AIR][Screen] fighters=3 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.3 bank 703/1350, energy +139.9 bank 0/1375, units 21
  4.08  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.08  [AIR][Rule] commander.idle.wait builder=2274
  4.08  [AIR][Produce] opening.screen armfig plant=14169 projected=5/6
  4.10  [AIR][Capacity] own=7/139 usage=3/83 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=134 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=724 E=139 bank=62 pull=92 plants=1/0 aircraftDemand=3/126
  4.10  [AIR][Projects] energyQueued=0 committed=17/172
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=65
  4.11  [AIR][Rule] commander.factory.guard builder=2274
  4.15  [AIR][Screen] fighters=4 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  4.24  [Playtest] finished armmex team 0 at 4.24 min
  4.25  [AIR][Rule] wait builder=19803
  4.25  [AIR][Rule] wait builder=15132
  4.26  [AIR][Rule] wait builder=9205
  4.27  [AIR][Capacity] own=7/139 usage=3/135 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=766 E=139 bank=0 pull=270 plants=1/0 aircraftDemand=3/126
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.32  [AIR][Screen] fighters=4 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  4.43  [AIR][Capacity] own=11/137 usage=3/140 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=854 E=138 bank=7 pull=183 plants=1/0 aircraftDemand=3/126
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.48  [AIR][Screen] fighters=4 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  4.50  [AIR][Produce] opening.screen armfig plant=14169 projected=6/6
  4.50  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.50  [AIR][Rule] commander.idle.wait builder=2274
  4.53  [AIR][Rule] commander.factory.guard builder=2274
  4.60  [AIR][Capacity] own=11/136 usage=3/143 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=12 bank=949 E=136 bank=1 pull=328 plants=1/0 aircraftDemand=3/126
  4.60  [AIR][Projects] energyQueued=0 committed=0/0
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=59
  4.65  [AIR][Screen] fighters=5 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  4.77  [AIR][Capacity] own=7/136 usage=3/139 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=1026 E=136 bank=5 pull=266 plants=1/0 aircraftDemand=3/126
  4.77  [AIR][Projects] energyQueued=0 committed=0/0
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.82  [AIR][Screen] fighters=5 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  4.92  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.92  [AIR][Rule] commander.idle.wait builder=2274
  4.93  [AIR][Capacity] own=11/134 usage=0/18 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=1120 E=136 bank=214 pull=18 plants=1/0 aircraftDemand=3/126
  4.93  [AIR][Projects] energyQueued=0 committed=0/0
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.00  [AIR][Screen] fighters=6 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +13.0 bank 1183/1400, energy +132.4 bank 775/1375, units 23
  5.00  [Playtest] target team 0 at (2801, 775) from its start position
  5.00  [Playtest] camera requested (2792,640) height=2200
  5.01  [Playtest] camera captured name=ta position=(2792,640) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2792, 640)
  5.07  [AIR][Rule] transition.storage builder=19803
  5.10  [AIR][Capacity] own=13/131 usage=0/18 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST RECOVERY M=12 bank=1250 E=131 bank=1306 pull=18 plants=1/0 aircraftDemand=3/126
  5.10  [AIR][Projects] energyQueued=0 committed=330/570
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=53
  5.17  [AIR][Screen] fighters=6 cells=8 centre=4177,1009 width=600 advance=400 responding=false
  5.17  [AIR][Rule] commander.energy.local builder=2274
  5.20  [AIR][Layout] repaired support air.bay.0 viable=1/5 slot=16749 at=2696,648
  5.20  [AIR][Rule] opening.support builder=15132
  5.20  [AIR][Share] metal 1338 of 1400 (95%): sent 280 to team 1 (0% full); the engine counts 0 metal sent in the last update (D-106)
  5.21  [AIR][Rule] energy.grow builder=9205
  5.23  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 230) (D-106)
  5.27  [AIR][Capacity] own=13/131 usage=13/60 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=350 shortage=90 reason=funded workload
  5.27  [AIR][Economy] T1_CONTEST M=13 bank=1062 E=131 bank=1306 pull=60 plants=1/0 aircraftDemand=3/126
... 5385 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (3819, 469) facing 0, 77x61 cells: 3980 of 4697 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3819, 965) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3819, 917) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3819, 869) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3819, 821) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (4056, 1048) facing 0 (id 63)
  0.08  RESERVE: zone 8 at (3499, 1445) facing 0, 41x45 cells: 1845 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3499, 1797) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3499, 1749) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3499, 1701) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3499, 1653) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (4688, 1520) facing 0 (id 116)
  0.08  RESERVE: zone 9 at (4688, 1448) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (4688, 1472) facing 0: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (4784, 1496) facing 0, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (4688, 1496) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (4688, 1744) facing 0, 10x20 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (1461, 9771) facing 2, 77x61 cells: 4076 of 4697 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9275) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9323) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9371) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9419) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (1704, 9192) facing 2 (id 63)
  0.09  RESERVE: zone 8 at (1461, 8795) facing 2, 41x45 cells: 1811 of 1845 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8443) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8491) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8539) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8587) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (1968, 8720) facing 2 (id 116)
  0.09  RESERVE: zone 9 at (1968, 8792) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (1968, 8768) facing 2: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (2064, 8744) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (1872, 8744) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 12 at (1968, 8744) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (1968, 8496) facing 2, 10x20 cells: 164 of 200 held
  0.17  RESERVE: armlab at (4944, 1536) facing 0 (id 119)
  0.17  RESERVE: zone 12 at (4944, 1464) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (4944, 1488) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (5040, 1512) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (4944, 1512) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (4944, 1760) facing 0, 10x20 cells: 190 of 200 held
  0.17  RESERVE: leglab at (2352, 8736) facing 2 (id 119)
  0.17  RESERVE: zone 13 at (2352, 8808) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (2352, 8784) facing 2: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 14 at (2448, 8760) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: corridor 15 at (2256, 8760) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (2352, 8760) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (2352, 8512) facing 2, 10x20 cells: 180 of 200 held
  0.18  EXP: approach: corcom(24492) at (3450, 9699) walks to (3425, 9681), 139 from the cormex site (3312, 9600)
  0.25  RESERVE: armalab at (5240, 1544) facing 0 (id 122)
  0.25  RESERVE: zone 15 at (5240, 1424) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (5240, 1472) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (5240, 1496) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (5240, 1792) facing 0, 13x20 cells: 257 of 260 held
  0.25  RESERVE: zone 18 at (4592, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4592, 1904) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (4560, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4560, 1904) facing 0 (id 128)
  0.25  RESERVE: zone 20 at (4528, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4528, 1904) facing 0 (id 129)
  0.25  RESERVE: zone 21 at (4496, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4496, 1904) facing 0 (id 130)
  0.25  RESERVE: zone 22 at (4400, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4400, 1904) facing 0 (id 131)
  0.25  RESERVE: zone 23 at (4368, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4368, 1904) facing 0 (id 132)
  0.25  RESERVE: zone 24 at (4048, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4048, 1904) facing 0 (id 133)
  0.25  RESERVE: zone 25 at (4016, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4016, 1904) facing 0 (id 134)
  0.25  RESERVE: zone 26 at (3984, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3984, 1904) facing 0 (id 135)
  0.25  RESERVE: zone 27 at (3952, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3952, 1904) facing 0 (id 136)
  0.25  RESERVE: zone 28 at (3920, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3920, 1904) facing 0 (id 137)
  0.25  RESERVE: zone 29 at (3888, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3888, 1904) facing 0 (id 138)
  0.25  RESERVE: zone 30 at (3856, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3856, 1904) facing 0 (id 139)
  0.25  RESERVE: zone 31 at (3824, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3824, 1904) facing 0 (id 140)
  0.25  RESERVE: zone 32 at (3792, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3792, 1904) facing 0 (id 141)
  0.25  RESERVE: zone 33 at (3760, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3760, 1904) facing 0 (id 142)
  0.25  RESERVE: zone 34 at (3728, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3728, 1904) facing 0 (id 143)
  0.25  RESERVE: zone 35 at (4464, 1792) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (4464, 1792) facing 0 (id 144)
  0.25  RESERVE: zone 36 at (3960, 1800) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (3960, 1800) facing 0 (id 145)
  0.25  RESERVE: legalab at (3016, 8744) facing 2 (id 122)
  0.25  RESERVE: zone 17 at (3016, 8864) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (3016, 8816) facing 2: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 18 at (3016, 8792) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 19 at (3016, 8496) facing 2, 13x20 cells: 252 of 260 held
  0.25  RESERVE: zone 20 at (1456, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1456, 8336) facing 0 (id 127)
  0.25  RESERVE: zone 21 at (1488, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1488, 8336) facing 0 (id 128)
  0.25  RESERVE: zone 22 at (1520, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1520, 8336) facing 0 (id 129)
  0.25  RESERVE: zone 23 at (1552, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1552, 8336) facing 0 (id 130)
  0.25  RESERVE: zone 24 at (1584, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1584, 8336) facing 0 (id 131)
  0.25  RESERVE: zone 25 at (1616, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1616, 8336) facing 0 (id 132)
  0.25  RESERVE: zone 26 at (1648, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1648, 8336) facing 0 (id 133)
  0.25  RESERVE: zone 27 at (1744, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1744, 8336) facing 0 (id 134)
  0.25  RESERVE: zone 28 at (1776, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1776, 8336) facing 0 (id 135)
  0.25  RESERVE: zone 29 at (2096, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2096, 8336) facing 0 (id 136)
  0.25  RESERVE: zone 30 at (2128, 8336) facing 0, 2x2 cells: 4 of 4 held
```
