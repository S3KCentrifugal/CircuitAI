# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54002); wall 230 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:44:07
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\caldera\runs\20261003T174800Z-83e1b776\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\caldera\runs\20261003T174800Z-83e1b776\screen_2026-10-03_17-45-23-208.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\caldera\runs\20261003T174800Z-83e1b776\screen_2026-10-03_17-46-20-561.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\caldera\runs\20261003T174800Z-83e1b776\screen_2026-10-03_17-46-50-757.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\caldera\runs\20261003T174800Z-83e1b776\screen_2026-10-03_17-47-59-514.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (8800, 1100) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (6600, 14250) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 139
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (8800, 1100) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (6600, 14250) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 139
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=314 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (8802, 1114), 11 from the start
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 20350 at 8896,1264
  0.20  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|8812|1121|0|4|1|8896|1264
  0.21  [AIR][Rule] opening.mex builder=17070
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=977 E=21 bank=804 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=321 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=976 E=30 bank=567 pull=6 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=397 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1015 E=30 bank=468 pull=89 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=12/127
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=508 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.62  [Playtest] finished armmex team 0 at 0.63 min
  0.64  [AIR][Wind] cluster=0 slots=6 at=8712,1104 local=true builder=17070
  0.64  [AIR][Rule] opening.energy builder=17070
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1062 E=30 bank=412 pull=41 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=13/61
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=539 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.80  [Playtest] finished armwin team 0 at 0.80 min
  0.92  [Playtest] finished armwin team 0 at 0.92 min
  0.93  [AIR][Economy] BOOTSTRAP M=9 bank=1096 E=30 bank=532 pull=41 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=647 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +9.3 bank 1117/1150, energy +70.0 bank 713/1001, units 7
  1.04  [Playtest] finished armwin team 0 at 1.04 min
  1.10  [AIR][Economy] BOOTSTRAP M=9 bank=1143 E=63 bank=985 pull=25 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=29/126
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=675 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.16  [Playtest] finished armwin team 0 at 1.16 min
  1.27  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=88 bank=988 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=10/44
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=679 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.29  [Playtest] finished armwin team 0 at 1.29 min
  1.30  [AIR][Starter] nearby distance=128
  1.30  [AIR][Rule] opening.plant builder=17070
  1.43  [AIR][Economy] BOOTSTRAP M=9 bank=1114 E=109 bank=978 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=561/950
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=658 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=3267 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Economy] BOOTSTRAP M=9 bank=849 E=121 bank=990 pull=69 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=203/345
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=222 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=3267 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.69  [Playtest] finished armap team 0 at 1.69 min
  1.70  [AIR][State] T1_CONTEST
  1.71  [AIR][Produce] opening.scout armpeep plant=3267 projected=1/1
  1.71  [AIR][Rule] opening.commander.guard builder=17070
  1.77  [AIR][Economy] T1_CONTEST M=9 bank=693 E=112 bank=855 pull=258 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=222 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.84  [AIR][Produce] constructor.recovery armca plant=3267 projected=1/3
  1.93  [AIR][Economy] T1_CONTEST M=9 bank=717 E=111 bank=248 pull=198 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=222 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +5.6 bank 711/1250, energy +129.3 bank 42/1102, units 12
  2.00  [AIR][Commander] cleared factory guard for commander.energy.local
  2.00  [AIR][Rule] commander.energy.local builder=17070
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=711 E=121 bank=292 pull=58 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=6/28
  2.10  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=141 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.11  [Playtest] finished armwin team 0 at 2.11 min
  2.12  [AIR][Rule] opening.commander.guard builder=17070
  2.20  [AIR][Produce] constructor.recovery armca plant=3267 projected=2/3
  2.20  [AIR][Wind] cluster=1 slots=6 at=10760,1648 local=false builder=21740
  2.20  [AIR][Rule] recovery.energy builder=21740
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=746 E=129 bank=732 pull=170 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=1 committed=40/175
  2.27  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=222 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Economy] T1_CONTEST M=9 bank=758 E=154 bank=670 pull=166 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=1 committed=40/175
  2.43  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=222 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.45  [AIR][Produce] constructor.recovery armca plant=3267 projected=3/3
  2.45  [AIR][Rule] mex.expand builder=28726
  2.60  [AIR][Economy] T1_CONTEST M=9 bank=759 E=154 bank=534 pull=203 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=79/628
  2.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=222 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.67  [AIR][Produce] opening.screen armfig plant=3267 projected=1/6
  2.67  [AIR][Rule] mex.assist builder=18821
  2.71  [AIR][Rule] commander.factory.guard builder=17070
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=760 E=128 bank=30 pull=263 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=58/489
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=181 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=762 E=127 bank=82 pull=169 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=38/354
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=65 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.4 bank 748/1250, energy +158.7 bank 38/1178, units 18
  3.02  [Playtest] finished armwin team 0 at 3.02 min
  3.03  [AIR][Produce] opening.screen armfig plant=3267 projected=2/6
  3.03  [AIR][Screen] fighters=1 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=750 E=145 bank=52 pull=318 plants=1/0 aircraftDemand=3/127
  3.10  [AIR][Projects] energyQueued=0 committed=54/347
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=82 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.20  [AIR][Screen] fighters=1 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=734 E=175 bank=46 pull=276 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=31/177
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=82 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.33  [AIR][Produce] opening.screen armfig plant=3267 projected=3/6
  3.34  [Playtest] finished armmex team 0 at 3.34 min
  3.36  [AIR][Rule] recovery.energy builder=28726
  3.36  [AIR][Rule] recovery.energy builder=18821
  3.37  [AIR][Screen] fighters=2 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=726 E=181 bank=81 pull=237 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=2 committed=92/402
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=48 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.48  [AIR][Layout] cluster=0 labs=1 at=6628,1289
  3.53  [AIR][Screen] fighters=2 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.59  [Playtest] finished armwin team 0 at 3.59 min
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=740 E=182 bank=29 pull=266 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=79/349
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=118 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.62  [AIR][Produce] opening.screen armfig plant=3267 projected=4/6
  3.70  [AIR][Screen] fighters=3 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=746 E=186 bank=47 pull=276 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=83/365
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=147 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.83  [AIR][Layout] cluster=1 labs=1 at=8932,905
  3.85  [AIR][Layout] cluster=2 labs=1 at=10276,3017
  3.87  [AIR][Screen] fighters=3 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.91  [AIR][Produce] opening.screen armfig plant=3267 projected=5/6
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=747 E=185 bank=255 pull=28 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=46/203
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=118 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.4 bank 744/1300, energy +204.1 bank 51/1179, units 26
  4.05  [AIR][Screen] fighters=4 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=735 E=196 bank=1 pull=268 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=10/44
  4.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=153 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.14  [Playtest] finished armwin team 0 at 4.14 min
  4.14  [Playtest] finished armwin team 0 at 4.14 min
  4.16  [Playtest] finished armwin team 0 at 4.16 min
  4.16  [AIR][Wind] cluster=2 slots=6 at=6792,1120 local=false builder=18821
  4.17  [AIR][Produce] opening.screen armfig plant=3267 projected=6/6
  4.18  [AIR][Wind] cluster=3 slots=6 at=9016,832 local=false builder=17070
  4.18  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.18  [AIR][Rule] commander.idle.energy builder=17070
  4.22  [AIR][Screen] fighters=5 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=771 E=201 bank=1040 pull=136 plants=1/0 aircraftDemand=3/124
  4.27  [AIR][Projects] energyQueued=4 committed=160/700
  4.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=112 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.40  [AIR][Screen] fighters=5 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.43  [AIR][Economy] T1_CONTEST M=11 bank=849 E=261 bank=1150 pull=141 plants=1/0 aircraftDemand=3/124
  4.43  [AIR][Projects] energyQueued=3 committed=151/661
  4.43  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=281 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.54  [Playtest] finished armwin team 0 at 4.54 min
  4.55  [AIR][Rule] commander.energy.local builder=17070
  4.57  [AIR][Screen] fighters=5 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.58  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=294 at=8824,1320
  4.58  [AIR][Produce] intercept armfig plant=3267 projected=7/7
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=885 E=261 bank=1181 pull=38 plants=1/0 aircraftDemand=3/125
  4.60  [AIR][Projects] energyQueued=3 committed=138/606
  4.60  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=281 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=274
  4.71  [Playtest] finished armwin team 0 at 4.71 min
  4.72  [AIR][Rule] commander.factory.guard builder=17070
  4.75  [AIR][Screen] fighters=6 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=908 E=282 bank=1143 pull=152 plants=1/0 aircraftDemand=3/125
  4.77  [AIR][Projects] energyQueued=0 committed=72/315
  4.77  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=281 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.85  [Playtest] finished armwin team 0 at 4.85 min
  4.86  [AIR][Rule] mex.phase.convert builder=28726
  4.91  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=302 at=8776,1320
  4.92  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.92  [AIR][Rule] commander.idle.energy builder=17070
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=950 E=289 bank=1181 pull=22 plants=1/0 aircraftDemand=3/125
  4.93  [AIR][Projects] energyQueued=1 committed=81/1504
  4.93  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=281 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.95  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.7 bank 995/1300, energy +273.2 bank 1181/1182, units 32
  5.00  [Playtest] target team 0 at (8800, 1100) from its start position
  5.00  [Playtest] camera requested (8800,1224) height=2200
  5.01  [Playtest] camera captured name=ta position=(8800,1224) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (8800, 1224)
  5.10  [AIR][Economy] T1_CONTEST M=11 bank=1020 E=267 bank=1180 pull=55 plants=1/0 aircraftDemand=3/125
  5.10  [AIR][Projects] energyQueued=0 committed=27/1262
  5.10  [AIR][Workforce] t1=3/13 t2=0/6 targetBP=644 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/4 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  5.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=247
  5.12  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.12  [Playtest] finished armwin team 0 at 5.12 min
  5.13  [AIR][Rule] commander.energy.local builder=17070
  5.18  [Playtest] finished armwin team 0 at 5.18 min
  5.20  [AIR][Rule] mex.expand builder=18821
  5.23  [Playtest] finished armwin team 0 at 5.23 min
  5.23  [Playtest] finished armwin team 0 at 5.23 min
  5.25  [AIR][Rule] commander.local.assist builder=17070
  5.25  [AIR][Rule] energy.grow builder=21740
  5.27  [AIR][Economy] T1_CONTEST M=11 bank=1061 E=249 bank=1163 pull=65 plants=1/0 aircraftDemand=3/125
  5.27  [AIR][Projects] energyQueued=1 committed=90/1442
  5.27  [AIR][Workforce] t1=3/14 t2=0/6 targetBP=668 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.28  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.35  [Playtest] finished armmakr team 0 at 5.35 min
  5.36  [AIR][Rule] transition.storage builder=28726
  5.37  [AIR][Rule] commander.idle.energy builder=17070
  5.43  [AIR][Economy] T1_CONTEST M=11 bank=1168 E=223 bank=1184 pull=128 plants=1/0 aircraftDemand=3/125
  5.43  [AIR][Projects] energyQueued=1 committed=438/1310
  5.43  [AIR][Workforce] t1=3/15 t2=0/7 targetBP=733 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.45  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.48  [Playtest] finished armwin team 0 at 5.48 min
  5.49  [AIR][Rule] commander.idle.assist builder=17070
  5.60  [AIR][Economy] T1_CONTEST M=12 bank=1208 E=148 bank=1180 pull=111 plants=1/0 aircraftDemand=3/125
  5.60  [AIR][Projects] energyQueued=0 committed=351/974
  5.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=792 floating=true savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=224
  5.62  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.70  [AIR][Share] metal 1239 of 1300 (95%): no teammate with room (0 teammates); the engine counts 0 metal sent in the last update (D-106)
  5.77  [AIR][Economy] T1_CONTEST M=12 bank=1252 E=140 bank=1138 pull=111 plants=1/0 aircraftDemand=3/125
  5.77  [AIR][Projects] energyQueued=0 committed=251/654
  5.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=819 floating=true savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.78  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.86  [Playtest] finished armmstor team 0 at 5.86 min
  5.87  [AIR][Rule] energy.grow builder=28726
  5.87  [AIR][Rule] commander.idle.energy builder=17070
  5.93  [AIR][Economy] T1_CONTEST M=12 bank=1121 E=152 bank=1181 pull=101 plants=1/0 aircraftDemand=3/125
  5.93  [AIR][Projects] energyQueued=2 committed=95/448
  5.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=305 floating=false savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.95  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  6.00  [Playtest] finished armmex team 0 at 6.00 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.7 bank 1170/4350, energy +258.8 bank 1160/1184, units 39
  6.01  [AIR][Rule] energy.grow builder=18821
  6.06  [Playtest] finished armwin team 0 at 6.06 min
  6.10  [AIR][Economy] T1_CONTEST M=12 bank=1242 E=193 bank=1185 pull=85 plants=1/0 aircraftDemand=3/125
  6.10  [AIR][Projects] energyQueued=4 committed=160/700
  6.10  [AIR][Workforce] t1=3/7 t2=0/3 targetBP=305 floating=false savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.10  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  6.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=202
  6.12  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  6.23  [Playtest] finished armwin team 0 at 6.23 min
  6.25  [AIR][State] T1_SCALE
  6.27  [AIR][Economy] T1_SCALE M=15 bank=1349 E=309 bank=1185 pull=99 plants=1/0 aircraftDemand=3/125
  6.27  [AIR][Projects] energyQueued=1 committed=151/662
  6.27  [AIR][Workforce] t1=3/8 t2=0/4 targetBP=363 floating=false savingLab=false
  6.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.27  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  6.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.28  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  6.43  [AIR][Economy] T1_SCALE M=15 bank=1462 E=458 bank=1185 pull=101 plants=1/0 aircraftDemand=3/125
  6.43  [AIR][Projects] energyQueued=0 committed=73/323
  6.43  [AIR][Workforce] t1=3/8 t2=0/4 targetBP=363 floating=false savingLab=false
  6.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.43  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  6.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.45  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  6.60  [AIR][Economy] T1_SCALE M=15 bank=1576 E=458 bank=1185 pull=101 plants=1/0 aircraftDemand=3/125
  6.60  [AIR][Projects] energyQueued=0 committed=36/159
  6.60  [AIR][Workforce] t1=3/8 t2=0/4 targetBP=363 floating=false savingLab=false
  6.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.60  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  6.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=183
  6.62  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  6.75  [Playtest] finished armwin team 0 at 6.75 min
  6.76  [AIR][Rule] mex.phase.convert builder=21740
  6.76  [Playtest] finished armwin team 0 at 6.76 min
  6.77  [AIR][Economy] T1_SCALE M=15 bank=1691 E=454 bank=1186 pull=100 plants=1/0 aircraftDemand=3/125
  6.77  [AIR][Projects] energyQueued=0 committed=1/1152
  6.77  [AIR][Workforce] t1=3/8 t2=0/4 targetBP=363 floating=false savingLab=false
  6.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.77  [AIR][Bay] 0 plant=3267 BP=150 nanos=0+0/2 available=yes firstSlot=0
... 1517 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(17070) at (8813, 1121) walks to (8827, 1146), 136 from the armmex site (8896, 1264)
  0.08  EXP: approach: armcom(1901) at (6600, 14247) walks to (6591, 14272), 136 from the armmex site (6544, 14400)
  0.11  EXP: idle: armcom(1901) on armmex at (6595, 14262), site (6544, 14400), target yes, fails 2 (arrived at the approach point)
  0.21  EXP: approach: armcom(17070) at (8820, 1133) walks to (8908, 1052), 136 from the armmex site (9008, 960)
  0.21  EXP: approach: armcom(1901) at (6595, 14263) walks to (6472, 14119), 136 from the armmex site (6384, 14016)
  0.40  EXP: approach: armcom(17070) at (8882, 1075) walks to (8646, 1114), 136 from the armmex site (8512, 1136)
  0.43  EXP: approach: armcom(1901) at (6492, 14144) walks to (6872, 14351), 136 from the armmex site (6992, 14416)
  0.64  RESERVE: zone 1 at (8664, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8664, 1080) facing 0 (id 1)
  0.64  RESERVE: zone 2 at (8712, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8712, 1080) facing 0 (id 2)
  0.64  RESERVE: zone 3 at (8760, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8760, 1080) facing 0 (id 3)
  0.64  RESERVE: zone 4 at (8664, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8664, 1128) facing 0 (id 4)
  0.64  RESERVE: zone 5 at (8712, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8712, 1128) facing 0 (id 5)
  0.64  RESERVE: zone 6 at (8760, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8760, 1128) facing 0 (id 6)
  0.64  RESERVE: served armwin at (8664, 1080) facing 0 (id 1, 5 of this def still held)
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
  0.81  RESERVE: served armwin at (8712, 1080) facing 0 (id 2, 4 of this def still held)
  0.88  RESERVE: served armwin at (6872, 14360) facing 2 (id 2, 4 of this def still held)
  0.93  RESERVE: served armwin at (8760, 1080) facing 0 (id 3, 3 of this def still held)
  1.05  RESERVE: served armwin at (6824, 14360) facing 2 (id 3, 3 of this def still held)
  1.05  RESERVE: served armwin at (8664, 1128) facing 0 (id 4, 2 of this def still held)
  1.18  RESERVE: served armwin at (8712, 1128) facing 0 (id 5, 1 of this def still held)
  1.18  RESERVE: served armwin at (6920, 14312) facing 2 (id 4, 2 of this def still held)
  1.30  RESERVE: armap at (8800, 1224) facing 1 (id 7)
  1.30  RESERVE: served armap at (8800, 1224) facing 1 (id 7, 0 of this def still held)
  1.30  RESERVE: served armwin at (6872, 14312) facing 2 (id 5, 1 of this def still held)
  1.32  RESERVE: zone 7 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.32  RESERVE: armafus at (7024, 1376) facing 0 (id 8)
  1.32  RESERVE: zone 7 released
  1.32  RESERVE: zone 8 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.32  RESERVE: armafus at (10608, 1760) facing 0 (id 9)
  1.32  RESERVE: zone 8 released
  1.32  RESERVE: zone 9 at (6896, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.32  RESERVE: armafus at (6896, 1376) facing 0 (id 10)
  1.32  RESERVE: zone 9 released
  1.32  RESERVE: zone 10 at (10736, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.32  RESERVE: armafus at (10736, 1760) facing 0 (id 11)
  1.32  RESERVE: zone 10 released
  1.32  RESERVE: zone 11 at (6640, 1120) facing 0, 6x6 cells: 36 of 36 held
  1.32  RESERVE: armafus at (6640, 1120) facing 0 (id 12)
  1.32  RESERVE: zone 11 released
  1.32  RESERVE: zone 12 at (6640, 1248) facing 0, 6x6 cells: 36 of 36 held
  1.32  RESERVE: armafus at (6640, 1248) facing 0 (id 13)
  1.32  RESERVE: zone 12 released
  1.32  RESERVE: zone 13 at (8048, 2400) facing 0, 6x6 cells: 36 of 36 held
  1.32  RESERVE: armafus at (8048, 2400) facing 0 (id 14)
  1.32  RESERVE: zone 13 released
  1.40  RESERVE: zone 14 at (8808, 1112) facing 0, 3x3 cells: 9 of 9 held
  1.40  RESERVE: armnanotc at (8808, 1112) facing 0 (id 15)
  1.40  RESERVE: zone 15 at (8856, 1112) facing 0, 3x3 cells: 9 of 9 held
  1.40  RESERVE: armnanotc at (8856, 1112) facing 0 (id 16)
  1.40  RESERVE: zone 16 at (8904, 1112) facing 0, 3x3 cells: 9 of 9 held
  1.40  RESERVE: armnanotc at (8904, 1112) facing 0 (id 17)
  1.43  RESERVE: armap at (6752, 14408) facing 1 (id 7)
  1.43  RESERVE: served armap at (6752, 14408) facing 1 (id 7, 0 of this def still held)
  1.43  RESERVE: zone 7 at (6352, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.43  RESERVE: armafus at (6352, 13872) facing 2 (id 8)
  1.43  RESERVE: zone 7 released
  1.43  RESERVE: zone 8 at (6224, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.43  RESERVE: armafus at (6224, 13872) facing 2 (id 9)
  1.43  RESERVE: zone 8 released
  1.43  RESERVE: zone 9 at (6096, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.43  RESERVE: armafus at (6096, 13872) facing 2 (id 10)
  1.43  RESERVE: zone 9 released
  1.48  RESERVE: zone 17 at (8688, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (8688, 1376) facing 0 (id 18)
  1.48  RESERVE: zone 17 released
  1.48  RESERVE: zone 18 at (8816, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (8816, 1376) facing 0 (id 19)
  1.48  RESERVE: zone 18 released
  1.48  RESERVE: zone 19 at (8944, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (8944, 1376) facing 0 (id 20)
  1.48  RESERVE: zone 19 released
  1.48  RESERVE: zone 20 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (7024, 1376) facing 0 (id 21)
  1.48  RESERVE: zone 20 released
  1.48  RESERVE: zone 21 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (10608, 1760) facing 0 (id 22)
  1.48  RESERVE: zone 21 released
  1.48  RESERVE: zone 22 at (6896, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (6896, 1376) facing 0 (id 23)
  1.48  RESERVE: zone 22 released
  1.48  RESERVE: zone 23 at (10736, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (10736, 1760) facing 0 (id 24)
  1.48  RESERVE: zone 23 released
  1.48  RESERVE: zone 24 at (6640, 1120) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (6640, 1120) facing 0 (id 25)
  1.48  RESERVE: zone 24 released
  1.48  RESERVE: zone 25 at (6640, 1248) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (6640, 1248) facing 0 (id 26)
  1.48  RESERVE: zone 25 released
  1.48  RESERVE: zone 26 at (8048, 2400) facing 0, 6x6 cells: 36 of 36 held
  1.48  RESERVE: armafus at (8048, 2400) facing 0 (id 27)
  1.48  RESERVE: zone 26 released
  1.60  RESERVE: zone 10 at (6352, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.60  RESERVE: armafus at (6352, 13872) facing 2 (id 11)
  1.60  RESERVE: zone 10 released
  1.60  RESERVE: zone 11 at (6224, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.60  RESERVE: armafus at (6224, 13872) facing 2 (id 12)
  1.60  RESERVE: zone 11 released
  1.60  RESERVE: zone 12 at (6096, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.60  RESERVE: armafus at (6096, 13872) facing 2 (id 13)
  1.60  RESERVE: zone 12 released
```
