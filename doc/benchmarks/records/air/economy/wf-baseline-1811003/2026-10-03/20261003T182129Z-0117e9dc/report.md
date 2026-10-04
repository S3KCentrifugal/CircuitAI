# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54005); wall 210 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:17:56
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glitters\runs\20261003T182129Z-0117e9dc\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=981 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 952 (3 by power), bank 0 + 17/s (0 by metal))` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 5.6 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 952 (3 by power), bank 0 + 17/s (0 by metal))
- forbid 'invariant' hit at 11.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added
- forbid 'invariant' hit at 12.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added
- forbid 'invariant' hit at 13.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added
- forbid 'invariant' hit at 14.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added
- forbid 'invariant' hit at 18.2 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (4256, 480) not upgraded
- forbid 'invariant' hit at 19.1 min: [INVARIANT] INV-022 a new set of armafus starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 21.5 min: [INVARIANT] INV-010 combat unit armfast 31083 produced at +170 metal under the gate 200
- forbid 'invariant' hit at 23.9 min: [INVARIANT] INV-010 combat unit armfast 5778 produced at +170 metal under the gate 200
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-011 metal floating at 17043 of 17100 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 28.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-010 combat unit armfast 9397 produced at +192 metal under the gate 200
- forbid 'invariant' hit at 29.1 min: [t=00:03:17.320138][f=0052434] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-011 metal floating at 17610 of 17750 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glitters\runs\20261003T182129Z-0117e9dc\screen_2026-10-03_18-18-54-419.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glitters\runs\20261003T182129Z-0117e9dc\screen_2026-10-03_18-19-29-018.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glitters\runs\20261003T182129Z-0117e9dc\screen_2026-10-03_18-19-53-705.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\glitters\runs\20261003T182129Z-0117e9dc\screen_2026-10-03_18-21-28-768.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (2801, 775) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2801, 775) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order legap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=981 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2832, 746), 64 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|2769|763|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(4210,609) factory=armlab landLocked=no spot=2 known=1/1
  0.17  [Team][Roster] team 1 first mex at 4256,480
  0.20  [Playtest] finished legmex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 20017 at 2688,704
  0.20  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|2769|763|0|1|1|2688|704
  0.21  [AIR][Rule] opening.mex builder=23483
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=965 E=18 bank=661 pull=72 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=35/353
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.34  [Playtest] finished legmex team 0 at 0.34 min
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=949 E=30 bank=276 pull=85 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=22/228
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=364 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.48  [Playtest] finished legmex team 0 at 0.48 min
  0.49  [AIR][Rule] recovery.energy builder=23483
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=907 E=30 bank=268 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=55/0
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=403 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.66  [Playtest] finished legsolar team 0 at 0.66 min
  0.67  [AIR][Wind] cluster=0 slots=6 at=2680,784 local=false builder=23483
  0.67  [AIR][Rule] opening.energy builder=23483
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=881 E=30 bank=449 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=5/21
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=454 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [Playtest] finished legwin team 0 at 0.78 min
  0.90  [Playtest] finished legwin team 0 at 0.89 min
  0.93  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=901 E=50 bank=772 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=36/146
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=465 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +7.5 bank 900/1150, energy +67.8 bank 899/1051, units 8
  1.01  [Playtest] finished legwin team 0 at 1.01 min
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=910 E=68 bank=998 pull=40 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=13/53
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=471 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.13  [Playtest] finished legwin team 0 at 1.13 min
  1.24  [Playtest] finished legwin team 0 at 1.24 min
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=922 E=77 bank=1052 pull=28 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=1 committed=43/175
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=478 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.37  [Playtest] finished legwin team 0 at 1.37 min
  1.38  [AIR][Starter] nearby distance=128
  1.38  [AIR][Rule] opening.plant builder=23483
  1.38  [AIR][EcoLayout] reserved air.eco.0 reactor=1872,368 converters=8 zone=707
  1.40  [AIR][EcoLayout] reserved air.eco.1 reactor=1744,880 converters=8 zone=718
  1.42  [AIR][EcoLayout] reserved air.eco.2 reactor=1360,496 converters=8 zone=732
  1.43  [AIR][EcoLayout] reserved air.eco.3 reactor=4048,1392 converters=8 zone=753
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=925 E=110 bank=1000 pull=60 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=381/975
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=480 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=19997 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=798 E=116 bank=1051 pull=60 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=179/458
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=19997 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.75  [Playtest] finished legap team 0 at 1.75 min
  1.75  [AIR][Claim] cancel unowned native order legnanotc
  1.75  [AIR][State] T1_CONTEST
  1.76  [AIR][Produce] opening.scout legfig plant=19997 projected=1/1
  1.76  [AIR][Rule] opening.commander.guard builder=23483
  1.77  [AIR][Economy] T1_CONTEST M=7 bank=674 E=118 bank=1153 pull=52 plants=1/0 aircraftDemand=2/115
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.86  [AIR][Produce] constructor.recovery legca plant=19997 projected=1/3
  1.86  [AIR][Scout] opening drone=30493 enemy starts=2
  1.93  [AIR][Economy] T1_CONTEST M=7 bank=690 E=129 bank=231 pull=206 plants=1/0 aircraftDemand=2/115
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.5 bank 691/1250, energy +120.9 bank 33/1153, units 14
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=700 E=120 bank=46 pull=97 plants=1/0 aircraftDemand=2/115
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=167 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.15  [AIR][Produce] constructor.recovery legca plant=19997 projected=2/3
  2.15  [AIR][Rule] recovery.energy builder=8489
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=708 E=123 bank=599 pull=156 plants=1/0 aircraftDemand=2/115
  2.27  [AIR][Projects] energyQueued=0 committed=138/0
  2.27  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=167 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.38  [AIR][Produce] constructor.recovery legca plant=19997 projected=3/3
  2.38  [AIR][Rule] recovery.energy builder=31776
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=684 E=149 bank=1169 pull=206 plants=1/0 aircraftDemand=2/115
  2.43  [AIR][Projects] energyQueued=0 committed=263/0
  2.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.59  [AIR][Produce] opening.screen legfig plant=19997 projected=2/7
  2.59  [AIR][Rule] mex.expand builder=14148
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=628 E=152 bank=1228 pull=127 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=265/500
  2.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.64  [AIR][Rule] commander.factory.guard builder=23483
  2.70  [AIR][Produce] opening.screen legfig plant=19997 projected=3/7
  2.70  [AIR][Screen] fighters=1 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  2.77  [AIR][Economy] T1_CONTEST M=7 bank=593 E=156 bank=209 pull=380 plants=1/0 aircraftDemand=3/84
  2.77  [AIR][Projects] energyQueued=0 committed=210/435
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.84  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.84  [AIR][Rule] commander.idle.assist builder=23483
  2.85  [AIR][Produce] opening.screen legfig plant=19997 projected=4/7
  2.88  [AIR][Screen] fighters=2 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=553 E=160 bank=304 pull=140 plants=1/0 aircraftDemand=3/96
  2.93  [AIR][Projects] energyQueued=0 committed=114/361
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=175 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.97  [Playtest] finished legsolar team 0 at 2.97 min
  2.98  [AIR][Rule] commander.energy.local builder=23483
  3.00  [Playtest] eco team 0 at 3.0 min: metal +7.5 bank 487/1250, energy +181.0 bank 434/1278, units 23
  3.05  [AIR][Screen] fighters=2 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  3.09  [AIR][Produce] opening.screen legfig plant=19997 projected=4/6
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=402 E=160 bank=697 pull=128 plants=1/0 aircraftDemand=3/91
  3.10  [AIR][Projects] energyQueued=0 committed=218/241
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=70
  3.14  [Playtest] finished legsolar team 0 at 3.14 min
  3.15  [AIR][Rule] commander.factory.guard builder=23483
  3.22  [AIR][Layout] cluster=0 labs=3 at=3369,2947
  3.23  [Playtest] finished legsolar team 0 at 3.23 min
  3.23  [AIR][Screen] fighters=3 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  3.24  [AIR][Wind] cluster=1 slots=6 at=3016,624 local=false builder=8489
  3.24  [AIR][Rule] energy.grow builder=8489
  3.25  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.25  [AIR][Rule] commander.idle.assist builder=23483
  3.26  [AIR][Produce] opening.screen legfig plant=19997 projected=5/6
  3.27  [AIR][Economy] T1_CONTEST M=7 bank=326 E=179 bank=908 pull=280 plants=1/0 aircraftDemand=3/91
  3.27  [AIR][Projects] energyQueued=1 committed=168/297
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.28  [AIR][Rule] commander.factory.guard builder=23483
  3.39  [AIR][Produce] opening.screen legfig plant=19997 projected=6/6
  3.40  [AIR][Layout] cluster=1 labs=1 at=2505,547
  3.42  [AIR][Layout] cluster=2 labs=1 at=3177,1411
  3.43  [AIR][Layout] cluster=3 labs=1 at=2985,1507
  3.43  [AIR][Economy] T1_CONTEST M=7 bank=307 E=211 bank=717 pull=385 plants=1/0 aircraftDemand=3/87
  3.43  [AIR][Projects] energyQueued=0 committed=123/139
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Screen] fighters=5 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  3.44  [Playtest] finished legmex team 0 at 3.44 min
  3.45  [AIR][Layout] cluster=4 labs=1 at=2313,547
  3.57  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.57  [AIR][Rule] commander.idle.assist builder=23483
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=331 E=200 bank=1377 pull=25 plants=1/0 aircraftDemand=3/87
  3.60  [AIR][Projects] energyQueued=0 committed=135/569
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  3.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=63
  3.65  [Playtest] finished legwin team 0 at 3.65 min
  3.67  [AIR][Rule] intel.radar builder=8489
  3.67  [AIR][Produce] constructor.expand legca plant=19997 projected=4/5
  3.77  [AIR][Economy] T1_CONTEST M=9 bank=354 E=200 bank=1378 pull=89 plants=1/0 aircraftDemand=3/87
  3.77  [AIR][Projects] energyQueued=0 committed=127/976
  3.77  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=224 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.77  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  3.80  [Playtest] finished legsolar team 0 at 3.80 min
  3.81  [AIR][Rule] commander.factory.guard builder=23483
  3.81  [AIR][Rule] mex.assist builder=31776
  3.93  [AIR][Economy] T1_CONTEST M=9 bank=633 E=217 bank=1357 pull=185 plants=1/0 aircraftDemand=3/87
  3.93  [AIR][Projects] energyQueued=0 committed=59/608
  3.93  [AIR][Workforce] t1=4/6 t2=0/2 targetBP=228 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.93  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  4.00  [AIR][Layout] repaired support air.bay.0 viable=3/5 slot=7994 at=2840,648
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.3 bank 623/1300, energy +215.5 bank 1368/1453, units 30
  4.00  [AIR][Rule] energy.grow builder=19816
  4.00  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.00  [AIR][Rule] commander.idle.energy builder=23483
  4.10  [AIR][Economy] T1_CONTEST M=9 bank=649 E=217 bank=1380 pull=65 plants=1/0 aircraftDemand=3/87
  4.10  [AIR][Projects] energyQueued=1 committed=102/534
  4.10  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=224 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  4.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=57
  4.15  [Playtest] finished legmex team 0 at 4.15 min
  4.17  [AIR][Rule] mex.expand builder=31776
  4.17  [AIR][Rule] energy.grow builder=14148
  4.18  [Playtest] finished legrad team 0 at 4.18 min
  4.18  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=7995 at=2696,648
  4.19  [AIR][Rule] energy.grow builder=8489
  4.27  [AIR][Economy] T1_CONTEST M=9 bank=718 E=222 bank=1380 pull=19 plants=1/0 aircraftDemand=3/87
  4.27  [AIR][Projects] energyQueued=3 committed=208/1143
  4.27  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=224 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  4.37  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=7996 at=2680,600
  4.41  [Playtest] finished legwin team 0 at 4.41 min
  4.42  [AIR][Rule] commander.energy.assist builder=23483
  4.43  [AIR][Economy] T1_CONTEST M=11 bank=761 E=229 bank=1449 pull=45 plants=1/0 aircraftDemand=3/87
  4.43  [AIR][Projects] energyQueued=0 committed=130/800
  4.43  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  4.50  [Playtest] finished legwin team 0 at 4.50 min
  4.52  [AIR][Rule] mex.assist builder=14148
  4.57  [Playtest] finished legwin team 0 at 4.57 min
  4.58  [AIR][Rule] commander.energy.local builder=23483
  4.58  [AIR][Wind] cluster=2 slots=6 at=2648,1232 local=false builder=8489
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=775 E=211 bank=1382 pull=31 plants=1/0 aircraftDemand=3/87
  4.60  [AIR][Projects] energyQueued=2 committed=125/710
  4.60  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=52
  4.69  [Playtest] finished legwin team 0 at 4.69 min
  4.69  [Playtest] finished legwin team 0 at 4.69 min
  4.71  [AIR][Rule] commander.idle.assist builder=23483
  4.75  [Ferry] AIR: queued request from team 1
  4.75  [Ferry] AIR: serving team 1 queued=0
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=811 E=214 bank=1455 pull=43 plants=1/0 aircraftDemand=3/87
  4.77  [AIR][Projects] energyQueued=1 committed=92/440
  4.77  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  4.81  [Ferry] AIR: ordered one leglts for team 1
  4.84  [Playtest] finished legmex team 0 at 4.84 min
  4.86  [AIR][Rule] energy.grow builder=31776
  4.86  [AIR][Rule] energy.grow builder=14148
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=876 E=216 bank=1383 pull=87 plants=1/0 aircraftDemand=3/87
  4.93  [AIR][Projects] energyQueued=0 committed=137/559
  4.93  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +13.0 bank 903/1400, energy +226.6 bank 1451/1456, units 41
  5.00  [Playtest] target team 0 at (2801, 775) from its start position
  5.00  [Playtest] camera requested (2768,640) height=2200
  5.01  [Playtest] camera captured name=ta position=(2768,640) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2768, 640)
  5.09  [Playtest] finished legwin team 0 at 5.09 min
  5.10  [AIR][Economy] T1_CONTEST M=13 bank=922 E=216 bank=1383 pull=118 plants=1/0 aircraftDemand=3/87
  5.10  [AIR][Projects] energyQueued=0 committed=76/310
  5.10  [AIR][Workforce] t1=4/7 t2=0/3 targetBP=312 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=47
  5.10  [AIR][Rule] commander.energy.assist builder=23483
  5.17  [Playtest] finished legwin team 0 at 5.17 min
  5.23  [Playtest] finished legwin team 0 at 5.23 min
  5.25  [AIR][Wind] cluster=3 slots=6 at=2312,880 local=false builder=19816
  5.25  [Ferry] AIR: transport 13237 built for team 1; hold pending task
  5.27  [AIR][Economy] T1_CONTEST M=13 bank=949 E=233 bank=1384 pull=67 plants=1/0 aircraftDemand=3/87
  5.27  [AIR][Projects] energyQueued=1 committed=128/523
  5.27  [AIR][Workforce] t1=4/7 t2=0/3 targetBP=312 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Screen] fighters=6 cells=8 centre=4176,1007 width=600 advance=400 responding=false
  5.27  [Ferry] AIR: transport 13237 flying to (4210,609)
  5.33  [Playtest] finished legwin team 0 at 5.33 min
  5.35  [AIR][Rule] commander.idle.assist builder=23483
... 4115 more
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
  0.18  EXP: approach: corcom(14393) at (3450, 9700) walks to (3424, 9681), 139 from the cormex site (3312, 9600)
  0.21  EXP: approach: legcom(23483) at (2763, 757) walks to (2799, 733), 137 from the legmex site (2912, 656)
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
```
