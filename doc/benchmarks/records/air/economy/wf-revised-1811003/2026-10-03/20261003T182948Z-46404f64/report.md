# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54065); wall 220 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:26:06
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\caldera\runs\20261003T182948Z-46404f64\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=959 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\caldera\runs\20261003T182948Z-46404f64\screen_2026-10-03_18-27-13-859.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\caldera\runs\20261003T182948Z-46404f64\screen_2026-10-03_18-28-19-855.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\caldera\runs\20261003T182948Z-46404f64\screen_2026-10-03_18-28-48-641.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811003\cohort\20261003T172752Z-670b04a4\caldera\runs\20261003T182948Z-46404f64\screen_2026-10-03_18-29-47-566.png

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
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=959 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (8802, 1114), 14 from the start
  0.21  [Playtest] finished legmex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 21190 at 8896,1264
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|8814|1123|0|4|1|8896|1264
  0.23  [AIR][Rule] opening.mex builder=28186
  0.27  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=976 E=21 bank=806 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.40  [Playtest] finished legmex team 0 at 0.40 min
  0.43  [AIR][Capacity] own=4/30 usage=2/27 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=4 bank=972 E=30 bank=571 pull=27 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=6/30 usage=7/85 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1025 E=30 bank=590 pull=85 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=26/263
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.65  [Playtest] finished legmex team 0 at 0.65 min
  0.67  [AIR][Wind] cluster=0 slots=6 at=8712,1104 local=true builder=28186
  0.67  [AIR][Rule] opening.energy builder=28186
  0.77  [AIR][Capacity] own=6/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1066 E=30 bank=477 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=27/113
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.83  [Playtest] finished legwin team 0 at 0.83 min
  0.93  [AIR][Capacity] own=9/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=9 bank=1097 E=30 bank=479 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=8/35
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.95  [Playtest] finished legwin team 0 at 0.95 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +9.3 bank 1119/1150, energy +50.8 bank 564/1001, units 7
  1.08  [Playtest] finished legwin team 0 at 1.08 min
  1.10  [AIR][Capacity] own=9/39 usage=4/27 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=9 bank=1130 E=38 bank=649 pull=27 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=1 committed=43/175
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.21  [Playtest] finished legwin team 0 at 1.21 min
  1.27  [AIR][Capacity] own=9/58 usage=3/24 gifts=0 sent=0 excess=5 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=59 bank=994 pull=24 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=31/129
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.34  [Playtest] finished legwin team 0 at 1.34 min
  1.43  [AIR][Capacity] own=9/62 usage=7/40 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=65 bank=1002 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=8/35
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.45  [Playtest] finished legwin team 0 at 1.45 min
  1.47  [AIR][Wind] cluster=1 slots=6 at=9016,1328 local=false builder=28186
  1.60  [AIR][Capacity] own=9/61 usage=7/40 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=65 bank=1003 pull=40 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=12/51
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.63  [Playtest] finished legwin team 0 at 1.63 min
  1.77  [AIR][Capacity] own=9/60 usage=7/40 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=63 bank=1003 pull=40 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=8/35
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.79  [Playtest] finished legwin team 0 at 1.79 min
  1.92  [Playtest] finished legwin team 0 at 1.92 min
  1.93  [AIR][Capacity] own=9/66 usage=7/40 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=65 bank=1004 pull=40 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 1150/1150, energy +193.1 bank 1004/1004, units 13
  2.10  [AIR][Capacity] own=9/109 usage=0/9 gifts=0 sent=0 excess=9 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=105 bank=1004 pull=9 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=35/144
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.18  [Playtest] finished legwin team 0 at 2.18 min
  2.19  [AIR][Starter] nearby distance=128
  2.19  [AIR][Rule] opening.plant builder=28186
  2.27  [AIR][Capacity] own=9/137 usage=20/60 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=9 bank=1128 E=148 bank=989 pull=60 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=363/931
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=3968 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Capacity] own=9/196 usage=20/60 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] BOOTSTRAP M=9 bank=1018 E=192 bank=989 pull=60 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=161/413
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=3968 BP=0 nanos=0+0/1 available=yes firstSlot=0
  2.57  [Playtest] finished legap team 0 at 2.57 min
  2.57  [AIR][State] T1_CONTEST
  2.58  [AIR][Produce] opening.scout legfig plant=3968 projected=1/1
  2.58  [AIR][Rule] opening.commander.guard builder=28186
  2.60  [AIR][Capacity] own=9/222 usage=0/29 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=9 bank=929 E=215 bank=1105 pull=29 plants=1/0 aircraftDemand=2/115
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/1 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.67  [AIR][Produce] constructor.recovery legca plant=3968 projected=1/3
  2.67  [AIR][Scout] opening drone=9829 enemy starts=1
  2.77  [AIR][Capacity] own=9/229 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=9 bank=945 E=229 bank=865 pull=206 plants=1/0 aircraftDemand=2/115
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=45 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/1 available=yes firstSlot=0
  2.88  [AIR][Produce] constructor.recovery legca plant=3968 projected=2/3
  2.88  [AIR][Rule] mex.expand builder=16924
  2.93  [AIR][Capacity] own=9/184 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=45 arriving=45 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST M=9 bank=968 E=197 bank=1130 pull=145 plants=1/0 aircraftDemand=2/115
  2.93  [AIR][Projects] energyQueued=0 committed=50/500
  2.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=90 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/1 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +9.3 bank 971/1250, energy +162.9 bank 978/1130, units 18
  3.10  [AIR][Capacity] own=9/148 usage=4/95 gifts=0 sent=0 excess=0 pressure=true mobile=90 arriving=0 idle=45 ecoStatic=0 working=45 shortage=182 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST M=9 bank=969 E=155 bank=688 pull=218 plants=1/0 aircraftDemand=2/115
  3.10  [AIR][Projects] energyQueued=0 committed=44/448
  3.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=272 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.11  [AIR][Produce] constructor.recovery legca plant=3968 projected=3/3
  3.11  [AIR][Rule] mex.assist builder=7882
  3.27  [AIR][Capacity] own=9/119 usage=1/20 gifts=0 sent=0 excess=0 pressure=true mobile=90 arriving=45 idle=0 ecoStatic=0 working=68 shortage=66 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST M=9 bank=984 E=121 bank=200 pull=218 plants=1/0 aircraftDemand=2/115
  3.27  [AIR][Projects] energyQueued=0 committed=32/322
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=201 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.36  [AIR][Produce] opening.screen legfig plant=3968 projected=2/7
  3.36  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.36  [AIR][Rule] commander.idle.energy builder=28186
  3.37  [AIR][Rule] recovery.energy builder=5396
  3.37  [AIR][Layout] cluster=0 labs=1 at=6630,1291
  3.43  [AIR][Capacity] own=2/116 usage=12/112 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=434 shortage=31 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=977 E=117 bank=193 pull=112 plants=1/0 aircraftDemand=2/115
  3.43  [AIR][Projects] energyQueued=0 committed=73/376
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=166 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.48  [Playtest] finished legwin team 0 at 3.48 min
  3.49  [AIR][Rule] commander.factory.guard builder=28186
  3.55  [Playtest] finished legmex team 0 at 3.55 min
  3.56  [AIR][Wind] cluster=2 slots=6 at=10760,1648 local=false builder=16924
  3.56  [AIR][Rule] recovery.energy builder=16924
  3.57  [AIR][Rule] recovery.energy builder=7882
  3.60  [AIR][Capacity] own=2/117 usage=4/160 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=41 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=966 E=118 bank=0 pull=332 plants=1/0 aircraftDemand=2/115
  3.60  [AIR][Projects] energyQueued=2 committed=115/469
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.64  [AIR][Produce] opening.screen legfig plant=3968 projected=2/6
  3.64  [AIR][Screen] fighters=1 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=4/153 usage=8/315 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=45 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=1009 E=138 bank=58 pull=352 plants=1/0 aircraftDemand=3/84
  3.77  [AIR][Projects] energyQueued=2 committed=103/423
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Produce] opening.screen legfig plant=3968 projected=3/6
  3.78  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.78  [AIR][Rule] commander.idle.assist builder=28186
  3.81  [AIR][Rule] commander.factory.guard builder=28186
  3.82  [AIR][Screen] fighters=2 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  3.86  [Playtest] finished legwin team 0 at 3.86 min
  3.88  [AIR][Layout] cluster=1 labs=1 at=8934,907
  3.90  [AIR][Layout] cluster=2 labs=1 at=10278,3019
  3.92  [AIR][Produce] opening.screen legfig plant=3968 projected=4/6
  3.93  [AIR][Capacity] own=8/230 usage=6/185 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=90 shortage=174 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=1043 E=233 bank=408 pull=185 plants=1/0 aircraftDemand=3/84
  3.93  [AIR][Projects] energyQueued=1 committed=110/449
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=309 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.00  [AIR][Screen] fighters=3 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.7 bank 1061/1300, energy +235.6 bank 317/1181, units 27
  4.03  [AIR][Produce] opening.screen legfig plant=3968 projected=5/6
  4.10  [AIR][Capacity] own=11/217 usage=11/381 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=89 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=1081 E=228 bank=277 pull=381 plants=1/0 aircraftDemand=3/84
  4.10  [AIR][Projects] energyQueued=1 committed=87/355
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.16  [AIR][Produce] opening.screen legfig plant=3968 projected=6/6
  4.20  [AIR][Screen] fighters=5 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.27  [AIR][Capacity] own=4/144 usage=5/145 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=0 idle=0 ecoStatic=0 working=120 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=1093 E=152 bank=3 pull=330 plants=1/0 aircraftDemand=3/84
  4.27  [AIR][Projects] energyQueued=0 committed=57/232
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=135 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.37  [AIR][Screen] fighters=5 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.40  [AIR][Wind] cluster=3 slots=6 at=8376,1232 local=false builder=28186
  4.40  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.40  [AIR][Rule] commander.idle.energy builder=28186
  4.42  [AIR][Layout] cluster=3 labs=1 at=6726,907
  4.43  [AIR][Produce] constructor.expand legca plant=3968 projected=4/4
  4.43  [AIR][Capacity] own=4/127 usage=3/26 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=45 idle=0 ecoStatic=0 working=135 shortage=62 reason=funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=1118 E=131 bank=411 pull=26 plants=1/0 aircraftDemand=3/84
  4.43  [AIR][Projects] energyQueued=1 committed=70/285
  4.43  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=242 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.46  [Playtest] finished legwin team 0 at 4.46 min
  4.46  [Playtest] finished legwin team 0 at 4.46 min
  4.55  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=11/125 usage=3/26 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=45 idle=0 ecoStatic=0 working=135 shortage=144 reason=funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=1180 E=127 bank=940 pull=92 plants=1/0 aircraftDemand=3/84
  4.60  [AIR][Projects] energyQueued=1 committed=126/516
  4.60  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=324 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.72  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.73  [Playtest] finished legwin team 0 at 4.73 min
  4.75  [AIR][Rule] commander.energy.local builder=28186
  4.77  [AIR][Capacity] own=11/152 usage=3/26 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=45 idle=0 ecoStatic=0 working=135 shortage=69 reason=funded workload
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=1189 E=143 bank=1175 pull=92 plants=1/0 aircraftDemand=3/84
  4.77  [AIR][Projects] energyQueued=0 committed=84/345
  4.77  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=249 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [Playtest] finished legwin team 0 at 4.77 min
  4.79  [AIR][Layout] repaired support air.bay.0 viable=3/5 slot=254 at=9000,1256
  4.79  [AIR][Rule] opening.support builder=5396
  4.84  [Playtest] finished legwin team 0 at 4.84 min
  4.88  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  4.93  [AIR][Capacity] own=11/259 usage=9/52 gifts=0 sent=0 excess=0 pressure=true mobile=135 arriving=45 idle=0 ecoStatic=0 working=390 shortage=0 reason=available or arriving power
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=1186 E=247 bank=1183 pull=118 plants=1/0 aircraftDemand=3/84
  4.93  [AIR][Projects] energyQueued=0 committed=268/3356
  4.93  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=180 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+0/2 available=yes firstSlot=2
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.96  [Playtest] finished legwin team 0 at 4.96 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.7 bank 1199/1300, energy +391.9 bank 1208/1209, units 36
  5.00  [Playtest] target team 0 at (8800, 1100) from its start position
  5.00  [Playtest] camera requested (9072,1232) height=2200
  5.00  [AIR][Produce] air.control legfig plant=3968 projected=7/7
  5.00  [AIR][Rule] transition.storage builder=9996
  5.02  [Playtest] camera captured name=ta position=(9072,1232) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (9072, 1232)
  5.05  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.09  [Playtest] finished legwin team 0 at 5.09 min
  5.10  [AIR][Capacity] own=11/350 usage=18/181 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=180 shortage=179 reason=funded workload
  5.10  [AIR][Economy] T1_CONTEST M=11 bank=1183 E=332 bank=1209 pull=208 plants=1/0 aircraftDemand=3/84
  5.10  [AIR][Projects] energyQueued=0 committed=552/3647
  5.10  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=359 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.12  [Playtest] finished legwin team 0 at 5.12 min
  5.12  [Playtest] finished legwin team 0 at 5.12 min
  5.13  [AIR][Rule] mex.phase.convert builder=16924
  5.14  [AIR][Rule] opening.support.assist builder=7882
  5.22  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.25  [AIR][Produce] air.control legfig plant=3968 projected=9/9
  5.25  [AIR][Scout] opening drone=25262 enemy starts=1
  5.25  [AIR][Scout] replacement drone=25262
  5.27  [AIR][Capacity] own=11/410 usage=24/137 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=390 shortage=2 reason=funded workload
  5.27  [AIR][Economy] T1_CONTEST M=11 bank=1076 E=413 bank=1209 pull=164 plants=1/0 aircraftDemand=3/84
  5.27  [AIR][Projects] energyQueued=0 committed=500/4423
  5.27  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=182 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.29  [Playtest] finished legsolar team 0 at 5.29 min
  5.30  [AIR][Rule] commander.factory.guard builder=28186
  5.40  [AIR][Screen] fighters=6 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.40  [AIR][Commander] cleared factory guard for commander.energy.local
  5.40  [AIR][Rule] commander.energy.local builder=28186
  5.43  [AIR][Capacity] own=11/457 usage=8/160 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=180 shortage=378 reason=funded workload
  5.43  [AIR][Economy] T1_CONTEST M=11 bank=1052 E=457 bank=1260 pull=215 plants=1/0 aircraftDemand=3/84
  5.43  [AIR][Projects] energyQueued=1 committed=548/3906
  5.43  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=558 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.50  [AIR][Produce] air.control legfig plant=3968 projected=9/9
  5.58  [AIR][Screen] fighters=7 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.60  [AIR][Capacity] own=11/489 usage=24/160 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=480 shortage=0 reason=no funded workload
  5.60  [AIR][Economy] T1_CONTEST M=11 bank=966 E=489 bank=1260 pull=215 plants=1/0 aircraftDemand=3/84
  5.60  [AIR][Projects] energyQueued=0 committed=354/3073
  5.60  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=180 floating=false savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.65  [Playtest] finished legsolar team 0 at 5.65 min
  5.66  [AIR][Rule] commander.convert builder=28186
  5.75  [AIR][Screen] fighters=7 cells=8 centre=8747,1518 width=600 advance=400 responding=false
  5.75  [AIR][Produce] air.control legfig plant=3968 projected=10/10
  5.77  [AIR][Capacity] own=11/489 usage=6/213 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=479 shortage=274 reason=funded workload
  5.77  [AIR][Economy] T1_CONTEST M=11 bank=900 E=489 bank=1310 pull=268 plants=1/0 aircraftDemand=3/84
  5.77  [AIR][Projects] energyQueued=0 committed=215/2739
  5.77  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=454 floating=false savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.83  [Playtest] finished legeconv team 0 at 5.83 min
  5.93  [AIR][Capacity] own=11/395 usage=8/363 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=479 shortage=81 reason=funded workload
  5.93  [AIR][Economy] T1_CONTEST M=11 bank=901 E=430 bank=1283 pull=418 plants=1/0 aircraftDemand=3/87
  5.93  [AIR][Projects] energyQueued=0 committed=124/1963
  5.93  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=261 floating=false savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=3968 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  5.93  [AIR][Screen] fighters=8 cells=8 centre=8643,2137 width=1200 advance=1028 responding=false
  5.99  [AIR][Produce] air.control legfig plant=3968 projected=11/11
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.7 bank 905/1300, energy +340.8 bank 1053/1310, units 49
  6.00  [Playtest] finished legeconv team 0 at 6.00 min
  6.01  [AIR][Rule] commander.factory.guard builder=28186
  6.10  [AIR][Capacity] own=12/301 usage=8/253 gifts=0 sent=0 excess=0 pressure=true mobile=180 arriving=0 idle=0 ecoStatic=0 working=179 shortage=72 reason=funded workload
  6.10  [AIR][Economy] T1_CONTEST M=12 bank=911 E=319 bank=1032 pull=308 plants=1/0 aircraftDemand=3/87
  6.10  [AIR][Projects] energyQueued=0 committed=32/573
  6.10  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=252 floating=false savingLab=false
... 2549 more
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
  0.67  RESERVE: zone 1 at (8664, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (8664, 1080) facing 0 (id 1)
  0.67  RESERVE: zone 2 at (8712, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (8712, 1080) facing 0 (id 2)
  0.67  RESERVE: zone 3 at (8760, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (8760, 1080) facing 0 (id 3)
  0.67  RESERVE: zone 4 at (8664, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (8664, 1128) facing 0 (id 4)
  0.67  RESERVE: zone 5 at (8712, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (8712, 1128) facing 0 (id 5)
  0.67  RESERVE: zone 6 at (8760, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: legwin at (8760, 1128) facing 0 (id 6)
  0.67  RESERVE: served legwin at (8664, 1080) facing 0 (id 1, 5 of this def still held)
  0.77  RESERVE: zone 1 at (6936, 14360) facing 2, 3x3 cells: 9 of 9 held
  0.77  RESERVE: armwin at (6936, 14360) facing 2 (id 1)
  0.77  RESERVE: zone 2 at (6888, 14360) facing 2, 3x3 cells: 9 of 9 held
  0.77  RESERVE: armwin at (6888, 14360) facing 2 (id 2)
  0.77  RESERVE: zone 3 at (6840, 14360) facing 2, 3x3 cells: 9 of 9 held
  0.77  RESERVE: armwin at (6840, 14360) facing 2 (id 3)
  0.77  RESERVE: zone 4 at (6936, 14312) facing 2, 3x3 cells: 9 of 9 held
  0.77  RESERVE: armwin at (6936, 14312) facing 2 (id 4)
  0.77  RESERVE: zone 5 at (6888, 14312) facing 2, 3x3 cells: 9 of 9 held
  0.77  RESERVE: armwin at (6888, 14312) facing 2 (id 5)
  0.77  RESERVE: zone 6 at (6840, 14312) facing 2, 3x3 cells: 9 of 9 held
  0.77  RESERVE: armwin at (6840, 14312) facing 2 (id 6)
  0.77  RESERVE: served armwin at (6936, 14360) facing 2 (id 1, 5 of this def still held)
  0.84  RESERVE: served legwin at (8712, 1080) facing 0 (id 2, 4 of this def still held)
  0.89  RESERVE: served armwin at (6888, 14360) facing 2 (id 2, 4 of this def still held)
  0.96  RESERVE: served legwin at (8760, 1080) facing 0 (id 3, 3 of this def still held)
  1.06  RESERVE: served armwin at (6840, 14360) facing 2 (id 3, 3 of this def still held)
  1.09  RESERVE: served legwin at (8664, 1128) facing 0 (id 4, 2 of this def still held)
  1.18  RESERVE: served armwin at (6936, 14312) facing 2 (id 4, 2 of this def still held)
  1.22  RESERVE: served legwin at (8712, 1128) facing 0 (id 5, 1 of this def still held)
  1.30  RESERVE: served armwin at (6888, 14312) facing 2 (id 5, 1 of this def still held)
  1.35  RESERVE: served legwin at (8760, 1128) facing 0 (id 6, 0 of this def still held)
  1.43  RESERVE: served armwin at (6840, 14312) facing 2 (id 6, 0 of this def still held)
  1.47  RESERVE: zone 7 at (9048, 1096) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (9048, 1096) facing 0 (id 7)
  1.47  RESERVE: zone 7 released
  1.47  RESERVE: zone 8 at (9048, 1176) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (9048, 1176) facing 0 (id 8)
  1.47  RESERVE: zone 8 released
  1.47  RESERVE: zone 9 at (9016, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (9016, 1240) facing 0 (id 9)
  1.47  RESERVE: zone 10 at (9064, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (9064, 1240) facing 0 (id 10)
  1.47  RESERVE: zone 9 released
  1.47  RESERVE: zone 10 released
  1.47  RESERVE: zone 11 at (8968, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (8968, 1304) facing 0 (id 11)
  1.47  RESERVE: zone 12 at (9016, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (9016, 1304) facing 0 (id 12)
  1.47  RESERVE: zone 13 at (9064, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (9064, 1304) facing 0 (id 13)
  1.47  RESERVE: zone 14 at (8968, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (8968, 1352) facing 0 (id 14)
  1.47  RESERVE: zone 15 at (9016, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (9016, 1352) facing 0 (id 15)
  1.47  RESERVE: zone 16 at (9064, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: legwin at (9064, 1352) facing 0 (id 16)
  1.47  RESERVE: served legwin at (8968, 1304) facing 0 (id 11, 5 of this def still held)
  1.58  RESERVE: zone 7 at (6600, 14360) facing 2, 3x3 cells: 9 of 9 held
  1.58  RESERVE: armwin at (6600, 14360) facing 2 (id 7)
  1.58  RESERVE: zone 7 released
  1.58  RESERVE: zone 8 at (6584, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.58  RESERVE: armwin at (6584, 14344) facing 2 (id 8)
  1.58  RESERVE: zone 9 at (6536, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.58  RESERVE: armwin at (6536, 14344) facing 2 (id 9)
  1.58  RESERVE: zone 10 at (6488, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.58  RESERVE: armwin at (6488, 14344) facing 2 (id 10)
  1.58  RESERVE: zone 11 at (6584, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.58  RESERVE: armwin at (6584, 14296) facing 2 (id 11)
  1.58  RESERVE: zone 12 at (6536, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.58  RESERVE: armwin at (6536, 14296) facing 2 (id 12)
  1.58  RESERVE: zone 13 at (6488, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.58  RESERVE: armwin at (6488, 14296) facing 2 (id 13)
  1.58  EXP: approach: armcom(1236) at (6749, 14277) walks to (6710, 14293), 136 from the armwin site (6584, 14344)
  1.58  RESERVE: served armwin at (6584, 14344) facing 2 (id 8, 5 of this def still held)
  1.64  EXP: approach: legcom(28186) at (8807, 1223) walks to (8868, 1307), 148 from the legwin site (9016, 1304)
  1.65  RESERVE: served legwin at (9016, 1304) facing 0 (id 12, 4 of this def still held)
  1.70  EXP: approach: armcom(1236) at (6733, 14280) walks to (6665, 14302), 136 from the armwin site (6536, 14344)
  1.70  RESERVE: served armwin at (6536, 14344) facing 2 (id 9, 4 of this def still held)
  1.80  EXP: approach: legcom(28186) at (8875, 1215) walks to (8930, 1241), 148 from the legwin site (9064, 1304)
  1.80  RESERVE: served legwin at (9064, 1304) facing 0 (id 13, 3 of this def still held)
  1.84  RESERVE: served armwin at (6584, 14296) facing 2 (id 11, 3 of this def still held)
  1.93  RESERVE: served legwin at (8968, 1352) facing 0 (id 14, 2 of this def still held)
  1.94  EXP: approach: armcom(1236) at (6699, 14294) walks to (6620, 14312), 136 from the armwin site (6488, 14344)
  1.95  RESERVE: served armwin at (6488, 14344) facing 2 (id 10, 2 of this def still held)
  2.09  RESERVE: armap at (6768, 14312) facing 1 (id 14)
  2.09  RESERVE: served armap at (6768, 14312) facing 1 (id 14, 0 of this def still held)
  2.10  RESERVE: zone 14 at (6352, 13872) facing 2, 6x6 cells: 36 of 36 held
  2.10  RESERVE: armafus at (6352, 13872) facing 2 (id 15)
  2.10  RESERVE: zone 14 released
  2.10  RESERVE: zone 15 at (6224, 13872) facing 2, 6x6 cells: 36 of 36 held
  2.10  RESERVE: armafus at (6224, 13872) facing 2 (id 16)
  2.10  RESERVE: zone 15 released
  2.10  RESERVE: zone 16 at (6096, 13872) facing 2, 6x6 cells: 36 of 36 held
  2.10  RESERVE: armafus at (6096, 13872) facing 2 (id 17)
  2.10  RESERVE: zone 16 released
  2.19  RESERVE: legap at (9072, 1232) facing 0 (id 17)
  2.19  RESERVE: served legap at (9072, 1232) facing 0 (id 17, 0 of this def still held)
  2.20  RESERVE: zone 17 at (8432, 1248) facing 0, 6x6 cells: 36 of 36 held
  2.20  RESERVE: legafus at (8432, 1248) facing 0 (id 18)
  2.20  RESERVE: zone 17 released
  2.20  RESERVE: zone 18 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  2.20  RESERVE: legafus at (7024, 1376) facing 0 (id 19)
  2.20  RESERVE: zone 18 released
  2.20  RESERVE: zone 19 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
  2.20  RESERVE: legafus at (10608, 1760) facing 0 (id 20)
  2.20  RESERVE: zone 19 released
  2.20  RESERVE: zone 20 at (6896, 1376) facing 0, 6x6 cells: 36 of 36 held
  2.20  RESERVE: legafus at (6896, 1376) facing 0 (id 21)
```
