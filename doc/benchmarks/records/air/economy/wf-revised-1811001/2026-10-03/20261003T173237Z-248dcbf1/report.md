# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54045); wall 281 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:27:52
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\supreme\runs\20261003T173237Z-248dcbf1\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 25952 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 3.9 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 25952 are not on it
- forbid 'invariant' hit at 12.4 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added
- forbid 'invariant' hit at 12.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 8 T2 constructors, none added
- forbid 'invariant' hit at 13.4 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added
- forbid 'invariant' hit at 13.7 min: [INVARIANT] INV-008 2 turret(s) in range of the reclaim of armwin 2139 are not on it
- forbid 'invariant' hit at 13.8 min: [INVARIANT] INV-008 9 turret(s) in range of the reclaim of legwin 28332 are not on it
- forbid 'invariant' hit at 14.0 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of legalab 23500 are not on it
- forbid 'invariant' hit at 15.1 min: [INVARIANT] INV-010 combat unit armfast 11788 produced at +113 metal under the gate 200
- forbid 'invariant' hit at 17.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 18.2 min: [INVARIANT] INV-010 combat unit armfast 3490 produced at +91 metal under the gate 200
- forbid 'invariant' hit at 22.2 min: [INVARIANT] INV-010 combat unit armfast 17006 produced at +197 metal under the gate 200
- forbid 'invariant' hit at 22.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 22.8 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 12300 (46 by power), bank 111 + 204/s (0 by metal))
- forbid 'invariant' hit at 23.2 min: [INVARIANT] INV-010 combat unit armfast 1533 produced at +192 metal under the gate 200
- forbid 'invariant' hit at 23.3 min: [INVARIANT] INV-010 combat unit armpw 24600 produced at +192 metal under the gate 200
- forbid 'invariant' hit at 23.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.8 min: [INVARIANT] INV-019 4 turret frames under construction, 1 allowed (build power 13500 (50 by power), bank 122 + 226/s (0 by metal))
- forbid 'invariant' hit at 24.7 min: [INVARIANT] INV-039 T1 land constructors released 295 s, 0 spam labs of 3 wanted, no forward order for 180 s
- forbid 'invariant' hit at 24.7 min: [INVARIANT] INV-022 a new set of legadveconv starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.7 min: [INVARIANT] INV-001 a retiring factory produced armfast 15436
- forbid 'invariant' hit at 25.4 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.3 min: [INVARIANT] INV-014 legadveconv packed at (10336, 1600) with no turret slot within 450
- forbid 'invariant' hit at 26.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.3 min: [INVARIANT] INV-016 the advanced lab 12634 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 26.3 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 291 elmos away, not flush (160)
- forbid 'invariant' hit at 26.4 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 26.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.3 min: [INVARIANT] INV-016 the advanced lab 12634 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 27.3 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 291 elmos away, not flush (160)
- forbid 'invariant' hit at 27.4 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 28.2 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.4 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-014 legadveconv packed at (10784, 1568) with no turret slot within 450
- forbid 'invariant' hit at 29.2 min: [INVARIANT] INV-011 metal floating at 7441 of 7450 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-022 a new set of legadveconv starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.4 min: [INVARIANT] INV-060 air defence cluster #9 has 3 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 29.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 7 cell(s) from the turrets, not flush

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\supreme\runs\20261003T173237Z-248dcbf1\screen_2026-10-03_17-29-00-662.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\supreme\runs\20261003T173237Z-248dcbf1\screen_2026-10-03_17-29-58-550.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\supreme\runs\20261003T173237Z-248dcbf1\screen_2026-10-03_17-30-33-079.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\supreme\runs\20261003T173237Z-248dcbf1\screen_2026-10-03_17-32-36-129.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 26
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 26
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.08  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 55 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(813,10380) factory=armlab landLocked=no spot=1 known=1/1
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=976 E=18 bank=780 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.30  [AIR][Rule] opening.mex builder=2274
  0.30  [Team][Roster] first mex 14169 at 2288,11968
  0.30  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|2288|11968
  0.30  [Team][Roster] team 1 first mex at 752,10160
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=997 E=30 bank=961 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.60  [AIR][Capacity] own=4/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=997 E=30 bank=711 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=6/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1022 E=30 bank=463 pull=89 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/5
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.77  [Playtest] finished armmex team 0 at 0.77 min
  0.78  [AIR][Wind] cluster=0 slots=6 at=2088,11696 local=true builder=2274
  0.78  [AIR][Rule] opening.energy builder=2274
  0.88  [Playtest] finished armwin team 0 at 0.88 min
  0.93  [AIR][Capacity] own=6/30 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=1060 E=30 bank=523 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1079/1150, energy +46.3 bank 562/1000, units 6
  1.03  [Playtest] finished armwin team 0 at 1.03 min
  1.10  [AIR][Capacity] own=8/45 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=1094 E=40 bank=696 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=18/78
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.14  [Playtest] finished armwin team 0 at 1.14 min
  1.25  [Playtest] finished armwin team 0 at 1.25 min
  1.27  [AIR][Capacity] own=8/64 usage=6/37 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1118 E=61 bank=999 pull=37 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=1 committed=40/175
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.36  [Playtest] finished armwin team 0 at 1.36 min
  1.37  [AIR][Starter] nearby distance=128
  1.37  [AIR][Rule] opening.plant builder=2274
  1.38  [AIR][Layout] cluster=0 labs=6 at=2727,11425
  1.38  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 support=12 zone=140
  1.40  [AIR][EcoLayout] reserved air.eco.1 reactor=1536,11920 converters=8 support=12 zone=162
  1.42  [AIR][EcoLayout] reserved air.eco.2 reactor=3200,11408 converters=8 support=12 zone=187
  1.43  [AIR][EcoLayout] reserved air.eco.3 reactor=3712,11152 converters=8 support=12 zone=210
  1.43  [AIR][Capacity] own=8/95 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1079 E=98 bank=948 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=528/894
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=1029 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.60  [AIR][Capacity] own=8/88 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=810 E=88 bank=944 pull=69 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=170/288
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=1029 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.68  [Playtest] finished armap team 0 at 1.68 min
  1.68  [AIR][Claim] cancel unowned native order armnanotc
  1.68  [AIR][Claim] cancel unowned native order armnanotc
  1.68  [AIR][State] T1_CONTEST
  1.69  [AIR][Produce] opening.scout armpeep plant=1029 projected=1/1
  1.69  [AIR][Rule] opening.commander.guard builder=2274
  1.77  [AIR][Capacity] own=8/89 usage=8/258 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=8 bank=670 E=88 bank=633 pull=258 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  1.82  [AIR][Produce] constructor.recovery armca plant=1029 projected=1/3
  1.93  [AIR][Capacity] own=4/94 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=688 E=94 bank=8 pull=147 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 670/1250, energy +123.4 bank 7/1102, units 12
  2.10  [AIR][Capacity] own=2/115 usage=0/15 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=668 E=108 bank=8 pull=168 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.13  [AIR][Produce] constructor.recovery armca plant=1029 projected=2/3
  2.13  [AIR][Rule] recovery.energy builder=16396
  2.27  [AIR][Capacity] own=4/124 usage=2/9 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=119 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=683 E=124 bank=807 pull=198 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=143/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=219 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.37  [AIR][Produce] constructor.recovery armca plant=1029 projected=3/3
  2.37  [AIR][Rule] mex.expand builder=9316
  2.43  [AIR][Capacity] own=8/128 usage=2/8 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=49 shortage=182 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST M=8 bank=664 E=129 bank=1140 pull=197 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=163/500
  2.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=332 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.59  [AIR][Produce] opening.screen armfig plant=1029 projected=1/6
  2.59  [AIR][Rule] mex.assist builder=481
  2.60  [AIR][Capacity] own=8/132 usage=10/134 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=126 reason=funded workload
  2.60  [AIR][Economy] T1_CONTEST M=8 bank=626 E=133 bank=794 pull=134 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=127/436
  2.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=276 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.67  [AIR][Commander] cleared factory guard for commander.energy.local
  2.67  [AIR][Rule] commander.energy.local builder=2274
  2.77  [AIR][Capacity] own=3/138 usage=12/94 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=595 E=134 bank=138 pull=94 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=91/337
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.78  [Playtest] finished armwin team 0 at 2.78 min
  2.80  [AIR][Rule] commander.factory.guard builder=2274
  2.89  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.89  [AIR][Rule] commander.idle.assist builder=2274
  2.90  [AIR][Produce] opening.screen armfig plant=1029 projected=2/6
  2.90  [AIR][Screen] fighters=1 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  2.92  [AIR][Rule] commander.factory.guard builder=2274
  2.93  [AIR][Capacity] own=3/139 usage=6/61 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=16 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=581 E=139 bank=430 pull=61 plants=1/0 aircraftDemand=3/127
  2.93  [AIR][Projects] energyQueued=0 committed=31/73
  2.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=166 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.98  [Playtest] finished armmex team 0 at 2.98 min
  2.99  [AIR][Rule] recovery.energy builder=9316
  3.00  [AIR][Rule] recovery.energy builder=481
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.1 bank 574/1300, energy +158.8 bank 95/1178, units 18
  3.07  [Playtest] finished armsolar team 0 at 3.07 min
  3.07  [AIR][Screen] fighters=1 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.10  [AIR][Capacity] own=7/154 usage=5/234 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=171 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=584 E=158 bank=88 pull=322 plants=1/0 aircraftDemand=3/124
  3.10  [AIR][Projects] energyQueued=2 committed=464/0
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=321 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=71
  3.13  [AIR][Produce] opening.screen armfig plant=1029 projected=3/6
  3.23  [AIR][Screen] fighters=2 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.27  [AIR][Capacity] own=4/135 usage=12/135 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=577 E=140 bank=13 pull=335 plants=1/0 aircraftDemand=3/125
  3.27  [AIR][Projects] energyQueued=0 committed=398/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.38  [AIR][Layout] cluster=1 labs=1 at=2727,11041
  3.40  [AIR][Screen] fighters=2 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.43  [AIR][Capacity] own=3/134 usage=12/139 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=505 E=134 bank=10 pull=335 plants=1/0 aircraftDemand=3/125
  3.43  [AIR][Projects] energyQueued=0 committed=308/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.44  [AIR][Produce] opening.screen armfig plant=1029 projected=4/6
  3.58  [AIR][Screen] fighters=3 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=6/148 usage=12/155 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=2 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=474 E=142 bank=9 pull=306 plants=1/0 aircraftDemand=3/126
  3.60  [AIR][Projects] energyQueued=0 committed=219/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=152 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=64
  3.75  [AIR][Screen] fighters=3 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.77  [AIR][Produce] opening.screen armfig plant=1029 projected=5/6
  3.77  [AIR][Capacity] own=6/156 usage=12/162 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=422 E=156 bank=30 pull=326 plants=1/0 aircraftDemand=3/126
  3.77  [AIR][Projects] energyQueued=0 committed=129/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Capacity] own=3/164 usage=11/127 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=1 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=381 E=162 bank=52 pull=227 plants=1/0 aircraftDemand=3/126
  3.93  [AIR][Projects] energyQueued=0 committed=40/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=151 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Screen] fighters=4 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  3.96  [Playtest] finished armsolar team 0 at 3.96 min
  3.97  [AIR][Rule] intel.radar builder=16396
  4.00  [Playtest] eco team 0 at 4.0 min: metal +7.8 bank 613/1300, energy +198.2 bank 1/1278, units 24
  4.02  [Playtest] finished armsolar team 0 at 4.02 min
  4.04  [AIR][Rule] wait builder=9316
  4.04  [Playtest] finished armsolar team 0 at 4.04 min
  4.05  [AIR][Produce] opening.screen armfig plant=1029 projected=6/6
  4.05  [AIR][Rule] project.assist builder=481
  4.10  [AIR][Rule] project.assist builder=9316
  4.10  [AIR][Capacity] own=4/174 usage=10/285 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=623 E=172 bank=300 pull=285 plants=1/0 aircraftDemand=3/126
  4.10  [AIR][Projects] energyQueued=0 committed=45/478
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=58
  4.12  [AIR][Screen] fighters=5 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.26  [Playtest] finished armrad team 0 at 4.26 min
  4.27  [AIR][Capacity] own=2/238 usage=9/243 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=573 E=236 bank=0 pull=438 plants=1/0 aircraftDemand=3/126
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Rule] wait builder=16396
  4.28  [AIR][Rule] wait builder=9316
  4.28  [AIR][Rule] wait builder=481
  4.28  [AIR][Screen] fighters=5 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.39  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.39  [AIR][Rule] commander.idle.wait builder=2274
  4.43  [AIR][Capacity] own=3/238 usage=0/12 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=655 E=238 bank=1347 pull=12 plants=1/0 aircraftDemand=3/126
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=1029 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [AIR][Screen] fighters=6 cells=8 centre=1088,10089 width=600 advance=400 responding=false
  4.52  [AIR][Layout] repaired support air.bay.6 viable=1/5 slot=317 at=1784,11640
  4.52  [AIR][Rule] opening.support builder=16396
  4.53  [AIR][Wind] cluster=1 slots=6 at=2424,11936 local=false builder=9316
  4.53  [AIR][Rule] energy.grow builder=9316
  4.53  [AIR][Rule] energy.grow builder=481
  4.54  [AIR][Rule] commander.idle.energy builder=2274
  4.55  [AIR][Produce] recon.replace armpeep plant=1029 projected=1/1
  4.60  [AIR][Capacity] own=11/238 usage=3/96 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=235 reason=funded workload
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=764 E=238 bank=1309 pull=96 plants=1/0 aircraftDemand=3/126
  4.60  [AIR][Projects] energyQueued=1 committed=345/3692
  4.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=385 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 3334 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(2274) at (2175, 11785) walks to (2216, 11852), 136 from the armmex site (2288, 11968)
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
  0.08  EXP: approach: armcom(1901) at (814, 10380) walks to (789, 10291), 136 from the armmex site (752, 10160)
  0.09  EXP: approach: corcom(24492) at (10102, 513) walks to (10077, 461), 139 from the cormex site (10016, 336)
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
  0.09  EXP: approach: legcom(17070) at (11479, 1952) walks to (11503, 2016), 137 from the legmex site (11552, 2144)
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
