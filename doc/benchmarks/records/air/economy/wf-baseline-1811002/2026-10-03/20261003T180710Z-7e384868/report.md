# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54001); wall 229 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:03:17
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\caldera\runs\20261003T180710Z-7e384868\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=958 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\caldera\runs\20261003T180710Z-7e384868\screen_2026-10-03_18-04-42-349.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\caldera\runs\20261003T180710Z-7e384868\screen_2026-10-03_18-05-41-331.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\caldera\runs\20261003T180710Z-7e384868\screen_2026-10-03_18-06-08-885.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811002\cohort\20261003T172752Z-58ddbf8e\caldera\runs\20261003T180710Z-7e384868\screen_2026-10-03_18-07-09-153.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (8800, 1100) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (6600, 14250) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 122
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (8800, 1100) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (6600, 14250) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 122
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=958 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=314 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (8802, 1114), 16 from the start
  0.21  [Playtest] finished cormex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 13852 at 8896,1264
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|8817|1122|0|4|1|8896|1264
  0.23  [AIR][Rule] opening.mex builder=13591
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=976 E=21 bank=806 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=321 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.40  [Playtest] finished cormex team 0 at 0.40 min
  0.43  [AIR][Economy] BOOTSTRAP M=4 bank=972 E=30 bank=571 pull=24 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=404 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1025 E=30 bank=589 pull=86 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=26/262
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=531 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.65  [Playtest] finished cormex team 0 at 0.65 min
  0.67  [AIR][Wind] cluster=0 slots=6 at=8712,1104 local=true builder=13591
  0.67  [AIR][Rule] opening.energy builder=13591
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1066 E=30 bank=477 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=27/113
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=541 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.83  [Playtest] finished corwin team 0 at 0.83 min
  0.93  [AIR][Economy] BOOTSTRAP M=9 bank=1093 E=30 bank=507 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=4/19
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=645 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.94  [Playtest] finished corwin team 0 at 0.94 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +9.3 bank 1115/1150, energy +55.4 bank 622/1001, units 7
  1.07  [Playtest] finished corwin team 0 at 1.07 min
  1.10  [AIR][Economy] BOOTSTRAP M=9 bank=1130 E=44 bank=791 pull=12 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=1 committed=43/175
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=667 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.19  [Playtest] finished corwin team 0 at 1.19 min
  1.27  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=70 bank=996 pull=9 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=39/160
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=679 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.35  [Playtest] finished corwin team 0 at 1.35 min
  1.36  [AIR][Starter] nearby distance=128
  1.36  [AIR][Rule] opening.plant builder=13591
  1.43  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=105 bank=1002 pull=9 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=630/1100
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=679 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Economy] BOOTSTRAP M=9 bank=944 E=104 bank=1002 pull=70 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=316/552
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=555 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=13377 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.75  [Playtest] finished corap team 0 at 1.75 min
  1.76  [AIR][Produce] opening.scout corfink plant=13377 projected=1/1
  1.76  [AIR][Rule] opening.commander.guard builder=13591
  1.77  [AIR][State] T1_CONTEST
  1.77  [AIR][Economy] T1_CONTEST M=9 bank=687 E=107 bank=1064 pull=68 plants=1/0 aircraftDemand=3/123
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=222 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.90  [AIR][Produce] constructor.recovery corca plant=13377 projected=1/3
  1.93  [AIR][Economy] T1_CONTEST M=9 bank=727 E=112 bank=457 pull=36 plants=1/0 aircraftDemand=3/123
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=222 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 729/1250, energy +96.7 bank 59/1102, units 12
  2.06  [AIR][Commander] cleared factory guard for commander.energy.local
  2.06  [AIR][Rule] commander.energy.local builder=13591
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=722 E=96 bank=67 pull=89 plants=1/0 aircraftDemand=3/123
  2.10  [AIR][Projects] energyQueued=0 committed=35/144
  2.10  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=82 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.18  [Playtest] finished corwin team 0 at 2.18 min
  2.19  [AIR][Rule] opening.commander.guard builder=13591
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=738 E=99 bank=347 pull=169 plants=1/0 aircraftDemand=3/123
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=112 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.28  [AIR][Produce] constructor.recovery corca plant=13377 projected=2/3
  2.28  [AIR][Wind] cluster=1 slots=6 at=10760,1648 local=false builder=7076
  2.28  [AIR][Rule] recovery.energy builder=7076
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=743 E=140 bank=45 pull=199 plants=1/0 aircraftDemand=3/123
  2.43  [AIR][Projects] energyQueued=1 committed=43/175
  2.43  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=222 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.52  [AIR][Produce] constructor.recovery corca plant=13377 projected=3/3
  2.52  [AIR][Rule] recovery.energy builder=17263
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=754 E=150 bank=194 pull=205 plants=1/0 aircraftDemand=3/123
  2.60  [AIR][Projects] energyQueued=1 committed=80/326
  2.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=187 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=761 E=129 bank=9 pull=141 plants=1/0 aircraftDemand=3/123
  2.77  [AIR][Projects] energyQueued=1 committed=66/269
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=222 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.79  [AIR][Produce] opening.screen corveng plant=13377 projected=1/6
  2.79  [AIR][Rule] recovery.energy builder=4213
  2.88  [AIR][Rule] commander.factory.guard builder=13591
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=752 E=126 bank=0 pull=272 plants=1/0 aircraftDemand=3/123
  2.93  [AIR][Projects] energyQueued=1 committed=86/352
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=48 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +5.6 bank 740/1250, energy +130.2 bank 17/1178, units 18
  3.07  [Playtest] finished corwin team 0 at 3.07 min
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=729 E=126 bank=38 pull=264 plants=1/0 aircraftDemand=3/123
  3.10  [AIR][Projects] energyQueued=0 committed=101/413
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=48 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.17  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.17  [AIR][Rule] commander.idle.energy builder=13591
  3.18  [AIR][Produce] opening.screen corveng plant=13377 projected=2/6
  3.18  [AIR][Screen] fighters=1 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=671 E=144 bank=236 pull=152 plants=1/0 aircraftDemand=4/131
  3.27  [AIR][Projects] energyQueued=0 committed=149/257
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=48 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.34  [Playtest] finished corwin team 0 at 3.34 min
  3.35  [AIR][Screen] fighters=1 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.36  [Playtest] finished corsolar team 0 at 3.36 min
  3.37  [AIR][Layout] cluster=0 labs=1 at=6633,1290
  3.37  [AIR][Rule] commander.factory.guard builder=13591
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=581 E=152 bank=25 pull=404 plants=1/0 aircraftDemand=4/131
  3.43  [AIR][Projects] energyQueued=0 committed=66/270
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=222 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.52  [AIR][Screen] fighters=1 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.52  [AIR][Produce] opening.screen corveng plant=13377 projected=3/6
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=561 E=161 bank=9 pull=345 plants=1/0 aircraftDemand=4/131
  3.60  [AIR][Projects] energyQueued=0 committed=28/116
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=82 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.62  [Playtest] finished corwin team 0 at 3.62 min
  3.63  [Playtest] finished corwin team 0 at 3.63 min
  3.65  [AIR][Wind] cluster=2 slots=6 at=6808,1120 local=false builder=7076
  3.70  [AIR][Screen] fighters=2 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=553 E=160 bank=32 pull=266 plants=1/0 aircraftDemand=3/129
  3.77  [AIR][Projects] energyQueued=2 committed=97/395
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=94 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.79  [AIR][Produce] opening.screen corveng plant=13377 projected=4/6
  3.87  [AIR][Screen] fighters=3 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.88  [AIR][Layout] cluster=1 labs=1 at=8937,906
  3.90  [AIR][Layout] cluster=2 labs=1 at=10281,3018
  3.91  [Playtest] finished corwin team 0 at 3.91 min
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=555 E=175 bank=33 pull=270 plants=1/0 aircraftDemand=3/130
  3.93  [AIR][Projects] energyQueued=2 committed=116/474
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=117 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.4 bank 556/1250, energy +177.2 bank 39/1230, units 25
  4.05  [AIR][Screen] fighters=3 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.07  [AIR][Produce] opening.screen corveng plant=13377 projected=5/6
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=562 E=177 bank=223 pull=48 plants=1/0 aircraftDemand=3/130
  4.10  [AIR][Projects] energyQueued=2 committed=102/417
  4.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=106 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=71
  4.22  [AIR][Screen] fighters=4 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=551 E=180 bank=68 pull=272 plants=1/0 aircraftDemand=3/130
  4.27  [AIR][Projects] energyQueued=1 committed=79/321
  4.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=141 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.29  [Playtest] finished corwin team 0 at 4.30 min
  4.31  [AIR][Produce] opening.screen corveng plant=13377 projected=6/6
  4.38  [AIR][Screen] fighters=5 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=547 E=220 bank=46 pull=338 plants=1/0 aircraftDemand=3/130
  4.43  [AIR][Projects] energyQueued=2 committed=105/430
  4.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=152 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.51  [AIR][Produce] intercept corveng plant=13377 projected=7/7
  4.55  [AIR][Screen] fighters=6 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=557 E=264 bank=459 pull=396 plants=1/0 aircraftDemand=3/130
  4.60  [AIR][Projects] energyQueued=1 committed=89/364
  4.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=181 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=64
  4.66  [AIR][Produce] constructor.expand corca plant=13377 projected=4/4
  4.67  [Playtest] finished corwin team 0 at 4.67 min
  4.73  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=542 E=290 bank=1112 pull=192 plants=1/0 aircraftDemand=3/130
  4.77  [AIR][Projects] energyQueued=2 committed=112/458
  4.77  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=211 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.88  [AIR][Rule] mex.phase.convert builder=6200
  4.90  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.93  [AIR][Economy] T1_CONTEST M=9 bank=545 E=339 bank=1256 pull=22 plants=1/0 aircraftDemand=3/130
  4.93  [AIR][Projects] energyQueued=1 committed=90/1586
  4.93  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=222 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.93  [AIR][Rule] commander.idle.assist builder=13591
  5.00  [Playtest] eco team 0 at 5.0 min: metal +9.3 bank 573/1250, energy +328.6 bank 1244/1256, units 34
  5.00  [Playtest] target team 0 at (8800, 1100) from its start position
  5.00  [Playtest] camera requested (8816,1320) height=2200
  5.01  [Playtest] camera captured name=ta position=(8816,1320) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (8816, 1320)
  5.07  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  5.08  [Playtest] finished corwin team 0 at 5.08 min
  5.09  [AIR][Rule] mex.expand builder=17263
  5.10  [AIR][Economy] T1_CONTEST M=9 bank=599 E=329 bank=1257 pull=191 plants=1/0 aircraftDemand=3/130
  5.10  [AIR][Projects] energyQueued=0 committed=101/765
  5.10  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=222 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=58
  5.11  [Playtest] finished cormakr team 0 at 5.11 min
  5.12  [AIR][Rule] storage.buffer builder=6200
  5.12  [AIR][Rule] commander.idle.energy builder=13591
  5.23  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  5.27  [AIR][Economy] T1_CONTEST M=9 bank=609 E=340 bank=1257 pull=90 plants=1/0 aircraftDemand=3/130
  5.27  [AIR][Projects] energyQueued=0 committed=319/2393
  5.27  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=222 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.33  [Playtest] finished corwin team 0 at 5.33 min
  5.34  [Playtest] finished corsolar team 0 at 5.34 min
  5.34  [AIR][Rule] mex.assist builder=7076
  5.35  [AIR][Rule] commander.idle.assist builder=13591
  5.40  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  5.43  [AIR][Economy] T1_CONTEST M=10 bank=579 E=373 bank=1307 pull=122 plants=1/0 aircraftDemand=3/130
  5.43  [AIR][Projects] energyQueued=0 committed=193/1961
  5.43  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=246 floating=false savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.47  [Playtest] finished corwin team 0 at 5.47 min
  5.49  [AIR][Rule] mex.phase.convert builder=4213
  5.57  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  5.60  [AIR][Economy] T1_CONTEST M=10 bank=520 E=389 bank=1302 pull=258 plants=1/0 aircraftDemand=3/130
  5.60  [AIR][Projects] energyQueued=0 committed=27/1518
  5.60  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=246 floating=false savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=52
  5.61  [Playtest] finished corestor team 0 at 5.61 min
  5.62  [AIR][Rule] opening.support builder=6200
  5.62  [AIR][Rule] commander.energy.local builder=13591
  5.63  [AIR][Rule] energy.grow builder=4213
  5.72  [Playtest] finished cormex team 0 at 5.72 min
  5.73  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  5.74  [AIR][Rule] opening.support.assist builder=17263
  5.74  [AIR][Rule] opening.support.assist builder=7076
  5.77  [AIR][Economy] T1_CONTEST M=9 bank=455 E=409 bank=4673 pull=45 plants=1/0 aircraftDemand=3/130
  5.77  [AIR][Projects] energyQueued=0 committed=284/3222
  5.77  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=222 floating=false savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.79  [Playtest] finished corsolar team 0 at 5.79 min
  5.80  [AIR][Rule] commander.idle.assist builder=13591
  5.90  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  5.93  [AIR][Economy] T1_CONTEST M=11 bank=464 E=363 bank=6820 pull=308 plants=1/0 aircraftDemand=3/130
  5.93  [AIR][Projects] energyQueued=0 committed=167/2047
  5.93  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=280 floating=false savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=13377 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.7 bank 420/1300, energy +299.2 bank 6518/7358, units 40
  6.05  [Playtest] finished cornanotc team 0 at 6.05 min
  6.07  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  6.07  [AIR][Rule] commander.idle.energy builder=13591
  6.07  [AIR][Rule] mex.expand builder=17263
  6.10  [AIR][Economy] T1_CONTEST M=12 bank=417 E=291 bank=6711 pull=122 plants=1/0 aircraftDemand=8/296
  6.10  [AIR][Projects] energyQueued=1 committed=435/3636
  6.10  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=304 floating=false savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  6.10  [AIR][Bay] 0 plant=13377 BP=350 nanos=1+1/2 available=yes firstSlot=3
  6.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=47
  6.23  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  6.27  [AIR][Economy] T1_CONTEST M=12 bank=295 E=265 bank=6724 pull=289 plants=1/0 aircraftDemand=8/296
  6.27  [AIR][Projects] energyQueued=0 committed=162/1663
  6.27  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=304 floating=false savingLab=false
  6.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.27  [AIR][Bay] 0 plant=13377 BP=350 nanos=1+1/2 available=yes firstSlot=3
  6.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.27  [Playtest] finished corwin team 0 at 6.27 min
  6.30  [Playtest] finished corsolar team 0 at 6.30 min
  6.37  [Playtest] finished cornanotc team 0 at 6.37 min
  6.39  [AIR][Rule] mex.assist builder=6200
  6.40  [AIR][Rule] energy.grow builder=7076
  6.40  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  6.43  [AIR][Economy] T1_CONTEST M=12 bank=260 E=264 bank=7408 pull=96 plants=1/0 aircraftDemand=13/455
  6.43  [AIR][Projects] energyQueued=1 committed=223/483
  6.43  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=304 floating=false savingLab=false
  6.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.43  [AIR][Bay] 0 plant=13377 BP=550 nanos=2+0/2 available=yes firstSlot=3
  6.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.44  [AIR][Raid] opening size drawn=1
  6.44  [AIR][Produce] opening.raid corshad plant=13377 projected=1/1
  6.45  [AIR][Rule] commander.idle.assist builder=13591
  6.57  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  6.60  [AIR][Economy] T1_CONTEST M=12 bank=198 E=405 bank=6097 pull=618 plants=1/0 aircraftDemand=13/455
  6.60  [AIR][Projects] energyQueued=0 committed=150/233
  6.60  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=304 floating=false savingLab=false
  6.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.60  [AIR][Bay] 0 plant=13377 BP=550 nanos=2+0/2 available=yes firstSlot=3
  6.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=43
  6.62  [AIR][Produce] constructor.expand corca plant=13377 projected=5/6
  6.67  [Playtest] finished cormex team 0 at 6.67 min
  6.68  [AIR][Rule] intel.radar builder=6200
  6.68  [AIR][Rule] wait builder=17263
  6.72  [Playtest] finished corsolar team 0 at 6.72 min
  6.73  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
... 2212 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: corcom(13591) at (8817, 1122) walks to (8829, 1143), 139 from the cormex site (8896, 1264)
  0.08  EXP: approach: armcom(30290) at (6600, 14247) walks to (6591, 14272), 136 from the armmex site (6544, 14400)
  0.11  EXP: idle: corcom(13591) on cormex at (8825, 1138), site (8896, 1264), target yes, fails 2 (arrived at the approach point)
  0.11  EXP: idle: armcom(30290) on armmex at (6595, 14262), site (6544, 14400), target yes, fails 2 (arrived at the approach point)
  0.21  EXP: approach: armcom(30290) at (6595, 14263) walks to (6472, 14119), 136 from the armmex site (6384, 14016)
  0.23  EXP: approach: corcom(13591) at (8826, 1138) walks to (8909, 1057), 139 from the cormex site (9008, 960)
  0.42  EXP: approach: corcom(13591) at (8897, 1073) walks to (8649, 1114), 139 from the cormex site (8512, 1136)
  0.43  EXP: approach: armcom(30290) at (6492, 14144) walks to (6872, 14351), 136 from the armmex site (6992, 14416)
  0.67  RESERVE: zone 1 at (8664, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8664, 1080) facing 0 (id 1)
  0.67  RESERVE: zone 2 at (8712, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8712, 1080) facing 0 (id 2)
  0.67  RESERVE: zone 3 at (8760, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8760, 1080) facing 0 (id 3)
  0.67  RESERVE: zone 4 at (8664, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8664, 1128) facing 0 (id 4)
  0.67  RESERVE: zone 5 at (8712, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8712, 1128) facing 0 (id 5)
  0.67  RESERVE: zone 6 at (8760, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8760, 1128) facing 0 (id 6)
  0.67  RESERVE: served corwin at (8664, 1080) facing 0 (id 1, 5 of this def still held)
  0.76  RESERVE: zone 1 at (6920, 14360) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6920, 14360) facing 2 (id 1)
  0.76  RESERVE: zone 2 at (6872, 14360) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6872, 14360) facing 2 (id 2)
  0.76  RESERVE: zone 3 at (6824, 14360) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6824, 14360) facing 2 (id 3)
  0.76  RESERVE: zone 4 at (6920, 14312) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6920, 14312) facing 2 (id 4)
  0.76  RESERVE: zone 5 at (6872, 14312) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6872, 14312) facing 2 (id 5)
  0.76  RESERVE: zone 6 at (6824, 14312) facing 2, 3x3 cells: 9 of 9 held
  0.76  RESERVE: armwin at (6824, 14312) facing 2 (id 6)
  0.76  RESERVE: served armwin at (6920, 14360) facing 2 (id 1, 5 of this def still held)
  0.84  RESERVE: served corwin at (8712, 1080) facing 0 (id 2, 4 of this def still held)
  0.88  RESERVE: served armwin at (6872, 14360) facing 2 (id 2, 4 of this def still held)
  0.96  RESERVE: served corwin at (8760, 1080) facing 0 (id 3, 3 of this def still held)
  1.05  RESERVE: served armwin at (6824, 14360) facing 2 (id 3, 3 of this def still held)
  1.08  RESERVE: served corwin at (8664, 1128) facing 0 (id 4, 2 of this def still held)
  1.17  RESERVE: served armwin at (6920, 14312) facing 2 (id 4, 2 of this def still held)
  1.21  RESERVE: served corwin at (8712, 1128) facing 0 (id 5, 1 of this def still held)
  1.29  RESERVE: served armwin at (6872, 14312) facing 2 (id 5, 1 of this def still held)
  1.36  RESERVE: corap at (8816, 1320) facing 1 (id 7)
  1.36  RESERVE: served corap at (8816, 1320) facing 1 (id 7, 0 of this def still held)
  1.37  RESERVE: zone 7 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.37  RESERVE: corafus at (7024, 1376) facing 0 (id 8)
  1.37  RESERVE: zone 7 released
  1.37  RESERVE: zone 8 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.37  RESERVE: corafus at (10608, 1760) facing 0 (id 9)
  1.37  RESERVE: zone 8 released
  1.37  RESERVE: zone 9 at (6896, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.37  RESERVE: corafus at (6896, 1376) facing 0 (id 10)
  1.37  RESERVE: zone 9 released
  1.37  RESERVE: zone 10 at (10736, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.37  RESERVE: corafus at (10736, 1760) facing 0 (id 11)
  1.37  RESERVE: zone 10 released
  1.37  RESERVE: zone 11 at (6640, 1120) facing 0, 6x6 cells: 36 of 36 held
  1.37  RESERVE: corafus at (6640, 1120) facing 0 (id 12)
  1.37  RESERVE: zone 11 released
  1.37  RESERVE: zone 12 at (6640, 1248) facing 0, 6x6 cells: 36 of 36 held
  1.37  RESERVE: corafus at (6640, 1248) facing 0 (id 13)
  1.37  RESERVE: zone 12 released
  1.37  RESERVE: zone 13 at (8048, 2400) facing 0, 6x6 cells: 36 of 36 held
  1.37  RESERVE: corafus at (8048, 2400) facing 0 (id 14)
  1.37  RESERVE: zone 13 released
  1.40  RESERVE: armap at (6752, 14408) facing 1 (id 7)
  1.40  RESERVE: served armap at (6752, 14408) facing 1 (id 7, 0 of this def still held)
  1.42  RESERVE: zone 7 at (6352, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.42  RESERVE: armafus at (6352, 13872) facing 2 (id 8)
  1.42  RESERVE: zone 7 released
  1.42  RESERVE: zone 8 at (6224, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.42  RESERVE: armafus at (6224, 13872) facing 2 (id 9)
  1.42  RESERVE: zone 8 released
  1.42  RESERVE: zone 9 at (6096, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.42  RESERVE: armafus at (6096, 13872) facing 2 (id 10)
  1.42  RESERVE: zone 9 released
  1.47  RESERVE: zone 14 at (8728, 1208) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: cornanotc at (8728, 1208) facing 0 (id 15)
  1.47  RESERVE: zone 15 at (8776, 1208) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: cornanotc at (8776, 1208) facing 0 (id 16)
  1.47  RESERVE: zone 16 at (8824, 1208) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: cornanotc at (8824, 1208) facing 0 (id 17)
  1.47  RESERVE: zone 17 at (8872, 1208) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: cornanotc at (8872, 1208) facing 0 (id 18)
  1.47  RESERVE: zone 18 at (8920, 1208) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: cornanotc at (8920, 1208) facing 0 (id 19)
  1.53  RESERVE: zone 19 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.53  RESERVE: corafus at (7024, 1376) facing 0 (id 20)
  1.53  RESERVE: zone 19 released
  1.53  RESERVE: zone 20 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.53  RESERVE: corafus at (10608, 1760) facing 0 (id 21)
  1.53  RESERVE: zone 20 released
  1.53  RESERVE: zone 21 at (6896, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.53  RESERVE: corafus at (6896, 1376) facing 0 (id 22)
  1.53  RESERVE: zone 21 released
  1.53  RESERVE: zone 22 at (10736, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.53  RESERVE: corafus at (10736, 1760) facing 0 (id 23)
  1.53  RESERVE: zone 22 released
  1.53  RESERVE: zone 23 at (6640, 1120) facing 0, 6x6 cells: 36 of 36 held
  1.53  RESERVE: corafus at (6640, 1120) facing 0 (id 24)
  1.53  RESERVE: zone 23 released
  1.53  RESERVE: zone 24 at (6640, 1248) facing 0, 6x6 cells: 36 of 36 held
  1.53  RESERVE: corafus at (6640, 1248) facing 0 (id 25)
  1.53  RESERVE: zone 24 released
  1.53  RESERVE: zone 25 at (8048, 2400) facing 0, 6x6 cells: 36 of 36 held
  1.53  RESERVE: corafus at (8048, 2400) facing 0 (id 26)
  1.53  RESERVE: zone 25 released
  1.58  RESERVE: zone 10 at (6352, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.58  RESERVE: armafus at (6352, 13872) facing 2 (id 11)
  1.58  RESERVE: zone 10 released
  1.58  RESERVE: zone 11 at (6224, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.58  RESERVE: armafus at (6224, 13872) facing 2 (id 12)
  1.58  RESERVE: zone 11 released
  1.58  RESERVE: zone 12 at (6096, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.58  RESERVE: armafus at (6096, 13872) facing 2 (id 13)
  1.58  RESERVE: zone 12 released
  1.70  RESERVE: zone 26 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.70  RESERVE: corafus at (7024, 1376) facing 0 (id 27)
  1.70  RESERVE: zone 26 released
  1.70  RESERVE: zone 27 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
```
