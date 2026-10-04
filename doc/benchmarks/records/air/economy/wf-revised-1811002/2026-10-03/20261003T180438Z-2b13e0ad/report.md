# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54036); wall 219 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:00:56
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\tundra\runs\20261003T180438Z-2b13e0ad\infolog.txt

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
- forbid 'invariant' hit at 12.6 min: [INVARIANT] INV-014 legwin ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 13.7 min: [INVARIANT] INV-022 a new set of legafus starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 17.2 min: [INVARIANT] INV-029 leghp 18244 stands 14 cells from the turrets, not tight
- forbid 'invariant' hit at 17.4 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of legalab 12406 are not on it
- forbid 'invariant' hit at 18.4 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 18.6 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of legwin 20213 are not on it
- forbid 'invariant' hit at 19.8 min: [INVARIANT] INV-029 legap 26151 stands 18 cells from the turrets, not tight
- forbid 'invariant' hit at 19.8 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 20.8 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 21.8 min: [INVARIANT] INV-020 no layout room for legafus for 120 s
- forbid 'invariant' hit at 21.8 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 22.8 min: [INVARIANT] INV-020 no layout room for legafus for 181 s
- forbid 'invariant' hit at 22.8 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-020 no layout room for legafus for 285 s
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-020 no layout room for legafus for 346 s
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 26.9 min: [INVARIANT] INV-011 metal floating at 2086 of 2300 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 28.4 min: [INVARIANT] INV-029 leghp 13823 stands 9 cells from the turrets, not tight

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\tundra\runs\20261003T180438Z-2b13e0ad\screen_2026-10-03_18-02-08-211.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\tundra\runs\20261003T180438Z-2b13e0ad\screen_2026-10-03_18-02-55-968.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\tundra\runs\20261003T180438Z-2b13e0ad\screen_2026-10-03_18-03-22-937.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\tundra\runs\20261003T180438Z-2b13e0ad\screen_2026-10-03_18-04-37-549.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2800, 800) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (300, 460) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (4600, 11400) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (6000, 11400) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2800, 800) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (300, 460) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (4600, 11400) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (6000, 11400) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2866, 888), 81 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|cortex|corap|2809|829|1|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(326,467) factory=armlab landLocked=yes spot=0 known=1/1
  0.20  [Team][Roster] team 1 first mex at 480,432
  0.21  [Playtest] finished cormex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 6710 at 2848,928
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|2809|829|1|2|1|2848|928
  0.23  [AIR][Rule] opening.mex builder=26153
  0.27  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=970 E=18 bank=781 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.40  [Playtest] finished cormex team 0 at 0.40 min
  0.43  [AIR][Capacity] own=3/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=962 E=30 bank=545 pull=6 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=5/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=5 bank=1011 E=30 bank=617 pull=86 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=30/307
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.66  [Playtest] finished cormex team 0 at 0.66 min
  0.68  [AIR][Wind] cluster=0 slots=6 at=3048,928 local=true builder=26153
  0.68  [AIR][Rule] opening.energy builder=26153
  0.77  [AIR][Capacity] own=5/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=5 bank=1031 E=30 bank=435 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=24/99
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.82  [Playtest] finished corwin team 0 at 0.82 min
  0.93  [AIR][Capacity] own=7/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=1045 E=30 bank=447 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=1/6
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.94  [Playtest] finished corwin team 0 at 0.94 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1057/1150, energy +45.6 bank 514/1001, units 7
  1.05  [Playtest] finished corwin team 0 at 1.05 min
  1.10  [AIR][Capacity] own=7/38 usage=3/22 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=1070 E=40 bank=617 pull=22 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=32/131
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.17  [Playtest] finished corwin team 0 at 1.17 min
  1.27  [AIR][Capacity] own=7/57 usage=7/39 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=1102 E=55 bank=981 pull=39 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=28/114
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.33  [Playtest] finished corwin team 0 at 1.33 min
  1.43  [AIR][Capacity] own=7/83 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=1116 E=81 bank=952 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=5/20
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.44  [Playtest] finished corwin team 0 at 1.44 min
  1.46  [AIR][Starter] nearby distance=128
  1.46  [AIR][Rule] opening.plant builder=26153
  1.47  [AIR][EcoLayout] reserved air.eco.0 reactor=1920,832 converters=8 support=12 zone=35
  1.48  [AIR][EcoLayout] reserved air.eco.1 reactor=1792,1344 converters=8 support=12 zone=64
  1.50  [AIR][EcoLayout] reserved air.eco.2 reactor=2304,1856 converters=8 support=12 zone=111
  1.60  [AIR][Capacity] own=7/100 usage=35/70 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=961 E=99 bank=997 pull=70 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=373/652
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=8426 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=7/119 usage=35/70 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=7 bank=690 E=118 bank=998 pull=70 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=22/38
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=8426 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.78  [Playtest] finished corap team 0 at 1.78 min
  1.78  [AIR][Claim] cancel unowned native order cornanotc
  1.78  [AIR][State] T1_CONTEST
  1.79  [AIR][Produce] opening.scout corfink plant=8426 projected=1/1
  1.79  [AIR][Rule] opening.commander.guard builder=26153
  1.93  [AIR][Produce] constructor.recovery corca plant=8426 projected=1/3
  1.93  [AIR][Capacity] own=7/124 usage=4/147 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST M=7 bank=662 E=124 bank=899 pull=147 plants=1/0 aircraftDemand=3/123
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=55 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 671/1250, energy +125.8 bank 1020/1103, units 13
  2.10  [AIR][Capacity] own=7/124 usage=1/30 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST M=7 bank=663 E=124 bank=880 pull=199 plants=1/0 aircraftDemand=3/123
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=55 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.16  [AIR][Produce] constructor.recovery corca plant=8426 projected=2/3
  2.16  [AIR][Rule] mex.expand builder=24812
  2.27  [AIR][Capacity] own=7/124 usage=0/8 gifts=0 sent=0 excess=0 pressure=false mobile=55 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=7 bank=668 E=125 bank=1116 pull=199 plants=1/0 aircraftDemand=3/123
  2.27  [AIR][Projects] energyQueued=0 committed=50/500
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=110 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.39  [AIR][Produce] constructor.recovery corca plant=8426 projected=3/3
  2.39  [AIR][Rule] mex.assist builder=25585
  2.43  [AIR][Capacity] own=7/129 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=110 arriving=55 idle=0 ecoStatic=0 working=55 shortage=3 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=653 E=129 bank=1141 pull=154 plants=1/0 aircraftDemand=3/123
  2.43  [AIR][Projects] energyQueued=0 committed=35/358
  2.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=168 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=7/134 usage=5/84 gifts=0 sent=0 excess=0 pressure=false mobile=110 arriving=55 idle=0 ecoStatic=0 working=109 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=611 E=133 bank=280 pull=228 plants=1/0 aircraftDemand=3/123
  2.60  [AIR][Projects] energyQueued=0 committed=12/121
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.61  [AIR][Produce] opening.screen corveng plant=8426 projected=1/6
  2.61  [AIR][Wind] cluster=1 slots=6 at=2712,848 local=false builder=8551
  2.61  [AIR][Rule] energy.grow builder=8551
  2.67  [AIR][Rule] commander.factory.guard builder=26153
  2.69  [Playtest] finished cormex team 0 at 2.69 min
  2.70  [AIR][Rule] recovery.energy builder=24812
  2.70  [AIR][Rule] recovery.energy builder=25585
  2.77  [AIR][Capacity] own=4/133 usage=5/154 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=51 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=626 E=134 bank=15 pull=354 plants=1/0 aircraftDemand=3/123
  2.77  [AIR][Projects] energyQueued=2 committed=337/152
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Produce] opening.screen corveng plant=8426 projected=2/6
  2.93  [AIR][Screen] fighters=1 cells=8 centre=471,839 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=6/137 usage=10/152 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=165 shortage=93 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=627 E=137 bank=35 pull=341 plants=1/0 aircraftDemand=4/131
  2.93  [AIR][Projects] energyQueued=0 committed=285/97
  2.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=258 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 615/1300, energy +140.7 bank 1/1178, units 21
  3.10  [AIR][Capacity] own=7/139 usage=10/140 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=161 shortage=108 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=604 E=138 bank=9 pull=211 plants=1/0 aircraftDemand=4/131
  3.10  [AIR][Projects] energyQueued=0 committed=213/41
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=273 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Screen] fighters=1 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.22  [Playtest] finished corwin team 0 at 3.22 min
  3.24  [AIR][Rule] recovery.energy builder=8551
  3.27  [AIR][Capacity] own=7/140 usage=9/154 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=123 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=594 E=140 bank=25 pull=264 plants=1/0 aircraftDemand=4/131
  3.27  [AIR][Projects] energyQueued=1 committed=294/0
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=288 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Screen] fighters=1 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.27  [AIR][Produce] opening.screen corveng plant=8426 projected=3/6
  3.43  [AIR][Capacity] own=8/120 usage=11/119 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=98 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=580 E=131 bank=12 pull=264 plants=1/0 aircraftDemand=4/131
  3.43  [AIR][Projects] energyQueued=0 committed=212/0
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=263 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Screen] fighters=2 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.47  [AIR][Layout] cluster=0 labs=1 at=1873,2629
  3.60  [AIR][Capacity] own=8/101 usage=11/104 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=176 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=805 E=102 bank=9 pull=264 plants=1/0 aircraftDemand=4/131
  3.60  [AIR][Projects] energyQueued=0 committed=124/0
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=341 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.62  [AIR][Screen] fighters=2 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.67  [Playtest] finished corsolar team 0 at 3.67 min
  3.68  [Playtest] finished corsolar team 0 at 3.68 min
  3.70  [AIR][Produce] opening.screen corveng plant=8426 projected=4/6
  3.77  [AIR][Capacity] own=8/105 usage=13/289 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=147 reason=funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=803 E=103 bank=60 pull=289 plants=1/0 aircraftDemand=4/131
  3.77  [AIR][Projects] energyQueued=1 committed=358/0
  3.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=312 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [AIR][Screen] fighters=3 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=6/149 usage=12/157 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=106 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=789 E=151 bank=3 pull=352 plants=1/0 aircraftDemand=4/131
  3.93  [AIR][Projects] energyQueued=0 committed=270/0
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=271 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [AIR][Screen] fighters=3 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.98  [AIR][Layout] cluster=1 labs=1 at=3409,1477
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.0 bank 771/1300, energy +150.6 bank 5/1278, units 26
  4.02  [AIR][Produce] opening.screen corveng plant=8426 projected=5/6
  4.10  [AIR][Capacity] own=6/149 usage=16/289 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=109 reason=funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=998 E=149 bank=7 pull=314 plants=1/0 aircraftDemand=4/131
  4.10  [AIR][Projects] energyQueued=0 committed=182/0
  4.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=274 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.13  [AIR][Screen] fighters=4 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.16  [Playtest] finished corsolar team 0 at 4.16 min
  4.27  [AIR][Capacity] own=6/149 usage=11/112 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=185 reason=funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=970 E=149 bank=60 pull=205 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=251/0
  4.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=350 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.32  [AIR][Screen] fighters=4 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.33  [AIR][Produce] opening.screen corveng plant=8426 projected=6/6
  4.33  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.33  [AIR][Rule] commander.idle.assist builder=26153
  4.36  [AIR][Rule] commander.factory.guard builder=26153
  4.43  [AIR][Capacity] own=6/144 usage=13/178 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=141 reason=funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=933 E=151 bank=2 pull=323 plants=1/0 aircraftDemand=3/129
  4.43  [AIR][Projects] energyQueued=0 committed=162/0
  4.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=306 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.48  [AIR][Screen] fighters=5 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.55  [Playtest] finished corsolar team 0 at 4.55 min
  4.60  [AIR][Capacity] own=6/137 usage=10/175 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=189 reason=funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=1148 E=138 bank=3 pull=297 plants=1/0 aircraftDemand=3/129
  4.60  [AIR][Projects] energyQueued=1 committed=232/0
  4.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=354 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=201
  4.62  [Playtest] finished corsolar team 0 at 4.62 min
  4.65  [AIR][Screen] fighters=5 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.65  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.65  [AIR][Rule] commander.idle.assist builder=26153
  4.72  [AIR][Produce] constructor.expand corca plant=8426 projected=4/4
  4.77  [AIR][Capacity] own=7/169 usage=6/0 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=55 idle=0 ecoStatic=0 working=164 shortage=275 reason=funded workload
  4.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=1171 E=163 bank=1261 pull=56 plants=1/0 aircraftDemand=3/129
  4.77  [AIR][Projects] energyQueued=0 committed=327/0
  4.77  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=495 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.83  [AIR][Layout] cluster=2 labs=1 at=2641,1861
  4.83  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.84  [AIR][Rule] commander.energy.local builder=26153
  4.85  [AIR][Layout] cluster=3 labs=1 at=2065,2341
  4.93  [AIR][Capacity] own=9/221 usage=24/11 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=55 idle=0 ecoStatic=0 working=464 shortage=0 reason=available or arriving power
  4.93  [AIR][Economy] T1_CONTEST M=9 bank=1093 E=224 bank=1423 pull=75 plants=1/0 aircraftDemand=3/129
  4.93  [AIR][Projects] energyQueued=0 committed=317/0
  4.93  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.00  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 1002/1300, energy +218.3 bank 1420/1428, units 32
  5.00  [Playtest] target team 0 at (2800, 800) from its start position
  5.00  [Playtest] camera requested (3248,1000) height=2200
  5.01  [Playtest] finished corsolar team 0 at 5.01 min
  5.02  [AIR][Claim] cancel unowned native order cormakr
  5.02  [Playtest] camera captured name=ta position=(3248,1000) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (3248, 1000)
  5.04  [Playtest] finished corsolar team 0 at 5.04 min
  5.05  [AIR][Claim] cancel unowned native order cormakr
  5.06  [AIR][Layout] repaired support air.bay.0 viable=2/5 slot=616 at=3176,1064
  5.06  [AIR][Rule] opening.support builder=8551
  5.10  [AIR][Capacity] own=9/217 usage=13/43 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=55 idle=0 ecoStatic=0 working=409 shortage=160 reason=funded workload
  5.10  [AIR][Economy] T1_CONTEST M=9 bank=1205 E=219 bank=1528 pull=106 plants=1/0 aircraftDemand=3/129
  5.10  [AIR][Projects] energyQueued=0 committed=406/3266
  5.10  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=380 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+0/2 available=yes firstSlot=2
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=182
  5.14  [Playtest] finished corwin team 0 at 5.14 min
  5.15  [AIR][Rule] commander.factory.guard builder=26153
  5.17  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.25  [AIR][Commander] cleared factory guard for commander.energy.local
  5.25  [AIR][Rule] commander.energy.local builder=26153
  5.27  [AIR][Capacity] own=9/253 usage=5/11 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=55 idle=0 ecoStatic=0 working=164 shortage=344 reason=funded workload
  5.27  [AIR][Economy] T1_CONTEST M=9 bank=1173 E=253 bank=1529 pull=108 plants=1/0 aircraftDemand=3/129
  5.27  [AIR][Projects] energyQueued=1 committed=462/2946
  5.27  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=564 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.33  [AIR][Produce] recon.replace corfink plant=8426 projected=1/1
  5.33  [AIR][Rule] opening.support.assist builder=18705
  5.33  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.42  [Playtest] finished corsolar team 0 at 5.42 min
  5.43  [AIR][Claim] cancel unowned native order cormakr
  5.43  [AIR][Capacity] own=9/241 usage=25/102 gifts=0 sent=0 excess=0 pressure=true mobile=220 arriving=0 idle=0 ecoStatic=0 working=220 shortage=0 reason=no funded workload
  5.43  [AIR][Economy] T1_CONTEST M=9 bank=1006 E=249 bank=1541 pull=169 plants=1/0 aircraftDemand=3/129
  5.43  [AIR][Projects] energyQueued=0 committed=216/2431
  5.43  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.44  [AIR][Rule] commander.factory.guard builder=26153
  5.50  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.51  [Playtest] finished corsolar team 0 at 5.51 min
  5.52  [AIR][Claim] cancel unowned native order cormakr
  5.53  [AIR][Rule] opening.support.assist builder=24812
  5.53  [AIR][Commander] cleared factory guard for opening.support.assist
  5.53  [AIR][Rule] opening.support.assist builder=26153
  5.54  [AIR][Produce] air.control corveng plant=8426 projected=7/7
  5.59  [Playtest] finished corsolar team 0 at 5.59 min
  5.60  [AIR][Capacity] own=9/255 usage=6/138 gifts=0 sent=0 excess=0 pressure=true mobile=220 arriving=0 idle=55 ecoStatic=0 working=409 shortage=0 reason=no funded workload
  5.60  [AIR][Economy] T1_CONTEST M=9 bank=1179 E=256 bank=1375 pull=385 plants=1/0 aircraftDemand=3/129
  5.60  [AIR][Projects] energyQueued=0 committed=88/1230
  5.60  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=true savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=8426 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=164
  5.61  [AIR][Rule] transition.storage builder=25585
  5.67  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.67  [Playtest] finished cornanotc team 0 at 5.67 min
  5.68  [AIR][Rule] mex.expand builder=24812
  5.69  [AIR][Rule] storage.buffer builder=8551
  5.69  [AIR][Rule] energy.grow builder=18705
  5.70  [AIR][Rule] commander.factory.guard builder=26153
  5.77  [AIR][Capacity] own=9/276 usage=20/569 gifts=0 sent=0 excess=0 pressure=true mobile=220 arriving=0 idle=0 ecoStatic=0 working=91 shortage=0 reason=no funded workload
  5.77  [AIR][Economy] T1_CONTEST M=9 bank=1092 E=276 bank=459 pull=569 plants=1/0 aircraftDemand=8/293
  5.77  [AIR][Projects] energyQueued=1 committed=572/2990
  5.77  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=true savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=8426 BP=350 nanos=1+0/2 available=yes firstSlot=3
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.78  [AIR][Produce] air.control corveng plant=8426 projected=8/8
  5.80  [AIR][Support] return to production bay=0
  5.85  [AIR][Screen] fighters=7 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.93  [AIR][Capacity] own=9/258 usage=15/261 gifts=0 sent=0 excess=0 pressure=true mobile=220 arriving=0 idle=0 ecoStatic=0 working=163 shortage=0 reason=no funded workload
  5.93  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=975 E=264 bank=32 pull=304 plants=1/0 aircraftDemand=8/296
  5.93  [AIR][Projects] energyQueued=0 committed=418/2450
  5.93  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=true savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=8426 BP=350 nanos=1+0/0 available=yes firstSlot=3
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.99  [AIR][Commander] cleared factory guard for commander.idle.assist
... 2665 more
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
  0.08  EXP: approach: armcom(30290) at (327, 468) walks to (347, 463), 136 from the armmex site (480, 432)
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
  0.09  EXP: approach: legcom(13591) at (5988, 11437) walks to (5877, 11461), 137 from the legmex site (5936, 11584)
  0.11  EXP: idle: armcom(30290) on armmex at (338, 465), site (480, 432), target yes, fails 2 (arrived at the approach point)
  0.16  EXP: idle: legcom(13591) on legmex at (5884, 11459), site (5936, 11584), target yes, fails 2 (arrived at the approach point)
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
  0.19  EXP: approach: corcom(28807) at (4599, 11401) walks to (4532, 11356), 139 from the cormex site (4416, 11280)
  0.21  EXP: approach: armcom(30290) at (338, 465) walks to (280, 654), 136 from the armmex site (240, 784)
  0.23  EXP: approach: corcom(26153) at (2823, 865) walks to (2738, 833), 139 from the cormex site (2608, 784)
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
  0.37  EXP: approach: corcom(28807) at (4542, 11373) walks to (4746, 11635), 139 from the cormex site (4832, 11744)
  0.41  EXP: approach: corcom(26153) at (2754, 834) walks to (3037, 931), 139 from the cormex site (3168, 976)
  0.44  RESERVE: armlab at (368, 688) facing 1 (id 19)
  0.44  RESERVE: served armlab at (368, 688) facing 1 (id 19, 1 of this def still held)
  0.58  RESERVE: armlab at (256, 144) facing 2 (id 20)
  0.58  RESERVE: zone 11 at (256, 216) facing 2, 6x3 cells: 3 of 18 held
  0.65  RESERVE: zone 1 at (4824, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4824, 11640) facing 2 (id 1)
  0.65  RESERVE: zone 2 at (4776, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4776, 11640) facing 2 (id 2)
  0.65  RESERVE: zone 3 at (4728, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4728, 11640) facing 2 (id 3)
  0.65  RESERVE: zone 4 at (4824, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4824, 11592) facing 2 (id 4)
  0.65  RESERVE: zone 5 at (4776, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4776, 11592) facing 2 (id 5)
  0.65  RESERVE: zone 6 at (4728, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: corwin at (4728, 11592) facing 2 (id 6)
  0.65  RESERVE: served corwin at (4824, 11640) facing 2 (id 1, 5 of this def still held)
  0.68  RESERVE: zone 1 at (3000, 904) facing 0, 3x3 cells: 9 of 9 held
  0.68  RESERVE: corwin at (3000, 904) facing 0 (id 1)
  0.68  RESERVE: zone 2 at (3048, 904) facing 0, 3x3 cells: 9 of 9 held
  0.68  RESERVE: corwin at (3048, 904) facing 0 (id 2)
  0.68  RESERVE: zone 3 at (3096, 904) facing 0, 3x3 cells: 9 of 9 held
  0.68  RESERVE: corwin at (3096, 904) facing 0 (id 3)
  0.68  RESERVE: zone 4 at (3000, 952) facing 0, 3x3 cells: 9 of 9 held
  0.68  RESERVE: corwin at (3000, 952) facing 0 (id 4)
  0.68  RESERVE: zone 5 at (3048, 952) facing 0, 3x3 cells: 9 of 9 held
  0.68  RESERVE: corwin at (3048, 952) facing 0 (id 5)
  0.68  RESERVE: zone 6 at (3096, 952) facing 0, 3x3 cells: 9 of 9 held
  0.68  RESERVE: corwin at (3096, 952) facing 0 (id 6)
  0.68  RESERVE: served corwin at (3000, 904) facing 0 (id 1, 5 of this def still held)
  0.75  RESERVE: corridor 12 at (576, 688) facing 1, 20x10 cells: 150 of 200 held
  0.76  EXP: swap: armcom(30290) from task type 5 to task type 5
  0.76  EXP: approach: armcom(30290) at (295, 627) walks to (309, 550), 136 from the armwin site (440, 512)
  0.76  RESERVE: armwin at (392, 552) facing 0 (id 21)
  0.76  RESERVE: packed armwin near (395, 552) at (392, 552), 3 away (id 21, 1493 candidates)
  0.77  RESERVE: served corwin at (4776, 11640) facing 2 (id 2, 4 of this def still held)
  0.77  EXP: approach: legcom(13591) at (6273, 11711) walks to (5875, 11554), 163 from the leglab site (5988, 11437)
  0.77  RESERVE: served leglab at (6160, 11392) facing 2 (id 1, 2 of this def still held)
  0.83  RESERVE: served corwin at (3048, 904) facing 0 (id 2, 4 of this def still held)
```
