# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 45.0 min (frame 81000); wall 463 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:27:03
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glacial\runs\20261003T183449Z-5e3c6d45\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=992 E=0 bank=970 pull=83 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 2178 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 4.3 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 2178 are not on it
- forbid 'invariant' hit at 5.4 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1432 (5 by power), bank 0 + 13/s (0 by metal))
- forbid 'invariant' hit at 6.4 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1432 (5 by power), bank 0 + 15/s (0 by metal))
- forbid 'invariant' hit at 15.4 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added
- forbid 'invariant' hit at 18.1 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (12720, 1408) not upgraded
- forbid 'invariant' hit at 22.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.0 min: [t=00:02:42.937279][f=0043219] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-022 a new set of legadveconv starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-053 air constructor 25414 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.3 min: [INVARIANT] INV-019 8 turret frames under construction, 1 allowed (build power 0 (0 by power), bank 2144 + 0/s (0 by metal))
- forbid 'invariant' hit at 28.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 7 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.3 min: [INVARIANT] INV-019 7 turret frames under construction, 1 allowed (build power 0 (0 by power), bank 1787 + 0/s (0 by metal))
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 0 (0 by power), bank 1141 + 13/s (0 by metal))
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-014 legadveconv packed at (12896, 640) with no turret slot within 450
- forbid 'invariant' hit at 30.0 min: [INVARIANT] INV-053 air constructor 18864 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 30.0 min: [INVARIANT] INV-053 air constructor 24273 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 30.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.3 min: [INVARIANT] INV-014 legadveconv packed at (12656, 1792) with no turret slot within 450
- forbid 'invariant' hit at 31.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.4 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 32.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.4 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 32.8 min: [t=00:04:11.489458][f=0059043] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 33.2 min: [INVARIANT] INV-016 the advanced lab 22895 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 33.4 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 2 T2 constructors, none added
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-035 dedicated 12091 (legafus) holds legacluster
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-014 legadveconv packed at (12848, 1584) with no turret slot within 450
- forbid 'invariant' hit at 34.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 16 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-035 dedicated 12091 (legafus) holds legacluster
- forbid 'invariant' hit at 34.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 34.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (6 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 35.1 min: [INVARIANT] INV-014 legadveconv packed at (12928, 1200) with no turret slot within 450
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-035 dedicated 12091 (legafus) holds legacluster
- forbid 'invariant' hit at 35.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 35.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 18 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-035 dedicated 12091 (legafus) holds legacluster
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-001 a retiring factory produced legstr 14173
- forbid 'invariant' hit at 36.8 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 37.1 min: [INVARIANT] INV-014 legadveconv packed at (12912, 1280) with no turret slot within 450
- forbid 'invariant' hit at 37.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 19 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 37.8 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-014 legadveconv packed at (12880, 1136) with no turret slot within 450
- forbid 'invariant' hit at 38.8 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 38.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 21 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-014 legadveconv packed at (13008, 1344) with no turret slot within 450
- forbid 'invariant' hit at 39.8 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-060 air defence cluster #10 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 5 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.9 min: [INVARIANT] INV-060 air defence cluster #10 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 5 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 40.9 min: [INVARIANT] INV-060 kill zone cluster #2 has 6 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 24273 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 5375 has done nothing for 60 s (task type 2, last rule mex.upgrade)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 17637 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 14017 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 19238 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 28368 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 2867 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.9 min: [INVARIANT] INV-060 air defence cluster #10 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 5 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 41.9 min: [INVARIANT] INV-060 kill zone cluster #2 has 7 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 26769 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 18864 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 42.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 6472 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.9 min: [INVARIANT] INV-060 air defence cluster #10 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 42.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 5 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 42.9 min: [INVARIANT] INV-060 kill zone cluster #2 has 7 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 43.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 43.4 min: [INVARIANT] INV-060 artillery cluster #13 has 3 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 43.4 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (10 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 3667 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 11967 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.9 min: [INVARIANT] INV-060 air defence cluster #10 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 43.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 5 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 43.9 min: [INVARIANT] INV-060 kill zone cluster #2 has 7 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-014 legadveconv packed at (11856, 2208) with no turret slot within 450
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 27230 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 44.4 min: [INVARIANT] INV-060 artillery cluster #13 has 3 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 4191 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 4741 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 5375 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 44.9 min: [INVARIANT] INV-060 air defence cluster #10 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 44.9 min: [INVARIANT] INV-060 kill zone cluster #1 has 5 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 44.9 min: [INVARIANT] INV-060 kill zone cluster #2 has 7 weapons standing and 3 construction turrets (under 4) after 10 minutes

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glacial\runs\20261003T183449Z-5e3c6d45\screen_2026-10-03_18-28-14-083.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glacial\runs\20261003T183449Z-5e3c6d45\screen_2026-10-03_18-28-55-790.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glacial\runs\20261003T183449Z-5e3c6d45\screen_2026-10-03_18-29-20-030.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glacial\runs\20261003T183449Z-5e3c6d45\screen_2026-10-03_18-30-47-847.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\glacial\runs\20261003T183449Z-5e3c6d45\screen_2026-10-03_18-33-02-770.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 45.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=992 E=0 bank=970 pull=83 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=33/336
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(1846,1406) factory=armlab landLocked=no spot=1 known=1/1
  0.18  [Playtest] finished armmex team 0 at 0.18 min
  0.20  [AIR][Rule] opening.mex builder=2274
  0.20  [Team][Roster] first mex 12607 at 496,1296
  0.20  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|496|1296
  0.22  [Team][Roster] team 1 first mex at 1952,1408
  0.27  [AIR][Capacity] own=2/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=966 E=18 bank=663 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=22/222
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.31  [Playtest] finished armmex team 0 at 0.31 min
  0.43  [AIR][Capacity] own=3/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=956 E=30 bank=269 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=9/97
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.45  [Playtest] finished armmex team 0 at 0.45 min
  0.47  [AIR][Rule] recovery.energy builder=2274
  0.60  [AIR][Capacity] own=5/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=899 E=30 bank=379 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=22/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.62  [Playtest] finished armsolar team 0 at 0.62 min
  0.77  [AIR][Capacity] own=7/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=824 E=30 bank=769 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=22/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.79  [Playtest] finished armsolar team 0 at 0.79 min
  0.80  [AIR][Wind] cluster=0 slots=6 at=352,1272 local=false builder=2274
  0.80  [AIR][Rule] opening.energy builder=2274
  0.93  [AIR][Capacity] own=7/50 usage=7/41 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=854 E=50 bank=1058 pull=41 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=22/96
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.98  [Playtest] finished armwin team 0 at 0.98 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 864/1150, energy +70.0 bank 1100/1100, units 7
  1.10  [Playtest] finished armwin team 0 at 1.10 min
  1.10  [AIR][Capacity] own=7/70 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=871 E=70 bank=1045 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.21  [Playtest] finished armwin team 0 at 1.21 min
  1.27  [AIR][Capacity] own=7/78 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=897 E=80 bank=1097 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=25/111
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.32  [Playtest] finished armwin team 0 at 1.32 min
  1.33  [AIR][Starter] nearby distance=127
  1.33  [AIR][Rule] opening.plant builder=2274
  1.35  [AIR][Layout] cluster=0 labs=6 at=562,1113
  1.35  [AIR][EcoLayout] reserved air.eco.0 reactor=352,1776 converters=8 support=12 zone=140
  1.37  [AIR][EcoLayout] reserved air.eco.1 reactor=736,2288 converters=8 support=12 zone=165
  1.38  [AIR][EcoLayout] reserved air.eco.2 reactor=736,1392 converters=8 support=12 zone=187
  1.40  [AIR][EcoLayout] reserved air.eco.3 reactor=352,2672 converters=8 support=12 zone=209
  1.43  [AIR][Capacity] own=7/72 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=787 E=78 bank=1058 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=457/775
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=17770 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Capacity] own=7/75 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=509 E=75 bank=1046 pull=69 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=100/169
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=17770 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.65  [Playtest] finished armap team 0 at 1.65 min
  1.65  [AIR][Claim] cancel unowned native order armnanotc
  1.65  [AIR][Claim] cancel unowned native order armnanotc
  1.65  [AIR][State] T1_CONTEST
  1.66  [AIR][Produce] opening.scout armpeep plant=17770 projected=1/1
  1.66  [AIR][Rule] opening.commander.guard builder=2274
  1.77  [AIR][Capacity] own=7/71 usage=8/258 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=7 bank=416 E=73 bank=273 pull=258 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.79  [AIR][Produce] constructor.recovery armca plant=17770 projected=1/3
  1.93  [AIR][Capacity] own=6/82 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=440 E=81 bank=1 pull=153 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 450/1250, energy +115.8 bank 0/1202, units 13
  2.10  [AIR][Capacity] own=6/108 usage=0/17 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=459 E=101 bank=1 pull=134 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.13  [AIR][Produce] constructor.recovery armca plant=17770 projected=2/3
  2.13  [AIR][Rule] recovery.energy builder=1646
  2.27  [AIR][Capacity] own=7/125 usage=3/19 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=49 shortage=60 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=468 E=121 bank=389 pull=153 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=139/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=160 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.38  [AIR][Produce] constructor.recovery armca plant=17770 projected=3/3
  2.38  [AIR][Rule] recovery.energy builder=10732
  2.43  [AIR][Capacity] own=7/150 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=49 shortage=103 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=446 E=149 bank=1252 pull=139 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=1 committed=264/0
  2.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=253 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=7/155 usage=9/86 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=376 E=154 bank=1239 pull=199 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=208/0
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.60  [AIR][Produce] opening.screen armfig plant=17770 projected=1/6
  2.60  [AIR][Rule] mex.expand builder=6893
  2.64  [AIR][Commander] cleared factory guard for commander.energy.local
  2.64  [AIR][Rule] commander.energy.local builder=2274
  2.75  [Playtest] finished armwin team 0 at 2.75 min
  2.76  [AIR][Rule] commander.factory.guard builder=2274
  2.77  [AIR][Capacity] own=7/158 usage=16/174 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=7 bank=309 E=156 bank=1264 pull=174 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=187/388
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.86  [AIR][Produce] opening.screen armfig plant=17770 projected=2/6
  2.86  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.86  [AIR][Rule] commander.idle.assist builder=2274
  2.86  [AIR][Screen] fighters=1 cells=8 centre=2246,1405 width=600 advance=400 responding=false
  2.88  [AIR][Rule] commander.factory.guard builder=2274
  2.93  [AIR][Capacity] own=7/179 usage=13/279 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST M=7 bank=263 E=172 bank=1264 pull=279 plants=1/0 aircraftDemand=3/127
  2.93  [AIR][Projects] energyQueued=0 committed=113/249
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 220/1250, energy +179.9 bank 267/1277, units 21
  3.03  [AIR][Screen] fighters=1 cells=8 centre=2246,1405 width=600 advance=400 responding=false
  3.05  [Playtest] finished armsolar team 0 at 3.05 min
  3.05  [AIR][Produce] opening.screen armfig plant=17770 projected=3/6
  3.06  [AIR][Rule] recovery.assist builder=1646
  3.10  [AIR][Capacity] own=4/179 usage=12/209 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=204 E=179 bank=202 pull=209 plants=1/0 aircraftDemand=3/127
  3.10  [AIR][Projects] energyQueued=0 committed=43/112
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.18  [AIR][Layout] cluster=1 labs=3 at=1714,2649
  3.19  [Playtest] finished armsolar team 0 at 3.19 min
  3.20  [AIR][Screen] fighters=2 cells=8 centre=2246,1405 width=600 advance=400 responding=false
  3.21  [AIR][Rule] intel.radar builder=10732
  3.21  [AIR][Rule] wait builder=1646
  3.24  [Playtest] finished armmex team 0 at 3.24 min
  3.27  [AIR][Capacity] own=5/199 usage=7/221 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=46 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=176 E=195 bank=4 pull=295 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=103/1062
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Rule] project.assist builder=1646
  3.33  [AIR][Produce] opening.screen armfig plant=17770 projected=4/6
  3.37  [AIR][Screen] fighters=3 cells=8 centre=2246,1405 width=600 advance=400 responding=false
  3.43  [AIR][Capacity] own=5/219 usage=8/222 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=89 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=189 E=217 bank=0 pull=424 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=62/628
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.50  [Playtest] finished armrad team 0 at 3.50 min
  3.51  [AIR][Rule] project.assist builder=10732
  3.53  [AIR][Screen] fighters=3 cells=8 centre=2246,1405 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=3/219 usage=6/224 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=186 E=219 bank=4 pull=299 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=37/378
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.60  [AIR][Produce] opening.screen armfig plant=17770 projected=5/6
  3.72  [AIR][Screen] fighters=4 cells=8 centre=2246,1405 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=6/216 usage=8/216 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=141 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=207 E=217 bank=4 pull=302 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=8/84
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [Playtest] finished armmex team 0 at 3.80 min
  3.81  [AIR][Rule] mex.expand builder=10732
  3.82  [AIR][Rule] wait builder=1646
  3.82  [AIR][Rule] wait builder=6893
  3.86  [AIR][Commander] cleared factory guard for commander.idle.wait
  3.86  [AIR][Rule] commander.idle.wait builder=2274
  3.87  [AIR][Produce] opening.screen armfig plant=17770 projected=6/6
  3.88  [AIR][Rule] project.assist builder=1646
  3.89  [AIR][Rule] project.assist builder=6893
  3.89  [AIR][Rule] commander.factory.guard builder=2274
  3.92  [AIR][Screen] fighters=5 cells=8 centre=2246,1405 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=9/216 usage=2/82 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=60 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=271 E=216 bank=575 pull=82 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=43/434
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=210 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 277/1350, energy +219.8 bank 0/1377, units 28
  4.08  [AIR][Screen] fighters=5 cells=8 centre=2246,1405 width=600 advance=400 responding=false
  4.10  [AIR][Capacity] own=5/218 usage=6/220 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=68 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=291 E=218 bank=6 pull=336 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=17/175
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.18  [Playtest] finished armmex team 0 at 4.18 min
  4.19  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.19  [AIR][Rule] commander.idle.wait builder=2274
  4.19  [AIR][Rule] wait builder=10732
  4.20  [AIR][Rule] wait builder=1646
  4.20  [AIR][Rule] wait builder=6893
  4.27  [AIR][Capacity] own=5/219 usage=0/18 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=384 E=219 bank=1308 pull=18 plants=1/0 aircraftDemand=3/126
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Screen] fighters=6 cells=8 centre=2246,1405 width=600 advance=400 responding=false
  4.37  [AIR][Rule] commander.idle.energy builder=2274
  4.38  [AIR][Produce] air.control armfig plant=17770 projected=7/7
  4.38  [AIR][Layout] repaired support air.bay.6 viable=4/5 slot=274 at=424,984
  4.38  [AIR][Rule] opening.support builder=10732
  4.38  [AIR][Wind] cluster=1 slots=6 at=592,1512 local=false builder=1646
  4.38  [AIR][Rule] energy.grow builder=1646
... 4794 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(2274) at (490, 1137) walks to (491, 1160), 136 from the armmex site (496, 1296)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (1688, 1784) facing 1, 63x77 cells: 4530 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2184, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2136, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2088, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2040, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (2264, 1544) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (2536, 1464) facing 1, 29x41 cells: 1116 of 1189 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2760, 1464) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2712, 1464) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2664, 1464) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2616, 1464) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (4080, 1264) facing 1 (id 106)
  0.08  RESERVE: zone 9 at (4008, 1264) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (4032, 1264) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (4368, 1440) facing 1 (id 109)
  0.08  RESERVE: zone 10 at (4296, 1440) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (4320, 1440) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: corridor 11 at (4344, 1536) facing 1, 21x6 cells: 126 of 126 held
  0.08  RESERVE: zone 12 at (4344, 1440) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 12 at (4592, 1440) facing 1, 20x10 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.09  RESERVE: zone 7 at (12757, 1112) facing 3, 63x77 cells: 4568 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12261, 1112) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12309, 1112) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12357, 1112) facing 3: 12 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12405, 1112) facing 3: 12 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (12184, 1352) facing 3 (id 61)
  0.09  RESERVE: zone 8 at (11845, 1432) facing 3, 37x41 cells: 1410 of 1517 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11557, 1432) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11605, 1432) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11653, 1432) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11701, 1432) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (10320, 1136) facing 3 (id 114)
  0.09  RESERVE: zone 9 at (10392, 1136) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10368, 1136) facing 3: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (10344, 1040) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (10344, 1232) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: zone 12 at (10344, 1136) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (10096, 1136) facing 3, 20x10 cells: 180 of 200 held
  0.10  EXP: idle: armcom(2274) on armmex at (490, 1150), site (496, 1296), target yes, fails 2 (arrived at the approach point)
  0.17  RESERVE: armlab at (4416, 1200) facing 1 (id 112)
  0.17  RESERVE: zone 13 at (4344, 1200) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (4368, 1200) facing 1: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 14 at (4392, 1296) facing 1, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (4392, 1200) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (4640, 1200) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: leglab at (10048, 1440) facing 3 (id 117)
  0.17  RESERVE: zone 13 at (10120, 1440) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (10096, 1440) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 14 at (10072, 1344) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (10072, 1440) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (9824, 1440) facing 3, 20x10 cells: 190 of 200 held
  0.20  EXP: approach: armcom(2274) at (490, 1150) walks to (472, 1148), 136 from the armmex site (336, 1136)
  0.22  EXP: approach: corcom(24492) at (13994, 1034) walks to (13970, 1025), 139 from the cormex site (13840, 976)
  0.23  EXP: approach: armcom(1901) at (1883, 1405) walks to (1774, 1113), 136 from the armmex site (1792, 1248)
  0.25  RESERVE: armalab at (3512, 2760) facing 1 (id 115)
  0.25  RESERVE: zone 16 at (3392, 2760) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3440, 2760) facing 1: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 17 at (3464, 2760) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (3760, 2760) facing 1, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (3136, 928) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 928) facing 0 (id 120)
  0.25  RESERVE: zone 20 at (3136, 960) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 960) facing 0 (id 121)
  0.25  RESERVE: zone 21 at (3136, 992) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 992) facing 0 (id 122)
  0.25  RESERVE: zone 22 at (3136, 1024) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1024) facing 0 (id 123)
  0.25  RESERVE: zone 23 at (3136, 1056) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1056) facing 0 (id 124)
  0.25  RESERVE: zone 24 at (3136, 1088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1088) facing 0 (id 125)
  0.25  RESERVE: zone 25 at (3136, 1120) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1120) facing 0 (id 126)
  0.25  RESERVE: zone 26 at (3136, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1152) facing 0 (id 127)
  0.25  RESERVE: zone 27 at (3136, 1184) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1184) facing 0 (id 128)
  0.25  RESERVE: zone 28 at (3136, 1216) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1216) facing 0 (id 129)
  0.25  RESERVE: zone 29 at (3136, 1248) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1248) facing 0 (id 130)
  0.25  RESERVE: zone 30 at (3136, 1568) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1568) facing 0 (id 131)
  0.25  RESERVE: zone 31 at (3136, 1600) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1600) facing 0 (id 132)
  0.25  RESERVE: zone 32 at (3136, 1632) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1632) facing 0 (id 133)
  0.25  RESERVE: zone 33 at (3136, 1664) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1664) facing 0 (id 134)
  0.25  RESERVE: zone 34 at (3136, 1696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1696) facing 0 (id 135)
  0.25  RESERVE: zone 35 at (3136, 1728) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1728) facing 0 (id 136)
  0.25  RESERVE: zone 36 at (3136, 1760) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1760) facing 0 (id 137)
  0.25  RESERVE: zone 37 at (3136, 1792) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1792) facing 0 (id 138)
  0.25  RESERVE: zone 38 at (3136, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1824) facing 0 (id 139)
  0.25  RESERVE: zone 39 at (3136, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1856) facing 0 (id 140)
  0.25  RESERVE: zone 40 at (3136, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1888) facing 0 (id 141)
  0.25  RESERVE: zone 41 at (3024, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (3024, 1152) facing 0 (id 142)
  0.25  RESERVE: legalab at (11224, 2712) facing 3 (id 120)
  0.25  RESERVE: zone 16 at (11344, 2712) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (11296, 2712) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 17 at (11272, 2712) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (10976, 2712) facing 3, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (11328, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1888) facing 0 (id 125)
  0.25  RESERVE: zone 20 at (11328, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1856) facing 0 (id 126)
  0.25  RESERVE: zone 21 at (11328, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1824) facing 0 (id 127)
  0.25  RESERVE: zone 22 at (11328, 1792) facing 0, 2x2 cells: 4 of 4 held
```
