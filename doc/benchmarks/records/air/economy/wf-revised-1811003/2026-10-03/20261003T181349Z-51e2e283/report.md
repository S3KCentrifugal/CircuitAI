# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54076); wall 323 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:08:23
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\supreme\runs\20261003T181349Z-51e2e283\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 4 turret(s) in range of the reclaim of legwin 21564 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 14.7 min: [INVARIANT] INV-008 4 turret(s) in range of the reclaim of legwin 21564 are not on it
- forbid 'invariant' hit at 15.7 min: [INVARIANT] INV-010 combat unit armfast 18943 produced at +68 metal under the gate 200
- forbid 'invariant' hit at 18.6 min: [INVARIANT] INV-008 5 turret(s) in range of the reclaim of legalab 16408 are not on it
- forbid 'invariant' hit at 20.0 min: [INVARIANT] INV-004 metal floating at 11898 of 11900 for 60 s while legafus is under construction and static build power 1920 is under 2785
- forbid 'invariant' hit at 20.0 min: [INVARIANT] INV-011 metal floating at 11898 of 11900 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 21.0 min: [INVARIANT] INV-004 metal floating at 11897 of 11900 for 60 s while legafus is under construction and static build power 1920 is under 2854
- forbid 'invariant' hit at 21.0 min: [INVARIANT] INV-011 metal floating at 11897 of 11900 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 22.0 min: [INVARIANT] INV-004 metal floating at 11897 of 11900 for 60 s while legafus is under construction and static build power 1920 is under 2998
- forbid 'invariant' hit at 22.0 min: [INVARIANT] INV-011 metal floating at 11897 of 11900 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 22.2 min: [INVARIANT] INV-010 combat unit armfast 28725 produced at +199 metal under the gate 200
- forbid 'invariant' hit at 23.0 min: [INVARIANT] INV-011 metal floating at 11786 of 12200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 25.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-031 the advanced lab 29960 retired while the advanced fusion was funded: bank 6818 + 337/s x 24 s (12% built, build power 11820) = 15009 against 8245 (85% of 9700)
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-008 10 turret(s) in range of the reclaim of armalab 29960 are not on it
- forbid 'invariant' hit at 28.3 min: [t=00:04:46.785089][f=0050885] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-031 the advanced lab 20053 retired while the advanced fusion was funded: bank 11553 + 527/s x 52 s (1% built, build power 6120) = 39482 against 8925 (85% of 10500)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-001 a retiring factory produced legstr 17157
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-060 kill zone cluster #1 has 3 weapons standing and 0 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-008 10 turret(s) in range of the reclaim of legalab 20053 are not on it
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-060 air defence cluster #10 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.0 min: [INVARIANT] INV-060 kill zone cluster #1 has 3 weapons standing and 1 construction turrets (under 4) after 10 minutes

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\supreme\runs\20261003T181349Z-51e2e283\screen_2026-10-03_18-09-35-418.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\supreme\runs\20261003T181349Z-51e2e283\screen_2026-10-03_18-10-36-226.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\supreme\runs\20261003T181349Z-51e2e283\screen_2026-10-03_18-11-28-962.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\supreme\runs\20261003T181349Z-51e2e283\screen_2026-10-03_18-13-47-456.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 40
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 40
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.08  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order legap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 58 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|2176|11787|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(813,10380) factory=armlab landLocked=no spot=1 known=1/1
  0.27  [AIR][Capacity] own=2/30 usage=7/79 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=975 E=18 bank=790 pull=79 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished legmex team 0 at 0.28 min
  0.28  [Team][Roster] first mex 28395 at 2288,11968
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|2176|11787|0|2|1|2288|11968
  0.29  [AIR][Rule] opening.mex builder=23483
  0.30  [Team][Roster] team 1 first mex at 752,10160
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=1001 E=30 bank=965 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=46/465
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.53  [Playtest] finished legmex team 0 at 0.53 min
  0.60  [AIR][Capacity] own=4/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=1002 E=30 bank=736 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=6/30 usage=7/85 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1028 E=30 bank=532 pull=85 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=2/26
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.77  [Playtest] finished legmex team 0 at 0.77 min
  0.78  [AIR][Wind] cluster=0 slots=6 at=2104,11696 local=true builder=23483
  0.78  [AIR][Rule] opening.energy builder=23483
  0.90  [Playtest] finished legwin team 0 at 0.90 min
  0.93  [AIR][Capacity] own=6/30 usage=1/13 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=1062 E=30 bank=523 pull=13 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=43/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1095/1150, energy +35.9 bank 585/1000, units 6
  1.07  [Playtest] finished legwin team 0 at 1.07 min
  1.10  [AIR][Capacity] own=8/35 usage=0/12 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=1108 E=35 bank=627 pull=12 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=1 committed=43/175
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.19  [Playtest] finished legwin team 0 at 1.19 min
  1.27  [AIR][Capacity] own=8/42 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=42 bank=760 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=20/82
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.31  [Playtest] finished legwin team 0 at 1.31 min
  1.43  [AIR][Capacity] own=8/35 usage=7/40 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=42 bank=941 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=16/66
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.47  [Playtest] finished legwin team 0 at 1.47 min
  1.60  [AIR][Capacity] own=8/35 usage=7/40 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=37 bank=939 pull=40 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=8/35
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.62  [Playtest] finished legwin team 0 at 1.62 min
  1.63  [AIR][Wind] cluster=1 slots=6 at=2472,11792 local=false builder=23483
  1.77  [AIR][Capacity] own=8/38 usage=0/9 gifts=0 sent=8 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=40 bank=952 pull=9 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=1 committed=43/175
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [Playtest] finished legwin team 0 at 1.93 min
  1.93  [AIR][Capacity] own=8/69 usage=7/40 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=66 bank=952 pull=40 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=1 committed=43/175
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 1138/1150, energy +109.1 bank 1001/1003, units 12
  2.05  [Playtest] finished legwin team 0 at 2.05 min
  2.07  [AIR][Starter] nearby distance=127
  2.07  [AIR][Rule] opening.plant builder=23483
  2.08  [AIR][Layout] cluster=0 labs=6 at=2728,11427
  2.08  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 support=12 zone=146
  2.10  [AIR][EcoLayout] reserved air.eco.1 reactor=1664,11920 converters=8 support=12 zone=168
  2.10  [AIR][Capacity] own=8/97 usage=0/9 gifts=0 sent=8 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=95 bank=1002 pull=9 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=420/1075
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=3049 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.12  [AIR][EcoLayout] reserved air.eco.2 reactor=2048,11536 converters=8 support=12 zone=191
  2.13  [AIR][EcoLayout] reserved air.eco.3 reactor=3200,11408 converters=8 support=12 zone=217
  2.27  [AIR][Capacity] own=8/127 usage=20/60 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=8 bank=1035 E=123 bank=1004 pull=60 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=218/558
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=3049 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Capacity] own=8/142 usage=20/60 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] BOOTSTRAP M=8 bank=922 E=141 bank=1004 pull=60 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=16/41
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=3049 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.45  [Playtest] finished legap team 0 at 2.45 min
  2.45  [AIR][Claim] cancel unowned native order legnanotc
  2.45  [AIR][State] T1_CONTEST
  2.46  [AIR][Produce] opening.scout legfig plant=3049 projected=1/1
  2.46  [AIR][Rule] opening.commander.guard builder=23483
  2.56  [AIR][Produce] constructor.recovery legca plant=3049 projected=1/3
  2.56  [AIR][Scout] opening drone=5913 enemy starts=2
  2.60  [AIR][Capacity] own=8/172 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=8 bank=933 E=164 bank=1078 pull=50 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=45 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=8/181 usage=1/48 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=8 bank=933 E=181 bank=878 pull=206 plants=1/0 aircraftDemand=2/115
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=45 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+0/1 available=yes firstSlot=0
  2.78  [AIR][Produce] constructor.recovery legca plant=3049 projected=2/3
  2.78  [AIR][Rule] mex.expand builder=8112
  2.93  [AIR][Capacity] own=8/181 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=45 arriving=45 idle=0 ecoStatic=0 working=44 shortage=215 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST M=8 bank=953 E=181 bank=928 pull=207 plants=1/0 aircraftDemand=2/115
  2.93  [AIR][Projects] energyQueued=0 committed=48/487
  2.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=305 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+0/1 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 951/1250, energy +185.8 bank 909/1154, units 17
  3.00  [AIR][Produce] constructor.recovery legca plant=3049 projected=3/3
  3.00  [AIR][Rule] mex.assist builder=31055
  3.10  [AIR][Capacity] own=8/185 usage=1/20 gifts=0 sent=0 excess=0 pressure=true mobile=90 arriving=45 idle=0 ecoStatic=0 working=44 shortage=50 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST M=8 bank=954 E=185 bank=933 pull=218 plants=1/0 aircraftDemand=2/115
  3.10  [AIR][Projects] energyQueued=0 committed=36/367
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=185 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+0/1 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.21  [AIR][Produce] opening.screen legfig plant=3049 projected=2/7
  3.21  [AIR][Layout] repaired support air.bay.6 viable=2/5 slot=214 at=2216,11848
  3.21  [AIR][Rule] opening.support builder=19948
  3.24  [AIR][Commander] cleared factory guard for commander.energy.local
  3.24  [AIR][Rule] commander.energy.local builder=23483
  3.27  [AIR][Capacity] own=8/182 usage=8/280 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=134 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST M=8 bank=951 E=183 bank=805 pull=308 plants=1/0 aircraftDemand=2/115
  3.27  [AIR][Projects] energyQueued=1 committed=285/3485
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+1/2 available=yes firstSlot=2
  3.36  [Playtest] finished legwin team 0 at 3.36 min
  3.38  [Playtest] finished legmex team 0 at 3.38 min
  3.40  [AIR][Rule] opening.support.assist builder=31055
  3.40  [AIR][Rule] opening.support.assist builder=8112
  3.42  [AIR][Layout] cluster=1 labs=1 at=2728,11043
  3.43  [AIR][Capacity] own=8/180 usage=10/163 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=345 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST M=8 bank=919 E=183 bank=818 pull=190 plants=1/0 aircraftDemand=2/115
  3.43  [AIR][Projects] energyQueued=0 committed=230/2967
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+1/2 available=yes firstSlot=2
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Produce] opening.screen legfig plant=3049 projected=3/7
  3.43  [AIR][Screen] fighters=1 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.49  [Playtest] finished legwin team 0 at 3.49 min
  3.50  [AIR][Rule] commander.factory.guard builder=23483
  3.58  [AIR][Produce] opening.screen legfig plant=3049 projected=4/7
  3.60  [AIR][Capacity] own=11/192 usage=0/32 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=134 shortage=266 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST M=11 bank=929 E=192 bank=550 pull=113 plants=1/0 aircraftDemand=3/84
  3.60  [AIR][Projects] energyQueued=0 committed=172/2401
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=401 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+1/2 available=yes firstSlot=2
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.62  [AIR][Screen] fighters=2 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.73  [AIR][Produce] opening.screen legfig plant=3049 projected=4/6
  3.77  [AIR][Capacity] own=4/189 usage=0/47 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=135 shortage=235 reason=funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=920 E=190 bank=187 pull=129 plants=1/0 aircraftDemand=3/84
  3.77  [AIR][Projects] energyQueued=0 committed=122/1706
  3.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=370 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [AIR][Screen] fighters=3 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.93  [AIR][Produce] opening.screen legfig plant=3049 projected=5/6
  3.93  [AIR][Capacity] own=2/190 usage=2/149 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=119 shortage=67 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=883 E=190 bank=4 pull=401 plants=1/0 aircraftDemand=3/84
  3.93  [AIR][Projects] energyQueued=0 committed=81/1128
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=202 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [AIR][Screen] fighters=4 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +6.6 bank 880/1300, energy +222.6 bank 0/1180, units 25
  4.10  [AIR][Capacity] own=4/214 usage=3/153 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=121 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=860 E=207 bank=0 pull=333 plants=1/0 aircraftDemand=3/84
  4.10  [AIR][Projects] energyQueued=0 committed=33/462
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=3049 BP=150 nanos=0+1/0 available=yes firstSlot=2
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.11  [AIR][Produce] opening.screen legfig plant=3049 projected=6/6
  4.15  [AIR][Screen] fighters=5 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.22  [Playtest] finished legnanotc team 0 at 4.22 min
  4.24  [AIR][Rule] recovery.energy builder=31055
  4.24  [AIR][Rule] recovery.energy builder=19948
  4.25  [AIR][Rule] recovery.energy builder=8112
  4.27  [AIR][Capacity] own=3/226 usage=5/231 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=839 E=225 bank=24 pull=338 plants=1/0 aircraftDemand=8/190
  4.27  [AIR][Projects] energyQueued=3 committed=450/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=3049 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.28  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.28  [AIR][Rule] commander.idle.energy builder=23483
  4.33  [AIR][Produce] constructor.expand legca plant=3049 projected=4/4
  4.33  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.35  [AIR][Support] return to production bay=6
  4.43  [AIR][Capacity] own=11/193 usage=23/12 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=45 idle=0 ecoStatic=0 working=435 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=740 E=206 bank=1168 pull=165 plants=1/0 aircraftDemand=8/190
  4.43  [AIR][Projects] energyQueued=0 committed=393/0
  4.43  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=180 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=3049 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.47  [Playtest] finished legsolar team 0 at 4.47 min
  4.49  [AIR][Rule] commander.factory.guard builder=23483
  4.50  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.56  [AIR][Produce] constructor.expand legca plant=3049 projected=5/5
  4.56  [AIR][Rule] energy.grow builder=3968
  4.57  [AIR][Support] return to production bay=6
  4.60  [AIR][Capacity] own=11/177 usage=15/10 gifts=0 sent=0 excess=0 pressure=false mobile=180 arriving=45 idle=0 ecoStatic=0 working=135 shortage=78 reason=funded workload
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=629 E=188 bank=1067 pull=168 plants=1/0 aircraftDemand=8/190
  4.60  [AIR][Projects] energyQueued=0 committed=309/175
  4.60  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=303 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=3049 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.67  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.72  [AIR][Produce] constructor.screen legfig plant=3049 projected=7/7
  4.72  [AIR][Layout] repaired support air.bay.6 viable=3/5 slot=240 at=2248,11752
  4.72  [AIR][Rule] opening.support builder=7882
  4.73  [AIR][Support] return to production bay=6
  4.77  [AIR][Capacity] own=11/167 usage=19/312 gifts=0 sent=0 excess=0 pressure=false mobile=225 arriving=0 idle=0 ecoStatic=0 working=217 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=545 E=169 bank=12 pull=335 plants=1/0 aircraftDemand=8/190
  4.77  [AIR][Projects] energyQueued=0 committed=440/3226
  4.77  [AIR][Workforce] t1=5/5 t2=0/2 targetBP=225 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=3049 BP=350 nanos=1+1/2 available=yes firstSlot=3
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.83  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.92  [AIR][Scout] opening drone=5396 enemy starts=2
  4.92  [AIR][Scout] replacement drone=5396
  4.93  [AIR][Capacity] own=4/164 usage=4/0 gifts=0 sent=0 excess=0 pressure=false mobile=225 arriving=0 idle=0 ecoStatic=0 working=385 shortage=79 reason=funded workload
  4.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=495 E=166 bank=208 pull=80 plants=1/0 aircraftDemand=8/190
  4.93  [AIR][Projects] energyQueued=0 committed=329/2792
  4.93  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=304 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 3870 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: legcom(23483) at (2177, 11788) walks to (2216, 11851), 137 from the legmex site (2288, 11968)
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
  0.08  EXP: approach: armcom(1236) at (814, 10380) walks to (789, 10291), 136 from the armmex site (752, 10160)
  0.09  EXP: approach: corcom(14393) at (10102, 513) walks to (10077, 461), 139 from the cormex site (10016, 336)
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
  0.09  EXP: approach: legcom(28186) at (11479, 1952) walks to (11503, 2016), 137 from the legmex site (11552, 2144)
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
