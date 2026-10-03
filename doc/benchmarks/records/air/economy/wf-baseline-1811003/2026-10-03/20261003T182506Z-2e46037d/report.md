# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54000); wall 213 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:21:29
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\tundra\runs\20261003T182506Z-2e46037d\infolog.txt

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
- forbid 'invariant' hit at 5.2 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 1192 (4 by power), bank 0 + 11/s (0 by metal))
- forbid 'invariant' hit at 6.2 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 1192 (4 by power), bank 0 + 12/s (0 by metal))
- forbid 'invariant' hit at 7.2 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 1192 (4 by power), bank 0 + 10/s (0 by metal))
- forbid 'invariant' hit at 13.9 min: [INVARIANT] INV-008 5 turret(s) in range of the reclaim of legalab 13772 are not on it
- forbid 'invariant' hit at 14.0 min: [INVARIANT] INV-001 a retiring factory produced legack 18622
- forbid 'invariant' hit at 17.1 min: [INVARIANT] INV-029 leghp 25045 stands 4 cells from the turrets, not tight
- forbid 'invariant' hit at 19.7 min: [INVARIANT] INV-029 legap 6938 stands 12 cells from the turrets, not tight
- forbid 'invariant' hit at 21.5 min: [INVARIANT] INV-029 legaap 5478 stands 8 cells from the turrets, not tight
- forbid 'invariant' hit at 21.5 min: [INVARIANT] INV-022 a new set of legafus starts 12 cell(s) from the turrets, not flush

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\tundra\runs\20261003T182506Z-2e46037d\screen_2026-10-03_18-22-30-866.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\tundra\runs\20261003T182506Z-2e46037d\screen_2026-10-03_18-23-07-973.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\tundra\runs\20261003T182506Z-2e46037d\screen_2026-10-03_18-23-42-164.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\tundra\runs\20261003T182506Z-2e46037d\screen_2026-10-03_18-25-06-003.png

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
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2866, 888), 81 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|2810|829|1|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(328,467) factory=armlab landLocked=yes spot=0 known=1/1
  0.20  [Team][Roster] team 1 first mex at 480,432
  0.21  [Playtest] finished legmex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 20017 at 2848,928
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|2810|829|1|2|1|2848|928
  0.22  [AIR][Rule] opening.mex builder=23483
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=972 E=18 bank=818 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=311 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.38  [Playtest] finished legmex team 0 at 0.38 min
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=966 E=30 bank=581 pull=6 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=386 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Economy] BOOTSTRAP M=5 bank=1007 E=30 bank=561 pull=85 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=22/228
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=475 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.65  [Playtest] finished legmex team 0 at 0.65 min
  0.66  [AIR][Wind] cluster=0 slots=6 at=3048,928 local=true builder=23483
  0.66  [AIR][Rule] opening.energy builder=23483
  0.77  [AIR][Economy] BOOTSTRAP M=5 bank=1033 E=30 bank=457 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=20/84
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=491 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.81  [Playtest] finished legwin team 0 at 0.81 min
  0.93  [Playtest] finished legwin team 0 at 0.93 min
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=1047 E=30 bank=515 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=571 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1064/1150, energy +62.0 bank 662/1001, units 7
  1.05  [Playtest] finished legwin team 0 at 1.05 min
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=1079 E=54 bank=864 pull=9 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=36/146
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=590 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.18  [Playtest] finished legwin team 0 at 1.18 min
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=1116 E=72 bank=998 pull=9 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=39/161
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=612 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.35  [Playtest] finished legwin team 0 at 1.35 min
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=1134 E=75 bank=984 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=16/67
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=623 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.47  [Playtest] finished legwin team 0 at 1.47 min
  1.48  [AIR][Wind] cluster=1 slots=6 at=2712,848 local=false builder=23483
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=70 bank=988 pull=9 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=1 committed=43/175
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=625 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.75  [Playtest] finished legwin team 0 at 1.75 min
  1.77  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=76 bank=1003 pull=40 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=625 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.89  [Playtest] finished legwin team 0 at 1.89 min
  1.90  [AIR][Starter] nearby distance=128
  1.90  [AIR][Rule] opening.plant builder=23483
  1.90  [AIR][EcoLayout] reserved air.eco.0 reactor=1920,832 converters=8 zone=29
  1.92  [AIR][EcoLayout] reserved air.eco.1 reactor=1792,1344 converters=8 zone=47
  1.93  [AIR][EcoLayout] reserved air.eco.2 reactor=2304,1856 converters=8 zone=82
  1.93  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=97 bank=996 pull=9 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=421/1077
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=625 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=21652 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 1088/1150, energy +69.3 bank 994/1004, units 13
  2.10  [AIR][Economy] BOOTSTRAP M=7 bank=1026 E=68 bank=953 pull=60 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=219/560
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=558 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=21652 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Economy] BOOTSTRAP M=7 bank=905 E=73 bank=1004 pull=60 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=16/43
  2.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=486 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=21652 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.28  [Playtest] finished legap team 0 at 2.28 min
  2.28  [AIR][Claim] cancel unowned native order legnanotc
  2.28  [AIR][State] T1_CONTEST
  2.29  [AIR][Produce] opening.scout legfig plant=21652 projected=1/1
  2.29  [AIR][Rule] opening.commander.guard builder=23483
  2.39  [AIR][Produce] constructor.recovery legca plant=21652 projected=1/3
  2.39  [AIR][Scout] opening drone=5963 enemy starts=2
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=908 E=120 bank=979 pull=35 plants=1/0 aircraftDemand=2/115
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=901 E=142 bank=1088 pull=206 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.62  [AIR][Produce] constructor.recovery legca plant=21652 projected=2/3
  2.62  [AIR][Rule] mex.expand builder=20512
  2.77  [AIR][Economy] T1_CONTEST M=7 bank=911 E=157 bank=839 pull=218 plants=1/0 aircraftDemand=2/115
  2.77  [AIR][Projects] energyQueued=0 committed=45/457
  2.77  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.85  [AIR][Produce] constructor.recovery legca plant=21652 projected=3/3
  2.85  [AIR][Rule] mex.assist builder=14148
  2.93  [AIR][Economy] T1_CONTEST M=7 bank=911 E=162 bank=836 pull=218 plants=1/0 aircraftDemand=2/115
  2.93  [AIR][Projects] energyQueued=0 committed=33/336
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 896/1250, energy +167.6 bank 574/1154, units 18
  3.08  [AIR][Produce] opening.screen legfig plant=21652 projected=2/7
  3.08  [AIR][Commander] cleared factory guard for commander.energy.local
  3.08  [AIR][Rule] commander.energy.local builder=23483
  3.08  [AIR][Rule] energy.grow builder=26388
  3.10  [AIR][Economy] T1_CONTEST M=7 bank=890 E=166 bank=511 pull=32 plants=1/0 aircraftDemand=2/115
  3.10  [AIR][Projects] energyQueued=1 committed=52/272
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.17  [Playtest] finished legmex team 0 at 3.17 min
  3.18  [AIR][Rule] energy.grow builder=14148
  3.19  [Playtest] finished legwin team 0 at 3.19 min
  3.21  [AIR][Rule] commander.energy.assist builder=23483
  3.27  [AIR][Economy] T1_CONTEST M=7 bank=1114 E=170 bank=644 pull=180 plants=1/0 aircraftDemand=2/115
  3.27  [AIR][Projects] energyQueued=0 committed=102/699
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=566 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.29  [Playtest] finished legwin team 0 at 3.29 min
  3.30  [AIR][Rule] mex.assist builder=26388
  3.31  [AIR][Rule] commander.energy.local builder=23483
  3.33  [AIR][Produce] opening.screen legfig plant=21652 projected=3/7
  3.33  [AIR][Screen] fighters=1 cells=8 centre=473,839 width=600 advance=400 responding=false
  3.40  [AIR][Layout] cluster=0 labs=1 at=1874,2629
  3.42  [Playtest] finished legwin team 0 at 3.42 min
  3.43  [AIR][Rule] commander.factory.guard builder=23483
  3.43  [AIR][Economy] T1_CONTEST M=9 bank=1100 E=184 bank=1050 pull=191 plants=1/0 aircraftDemand=2/115
  3.43  [AIR][Projects] energyQueued=0 committed=63/453
  3.43  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=629 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.50  [AIR][Produce] opening.screen legfig plant=21652 projected=4/7
  3.50  [AIR][Screen] fighters=2 cells=8 centre=473,839 width=600 advance=400 responding=false
  3.60  [AIR][Economy] T1_CONTEST M=9 bank=1101 E=213 bank=270 pull=400 plants=1/0 aircraftDemand=3/96
  3.60  [AIR][Projects] energyQueued=0 committed=27/166
  3.60  [AIR][Workforce] t1=3/15 t2=0/6 targetBP=630 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=69
  3.60  [AIR][Produce] opening.screen legfig plant=21652 projected=4/6
  3.66  [Playtest] finished legmex team 0 at 3.66 min
  3.68  [AIR][Wind] cluster=2 slots=6 at=2536,560 local=false builder=26388
  3.68  [AIR][Rule] energy.grow builder=26388
  3.68  [AIR][Rule] energy.grow builder=20512
  3.68  [AIR][Screen] fighters=3 cells=8 centre=473,839 width=600 advance=400 responding=false
  3.72  [AIR][Share] metal 1336 of 1350 (99%): sent 256 to team 1 (78% full); the engine counts 0 metal sent in the last update (D-106)
  3.74  [AIR][Produce] opening.screen legfig plant=21652 projected=5/6
  3.75  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=1126 E=184 bank=186 pull=19 plants=1/0 aircraftDemand=3/91
  3.77  [AIR][Projects] energyQueued=2 committed=93/379
  3.77  [AIR][Workforce] t1=3/15 t2=0/6 targetBP=630 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [AIR][Share] metal 1336 of 1350 (99%): sent 182 to team 1 (84% full); the engine counts 0 metal sent in the last update (D-106)
  3.83  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  3.85  [AIR][Screen] fighters=4 cells=8 centre=473,839 width=600 advance=400 responding=false
  3.87  [Playtest] finished legwin team 0 at 3.87 min
  3.88  [AIR][State] T1_SCALE
  3.88  [AIR][Share] metal 1336 of 1350 (99%): sent 121 to team 1 (89% full); the engine counts 0 metal sent in the last update (D-106)
  3.88  [AIR][Rule] recovery.energy builder=14148
  3.90  [Ferry] AIR: queued request from team 1
  3.90  [Ferry] AIR: serving team 1 queued=0
  3.90  [Ferry] AIR: ordered one leglts for team 1
  3.92  [AIR][Layout] cluster=1 labs=1 at=3410,1477
  3.92  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  3.93  [AIR][Layout] cluster=2 labs=1 at=3218,1669
  3.93  [AIR][Economy] T1_SCALE RECOVERY M=17 bank=1260 E=180 bank=367 pull=26 plants=1/0 aircraftDemand=3/87
  3.93  [AIR][Projects] energyQueued=0 committed=222/294
  3.93  [AIR][Workforce] t1=3/22 t2=0/9 targetBP=968 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [AIR][Share] metal 1336 of 1350 (99%): sent 56 to team 1 (95% full); the engine counts 0 metal sent in the last update (D-106)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 1298/1350, energy +234.6 bank 692/1181, units 31
  4.00  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  4.02  [AIR][Screen] fighters=5 cells=8 centre=473,839 width=600 advance=400 responding=false
  4.02  [AIR][Commander] cleared factory guard for commander.energy.assist
  4.02  [AIR][Rule] commander.energy.assist builder=23483
  4.05  [AIR][Share] metal 1331 of 1350 (98%): sent 26 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  4.08  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  4.10  [AIR][Economy] T1_SCALE RECOVERY M=18 bank=1311 E=213 bank=1121 pull=75 plants=1/0 aircraftDemand=3/87
  4.10  [AIR][Projects] energyQueued=0 committed=108/200
  4.10  [AIR][Workforce] t1=3/23 t2=0/9 targetBP=1034 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=63
  4.13  [AIR][Share] metal 1331 of 1350 (98%): sent 39 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  4.15  [Playtest] finished legsolar team 0 at 4.15 min
  4.16  [Ferry] AIR: transport 1917 built for team 1; hold pending task
  4.17  [AIR][Rule] energy.grow builder=14148
  4.17  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  4.17  [AIR][Rule] commander.idle.assist builder=23483
  4.17  [AIR][Produce] opening.screen legfig plant=21652 projected=6/6
  4.18  [AIR][Screen] fighters=5 cells=8 centre=473,839 width=600 advance=400 responding=false
  4.18  [Ferry] AIR: transport 1917 flying to (328,467)
  4.27  [AIR][Economy] T1_SCALE M=15 bank=1350 E=192 bank=1182 pull=148 plants=1/0 aircraftDemand=3/87
  4.27  [AIR][Projects] energyQueued=0 committed=67/273
  4.27  [AIR][Workforce] t1=3/22 t2=0/9 targetBP=965 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.28  [AIR][State] T1_CONTEST
  4.33  [Playtest] finished legwin team 0 at 4.34 min
  4.35  [AIR][Screen] fighters=5 cells=8 centre=473,839 width=600 advance=400 responding=false
  4.35  [AIR][Rule] commander.energy.assist builder=23483
  4.40  [Ferry] AIR: transport 1917 arrived and transferred to team 1
  4.42  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=479 at=3032,1000
  4.42  [AIR][Produce] intercept legfig plant=21652 projected=7/7
  4.43  [Playtest] finished legwin team 0 at 4.43 min
  4.43  [AIR][Economy] T1_CONTEST M=11 bank=1345 E=189 bank=1229 pull=108 plants=1/0 aircraftDemand=3/87
  4.43  [AIR][Projects] energyQueued=0 committed=39/161
  4.43  [AIR][Workforce] t1=3/19 t2=0/8 targetBP=833 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [AIR][Rule] commander.energy.local builder=23483
  4.45  [Playtest] finished legwin team 0 at 4.45 min
  4.47  [AIR][Wind] cluster=3 slots=6 at=2328,832 local=false builder=26388
  4.53  [AIR][Screen] fighters=6 cells=8 centre=473,839 width=600 advance=400 responding=false
  4.56  [Playtest] finished legwin team 0 at 4.56 min
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=1349 E=243 bank=1220 pull=149 plants=1/0 aircraftDemand=3/87
  4.60  [AIR][Projects] energyQueued=1 committed=247/397
  4.60  [AIR][Workforce] t1=3/19 t2=0/8 targetBP=836 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=57
  4.68  [AIR][Scout] opening drone=19948 enemy starts=2
  4.68  [AIR][Scout] replacement drone=19948
  4.70  [AIR][Screen] fighters=6 cells=8 centre=473,839 width=600 advance=400 responding=false
  4.76  [Playtest] finished legsolar team 0 at 4.76 min
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=1336 E=315 bank=1233 pull=29 plants=1/0 aircraftDemand=3/87
  4.77  [AIR][Projects] energyQueued=0 committed=63/256
  4.77  [AIR][Workforce] t1=3/19 t2=0/8 targetBP=828 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/5 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  4.83  [AIR][State] T1_SCALE
  4.85  [AIR][State] T1_CONTEST
  4.87  [AIR][Screen] fighters=6 cells=8 centre=473,839 width=600 advance=400 responding=false
  4.93  [AIR][Economy] T1_CONTEST M=12 bank=1336 E=307 bank=1270 pull=29 plants=1/0 aircraftDemand=3/87
  4.93  [AIR][Projects] energyQueued=0 committed=42/115
  4.93  [AIR][Workforce] t1=3/20 t2=0/8 targetBP=857 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/5 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  4.95  [Playtest] finished legsolar team 0 at 4.95 min
  4.95  [AIR][Layout] cluster=3 labs=1 at=2066,2341
  4.99  [Playtest] finished legwin team 0 at 4.99 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 1339/1350, energy +303.3 bank 1332/1333, units 40
  5.00  [Playtest] target team 0 at (2800, 800) from its start position
  5.00  [Playtest] camera requested (2928,944) height=2200
  5.00  [AIR][Rule] transition.storage builder=20512
  5.01  [Playtest] camera captured name=ta position=(2928,944) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2928, 944)
  5.03  [AIR][Screen] fighters=6 cells=8 centre=473,839 width=600 advance=400 responding=false
  5.09  [Playtest] finished legwin team 0 at 5.09 min
  5.10  [AIR][Rule] mex.phase.convert builder=14148
  5.10  [AIR][Economy] T1_CONTEST M=13 bank=1336 E=302 bank=1333 pull=31 plants=1/0 aircraftDemand=3/87
  5.10  [AIR][Projects] energyQueued=0 committed=368/1734
  5.10  [AIR][Workforce] t1=3/20 t2=0/8 targetBP=867 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/5 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=51
  5.13  [Playtest] finished legsolar team 0 at 5.14 min
  5.14  [Playtest] finished legwin team 0 at 5.14 min
  5.15  [AIR][Rule] storage.buffer builder=26388
  5.15  [AIR][Rule] commander.idle.assist builder=23483
  5.20  [AIR][Screen] fighters=6 cells=8 centre=473,839 width=600 advance=400 responding=false
  5.22  [AIR][Share] metal 1329 of 1350 (98%): sent 38 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  5.25  [AIR][State] T1_SCALE
  5.25  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.27  [AIR][Economy] T1_SCALE M=17 bank=1264 E=290 bank=1381 pull=103 plants=1/0 aircraftDemand=3/87
  5.27  [AIR][Projects] energyQueued=0 committed=237/2960
  5.27  [AIR][Workforce] t1=3/23 t2=0/9 targetBP=995 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/5 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.30  [Playtest] finished legmstor team 0 at 5.30 min
  5.31  [AIR][Rule] energy.grow builder=20512
  5.37  [AIR][Screen] fighters=6 cells=8 centre=473,839 width=600 advance=400 responding=false
  5.42  [AIR][State] T1_CONTEST
  5.43  [AIR][Economy] T1_CONTEST M=11 bank=1405 E=273 bank=1383 pull=38 plants=1/0 aircraftDemand=3/91
  5.43  [AIR][Projects] energyQueued=0 committed=183/2797
  5.43  [AIR][Workforce] t1=3/7 t2=0/3 targetBP=287 floating=false savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.55  [AIR][Screen] fighters=6 cells=8 centre=473,839 width=600 advance=400 responding=false
  5.60  [AIR][Economy] T1_CONTEST M=11 bank=1666 E=273 bank=1379 pull=165 plants=1/0 aircraftDemand=3/91
  5.60  [AIR][Projects] energyQueued=0 committed=73/1736
  5.60  [AIR][Workforce] t1=3/7 t2=0/3 targetBP=287 floating=false savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=138
  5.65  [Playtest] finished legestor team 0 at 5.65 min
  5.67  [AIR][Rule] energy.grow builder=26388
  5.67  [AIR][Rule] energy.grow builder=14148
  5.68  [AIR][Rule] commander.energy.assist builder=23483
  5.72  [AIR][Screen] fighters=6 cells=8 centre=473,839 width=600 advance=400 responding=false
  5.73  [Playtest] finished legwin team 0 at 5.73 min
  5.74  [AIR][Rule] opening.support builder=20512
  5.77  [AIR][Economy] T1_CONTEST M=11 bank=1696 E=271 bank=2812 pull=19 plants=1/0 aircraftDemand=3/91
  5.77  [AIR][Projects] energyQueued=1 committed=310/3527
  5.77  [AIR][Workforce] t1=3/7 t2=0/3 targetBP=287 floating=false savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+0/2 available=yes firstSlot=2
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.84  [Playtest] finished legwin team 0 at 5.84 min
  5.85  [AIR][Rule] opening.support.assist builder=26388
  5.85  [AIR][Rule] commander.idle.assist builder=23483
  5.88  [AIR][Screen] fighters=6 cells=8 centre=473,839 width=600 advance=400 responding=false
  5.93  [AIR][Economy] T1_CONTEST M=11 bank=1766 E=297 bank=5738 pull=42 plants=1/0 aircraftDemand=3/91
  5.93  [AIR][Projects] energyQueued=1 committed=261/3218
  5.93  [AIR][Workforce] t1=3/7 t2=0/3 targetBP=287 floating=false savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=21652 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
... 2824 more
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
  0.08  EXP: approach: armcom(1236) at (329, 467) walks to (347, 463), 136 from the armmex site (480, 432)
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
  0.09  EXP: approach: legcom(28186) at (5988, 11437) walks to (5877, 11461), 137 from the legmex site (5936, 11584)
  0.11  EXP: idle: armcom(1236) on armmex at (338, 465), site (480, 432), target yes, fails 2 (arrived at the approach point)
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
  0.17  EXP: approach: corcom(14393) at (4599, 11401) walks to (4532, 11356), 139 from the cormex site (4416, 11280)
  0.21  EXP: approach: armcom(1236) at (338, 465) walks to (280, 654), 136 from the armmex site (240, 784)
  0.22  EXP: approach: legcom(23483) at (2821, 857) walks to (2738, 829), 137 from the legmex site (2608, 784)
  0.25  RESERVE: armlab at (576, 160) facing 2 (id 17)
  0.25  RESERVE: zone 11 at (576, 232) facing 2, 6x3 cells: 16 of 18 held
  0.25  RESERVE: grid of armnanotc 2x1 gap 0 behind (576, 208) facing 2: 1 of 2 slots (group 9, zone)
  0.25  RESERVE: zone 11 released
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
  0.34  EXP: approach: corcom(14393) at (4552, 11368) walks to (4749, 11633), 139 from the cormex site (4832, 11744)
  0.40  EXP: approach: legcom(23483) at (2754, 835) walks to (3038, 932), 137 from the legmex site (3168, 976)
  0.42  RESERVE: armlab at (256, 352) facing 2 (id 19)
  0.42  RESERVE: zone 12 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.42  RESERVE: armlab at (256, 336) facing 2 (id 20)
  0.42  RESERVE: zone 12 at (256, 408) facing 2, 6x3 cells: 6 of 18 held
  0.42  RESERVE: armlab at (288, 144) facing 2 (id 21)
  0.42  RESERVE: zone 13 at (288, 216) facing 2, 6x3 cells: 3 of 18 held
  0.42  RESERVE: armlab at (368, 688) facing 1 (id 22)
  0.42  RESERVE: served armlab at (368, 688) facing 1 (id 22, 1 of this def still held)
  0.45  EXP: idle: legcom(28186) on legmex at (6104, 11507), site (6304, 11568), target no, fails 1
  0.58  RESERVE: armlab at (272, 144) facing 2 (id 23)
  0.58  RESERVE: zone 14 at (272, 216) facing 2, 6x3 cells: 0 of 18 held
  0.58  RESERVE: armlab at (256, 128) facing 2 (id 24)
  0.58  RESERVE: zone 14 at (256, 200) facing 2, 6x3 cells: 8 of 18 held
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
  0.66  RESERVE: zone 1 at (3000, 904) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: legwin at (3000, 904) facing 0 (id 1)
  0.66  RESERVE: zone 2 at (3048, 904) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: legwin at (3048, 904) facing 0 (id 2)
  0.66  RESERVE: zone 3 at (3096, 904) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: legwin at (3096, 904) facing 0 (id 3)
  0.66  RESERVE: zone 4 at (3000, 952) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: legwin at (3000, 952) facing 0 (id 4)
  0.66  RESERVE: zone 5 at (3048, 952) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: legwin at (3048, 952) facing 0 (id 5)
  0.66  RESERVE: zone 6 at (3096, 952) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: legwin at (3096, 952) facing 0 (id 6)
  0.66  RESERVE: served legwin at (3000, 904) facing 0 (id 1, 5 of this def still held)
```
