# Playtest report: PASS

- Verdict: **PASS** (reached 45 min)
- Game time reached: 45.0 min (frame 81081); wall 242 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:41:24
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\caldera\runs\20261003T184529Z-4950273e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\caldera\runs\20261003T184529Z-4950273e\screen_2026-10-03_18-42-27-524.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\caldera\runs\20261003T184529Z-4950273e\screen_2026-10-03_18-43-07-361.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\caldera\runs\20261003T184529Z-4950273e\screen_2026-10-03_18-43-25-448.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\caldera\runs\20261003T184529Z-4950273e\screen_2026-10-03_18-44-07-196.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\caldera\runs\20261003T184529Z-4950273e\screen_2026-10-03_18-44-58-427.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 45.5 min
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
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1019 E=30 bank=479 pull=89 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=16/169
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.63  [Playtest] finished armmex team 0 at 0.63 min
  0.65  [AIR][Wind] cluster=0 slots=6 at=8696,1104 local=true builder=17070
  0.65  [AIR][Rule] opening.energy builder=17070
  0.77  [AIR][Capacity] own=6/30 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1057 E=30 bank=395 pull=41 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=10/44
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.79  [Playtest] finished armwin team 0 at 0.79 min
  0.90  [Playtest] finished armwin team 0 at 0.90 min
  0.93  [AIR][Capacity] own=9/30 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=9 bank=1093 E=30 bank=540 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=32/143
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +9.3 bank 1101/1150, energy +61.3 bank 624/1001, units 7
  1.01  [Playtest] finished armwin team 0 at 1.01 min
  1.10  [AIR][Capacity] own=9/61 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=9 bank=1119 E=59 bank=831 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=6/28
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.11  [Playtest] finished armwin team 0 at 1.11 min
  1.22  [Playtest] finished armwin team 0 at 1.22 min
  1.27  [AIR][Capacity] own=9/72 usage=3/25 gifts=0 sent=0 excess=5 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=74 bank=994 pull=25 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=29/126
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.33  [Playtest] finished armwin team 0 at 1.33 min
  1.34  [AIR][Wind] cluster=1 slots=6 at=9016,1328 local=false builder=17070
  1.43  [AIR][Capacity] own=9/83 usage=0/9 gifts=0 sent=0 excess=9 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=87 bank=1003 pull=9 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=36/159
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.51  [Playtest] finished armwin team 0 at 1.51 min
  1.60  [AIR][Capacity] own=9/76 usage=0/9 gifts=0 sent=0 excess=9 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=79 bank=1003 pull=9 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=36/159
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.68  [Playtest] finished armwin team 0 at 1.68 min
  1.77  [AIR][Capacity] own=9/65 usage=7/41 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=67 bank=1004 pull=41 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=21/95
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.81  [Playtest] finished armwin team 0 at 1.81 min
  1.93  [AIR][Capacity] own=9/71 usage=0/9 gifts=0 sent=0 excess=9 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=71 bank=1004 pull=9 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=1 committed=40/175
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 1150/1150, energy +200.8 bank 1004/1004, units 13
  2.10  [Playtest] finished armwin team 0 at 2.10 min
  2.10  [AIR][Capacity] own=9/125 usage=7/41 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=126 bank=994 pull=41 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.11  [AIR][Starter] nearby distance=127
  2.11  [AIR][Rule] opening.plant builder=17070
  2.27  [AIR][Capacity] own=9/129 usage=17/39 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=9 bank=1141 E=132 bank=1005 pull=39 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=597/1011
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=15210 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Capacity] own=9/129 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] BOOTSTRAP M=9 bank=876 E=133 bank=1005 pull=69 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=239/405
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=15210 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.54  [Playtest] finished armap team 0 at 2.54 min
  2.55  [AIR][State] T1_CONTEST
  2.56  [AIR][Produce] opening.scout armpeep plant=15210 projected=1/1
  2.56  [AIR][Rule] opening.commander.guard builder=17070
  2.60  [AIR][Capacity] own=9/205 usage=5/180 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=9 bank=687 E=185 bank=1002 pull=180 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=15210 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.69  [AIR][Produce] constructor.recovery armca plant=15210 projected=1/3
  2.77  [AIR][Capacity] own=9/211 usage=2/63 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=9 bank=708 E=212 bank=1086 pull=198 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=15210 BP=150 nanos=0+0/1 available=yes firstSlot=0
  2.91  [AIR][Produce] constructor.recovery armca plant=15210 projected=2/3
  2.91  [AIR][Rule] mex.expand builder=9889
  2.93  [AIR][Capacity] own=9/214 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST M=9 bank=718 E=213 bank=1127 pull=9 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=50/500
  2.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=15210 BP=150 nanos=0+0/1 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +9.3 bank 724/1250, energy +234.4 bank 1119/1130, units 18
  3.10  [AIR][Capacity] own=9/231 usage=1/21 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=49 shortage=134 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST M=9 bank=723 E=225 bank=1102 pull=210 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=47/474
  3.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=234 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=15210 BP=150 nanos=0+0/1 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.13  [AIR][Produce] constructor.recovery armca plant=15210 projected=3/3
  3.13  [AIR][Rule] mex.assist builder=14746
  3.27  [AIR][Capacity] own=9/234 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=50 shortage=1 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST M=9 bank=724 E=234 bank=1155 pull=186 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=33/335
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=151 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=15210 BP=150 nanos=0+0/1 available=yes firstSlot=0
  3.35  [AIR][Produce] opening.screen armfig plant=15210 projected=1/6
  3.36  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=77 at=8840,1336
  3.36  [AIR][Rule] opening.support builder=28329
  3.43  [AIR][Capacity] own=9/239 usage=12/409 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST M=9 bank=709 E=239 bank=787 pull=439 plants=1/0 aircraftDemand=3/121
  3.43  [AIR][Projects] energyQueued=0 committed=229/3166
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=15210 BP=150 nanos=0+1/2 available=yes firstSlot=2
  3.44  [AIR][Commander] cleared factory guard for opening.support.assist
  3.44  [AIR][Rule] opening.support.assist builder=17070
  3.45  [AIR][Layout] cluster=0 labs=1 at=6628,1289
  3.48  [Playtest] finished armmex team 0 at 3.48 min
  3.49  [AIR][Rule] opening.support.assist builder=14746
  3.50  [AIR][Rule] opening.support.assist builder=9889
  3.60  [AIR][Capacity] own=4/243 usage=1/72 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=318 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=620 E=243 bank=64 pull=306 plants=1/0 aircraftDemand=3/121
  3.60  [AIR][Projects] energyQueued=0 committed=92/1283
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=15210 BP=150 nanos=0+1/0 available=yes firstSlot=2
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.70  [Playtest] finished armnanotc team 0 at 3.70 min
  3.71  [AIR][Rule] recovery.energy builder=28329
  3.72  [AIR][Rule] recovery.energy builder=14746
  3.72  [AIR][Wind] cluster=2 slots=6 at=10760,1648 local=false builder=9889
  3.72  [AIR][Rule] recovery.energy builder=9889
  3.73  [AIR][Rule] commander.factory.guard builder=17070
  3.77  [AIR][Capacity] own=4/242 usage=7/287 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=49 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=587 E=242 bank=522 pull=287 plants=1/0 aircraftDemand=6/276
  3.77  [AIR][Projects] energyQueued=1 committed=117/514
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/0 available=yes firstSlot=3
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Produce] opening.screen armfig plant=15210 projected=2/6
  3.77  [AIR][Screen] fighters=1 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.80  [AIR][Support] return to production bay=0
  3.93  [AIR][Capacity] own=4/224 usage=7/209 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=85 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=583 E=230 bank=65 pull=350 plants=1/0 aircraftDemand=9/290
  3.93  [AIR][Projects] energyQueued=1 committed=85/372
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=235 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/0 available=yes firstSlot=3
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.95  [AIR][Screen] fighters=1 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  3.97  [AIR][Layout] cluster=1 labs=1 at=8932,905
  3.98  [AIR][Produce] opening.screen armfig plant=15210 projected=3/6
  3.98  [AIR][Layout] cluster=2 labs=1 at=10276,3017
  3.98  [AIR][Support] return to production bay=0
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.7 bank 595/1300, energy +215.5 bank 165/1180, units 27
  4.10  [AIR][Capacity] own=4/214 usage=9/234 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=124 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=577 E=214 bank=0 pull=318 plants=1/0 aircraftDemand=8/286
  4.10  [AIR][Projects] energyQueued=0 committed=48/214
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=72
  4.12  [AIR][Screen] fighters=2 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.19  [Playtest] finished armwin team 0 at 4.19 min
  4.21  [AIR][Produce] opening.screen armfig plant=15210 projected=4/6
  4.21  [AIR][Wind] cluster=3 slots=6 at=9016,832 local=false builder=17070
  4.21  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.21  [AIR][Rule] commander.idle.energy builder=17070
  4.25  [Playtest] finished armwin team 0 at 4.25 min
  4.27  [AIR][Capacity] own=4/222 usage=7/205 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=50 shortage=0 reason=available or arriving power
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=575 E=217 bank=556 pull=205 plants=1/0 aircraftDemand=8/288
  4.27  [AIR][Projects] energyQueued=2 committed=100/438
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.28  [AIR][Screen] fighters=3 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.33  [AIR][Layout] cluster=3 labs=1 at=6724,905
  4.43  [AIR][Produce] opening.screen armfig plant=15210 projected=5/6
  4.43  [AIR][Capacity] own=11/239 usage=16/340 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=370 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=594 E=251 bank=295 pull=340 plants=1/0 aircraftDemand=8/286
  4.43  [AIR][Projects] energyQueued=1 committed=100/439
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [Playtest] finished armwin team 0 at 4.45 min
  4.47  [AIR][Screen] fighters=4 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.47  [AIR][Rule] commander.energy.local builder=17070
  4.54  [Playtest] finished armwin team 0 at 4.54 min
  4.60  [AIR][Capacity] own=11/229 usage=18/351 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=588 E=239 bank=140 pull=351 plants=1/0 aircraftDemand=8/284
  4.60  [AIR][Projects] energyQueued=0 committed=115/505
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=215
  4.63  [AIR][Screen] fighters=4 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.64  [Playtest] finished armwin team 0 at 4.64 min
  4.65  [AIR][Produce] opening.screen armfig plant=15210 projected=6/6
  4.76  [Playtest] finished armwin team 0 at 4.76 min
  4.77  [AIR][Capacity] own=11/171 usage=12/126 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=64 reason=funded workload
  4.77  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=570 E=181 bank=158 pull=126 plants=1/0 aircraftDemand=8/286
  4.77  [AIR][Projects] energyQueued=0 committed=60/263
  4.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=214 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.80  [AIR][Screen] fighters=5 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.92  [Playtest] finished armsolar team 0 at 4.92 min
  4.93  [AIR][Capacity] own=11/178 usage=27/279 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=466 E=181 bank=680 pull=279 plants=1/0 aircraftDemand=8/286
  4.93  [AIR][Projects] energyQueued=0 committed=22/99
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Rule] commander.factory.guard builder=17070
  4.96  [Playtest] finished armwin team 0 at 4.96 min
  4.97  [AIR][Screen] fighters=5 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  4.98  [AIR][Produce] intercept armfig plant=15210 projected=7/7
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.7 bank 473/1300, energy +328.5 bank 798/1233, units 38
  5.00  [Playtest] target team 0 at (8800, 1100) from its start position
  5.00  [Playtest] camera requested (8816,1240) height=2200
  5.01  [Playtest] camera captured name=ta position=(8816,1240) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (8816, 1240)
  5.05  [Playtest] finished armwin team 0 at 5.05 min
  5.06  [AIR][Rule] mex.expand builder=14746
  5.10  [Playtest] finished armwin team 0 at 5.10 min
  5.10  [AIR][Capacity] own=11/262 usage=13/467 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=49 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=11 bank=464 E=241 bank=192 pull=467 plants=1/0 aircraftDemand=8/286
  5.10  [AIR][Projects] energyQueued=0 committed=81/636
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/2 available=yes firstSlot=3
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=194
  5.11  [AIR][Rule] energy.grow builder=9889
  5.13  [AIR][Commander] cleared factory guard for commander.idle.energy
  5.13  [AIR][Rule] commander.idle.energy builder=17070
  5.17  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.18  [AIR][Produce] constructor.expand armca plant=15210 projected=4/4
  5.27  [AIR][Capacity] own=11/358 usage=5/33 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=50 idle=0 ecoStatic=0 working=349 shortage=166 reason=funded workload
  5.27  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=527 E=344 bank=1228 pull=180 plants=1/0 aircraftDemand=8/286
  5.27  [AIR][Projects] energyQueued=0 committed=137/883
  5.27  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=366 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/0 available=yes firstSlot=3
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.33  [Playtest] finished armwin team 0 at 5.33 min
  5.33  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.34  [AIR][Rule] commander.factory.guard builder=17070
  5.43  [AIR][Capacity] own=11/344 usage=1/1 gifts=0 sent=0 excess=0 pressure=false mobile=200 arriving=0 idle=50 ecoStatic=0 working=99 shortage=195 reason=funded workload
  5.43  [AIR][Economy] T1_CONTEST M=11 bank=507 E=381 bank=1235 pull=169 plants=1/0 aircraftDemand=8/286
  5.43  [AIR][Projects] energyQueued=0 committed=82/639
  5.43  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=395 floating=false savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/2 available=yes firstSlot=3
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.44  [AIR][Commander] cleared factory guard for commander.idle.energy
  5.44  [AIR][Rule] commander.idle.energy builder=17070
  5.44  [AIR][Produce] constructor.expand armca plant=15210 projected=5/5
  5.45  [AIR][Rule] mex.assist builder=2895
  5.50  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.52  [Playtest] finished armwin team 0 at 5.52 min
  5.53  [AIR][Rule] storage.buffer builder=28329
  5.60  [AIR][Capacity] own=11/283 usage=10/64 gifts=0 sent=0 excess=0 pressure=false mobile=200 arriving=50 idle=0 ecoStatic=0 working=403 shortage=8 reason=funded workload
  5.60  [AIR][Economy] T1_CONTEST M=11 bank=507 E=296 bank=1214 pull=211 plants=1/0 aircraftDemand=8/286
  5.60  [AIR][Projects] energyQueued=0 committed=241/2212
  5.60  [AIR][Workforce] t1=5/5 t2=0/2 targetBP=258 floating=false savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+0/2 available=yes firstSlot=3
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=176
  5.65  [Playtest] finished armwin team 0 at 5.65 min
  5.66  [AIR][Rule] commander.factory.guard builder=17070
  5.67  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.69  [AIR][Produce] recon.replace armpeep plant=15210 projected=1/1
  5.69  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=227 at=8792,1336
  5.69  [AIR][Rule] opening.support builder=28176
  5.76  [AIR][Commander] cleared factory guard for opening.support.assist
  5.76  [AIR][Rule] opening.support.assist builder=17070
  5.77  [AIR][Capacity] own=11/332 usage=4/147 gifts=0 sent=0 excess=0 pressure=false mobile=250 arriving=0 idle=0 ecoStatic=0 working=419 shortage=195 reason=funded workload
  5.77  [AIR][Economy] T1_CONTEST M=11 bank=485 E=311 bank=1286 pull=280 plants=1/0 aircraftDemand=8/286
  5.77  [AIR][Projects] energyQueued=0 committed=390/4724
  5.77  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=445 floating=false savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+1/2 available=yes firstSlot=3
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.80  [Playtest] finished armwin team 0 at 5.80 min
  5.81  [Playtest] finished armmex team 0 at 5.81 min
  5.82  [AIR][Rule] opening.support.assist builder=14746
  5.83  [AIR][Rule] energy.grow builder=2895
  5.83  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
  5.85  [AIR][Produce] air.control armfig plant=15210 projected=8/8
  5.93  [AIR][Capacity] own=11/489 usage=9/325 gifts=0 sent=0 excess=0 pressure=false mobile=250 arriving=0 idle=0 ecoStatic=0 working=400 shortage=89 reason=funded workload
  5.93  [AIR][Economy] T1_CONTEST M=11 bank=370 E=475 bank=1243 pull=537 plants=1/0 aircraftDemand=8/288
  5.93  [AIR][Projects] energyQueued=2 committed=396/2400
  5.93  [AIR][Workforce] t1=5/6 t2=0/2 targetBP=339 floating=false savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=15210 BP=350 nanos=1+1/2 available=yes firstSlot=3
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.99  [Playtest] finished armnanotc team 0 at 5.99 min
  6.00  [AIR][Screen] fighters=7 cells=8 centre=8746,1515 width=600 advance=400 responding=false
... 4510 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(17070) at (8813, 1121) walks to (8827, 1146), 136 from the armmex site (8896, 1264)
  0.08  EXP: approach: armcom(1901) at (6600, 14247) walks to (6591, 14272), 136 from the armmex site (6544, 14400)
  0.11  EXP: idle: armcom(1901) on armmex at (6595, 14262), site (6544, 14400), target yes, fails 2 (arrived at the approach point)
  0.21  EXP: approach: armcom(17070) at (8820, 1133) walks to (8908, 1052), 136 from the armmex site (9008, 960)
  0.21  EXP: approach: armcom(1901) at (6595, 14263) walks to (6472, 14119), 136 from the armmex site (6384, 14016)
  0.40  EXP: approach: armcom(17070) at (8890, 1079) walks to (8647, 1116), 136 from the armmex site (8512, 1136)
  0.43  EXP: approach: armcom(1901) at (6492, 14144) walks to (6872, 14351), 136 from the armmex site (6992, 14416)
  0.65  RESERVE: zone 1 at (8648, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (8648, 1080) facing 0 (id 1)
  0.65  RESERVE: zone 2 at (8696, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (8696, 1080) facing 0 (id 2)
  0.65  RESERVE: zone 3 at (8744, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (8744, 1080) facing 0 (id 3)
  0.65  RESERVE: zone 4 at (8648, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (8648, 1128) facing 0 (id 4)
  0.65  RESERVE: zone 5 at (8696, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (8696, 1128) facing 0 (id 5)
  0.65  RESERVE: zone 6 at (8744, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (8744, 1128) facing 0 (id 6)
  0.65  RESERVE: served armwin at (8648, 1080) facing 0 (id 1, 5 of this def still held)
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
  0.80  RESERVE: served armwin at (8696, 1080) facing 0 (id 2, 4 of this def still held)
  0.87  RESERVE: served armwin at (6888, 14360) facing 2 (id 2, 4 of this def still held)
  0.91  RESERVE: served armwin at (8744, 1080) facing 0 (id 3, 3 of this def still held)
  1.02  RESERVE: served armwin at (8648, 1128) facing 0 (id 4, 2 of this def still held)
  1.03  RESERVE: served armwin at (6840, 14360) facing 2 (id 3, 3 of this def still held)
  1.12  RESERVE: served armwin at (8696, 1128) facing 0 (id 5, 1 of this def still held)
  1.14  RESERVE: served armwin at (6936, 14312) facing 2 (id 4, 2 of this def still held)
  1.24  RESERVE: served armwin at (8744, 1128) facing 0 (id 6, 0 of this def still held)
  1.25  RESERVE: served armwin at (6888, 14312) facing 2 (id 5, 1 of this def still held)
  1.34  RESERVE: zone 7 at (9048, 1096) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (9048, 1096) facing 0 (id 7)
  1.34  RESERVE: zone 7 released
  1.34  RESERVE: zone 8 at (9048, 1176) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (9048, 1176) facing 0 (id 8)
  1.34  RESERVE: zone 8 released
  1.34  RESERVE: zone 9 at (9016, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (9016, 1240) facing 0 (id 9)
  1.34  RESERVE: zone 10 at (9064, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (9064, 1240) facing 0 (id 10)
  1.34  RESERVE: zone 9 released
  1.34  RESERVE: zone 10 released
  1.34  RESERVE: zone 11 at (8968, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (8968, 1304) facing 0 (id 11)
  1.34  RESERVE: zone 12 at (9016, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (9016, 1304) facing 0 (id 12)
  1.34  RESERVE: zone 13 at (9064, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (9064, 1304) facing 0 (id 13)
  1.34  RESERVE: zone 14 at (8968, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (8968, 1352) facing 0 (id 14)
  1.34  RESERVE: zone 15 at (9016, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (9016, 1352) facing 0 (id 15)
  1.34  RESERVE: zone 16 at (9064, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.34  RESERVE: armwin at (9064, 1352) facing 0 (id 16)
  1.34  RESERVE: served armwin at (8968, 1304) facing 0 (id 11, 5 of this def still held)
  1.36  RESERVE: served armwin at (6840, 14312) facing 2 (id 6, 0 of this def still held)
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
  1.52  EXP: approach: armcom(1901) at (6747, 14283) walks to (6711, 14296), 136 from the armwin site (6584, 14344)
  1.52  RESERVE: served armwin at (6584, 14344) facing 2 (id 8, 5 of this def still held)
  1.52  EXP: approach: armcom(17070) at (8814, 1229) walks to (8880, 1309), 136 from the armwin site (9016, 1304)
  1.53  RESERVE: served armwin at (9016, 1304) facing 0 (id 12, 4 of this def still held)
  1.64  EXP: approach: armcom(1901) at (6740, 14281) walks to (6666, 14304), 136 from the armwin site (6536, 14344)
  1.64  RESERVE: served armwin at (6536, 14344) facing 2 (id 9, 4 of this def still held)
  1.69  EXP: approach: armcom(17070) at (8878, 1213) walks to (8942, 1244), 136 from the armwin site (9064, 1304)
  1.70  RESERVE: served armwin at (9064, 1304) facing 0 (id 13, 3 of this def still held)
  1.78  RESERVE: served armwin at (6584, 14296) facing 2 (id 11, 3 of this def still held)
  1.83  RESERVE: served armwin at (8968, 1352) facing 0 (id 14, 2 of this def still held)
  1.89  EXP: approach: armcom(1901) at (6687, 14299) walks to (6621, 14314), 136 from the armwin site (6488, 14344)
  1.90  RESERVE: served armwin at (6488, 14344) facing 2 (id 10, 2 of this def still held)
  2.05  RESERVE: served armwin at (6536, 14296) facing 2 (id 12, 1 of this def still held)
  2.11  RESERVE: armap at (8816, 1240) facing 1 (id 17)
  2.11  RESERVE: served armap at (8816, 1240) facing 1 (id 17, 0 of this def still held)
  2.12  RESERVE: zone 17 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  2.12  RESERVE: armafus at (7024, 1376) facing 0 (id 18)
  2.12  RESERVE: zone 17 released
  2.12  RESERVE: zone 18 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
  2.12  RESERVE: armafus at (10608, 1760) facing 0 (id 19)
  2.12  RESERVE: zone 18 released
  2.12  RESERVE: zone 19 at (6896, 1376) facing 0, 6x6 cells: 36 of 36 held
  2.12  RESERVE: armafus at (6896, 1376) facing 0 (id 20)
  2.12  RESERVE: zone 19 released
  2.12  RESERVE: zone 20 at (10736, 1760) facing 0, 6x6 cells: 36 of 36 held
  2.12  RESERVE: armafus at (10736, 1760) facing 0 (id 21)
  2.12  RESERVE: zone 20 released
  2.12  RESERVE: zone 21 at (6640, 1120) facing 0, 6x6 cells: 36 of 36 held
  2.12  RESERVE: armafus at (6640, 1120) facing 0 (id 22)
  2.12  RESERVE: zone 21 released
  2.12  RESERVE: zone 22 at (6640, 1248) facing 0, 6x6 cells: 36 of 36 held
  2.12  RESERVE: armafus at (6640, 1248) facing 0 (id 23)
  2.12  RESERVE: zone 22 released
  2.12  RESERVE: zone 23 at (8048, 2400) facing 0, 6x6 cells: 36 of 36 held
  2.12  RESERVE: armafus at (8048, 2400) facing 0 (id 24)
  2.12  RESERVE: zone 23 released
  2.15  RESERVE: armap at (6768, 14312) facing 1 (id 14)
```
