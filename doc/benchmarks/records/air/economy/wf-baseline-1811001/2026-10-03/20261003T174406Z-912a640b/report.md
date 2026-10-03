# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54020); wall 222 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:40:22
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\tundra\runs\20261003T174406Z-912a640b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-001 a retiring factory produced legck 25952` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 2.0 min: [INVARIANT] INV-001 a retiring factory produced legck 25952
- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 12.0 min: [INVARIANT] INV-014 legwin ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 13.0 min: [INVARIANT] INV-014 legwin ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 13.4 min: [INVARIANT] INV-008 5 turret(s) in range of the reclaim of legalab 15664 are not on it
- forbid 'invariant' hit at 14.4 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 15.4 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 16.4 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 16.9 min: [INVARIANT] INV-029 leghp 701 stands 4 cells from the turrets, not tight
- forbid 'invariant' hit at 17.2 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of legwin 11944 are not on it
- forbid 'invariant' hit at 17.7 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 19.8 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 6045 (22 by power), bank 28 + 88/s (0 by metal))
- forbid 'invariant' hit at 22.9 min: [INVARIANT] INV-020 no layout room for legmstor for 123 s
- forbid 'invariant' hit at 23.0 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 23.7 min: [INVARIANT] INV-011 metal floating at 3200 of 3200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 23.9 min: [INVARIANT] INV-020 no layout room for legmstor for 183 s
- forbid 'invariant' hit at 24.1 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 24.7 min: [INVARIANT] INV-011 metal floating at 3199 of 3200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 25.7 min: [INVARIANT] INV-011 metal floating at 3186 of 3200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-020 no layout room for legmstor for 302 s
- forbid 'invariant' hit at 27.0 min: [INVARIANT] INV-020 no layout room for legadveconv for 366 s
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-020 no layout room for legmstor for 427 s
- forbid 'invariant' hit at 28.3 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-020 no layout room for legmstor for 487 s
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 29.4 min: [INVARIANT] INV-011 metal floating at 3200 of 3200 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 30.0 min: [INVARIANT] INV-020 no layout room for legmstor for 547 s

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\tundra\runs\20261003T174406Z-912a640b\screen_2026-10-03_17-41-23-927.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\tundra\runs\20261003T174406Z-912a640b\screen_2026-10-03_17-42-09-965.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\tundra\runs\20261003T174406Z-912a640b\screen_2026-10-03_17-42-34-113.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\tundra\runs\20261003T174406Z-912a640b\screen_2026-10-03_17-44-05-839.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2800, 800) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (300, 460) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (4600, 11400) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (6000, 11400) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2800, 800) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (300, 460) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (4600, 11400) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (6000, 11400) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2866, 888), 81 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2810|828|1|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(327,467) factory=armlab landLocked=yes spot=0 known=1/1
  0.21  [Playtest] finished armmex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 19579 at 2848,928
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2810|828|1|2|1|2848|928
  0.22  [Team][Roster] team 1 first mex at 480,432
  0.22  [AIR][Rule] opening.mex builder=2274
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=972 E=18 bank=811 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=311 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.39  [Playtest] finished armmex team 0 at 0.39 min
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=965 E=30 bank=572 pull=6 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=386 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Economy] BOOTSTRAP M=5 bank=1013 E=30 bank=641 pull=89 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=29/299
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=486 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.66  [Playtest] finished armmex team 0 at 0.66 min
  0.67  [AIR][Wind] cluster=0 slots=6 at=3048,928 local=true builder=2274
  0.67  [AIR][Rule] opening.energy builder=2274
  0.77  [AIR][Economy] BOOTSTRAP M=5 bank=1036 E=30 bank=459 pull=41 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=22/96
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=492 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.81  [Playtest] finished armwin team 0 at 0.81 min
  0.92  [Playtest] finished armwin team 0 at 0.92 min
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=1049 E=30 bank=460 pull=41 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=572 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1064/1150, energy +61.5 bank 597/1001, units 7
  1.04  [Playtest] finished armwin team 0 at 1.04 min
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=1075 E=51 bank=793 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=22/96
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=588 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.15  [Playtest] finished armwin team 0 at 1.15 min
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=1107 E=69 bank=970 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=14/62
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=607 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.30  [Playtest] finished armwin team 0 at 1.30 min
  1.41  [Playtest] finished armwin team 0 at 1.41 min
  1.43  [AIR][Wind] cluster=1 slots=6 at=2712,848 local=false builder=2274
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=1126 E=67 bank=1003 pull=37 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=1 committed=40/175
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=618 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=102 bank=1003 pull=9 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=1 committed=40/175
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=625 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.71  [Playtest] finished armwin team 0 at 1.71 min
  1.73  [AIR][Starter] nearby distance=128
  1.73  [AIR][Rule] opening.plant builder=2274
  1.73  [AIR][EcoLayout] reserved air.eco.0 reactor=1920,832 converters=8 zone=29
  1.75  [AIR][EcoLayout] reserved air.eco.1 reactor=1792,1344 converters=8 zone=47
  1.77  [AIR][EcoLayout] reserved air.eco.2 reactor=2304,1856 converters=8 zone=82
  1.77  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=105 bank=999 pull=9 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=616/1043
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=625 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=1646 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Economy] BOOTSTRAP M=7 bank=861 E=108 bank=1003 pull=69 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=258/437
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=1646 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 724/1150, energy +140.6 bank 995/1003, units 12
  2.05  [Playtest] finished armap team 0 at 2.05 min
  2.06  [AIR][Produce] opening.scout armpeep plant=1646 projected=1/1
  2.07  [AIR][Claim] cancel unowned native order armnanotc
  2.07  [AIR][Claim] cancel unowned native order armnanotc
  2.07  [AIR][State] T1_CONTEST
  2.07  [AIR][Rule] opening.commander.guard builder=2274
  2.10  [AIR][Economy] T1_CONTEST M=7 bank=646 E=127 bank=1063 pull=50 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.21  [AIR][Produce] constructor.recovery armca plant=1646 projected=1/3
  2.27  [AIR][Economy] T1_CONTEST M=7 bank=667 E=141 bank=1102 pull=134 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=652 E=141 bank=896 pull=197 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.44  [AIR][Produce] constructor.recovery armca plant=1646 projected=2/3
  2.44  [AIR][Rule] mex.expand builder=18052
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=652 E=145 bank=672 pull=178 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=44/443
  2.60  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.66  [AIR][Produce] constructor.recovery armca plant=1646 projected=3/3
  2.66  [AIR][Rule] mex.assist builder=8853
  2.77  [AIR][Economy] T1_CONTEST M=7 bank=634 E=146 bank=352 pull=220 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=28/281
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.88  [AIR][Produce] opening.screen armfig plant=1646 projected=1/6
  2.88  [AIR][Rule] recovery.energy builder=19803
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=612 E=151 bank=0 pull=282 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=161/62
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=177 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.95  [AIR][Rule] commander.factory.guard builder=2274
  3.00  [Playtest] eco team 0 at 3.0 min: metal +7.0 bank 606/1250, energy +156.9 bank 1/1178, units 19
  3.01  [Playtest] finished armmex team 0 at 3.01 min
  3.02  [AIR][Rule] recovery.energy builder=18052
  3.03  [AIR][Rule] recovery.energy builder=8853
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=611 E=155 bank=12 pull=260 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=2 committed=436/0
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=139 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.23  [AIR][Produce] opening.screen armfig plant=1646 projected=2/6
  3.23  [AIR][Screen] fighters=1 cells=8 centre=472,839 width=600 advance=400 responding=false
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=849 E=156 bank=205 pull=119 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=362/0
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.40  [AIR][Layout] cluster=0 labs=1 at=1874,2628
  3.40  [AIR][Screen] fighters=1 cells=8 centre=472,839 width=600 advance=400 responding=false
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=819 E=131 bank=10 pull=260 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=273/0
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=230 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.57  [AIR][Screen] fighters=1 cells=8 centre=472,839 width=600 advance=400 responding=false
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=803 E=102 bank=4 pull=260 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=184/0
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=230 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.66  [AIR][Produce] opening.screen armfig plant=1646 projected=3/6
  3.73  [AIR][Screen] fighters=2 cells=8 centre=472,839 width=600 advance=400 responding=false
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=1024 E=103 bank=6 pull=351 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=94/0
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=555 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.81  [Playtest] finished armsolar team 0 at 3.81 min
  3.90  [AIR][Screen] fighters=2 cells=8 centre=472,839 width=600 advance=400 responding=false
  3.92  [AIR][Layout] cluster=1 labs=1 at=3410,1476
  3.93  [AIR][Layout] cluster=2 labs=1 at=3218,1668
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=1006 E=119 bank=4 pull=322 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=170/0
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=537 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.0 bank 989/1300, energy +132.5 bank 2/1228, units 24
  4.00  [Playtest] finished armsolar team 0 at 4.00 min
  4.01  [AIR][Rule] recovery.assist builder=8853
  4.02  [Playtest] finished armsolar team 0 at 4.02 min
  4.03  [AIR][Rule] recovery.assist builder=18052
  4.06  [AIR][Produce] opening.screen armfig plant=1646 projected=4/6
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=995 E=132 bank=279 pull=103 plants=1/0 aircraftDemand=3/124
  4.10  [AIR][Projects] energyQueued=0 committed=94/0
  4.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=509 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Screen] fighters=3 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.10  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=215
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=1193 E=168 bank=11 pull=273 plants=1/0 aircraftDemand=3/124
  4.27  [AIR][Projects] energyQueued=0 committed=4/0
  4.27  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=664 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Screen] fighters=3 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.28  [Playtest] finished armsolar team 0 at 4.28 min
  4.29  [AIR][Rule] mex.expand builder=19803
  4.29  [AIR][Rule] intel.radar builder=18052
  4.30  [AIR][Rule] wait builder=8853
  4.35  [AIR][Produce] opening.screen armfig plant=1646 projected=5/6
  4.36  [AIR][Rule] project.assist builder=8853
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=1229 E=177 bank=105 pull=342 plants=1/0 aircraftDemand=3/124
  4.43  [AIR][Projects] energyQueued=0 committed=96/983
  4.43  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=692 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Screen] fighters=4 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.59  [Playtest] finished armrad team 0 at 4.59 min
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=1224 E=200 bank=8 pull=315 plants=1/0 aircraftDemand=3/124
  4.60  [AIR][Projects] energyQueued=0 committed=48/481
  4.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=603 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Screen] fighters=4 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.60  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=194
  4.61  [AIR][Rule] project.assist builder=18052
  4.63  [AIR][Share] metal 1238 of 1300 (95%): sent 100 to team 1 (91% full); the engine counts 0 metal sent in the last update (D-106)
  4.66  [AIR][Produce] opening.screen armfig plant=1646 projected=6/6
  4.67  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1081) (D-106)
  4.72  [AIR][Share] metal 1287 of 1300 (99%): sent 86 to team 1 (92% full); the engine counts 1 metal sent in the last update (D-106)
  4.75  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  4.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=1231 E=199 bank=9 pull=331 plants=1/0 aircraftDemand=3/125
  4.77  [AIR][Projects] energyQueued=0 committed=37/375
  4.77  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=694 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Screen] fighters=5 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.80  [AIR][Share] metal 1287 of 1300 (99%): sent 34 to team 1 (97% full); the engine counts 3 metal sent in the last update (D-106)
  4.82  [Ferry] AIR: queued request from team 1
  4.82  [Ferry] AIR: serving team 1 queued=0
  4.83  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  4.93  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=1298 E=194 bank=31 pull=263 plants=1/0 aircraftDemand=3/125
  4.93  [AIR][Projects] energyQueued=0 committed=10/108
  4.93  [AIR][Workforce] t1=3/16 t2=0/7 targetBP=781 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Screen] fighters=5 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.95  [Ferry] AIR: ordered one armatlas for team 1
  4.95  [AIR][Layout] cluster=3 labs=1 at=2066,2340
  4.98  [Playtest] finished armmex team 0 at 4.98 min
  5.00  [AIR][Rule] wait builder=19803
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.0 bank 1327/1350, energy +186.7 bank 347/1378, units 29
  5.00  [Playtest] target team 0 at (2800, 800) from its start position
  5.00  [Playtest] camera requested (2928,920) height=2200
  5.00  [AIR][Rule] transition.storage builder=18052
  5.00  [AIR][Rule] wait builder=8853
  5.02  [Playtest] camera captured name=ta position=(2928,920) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2928, 920)
  5.10  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=1350 E=186 bank=477 pull=166 plants=1/0 aircraftDemand=3/125
  5.10  [AIR][Projects] energyQueued=0 committed=330/570
  5.10  [AIR][Workforce] t1=3/15 t2=0/7 targetBP=742 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=176
  5.12  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.12  [Ferry] AIR: transport 30085 built for team 1; hold pending task
  5.12  [AIR][Rule] project.assist builder=19803
  5.13  [AIR][Rule] project.assist builder=8853
  5.15  [Ferry] AIR: transport 30085 flying to (327,467)
  5.20  [AIR][Produce] constructor.expand armca plant=1646 projected=4/17
  5.21  [AIR][Commander] cleared factory guard for commander.idle.energy
  5.21  [AIR][Rule] commander.idle.energy builder=2274
  5.22  [AIR][Rule] commander.factory.guard builder=2274
  5.27  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=1336 E=187 bank=1309 pull=174 plants=1/0 aircraftDemand=3/125
  5.27  [AIR][Projects] energyQueued=0 committed=250/433
  5.27  [AIR][Workforce] t1=4/17 t2=0/7 targetBP=828 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.28  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.32  [AIR][Commander] cleared factory guard for commander.energy.local
  5.32  [AIR][Rule] commander.energy.local builder=2274
  5.38  [Ferry] AIR: transport 30085 arrived and transferred to team 1
  5.42  [Playtest] finished armwin team 0 at 5.42 min
  5.43  [AIR][Economy] T1_CONTEST M=12 bank=1332 E=196 bank=1309 pull=140 plants=1/0 aircraftDemand=3/125
  5.43  [AIR][Projects] energyQueued=0 committed=81/140
  5.43  [AIR][Workforce] t1=4/18 t2=0/8 targetBP=852 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.45  [AIR][State] T1_SCALE
  5.47  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.47  [AIR][Share] metal 1301 of 1350 (96%): sent 41 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  5.50  [AIR][Share] after the donation: we sent 20; team 1 received 20 (bank 1188) (D-106)
  5.51  [Playtest] finished armmstor team 0 at 5.51 min
  5.52  [AIR][State] T1_CONTEST
  5.53  [AIR][Rule] energy.grow builder=19803
  5.53  [AIR][Rule] energy.grow builder=18052
  5.53  [AIR][Rule] energy.grow builder=8853
  5.55  [Playtest] finished armwin team 0 at 5.55 min
  5.56  [AIR][Rule] commander.factory.guard builder=2274
  5.60  [AIR][Wind] cluster=2 slots=6 at=2536,560 local=false builder=13761
  5.60  [AIR][Rule] energy.grow builder=13761
  5.60  [AIR][Economy] T1_CONTEST M=11 bank=1342 E=219 bank=1379 pull=85 plants=1/0 aircraftDemand=3/125
  5.60  [AIR][Projects] energyQueued=2 committed=157/687
  5.60  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=287 floating=false savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=159
  5.63  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.66  [AIR][Commander] cleared factory guard for commander.energy.assist
  5.66  [AIR][Rule] commander.energy.assist builder=2274
  5.68  [AIR][State] T1_SCALE
  5.70  [AIR][State] T1_CONTEST
  5.74  [Playtest] finished armwin team 0 at 5.74 min
  5.77  [AIR][Economy] T1_CONTEST M=11 bank=1632 E=243 bank=1404 pull=47 plants=1/0 aircraftDemand=3/125
  5.77  [AIR][Projects] energyQueued=1 committed=126/552
  5.77  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=287 floating=false savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.80  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.82  [Playtest] finished armwin team 0 at 5.82 min
  5.83  [AIR][Rule] commander.idle.assist builder=2274
  5.93  [AIR][Economy] T1_CONTEST M=11 bank=1681 E=251 bank=1405 pull=36 plants=1/0 aircraftDemand=3/125
  5.93  [AIR][Projects] energyQueued=0 committed=92/405
  5.93  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=287 floating=false savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.95  [Playtest] finished armwin team 0 at 5.95 min
  5.96  [AIR][Rule] storage.buffer builder=8853
  5.97  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.0 bank 1717/4350, energy +319.0 bank 1404/1406, units 38
  6.10  [AIR][Economy] T1_CONTEST M=11 bank=1991 E=285 bank=1406 pull=69 plants=1/0 aircraftDemand=3/126
  6.10  [AIR][Projects] energyQueued=0 committed=205/1815
  6.10  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=287 floating=false savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.10  [AIR][Bay] 0 plant=1646 BP=150 nanos=0+0/2 available=yes firstSlot=0
  6.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=144
  6.12  [Playtest] finished armwin team 0 at 6.12 min
  6.13  [AIR][Rule] commander.energy.assist builder=2274
  6.13  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  6.13  [AIR][Rule] mex.phase.convert builder=18052
  6.18  [Playtest] finished armwin team 0 at 6.18 min
... 2507 more
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
  0.08  EXP: approach: armcom(1901) at (328, 468) walks to (347, 463), 136 from the armmex site (480, 432)
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
  0.09  EXP: approach: legcom(17070) at (5988, 11437) walks to (5877, 11461), 137 from the legmex site (5936, 11584)
  0.11  EXP: idle: armcom(1901) on armmex at (338, 465), site (480, 432), target yes, fails 2 (arrived at the approach point)
  0.16  EXP: idle: legcom(17070) on legmex at (5884, 11459), site (5936, 11584), target yes, fails 2 (arrived at the approach point)
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
  0.17  EXP: approach: corcom(24492) at (4599, 11401) walks to (4532, 11356), 139 from the cormex site (4416, 11280)
  0.22  EXP: approach: armcom(1901) at (338, 465) walks to (280, 654), 136 from the armmex site (240, 784)
  0.22  EXP: approach: armcom(2274) at (2824, 864) walks to (2736, 831), 136 from the armmex site (2608, 784)
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
  0.34  EXP: approach: corcom(24492) at (4549, 11378) walks to (4747, 11634), 139 from the cormex site (4832, 11744)
  0.41  EXP: approach: armcom(2274) at (2757, 836) walks to (3039, 932), 136 from the armmex site (3168, 976)
  0.42  RESERVE: armlab at (256, 352) facing 2 (id 19)
  0.42  RESERVE: zone 11 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.42  RESERVE: armlab at (272, 144) facing 2 (id 20)
  0.42  RESERVE: zone 11 at (272, 216) facing 2, 6x3 cells: 0 of 18 held
  0.45  RESERVE: armlab at (368, 688) facing 1 (id 21)
  0.45  RESERVE: served armlab at (368, 688) facing 1 (id 21, 1 of this def still held)
  0.58  RESERVE: armlab at (256, 352) facing 2 (id 22)
  0.58  RESERVE: zone 11 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.58  RESERVE: armlab at (256, 336) facing 2 (id 23)
  0.58  RESERVE: zone 11 at (256, 408) facing 2, 6x3 cells: 6 of 18 held
  0.58  RESERVE: armlab at (288, 144) facing 2 (id 24)
  0.58  RESERVE: zone 12 at (288, 216) facing 2, 6x3 cells: 3 of 18 held
  0.62  RESERVE: zone 1 at (4824, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4824, 11640) facing 2 (id 1)
  0.62  RESERVE: zone 2 at (4776, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4776, 11640) facing 2 (id 2)
  0.62  RESERVE: zone 3 at (4728, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4728, 11640) facing 2 (id 3)
  0.62  RESERVE: zone 4 at (4824, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4824, 11592) facing 2 (id 4)
  0.62  RESERVE: zone 5 at (4776, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4776, 11592) facing 2 (id 5)
  0.62  RESERVE: zone 6 at (4728, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4728, 11592) facing 2 (id 6)
  0.62  RESERVE: served corwin at (4824, 11640) facing 2 (id 1, 5 of this def still held)
  0.67  RESERVE: zone 1 at (3000, 904) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: armwin at (3000, 904) facing 0 (id 1)
  0.67  RESERVE: zone 2 at (3048, 904) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: armwin at (3048, 904) facing 0 (id 2)
  0.67  RESERVE: zone 3 at (3096, 904) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: armwin at (3096, 904) facing 0 (id 3)
  0.67  RESERVE: zone 4 at (3000, 952) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: armwin at (3000, 952) facing 0 (id 4)
  0.67  RESERVE: zone 5 at (3048, 952) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: armwin at (3048, 952) facing 0 (id 5)
  0.67  RESERVE: zone 6 at (3096, 952) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: armwin at (3096, 952) facing 0 (id 6)
  0.67  RESERVE: served armwin at (3000, 904) facing 0 (id 1, 5 of this def still held)
  0.73  RESERVE: served corwin at (4776, 11640) facing 2 (id 2, 4 of this def still held)
```
