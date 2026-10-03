# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54011); wall 222 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:22:20
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\tundra\runs\20261003T182606Z-79115e8b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 10.9 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 915 (3 by power), bank 0 + 25/s (0 by metal))
- forbid 'invariant' hit at 16.1 min: [INVARIANT] INV-029 leghp 203 stands 19 cells from the turrets, not tight
- forbid 'invariant' hit at 16.3 min: [INVARIANT] INV-008 6 turret(s) in range of the reclaim of legalab 27906 are not on it
- forbid 'invariant' hit at 19.2 min: [INVARIANT] INV-008 2 turret(s) in range of the reclaim of legwin 12858 are not on it
- forbid 'invariant' hit at 20.2 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of legwin 1112 are not on it
- forbid 'invariant' hit at 20.2 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 20.6 min: [INVARIANT] INV-008 2 turret(s) in range of the reclaim of legwin 11638 are not on it
- forbid 'invariant' hit at 23.6 min: [INVARIANT] INV-020 no layout room for legadveconv for 136 s
- forbid 'invariant' hit at 23.7 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 23.7 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 24.6 min: [INVARIANT] INV-020 no layout room for legafus for 196 s
- forbid 'invariant' hit at 24.7 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 24.7 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 25.8 min: [INVARIANT] INV-011 metal floating at 6200 of 6200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 25.8 min: [INVARIANT] INV-020 no layout room for legafus for 266 s
- forbid 'invariant' hit at 25.8 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 26.7 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 26.8 min: [INVARIANT] INV-011 metal floating at 6200 of 6200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 26.8 min: [INVARIANT] INV-020 no layout room for legafus for 326 s
- forbid 'invariant' hit at 26.8 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 27.7 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-011 metal floating at 6200 of 6200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-020 no layout room for legafus for 387 s
- forbid 'invariant' hit at 27.8 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 28.8 min: [INVARIANT] INV-011 metal floating at 1951 of 2000 for 60 s with an income step of the plan unmet

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\tundra\runs\20261003T182606Z-79115e8b\screen_2026-10-03_18-23-26-501.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\tundra\runs\20261003T182606Z-79115e8b\screen_2026-10-03_18-24-19-543.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\tundra\runs\20261003T182606Z-79115e8b\screen_2026-10-03_18-24-48-222.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (2800, 800) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (300, 460) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (4600, 11400) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (6000, 11400) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2800, 800) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (300, 460) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (4600, 11400) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (6000, 11400) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order legap
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2866, 888), 82 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|2810|828|1|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(325,468) factory=armlab landLocked=yes spot=0 known=1/1
  0.20  [Team][Roster] team 1 first mex at 480,432
  0.21  [Playtest] finished legmex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 20017 at 2848,928
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|2810|828|1|2|1|2848|928
  0.22  [AIR][Rule] opening.mex builder=23483
  0.27  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=972 E=18 bank=818 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.39  [Playtest] finished legmex team 0 at 0.39 min
  0.43  [AIR][Capacity] own=3/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=965 E=30 bank=581 pull=6 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=5/30 usage=7/85 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=5 bank=1010 E=30 bank=603 pull=85 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=26/268
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.66  [Playtest] finished legmex team 0 at 0.66 min
  0.67  [AIR][Wind] cluster=0 slots=6 at=3048,912 local=true builder=23483
  0.67  [AIR][Rule] opening.energy builder=23483
  0.77  [AIR][Capacity] own=5/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=5 bank=1031 E=30 bank=460 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=20/84
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.81  [Playtest] finished legwin team 0 at 0.81 min
  0.93  [Playtest] finished legwin team 0 at 0.93 min
  0.93  [AIR][Capacity] own=7/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=1045 E=30 bank=489 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1062/1150, energy +51.5 bank 588/1001, units 7
  1.05  [Playtest] finished legwin team 0 at 1.05 min
  1.10  [AIR][Capacity] own=7/46 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=1077 E=49 bank=733 pull=9 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=36/146
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.18  [Playtest] finished legwin team 0 at 1.18 min
  1.27  [AIR][Capacity] own=7/61 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=1099 E=61 bank=951 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=20/83
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.31  [Playtest] finished legwin team 0 at 1.31 min
  1.43  [Playtest] finished legwin team 0 at 1.43 min
  1.43  [AIR][Capacity] own=7/72 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=1113 E=72 bank=952 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.44  [AIR][Wind] cluster=1 slots=6 at=2712,848 local=false builder=23483
  1.60  [AIR][Capacity] own=7/104 usage=3/23 gifts=0 sent=7 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=102 bank=1000 pull=23 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=31/130
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.67  [Playtest] finished legwin team 0 at 1.67 min
  1.68  [AIR][Starter] nearby distance=128
  1.68  [AIR][Rule] opening.plant builder=23483
  1.68  [AIR][EcoLayout] reserved air.eco.0 reactor=1920,832 converters=8 support=12 zone=41
  1.70  [AIR][EcoLayout] reserved air.eco.1 reactor=1792,1344 converters=8 support=12 zone=71
  1.72  [AIR][EcoLayout] reserved air.eco.2 reactor=2304,1856 converters=8 support=12 zone=120
  1.77  [AIR][Capacity] own=7/116 usage=20/60 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=7 bank=1100 E=116 bank=1000 pull=60 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=340/870
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=31706 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Capacity] own=7/131 usage=20/60 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=7 bank=978 E=131 bank=998 pull=60 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=138/353
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=31706 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 917/1150, energy +141.4 bank 994/1003, units 12
  2.05  [Playtest] finished legap team 0 at 2.05 min
  2.05  [AIR][Claim] cancel unowned native order legnanotc
  2.05  [AIR][State] T1_CONTEST
  2.06  [AIR][Produce] opening.scout legfig plant=31706 projected=1/1
  2.06  [AIR][Rule] opening.commander.guard builder=23483
  2.10  [AIR][Capacity] own=7/136 usage=5/249 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST M=7 bank=893 E=136 bank=933 pull=249 plants=1/0 aircraftDemand=2/115
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.16  [AIR][Produce] constructor.recovery legca plant=31706 projected=1/3
  2.16  [AIR][Scout] opening drone=21652 enemy starts=2
  2.27  [AIR][Capacity] own=7/113 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=7 bank=893 E=116 bank=381 pull=206 plants=1/0 aircraftDemand=2/115
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=45 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.37  [AIR][Produce] constructor.recovery legca plant=31706 projected=2/3
  2.37  [AIR][Rule] mex.expand builder=30972
  2.43  [AIR][Capacity] own=7/109 usage=0/8 gifts=0 sent=0 excess=0 pressure=true mobile=45 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=901 E=111 bank=180 pull=206 plants=1/0 aircraftDemand=2/115
  2.43  [AIR][Projects] energyQueued=0 committed=50/500
  2.43  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=90 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=5/109 usage=0/20 gifts=0 sent=0 excess=0 pressure=true mobile=45 arriving=45 idle=0 ecoStatic=0 working=0 shortage=204 reason=funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=920 E=109 bank=1 pull=141 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=49/496
  2.60  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=294 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.69  [AIR][Produce] constructor.recovery legca plant=31706 projected=3/3
  2.69  [AIR][Rule] recovery.energy builder=31304
  2.74  [AIR][Commander] cleared factory guard for commander.energy.assist
  2.74  [AIR][Rule] commander.energy.assist builder=23483
  2.77  [AIR][Capacity] own=5/111 usage=9/163 gifts=0 sent=0 excess=0 pressure=true mobile=90 arriving=45 idle=0 ecoStatic=0 working=348 shortage=18 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=940 E=110 bank=40 pull=200 plants=1/0 aircraftDemand=2/115
  2.77  [AIR][Projects] energyQueued=0 committed=175/439
  2.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=153 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.88  [Playtest] finished legsolar team 0 at 2.88 min
  2.90  [AIR][Rule] opening.commander.guard builder=23483
  2.93  [AIR][Capacity] own=7/126 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=90 arriving=45 idle=0 ecoStatic=0 working=44 shortage=318 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=836 E=125 bank=672 pull=86 plants=1/0 aircraftDemand=2/115
  2.93  [AIR][Projects] energyQueued=0 committed=182/320
  2.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=453 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 819/1250, energy +170.7 bank 476/1203, units 19
  3.04  [AIR][Produce] opening.screen legfig plant=31706 projected=1/6
  3.04  [AIR][Rule] recovery.energy builder=2498
  3.10  [AIR][Rule] commander.factory.guard builder=23483
  3.10  [AIR][Capacity] own=7/165 usage=12/380 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=89 shortage=134 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=813 E=160 bank=350 pull=380 plants=1/0 aircraftDemand=2/115
  3.10  [AIR][Projects] energyQueued=0 committed=297/200
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=269 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.16  [AIR][Produce] opening.screen legfig plant=31706 projected=2/6
  3.16  [AIR][Screen] fighters=1 cells=8 centre=470,840 width=600 advance=400 responding=false
  3.27  [AIR][Capacity] own=4/175 usage=9/177 gifts=0 sent=0 excess=0 pressure=false mobile=135 arriving=0 idle=0 ecoStatic=0 working=90 shortage=138 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=790 E=176 bank=12 pull=341 plants=1/0 aircraftDemand=3/84
  3.27  [AIR][Projects] energyQueued=0 committed=246/171
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=273 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.32  [AIR][Produce] opening.screen legfig plant=31706 projected=3/6
  3.35  [AIR][Layout] cluster=0 labs=1 at=1874,2628
  3.35  [AIR][Screen] fighters=2 cells=8 centre=470,840 width=600 advance=400 responding=false
  3.43  [AIR][Capacity] own=6/176 usage=9/177 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=90 shortage=245 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=1013 E=176 bank=8 pull=185 plants=1/0 aircraftDemand=3/84
  3.43  [AIR][Projects] energyQueued=0 committed=194/136
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=380 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.48  [AIR][Produce] opening.screen legfig plant=31706 projected=4/6
  3.49  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.49  [AIR][Rule] commander.idle.assist builder=23483
  3.52  [AIR][Screen] fighters=3 cells=8 centre=470,840 width=600 advance=400 responding=false
  3.52  [AIR][Rule] commander.factory.guard builder=23483
  3.60  [AIR][Capacity] own=6/176 usage=12/288 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=135 shortage=172 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=1004 E=176 bank=482 pull=288 plants=1/0 aircraftDemand=3/84
  3.60  [AIR][Projects] energyQueued=0 committed=133/46
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=307 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.65  [AIR][Produce] opening.screen legfig plant=31706 projected=5/6
  3.68  [Playtest] finished legmex team 0 at 3.68 min
  3.69  [AIR][Rule] recovery.energy builder=30972
  3.70  [AIR][Screen] fighters=4 cells=8 centre=470,840 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=7/176 usage=10/234 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=90 shortage=122 reason=funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=986 E=176 bank=7 pull=304 plants=1/0 aircraftDemand=3/84
  3.77  [AIR][Projects] energyQueued=1 committed=231/0
  3.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=257 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.81  [AIR][Produce] opening.screen legfig plant=31706 projected=6/6
  3.81  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.81  [AIR][Rule] commander.idle.assist builder=23483
  3.83  [AIR][Share] metal 1236 of 1300 (95%): sent 260 to team 1 (77% full); the engine counts 0 metal sent in the last update (D-106)
  3.84  [AIR][Rule] commander.factory.guard builder=23483
  3.87  [AIR][Layout] cluster=1 labs=1 at=3410,1476
  3.87  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  3.88  [AIR][Layout] cluster=2 labs=1 at=3218,1668
  3.88  [AIR][Screen] fighters=5 cells=8 centre=470,840 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=8/175 usage=13/264 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=135 shortage=265 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=1231 E=175 bank=167 pull=264 plants=1/0 aircraftDemand=3/84
  3.93  [AIR][Projects] energyQueued=0 committed=169/0
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=400 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.95  [Playtest] finished legsolar team 0 at 3.95 min
  3.96  [AIR][Rule] recovery.assist builder=31304
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 1232/1300, energy +196.7 bank 418/1278, units 26
  4.02  [AIR][Share] metal 1236 of 1300 (95%): sent 186 to team 1 (84% full); the engine counts 0 metal sent in the last update (D-106)
  4.03  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.03  [AIR][Rule] commander.idle.assist builder=23483
  4.04  [AIR][Produce] constructor.expand legca plant=31706 projected=4/4
  4.05  [AIR][Screen] fighters=6 cells=8 centre=470,840 width=600 advance=400 responding=false
  4.05  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 984) (D-106)
  4.06  [AIR][Rule] commander.factory.guard builder=23483
  4.10  [AIR][Capacity] own=9/175 usage=4/0 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=45 idle=0 ecoStatic=0 working=135 shortage=160 reason=funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=1283 E=175 bank=1171 pull=148 plants=1/0 aircraftDemand=3/84
  4.10  [AIR][Projects] energyQueued=0 committed=100/0
  4.10  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=340 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.10  [AIR][Share] metal 1277 of 1300 (98%): sent 190 to team 1 (84% full); the engine counts 0 metal sent in the last update (D-106)
  4.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1004) (D-106)
  4.14  [Playtest] finished legsolar team 0 at 4.14 min
  4.15  [AIR][Rule] recovery.assist builder=2498
  4.18  [AIR][Share] metal 1277 of 1300 (98%): sent 171 to team 1 (85% full); the engine counts 0 metal sent in the last update (D-106)
  4.20  [Ferry] AIR: queued request from team 1
  4.20  [Ferry] AIR: serving team 1 queued=0
  4.22  [AIR][Screen] fighters=6 cells=8 centre=470,840 width=600 advance=400 responding=false
  4.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1026) (D-106)
  4.23  [AIR][State] T1_SCALE
  4.25  [AIR][NanoGate] legcom 23483 can=no busy=no count=0
  4.25  [AIR][Commander] cleared factory guard for commander.energy.local
  4.25  [AIR][Rule] commander.energy.local builder=23483
  4.27  [AIR][Capacity] own=9/196 usage=10/73 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=45 ecoStatic=0 working=135 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_SCALE M=44 bank=1271 E=196 bank=1262 pull=209 plants=1/0 aircraftDemand=3/84
  4.27  [AIR][Projects] energyQueued=1 committed=77/175
  4.27  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=180 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Share] metal 1268 of 1300 (97%): sent 149 to team 1 (87% full); the engine counts 0 metal sent in the last update (D-106)
  4.27  [Ferry] AIR: ordered one leglts for team 1
  4.28  [AIR][NanoGate] legca 10327 can=yes busy=no count=0
  4.28  [AIR][Layout] repaired support air.bay.0 viable=3/5 slot=535 at=3032,1000
  4.28  [AIR][Rule] opening.support builder=10327
  4.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1043) (D-106)
  4.34  [Playtest] finished legsolar team 0 at 4.34 min
  4.35  [AIR][Share] metal 1255 of 1300 (96%): sent 129 to team 1 (89% full); the engine counts 0 metal sent in the last update (D-106)
  4.36  [AIR][NanoGate] legca 2498 can=yes busy=yes count=1
  4.36  [AIR][Rule] opening.support.assist builder=2498
  4.36  [AIR][NanoGate] legca 30972 can=yes busy=yes count=1
  4.36  [AIR][Rule] opening.support.assist builder=30972
  4.37  [AIR][NanoGate] legca 31304 can=yes busy=yes count=1
  4.37  [AIR][Rule] opening.support.assist builder=31304
  4.37  [Playtest] finished legwin team 0 at 4.37 min
  4.38  [AIR][Rule] opening.support.assist builder=23483
  4.38  [AIR][Screen] fighters=6 cells=8 centre=470,840 width=600 advance=400 responding=false
  4.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1059) (D-106)
  4.43  [AIR][Capacity] own=9/219 usage=0/21 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=412 shortage=202 reason=funded workload
  4.43  [AIR][Economy] T1_SCALE M=37 bank=1278 E=217 bank=1361 pull=270 plants=1/0 aircraftDemand=3/84
  4.43  [AIR][Projects] energyQueued=0 committed=177/2471
  4.43  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=382 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=31706 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Share] metal 1267 of 1300 (97%): sent 113 to team 1 (90% full); the engine counts 0 metal sent in the last update (D-106)
  4.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1059) (D-106)
  4.52  [AIR][Share] metal 1239 of 1300 (95%): sent 122 to team 1 (89% full); the engine counts 0 metal sent in the last update (D-106)
  4.55  [AIR][Screen] fighters=6 cells=8 centre=470,840 width=600 advance=400 responding=false
  4.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1022) (D-106)
  4.58  [Playtest] finished legnanotc team 0 at 4.58 min
  4.59  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=552 at=2824,1000
  4.59  [AIR][Rule] opening.support builder=2498
  4.59  [AIR][Rule] mex.expand builder=30972
  4.60  [AIR][Rule] energy.grow builder=10327
  4.60  [AIR][Capacity] own=9/245 usage=13/213 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=45 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_SCALE M=37 bank=1263 E=247 bank=507 pull=213 plants=1/0 aircraftDemand=8/190
  4.60  [AIR][Projects] energyQueued=1 committed=323/3875
  4.60  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=180 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=31706 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.60  [AIR][Share] metal 1269 of 1300 (97%): sent 155 to team 1 (87% full); the engine counts 0 metal sent in the last update (D-106)
  4.60  [AIR][Rule] energy.grow builder=31304
  4.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1033) (D-106)
  4.64  [Ferry] AIR: transport 1489 built for team 1; hold pending task
  4.66  [AIR][Produce] air.control legfig plant=31706 projected=7/7
  4.67  [AIR][Support] return to production bay=0
  4.67  [Ferry] AIR: transport 1489 flying to (325,468)
  4.68  [AIR][Share] metal 1242 of 1300 (95%): sent 142 to team 1 (88% full); the engine counts 0 metal sent in the last update (D-106)
  4.72  [AIR][Screen] fighters=6 cells=8 centre=470,840 width=600 advance=400 responding=false
  4.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1007) (D-106)
  4.77  [AIR][Capacity] own=9/225 usage=4/64 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=350 shortage=256 reason=funded workload
  4.77  [AIR][Economy] T1_SCALE RECOVERY M=43 bank=1274 E=228 bank=11 pull=257 plants=1/0 aircraftDemand=8/190
  4.77  [AIR][Projects] energyQueued=0 committed=202/1984
  4.77  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=436 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=31706 BP=350 nanos=1+1/0 available=yes firstSlot=3
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Share] metal 1268 of 1300 (97%): sent 169 to team 1 (85% full); the engine counts 0 metal sent in the last update (D-106)
  4.80  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1016) (D-106)
  4.85  [AIR][Share] metal 1266 of 1300 (97%): sent 160 to team 1 (86% full); the engine counts 0 metal sent in the last update (D-106)
  4.88  [AIR][Screen] fighters=6 cells=8 centre=470,840 width=600 advance=400 responding=false
  4.88  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1026) (D-106)
  4.89  [Playtest] finished legnanotc team 0 at 4.89 min
  4.90  [AIR][Rule] recovery.assist builder=2498
  4.90  [AIR][Layout] cluster=3 labs=1 at=2066,2340
  4.90  [Ferry] AIR: transport 1489 arrived and transferred to team 1
  4.90  [AIR][Rule] commander.energy.assist builder=23483
  4.93  [AIR][Capacity] own=7/174 usage=10/231 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=459 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_SCALE RECOVERY M=43 bank=1286 E=190 bank=87 pull=231 plants=1/0 aircraftDemand=12/291
  4.93  [AIR][Projects] energyQueued=0 committed=78/600
  4.93  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=180 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=31706 BP=550 nanos=2+0/0 available=yes firstSlot=3
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Share] metal 1282 of 1300 (98%): sent 151 to team 1 (87% full); the engine counts 0 metal sent in the last update (D-106)
  4.95  [Playtest] finished legwin team 0 at 4.95 min
  4.97  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1059) (D-106)
  4.97  [AIR][NanoGate] legca 10327 can=yes busy=no count=2
  4.97  [AIR][Rule] intel.radar builder=10327
  4.97  [AIR][NanoGate] legcom 23483 can=no busy=no count=2
  4.97  [AIR][Rule] commander.factory.guard builder=23483
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 1288/1300, energy +151.8 bank 61/1404, units 34
  5.00  [Playtest] target team 0 at (2800, 800) from its start position
  5.00  [Playtest] camera requested (2928,944) height=2200
  5.02  [Playtest] camera captured name=ta position=(2928,944) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2928, 944)
  5.02  [AIR][Share] metal 1287 of 1300 (99%): sent 112 to team 1 (90% full); the engine counts 2 metal sent in the last update (D-106)
  5.05  [AIR][Scout] opening drone=4488 enemy starts=2
  5.05  [AIR][Scout] replacement drone=4488
  5.05  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.07  [AIR][State] T1_CONTEST
  5.07  [AIR][Screen] fighters=6 cells=8 centre=470,840 width=600 advance=400 responding=false
  5.07  [AIR][Commander] cleared factory guard for commander.local.assist
  5.07  [AIR][Rule] commander.local.assist builder=23483
  5.10  [AIR][Capacity] own=7/147 usage=11/113 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=506 shortage=126 reason=funded workload
  5.10  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=1270 E=147 bank=132 pull=113 plants=1/0 aircraftDemand=12/291
  5.10  [AIR][Projects] energyQueued=0 committed=49/490
  5.10  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=306 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=31706 BP=550 nanos=2+0/0 available=yes firstSlot=3
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.10  [AIR][Share] metal 1257 of 1300 (96%): sent 66 to team 1 (94% full); the engine counts 0 metal sent in the last update (D-106)
  5.10  [AIR][Rule] commander.idle.energy builder=23483
  5.11  [Playtest] finished legrad team 0 at 5.11 min
  5.11  [Playtest] finished legwin team 0 at 5.11 min
  5.12  [AIR][Rule] transition.storage builder=2498
... 3032 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: armlab at (272, 384) facing 2 (id 11)
  0.08  RESERVE: zone 7 at (272, 456) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (272, 432) facing 2: 2 of 2 slots (group 5, zone)
  0.08  RESERVE: armlab at (272, 368) facing 2 (id 14)
  0.08  RESERVE: zone 8 at (272, 440) facing 2, 6x3 cells: 6 of 18 held
  0.08  RESERVE: armlab at (256, 352) facing 2 (id 15)
  0.08  RESERVE: zone 9 at (256, 424) facing 2, 6x3 cells: 8 of 18 held
  0.08  RESERVE: armlab at (272, 144) facing 2 (id 16)
  0.08  RESERVE: zone 10 at (272, 216) facing 2, 6x3 cells: 6 of 18 held
  0.08  EXP: approach: armcom(1236) at (325, 468) walks to (347, 463), 136 from the armmex site (480, 432)
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (6579, 11928) facing 2, 77x54 cells: 3759 of 4158 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (6579, 11432) facing 2: 5 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (6579, 11480) facing 2: 5 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (6579, 11528) facing 2: 6 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (6579, 11576) facing 2: 6 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (6344, 11352) facing 2 (id 33)
  0.09  RESERVE: leglab at (5936, 8272) facing 2 (id 34)
  0.09  RESERVE: zone 8 at (5936, 8344) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (5936, 8320) facing 2: 2 of 2 slots (group 6, zone)
  0.09  RESERVE: leglab at (6704, 7248) facing 2 (id 37)
  0.09  RESERVE: zone 9 at (6704, 7320) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (6704, 7296) facing 2: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (6800, 7272) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 11 at (6704, 7272) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (6704, 7024) facing 2, 10x20 cells: 190 of 200 held
  0.09  EXP: approach: legcom(28186) at (5988, 11435) walks to (5877, 11461), 137 from the legmex site (5936, 11584)
  0.16  EXP: idle: legcom(28186) on legmex at (5884, 11459), site (5936, 11584), target yes, fails 2 (arrived at the approach point)
  0.17  RESERVE: leglab at (5936, 8272) facing 2 (id 40)
  0.17  RESERVE: zone 12 at (5936, 8344) facing 2, 6x3 cells: 0 of 18 held
  0.17  RESERVE: leglab at (6576, 7232) facing 2 (id 41)
  0.17  RESERVE: zone 12 at (6576, 7304) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: leglab at (6448, 7216) facing 2 (id 42)
  0.17  RESERVE: zone 13 at (6448, 7288) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (6448, 7264) facing 2: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: leglab at (6320, 7200) facing 2 (id 45)
  0.17  RESERVE: zone 14 at (6320, 7272) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (6320, 7248) facing 2: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: leglab at (6192, 7184) facing 2 (id 48)
  0.17  RESERVE: zone 15 at (6192, 7256) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (6192, 7232) facing 2: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: leglab at (7344, 7312) facing 2 (id 51)
  0.17  RESERVE: zone 16 at (7344, 7384) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (7344, 7360) facing 2: 2 of 2 slots (group 12, zone)
  0.17  RESERVE: leglab at (7456, 7328) facing 2 (id 54)
  0.17  RESERVE: zone 17 at (7456, 7400) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (7456, 7376) facing 2: 2 of 2 slots (group 13, zone)
  0.17  RESERVE: corridor 18 at (7552, 7352) facing 2, 6x21 cells: 110 of 126 held
  0.17  RESERVE: zone 19 at (7456, 7352) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 19 at (7456, 7104) facing 2, 10x20 cells: 182 of 200 held
  0.19  EXP: approach: corcom(14393) at (4599, 11401) walks to (4532, 11356), 139 from the cormex site (4416, 11280)
  0.21  EXP: approach: armcom(1236) at (338, 465) walks to (280, 654), 136 from the armmex site (240, 784)
  0.22  EXP: approach: legcom(23483) at (2824, 863) walks to (2737, 831), 137 from the legmex site (2608, 784)
  0.25  RESERVE: armlab at (256, 352) facing 2 (id 17)
  0.25  RESERVE: zone 11 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.25  RESERVE: armlab at (272, 144) facing 2 (id 18)
  0.25  RESERVE: zone 11 at (272, 216) facing 2, 6x3 cells: 0 of 18 held
  0.25  RESERVE: leggant at (4800, 10384) facing 2 (id 57)
  0.25  RESERVE: zone 20 at (4800, 10600) facing 2, 30x15 cells: 450 of 450 held
  0.25  RESERVE: grid of legnanotc 10x5 gap 0 behind (4800, 10480) facing 2: 50 of 50 slots (group 14, zone)
  0.25  RESERVE: zone 20 released
  0.25  RESERVE: zone 21 at (4800, 10600) facing 2, 24x15 cells: 360 of 360 held
  0.25  RESERVE: grid of legnanotc 8x5 gap 0 behind (4800, 10480) facing 2: 40 of 40 slots (group 15, zone)
  0.25  RESERVE: zone 21 released
  0.25  RESERVE: zone 22 at (4800, 10576) facing 2, 24x12 cells: 288 of 288 held
  0.25  RESERVE: grid of legnanotc 8x4 gap 0 behind (4800, 10480) facing 2: 32 of 32 slots (group 16, zone)
  0.25  RESERVE: zone 22 released
  0.25  RESERVE: zone 23 at (4800, 10576) facing 2, 18x12 cells: 216 of 216 held
  0.25  RESERVE: grid of legnanotc 6x4 gap 0 behind (4800, 10480) facing 2: 24 of 24 slots (group 17, zone)
  0.25  RESERVE: zone 23 released
  0.25  RESERVE: zone 24 at (4800, 10552) facing 2, 18x9 cells: 162 of 162 held
  0.25  RESERVE: grid of legnanotc 6x3 gap 0 behind (4800, 10480) facing 2: 18 of 18 slots (group 18, zone)
  0.25  RESERVE: zone 24 released
  0.25  RESERVE: zone 25 at (4800, 10528) facing 2, 10x6 cells: 60 of 60 held
  0.25  RESERVE: grid of legnanotc 3x2 gap 0 behind (4800, 10480) facing 2: 6 of 6 slots (group 19, zone)
  0.25  RESERVE: zone 26 at (4800, 10432) facing 0, 12x18 cells: 12 of 216 held
  0.25  RESERVE: corridor 27 at (4800, 10112) facing 2, 16x20 cells: 320 of 320 held
  0.37  EXP: approach: corcom(14393) at (4545, 11375) walks to (4747, 11634), 139 from the cormex site (4832, 11744)
  0.41  EXP: approach: legcom(23483) at (2754, 835) walks to (3038, 932), 137 from the legmex site (3168, 976)
  0.42  RESERVE: armalab at (536, 168) facing 2 (id 19)
  0.42  RESERVE: zone 11 at (536, 288) facing 2, 7x6 cells: 7 of 42 held
  0.43  RESERVE: armlab at (368, 688) facing 1 (id 20)
  0.43  RESERVE: served armlab at (368, 688) facing 1 (id 20, 1 of this def still held)
  0.47  EXP: idle: legcom(28186) on legmex at (6105, 11507), site (6304, 11568), target no, fails 1
  0.65  RESERVE: zone 1 at (4808, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4808, 11640) facing 2 (id 1)
  0.65  RESERVE: zone 2 at (4760, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4760, 11640) facing 2 (id 2)
  0.65  RESERVE: zone 3 at (4712, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4712, 11640) facing 2 (id 3)
  0.65  RESERVE: zone 4 at (4808, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4808, 11592) facing 2 (id 4)
  0.65  RESERVE: zone 5 at (4760, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4760, 11592) facing 2 (id 5)
  0.65  RESERVE: zone 6 at (4712, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4712, 11592) facing 2 (id 6)
  0.65  RESERVE: served corwin at (4808, 11640) facing 2 (id 1, 5 of this def still held)
  0.67  RESERVE: zone 1 at (3000, 888) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (3000, 888) facing 0 (id 1)
  0.67  RESERVE: zone 2 at (3048, 888) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (3048, 888) facing 0 (id 2)
  0.67  RESERVE: zone 3 at (3096, 888) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (3096, 888) facing 0 (id 3)
  0.67  RESERVE: zone 4 at (3000, 936) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (3000, 936) facing 0 (id 4)
  0.67  RESERVE: zone 5 at (3048, 936) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (3048, 936) facing 0 (id 5)
  0.67  RESERVE: zone 6 at (3096, 936) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (3096, 936) facing 0 (id 6)
  0.67  RESERVE: served legwin at (3000, 888) facing 0 (id 1, 5 of this def still held)
  0.73  RESERVE: corridor 12 at (576, 688) facing 1, 20x10 cells: 150 of 200 held
  0.74  EXP: swap: armcom(1236) from task type 5 to task type 5
  0.74  EXP: approach: armcom(1236) at (296, 625) walks to (309, 549), 136 from the armwin site (440, 512)
  0.75  RESERVE: armwin at (424, 440) facing 0 (id 21)
  0.75  RESERVE: packed armwin near (452, 461) at (424, 440), 35 away (id 21, 1384 candidates)
  0.77  RESERVE: served corwin at (4760, 11640) facing 2 (id 2, 4 of this def still held)
  0.82  RESERVE: served legwin at (3048, 888) facing 0 (id 2, 4 of this def still held)
  0.86  EXP: approach: legcom(28186) at (6274, 11713) walks to (5875, 11551), 163 from the leglab site (5988, 11435)
  0.86  RESERVE: served leglab at (6160, 11392) facing 2 (id 1, 2 of this def still held)
```
