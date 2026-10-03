# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54003); wall 286 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:48:01
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\supreme\runs\20261003T175250Z-96e87827\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-004 metal floating at 9031 of 9050 for 60 s while legafus is under construction and static build power 2160 is under 2479` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 18.2 min: [INVARIANT] INV-004 metal floating at 9031 of 9050 for 60 s while legafus is under construction and static build power 2160 is under 2479
- forbid 'invariant' hit at 18.6 min: [INVARIANT] INV-004 metal floating at 8649 of 8650 for 60 s while armmmkr is under construction and static build power 960 is under 2666
- forbid 'invariant' hit at 18.8 min: [INVARIANT] INV-011 metal floating at 8649 of 8650 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 19.6 min: [INVARIANT] INV-004 metal floating at 8649 of 8650 for 60 s while armmmkr is under construction and static build power 960 is under 2307
- forbid 'invariant' hit at 19.8 min: [INVARIANT] INV-011 metal floating at 8650 of 8650 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 21.0 min: [INVARIANT] INV-010 combat unit legstr 4996 produced at +165 metal under the gate 200
- forbid 'invariant' hit at 21.1 min: [INVARIANT] INV-022 a new set of legafus starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.4 min: [t=00:03:13.968022][f=0042115] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 23.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.1 min: [INVARIANT] INV-010 combat unit leggob 21337 produced at +182 metal under the gate 200
- forbid 'invariant' hit at 25.8 min: [INVARIANT] INV-052 ferry run for cargo 11729 unloading for 16 s
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-010 combat unit armfast 15825 produced at +189 metal under the gate 200
- forbid 'invariant' hit at 26.1 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (3 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 26.1 min: [INVARIANT] INV-010 combat unit leggob 24172 produced at +190 metal under the gate 200
- forbid 'invariant' hit at 26.4 min: [INVARIANT] INV-004 metal floating at 8948 of 8950 for 60 s while armmmkr is under construction and static build power 960 is under 4186
- forbid 'invariant' hit at 26.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.4 min: [INVARIANT] INV-004 metal floating at 8897 of 8900 for 60 s while armmmkr is under construction and static build power 960 is under 4934
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-011 metal floating at 8897 of 8900 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 28.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.4 min: [INVARIANT] INV-004 metal floating at 8896 of 8900 for 60 s while armmmkr is under construction and static build power 960 is under 4393
- forbid 'invariant' hit at 28.8 min: [INVARIANT] INV-014 legadveconv packed at (10320, 1584) with no turret slot within 450
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-011 metal floating at 8894 of 8900 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.4 min: [INVARIANT] INV-004 metal floating at 8643 of 8900 for 60 s while armmmkr is under construction and static build power 960 is under 4096
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-060 air defence cluster #10 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\supreme\runs\20261003T175250Z-96e87827\screen_2026-10-03_17-49-13-521.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\supreme\runs\20261003T175250Z-96e87827\screen_2026-10-03_17-50-11-267.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\supreme\runs\20261003T175250Z-96e87827\screen_2026-10-03_17-50-46-055.png

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
  0.08  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 59 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|cortex|corap|2176|11788|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(813,10380) factory=armlab landLocked=no spot=1 known=1/1
  0.27  [AIR][Capacity] own=2/30 usage=8/80 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=975 E=18 bank=793 pull=80 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished cormex team 0 at 0.28 min
  0.28  [Team][Roster] first mex 19496 at 2287,11967
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|2176|11788|0|2|1|2287|11967
  0.29  [AIR][Rule] opening.mex builder=26153
  0.30  [Team][Roster] team 1 first mex at 752,10160
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=1001 E=30 bank=967 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=46/465
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.53  [Playtest] finished cormex team 0 at 0.53 min
  0.60  [AIR][Capacity] own=4/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=1002 E=30 bank=736 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=6/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1028 E=30 bank=532 pull=86 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=2/24
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.77  [Playtest] finished cormex team 0 at 0.77 min
  0.78  [AIR][Wind] cluster=0 slots=6 at=2104,11696 local=true builder=26153
  0.78  [AIR][Rule] opening.energy builder=26153
  0.89  [Playtest] finished corwin team 0 at 0.89 min
  0.93  [AIR][Capacity] own=6/30 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=1061 E=30 bank=550 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=43/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1087/1150, energy +49.0 bank 639/1000, units 6
  1.05  [Playtest] finished corwin team 0 at 1.05 min
  1.10  [AIR][Capacity] own=8/48 usage=3/23 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=1104 E=43 bank=782 pull=23 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=31/130
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.17  [Playtest] finished corwin team 0 at 1.17 min
  1.27  [AIR][Capacity] own=8/54 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1127 E=58 bank=960 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=8/36
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.29  [Playtest] finished corwin team 0 at 1.29 min
  1.43  [AIR][Capacity] own=8/57 usage=7/40 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=58 bank=951 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=1/5
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.44  [Playtest] finished corwin team 0 at 1.44 min
  1.59  [Playtest] finished corwin team 0 at 1.59 min
  1.60  [AIR][Capacity] own=8/78 usage=7/40 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=75 bank=952 pull=40 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Wind] cluster=1 slots=6 at=2472,11792 local=false builder=26153
  1.77  [AIR][Capacity] own=8/118 usage=0/9 gifts=0 sent=8 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=110 bank=1003 pull=9 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=1 committed=43/175
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.90  [Playtest] finished corwin team 0 at 1.90 min
  1.92  [AIR][Starter] nearby distance=127
  1.92  [AIR][Rule] opening.plant builder=26153
  1.93  [AIR][Layout] cluster=0 labs=6 at=2728,11428
  1.93  [AIR][EcoLayout] reserved air.eco.0 reactor=1664,11920 converters=8 support=12 zone=146
  1.93  [AIR][Capacity] own=8/143 usage=0/12 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=141 bank=999 pull=12 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=630/1100
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.95  [AIR][EcoLayout] reserved air.eco.1 reactor=2944,11792 converters=8 support=12 zone=168
  1.97  [AIR][EcoLayout] reserved air.eco.2 reactor=2048,11408 converters=8 support=12 zone=197
  1.98  [AIR][EcoLayout] reserved air.eco.3 reactor=3200,11280 converters=8 support=12 zone=224
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 1051/1150, energy +162.9 bank 999/1003, units 12
  2.10  [AIR][Capacity] own=8/162 usage=35/70 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=8 bank=920 E=157 bank=1003 pull=70 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=297/519
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=24807 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.24  [Playtest] finished corap team 0 at 2.24 min
  2.25  [AIR][Claim] cancel unowned native order cornanotc
  2.25  [AIR][State] T1_CONTEST
  2.25  [AIR][Produce] opening.scout corfink plant=24807 projected=1/1
  2.25  [AIR][Rule] opening.commander.guard builder=26153
  2.27  [AIR][Capacity] own=8/162 usage=15/35 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=8 bank=677 E=162 bank=1103 pull=35 plants=1/0 aircraftDemand=3/123
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.37  [AIR][Produce] constructor.recovery corca plant=24807 projected=1/3
  2.43  [AIR][Capacity] own=8/162 usage=0/8 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=8 bank=703 E=162 bank=989 pull=199 plants=1/0 aircraftDemand=3/123
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=55 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=8/158 usage=4/87 gifts=0 sent=0 excess=0 pressure=false mobile=55 arriving=0 idle=55 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=8 bank=695 E=161 bank=658 pull=199 plants=1/0 aircraftDemand=3/123
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=55 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.60  [AIR][Produce] constructor.recovery corca plant=24807 projected=2/3
  2.60  [AIR][Rule] mex.expand builder=16575
  2.77  [AIR][Capacity] own=8/150 usage=3/68 gifts=0 sent=0 excess=0 pressure=false mobile=55 arriving=55 idle=0 ecoStatic=0 working=55 shortage=192 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST M=8 bank=709 E=152 bank=679 pull=199 plants=1/0 aircraftDemand=3/123
  2.77  [AIR][Projects] energyQueued=0 committed=48/485
  2.77  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=302 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.84  [AIR][Produce] constructor.recovery corca plant=24807 projected=3/3
  2.85  [AIR][Rule] mex.assist builder=17883
  2.93  [AIR][Capacity] own=8/150 usage=1/23 gifts=0 sent=0 excess=0 pressure=false mobile=110 arriving=55 idle=0 ecoStatic=0 working=55 shortage=0 reason=available or arriving power
  2.93  [AIR][Economy] T1_CONTEST M=8 bank=705 E=151 bank=517 pull=214 plants=1/0 aircraftDemand=3/123
  2.93  [AIR][Projects] energyQueued=0 committed=33/338
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 693/1250, energy +172.2 bank 336/1153, units 17
  3.08  [AIR][Produce] opening.screen corveng plant=24807 projected=1/6
  3.08  [AIR][Rule] recovery.energy builder=2115
  3.10  [AIR][Capacity] own=8/168 usage=2/38 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=689 E=165 bank=526 pull=38 plants=1/0 aircraftDemand=3/123
  3.10  [AIR][Projects] energyQueued=1 committed=159/94
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.13  [AIR][Rule] commander.factory.guard builder=26153
  3.15  [Playtest] finished cormex team 0 at 3.15 min
  3.17  [AIR][Rule] recovery.energy builder=17883
  3.17  [AIR][Rule] recovery.energy builder=16575
  3.27  [AIR][Capacity] own=8/176 usage=8/215 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=54 shortage=191 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=679 E=174 bank=47 pull=281 plants=1/0 aircraftDemand=3/123
  3.27  [AIR][Projects] energyQueued=2 committed=425/0
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=356 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.28  [AIR][Produce] opening.screen corveng plant=24807 projected=2/6
  3.28  [AIR][Screen] fighters=1 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.43  [AIR][Layout] cluster=1 labs=1 at=2824,10468
  3.43  [AIR][Capacity] own=7/175 usage=13/209 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=171 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=773 E=175 bank=40 pull=335 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=354/0
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=336 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Screen] fighters=1 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.50  [AIR][Produce] opening.screen corveng plant=24807 projected=3/6
  3.60  [AIR][Capacity] own=7/175 usage=14/238 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=141 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=988 E=175 bank=23 pull=377 plants=1/0 aircraftDemand=3/129
  3.60  [AIR][Projects] energyQueued=0 committed=266/0
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=306 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=71
  3.63  [AIR][Screen] fighters=2 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.71  [AIR][Produce] opening.screen corveng plant=24807 projected=4/6
  3.72  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.72  [AIR][Rule] commander.idle.assist builder=26153
  3.75  [AIR][Rule] commander.factory.guard builder=26153
  3.77  [AIR][Capacity] own=7/176 usage=25/138 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=365 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=942 E=176 bank=442 pull=138 plants=1/0 aircraftDemand=3/130
  3.77  [AIR][Projects] energyQueued=0 committed=154/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.82  [AIR][Screen] fighters=3 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=7/176 usage=13/177 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=91 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=885 E=176 bank=7 pull=352 plants=1/0 aircraftDemand=3/130
  3.93  [AIR][Projects] energyQueued=0 committed=65/0
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=256 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [Playtest] finished corsolar team 0 at 3.97 min
  3.98  [AIR][Produce] opening.screen corveng plant=24807 projected=5/6
  4.00  [Playtest] finished corsolar team 0 at 4.00 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.2 bank 876/1300, energy +187.7 bank 299/1278, units 25
  4.02  [AIR][Screen] fighters=4 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.10  [AIR][Capacity] own=6/176 usage=11/213 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=222 reason=funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=1100 E=176 bank=6 pull=373 plants=1/0 aircraftDemand=3/129
  4.10  [AIR][Projects] energyQueued=0 committed=299/0
  4.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=387 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=146
  4.18  [AIR][Screen] fighters=4 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.20  [Playtest] finished corsolar team 0 at 4.20 min
  4.21  [AIR][Produce] opening.screen corveng plant=24807 projected=6/6
  4.27  [AIR][Capacity] own=5/217 usage=12/281 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=159 reason=funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=1064 E=217 bank=391 pull=281 plants=1/0 aircraftDemand=3/129
  4.27  [AIR][Projects] energyQueued=1 committed=373/0
  4.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=324 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.35  [AIR][Screen] fighters=5 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.43  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.43  [AIR][Rule] commander.idle.assist builder=26153
  4.43  [AIR][Capacity] own=5/229 usage=10/66 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=191 reason=funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=1009 E=231 bank=171 pull=100 plants=1/0 aircraftDemand=3/130
  4.43  [AIR][Projects] energyQueued=0 committed=288/0
  4.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=356 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.48  [AIR][Produce] constructor.expand corca plant=24807 projected=4/4
  4.52  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=11/223 usage=24/11 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=55 idle=0 ecoStatic=0 working=465 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=995 E=224 bank=1326 pull=75 plants=1/0 aircraftDemand=3/130
  4.60  [AIR][Projects] energyQueued=0 committed=168/0
  4.60  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=132
  4.61  [Playtest] finished corsolar team 0 at 4.61 min
  4.62  [AIR][Claim] cancel unowned native order cormakr
  4.62  [AIR][Rule] commander.factory.guard builder=26153
  4.63  [AIR][Rule] energy.grow builder=2115
  4.68  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.77  [AIR][Capacity] own=11/226 usage=4/0 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=55 idle=0 ecoStatic=0 working=164 shortage=150 reason=funded workload
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=946 E=225 bank=1309 pull=157 plants=1/0 aircraftDemand=3/130
  4.77  [AIR][Projects] energyQueued=0 committed=136/162
  4.77  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=370 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.80  [AIR][Produce] constructor.expand corca plant=24807 projected=5/5
  4.80  [AIR][Rule] energy.grow builder=3848
  4.85  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.93  [AIR][Capacity] own=11/257 usage=9/40 gifts=0 sent=0 excess=0 pressure=true mobile=220 arriving=55 idle=0 ecoStatic=0 working=219 shortage=108 reason=funded workload
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=896 E=256 bank=1333 pull=213 plants=1/0 aircraftDemand=3/130
  4.93  [AIR][Projects] energyQueued=0 committed=96/241
  4.93  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=383 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=24807 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.94  [Playtest] finished corsolar team 0 at 4.94 min
... 3482 more
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
