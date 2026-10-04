# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54030); wall 292 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:13:49
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\glacial\runs\20261003T181845Z-a44c5125\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=993 E=0 bank=982 pull=79 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1380 (5 by power), bank 0 + 17/s (0 by metal))` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 4.9 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1380 (5 by power), bank 0 + 17/s (0 by metal))
- forbid 'invariant' hit at 5.9 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1380 (5 by power), bank 0 + 17/s (0 by metal))
- forbid 'invariant' hit at 13.6 min: [INVARIANT] INV-008 17 turret(s) in range of the reclaim of armalab 19400 are not on it
- forbid 'invariant' hit at 15.0 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (12720, 2560) not upgraded
- forbid 'invariant' hit at 19.5 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 14340 (54 by power), bank 62 + 132/s (0 by metal))
- forbid 'invariant' hit at 20.6 min: [INVARIANT] INV-011 metal floating at 15085 of 15350 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 21.2 min: [INVARIANT] INV-022 a new set of armafus starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 21.2 min: [INVARIANT] INV-010 combat unit armpw 17238 produced at +145 metal under the gate 200
- forbid 'invariant' hit at 21.4 min: [INVARIANT] INV-010 combat unit legsrail 28127 produced at +187 metal under the gate 200
- forbid 'invariant' hit at 21.6 min: [INVARIANT] INV-011 metal floating at 15389 of 15550 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 22.1 min: [INVARIANT] INV-039 T2 land constructors released 277 s, 1 mex cluster(s) without long-range AA, no defence order for 180 s
- forbid 'invariant' hit at 22.2 min: [INVARIANT] INV-022 a new set of legafus starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 22.4 min: [INVARIANT] INV-010 combat unit armpw 24894 produced at +194 metal under the gate 200
- forbid 'invariant' hit at 22.5 min: [INVARIANT] INV-010 combat unit legsrail 2804 produced at +172 metal under the gate 200
- forbid 'invariant' hit at 22.6 min: [INVARIANT] INV-022 a new set of armmmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.2 min: [INVARIANT] INV-010 combat unit armfast 31222 produced at +181 metal under the gate 200
- forbid 'invariant' hit at 23.4 min: [INVARIANT] INV-010 combat unit armpw 9782 produced at +197 metal under the gate 200
- forbid 'invariant' hit at 23.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 7 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-010 combat unit leggob 2991 produced at +199 metal under the gate 200
- forbid 'invariant' hit at 24.3 min: [INVARIANT] INV-010 combat unit legsrail 20497 produced at +187 metal under the gate 200
- forbid 'invariant' hit at 24.3 min: [INVARIANT] INV-035 dedicated 28178 (legadveconv) holds legforti
- forbid 'invariant' hit at 24.6 min: [INVARIANT] INV-031 the advanced lab 21730 retired while the advanced fusion was funded: bank 6269 + 191/s x 14 s (53% built, build power 10552) = 9039 against 8925 (85% of 10500)
- forbid 'invariant' hit at 24.8 min: [INVARIANT] INV-014 armmmkr packed at (1600, 2240) with no turret slot within 450
- forbid 'invariant' hit at 25.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-022 a new set of armmmkr starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.1 min: [INVARIANT] INV-014 armmmkr packed at (1568, 1344) with no turret slot within 450
- forbid 'invariant' hit at 26.1 min: [INVARIANT] INV-001 a retiring factory produced armfast 30085
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.7 min: [t=00:04:11.987886][f=0049823] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 27.7 min: [INVARIANT] INV-014 armmmkr packed at (1856, 2560) with no turret slot within 450
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-022 a new set of armmmkr starts 12 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-022 a new set of legafus starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-053 air constructor 7515 has done nothing for 60 s (task type 2, last rule assist.any)
- forbid 'invariant' hit at 28.8 min: [INVARIANT] INV-010 combat unit armpw 2099 produced at +186 metal under the gate 200
- forbid 'invariant' hit at 28.8 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 29.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.5 min: [t=00:04:43.583817][f=0053107] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\glacial\runs\20261003T181845Z-a44c5125\screen_2026-10-03_18-15-01-666.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\glacial\runs\20261003T181845Z-a44c5125\screen_2026-10-03_18-15-56-976.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\glacial\runs\20261003T181845Z-a44c5125\screen_2026-10-03_18-16-31-320.png

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
  0.10  [AIR][Capacity] own=2/30 usage=7/79 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=993 E=0 bank=982 pull=79 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|490|1140|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(1841,1406) factory=armlab landLocked=no spot=1 known=1/1
  0.18  [Playtest] finished legmex team 0 at 0.18 min
  0.18  [Team][Roster] first mex 8838 at 496,1296
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|490|1140|0|0|1|496|1296
  0.20  [AIR][Rule] opening.mex builder=23483
  0.22  [Team][Roster] team 1 first mex at 1952,1408
  0.27  [AIR][Capacity] own=2/30 usage=7/82 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=967 E=18 bank=689 pull=82 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=23/234
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.32  [Playtest] finished legmex team 0 at 0.31 min
  0.43  [AIR][Capacity] own=3/30 usage=7/85 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=957 E=30 bank=313 pull=85 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=11/114
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.46  [Playtest] finished legmex team 0 at 0.46 min
  0.47  [AIR][Wind] cluster=0 slots=6 at=544,1160 local=true builder=23483
  0.47  [AIR][Rule] opening.energy builder=23483
  0.58  [Playtest] finished legwin team 0 at 0.58 min
  0.59  [AIR][Rule] recovery.energy builder=23483
  0.60  [AIR][Capacity] own=5/30 usage=5/29 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=970 E=30 bank=230 pull=29 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=1 committed=150/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [Playtest] finished legsolar team 0 at 0.76 min
  0.77  [AIR][Capacity] own=7/48 usage=16/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=914 E=41 bank=642 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [AIR][Rule] opening.energy builder=23483
  0.93  [AIR][Capacity] own=7/48 usage=7/40 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=946 E=64 bank=1016 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=1/6
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.94  [Playtest] finished legwin team 0 at 0.94 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 958/1150, energy +88.0 bank 1046/1051, units 8
  1.05  [Playtest] finished legwin team 0 at 1.05 min
  1.10  [AIR][Capacity] own=7/68 usage=3/22 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=970 E=68 bank=1009 pull=22 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=32/131
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.17  [Playtest] finished legwin team 0 at 1.17 min
  1.18  [AIR][Starter] nearby distance=128
  1.18  [AIR][Rule] opening.plant builder=23483
  1.18  [AIR][Layout] cluster=0 labs=6 at=178,1884
  1.18  [AIR][EcoLayout] reserved air.eco.0 reactor=480,752 converters=8 support=12 zone=140
  1.20  [AIR][EcoLayout] reserved air.eco.1 reactor=736,2288 converters=8 support=12 zone=416
  1.22  [AIR][EcoLayout] reserved air.eco.2 reactor=992,880 converters=8 support=12 zone=438
  1.23  [AIR][EcoLayout] reserved air.eco.3 reactor=352,2672 converters=8 support=12 zone=463
  1.27  [AIR][Capacity] own=7/106 usage=20/60 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=951 E=103 bank=999 pull=60 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=351/898
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=30645 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.35  [AIR][Layout] cluster=1 labs=6 at=1330,1020
  1.43  [AIR][Capacity] own=7/125 usage=20/60 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=829 E=125 bank=1042 pull=60 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=148/381
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=30645 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.56  [Playtest] finished legap team 0 at 1.56 min
  1.57  [AIR][Claim] cancel unowned native order legnanotc
  1.57  [AIR][State] T1_CONTEST
  1.57  [AIR][Produce] opening.scout legfig plant=30645 projected=1/1
  1.57  [AIR][Rule] opening.commander.guard builder=23483
  1.60  [AIR][Capacity] own=7/119 usage=5/217 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_CONTEST M=7 bank=735 E=123 bank=845 pull=217 plants=1/0 aircraftDemand=2/115
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.66  [AIR][Produce] constructor.recovery legca plant=30645 projected=1/3
  1.66  [AIR][Scout] opening drone=31706 enemy starts=2
  1.77  [AIR][Capacity] own=7/95 usage=0/8 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=755 E=98 bank=2 pull=141 plants=1/0 aircraftDemand=2/115
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=45 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Capacity] own=7/95 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=793 E=95 bank=1 pull=141 plants=1/0 aircraftDemand=2/115
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=45 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 808/1250, energy +116.5 bank 42/1152, units 12
  2.03  [AIR][Produce] constructor.recovery legca plant=30645 projected=2/3
  2.03  [AIR][Rule] recovery.energy builder=28395
  2.10  [AIR][Capacity] own=7/111 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=45 arriving=45 idle=0 ecoStatic=0 working=0 shortage=305 reason=funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=828 E=107 bank=200 pull=165 plants=1/0 aircraftDemand=2/115
  2.10  [AIR][Projects] energyQueued=0 committed=148/0
  2.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=395 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=7/120 usage=2/9 gifts=0 sent=0 excess=0 pressure=false mobile=45 arriving=45 idle=0 ecoStatic=0 working=44 shortage=278 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=810 E=121 bank=426 pull=193 plants=1/0 aircraftDemand=2/115
  2.27  [AIR][Projects] energyQueued=0 committed=124/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=368 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.29  [AIR][Produce] constructor.recovery legca plant=30645 projected=3/3
  2.29  [AIR][Rule] recovery.energy builder=27906
  2.43  [AIR][Capacity] own=7/124 usage=4/9 gifts=0 sent=0 excess=0 pressure=false mobile=90 arriving=45 idle=0 ecoStatic=0 working=90 shortage=215 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=788 E=124 bank=921 pull=206 plants=1/0 aircraftDemand=2/115
  2.43  [AIR][Projects] energyQueued=0 committed=237/0
  2.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=350 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.52  [AIR][Produce] opening.screen legfig plant=30645 projected=2/7
  2.52  [AIR][Layout] repaired support air.bay.6 viable=4/5 slot=587 at=408,1016
  2.52  [AIR][Rule] opening.support builder=11987
  2.55  [AIR][Rule] commander.factory.guard builder=23483
  2.60  [AIR][Capacity] own=7/126 usage=13/369 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=135 shortage=20 reason=funded workload
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=747 E=126 bank=691 pull=396 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=411/3093
  2.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=155 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.63  [AIR][Produce] opening.screen legfig plant=30645 projected=3/7
  2.63  [AIR][Screen] fighters=1 cells=8 centre=2241,1405 width=600 advance=400 responding=false
  2.77  [AIR][Capacity] own=3/116 usage=7/98 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=127 shortage=63 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=706 E=117 bank=0 pull=348 plants=1/0 aircraftDemand=3/84
  2.77  [AIR][Projects] energyQueued=0 committed=344/2839
  2.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=198 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+1/0 available=yes firstSlot=2
  2.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.80  [AIR][Screen] fighters=1 cells=8 centre=2241,1405 width=600 advance=400 responding=false
  2.84  [AIR][Produce] opening.screen legfig plant=30645 projected=4/7
  2.84  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.84  [AIR][Rule] commander.idle.assist builder=23483
  2.87  [AIR][Rule] commander.factory.guard builder=23483
  2.93  [AIR][Capacity] own=3/98 usage=6/80 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=127 shortage=69 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=667 E=103 bank=0 pull=352 plants=1/0 aircraftDemand=3/96
  2.93  [AIR][Projects] energyQueued=0 committed=259/2595
  2.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=204 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+1/0 available=yes firstSlot=2
  2.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.98  [AIR][Screen] fighters=2 cells=8 centre=2241,1405 width=600 advance=400 responding=false
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 656/1250, energy +92.5 bank 3/1227, units 20
  3.10  [AIR][Capacity] own=3/91 usage=6/73 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=121 shortage=29 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=647 E=91 bank=1 pull=264 plants=1/0 aircraftDemand=3/96
  3.10  [AIR][Projects] energyQueued=0 committed=196/2382
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=164 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=71
  3.13  [Playtest] finished legsolar team 0 at 3.13 min
  3.15  [AIR][Screen] fighters=2 cells=8 centre=2241,1405 width=600 advance=400 responding=false
  3.21  [AIR][Produce] opening.screen legfig plant=30645 projected=4/6
  3.25  [Playtest] finished legsolar team 0 at 3.25 min
  3.26  [AIR][Rule] recovery.assist builder=27906
  3.27  [AIR][Capacity] own=3/93 usage=10/256 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=78 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=634 E=92 bank=5 pull=352 plants=1/0 aircraftDemand=3/91
  3.27  [AIR][Projects] energyQueued=0 committed=288/2155
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.32  [AIR][Screen] fighters=3 cells=8 centre=2241,1405 width=600 advance=400 responding=false
  3.43  [AIR][Capacity] own=3/143 usage=7/116 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=135 shortage=53 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=611 E=146 bank=5 pull=276 plants=1/0 aircraftDemand=3/91
  3.43  [AIR][Projects] energyQueued=0 committed=227/1951
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=188 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Produce] opening.screen legfig plant=30645 projected=5/6
  3.48  [AIR][Screen] fighters=4 cells=8 centre=2241,1405 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=5/140 usage=7/122 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=130 shortage=31 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=597 E=140 bank=4 pull=276 plants=1/0 aircraftDemand=3/91
  3.60  [AIR][Projects] energyQueued=0 committed=163/1734
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=166 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=30645 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 12 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=64
  3.65  [AIR][Screen] fighters=4 cells=8 centre=2241,1405 width=600 advance=400 responding=false
  3.67  [AIR][Produce] opening.screen legfig plant=30645 projected=6/6
  3.73  [Playtest] finished legsolar team 0 at 3.73 min
  3.75  [AIR][Rule] overflow.support.assist builder=28395
  3.76  [AIR][Rule] overflow.support.assist builder=27906
  3.77  [AIR][Capacity] own=7/145 usage=4/156 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=38 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=960 E=142 bank=6 pull=276 plants=1/0 aircraftDemand=3/87
  3.77  [AIR][Projects] energyQueued=0 committed=107/1490
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 4540 more
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
  0.20  EXP: approach: legcom(23483) at (490, 1152) walks to (472, 1150), 137 from the legmex site (336, 1136)
  0.22  EXP: approach: corcom(14393) at (13991, 1050) walks to (13965, 1037), 139 from the cormex site (13840, 976)
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
  0.25  RESERVE: zone 19 at (11328, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1888) facing 0 (id 125)
  0.25  RESERVE: zone 20 at (11328, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1856) facing 0 (id 126)
  0.25  RESERVE: zone 21 at (11328, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1824) facing 0 (id 127)
  0.25  RESERVE: zone 22 at (11328, 1792) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1792) facing 0 (id 128)
```
