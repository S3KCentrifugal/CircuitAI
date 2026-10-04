# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54030); wall 194 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:25:06
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\caldera\runs\20261003T182824Z-7ad2e16a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=959 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\caldera\runs\20261003T182824Z-7ad2e16a\screen_2026-10-03_18-26-10-722.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\caldera\runs\20261003T182824Z-7ad2e16a\screen_2026-10-03_18-26-49-672.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\caldera\runs\20261003T182824Z-7ad2e16a\screen_2026-10-03_18-27-16-282.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811003\cohort\20261003T172752Z-b35fb2f6\caldera\runs\20261003T182824Z-7ad2e16a\screen_2026-10-03_18-28-23-807.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (8800, 1100) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (6600, 14250) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 123
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (8800, 1100) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (6600, 14250) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 123
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order legap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=959 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=314 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (8802, 1114), 14 from the start
  0.21  [Playtest] finished legmex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 21190 at 8896,1264
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|8814|1123|0|4|1|8896|1264
  0.23  [AIR][Rule] opening.mex builder=28186
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=976 E=21 bank=806 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=321 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.40  [Playtest] finished legmex team 0 at 0.40 min
  0.43  [AIR][Economy] BOOTSTRAP M=4 bank=972 E=30 bank=571 pull=27 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=404 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1017 E=30 bank=526 pull=85 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=18/183
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=527 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.64  [Playtest] finished legmex team 0 at 0.64 min
  0.65  [AIR][Wind] cluster=0 slots=6 at=8712,1104 local=true builder=28186
  0.65  [AIR][Rule] opening.energy builder=28186
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1057 E=30 bank=434 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=16/66
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=536 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.80  [Playtest] finished legwin team 0 at 0.80 min
  0.92  [Playtest] finished legwin team 0 at 0.92 min
  0.93  [AIR][Economy] BOOTSTRAP M=9 bank=1084 E=30 bank=440 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=639 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +9.3 bank 1102/1150, energy +40.0 bank 470/1001, units 7
  1.04  [Playtest] finished legwin team 0 at 1.04 min
  1.10  [AIR][Economy] BOOTSTRAP M=9 bank=1121 E=40 bank=534 pull=40 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=24/97
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=662 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.15  [Playtest] finished legwin team 0 at 1.15 min
  1.27  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=45 bank=760 pull=40 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=12/51
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=679 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.29  [Playtest] finished legwin team 0 at 1.29 min
  1.41  [Playtest] finished legwin team 0 at 1.41 min
  1.42  [AIR][Wind] cluster=1 slots=6 at=9016,1328 local=false builder=28186
  1.43  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=59 bank=1003 pull=27 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=1 committed=43/175
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=679 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.58  [Playtest] finished legwin team 0 at 1.58 min
  1.60  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=61 bank=1003 pull=27 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=1 committed=43/175
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=679 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.72  [Playtest] finished legwin team 0 at 1.72 min
  1.77  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=64 bank=1004 pull=9 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=1 committed=43/175
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=679 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.88  [Playtest] finished legwin team 0 at 1.88 min
  1.93  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=82 bank=1004 pull=9 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=1 committed=43/175
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=679 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 1150/1150, energy +201.6 bank 1004/1004, units 13
  2.10  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=143 bank=997 pull=40 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=16/66
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=679 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.14  [Playtest] finished legwin team 0 at 2.14 min
  2.15  [AIR][Starter] nearby distance=128
  2.15  [AIR][Rule] opening.plant builder=28186
  2.27  [AIR][Economy] BOOTSTRAP M=9 bank=1099 E=138 bank=1005 pull=60 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=313/801
  2.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=648 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=3968 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Economy] BOOTSTRAP M=9 bank=989 E=166 bank=1005 pull=60 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=111/284
  2.43  [AIR][Workforce] t1=0/13 t2=0/6 targetBP=583 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=3968 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.52  [Playtest] finished legap team 0 at 2.52 min
  2.53  [AIR][State] T1_CONTEST
  2.54  [AIR][Produce] opening.scout legfig plant=3968 projected=1/1
  2.54  [AIR][Rule] opening.commander.guard builder=28186
  2.60  [AIR][Economy] T1_CONTEST M=9 bank=936 E=173 bank=840 pull=369 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/5 t2=0/2 targetBP=222 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.64  [AIR][Produce] constructor.recovery legca plant=3968 projected=1/3
  2.64  [AIR][Scout] opening drone=9829 enemy starts=1
  2.77  [AIR][Economy] T1_CONTEST M=9 bank=957 E=177 bank=500 pull=198 plants=1/0 aircraftDemand=2/115
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=1/12 t2=0/5 targetBP=533 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.86  [AIR][Produce] constructor.recovery legca plant=3968 projected=2/3
  2.86  [AIR][Rule] mex.expand builder=16924
  2.93  [AIR][Economy] T1_CONTEST M=9 bank=981 E=177 bank=758 pull=206 plants=1/0 aircraftDemand=2/115
  2.93  [AIR][Projects] energyQueued=0 committed=50/500
  2.93  [AIR][Workforce] t1=2/13 t2=0/5 targetBP=548 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +9.3 bank 982/1250, energy +208.3 bank 749/1130, units 19
  3.08  [AIR][Produce] constructor.recovery legca plant=3968 projected=3/3
  3.08  [AIR][Rule] mex.assist builder=7882
  3.10  [AIR][Economy] T1_CONTEST M=9 bank=984 E=196 bank=804 pull=86 plants=1/0 aircraftDemand=2/115
  3.10  [AIR][Projects] energyQueued=0 committed=43/430
  3.10  [AIR][Workforce] t1=3/13 t2=0/5 targetBP=549 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/1 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Economy] T1_CONTEST M=9 bank=988 E=111 bank=285 pull=182 plants=1/0 aircraftDemand=2/115
  3.27  [AIR][Projects] energyQueued=0 committed=27/274
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=552 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.32  [AIR][Commander] cleared factory guard for commander.energy.local
  3.32  [AIR][Rule] commander.energy.local builder=28186
  3.33  [AIR][Produce] opening.screen legfig plant=3968 projected=2/7
  3.33  [AIR][Rule] recovery.energy builder=31910
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=968 E=93 bank=1 pull=128 plants=1/0 aircraftDemand=2/115
  3.43  [AIR][Projects] energyQueued=0 committed=59/324
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=417 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.45  [Playtest] finished legwin team 0 at 3.45 min
  3.46  [AIR][Rule] commander.factory.guard builder=28186
  3.48  [AIR][Layout] cluster=0 labs=1 at=6630,1291
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=952 E=95 bank=7 pull=257 plants=1/0 aircraftDemand=2/115
  3.60  [AIR][Projects] energyQueued=0 committed=32/151
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=277 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.66  [Playtest] finished legmex team 0 at 3.66 min
  3.67  [AIR][Wind] cluster=2 slots=6 at=10760,1648 local=false builder=7882
  3.67  [AIR][Rule] recovery.energy builder=7882
  3.68  [AIR][Rule] recovery.energy builder=16924
  3.69  [AIR][Produce] opening.screen legfig plant=3968 projected=2/6
  3.69  [AIR][Screen] fighters=1 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=980 E=100 bank=4 pull=328 plants=1/0 aircraftDemand=3/84
  3.77  [AIR][Projects] energyQueued=2 committed=106/431
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=287 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.83  [AIR][Layout] cluster=1 labs=1 at=10278,3019
  3.87  [AIR][Screen] fighters=1 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=993 E=101 bank=32 pull=271 plants=1/0 aircraftDemand=3/84
  3.93  [AIR][Projects] energyQueued=0 committed=94/382
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=374 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.94  [AIR][Produce] opening.screen legfig plant=3968 projected=3/6
  3.95  [AIR][Wind] cluster=3 slots=6 at=9016,880 local=false builder=28186
  3.95  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.95  [AIR][Rule] commander.idle.energy builder=28186
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.7 bank 1021/1300, energy +172.1 bank 485/1180, units 26
  4.05  [AIR][Screen] fighters=2 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.08  [Playtest] finished legwin team 0 at 4.07 min
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=1057 E=142 bank=969 pull=119 plants=1/0 aircraftDemand=3/84
  4.10  [AIR][Projects] energyQueued=2 committed=147/599
  4.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=412 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.22  [AIR][Screen] fighters=2 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.26  [AIR][Produce] opening.screen legfig plant=3968 projected=4/6
  4.27  [AIR][Economy] T1_CONTEST M=11 bank=1107 E=191 bank=1181 pull=128 plants=1/0 aircraftDemand=3/84
  4.27  [AIR][Projects] energyQueued=1 committed=101/412
  4.27  [AIR][Workforce] t1=3/16 t2=0/7 targetBP=696 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.31  [Playtest] finished legwin team 0 at 4.31 min
  4.33  [AIR][Rule] commander.energy.local builder=28186
  4.35  [AIR][Layout] cluster=2 labs=1 at=6726,907
  4.40  [AIR][Screen] fighters=3 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.43  [AIR][Economy] T1_CONTEST M=11 bank=1106 E=244 bank=1181 pull=177 plants=1/0 aircraftDemand=3/84
  4.43  [AIR][Projects] energyQueued=0 committed=52/212
  4.43  [AIR][Workforce] t1=3/16 t2=0/7 targetBP=696 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.44  [Playtest] finished legwin team 0 at 4.44 min
  4.50  [AIR][Produce] opening.screen legfig plant=3968 projected=5/6
  4.54  [Playtest] finished legwin team 0 at 4.54 min
  4.55  [AIR][Rule] mex.phase.convert builder=7882
  4.55  [Playtest] finished legwin team 0 at 4.55 min
  4.55  [Playtest] finished legwin team 0 at 4.55 min
  4.56  [AIR][Rule] mex.expand builder=16924
  4.58  [AIR][Screen] fighters=4 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=1118 E=265 bank=1179 pull=136 plants=1/0 aircraftDemand=3/84
  4.60  [AIR][Projects] energyQueued=0 committed=210/1750
  4.60  [AIR][Workforce] t1=3/16 t2=0/7 targetBP=702 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/4 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.60  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.74  [Playtest] finished legsolar team 0 at 4.74 min
  4.75  [AIR][Screen] fighters=4 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.75  [AIR][Produce] opening.screen legfig plant=3968 projected=6/6
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=1045 E=293 bank=1229 pull=72 plants=1/0 aircraftDemand=3/84
  4.77  [AIR][Projects] energyQueued=1 committed=214/1703
  4.77  [AIR][Workforce] t1=3/15 t2=0/6 targetBP=659 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/4 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=1041 E=234 bank=1233 pull=168 plants=1/0 aircraftDemand=3/84
  4.93  [AIR][Projects] energyQueued=0 committed=104/1452
  4.93  [AIR][Workforce] t1=3/15 t2=0/6 targetBP=656 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Screen] fighters=5 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.96  [Playtest] finished legwin team 0 at 4.95 min
  4.97  [AIR][Rule] energy.grow builder=31910
  4.99  [Playtest] finished legsolar team 0 at 4.99 min
  5.00  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=215 at=8840,1400
  5.00  [AIR][Produce] intercept legfig plant=3968 projected=7/7
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.7 bank 1006/1300, energy +164.1 bank 1278/1284, units 39
  5.00  [Playtest] target team 0 at (8800, 1100) from its start position
  5.00  [Playtest] camera requested (8768,1392) height=2200
  5.00  [AIR][Rule] commander.local.assist builder=28186
  5.01  [Playtest] camera captured name=ta position=(8768,1392) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (8768, 1392)
  5.10  [Playtest] finished legeconv team 0 at 5.10 min
  5.10  [AIR][Economy] T1_CONTEST M=11 bank=1038 E=175 bank=667 pull=301 plants=1/0 aircraftDemand=3/84
  5.10  [AIR][Projects] energyQueued=0 committed=69/495
  5.10  [AIR][Workforce] t1=3/15 t2=0/6 targetBP=655 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.11  [AIR][Rule] mex.assist builder=7882
  5.12  [AIR][Rule] commander.factory.guard builder=28186
  5.21  [AIR][Commander] cleared factory guard for commander.energy.local
  5.21  [AIR][Rule] commander.energy.local builder=28186
  5.23  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=219 at=8696,1400
  5.23  [AIR][Scout] opening drone=25262 enemy starts=1
  5.23  [AIR][Scout] replacement drone=25262
  5.27  [AIR][Economy] T1_CONTEST M=11 bank=1100 E=175 bank=1121 pull=28 plants=1/0 aircraftDemand=3/84
  5.27  [AIR][Projects] energyQueued=0 committed=173/329
  5.27  [AIR][Workforce] t1=3/16 t2=0/7 targetBP=692 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.28  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.40  [Playtest] finished legsolar team 0 at 5.40 min
  5.41  [AIR][Rule] commander.idle.energy builder=28186
  5.43  [AIR][Economy] T1_CONTEST M=11 bank=1053 E=184 bank=1334 pull=110 plants=1/0 aircraftDemand=3/84
  5.43  [AIR][Projects] energyQueued=1 committed=57/252
  5.43  [AIR][Workforce] t1=3/15 t2=0/6 targetBP=671 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.45  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.46  [Playtest] finished legmex team 0 at 5.46 min
  5.47  [AIR][Rule] energy.grow builder=7882
  5.47  [AIR][Rule] energy.grow builder=16924
  5.59  [Playtest] finished legwin team 0 at 5.59 min
  5.60  [AIR][Economy] T1_CONTEST M=12 bank=1156 E=283 bank=1315 pull=120 plants=1/0 aircraftDemand=3/84
  5.60  [AIR][Projects] energyQueued=2 committed=94/385
  5.60  [AIR][Workforce] t1=3/17 t2=0/7 targetBP=746 floating=true savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/4 available=yes firstSlot=0
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  5.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.61  [AIR][Rule] transition.storage builder=31910
  5.62  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.62  [Playtest] finished legwin team 0 at 5.62 min
  5.63  [AIR][State] T1_SCALE
  5.76  [Playtest] finished legwin team 0 at 5.76 min
  5.77  [AIR][Economy] T1_SCALE M=15 bank=1252 E=372 bank=1335 pull=116 plants=1/0 aircraftDemand=3/84
  5.77  [AIR][Projects] energyQueued=2 committed=426/940
  5.77  [AIR][Workforce] t1=3/20 t2=0/8 targetBP=891 floating=true savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/5 available=yes firstSlot=0
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.77  [AIR][Rule] commander.convert builder=28186
  5.78  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.80  [AIR][Share] metal 1293 of 1350 (95%): no teammate with room (0 teammates); the engine counts 0 metal sent in the last update (D-106)
  5.93  [AIR][Economy] T1_SCALE M=15 bank=1350 E=506 bank=1316 pull=222 plants=1/0 aircraftDemand=3/87
  5.93  [AIR][Projects] energyQueued=1 committed=417/997
  5.93  [AIR][Workforce] t1=3/22 t2=0/9 targetBP=949 floating=true savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/5 available=yes firstSlot=0
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  5.94  [Playtest] finished legeconv team 0 at 5.94 min
  5.95  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.96  [AIR][Rule] commander.idle.energy builder=28186
  6.00  [Playtest] eco team 0 at 6.0 min: metal +16.1 bank 1349/1350, energy +585.3 bank 1300/1335, units 46
  6.08  [Playtest] finished legwin team 0 at 6.08 min
  6.09  [AIR][Rule] commander.idle.assist builder=28186
  6.10  [AIR][Economy] T1_SCALE M=15 bank=1350 E=536 bank=1336 pull=192 plants=1/0 aircraftDemand=2/115
  6.10  [AIR][Projects] energyQueued=0 committed=377/790
  6.10  [AIR][Workforce] t1=3/22 t2=0/9 targetBP=949 floating=true savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.10  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/5 available=yes firstSlot=0
  6.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  6.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  6.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  6.10  [AIR][Attack] home=6 target=13 heldBombers=0 escorts=0 wave=0 enemyAir=425
  6.12  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  6.27  [AIR][Economy] T1_SCALE M=16 bank=1234 E=420 bank=1314 pull=234 plants=1/0 aircraftDemand=2/115
  6.27  [AIR][Projects] energyQueued=0 committed=109/272
  6.27  [AIR][Workforce] t1=3/21 t2=0/8 targetBP=916 floating=true savingLab=false
  6.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.27  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/5 available=yes firstSlot=0
  6.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  6.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  6.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  6.28  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  6.30  [Playtest] finished legmstor team 0 at 6.30 min
  6.31  [AIR][Rule] mex.phase.convert builder=31910
  6.32  [AIR][Rule] commander.energy.local builder=28186
  6.43  [Playtest] finished legwin team 0 at 6.43 min
  6.43  [AIR][Economy] T1_SCALE M=16 bank=1252 E=405 bank=1320 pull=164 plants=1/0 aircraftDemand=2/115
  6.43  [AIR][Projects] energyQueued=0 committed=140/1200
  6.43  [AIR][Workforce] t1=3/9 t2=0/4 targetBP=387 floating=false savingLab=false
  6.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.43  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=0
  6.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.44  [AIR][Rule] storage.buffer builder=7882
  6.45  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  6.57  [Playtest] finished legsolar team 0 at 6.57 min
  6.58  [AIR][Rule] commander.idle.assist builder=28186
  6.60  [AIR][Economy] T1_SCALE M=16 bank=1258 E=551 bank=1386 pull=179 plants=1/0 aircraftDemand=2/115
  6.60  [AIR][Projects] energyQueued=0 committed=176/2821
  6.60  [AIR][Workforce] t1=3/9 t2=0/4 targetBP=387 floating=false savingLab=false
  6.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.60  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Attack] home=6 target=12 heldBombers=0 escorts=0 wave=0 enemyAir=384
  6.61  [Playtest] finished legwin team 0 at 6.61 min
  6.62  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  6.63  [AIR][Rule] opening.support builder=16924
  6.77  [AIR][Economy] T1_SCALE M=16 bank=1414 E=484 bank=1387 pull=326 plants=1/0 aircraftDemand=2/115
  6.77  [AIR][Projects] energyQueued=0 committed=400/5437
  6.77  [AIR][Workforce] t1=3/9 t2=0/4 targetBP=387 floating=false savingLab=false
  6.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
... 1848 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: legcom(28186) at (8814, 1124) walks to (8827, 1146), 137 from the legmex site (8896, 1264)
  0.08  EXP: approach: armcom(1236) at (6600, 14247) walks to (6591, 14272), 136 from the armmex site (6544, 14400)
  0.11  EXP: idle: legcom(28186) on legmex at (8823, 1139), site (8896, 1264), target yes, fails 2 (arrived at the approach point)
  0.11  EXP: idle: armcom(1236) on armmex at (6595, 14262), site (6544, 14400), target yes, fails 2 (arrived at the approach point)
  0.21  EXP: approach: armcom(1236) at (6595, 14263) walks to (6472, 14119), 136 from the armmex site (6384, 14016)
  0.23  EXP: approach: legcom(28186) at (8823, 1139) walks to (8910, 1055), 137 from the legmex site (9008, 960)
  0.42  EXP: approach: legcom(28186) at (8892, 1068) walks to (8647, 1112), 137 from the legmex site (8512, 1136)
  0.43  EXP: approach: armcom(1236) at (6492, 14144) walks to (6872, 14351), 136 from the armmex site (6992, 14416)
  0.65  RESERVE: zone 1 at (8664, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: legwin at (8664, 1080) facing 0 (id 1)
  0.65  RESERVE: zone 2 at (8712, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: legwin at (8712, 1080) facing 0 (id 2)
  0.65  RESERVE: zone 3 at (8760, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: legwin at (8760, 1080) facing 0 (id 3)
  0.65  RESERVE: zone 4 at (8664, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: legwin at (8664, 1128) facing 0 (id 4)
  0.65  RESERVE: zone 5 at (8712, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: legwin at (8712, 1128) facing 0 (id 5)
  0.65  RESERVE: zone 6 at (8760, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: legwin at (8760, 1128) facing 0 (id 6)
  0.65  RESERVE: served legwin at (8664, 1080) facing 0 (id 1, 5 of this def still held)
  0.76  RESERVE: zone 1 at (6936, 14360) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6936, 14360) facing 2 (id 1)
  0.76  RESERVE: zone 2 at (6888, 14360) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6888, 14360) facing 2 (id 2)
  0.76  RESERVE: zone 3 at (6840, 14360) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6840, 14360) facing 2 (id 3)
  0.76  RESERVE: zone 4 at (6936, 14312) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6936, 14312) facing 2 (id 4)
  0.76  RESERVE: zone 5 at (6888, 14312) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6888, 14312) facing 2 (id 5)
  0.76  RESERVE: zone 6 at (6840, 14312) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6840, 14312) facing 2 (id 6)
  0.76  RESERVE: served armwin at (6936, 14360) facing 2 (id 1, 5 of this def still held)
  0.81  RESERVE: served legwin at (8712, 1080) facing 0 (id 2, 4 of this def still held)
  0.87  RESERVE: served armwin at (6888, 14360) facing 2 (id 2, 4 of this def still held)
  0.93  RESERVE: served legwin at (8760, 1080) facing 0 (id 3, 3 of this def still held)
  1.04  RESERVE: served armwin at (6840, 14360) facing 2 (id 3, 3 of this def still held)
  1.05  RESERVE: served legwin at (8664, 1128) facing 0 (id 4, 2 of this def still held)
  1.15  RESERVE: served armwin at (6936, 14312) facing 2 (id 4, 2 of this def still held)
  1.17  RESERVE: served legwin at (8712, 1128) facing 0 (id 5, 1 of this def still held)
  1.26  RESERVE: served armwin at (6888, 14312) facing 2 (id 5, 1 of this def still held)
  1.31  RESERVE: served legwin at (8760, 1128) facing 0 (id 6, 0 of this def still held)
  1.37  RESERVE: served armwin at (6840, 14312) facing 2 (id 6, 0 of this def still held)
  1.42  RESERVE: zone 7 at (9048, 1096) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (9048, 1096) facing 0 (id 7)
  1.42  RESERVE: zone 7 released
  1.42  RESERVE: zone 8 at (9048, 1176) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (9048, 1176) facing 0 (id 8)
  1.42  RESERVE: zone 8 released
  1.42  RESERVE: zone 9 at (9016, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (9016, 1240) facing 0 (id 9)
  1.42  RESERVE: zone 10 at (9064, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (9064, 1240) facing 0 (id 10)
  1.42  RESERVE: zone 9 released
  1.42  RESERVE: zone 10 released
  1.42  RESERVE: zone 11 at (8968, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (8968, 1304) facing 0 (id 11)
  1.42  RESERVE: zone 12 at (9016, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (9016, 1304) facing 0 (id 12)
  1.42  RESERVE: zone 13 at (9064, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (9064, 1304) facing 0 (id 13)
  1.42  RESERVE: zone 14 at (8968, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (8968, 1352) facing 0 (id 14)
  1.42  RESERVE: zone 15 at (9016, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (9016, 1352) facing 0 (id 15)
  1.42  RESERVE: zone 16 at (9064, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.42  RESERVE: legwin at (9064, 1352) facing 0 (id 16)
  1.42  EXP: approach: legcom(28186) at (8709, 1227) walks to (8826, 1262), 148 from the legwin site (8968, 1304)
  1.43  RESERVE: served legwin at (8968, 1304) facing 0 (id 11, 5 of this def still held)
  1.52  RESERVE: zone 7 at (6600, 14360) facing 2, 3x3 cells: 9 of 9 held
  1.52  RESERVE: armwin at (6600, 14360) facing 2 (id 7)
  1.52  RESERVE: zone 7 released
  1.52  RESERVE: zone 8 at (6584, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.52  RESERVE: armwin at (6584, 14344) facing 2 (id 8)
  1.52  RESERVE: zone 9 at (6536, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.52  RESERVE: armwin at (6536, 14344) facing 2 (id 9)
  1.52  RESERVE: zone 10 at (6488, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.52  RESERVE: armwin at (6488, 14344) facing 2 (id 10)
  1.52  RESERVE: zone 11 at (6584, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.52  RESERVE: armwin at (6584, 14296) facing 2 (id 11)
  1.52  RESERVE: zone 12 at (6536, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.52  RESERVE: armwin at (6536, 14296) facing 2 (id 12)
  1.52  RESERVE: zone 13 at (6488, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.52  RESERVE: armwin at (6488, 14296) facing 2 (id 13)
  1.52  EXP: approach: armcom(1236) at (6747, 14279) walks to (6711, 14294), 136 from the armwin site (6584, 14344)
  1.52  RESERVE: served armwin at (6584, 14344) facing 2 (id 8, 5 of this def still held)
  1.59  EXP: approach: legcom(28186) at (8806, 1259) walks to (8870, 1331), 148 from the legwin site (9016, 1304)
  1.60  RESERVE: served legwin at (9016, 1304) facing 0 (id 12, 4 of this def still held)
  1.65  EXP: approach: armcom(1236) at (6726, 14283) walks to (6666, 14303), 136 from the armwin site (6536, 14344)
  1.65  RESERVE: served armwin at (6536, 14344) facing 2 (id 9, 4 of this def still held)
  1.73  EXP: approach: legcom(28186) at (8839, 1291) walks to (8924, 1353), 148 from the legwin site (9064, 1304)
  1.74  RESERVE: served legwin at (9064, 1304) facing 0 (id 13, 3 of this def still held)
  1.78  RESERVE: served armwin at (6584, 14296) facing 2 (id 11, 3 of this def still held)
  1.89  RESERVE: served legwin at (8968, 1352) facing 0 (id 14, 2 of this def still held)
  1.89  EXP: approach: armcom(1236) at (6695, 14290) walks to (6620, 14310), 136 from the armwin site (6488, 14344)
  1.90  RESERVE: served armwin at (6488, 14344) facing 2 (id 10, 2 of this def still held)
  2.05  RESERVE: armap at (6768, 14296) facing 1 (id 14)
  2.05  RESERVE: served armap at (6768, 14296) facing 1 (id 14, 0 of this def still held)
  2.05  RESERVE: zone 14 at (6352, 13872) facing 2, 6x6 cells: 36 of 36 held
  2.05  RESERVE: armafus at (6352, 13872) facing 2 (id 15)
  2.05  RESERVE: zone 14 released
  2.05  RESERVE: zone 15 at (6224, 13872) facing 2, 6x6 cells: 36 of 36 held
  2.05  RESERVE: armafus at (6224, 13872) facing 2 (id 16)
  2.05  RESERVE: zone 15 released
  2.05  RESERVE: zone 16 at (6096, 13872) facing 2, 6x6 cells: 36 of 36 held
  2.05  RESERVE: armafus at (6096, 13872) facing 2 (id 17)
  2.05  RESERVE: zone 16 released
  2.15  RESERVE: legap at (8768, 1392) facing 0 (id 17)
  2.15  RESERVE: served legap at (8768, 1392) facing 0 (id 17, 0 of this def still held)
  2.15  RESERVE: zone 17 at (8432, 1248) facing 0, 6x6 cells: 36 of 36 held
  2.15  RESERVE: legafus at (8432, 1248) facing 0 (id 18)
  2.15  RESERVE: zone 17 released
  2.15  RESERVE: zone 18 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  2.15  RESERVE: legafus at (7024, 1376) facing 0 (id 19)
  2.15  RESERVE: zone 18 released
  2.15  RESERVE: zone 19 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
  2.15  RESERVE: legafus at (10608, 1760) facing 0 (id 20)
  2.15  RESERVE: zone 19 released
  2.15  RESERVE: zone 20 at (6896, 1376) facing 0, 6x6 cells: 36 of 36 held
```
