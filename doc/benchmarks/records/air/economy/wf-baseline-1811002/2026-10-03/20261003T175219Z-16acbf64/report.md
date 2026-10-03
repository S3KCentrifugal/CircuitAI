# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54074); wall 282 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:47:32
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\supreme\runs\20261003T175219Z-16acbf64\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-010 combat unit armfast 2967 produced at +54 metal under the gate 200` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 13.3 min: [INVARIANT] INV-010 combat unit armfast 2967 produced at +54 metal under the gate 200
- forbid 'invariant' hit at 16.7 min: [INVARIANT] INV-004 metal floating at 7075 of 7400 for 60 s while legwin is under construction and static build power 480 is under 1177
- forbid 'invariant' hit at 18.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 20.6 min: [INVARIANT] INV-010 combat unit armfast 825 produced at +163 metal under the gate 200
- forbid 'invariant' hit at 21.4 min: [INVARIANT] INV-004 metal floating at 11549 of 11550 for 60 s while armmmkr is under construction and static build power 1680 is under 3031
- forbid 'invariant' hit at 21.7 min: [INVARIANT] INV-011 metal floating at 10949 of 10950 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 22.0 min: [INVARIANT] INV-052 ferry run for cargo 25602 unloading for 16 s
- forbid 'invariant' hit at 22.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 22.8 min: [t=00:03:11.287188][f=0040994] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 22.8 min: [INVARIANT] INV-010 combat unit armfast 25759 produced at +188 metal under the gate 200
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.1 min: [INVARIANT] INV-022 a new set of legafus starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.3 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (3 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 26.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.9 min: [t=00:03:55.766619][f=0048474] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-010 combat unit armfast 18063 produced at +181 metal under the gate 200
- forbid 'invariant' hit at 27.7 min: [INVARIANT] INV-014 legadveconv packed at (10352, 1616) with no turret slot within 450
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-022 a new set of legadveconv starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-035 dedicated 31815 (legadveconv) holds leglraa

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\supreme\runs\20261003T175219Z-16acbf64\screen_2026-10-03_17-48-52-096.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\supreme\runs\20261003T175219Z-16acbf64\screen_2026-10-03_17-49-48-530.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\supreme\runs\20261003T175219Z-16acbf64\screen_2026-10-03_17-50-22-744.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\supreme\runs\20261003T175219Z-16acbf64\screen_2026-10-03_17-52-18-213.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 23
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 23
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 59 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|cortex|corap|2176|11788|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(813,10380) factory=armlab landLocked=no spot=1 known=1/1
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=975 E=18 bank=793 pull=80 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=328 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished cormex team 0 at 0.28 min
  0.28  [Team][Roster] first mex 19496 at 2287,11967
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|2176|11788|0|2|1|2287|11967
  0.29  [AIR][Rule] opening.mex builder=26153
  0.30  [Team][Roster] team 1 first mex at 752,10160
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=1001 E=30 bank=967 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=46/465
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=368 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.53  [Playtest] finished cormex team 0 at 0.53 min
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=1002 E=30 bank=736 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=426 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.76  [Playtest] finished cormex team 0 at 0.76 min
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1024 E=30 bank=479 pull=86 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=513 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.77  [AIR][Wind] cluster=0 slots=6 at=2104,11696 local=true builder=26153
  0.77  [AIR][Rule] opening.energy builder=26153
  0.88  [Playtest] finished corwin team 0 at 0.88 min
  0.93  [AIR][Economy] BOOTSTRAP M=8 bank=1063 E=30 bank=548 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=43/175
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=605 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1081/1150, energy +48.8 bank 619/1000, units 6
  1.04  [Playtest] finished corwin team 0 at 1.04 min
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=1097 E=44 bank=777 pull=40 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=24/98
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=634 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.15  [Playtest] finished corwin team 0 at 1.15 min
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1120 E=65 bank=957 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=1/5
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=648 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [Playtest] finished corwin team 0 at 1.27 min
  1.39  [Playtest] finished corwin team 0 at 1.39 min
  1.41  [AIR][Starter] nearby distance=127
  1.41  [AIR][Rule] opening.plant builder=26153
  1.42  [AIR][Layout] cluster=0 labs=6 at=2728,11428
  1.42  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 zone=128
  1.43  [AIR][EcoLayout] reserved air.eco.1 reactor=1536,11920 converters=8 zone=138
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=80 bank=952 pull=9 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=615/1075
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=658 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=12406 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.45  [AIR][EcoLayout] reserved air.eco.2 reactor=3200,11408 converters=8 zone=151
  1.47  [AIR][EcoLayout] reserved air.eco.3 reactor=3712,11152 converters=8 zone=166
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=897 E=104 bank=964 pull=70 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=264/462
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=513 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=12406 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.73  [Playtest] finished corap team 0 at 1.73 min
  1.73  [AIR][Claim] cancel unowned native order cornanotc
  1.73  [AIR][State] T1_CONTEST
  1.74  [AIR][Produce] opening.scout corfink plant=12406 projected=1/1
  1.74  [AIR][Rule] opening.commander.guard builder=26153
  1.77  [AIR][Economy] T1_CONTEST M=8 bank=687 E=113 bank=1027 pull=9 plants=1/0 aircraftDemand=3/123
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=213 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  1.86  [AIR][Produce] constructor.recovery corca plant=12406 projected=1/3
  1.93  [AIR][Economy] T1_CONTEST M=8 bank=703 E=111 bank=255 pull=199 plants=1/0 aircraftDemand=3/123
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=213 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +3.2 bank 699/1250, energy +98.3 bank 0/1102, units 12
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=695 E=95 bank=0 pull=154 plants=1/0 aircraftDemand=3/123
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=92 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.22  [AIR][Produce] constructor.recovery corca plant=12406 projected=2/3
  2.22  [AIR][Rule] recovery.energy builder=15495
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=703 E=80 bank=48 pull=116 plants=1/0 aircraftDemand=3/123
  2.27  [AIR][Projects] energyQueued=1 committed=150/0
  2.27  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=64 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=667 E=80 bank=10 pull=135 plants=1/0 aircraftDemand=3/123
  2.43  [AIR][Projects] energyQueued=0 committed=123/0
  2.43  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=64 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=636 E=93 bank=18 pull=135 plants=1/0 aircraftDemand=3/123
  2.60  [AIR][Projects] energyQueued=0 committed=93/0
  2.60  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=86 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.62  [AIR][Produce] constructor.recovery corca plant=12406 projected=3/3
  2.62  [AIR][Rule] recovery.energy builder=12049
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=622 E=106 bank=619 pull=182 plants=1/0 aircraftDemand=3/123
  2.77  [AIR][Projects] energyQueued=0 committed=201/0
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=147 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.88  [AIR][Produce] opening.screen corveng plant=12406 projected=1/6
  2.88  [AIR][Rule] recovery.energy builder=8696
  2.91  [AIR][Rule] commander.factory.guard builder=26153
  2.93  [AIR][Economy] T1_CONTEST M=8 bank=580 E=121 bank=1140 pull=269 plants=1/0 aircraftDemand=3/123
  2.93  [AIR][Projects] energyQueued=1 committed=292/0
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 537/1250, energy +139.4 bank 857/1177, units 18
  3.05  [AIR][Produce] opening.screen corveng plant=12406 projected=2/6
  3.05  [AIR][Screen] fighters=1 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.10  [AIR][Economy] T1_CONTEST M=8 bank=513 E=134 bank=1165 pull=269 plants=1/0 aircraftDemand=4/131
  3.10  [AIR][Projects] energyQueued=0 committed=205/0
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=213 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.13  [Playtest] finished corsolar team 0 at 3.13 min
  3.13  [AIR][Claim] cancel unowned native order cormakr
  3.14  [AIR][Rule] mex.expand builder=15495
  3.21  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.21  [AIR][Rule] commander.idle.assist builder=26153
  3.21  [AIR][Produce] opening.screen corveng plant=12406 projected=3/6
  3.22  [AIR][Rule] commander.factory.guard builder=26153
  3.25  [AIR][Screen] fighters=2 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.27  [AIR][Economy] T1_CONTEST M=8 bank=801 E=137 bank=1215 pull=269 plants=1/0 aircraftDemand=4/131
  3.27  [AIR][Projects] energyQueued=0 committed=190/497
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=213 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.38  [AIR][Produce] opening.screen corveng plant=12406 projected=4/6
  3.42  [AIR][Layout] cluster=1 labs=1 at=2344,11716
  3.42  [AIR][Screen] fighters=3 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.43  [AIR][Economy] T1_CONTEST M=8 bank=737 E=152 bank=1118 pull=402 plants=1/0 aircraftDemand=4/131
  3.43  [AIR][Projects] energyQueued=0 committed=117/350
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=213 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.54  [AIR][Produce] opening.screen corveng plant=12406 projected=5/6
  3.54  [Playtest] finished corsolar team 0 at 3.54 min
  3.55  [AIR][Rule] energy.grow builder=12049
  3.58  [AIR][Screen] fighters=4 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.60  [AIR][Economy] T1_CONTEST M=8 bank=691 E=156 bank=864 pull=407 plants=1/0 aircraftDemand=4/131
  3.60  [AIR][Projects] energyQueued=0 committed=94/367
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=213 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.73  [AIR][Produce] opening.screen corveng plant=12406 projected=6/6
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=658 E=168 bank=265 pull=54 plants=1/0 aircraftDemand=4/131
  3.77  [AIR][Projects] energyQueued=0 committed=41/212
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=175 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Screen] fighters=5 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.79  [Playtest] finished corsolar team 0 at 3.79 min
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=633 E=167 bank=69 pull=174 plants=1/0 aircraftDemand=4/131
  3.93  [AIR][Projects] energyQueued=0 committed=154/147
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=97 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Screen] fighters=5 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +6.6 bank 628/1250, energy +145.8 bank 4/1327, units 25
  4.09  [Playtest] finished corwin team 0 at 4.09 min
  4.10  [AIR][Rule] recovery.energy builder=12049
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=632 E=143 bank=367 pull=29 plants=1/0 aircraftDemand=4/131
  4.10  [AIR][Projects] energyQueued=1 committed=257/42
  4.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=141 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.10  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.10  [AIR][Rule] commander.idle.assist builder=26153
  4.12  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.15  [Playtest] finished cormex team 0 at 4.15 min
  4.16  [AIR][Rule] recovery.energy builder=15495
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=624 E=153 bank=1261 pull=12 plants=1/0 aircraftDemand=4/131
  4.27  [AIR][Projects] energyQueued=0 committed=279/0
  4.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [Playtest] finished corsolar team 0 at 4.27 min
  4.28  [AIR][Claim] cancel unowned native order cormakr
  4.28  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.29  [AIR][Rule] commander.energy.assist builder=26153
  4.40  [Playtest] finished corsolar team 0 at 4.40 min
  4.40  [AIR][Claim] cancel unowned native order cormakr
  4.41  [AIR][Wind] cluster=1 slots=6 at=2568,11792 local=false builder=12049
  4.41  [AIR][Rule] energy.grow builder=12049
  4.41  [AIR][Rule] commander.idle.assist builder=26153
  4.42  [AIR][Layout] repaired support air.bay.6 viable=1/5 slot=200 at=1800,11624
  4.43  [AIR][Economy] T1_CONTEST M=11 bank=535 E=170 bank=1381 pull=12 plants=1/0 aircraftDemand=4/131
  4.43  [AIR][Projects] energyQueued=1 committed=286/175
  4.43  [AIR][Workforce] t1=3/5 t2=0/3 targetBP=268 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.56  [Playtest] finished corsolar team 0 at 4.56 min
  4.57  [AIR][Claim] cancel unowned native order cormakr
  4.57  [AIR][Rule] energy.grow builder=8696
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=483 E=212 bank=1466 pull=17 plants=1/0 aircraftDemand=4/131
  4.60  [AIR][Projects] energyQueued=1 committed=167/314
  4.60  [AIR][Workforce] t1=3/5 t2=0/3 targetBP=268 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.60  [AIR][Layout] repaired support air.bay.6 viable=2/5 slot=205 at=1832,11544
  4.62  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.76  [Playtest] finished corsolar team 0 at 4.76 min
  4.77  [AIR][Claim] cancel unowned native order cormakr
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=486 E=200 bank=1527 pull=23 plants=1/0 aircraftDemand=4/131
  4.77  [AIR][Projects] energyQueued=0 committed=52/213
  4.77  [AIR][Workforce] t1=3/5 t2=0/3 targetBP=268 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=12406 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Rule] energy.grow builder=15495
  4.78  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.79  [AIR][Layout] repaired support air.bay.6 viable=3/5 slot=206 at=1960,11544
  4.93  [Playtest] finished corwin team 0 at 4.93 min
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=543 E=213 bank=1528 pull=60 plants=1/0 aircraftDemand=4/131
  4.93  [AIR][Projects] energyQueued=0 committed=40/164
  4.93  [AIR][Workforce] t1=3/5 t2=0/3 targetBP=268 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 3667 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: corcom(26153) at (2176, 11789) walks to (2215, 11850), 139 from the cormex site (2288, 11968)
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
  0.08  EXP: approach: armcom(30290) at (814, 10380) walks to (789, 10291), 136 from the armmex site (752, 10160)
  0.09  EXP: approach: corcom(28807) at (10102, 513) walks to (10077, 461), 139 from the cormex site (10016, 336)
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
  0.09  EXP: approach: legcom(13591) at (11479, 1952) walks to (11503, 2016), 137 from the legmex site (11552, 2144)
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
