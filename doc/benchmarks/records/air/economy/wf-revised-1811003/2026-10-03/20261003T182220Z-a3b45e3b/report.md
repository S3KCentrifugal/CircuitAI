# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54028); wall 212 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:18:45
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\glitters\runs\20261003T182220Z-a3b45e3b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=981 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 5852 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 5.1 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 5852 are not on it
- forbid 'invariant' hit at 6.2 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 990 (3 by power), bank 0 + 14/s (0 by metal))
- forbid 'invariant' hit at 6.4 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1080 (4 by power), bank 5 + 14/s (0 by metal))
- forbid 'invariant' hit at 16.7 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (1616, 10080) not upgraded
- forbid 'invariant' hit at 17.9 min: [INVARIANT] INV-010 combat unit armfast 24374 produced at +81 metal under the gate 200
- forbid 'invariant' hit at 18.6 min: [INVARIANT] INV-022 a new set of armafus starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 20.2 min: [INVARIANT] INV-010 combat unit armfast 27329 produced at +120 metal under the gate 200
- forbid 'invariant' hit at 20.8 min: [INVARIANT] INV-010 combat unit legstr 20337 produced at +150 metal under the gate 200
- forbid 'invariant' hit at 24.0 min: [INVARIANT] INV-011 metal floating at 13498 of 13500 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 25.7 min: [INVARIANT] INV-010 combat unit armfast 30408 produced at +187 metal under the gate 200
- forbid 'invariant' hit at 27.0 min: [INVARIANT] INV-010 combat unit armfast 21843 produced at +191 metal under the gate 200
- forbid 'invariant' hit at 27.2 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 28.2 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 2 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 28.3 min: [INVARIANT] INV-011 metal floating at 16313 of 16550 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-011 metal floating at 18714 of 18850 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-010 combat unit armfast 30714 produced at +160 metal under the gate 200
- forbid 'invariant' hit at 29.4 min: [INVARIANT] INV-060 kill zone cluster #1 has 4 weapons standing and 3 construction turrets (under 4) after 10 minutes
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-011 metal floating at 19236 of 19400 for 60 s with an income step of the plan unmet

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\glitters\runs\20261003T182220Z-a3b45e3b\screen_2026-10-03_18-19-43-031.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\glitters\runs\20261003T182220Z-a3b45e3b\screen_2026-10-03_18-20-15-005.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\glitters\runs\20261003T182220Z-a3b45e3b\screen_2026-10-03_18-20-41-267.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\glitters\runs\20261003T182220Z-a3b45e3b\screen_2026-10-03_18-22-19-141.png

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
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=981 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2832, 746), 70 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|2762|759|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(4230,585) factory=armlab landLocked=no spot=2 known=1/1
  0.20  [Playtest] finished legmex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 8838 at 2688,704
  0.20  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|2762|759|0|1|1|2688|704
  0.21  [AIR][Rule] opening.mex builder=23483
  0.22  [Team][Roster] team 1 first mex at 4256,480
  0.27  [AIR][Capacity] own=2/30 usage=6/72 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=971 E=18 bank=726 pull=72 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=35/353
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.34  [Playtest] finished legmex team 0 at 0.34 min
  0.43  [AIR][Capacity] own=3/30 usage=7/85 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=956 E=30 bank=349 pull=85 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=23/234
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.48  [Playtest] finished legmex team 0 at 0.48 min
  0.49  [AIR][Wind] cluster=0 slots=6 at=2824,752 local=true builder=23483
  0.49  [AIR][Rule] opening.energy builder=23483
  0.60  [AIR][Capacity] own=5/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=974 E=30 bank=237 pull=40 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=16/68
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.64  [Playtest] finished legwin team 0 at 0.64 min
  0.65  [AIR][Rule] recovery.energy builder=23483
  0.77  [AIR][Capacity] own=7/30 usage=16/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=945 E=30 bank=475 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=55/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.82  [Playtest] finished legsolar team 0 at 0.82 min
  0.84  [AIR][Rule] opening.energy builder=23483
  0.93  [AIR][Capacity] own=7/43 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=919 E=43 bank=785 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=5/21
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.94  [Playtest] finished legwin team 0 at 0.94 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +7.5 bank 929/1150, energy +72.6 bank 954/1051, units 8
  1.06  [Playtest] finished legwin team 0 at 1.06 min
  1.10  [AIR][Capacity] own=7/61 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=939 E=61 bank=1027 pull=9 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=36/146
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.18  [Playtest] finished legwin team 0 at 1.18 min
  1.27  [AIR][Capacity] own=7/75 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=948 E=76 bank=1022 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=12/52
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.29  [Playtest] finished legwin team 0 at 1.29 min
  1.41  [Playtest] finished legwin team 0 at 1.41 min
  1.42  [AIR][Starter] nearby distance=159
  1.42  [AIR][Rule] opening.plant builder=23483
  1.43  [AIR][EcoLayout] reserved air.eco.0 reactor=3152,624 converters=8 support=12 zone=716
  1.43  [AIR][Capacity] own=7/82 usage=4/28 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=960 E=82 bank=1046 pull=28 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=430/1100
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.45  [AIR][EcoLayout] reserved air.eco.1 reactor=1872,368 converters=8 support=12 zone=754
  1.47  [AIR][EcoLayout] reserved air.eco.2 reactor=3664,368 converters=8 support=12 zone=778
  1.48  [AIR][EcoLayout] reserved air.eco.3 reactor=1744,880 converters=8 support=12 zone=810
  1.60  [AIR][Capacity] own=7/105 usage=20/60 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=867 E=106 bank=1000 pull=60 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=242/620
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=19997 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=7/64 usage=20/60 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=7 bank=740 E=68 bank=1000 pull=60 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=40/103
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=19997 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.80  [Playtest] finished legap team 0 at 1.80 min
  1.80  [AIR][Claim] cancel unowned native order legnanotc
  1.80  [AIR][State] T1_CONTEST
  1.81  [AIR][Produce] opening.scout legfig plant=19997 projected=1/1
  1.81  [AIR][Rule] opening.commander.guard builder=23483
  1.93  [AIR][Capacity] own=6/51 usage=1/61 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=721 E=55 bank=9 pull=225 plants=1/0 aircraftDemand=2/115
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.99  [AIR][Produce] constructor.recovery legca plant=19997 projected=1/3
  1.99  [AIR][Scout] opening drone=11140 enemy starts=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.5 bank 751/1250, energy +82.1 bank 82/1153, units 14
  2.10  [AIR][Capacity] own=7/72 usage=0/13 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=768 E=63 bank=0 pull=141 plants=1/0 aircraftDemand=2/115
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=45 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=7/74 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=811 E=75 bank=2 pull=141 plants=1/0 aircraftDemand=2/115
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=45 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Capacity] own=6/73 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=851 E=85 bank=1 pull=119 plants=1/0 aircraftDemand=2/115
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=45 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.47  [AIR][Produce] constructor.recovery legca plant=19997 projected=2/3
  2.47  [AIR][Rule] recovery.energy builder=21652
  2.60  [AIR][Capacity] own=5/92 usage=2/6 gifts=0 sent=0 excess=0 pressure=true mobile=45 arriving=45 idle=0 ecoStatic=0 working=44 shortage=237 reason=funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=873 E=92 bank=9 pull=169 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=139/0
  2.60  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=327 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=5/95 usage=2/4 gifts=0 sent=0 excess=0 pressure=true mobile=45 arriving=45 idle=0 ecoStatic=0 working=44 shortage=254 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=877 E=95 bank=14 pull=141 plants=1/0 aircraftDemand=2/115
  2.77  [AIR][Projects] energyQueued=0 committed=114/0
  2.77  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=344 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.90  [AIR][Produce] constructor.recovery legca plant=19997 projected=3/3
  2.90  [AIR][Rule] recovery.energy builder=31776
  2.93  [AIR][Capacity] own=7/67 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=90 arriving=45 idle=0 ecoStatic=0 working=45 shortage=192 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=899 E=74 bank=89 pull=28 plants=1/0 aircraftDemand=2/115
  2.93  [AIR][Projects] energyQueued=1 committed=240/0
  2.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=327 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 899/1250, energy +68.2 bank 3/1203, units 17
  3.10  [AIR][Capacity] own=6/61 usage=5/13 gifts=0 sent=0 excess=0 pressure=true mobile=90 arriving=45 idle=0 ecoStatic=0 working=90 shortage=212 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=900 E=65 bank=13 pull=141 plants=1/0 aircraftDemand=2/115
  3.10  [AIR][Projects] energyQueued=0 committed=197/0
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=347 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Layout] cluster=0 labs=3 at=3362,2943
  3.27  [AIR][Capacity] own=7/68 usage=4/4 gifts=0 sent=0 excess=0 pressure=true mobile=90 arriving=45 idle=0 ecoStatic=0 working=90 shortage=241 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=899 E=69 bank=3 pull=141 plants=1/0 aircraftDemand=2/115
  3.27  [AIR][Projects] energyQueued=0 committed=149/0
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=376 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Capacity] own=7/73 usage=4/4 gifts=0 sent=0 excess=0 pressure=true mobile=90 arriving=45 idle=0 ecoStatic=0 working=90 shortage=166 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=892 E=72 bank=3 pull=141 plants=1/0 aircraftDemand=2/115
  3.43  [AIR][Projects] energyQueued=0 committed=100/0
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=301 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Produce] opening.screen legfig plant=19997 projected=1/6
  3.45  [AIR][Rule] recovery.energy builder=11666
  3.45  [AIR][Layout] cluster=1 labs=1 at=2498,543
  3.47  [AIR][Layout] cluster=2 labs=1 at=3458,1503
  3.48  [AIR][Rule] commander.factory.guard builder=23483
  3.48  [AIR][Layout] cluster=3 labs=1 at=1634,543
  3.56  [Playtest] finished legsolar team 0 at 3.56 min
  3.58  [AIR][Rule] recovery.assist builder=21652
  3.60  [AIR][Capacity] own=6/105 usage=8/145 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=120 shortage=209 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=876 E=96 bank=13 pull=217 plants=1/0 aircraftDemand=2/115
  3.60  [AIR][Projects] energyQueued=0 committed=192/0
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=344 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.67  [AIR][Produce] opening.screen legfig plant=19997 projected=2/6
  3.67  [AIR][Screen] fighters=1 cells=8 centre=4195,983 width=600 advance=400 responding=false
  3.67  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.67  [AIR][Rule] commander.idle.assist builder=23483
  3.70  [AIR][Rule] commander.factory.guard builder=23483
  3.77  [AIR][Capacity] own=6/147 usage=14/301 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=135 shortage=81 reason=funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=847 E=143 bank=231 pull=301 plants=1/0 aircraftDemand=3/84
  3.77  [AIR][Projects] energyQueued=0 committed=119/0
  3.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=216 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.83  [AIR][Layout] cluster=4 labs=1 at=2402,1119
  3.83  [AIR][Screen] fighters=1 cells=8 centre=4195,983 width=600 advance=400 responding=false
  3.84  [AIR][Produce] opening.screen legfig plant=19997 projected=3/6
  3.93  [AIR][Capacity] own=7/160 usage=16/369 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=135 shortage=26 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=797 E=158 bank=644 pull=369 plants=1/0 aircraftDemand=3/84
  3.93  [AIR][Projects] energyQueued=0 committed=47/0
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=161 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.95  [AIR][Produce] opening.screen legfig plant=19997 projected=4/6
  4.00  [Playtest] eco team 0 at 4.0 min: metal +7.5 bank 771/1250, energy +179.0 bank 1097/1278, units 22
  4.00  [Playtest] finished legsolar team 0 at 4.00 min
  4.01  [AIR][Rule] mex.expand builder=31776
  4.02  [AIR][Screen] fighters=3 cells=8 centre=4195,983 width=600 advance=400 responding=false
  4.06  [AIR][Produce] opening.screen legfig plant=19997 projected=5/6
  4.06  [Playtest] finished legsolar team 0 at 4.06 min
  4.08  [AIR][Wind] cluster=1 slots=6 at=2888,1216 local=false builder=11666
  4.08  [AIR][Rule] energy.grow builder=11666
  4.08  [AIR][Rule] energy.grow builder=21652
  4.10  [AIR][Capacity] own=7/172 usage=6/257 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=45 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST M=7 bank=759 E=167 bank=1259 pull=257 plants=1/0 aircraftDemand=3/84
  4.10  [AIR][Projects] energyQueued=0 committed=133/833
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.16  [AIR][Produce] opening.screen legfig plant=19997 projected=6/6
  4.20  [AIR][Screen] fighters=5 cells=8 centre=4195,983 width=600 advance=400 responding=false
  4.26  [AIR][Produce] intercept legfig plant=19997 projected=7/7
  4.27  [AIR][Capacity] own=7/201 usage=10/322 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=134 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST M=7 bank=727 E=203 bank=347 pull=322 plants=1/0 aircraftDemand=3/84
  4.27  [AIR][Projects] energyQueued=0 committed=98/619
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.37  [AIR][Screen] fighters=6 cells=8 centre=4195,983 width=600 advance=400 responding=false
  4.38  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.38  [AIR][Rule] commander.idle.assist builder=23483
  4.40  [AIR][Scout] opening drone=31134 enemy starts=2
  4.40  [AIR][Scout] replacement drone=31134
  4.43  [AIR][Capacity] own=3/201 usage=3/30 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=135 shortage=129 reason=funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=725 E=202 bank=476 pull=30 plants=1/0 aircraftDemand=3/84
  4.43  [AIR][Projects] energyQueued=0 committed=66/434
  4.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=264 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [AIR][Produce] constructor.expand legca plant=19997 projected=4/4
  4.51  [Playtest] finished legwin team 0 at 4.51 min
  4.52  [AIR][Rule] recovery.assist builder=11666
  4.53  [AIR][Rule] commander.factory.guard builder=23483
  4.55  [AIR][Screen] fighters=6 cells=8 centre=4195,983 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=7/215 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=45 idle=0 ecoStatic=0 working=135 shortage=9 reason=funded workload
  4.60  [AIR][Economy] T1_CONTEST M=7 bank=728 E=211 bank=1378 pull=96 plants=1/0 aircraftDemand=3/84
  4.60  [AIR][Projects] energyQueued=0 committed=18/168
  4.60  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=189 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.62  [Playtest] finished legwin team 0 at 4.62 min
  4.63  [AIR][Rule] energy.grow builder=11666
  4.72  [AIR][Screen] fighters=6 cells=8 centre=4195,983 width=600 advance=400 responding=false
  4.75  [AIR][Produce] constructor.expand legca plant=19997 projected=5/5
  4.76  [AIR][Rule] energy.grow builder=19948
  4.77  [AIR][Capacity] own=7/207 usage=6/96 gifts=0 sent=0 excess=0 pressure=false mobile=180 arriving=45 idle=0 ecoStatic=0 working=135 shortage=135 reason=funded workload
  4.77  [AIR][Economy] T1_CONTEST M=7 bank=696 E=211 bank=1404 pull=96 plants=1/0 aircraftDemand=3/84
  4.77  [AIR][Projects] energyQueued=1 committed=115/494
  4.77  [AIR][Workforce] t1=4/6 t2=0/2 targetBP=360 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.82  [Playtest] finished legmex team 0 at 4.82 min
  4.88  [AIR][Screen] fighters=6 cells=8 centre=4195,983 width=600 advance=400 responding=false
  4.93  [AIR][Capacity] own=7/178 usage=4/52 gifts=0 sent=0 excess=0 pressure=false mobile=180 arriving=45 idle=0 ecoStatic=0 working=134 shortage=144 reason=funded workload
  4.93  [AIR][Economy] T1_CONTEST M=7 bank=676 E=186 bank=1325 pull=224 plants=1/0 aircraftDemand=3/84
  4.93  [AIR][Projects] energyQueued=0 committed=131/832
  4.93  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=369 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.98  [AIR][Produce] constructor.screen legfig plant=19997 projected=8/8
  4.98  [AIR][Layout] repaired support air.bay.0 viable=3/5 slot=8251 at=2760,888
  4.98  [AIR][Rule] opening.support builder=30879
  5.00  [Playtest] eco team 0 at 5.0 min: metal +9.3 bank 673/1300, energy +181.2 bank 1408/1429, units 36
  5.00  [Playtest] target team 0 at (2801, 775) from its start position
  5.00  [Playtest] camera requested (2656,784) height=2200
  5.02  [Playtest] camera captured name=ta position=(2656,784) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2656, 784)
  5.05  [AIR][Screen] fighters=6 cells=8 centre=4195,983 width=600 advance=400 responding=false
  5.09  [AIR][Produce] air.control legfig plant=19997 projected=8/8
  5.10  [AIR][Capacity] own=9/175 usage=10/254 gifts=0 sent=0 excess=0 pressure=true mobile=225 arriving=0 idle=0 ecoStatic=0 working=225 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=9 bank=910 E=177 bank=509 pull=281 plants=1/0 aircraftDemand=2/115
  5.10  [AIR][Projects] energyQueued=0 committed=307/3651
  5.10  [AIR][Workforce] t1=5/5 t2=0/2 targetBP=225 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Attack] home=7 target=11 heldBombers=0 escorts=0 wave=0 enemyAir=358
  5.22  [AIR][Screen] fighters=8 cells=8 centre=4162,1378 width=1200 advance=796 responding=false
  5.26  [Playtest] finished legwin team 0 at 5.26 min
  5.27  [AIR][Capacity] own=5/193 usage=4/38 gifts=0 sent=0 excess=0 pressure=true mobile=225 arriving=0 idle=45 ecoStatic=0 working=180 shortage=208 reason=funded workload
  5.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=897 E=187 bank=418 pull=65 plants=1/0 aircraftDemand=2/115
  5.27  [AIR][Projects] energyQueued=0 committed=247/3175
  5.27  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=433 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=19997 BP=150 nanos=0+1/0 available=yes firstSlot=2
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [Playtest] finished legwin team 0 at 5.27 min
  5.28  [AIR][Rule] recovery.assist builder=11666
  5.29  [AIR][Rule] overflow.support.assist builder=21652
  5.31  [AIR][Commander] cleared factory guard for commander.idle.wait
  5.31  [AIR][Rule] commander.idle.wait builder=23483
  5.38  [Playtest] finished legwin team 0 at 5.38 min
... 4227 more
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
  0.21  EXP: approach: legcom(23483) at (2754, 752) walks to (2795, 727), 137 from the legmex site (2912, 656)
  0.25  RESERVE: armalab at (3128, 1496) facing 0 (id 122)
  0.25  RESERVE: zone 15 at (3128, 1376) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3128, 1424) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (3128, 1448) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (3128, 1744) facing 0, 13x20 cells: 252 of 260 held
  0.25  RESERVE: zone 18 at (4704, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4704, 1888) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (4672, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4672, 1888) facing 0 (id 128)
  0.25  RESERVE: zone 20 at (4640, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4640, 1888) facing 0 (id 129)
  0.25  RESERVE: zone 21 at (4608, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4608, 1888) facing 0 (id 130)
  0.25  RESERVE: zone 22 at (4576, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4576, 1888) facing 0 (id 131)
  0.25  RESERVE: zone 23 at (4544, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4544, 1888) facing 0 (id 132)
  0.25  RESERVE: zone 24 at (4512, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4512, 1888) facing 0 (id 133)
  0.25  RESERVE: zone 25 at (4480, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4480, 1888) facing 0 (id 134)
  0.25  RESERVE: zone 26 at (4448, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4448, 1888) facing 0 (id 135)
  0.25  RESERVE: zone 27 at (4416, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4416, 1888) facing 0 (id 136)
  0.25  RESERVE: zone 28 at (4384, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4384, 1888) facing 0 (id 137)
  0.25  RESERVE: zone 29 at (4064, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4064, 1888) facing 0 (id 138)
  0.25  RESERVE: zone 30 at (4032, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4032, 1888) facing 0 (id 139)
  0.25  RESERVE: zone 31 at (3808, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3808, 1888) facing 0 (id 140)
  0.25  RESERVE: zone 32 at (3776, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3776, 1888) facing 0 (id 141)
  0.25  RESERVE: zone 33 at (4480, 1776) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (4480, 1776) facing 0 (id 142)
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
  0.29  EXP: approach: corcom(14393) at (3452, 9683) walks to (3431, 9671), 139 from the cormex site (3312, 9600)
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
  0.35  EXP: approach: legcom(23483) at (2768, 734) walks to (2806, 777), 137 from the legmex site (2896, 880)
  0.39  EXP: approach: armcom(1236) at (4253, 577) walks to (4047, 505), 136 from the armmex site (4032, 640)
  0.42  RESERVE: armshltx at (5712, 1552) facing 0 (id 148)
  0.42  RESERVE: zone 37 at (5712, 1336) facing 0, 30x15 cells: 434 of 450 held
```
