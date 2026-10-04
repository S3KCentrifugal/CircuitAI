# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54002); wall 251 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:52:50
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glacial\runs\20261003T175705Z-957a7fa7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=993 E=0 bank=955 pull=80 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 1 turret(s) in range of the reclaim of armlab 8999 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 5.4 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of armlab 8999 are not on it
- forbid 'invariant' hit at 14.8 min: [INVARIANT] INV-010 combat unit legstr 2419 produced at +91 metal under the gate 200
- forbid 'invariant' hit at 15.5 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (1616, 2560) not upgraded
- forbid 'invariant' hit at 16.5 min: [INVARIANT] INV-022 a new set of armmmkr starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 16.6 min: [INVARIANT] INV-010 combat unit armsptk 15607 produced at +79 metal under the gate 200
- forbid 'invariant' hit at 17.3 min: [INVARIANT] INV-010 combat unit legsrail 7406 produced at +106 metal under the gate 200
- forbid 'invariant' hit at 19.7 min: [INVARIANT] INV-010 combat unit legsrail 19513 produced at +97 metal under the gate 200
- forbid 'invariant' hit at 20.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 20.7 min: [INVARIANT] INV-010 combat unit armsptk 23485 produced at +159 metal under the gate 200
- forbid 'invariant' hit at 21.1 min: [INVARIANT] INV-010 combat unit legsrail 13242 produced at +101 metal under the gate 200
- forbid 'invariant' hit at 21.8 min: [INVARIANT] INV-010 combat unit armsptk 23274 produced at +120 metal under the gate 200
- forbid 'invariant' hit at 22.2 min: [INVARIANT] INV-010 combat unit legsrail 16461 produced at +121 metal under the gate 200
- forbid 'invariant' hit at 22.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 22.8 min: [INVARIANT] INV-010 combat unit armsptk 6780 produced at +114 metal under the gate 200
- forbid 'invariant' hit at 23.4 min: [INVARIANT] INV-010 combat unit legsrail 31300 produced at +175 metal under the gate 200
- forbid 'invariant' hit at 23.9 min: [INVARIANT] INV-010 combat unit armsptk 26039 produced at +154 metal under the gate 200
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-010 combat unit legsrail 17963 produced at +190 metal under the gate 200
- forbid 'invariant' hit at 24.9 min: [INVARIANT] INV-010 combat unit armsptk 17746 produced at +152 metal under the gate 200
- forbid 'invariant' hit at 25.1 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 2032 elmos away, not flush (160)
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-010 combat unit armfast 17158 produced at +138 metal under the gate 200
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-010 combat unit armpw 16457 produced at +124 metal under the gate 200
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 14970 (56 by power), bank 129 + 238/s (0 by metal))
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-010 combat unit armsptk 30448 produced at +141 metal under the gate 200
- forbid 'invariant' hit at 26.1 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 2032 elmos away, not flush (160)
- forbid 'invariant' hit at 26.1 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (3 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 26.4 min: [INVARIANT] INV-029 armap 6036 stands 17 cells from the turrets, not tight
- forbid 'invariant' hit at 26.7 min: [INVARIANT] INV-010 combat unit armpw 10763 produced at +109 metal under the gate 200
- forbid 'invariant' hit at 27.0 min: [INVARIANT] INV-010 combat unit armsptk 7549 produced at +190 metal under the gate 200
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 2032 elmos away, not flush (160)
- forbid 'invariant' hit at 27.7 min: [INVARIANT] INV-010 combat unit armpw 6272 produced at +186 metal under the gate 200
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-010 combat unit armsptk 13621 produced at +187 metal under the gate 200
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 2032 elmos away, not flush (160)
- forbid 'invariant' hit at 28.3 min: [INVARIANT] INV-039 T1 land constructors released 372 s, 1 spam labs of 2 wanted, no forward order for 180 s
- forbid 'invariant' hit at 28.3 min: [INVARIANT] INV-010 combat unit armfast 7332 produced at +189 metal under the gate 200
- forbid 'invariant' hit at 28.7 min: [INVARIANT] INV-010 combat unit armpw 5768 produced at +176 metal under the gate 200
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.0 min: [t=00:03:46.134083][f=0052190] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 2032 elmos away, not flush (160)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-014 legadveconv packed at (12880, 1232) with no turret slot within 450

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glacial\runs\20261003T175705Z-957a7fa7\screen_2026-10-03_17-53-56-660.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glacial\runs\20261003T175705Z-957a7fa7\screen_2026-10-03_17-54-46-086.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glacial\runs\20261003T175705Z-957a7fa7\screen_2026-10-03_17-55-10-461.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glacial\runs\20261003T175705Z-957a7fa7\screen_2026-10-03_17-57-04-705.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Capacity] own=2/30 usage=8/80 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=993 E=0 bank=955 pull=80 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|cortex|corap|489|1141|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(1810,1411) factory=armlab landLocked=no spot=1 known=1/1
  0.18  [Playtest] finished cormex team 0 at 0.18 min
  0.18  [Team][Roster] first mex 2114 at 496,1295
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|489|1141|0|0|1|496|1295
  0.18  [Team][Roster] team 1 first mex at 1952,1408
  0.20  [AIR][Rule] opening.mex builder=26153
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=961 E=18 bank=630 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=23/232
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.31  [Playtest] finished cormex team 0 at 0.31 min
  0.43  [AIR][Capacity] own=3/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=951 E=30 bank=254 pull=86 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=11/112
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.46  [Playtest] finished cormex team 0 at 0.46 min
  0.47  [AIR][Rule] recovery.energy builder=26153
  0.60  [AIR][Capacity] own=5/30 usage=16/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=903 E=30 bank=340 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=31/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.63  [Playtest] finished corsolar team 0 at 0.63 min
  0.65  [AIR][Wind] cluster=0 slots=6 at=352,1272 local=false builder=26153
  0.65  [AIR][Rule] opening.energy builder=26153
  0.77  [AIR][Capacity] own=7/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=918 E=30 bank=596 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=16/68
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.80  [Playtest] finished corwin team 0 at 0.80 min
  0.92  [Playtest] finished corwin team 0 at 0.92 min
  0.93  [AIR][Capacity] own=7/50 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=932 E=50 bank=739 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 945/1150, energy +53.0 bank 846/1051, units 8
  1.04  [Playtest] finished corwin team 0 at 1.04 min
  1.10  [AIR][Capacity] own=7/52 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=957 E=52 bank=977 pull=40 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=24/99
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.15  [Playtest] finished corwin team 0 at 1.15 min
  1.27  [AIR][Capacity] own=7/61 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=970 E=59 bank=1026 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=1/5
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [Playtest] finished corwin team 0 at 1.27 min
  1.39  [Playtest] finished corwin team 0 at 1.39 min
  1.40  [AIR][Starter] nearby distance=128
  1.40  [AIR][Rule] opening.plant builder=26153
  1.42  [AIR][Layout] cluster=0 labs=6 at=945,925
  1.42  [AIR][EcoLayout] reserved air.eco.0 reactor=352,1776 converters=8 support=12 zone=140
  1.43  [AIR][EcoLayout] reserved air.eco.1 reactor=352,752 converters=8 support=12 zone=417
  1.43  [AIR][Capacity] own=7/89 usage=15/35 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=983 E=87 bank=1050 pull=35 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=580/1014
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=8241 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.45  [AIR][EcoLayout] reserved air.eco.2 reactor=736,2288 converters=8 support=12 zone=439
  1.47  [AIR][EcoLayout] reserved air.eco.3 reactor=736,1392 converters=8 support=12 zone=461
  1.60  [AIR][Capacity] own=7/151 usage=35/70 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=712 E=139 bank=1040 pull=70 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=229/400
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=8241 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.71  [Playtest] finished corap team 0 at 1.71 min
  1.72  [AIR][Claim] cancel unowned native order cornanotc
  1.72  [AIR][State] T1_CONTEST
  1.72  [AIR][Produce] opening.scout corfink plant=8241 projected=1/1
  1.72  [AIR][Rule] opening.commander.guard builder=26153
  1.77  [AIR][Capacity] own=7/161 usage=1/39 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=7 bank=527 E=161 bank=1143 pull=39 plants=1/0 aircraftDemand=3/123
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.85  [AIR][Produce] constructor.recovery corca plant=8241 projected=1/3
  1.93  [AIR][Capacity] own=7/150 usage=1/30 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST M=7 bank=530 E=154 bank=852 pull=199 plants=1/0 aircraftDemand=3/123
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=55 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 522/1250, energy +144.2 bank 908/1153, units 14
  2.08  [AIR][Produce] constructor.recovery corca plant=8241 projected=2/3
  2.08  [AIR][Rule] mex.expand builder=15289
  2.10  [AIR][Capacity] own=7/143 usage=0/25 gifts=0 sent=0 excess=0 pressure=false mobile=55 arriving=55 idle=0 ecoStatic=0 working=0 shortage=200 reason=funded workload
  2.10  [AIR][Economy] T1_CONTEST M=7 bank=522 E=143 bank=1089 pull=25 plants=1/0 aircraftDemand=3/123
  2.10  [AIR][Projects] energyQueued=0 committed=49/497
  2.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=310 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=7/154 usage=1/23 gifts=0 sent=0 excess=0 pressure=false mobile=55 arriving=55 idle=0 ecoStatic=0 working=55 shortage=108 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST M=7 bank=505 E=150 bank=1060 pull=214 plants=1/0 aircraftDemand=3/123
  2.27  [AIR][Projects] energyQueued=0 committed=35/350
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=218 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.31  [AIR][Produce] constructor.recovery corca plant=8241 projected=3/3
  2.32  [AIR][Rule] mex.assist builder=21627
  2.43  [AIR][Capacity] own=7/168 usage=5/80 gifts=0 sent=0 excess=0 pressure=false mobile=110 arriving=55 idle=0 ecoStatic=0 working=109 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=484 E=167 bank=1190 pull=228 plants=1/0 aircraftDemand=3/123
  2.43  [AIR][Projects] energyQueued=0 committed=11/111
  2.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.50  [Playtest] finished cormex team 0 at 2.50 min
  2.51  [AIR][Wind] cluster=1 slots=6 at=880,1144 local=false builder=21627
  2.51  [AIR][Rule] energy.grow builder=21627
  2.54  [AIR][Produce] opening.screen corveng plant=8241 projected=1/6
  2.55  [AIR][Layout] repaired support air.bay.6 viable=2/5 slot=1977 at=424,984
  2.55  [AIR][Rule] opening.support builder=15495
  2.60  [AIR][Capacity] own=7/173 usage=6/272 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=54 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=483 E=173 bank=1215 pull=305 plants=1/0 aircraftDemand=3/123
  2.60  [AIR][Projects] energyQueued=0 committed=316/3799
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.60  [AIR][Rule] commander.factory.guard builder=26153
  2.75  [AIR][Produce] opening.screen corveng plant=8241 projected=2/6
  2.75  [AIR][Screen] fighters=1 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  2.77  [AIR][Capacity] own=2/153 usage=2/44 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=157 shortage=103 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=464 E=156 bank=119 pull=97 plants=1/0 aircraftDemand=4/131
  2.77  [AIR][Projects] energyQueued=0 committed=277/3402
  2.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=268 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  2.92  [AIR][Screen] fighters=1 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=5/139 usage=4/128 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=91 shortage=44 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=480 E=142 bank=6 pull=303 plants=1/0 aircraftDemand=4/131
  2.93  [AIR][Projects] energyQueued=0 committed=243/3070
  2.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=209 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 492/1300, energy +138.1 bank 0/1228, units 22
  3.08  [AIR][Screen] fighters=1 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  3.10  [AIR][Capacity] own=6/134 usage=2/101 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=54 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=504 E=136 bank=5 pull=303 plants=1/0 aircraftDemand=4/131
  3.10  [AIR][Projects] energyQueued=0 committed=214/2780
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=219 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.13  [Playtest] finished corwin team 0 at 3.13 min
  3.14  [AIR][Rule] recovery.energy builder=21627
  3.21  [AIR][Produce] opening.screen corveng plant=8241 projected=3/6
  3.25  [AIR][Screen] fighters=2 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  3.27  [AIR][Capacity] own=7/130 usage=8/201 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=91 shortage=87 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=535 E=134 bank=0 pull=361 plants=1/0 aircraftDemand=4/131
  3.27  [AIR][Projects] energyQueued=0 committed=325/2465
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=252 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.42  [AIR][Layout] cluster=1 labs=1 at=1329,925
  3.42  [AIR][Screen] fighters=2 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  3.43  [AIR][Capacity] own=4/150 usage=6/138 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=93 shortage=62 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=525 E=148 bank=1 pull=347 plants=1/0 aircraftDemand=4/131
  3.43  [AIR][Projects] energyQueued=0 committed=279/2236
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=227 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.58  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.58  [AIR][Rule] commander.idle.assist builder=26153
  3.58  [AIR][Screen] fighters=2 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  3.59  [AIR][Produce] opening.screen corveng plant=8241 projected=4/6
  3.60  [AIR][Capacity] own=5/165 usage=4/74 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=157 shortage=203 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=535 E=160 bank=175 pull=171 plants=1/0 aircraftDemand=4/131
  3.60  [AIR][Projects] energyQueued=0 committed=229/1954
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=368 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.67  [Playtest] finished corsolar team 0 at 3.67 min
  3.68  [AIR][Rule] commander.factory.guard builder=26153
  3.77  [AIR][Capacity] own=9/161 usage=14/405 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=3 reason=funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=462 E=165 bank=725 pull=438 plants=1/0 aircraftDemand=4/131
  3.77  [AIR][Projects] energyQueued=0 committed=255/1475
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=168 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Screen] fighters=3 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  3.80  [AIR][Produce] opening.screen corveng plant=8241 projected=5/6
  3.93  [AIR][Capacity] own=9/175 usage=14/405 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=420 E=175 bank=383 pull=438 plants=1/0 aircraftDemand=4/131
  3.93  [AIR][Projects] energyQueued=0 committed=187/996
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.95  [AIR][Screen] fighters=4 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  3.97  [AIR][Produce] opening.screen corveng plant=8241 projected=6/6
  3.97  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.97  [AIR][Rule] commander.idle.assist builder=26153
  3.99  [AIR][Rule] commander.factory.guard builder=26153
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 411/1300, energy +175.5 bank 412/1278, units 28
  4.10  [AIR][Capacity] own=9/175 usage=12/354 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=115 shortage=21 reason=funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=387 E=175 bank=25 pull=385 plants=1/0 aircraftDemand=4/131
  4.10  [AIR][Projects] energyQueued=0 committed=122/552
  4.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=186 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.12  [AIR][Screen] fighters=5 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  4.19  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.19  [AIR][Rule] commander.idle.assist builder=26153
  4.20  [Playtest] finished cormex team 0 at 4.20 min
  4.21  [AIR][Rule] recovery.energy builder=15289
  4.26  [AIR][Produce] constructor.expand corca plant=8241 projected=4/4
  4.27  [AIR][Capacity] own=5/183 usage=11/15 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=55 idle=0 ecoStatic=0 working=409 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=396 E=179 bank=602 pull=48 plants=1/0 aircraftDemand=4/131
  4.27  [AIR][Projects] energyQueued=1 committed=199/275
  4.27  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=8241 BP=150 nanos=0+1/0 available=yes firstSlot=2
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.29  [Playtest] finished corsolar team 0 at 4.29 min
  4.30  [AIR][Screen] fighters=6 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  4.31  [AIR][Rule] commander.factory.guard builder=26153
  4.41  [Playtest] finished cornanotc team 0 at 4.41 min
  4.42  [AIR][Rule] mex.expand builder=15495
  4.43  [AIR][Capacity] own=12/210 usage=1/0 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=55 idle=0 ecoStatic=0 working=109 shortage=199 reason=funded workload
  4.43  [AIR][Economy] T1_CONTEST M=11 bank=360 E=207 bank=1311 pull=138 plants=1/0 aircraftDemand=8/296
  4.43  [AIR][Projects] energyQueued=0 committed=311/500
  4.43  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=419 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=8241 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.47  [AIR][Screen] fighters=6 cells=8 centre=2209,1410 width=600 advance=400 responding=false
  4.50  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.50  [AIR][Rule] commander.idle.assist builder=26153
  4.50  [AIR][Produce] air.control corveng plant=8241 projected=7/7
  4.51  [AIR][Rule] energy.grow builder=19797
  4.52  [AIR][Rule] commander.factory.guard builder=26153
  4.60  [AIR][Capacity] own=12/233 usage=21/568 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=219 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=12 bank=309 E=232 bank=108 pull=568 plants=1/0 aircraftDemand=8/296
  4.60  [AIR][Projects] energyQueued=0 committed=291/648
  4.60  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 3657 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: corcom(26153) at (489, 1141) walks to (490, 1157), 139 from the cormex site (496, 1296)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (1688, 1688) facing 1, 63x77 cells: 4441 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2184, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2136, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2088, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2040, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (2264, 1448) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (2536, 1368) facing 1, 29x41 cells: 1153 of 1189 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2760, 1368) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2712, 1368) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2664, 1368) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2616, 1368) facing 1: 8 of 13 slots (group 6, held, zone)
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
  0.10  EXP: idle: corcom(26153) on cormex at (489, 1151), site (496, 1296), target yes, fails 2 (arrived at the approach point)
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
  0.22  EXP: approach: corcom(28807) at (13991, 1047) walks to (13966, 1035), 139 from the cormex site (13840, 976)
  0.25  RESERVE: armalab at (3512, 2760) facing 1 (id 115)
  0.25  RESERVE: zone 16 at (3392, 2760) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3440, 2760) facing 1: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 17 at (3464, 2760) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (3760, 2760) facing 1, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (3104, 928) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 928) facing 0 (id 120)
  0.25  RESERVE: zone 20 at (3104, 960) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 960) facing 0 (id 121)
  0.25  RESERVE: zone 21 at (3104, 992) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 992) facing 0 (id 122)
  0.25  RESERVE: zone 22 at (3104, 1024) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1024) facing 0 (id 123)
  0.25  RESERVE: zone 23 at (3104, 1056) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1056) facing 0 (id 124)
  0.25  RESERVE: zone 24 at (3104, 1088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1088) facing 0 (id 125)
  0.25  RESERVE: zone 25 at (3104, 1120) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1120) facing 0 (id 126)
  0.25  RESERVE: zone 26 at (3104, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1152) facing 0 (id 127)
  0.25  RESERVE: zone 27 at (3104, 1184) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1184) facing 0 (id 128)
  0.25  RESERVE: zone 28 at (3104, 1216) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1216) facing 0 (id 129)
  0.25  RESERVE: zone 29 at (3104, 1248) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1248) facing 0 (id 130)
  0.25  RESERVE: zone 30 at (3104, 1568) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1568) facing 0 (id 131)
  0.25  RESERVE: zone 31 at (3104, 1600) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1600) facing 0 (id 132)
  0.25  RESERVE: zone 32 at (3104, 1632) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1632) facing 0 (id 133)
  0.25  RESERVE: zone 33 at (3104, 1664) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1664) facing 0 (id 134)
  0.25  RESERVE: zone 34 at (3104, 1696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1696) facing 0 (id 135)
  0.25  RESERVE: zone 35 at (3104, 1728) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1728) facing 0 (id 136)
  0.25  RESERVE: zone 36 at (3104, 1760) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1760) facing 0 (id 137)
  0.25  RESERVE: zone 37 at (3104, 1792) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1792) facing 0 (id 138)
  0.25  RESERVE: zone 38 at (3104, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1824) facing 0 (id 139)
  0.25  RESERVE: zone 39 at (3104, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1856) facing 0 (id 140)
  0.25  RESERVE: zone 40 at (3104, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1888) facing 0 (id 141)
  0.25  RESERVE: zone 41 at (2992, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (2992, 1152) facing 0 (id 142)
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
  0.25  RESERVE: legdrag at (11312, 1792) facing 0 (id 128)
  0.25  RESERVE: zone 23 at (11312, 1760) facing 0, 2x2 cells: 4 of 4 held
```
