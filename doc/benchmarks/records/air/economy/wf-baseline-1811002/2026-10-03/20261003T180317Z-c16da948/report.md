# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54000); wall 198 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:59:55
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\tundra\runs\20261003T180317Z-c16da948\infolog.txt

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
- forbid 'invariant' hit at 5.8 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 952 (3 by power), bank 0 + 11/s (0 by metal))
- forbid 'invariant' hit at 15.6 min: [INVARIANT] INV-008 4 turret(s) in range of the reclaim of legwin 18907 are not on it
- forbid 'invariant' hit at 16.6 min: [INVARIANT] INV-029 leghp 11545 stands 2 cells from the turrets, not tight
- forbid 'invariant' hit at 17.6 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of legalab 1182 are not on it
- forbid 'invariant' hit at 25.2 min: [INVARIANT] INV-029 legaap 22197 stands 11 cells from the turrets, not tight
- forbid 'invariant' hit at 25.2 min: [INVARIANT] INV-022 a new set of legafus starts 12 cell(s) from the turrets, not flush

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\tundra\runs\20261003T180317Z-c16da948\screen_2026-10-03_18-01-00-529.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\tundra\runs\20261003T180317Z-c16da948\screen_2026-10-03_18-01-46-132.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\tundra\runs\20261003T180317Z-c16da948\screen_2026-10-03_18-02-08-156.png

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
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2866, 888), 80 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|cortex|corap|2810|830|1|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(326,467) factory=armlab landLocked=yes spot=0 known=1/1
  0.20  [Team][Roster] team 1 first mex at 480,432
  0.21  [Playtest] finished cormex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 6710 at 2848,928
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|2810|830|1|2|1|2848|928
  0.23  [AIR][Rule] opening.mex builder=26153
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=970 E=18 bank=781 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=310 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.40  [Playtest] finished cormex team 0 at 0.40 min
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=962 E=30 bank=545 pull=6 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=377 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Economy] BOOTSTRAP M=5 bank=1011 E=30 bank=617 pull=86 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=30/307
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=478 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.66  [Playtest] finished cormex team 0 at 0.66 min
  0.68  [AIR][Wind] cluster=0 slots=6 at=3048,928 local=true builder=26153
  0.68  [AIR][Rule] opening.energy builder=26153
  0.77  [AIR][Economy] BOOTSTRAP M=5 bank=1031 E=30 bank=435 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=24/99
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=489 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.82  [Playtest] finished corwin team 0 at 0.82 min
  0.93  [Playtest] finished corwin team 0 at 0.93 min
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=1041 E=30 bank=429 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=567 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1054/1150, energy +51.7 bank 512/1001, units 7
  1.04  [Playtest] finished corwin team 0 at 1.04 min
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=1066 E=47 bank=656 pull=38 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=28/115
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=582 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.16  [Playtest] finished corwin team 0 at 1.16 min
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=1098 E=59 bank=951 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=24/98
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=602 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.32  [Playtest] finished corwin team 0 at 1.32 min
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=1112 E=61 bank=975 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=1/5
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=610 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.44  [Playtest] finished corwin team 0 at 1.44 min
  1.45  [AIR][Wind] cluster=1 slots=6 at=2712,848 local=false builder=26153
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=64 bank=972 pull=39 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=28/114
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=625 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.66  [Playtest] finished corwin team 0 at 1.66 min
  1.77  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=71 bank=989 pull=40 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=8/36
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=625 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.79  [Playtest] finished corwin team 0 at 1.79 min
  1.91  [Playtest] finished corwin team 0 at 1.91 min
  1.93  [AIR][Starter] nearby distance=128
  1.93  [AIR][Rule] opening.plant builder=26153
  1.93  [AIR][EcoLayout] reserved air.eco.0 reactor=1920,832 converters=8 zone=29
  1.93  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=89 bank=1004 pull=28 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=630/1100
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=625 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.95  [AIR][EcoLayout] reserved air.eco.1 reactor=1792,1344 converters=8 zone=47
  1.97  [AIR][EcoLayout] reserved air.eco.2 reactor=2304,1856 converters=8 zone=82
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 1049/1150, energy +154.0 bank 1000/1004, units 14
  2.10  [AIR][Economy] BOOTSTRAP M=7 bank=913 E=130 bank=997 pull=70 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=298/521
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=491 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=31761 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.24  [Playtest] finished corap team 0 at 2.24 min
  2.25  [AIR][Claim] cancel unowned native order cornanotc
  2.25  [AIR][State] T1_CONTEST
  2.25  [AIR][Produce] opening.scout corfink plant=31761 projected=1/1
  2.25  [AIR][Rule] opening.commander.guard builder=26153
  2.27  [AIR][Economy] T1_CONTEST M=7 bank=661 E=155 bank=1104 pull=37 plants=1/0 aircraftDemand=3/123
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.38  [AIR][Produce] constructor.recovery corca plant=31761 projected=1/3
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=677 E=168 bank=1067 pull=199 plants=1/0 aircraftDemand=3/123
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=660 E=161 bank=1033 pull=199 plants=1/0 aircraftDemand=3/123
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.60  [AIR][Produce] constructor.recovery corca plant=31761 projected=2/3
  2.60  [AIR][Rule] mex.expand builder=3710
  2.77  [AIR][Economy] T1_CONTEST M=7 bank=660 E=162 bank=1118 pull=171 plants=1/0 aircraftDemand=3/123
  2.77  [AIR][Projects] energyQueued=0 committed=42/425
  2.77  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.84  [AIR][Produce] constructor.recovery corca plant=31761 projected=3/3
  2.85  [AIR][Rule] mex.assist builder=5980
  2.93  [AIR][Economy] T1_CONTEST M=7 bank=642 E=161 bank=928 pull=214 plants=1/0 aircraftDemand=3/123
  2.93  [AIR][Projects] energyQueued=0 committed=26/269
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 619/1250, energy +143.7 bank 533/1154, units 19
  3.06  [AIR][Produce] opening.screen corveng plant=31761 projected=1/6
  3.07  [AIR][Rule] energy.grow builder=12049
  3.09  [Playtest] finished cormex team 0 at 3.09 min
  3.10  [AIR][Rule] mex.expand builder=5980
  3.10  [AIR][Economy] T1_CONTEST M=7 bank=608 E=142 bank=215 pull=299 plants=1/0 aircraftDemand=3/123
  3.10  [AIR][Projects] energyQueued=1 committed=93/675
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.10  [AIR][Rule] energy.grow builder=3710
  3.13  [AIR][Commander] cleared factory guard for commander.energy.assist
  3.13  [AIR][Rule] commander.energy.assist builder=26153
  3.22  [Playtest] finished corwin team 0 at 3.22 min
  3.23  [AIR][Rule] recovery.energy builder=12049
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=618 E=139 bank=318 pull=93 plants=1/0 aircraftDemand=3/123
  3.27  [AIR][Projects] energyQueued=0 committed=208/483
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=230 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.31  [Playtest] finished corwin team 0 at 3.31 min
  3.33  [AIR][Rule] recovery.energy builder=3710
  3.33  [AIR][Rule] commander.factory.guard builder=26153
  3.43  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.43  [AIR][Rule] commander.idle.assist builder=26153
  3.43  [AIR][Layout] cluster=0 labs=1 at=1874,2630
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=595 E=146 bank=64 pull=343 plants=1/0 aircraftDemand=3/123
  3.43  [AIR][Projects] energyQueued=0 committed=284/258
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=239 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.44  [AIR][Produce] opening.screen corveng plant=31761 projected=2/6
  3.44  [AIR][Screen] fighters=1 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.55  [Playtest] finished corsolar team 0 at 3.55 min
  3.56  [AIR][Rule] commander.factory.guard builder=26153
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=760 E=179 bank=1168 pull=93 plants=1/0 aircraftDemand=4/131
  3.60  [AIR][Projects] energyQueued=1 committed=274/111
  3.60  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=239 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.62  [AIR][Screen] fighters=1 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.73  [AIR][Produce] opening.screen corveng plant=31761 projected=3/6
  3.73  [Playtest] finished cormex team 0 at 3.73 min
  3.74  [AIR][Rule] energy.grow builder=5980
  3.77  [AIR][Economy] T1_CONTEST M=9 bank=735 E=216 bank=772 pull=94 plants=1/0 aircraftDemand=4/131
  3.77  [AIR][Projects] energyQueued=1 committed=251/175
  3.77  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=239 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [AIR][Screen] fighters=2 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.86  [AIR][Commander] cleared factory guard for commander.energy.assist
  3.86  [AIR][Rule] commander.energy.assist builder=26153
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=704 E=238 bank=345 pull=127 plants=1/0 aircraftDemand=4/131
  3.93  [AIR][Projects] energyQueued=0 committed=159/42
  3.93  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=282 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.95  [AIR][Layout] cluster=1 labs=1 at=3410,1478
  3.95  [Playtest] finished corwin team 0 at 3.95 min
  3.96  [AIR][Rule] recovery.energy builder=5980
  3.97  [AIR][Layout] cluster=2 labs=1 at=3218,1670
  3.97  [AIR][Screen] fighters=2 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.97  [AIR][Rule] commander.idle.assist builder=26153
  3.98  [AIR][Produce] opening.screen corveng plant=31761 projected=4/6
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 950/1350, energy +257.0 bank 1222/1231, units 30
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=958 E=240 bank=1198 pull=141 plants=1/0 aircraftDemand=4/131
  4.10  [AIR][Projects] energyQueued=0 committed=231/0
  4.10  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=287 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.15  [AIR][Screen] fighters=3 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.23  [Playtest] finished corsolar team 0 at 4.23 min
  4.23  [AIR][Claim] cancel unowned native order cormakr
  4.24  [AIR][Wind] cluster=2 slots=6 at=2536,560 local=false builder=3710
  4.24  [AIR][Rule] energy.grow builder=3710
  4.25  [AIR][Rule] commander.energy.assist builder=26153
  4.27  [AIR][Economy] T1_CONTEST M=11 bank=959 E=221 bank=1216 pull=141 plants=1/0 aircraftDemand=4/131
  4.27  [AIR][Projects] energyQueued=1 committed=184/175
  4.27  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=287 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.29  [Playtest] finished corsolar team 0 at 4.29 min
  4.30  [AIR][Claim] cancel unowned native order cormakr
  4.31  [AIR][Rule] energy.grow builder=12049
  4.32  [AIR][Screen] fighters=3 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.37  [AIR][Produce] opening.screen corveng plant=31761 projected=5/6
  4.40  [Playtest] finished corwin team 0 at 4.40 min
  4.43  [AIR][Economy] T1_CONTEST M=11 bank=1175 E=227 bank=1302 pull=146 plants=1/0 aircraftDemand=4/131
  4.43  [AIR][Projects] energyQueued=0 committed=161/324
  4.43  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=731 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.48  [AIR][Screen] fighters=4 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.50  [Playtest] finished corwin team 0 at 4.50 min
  4.60  [Playtest] finished corwin team 0 at 4.60 min
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=1155 E=273 bank=1276 pull=183 plants=1/0 aircraftDemand=4/131
  4.60  [AIR][Projects] energyQueued=0 committed=89/153
  4.60  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=719 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/4 available=yes firstSlot=-1
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.60  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.65  [AIR][Screen] fighters=4 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.69  [Playtest] finished corwin team 0 at 4.69 min
  4.71  [AIR][Rule] mex.phase.convert builder=12049
  4.71  [AIR][Rule] commander.energy.local builder=26153
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=1164 E=319 bank=1332 pull=146 plants=1/0 aircraftDemand=4/131
  4.77  [AIR][Projects] energyQueued=1 committed=106/1586
  4.77  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=724 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/4 available=yes firstSlot=-1
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.77  [AIR][Produce] opening.screen corveng plant=31761 projected=6/6
  4.82  [AIR][Screen] fighters=5 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.82  [AIR][Share] metal 1336 of 1350 (99%): sent 196 to team 1 (83% full); the engine counts 0 metal sent in the last update (D-106)
  4.85  [AIR][Share] after the donation: we sent 172; team 1 received 172 (bank 1188) (D-106)
  4.89  [Playtest] finished corsolar team 0 at 4.89 min
  4.90  [AIR][Claim] cancel unowned native order cormakr
  4.90  [AIR][Share] metal 1334 of 1350 (98%): sent 146 to team 1 (87% full); the engine counts 0 metal sent in the last update (D-106)
  4.91  [AIR][Rule] mex.phase.convert builder=5980
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=1208 E=348 bank=1376 pull=203 plants=1/0 aircraftDemand=3/127
  4.93  [AIR][Projects] energyQueued=0 committed=32/2406
  4.93  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=751 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/4 available=yes firstSlot=-1
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.93  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  4.95  [Playtest] finished corwin team 0 at 4.95 min
  4.96  [AIR][Rule] commander.energy.assist builder=26153
  4.98  [AIR][Layout] cluster=3 labs=1 at=2066,2342
  4.98  [AIR][State] T1_SCALE
  4.98  [AIR][Screen] fighters=5 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.98  [AIR][Share] metal 1336 of 1350 (99%): sent 92 to team 1 (92% full); the engine counts 0 metal sent in the last update (D-106)
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 1334/1350, energy +369.9 bank 1376/1383, units 40
  5.00  [Playtest] target team 0 at (2800, 800) from its start position
  5.00  [Playtest] camera requested (2872,1008) height=2200
  5.01  [Playtest] finished corwin team 0 at 5.01 min
  5.02  [AIR][Share] after the donation: we sent 70; team 1 received 70 (bank 1188) (D-106)
  5.02  [Playtest] camera captured name=ta position=(2872,1008) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2872, 1008)
  5.03  [AIR][NanoGate] corca 3710 can=yes busy=no count=0
  5.03  [AIR][Rule] transition.storage builder=3710
  5.03  [AIR][NanoGate] corcom 26153 can=no busy=no count=0
  5.03  [AIR][Rule] commander.factory.guard builder=26153
  5.10  [AIR][Economy] T1_SCALE M=18 bank=1345 E=356 bank=1378 pull=192 plants=1/0 aircraftDemand=3/127
  5.10  [AIR][Projects] energyQueued=0 committed=341/2391
  5.10  [AIR][Workforce] t1=3/20 t2=0/9 targetBP=1060 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/5 available=yes firstSlot=-1
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/6 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/6 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/6 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/6 available=yes firstSlot=0
  5.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=350
  5.15  [AIR][Screen] fighters=5 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.17  [AIR][State] T1_CONTEST
  5.17  [AIR][Layout] repaired support air.bay.0 viable=1/5 slot=540 at=2968,1016
  5.17  [AIR][Produce] intercept corveng plant=31761 projected=7/7
  5.23  [AIR][Commander] cleared factory guard for commander.local.assist
  5.23  [AIR][Rule] commander.local.assist builder=26153
  5.27  [AIR][Economy] T1_CONTEST M=11 bank=1350 E=310 bank=1286 pull=254 plants=1/0 aircraftDemand=3/127
  5.27  [AIR][Projects] energyQueued=0 committed=278/1583
  5.27  [AIR][Workforce] t1=3/16 t2=0/7 targetBP=836 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/5 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.30  [Playtest] finished cormakr team 0 at 5.30 min
  5.31  [AIR][Rule] storage.buffer builder=12049
  5.32  [AIR][Rule] commander.factory.guard builder=26153
  5.32  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.41  [AIR][Commander] cleared factory guard for commander.local.assist
  5.41  [AIR][Rule] commander.local.assist builder=26153
  5.43  [AIR][Economy] T1_CONTEST M=11 bank=1350 E=301 bank=1314 pull=279 plants=1/0 aircraftDemand=3/127
  5.43  [AIR][Projects] energyQueued=0 committed=372/2600
  5.43  [AIR][Workforce] t1=3/16 t2=0/7 targetBP=836 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/5 available=yes firstSlot=0
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.48  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.48  [AIR][Share] metal 1315 of 1350 (97%): sent 56 to team 1 (95% full); the engine counts 0 metal sent in the last update (D-106)
  5.51  [Playtest] finished cormstor team 0 at 5.51 min
  5.52  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.53  [AIR][Wind] cluster=3 slots=6 at=2328,832 local=false builder=3710
  5.53  [AIR][Rule] energy.grow builder=3710
  5.53  [AIR][Rule] commander.idle.assist builder=26153
  5.54  [AIR][Layout] repaired support air.bay.0 viable=2/5 slot=561 at=2776,1032
  5.60  [AIR][Economy] T1_CONTEST M=12 bank=1514 E=310 bank=1378 pull=201 plants=1/0 aircraftDemand=3/129
  5.60  [AIR][Projects] energyQueued=1 committed=170/1744
  5.60  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=311 floating=false savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=317
  5.63  [AIR][State] T1_SCALE
  5.65  [AIR][Screen] fighters=7 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.67  [AIR][State] T1_CONTEST
  5.73  [AIR][Layout] repaired support air.bay.0 viable=3/5 slot=568 at=2776,984
  5.75  [Playtest] finished corestor team 0 at 5.75 min
  5.76  [AIR][Rule] energy.grow builder=12049
  5.77  [AIR][Economy] T1_CONTEST M=12 bank=1492 E=342 bank=1496 pull=223 plants=1/0 aircraftDemand=3/129
  5.77  [AIR][Projects] energyQueued=1 committed=74/303
  5.77  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=311 floating=false savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.77  [Playtest] finished cormakr team 0 at 5.77 min
  5.78  [AIR][Rule] opening.support builder=5980
  5.82  [AIR][Screen] fighters=7 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.92  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=575 at=2936,936
  5.93  [AIR][Economy] T1_CONTEST M=11 bank=1587 E=366 bank=5002 pull=59 plants=1/0 aircraftDemand=3/129
  5.93  [AIR][Projects] energyQueued=0 committed=274/3270
  5.93  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=287 floating=false savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=31761 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.98  [AIR][Screen] fighters=7 cells=8 centre=471,839 width=600 advance=400 responding=false
  6.00  [Playtest] eco team 0 at 6.0 min: metal +14.0 bank 1863/4350, energy +333.0 bank 5990/7384, units 46
  6.10  [AIR][Economy] T1_CONTEST M=13 bank=1910 E=329 bank=6649 pull=199 plants=1/0 aircraftDemand=3/129
  6.10  [AIR][Projects] energyQueued=0 committed=222/2823
  6.10  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=321 floating=false savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
... 1748 more
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
  0.09  EXP: approach: legcom(13591) at (5988, 11436) walks to (5877, 11461), 137 from the legmex site (5936, 11584)
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
  0.23  EXP: approach: corcom(26153) at (2823, 866) walks to (2738, 833), 139 from the cormex site (2608, 784)
  0.25  RESERVE: armlab at (256, 352) facing 2 (id 17)
  0.25  RESERVE: zone 11 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.25  RESERVE: armlab at (256, 144) facing 2 (id 18)
  0.25  RESERVE: zone 11 at (256, 216) facing 2, 6x3 cells: 3 of 18 held
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
  0.35  EXP: approach: corcom(28807) at (4551, 11380) walks to (4747, 11634), 139 from the cormex site (4832, 11744)
  0.41  EXP: approach: corcom(26153) at (2753, 842) walks to (3036, 933), 139 from the cormex site (3168, 976)
  0.42  RESERVE: armalab at (536, 168) facing 2 (id 19)
  0.42  RESERVE: zone 12 at (536, 288) facing 2, 7x6 cells: 7 of 42 held
  0.43  RESERVE: armlab at (368, 688) facing 1 (id 20)
  0.43  RESERVE: served armlab at (368, 688) facing 1 (id 20, 1 of this def still held)
  0.62  RESERVE: zone 1 at (4808, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4808, 11640) facing 2 (id 1)
  0.62  RESERVE: zone 2 at (4760, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4760, 11640) facing 2 (id 2)
  0.62  RESERVE: zone 3 at (4712, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4712, 11640) facing 2 (id 3)
  0.62  RESERVE: zone 4 at (4808, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4808, 11592) facing 2 (id 4)
  0.62  RESERVE: zone 5 at (4760, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4760, 11592) facing 2 (id 5)
  0.62  RESERVE: zone 6 at (4712, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4712, 11592) facing 2 (id 6)
  0.62  RESERVE: served corwin at (4808, 11640) facing 2 (id 1, 5 of this def still held)
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
  0.73  RESERVE: corridor 13 at (576, 688) facing 1, 20x10 cells: 150 of 200 held
  0.74  RESERVE: served corwin at (4760, 11640) facing 2 (id 2, 4 of this def still held)
  0.74  EXP: swap: armcom(30290) from task type 5 to task type 5
  0.74  EXP: approach: armcom(30290) at (297, 623) walks to (309, 548), 136 from the armwin site (440, 512)
  0.74  RESERVE: armwin at (392, 552) facing 0 (id 21)
  0.74  RESERVE: packed armwin near (395, 552) at (392, 552), 3 away (id 21, 1485 candidates)
  0.78  EXP: approach: legcom(13591) at (6276, 11716) walks to (5874, 11553), 163 from the leglab site (5988, 11436)
  0.78  RESERVE: served leglab at (6160, 11392) facing 2 (id 1, 2 of this def still held)
  0.83  RESERVE: served corwin at (3048, 904) facing 0 (id 2, 4 of this def still held)
```
