# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54003); wall 194 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:56:37
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\glitters\runs\20261003T175955Z-32f31965\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=981 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-028 metal bank over 50% for 60 s, 5 T2 constructors, none added` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 11.8 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 5 T2 constructors, none added
- forbid 'invariant' hit at 13.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 6 T2 constructors, none added
- forbid 'invariant' hit at 15.2 min: [INVARIANT] INV-010 combat unit armfast 25186 produced at +108 metal under the gate 200
- forbid 'invariant' hit at 16.8 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 9 T2 constructors, none added
- forbid 'invariant' hit at 17.0 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 244 elmos away, not flush (160)
- forbid 'invariant' hit at 17.4 min: [INVARIANT] INV-004 metal floating at 15742 of 15850 for 60 s while armfus is under construction and static build power 240 is under 296
- forbid 'invariant' hit at 17.8 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 9 T2 constructors, none added
- forbid 'invariant' hit at 18.0 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 244 elmos away, not flush (160)
- forbid 'invariant' hit at 19.0 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 237 elmos away, not flush (160)
- forbid 'invariant' hit at 20.0 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 237 elmos away, not flush (160)
- forbid 'invariant' hit at 20.2 min: [INVARIANT] INV-022 a new set of legafus starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 20.6 min: [t=00:01:58.413861][f=0037035] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:01:59.610279][f=0037560] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 204 elmos away, not flush (160)
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.538752][f=0038445] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.575192][f=0038460] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.611982][f=0038475] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.648061][f=0038490] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.685774][f=0038505] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.704305][f=0038520] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.741187][f=0038535] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.773333][f=0038550] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.820929][f=0038565] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.858987][f=0038580] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.903805][f=0038595] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.942077][f=0038610] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:03.986516][f=0038625] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [INVARIANT] INV-010 combat unit legstr 7785 produced at +115 metal under the gate 200
- forbid 'invariant' hit at 22.0 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 178 elmos away, not flush (160)
- forbid 'invariant' hit at 23.0 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 170 elmos away, not flush (160)
- forbid 'invariant' hit at 23.4 min: [INVARIANT] INV-004 metal floating at 19963 of 20050 for 60 s while armafus is under construction and static build power 2640 is under 2900
- forbid 'invariant' hit at 23.6 min: [INVARIANT] INV-010 combat unit armfast 6973 produced at +165 metal under the gate 200
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 163 elmos away, not flush (160)
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-011 metal floating at 16327 of 16600 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-011 metal floating at 16695 of 16700 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-010 combat unit leggob 8278 produced at +181 metal under the gate 200

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\glitters\runs\20261003T175955Z-32f31965\screen_2026-10-03_17-57-39-550.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\glitters\runs\20261003T175955Z-32f31965\screen_2026-10-03_17-58-16-905.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\glitters\runs\20261003T175955Z-32f31965\screen_2026-10-03_17-58-37-735.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\glitters\runs\20261003T175955Z-32f31965\screen_2026-10-03_17-59-54-154.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2801, 775) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2801, 775) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=981 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2832, 746), 71 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|cortex|corap|2760|757|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(4230,583) factory=armlab landLocked=no spot=2 known=1/1
  0.20  [Playtest] finished cormex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 2076 at 2688,704
  0.20  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|2760|757|0|1|1|2688|704
  0.21  [AIR][Rule] opening.mex builder=26153
  0.22  [Team][Roster] team 1 first mex at 4256,480
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=971 E=18 bank=726 pull=72 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=35/352
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=311 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.34  [Playtest] finished cormex team 0 at 0.34 min
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=956 E=30 bank=349 pull=86 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=23/232
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=368 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.48  [Playtest] finished cormex team 0 at 0.48 min
  0.49  [AIR][Wind] cluster=0 slots=6 at=2808,752 local=true builder=26153
  0.49  [AIR][Rule] opening.energy builder=26153
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=970 E=30 bank=216 pull=40 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=13/53
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=441 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.63  [Playtest] finished corwin team 0 at 0.63 min
  0.64  [AIR][Rule] recovery.energy builder=26153
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=929 E=30 bank=428 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=39/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=483 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.81  [Playtest] finished corsolar team 0 at 0.81 min
  0.82  [AIR][Rule] opening.energy builder=26153
  0.92  [Playtest] finished corwin team 0 at 0.92 min
  0.93  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=908 E=38 bank=653 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=470 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +7.5 bank 918/1150, energy +63.2 bank 814/1051, units 8
  1.04  [Playtest] finished corwin team 0 at 1.04 min
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=928 E=63 bank=1013 pull=40 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=24/99
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=482 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.15  [Playtest] finished corwin team 0 at 1.15 min
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=952 E=71 bank=1011 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=16/67
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=496 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.30  [Playtest] finished corwin team 0 at 1.30 min
  1.42  [Playtest] finished corwin team 0 at 1.42 min
  1.43  [AIR][Starter] nearby distance=128
  1.43  [AIR][Rule] opening.plant builder=26153
  1.43  [AIR][EcoLayout] reserved air.eco.0 reactor=3152,624 converters=8 zone=704
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=961 E=92 bank=999 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=630/1100
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=502 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.45  [AIR][EcoLayout] reserved air.eco.1 reactor=1872,368 converters=8 zone=730
  1.47  [AIR][EcoLayout] reserved air.eco.2 reactor=3664,368 converters=8 zone=741
  1.48  [AIR][EcoLayout] reserved air.eco.3 reactor=1744,880 converters=8 zone=752
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=739 E=107 bank=1032 pull=70 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=299/523
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=8241 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.74  [Playtest] finished corap team 0 at 1.74 min
  1.75  [AIR][Claim] cancel unowned native order cornanotc
  1.75  [AIR][State] T1_CONTEST
  1.75  [AIR][Produce] opening.scout corfink plant=8241 projected=1/1
  1.76  [AIR][Rule] opening.commander.guard builder=26153
  1.77  [AIR][Economy] T1_CONTEST M=7 bank=480 E=109 bank=1151 pull=39 plants=1/0 aircraftDemand=3/123
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  1.89  [AIR][Produce] constructor.recovery corca plant=8241 projected=1/3
  1.93  [AIR][Economy] T1_CONTEST M=7 bank=491 E=118 bank=340 pull=199 plants=1/0 aircraftDemand=3/123
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.5 bank 486/1250, energy +114.7 bank 54/1153, units 14
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=494 E=113 bank=15 pull=135 plants=1/0 aircraftDemand=3/123
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.19  [AIR][Produce] constructor.recovery corca plant=8241 projected=2/3
  2.19  [AIR][Rule] recovery.energy builder=16343
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=518 E=109 bank=40 pull=106 plants=1/0 aircraftDemand=3/123
  2.27  [AIR][Projects] energyQueued=0 committed=147/0
  2.27  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=514 E=97 bank=12 pull=135 plants=1/0 aircraftDemand=3/123
  2.43  [AIR][Projects] energyQueued=0 committed=118/0
  2.43  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=519 E=84 bank=11 pull=135 plants=1/0 aircraftDemand=3/123
  2.60  [AIR][Projects] energyQueued=0 committed=88/0
  2.60  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.60  [AIR][Produce] constructor.recovery corca plant=8241 projected=3/3
  2.60  [AIR][Rule] recovery.energy builder=12406
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=504 E=87 bank=38 pull=93 plants=1/0 aircraftDemand=3/123
  2.77  [AIR][Projects] energyQueued=0 committed=195/0
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=464 E=113 bank=2 pull=135 plants=1/0 aircraftDemand=3/123
  2.93  [AIR][Projects] energyQueued=0 committed=136/0
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.96  [AIR][Produce] opening.screen corveng plant=8241 projected=1/6
  2.96  [AIR][Rule] recovery.energy builder=26077
  3.00  [Playtest] eco team 0 at 3.0 min: metal +7.5 bank 455/1250, energy +124.2 bank 156/1228, units 19
  3.03  [AIR][Rule] commander.factory.guard builder=26153
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=441 E=113 bank=10 pull=261 plants=1/0 aircraftDemand=3/123
  3.10  [AIR][Projects] energyQueued=0 committed=220/0
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.10  [Playtest] finished corsolar team 0 at 3.10 min
  3.27  [AIR][Layout] cluster=0 labs=3 at=3360,2941
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=397 E=129 bank=82 pull=261 plants=1/0 aircraftDemand=3/123
  3.27  [AIR][Projects] energyQueued=0 committed=300/0
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=158 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.28  [AIR][Produce] opening.screen corveng plant=8241 projected=2/6
  3.28  [AIR][Screen] fighters=1 cells=8 centre=4195,981 width=600 advance=400 responding=false
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=312 E=176 bank=146 pull=320 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=211/0
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=167 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Produce] opening.screen corveng plant=8241 projected=3/6
  3.45  [AIR][Screen] fighters=2 cells=8 centre=4195,981 width=600 advance=400 responding=false
  3.45  [AIR][Layout] cluster=1 labs=1 at=2496,541
  3.47  [AIR][Layout] cluster=2 labs=1 at=3456,1501
  3.48  [AIR][Layout] cluster=3 labs=1 at=1632,541
  3.53  [Playtest] finished corsolar team 0 at 3.53 min
  3.55  [AIR][Rule] recovery.assist builder=12406
  3.59  [AIR][Produce] opening.screen corveng plant=8241 projected=4/6
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=226 E=180 bank=441 pull=315 plants=1/0 aircraftDemand=3/129
  3.60  [AIR][Projects] energyQueued=0 committed=131/0
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=146
  3.63  [AIR][Screen] fighters=3 cells=8 centre=4195,981 width=600 advance=400 responding=false
  3.74  [Playtest] finished corsolar team 0 at 3.74 min
  3.76  [AIR][Produce] opening.screen corveng plant=8241 projected=5/6
  3.76  [AIR][Rule] recovery.assist builder=26077
  3.76  [AIR][Rule] mex.expand builder=12406
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=143 E=200 bank=456 pull=193 plants=1/0 aircraftDemand=3/129
  3.77  [AIR][Projects] energyQueued=0 committed=100/500
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [AIR][Screen] fighters=4 cells=8 centre=4195,981 width=600 advance=400 responding=false
  3.83  [AIR][Layout] cluster=4 labs=1 at=2400,1117
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=112 E=218 bank=92 pull=175 plants=1/0 aircraftDemand=3/129
  3.93  [AIR][Projects] energyQueued=0 committed=53/416
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=162 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [AIR][Screen] fighters=4 cells=8 centre=4195,981 width=600 advance=400 responding=false
  3.97  [Playtest] finished corsolar team 0 at 3.97 min
  3.97  [AIR][Produce] opening.screen corveng plant=8241 projected=6/6
  3.98  [AIR][Rule] intel.radar builder=26077
  3.98  [AIR][Rule] project.assist builder=16343
  4.00  [Playtest] eco team 0 at 4.0 min: metal +7.5 bank 96/1250, energy +240.9 bank 75/1428, units 26
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=93 E=220 bank=5 pull=306 plants=1/0 aircraftDemand=3/129
  4.10  [AIR][Projects] energyQueued=0 committed=77/803
  4.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=171 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=133
  4.15  [AIR][Screen] fighters=5 cells=8 centre=4195,981 width=600 advance=400 responding=false
  4.20  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.20  [AIR][Rule] commander.idle.wait builder=26153
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=86 E=240 bank=606 pull=68 plants=1/0 aircraftDemand=3/130
  4.27  [AIR][Projects] energyQueued=0 committed=26/276
  4.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [Playtest] finished cormex team 0 at 4.27 min
  4.29  [AIR][Rule] wait builder=16343
  4.32  [AIR][Screen] fighters=6 cells=8 centre=4195,981 width=600 advance=400 responding=false
  4.36  [AIR][Rule] commander.idle.energy builder=26153
  4.41  [Playtest] finished corrad team 0 at 4.41 min
  4.42  [AIR][Rule] project.assist builder=26077
  4.43  [AIR][Rule] recovery.energy builder=16343
  4.43  [AIR][Economy] T1_CONTEST M=7 bank=144 E=239 bank=1411 pull=43 plants=1/0 aircraftDemand=3/130
  4.43  [AIR][Projects] energyQueued=1 committed=340/474
  4.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.45  [AIR][Layout] repaired support air.bay.0 viable=1/5 slot=8186 at=3000,984
  4.48  [AIR][Screen] fighters=6 cells=8 centre=4195,981 width=600 advance=400 responding=false
  4.58  [Playtest] finished corsolar team 0 at 4.58 min
  4.58  [AIR][Claim] cancel unowned native order cormakr
  4.60  [AIR][Rule] commander.idle.assist builder=26153
  4.60  [AIR][Economy] T1_CONTEST M=9 bank=68 E=239 bank=1472 pull=26 plants=1/0 aircraftDemand=3/130
  4.60  [AIR][Projects] energyQueued=0 committed=173/315
  4.60  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=224 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=121
  4.64  [AIR][Layout] repaired support air.bay.0 viable=2/5 slot=8187 at=2808,984
  4.65  [AIR][Screen] fighters=6 cells=8 centre=4195,981 width=600 advance=400 responding=false
  4.77  [AIR][Economy] T1_CONTEST M=9 bank=1 E=257 bank=1404 pull=41 plants=1/0 aircraftDemand=3/130
  4.77  [AIR][Projects] energyQueued=0 committed=9/50
  4.77  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=224 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.78  [Playtest] finished corsolar team 0 at 4.78 min
  4.78  [AIR][Claim] cancel unowned native order cormakr
  4.79  [AIR][Wind] cluster=1 slots=6 at=2632,1312 local=false builder=26153
  4.79  [AIR][Rule] commander.idle.energy builder=26153
  4.79  [AIR][Rule] wait builder=16343
  4.80  [Playtest] finished cormex team 0 at 4.80 min
  4.81  [AIR][Rule] mex.expand builder=26077
  4.82  [AIR][Screen] fighters=6 cells=8 centre=4195,981 width=600 advance=400 responding=false
  4.82  [AIR][Rule] wait builder=12406
  4.83  [AIR][Layout] repaired support air.bay.0 viable=3/5 slot=8198 at=2808,936
  4.86  [AIR][Rule] energy.grow builder=16343
  4.88  [AIR][Rule] energy.grow builder=12406
  4.93  [AIR][Economy] T1_CONTEST M=9 bank=68 E=260 bank=1525 pull=50 plants=1/0 aircraftDemand=3/130
  4.93  [AIR][Projects] energyQueued=1 committed=150/907
  4.93  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=224 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.97  [Playtest] finished corwin team 0 at 4.97 min
  4.98  [AIR][Rule] commander.idle.assist builder=26153
  4.98  [AIR][Screen] fighters=6 cells=8 centre=4195,981 width=600 advance=400 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.2 bank 89/1350, energy +277.6 bank 1526/1528, units 32
  5.00  [Playtest] target team 0 at (2801, 775) from its start position
  5.00  [Playtest] camera requested (2904,960) height=2200
  5.01  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=8199 at=2840,888
  5.02  [Playtest] camera captured name=ta position=(2904,960) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2904, 960)
  5.06  [Playtest] finished corwin team 0 at 5.06 min
  5.08  [AIR][Rule] storage.buffer builder=16343
  5.10  [AIR][Economy] T1_CONTEST M=11 bank=113 E=267 bank=1529 pull=29 plants=1/0 aircraftDemand=3/130
  5.10  [AIR][Projects] energyQueued=0 committed=262/2430
  5.10  [AIR][Workforce] t1=3/5 t2=0/3 targetBP=268 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=109
  5.10  [Ferry] AIR: queued request from team 1
  5.10  [Ferry] AIR: serving team 1 queued=0
  5.14  [Ferry] AIR: ordered one corvalk for team 1
  5.15  [AIR][Screen] fighters=6 cells=8 centre=4195,981 width=600 advance=400 responding=false
  5.19  [Playtest] finished cormex team 0 at 5.19 min
  5.21  [AIR][Rule] energy.grow builder=26077
  5.21  [AIR][Rule] commander.energy.assist builder=26153
  5.27  [AIR][Economy] T1_CONTEST M=11 bank=139 E=288 bank=1524 pull=136 plants=1/0 aircraftDemand=3/130
  5.27  [AIR][Projects] energyQueued=0 committed=219/1937
  5.27  [AIR][Workforce] t1=3/5 t2=0/3 targetBP=268 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.29  [Playtest] finished corwin team 0 at 5.29 min
  5.30  [AIR][Rule] commander.factory.guard builder=26153
  5.31  [AIR][Rule] mex.phase.convert builder=12406
  5.32  [AIR][Screen] fighters=6 cells=8 centre=4195,981 width=600 advance=400 responding=false
  5.43  [AIR][Economy] T1_CONTEST M=12 bank=185 E=311 bank=1492 pull=99 plants=1/0 aircraftDemand=3/130
  5.43  [AIR][Projects] energyQueued=0 committed=172/2844
  5.43  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=308 floating=false savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=8241 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.48  [AIR][Screen] fighters=6 cells=8 centre=4195,981 width=600 advance=400 responding=false
  5.50  [Ferry] AIR: transport 18404 built for team 1; hold pending task
  5.52  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=8202 at=3048,1000
  5.52  [Ferry] AIR: transport 18404 flying to (4230,583)
  5.60  [AIR][Commander] cleared factory guard for commander.idle.assist
  5.60  [AIR][Rule] commander.idle.assist builder=26153
  5.60  [AIR][Economy] T1_CONTEST M=13 bank=247 E=313 bank=1524 pull=72 plants=1/0 aircraftDemand=3/130
... 2809 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (4683, 469) facing 0, 77x61 cells: 4089 of 4697 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4683, 965) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4683, 917) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4683, 869) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4683, 821) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (4568, 1048) facing 0 (id 63)
  0.08  RESERVE: zone 8 at (5003, 1445) facing 0, 41x45 cells: 1845 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (5003, 1797) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (5003, 1749) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (5003, 1701) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (5003, 1653) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (3920, 1504) facing 0 (id 116)
  0.08  RESERVE: zone 9 at (3920, 1432) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 1456) facing 0: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (4016, 1480) facing 0, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (3920, 1480) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (3920, 1728) facing 0, 10x20 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (2325, 9707) facing 2, 77x63 cells: 4237 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (2325, 9211) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (2325, 9259) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (2325, 9307) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (2325, 9355) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (2088, 9128) facing 2 (id 63)
  0.09  RESERVE: zone 8 at (2005, 8731) facing 2, 41x45 cells: 1799 of 1845 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (2005, 8379) facing 2: 11 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (2005, 8427) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (2005, 8475) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (2005, 8523) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (2480, 8736) facing 2 (id 114)
  0.09  RESERVE: zone 9 at (2480, 8808) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (2480, 8784) facing 2: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (2576, 8760) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (2384, 8760) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 12 at (2480, 8760) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (2480, 8512) facing 2, 10x20 cells: 180 of 200 held
  0.17  RESERVE: armlab at (3664, 1680) facing 0 (id 119)
  0.17  RESERVE: zone 12 at (3664, 1608) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3664, 1632) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (3760, 1656) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (3664, 1656) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (3664, 1904) facing 0, 10x20 cells: 174 of 200 held
  0.17  RESERVE: leglab at (1456, 8720) facing 2 (id 117)
  0.17  RESERVE: zone 13 at (1456, 8792) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (1456, 8768) facing 2: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 14 at (1552, 8744) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: corridor 15 at (1360, 8744) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (1456, 8744) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (1456, 8496) facing 2, 10x20 cells: 180 of 200 held
  0.21  EXP: approach: corcom(26153) at (2753, 751) walks to (2793, 727), 139 from the cormex site (2912, 656)
  0.25  RESERVE: armalab at (3128, 1496) facing 0 (id 122)
  0.25  RESERVE: zone 15 at (3128, 1376) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3128, 1424) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (3128, 1448) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (3128, 1744) facing 0, 13x20 cells: 252 of 260 held
  0.25  RESERVE: zone 18 at (4704, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4704, 1872) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (4672, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4672, 1872) facing 0 (id 128)
  0.25  RESERVE: zone 20 at (4640, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4640, 1872) facing 0 (id 129)
  0.25  RESERVE: zone 21 at (4608, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4608, 1872) facing 0 (id 130)
  0.25  RESERVE: zone 22 at (4576, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4576, 1872) facing 0 (id 131)
  0.25  RESERVE: zone 23 at (4544, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4544, 1872) facing 0 (id 132)
  0.25  RESERVE: zone 24 at (4512, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4512, 1872) facing 0 (id 133)
  0.25  RESERVE: zone 25 at (4480, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4480, 1872) facing 0 (id 134)
  0.25  RESERVE: zone 26 at (4448, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4448, 1872) facing 0 (id 135)
  0.25  RESERVE: zone 27 at (4416, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4416, 1872) facing 0 (id 136)
  0.25  RESERVE: zone 28 at (4384, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4384, 1872) facing 0 (id 137)
  0.25  RESERVE: zone 29 at (4064, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4064, 1872) facing 0 (id 138)
  0.25  RESERVE: zone 30 at (4032, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4032, 1872) facing 0 (id 139)
  0.25  RESERVE: zone 31 at (3808, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3808, 1872) facing 0 (id 140)
  0.25  RESERVE: zone 32 at (3776, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3776, 1872) facing 0 (id 141)
  0.25  RESERVE: zone 33 at (4480, 1760) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (4480, 1760) facing 0 (id 142)
  0.25  RESERVE: legalab at (1080, 8712) facing 2 (id 120)
  0.25  RESERVE: zone 17 at (1080, 8832) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (1080, 8784) facing 2: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 18 at (1080, 8760) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 19 at (1080, 8464) facing 2, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 20 at (1568, 8384) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1568, 8384) facing 0 (id 125)
  0.25  RESERVE: zone 21 at (1600, 8384) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1600, 8384) facing 0 (id 126)
  0.25  RESERVE: zone 22 at (1632, 8384) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1632, 8384) facing 0 (id 127)
  0.25  RESERVE: zone 23 at (1664, 8384) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1664, 8384) facing 0 (id 128)
  0.25  RESERVE: zone 24 at (2368, 8384) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2368, 8384) facing 0 (id 129)
  0.25  RESERVE: zone 25 at (1664, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: leglht at (1664, 8496) facing 0 (id 130)
  0.29  EXP: approach: corcom(28807) at (3452, 9683) walks to (3431, 9671), 139 from the cormex site (3312, 9600)
  0.33  RESERVE: armalab at (4168, 2056) facing 0 (id 143)
  0.33  RESERVE: zone 34 at (4168, 1936) facing 0, 7x6 cells: 42 of 42 held
  0.33  RESERVE: grid of armnanotc 2x2 gap 0 behind (4168, 1984) facing 0: 4 of 4 slots (group 10, zone)
  0.33  RESERVE: zone 35 at (4168, 2008) facing 0, 9x15 cells: 12 of 135 held
  0.33  RESERVE: corridor 36 at (4168, 2304) facing 0, 13x20 cells: 251 of 260 held
  0.34  RESERVE: legalab at (3016, 8744) facing 2 (id 131)
  0.34  RESERVE: zone 26 at (3016, 8864) facing 2, 7x6 cells: 42 of 42 held
  0.34  RESERVE: grid of legnanotc 2x2 gap 0 behind (3016, 8816) facing 2: 4 of 4 slots (group 10, zone)
  0.34  RESERVE: zone 27 at (3016, 8792) facing 0, 9x15 cells: 12 of 135 held
  0.34  RESERVE: corridor 28 at (3016, 8496) facing 2, 13x20 cells: 252 of 260 held
  0.35  EXP: approach: corcom(26153) at (2764, 733) walks to (2803, 777), 139 from the cormex site (2896, 880)
  0.39  EXP: approach: armcom(30290) at (4254, 572) walks to (4045, 505), 136 from the armmex site (4032, 640)
  0.42  RESERVE: armshltx at (5712, 1552) facing 0 (id 148)
  0.42  RESERVE: zone 37 at (5712, 1336) facing 0, 30x15 cells: 434 of 450 held
```
