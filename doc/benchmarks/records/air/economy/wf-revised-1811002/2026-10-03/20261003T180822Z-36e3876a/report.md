# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54105); wall 220 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:04:39
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\caldera\runs\20261003T180822Z-36e3876a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=958 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\caldera\runs\20261003T180822Z-36e3876a\screen_2026-10-03_18-05-59-082.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\caldera\runs\20261003T180822Z-36e3876a\screen_2026-10-03_18-06-51-702.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\caldera\runs\20261003T180822Z-36e3876a\screen_2026-10-03_18-07-19-594.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\caldera\runs\20261003T180822Z-36e3876a\screen_2026-10-03_18-08-21-157.png

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
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=958 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (8802, 1114), 16 from the start
  0.21  [Playtest] finished cormex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 13852 at 8896,1264
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|8817|1122|0|4|1|8896|1264
  0.23  [AIR][Rule] opening.mex builder=13591
  0.27  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=976 E=21 bank=806 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.40  [Playtest] finished cormex team 0 at 0.40 min
  0.43  [AIR][Capacity] own=4/30 usage=1/24 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=4 bank=972 E=30 bank=571 pull=24 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=6/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1025 E=30 bank=589 pull=86 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=26/262
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.65  [Playtest] finished cormex team 0 at 0.65 min
  0.67  [AIR][Wind] cluster=0 slots=6 at=8696,1104 local=true builder=13591
  0.67  [AIR][Rule] opening.energy builder=13591
  0.77  [AIR][Capacity] own=6/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1058 E=30 bank=449 pull=40 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=20/82
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.81  [Playtest] finished corwin team 0 at 0.81 min
  0.93  [Playtest] finished corwin team 0 at 0.93 min
  0.93  [AIR][Capacity] own=9/30 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=9 bank=1085 E=30 bank=459 pull=40 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +9.3 bank 1107/1150, energy +44.4 bank 523/1001, units 7
  1.05  [Playtest] finished corwin team 0 at 1.05 min
  1.10  [AIR][Capacity] own=9/41 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=9 bank=1130 E=43 bank=619 pull=9 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=35/144
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.18  [Playtest] finished corwin team 0 at 1.18 min
  1.27  [AIR][Capacity] own=9/45 usage=3/24 gifts=0 sent=0 excess=5 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=45 bank=812 pull=24 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=31/129
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.34  [Playtest] finished corwin team 0 at 1.34 min
  1.43  [AIR][Capacity] own=9/50 usage=7/40 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=50 bank=1002 pull=40 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=8/35
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.45  [Playtest] finished corwin team 0 at 1.45 min
  1.47  [AIR][Wind] cluster=1 slots=6 at=9016,1328 local=false builder=13591
  1.60  [AIR][Capacity] own=9/92 usage=7/40 gifts=0 sent=0 excess=1 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=9 bank=1150 E=83 bank=1000 pull=40 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=4/19
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.61  [Playtest] finished corwin team 0 at 1.61 min
  1.62  [AIR][Starter] nearby distance=127
  1.62  [AIR][Rule] opening.plant builder=13591
  1.77  [AIR][Capacity] own=9/124 usage=35/70 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=9 bank=963 E=121 bank=991 pull=70 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=334/584
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=18404 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [Playtest] finished corap team 0 at 1.93 min
  1.93  [AIR][Capacity] own=9/168 usage=35/70 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][State] T1_CONTEST
  1.93  [AIR][Economy] T1_CONTEST M=9 bank=704 E=166 bank=987 pull=70 plants=1/0 aircraftDemand=3/123
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.94  [AIR][Produce] opening.scout corfink plant=18404 projected=1/1
  1.94  [AIR][Rule] opening.commander.guard builder=13591
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 707/1250, energy +169.1 bank 861/1103, units 13
  2.06  [AIR][Produce] constructor.recovery corca plant=18404 projected=1/3
  2.10  [AIR][Capacity] own=9/166 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST M=9 bank=720 E=168 bank=776 pull=140 plants=1/0 aircraftDemand=3/123
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=55 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=9/165 usage=0/8 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=9 bank=717 E=166 bank=512 pull=199 plants=1/0 aircraftDemand=3/123
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=55 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.28  [AIR][Produce] constructor.recovery corca plant=18404 projected=2/3
  2.28  [AIR][Rule] mex.expand builder=12761
  2.43  [AIR][Capacity] own=9/169 usage=2/53 gifts=0 sent=0 excess=0 pressure=false mobile=55 arriving=55 idle=0 ecoStatic=0 working=55 shortage=188 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST M=9 bank=723 E=169 bank=520 pull=205 plants=1/0 aircraftDemand=3/123
  2.43  [AIR][Projects] energyQueued=0 committed=47/479
  2.43  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=298 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.50  [AIR][Produce] constructor.recovery corca plant=18404 projected=3/3
  2.50  [AIR][Rule] mex.assist builder=4313
  2.60  [AIR][Capacity] own=9/174 usage=1/23 gifts=0 sent=0 excess=0 pressure=false mobile=110 arriving=55 idle=0 ecoStatic=0 working=55 shortage=0 reason=available or arriving power
  2.60  [AIR][Economy] T1_CONTEST M=9 bank=716 E=174 bank=413 pull=214 plants=1/0 aircraftDemand=3/123
  2.60  [AIR][Projects] energyQueued=0 committed=33/332
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.72  [AIR][Produce] opening.screen corveng plant=18404 projected=1/6
  2.72  [AIR][Rule] recovery.energy builder=11756
  2.73  [AIR][Rule] commander.factory.guard builder=13591
  2.77  [AIR][Capacity] own=8/171 usage=13/405 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=104 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=698 E=172 bank=30 pull=415 plants=1/0 aircraftDemand=3/123
  2.77  [AIR][Projects] energyQueued=0 committed=47/242
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.88  [Playtest] finished cormex team 0 at 2.88 min
  2.89  [AIR][Rule] recovery.energy builder=12761
  2.89  [AIR][Rule] recovery.energy builder=4313
  2.93  [AIR][Capacity] own=2/184 usage=5/185 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=55 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=2 bank=678 E=182 bank=49 pull=269 plants=1/0 aircraftDemand=3/123
  2.93  [AIR][Projects] energyQueued=2 committed=112/457
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [AIR][Produce] opening.screen corveng plant=18404 projected=2/6
  3.00  [AIR][Screen] fighters=1 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.5 bank 707/1300, energy +185.0 bank 189/1178, units 20
  3.10  [AIR][Capacity] own=9/184 usage=7/215 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=725 E=184 bank=54 pull=275 plants=1/0 aircraftDemand=4/131
  3.10  [AIR][Projects] energyQueued=1 committed=94/384
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.17  [AIR][Screen] fighters=1 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.24  [AIR][Produce] opening.screen corveng plant=18404 projected=3/6
  3.25  [Playtest] finished corwin team 0 at 3.24 min
  3.27  [AIR][Capacity] own=8/205 usage=3/67 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=55 shortage=225 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=754 E=211 bank=270 pull=67 plants=1/0 aircraftDemand=4/131
  3.27  [AIR][Projects] energyQueued=1 committed=111/452
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=390 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.35  [AIR][Screen] fighters=2 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.43  [AIR][Capacity] own=4/166 usage=7/169 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=131 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=728 E=177 bank=10 pull=336 plants=1/0 aircraftDemand=3/129
  3.43  [AIR][Projects] energyQueued=0 committed=77/315
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.47  [AIR][Layout] cluster=0 labs=1 at=6633,1290
  3.52  [AIR][Screen] fighters=2 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.52  [AIR][Produce] opening.screen corveng plant=18404 projected=4/6
  3.60  [AIR][Capacity] own=4/142 usage=7/167 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=115 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=730 E=146 bank=19 pull=361 plants=1/0 aircraftDemand=3/130
  3.60  [AIR][Projects] energyQueued=0 committed=42/171
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=69
  3.62  [Playtest] finished corwin team 0 at 3.62 min
  3.70  [AIR][Screen] fighters=3 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=4/137 usage=6/149 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=117 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=721 E=142 bank=19 pull=281 plants=1/0 aircraftDemand=3/130
  3.77  [AIR][Projects] energyQueued=0 committed=53/219
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.87  [AIR][Screen] fighters=3 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  3.88  [AIR][Produce] opening.screen corveng plant=18404 projected=5/6
  3.89  [Playtest] finished corwin team 0 at 3.89 min
  3.90  [Playtest] finished corwin team 0 at 3.90 min
  3.91  [AIR][Wind] cluster=2 slots=6 at=10760,1648 local=false builder=11756
  3.93  [AIR][Capacity] own=4/149 usage=7/240 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=55 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=725 E=148 bank=252 pull=240 plants=1/0 aircraftDemand=3/130
  3.93  [AIR][Projects] energyQueued=2 committed=108/440
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.98  [AIR][Layout] cluster=1 labs=1 at=10281,3018
  4.00  [Playtest] eco team 0 at 4.0 min: metal +6.9 bank 730/1300, energy +232.2 bank 100/1180, units 26
  4.05  [AIR][Screen] fighters=4 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.10  [AIR][Capacity] own=4/217 usage=6/215 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=54 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=738 E=201 bank=64 pull=269 plants=1/0 aircraftDemand=3/130
  4.10  [AIR][Projects] energyQueued=2 committed=94/383
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=63
  4.11  [AIR][Produce] opening.screen corveng plant=18404 projected=6/6
  4.21  [Playtest] finished corwin team 0 at 4.21 min
  4.22  [AIR][Screen] fighters=5 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.27  [AIR][Capacity] own=4/162 usage=5/146 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=89 shortage=147 reason=funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=751 E=170 bank=17 pull=330 plants=1/0 aircraftDemand=3/130
  4.27  [AIR][Projects] energyQueued=1 committed=109/446
  4.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=312 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.33  [AIR][Layout] cluster=2 labs=1 at=6729,906
  4.38  [AIR][Screen] fighters=5 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.43  [AIR][Capacity] own=4/161 usage=4/69 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=82 reason=funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=757 E=161 bank=184 pull=69 plants=1/0 aircraftDemand=3/130
  4.43  [AIR][Projects] energyQueued=1 committed=84/342
  4.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=247 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.48  [AIR][Produce] constructor.expand corca plant=18404 projected=4/4
  4.55  [AIR][Screen] fighters=6 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=11/174 usage=7/84 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=55 idle=0 ecoStatic=0 working=164 shortage=105 reason=funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=779 E=171 bank=630 pull=219 plants=1/0 aircraftDemand=3/130
  4.60  [AIR][Projects] energyQueued=0 committed=46/187
  4.60  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=325 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=57
  4.67  [Playtest] finished corwin team 0 at 4.67 min
  4.68  [Playtest] finished corwin team 0 at 4.68 min
  4.68  [AIR][Layout] repaired support air.bay.0 viable=3/5 slot=244 at=8968,1400
  4.68  [AIR][Rule] opening.support builder=11756
  4.70  [AIR][Produce] recon.replace corfink plant=18404 projected=1/1
  4.70  [AIR][Rule] mex.expand builder=12513
  4.70  [AIR][Rule] energy.grow builder=4313
  4.72  [AIR][Screen] fighters=6 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.77  [AIR][Capacity] own=11/193 usage=12/295 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=109 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=785 E=185 bank=1057 pull=295 plants=1/0 aircraftDemand=3/130
  4.77  [AIR][Projects] energyQueued=0 committed=337/3934
  4.77  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/2 available=yes firstSlot=2
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.82  [AIR][Produce] air.control corveng plant=18404 projected=7/7
  4.88  [AIR][Screen] fighters=6 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  4.93  [AIR][Capacity] own=11/292 usage=14/416 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=164 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=794 E=285 bank=777 pull=416 plants=1/0 aircraftDemand=3/130
  4.93  [AIR][Projects] energyQueued=0 committed=303/3755
  4.93  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/2 available=yes firstSlot=2
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.97  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.97  [AIR][Rule] commander.idle.energy builder=13591
  4.98  [AIR][Produce] air.control corveng plant=18404 projected=8/8
  4.99  [Playtest] finished corwin team 0 at 4.99 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.7 bank 799/1300, energy +332.7 bank 1084/1207, units 36
  5.00  [Playtest] target team 0 at (8800, 1100) from its start position
  5.00  [Playtest] camera requested (8872,1376) height=2200
  5.00  [AIR][Rule] storage.buffer builder=12761
  5.01  [Playtest] camera captured name=ta position=(8872,1376) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (8872, 1376)
  5.05  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  5.10  [AIR][Capacity] own=11/317 usage=22/158 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=410 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=11 bank=747 E=309 bank=1207 pull=158 plants=1/0 aircraftDemand=3/130
  5.10  [AIR][Projects] energyQueued=0 committed=498/5330
  5.10  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=220 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+0/2 available=yes firstSlot=2
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=51
  5.21  [Playtest] finished corsolar team 0 at 5.21 min
  5.22  [AIR][Screen] fighters=7 cells=8 centre=8750,1516 width=600 advance=400 responding=false
  5.22  [Playtest] finished corwin team 0 at 5.22 min
  5.23  [AIR][Rule] opening.support.assist builder=13591
  5.24  [AIR][Rule] mex.phase.convert builder=4313
  5.27  [AIR][Capacity] own=11/306 usage=0/44 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=410 shortage=394 reason=funded workload
  5.27  [AIR][Economy] T1_CONTEST M=11 bank=715 E=312 bank=1172 pull=258 plants=1/0 aircraftDemand=3/130
  5.27  [AIR][Projects] energyQueued=0 committed=385/5907
  5.27  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=614 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.36  [AIR][Produce] air.control corveng plant=18404 projected=9/9
  5.40  [AIR][Screen] fighters=8 cells=8 centre=8646,2136 width=1200 advance=1028 responding=false
  5.43  [Playtest] finished cormex team 0 at 5.43 min
  5.43  [AIR][Capacity] own=11/340 usage=7/176 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=55 ecoStatic=0 working=409 shortage=251 reason=funded workload
  5.43  [AIR][Economy] T1_CONTEST M=11 bank=623 E=335 bank=1072 pull=390 plants=1/0 aircraftDemand=3/129
  5.43  [AIR][Projects] energyQueued=0 committed=201/3459
  5.43  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=471 floating=false savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=18404 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.44  [AIR][Layout] repaired support air.bay.0 viable=4/5 slot=261 at=8776,1400
  5.44  [AIR][Rule] opening.support builder=12513
  5.48  [Playtest] finished cornanotc team 0 at 5.48 min
  5.49  [AIR][Rule] energy.grow builder=11756
  5.49  [AIR][Rule] commander.factory.guard builder=13591
  5.57  [AIR][Screen] fighters=8 cells=8 centre=8646,2136 width=1200 advance=1028 responding=false
  5.58  [AIR][Produce] air.control corveng plant=18404 projected=10/10
  5.59  [AIR][Commander] cleared factory guard for commander.idle.assist
  5.59  [AIR][Rule] commander.idle.assist builder=13591
  5.60  [AIR][Capacity] own=12/363 usage=2/63 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=223 shortage=279 reason=funded workload
  5.60  [AIR][Economy] T1_CONTEST M=13 bank=619 E=356 bank=993 pull=63 plants=1/0 aircraftDemand=8/293
  5.60  [AIR][Projects] energyQueued=1 committed=405/5774
  5.60  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=499 floating=false savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=18404 BP=350 nanos=1+0/2 available=yes firstSlot=3
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Support] return to production bay=0
  5.60  [AIR][Attack] home=9 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=349
  5.62  [AIR][Rule] commander.factory.guard builder=13591
  5.72  [AIR][Commander] cleared factory guard for commander.idle.assist
  5.72  [AIR][Rule] commander.idle.assist builder=13591
  5.72  [AIR][Produce] air.control corveng plant=18404 projected=11/11
  5.75  [AIR][Support] return to production bay=0
  5.75  [AIR][Rule] commander.factory.guard builder=13591
  5.77  [AIR][Capacity] own=14/361 usage=0/32 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=514 shortage=449 reason=funded workload
  5.77  [AIR][Economy] T1_CONTEST M=14 bank=622 E=362 bank=483 pull=277 plants=1/0 aircraftDemand=8/293
  5.77  [AIR][Projects] energyQueued=0 committed=330/4598
  5.77  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=669 floating=false savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.77  [AIR][Bay] 0 plant=18404 BP=350 nanos=1+1/2 available=yes firstSlot=3
  5.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.77  [AIR][Screen] fighters=10 cells=8 centre=8646,2136 width=1200 advance=1028 responding=false
  5.93  [AIR][Capacity] own=6/342 usage=6/157 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=219 shortage=189 reason=funded workload
  5.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=571 E=345 bank=225 pull=238 plants=1/0 aircraftDemand=8/293
  5.93  [AIR][Projects] energyQueued=0 committed=265/3806
  5.93  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=409 floating=false savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.93  [AIR][Bay] 0 plant=18404 BP=350 nanos=1+1/0 available=yes firstSlot=3
  5.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.95  [AIR][Commander] cleared factory guard for commander.idle.energy
  5.95  [AIR][Rule] commander.idle.energy builder=13591
  5.97  [AIR][Screen] fighters=11 cells=8 centre=8646,2136 width=1200 advance=1028 responding=false
  6.00  [Playtest] eco team 0 at 6.0 min: metal +14.1 bank 593/1350, energy +344.7 bank 1168/1258, units 44
  6.10  [AIR][Capacity] own=14/339 usage=14/1 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=686 shortage=141 reason=funded workload
  6.10  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=599 E=342 bank=1258 pull=135 plants=1/0 aircraftDemand=8/293
  6.10  [AIR][Projects] energyQueued=0 committed=279/2320
  6.10  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=361 floating=false savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  6.10  [AIR][Bay] 0 plant=18404 BP=350 nanos=1+1/0 available=yes firstSlot=3
  6.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  6.10  [AIR][Attack] home=11 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=316
  6.13  [AIR][Screen] fighters=11 cells=8 centre=8646,2136 width=1200 advance=1028 responding=false
  6.17  [AIR][Produce] air.control corveng plant=18404 projected=12/12
  6.20  [AIR][Support] return to production bay=0
  6.22  [Playtest] finished corsolar team 0 at 6.22 min
  6.24  [AIR][Rule] commander.factory.guard builder=13591
  6.27  [AIR][Capacity] own=14/311 usage=11/363 gifts=0 sent=0 excess=0 pressure=false mobile=220 arriving=0 idle=0 ecoStatic=0 working=219 shortage=0 reason=no funded workload
  6.27  [AIR][Economy] T1_CONTEST M=14 bank=455 E=318 bank=1083 pull=397 plants=1/0 aircraftDemand=8/293
... 2476 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: corcom(13591) at (8817, 1122) walks to (8829, 1143), 139 from the cormex site (8896, 1264)
  0.08  EXP: approach: armcom(30290) at (6600, 14247) walks to (6591, 14272), 136 from the armmex site (6544, 14400)
  0.11  EXP: idle: corcom(13591) on cormex at (8825, 1138), site (8896, 1264), target yes, fails 2 (arrived at the approach point)
  0.11  EXP: idle: armcom(30290) on armmex at (6595, 14262), site (6544, 14400), target yes, fails 2 (arrived at the approach point)
  0.21  EXP: approach: armcom(30290) at (6595, 14263) walks to (6472, 14119), 136 from the armmex site (6384, 14016)
  0.23  EXP: approach: corcom(13591) at (8826, 1138) walks to (8909, 1057), 139 from the cormex site (9008, 960)
  0.42  EXP: approach: corcom(13591) at (8898, 1072) walks to (8649, 1113), 139 from the cormex site (8512, 1136)
  0.43  EXP: approach: armcom(30290) at (6491, 14143) walks to (6872, 14351), 136 from the armmex site (6992, 14416)
  0.67  RESERVE: zone 1 at (8648, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8648, 1080) facing 0 (id 1)
  0.67  RESERVE: zone 2 at (8696, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8696, 1080) facing 0 (id 2)
  0.67  RESERVE: zone 3 at (8744, 1080) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8744, 1080) facing 0 (id 3)
  0.67  RESERVE: zone 4 at (8648, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8648, 1128) facing 0 (id 4)
  0.67  RESERVE: zone 5 at (8696, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8696, 1128) facing 0 (id 5)
  0.67  RESERVE: zone 6 at (8744, 1128) facing 0, 3x3 cells: 9 of 9 held
  0.67  RESERVE: corwin at (8744, 1128) facing 0 (id 6)
  0.67  RESERVE: served corwin at (8648, 1080) facing 0 (id 1, 5 of this def still held)
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
  0.82  RESERVE: served corwin at (8696, 1080) facing 0 (id 2, 4 of this def still held)
  0.88  RESERVE: served armwin at (6888, 14360) facing 2 (id 2, 4 of this def still held)
  0.94  RESERVE: served corwin at (8744, 1080) facing 0 (id 3, 3 of this def still held)
  1.05  RESERVE: served armwin at (6840, 14360) facing 2 (id 3, 3 of this def still held)
  1.07  RESERVE: served corwin at (8648, 1128) facing 0 (id 4, 2 of this def still held)
  1.17  RESERVE: served armwin at (6936, 14312) facing 2 (id 4, 2 of this def still held)
  1.19  RESERVE: served corwin at (8696, 1128) facing 0 (id 5, 1 of this def still held)
  1.29  RESERVE: served armwin at (6888, 14312) facing 2 (id 5, 1 of this def still held)
  1.35  RESERVE: served corwin at (8744, 1128) facing 0 (id 6, 0 of this def still held)
  1.39  RESERVE: served armwin at (6840, 14312) facing 2 (id 6, 0 of this def still held)
  1.47  RESERVE: zone 7 at (9064, 1096) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (9064, 1096) facing 0 (id 7)
  1.47  RESERVE: zone 7 released
  1.47  RESERVE: zone 8 at (9048, 1176) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (9048, 1176) facing 0 (id 8)
  1.47  RESERVE: zone 8 released
  1.47  RESERVE: zone 9 at (9016, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (9016, 1240) facing 0 (id 9)
  1.47  RESERVE: zone 10 at (9064, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (9064, 1240) facing 0 (id 10)
  1.47  RESERVE: zone 9 released
  1.47  RESERVE: zone 10 released
  1.47  RESERVE: zone 11 at (8968, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (8968, 1304) facing 0 (id 11)
  1.47  RESERVE: zone 12 at (9016, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (9016, 1304) facing 0 (id 12)
  1.47  RESERVE: zone 13 at (9064, 1304) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (9064, 1304) facing 0 (id 13)
  1.47  RESERVE: zone 14 at (8968, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (8968, 1352) facing 0 (id 14)
  1.47  RESERVE: zone 15 at (9016, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (9016, 1352) facing 0 (id 15)
  1.47  RESERVE: zone 16 at (9064, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: corwin at (9064, 1352) facing 0 (id 16)
  1.47  EXP: approach: corcom(13591) at (8743, 1219) walks to (8839, 1255), 138 from the corwin site (8968, 1304)
  1.47  RESERVE: served corwin at (8968, 1304) facing 0 (id 11, 5 of this def still held)
  1.54  RESERVE: zone 7 at (6600, 14360) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6600, 14360) facing 2 (id 7)
  1.54  RESERVE: zone 7 released
  1.54  RESERVE: zone 8 at (6584, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6584, 14344) facing 2 (id 8)
  1.54  RESERVE: zone 9 at (6536, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6536, 14344) facing 2 (id 9)
  1.54  RESERVE: zone 10 at (6488, 14344) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6488, 14344) facing 2 (id 10)
  1.54  RESERVE: zone 11 at (6584, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6584, 14296) facing 2 (id 11)
  1.54  RESERVE: zone 12 at (6536, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6536, 14296) facing 2 (id 12)
  1.54  RESERVE: zone 13 at (6488, 14296) facing 2, 3x3 cells: 9 of 9 held
  1.54  RESERVE: armwin at (6488, 14296) facing 2 (id 13)
  1.54  EXP: approach: armcom(30290) at (6747, 14281) walks to (6711, 14295), 136 from the armwin site (6584, 14344)
  1.55  RESERVE: served armwin at (6584, 14344) facing 2 (id 8, 5 of this def still held)
  1.62  RESERVE: corap at (8872, 1376) facing 0 (id 17)
  1.62  RESERVE: served corap at (8872, 1376) facing 0 (id 17, 0 of this def still held)
  1.63  RESERVE: zone 17 at (8432, 1248) facing 0, 6x6 cells: 36 of 36 held
  1.63  RESERVE: corafus at (8432, 1248) facing 0 (id 18)
  1.63  RESERVE: zone 17 released
  1.63  RESERVE: zone 18 at (7024, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.63  RESERVE: corafus at (7024, 1376) facing 0 (id 19)
  1.63  RESERVE: zone 18 released
  1.63  RESERVE: zone 19 at (10608, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.63  RESERVE: corafus at (10608, 1760) facing 0 (id 20)
  1.63  RESERVE: zone 19 released
  1.63  RESERVE: zone 20 at (6896, 1376) facing 0, 6x6 cells: 36 of 36 held
  1.63  RESERVE: corafus at (6896, 1376) facing 0 (id 21)
  1.63  RESERVE: zone 20 released
  1.63  RESERVE: zone 21 at (10736, 1760) facing 0, 6x6 cells: 36 of 36 held
  1.63  RESERVE: corafus at (10736, 1760) facing 0 (id 22)
  1.63  RESERVE: zone 21 released
  1.63  RESERVE: zone 22 at (6640, 1120) facing 0, 6x6 cells: 36 of 36 held
  1.63  RESERVE: corafus at (6640, 1120) facing 0 (id 23)
  1.63  RESERVE: zone 22 released
  1.63  RESERVE: zone 23 at (6640, 1248) facing 0, 6x6 cells: 36 of 36 held
  1.63  RESERVE: corafus at (6640, 1248) facing 0 (id 24)
  1.63  RESERVE: zone 23 released
  1.63  RESERVE: zone 24 at (8048, 2400) facing 0, 6x6 cells: 36 of 36 held
  1.63  RESERVE: corafus at (8048, 2400) facing 0 (id 25)
  1.63  RESERVE: zone 24 released
  1.63  RESERVE: zone 25 at (8776, 1256) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: cornanotc at (8776, 1256) facing 0 (id 26)
  1.63  RESERVE: zone 26 at (8968, 1256) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: cornanotc at (8968, 1256) facing 0 (id 27)
  1.66  RESERVE: armap at (6768, 14408) facing 1 (id 14)
  1.66  RESERVE: served armap at (6768, 14408) facing 1 (id 14, 0 of this def still held)
  1.67  RESERVE: zone 14 at (6352, 13872) facing 2, 6x6 cells: 36 of 36 held
```
