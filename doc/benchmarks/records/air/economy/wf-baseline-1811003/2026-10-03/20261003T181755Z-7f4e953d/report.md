# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54003); wall 288 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:13:03
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glacial\runs\20261003T181755Z-7f4e953d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=993 E=0 bank=977 pull=79 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-052 ferry run for cargo 11128 unloading for 16 s` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 8.1 min: [INVARIANT] INV-052 ferry run for cargo 11128 unloading for 16 s
- forbid 'invariant' hit at 12.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 1 T2 constructors, none added
- forbid 'invariant' hit at 14.6 min: [INVARIANT] INV-022 a new set of legafus starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 17.2 min: [INVARIANT] INV-008 18 turret(s) in range of the reclaim of legalab 16408 are not on it
- forbid 'invariant' hit at 19.9 min: [INVARIANT] INV-022 a new set of legafus starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 20.9 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 16215 (61 by power), bank 126 + 168/s (0 by metal))
- forbid 'invariant' hit at 21.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.0 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 15412 (58 by power), bank 112 + 268/s (0 by metal))
- forbid 'invariant' hit at 24.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-035 dedicated 1801 (legadveconv) holds leglraa
- forbid 'invariant' hit at 25.4 min: [INVARIANT] INV-029 armalab 26529 stands 3 cells from the turrets, not tight
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 26.7 min: [INVARIANT] INV-014 legadveconv packed at (12880, 1248) with no turret slot within 450
- forbid 'invariant' hit at 26.7 min: [INVARIANT] INV-022 a new set of legadveconv starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 27.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 28.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 28.8 min: [INVARIANT] INV-014 legadveconv packed at (12928, 1168) with no turret slot within 450
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 20 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-014 legadveconv packed at (13056, 1024) with no turret slot within 450
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glacial\runs\20261003T181755Z-7f4e953d\screen_2026-10-03_18-14-15-074.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glacial\runs\20261003T181755Z-7f4e953d\screen_2026-10-03_18-15-04-953.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glacial\runs\20261003T181755Z-7f4e953d\screen_2026-10-03_18-15-42-364.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glacial\runs\20261003T181755Z-7f4e953d\screen_2026-10-03_18-17-55-205.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order legap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=993 E=0 bank=977 pull=79 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=303 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|490|1140|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(1836,1405) factory=armlab landLocked=no spot=1 known=1/1
  0.18  [Playtest] finished legmex team 0 at 0.18 min
  0.18  [Team][Roster] first mex 8838 at 496,1296
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|490|1140|0|0|1|496|1296
  0.19  [AIR][Rule] opening.mex builder=23483
  0.22  [Team][Roster] team 1 first mex at 1952,1408
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=964 E=18 bank=651 pull=82 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=19/194
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=306 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.31  [Playtest] finished legmex team 0 at 0.31 min
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=955 E=30 bank=277 pull=85 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=7/74
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=386 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.45  [Playtest] finished legmex team 0 at 0.45 min
  0.46  [AIR][Wind] cluster=0 slots=6 at=544,1160 local=true builder=23483
  0.46  [AIR][Rule] opening.energy builder=23483
  0.57  [Playtest] finished legwin team 0 at 0.57 min
  0.58  [AIR][Rule] recovery.energy builder=23483
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=972 E=30 bank=244 pull=14 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=1 committed=150/0
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=454 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [Playtest] finished legsolar team 0 at 0.76 min
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=917 E=40 bank=575 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=493 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [AIR][Rule] opening.energy builder=23483
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=952 E=58 bank=941 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=5/21
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=514 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.94  [Playtest] finished legwin team 0 at 0.94 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 965/1150, energy +73.4 bank 1032/1051, units 8
  1.06  [Playtest] finished legwin team 0 at 1.06 min
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=976 E=61 bank=1046 pull=9 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=39/162
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=528 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.19  [Playtest] finished legwin team 0 at 1.19 min
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=994 E=85 bank=999 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=16/67
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=539 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.30  [Playtest] finished legwin team 0 at 1.30 min
  1.32  [AIR][Starter] nearby distance=128
  1.32  [AIR][Rule] opening.plant builder=23483
  1.32  [AIR][EcoLayout] reserved air.eco.0 reactor=480,1776 converters=8 zone=352
  1.33  [AIR][EcoLayout] reserved air.eco.1 reactor=480,752 converters=8 zone=362
  1.35  [AIR][EcoLayout] reserved air.eco.2 reactor=736,2288 converters=8 zone=375
  1.37  [AIR][EcoLayout] reserved air.eco.3 reactor=992,880 converters=8 zone=385
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=940 E=124 bank=999 pull=60 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=299/767
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=506 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=11266 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.48  [AIR][Layout] cluster=0 labs=6 at=1330,1020
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=817 E=143 bank=1050 pull=60 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=97/249
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=11266 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.68  [Playtest] finished legap team 0 at 1.68 min
  1.68  [AIR][Claim] cancel unowned native order legnanotc
  1.68  [AIR][State] T1_CONTEST
  1.69  [AIR][Produce] opening.scout legfig plant=11266 projected=1/1
  1.69  [AIR][Rule] opening.commander.guard builder=23483
  1.77  [AIR][Economy] T1_CONTEST M=7 bank=757 E=144 bank=738 pull=369 plants=1/0 aircraftDemand=2/115
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.79  [AIR][Produce] constructor.recovery legca plant=11266 projected=1/3
  1.79  [AIR][Scout] opening drone=6056 enemy starts=2
  1.93  [AIR][Economy] T1_CONTEST M=7 bank=761 E=144 bank=323 pull=206 plants=1/0 aircraftDemand=2/115
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=191 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 760/1250, energy +145.0 bank 346/1177, units 13
  2.01  [AIR][Produce] constructor.recovery legca plant=11266 projected=2/3
  2.01  [AIR][Rule] recovery.energy builder=11708
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=770 E=144 bank=771 pull=206 plants=1/0 aircraftDemand=2/115
  2.10  [AIR][Projects] energyQueued=0 committed=145/0
  2.10  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.23  [AIR][Produce] constructor.recovery legca plant=11266 projected=3/3
  2.24  [AIR][Rule] mex.expand builder=8489
  2.27  [AIR][Economy] T1_CONTEST M=7 bank=752 E=148 bank=587 pull=64 plants=1/0 aircraftDemand=2/115
  2.27  [AIR][Projects] energyQueued=0 committed=171/500
  2.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=713 E=152 bank=114 pull=160 plants=1/0 aircraftDemand=2/115
  2.43  [AIR][Projects] energyQueued=0 committed=136/395
  2.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.46  [AIR][Produce] opening.screen legfig plant=11266 projected=2/7
  2.46  [AIR][Rule] recovery.energy builder=1495
  2.48  [AIR][Rule] commander.factory.guard builder=23483
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=710 E=154 bank=2 pull=269 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=245/347
  2.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=187 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.63  [AIR][Produce] opening.screen legfig plant=11266 projected=3/7
  2.63  [AIR][Screen] fighters=1 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=941 E=157 bank=6 pull=321 plants=1/0 aircraftDemand=3/84
  2.77  [AIR][Projects] energyQueued=0 committed=194/316
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=477 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.80  [AIR][Screen] fighters=1 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  2.81  [AIR][Produce] opening.screen legfig plant=11266 projected=4/7
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=928 E=153 bank=2 pull=325 plants=1/0 aircraftDemand=3/96
  2.93  [AIR][Projects] energyQueued=0 committed=144/298
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=177 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.98  [AIR][Screen] fighters=2 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  3.00  [AIR][Produce] opening.screen legfig plant=11266 projected=5/7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 925/1250, energy +148.6 bank 75/1227, units 22
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=921 E=147 bank=9 pull=249 plants=1/0 aircraftDemand=3/91
  3.10  [AIR][Projects] energyQueued=0 committed=94/284
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=172 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=70
  3.11  [Playtest] finished legsolar team 0 at 3.11 min
  3.17  [AIR][Screen] fighters=3 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  3.19  [AIR][Produce] opening.screen legfig plant=11266 projected=5/6
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=925 E=146 bank=64 pull=249 plants=1/0 aircraftDemand=3/91
  3.27  [AIR][Projects] energyQueued=0 committed=204/258
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=187 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.33  [AIR][Layout] cluster=1 labs=1 at=562,1308
  3.33  [AIR][Screen] fighters=4 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  3.37  [AIR][Produce] opening.screen legfig plant=11266 projected=6/6
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=917 E=156 bank=26 pull=269 plants=1/0 aircraftDemand=3/87
  3.43  [AIR][Projects] energyQueued=0 committed=154/241
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=187 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.52  [AIR][Screen] fighters=5 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  3.55  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.55  [AIR][Rule] commander.idle.assist builder=23483
  3.55  [Playtest] finished legsolar team 0 at 3.55 min
  3.56  [AIR][Rule] recovery.assist builder=1495
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=920 E=160 bank=465 pull=20 plants=1/0 aircraftDemand=3/87
  3.60  [AIR][Projects] energyQueued=0 committed=104/201
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=187 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=64
  3.68  [AIR][Screen] fighters=6 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  3.77  [AIR][Economy] T1_CONTEST M=7 bank=940 E=172 bank=1261 pull=20 plants=1/0 aircraftDemand=3/87
  3.77  [AIR][Projects] energyQueued=0 committed=44/81
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=477 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.80  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=3849 at=360,1192
  3.83  [Playtest] finished legsolar team 0 at 3.83 min
  3.85  [AIR][Rule] energy.grow builder=1495
  3.85  [AIR][Wind] cluster=1 slots=6 at=816,1368 local=false builder=23483
  3.85  [AIR][Rule] commander.idle.energy builder=23483
  3.85  [AIR][Screen] fighters=6 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  3.85  [AIR][Rule] energy.grow builder=11708
  3.88  [Playtest] finished legmex team 0 at 3.88 min
  3.93  [AIR][Economy] T1_CONTEST M=7 bank=961 E=172 bank=1308 pull=47 plants=1/0 aircraftDemand=3/87
  3.93  [AIR][Projects] energyQueued=0 committed=156/934
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.98  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=3856 at=520,1352
  3.99  [Playtest] finished legwin team 0 at 3.99 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 966/1300, energy +218.3 bank 1377/1378, units 27
  4.00  [AIR][Rule] commander.energy.assist builder=23483
  4.02  [AIR][Screen] fighters=6 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  4.07  [Playtest] finished legwin team 0 at 4.07 min
  4.08  [AIR][Rule] commander.energy.local builder=23483
  4.09  [AIR][Rule] mex.assist builder=11708
  4.10  [AIR][Economy] T1_CONTEST M=9 bank=973 E=206 bank=1375 pull=40 plants=1/0 aircraftDemand=3/87
  4.10  [AIR][Projects] energyQueued=1 committed=119/762
  4.10  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=230 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=57
  4.18  [AIR][Screen] fighters=6 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  4.19  [Playtest] finished legwin team 0 at 4.19 min
  4.21  [AIR][Rule] commander.idle.assist builder=23483
  4.27  [AIR][Economy] T1_CONTEST M=9 bank=998 E=244 bank=1379 pull=57 plants=1/0 aircraftDemand=3/87
  4.27  [AIR][Projects] energyQueued=0 committed=35/316
  4.27  [AIR][Workforce] t1=3/13 t2=0/5 targetBP=568 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.28  [Playtest] finished legwin team 0 at 4.28 min
  4.29  [AIR][Rule] mex.phase.convert builder=1495
  4.30  [AIR][Rule] commander.idle.energy builder=23483
  4.35  [AIR][Screen] fighters=6 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  4.43  [AIR][Economy] T1_CONTEST M=9 bank=1032 E=252 bank=1379 pull=87 plants=1/0 aircraftDemand=3/87
  4.43  [AIR][Projects] energyQueued=0 committed=14/1132
  4.43  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=589 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/3 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  4.45  [Playtest] finished legwin team 0 at 4.45 min
  4.47  [AIR][Rule] commander.local.assist builder=23483
  4.47  [Playtest] finished legmex team 0 at 4.47 min
  4.52  [AIR][Screen] fighters=6 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  4.58  [Playtest] finished legeconv team 0 at 4.58 min
  4.59  [AIR][Rule] energy.grow builder=1495
  4.60  [AIR][Rule] commander.idle.energy builder=23483
  4.60  [AIR][Economy] T1_CONTEST M=9 bank=1109 E=236 bank=1311 pull=150 plants=1/0 aircraftDemand=3/87
  4.60  [AIR][Projects] energyQueued=2 committed=121/701
  4.60  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=620 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=52
  4.68  [AIR][Screen] fighters=6 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  4.72  [Playtest] finished legwin team 0 at 4.72 min
  4.73  [AIR][Rule] commander.idle.assist builder=23483
  4.77  [AIR][Economy] T1_CONTEST M=12 bank=1159 E=242 bank=1380 pull=135 plants=1/0 aircraftDemand=3/87
  4.77  [AIR][Projects] energyQueued=0 committed=33/201
  4.77  [AIR][Workforce] t1=3/17 t2=0/7 targetBP=730 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=11266 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.81  [Playtest] finished legwin team 0 at 4.81 min
  4.82  [AIR][Wind] cluster=2 slots=6 at=208,1064 local=false builder=1495
  4.83  [AIR][Rule] commander.idle.energy builder=23483
  4.84  [Playtest] finished legmex team 0 at 4.84 min
  4.85  [AIR][Screen] fighters=6 cells=8 centre=2236,1404 width=600 advance=400 responding=false
  4.86  [AIR][Rule] energy.grow builder=8489
  4.86  [AIR][Rule] energy.grow builder=11708
  4.93  [AIR][Economy] T1_CONTEST M=13 bank=1253 E=310 bank=1381 pull=91 plants=1/0 aircraftDemand=3/87
  4.93  [AIR][Projects] energyQueued=3 committed=170/691
  4.93  [AIR][Workforce] t1=3/18 t2=0/7 targetBP=800 floating=true savingLab=false
... 3158 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: legcom(23483) at (490, 1140) walks to (491, 1159), 137 from the legmex site (496, 1296)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (1688, 1784) facing 1, 63x77 cells: 4515 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2184, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2136, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2088, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2040, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (2264, 1544) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (2536, 1464) facing 1, 29x41 cells: 1133 of 1189 held
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
  0.10  EXP: idle: legcom(23483) on legmex at (490, 1151), site (496, 1296), target yes, fails 2 (arrived at the approach point)
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
  0.19  EXP: approach: legcom(23483) at (490, 1152) walks to (472, 1150), 137 from the legmex site (336, 1136)
  0.22  EXP: approach: corcom(14393) at (13992, 1046) walks to (13966, 1034), 139 from the cormex site (13840, 976)
  0.23  EXP: approach: armcom(1236) at (1874, 1404) walks to (1779, 1112), 136 from the armmex site (1792, 1248)
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
  0.25  RESERVE: zone 19 at (11312, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11312, 1888) facing 0 (id 125)
  0.25  RESERVE: zone 20 at (11312, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11312, 1856) facing 0 (id 126)
  0.25  RESERVE: zone 21 at (11312, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11312, 1824) facing 0 (id 127)
  0.25  RESERVE: zone 22 at (11312, 1792) facing 0, 2x2 cells: 4 of 4 held
```
