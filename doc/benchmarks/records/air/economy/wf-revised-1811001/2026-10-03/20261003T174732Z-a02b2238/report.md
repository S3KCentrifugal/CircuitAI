# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54000); wall 229 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:43:40
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\caldera\runs\20261003T174732Z-a02b2238\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\caldera\runs\20261003T174732Z-a02b2238\screen_2026-10-03_17-44-55-791.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\caldera\runs\20261003T174732Z-a02b2238\screen_2026-10-03_17-45-58-276.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\caldera\runs\20261003T174732Z-a02b2238\screen_2026-10-03_17-46-25-322.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\caldera\runs\20261003T174732Z-a02b2238\screen_2026-10-03_17-47-31-254.png

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
  0.08  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (8802, 1114), 11 from the start
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 20350 at 8896,1264
  0.20  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|8812|1121|0|4|1|8896|1264
  0.21  [AIR][Rule] opening.mex builder=17070
  0.27  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=977 E=21 bank=804 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.43  [AIR][Capacity] own=4/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=976 E=30 bank=567 pull=6 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=6/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1015 E=30 bank=468 pull=89 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=12/127
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.62  [Playtest] finished armmex team 0 at 0.63 min
  0.64  [AIR][Wind] cluster=0 slots=6 at=8696,1104 local=true builder=17070
  0.64  [AIR][Rule] opening.energy builder=17070
  0.77  [AIR][Capacity] own=6/30 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1062 E=30 bank=412 pull=41 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=13/61
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.80  [Playtest] finished armwin team 0 at 0.80 min
  0.91  [Playtest] finished armwin team 0 at 0.91 min
  0.93  [AIR][Capacity] own=9/30 usage=2/19 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=9 bank=1094 E=30 bank=416 pull=19 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +9.3 bank 1110/1150, energy +45.9 bank 450/1001, units 7
  1.02  [Playtest] finished armwin team 0 at 1.02 min
  1.10  [AIR][Capacity] own=9/42 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=9 bank=1136 E=43 bank=581 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=21/94
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.15  [Playtest] finished armwin team 0 at 1.15 min
  1.27  [AIR][Capacity] own=9/52 usage=7/41 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=53 bank=918 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=21/94
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.31  [Playtest] finished armwin team 0 at 1.31 min
  1.42  [Playtest] finished armwin team 0 at 1.42 min
  1.43  [AIR][Capacity] own=9/59 usage=7/41 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=63 bank=1002 pull=41 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.44  [AIR][Wind] cluster=1 slots=6 at=9016,1328 local=false builder=17070
  1.59  [Playtest] finished armwin team 0 at 1.59 min
  1.60  [AIR][Capacity] own=9/60 usage=7/41 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=60 bank=1003 pull=41 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.75  [Playtest] finished armwin team 0 at 1.75 min
  1.77  [AIR][Capacity] own=9/84 usage=6/36 gifts=0 sent=0 excess=3 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=79 bank=1004 pull=36 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=1 committed=40/175
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Capacity] own=9/146 usage=7/41 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=140 bank=1001 pull=41 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=21/94
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.98  [Playtest] finished armwin team 0 at 1.98 min
  1.99  [AIR][Starter] nearby distance=128
  1.99  [AIR][Rule] opening.plant builder=17070
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 1150/1150, energy +161.9 bank 1004/1004, units 13
  2.10  [AIR][Capacity] own=9/149 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=9 bank=1037 E=149 bank=1002 pull=69 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=456/773
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=21618 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=9/178 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=9 bank=772 E=174 bank=1004 pull=69 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=98/167
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=21618 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.31  [Playtest] finished armap team 0 at 2.31 min
  2.32  [AIR][State] T1_CONTEST
  2.33  [AIR][Produce] opening.scout armpeep plant=21618 projected=1/1
  2.33  [AIR][Rule] opening.commander.guard builder=17070
  2.43  [AIR][Capacity] own=9/169 usage=8/258 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=9 bank=691 E=181 bank=711 pull=258 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.45  [AIR][Produce] constructor.recovery armca plant=21618 projected=1/3
  2.60  [AIR][Capacity] own=9/140 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=9 bank=701 E=146 bank=516 pull=198 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.66  [AIR][Produce] constructor.recovery armca plant=21618 projected=2/3
  2.66  [AIR][Rule] mex.expand builder=16257
  2.77  [AIR][Capacity] own=9/130 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=709 E=133 bank=95 pull=198 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=50/500
  2.77  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.90  [AIR][Produce] constructor.recovery armca plant=21618 projected=3/3
  2.90  [AIR][Rule] recovery.energy builder=15210
  2.93  [AIR][Capacity] own=3/142 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=50 shortage=169 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=701 E=140 bank=290 pull=54 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=1 committed=84/624
  2.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=319 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +9.3 bank 695/1250, energy +164.0 bank 173/1154, units 20
  3.10  [AIR][Capacity] own=4/148 usage=1/14 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=50 shortage=113 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=683 E=152 bank=68 pull=140 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=65/493
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=263 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.16  [AIR][Produce] opening.screen armfig plant=21618 projected=1/6
  3.17  [AIR][Rule] recovery.energy builder=9889
  3.21  [AIR][Rule] commander.factory.guard builder=17070
  3.27  [AIR][Capacity] own=2/90 usage=4/92 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=66 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=699 E=97 bank=0 pull=268 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=85/554
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.33  [AIR][Layout] cluster=0 labs=1 at=6628,1289
  3.43  [AIR][Capacity] own=2/90 usage=4/80 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=75 shortage=89 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=686 E=90 bank=48 pull=193 plants=1/0 aircraftDemand=3/121
  3.43  [AIR][Projects] energyQueued=0 committed=65/466
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=239 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.54  [Playtest] finished armwin team 0 at 3.54 min
  3.60  [AIR][Capacity] own=2/121 usage=5/148 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=692 E=111 bank=2 pull=267 plants=1/0 aircraftDemand=3/121
  3.60  [AIR][Projects] energyQueued=0 committed=84/549
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.63  [AIR][Produce] opening.screen armfig plant=21618 projected=2/6
  3.63  [AIR][Screen] fighters=1 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=2/147 usage=5/165 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=73 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=684 E=146 bank=0 pull=359 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=59/421
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [AIR][Screen] fighters=1 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.83  [Playtest] finished armwin team 0 at 3.83 min
  3.84  [AIR][Wind] cluster=2 slots=6 at=10760,1648 local=false builder=9889
  3.85  [AIR][Layout] cluster=1 labs=1 at=8932,905
  3.87  [AIR][Layout] cluster=2 labs=1 at=10276,3017
  3.93  [AIR][Capacity] own=2/150 usage=5/162 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=49 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=690 E=152 bank=39 pull=196 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=1 committed=83/525
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [AIR][Screen] fighters=1 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.97  [AIR][Produce] opening.screen armfig plant=21618 projected=3/6
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.3 bank 705/1250, energy +174.3 bank 157/1180, units 25
  4.10  [AIR][Capacity] own=2/165 usage=6/173 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=79 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=694 E=161 bank=2 pull=353 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=67/439
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.14  [Playtest] finished armwin team 0 at 4.14 min
  4.15  [AIR][Screen] fighters=2 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.27  [AIR][Capacity] own=2/129 usage=4/128 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=0 reason=funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=695 E=134 bank=5 pull=263 plants=1/0 aircraftDemand=3/125
  4.27  [AIR][Projects] energyQueued=1 committed=92/549
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.32  [AIR][Screen] fighters=2 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.32  [AIR][Produce] opening.screen armfig plant=21618 projected=4/6
  4.38  [AIR][Layout] cluster=3 labs=1 at=6724,905
  4.43  [AIR][Capacity] own=2/128 usage=6/184 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=86 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=712 E=129 bank=45 pull=301 plants=1/0 aircraftDemand=3/126
  4.43  [AIR][Projects] energyQueued=0 committed=74/457
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.50  [AIR][Screen] fighters=3 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=2/182 usage=6/161 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=84 shortage=116 reason=funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=706 E=167 bank=86 pull=202 plants=1/0 aircraftDemand=3/126
  4.60  [AIR][Projects] energyQueued=0 committed=51/353
  4.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=266 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=67
  4.61  [AIR][Produce] opening.screen armfig plant=21618 projected=5/6
  4.64  [Playtest] finished armwin team 0 at 4.64 min
  4.68  [AIR][Screen] fighters=4 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.77  [AIR][Capacity] own=2/166 usage=6/167 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=713 E=170 bank=4 pull=268 plants=1/0 aircraftDemand=3/124
  4.77  [AIR][Projects] energyQueued=0 committed=65/401
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.85  [AIR][Screen] fighters=4 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.91  [AIR][Produce] opening.screen armfig plant=21618 projected=6/6
  4.93  [AIR][Capacity] own=2/165 usage=4/49 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=81 reason=funded workload
  4.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=713 E=167 bank=333 pull=49 plants=1/0 aircraftDemand=3/125
  4.93  [AIR][Projects] energyQueued=0 committed=37/265
  4.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=231 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.94  [Playtest] finished armwin team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +9.3 bank 706/1250, energy +304.8 bank 121/1182, units 32
  5.00  [Playtest] target team 0 at (8800, 1100) from its start position
  5.00  [Playtest] camera requested (8768,1400) height=2200
  5.01  [Playtest] camera captured name=ta position=(8768,1400) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (8768, 1400)
  5.02  [AIR][Screen] fighters=5 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.10  [AIR][Capacity] own=5/258 usage=8/238 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=147 reason=funded workload
  5.10  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=692 E=234 bank=249 pull=238 plants=1/0 aircraftDemand=3/125
  5.10  [AIR][Projects] energyQueued=0 committed=50/297
  5.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=297 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=204
  5.15  [AIR][Produce] constructor.expand armca plant=21618 projected=4/4
  5.20  [Playtest] finished armwin team 0 at 5.20 min
  5.20  [AIR][Screen] fighters=6 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.26  [Playtest] finished armmex team 0 at 5.26 min
  5.27  [AIR][Capacity] own=9/308 usage=6/84 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=50 idle=50 ecoStatic=0 working=99 shortage=95 reason=funded workload
  5.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=696 E=309 bank=1168 pull=222 plants=1/0 aircraftDemand=3/125
  5.27  [AIR][Projects] energyQueued=0 committed=53/236
  5.27  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=295 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.28  [AIR][Rule] recovery.energy builder=16257
  5.36  [AIR][Commander] cleared factory guard for commander.idle.energy
  5.36  [AIR][Rule] commander.idle.energy builder=17070
  5.36  [AIR][Produce] constructor.expand armca plant=21618 projected=5/5
  5.37  [AIR][Rule] mex.phase.convert builder=8892
  5.37  [AIR][Screen] fighters=6 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.43  [AIR][Capacity] own=10/314 usage=11/34 gifts=0 sent=0 excess=0 pressure=false mobile=200 arriving=50 idle=0 ecoStatic=0 working=449 shortage=320 reason=funded workload
  5.43  [AIR][Economy] T1_CONTEST M=11 bank=710 E=315 bank=1207 pull=97 plants=1/0 aircraftDemand=3/125
  5.43  [AIR][Projects] energyQueued=1 committed=198/1418
  5.43  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=570 floating=false savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.50  [Playtest] finished armwin team 0 at 5.50 min
  5.51  [AIR][Rule] mex.expand builder=15210
  5.53  [AIR][Screen] fighters=6 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.55  [Playtest] finished armsolar team 0 at 5.55 min
  5.57  [AIR][Rule] commander.factory.guard builder=17070
  5.60  [AIR][Capacity] own=11/314 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=200 arriving=50 idle=0 ecoStatic=0 working=99 shortage=237 reason=funded workload
  5.60  [AIR][Economy] T1_CONTEST M=11 bank=626 E=315 bank=1258 pull=169 plants=1/0 aircraftDemand=3/125
  5.60  [AIR][Projects] energyQueued=1 committed=102/1622
  5.60  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=487 floating=false savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=204
  5.70  [AIR][Screen] fighters=6 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.71  [AIR][Produce] constructor.screen armfig plant=21618 projected=7/7
  5.71  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=224 at=8696,1336
  5.71  [AIR][Rule] opening.support builder=14005
  5.76  [Playtest] finished armwin team 0 at 5.76 min
  5.77  [AIR][Capacity] own=11/374 usage=11/417 gifts=0 sent=0 excess=0 pressure=false mobile=250 arriving=0 idle=50 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  5.77  [AIR][Economy] T1_CONTEST M=11 bank=637 E=383 bank=1283 pull=417 plants=1/0 aircraftDemand=3/125
  5.77  [AIR][Projects] energyQueued=0 committed=311/4508
  5.77  [AIR][Workforce] t1=5/5 t2=0/2 targetBP=250 floating=false savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+0/2 available=yes firstSlot=2
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Rule] mex.phase.convert builder=9889
  5.86  [AIR][Produce] recon.replace armpeep plant=21618 projected=1/1
  5.86  [AIR][Commander] cleared factory guard for commander.idle.assist
  5.86  [AIR][Rule] commander.idle.assist builder=17070
  5.88  [AIR][Rule] commander.factory.guard builder=17070
  5.90  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.93  [AIR][Capacity] own=11/409 usage=11/302 gifts=0 sent=0 excess=0 pressure=false mobile=250 arriving=0 idle=0 ecoStatic=0 working=200 shortage=216 reason=funded workload
  5.93  [AIR][Economy] T1_CONTEST M=11 bank=645 E=413 bank=1272 pull=332 plants=1/0 aircraftDemand=3/125
  5.93  [AIR][Projects] energyQueued=0 committed=269/4983
  5.93  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=466 floating=false savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.00  [Playtest] eco team 0 at 6.0 min: metal +11.7 bank 644/1300, energy +413.9 bank 1278/1283, units 41
  6.00  [AIR][Produce] air.control armfig plant=21618 projected=8/8
  6.07  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  6.10  [AIR][Capacity] own=11/410 usage=10/373 gifts=0 sent=0 excess=0 pressure=false mobile=250 arriving=0 idle=0 ecoStatic=0 working=250 shortage=133 reason=funded workload
  6.10  [AIR][Economy] T1_CONTEST M=11 bank=641 E=410 bank=1106 pull=404 plants=1/0 aircraftDemand=3/125
  6.10  [AIR][Projects] energyQueued=0 committed=220/4165
  6.10  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=383 floating=false savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.10  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+1/2 available=yes firstSlot=2
  6.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=185
  6.16  [AIR][Produce] air.control armfig plant=21618 projected=9/9
  6.17  [Playtest] finished armwin team 0 at 6.17 min
  6.19  [AIR][Rule] storage.buffer builder=16257
  6.23  [AIR][Screen] fighters=8 cells=8 centre=8641,2135 width=1200 advance=1028 responding=false
  6.27  [AIR][Capacity] own=11/409 usage=10/442 gifts=0 sent=0 excess=0 pressure=false mobile=250 arriving=0 idle=0 ecoStatic=0 working=200 shortage=0 reason=no funded workload
  6.27  [AIR][Economy] T1_CONTEST M=11 bank=637 E=410 bank=1124 pull=473 plants=1/0 aircraftDemand=3/126
  6.27  [AIR][Projects] energyQueued=0 committed=349/4957
  6.27  [AIR][Workforce] t1=5/5 t2=0/2 targetBP=250 floating=false savingLab=false
  6.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.27  [AIR][Bay] 0 plant=21618 BP=150 nanos=0+1/2 available=yes firstSlot=2
  6.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 1856 more
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
  0.64  RESERVE: zone 1 at (8648, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8648, 1080) facing 0 (id 1)
  0.64  RESERVE: zone 2 at (8696, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8696, 1080) facing 0 (id 2)
  0.64  RESERVE: zone 3 at (8744, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8744, 1080) facing 0 (id 3)
  0.64  RESERVE: zone 4 at (8648, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8648, 1128) facing 0 (id 4)
  0.64  RESERVE: zone 5 at (8696, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8696, 1128) facing 0 (id 5)
  0.64  RESERVE: zone 6 at (8744, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.64  RESERVE: armwin at (8744, 1128) facing 0 (id 6)
  0.64  RESERVE: served armwin at (8648, 1080) facing 0 (id 1, 5 of this def still held)
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
  0.81  RESERVE: served armwin at (8696, 1080) facing 0 (id 2, 4 of this def still held)
  0.87  RESERVE: served armwin at (6872, 14360) facing 2 (id 2, 4 of this def still held)
  0.92  RESERVE: served armwin at (8744, 1080) facing 0 (id 3, 3 of this def still held)
  1.04  RESERVE: served armwin at (8648, 1128) facing 0 (id 4, 2 of this def still held)
  1.04  RESERVE: served armwin at (6824, 14360) facing 2 (id 3, 3 of this def still held)
  1.16  RESERVE: served armwin at (8696, 1128) facing 0 (id 5, 1 of this def still held)
  1.16  RESERVE: served armwin at (6920, 14312) facing 2 (id 4, 2 of this def still held)
  1.29  RESERVE: served armwin at (6872, 14312) facing 2 (id 5, 1 of this def still held)
  1.32  RESERVE: served armwin at (8744, 1128) facing 0 (id 6, 0 of this def still held)
  1.39  RESERVE: served armwin at (6824, 14312) facing 2 (id 6, 0 of this def still held)
  1.44  RESERVE: zone 7 at (9048, 1096) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (9048, 1096) facing 0 (id 7)
  1.44  RESERVE: zone 7 released
  1.44  RESERVE: zone 8 at (9048, 1176) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (9048, 1176) facing 0 (id 8)
  1.44  RESERVE: zone 8 released
  1.44  RESERVE: zone 9 at (9016, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (9016, 1240) facing 0 (id 9)
  1.44  RESERVE: zone 10 at (9064, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (9064, 1240) facing 0 (id 10)
  1.44  RESERVE: zone 9 released
  1.44  RESERVE: zone 10 released
  1.44  RESERVE: zone 11 at (8968, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (8968, 1304) facing 0 (id 11)
  1.44  RESERVE: zone 12 at (9016, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (9016, 1304) facing 0 (id 12)
  1.44  RESERVE: zone 13 at (9064, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (9064, 1304) facing 0 (id 13)
  1.44  RESERVE: zone 14 at (8968, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (8968, 1352) facing 0 (id 14)
  1.44  RESERVE: zone 15 at (9016, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (9016, 1352) facing 0 (id 15)
  1.44  RESERVE: zone 16 at (9064, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.44  RESERVE: armwin at (9064, 1352) facing 0 (id 16)
  1.44  EXP: approach: armcom(17070) at (8721, 1223) walks to (8839, 1262), 136 from the armwin site (8968, 1304)
  1.44  RESERVE: served armwin at (8968, 1304) facing 0 (id 11, 5 of this def still held)
  1.54  RESERVE: zone 7 at (6584, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6584, 14344) facing 2 (id 7)
  1.54  RESERVE: zone 8 at (6536, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6536, 14344) facing 2 (id 8)
  1.54  RESERVE: zone 9 at (6488, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6488, 14344) facing 2 (id 9)
  1.54  RESERVE: zone 10 at (6584, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6584, 14296) facing 2 (id 10)
  1.54  RESERVE: zone 11 at (6536, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6536, 14296) facing 2 (id 11)
  1.54  RESERVE: zone 12 at (6488, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6488, 14296) facing 2 (id 12)
  1.54  EXP: approach: armcom(1901) at (6768, 14232) walks to (6700, 14273), 136 from the armwin site (6584, 14344)
  1.55  RESERVE: served armwin at (6584, 14344) facing 2 (id 7, 5 of this def still held)
  1.60  EXP: approach: armcom(17070) at (8807, 1249) walks to (8881, 1323), 136 from the armwin site (9016, 1304)
  1.60  RESERVE: served armwin at (9016, 1304) facing 0 (id 12, 4 of this def still held)
  1.69  EXP: approach: armcom(1901) at (6723, 14254) walks to (6659, 14285), 136 from the armwin site (6536, 14344)
  1.70  RESERVE: served armwin at (6536, 14344) facing 2 (id 8, 4 of this def still held)
  1.76  RESERVE: served armwin at (8968, 1352) facing 0 (id 14, 3 of this def still held)
  1.83  RESERVE: armap at (6752, 14376) facing 1 (id 13)
  1.83  RESERVE: served armap at (6752, 14376) facing 1 (id 13, 0 of this def still held)
  1.83  RESERVE: zone 13 at (6352, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.83  RESERVE: armafus at (6352, 13872) facing 2 (id 14)
  1.83  RESERVE: zone 13 released
  1.83  RESERVE: zone 14 at (6224, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.83  RESERVE: armafus at (6224, 13872) facing 2 (id 15)
  1.83  RESERVE: zone 14 released
  1.83  RESERVE: zone 15 at (6096, 13872) facing 2, 6x6 cells: 36 of 36 held
  1.83  RESERVE: armafus at (6096, 13872) facing 2 (id 16)
  1.83  RESERVE: zone 15 released
  1.99  RESERVE: armap at (8768, 1400) facing 1 (id 17)
  1.99  RESERVE: served armap at (8768, 1400) facing 1 (id 17, 0 of this def still held)
  2.00  RESERVE: zone 17 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  2.00  RESERVE: armafus at (7024, 1376) facing 0 (id 18)
  2.00  RESERVE: zone 17 released
  2.00  RESERVE: zone 18 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
  2.00  RESERVE: armafus at (10608, 1760) facing 0 (id 19)
  2.00  RESERVE: zone 18 released
  2.00  RESERVE: zone 19 at (6896, 1376) facing 0, 6x6 cells: 36 of 36 held
  2.00  RESERVE: armafus at (6896, 1376) facing 0 (id 20)
  2.00  RESERVE: zone 19 released
  2.00  RESERVE: zone 20 at (10736, 1760) facing 0, 6x6 cells: 36 of 36 held
  2.00  RESERVE: armafus at (10736, 1760) facing 0 (id 21)
  2.00  RESERVE: zone 20 released
  2.00  RESERVE: zone 21 at (6640, 1120) facing 0, 6x6 cells: 36 of 36 held
  2.00  RESERVE: armafus at (6640, 1120) facing 0 (id 22)
  2.00  RESERVE: zone 21 released
  2.00  RESERVE: zone 22 at (6640, 1248) facing 0, 6x6 cells: 36 of 36 held
  2.00  RESERVE: armafus at (6640, 1248) facing 0 (id 23)
  2.00  RESERVE: zone 22 released
  2.00  RESERVE: zone 23 at (8048, 2400) facing 0, 6x6 cells: 36 of 36 held
```
