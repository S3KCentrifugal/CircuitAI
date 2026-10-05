# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36030); wall 178 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (8a05e13b0b70c836); AI BARbTest/test; staged 2026-10-04T17:49:54
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=SEA/armada/test, 2=AIR/cortex/test, 3=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\naval-natural\supreme\20261004T204953Z-7e1add8e\runs\20261004T205254Z-b0090b40\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\naval-natural\supreme\20261004T204953Z-7e1add8e\runs\20261004T205254Z-b0090b40\screen_2026-10-04_20-51-07-829.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\naval-natural\supreme\20261004T204953Z-7e1add8e\runs\20261004T205254Z-b0090b40\screen_2026-10-04_20-52-14-842.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\naval-natural\supreme\20261004T204953Z-7e1add8e\runs\20261004T205254Z-b0090b40\screen_2026-10-04_20-52-53-541.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 20, 3 shots, end at 20.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 28
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 28
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.08  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 55 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(4766,11076) factory=armsy landLocked=no spot=7 known=1/1
  0.20  [Team][Roster] team 1 first mex at 4608,11072
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=964 E=18 bank=699 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.30  [AIR][Rule] opening.mex builder=18649
  0.30  [Team][Roster] first mex 11230 at 2288,11968
  0.30  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|2288|11968
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=986 E=30 bank=988 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=46/463
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.60  [AIR][Capacity] own=4/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=987 E=30 bank=785 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=6/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1016 E=30 bank=611 pull=89 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=4/47
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [Playtest] finished armmex team 0 at 0.78 min
  0.79  [AIR][Wind] cluster=0 slots=6 at=2104,11696 local=true builder=18649
  0.79  [AIR][Rule] opening.energy builder=18649
  0.88  [Playtest] finished armwin team 0 at 0.88 min
  0.93  [AIR][Capacity] own=6/30 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=1049 E=30 bank=1000 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1067/1150, energy +48.8 bank 990/1000, units 6
  1.03  [Playtest] finished armwin team 0 at 1.03 min
  1.10  [AIR][Capacity] own=8/47 usage=7/41 gifts=6 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=1113 E=44 bank=998 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=18/78
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.14  [Playtest] finished armwin team 0 at 1.14 min
  1.25  [Playtest] finished armwin team 0 at 1.25 min
  1.27  [AIR][Capacity] own=8/59 usage=6/37 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=62 bank=1002 pull=37 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=1 committed=40/175
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.36  [Playtest] finished armwin team 0 at 1.36 min
  1.43  [AIR][Capacity] own=8/73 usage=7/41 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=73 bank=1002 pull=41 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=17/77
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.47  [Playtest] finished armwin team 0 at 1.47 min
  1.49  [AIR][Wind] cluster=1 slots=6 at=2456,11792 local=false builder=18649
  1.60  [AIR][Capacity] own=8/98 usage=0/9 gifts=0 sent=8 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=92 bank=1003 pull=9 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=1 committed=40/175
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=8/92 usage=7/41 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=94 bank=978 pull=41 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=1 committed=40/175
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.80  [Playtest] finished armwin team 0 at 1.80 min
  1.81  [AIR][Starter] nearby distance=127
  1.81  [AIR][Rule] opening.plant builder=18649
  1.82  [AIR][Layout] cluster=0 labs=6 at=2055,11521
  1.82  [AIR][EcoLayout] reserved air.eco.0 reactor=1664,11920 converters=8 support=12 zone=146
  1.82  [AIR][Layout] cluster=1 labs=6 at=2535,11425
  1.83  [AIR][EcoLayout] reserved air.eco.1 reactor=2944,11792 converters=8 support=12 zone=295
  1.85  [AIR][EcoLayout] reserved air.eco.2 reactor=3200,11280 converters=8 support=12 zone=329
  1.87  [AIR][EcoLayout] reserved air.eco.3 reactor=3712,11152 converters=8 support=12 zone=353
  1.93  [AIR][Capacity] own=8/92 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=8 bank=995 E=93 bank=943 pull=69 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=418/708
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 12 plant=17940 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 860/1150, energy +151.1 bank 995/1003, units 12
  2.10  [AIR][Capacity] own=8/141 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=8 bank=726 E=131 bank=953 pull=69 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=60/102
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 12 plant=17940 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.13  [Playtest] finished armap team 0 at 2.13 min
  2.13  [AIR][Claim] cancel unowned native order armnanotc
  2.13  [AIR][Claim] cancel unowned native order armnanotc
  2.13  [AIR][State] T1_CONTEST
  2.14  [AIR][Produce] opening.scout armpeep plant=17940 projected=1/1
  2.14  [AIR][Rule] opening.commander.guard builder=18649
  2.27  [AIR][Capacity] own=8/155 usage=8/258 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=8 bank=676 E=154 bank=567 pull=258 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.28  [AIR][Produce] constructor.recovery armca plant=17940 projected=1/3
  2.28  [AIR][Scout] opening drone=2855 enemy starts=2
  2.43  [AIR][Capacity] own=8/161 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=8 bank=691 E=162 bank=616 pull=198 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.50  [AIR][Produce] constructor.recovery armca plant=17940 projected=2/3
  2.51  [AIR][Rule] mex.expand builder=26183
  2.60  [AIR][Capacity] own=8/159 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=8 bank=699 E=161 bank=608 pull=198 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=50/500
  2.60  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.72  [AIR][Produce] constructor.recovery armca plant=17940 projected=3/3
  2.73  [AIR][Rule] mex.assist builder=7403
  2.77  [AIR][Capacity] own=8/140 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=50 shortage=41 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=699 E=142 bank=359 pull=153 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=40/402
  2.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=191 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Capacity] own=8/86 usage=5/97 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=94 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=673 E=103 bank=0 pull=225 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=20/200
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.94  [AIR][Produce] opening.screen armfig plant=17940 projected=1/6
  2.94  [AIR][Rule] recovery.energy builder=1166
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 682/1250, energy +67.3 bank 6/1178, units 18
  3.02  [AIR][Rule] commander.factory.guard builder=18649
  3.10  [AIR][Capacity] own=3/63 usage=6/113 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=94 shortage=49 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=674 E=65 bank=98 pull=321 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=139/42
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=199 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.16  [Playtest] finished armmex team 0 at 3.16 min
  3.17  [AIR][Rule] recovery.energy builder=26183
  3.17  [AIR][Rule] recovery.energy builder=7403
  3.27  [AIR][Capacity] own=2/74 usage=7/177 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=49 shortage=24 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=674 E=69 bank=75 pull=202 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=2 committed=415/0
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=174 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.31  [AIR][Produce] opening.screen armfig plant=17940 projected=2/6
  3.31  [AIR][Screen] fighters=1 cells=8 centre=2354,11427 width=600 advance=400 responding=false
  3.32  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.32  [AIR][Rule] commander.idle.assist builder=18649
  3.34  [AIR][Rule] commander.factory.guard builder=18649
  3.43  [AIR][Capacity] own=6/106 usage=16/330 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=634 E=104 bank=422 pull=330 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=310/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.48  [AIR][Screen] fighters=1 cells=8 centre=2354,11427 width=600 advance=400 responding=false
  3.52  [AIR][Produce] opening.screen armfig plant=17940 projected=3/6
  3.54  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.54  [AIR][Rule] commander.idle.assist builder=18649
  3.56  [AIR][Rule] commander.factory.guard builder=18649
  3.60  [AIR][Capacity] own=10/157 usage=21/144 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=579 E=143 bank=898 pull=144 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=198/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.67  [AIR][Screen] fighters=2 cells=8 centre=2354,11427 width=600 advance=400 responding=false
  3.71  [AIR][Produce] opening.screen armfig plant=17940 projected=4/6
  3.77  [AIR][Capacity] own=11/174 usage=18/384 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=522 E=174 bank=496 pull=384 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=109/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.85  [AIR][Screen] fighters=3 cells=8 centre=2354,11427 width=600 advance=400 responding=false
  3.85  [Playtest] finished armsolar team 0 at 3.85 min
  3.86  [Playtest] finished armsolar team 0 at 3.86 min
  3.86  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.86  [AIR][Rule] commander.idle.assist builder=18649
  3.86  [AIR][Produce] opening.screen armfig plant=17940 projected=5/6
  3.87  [AIR][Rule] commander.factory.guard builder=18649
  3.93  [AIR][Capacity] own=11/176 usage=15/384 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=481 E=177 bank=827 pull=384 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=348/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 12 plant=17940 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.2 bank 449/1300, energy +217.6 bank 663/1278, units 26
  4.02  [AIR][Produce] opening.screen armfig plant=17940 projected=6/6
  4.02  [AIR][Screen] fighters=5 cells=8 centre=2354,11427 width=600 advance=400 responding=false
  4.07  [AIR][Commander] cleared factory guard for commander.energy.local
  4.07  [AIR][Rule] commander.energy.local builder=18649
  4.10  [AIR][Capacity] own=11/216 usage=17/202 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST M=11 bank=435 E=214 bank=1278 pull=202 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=288/126
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 2212 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(18649) at (2175, 11785) walks to (2216, 11852), 136 from the armmex site (2288, 11968)
  0.09  EXP: approach: corcom(20332) at (10102, 513) walks to (10077, 461), 139 from the cormex site (10016, 336)
  0.29  EXP: approach: corcom(20332) at (10043, 389) walks to (10006, 631), 139 from the cormex site (9984, 768)
  0.30  EXP: approach: armcom(18649) at (2253, 11912) walks to (2296, 11670), 136 from the armmex site (2320, 11536)
  0.53  EXP: approach: corcom(20332) at (10011, 611) walks to (10261, 599), 139 from the cormex site (10400, 592)
  0.54  EXP: approach: armcom(18649) at (2291, 11697) walks to (2040, 11707), 136 from the armmex site (1904, 11712)
  0.77  RESERVE: zone 1 at (10216, 584) facing 0, 3x3 cells: 9 of 9 held
  0.77  RESERVE: corwin at (10216, 584) facing 0 (id 1)
  0.77  RESERVE: zone 2 at (10264, 584) facing 0, 3x3 cells: 9 of 9 held
  0.77  RESERVE: corwin at (10264, 584) facing 0 (id 2)
  0.77  RESERVE: zone 3 at (10312, 584) facing 0, 3x3 cells: 9 of 9 held
  0.77  RESERVE: corwin at (10312, 584) facing 0 (id 3)
  0.77  RESERVE: zone 4 at (10216, 632) facing 0, 3x3 cells: 9 of 9 held
  0.77  RESERVE: corwin at (10216, 632) facing 0 (id 4)
  0.77  RESERVE: zone 5 at (10264, 632) facing 0, 3x3 cells: 9 of 9 held
  0.77  RESERVE: corwin at (10264, 632) facing 0 (id 5)
  0.77  RESERVE: zone 6 at (10312, 632) facing 0, 3x3 cells: 9 of 9 held
  0.77  RESERVE: corwin at (10312, 632) facing 0 (id 6)
  0.77  RESERVE: served corwin at (10216, 584) facing 0 (id 1, 5 of this def still held)
  0.79  RESERVE: zone 1 at (2152, 11720) facing 2, 3x3 cells: 9 of 9 held
  0.79  RESERVE: armwin at (2152, 11720) facing 2 (id 1)
  0.79  RESERVE: zone 2 at (2104, 11720) facing 2, 3x3 cells: 9 of 9 held
  0.79  RESERVE: armwin at (2104, 11720) facing 2 (id 2)
  0.79  RESERVE: zone 3 at (2056, 11720) facing 2, 3x3 cells: 9 of 9 held
  0.79  RESERVE: armwin at (2056, 11720) facing 2 (id 3)
  0.79  RESERVE: zone 4 at (2152, 11672) facing 2, 3x3 cells: 9 of 9 held
  0.79  RESERVE: armwin at (2152, 11672) facing 2 (id 4)
  0.79  RESERVE: zone 5 at (2104, 11672) facing 2, 3x3 cells: 9 of 9 held
  0.79  RESERVE: armwin at (2104, 11672) facing 2 (id 5)
  0.79  RESERVE: zone 6 at (2056, 11672) facing 2, 3x3 cells: 9 of 9 held
  0.79  RESERVE: armwin at (2056, 11672) facing 2 (id 6)
  0.79  RESERVE: served armwin at (2152, 11720) facing 2 (id 1, 5 of this def still held)
  0.89  RESERVE: served armwin at (2104, 11720) facing 2 (id 2, 4 of this def still held)
  0.92  RESERVE: served corwin at (10264, 584) facing 0 (id 2, 4 of this def still held)
  1.03  RESERVE: served corwin at (10312, 584) facing 0 (id 3, 3 of this def still held)
  1.04  RESERVE: served armwin at (2056, 11720) facing 2 (id 3, 3 of this def still held)
  1.15  RESERVE: served corwin at (10216, 632) facing 0 (id 4, 2 of this def still held)
  1.15  RESERVE: served armwin at (2104, 11672) facing 2 (id 5, 2 of this def still held)
  1.26  RESERVE: served armwin at (2056, 11672) facing 2 (id 6, 1 of this def still held)
  1.26  RESERVE: served corwin at (10264, 632) facing 0 (id 5, 1 of this def still held)
  1.37  RESERVE: served armwin at (2152, 11672) facing 2 (id 4, 0 of this def still held)
  1.42  RESERVE: served corwin at (10312, 632) facing 0 (id 6, 0 of this def still held)
  1.45  RESERVE: zone 1 at (5800, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5800, 10904) facing 2 (id 1)
  1.45  RESERVE: zone 1 released
  1.45  RESERVE: corridor 2 at (5840, 10448) facing 2, 12x30 cells: 210 of 360 held
  1.45  RESERVE: zone 3 at (5968, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: zone 3 released
  1.45  RESERVE: zone 4 at (6096, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6096, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  1.45  RESERVE: zone 4 released
  1.45  RESERVE: zone 5 at (6224, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6224, 11424) facing 2: 10 of 16 slots (group 3, held, zone)
  1.45  RESERVE: zone 5 released
  1.47  RESERVE: zone 6 at (5864, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5864, 10856) facing 2 (id 14)
  1.47  RESERVE: zone 7 at (5816, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5816, 10856) facing 2 (id 15)
  1.47  RESERVE: zone 8 at (5768, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5768, 10856) facing 2 (id 16)
  1.47  RESERVE: zone 6 released
  1.47  RESERVE: zone 7 released
  1.47  RESERVE: zone 8 released
  1.47  RESERVE: zone 9 at (5944, 10840) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5944, 10840) facing 2 (id 17)
  1.47  RESERVE: zone 10 at (5896, 10840) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5896, 10840) facing 2 (id 18)
  1.47  RESERVE: zone 11 at (5848, 10840) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5848, 10840) facing 2 (id 19)
  1.47  RESERVE: zone 12 at (5800, 10840) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5800, 10840) facing 2 (id 20)
  1.47  RESERVE: zone 9 released
  1.47  RESERVE: zone 10 released
  1.47  RESERVE: zone 11 released
  1.47  RESERVE: zone 12 released
  1.47  RESERVE: zone 13 at (6008, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6008, 10856) facing 2 (id 21)
  1.47  RESERVE: zone 14 at (5960, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5960, 10856) facing 2 (id 22)
  1.47  RESERVE: zone 15 at (5912, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5912, 10856) facing 2 (id 23)
  1.47  RESERVE: zone 16 at (5864, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5864, 10856) facing 2 (id 24)
  1.47  RESERVE: zone 17 at (5816, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5816, 10856) facing 2 (id 25)
  1.47  RESERVE: zone 18 at (6008, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6008, 10808) facing 2 (id 26)
  1.47  RESERVE: zone 13 released
  1.47  RESERVE: zone 14 released
  1.47  RESERVE: zone 15 released
  1.47  RESERVE: zone 16 released
  1.47  RESERVE: zone 17 released
  1.47  RESERVE: zone 18 released
  1.47  RESERVE: zone 19 at (6072, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6072, 10904) facing 2 (id 27)
  1.47  RESERVE: zone 20 at (6024, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6024, 10904) facing 2 (id 28)
  1.47  RESERVE: zone 21 at (5976, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5976, 10904) facing 2 (id 29)
  1.47  RESERVE: zone 22 at (5928, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5928, 10904) facing 2 (id 30)
  1.47  RESERVE: zone 23 at (5880, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5880, 10904) facing 2 (id 31)
  1.47  RESERVE: zone 24 at (6072, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6072, 10856) facing 2 (id 32)
  1.47  RESERVE: zone 25 at (6024, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6024, 10856) facing 2 (id 33)
  1.47  RESERVE: zone 26 at (5976, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5976, 10856) facing 2 (id 34)
  1.47  RESERVE: zone 27 at (5928, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5928, 10856) facing 2 (id 35)
  1.47  RESERVE: zone 28 at (5880, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5880, 10856) facing 2 (id 36)
  1.47  RESERVE: zone 29 at (6072, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6072, 10808) facing 2 (id 37)
  1.47  RESERVE: zone 30 at (6024, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6024, 10808) facing 2 (id 38)
  1.47  RESERVE: zone 19 released
  1.47  RESERVE: zone 20 released
  1.47  RESERVE: zone 21 released
```
