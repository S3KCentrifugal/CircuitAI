# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54012); wall 349 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:07:10
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\supreme\runs\20261003T181303Z-23f19131\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-021 a fusion frame started with a T1 mex at (11632, 1680) not upgraded` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 11.7 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (11632, 1680) not upgraded
- forbid 'invariant' hit at 15.6 min: [INVARIANT] INV-010 combat unit legstr 14200 produced at +118 metal under the gate 200
- forbid 'invariant' hit at 16.2 min: [INVARIANT] INV-004 metal floating at 7928 of 7950 for 60 s while legafus is under construction and static build power 0 is under 2264
- forbid 'invariant' hit at 17.6 min: [INVARIANT] INV-004 metal floating at 10948 of 10950 for 60 s while armafus is under construction and static build power 240 is under 2263
- forbid 'invariant' hit at 18.2 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of legwin 24302 are not on it
- forbid 'invariant' hit at 19.8 min: [t=00:02:59.926317][f=0035607] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 19.9 min: [INVARIANT] INV-004 metal floating at 7948 of 7950 for 60 s while legadveconv is under construction and static build power 240 is under 3150
- forbid 'invariant' hit at 20.9 min: [INVARIANT] INV-004 metal floating at 7946 of 7950 for 60 s while legadveconv is under construction and static build power 240 is under 3202
- forbid 'invariant' hit at 21.0 min: [INVARIANT] INV-010 combat unit armfast 31743 produced at +132 metal under the gate 200
- forbid 'invariant' hit at 23.2 min: [t=00:03:44.153381][f=0041776] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 23.7 min: [INVARIANT] INV-022 a new set of legadveconv starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-004 metal floating at 10346 of 10350 for 60 s while armafus is under construction and static build power 1200 is under 3995
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-011 metal floating at 10346 of 10350 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 26.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.7 min: [INVARIANT] INV-039 T1 land constructors released 180 s, 0 spam labs of 2 wanted, no forward order for 180 s
- forbid 'invariant' hit at 26.7 min: [INVARIANT] INV-010 combat unit legstr 25160 produced at +197 metal under the gate 200
- forbid 'invariant' hit at 27.4 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 2449 elmos away, not flush (160)
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-004 metal floating at 10349 of 10350 for 60 s while armnanotc is under construction and static build power 0 is under 4823
- forbid 'invariant' hit at 28.4 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 2317 elmos away, not flush (160)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 450 (1 by power), bank 10347 + 241/s (8 by metal))
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-004 metal floating at 10347 of 10350 for 60 s while armnanotc is under construction and static build power 0 is under 4823
- forbid 'invariant' hit at 29.4 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 688 elmos away, not flush (160)
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (4 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-004 metal floating at 10347 of 10350 for 60 s while armnanotc is under construction and static build power 480 is under 4823

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\supreme\runs\20261003T181303Z-23f19131\screen_2026-10-03_18-08-23-043.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\supreme\runs\20261003T181303Z-23f19131\screen_2026-10-03_18-09-23-251.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\supreme\runs\20261003T181303Z-23f19131\screen_2026-10-03_18-10-17-097.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\supreme\runs\20261003T181303Z-23f19131\screen_2026-10-03_18-13-01-519.png

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
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order legap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 58 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|2176|11787|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(813,10380) factory=armlab landLocked=no spot=1 known=1/1
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=975 E=18 bank=790 pull=79 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=328 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished legmex team 0 at 0.28 min
  0.28  [Team][Roster] first mex 28395 at 2288,11968
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|2176|11787|0|2|1|2288|11968
  0.29  [AIR][Rule] opening.mex builder=23483
  0.30  [Team][Roster] team 1 first mex at 752,10160
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=1001 E=30 bank=935 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=42/425
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=368 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.52  [Playtest] finished legmex team 0 at 0.52 min
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=1003 E=30 bank=735 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=426 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.76  [Playtest] finished legmex team 0 at 0.75 min
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1021 E=30 bank=468 pull=85 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=520 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.77  [AIR][Wind] cluster=0 slots=6 at=2104,11696 local=true builder=23483
  0.77  [AIR][Rule] opening.energy builder=23483
  0.88  [Playtest] finished legwin team 0 at 0.88 min
  0.93  [AIR][Economy] BOOTSTRAP M=8 bank=1066 E=30 bank=549 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=43/175
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=615 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1087/1150, energy +49.0 bank 636/1000, units 6
  1.04  [Playtest] finished legwin team 0 at 1.04 min
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=1104 E=46 bank=772 pull=40 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=27/113
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=638 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.16  [Playtest] finished legwin team 0 at 1.16 min
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1127 E=62 bank=956 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=4/19
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=652 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.28  [Playtest] finished legwin team 0 at 1.28 min
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=68 bank=936 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=4/19
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=658 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.44  [Playtest] finished legwin team 0 at 1.44 min
  1.57  [Playtest] finished legwin team 0 at 1.57 min
  1.58  [AIR][Starter] nearby distance=127
  1.58  [AIR][Rule] opening.plant builder=23483
  1.58  [AIR][Layout] cluster=0 labs=6 at=2728,11427
  1.58  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 zone=128
  1.60  [AIR][EcoLayout] reserved air.eco.1 reactor=1536,11920 converters=8 zone=138
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=94 bank=952 pull=12 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=430/1100
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=658 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.62  [AIR][EcoLayout] reserved air.eco.2 reactor=3200,11408 converters=8 zone=151
  1.63  [AIR][EcoLayout] reserved air.eco.3 reactor=3712,11152 converters=8 zone=162
  1.77  [AIR][Economy] BOOTSTRAP M=8 bank=1036 E=138 bank=992 pull=60 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=228/584
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=597 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=16943 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.93  [AIR][Economy] BOOTSTRAP M=8 bank=923 E=141 bank=997 pull=60 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=26/67
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=529 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=16943 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.95  [Playtest] finished legap team 0 at 1.95 min
  1.97  [AIR][Claim] cancel unowned native order legnanotc
  1.97  [AIR][State] T1_CONTEST
  1.97  [AIR][Produce] opening.scout legfig plant=16943 projected=1/1
  1.97  [AIR][Rule] opening.commander.guard builder=23483
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 914/1250, energy +143.7 bank 970/1103, units 12
  2.07  [AIR][Produce] constructor.recovery legca plant=16943 projected=1/3
  2.07  [AIR][Scout] opening drone=583 enemy starts=2
  2.10  [AIR][Economy] T1_CONTEST M=8 bank=926 E=140 bank=702 pull=9 plants=1/0 aircraftDemand=2/115
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=934 E=104 bank=8 pull=206 plants=1/0 aircraftDemand=2/115
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=202 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.34  [AIR][Produce] constructor.recovery legca plant=16943 projected=2/3
  2.34  [AIR][Rule] recovery.energy builder=1489
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=952 E=101 bank=87 pull=165 plants=1/0 aircraftDemand=2/115
  2.43  [AIR][Projects] energyQueued=0 committed=146/0
  2.43  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=326 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=910 E=121 bank=11 pull=162 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=122/0
  2.60  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=70 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.64  [AIR][Produce] constructor.recovery legca plant=16943 projected=3/3
  2.64  [AIR][Rule] recovery.energy builder=5913
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=905 E=135 bank=508 pull=167 plants=1/0 aircraftDemand=2/115
  2.77  [AIR][Projects] energyQueued=0 committed=239/0
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=108 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.91  [AIR][Produce] opening.screen legfig plant=16943 projected=2/7
  2.92  [AIR][Rule] recovery.energy builder=16408
  2.93  [AIR][Economy] T1_CONTEST M=8 bank=883 E=152 bank=1074 pull=36 plants=1/0 aircraftDemand=2/115
  2.93  [AIR][Projects] energyQueued=1 committed=341/0
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  2.95  [AIR][Rule] commander.factory.guard builder=23483
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 858/1250, energy +157.5 bank 685/1178, units 19
  3.01  [AIR][Produce] opening.screen legfig plant=16943 projected=3/7
  3.01  [AIR][Screen] fighters=1 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.10  [AIR][Economy] T1_CONTEST M=8 bank=841 E=153 bank=561 pull=369 plants=1/0 aircraftDemand=2/115
  3.10  [AIR][Projects] energyQueued=0 committed=274/0
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=213 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=73
  3.12  [AIR][Produce] opening.screen legfig plant=16943 projected=4/7
  3.20  [AIR][Screen] fighters=2 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.26  [AIR][Produce] opening.screen legfig plant=16943 projected=4/6
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=786 E=151 bank=12 pull=305 plants=1/0 aircraftDemand=3/91
  3.27  [AIR][Projects] energyQueued=0 committed=202/0
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=130 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.37  [AIR][Screen] fighters=3 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.42  [AIR][Layout] cluster=1 labs=1 at=2344,11715
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=734 E=151 bank=12 pull=305 plants=1/0 aircraftDemand=3/91
  3.43  [AIR][Projects] energyQueued=0 committed=129/0
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=86 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.44  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.44  [AIR][Rule] commander.idle.assist builder=23483
  3.44  [AIR][Produce] opening.screen legfig plant=16943 projected=5/6
  3.45  [Playtest] finished legsolar team 0 at 3.45 min
  3.46  [AIR][Rule] commander.factory.guard builder=23483
  3.55  [AIR][Screen] fighters=4 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.59  [AIR][Produce] opening.screen legfig plant=16943 projected=6/6
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=698 E=152 bank=153 pull=109 plants=1/0 aircraftDemand=3/91
  3.60  [AIR][Projects] energyQueued=0 committed=211/0
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=108 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=66
  3.73  [AIR][Screen] fighters=5 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.75  [Playtest] finished legsolar team 0 at 3.75 min
  3.75  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.75  [AIR][Rule] commander.idle.assist builder=23483
  3.76  [AIR][Rule] recovery.assist builder=5913
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=648 E=176 bank=298 pull=9 plants=1/0 aircraftDemand=3/87
  3.77  [AIR][Projects] energyQueued=0 committed=142/0
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=81 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.89  [Playtest] finished legsolar team 0 at 3.89 min
  3.91  [AIR][Rule] mex.expand builder=16408
  3.91  [AIR][Rule] intel.radar builder=5913
  3.92  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=619 E=196 bank=1269 pull=9 plants=1/0 aircraftDemand=3/87
  3.93  [AIR][Projects] energyQueued=0 committed=129/1130
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=141 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.98  [AIR][Layout] repaired support air.bay.6 viable=1/5 slot=185 at=1800,11640
  3.99  [Playtest] finished legsolar team 0 at 3.99 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.9 bank 626/1250, energy +219.0 bank 1375/1378, units 25
  4.00  [AIR][Rule] commander.local.assist builder=23483
  4.00  [AIR][Wind] cluster=1 slots=6 at=2104,12064 local=false builder=1489
  4.00  [AIR][Rule] energy.grow builder=1489
  4.05  [Playtest] finished legrad team 0 at 4.05 min
  4.07  [AIR][Rule] commander.idle.assist builder=23483
  4.07  [AIR][Rule] mex.assist builder=5913
  4.08  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.10  [AIR][Economy] T1_CONTEST M=8 bank=612 E=216 bank=1378 pull=25 plants=1/0 aircraftDemand=3/87
  4.10  [AIR][Projects] energyQueued=0 committed=83/614
  4.10  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=60
  4.17  [AIR][Layout] repaired support air.bay.6 viable=2/5 slot=194 at=1944,11608
  4.19  [Playtest] finished legwin team 0 at 4.19 min
  4.21  [AIR][Rule] commander.energy.local builder=23483
  4.25  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.27  [AIR][Economy] T1_CONTEST M=8 bank=630 E=226 bank=1378 pull=68 plants=1/0 aircraftDemand=3/87
  4.27  [AIR][Projects] energyQueued=0 committed=89/547
  4.27  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.31  [Playtest] finished legwin team 0 at 4.31 min
  4.36  [AIR][Layout] repaired support air.bay.6 viable=3/5 slot=195 at=1944,11656
  4.42  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.43  [Playtest] finished legwin team 0 at 4.43 min
  4.43  [AIR][Economy] T1_CONTEST M=8 bank=617 E=231 bank=1379 pull=68 plants=1/0 aircraftDemand=3/87
  4.43  [AIR][Projects] energyQueued=0 committed=34/178
  4.43  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.44  [AIR][Rule] commander.idle.assist builder=23483
  4.48  [Playtest] finished legmex team 0 at 4.48 min
  4.49  [AIR][Rule] energy.grow builder=16408
  4.49  [Playtest] finished legwin team 0 at 4.49 min
  4.50  [AIR][Rule] energy.grow builder=5913
  4.51  [AIR][Wind] cluster=2 slots=6 at=2472,11536 local=false builder=23483
  4.51  [AIR][Rule] commander.idle.energy builder=23483
  4.54  [AIR][Layout] repaired support air.bay.6 viable=4/5 slot=209 at=1784,11592
  4.58  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.60  [AIR][Economy] T1_CONTEST M=8 bank=679 E=234 bank=1380 pull=12 plants=1/0 aircraftDemand=3/87
  4.60  [AIR][Projects] energyQueued=4 committed=172/700
  4.60  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=54
  4.73  [AIR][Layout] repaired support air.bay.6 viable=5/5 slot=210 at=1832,11544
  4.75  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=767 E=251 bank=1378 pull=26 plants=1/0 aircraftDemand=3/87
  4.77  [AIR][Projects] energyQueued=1 committed=145/590
  4.77  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=16943 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.85  [Playtest] finished legwin team 0 at 4.85 min
  4.90  [AIR][Rule] commander.energy.local builder=23483
  4.92  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=798 E=291 bank=1380 pull=41 plants=1/0 aircraftDemand=3/87
  4.93  [AIR][Projects] energyQueued=0 committed=99/404
  4.93  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
... 4298 more
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
