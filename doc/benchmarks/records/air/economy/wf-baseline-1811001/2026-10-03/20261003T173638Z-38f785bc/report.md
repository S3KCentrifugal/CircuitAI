# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54059); wall 265 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:32:10
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\glacial\runs\20261003T173638Z-38f785bc\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=992 E=0 bank=989 pull=83 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-052 ferry run for cargo 29422 unloading for 16 s` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 7.8 min: [INVARIANT] INV-052 ferry run for cargo 29422 unloading for 16 s
- forbid 'invariant' hit at 13.3 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of armalab 29339 are not on it
- forbid 'invariant' hit at 13.7 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (12576, 2720) not upgraded
- forbid 'invariant' hit at 19.2 min: [INVARIANT] INV-010 combat unit legstr 30979 produced at +115 metal under the gate 200
- forbid 'invariant' hit at 19.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 21.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 21.7 min: [t=00:02:10.677755][f=0039146] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 23.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.8 min: [INVARIANT] INV-010 combat unit legstr 22895 produced at +196 metal under the gate 200
- forbid 'invariant' hit at 23.8 min: [INVARIANT] INV-010 combat unit legsrail 17044 produced at +196 metal under the gate 200
- forbid 'invariant' hit at 24.4 min: [INVARIANT] INV-039 T1 land constructors released 278 s, 0 spam labs of 2 wanted, no forward order for 180 s
- forbid 'invariant' hit at 24.6 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 15390 (58 by power), bank 127 + 240/s (0 by metal))
- forbid 'invariant' hit at 24.9 min: [INVARIANT] INV-001 a retiring factory produced legstr 10679
- forbid 'invariant' hit at 24.9 min: [INVARIANT] INV-016 the advanced lab 1583 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 24.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 400 elmos away, not flush (160)
- forbid 'invariant' hit at 24.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 25.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.4 min: [INVARIANT] INV-010 combat unit armsptk 9404 produced at +163 metal under the gate 200
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-010 combat unit leggob 1473 produced at +196 metal under the gate 200
- forbid 'invariant' hit at 25.6 min: [t=00:02:54.428411][f=0046033] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-010 combat unit legsrail 15552 produced at +194 metal under the gate 200
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-004 metal floating at 5100 of 5100 for 60 s while armmmkr is under construction and static build power 480 is under 3107
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-011 metal floating at 5100 of 5100 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-016 the advanced lab 1583 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 400 elmos away, not flush (160)
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-010 combat unit armsptk 20374 produced at +10 metal under the gate 200
- forbid 'invariant' hit at 26.9 min: [INVARIANT] INV-016 the advanced lab 1583 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 26.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 400 elmos away, not flush (160)
- forbid 'invariant' hit at 26.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 27.3 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 27.4 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 1 T2 constructors, none added
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-016 the advanced lab 1583 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 400 elmos away, not flush (160)
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 28.1 min: [t=00:03:40.111634][f=0050648] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 28.3 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 28.4 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 1 T2 constructors, none added
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-016 the advanced lab 1583 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 17515 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-014 legadveconv packed at (12880, 1232) with no turret slot within 450
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 10 cell(s) from the turrets, not flush

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\glacial\runs\20261003T173638Z-38f785bc\screen_2026-10-03_17-33-06-796.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\glacial\runs\20261003T173638Z-38f785bc\screen_2026-10-03_17-33-42-781.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\glacial\runs\20261003T173638Z-38f785bc\screen_2026-10-03_17-34-12-518.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\glacial\runs\20261003T173638Z-38f785bc\screen_2026-10-03_17-36-37-240.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
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
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=992 E=0 bank=989 pull=83 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=302 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(1850,1404) factory=armlab landLocked=no spot=1 known=1/1
  0.18  [Playtest] finished armmex team 0 at 0.18 min
  0.18  [Team][Roster] first mex 12607 at 496,1296
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|496|1296
  0.19  [AIR][Rule] opening.mex builder=2274
  0.22  [Team][Roster] team 1 first mex at 1952,1408
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=968 E=18 bank=687 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=22/222
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=309 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.31  [Playtest] finished armmex team 0 at 0.31 min
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=959 E=30 bank=293 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=9/97
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=389 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.45  [Playtest] finished armmex team 0 at 0.45 min
  0.47  [AIR][Rule] recovery.energy builder=2274
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=902 E=30 bank=404 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=22/0
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=412 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.62  [Playtest] finished armsolar team 0 at 0.62 min
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=818 E=30 bank=794 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=13/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [Playtest] finished armsolar team 0 at 0.78 min
  0.79  [AIR][Wind] cluster=0 slots=6 at=352,1272 local=false builder=2274
  0.79  [AIR][Rule] opening.energy builder=2274
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=849 E=50 bank=1055 pull=41 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=14/63
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.96  [Playtest] finished armwin team 0 at 0.96 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 860/1150, energy +84.3 bank 1091/1100, units 8
  1.07  [Playtest] finished armwin team 0 at 1.07 min
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=867 E=70 bank=1056 pull=22 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=37/161
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=463 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.18  [Playtest] finished armwin team 0 at 1.18 min
  1.20  [AIR][Starter] nearby distance=127
  1.20  [AIR][Rule] opening.plant builder=2274
  1.20  [AIR][Layout] cluster=0 labs=6 at=178,1881
  1.20  [AIR][EcoLayout] reserved air.eco.0 reactor=480,752 converters=8 zone=128
  1.22  [AIR][EcoLayout] reserved air.eco.1 reactor=736,2288 converters=8 zone=138
  1.23  [AIR][EcoLayout] reserved air.eco.2 reactor=992,880 converters=8 zone=151
  1.25  [AIR][EcoLayout] reserved air.eco.3 reactor=352,2672 converters=8 zone=161
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=803 E=96 bank=1099 pull=69 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=511/865
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=6347 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.37  [AIR][Layout] cluster=1 labs=6 at=1330,1017
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=525 E=116 bank=1048 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=153/260
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=6347 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.50  [Playtest] finished armap team 0 at 1.50 min
  1.52  [AIR][Produce] opening.scout armpeep plant=6347 projected=1/1
  1.52  [AIR][Rule] opening.commander.guard builder=2274
  1.52  [AIR][Claim] cancel unowned native order armpeep
  1.52  [AIR][State] T1_CONTEST
  1.60  [AIR][Economy] T1_CONTEST M=7 bank=389 E=106 bank=600 pull=258 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.65  [AIR][Produce] constructor.recovery armca plant=6347 projected=1/3
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=401 E=93 bank=0 pull=134 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=191 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=440 E=86 bank=2 pull=134 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=191 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 459/1250, energy +85.6 bank 2/1201, units 12
  2.03  [AIR][Produce] constructor.recovery armca plant=6347 projected=2/3
  2.03  [AIR][Rule] recovery.energy builder=7123
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=478 E=85 bank=11 pull=195 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=150/0
  2.10  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=480 E=90 bank=0 pull=172 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=120/0
  2.27  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=182 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.42  [AIR][Produce] constructor.recovery armca plant=6347 projected=3/3
  2.42  [AIR][Rule] recovery.energy builder=15154
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=474 E=97 bank=294 pull=84 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=1 committed=245/0
  2.43  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=172 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=432 E=112 bank=534 pull=197 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=196/0
  2.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=177 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.66  [AIR][Produce] opening.screen armfig plant=6347 projected=1/6
  2.66  [AIR][Rule] recovery.assist builder=4518
  2.69  [AIR][Rule] commander.factory.guard builder=2274
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=366 E=125 bank=123 pull=328 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=124/0
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.82  [Playtest] finished armsolar team 0 at 2.82 min
  2.84  [AIR][Rule] recovery.assist builder=7123
  2.85  [AIR][Produce] opening.screen armfig plant=6347 projected=2/6
  2.85  [AIR][Screen] fighters=1 cells=8 centre=2250,1403 width=600 advance=400 responding=false
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=331 E=129 bank=0 pull=220 plants=1/0 aircraftDemand=3/127
  2.93  [AIR][Projects] energyQueued=0 committed=56/0
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +7.0 bank 304/1250, energy +140.2 bank 6/1326, units 18
  3.02  [AIR][Screen] fighters=1 cells=8 centre=2250,1403 width=600 advance=400 responding=false
  3.04  [Playtest] finished armsolar team 0 at 3.04 min
  3.05  [AIR][Rule] mex.expand builder=4518
  3.06  [AIR][Rule] intel.radar builder=7123
  3.06  [AIR][Rule] wait builder=15154
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=304 E=140 bank=8 pull=257 plants=1/0 aircraftDemand=3/127
  3.10  [AIR][Projects] energyQueued=0 committed=110/1130
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=172 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.12  [AIR][Rule] project.assist builder=15154
  3.18  [AIR][Commander] cleared factory guard for commander.idle.wait
  3.18  [AIR][Rule] commander.idle.wait builder=2274
  3.18  [AIR][Screen] fighters=1 cells=8 centre=2250,1403 width=600 advance=400 responding=false
  3.19  [AIR][Produce] opening.screen armfig plant=6347 projected=3/6
  3.21  [AIR][Rule] commander.factory.guard builder=2274
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=323 E=158 bank=0 pull=398 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=81/836
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=177 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.37  [AIR][Screen] fighters=2 cells=8 centre=2250,1403 width=600 advance=400 responding=false
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=317 E=155 bank=3 pull=332 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=57/588
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=105 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.53  [AIR][Screen] fighters=2 cells=8 centre=2250,1403 width=600 advance=400 responding=false
  3.59  [AIR][Produce] opening.screen armfig plant=6347 projected=4/6
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=334 E=152 bank=55 pull=174 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=26/267
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=124 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.66  [Playtest] finished armrad team 0 at 3.66 min
  3.68  [AIR][Rule] wait builder=7123
  3.70  [AIR][Screen] fighters=3 cells=8 centre=2250,1403 width=600 advance=400 responding=false
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=342 E=152 bank=0 pull=325 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=8/89
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=134 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.87  [AIR][Screen] fighters=3 cells=8 centre=2250,1403 width=600 advance=400 responding=false
  3.89  [Playtest] finished armmex team 0 at 3.89 min
  3.91  [AIR][Rule] wait builder=15154
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=359 E=156 bank=34 pull=219 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=50/500
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=134 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=6347 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 5196 more
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
  0.19  EXP: approach: armcom(2274) at (490, 1150) walks to (472, 1148), 136 from the armmex site (336, 1136)
  0.22  EXP: approach: corcom(24492) at (13999, 1023) walks to (13973, 1015), 139 from the cormex site (13840, 976)
  0.23  EXP: approach: armcom(1901) at (1887, 1405) walks to (1771, 1114), 136 from the armmex site (1792, 1248)
  0.25  RESERVE: armalab at (3512, 2760) facing 1 (id 115)
  0.25  RESERVE: zone 16 at (3392, 2760) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3440, 2760) facing 1: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 17 at (3464, 2760) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (3760, 2760) facing 1, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (3152, 928) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 928) facing 0 (id 120)
  0.25  RESERVE: zone 20 at (3152, 960) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 960) facing 0 (id 121)
  0.25  RESERVE: zone 21 at (3152, 992) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 992) facing 0 (id 122)
  0.25  RESERVE: zone 22 at (3152, 1024) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1024) facing 0 (id 123)
  0.25  RESERVE: zone 23 at (3152, 1056) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1056) facing 0 (id 124)
  0.25  RESERVE: zone 24 at (3152, 1088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1088) facing 0 (id 125)
  0.25  RESERVE: zone 25 at (3152, 1120) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1120) facing 0 (id 126)
  0.25  RESERVE: zone 26 at (3152, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1152) facing 0 (id 127)
  0.25  RESERVE: zone 27 at (3152, 1184) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1184) facing 0 (id 128)
  0.25  RESERVE: zone 28 at (3152, 1216) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1216) facing 0 (id 129)
  0.25  RESERVE: zone 29 at (3152, 1248) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1248) facing 0 (id 130)
  0.25  RESERVE: zone 30 at (3152, 1568) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1568) facing 0 (id 131)
  0.25  RESERVE: zone 31 at (3152, 1600) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1600) facing 0 (id 132)
  0.25  RESERVE: zone 32 at (3152, 1632) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1632) facing 0 (id 133)
  0.25  RESERVE: zone 33 at (3152, 1664) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1664) facing 0 (id 134)
  0.25  RESERVE: zone 34 at (3152, 1696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1696) facing 0 (id 135)
  0.25  RESERVE: zone 35 at (3152, 1728) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1728) facing 0 (id 136)
  0.25  RESERVE: zone 36 at (3152, 1760) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1760) facing 0 (id 137)
  0.25  RESERVE: zone 37 at (3152, 1792) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1792) facing 0 (id 138)
  0.25  RESERVE: zone 38 at (3152, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1824) facing 0 (id 139)
  0.25  RESERVE: zone 39 at (3152, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1856) facing 0 (id 140)
  0.25  RESERVE: zone 40 at (3152, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3152, 1888) facing 0 (id 141)
  0.25  RESERVE: zone 41 at (3040, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (3040, 1152) facing 0 (id 142)
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
